Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06E48282369
	for <lists+linux-wireless@lfdr.de>; Sat,  3 Oct 2020 12:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725770AbgJCKA3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 3 Oct 2020 06:00:29 -0400
Received: from mga11.intel.com ([192.55.52.93]:5545 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbgJCKA3 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 3 Oct 2020 06:00:29 -0400
IronPort-SDR: fmD/LWE3htfY4ufukqTJxRWgM2OBU+L/VZybMRY4wV85IfAncJvIzRasWFMMfz+Mep0vcBX13X
 ENUZyt2uV3ZA==
X-IronPort-AV: E=McAfee;i="6000,8403,9762"; a="160488962"
X-IronPort-AV: E=Sophos;i="5.77,331,1596524400"; 
   d="scan'208";a="160488962"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2020 03:00:23 -0700
IronPort-SDR: KYW+FqFdrrhMpv+JxqWaX8bG7cP1Q6ReNICfBxWo8lVAoKjMlhykL9nTgYJdDqTvwnI4y6Xexv
 Ef8Aanc/g4iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,331,1596524400"; 
   d="scan'208";a="352604168"
Received: from lkp-server02.sh.intel.com (HELO b5ae2f167493) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 03 Oct 2020 03:00:22 -0700
Received: from kbuild by b5ae2f167493 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kOeKz-00001c-Ir; Sat, 03 Oct 2020 10:00:21 +0000
Date:   Sat, 03 Oct 2020 18:00:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org
Subject: [mac80211-next:genetlink-op-policy-export] BUILD SUCCESS
 4d5045adfe90c534dbf93f125c3d532ec47fe7c4
Message-ID: <5f784baf.Vp3o7F47ImFdJxFd%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211-next.git  genetlink-op-policy-export
branch HEAD: 4d5045adfe90c534dbf93f125c3d532ec47fe7c4  genetlink: properly support per-op policy dumping

elapsed time: 724m

configs tested: 94
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                  mpc885_ads_defconfig
powerpc                 mpc834x_itx_defconfig
powerpc                      ppc6xx_defconfig
arm                         s3c2410_defconfig
arm                           viper_defconfig
arm                            lart_defconfig
mips                           jazz_defconfig
c6x                         dsk6455_defconfig
arm                        mini2440_defconfig
c6x                        evmc6474_defconfig
arm                          imote2_defconfig
arm                         ebsa110_defconfig
powerpc                     tqm8555_defconfig
m68k                        m5272c3_defconfig
um                            kunit_defconfig
arc                        nsimosci_defconfig
powerpc                       maple_defconfig
powerpc                       ebony_defconfig
sh                   secureedge5410_defconfig
powerpc                         wii_defconfig
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
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a006-20201002
i386                 randconfig-a005-20201002
i386                 randconfig-a001-20201002
i386                 randconfig-a004-20201002
i386                 randconfig-a003-20201002
i386                 randconfig-a002-20201002
x86_64               randconfig-a004-20201002
x86_64               randconfig-a001-20201002
x86_64               randconfig-a002-20201002
x86_64               randconfig-a005-20201002
x86_64               randconfig-a003-20201002
x86_64               randconfig-a006-20201002
i386                 randconfig-a014-20201002
i386                 randconfig-a013-20201002
i386                 randconfig-a015-20201002
i386                 randconfig-a016-20201002
i386                 randconfig-a011-20201002
i386                 randconfig-a012-20201002
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
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a012-20201002
x86_64               randconfig-a015-20201002
x86_64               randconfig-a014-20201002
x86_64               randconfig-a013-20201002
x86_64               randconfig-a011-20201002
x86_64               randconfig-a016-20201002

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
