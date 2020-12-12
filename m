Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A464E2D888A
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Dec 2020 18:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439606AbgLLRH4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 12 Dec 2020 12:07:56 -0500
Received: from mga12.intel.com ([192.55.52.136]:45488 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392633AbgLLRHz (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 12 Dec 2020 12:07:55 -0500
IronPort-SDR: iMWPFTpSVz6yXLIpDV8nd3oOa8GIMdkJSc6zdSlZq1Aw+wk6GW36XedmNF6fyA/ZkYnTv3ZmcA
 BJuAK/sFzoaA==
X-IronPort-AV: E=McAfee;i="6000,8403,9833"; a="153795302"
X-IronPort-AV: E=Sophos;i="5.78,414,1599548400"; 
   d="scan'208";a="153795302"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2020 09:07:15 -0800
IronPort-SDR: MzBubP12scTUEcFUrPeqYCrnQ/H/c069tPoh8a7oLcuubXYvy+ld/NLkLjPBTFTI/lcwCgoWbf
 H6iA6fV3dBcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,414,1599548400"; 
   d="scan'208";a="326839381"
Received: from lkp-server01.sh.intel.com (HELO ecc0cebe68d1) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 12 Dec 2020 09:07:14 -0800
Received: from kbuild by ecc0cebe68d1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1ko8MT-0001RC-E5; Sat, 12 Dec 2020 17:07:13 +0000
Date:   Sun, 13 Dec 2020 01:06:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Subject: [wireless-drivers-next:master] BUILD SUCCESS
 7ab250385ec276b7b37a2ecc96d375a75b573bd4
Message-ID: <5fd4f8b0.qKDuKhOzTCiSPPAZ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git  master
branch HEAD: 7ab250385ec276b7b37a2ecc96d375a75b573bd4  Merge ath-next from git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git

elapsed time: 723m

configs tested: 208
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
nios2                         3c120_defconfig
sh                 kfr2r09-romimage_defconfig
sh                          r7785rp_defconfig
mips                             allmodconfig
powerpc                     tqm8548_defconfig
m68k                           sun3_defconfig
openrisc                            defconfig
arm                            pleb_defconfig
arm                          collie_defconfig
arm                           sunxi_defconfig
parisc                generic-32bit_defconfig
m68k                       m5275evb_defconfig
arm                          exynos_defconfig
sh                           se7343_defconfig
arm                      integrator_defconfig
arm                        spear6xx_defconfig
arm                          iop32x_defconfig
sh                          lboxre2_defconfig
powerpc                     tqm8541_defconfig
sh                          landisk_defconfig
powerpc                       holly_defconfig
s390                                defconfig
powerpc                 mpc832x_rdb_defconfig
xtensa                    smp_lx200_defconfig
arm                        mvebu_v7_defconfig
sh                             shx3_defconfig
arm                         socfpga_defconfig
arm                          moxart_defconfig
arc                                 defconfig
arm                         s3c6400_defconfig
mips                     cu1000-neo_defconfig
arm                       aspeed_g4_defconfig
arc                         haps_hs_defconfig
powerpc                        warp_defconfig
nios2                         10m50_defconfig
parisc                generic-64bit_defconfig
arm                        mvebu_v5_defconfig
powerpc                      bamboo_defconfig
powerpc                     ppa8548_defconfig
riscv                               defconfig
arm                          gemini_defconfig
sh                             sh03_defconfig
powerpc                      chrp32_defconfig
mips                           gcw0_defconfig
i386                             allyesconfig
m68k                       bvme6000_defconfig
powerpc                   currituck_defconfig
mips                      loongson3_defconfig
nds32                               defconfig
parisc                           alldefconfig
ia64                                defconfig
powerpc                    klondike_defconfig
powerpc                 mpc8560_ads_defconfig
arm                         assabet_defconfig
arm                     eseries_pxa_defconfig
arm                         lubbock_defconfig
arm                   milbeaut_m10v_defconfig
arm                         s3c2410_defconfig
arm                       spear13xx_defconfig
powerpc                        icon_defconfig
powerpc                  mpc885_ads_defconfig
mips                           xway_defconfig
powerpc                      cm5200_defconfig
arm                      footbridge_defconfig
mips                      pistachio_defconfig
mips                      maltaaprp_defconfig
s390                          debug_defconfig
powerpc                    ge_imp3a_defconfig
mips                      bmips_stb_defconfig
powerpc                 xes_mpc85xx_defconfig
sh                             espt_defconfig
sh                   secureedge5410_defconfig
arm                  colibri_pxa270_defconfig
mips                            gpr_defconfig
xtensa                         virt_defconfig
xtensa                generic_kc705_defconfig
sparc                            allyesconfig
powerpc                          g5_defconfig
powerpc                     powernv_defconfig
sh                        sh7763rdp_defconfig
arm                        realview_defconfig
xtensa                           allyesconfig
arm                         mv78xx0_defconfig
sh                  sh7785lcr_32bit_defconfig
arm                          simpad_defconfig
sh                           se7724_defconfig
c6x                                 defconfig
sh                            hp6xx_defconfig
m68k                                defconfig
xtensa                    xip_kc705_defconfig
powerpc               mpc834x_itxgp_defconfig
powerpc                      katmai_defconfig
xtensa                           alldefconfig
riscv                    nommu_virt_defconfig
mips                      maltasmvp_defconfig
powerpc                      makalu_defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20201212
i386                 randconfig-a004-20201212
i386                 randconfig-a003-20201212
i386                 randconfig-a002-20201212
i386                 randconfig-a005-20201212
i386                 randconfig-a006-20201212
i386                 randconfig-a004-20201209
i386                 randconfig-a005-20201209
i386                 randconfig-a001-20201209
i386                 randconfig-a002-20201209
i386                 randconfig-a006-20201209
i386                 randconfig-a003-20201209
i386                 randconfig-a001-20201210
i386                 randconfig-a004-20201210
i386                 randconfig-a003-20201210
i386                 randconfig-a002-20201210
i386                 randconfig-a005-20201210
i386                 randconfig-a006-20201210
x86_64               randconfig-a016-20201212
x86_64               randconfig-a013-20201212
x86_64               randconfig-a015-20201212
x86_64               randconfig-a014-20201212
x86_64               randconfig-a011-20201212
x86_64               randconfig-a016-20201209
x86_64               randconfig-a012-20201209
x86_64               randconfig-a013-20201209
x86_64               randconfig-a014-20201209
x86_64               randconfig-a015-20201209
x86_64               randconfig-a011-20201209
x86_64               randconfig-a012-20201212
x86_64               randconfig-a016-20201210
x86_64               randconfig-a012-20201210
x86_64               randconfig-a013-20201210
x86_64               randconfig-a015-20201210
x86_64               randconfig-a014-20201210
x86_64               randconfig-a011-20201210
i386                 randconfig-a014-20201212
i386                 randconfig-a013-20201212
i386                 randconfig-a012-20201212
i386                 randconfig-a011-20201212
i386                 randconfig-a016-20201212
i386                 randconfig-a015-20201212
i386                 randconfig-a014-20201210
i386                 randconfig-a013-20201210
i386                 randconfig-a012-20201210
i386                 randconfig-a011-20201210
i386                 randconfig-a016-20201210
i386                 randconfig-a015-20201210
i386                 randconfig-a014-20201211
i386                 randconfig-a013-20201211
i386                 randconfig-a012-20201211
i386                 randconfig-a011-20201211
i386                 randconfig-a016-20201211
i386                 randconfig-a015-20201211
i386                 randconfig-a013-20201209
i386                 randconfig-a014-20201209
i386                 randconfig-a011-20201209
i386                 randconfig-a015-20201209
i386                 randconfig-a012-20201209
i386                 randconfig-a016-20201209
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a003-20201212
x86_64               randconfig-a006-20201212
x86_64               randconfig-a002-20201212
x86_64               randconfig-a005-20201212
x86_64               randconfig-a004-20201212
x86_64               randconfig-a001-20201212
x86_64               randconfig-a004-20201209
x86_64               randconfig-a006-20201209
x86_64               randconfig-a005-20201209
x86_64               randconfig-a001-20201209
x86_64               randconfig-a002-20201209
x86_64               randconfig-a003-20201209

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
