Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8635331F31D
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Feb 2021 00:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbhBRXb5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Feb 2021 18:31:57 -0500
Received: from mga04.intel.com ([192.55.52.120]:54833 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229577AbhBRXb5 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Feb 2021 18:31:57 -0500
IronPort-SDR: DqQftanpBUi4M/O/fcfPScpIU3BahZXF3vs0VEUtAkqTWXWXAPJjGCtE+AJfl9mD2P27RrNuw3
 4Dc2qd8bnr6w==
X-IronPort-AV: E=McAfee;i="6000,8403,9899"; a="181120570"
X-IronPort-AV: E=Sophos;i="5.81,187,1610438400"; 
   d="scan'208";a="181120570"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2021 15:31:16 -0800
IronPort-SDR: W9lZ2W3a+8Bikhhx7NggCLZT+9m60q+ZLp7eQw56KIjOJNTzh/sRBztiaPUxAi6Za49OlPrdBj
 HSWj7oLpjeug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,187,1610438400"; 
   d="scan'208";a="581458933"
Received: from lkp-server02.sh.intel.com (HELO cd560a204411) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 18 Feb 2021 15:31:14 -0800
Received: from kbuild by cd560a204411 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lCslO-0009yH-0O; Thu, 18 Feb 2021 23:31:14 +0000
Date:   Fri, 19 Feb 2021 07:30:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Subject: [wireless-drivers-next:pending] BUILD SUCCESS
 b8a12d2aca7ce360b32b616844bc1561fce37333
Message-ID: <602ef8ab.OMFBJGjUua4smIbK%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git pending
branch HEAD: b8a12d2aca7ce360b32b616844bc1561fce37333  wireless: Initial driver submission for pureLiFi STA devices

elapsed time: 724m

configs tested: 103
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                         cm_x300_defconfig
c6x                                 defconfig
sh                ecovec24-romimage_defconfig
arm                         lubbock_defconfig
sh                                  defconfig
sh                          rsk7264_defconfig
sh                          rsk7269_defconfig
mips                        maltaup_defconfig
powerpc                     sbc8548_defconfig
arm                          imote2_defconfig
powerpc                      pasemi_defconfig
m68k                        m5407c3_defconfig
mips                          rm200_defconfig
arm                            dove_defconfig
arm                        spear3xx_defconfig
sh                          lboxre2_defconfig
arm                          pxa3xx_defconfig
m68k                       m5208evb_defconfig
mips                      pic32mzda_defconfig
sparc                       sparc64_defconfig
powerpc                      katmai_defconfig
powerpc                      acadia_defconfig
xtensa                    xip_kc705_defconfig
m68k                        m5307c3_defconfig
arm                             rpc_defconfig
sh                           sh2007_defconfig
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
i386                 randconfig-a005-20210218
i386                 randconfig-a003-20210218
i386                 randconfig-a002-20210218
i386                 randconfig-a004-20210218
i386                 randconfig-a001-20210218
i386                 randconfig-a006-20210218
x86_64               randconfig-a013-20210217
x86_64               randconfig-a016-20210217
x86_64               randconfig-a012-20210217
x86_64               randconfig-a015-20210217
x86_64               randconfig-a014-20210217
x86_64               randconfig-a011-20210217
i386                 randconfig-a016-20210218
i386                 randconfig-a012-20210218
i386                 randconfig-a014-20210218
i386                 randconfig-a013-20210218
i386                 randconfig-a011-20210218
i386                 randconfig-a015-20210218
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
x86_64               randconfig-a003-20210215
x86_64               randconfig-a002-20210215
x86_64               randconfig-a001-20210215
x86_64               randconfig-a004-20210215
x86_64               randconfig-a005-20210215
x86_64               randconfig-a006-20210215

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
