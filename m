Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 216EF2D8C86
	for <lists+linux-wireless@lfdr.de>; Sun, 13 Dec 2020 10:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405671AbgLMJ3q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 13 Dec 2020 04:29:46 -0500
Received: from mga04.intel.com ([192.55.52.120]:2912 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728505AbgLMJ3p (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 13 Dec 2020 04:29:45 -0500
IronPort-SDR: 0Vf5U46hdeUhE5PAFZ6OSo+MXueUncpWjNHm0YN6XK1haUwEzULmoCKWOqoq11cU67NNNYx1rA
 uEttfx8YXR8g==
X-IronPort-AV: E=McAfee;i="6000,8403,9833"; a="172030455"
X-IronPort-AV: E=Sophos;i="5.78,416,1599548400"; 
   d="scan'208";a="172030455"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2020 01:28:58 -0800
IronPort-SDR: igzxc+KPUqQlKlrismO/de0lyCHRGz048FzG4ti8posQxr7/vUHROVWLfP4TAXOOkhliHqAML0
 itYknxrYWlEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,416,1599548400"; 
   d="scan'208";a="329549753"
Received: from lkp-server01.sh.intel.com (HELO ecc0cebe68d1) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 13 Dec 2020 01:28:57 -0800
Received: from kbuild by ecc0cebe68d1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1koNgW-0001jq-OU; Sun, 13 Dec 2020 09:28:56 +0000
Date:   Sun, 13 Dec 2020 17:28:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     linux-wireless@vger.kernel.org
Subject: [mac80211-next:master] BUILD SUCCESS
 e5795aacd71b697c739f2d193b0e275993d93187
Message-ID: <5fd5decc.K+92xzlaUg9ViA0h%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211-next.git  master
branch HEAD: e5795aacd71b697c739f2d193b0e275993d93187  Merge tag 'wireless-drivers-next-2020-12-12' of git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next

elapsed time: 723m

configs tested: 106
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
nios2                            alldefconfig
sh                          polaris_defconfig
m68k                        mvme16x_defconfig
openrisc                            defconfig
mips                        qi_lb60_defconfig
arm                           tegra_defconfig
mips                          rm200_defconfig
sh                               j2_defconfig
powerpc                     pseries_defconfig
mips                        bcm63xx_defconfig
mips                        nlm_xlp_defconfig
arm                        shmobile_defconfig
powerpc                 linkstation_defconfig
sh                        apsh4ad0a_defconfig
arc                           tb10x_defconfig
riscv                             allnoconfig
arm                        multi_v5_defconfig
sh                                  defconfig
powerpc                      pcm030_defconfig
m68k                          atari_defconfig
mips                      loongson3_defconfig
powerpc                    amigaone_defconfig
powerpc                       ebony_defconfig
x86_64                              defconfig
alpha                            allyesconfig
mips                      maltasmvp_defconfig
arc                 nsimosci_hs_smp_defconfig
powerpc                 mpc832x_mds_defconfig
powerpc                   currituck_defconfig
arm                          pxa910_defconfig
arm                          imote2_defconfig
parisc                generic-32bit_defconfig
csky                                defconfig
arm                       multi_v4t_defconfig
sh                         ecovec24_defconfig
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
alpha                               defconfig
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
x86_64               randconfig-a003-20201213
x86_64               randconfig-a006-20201213
x86_64               randconfig-a002-20201213
x86_64               randconfig-a005-20201213
x86_64               randconfig-a004-20201213
x86_64               randconfig-a001-20201213
i386                 randconfig-a001-20201213
i386                 randconfig-a004-20201213
i386                 randconfig-a003-20201213
i386                 randconfig-a002-20201213
i386                 randconfig-a005-20201213
i386                 randconfig-a006-20201213
i386                 randconfig-a014-20201213
i386                 randconfig-a013-20201213
i386                 randconfig-a012-20201213
i386                 randconfig-a011-20201213
i386                 randconfig-a016-20201213
i386                 randconfig-a015-20201213
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a016-20201213
x86_64               randconfig-a012-20201213
x86_64               randconfig-a013-20201213
x86_64               randconfig-a015-20201213
x86_64               randconfig-a014-20201213
x86_64               randconfig-a011-20201213

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
