Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05F7525528A
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Aug 2020 03:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbgH1B3r (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Aug 2020 21:29:47 -0400
Received: from mga12.intel.com ([192.55.52.136]:39900 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726147AbgH1B3r (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Aug 2020 21:29:47 -0400
IronPort-SDR: FYEMHEz/q1FiHGAy6BZU37sRABcvYBth71wWZOjWMCknmVMCY5PatVQe1/p7TLD/pF097v7NYc
 9caRujGbbWpw==
X-IronPort-AV: E=McAfee;i="6000,8403,9726"; a="136136610"
X-IronPort-AV: E=Sophos;i="5.76,361,1592895600"; 
   d="scan'208";a="136136610"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2020 18:29:46 -0700
IronPort-SDR: mAB4zzDAwCSa5Jdsjz7vU+TBdbarRe2rpqHIqifC/4w53z9NrtyReIRwGmI0+SAGAI0bCDaYrV
 vzwXblT2FNAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,361,1592895600"; 
   d="scan'208";a="332388390"
Received: from lkp-server01.sh.intel.com (HELO 4f455964fc6c) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 27 Aug 2020 18:29:45 -0700
Received: from kbuild by 4f455964fc6c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kBTD7-0002Px-15; Fri, 28 Aug 2020 01:29:45 +0000
Date:   Fri, 28 Aug 2020 09:29:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org
Subject: [mac80211-next:master] BUILD SUCCESS
 2831a631022eed6e3f800f08892132c6edde652c
Message-ID: <5f485de1.S/Kp19zWh/+8i9uD%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211-next.git  master
branch HEAD: 2831a631022eed6e3f800f08892132c6edde652c  nl80211: support SAE authentication offload in AP mode

elapsed time: 727m

configs tested: 115
configs skipped: 13

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                         bigsur_defconfig
sh                   sh7770_generic_defconfig
arm                          iop32x_defconfig
c6x                              alldefconfig
arm                          pxa168_defconfig
powerpc                         ps3_defconfig
arm                             rpc_defconfig
arm                            zeus_defconfig
arm                       aspeed_g4_defconfig
mips                           xway_defconfig
mips                     loongson1c_defconfig
mips                            gpr_defconfig
s390                          debug_defconfig
sh                           se7712_defconfig
arm                           stm32_defconfig
ia64                             allyesconfig
sparc64                          alldefconfig
powerpc                mpc7448_hpc2_defconfig
ia64                             allmodconfig
sh                        sh7763rdp_defconfig
arm                         orion5x_defconfig
mips                         rt305x_defconfig
mips                          malta_defconfig
arm                         lpc32xx_defconfig
arc                            hsdk_defconfig
powerpc                     pseries_defconfig
arc                           tb10x_defconfig
sh                        sh7757lcr_defconfig
mips                      maltaaprp_defconfig
arm                       mainstone_defconfig
m68k                             allmodconfig
c6x                         dsk6455_defconfig
powerpc                     powernv_defconfig
mips                          rb532_defconfig
ia64                         bigsur_defconfig
arm                        multi_v5_defconfig
sh                         ecovec24_defconfig
c6x                        evmc6678_defconfig
sparc                               defconfig
arc                    vdk_hs38_smp_defconfig
sh                        apsh4ad0a_defconfig
powerpc                      pasemi_defconfig
arm                           omap1_defconfig
m68k                        m5272c3_defconfig
m68k                       m5475evb_defconfig
sh                          sdk7780_defconfig
mips                           ip22_defconfig
ia64                                defconfig
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
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
powerpc                             defconfig
x86_64               randconfig-a003-20200827
x86_64               randconfig-a002-20200827
x86_64               randconfig-a001-20200827
x86_64               randconfig-a005-20200827
x86_64               randconfig-a006-20200827
x86_64               randconfig-a004-20200827
i386                 randconfig-a002-20200827
i386                 randconfig-a004-20200827
i386                 randconfig-a003-20200827
i386                 randconfig-a005-20200827
i386                 randconfig-a006-20200827
i386                 randconfig-a001-20200827
i386                 randconfig-a013-20200827
i386                 randconfig-a012-20200827
i386                 randconfig-a011-20200827
i386                 randconfig-a016-20200827
i386                 randconfig-a015-20200827
i386                 randconfig-a014-20200827
i386                 randconfig-a013-20200828
i386                 randconfig-a012-20200828
i386                 randconfig-a011-20200828
i386                 randconfig-a016-20200828
i386                 randconfig-a014-20200828
i386                 randconfig-a015-20200828
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
