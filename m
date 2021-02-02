Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5B3130B912
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Feb 2021 09:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbhBBH7f (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 2 Feb 2021 02:59:35 -0500
Received: from mga18.intel.com ([134.134.136.126]:34124 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231132AbhBBH7b (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 2 Feb 2021 02:59:31 -0500
IronPort-SDR: ioPFGXkiCbSNshrExg+DQv+nxQQB9eZxlKHWnHSDslDeZplO472zXJPfOixHzYR43s2QCAyr4R
 nMmVG1PvPEpg==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="168493102"
X-IronPort-AV: E=Sophos;i="5.79,394,1602572400"; 
   d="scan'208";a="168493102"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 23:58:38 -0800
IronPort-SDR: DbSEdgXpJCmGnRdneE9qmu1j39eNZONeF6e0rzyazRwSNyumLJFG5Zv02+sBRD4QcwffzJfWEy
 EBwVfcYseLvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,394,1602572400"; 
   d="scan'208";a="575409674"
Received: from lkp-server02.sh.intel.com (HELO 625d3a354f04) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 01 Feb 2021 23:58:37 -0800
Received: from kbuild by 625d3a354f04 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l6qa4-0009Ca-KO; Tue, 02 Feb 2021 07:58:36 +0000
Date:   Tue, 02 Feb 2021 15:57:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org
Subject: [mac80211:master] BUILD SUCCESS
 50af06d43eab6b09afc37aa7c8bbf69b14a3b2f7
Message-ID: <601905f5.6aJP/HDH+g/RuemH%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211.git master
branch HEAD: 50af06d43eab6b09afc37aa7c8bbf69b14a3b2f7  staging: rtl8723bs: Move wiphy setup to after reading the regulatory settings from the chip

elapsed time: 727m

configs tested: 100
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc64                           defconfig
x86_64                           alldefconfig
arm                             ezx_defconfig
powerpc                 canyonlands_defconfig
mips                      maltasmvp_defconfig
powerpc                      tqm8xx_defconfig
powerpc                     tqm8541_defconfig
powerpc                    amigaone_defconfig
powerpc                        cell_defconfig
sh                        sh7785lcr_defconfig
s390                          debug_defconfig
m68k                       m5208evb_defconfig
powerpc                 mpc837x_mds_defconfig
ia64                             alldefconfig
powerpc                      pasemi_defconfig
mips                malta_qemu_32r6_defconfig
powerpc                 mpc85xx_cds_defconfig
mips                   sb1250_swarm_defconfig
s390                       zfcpdump_defconfig
arm                          gemini_defconfig
alpha                            alldefconfig
mips                        omega2p_defconfig
mips                      bmips_stb_defconfig
xtensa                  audio_kc705_defconfig
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
x86_64               randconfig-a006-20210201
x86_64               randconfig-a001-20210201
x86_64               randconfig-a005-20210201
x86_64               randconfig-a002-20210201
x86_64               randconfig-a004-20210201
x86_64               randconfig-a003-20210201
i386                 randconfig-a001-20210201
i386                 randconfig-a005-20210201
i386                 randconfig-a003-20210201
i386                 randconfig-a006-20210201
i386                 randconfig-a002-20210201
i386                 randconfig-a004-20210201
i386                 randconfig-a013-20210201
i386                 randconfig-a016-20210201
i386                 randconfig-a014-20210201
i386                 randconfig-a012-20210201
i386                 randconfig-a015-20210201
i386                 randconfig-a011-20210201
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
x86_64               randconfig-a013-20210201
x86_64               randconfig-a014-20210201
x86_64               randconfig-a015-20210201
x86_64               randconfig-a016-20210201
x86_64               randconfig-a011-20210201
x86_64               randconfig-a012-20210201

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
