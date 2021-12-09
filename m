Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43C9546E904
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Dec 2021 14:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237889AbhLINWE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Dec 2021 08:22:04 -0500
Received: from mga09.intel.com ([134.134.136.24]:51105 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237863AbhLINWC (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Dec 2021 08:22:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639055909; x=1670591909;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=RQF2cIsT5+92HYK74sxhOnYAEbeSFbKBCR+ynsKolhk=;
  b=SkroDb88f70NWslPtp+oDivGvWNn+WI+xAEa3wakeWQHs21AmrkvAelW
   9QmepaPdFooGG1qvG7jQkFCwlS1RUWk01+y0DWqbA2RoCcWP3xK0WnQRF
   Bl2Wo+tgsdVj9lyq0eq8xXbxDjoxmAvHx6HYWXUEH1xDYgA1XCx8dP801
   mczV0qVeBDEh85ADo8pLzbHmZzsIwfhXVvwXVTjqS3/fImd5bfGrX5SrQ
   lWOpbKu6yGuRfelECA2T/74zOBAAkG61Iiux/PSH3NGCEE4R5VEmSmfp9
   Z49WTvDrMFIjfDfBGnivWS4PLuw946fumJ5Mlg7xj7YrGAd6iN/dMlchz
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10192"; a="237899592"
X-IronPort-AV: E=Sophos;i="5.88,192,1635231600"; 
   d="scan'208";a="237899592"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 05:18:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,192,1635231600"; 
   d="scan'208";a="680323986"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 09 Dec 2021 05:18:27 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mvJJa-0001x5-Ov; Thu, 09 Dec 2021 13:18:26 +0000
Date:   Thu, 09 Dec 2021 21:17:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org
Subject: [kvalo-wireless-drivers-next:master] BUILD SUCCESS
 05db148ee9a7c7d2a690ff2862fac77be06ce667
Message-ID: <61b201e4.Xtu2tEiwuwY+FKXz%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git master
branch HEAD: 05db148ee9a7c7d2a690ff2862fac77be06ce667  libertas_tf: Add missing __packed annotations

elapsed time: 1065m

configs tested: 147
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211209
powerpc                      mgcoge_defconfig
arm                        mvebu_v7_defconfig
m68k                        stmark2_defconfig
arm                          imote2_defconfig
arm                       imx_v6_v7_defconfig
sh                             espt_defconfig
powerpc                   microwatt_defconfig
arm                          exynos_defconfig
sh                     magicpanelr2_defconfig
powerpc                      chrp32_defconfig
arm                         hackkit_defconfig
arm                             mxs_defconfig
powerpc                       holly_defconfig
mips                         mpc30x_defconfig
sh                           se7206_defconfig
arc                      axs103_smp_defconfig
mips                           mtx1_defconfig
m68k                       m5249evb_defconfig
arm                           spitz_defconfig
powerpc64                        alldefconfig
sh                            titan_defconfig
powerpc                  storcenter_defconfig
arm                          lpd270_defconfig
powerpc                    sam440ep_defconfig
mips                          rm200_defconfig
arm                        keystone_defconfig
mips                      loongson3_defconfig
xtensa                  nommu_kc705_defconfig
mips                     loongson2k_defconfig
sh                          kfr2r09_defconfig
arc                 nsimosci_hs_smp_defconfig
arm                            dove_defconfig
powerpc                     tqm8548_defconfig
mips                         tb0287_defconfig
sh                          landisk_defconfig
powerpc                 mpc8313_rdb_defconfig
arm                      pxa255-idp_defconfig
mips                       lemote2f_defconfig
riscv                               defconfig
arm                        clps711x_defconfig
sh                     sh7710voipgw_defconfig
arm                      integrator_defconfig
powerpc                      makalu_defconfig
m68k                             alldefconfig
arm                           sama5_defconfig
powerpc                          g5_defconfig
powerpc                     sequoia_defconfig
arm                        multi_v5_defconfig
h8300                       h8s-sim_defconfig
sh                   sh7724_generic_defconfig
powerpc               mpc834x_itxgp_defconfig
um                                  defconfig
arc                     nsimosci_hs_defconfig
sh                          lboxre2_defconfig
arm                         cm_x300_defconfig
arm                      tct_hammer_defconfig
powerpc                      ppc6xx_defconfig
m68k                        m5272c3_defconfig
arm                  randconfig-c002-20211209
arm                  randconfig-c002-20211207
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
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20211209
x86_64               randconfig-a005-20211209
x86_64               randconfig-a001-20211209
x86_64               randconfig-a002-20211209
x86_64               randconfig-a004-20211209
x86_64               randconfig-a003-20211209
x86_64               randconfig-a006-20211207
x86_64               randconfig-a005-20211207
x86_64               randconfig-a001-20211207
x86_64               randconfig-a002-20211207
x86_64               randconfig-a004-20211207
x86_64               randconfig-a003-20211207
i386                 randconfig-a001-20211209
i386                 randconfig-a005-20211209
i386                 randconfig-a003-20211209
i386                 randconfig-a002-20211209
i386                 randconfig-a006-20211209
i386                 randconfig-a004-20211209
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
arm                  randconfig-c002-20211209
x86_64               randconfig-c007-20211209
riscv                randconfig-c006-20211209
i386                 randconfig-c001-20211209
mips                 randconfig-c004-20211209
powerpc              randconfig-c003-20211209
s390                 randconfig-c005-20211209
i386                 randconfig-a013-20211209
i386                 randconfig-a016-20211209
i386                 randconfig-a011-20211209
i386                 randconfig-a014-20211209
i386                 randconfig-a012-20211209
i386                 randconfig-a015-20211209
hexagon              randconfig-r045-20211209
s390                 randconfig-r044-20211209
hexagon              randconfig-r041-20211209
riscv                randconfig-r042-20211209

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
