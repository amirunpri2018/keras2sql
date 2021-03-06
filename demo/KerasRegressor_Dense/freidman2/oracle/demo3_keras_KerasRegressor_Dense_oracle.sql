-- This SQL code was generated by sklearn2sql (development version).
-- Copyright 2018

-- Model : KerasRegressor_Dense
-- Dataset : freidman2
-- Database : oracle


-- This SQL code can contain one or more statements, to be executed in the order they appear in this file.



-- Model deployment code

WITH keras_input AS 
(SELECT "ADS"."KEY" AS "KEY", "ADS"."Feature_0" AS "Feature_0", "ADS"."Feature_1" AS "Feature_1", "ADS"."Feature_2" AS "Feature_2", "ADS"."Feature_3" AS "Feature_3" 
FROM "FREIDMAN2" "ADS"), 
keras_input_1 AS 
(SELECT keras_input."KEY" AS "KEY", keras_input."Feature_0" AS "Feature_0", keras_input."Feature_1" AS "Feature_1", keras_input."Feature_2" AS "Feature_2", keras_input."Feature_3" AS "Feature_3" 
FROM keras_input), 
layer_dense_1 AS 
(SELECT keras_input_1."KEY" AS "KEY", 0.15351666929196153 + 0.849628653630841 * keras_input_1."Feature_0" + 0.7429914514561644 * keras_input_1."Feature_1" + 0.019779647198307593 * keras_input_1."Feature_2" + 1.0230880724890996 * keras_input_1."Feature_3" AS output_1, -0.14877958519498954 + -0.7763849065435856 * keras_input_1."Feature_0" + -0.07180150920277968 * keras_input_1."Feature_1" + -0.40053764705761286 * keras_input_1."Feature_2" + -0.07684746196798514 * keras_input_1."Feature_3" AS output_2, 0.14912428653548832 + -0.256574512817607 * keras_input_1."Feature_0" + 0.22129523343447297 * keras_input_1."Feature_1" + 0.4481093552097636 * keras_input_1."Feature_2" + -0.20359972875850027 * keras_input_1."Feature_3" AS output_3, 0.14089784507066358 + 0.9247414239651743 * keras_input_1."Feature_0" + -0.26808080954946384 * keras_input_1."Feature_1" + 0.4884524438813464 * keras_input_1."Feature_2" + 0.9882631616286883 * keras_input_1."Feature_3" AS output_4 
FROM keras_input_1), 
layer_dense_1_1 AS 
(SELECT layer_dense_1."KEY" AS "KEY", layer_dense_1.output_1 AS output_1, layer_dense_1.output_2 AS output_2, layer_dense_1.output_3 AS output_3, layer_dense_1.output_4 AS output_4 
FROM layer_dense_1), 
layer_dense_2 AS 
(SELECT layer_dense_1_1."KEY" AS "KEY", 0.1446716832094118 + 0.5542090868139369 * layer_dense_1_1.output_1 + -0.42504204277303353 * layer_dense_1_1.output_2 + 1.1557839908312857 * layer_dense_1_1.output_3 + 0.86996203274465 * layer_dense_1_1.output_4 AS output_1 
FROM layer_dense_1_1)
 SELECT layer_dense_2."KEY" AS "KEY", layer_dense_2.output_1 AS "Estimator" 
FROM layer_dense_2