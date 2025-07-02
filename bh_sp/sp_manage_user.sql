CREATE PROCEDURE manage_user( 
    @last_name varchar(100), 
    @first_name varchar(100), 
    @user_sso varchar(100), 
    @user_role varchar(100), 
    @success_flag int output
) AS  
BEGIN
    DECLARE @id INT;

    SELECT @id = MAX(user_id) + 1 FROM new_user_table;

    INSERT INTO new_user_table (
        first_name, 
        last_name,
        user_sso,
        user_id,
        start_date_active,
        last_date_active,
        creation_date,
        active
    )
    VALUES (
        @first_name,
        @last_name,
        @user_sso,
        @id,
        GETDATE(),
        NULL,
        GETDATE(),
        'A'
    );

    SELECT @id = MAX(role_id) + 1 FROM new_user_roles_table;

    INSERT INTO new_user_roles_table (
        active,
        creation_date,
        role_id,
        role_name,
        user_sso
    )
    VALUES (
        'A',
        GETDATE(),
        @id,
        @user_role,
        @user_sso
    );
END;