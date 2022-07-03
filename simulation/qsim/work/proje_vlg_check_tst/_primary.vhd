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
        ind1            : in     vl_logic_vector(4 downto 0);
        ind2            : in     vl_logic_vector(4 downto 0);
        ind3            : in     vl_logic_vector(4 downto 0);
        ind4            : in     vl_logic_vector(4 downto 0);
        isitstart       : in     vl_logic_vector(1 downto 0);
        o_hsync         : in     vl_logic;
        o_vsync         : in     vl_logic;
        registeredbin   : in     vl_logic_vector(3 downto 0);
        sampler_rx      : in     vl_logic
    );
end proje_vlg_check_tst;
