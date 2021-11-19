Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99D9845786F
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Nov 2021 23:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233983AbhKSWEb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Nov 2021 17:04:31 -0500
Received: from mga07.intel.com ([134.134.136.100]:16025 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233746AbhKSWEa (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Nov 2021 17:04:30 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10173"; a="297917575"
X-IronPort-AV: E=Sophos;i="5.87,248,1631602800"; 
   d="scan'208";a="297917575"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 14:01:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,248,1631602800"; 
   d="scan'208";a="587907137"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Nov 2021 14:01:26 -0800
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1moBwj-00050W-L0; Fri, 19 Nov 2021 22:01:25 +0000
Date:   Sat, 20 Nov 2021 06:00:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org
Subject: [jberg-mac80211-next:master] BUILD SUCCESS
 1507b153198137dfa9cb4bec7c5dee07089ec3af
Message-ID: <61981e83.g3+ra7LTJmBEAvlN%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211-next.git master
branch HEAD: 1507b153198137dfa9cb4bec7c5dee07089ec3af  cfg80211: move offchan_cac_event to a dedicated work

elapsed time: 722m

configs tested: 180
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211119
i386                 randconfig-c001-20211118
mips                 randconfig-c004-20211118
powerpc                 mpc836x_rdk_defconfig
arm                  colibri_pxa300_defconfig
arm                           h3600_defconfig
arc                    vdk_hs38_smp_defconfig
riscv                    nommu_virt_defconfig
mips                   sb1250_swarm_defconfig
powerpc                      pcm030_defconfig
arm                     eseries_pxa_defconfig
powerpc                     powernv_defconfig
mips                malta_qemu_32r6_defconfig
sh                           se7750_defconfig
powerpc                   bluestone_defconfig
mips                     loongson2k_defconfig
arc                         haps_hs_defconfig
sh                 kfr2r09-romimage_defconfig
mips                           jazz_defconfig
mips                       capcella_defconfig
arm                         vf610m4_defconfig
powerpc                 mpc836x_mds_defconfig
powerpc                      chrp32_defconfig
powerpc                     tqm8541_defconfig
powerpc                 mpc834x_itx_defconfig
arm                         s5pv210_defconfig
m68k                        stmark2_defconfig
nds32                               defconfig
arm                       cns3420vb_defconfig
arm                       netwinder_defconfig
powerpc                      katmai_defconfig
arm                      integrator_defconfig
powerpc                     mpc5200_defconfig
powerpc                       maple_defconfig
mips                           gcw0_defconfig
mips                           ip22_defconfig
arm                        spear3xx_defconfig
powerpc                  mpc885_ads_defconfig
powerpc                      pasemi_defconfig
powerpc                     rainier_defconfig
sparc64                             defconfig
riscv             nommu_k210_sdcard_defconfig
arm                          collie_defconfig
h8300                     edosk2674_defconfig
arm                             mxs_defconfig
sh                               allmodconfig
arm                           stm32_defconfig
arm                            hisi_defconfig
mips                           ip27_defconfig
powerpc                        warp_defconfig
openrisc                 simple_smp_defconfig
sh                   sh7724_generic_defconfig
mips                         db1xxx_defconfig
arm                        cerfcube_defconfig
arm                          pxa168_defconfig
m68k                          multi_defconfig
arm                              alldefconfig
powerpc                       holly_defconfig
arm                        mini2440_defconfig
i386                                defconfig
x86_64                              defconfig
mips                       bmips_be_defconfig
sh                           se7619_defconfig
arm                         cm_x300_defconfig
sh                          r7780mp_defconfig
powerpc                      obs600_defconfig
csky                             alldefconfig
mips                        bcm47xx_defconfig
arm                       spear13xx_defconfig
arm                           tegra_defconfig
ia64                            zx1_defconfig
arm                       imx_v6_v7_defconfig
m68k                          sun3x_defconfig
powerpc64                        alldefconfig
powerpc                 mpc834x_mds_defconfig
mips                 decstation_r4k_defconfig
mips                           rs90_defconfig
arm                         mv78xx0_defconfig
ia64                             alldefconfig
sh                        sh7785lcr_defconfig
arm                  randconfig-c002-20211119
arm                  randconfig-c002-20211118
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a005-20211119
x86_64               randconfig-a003-20211119
x86_64               randconfig-a002-20211119
x86_64               randconfig-a001-20211119
x86_64               randconfig-a006-20211119
x86_64               randconfig-a004-20211119
x86_64               randconfig-a015-20211118
x86_64               randconfig-a012-20211118
x86_64               randconfig-a011-20211118
x86_64               randconfig-a013-20211118
x86_64               randconfig-a016-20211118
x86_64               randconfig-a014-20211118
i386                 randconfig-a016-20211118
i386                 randconfig-a014-20211118
i386                 randconfig-a012-20211118
i386                 randconfig-a011-20211118
i386                 randconfig-a013-20211118
i386                 randconfig-a015-20211118
i386                 randconfig-a016-20211120
i386                 randconfig-a015-20211120
i386                 randconfig-a012-20211120
i386                 randconfig-a013-20211120
i386                 randconfig-a014-20211120
i386                 randconfig-a011-20211120
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
i386                 randconfig-c001-20211119
x86_64               randconfig-c007-20211119
arm                  randconfig-c002-20211119
s390                 randconfig-c005-20211119
powerpc              randconfig-c003-20211119
riscv                randconfig-c006-20211119
i386                 randconfig-a006-20211118
i386                 randconfig-a003-20211118
i386                 randconfig-a001-20211118
i386                 randconfig-a005-20211118
i386                 randconfig-a004-20211118
i386                 randconfig-a002-20211118
x86_64               randconfig-a005-20211118
x86_64               randconfig-a003-20211118
x86_64               randconfig-a001-20211118
x86_64               randconfig-a002-20211118
x86_64               randconfig-a006-20211118
x86_64               randconfig-a004-20211118
x86_64               randconfig-a015-20211119
x86_64               randconfig-a011-20211119
x86_64               randconfig-a012-20211119
x86_64               randconfig-a013-20211119
x86_64               randconfig-a016-20211119
x86_64               randconfig-a014-20211119
hexagon              randconfig-r045-20211119
hexagon              randconfig-r041-20211119
riscv                randconfig-r042-20211119
s390                 randconfig-r044-20211119

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
