library verilog;
use verilog.vl_types.all;
entity proje_vlg_check_tst is
    port(
        b               : in     vl_logic;
        bf1             : in     vl_logic_vector(17 downto 0);
        bf2             : in     vl_logic_vector(17 downto 0);
        bf3             : in     vl_logic_vector(17 downto 0);
        bf4             : in     vl_logic_vector(17 downto 0);
        clk25           : in     vl_logic;
        color           : in     vl_logic_vector(7 downto 0);
        inside1         : in     vl_logic_vector(2 downto 0);
        inside2         : in     vl_logic_vector(2 downto 0);
        inside3         : in     vl_logic_vector(2 downto 0);
        inside4         : in     vl_logic_vector(2 downto 0);
        isitstart       : in     vl_logic_vector(1 downto 0);
        o_hsync         : in     vl_logic;
        o_vsync         : in     vl_logic;
        registeredbin   : in     vl_logic_vector(3 downto 0);
        sampler_rx      : in     vl_logic
    );
end proje_vlg_check_tst;
