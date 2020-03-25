Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C11C419305F
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2020 19:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbgCYS34 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Mar 2020 14:29:56 -0400
Received: from mga01.intel.com ([192.55.52.88]:31287 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727027AbgCYS34 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Mar 2020 14:29:56 -0400
IronPort-SDR: Cno/tF2BM9Z1zPiDeAdzLiTmPjrU793nxDcnMEfIJ7CNT1n5EZW5n1E+M45OF2dyoGubWPR0R4
 OP1vCVIHqR7g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2020 11:29:55 -0700
IronPort-SDR: 8nHXFds0uyr+byOCeYniGdPyf6K6ib3KOGA/0fA4ifJlequuJg5jAKV0DAKuK4UJk2IE/ejH11
 Po/OD5pdMDCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,305,1580803200"; 
   d="scan'208";a="293415876"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 25 Mar 2020 11:29:54 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jHAmo-000HXW-0d; Thu, 26 Mar 2020 02:29:54 +0800
Date:   Thu, 26 Mar 2020 02:28:59 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org
Subject: [mac80211:master] BUILD SUCCESS
 575a97acc3b7446094b0dcaf6285c7c6934c2477
Message-ID: <5e7ba2eb.ww3RtOlVHIlCinae%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211.git  master
branch HEAD: 575a97acc3b7446094b0dcaf6285c7c6934c2477  ieee80211: fix HE SPR size calculation

elapsed time: 568m

configs tested: 150
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

arm64                            allyesconfig
arm                              allyesconfig
arm64                            allmodconfig
arm                              allmodconfig
arm64                             allnoconfig
arm                               allnoconfig
arm                         at91_dt_defconfig
arm                           efm32_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
arm                        shmobile_defconfig
arm                           sunxi_defconfig
arm64                               defconfig
sparc                            allyesconfig
mips                             allmodconfig
xtensa                       common_defconfig
sh                                allnoconfig
h8300                       h8s-sim_defconfig
m68k                           sun3_defconfig
s390                             allyesconfig
nds32                               defconfig
powerpc                             defconfig
sh                            titan_defconfig
csky                                defconfig
nds32                             allnoconfig
i386                              allnoconfig
i386                             allyesconfig
i386                             alldefconfig
i386                                defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                              allnoconfig
ia64                             allyesconfig
ia64                             alldefconfig
c6x                              allyesconfig
c6x                        evmc6678_defconfig
nios2                         10m50_defconfig
nios2                         3c120_defconfig
openrisc                    or1ksim_defconfig
openrisc                 simple_smp_defconfig
xtensa                          iss_defconfig
h8300                     edosk2674_defconfig
h8300                    h8300h-sim_defconfig
m68k                             allmodconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
powerpc                          rhel-kconfig
arc                              allyesconfig
arc                                 defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
powerpc                       ppc64_defconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
mips                             allyesconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                           32r2_defconfig
parisc                            allnoconfig
parisc                           allyesconfig
parisc                generic-32bit_defconfig
parisc                generic-64bit_defconfig
i386                 randconfig-a002-20200325
x86_64               randconfig-a002-20200325
i386                 randconfig-a001-20200325
x86_64               randconfig-a001-20200325
i386                 randconfig-a003-20200325
x86_64               randconfig-a003-20200325
mips                 randconfig-a001-20200325
nds32                randconfig-a001-20200325
m68k                 randconfig-a001-20200325
parisc               randconfig-a001-20200325
alpha                randconfig-a001-20200325
riscv                randconfig-a001-20200325
h8300                randconfig-a001-20200325
microblaze           randconfig-a001-20200325
nios2                randconfig-a001-20200325
c6x                  randconfig-a001-20200325
sparc64              randconfig-a001-20200325
csky                 randconfig-a001-20200325
openrisc             randconfig-a001-20200325
s390                 randconfig-a001-20200325
sh                   randconfig-a001-20200325
xtensa               randconfig-a001-20200325
x86_64               randconfig-b001-20200325
x86_64               randconfig-b002-20200325
x86_64               randconfig-b003-20200325
i386                 randconfig-b001-20200325
i386                 randconfig-b002-20200325
i386                 randconfig-b003-20200325
x86_64               randconfig-c003-20200325
i386                 randconfig-c002-20200325
x86_64               randconfig-c001-20200325
x86_64               randconfig-c002-20200325
i386                 randconfig-c003-20200325
i386                 randconfig-c001-20200325
x86_64               randconfig-e001-20200325
x86_64               randconfig-e003-20200325
i386                 randconfig-e002-20200325
i386                 randconfig-e003-20200325
x86_64               randconfig-e002-20200325
i386                 randconfig-e001-20200325
i386                 randconfig-f001-20200325
i386                 randconfig-f003-20200325
i386                 randconfig-f002-20200325
x86_64               randconfig-f002-20200325
x86_64               randconfig-f003-20200325
x86_64               randconfig-f001-20200325
x86_64               randconfig-h002-20200325
x86_64               randconfig-h003-20200325
i386                 randconfig-h003-20200325
i386                 randconfig-h001-20200325
x86_64               randconfig-h001-20200325
i386                 randconfig-h002-20200325
arm                  randconfig-a001-20200325
powerpc              randconfig-a001-20200325
arm64                randconfig-a001-20200325
ia64                 randconfig-a001-20200325
sparc                randconfig-a001-20200325
arc                  randconfig-a001-20200325
riscv                             allnoconfig
riscv                            allyesconfig
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
s390                       zfcpdump_defconfig
s390                          debug_defconfig
s390                              allnoconfig
s390                             allmodconfig
s390                             alldefconfig
s390                                defconfig
sh                          rsk7269_defconfig
sh                               allmodconfig
sh                  sh7785lcr_32bit_defconfig
sparc                               defconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
um                                  defconfig
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
