Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC0947E7A7
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Dec 2021 19:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240159AbhLWSeF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Dec 2021 13:34:05 -0500
Received: from mga07.intel.com ([134.134.136.100]:49343 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235579AbhLWSeE (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Dec 2021 13:34:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640284444; x=1671820444;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=BFv40C4tL416DsOs+PpT2MD7H41mH/r5lDk6Ih6wPVc=;
  b=GzRkwWK7RRurhK0Cv33P5+7HXiTA5im5NJn32HXoxK1xBmRVs9Q5AgaW
   T7tt45pLd5KmfOKotdedWyuu3H0PtxM69L5qRQzmVS/40Q8V0BKihDFre
   2klqYkDpA3bYX8JGwG+fnorjuifLtvtcxZMSb5dAwqeYPBuKRQ38okGCF
   XGANixNoaA1nTCxGLqylg1ycnYiOqkiFzoyxVOucfo1mFUGcR7i4EvF9S
   J0ay2tfT6OUiAs+0ReesPhskasDej4A/Gvtpm8X8PWFznLAOhIm470HSc
   IqTaSYsgq4dYTbtAYJQw4QX4jHsm+8fcthR2alZLyhf6U1tibh3VE4CaX
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10207"; a="304239469"
X-IronPort-AV: E=Sophos;i="5.88,230,1635231600"; 
   d="scan'208";a="304239469"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2021 10:34:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,230,1635231600"; 
   d="scan'208";a="685451546"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 23 Dec 2021 10:34:03 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n0Sug-0002A8-HA; Thu, 23 Dec 2021 18:34:02 +0000
Date:   Fri, 24 Dec 2021 02:33:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org
Subject: [kvalo-wireless-drivers-next:master] BUILD SUCCESS
 d430dffbe9dd30759f3c64b65bf85b0245c8d8ab
Message-ID: <61c4c0e6.hYF9nTZ5OG8snjPB%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git master
branch HEAD: d430dffbe9dd30759f3c64b65bf85b0245c8d8ab  mt76: mt7921: fix a possible race enabling/disabling runtime-pm

elapsed time: 1409m

configs tested: 166
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211223
arm                          moxart_defconfig
powerpc               mpc834x_itxgp_defconfig
sparc                       sparc64_defconfig
powerpc                         wii_defconfig
powerpc64                        alldefconfig
powerpc                      ppc44x_defconfig
sh                 kfr2r09-romimage_defconfig
powerpc                      pcm030_defconfig
arc                     nsimosci_hs_defconfig
mips                         db1xxx_defconfig
sh                          sdk7786_defconfig
arm                          badge4_defconfig
powerpc                     tqm8540_defconfig
mips                           ip22_defconfig
sh                          landisk_defconfig
arm                           sama5_defconfig
ia64                          tiger_defconfig
sh                           se7343_defconfig
ia64                      gensparse_defconfig
powerpc                   motionpro_defconfig
arm                        clps711x_defconfig
h8300                     edosk2674_defconfig
arc                        vdk_hs38_defconfig
m68k                       m5208evb_defconfig
powerpc                     tqm8555_defconfig
arm                         lpc32xx_defconfig
mips                   sb1250_swarm_defconfig
arm                       aspeed_g4_defconfig
arm                          pxa3xx_defconfig
sh                           se7722_defconfig
mips                     cu1000-neo_defconfig
mips                            e55_defconfig
arm                             pxa_defconfig
sh                          kfr2r09_defconfig
powerpc                 mpc832x_mds_defconfig
ia64                             allyesconfig
powerpc                     skiroot_defconfig
powerpc                      ep88xc_defconfig
mips                     decstation_defconfig
arc                            hsdk_defconfig
powerpc                      pmac32_defconfig
arm                        oxnas_v6_defconfig
powerpc                     ppa8548_defconfig
powerpc64                           defconfig
sh                        edosk7760_defconfig
powerpc                     kilauea_defconfig
sh                          rsk7264_defconfig
arm                          pxa168_defconfig
powerpc                      makalu_defconfig
arm                        trizeps4_defconfig
sh                      rts7751r2d1_defconfig
s390                             allyesconfig
openrisc                            defconfig
m68k                       bvme6000_defconfig
alpha                               defconfig
riscv             nommu_k210_sdcard_defconfig
arm                            mmp2_defconfig
powerpc                         ps3_defconfig
sh                          rsk7203_defconfig
powerpc                 mpc832x_rdb_defconfig
mips                       capcella_defconfig
mips                         tb0226_defconfig
xtensa                           alldefconfig
sh                           se7724_defconfig
mips                     loongson1b_defconfig
powerpc                 mpc8313_rdb_defconfig
arm                           sunxi_defconfig
sh                           se7721_defconfig
arm                  randconfig-c002-20211223
arm                  randconfig-c002-20211222
ia64                             allmodconfig
ia64                                defconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a006-20211222
i386                 randconfig-a004-20211222
i386                 randconfig-a002-20211222
i386                 randconfig-a003-20211222
i386                 randconfig-a005-20211222
i386                 randconfig-a001-20211222
x86_64               randconfig-a013-20211223
x86_64               randconfig-a015-20211223
x86_64               randconfig-a014-20211223
x86_64               randconfig-a011-20211223
x86_64               randconfig-a012-20211223
x86_64               randconfig-a016-20211223
i386                 randconfig-a012-20211223
i386                 randconfig-a011-20211223
i386                 randconfig-a014-20211223
i386                 randconfig-a016-20211223
i386                 randconfig-a015-20211223
i386                 randconfig-a013-20211223
x86_64               randconfig-a001-20211222
x86_64               randconfig-a003-20211222
x86_64               randconfig-a005-20211222
x86_64               randconfig-a006-20211222
x86_64               randconfig-a004-20211222
x86_64               randconfig-a002-20211222
arc                  randconfig-r043-20211223
riscv                randconfig-r042-20211223
s390                 randconfig-r044-20211223
arc                  randconfig-r043-20211222
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a001-20211223
x86_64               randconfig-a003-20211223
x86_64               randconfig-a005-20211223
x86_64               randconfig-a006-20211223
x86_64               randconfig-a004-20211223
x86_64               randconfig-a002-20211223
i386                 randconfig-a006-20211223
i386                 randconfig-a004-20211223
i386                 randconfig-a002-20211223
i386                 randconfig-a003-20211223
i386                 randconfig-a005-20211223
i386                 randconfig-a001-20211223
hexagon              randconfig-r041-20211222
hexagon              randconfig-r045-20211222
s390                 randconfig-r044-20211222
riscv                randconfig-r042-20211222

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
