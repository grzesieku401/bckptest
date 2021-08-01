CREATE TABLE test_table (
    id            NUMBER,
    name          VARCHAR2(256),
    text          CLOB,
    text_xml      XMLTYPE,
    some_column   VARCHAR2(512)
);

DECLARE

BEGIN

    FOR I IN 1..100 LOOP
    
        INSERT INTO test_table (
            id,
            name,
            text,
            text_xml,
            some_column
        ) VALUES (
            I,
            'GREAT_NAME_'||I,
            I||' Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque nec velit quis urna tempor posuere ut id turpis. Integer suscipit nibh ut gravida sodales. Morbi placerat leo eros, ut tincidunt turpis auctor at. Pellentesque dictum est quis efficitur tristique. Donec lobortis lectus massa. Fusce tincidunt nisi nulla, a mollis orci placerat vitae. In vel magna convallis tortor commodo tempor at at orci. Mauris rutrum nisl est, quis sagittis tortor consectetur ac. Integer id neque nec lorem porttitor lobortis sit amet a nulla. Quisque ut turpis eget libero faucibus laoreet. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.
                
                Aenean vestibulum, purus ut efficitur dignissim, magna ante mattis diam, aliquam egestas ex est ac arcu. Morbi semper velit quis viverra malesuada. In lorem nunc, finibus in metus a, tincidunt tempor leo. Cras odio libero, pharetra quis eros a, fringilla facilisis nibh. Pellentesque molestie mattis neque vitae ullamcorper. Integer et magna odio. Suspendisse sed scelerisque quam. In dapibus nisi vel tincidunt ultricies. Curabitur nec turpis in nisi pulvinar tincidunt eget maximus sem. Aenean blandit risus varius velit ultrices ultricies eget rhoncus mi.
                
                In in nisi ac neque aliquet pharetra. Morbi iaculis dolor luctus, consequat nunc sit amet, ullamcorper arcu. Sed sit amet leo tempor, pulvinar libero nec, efficitur elit. Nulla facilisi. Aenean varius nulla vitae malesuada faucibus. Nulla maximus condimentum erat a porttitor. Duis auctor, dolor nec maximus rhoncus, sapien elit pellentesque nibh, eu interdum quam ipsum ut metus. Fusce et felis mattis dolor placerat luctus eget id lacus. Vestibulum ultrices leo ex, ac facilisis odio pharetra id. Sed ut nisi quis massa vestibulum euismod. Sed non justo sem. Suspendisse ut purus non augue cursus pretium vitae posuere nulla. Pellentesque aliquet rhoncus pharetra. Vivamus et purus id ex dictum finibus. Maecenas id mauris a dui iaculis consequat. Donec a maximus diam.
                
                Aenean ullamcorper condimentum mattis. Donec eget ante ante. Etiam non porttitor enim, at aliquet purus. Mauris vitae elit varius tortor pulvinar sodales. Nam tempor pharetra libero id lobortis. Nam posuere sagittis tempus. Vivamus varius imperdiet sapien. Phasellus semper eu metus at consequat. Quisque nec sagittis ex, sed eleifend enim. Aenean tincidunt arcu tortor, eu hendrerit nunc ultricies id. Nullam volutpat pretium dapibus. Curabitur malesuada leo diam, in vehicula lacus imperdiet id. Etiam imperdiet ligula nibh, in ullamcorper lorem congue ut. Nunc suscipit nibh odio, sed congue est iaculis ut. Integer dignissim vestibulum tellus, vel condimentum urna maximus et. Fusce imperdiet, ante at interdum viverra, neque ipsum hendrerit justo, at convallis lacus ligula quis mauris.
                
                Donec sed eros bibendum, ultricies nisl eget, sodales felis. Nunc eget diam mollis, posuere nisl a, dapibus mi. Vestibulum pulvinar non tellus nec condimentum. Praesent sit amet sodales felis, ac accumsan magna. Sed posuere magna lacus, vel consectetur nibh ultrices non. Proin tincidunt, magna ut feugiat scelerisque, orci magna placerat magna, sit amet vestibulum nibh quam quis nibh. Interdum et malesuada fames ac ante ipsum primis in faucibus. Etiam ante tellus, aliquam id libero a, bibendum fermentum mauris. Praesent dui libero, molestie et maximus euismod, rhoncus id erat. Donec in sapien at sem lobortis bibendum. Nullam non dui in neque pellentesque ultrices. Proin dignissim massa at mollis posuere. Pellentesque congue at diam vitae tempus.
                ','
            <note>
              <date>2015-09-01</date>
              <hour>08:30</hour>
              <to>Tove</to>
              <from>Jani</from>
              <body>Dont forget me this weekend!</body>
            </note>',
            
            to_char(sysdate,'MISS')*2342342
        );
    
    END LOOP;

END;

CREATE DIRECTORY test_dir AS 'C:\ExFiles'; --Someone with enough privileges

GRANT READ, WRITE, EXECUTE ON DIRECTORY test_dir TO hr; --Someone with enough privileges