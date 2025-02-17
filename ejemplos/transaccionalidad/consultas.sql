UPDATE A
JOIN A_B ON A_B.a_id = A.id
SET A.b_id = A_B.b_id
WHERE A.id = A_B.a_id;