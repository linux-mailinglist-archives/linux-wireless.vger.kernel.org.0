Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0387531AA8A
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Feb 2021 09:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbhBMIl3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 13 Feb 2021 03:41:29 -0500
Received: from mga11.intel.com ([192.55.52.93]:10836 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229469AbhBMIl2 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 13 Feb 2021 03:41:28 -0500
IronPort-SDR: RP1rFeZQ5Yo0t3Hes5agwB8gg78bk2wIZcdzezRrnnQCeG67BgctreijLgIMwB9s6ktcP8Mesw
 Ku8A0Yq3i/bw==
X-IronPort-AV: E=McAfee;i="6000,8403,9893"; a="179011876"
X-IronPort-AV: E=Sophos;i="5.81,175,1610438400"; 
   d="scan'208";a="179011876"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2021 00:40:47 -0800
IronPort-SDR: X2u3grAW+qObyVyPRezfwweq8pMcI34lNDuhVjORojKwTUVRSRAr0prYqmAcMWqiosr88vu8+5
 A1l4CVBpTVVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,175,1610438400"; 
   d="scan'208";a="416511334"
Received: from lkp-server02.sh.intel.com (HELO cd560a204411) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 13 Feb 2021 00:40:45 -0800
Received: from kbuild by cd560a204411 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lAqTs-0005FE-GN; Sat, 13 Feb 2021 08:40:44 +0000
Date:   Sat, 13 Feb 2021 16:40:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org
Subject: [mac80211-next:master] BUILD SUCCESS
 735a48481cca453525d9199772f9c3733a47cff4
Message-ID: <6027906c.fu/UfX0FM1YJUrmx%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211-next.git master
branch HEAD: 735a48481cca453525d9199772f9c3733a47cff4  nl80211: add documentation for HT/VHT/HE disable attributes

elapsed time: 728m

configs tested: 141
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                          moxart_defconfig
arm                        spear6xx_defconfig
openrisc                 simple_smp_defconfig
sh                      rts7751r2d1_defconfig
m68k                            q40_defconfig
arm                            lart_defconfig
arm                            pleb_defconfig
arm                   milbeaut_m10v_defconfig
h8300                            alldefconfig
powerpc                     akebono_defconfig
sh                           se7206_defconfig
powerpc                 mpc832x_rdb_defconfig
arm                          pcm027_defconfig
xtensa                    smp_lx200_defconfig
sh                     sh7710voipgw_defconfig
arm                         axm55xx_defconfig
sh                        apsh4ad0a_defconfig
mips                       bmips_be_defconfig
powerpc                  iss476-smp_defconfig
mips                           jazz_defconfig
arm                       netwinder_defconfig
arm                        magician_defconfig
arc                              alldefconfig
mips                        nlm_xlp_defconfig
arm                          pxa3xx_defconfig
sh                         ap325rxa_defconfig
powerpc                       eiger_defconfig
xtensa                  cadence_csp_defconfig
powerpc                 xes_mpc85xx_defconfig
m68k                        m5407c3_defconfig
powerpc                 mpc832x_mds_defconfig
powerpc                        fsp2_defconfig
powerpc                      ppc64e_defconfig
mips                           ci20_defconfig
powerpc                   bluestone_defconfig
sh                          rsk7203_defconfig
nds32                               defconfig
powerpc                    gamecube_defconfig
mips                          ath79_defconfig
powerpc64                        alldefconfig
powerpc                     mpc5200_defconfig
arm                        clps711x_defconfig
arc                        nsim_700_defconfig
powerpc                      pmac32_defconfig
powerpc                        icon_defconfig
powerpc                     pq2fads_defconfig
m68k                        mvme16x_defconfig
i386                                defconfig
powerpc                         wii_defconfig
parisc                           allyesconfig
s390                                defconfig
parisc                              defconfig
parisc                generic-32bit_defconfig
openrisc                            defconfig
powerpc                      ppc6xx_defconfig
powerpc                     mpc83xx_defconfig
h8300                               defconfig
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
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                             allyesconfig
s390                             allmodconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20210209
x86_64               randconfig-a001-20210209
x86_64               randconfig-a005-20210209
x86_64               randconfig-a004-20210209
x86_64               randconfig-a002-20210209
x86_64               randconfig-a003-20210209
x86_64               randconfig-a003-20210212
x86_64               randconfig-a002-20210212
x86_64               randconfig-a004-20210212
x86_64               randconfig-a001-20210212
x86_64               randconfig-a005-20210212
x86_64               randconfig-a006-20210212
i386                 randconfig-a001-20210209
i386                 randconfig-a005-20210209
i386                 randconfig-a003-20210209
i386                 randconfig-a002-20210209
i386                 randconfig-a006-20210209
i386                 randconfig-a004-20210209
i386                 randconfig-a003-20210212
i386                 randconfig-a005-20210212
i386                 randconfig-a002-20210212
i386                 randconfig-a001-20210212
i386                 randconfig-a004-20210212
i386                 randconfig-a006-20210212
i386                 randconfig-a016-20210209
i386                 randconfig-a013-20210209
i386                 randconfig-a012-20210209
i386                 randconfig-a014-20210209
i386                 randconfig-a011-20210209
i386                 randconfig-a015-20210209
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

clang tested configs:
x86_64               randconfig-a013-20210209
x86_64               randconfig-a014-20210209
x86_64               randconfig-a015-20210209
x86_64               randconfig-a012-20210209
x86_64               randconfig-a016-20210209
x86_64               randconfig-a011-20210209

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
