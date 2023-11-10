using {
  managed,
  sap.common.CodeList
} from '@sap/cds/common';

namespace sap.avp;

type UserID: String @title: 'User';
type Description: String @title: 'Description';
type TenantNotification: Boolean @title: 'Tenant Notification';
type EnvironmentNotification: Boolean @title: 'Environment Notification';
type ProcessNotification: Boolean @title: 'Process Notiication';
type ActivityNotification: Boolean @title: 'Activity Notification';

type Log: UUID  @odata.Type: 'Edm.String'  @title: 'Log ID';

@cds.odata.valuelist
@cds.autoexpose
@UI.Identification: [{Value: ID}] 
@Common.SemanticKey: [ID]
entity UserSettings: managed{
  key ID: UserID;
  description: Description @mandatory: false;
  environmentNotification: EnvironmentNotification default true;
  processNotification: ProcessNotification default true;
  activityNotification: ActivityNotification default true;
}

@cds.odata.valuelist
@cds.autoexpose
@UI.Identification: [{Value: ID}] 
entity EventLogs: managed{
  key ID: Log;
  user_ID: UserID;
    userSetting: Association to one UserSettings
                  on userSetting.ID=user_ID @title: 'User Setting';
}

@cds.autoexpose
entity EventLogUserTeamArrays as projection on EventLogs {
  key modifiedBy as user_ID,
      coalesce(
        last_value(userSetting.environmentNotification) over (order by modifiedAt), true
      ) as environmentNotification: EnvironmentNotification,
      coalesce(
        last_value(userSetting.processNotification) over (order by modifiedAt), true
      ) as processNotification: ProcessNotification,
      coalesce(
        last_value(userSetting.activityNotification) over (order by modifiedAt), true
      ) as activityNotification: ActivityNotification,
} group by modifiedBy;