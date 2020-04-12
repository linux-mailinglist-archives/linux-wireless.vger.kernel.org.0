Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 783611A5D12
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Apr 2020 08:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgDLGp6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 12 Apr 2020 02:45:58 -0400
Received: from mga09.intel.com ([134.134.136.24]:4248 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbgDLGp5 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 12 Apr 2020 02:45:57 -0400
IronPort-SDR: bSDhOFMjhSRDLru145jjCyFnWppvYIIX/CMP9hSE/YHiZHWPESPCoTmeUX1NELFYpx5Z3giJpv
 zB5a09j7tQQQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2020 23:45:58 -0700
IronPort-SDR: xOGfVTnlFZQRggMsKhzBRwsMBIiXv9K872RqOdvkHONpCgYJPcFr8PWAEv6y5J7Qh/ztqFWy/+
 B0LoCYyYdVfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,373,1580803200"; 
   d="scan'208";a="276605981"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 11 Apr 2020 23:45:56 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jNWNP-000Hl4-Fg; Sun, 12 Apr 2020 14:45:55 +0800
Date:   Sun, 12 Apr 2020 14:44:58 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org
Subject: [mac80211-next:netlink-validation] BUILD REGRESSION
 f58d4244f1913e1cb0fba75af0166327801d577c
Message-ID: <5e92b8ea.kYcU1wzVM33rQ9eI%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211-next.git  netlink-validation
branch HEAD: f58d4244f1913e1cb0fba75af0166327801d577c  nl80211: link recursive netlink nested policy

Error/Warning in current branch:

net/sched/act_api.c:888:43: error: initializer element is not constant
net/sched/sch_red.c:215:42: error: initializer element is not constant
net/sched/sch_red.c:218:42: error: initializer element is not constant

Error/Warning ids grouped by kconfigs:

recent_errors
|-- i386-allmodconfig
|   `-- net-sched-sch_red.c:error:initializer-element-is-not-constant
|-- i386-allyesconfig
|   `-- net-sched-sch_red.c:error:initializer-element-is-not-constant
|-- i386-debian-10.3
|   `-- net-sched-sch_red.c:error:initializer-element-is-not-constant
|-- i386-randconfig-c002-20200412
|   `-- net-sched-sch_red.c:error:initializer-element-is-not-constant
|-- i386-randconfig-g001-20200412
|   `-- net-sched-sch_red.c:error:initializer-element-is-not-constant
|-- x86_64-allmodconfig
|   `-- net-sched-sch_red.c:error:initializer-element-is-not-constant
|-- x86_64-allyesconfig
|   `-- net-sched-sch_red.c:error:initializer-element-is-not-constant
|-- x86_64-fedora-25
|   |-- net-sched-act_api.c:error:initializer-element-is-not-constant
|   `-- net-sched-sch_red.c:error:initializer-element-is-not-constant
|-- x86_64-randconfig-c003-20200412
|   |-- net-sched-act_api.c:error:initializer-element-is-not-constant
|   `-- net-sched-sch_red.c:error:initializer-element-is-not-constant
|-- x86_64-randconfig-f003-20200412
|   `-- net-sched-sch_red.c:error:initializer-element-is-not-constant
|-- x86_64-rhel
|   |-- net-sched-act_api.c:error:initializer-element-is-not-constant
|   `-- net-sched-sch_red.c:error:initializer-element-is-not-constant
|-- x86_64-rhel-7.2-clear
|   |-- net-sched-act_api.c:error:initializer-element-is-not-constant
|   `-- net-sched-sch_red.c:error:initializer-element-is-not-constant
|-- x86_64-rhel-7.6
|   |-- net-sched-act_api.c:error:initializer-element-is-not-constant
|   `-- net-sched-sch_red.c:error:initializer-element-is-not-constant
`-- x86_64-rhel-7.6-kselftests
    |-- net-sched-act_api.c:error:initializer-element-is-not-constant
    `-- net-sched-sch_red.c:error:initializer-element-is-not-constant

elapsed time: 480m

configs tested: 149
configs skipped: 0

arm64                            allyesconfig
arm                              allyesconfig
arm64                            allmodconfig
arm                              allmodconfig
arm64                             allnoconfig
arm                               allnoconfig
arm                           efm32_defconfig
arm                         at91_dt_defconfig
arm                        shmobile_defconfig
arm64                               defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                           sunxi_defconfig
arm                        multi_v7_defconfig
sparc                            allyesconfig
i386                              allnoconfig
i386                             allyesconfig
i386                             alldefconfig
i386                                defconfig
i386                              debian-10.3
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
ia64                                defconfig
nios2                         3c120_defconfig
nios2                         10m50_defconfig
c6x                        evmc6678_defconfig
xtensa                          iss_defconfig
c6x                              allyesconfig
xtensa                       common_defconfig
openrisc                 simple_smp_defconfig
openrisc                    or1ksim_defconfig
nds32                               defconfig
nds32                             allnoconfig
csky                                defconfig
alpha                               defconfig
h8300                       h8s-sim_defconfig
h8300                     edosk2674_defconfig
m68k                       m5475evb_defconfig
m68k                             allmodconfig
h8300                    h8300h-sim_defconfig
m68k                           sun3_defconfig
m68k                          multi_defconfig
arc                                 defconfig
arc                              allyesconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
mips                             allyesconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                           32r2_defconfig
mips                             allmodconfig
parisc                            allnoconfig
parisc                generic-64bit_defconfig
parisc                generic-32bit_defconfig
parisc                           allyesconfig
x86_64               randconfig-a001-20200412
x86_64               randconfig-a002-20200412
x86_64               randconfig-a003-20200412
i386                 randconfig-a001-20200412
i386                 randconfig-a002-20200412
i386                 randconfig-a003-20200412
mips                 randconfig-a001-20200412
nds32                randconfig-a001-20200412
riscv                randconfig-a001-20200412
m68k                 randconfig-a001-20200412
parisc               randconfig-a001-20200412
alpha                randconfig-a001-20200412
s390                 randconfig-a001-20200412
xtensa               randconfig-a001-20200412
sh                   randconfig-a001-20200412
openrisc             randconfig-a001-20200412
csky                 randconfig-a001-20200412
x86_64               randconfig-b002-20200412
i386                 randconfig-b001-20200412
x86_64               randconfig-b001-20200412
x86_64               randconfig-b003-20200412
i386                 randconfig-b003-20200412
i386                 randconfig-b002-20200412
x86_64               randconfig-e001-20200412
x86_64               randconfig-e002-20200412
x86_64               randconfig-e003-20200412
i386                 randconfig-e001-20200412
i386                 randconfig-e002-20200412
i386                 randconfig-e003-20200412
i386                 randconfig-f003-20200412
i386                 randconfig-f002-20200412
x86_64               randconfig-f003-20200412
x86_64               randconfig-f001-20200412
x86_64               randconfig-f002-20200412
i386                 randconfig-f001-20200412
x86_64               randconfig-g003-20200412
i386                 randconfig-g003-20200412
x86_64               randconfig-g002-20200412
x86_64               randconfig-g001-20200412
i386                 randconfig-g002-20200412
i386                 randconfig-g001-20200412
x86_64               randconfig-h001-20200412
i386                 randconfig-h003-20200412
i386                 randconfig-h002-20200412
i386                 randconfig-h001-20200412
x86_64               randconfig-h003-20200412
x86_64               randconfig-h002-20200412
sparc                randconfig-a001-20200412
arc                  randconfig-a001-20200412
arm                  randconfig-a001-20200412
arm64                randconfig-a001-20200412
ia64                 randconfig-a001-20200412
powerpc              randconfig-a001-20200412
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
s390                             alldefconfig
s390                             allmodconfig
s390                              allnoconfig
s390                             allyesconfig
s390                          debug_defconfig
s390                                defconfig
s390                       zfcpdump_defconfig
sh                          rsk7269_defconfig
sh                               allmodconfig
sh                            titan_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
sparc                               defconfig
sparc64                           allnoconfig
sparc64                          allmodconfig
sparc64                             defconfig
sparc64                          allyesconfig
um                           x86_64_defconfig
um                             i386_defconfig
um                                  defconfig
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                    lkp
x86_64                                   rhel
x86_64                         rhel-7.2-clear
x86_64                               rhel-7.6
x86_64                    rhel-7.6-kselftests

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
