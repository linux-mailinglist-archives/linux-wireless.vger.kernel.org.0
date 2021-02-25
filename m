Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64B47325708
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Feb 2021 20:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234048AbhBYTrQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Feb 2021 14:47:16 -0500
Received: from mga14.intel.com ([192.55.52.115]:34382 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235178AbhBYTpB (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Feb 2021 14:45:01 -0500
IronPort-SDR: tGNTDucXWw4dqR6fRQxUcbRt05S4jjxirICLTq0T9QxMdSdL6PvAo60ftnyCU9mhkXdSgQw8xj
 JuyazRbIcnig==
X-IronPort-AV: E=McAfee;i="6000,8403,9906"; a="184954360"
X-IronPort-AV: E=Sophos;i="5.81,206,1610438400"; 
   d="scan'208";a="184954360"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2021 11:42:08 -0800
IronPort-SDR: LSAI9ru+eWqgHD4Io3JWynZGBpvu9Xx5PvoL8LkPeBv3ozOaWllK/5ZCX1n7kczJ0t1oQvRc0i
 TT3aVWLggALA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,206,1610438400"; 
   d="scan'208";a="424774294"
Received: from lkp-server01.sh.intel.com (HELO 16660e54978b) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 25 Feb 2021 11:42:07 -0800
Received: from kbuild by 16660e54978b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lFMWU-0002qc-Tx; Thu, 25 Feb 2021 19:42:06 +0000
Date:   Fri, 26 Feb 2021 03:42:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Subject: [wireless-drivers-next:pending] BUILD SUCCESS
 6a50a3c949db01857a1165ba677d092a9f24fd1f
Message-ID: <6037fd8c.3eOsKw8+RlmSMsh3%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git pending
branch HEAD: 6a50a3c949db01857a1165ba677d092a9f24fd1f  iwlwifi: pcie: fix iwl_so_trans_cfg link error when CONFIG_IWLMVM is disabled

elapsed time: 722m

configs tested: 133
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                     tqm8541_defconfig
arm                          gemini_defconfig
powerpc                 xes_mpc85xx_defconfig
m68k                            q40_defconfig
arm                            mmp2_defconfig
m68k                       m5275evb_defconfig
arm                         socfpga_defconfig
arm                           h3600_defconfig
powerpc64                           defconfig
mips                      pic32mzda_defconfig
powerpc                mpc7448_hpc2_defconfig
m68k                          amiga_defconfig
arm                          ep93xx_defconfig
sh                           se7619_defconfig
powerpc                 mpc836x_mds_defconfig
powerpc                      pcm030_defconfig
arm                          iop32x_defconfig
mips                        bcm47xx_defconfig
powerpc                 mpc837x_mds_defconfig
microblaze                      mmu_defconfig
powerpc                     stx_gp3_defconfig
powerpc                 mpc836x_rdk_defconfig
powerpc                    ge_imp3a_defconfig
mips                           ip27_defconfig
mips                        omega2p_defconfig
arc                        nsim_700_defconfig
s390                             allmodconfig
riscv                            allyesconfig
arc                    vdk_hs38_smp_defconfig
powerpc                 canyonlands_defconfig
sh                     sh7710voipgw_defconfig
powerpc                     akebono_defconfig
h8300                       h8s-sim_defconfig
sh                          rsk7264_defconfig
mips                            e55_defconfig
powerpc                     kilauea_defconfig
arm                         lpc18xx_defconfig
mips                         tb0219_defconfig
powerpc                     ep8248e_defconfig
arm                   milbeaut_m10v_defconfig
riscv                             allnoconfig
arm                            zeus_defconfig
powerpc                      ep88xc_defconfig
mips                          rm200_defconfig
powerpc                       ebony_defconfig
mips                           xway_defconfig
arm                           omap1_defconfig
sh                              ul2_defconfig
powerpc64                        alldefconfig
openrisc                 simple_smp_defconfig
sh                      rts7751r2d1_defconfig
mips                           gcw0_defconfig
arm                         vf610m4_defconfig
arm                             ezx_defconfig
arm                        oxnas_v6_defconfig
mips                      maltaaprp_defconfig
powerpc                 mpc832x_mds_defconfig
arm                       cns3420vb_defconfig
sh                   secureedge5410_defconfig
riscv                    nommu_virt_defconfig
arm                          simpad_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a005-20210225
i386                 randconfig-a006-20210225
i386                 randconfig-a004-20210225
i386                 randconfig-a001-20210225
i386                 randconfig-a003-20210225
i386                 randconfig-a002-20210225
x86_64               randconfig-a015-20210225
x86_64               randconfig-a011-20210225
x86_64               randconfig-a012-20210225
x86_64               randconfig-a016-20210225
x86_64               randconfig-a013-20210225
x86_64               randconfig-a014-20210225
i386                 randconfig-a013-20210225
i386                 randconfig-a012-20210225
i386                 randconfig-a011-20210225
i386                 randconfig-a014-20210225
i386                 randconfig-a016-20210225
i386                 randconfig-a015-20210225
riscv                    nommu_k210_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a001-20210225
x86_64               randconfig-a002-20210225
x86_64               randconfig-a003-20210225
x86_64               randconfig-a005-20210225
x86_64               randconfig-a004-20210225
x86_64               randconfig-a006-20210225

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
