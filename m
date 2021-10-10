Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83917427E97
	for <lists+linux-wireless@lfdr.de>; Sun, 10 Oct 2021 05:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbhJJDeI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 9 Oct 2021 23:34:08 -0400
Received: from mga04.intel.com ([192.55.52.120]:39654 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229895AbhJJDeH (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 9 Oct 2021 23:34:07 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10132"; a="225479284"
X-IronPort-AV: E=Sophos;i="5.85,361,1624345200"; 
   d="scan'208";a="225479284"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2021 20:32:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,361,1624345200"; 
   d="scan'208";a="479409831"
Received: from lkp-server02.sh.intel.com (HELO 08b2c502c3de) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 09 Oct 2021 20:32:07 -0700
Received: from kbuild by 08b2c502c3de with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mZPZH-0000rv-7u; Sun, 10 Oct 2021 03:32:07 +0000
Date:   Sun, 10 Oct 2021 11:31:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Subject: [kvalo-wireless-drivers-next:pending] BUILD SUCCESS
 c321740f93af1a31d9e149ce5077e28bd4e859f7
Message-ID: <61625e8e.7HwEsBqd8ZUBgVjn%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git pending
branch HEAD: c321740f93af1a31d9e149ce5077e28bd4e859f7  rtw89: add Kconfig and Makefile

elapsed time: 1137m

configs tested: 259
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211009
i386                 randconfig-c001-20211010
powerpc              randconfig-c003-20211009
sh                          sdk7786_defconfig
arm                           stm32_defconfig
arm                             ezx_defconfig
arm                          exynos_defconfig
mips                          rb532_defconfig
mips                       bmips_be_defconfig
m68k                           sun3_defconfig
sh                           se7780_defconfig
nios2                         10m50_defconfig
mips                       capcella_defconfig
arm                        trizeps4_defconfig
powerpc                 mpc85xx_cds_defconfig
powerpc                    sam440ep_defconfig
powerpc                      tqm8xx_defconfig
sh                          rsk7269_defconfig
arm                             mxs_defconfig
m68k                        mvme147_defconfig
sh                            shmin_defconfig
powerpc                      pcm030_defconfig
um                             i386_defconfig
arm                            xcep_defconfig
arm                         lpc32xx_defconfig
mips                      maltaaprp_defconfig
sh                        sh7763rdp_defconfig
mips                        jmr3927_defconfig
mips                       rbtx49xx_defconfig
arm                           h5000_defconfig
m68k                        m5272c3_defconfig
arm                         palmz72_defconfig
ia64                      gensparse_defconfig
arm                       spear13xx_defconfig
m68k                        stmark2_defconfig
arm                     eseries_pxa_defconfig
powerpc64                           defconfig
s390                             alldefconfig
sh                          lboxre2_defconfig
powerpc                     akebono_defconfig
powerpc                   bluestone_defconfig
parisc                generic-32bit_defconfig
i386                                defconfig
powerpc                  mpc885_ads_defconfig
arm                         at91_dt_defconfig
arm                       cns3420vb_defconfig
mips                          ath25_defconfig
xtensa                  cadence_csp_defconfig
sh                               allmodconfig
arm                         axm55xx_defconfig
powerpc                     pseries_defconfig
xtensa                           alldefconfig
h8300                       h8s-sim_defconfig
mips                  maltasmvp_eva_defconfig
powerpc                      ppc6xx_defconfig
arm                         vf610m4_defconfig
arm                              alldefconfig
powerpc                     redwood_defconfig
mips                           mtx1_defconfig
arm                        vexpress_defconfig
microblaze                      mmu_defconfig
mips                       lemote2f_defconfig
arm                          lpd270_defconfig
powerpc                          allyesconfig
powerpc                     mpc83xx_defconfig
xtensa                          iss_defconfig
arm                           viper_defconfig
sh                      rts7751r2d1_defconfig
m68k                          atari_defconfig
arc                         haps_hs_defconfig
sh                   sh7770_generic_defconfig
arm                        mvebu_v7_defconfig
powerpc                 mpc8560_ads_defconfig
sh                            titan_defconfig
sh                             espt_defconfig
arm                      jornada720_defconfig
arm                         bcm2835_defconfig
arm                        shmobile_defconfig
powerpc               mpc834x_itxgp_defconfig
mips                     decstation_defconfig
mips                            e55_defconfig
mips                      maltasmvp_defconfig
arm                       imx_v4_v5_defconfig
mips                         mpc30x_defconfig
arm                          collie_defconfig
sh                           se7206_defconfig
powerpc                 mpc837x_rdb_defconfig
um                               alldefconfig
arm                        neponset_defconfig
powerpc                     tqm8560_defconfig
powerpc                      makalu_defconfig
mips                        omega2p_defconfig
powerpc                  storcenter_defconfig
x86_64                              defconfig
powerpc                    gamecube_defconfig
m68k                          multi_defconfig
sh                        edosk7705_defconfig
powerpc                     rainier_defconfig
mips                          malta_defconfig
arm                        keystone_defconfig
powerpc                      mgcoge_defconfig
sh                           se7712_defconfig
sh                   secureedge5410_defconfig
openrisc                            defconfig
powerpc                     asp8347_defconfig
powerpc                      ppc40x_defconfig
um                                  defconfig
mips                           ip22_defconfig
mips                   sb1250_swarm_defconfig
um                           x86_64_defconfig
powerpc                    mvme5100_defconfig
arm                            pleb_defconfig
sparc64                             defconfig
sh                        sh7785lcr_defconfig
sh                 kfr2r09-romimage_defconfig
alpha                            alldefconfig
powerpc                      acadia_defconfig
sh                     sh7710voipgw_defconfig
mips                           jazz_defconfig
arm                       aspeed_g5_defconfig
arm                            mmp2_defconfig
sh                            migor_defconfig
sh                               j2_defconfig
sh                           se7619_defconfig
sh                           se7721_defconfig
mips                            ar7_defconfig
sh                          r7785rp_defconfig
powerpc64                        alldefconfig
powerpc                      ppc44x_defconfig
powerpc                      arches_defconfig
arm                      footbridge_defconfig
mips                    maltaup_xpa_defconfig
powerpc                     ksi8560_defconfig
arc                              allyesconfig
powerpc                      obs600_defconfig
arm                           sama7_defconfig
powerpc                     tqm8555_defconfig
arm                         s5pv210_defconfig
m68k                        m5307c3_defconfig
arm                   milbeaut_m10v_defconfig
arm                  colibri_pxa270_defconfig
arm                            mps2_defconfig
sh                         ap325rxa_defconfig
arc                     haps_hs_smp_defconfig
mips                      pic32mzda_defconfig
arm                        realview_defconfig
x86_64               randconfig-c001-20211009
arm                  randconfig-c002-20211009
arm                  randconfig-c002-20211010
x86_64               randconfig-c001-20211010
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
nios2                               defconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                                defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a003-20211009
x86_64               randconfig-a005-20211009
x86_64               randconfig-a001-20211009
x86_64               randconfig-a002-20211009
x86_64               randconfig-a004-20211009
x86_64               randconfig-a006-20211009
x86_64               randconfig-a004-20211010
x86_64               randconfig-a006-20211010
x86_64               randconfig-a001-20211010
x86_64               randconfig-a005-20211010
x86_64               randconfig-a002-20211010
x86_64               randconfig-a003-20211010
i386                 randconfig-a001-20211010
i386                 randconfig-a003-20211010
i386                 randconfig-a004-20211010
i386                 randconfig-a005-20211010
i386                 randconfig-a002-20211010
i386                 randconfig-a006-20211010
i386                 randconfig-a001-20211009
i386                 randconfig-a003-20211009
i386                 randconfig-a005-20211009
i386                 randconfig-a004-20211009
i386                 randconfig-a002-20211009
i386                 randconfig-a006-20211009
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                           allyesconfig

clang tested configs:
arm                  randconfig-c002-20211010
mips                 randconfig-c004-20211010
i386                 randconfig-c001-20211010
s390                 randconfig-c005-20211010
x86_64               randconfig-c007-20211010
powerpc              randconfig-c003-20211010
riscv                randconfig-c006-20211010
x86_64               randconfig-c007-20211009
i386                 randconfig-c001-20211009
arm                  randconfig-c002-20211009
s390                 randconfig-c005-20211009
powerpc              randconfig-c003-20211009
riscv                randconfig-c006-20211009
mips                 randconfig-c004-20211009
x86_64               randconfig-a015-20211010
x86_64               randconfig-a012-20211010
x86_64               randconfig-a016-20211010
x86_64               randconfig-a014-20211010
x86_64               randconfig-a013-20211010
x86_64               randconfig-a011-20211010
x86_64               randconfig-a015-20211009
x86_64               randconfig-a012-20211009
x86_64               randconfig-a016-20211009
x86_64               randconfig-a013-20211009
x86_64               randconfig-a011-20211009
x86_64               randconfig-a014-20211009
i386                 randconfig-a013-20211009
i386                 randconfig-a016-20211009
i386                 randconfig-a014-20211009
i386                 randconfig-a012-20211009
i386                 randconfig-a011-20211009
i386                 randconfig-a015-20211009
i386                 randconfig-a016-20211010
i386                 randconfig-a014-20211010
i386                 randconfig-a011-20211010
i386                 randconfig-a015-20211010
i386                 randconfig-a012-20211010
i386                 randconfig-a013-20211010
hexagon              randconfig-r041-20211010
s390                 randconfig-r044-20211010
riscv                randconfig-r042-20211010
hexagon              randconfig-r045-20211010
hexagon              randconfig-r045-20211009
hexagon              randconfig-r041-20211009
s390                 randconfig-r044-20211009
riscv                randconfig-r042-20211009

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
