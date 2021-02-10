Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F52B315C4F
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Feb 2021 02:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235068AbhBJBcs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Feb 2021 20:32:48 -0500
Received: from mga05.intel.com ([192.55.52.43]:30127 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234918AbhBJBag (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Feb 2021 20:30:36 -0500
IronPort-SDR: 3srE4Sp1Sk+t4SSUFxPuJaQYnSAN2kUu129nXPe1JhEgEFvB8tEALZgXh3Fh2ltXOb3uhtQf9M
 6UgDrKiI0ykg==
X-IronPort-AV: E=McAfee;i="6000,8403,9890"; a="266831280"
X-IronPort-AV: E=Sophos;i="5.81,166,1610438400"; 
   d="scan'208";a="266831280"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2021 17:29:46 -0800
IronPort-SDR: qcpJSqS4Y2klDQsDdKrB+ftKEgQJFX3Qe9b40oKiCkmMykD49ulb4frdk463Qn8WD6FwWNvUIH
 9xXWMVDqIygw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,166,1610438400"; 
   d="scan'208";a="412436746"
Received: from lkp-server02.sh.intel.com (HELO cd560a204411) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 09 Feb 2021 17:29:44 -0800
Received: from kbuild by cd560a204411 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l9eK7-0002WR-Tk; Wed, 10 Feb 2021 01:29:43 +0000
Date:   Wed, 10 Feb 2021 09:29:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Subject: [wireless-drivers-next:master] BUILD SUCCESS
 7dd56ea45a6686719a9d05c3e3f946a85809d322
Message-ID: <602336f0.8tU1OfATcVJ6IpWq%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git master
branch HEAD: 7dd56ea45a6686719a9d05c3e3f946a85809d322  brcmfmac: add support for CQM RSSI notifications

elapsed time: 722m

configs tested: 106
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
m68k                       m5249evb_defconfig
sh                   sh7770_generic_defconfig
c6x                        evmc6472_defconfig
mips                         cobalt_defconfig
arc                        nsimosci_defconfig
sh                      rts7751r2d1_defconfig
powerpc                    klondike_defconfig
arm                           sunxi_defconfig
powerpc                     pseries_defconfig
arm                       spear13xx_defconfig
powerpc                     kmeter1_defconfig
mips                       lemote2f_defconfig
arc                              allyesconfig
arm                       versatile_defconfig
powerpc                     stx_gp3_defconfig
sh                        sh7785lcr_defconfig
arm                           sama5_defconfig
sh                        sh7763rdp_defconfig
mips                        bcm47xx_defconfig
openrisc                    or1ksim_defconfig
m68k                       m5475evb_defconfig
sh                         microdev_defconfig
powerpc                       ppc64_defconfig
arm                          badge4_defconfig
arm                         hackkit_defconfig
arm                           stm32_defconfig
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
nios2                               defconfig
nds32                             allnoconfig
c6x                              allyesconfig
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
