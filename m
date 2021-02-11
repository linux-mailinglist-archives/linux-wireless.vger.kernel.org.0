Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA66318303
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Feb 2021 02:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbhBKBTZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Feb 2021 20:19:25 -0500
Received: from mga12.intel.com ([192.55.52.136]:60878 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230433AbhBKBTY (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Feb 2021 20:19:24 -0500
IronPort-SDR: Hn04VLMFTJVTdZeoc+riZXswuULCjr35O1RTrjxF4+xdvA4AcNUs5I/gt3VBtvLlIdtd1BuIOX
 Mt7t92XJC6CQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9891"; a="161323470"
X-IronPort-AV: E=Sophos;i="5.81,169,1610438400"; 
   d="scan'208";a="161323470"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2021 17:18:43 -0800
IronPort-SDR: Gtal5LNeeJuxZRUaOJ3FHTwR31Hu7E7Drj7UfDev3r6p0OpJJtHAXNGG8OZgj6GDbyKqOlczid
 VrM3IAaOkaNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,169,1610438400"; 
   d="scan'208";a="361544693"
Received: from lkp-server02.sh.intel.com (HELO cd560a204411) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 10 Feb 2021 17:18:41 -0800
Received: from kbuild by cd560a204411 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lA0cy-0003Np-M8; Thu, 11 Feb 2021 01:18:40 +0000
Date:   Thu, 11 Feb 2021 09:17:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Subject: [wireless-drivers-next:master] BUILD SUCCESS
 8e79106a7dbbfcb9e87644d0ee1d038670fba844
Message-ID: <602485c2.d37oVpWDJ591F6C8%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git master
branch HEAD: 8e79106a7dbbfcb9e87644d0ee1d038670fba844  rtlwifi: rtl8821ae: phy: Simplify bool comparison

elapsed time: 721m

configs tested: 144
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                         shannon_defconfig
sh                          rsk7203_defconfig
sparc                               defconfig
mips                      bmips_stb_defconfig
arm                              alldefconfig
powerpc                    sam440ep_defconfig
m68k                          amiga_defconfig
sh                        apsh4ad0a_defconfig
arm                           tegra_defconfig
mips                 decstation_r4k_defconfig
sh                                  defconfig
powerpc                     powernv_defconfig
arm                         palmz72_defconfig
mips                       bmips_be_defconfig
mips                        bcm47xx_defconfig
openrisc                    or1ksim_defconfig
openrisc                  or1klitex_defconfig
powerpc                      obs600_defconfig
m68k                       m5249evb_defconfig
powerpc                mpc7448_hpc2_defconfig
arc                        nsimosci_defconfig
nios2                         3c120_defconfig
arm                         s3c6400_defconfig
arm                         vf610m4_defconfig
arc                              alldefconfig
c6x                        evmc6474_defconfig
arc                     haps_hs_smp_defconfig
mips                         bigsur_defconfig
mips                      maltaaprp_defconfig
arc                          axs103_defconfig
mips                         tb0219_defconfig
m68k                            q40_defconfig
mips                        qi_lb60_defconfig
arm                           sunxi_defconfig
powerpc                  mpc885_ads_defconfig
arc                         haps_hs_defconfig
arm                          prima2_defconfig
powerpc                          g5_defconfig
sh                  sh7785lcr_32bit_defconfig
arm                  colibri_pxa300_defconfig
sh                          rsk7269_defconfig
mips                            e55_defconfig
xtensa                  nommu_kc705_defconfig
arm                    vt8500_v6_v7_defconfig
arm                        realview_defconfig
arm                          badge4_defconfig
arm                             pxa_defconfig
parisc                              defconfig
mips                           xway_defconfig
arm                       netwinder_defconfig
mips                            gpr_defconfig
sh                         microdev_defconfig
ia64                         bigsur_defconfig
arc                        vdk_hs38_defconfig
mips                           rs90_defconfig
powerpc                     sequoia_defconfig
powerpc                     taishan_defconfig
alpha                               defconfig
mips                         tb0287_defconfig
powerpc                    socrates_defconfig
mips                            ar7_defconfig
powerpc                     sbc8548_defconfig
powerpc                     tqm8555_defconfig
powerpc                          allmodconfig
nios2                            alldefconfig
mips                           ip27_defconfig
powerpc                      katmai_defconfig
xtensa                       common_defconfig
powerpc                 mpc832x_rdb_defconfig
sh                           se7751_defconfig
ia64                      gensparse_defconfig
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
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
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
