Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95B393674E2
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Apr 2021 23:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243326AbhDUVtq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Apr 2021 17:49:46 -0400
Received: from mga02.intel.com ([134.134.136.20]:2670 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241973AbhDUVtq (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Apr 2021 17:49:46 -0400
IronPort-SDR: 0MJKwzXNRa+oYalqr/a9HYJrZdVD8u+zTegct/RhU1LXm90pn/BWwbJACrLGRcj6Xv4qRB8Wjk
 ElkEk14BaWhg==
X-IronPort-AV: E=McAfee;i="6200,9189,9961"; a="182915123"
X-IronPort-AV: E=Sophos;i="5.82,241,1613462400"; 
   d="scan'208";a="182915123"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2021 14:49:12 -0700
IronPort-SDR: EkNvntcxPrt/H3LSB+58d1iZ7q/CZkgjBv8Er4IbbZgJY4+zu2D2TudApnbuwbt+bwH0Xcdkj7
 jsxJVGUNcixA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,241,1613462400"; 
   d="scan'208";a="603018100"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 21 Apr 2021 14:49:11 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lZKic-0003mI-Dk; Wed, 21 Apr 2021 21:49:10 +0000
Date:   Thu, 22 Apr 2021 05:48:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Subject: [wireless-drivers-next:master] BUILD SUCCESS
 afda33499bea154dc792338c5c51a2038a206785
Message-ID: <60809da6.7jo/1YbhB/jnfnzp%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git master
branch HEAD: afda33499bea154dc792338c5c51a2038a206785  rtlwifi: implement set_tim by update beacon content

elapsed time: 721m

configs tested: 139
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
x86_64                           allyesconfig
riscv                            allyesconfig
i386                             allyesconfig
arm                         axm55xx_defconfig
ia64                        generic_defconfig
sparc64                             defconfig
arm                     am200epdkit_defconfig
sh                          rsk7201_defconfig
powerpc                  mpc866_ads_defconfig
um                                allnoconfig
sh                          rsk7203_defconfig
arm                      footbridge_defconfig
powerpc                      katmai_defconfig
arm                      integrator_defconfig
powerpc                    sam440ep_defconfig
arm                       aspeed_g4_defconfig
powerpc                       maple_defconfig
sh                        sh7763rdp_defconfig
arm                              alldefconfig
s390                       zfcpdump_defconfig
m68k                        m5307c3_defconfig
arm                          badge4_defconfig
m68k                           sun3_defconfig
mips                           ip22_defconfig
mips                  cavium_octeon_defconfig
sh                   secureedge5410_defconfig
powerpc                       eiger_defconfig
mips                       bmips_be_defconfig
arm                           sunxi_defconfig
arm                         hackkit_defconfig
powerpc                     pseries_defconfig
sparc                       sparc64_defconfig
powerpc                     sequoia_defconfig
arm                        oxnas_v6_defconfig
sh                          urquell_defconfig
m68k                         apollo_defconfig
arm                        mvebu_v5_defconfig
powerpc                       holly_defconfig
m68k                        m5272c3_defconfig
powerpc                   motionpro_defconfig
mips                     decstation_defconfig
arm                   milbeaut_m10v_defconfig
um                               alldefconfig
arm                       multi_v4t_defconfig
microblaze                          defconfig
mips                          rm200_defconfig
parisc                           allyesconfig
openrisc                    or1ksim_defconfig
nios2                               defconfig
arm                         lpc18xx_defconfig
arm                       mainstone_defconfig
mips                     loongson1b_defconfig
arm                       spear13xx_defconfig
powerpc                      cm5200_defconfig
arm                         vf610m4_defconfig
arc                     haps_hs_smp_defconfig
powerpc                    adder875_defconfig
nios2                         10m50_defconfig
sh                          sdk7780_defconfig
sh                          r7785rp_defconfig
nds32                               defconfig
xtensa                           alldefconfig
powerpc                 mpc836x_mds_defconfig
powerpc                      pasemi_defconfig
powerpc                    klondike_defconfig
mips                           jazz_defconfig
arc                         haps_hs_defconfig
m68k                         amcore_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
arc                              allyesconfig
nds32                             allnoconfig
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
s390                             allmodconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20210421
x86_64               randconfig-a002-20210421
x86_64               randconfig-a001-20210421
x86_64               randconfig-a005-20210421
x86_64               randconfig-a006-20210421
x86_64               randconfig-a003-20210421
i386                 randconfig-a005-20210421
i386                 randconfig-a002-20210421
i386                 randconfig-a001-20210421
i386                 randconfig-a006-20210421
i386                 randconfig-a004-20210421
i386                 randconfig-a003-20210421
i386                 randconfig-a012-20210421
i386                 randconfig-a014-20210421
i386                 randconfig-a011-20210421
i386                 randconfig-a013-20210421
i386                 randconfig-a015-20210421
i386                 randconfig-a016-20210421
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                               allmodconfig
um                               allyesconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a015-20210421
x86_64               randconfig-a016-20210421
x86_64               randconfig-a011-20210421
x86_64               randconfig-a014-20210421
x86_64               randconfig-a013-20210421
x86_64               randconfig-a012-20210421

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
