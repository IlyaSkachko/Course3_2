
EXEC CREATE_USER
	@NAME = 'DIMA',
	@PASSWORD = '123',
	@ROLE = 'DEVELOPER',
	@EMAIL = 'DIMA@MAIL.RU';

EXEC CREATE_USER
	@NAME = 'TOLIK',
	@PASSWORD = '123',
	@ROLE = 'QA',
	@EMAIL = 'TOLIK@MAIL.RU';

EXEC CREATE_USER
	@NAME = 'LENA',
	@PASSWORD = '123',
	@ROLE = 'QA',
	@EMAIL = 'LENA@MAIL.RU';

EXEC CREATE_USER
	@NAME = 'PETYA',
	@PASSWORD = '123',
	@ROLE = 'MANAGER',
	@EMAIL = 'PETYA@MAIL.RU';

EXEC CREATE_USER
    @NAME = 'IVAN',
    @PASSWORD = '123',
    @ROLE = 'DEVELOPER',
    @EMAIL = 'IVAN@MAIL.RU';

EXEC CREATE_USER
    @NAME = 'OLGA',
    @PASSWORD = '123',
    @ROLE = 'QA',
    @EMAIL = 'OLGA@MAIL.RU';

EXEC CREATE_USER
    @NAME = 'ANDREY',
    @PASSWORD = '123',
    @ROLE = 'QA',
    @EMAIL = 'ANDREY@MAIL.RU';

EXEC CREATE_USER
    @NAME = 'SVETA',
    @PASSWORD = '123',
    @ROLE = 'MANAGER',
    @EMAIL = 'SVETA@MAIL.RU';

EXEC CREATE_USER
    @NAME = 'MIKHAIL',
    @PASSWORD = '123',
    @ROLE = 'DEVELOPER',
    @EMAIL = 'MIKHAIL@MAIL.RU';

ALTER TABLE USERS ADD HierarchyNode HIERARCHYID;


UPDATE USERS
SET HierarchyNode = HIERARCHYID::Parse('/') where ID = 1;

UPDATE USERS
SET HierarchyNode = HIERARCHYID::Parse('/1/') where ID = 2;

UPDATE USERS
SET HierarchyNode = HIERARCHYID::Parse('/2/') where ID = 3;

UPDATE USERS
SET HierarchyNode = HIERARCHYID::Parse('/3/') where ID = 4;

UPDATE USERS
SET HierarchyNode = HIERARCHYID::Parse('/1/1/') where ID = 5;

UPDATE USERS
SET HierarchyNode = HIERARCHYID::Parse('/1/2/') where ID = 6;

UPDATE USERS
SET HierarchyNode = HIERARCHYID::Parse('/3/1/') where ID = 7;

UPDATE USERS
SET HierarchyNode = HIERARCHYID::Parse('/3/2/') where ID = 8;

UPDATE USERS
SET HierarchyNode = HIERARCHYID::Parse('/3/3/') where ID = 9;

SELECT *, HierarchyNode.ToString() as HierarchyString FROM USERS;


-- 2. —оздать процедуру, котора€ отобразит все подчиненные узлы с указанием уровн€ иерархии (параметр Ц значение узла).
--drop PROCEDURE DisplaySubordinates


CREATE OR ALTER PROCEDURE DisplaySubordinates
    @NodeHierarchy HIERARCHYID
AS
BEGIN
    SELECT *, HierarchyNode.ToString() AS HierarchyPath
    FROM USERS
    WHERE HierarchyNode.IsDescendantOf(@NodeHierarchy) = 1 -- проверка €вл€етс€ ли потомком
    ORDER BY HierarchyNode;
END;
GO

DECLARE @NodeHierarchy HIERARCHYID = '/';
EXEC DisplaySubordinates @NodeHierarchy;

SELECT *, HierarchyNode.ToString() as HierarchyString FROM USERS;



-- 3. —оздать процедуру, котора€ добавит подчиненный узел (параметр Ц значение родительского узла).
-- drop PROCEDURE AddSubordinate
CREATE OR ALTER PROCEDURE AddSubordinate
    @ParentNodeHierarchy HIERARCHYID,
    @NewNodeName NVARCHAR(100),
    @NewNodeRole NVARCHAR(100),
    @NewNodeMail NVARCHAR(100),
    @NewNodePassword NVARCHAR(100)
AS
BEGIN
    DECLARE @NewNode HIERARCHYID;
    DECLARE @LastChild HIERARCHYID;

    BEGIN TRY
        SELECT @LastChild = MAX(HierarchyNode)
        FROM USERS
        WHERE HierarchyNode.GetAncestor(1) = @ParentNodeHierarchy;

        SELECT @NewNode = @ParentNodeHierarchy.GetDescendant(@LastChild, NULL)
        FROM USERS
        WHERE HierarchyNode = @ParentNodeHierarchy;

        INSERT INTO USERS(HierarchyNode, NAME, ROLE, PASSWORD, EMAIL)
        VALUES (@NewNode, @NewNodeName, @NewNodeRole, @NewNodePassword, @NewNodeMail);
    END TRY
    BEGIN CATCH
        PRINT 'ќшибка: Ќевозможно добавить уже существующую иерархию.';
    END CATCH
END;
GO

DECLARE   @ParentNodeHierarchy HIERARCHYID = '/2/';
DECLARE    @NewNodeName NVARCHAR(100) = 'VALERA';
DECLARE    @NewNodeRole NVARCHAR(100) = 'MANAGER'
DECLARE    @NewNodeMail NVARCHAR(100) = 'VALERA@MAIL.RU';
DECLARE    @NewNodePassword NVARCHAR(100) = '123';


EXEC AddSubordinate @ParentNodeHierarchy, @NewNodeName, @NewNodeRole, @NewNodeMail, @NewNodePassword;

DELETE FROM USERS WHERE NAME = 'VALERA';

SELECT *, HierarchyNode.ToString() as HierarchyString FROM USERS;


-- 4.  —оздать процедуру, котора€ переместит всех подчиненных (первый параметр Ц значение родительского узла, 
-- подчиненные которого будут перемещатьс€, второй параметр Ц значение нового родительского узла).
CREATE OR ALTER PROCEDURE MoveSubordinates
    @OldParentNodeHierarchy HIERARCHYID,
    @NewParentNodeHierarchy HIERARCHYID
AS
BEGIN
    DECLARE @NewChildNode HIERARCHYID;
    DECLARE @MaxChildNode HIERARCHYID;
    DECLARE @CurrentChildNode HIERARCHYID;
    DECLARE @ChildNodesCursor CURSOR;

    BEGIN TRY
        SET @ChildNodesCursor = CURSOR FOR
        SELECT HierarchyNode
        FROM USERS
        WHERE HierarchyNode.GetAncestor(1) = @OldParentNodeHierarchy
        ORDER BY HierarchyNode;

        OPEN @ChildNodesCursor;

        FETCH NEXT FROM @ChildNodesCursor INTO @CurrentChildNode;
        WHILE @@FETCH_STATUS = 0
        BEGIN
            SELECT @MaxChildNode = MAX(HierarchyNode)
            FROM USERS
            WHERE HierarchyNode.GetAncestor(1) = @NewParentNodeHierarchy;

            SET @NewChildNode = @NewParentNodeHierarchy.GetDescendant(@MaxChildNode, NULL);

            UPDATE USERS
            SET HierarchyNode = @NewChildNode
            WHERE HierarchyNode = @CurrentChildNode;

            FETCH NEXT FROM @ChildNodesCursor INTO @CurrentChildNode;
        END;

        CLOSE @ChildNodesCursor;
        DEALLOCATE @ChildNodesCursor;

        PRINT '”злы успешно перемещены.';
    END TRY
    BEGIN CATCH
        PRINT 'ќшибка: Ќевозможно переместить узлы.';
    END CATCH
END;
GO

SELECT *, HierarchyNode.ToString() as HierarchyString FROM USERS;

DECLARE @OldParentNodeHierarchy HIERARCHYID = '/1/';
DECLARE @NewParentNodeHierarchy HIERARCHYID = '/2/';
EXEC MoveSubordinates @OldParentNodeHierarchy, @NewParentNodeHierarchy;

SELECT *, HierarchyNode.ToString() as HierarchyString FROM USERS;