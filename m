Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C40A02FFA4F
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Jan 2021 03:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbhAVCNi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Jan 2021 21:13:38 -0500
Received: from mga06.intel.com ([134.134.136.31]:59016 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726310AbhAVCNh (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Jan 2021 21:13:37 -0500
IronPort-SDR: jMR0H8wGKRvqtOh9Q8yStAHLbh3pakSZqhuaEql9taoLZKrGPnPtMFbH7R+hHqZA06c6buKOG7
 GFlovMv8V0fw==
X-IronPort-AV: E=McAfee;i="6000,8403,9871"; a="240916841"
X-IronPort-AV: E=Sophos;i="5.79,365,1602572400"; 
   d="scan'208";a="240916841"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 18:12:56 -0800
IronPort-SDR: ngvE6tSNwYpfFiXrUsviICdRU2XUt5PXus3/iyPf4ZVsRFG14E+BlIDA2GSp99E//Wm1sc7Ull
 2RH2GB8iBBbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,365,1602572400"; 
   d="scan'208";a="356743813"
Received: from lkp-server01.sh.intel.com (HELO 260eafd5ecd0) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 21 Jan 2021 18:12:54 -0800
Received: from kbuild by 260eafd5ecd0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l2lwT-0006pn-Vq; Fri, 22 Jan 2021 02:12:53 +0000
Date:   Fri, 22 Jan 2021 10:12:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org
Subject: [mac80211:master] BUILD SUCCESS
 dcf3c8fb32ddbfa3b8227db38aa6746405bd4527
Message-ID: <600a349e.rXQcXMNnMgduMJ6M%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211.git master
branch HEAD: dcf3c8fb32ddbfa3b8227db38aa6746405bd4527  mac80211: 160MHz with extended NSS BW in CSA

elapsed time: 726m

configs tested: 101
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
openrisc                         alldefconfig
arm                            lart_defconfig
arm                            pleb_defconfig
arm                         assabet_defconfig
sh                           se7619_defconfig
arm                        trizeps4_defconfig
powerpc                   motionpro_defconfig
c6x                        evmc6457_defconfig
mips                         tb0226_defconfig
mips                           ip22_defconfig
powerpc                        icon_defconfig
mips                        nlm_xlp_defconfig
arc                          axs101_defconfig
arc                        vdk_hs38_defconfig
x86_64                           alldefconfig
mips                          ath79_defconfig
sh                          lboxre2_defconfig
arm                         cm_x300_defconfig
mips                           ip27_defconfig
m68k                         amcore_defconfig
powerpc                     sequoia_defconfig
mips                          ath25_defconfig
arm                         orion5x_defconfig
mips                         tb0287_defconfig
mips                      pic32mzda_defconfig
sparc                            alldefconfig
sh                        apsh4ad0a_defconfig
powerpc                      makalu_defconfig
arm                           omap1_defconfig
arm                       spear13xx_defconfig
mips                      maltaaprp_defconfig
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
x86_64               randconfig-a002-20210121
x86_64               randconfig-a003-20210121
x86_64               randconfig-a001-20210121
x86_64               randconfig-a005-20210121
x86_64               randconfig-a006-20210121
x86_64               randconfig-a004-20210121
i386                 randconfig-a001-20210121
i386                 randconfig-a002-20210121
i386                 randconfig-a004-20210121
i386                 randconfig-a006-20210121
i386                 randconfig-a005-20210121
i386                 randconfig-a003-20210121
i386                 randconfig-a013-20210121
i386                 randconfig-a011-20210121
i386                 randconfig-a012-20210121
i386                 randconfig-a014-20210121
i386                 randconfig-a015-20210121
i386                 randconfig-a016-20210121
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
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

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
