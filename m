Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 318993EC0C6
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Aug 2021 07:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236932AbhHNFsX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 14 Aug 2021 01:48:23 -0400
Received: from mga03.intel.com ([134.134.136.65]:23921 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232615AbhHNFsX (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 14 Aug 2021 01:48:23 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10075"; a="215693007"
X-IronPort-AV: E=Sophos;i="5.84,321,1620716400"; 
   d="scan'208";a="215693007"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2021 22:47:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,321,1620716400"; 
   d="scan'208";a="508585362"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 13 Aug 2021 22:47:53 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mEmWO-000OTa-OW; Sat, 14 Aug 2021 05:47:52 +0000
Date:   Sat, 14 Aug 2021 13:47:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org
Subject: [mac80211-next:master] BUILD SUCCESS
 8c89f7b3d3f2880c57b0bc96c72ccd98fe354399
Message-ID: <61175903.o/V5BI1ecJVQW78E%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211-next.git master
branch HEAD: 8c89f7b3d3f2880c57b0bc96c72ccd98fe354399  mac80211: Use flex-array for radiotap header bitmap

elapsed time: 1254m

configs tested: 165
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210812
i386                 randconfig-c001-20210813
openrisc                  or1klitex_defconfig
m68k                        m5407c3_defconfig
powerpc                    klondike_defconfig
mips                     loongson1c_defconfig
arm                          ep93xx_defconfig
arm                          iop32x_defconfig
arm                     davinci_all_defconfig
mips                        workpad_defconfig
arm                       omap2plus_defconfig
powerpc                     pq2fads_defconfig
mips                  maltasmvp_eva_defconfig
h8300                            alldefconfig
xtensa                           allyesconfig
arm                       imx_v4_v5_defconfig
powerpc                      ep88xc_defconfig
powerpc                     rainier_defconfig
sh                            shmin_defconfig
h8300                               defconfig
sh                          rsk7269_defconfig
ia64                          tiger_defconfig
arm                             rpc_defconfig
powerpc                      ppc40x_defconfig
arm                          simpad_defconfig
sh                           se7750_defconfig
powerpc                    socrates_defconfig
riscv                             allnoconfig
powerpc                     ksi8560_defconfig
powerpc                 mpc837x_rdb_defconfig
powerpc                       maple_defconfig
mips                           rs90_defconfig
powerpc                         wii_defconfig
h8300                     edosk2674_defconfig
xtensa                         virt_defconfig
parisc                generic-32bit_defconfig
ia64                             alldefconfig
h8300                       h8s-sim_defconfig
arm                       aspeed_g4_defconfig
sh                  sh7785lcr_32bit_defconfig
mips                       lemote2f_defconfig
sh                 kfr2r09-romimage_defconfig
sh                        edosk7760_defconfig
mips                           xway_defconfig
parisc                generic-64bit_defconfig
arm                           h5000_defconfig
powerpc                     mpc512x_defconfig
powerpc                      ppc6xx_defconfig
powerpc                        warp_defconfig
arm                             ezx_defconfig
arm                          pxa3xx_defconfig
mips                      pic32mzda_defconfig
sparc                               defconfig
arm                           stm32_defconfig
mips                           ip22_defconfig
mips                        bcm63xx_defconfig
mips                     decstation_defconfig
arm                            lart_defconfig
mips                          rm200_defconfig
mips                        nlm_xlr_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a004-20210814
i386                 randconfig-a002-20210814
i386                 randconfig-a001-20210814
i386                 randconfig-a003-20210814
i386                 randconfig-a006-20210814
i386                 randconfig-a005-20210814
i386                 randconfig-a004-20210813
i386                 randconfig-a003-20210813
i386                 randconfig-a001-20210813
i386                 randconfig-a002-20210813
i386                 randconfig-a006-20210813
i386                 randconfig-a005-20210813
x86_64               randconfig-a004-20210814
x86_64               randconfig-a006-20210814
x86_64               randconfig-a003-20210814
x86_64               randconfig-a001-20210814
x86_64               randconfig-a005-20210814
x86_64               randconfig-a002-20210814
x86_64               randconfig-a011-20210813
x86_64               randconfig-a013-20210813
x86_64               randconfig-a012-20210813
x86_64               randconfig-a016-20210813
x86_64               randconfig-a015-20210813
x86_64               randconfig-a014-20210813
x86_64               randconfig-a013-20210814
x86_64               randconfig-a011-20210814
x86_64               randconfig-a016-20210814
x86_64               randconfig-a012-20210814
x86_64               randconfig-a014-20210814
x86_64               randconfig-a015-20210814
i386                 randconfig-a011-20210813
i386                 randconfig-a015-20210813
i386                 randconfig-a014-20210813
i386                 randconfig-a013-20210813
i386                 randconfig-a016-20210813
i386                 randconfig-a012-20210813
i386                 randconfig-a011-20210814
i386                 randconfig-a015-20210814
i386                 randconfig-a013-20210814
i386                 randconfig-a014-20210814
i386                 randconfig-a016-20210814
i386                 randconfig-a012-20210814
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-c001-20210813
x86_64               randconfig-c001-20210814
x86_64               randconfig-a006-20210813
x86_64               randconfig-a004-20210813
x86_64               randconfig-a003-20210813
x86_64               randconfig-a002-20210813
x86_64               randconfig-a005-20210813
x86_64               randconfig-a001-20210813
x86_64               randconfig-a013-20210814
x86_64               randconfig-a011-20210814
x86_64               randconfig-a016-20210814
x86_64               randconfig-a012-20210814
x86_64               randconfig-a014-20210814
x86_64               randconfig-a015-20210814
x86_64               randconfig-a011-20210812
x86_64               randconfig-a013-20210812
x86_64               randconfig-a012-20210812
x86_64               randconfig-a016-20210812
x86_64               randconfig-a015-20210812
x86_64               randconfig-a014-20210812

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
