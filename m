Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7EA92FAC78
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Jan 2021 22:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394442AbhARVUD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Jan 2021 16:20:03 -0500
Received: from mga07.intel.com ([134.134.136.100]:46821 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394475AbhARVT5 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Jan 2021 16:19:57 -0500
IronPort-SDR: JxEzDqM0KGUS6joa0aKVQBAadPn401azcHHmC4pIudAt7qpJdZhCTAuH1AvvNAgZOzJzG7Dy1z
 M9pIUY+16UQA==
X-IronPort-AV: E=McAfee;i="6000,8403,9868"; a="242919265"
X-IronPort-AV: E=Sophos;i="5.79,357,1602572400"; 
   d="scan'208";a="242919265"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2021 13:19:10 -0800
IronPort-SDR: sss2+fcK3ZNKKvjfur1UXLiM0zq/C7+1I1ca5dQ2rCOpbDetxk7wiivd8RFyvg/TCI00HmyY/k
 pydSoF0S+k3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,357,1602572400"; 
   d="scan'208";a="569285830"
Received: from lkp-server01.sh.intel.com (HELO 260eafd5ecd0) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 18 Jan 2021 13:19:08 -0800
Received: from kbuild by 260eafd5ecd0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l1bvY-0004Sj-8t; Mon, 18 Jan 2021 21:19:08 +0000
Date:   Tue, 19 Jan 2021 05:18:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org
Subject: [mac80211:master] BUILD SUCCESS
 8b194febe111c5cc47595749a766d24ca33dd95a
Message-ID: <6005fb40.NyAne1grAfDmlYvn%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211.git master
branch HEAD: 8b194febe111c5cc47595749a766d24ca33dd95a  mac80211: 160MHz with extended NSS BW in CSA

elapsed time: 721m

configs tested: 113
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                      pcm030_defconfig
c6x                                 defconfig
arm                          ixp4xx_defconfig
ia64                             alldefconfig
xtensa                         virt_defconfig
m68k                        m5307c3_defconfig
arm                           h3600_defconfig
powerpc                 mpc8560_ads_defconfig
xtensa                  nommu_kc705_defconfig
powerpc                 mpc85xx_cds_defconfig
arm                         cm_x300_defconfig
alpha                            alldefconfig
m68k                          amiga_defconfig
arm                        mini2440_defconfig
powerpc                   motionpro_defconfig
arm                         at91_dt_defconfig
arm                            hisi_defconfig
mips                       bmips_be_defconfig
arm                         hackkit_defconfig
sh                 kfr2r09-romimage_defconfig
arm                     eseries_pxa_defconfig
sh                   sh7724_generic_defconfig
mips                       rbtx49xx_defconfig
powerpc                   currituck_defconfig
sparc64                             defconfig
arm                          ep93xx_defconfig
mips                        nlm_xlr_defconfig
powerpc                        cell_defconfig
mips                            ar7_defconfig
powerpc                     pseries_defconfig
arm                           omap1_defconfig
arm                         vf610m4_defconfig
mips                        workpad_defconfig
powerpc                    amigaone_defconfig
sh                         apsh4a3a_defconfig
mips                           ip32_defconfig
microblaze                      mmu_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
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
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a002-20210118
i386                 randconfig-a005-20210118
i386                 randconfig-a006-20210118
i386                 randconfig-a001-20210118
i386                 randconfig-a003-20210118
i386                 randconfig-a004-20210118
x86_64               randconfig-a015-20210118
x86_64               randconfig-a013-20210118
x86_64               randconfig-a012-20210118
x86_64               randconfig-a016-20210118
x86_64               randconfig-a011-20210118
x86_64               randconfig-a014-20210118
i386                 randconfig-a011-20210118
i386                 randconfig-a012-20210118
i386                 randconfig-a016-20210118
i386                 randconfig-a015-20210118
i386                 randconfig-a013-20210118
i386                 randconfig-a014-20210118
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
x86_64               randconfig-a004-20210118
x86_64               randconfig-a006-20210118
x86_64               randconfig-a001-20210118
x86_64               randconfig-a003-20210118
x86_64               randconfig-a005-20210118
x86_64               randconfig-a002-20210118

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
