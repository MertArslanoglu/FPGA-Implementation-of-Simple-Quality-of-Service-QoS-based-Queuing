library verilog;
use verilog.vl_types.all;
entity proje is
    port(
        clk             : in     vl_logic;
        start           : in     vl_logic;
        bin0            : in     vl_logic;
        bin1            : in     vl_logic;
        registeredbin   : out    vl_logic_vector(3 downto 0);
        bf1             : out    vl_logic_vector(17 downto 0);
        bf2             : out    vl_logic_vector(17 downto 0);
        bf3             : out    vl_logic_vector(17 downto 0);
        bf4             : out    vl_logic_vector(17 downto 0);
        isitstart       : out    vl_logic_vector(1 downto 0);
        b               : out    vl_logic
    );
end proje;
