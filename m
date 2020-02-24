Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9909D16AFB1
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Feb 2020 19:51:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbgBXSvB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Feb 2020 13:51:01 -0500
Received: from mga17.intel.com ([192.55.52.151]:8097 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726652AbgBXSvB (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Feb 2020 13:51:01 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Feb 2020 10:51:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,481,1574150400"; 
   d="scan'208";a="229921621"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 24 Feb 2020 10:50:58 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1j6Iok-000Ii7-Vg; Tue, 25 Feb 2020 02:50:58 +0800
Date:   Tue, 25 Feb 2020 02:50:42 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org
Subject: [mac80211:master] BUILD SUCCESS
 253216ffb2a002a682c6f68bd3adff5b98b71de8
Message-ID: <5e541b02.lAKqojQCZVnN1wP9%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211.git  master
branch HEAD: 253216ffb2a002a682c6f68bd3adff5b98b71de8  mac80211: rx: avoid RCU list traversal under mutex

elapsed time: 481m

configs tested: 170
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                              allmodconfig
arm                               allnoconfig
arm                              allyesconfig
arm64                            allmodconfig
arm64                             allnoconfig
arm64                            allyesconfig
arm                         at91_dt_defconfig
arm                           efm32_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
arm                        shmobile_defconfig
arm                           sunxi_defconfig
arm64                               defconfig
sparc                            allyesconfig
ia64                                defconfig
parisc                generic-32bit_defconfig
arc                                 defconfig
s390                          debug_defconfig
h8300                    h8300h-sim_defconfig
parisc                generic-64bit_defconfig
s390                             allmodconfig
i386                              allnoconfig
i386                             alldefconfig
i386                             allyesconfig
i386                                defconfig
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
c6x                              allyesconfig
c6x                        evmc6678_defconfig
nios2                         10m50_defconfig
nios2                         3c120_defconfig
openrisc                    or1ksim_defconfig
openrisc                 simple_smp_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
alpha                               defconfig
csky                                defconfig
nds32                             allnoconfig
nds32                               defconfig
h8300                     edosk2674_defconfig
h8300                       h8s-sim_defconfig
m68k                             allmodconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
arc                              allyesconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                              allnoconfig
mips                             allyesconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
parisc                            allnoconfig
parisc                           allyesconfig
x86_64               randconfig-a001-20200224
x86_64               randconfig-a002-20200224
x86_64               randconfig-a003-20200224
i386                 randconfig-a001-20200224
i386                 randconfig-a002-20200224
i386                 randconfig-a003-20200224
alpha                randconfig-a001-20200224
m68k                 randconfig-a001-20200224
mips                 randconfig-a001-20200224
nds32                randconfig-a001-20200224
parisc               randconfig-a001-20200224
riscv                randconfig-a001-20200224
c6x                  randconfig-a001-20200224
h8300                randconfig-a001-20200224
microblaze           randconfig-a001-20200224
nios2                randconfig-a001-20200224
sparc64              randconfig-a001-20200224
openrisc             randconfig-a001-20200224
sh                   randconfig-a001-20200224
s390                 randconfig-a001-20200224
xtensa               randconfig-a001-20200224
csky                 randconfig-a001-20200224
x86_64               randconfig-b001-20200224
x86_64               randconfig-b002-20200224
x86_64               randconfig-b003-20200224
i386                 randconfig-b001-20200224
i386                 randconfig-b002-20200224
i386                 randconfig-b003-20200224
x86_64               randconfig-c001-20200224
x86_64               randconfig-c002-20200224
x86_64               randconfig-c003-20200224
i386                 randconfig-c001-20200224
i386                 randconfig-c002-20200224
i386                 randconfig-c003-20200224
x86_64               randconfig-d001-20200224
x86_64               randconfig-d002-20200224
x86_64               randconfig-d003-20200224
i386                 randconfig-d001-20200224
i386                 randconfig-d002-20200224
i386                 randconfig-d003-20200224
x86_64               randconfig-e001-20200224
x86_64               randconfig-e002-20200224
x86_64               randconfig-e003-20200224
i386                 randconfig-e001-20200224
i386                 randconfig-e002-20200224
i386                 randconfig-e003-20200224
x86_64               randconfig-f003-20200224
x86_64               randconfig-f002-20200224
x86_64               randconfig-f001-20200224
i386                 randconfig-f001-20200224
i386                 randconfig-f003-20200224
i386                 randconfig-f002-20200224
x86_64               randconfig-g001-20200223
x86_64               randconfig-g002-20200223
x86_64               randconfig-g003-20200223
i386                 randconfig-g001-20200223
i386                 randconfig-g002-20200223
i386                 randconfig-g003-20200223
x86_64               randconfig-g001-20200224
x86_64               randconfig-g002-20200224
x86_64               randconfig-g003-20200224
i386                 randconfig-g001-20200224
i386                 randconfig-g002-20200224
i386                 randconfig-g003-20200224
x86_64               randconfig-h001-20200224
x86_64               randconfig-h002-20200224
x86_64               randconfig-h003-20200224
i386                 randconfig-h001-20200224
i386                 randconfig-h002-20200224
i386                 randconfig-h003-20200224
arc                  randconfig-a001-20200224
arm                  randconfig-a001-20200224
arm64                randconfig-a001-20200224
ia64                 randconfig-a001-20200224
powerpc              randconfig-a001-20200224
sparc                randconfig-a001-20200224
riscv                            allmodconfig
riscv                             allnoconfig
riscv                            allyesconfig
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
s390                             alldefconfig
s390                              allnoconfig
s390                             allyesconfig
s390                                defconfig
s390                       zfcpdump_defconfig
sh                               allmodconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
sparc                               defconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
um                                  defconfig
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                    lkp
x86_64                                   rhel
x86_64                         rhel-7.2-clear
x86_64                               rhel-7.6

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
