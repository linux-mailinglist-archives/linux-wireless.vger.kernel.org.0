Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF3FD239E0D
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Aug 2020 06:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725959AbgHCEVY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Aug 2020 00:21:24 -0400
Received: from mga07.intel.com ([134.134.136.100]:11565 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725924AbgHCEVY (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Aug 2020 00:21:24 -0400
IronPort-SDR: urtJ+ihr/P5XTqOFnGRAeNJAd8bUfCSIxFXEgS2QSuHIwI25I+Vw9WkdcZOJH6+3axlzRV3ohc
 8+Bn9ITeFP2g==
X-IronPort-AV: E=McAfee;i="6000,8403,9701"; a="216468783"
X-IronPort-AV: E=Sophos;i="5.75,428,1589266800"; 
   d="scan'208";a="216468783"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2020 21:21:23 -0700
IronPort-SDR: jyrkGsSbbZ6Ii9TnS09A0LHNE8Ye3qmnijyJlhctiMOOoCLWj13e2DCyj89gr0+KJJb6n1VytN
 GMoTNC2hrITQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,428,1589266800"; 
   d="scan'208";a="329882202"
Received: from lkp-server01.sh.intel.com (HELO e21119890065) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Aug 2020 21:21:22 -0700
Received: from kbuild by e21119890065 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k2RyU-0001q6-05; Mon, 03 Aug 2020 04:21:22 +0000
Date:   Mon, 03 Aug 2020 12:20:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Subject: [wireless-drivers-next:pending] BUILD SUCCESS
 5c71d750035d5992b50a4a33d0a6154aa5a2f1c7
Message-ID: <5f2790a7.u0mM4tPDnCMdr0zN%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git  pending
branch HEAD: 5c71d750035d5992b50a4a33d0a6154aa5a2f1c7  Merge branch 'master' into test

elapsed time: 722m

configs tested: 84
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

arm64                            allyesconfig
arm                              allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm64                               defconfig
arm                  colibri_pxa300_defconfig
arm                          gemini_defconfig
c6x                        evmc6678_defconfig
arc                 nsimosci_hs_smp_defconfig
arm                        multi_v5_defconfig
m68k                        m5272c3_defconfig
arm                        shmobile_defconfig
arm                            pleb_defconfig
powerpc                mpc7448_hpc2_defconfig
arm                            zeus_defconfig
c6x                         dsk6455_defconfig
m68k                                defconfig
arm                     am200epdkit_defconfig
arm                         lpc32xx_defconfig
mips                          ath25_defconfig
mips                      maltaaprp_defconfig
mips                  cavium_octeon_defconfig
powerpc                       ppc64_defconfig
mips                  mips_paravirt_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
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
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20200802
x86_64               randconfig-a001-20200802
x86_64               randconfig-a004-20200802
x86_64               randconfig-a003-20200802
x86_64               randconfig-a002-20200802
x86_64               randconfig-a005-20200802
i386                 randconfig-a004-20200802
i386                 randconfig-a005-20200802
i386                 randconfig-a001-20200802
i386                 randconfig-a002-20200802
i386                 randconfig-a003-20200802
i386                 randconfig-a006-20200802
i386                 randconfig-a011-20200802
i386                 randconfig-a012-20200802
i386                 randconfig-a015-20200802
i386                 randconfig-a014-20200802
i386                 randconfig-a013-20200802
i386                 randconfig-a016-20200802
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

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
