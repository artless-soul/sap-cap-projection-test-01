using {
  sap.avp.EventLogs as eventLogs,
  sap.avp.UserSettings as userSettings,
  sap.avp.EventLogUserTeamArrays as eventLogUserTeamArrays
} from '../db/schema';

namespace sap.avp;

@path: 'sap/avp/TestService'
service TestService {

  entity EventLogs as projection on eventLogs;

  entity UserSettings as projection on userSettings;

  entity EventLogUserTeamArrays as projection on eventLogUserTeamArrays;

}