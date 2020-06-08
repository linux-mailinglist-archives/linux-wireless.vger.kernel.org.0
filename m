Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 613721F1CF7
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jun 2020 18:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730382AbgFHQKA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 Jun 2020 12:10:00 -0400
Received: from mga17.intel.com ([192.55.52.151]:62033 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730336AbgFHQKA (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 Jun 2020 12:10:00 -0400
IronPort-SDR: DvIfd1Vb6lUNWxehoHcMK+toXz3iZf5JHp2qNDogcE+fxDh0VbVCW+GvEItfqfeHESVU7WshIV
 DdWtfFm8bYHA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2020 09:09:59 -0700
IronPort-SDR: uA/7QapvpQoodocC+cF2NsbYkyFMmvOvHulMyoaoWS5Vkom4uWHjGYEMmmbcBtTBT9713Rv+X+
 Jsyv8uQBF3MA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,487,1583222400"; 
   d="scan'208";a="305985348"
Received: from lkp-server01.sh.intel.com (HELO 7b2aeca65b2f) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 08 Jun 2020 09:09:57 -0700
Received: from kbuild by 7b2aeca65b2f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jiKLV-00001E-8X; Mon, 08 Jun 2020 16:09:57 +0000
Date:   Tue, 09 Jun 2020 00:09:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org
Subject: [mac80211:master] BUILD SUCCESS
 59d4bfc1e2c09435d91c980b03f7b72ce6e9f24e
Message-ID: <5ede62c5.JmyJ2vqzRkjNMI/S%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211.git  master
branch HEAD: 59d4bfc1e2c09435d91c980b03f7b72ce6e9f24e  net: fix wiki website url mac80211 and wireless files

elapsed time: 481m

configs tested: 162
configs skipped: 13

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                               allnoconfig
arm64                            allyesconfig
arm64                               defconfig
arm64                            allmodconfig
arm64                             allnoconfig
m68k                         amcore_defconfig
mips                       rbtx49xx_defconfig
um                                  defconfig
sh                     magicpanelr2_defconfig
powerpc                      ep88xc_defconfig
sh                ecovec24-romimage_defconfig
sparc64                          allmodconfig
arm                           h3600_defconfig
sparc                            allyesconfig
powerpc                    mvme5100_defconfig
openrisc                 simple_smp_defconfig
sh                           se7705_defconfig
mips                     decstation_defconfig
c6x                        evmc6678_defconfig
arc                 nsimosci_hs_smp_defconfig
arm                        mvebu_v5_defconfig
arm                          iop32x_defconfig
arm                            mps2_defconfig
openrisc                         allyesconfig
mips                  cavium_octeon_defconfig
nds32                               defconfig
sparc64                             defconfig
sh                           se7343_defconfig
mips                         tb0226_defconfig
h8300                    h8300h-sim_defconfig
arc                          axs101_defconfig
sh                           se7724_defconfig
arm                       aspeed_g5_defconfig
mips                           xway_defconfig
arm                            dove_defconfig
xtensa                           alldefconfig
arm                         shannon_defconfig
arm                         socfpga_defconfig
sh                   sh7724_generic_defconfig
um                                allnoconfig
arc                                 defconfig
powerpc                    amigaone_defconfig
arc                        nsim_700_defconfig
arm                          exynos_defconfig
arc                            hsdk_defconfig
m68k                          sun3x_defconfig
m68k                        m5272c3_defconfig
m68k                        stmark2_defconfig
arm                            qcom_defconfig
sh                             espt_defconfig
powerpc                          allmodconfig
powerpc                     mpc512x_defconfig
i386                              allnoconfig
arm                     davinci_all_defconfig
mips                  maltasmvp_eva_defconfig
arm                            xcep_defconfig
arm                         mv78xx0_defconfig
c6x                        evmc6457_defconfig
m68k                        mvme16x_defconfig
s390                             allmodconfig
ia64                      gensparse_defconfig
arm                            zeus_defconfig
sh                           se7206_defconfig
sh                          rsk7203_defconfig
sh                          polaris_defconfig
arm                       omap2plus_defconfig
i386                             alldefconfig
parisc                generic-32bit_defconfig
arm                          ep93xx_defconfig
i386                             allyesconfig
i386                                defconfig
i386                              debian-10.3
ia64                             allmodconfig
ia64                                defconfig
ia64                              allnoconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                              allnoconfig
m68k                           sun3_defconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
nios2                            allyesconfig
openrisc                            defconfig
c6x                              allyesconfig
c6x                               allnoconfig
nds32                             allnoconfig
csky                             allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
h8300                            allmodconfig
xtensa                              defconfig
arc                              allyesconfig
sh                               allmodconfig
sh                                allnoconfig
microblaze                        allnoconfig
mips                             allyesconfig
mips                              allnoconfig
mips                             allmodconfig
parisc                            allnoconfig
parisc                              defconfig
parisc                           allyesconfig
parisc                           allmodconfig
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          rhel-kconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20200607
i386                 randconfig-a006-20200607
i386                 randconfig-a002-20200607
i386                 randconfig-a005-20200607
i386                 randconfig-a004-20200607
i386                 randconfig-a003-20200607
x86_64               randconfig-a011-20200608
x86_64               randconfig-a016-20200608
x86_64               randconfig-a012-20200608
x86_64               randconfig-a014-20200608
x86_64               randconfig-a013-20200608
x86_64               randconfig-a015-20200608
i386                 randconfig-a014-20200608
i386                 randconfig-a011-20200608
i386                 randconfig-a015-20200608
i386                 randconfig-a016-20200608
i386                 randconfig-a012-20200608
i386                 randconfig-a013-20200608
i386                 randconfig-a014-20200607
i386                 randconfig-a015-20200607
i386                 randconfig-a011-20200607
i386                 randconfig-a016-20200607
i386                 randconfig-a012-20200607
i386                 randconfig-a013-20200607
x86_64               randconfig-a002-20200607
x86_64               randconfig-a001-20200607
x86_64               randconfig-a006-20200607
x86_64               randconfig-a003-20200607
x86_64               randconfig-a004-20200607
x86_64               randconfig-a005-20200607
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
s390                             allyesconfig
s390                              allnoconfig
s390                                defconfig
sparc                               defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
um                               allmodconfig
um                               allyesconfig
x86_64                                   rhel
x86_64                               rhel-7.6
x86_64                    rhel-7.6-kselftests
x86_64                         rhel-7.2-clear
x86_64                                    lkp
x86_64                              fedora-25
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
