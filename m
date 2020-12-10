Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3E62D6C11
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Dec 2020 01:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393841AbgLJXlM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Dec 2020 18:41:12 -0500
Received: from mga03.intel.com ([134.134.136.65]:26776 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393842AbgLJXlC (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Dec 2020 18:41:02 -0500
IronPort-SDR: lWz4pXqas782CWCN5DuUYpglQQz/RPVS9ZxEBeDIALfyfxwDJX/0Kdmkp9qmFiuZ+/JWMUGvcG
 fOu2nTW7niSw==
X-IronPort-AV: E=McAfee;i="6000,8403,9831"; a="174464933"
X-IronPort-AV: E=Sophos;i="5.78,409,1599548400"; 
   d="scan'208";a="174464933"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2020 15:40:21 -0800
IronPort-SDR: knwrnAiFN3UfdD/ALB4kb/S2rPa5eAXVkkn/poVswPnkOloP3fefX3RTDuMgKLle0RW++7afQb
 LYHvSOryI5cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,409,1599548400"; 
   d="scan'208";a="544215719"
Received: from lkp-server01.sh.intel.com (HELO ecc0cebe68d1) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 10 Dec 2020 15:40:20 -0800
Received: from kbuild by ecc0cebe68d1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1knVXn-0000aH-Gb; Thu, 10 Dec 2020 23:40:19 +0000
Date:   Fri, 11 Dec 2020 07:39:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Subject: [wireless-drivers-next:pending] BUILD SUCCESS
 8e288af63f80b579652df97f1f6cfd069b85af96
Message-ID: <5fd2b1cd.MvSMXEoivVlU5QhP%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git  pending
branch HEAD: 8e288af63f80b579652df97f1f6cfd069b85af96  Merge tag 'iwlwifi-next-for-kalle-2020-12-09' of git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next into pending

elapsed time: 727m

configs tested: 182
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                       omap2plus_defconfig
mips                         db1xxx_defconfig
powerpc                      cm5200_defconfig
mips                        maltaup_defconfig
powerpc                     skiroot_defconfig
mips                        workpad_defconfig
arm                        shmobile_defconfig
powerpc                     ep8248e_defconfig
arm                          pcm027_defconfig
powerpc                 mpc836x_mds_defconfig
arc                         haps_hs_defconfig
sh                             shx3_defconfig
arm                          ixp4xx_defconfig
arm                          simpad_defconfig
mips                           ip28_defconfig
mips                           ci20_defconfig
arm                            zeus_defconfig
sh                           se7343_defconfig
sh                            migor_defconfig
mips                        vocore2_defconfig
arm                         orion5x_defconfig
arm                     eseries_pxa_defconfig
arm                      tct_hammer_defconfig
powerpc                    mvme5100_defconfig
powerpc                      acadia_defconfig
arm                          imote2_defconfig
mips                           gcw0_defconfig
powerpc                     asp8347_defconfig
powerpc                         ps3_defconfig
sh                           se7705_defconfig
sh                        sh7763rdp_defconfig
sparc64                          alldefconfig
h8300                               defconfig
sh                          rsk7201_defconfig
powerpc                 mpc836x_rdk_defconfig
sh                          rsk7264_defconfig
sh                             sh03_defconfig
powerpc                  iss476-smp_defconfig
mips                     loongson1c_defconfig
powerpc                  storcenter_defconfig
arm                      footbridge_defconfig
arm                          iop32x_defconfig
arc                            hsdk_defconfig
mips                           rs90_defconfig
arm                          collie_defconfig
openrisc                    or1ksim_defconfig
mips                        bcm63xx_defconfig
m68k                         apollo_defconfig
mips                          ath25_defconfig
powerpc                 mpc834x_mds_defconfig
arm                        oxnas_v6_defconfig
s390                                defconfig
arm                        spear6xx_defconfig
arm                         s3c6400_defconfig
mips                            ar7_defconfig
arm                       versatile_defconfig
powerpc                        icon_defconfig
c6x                                 defconfig
mips                             allyesconfig
mips                          rb532_defconfig
mips                        bcm47xx_defconfig
powerpc                     tqm8541_defconfig
m68k                             alldefconfig
arm                          ep93xx_defconfig
arm                        cerfcube_defconfig
arm                       multi_v4t_defconfig
sh                          urquell_defconfig
sh                          sdk7786_defconfig
powerpc                      ppc64e_defconfig
arm                         palmz72_defconfig
sh                  sh7785lcr_32bit_defconfig
arm                         shannon_defconfig
sh                               j2_defconfig
m68k                       m5249evb_defconfig
sh                   rts7751r2dplus_defconfig
powerpc                 mpc834x_itx_defconfig
sh                               alldefconfig
m68k                          amiga_defconfig
powerpc                      ppc40x_defconfig
mips                          rm200_defconfig
arm                             mxs_defconfig
riscv                            alldefconfig
powerpc                      arches_defconfig
m68k                        m5272c3_defconfig
powerpc                 mpc837x_rdb_defconfig
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
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
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
x86_64               randconfig-a016-20201209
x86_64               randconfig-a012-20201209
x86_64               randconfig-a013-20201209
x86_64               randconfig-a014-20201209
x86_64               randconfig-a015-20201209
x86_64               randconfig-a011-20201209
x86_64               randconfig-a016-20201210
x86_64               randconfig-a012-20201210
x86_64               randconfig-a013-20201210
x86_64               randconfig-a015-20201210
x86_64               randconfig-a014-20201210
x86_64               randconfig-a011-20201210
i386                 randconfig-a013-20201209
i386                 randconfig-a014-20201209
i386                 randconfig-a011-20201209
i386                 randconfig-a015-20201209
i386                 randconfig-a012-20201209
i386                 randconfig-a016-20201209
i386                 randconfig-a014-20201210
i386                 randconfig-a013-20201210
i386                 randconfig-a012-20201210
i386                 randconfig-a011-20201210
i386                 randconfig-a016-20201210
i386                 randconfig-a015-20201210
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20201209
x86_64               randconfig-a006-20201209
x86_64               randconfig-a005-20201209
x86_64               randconfig-a001-20201209
x86_64               randconfig-a002-20201209
x86_64               randconfig-a003-20201209
x86_64               randconfig-a003-20201210
x86_64               randconfig-a006-20201210
x86_64               randconfig-a002-20201210
x86_64               randconfig-a005-20201210
x86_64               randconfig-a004-20201210
x86_64               randconfig-a001-20201210

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
