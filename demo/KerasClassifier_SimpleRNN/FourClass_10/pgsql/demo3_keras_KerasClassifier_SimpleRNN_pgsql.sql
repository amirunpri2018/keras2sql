-- This SQL code was generated by sklearn2sql (development version).
-- Copyright 2018

-- Model : KerasClassifier_SimpleRNN
-- Dataset : FourClass_10
-- Database : pgsql


-- This SQL code can contain one or more statements, to be executed in the order they appear in this file.



-- Model deployment code

WITH RECURSIVE keras_input AS 
(SELECT "ADS"."KEY" AS "KEY", "ADS"."Feature_0" AS "Feature_0", "ADS"."Feature_1" AS "Feature_1", "ADS"."Feature_2" AS "Feature_2", "ADS"."Feature_3" AS "Feature_3", "ADS"."Feature_4" AS "Feature_4", "ADS"."Feature_5" AS "Feature_5", "ADS"."Feature_6" AS "Feature_6", "ADS"."Feature_7" AS "Feature_7", "ADS"."Feature_8" AS "Feature_8", "ADS"."Feature_9" AS "Feature_9" 
FROM "FourClass_10" AS "ADS"), 
keras_input_1 AS 
(SELECT keras_input."KEY" AS "KEY", keras_input."Feature_0" AS "Feature_0", keras_input."Feature_1" AS "Feature_1", keras_input."Feature_2" AS "Feature_2", keras_input."Feature_3" AS "Feature_3", keras_input."Feature_4" AS "Feature_4", keras_input."Feature_5" AS "Feature_5", keras_input."Feature_6" AS "Feature_6", keras_input."Feature_7" AS "Feature_7", keras_input."Feature_8" AS "Feature_8", keras_input."Feature_9" AS "Feature_9" 
FROM keras_input), 
keras_input_1_rn AS 
(SELECT row_number() OVER (ORDER BY keras_input_1."KEY" ASC) AS rn, keras_input_1."KEY" AS "KEY", keras_input_1."Feature_0" AS "Feature_0", keras_input_1."Feature_1" AS "Feature_1", keras_input_1."Feature_2" AS "Feature_2", keras_input_1."Feature_3" AS "Feature_3", keras_input_1."Feature_4" AS "Feature_4", keras_input_1."Feature_5" AS "Feature_5", keras_input_1."Feature_6" AS "Feature_6", keras_input_1."Feature_7" AS "Feature_7", keras_input_1."Feature_8" AS "Feature_8", keras_input_1."Feature_9" AS "Feature_9" 
FROM keras_input_1), 
input_kernel_bias AS 
(SELECT keras_input_1_rn.rn AS rn, keras_input_1_rn."KEY" AS "KEY", keras_input_1_rn."Feature_0" AS "Feature_0", keras_input_1_rn."Feature_1" AS "Feature_1", keras_input_1_rn."Feature_2" AS "Feature_2", keras_input_1_rn."Feature_3" AS "Feature_3", keras_input_1_rn."Feature_4" AS "Feature_4", keras_input_1_rn."Feature_5" AS "Feature_5", keras_input_1_rn."Feature_6" AS "Feature_6", keras_input_1_rn."Feature_7" AS "Feature_7", keras_input_1_rn."Feature_8" AS "Feature_8", keras_input_1_rn."Feature_9" AS "Feature_9", 0.00951489459221555 + -0.07979637771464865 * keras_input_1_rn."Feature_0" + -0.4613339186614196 * keras_input_1_rn."Feature_1" + -0.4809858466702249 * keras_input_1_rn."Feature_2" + 0.3630554635015063 * keras_input_1_rn."Feature_3" + -0.4926145725018959 * keras_input_1_rn."Feature_4" + -0.6822238838704181 * keras_input_1_rn."Feature_5" + 0.06222983574928912 * keras_input_1_rn."Feature_6" + -0.6433757314186982 * keras_input_1_rn."Feature_7" + -0.3196112225369647 * keras_input_1_rn."Feature_8" + 0.16764278164033491 * keras_input_1_rn."Feature_9" AS dot_prod_1, 0.00990574190093587 + 0.5286559859539827 * keras_input_1_rn."Feature_0" + -0.266416407795382 * keras_input_1_rn."Feature_1" + 0.3200370377841707 * keras_input_1_rn."Feature_2" + -0.09202206847067891 * keras_input_1_rn."Feature_3" + 0.1589314745806587 * keras_input_1_rn."Feature_4" + -0.2719246058183419 * keras_input_1_rn."Feature_5" + 0.5596420816352736 * keras_input_1_rn."Feature_6" + -0.23740310845766963 * keras_input_1_rn."Feature_7" + 0.18579253039529608 * keras_input_1_rn."Feature_8" + 0.6837210776849464 * keras_input_1_rn."Feature_9" AS dot_prod_2 
FROM keras_input_1_rn), 
rnn_cte_simple_rnn_1(rn_1, "KEY", "PreviousState_1", "PreviousState_2", output_1, output_2, "State_1", "State_2") AS 
(SELECT input_kernel_bias.rn AS rn_1, input_kernel_bias."KEY" AS "KEY", CAST(0.0 AS FLOAT) AS "PreviousState_1", CAST(0.0 AS FLOAT) AS "PreviousState_2", input_kernel_bias.dot_prod_1 + 0.0 AS output_1, input_kernel_bias.dot_prod_2 + 0.0 AS output_2, input_kernel_bias.dot_prod_1 + 0.0 AS "State_1", input_kernel_bias.dot_prod_2 + 0.0 AS "State_2" 
FROM input_kernel_bias 
WHERE input_kernel_bias.rn = 1 UNION ALL SELECT input_kernel_bias.rn AS rn, input_kernel_bias."KEY" AS "KEY", rnn_cte_simple_rnn_1."State_1" AS "PreviousState_1", rnn_cte_simple_rnn_1."State_2" AS "PreviousState_2", input_kernel_bias.dot_prod_1 + -0.014566793897911144 * rnn_cte_simple_rnn_1."State_1" + 1.0253390061624372 * rnn_cte_simple_rnn_1."State_2" AS output_1, input_kernel_bias.dot_prod_2 + 0.9092079814062047 * rnn_cte_simple_rnn_1."State_1" + -0.15480055519381575 * rnn_cte_simple_rnn_1."State_2" AS output_2, input_kernel_bias.dot_prod_1 + -0.014566793897911144 * rnn_cte_simple_rnn_1."State_1" + 1.0253390061624372 * rnn_cte_simple_rnn_1."State_2" AS "State_1", input_kernel_bias.dot_prod_2 + 0.9092079814062047 * rnn_cte_simple_rnn_1."State_1" + -0.15480055519381575 * rnn_cte_simple_rnn_1."State_2" AS "State_2" 
FROM input_kernel_bias, rnn_cte_simple_rnn_1 
WHERE input_kernel_bias.rn = rnn_cte_simple_rnn_1.rn_1 + 1), 
simple_rnn_1 AS 
(SELECT rnn_cte_simple_rnn_1."KEY" AS "KEY", CAST(rnn_cte_simple_rnn_1.output_1 AS FLOAT) AS output_1, CAST(rnn_cte_simple_rnn_1.output_2 AS FLOAT) AS output_2 
FROM rnn_cte_simple_rnn_1), 
simple_rnn_1_1 AS 
(SELECT simple_rnn_1."KEY" AS "KEY", simple_rnn_1.output_1 AS output_1, simple_rnn_1.output_2 AS output_2 
FROM simple_rnn_1), 
layer_dense_1 AS 
(SELECT simple_rnn_1_1."KEY" AS "KEY", 0.0112238185011923 + 0.6069456607760209 * simple_rnn_1_1.output_1 + 0.8888539770228024 * simple_rnn_1_1.output_2 AS output_1, -0.005595710875534145 + -0.49300751512601576 * simple_rnn_1_1.output_1 + -0.5751334307267305 * simple_rnn_1_1.output_2 AS output_2, 0.002930832612622847 + -0.6648866156861933 * simple_rnn_1_1.output_1 + -0.6867023599451552 * simple_rnn_1_1.output_2 AS output_3, -0.00433779345632819 + -0.577128602130313 * simple_rnn_1_1.output_1 + -0.19833449522035815 * simple_rnn_1_1.output_2 AS output_4 
FROM simple_rnn_1_1), 
layer_dense_1_1 AS 
(SELECT layer_dense_1."KEY" AS "KEY", layer_dense_1.output_1 AS output_1, layer_dense_1.output_2 AS output_2, layer_dense_1.output_3 AS output_3, layer_dense_1.output_4 AS output_4 
FROM layer_dense_1), 
score_soft_max_step1 AS 
(SELECT layer_dense_1_1."KEY" AS "KEY", layer_dense_1_1.output_1 AS "Score_0", exp(least(100.0, greatest(-100.0, layer_dense_1_1.output_1))) AS "exp_Score_0", layer_dense_1_1.output_2 AS "Score_1", exp(least(100.0, greatest(-100.0, layer_dense_1_1.output_2))) AS "exp_Score_1", layer_dense_1_1.output_3 AS "Score_2", exp(least(100.0, greatest(-100.0, layer_dense_1_1.output_3))) AS "exp_Score_2", layer_dense_1_1.output_4 AS "Score_3", exp(least(100.0, greatest(-100.0, layer_dense_1_1.output_4))) AS "exp_Score_3" 
FROM layer_dense_1_1), 
score_class_union_soft AS 
(SELECT soft_scu."KEY" AS "KEY", soft_scu.class AS class, soft_scu."exp_Score" AS "exp_Score" 
FROM (SELECT score_soft_max_step1."KEY" AS "KEY", 0 AS class, score_soft_max_step1."exp_Score_0" AS "exp_Score" 
FROM score_soft_max_step1 UNION ALL SELECT score_soft_max_step1."KEY" AS "KEY", 1 AS class, score_soft_max_step1."exp_Score_1" AS "exp_Score" 
FROM score_soft_max_step1 UNION ALL SELECT score_soft_max_step1."KEY" AS "KEY", 2 AS class, score_soft_max_step1."exp_Score_2" AS "exp_Score" 
FROM score_soft_max_step1 UNION ALL SELECT score_soft_max_step1."KEY" AS "KEY", 3 AS class, score_soft_max_step1."exp_Score_3" AS "exp_Score" 
FROM score_soft_max_step1) AS soft_scu), 
score_soft_max AS 
(SELECT score_soft_max_step1."KEY" AS "KEY", score_soft_max_step1."Score_0" AS "Score_0", score_soft_max_step1."exp_Score_0" AS "exp_Score_0", score_soft_max_step1."Score_1" AS "Score_1", score_soft_max_step1."exp_Score_1" AS "exp_Score_1", score_soft_max_step1."Score_2" AS "Score_2", score_soft_max_step1."exp_Score_2" AS "exp_Score_2", score_soft_max_step1."Score_3" AS "Score_3", score_soft_max_step1."exp_Score_3" AS "exp_Score_3", sum_exp_t."KEY_sum" AS "KEY_sum", sum_exp_t."sum_ExpScore" AS "sum_ExpScore" 
FROM score_soft_max_step1 LEFT OUTER JOIN (SELECT score_class_union_soft."KEY" AS "KEY_sum", sum(score_class_union_soft."exp_Score") AS "sum_ExpScore" 
FROM score_class_union_soft GROUP BY score_class_union_soft."KEY") AS sum_exp_t ON score_soft_max_step1."KEY" = sum_exp_t."KEY_sum"), 
layer_softmax AS 
(SELECT score_soft_max."KEY" AS "KEY", score_soft_max."exp_Score_0" / score_soft_max."sum_ExpScore" AS output_1, score_soft_max."exp_Score_1" / score_soft_max."sum_ExpScore" AS output_2, score_soft_max."exp_Score_2" / score_soft_max."sum_ExpScore" AS output_3, score_soft_max."exp_Score_3" / score_soft_max."sum_ExpScore" AS output_4 
FROM score_soft_max), 
orig_cte AS 
(SELECT layer_softmax."KEY" AS "KEY", CAST(NULL AS FLOAT) AS "Score_0", CAST(NULL AS FLOAT) AS "Score_1", CAST(NULL AS FLOAT) AS "Score_2", CAST(NULL AS FLOAT) AS "Score_3", layer_softmax.output_1 AS "Proba_0", layer_softmax.output_2 AS "Proba_1", layer_softmax.output_3 AS "Proba_2", layer_softmax.output_4 AS "Proba_3", CAST(NULL AS FLOAT) AS "LogProba_0", CAST(NULL AS FLOAT) AS "LogProba_1", CAST(NULL AS FLOAT) AS "LogProba_2", CAST(NULL AS FLOAT) AS "LogProba_3", CAST(NULL AS BIGINT) AS "Decision", CAST(NULL AS FLOAT) AS "DecisionProba" 
FROM layer_softmax), 
score_class_union AS 
(SELECT scu."KEY_u" AS "KEY_u", scu.class AS class, scu."LogProba" AS "LogProba", scu."Proba" AS "Proba", scu."Score" AS "Score" 
FROM (SELECT orig_cte."KEY" AS "KEY_u", 0 AS class, orig_cte."LogProba_0" AS "LogProba", orig_cte."Proba_0" AS "Proba", orig_cte."Score_0" AS "Score" 
FROM orig_cte UNION ALL SELECT orig_cte."KEY" AS "KEY_u", 1 AS class, orig_cte."LogProba_1" AS "LogProba", orig_cte."Proba_1" AS "Proba", orig_cte."Score_1" AS "Score" 
FROM orig_cte UNION ALL SELECT orig_cte."KEY" AS "KEY_u", 2 AS class, orig_cte."LogProba_2" AS "LogProba", orig_cte."Proba_2" AS "Proba", orig_cte."Score_2" AS "Score" 
FROM orig_cte UNION ALL SELECT orig_cte."KEY" AS "KEY_u", 3 AS class, orig_cte."LogProba_3" AS "LogProba", orig_cte."Proba_3" AS "Proba", orig_cte."Score_3" AS "Score" 
FROM orig_cte) AS scu), 
score_max AS 
(SELECT orig_cte."KEY" AS "KEY", orig_cte."Score_0" AS "Score_0", orig_cte."Score_1" AS "Score_1", orig_cte."Score_2" AS "Score_2", orig_cte."Score_3" AS "Score_3", orig_cte."Proba_0" AS "Proba_0", orig_cte."Proba_1" AS "Proba_1", orig_cte."Proba_2" AS "Proba_2", orig_cte."Proba_3" AS "Proba_3", orig_cte."LogProba_0" AS "LogProba_0", orig_cte."LogProba_1" AS "LogProba_1", orig_cte."LogProba_2" AS "LogProba_2", orig_cte."LogProba_3" AS "LogProba_3", orig_cte."Decision" AS "Decision", orig_cte."DecisionProba" AS "DecisionProba", max_select."KEY_m" AS "KEY_m", max_select."max_Proba" AS "max_Proba" 
FROM orig_cte LEFT OUTER JOIN (SELECT score_class_union."KEY_u" AS "KEY_m", max(score_class_union."Proba") AS "max_Proba" 
FROM score_class_union GROUP BY score_class_union."KEY_u") AS max_select ON orig_cte."KEY" = max_select."KEY_m"), 
union_with_max AS 
(SELECT score_class_union."KEY_u" AS "KEY_u", score_class_union.class AS class, score_class_union."LogProba" AS "LogProba", score_class_union."Proba" AS "Proba", score_class_union."Score" AS "Score", score_max."KEY" AS "KEY", score_max."Score_0" AS "Score_0", score_max."Score_1" AS "Score_1", score_max."Score_2" AS "Score_2", score_max."Score_3" AS "Score_3", score_max."Proba_0" AS "Proba_0", score_max."Proba_1" AS "Proba_1", score_max."Proba_2" AS "Proba_2", score_max."Proba_3" AS "Proba_3", score_max."LogProba_0" AS "LogProba_0", score_max."LogProba_1" AS "LogProba_1", score_max."LogProba_2" AS "LogProba_2", score_max."LogProba_3" AS "LogProba_3", score_max."Decision" AS "Decision", score_max."DecisionProba" AS "DecisionProba", score_max."KEY_m" AS "KEY_m", score_max."max_Proba" AS "max_Proba" 
FROM score_class_union LEFT OUTER JOIN score_max ON score_class_union."KEY_u" = score_max."KEY"), 
arg_max_cte AS 
(SELECT score_max."KEY" AS "KEY", score_max."Score_0" AS "Score_0", score_max."Score_1" AS "Score_1", score_max."Score_2" AS "Score_2", score_max."Score_3" AS "Score_3", score_max."Proba_0" AS "Proba_0", score_max."Proba_1" AS "Proba_1", score_max."Proba_2" AS "Proba_2", score_max."Proba_3" AS "Proba_3", score_max."LogProba_0" AS "LogProba_0", score_max."LogProba_1" AS "LogProba_1", score_max."LogProba_2" AS "LogProba_2", score_max."LogProba_3" AS "LogProba_3", score_max."Decision" AS "Decision", score_max."DecisionProba" AS "DecisionProba", score_max."KEY_m" AS "KEY_m", score_max."max_Proba" AS "max_Proba", "arg_max_t_Proba"."KEY_Proba" AS "KEY_Proba", "arg_max_t_Proba"."arg_max_Proba" AS "arg_max_Proba" 
FROM score_max LEFT OUTER JOIN (SELECT union_with_max."KEY" AS "KEY_Proba", max(union_with_max.class) AS "arg_max_Proba" 
FROM union_with_max 
WHERE union_with_max."max_Proba" <= union_with_max."Proba" GROUP BY union_with_max."KEY") AS "arg_max_t_Proba" ON score_max."KEY" = "arg_max_t_Proba"."KEY_Proba")
 SELECT arg_max_cte."KEY" AS "KEY", arg_max_cte."Score_0" AS "Score_0", arg_max_cte."Score_1" AS "Score_1", arg_max_cte."Score_2" AS "Score_2", arg_max_cte."Score_3" AS "Score_3", arg_max_cte."Proba_0" AS "Proba_0", arg_max_cte."Proba_1" AS "Proba_1", arg_max_cte."Proba_2" AS "Proba_2", arg_max_cte."Proba_3" AS "Proba_3", CASE WHEN (arg_max_cte."Proba_0" IS NULL OR arg_max_cte."Proba_0" > 0.0) THEN ln(arg_max_cte."Proba_0") ELSE -1.79769313486231e+308 END AS "LogProba_0", CASE WHEN (arg_max_cte."Proba_1" IS NULL OR arg_max_cte."Proba_1" > 0.0) THEN ln(arg_max_cte."Proba_1") ELSE -1.79769313486231e+308 END AS "LogProba_1", CASE WHEN (arg_max_cte."Proba_2" IS NULL OR arg_max_cte."Proba_2" > 0.0) THEN ln(arg_max_cte."Proba_2") ELSE -1.79769313486231e+308 END AS "LogProba_2", CASE WHEN (arg_max_cte."Proba_3" IS NULL OR arg_max_cte."Proba_3" > 0.0) THEN ln(arg_max_cte."Proba_3") ELSE -1.79769313486231e+308 END AS "LogProba_3", arg_max_cte."arg_max_Proba" AS "Decision", arg_max_cte."max_Proba" AS "DecisionProba" 
FROM arg_max_cte