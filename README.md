# Steps

yarn

cds deploy --to hana

## Compare the output in cds repl

cds repl
> var test = cds.test('.')

### Result directly from the db
> await cds.run('SELECT * from sap_avp_EventLogUserTeamArrays');

--> Ouput (as directly from db).. this can be seen using db explorer also..
<p><img width="467" alt="image" src="https://github.com/artless-soul/sap-cap-projection-test-01/assets/92021873/03c3ad8d-bed1-42fa-83b4-b6bde35ad2a7"></p>

### Result from the cap cql
> const { ['sap.avp.EventLogUserTeamArrays']: EventLogUserTeamArrays} = cds.model?.definitions;
>
> await SELECT.from(EventLogUserTeamArrays);

--> Output is differnt and not correct.
<p><img width="687" alt="image" src="https://github.com/artless-soul/sap-cap-projection-test-01/assets/92021873/51de999e-f053-4e7e-8a09-f68322500dae"></p>

==> Expectation is that the cql to return the same data as the view in the db.

# Note: 
The same sceario is tested on sqlite (need to use the commented definition from db/schema.db for EventLogUserTeamArrays).
There result is same from sql and cql.
