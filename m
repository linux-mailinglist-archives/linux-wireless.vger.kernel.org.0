Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18BDB3AD62F
	for <lists+linux-wireless@lfdr.de>; Sat, 19 Jun 2021 01:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235282AbhFRX54 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Jun 2021 19:57:56 -0400
Received: from mga03.intel.com ([134.134.136.65]:27945 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232678AbhFRX5z (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Jun 2021 19:57:55 -0400
IronPort-SDR: ngambsrn0r3wVSthjT5fmeeh9L+TRQCUg/CKqy2qYzzbcHs+QYoJTDVFL3gBoFcQ8oQ4mPIpXE
 uMSG9Sg3MJFw==
X-IronPort-AV: E=McAfee;i="6200,9189,10019"; a="206677024"
X-IronPort-AV: E=Sophos;i="5.83,284,1616482800"; 
   d="scan'208";a="206677024"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2021 16:55:45 -0700
IronPort-SDR: Sj20LMNIGpKoDrPhG+4qO15BBcHLqzsO7t+ExEHm04IMLlklcYtiokWPeQwMtptDoqSK2fYhBR
 QI3sp1mIXB4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,284,1616482800"; 
   d="scan'208";a="555724321"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 18 Jun 2021 16:55:44 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1luOKr-0003DC-Fh; Fri, 18 Jun 2021 23:55:41 +0000
Date:   Sat, 19 Jun 2021 07:55:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org
Subject: [mac80211:master] BUILD SUCCESS
 652e8363bbc7d149fa194a5cbf30b1001c0274b0
Message-ID: <60cd3262.Ljqq2Wcp4RAfhGyK%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211.git master
branch HEAD: 652e8363bbc7d149fa194a5cbf30b1001c0274b0  mac80211: handle various extensible elements correctly

elapsed time: 720m

configs tested: 115
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
nios2                         3c120_defconfig
arm                           sama5_defconfig
arm                       imx_v6_v7_defconfig
mips                     loongson1c_defconfig
m68k                            mac_defconfig
powerpc                     taishan_defconfig
riscv             nommu_k210_sdcard_defconfig
powerpc                   currituck_defconfig
xtensa                  nommu_kc705_defconfig
um                           x86_64_defconfig
powerpc                        fsp2_defconfig
arm                          badge4_defconfig
sh                           se7619_defconfig
powerpc                      pmac32_defconfig
arm                         axm55xx_defconfig
arc                        vdk_hs38_defconfig
m68k                        mvme16x_defconfig
microblaze                          defconfig
m68k                        stmark2_defconfig
powerpc                 mpc836x_rdk_defconfig
arm                          pxa3xx_defconfig
powerpc                      cm5200_defconfig
sparc                            alldefconfig
powerpc                        icon_defconfig
s390                          debug_defconfig
powerpc                     tqm5200_defconfig
arm                       netwinder_defconfig
arc                           tb10x_defconfig
arm                             ezx_defconfig
powerpc                     kmeter1_defconfig
powerpc                       maple_defconfig
powerpc                      ep88xc_defconfig
sh                           sh2007_defconfig
arm                        clps711x_defconfig
sh                             espt_defconfig
arm                     am200epdkit_defconfig
mips                  decstation_64_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
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
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a002-20210618
i386                 randconfig-a006-20210618
i386                 randconfig-a004-20210618
i386                 randconfig-a001-20210618
i386                 randconfig-a005-20210618
i386                 randconfig-a003-20210618
x86_64               randconfig-a015-20210618
x86_64               randconfig-a011-20210618
x86_64               randconfig-a012-20210618
x86_64               randconfig-a014-20210618
x86_64               randconfig-a016-20210618
x86_64               randconfig-a013-20210618
i386                 randconfig-a015-20210618
i386                 randconfig-a016-20210618
i386                 randconfig-a013-20210618
i386                 randconfig-a014-20210618
i386                 randconfig-a012-20210618
i386                 randconfig-a011-20210618
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                            kunit_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210618
x86_64               randconfig-a002-20210618
x86_64               randconfig-a001-20210618
x86_64               randconfig-a004-20210618
x86_64               randconfig-a003-20210618
x86_64               randconfig-a006-20210618
x86_64               randconfig-a005-20210618

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
