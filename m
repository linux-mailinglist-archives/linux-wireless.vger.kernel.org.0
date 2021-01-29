Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A03030823B
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Jan 2021 01:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbhA2ALT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Jan 2021 19:11:19 -0500
Received: from mga04.intel.com ([192.55.52.120]:14250 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229692AbhA2ALS (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Jan 2021 19:11:18 -0500
IronPort-SDR: x6HBYZc7UbSJGkkQ0OMYe5oiupvvlQfgFZIpkpQ2WhUvU5CB+4j/VMSDbC7BuazxKeRf7O3rw8
 3S+8Rzeaj7iw==
X-IronPort-AV: E=McAfee;i="6000,8403,9878"; a="177772949"
X-IronPort-AV: E=Sophos;i="5.79,384,1602572400"; 
   d="scan'208";a="177772949"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2021 16:10:38 -0800
IronPort-SDR: qdo1CdSTvPYYrfyqaMl5oUYe2+kRUrz1I8syDcEygvSWktWiIUhPNxkXjMpRTCKMk3TsvjFHNr
 S2iaU0mSPwFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,384,1602572400"; 
   d="scan'208";a="409348437"
Received: from lkp-server02.sh.intel.com (HELO 625d3a354f04) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 28 Jan 2021 16:10:37 -0800
Received: from kbuild by 625d3a354f04 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l5HMy-0003Dq-TS; Fri, 29 Jan 2021 00:10:36 +0000
Date:   Fri, 29 Jan 2021 08:09:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     linux-wireless@vger.kernel.org
Subject: [mac80211:master] BUILD SUCCESS
 44a674d6f79867d5652026f1cc11f7ba8a390183
Message-ID: <60135247.cqsBoMNxZwfRTDSN%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211.git master
branch HEAD: 44a674d6f79867d5652026f1cc11f7ba8a390183  Merge tag 'mlx5-fixes-2021-01-26' of git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux

elapsed time: 784m

configs tested: 144
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                  colibri_pxa300_defconfig
powerpc                   bluestone_defconfig
nios2                         3c120_defconfig
arc                        vdk_hs38_defconfig
sh                           se7724_defconfig
mips                malta_qemu_32r6_defconfig
powerpc                         ps3_defconfig
nds32                            alldefconfig
c6x                        evmc6457_defconfig
m68k                            q40_defconfig
m68k                       m5208evb_defconfig
sh                            titan_defconfig
arm                         lpc18xx_defconfig
sh                         microdev_defconfig
mips                         mpc30x_defconfig
riscv                               defconfig
arc                     nsimosci_hs_defconfig
c6x                        evmc6474_defconfig
xtensa                           allyesconfig
mips                      pic32mzda_defconfig
powerpc                     pseries_defconfig
arm                          ep93xx_defconfig
openrisc                    or1ksim_defconfig
nios2                            allyesconfig
sh                         apsh4a3a_defconfig
arm                       aspeed_g5_defconfig
arm                        mvebu_v5_defconfig
m68k                       m5275evb_defconfig
powerpc                      ppc44x_defconfig
arm                        clps711x_defconfig
arm                            qcom_defconfig
mips                      malta_kvm_defconfig
arm                        vexpress_defconfig
xtensa                generic_kc705_defconfig
sh                          rsk7269_defconfig
mips                            ar7_defconfig
arm                       multi_v4t_defconfig
xtensa                         virt_defconfig
mips                       capcella_defconfig
parisc                generic-32bit_defconfig
microblaze                      mmu_defconfig
sh                          sdk7780_defconfig
sh                   secureedge5410_defconfig
arc                              alldefconfig
mips                   sb1250_swarm_defconfig
openrisc                            defconfig
ia64                        generic_defconfig
openrisc                 simple_smp_defconfig
powerpc                    sam440ep_defconfig
arm                         hackkit_defconfig
powerpc                 mpc8272_ads_defconfig
arm                         vf610m4_defconfig
arm                        trizeps4_defconfig
sh                        edosk7705_defconfig
mips                  cavium_octeon_defconfig
sparc                            allyesconfig
powerpc                  storcenter_defconfig
x86_64                              defconfig
m68k                                defconfig
powerpc                    ge_imp3a_defconfig
arm                         at91_dt_defconfig
arm                            lart_defconfig
sh                          r7785rp_defconfig
ia64                         bigsur_defconfig
m68k                        m5272c3_defconfig
sh                          r7780mp_defconfig
mips                          ath79_defconfig
mips                       lemote2f_defconfig
mips                 decstation_r4k_defconfig
c6x                        evmc6678_defconfig
m68k                        mvme16x_defconfig
arc                         haps_hs_defconfig
sparc64                          alldefconfig
arm                  colibri_pxa270_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
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
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                                  kexec
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin

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
