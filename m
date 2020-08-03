Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFA17239DDF
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Aug 2020 05:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbgHCDk7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 2 Aug 2020 23:40:59 -0400
Received: from mga05.intel.com ([192.55.52.43]:35977 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725820AbgHCDk7 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 2 Aug 2020 23:40:59 -0400
IronPort-SDR: hXUzGsd0VIYnanOmQo3lbVUL351wj2JIgC/M+LmptGDoHiBivrZpZotkLegLLrkDUT3Bzk8TKH
 YJH4AzmI+b6g==
X-IronPort-AV: E=McAfee;i="6000,8403,9701"; a="236905972"
X-IronPort-AV: E=Sophos;i="5.75,428,1589266800"; 
   d="scan'208";a="236905972"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2020 20:40:50 -0700
IronPort-SDR: /PDlqv0bFZIvQqItcSv8vRUG8ClnF7W4G6VoEW3rMswFaBmT8OxyggGULRE/lUeoGnCsMcHQwX
 h0cDlpDFK8rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,428,1589266800"; 
   d="scan'208";a="491678985"
Received: from lkp-server01.sh.intel.com (HELO e21119890065) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 02 Aug 2020 20:40:48 -0700
Received: from kbuild by e21119890065 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k2RLD-0001pH-Sk; Mon, 03 Aug 2020 03:40:47 +0000
Date:   Mon, 03 Aug 2020 11:39:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Subject: [wireless-drivers-next:master] BUILD SUCCESS WITH WARNING
 3dc05ffb04436020f63138186dbc4f37bd938552
Message-ID: <5f278704.28CvpKmtytiU4XvD%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git  master
branch HEAD: 3dc05ffb04436020f63138186dbc4f37bd938552  brcmfmac: Set timeout value when configuring power save

Warning in current branch:

drivers/net/wireless/realtek/rtw88/rtw8821c.c:71:8: warning: type qualifiers ignored on function return type [-Wignored-qualifiers]

Warning ids grouped by kconfigs:

recent_errors
|-- alpha-allmodconfig
|   `-- drivers-net-wireless-realtek-rtw88-rtw8821c.c:warning:type-qualifiers-ignored-on-function-return-type
|-- alpha-allyesconfig
|   `-- drivers-net-wireless-realtek-rtw88-rtw8821c.c:warning:type-qualifiers-ignored-on-function-return-type
|-- arc-allyesconfig
|   `-- drivers-net-wireless-realtek-rtw88-rtw8821c.c:warning:type-qualifiers-ignored-on-function-return-type
|-- arm-allmodconfig
|   `-- drivers-net-wireless-realtek-rtw88-rtw8821c.c:warning:type-qualifiers-ignored-on-function-return-type
|-- arm-allyesconfig
|   `-- drivers-net-wireless-realtek-rtw88-rtw8821c.c:warning:type-qualifiers-ignored-on-function-return-type
|-- arm64-allyesconfig
|   `-- drivers-net-wireless-realtek-rtw88-rtw8821c.c:warning:type-qualifiers-ignored-on-function-return-type
|-- i386-allyesconfig
|   `-- drivers-net-wireless-realtek-rtw88-rtw8821c.c:warning:type-qualifiers-ignored-on-function-return-type
|-- ia64-allmodconfig
|   `-- drivers-net-wireless-realtek-rtw88-rtw8821c.c:warning:type-qualifiers-ignored-on-function-return-type
|-- ia64-allyesconfig
|   `-- drivers-net-wireless-realtek-rtw88-rtw8821c.c:warning:type-qualifiers-ignored-on-function-return-type
|-- microblaze-allyesconfig
|   `-- drivers-net-wireless-realtek-rtw88-rtw8821c.c:warning:type-qualifiers-ignored-on-function-return-type
|-- mips-allmodconfig
|   `-- drivers-net-wireless-realtek-rtw88-rtw8821c.c:warning:type-qualifiers-ignored-on-function-return-type
|-- mips-allyesconfig
|   `-- drivers-net-wireless-realtek-rtw88-rtw8821c.c:warning:type-qualifiers-ignored-on-function-return-type
|-- parisc-allyesconfig
|   `-- drivers-net-wireless-realtek-rtw88-rtw8821c.c:warning:type-qualifiers-ignored-on-function-return-type
|-- powerpc-allmodconfig
|   `-- drivers-net-wireless-realtek-rtw88-rtw8821c.c:warning:type-qualifiers-ignored-on-function-return-type
|-- powerpc-allyesconfig
|   `-- drivers-net-wireless-realtek-rtw88-rtw8821c.c:warning:type-qualifiers-ignored-on-function-return-type
|-- riscv-allmodconfig
|   `-- drivers-net-wireless-realtek-rtw88-rtw8821c.c:warning:type-qualifiers-ignored-on-function-return-type
|-- riscv-allyesconfig
|   `-- drivers-net-wireless-realtek-rtw88-rtw8821c.c:warning:type-qualifiers-ignored-on-function-return-type
|-- sparc-allyesconfig
|   `-- drivers-net-wireless-realtek-rtw88-rtw8821c.c:warning:type-qualifiers-ignored-on-function-return-type
|-- x86_64-allmodconfig
|   `-- drivers-net-wireless-realtek-rtw88-rtw8821c.c:warning:type-qualifiers-ignored-on-function-return-type
|-- x86_64-allyesconfig
|   `-- drivers-net-wireless-realtek-rtw88-rtw8821c.c:warning:type-qualifiers-ignored-on-function-return-type
`-- xtensa-allyesconfig
    `-- drivers-net-wireless-realtek-rtw88-rtw8821c.c:warning:type-qualifiers-ignored-on-function-return-type

elapsed time: 723m

configs tested: 85
configs skipped: 5

arm64                            allyesconfig
arm                              allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm64                               defconfig
powerpc                    adder875_defconfig
powerpc                          g5_defconfig
sh                   rts7751r2dplus_defconfig
arm                      jornada720_defconfig
mips                         rt305x_defconfig
powerpc                 linkstation_defconfig
sh                          r7785rp_defconfig
m68k                          sun3x_defconfig
arm                        mvebu_v7_defconfig
arm                            zeus_defconfig
c6x                         dsk6455_defconfig
m68k                                defconfig
nds32                            alldefconfig
arc                         haps_hs_defconfig
arm                          exynos_defconfig
mips                      pistachio_defconfig
arm                     davinci_all_defconfig
mips                           ip27_defconfig
mips                           xway_defconfig
riscv                    nommu_virt_defconfig
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
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
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
x86_64               randconfig-a006-20200802
x86_64               randconfig-a001-20200802
x86_64               randconfig-a004-20200802
x86_64               randconfig-a003-20200802
x86_64               randconfig-a002-20200802
x86_64               randconfig-a005-20200802
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
