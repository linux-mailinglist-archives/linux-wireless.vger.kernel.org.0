Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9754241CE9C
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Sep 2021 00:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346324AbhI2WBq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Sep 2021 18:01:46 -0400
Received: from mga17.intel.com ([192.55.52.151]:60942 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230458AbhI2WBp (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Sep 2021 18:01:45 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10122"; a="205196998"
X-IronPort-AV: E=Sophos;i="5.85,334,1624345200"; 
   d="scan'208";a="205196998"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2021 15:00:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,334,1624345200"; 
   d="scan'208";a="563631050"
Received: from lkp-server02.sh.intel.com (HELO f7acefbbae94) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 29 Sep 2021 15:00:02 -0700
Received: from kbuild by f7acefbbae94 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mVhcP-0003NA-Ae; Wed, 29 Sep 2021 22:00:01 +0000
Date:   Thu, 30 Sep 2021 05:59:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     linux-wireless@vger.kernel.org
Subject: [jberg-mac80211:master] BUILD SUCCESS
 f936bb42aeb94a069bec7c9e04100d199c372956
Message-ID: <6154e1d2.ieHeZEROqb20cN5W%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211.git master
branch HEAD: f936bb42aeb94a069bec7c9e04100d199c372956  net: bridge: mcast: Associate the seqcount with its protecting lock.

elapsed time: 1130m

configs tested: 186
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210929
i386                 randconfig-c001-20210928
powerpc                    sam440ep_defconfig
sh                          rsk7203_defconfig
powerpc                       ebony_defconfig
mips                            ar7_defconfig
xtensa                    smp_lx200_defconfig
arm                          iop32x_defconfig
sh                      rts7751r2d1_defconfig
nios2                            alldefconfig
arm                         s3c6400_defconfig
mips                        qi_lb60_defconfig
arm                          lpd270_defconfig
powerpc                       ppc64_defconfig
ia64                      gensparse_defconfig
powerpc                      pmac32_defconfig
powerpc                    amigaone_defconfig
mips                         bigsur_defconfig
arm                          collie_defconfig
sh                         ap325rxa_defconfig
powerpc                      mgcoge_defconfig
mips                       lemote2f_defconfig
sh                        sh7757lcr_defconfig
arm                      pxa255-idp_defconfig
arm                         lpc32xx_defconfig
mips                      fuloong2e_defconfig
sh                        edosk7760_defconfig
mips                        maltaup_defconfig
powerpc                       holly_defconfig
arm                      footbridge_defconfig
um                                  defconfig
arc                          axs101_defconfig
xtensa                    xip_kc705_defconfig
ia64                          tiger_defconfig
arm                           spitz_defconfig
mips                        bcm47xx_defconfig
sh                          lboxre2_defconfig
ia64                                defconfig
powerpc                     tqm8555_defconfig
powerpc                   microwatt_defconfig
microblaze                          defconfig
arm                            qcom_defconfig
powerpc                   lite5200b_defconfig
arm                             rpc_defconfig
sparc64                          alldefconfig
sh                            shmin_defconfig
xtensa                              defconfig
h8300                       h8s-sim_defconfig
arm                         hackkit_defconfig
powerpc                     asp8347_defconfig
mips                        jmr3927_defconfig
sparc                       sparc32_defconfig
powerpc                         ps3_defconfig
sh                                  defconfig
sh                 kfr2r09-romimage_defconfig
arm                       imx_v6_v7_defconfig
sh                   secureedge5410_defconfig
mips                     loongson1c_defconfig
mips                         mpc30x_defconfig
riscv             nommu_k210_sdcard_defconfig
powerpc                     tqm8560_defconfig
sh                           se7722_defconfig
sh                           se7751_defconfig
arm                       cns3420vb_defconfig
powerpc                          g5_defconfig
sh                            hp6xx_defconfig
arm                       spear13xx_defconfig
xtensa                generic_kc705_defconfig
arm                         s5pv210_defconfig
ia64                         bigsur_defconfig
mips                           ip22_defconfig
mips                        bcm63xx_defconfig
arm                         lpc18xx_defconfig
powerpc                        cell_defconfig
sh                           se7750_defconfig
nds32                               defconfig
parisc                           alldefconfig
sh                          kfr2r09_defconfig
arm                          simpad_defconfig
arm                            mmp2_defconfig
arm                         assabet_defconfig
m68k                            mac_defconfig
sh                           sh2007_defconfig
arm                          ixp4xx_defconfig
arm                       mainstone_defconfig
mips                           ip27_defconfig
powerpc                      walnut_defconfig
powerpc                 xes_mpc85xx_defconfig
m68k                         amcore_defconfig
powerpc                    gamecube_defconfig
powerpc                 linkstation_defconfig
sh                             shx3_defconfig
microblaze                      mmu_defconfig
m68k                            q40_defconfig
arm                           stm32_defconfig
arm                           tegra_defconfig
s390                          debug_defconfig
nios2                         10m50_defconfig
m68k                        mvme16x_defconfig
powerpc                     taishan_defconfig
ia64                             alldefconfig
x86_64               randconfig-c001-20210929
arm                  randconfig-c002-20210929
ia64                             allmodconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
parisc                              defconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allmodconfig
s390                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                             allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a002-20210929
x86_64               randconfig-a005-20210929
x86_64               randconfig-a001-20210929
x86_64               randconfig-a006-20210929
x86_64               randconfig-a003-20210929
x86_64               randconfig-a004-20210929
i386                 randconfig-a001-20210929
i386                 randconfig-a005-20210929
i386                 randconfig-a002-20210929
i386                 randconfig-a006-20210929
i386                 randconfig-a004-20210929
i386                 randconfig-a003-20210929
arc                  randconfig-r043-20210929
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                           allyesconfig

clang tested configs:
powerpc              randconfig-c003-20210929
mips                 randconfig-c004-20210929
arm                  randconfig-c002-20210929
x86_64               randconfig-c007-20210929
riscv                randconfig-c006-20210929
s390                 randconfig-c005-20210929
i386                 randconfig-c001-20210929
x86_64               randconfig-a014-20210929
x86_64               randconfig-a011-20210929
x86_64               randconfig-a013-20210929
x86_64               randconfig-a015-20210929
x86_64               randconfig-a012-20210929
x86_64               randconfig-a016-20210929
i386                 randconfig-a014-20210929
i386                 randconfig-a013-20210929
i386                 randconfig-a016-20210929
i386                 randconfig-a011-20210929
i386                 randconfig-a015-20210929
i386                 randconfig-a012-20210929
hexagon              randconfig-r045-20210929
riscv                randconfig-r042-20210929
hexagon              randconfig-r041-20210929
s390                 randconfig-r044-20210929

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
