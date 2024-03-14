select * from users;


ALTER TABLE USERS ADD (PARENT_ID NUMBER);


BEGIN
    UPDATE USERS SET PARENT_ID = NULL WHERE ID = 1;

    UPDATE USERS SET PARENT_ID = 1 WHERE ID IN (2, 3);
    UPDATE USERS SET PARENT_ID = 2 WHERE ID IN (4);
    COMMIT;
END;




--1
CREATE OR REPLACE PROCEDURE display_subordinates(p_node_id IN INTEGER) IS
BEGIN
  FOR rec IN (
    SELECT ID, LEVEL
    FROM USERS
    START WITH ID = p_node_id
    CONNECT BY PRIOR ID = PARENT_ID
  ) LOOP
    DBMS_OUTPUT.PUT_LINE('ID: ' || rec.ID || ', Level: ' || rec.LEVEL);
  END LOOP;
END;

--2
CREATE OR REPLACE PROCEDURE add_subordinate(p_parent_node_id IN NUMBER, p_child_node_id IN NUMBER) IS
BEGIN
    UPDATE USERS SET PARENT_ID = p_parent_node_id WHERE ID = p_child_node_id; COMMIT;
END;

--3
CREATE OR REPLACE PROCEDURE move_subordinates(p_old_parent_node_id IN INTEGER, p_new_parent_node_id IN INTEGER) IS
BEGIN
  UPDATE USERS SET PARENT_ID = p_new_parent_node_id WHERE PARENT_ID = p_old_parent_node_id;
END;

-- Отображение всех подчиненных узлов с указанием уровня иерархии для узла с ID = 1
BEGIN
  display_subordinates(1);
END;

-- Добавление подчиненного узла с ID = 2 к родительскому узлу с ID = 1
BEGIN
  add_subordinate(1, 2);
END;

-- Перемещение всех подчиненных узлов, у которых текущий родительский узел = 3, к новому родительскому узлу с ID = 4
BEGIN
  move_subordinates(3, 4);
END;

select * from USERS;