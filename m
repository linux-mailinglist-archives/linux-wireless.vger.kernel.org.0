Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3CC3F2143
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Aug 2021 21:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233919AbhHSUAQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Aug 2021 16:00:16 -0400
Received: from mga09.intel.com ([134.134.136.24]:10440 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229514AbhHSUAQ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Aug 2021 16:00:16 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10081"; a="216634836"
X-IronPort-AV: E=Sophos;i="5.84,335,1620716400"; 
   d="scan'208";a="216634836"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2021 12:59:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,335,1620716400"; 
   d="scan'208";a="679610884"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 19 Aug 2021 12:59:37 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mGoCP-000UFP-7I; Thu, 19 Aug 2021 19:59:37 +0000
Date:   Fri, 20 Aug 2021 03:59:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org
Subject: [mac80211-next:master] BUILD SUCCESS
 c448f0fd2ce59947b3b8b8d6b56e15036449d1f1
Message-ID: <611eb808.jwFMpSv89mwSIIzq%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211-next.git master
branch HEAD: c448f0fd2ce59947b3b8b8d6b56e15036449d1f1  cfg80211: fix BSS color notify trace enum confusion

elapsed time: 2187m

configs tested: 177
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210816
i386                 randconfig-c001-20210819
h8300                       h8s-sim_defconfig
powerpc                       maple_defconfig
sh                           se7751_defconfig
arm                        realview_defconfig
mips                      loongson3_defconfig
s390                                defconfig
mips                         rt305x_defconfig
powerpc                 linkstation_defconfig
arm                       netwinder_defconfig
alpha                               defconfig
powerpc                  mpc885_ads_defconfig
powerpc                 mpc8313_rdb_defconfig
powerpc                    klondike_defconfig
powerpc                          g5_defconfig
sparc64                          alldefconfig
riscv                          rv32_defconfig
powerpc                         ps3_defconfig
arm                         hackkit_defconfig
sh                           se7724_defconfig
parisc                generic-32bit_defconfig
powerpc                      pmac32_defconfig
sh                          rsk7203_defconfig
m68k                             allmodconfig
arm                           stm32_defconfig
powerpc                       ppc64_defconfig
mips                 decstation_r4k_defconfig
mips                  cavium_octeon_defconfig
arm                       aspeed_g5_defconfig
powerpc                       eiger_defconfig
xtensa                           alldefconfig
sh                          rsk7201_defconfig
sh                          lboxre2_defconfig
powerpc                     tqm8541_defconfig
sh                         ap325rxa_defconfig
nds32                             allnoconfig
mips                       capcella_defconfig
mips                      maltaaprp_defconfig
h8300                     edosk2674_defconfig
sh                               allmodconfig
ia64                        generic_defconfig
sh                            shmin_defconfig
mips                            e55_defconfig
sh                ecovec24-romimage_defconfig
arm                            mmp2_defconfig
powerpc                  storcenter_defconfig
sh                        dreamcast_defconfig
ia64                      gensparse_defconfig
powerpc                      ep88xc_defconfig
arm                        cerfcube_defconfig
sh                          rsk7269_defconfig
arm64                            alldefconfig
sh                        apsh4ad0a_defconfig
mips                       bmips_be_defconfig
powerpc                 mpc837x_rdb_defconfig
arm                       aspeed_g4_defconfig
nios2                         10m50_defconfig
m68k                       m5249evb_defconfig
m68k                       bvme6000_defconfig
microblaze                          defconfig
um                                  defconfig
parisc                           alldefconfig
m68k                       m5275evb_defconfig
arm                         s5pv210_defconfig
mips                         tb0226_defconfig
mips                           ip22_defconfig
arm                       imx_v4_v5_defconfig
mips                           ip27_defconfig
mips                      pic32mzda_defconfig
xtensa                          iss_defconfig
sh                           se7780_defconfig
powerpc                 mpc8540_ads_defconfig
powerpc                     mpc83xx_defconfig
mips                     cu1830-neo_defconfig
mips                           jazz_defconfig
sh                   secureedge5410_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20210818
x86_64               randconfig-a006-20210818
x86_64               randconfig-a003-20210818
x86_64               randconfig-a005-20210818
x86_64               randconfig-a002-20210818
x86_64               randconfig-a001-20210818
x86_64               randconfig-a006-20210816
x86_64               randconfig-a004-20210816
x86_64               randconfig-a003-20210816
x86_64               randconfig-a001-20210816
x86_64               randconfig-a005-20210816
x86_64               randconfig-a002-20210816
i386                 randconfig-a004-20210818
i386                 randconfig-a006-20210818
i386                 randconfig-a002-20210818
i386                 randconfig-a001-20210818
i386                 randconfig-a003-20210818
i386                 randconfig-a005-20210818
x86_64               randconfig-a013-20210819
x86_64               randconfig-a011-20210819
x86_64               randconfig-a012-20210819
x86_64               randconfig-a016-20210819
x86_64               randconfig-a014-20210819
x86_64               randconfig-a015-20210819
i386                 randconfig-a015-20210819
i386                 randconfig-a011-20210819
i386                 randconfig-a014-20210819
i386                 randconfig-a013-20210819
i386                 randconfig-a016-20210819
i386                 randconfig-a012-20210819
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
i386                 randconfig-c001-20210818
x86_64               randconfig-a004-20210819
x86_64               randconfig-a006-20210819
x86_64               randconfig-a003-20210819
x86_64               randconfig-a002-20210819
x86_64               randconfig-a005-20210819
x86_64               randconfig-a001-20210819
x86_64               randconfig-a013-20210818
x86_64               randconfig-a011-20210818
x86_64               randconfig-a012-20210818
x86_64               randconfig-a016-20210818
x86_64               randconfig-a014-20210818
x86_64               randconfig-a015-20210818
i386                 randconfig-a015-20210818
i386                 randconfig-a011-20210818
i386                 randconfig-a013-20210818
i386                 randconfig-a014-20210818
i386                 randconfig-a016-20210818
i386                 randconfig-a012-20210818
i386                 randconfig-a011-20210816
i386                 randconfig-a015-20210816
i386                 randconfig-a013-20210816
i386                 randconfig-a014-20210816
i386                 randconfig-a016-20210816

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
