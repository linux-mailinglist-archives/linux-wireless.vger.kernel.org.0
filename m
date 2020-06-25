Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5A6520A96D
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2020 01:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgFYXqn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Jun 2020 19:46:43 -0400
Received: from mga09.intel.com ([134.134.136.24]:61987 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726380AbgFYXqn (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Jun 2020 19:46:43 -0400
IronPort-SDR: 4RZ7dT7qgm/13gEBzaQRYn14MAkO7Mb6/p2+sVqzW0AHnvltU1Jka0S+TUY/cgddF4hX2KTNfo
 R09DrfUyrobA==
X-IronPort-AV: E=McAfee;i="6000,8403,9663"; a="146625025"
X-IronPort-AV: E=Sophos;i="5.75,280,1589266800"; 
   d="scan'208";a="146625025"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2020 16:46:42 -0700
IronPort-SDR: 74q/6wy9rjD/0mgXIwOuX4xO4ng8wIRxrVK0cYRB29yOOakkxFMn2jtrqo4A2tgMmV9jq5qqje
 70CHIc7BgRTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,280,1589266800"; 
   d="scan'208";a="319875920"
Received: from lkp-server01.sh.intel.com (HELO 538b5e3c8319) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 25 Jun 2020 16:46:41 -0700
Received: from kbuild by 538b5e3c8319 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jobZo-0001s0-IL; Thu, 25 Jun 2020 23:46:40 +0000
Date:   Fri, 26 Jun 2020 07:46:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org
Subject: [mac80211:master] BUILD SUCCESS
 5af7fef39d7952c0f5551afa7b821ee7b6c9dd3d
Message-ID: <5ef5375b.Cy5wsl5+Zah8KWVd%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211.git  master
branch HEAD: 5af7fef39d7952c0f5551afa7b821ee7b6c9dd3d  mac80211: skip mpath lookup also for control port tx

elapsed time: 723m

configs tested: 110
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

arm64                            allyesconfig
arm64                               defconfig
arm64                            allmodconfig
arm64                             allnoconfig
arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                               allnoconfig
arc                     haps_hs_smp_defconfig
s390                             allyesconfig
powerpc                          g5_defconfig
mips                        jmr3927_defconfig
i386                             alldefconfig
nds32                             allnoconfig
sh                           se7724_defconfig
mips                     loongson1b_defconfig
powerpc                  mpc885_ads_defconfig
sh                        sh7763rdp_defconfig
c6x                        evmc6472_defconfig
ia64                             allyesconfig
riscv                          rv32_defconfig
parisc                            allnoconfig
arm                            lart_defconfig
mips                      loongson3_defconfig
i386                              allnoconfig
i386                             allyesconfig
i386                                defconfig
i386                              debian-10.3
ia64                             allmodconfig
ia64                                defconfig
ia64                              allnoconfig
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
openrisc                         allyesconfig
nds32                               defconfig
csky                             allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
h8300                            allmodconfig
xtensa                              defconfig
arc                                 defconfig
arc                              allyesconfig
sh                               allmodconfig
sh                                allnoconfig
microblaze                        allnoconfig
mips                             allyesconfig
mips                              allnoconfig
mips                             allmodconfig
parisc                              defconfig
parisc                           allyesconfig
parisc                           allmodconfig
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          rhel-kconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a002-20200624
i386                 randconfig-a006-20200624
i386                 randconfig-a003-20200624
i386                 randconfig-a001-20200624
i386                 randconfig-a005-20200624
i386                 randconfig-a004-20200624
i386                 randconfig-a013-20200624
i386                 randconfig-a016-20200624
i386                 randconfig-a012-20200624
i386                 randconfig-a014-20200624
i386                 randconfig-a011-20200624
i386                 randconfig-a015-20200624
x86_64               randconfig-a004-20200624
x86_64               randconfig-a002-20200624
x86_64               randconfig-a003-20200624
x86_64               randconfig-a005-20200624
x86_64               randconfig-a001-20200624
x86_64               randconfig-a006-20200624
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
s390                              allnoconfig
s390                             allmodconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
um                                allnoconfig
um                                  defconfig
um                               allmodconfig
um                               allyesconfig
x86_64                               rhel-7.6
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                                   rhel
x86_64                         rhel-7.2-clear
x86_64                                    lkp
x86_64                              fedora-25

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
