Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3484F156C68
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Feb 2020 21:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbgBIUdV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 9 Feb 2020 15:33:21 -0500
Received: from mga03.intel.com ([134.134.136.65]:47919 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727416AbgBIUdV (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 9 Feb 2020 15:33:21 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Feb 2020 12:33:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,422,1574150400"; 
   d="scan'208";a="433133361"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 09 Feb 2020 12:33:19 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1j0tGZ-000EuM-6l; Mon, 10 Feb 2020 04:33:19 +0800
Date:   Mon, 10 Feb 2020 04:33:13 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org
Subject: [mac80211:master] BUILD SUCCESS
 bfb7bac3a8f47100ebe7961bd14e924c96e21ca7
Message-ID: <5e406c89.wDdP9lRpf/Yk2Fci%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211.git  master
branch HEAD: bfb7bac3a8f47100ebe7961bd14e924c96e21ca7  cfg80211: check wiphy driver existence for drvinfo report

elapsed time: 3257m

configs tested: 152
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                              allmodconfig
arm                         at91_dt_defconfig
arm64                               defconfig
arm                        multi_v5_defconfig
arm                              allyesconfig
arm64                            allyesconfig
arm                               allnoconfig
arm                           efm32_defconfig
arm                           sunxi_defconfig
arm64                             allnoconfig
arm64                            allmodconfig
arm                          exynos_defconfig
arm                        shmobile_defconfig
arm                        multi_v7_defconfig
sparc                            allyesconfig
ia64                                defconfig
mips                              allnoconfig
mips                      malta_kvm_defconfig
riscv                             allnoconfig
csky                                defconfig
um                                  defconfig
i386                              allnoconfig
riscv                          rv32_defconfig
xtensa                       common_defconfig
m68k                             allmodconfig
parisc                           allyesconfig
mips                             allyesconfig
powerpc                             defconfig
mips                      fuloong2e_defconfig
sparc64                          allmodconfig
riscv                               defconfig
s390                                defconfig
parisc                              defconfig
riscv                    nommu_virt_defconfig
s390                       zfcpdump_defconfig
arc                              allyesconfig
xtensa                          iss_defconfig
i386                                defconfig
c6x                        evmc6678_defconfig
sh                               allmodconfig
sparc64                          allyesconfig
powerpc                       ppc64_defconfig
mips                             allmodconfig
powerpc                           allnoconfig
sh                            titan_defconfig
nds32                               defconfig
riscv                            allmodconfig
openrisc                    or1ksim_defconfig
parisc                            allnoconfig
c6x                              allyesconfig
i386                             alldefconfig
i386                             allyesconfig
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
nios2                         10m50_defconfig
nios2                         3c120_defconfig
openrisc                 simple_smp_defconfig
alpha                               defconfig
nds32                             allnoconfig
h8300                     edosk2674_defconfig
h8300                    h8300h-sim_defconfig
h8300                       h8s-sim_defconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
arc                                 defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                          rhel-kconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
c6x                  randconfig-a001-20200209
h8300                randconfig-a001-20200209
microblaze           randconfig-a001-20200209
nios2                randconfig-a001-20200209
sparc64              randconfig-a001-20200209
h8300                randconfig-a001-20200207
nios2                randconfig-a001-20200207
sparc64              randconfig-a001-20200207
microblaze           randconfig-a001-20200207
c6x                  randconfig-a001-20200207
sh                   randconfig-a001-20200207
csky                 randconfig-a001-20200207
s390                 randconfig-a001-20200207
xtensa               randconfig-a001-20200207
openrisc             randconfig-a001-20200207
x86_64               randconfig-b001-20200210
x86_64               randconfig-b002-20200210
x86_64               randconfig-b003-20200210
i386                 randconfig-b001-20200210
i386                 randconfig-b002-20200210
i386                 randconfig-b003-20200210
x86_64               randconfig-c001-20200209
x86_64               randconfig-c002-20200209
x86_64               randconfig-c003-20200209
i386                 randconfig-c001-20200209
i386                 randconfig-c002-20200209
i386                 randconfig-c003-20200209
x86_64               randconfig-c001-20200208
x86_64               randconfig-c002-20200208
x86_64               randconfig-c003-20200208
i386                 randconfig-c001-20200208
i386                 randconfig-c002-20200208
i386                 randconfig-c003-20200208
x86_64               randconfig-d001-20200207
x86_64               randconfig-d002-20200207
x86_64               randconfig-d003-20200207
i386                 randconfig-d001-20200207
i386                 randconfig-d002-20200207
i386                 randconfig-d003-20200207
i386                 randconfig-e003-20200207
i386                 randconfig-e002-20200207
x86_64               randconfig-e001-20200207
x86_64               randconfig-e003-20200207
i386                 randconfig-e001-20200207
x86_64               randconfig-e002-20200207
x86_64               randconfig-f001-20200210
x86_64               randconfig-f002-20200210
x86_64               randconfig-f003-20200210
i386                 randconfig-f001-20200210
i386                 randconfig-f002-20200210
i386                 randconfig-f003-20200210
x86_64               randconfig-g001-20200210
x86_64               randconfig-g002-20200210
x86_64               randconfig-g003-20200210
i386                 randconfig-g001-20200210
i386                 randconfig-g002-20200210
i386                 randconfig-g003-20200210
riscv                            allyesconfig
s390                             alldefconfig
s390                             allmodconfig
s390                              allnoconfig
s390                             allyesconfig
s390                          debug_defconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                    lkp
x86_64                                   rhel
x86_64                         rhel-7.2-clear
x86_64                               rhel-7.6

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
