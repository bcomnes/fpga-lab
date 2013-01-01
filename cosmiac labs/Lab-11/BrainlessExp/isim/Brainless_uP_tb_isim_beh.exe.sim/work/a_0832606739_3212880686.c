/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0x7dea747 */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "C:/Users/BrianZ/Desktop/BrainlessExp/ALU.vhd";
extern char *IEEE_P_3620187407;
extern char *IEEE_P_2592010699;

char *ieee_p_2592010699_sub_1735675855_2592010699(char *, char *, char *, char *, char *, char *);
char *ieee_p_2592010699_sub_1837678034_2592010699(char *, char *, char *, char *);
char *ieee_p_3620187407_sub_436279890_3620187407(char *, char *, char *, char *, int );
char *ieee_p_3620187407_sub_767668596_3620187407(char *, char *, char *, char *, char *, char *);


static void work_a_0832606739_3212880686_p_0(char *t0)
{
    char t32[16];
    char t33[16];
    char t34[16];
    char *t1;
    char *t2;
    char *t3;
    int t4;
    char *t5;
    char *t6;
    int t7;
    char *t8;
    char *t9;
    int t10;
    char *t11;
    char *t12;
    int t13;
    char *t14;
    char *t15;
    int t16;
    char *t17;
    int t19;
    char *t20;
    int t22;
    char *t23;
    int t25;
    char *t26;
    char *t27;
    char *t28;
    char *t29;
    char *t30;
    char *t31;

LAB0:    xsi_set_current_line(36, ng0);
    t1 = (t0 + 2312U);
    t2 = *((char **)t1);
    t1 = (t0 + 6259);
    t4 = xsi_mem_cmp(t1, t2, 3U);
    if (t4 == 1)
        goto LAB3;

LAB12:    t5 = (t0 + 6262);
    t7 = xsi_mem_cmp(t5, t2, 3U);
    if (t7 == 1)
        goto LAB4;

LAB13:    t8 = (t0 + 6265);
    t10 = xsi_mem_cmp(t8, t2, 3U);
    if (t10 == 1)
        goto LAB5;

LAB14:    t11 = (t0 + 6268);
    t13 = xsi_mem_cmp(t11, t2, 3U);
    if (t13 == 1)
        goto LAB6;

LAB15:    t14 = (t0 + 6271);
    t16 = xsi_mem_cmp(t14, t2, 3U);
    if (t16 == 1)
        goto LAB7;

LAB16:    t17 = (t0 + 6274);
    t19 = xsi_mem_cmp(t17, t2, 3U);
    if (t19 == 1)
        goto LAB8;

LAB17:    t20 = (t0 + 6277);
    t22 = xsi_mem_cmp(t20, t2, 3U);
    if (t22 == 1)
        goto LAB9;

LAB18:    t23 = (t0 + 6280);
    t25 = xsi_mem_cmp(t23, t2, 3U);
    if (t25 == 1)
        goto LAB10;

LAB19:
LAB11:    xsi_set_current_line(54, ng0);
    t1 = (t0 + 6283);
    t3 = (t0 + 4136);
    t5 = (t3 + 56U);
    t6 = *((char **)t5);
    t8 = (t6 + 56U);
    t9 = *((char **)t8);
    memcpy(t9, t1, 4U);
    xsi_driver_first_trans_fast_port(t3);

LAB2:    t1 = (t0 + 4040);
    *((int *)t1) = 1;

LAB1:    return;
LAB3:    xsi_set_current_line(38, ng0);
    t26 = (t0 + 1032U);
    t27 = *((char **)t26);
    t26 = (t0 + 4136);
    t28 = (t26 + 56U);
    t29 = *((char **)t28);
    t30 = (t29 + 56U);
    t31 = *((char **)t30);
    memcpy(t31, t27, 4U);
    xsi_driver_first_trans_fast_port(t26);
    goto LAB2;

LAB4:    xsi_set_current_line(40, ng0);
    t1 = (t0 + 1032U);
    t2 = *((char **)t1);
    t1 = (t0 + 6172U);
    t3 = (t0 + 1192U);
    t5 = *((char **)t3);
    t3 = (t0 + 6188U);
    t6 = ieee_p_3620187407_sub_767668596_3620187407(IEEE_P_3620187407, t32, t2, t1, t5, t3);
    t8 = (t0 + 4136);
    t9 = (t8 + 56U);
    t11 = *((char **)t9);
    t12 = (t11 + 56U);
    t14 = *((char **)t12);
    memcpy(t14, t6, 4U);
    xsi_driver_first_trans_fast_port(t8);
    goto LAB2;

LAB5:    xsi_set_current_line(42, ng0);
    t1 = (t0 + 1032U);
    t2 = *((char **)t1);
    t1 = (t0 + 6172U);
    t3 = ieee_p_2592010699_sub_1837678034_2592010699(IEEE_P_2592010699, t33, t2, t1);
    t5 = ieee_p_3620187407_sub_436279890_3620187407(IEEE_P_3620187407, t32, t3, t33, 1);
    t6 = (t0 + 4136);
    t8 = (t6 + 56U);
    t9 = *((char **)t8);
    t11 = (t9 + 56U);
    t12 = *((char **)t11);
    memcpy(t12, t5, 4U);
    xsi_driver_first_trans_fast_port(t6);
    goto LAB2;

LAB6:    xsi_set_current_line(44, ng0);
    t1 = (t0 + 1032U);
    t2 = *((char **)t1);
    t1 = (t0 + 6172U);
    t3 = ieee_p_2592010699_sub_1837678034_2592010699(IEEE_P_2592010699, t34, t2, t1);
    t5 = ieee_p_3620187407_sub_436279890_3620187407(IEEE_P_3620187407, t33, t3, t34, 1);
    t6 = (t0 + 1192U);
    t8 = *((char **)t6);
    t6 = (t0 + 6188U);
    t9 = ieee_p_3620187407_sub_767668596_3620187407(IEEE_P_3620187407, t32, t5, t33, t8, t6);
    t11 = (t0 + 4136);
    t12 = (t11 + 56U);
    t14 = *((char **)t12);
    t15 = (t14 + 56U);
    t17 = *((char **)t15);
    memcpy(t17, t9, 4U);
    xsi_driver_first_trans_fast_port(t11);
    goto LAB2;

LAB7:    xsi_set_current_line(46, ng0);
    t1 = (t0 + 1032U);
    t2 = *((char **)t1);
    t1 = (t0 + 4136);
    t3 = (t1 + 56U);
    t5 = *((char **)t3);
    t6 = (t5 + 56U);
    t8 = *((char **)t6);
    memcpy(t8, t2, 4U);
    xsi_driver_first_trans_fast_port(t1);
    goto LAB2;

LAB8:    xsi_set_current_line(48, ng0);
    t1 = (t0 + 1032U);
    t2 = *((char **)t1);
    t1 = (t0 + 6172U);
    t3 = (t0 + 1192U);
    t5 = *((char **)t3);
    t3 = (t0 + 6188U);
    t6 = ieee_p_2592010699_sub_1735675855_2592010699(IEEE_P_2592010699, t32, t2, t1, t5, t3);
    t8 = (t0 + 4136);
    t9 = (t8 + 56U);
    t11 = *((char **)t9);
    t12 = (t11 + 56U);
    t14 = *((char **)t12);
    memcpy(t14, t6, 4U);
    xsi_driver_first_trans_fast_port(t8);
    goto LAB2;

LAB9:    xsi_set_current_line(50, ng0);
    t1 = (t0 + 1032U);
    t2 = *((char **)t1);
    t1 = (t0 + 6172U);
    t3 = ieee_p_2592010699_sub_1837678034_2592010699(IEEE_P_2592010699, t32, t2, t1);
    t5 = (t0 + 4136);
    t6 = (t5 + 56U);
    t8 = *((char **)t6);
    t9 = (t8 + 56U);
    t11 = *((char **)t9);
    memcpy(t11, t3, 4U);
    xsi_driver_first_trans_fast_port(t5);
    goto LAB2;

LAB10:    xsi_set_current_line(52, ng0);
    t1 = (t0 + 1032U);
    t2 = *((char **)t1);
    t1 = (t0 + 6172U);
    t3 = ieee_p_2592010699_sub_1837678034_2592010699(IEEE_P_2592010699, t33, t2, t1);
    t5 = (t0 + 1192U);
    t6 = *((char **)t5);
    t5 = (t0 + 6188U);
    t8 = ieee_p_2592010699_sub_1735675855_2592010699(IEEE_P_2592010699, t32, t3, t33, t6, t5);
    t9 = (t0 + 4136);
    t11 = (t9 + 56U);
    t12 = *((char **)t11);
    t14 = (t12 + 56U);
    t15 = *((char **)t14);
    memcpy(t15, t8, 4U);
    xsi_driver_first_trans_fast_port(t9);
    goto LAB2;

LAB20:;
}

static void work_a_0832606739_3212880686_p_1(char *t0)
{
    char t6[16];
    char t11[16];
    char *t1;
    char *t2;
    unsigned char t3;
    char *t4;
    unsigned char t5;
    char *t7;
    char *t8;
    char *t9;
    unsigned char t10;
    char *t12;
    char *t13;
    char *t14;
    char *t15;
    char *t16;
    char *t17;
    char *t18;

LAB0:    xsi_set_current_line(59, ng0);

LAB3:    t1 = (t0 + 1832U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t1 = (t0 + 1672U);
    t4 = *((char **)t1);
    t5 = *((unsigned char *)t4);
    t7 = ((IEEE_P_2592010699) + 4024);
    t1 = xsi_base_array_concat(t1, t6, t7, (char)99, t3, (char)99, t5, (char)101);
    t8 = (t0 + 1512U);
    t9 = *((char **)t8);
    t10 = *((unsigned char *)t9);
    t12 = ((IEEE_P_2592010699) + 4024);
    t8 = xsi_base_array_concat(t8, t11, t12, (char)97, t1, t6, (char)99, t10, (char)101);
    t13 = (t0 + 4200);
    t14 = (t13 + 56U);
    t15 = *((char **)t14);
    t16 = (t15 + 56U);
    t17 = *((char **)t16);
    memcpy(t17, t8, 3U);
    xsi_driver_first_trans_fast(t13);

LAB2:    t18 = (t0 + 4056);
    *((int *)t18) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}


extern void work_a_0832606739_3212880686_init()
{
	static char *pe[] = {(void *)work_a_0832606739_3212880686_p_0,(void *)work_a_0832606739_3212880686_p_1};
	xsi_register_didat("work_a_0832606739_3212880686", "isim/Brainless_uP_tb_isim_beh.exe.sim/work/a_0832606739_3212880686.didat");
	xsi_register_executes(pe);
}
