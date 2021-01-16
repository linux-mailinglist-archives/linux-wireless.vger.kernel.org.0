Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B939F2F8F44
	for <lists+linux-wireless@lfdr.de>; Sat, 16 Jan 2021 21:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbhAPUlg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 16 Jan 2021 15:41:36 -0500
Received: from mga18.intel.com ([134.134.136.126]:46981 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726083AbhAPUle (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 16 Jan 2021 15:41:34 -0500
IronPort-SDR: KVR4wxiPajrwCDuKHwPzJn52p5ZtH4gaEIaYZJyX/ccm9YwJvp9fA/pc0lssaL5KM6ISJ/6OVV
 xRJrNbMl3mGQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9866"; a="166353573"
X-IronPort-AV: E=Sophos;i="5.79,352,1602572400"; 
   d="scan'208";a="166353573"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2021 12:40:51 -0800
IronPort-SDR: bObV2KkdRVCrSJNkE6NS3CegRGClq3y7WckhvmwoISFCrBK7Auvh9VIRpmhDJWVa9r3HVnOWKq
 NvFiwHfgyGXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,352,1602572400"; 
   d="scan'208";a="398705818"
Received: from lkp-server01.sh.intel.com (HELO 260eafd5ecd0) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 16 Jan 2021 12:40:49 -0800
Received: from kbuild by 260eafd5ecd0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l0sNM-00017d-TU; Sat, 16 Jan 2021 20:40:48 +0000
Date:   Sun, 17 Jan 2021 04:39:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org
Subject: [mac80211-next:rtnl] BUILD SUCCESS WITH WARNING
 02268c4a68fde1d11204eb1ee51c8bc29ca5252b
Message-ID: <60034f19.ZkokEZdQw+MOR424%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211-next.git rtnl
branch HEAD: 02268c4a68fde1d11204eb1ee51c8bc29ca5252b  fixbrcm

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- openrisc-randconfig-c003-20210116
|   `-- net-wireless-nl80211.c:preceding-lock-on-line
`-- x86_64-randconfig-c002-20210116
    `-- net-wireless-nl80211.c:preceding-lock-on-line

elapsed time: 724m

configs tested: 93
configs skipped: 2

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                          landisk_defconfig
powerpc                   currituck_defconfig
powerpc                           allnoconfig
mips                     cu1830-neo_defconfig
sh                   sh7724_generic_defconfig
arm                          pcm027_defconfig
mips                         mpc30x_defconfig
arm                          exynos_defconfig
mips                            gpr_defconfig
powerpc                       maple_defconfig
sh                ecovec24-romimage_defconfig
sparc                       sparc64_defconfig
sh                        dreamcast_defconfig
openrisc                    or1ksim_defconfig
powerpc                          g5_defconfig
mips                        nlm_xlr_defconfig
ia64                            zx1_defconfig
sh                           se7619_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
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
i386                 randconfig-a002-20210116
i386                 randconfig-a005-20210116
i386                 randconfig-a006-20210116
i386                 randconfig-a003-20210116
i386                 randconfig-a001-20210116
i386                 randconfig-a004-20210116
x86_64               randconfig-a015-20210116
x86_64               randconfig-a012-20210116
x86_64               randconfig-a013-20210116
x86_64               randconfig-a016-20210116
x86_64               randconfig-a014-20210116
x86_64               randconfig-a011-20210116
i386                 randconfig-a012-20210116
i386                 randconfig-a011-20210116
i386                 randconfig-a016-20210116
i386                 randconfig-a013-20210116
i386                 randconfig-a015-20210116
i386                 randconfig-a014-20210116
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
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a006-20210116
x86_64               randconfig-a004-20210116
x86_64               randconfig-a001-20210116
x86_64               randconfig-a005-20210116
x86_64               randconfig-a003-20210116
x86_64               randconfig-a002-20210116

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
