Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 901CA316155
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Feb 2021 09:46:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbhBJIpr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Feb 2021 03:45:47 -0500
Received: from mga17.intel.com ([192.55.52.151]:19945 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230206AbhBJIlT (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Feb 2021 03:41:19 -0500
IronPort-SDR: p+fvoMMcw5A5TTpUeDxLe3j1VK0oDrxxofyxq9BJAwhqOrQYxwI3fJl70lNcv6m5M96YdaCptL
 6o4eI+p1wJlA==
X-IronPort-AV: E=McAfee;i="6000,8403,9890"; a="161787437"
X-IronPort-AV: E=Sophos;i="5.81,167,1610438400"; 
   d="scan'208";a="161787437"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2021 00:40:34 -0800
IronPort-SDR: smQhOqD2ESG+CibLN+ICzaU616lHv67fVCt93zKTTBuzRaXvzLguDob4SPYsLC1dsm6gTHnKre
 X967aydLyJAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,167,1610438400"; 
   d="scan'208";a="586118572"
Received: from lkp-server02.sh.intel.com (HELO cd560a204411) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 10 Feb 2021 00:40:33 -0800
Received: from kbuild by cd560a204411 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l9l33-0002qF-5C; Wed, 10 Feb 2021 08:40:33 +0000
Date:   Wed, 10 Feb 2021 16:40:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     linux-wireless@vger.kernel.org
Subject: [mac80211:master] BUILD SUCCESS
 b3d2c7b876d450e1d2624fd67658acc96465a9e6
Message-ID: <60239bfa.A7pk41lBe1J8b4Xk%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211.git master
branch HEAD: b3d2c7b876d450e1d2624fd67658acc96465a9e6  Merge git://git.kernel.org/pub/scm/linux/kernel/git/pablo/nf

elapsed time: 728m

configs tested: 123
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                          r7785rp_defconfig
sparc64                             defconfig
arm                     am200epdkit_defconfig
sh                            shmin_defconfig
powerpc                     tqm8540_defconfig
mips                           ci20_defconfig
m68k                       m5249evb_defconfig
sh                   sh7770_generic_defconfig
c6x                        evmc6472_defconfig
mips                         cobalt_defconfig
arc                        nsimosci_defconfig
powerpc                     sbc8548_defconfig
mips                       rbtx49xx_defconfig
xtensa                          iss_defconfig
riscv                    nommu_k210_defconfig
xtensa                         virt_defconfig
sh                 kfr2r09-romimage_defconfig
powerpc                 mpc8560_ads_defconfig
mips                           rs90_defconfig
arm                         s5pv210_defconfig
sh                               allmodconfig
xtensa                  audio_kc705_defconfig
arm                    vt8500_v6_v7_defconfig
arm                             pxa_defconfig
parisc                              defconfig
mips                           xway_defconfig
arm                       netwinder_defconfig
mips                            gpr_defconfig
arc                        vdk_hs38_defconfig
powerpc                     sequoia_defconfig
powerpc                     taishan_defconfig
alpha                               defconfig
mips                      maltaaprp_defconfig
arc                              allyesconfig
m68k                       m5475evb_defconfig
arm                           stm32_defconfig
mips                          malta_defconfig
m68k                        mvme147_defconfig
arm                       cns3420vb_defconfig
alpha                            allyesconfig
sh                             shx3_defconfig
arm                          ixp4xx_defconfig
xtensa                  nommu_kc705_defconfig
arm                        mvebu_v7_defconfig
arm                         s3c2410_defconfig
powerpc                        cell_defconfig
sh                   rts7751r2dplus_defconfig
arm                         hackkit_defconfig
nds32                               defconfig
sh                          rsk7201_defconfig
m68k                             allyesconfig
nios2                         3c120_defconfig
powerpc                     powernv_defconfig
sh                     sh7710voipgw_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
nds32                             allnoconfig
c6x                              allyesconfig
nios2                            allyesconfig
csky                                defconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
s390                             allyesconfig
s390                             allmodconfig
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
x86_64               randconfig-a006-20210209
x86_64               randconfig-a001-20210209
x86_64               randconfig-a005-20210209
x86_64               randconfig-a004-20210209
x86_64               randconfig-a002-20210209
x86_64               randconfig-a003-20210209
i386                 randconfig-a001-20210209
i386                 randconfig-a005-20210209
i386                 randconfig-a003-20210209
i386                 randconfig-a002-20210209
i386                 randconfig-a006-20210209
i386                 randconfig-a004-20210209
i386                 randconfig-a016-20210209
i386                 randconfig-a013-20210209
i386                 randconfig-a012-20210209
i386                 randconfig-a014-20210209
i386                 randconfig-a011-20210209
i386                 randconfig-a015-20210209
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
