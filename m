Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B83AC3085A8
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Jan 2021 07:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbhA2GXH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 Jan 2021 01:23:07 -0500
Received: from mga12.intel.com ([192.55.52.136]:2110 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232059AbhA2GXE (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 Jan 2021 01:23:04 -0500
IronPort-SDR: 9bMMpj5eNw0E9OKIgkpC7s6RQsBpv/VuhGtdiJOitgTCXu8v2hemJHZM35wNw1m1t0Bymp3/jo
 TpLvW48d/H6g==
X-IronPort-AV: E=McAfee;i="6000,8403,9878"; a="159545824"
X-IronPort-AV: E=Sophos;i="5.79,384,1602572400"; 
   d="scan'208";a="159545824"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2021 22:22:30 -0800
IronPort-SDR: kL56GqKNZJsk0kqGugYu1Sn57pKDN70aFy4UB9Os18BfySVPdSnOONksajA3Gv4UsY3ODk+3F5
 PomiVTwvfIlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,384,1602572400"; 
   d="scan'208";a="474420758"
Received: from lkp-server02.sh.intel.com (HELO 625d3a354f04) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 28 Jan 2021 22:22:29 -0800
Received: from kbuild by 625d3a354f04 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l5NAq-0003aD-DE; Fri, 29 Jan 2021 06:22:28 +0000
Date:   Fri, 29 Jan 2021 14:22:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org
Subject: [mac80211-next:master] BUILD SUCCESS
 776a39b8196dbca4afb69669db0d9926ffac29ab
Message-ID: <6013a99c.ONRWpgK5XLBDmNFG%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211-next.git master
branch HEAD: 776a39b8196dbca4afb69669db0d9926ffac29ab  cfg80211: call cfg80211_destroy_ifaces() with wiphy lock held

elapsed time: 727m

configs tested: 108
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                         ps3_defconfig
arm                          pxa3xx_defconfig
riscv                    nommu_virt_defconfig
m68k                           sun3_defconfig
arm                     eseries_pxa_defconfig
arm                            pleb_defconfig
powerpc                     rainier_defconfig
arm                          badge4_defconfig
arm                        spear3xx_defconfig
mips                           ip28_defconfig
powerpc                    ge_imp3a_defconfig
mips                     cu1830-neo_defconfig
nios2                         3c120_defconfig
sh                          polaris_defconfig
mips                  decstation_64_defconfig
sh                          kfr2r09_defconfig
mips                       bmips_be_defconfig
powerpc                 mpc837x_mds_defconfig
mips                      maltasmvp_defconfig
arm                          simpad_defconfig
powerpc                 mpc8272_ads_defconfig
arm                        shmobile_defconfig
arm                           u8500_defconfig
powerpc                 linkstation_defconfig
parisc                generic-64bit_defconfig
arm                            mmp2_defconfig
powerpc                      acadia_defconfig
arm                            u300_defconfig
mips                      maltaaprp_defconfig
m68k                        m5307c3_defconfig
sh                           se7751_defconfig
arm                           h3600_defconfig
arc                        nsimosci_defconfig
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
i386                 randconfig-a001-20210128
i386                 randconfig-a002-20210128
i386                 randconfig-a004-20210128
i386                 randconfig-a005-20210128
i386                 randconfig-a003-20210128
i386                 randconfig-a006-20210128
x86_64               randconfig-a012-20210128
x86_64               randconfig-a015-20210128
x86_64               randconfig-a016-20210128
x86_64               randconfig-a011-20210128
x86_64               randconfig-a013-20210128
x86_64               randconfig-a014-20210128
i386                 randconfig-a013-20210128
i386                 randconfig-a011-20210128
i386                 randconfig-a012-20210128
i386                 randconfig-a016-20210128
i386                 randconfig-a014-20210128
i386                 randconfig-a015-20210128
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
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
x86_64               randconfig-a002-20210128
x86_64               randconfig-a003-20210128
x86_64               randconfig-a001-20210128
x86_64               randconfig-a005-20210128
x86_64               randconfig-a006-20210128
x86_64               randconfig-a004-20210128

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
