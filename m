Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 653602607BD
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Sep 2020 02:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728220AbgIHAjV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Sep 2020 20:39:21 -0400
Received: from mga06.intel.com ([134.134.136.31]:39263 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728104AbgIHAjV (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Sep 2020 20:39:21 -0400
IronPort-SDR: eeaLNMGyB1m5Qi0dcvtx9j+Bn704500a9bcQb9vk+qkoKhYtUOs8ddR8j4tuzeHi13jxiopsT3
 ODvuaX7HlppA==
X-IronPort-AV: E=McAfee;i="6000,8403,9737"; a="219614016"
X-IronPort-AV: E=Sophos;i="5.76,403,1592895600"; 
   d="scan'208";a="219614016"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2020 17:39:19 -0700
IronPort-SDR: rhHupBQh5EUjRC7gz2SO7ZBchHHS0s0SPWzGXsRkh1ClkZ0ER/5G7P8sEhRqQ00a8gECmkggtP
 51xFr5K8ZsSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,403,1592895600"; 
   d="scan'208";a="316997635"
Received: from lkp-server02.sh.intel.com (HELO a98deea729ba) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 07 Sep 2020 17:39:18 -0700
Received: from kbuild by a98deea729ba with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kFRfJ-0000Kd-Cj; Tue, 08 Sep 2020 00:39:17 +0000
Date:   Tue, 08 Sep 2020 08:38:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Subject: [wireless-drivers-next:master] BUILD SUCCESS
 cc95fa81524a95358a7bc1d29e9e3c314753486c
Message-ID: <5f56d27e.pOaor9hW3CKiuDgx%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git  master
branch HEAD: cc95fa81524a95358a7bc1d29e9e3c314753486c  brcmfmac: set F2 SDIO block size to 128 bytes for BCM4329

elapsed time: 721m

configs tested: 120
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
nds32                            alldefconfig
mips                        workpad_defconfig
mips                     cu1000-neo_defconfig
powerpc                          g5_defconfig
mips                          ath25_defconfig
arm                          pcm027_defconfig
powerpc                      ppc40x_defconfig
mips                        nlm_xlp_defconfig
sh                           se7780_defconfig
powerpc                           allnoconfig
arm                    vt8500_v6_v7_defconfig
c6x                        evmc6457_defconfig
arm                         lpc18xx_defconfig
arm                           u8500_defconfig
arm                           omap1_defconfig
mips                  decstation_64_defconfig
arm                       omap2plus_defconfig
nios2                         3c120_defconfig
sh                         apsh4a3a_defconfig
m68k                          atari_defconfig
powerpc                     pseries_defconfig
arc                        nsimosci_defconfig
sh                          landisk_defconfig
powerpc                         wii_defconfig
h8300                    h8300h-sim_defconfig
xtensa                              defconfig
h8300                               defconfig
arm                        neponset_defconfig
riscv                    nommu_k210_defconfig
arm                            mmp2_defconfig
powerpc                      ppc64e_defconfig
powerpc                    gamecube_defconfig
c6x                              allyesconfig
sh                   sh7724_generic_defconfig
mips                          ath79_defconfig
openrisc                    or1ksim_defconfig
sh                          lboxre2_defconfig
arc                              allyesconfig
powerpc                    mvme5100_defconfig
openrisc                            defconfig
ia64                             alldefconfig
nds32                               defconfig
mips                             allyesconfig
sh                          sdk7786_defconfig
arm                             ezx_defconfig
mips                       lemote2f_defconfig
arm                        spear6xx_defconfig
powerpc                      ppc6xx_defconfig
riscv                            alldefconfig
arm                            xcep_defconfig
powerpc                       holly_defconfig
sh                   sh7770_generic_defconfig
arm                            mps2_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
nds32                             allnoconfig
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
i386                                defconfig
mips                             allmodconfig
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
i386                 randconfig-a004-20200907
i386                 randconfig-a005-20200907
i386                 randconfig-a006-20200907
i386                 randconfig-a002-20200907
i386                 randconfig-a003-20200907
i386                 randconfig-a001-20200907
x86_64               randconfig-a006-20200907
x86_64               randconfig-a004-20200907
x86_64               randconfig-a003-20200907
x86_64               randconfig-a005-20200907
x86_64               randconfig-a001-20200907
x86_64               randconfig-a002-20200907
i386                 randconfig-a016-20200907
i386                 randconfig-a015-20200907
i386                 randconfig-a011-20200907
i386                 randconfig-a013-20200907
i386                 randconfig-a014-20200907
i386                 randconfig-a012-20200907
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

clang tested configs:
x86_64               randconfig-a013-20200907
x86_64               randconfig-a011-20200907
x86_64               randconfig-a016-20200907
x86_64               randconfig-a012-20200907
x86_64               randconfig-a015-20200907
x86_64               randconfig-a014-20200907

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
