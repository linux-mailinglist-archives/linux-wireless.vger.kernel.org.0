Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 683C1221C2E
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jul 2020 07:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbgGPFxS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Jul 2020 01:53:18 -0400
Received: from mga03.intel.com ([134.134.136.65]:38291 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725844AbgGPFxS (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Jul 2020 01:53:18 -0400
IronPort-SDR: 3lWYaVvCe9x/0y3tJtbkeERq8aBUe8E4lzRsOZuGgVQ0gWV5J5jGhISVQoJ+giNKFLNW31qZDT
 RjFSuJUsecxQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9683"; a="149314184"
X-IronPort-AV: E=Sophos;i="5.75,358,1589266800"; 
   d="scan'208";a="149314184"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2020 22:53:17 -0700
IronPort-SDR: dYUW4K5MDLaacV1CyofFifd0VZFkQCQkWPDkwj3BA2jWoNuukPY37zOArAmIKhibyriaziSnOS
 o5q3YkwfVDhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,358,1589266800"; 
   d="scan'208";a="485981628"
Received: from lkp-server02.sh.intel.com (HELO 02dcbd16d3ea) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 15 Jul 2020 22:53:16 -0700
Received: from kbuild by 02dcbd16d3ea with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jvwpX-00003V-Vn; Thu, 16 Jul 2020 05:53:15 +0000
Date:   Thu, 16 Jul 2020 13:52:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Subject: [wireless-drivers-next:master] BUILD SUCCESS WITH WARNING
 0e20c3e10333326fc63646fa40b159eb88b7e8c8
Message-ID: <5f0feb00.Ma5reyOGmjZ9Hp1z%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git  master
branch HEAD: 0e20c3e10333326fc63646fa40b159eb88b7e8c8  wireless: Fix trivial spelling

Warning in current branch:

drivers/net/wireless/realtek/rtw88/rtw8821c.c:71:8: warning: type qualifiers ignored on function return type [-Wignored-qualifiers]

Warning ids grouped by kconfigs:

recent_errors
|-- arm-allmodconfig
|   `-- drivers-net-wireless-realtek-rtw88-rtw8821c.c:warning:type-qualifiers-ignored-on-function-return-type
|-- arm-allyesconfig
|   `-- drivers-net-wireless-realtek-rtw88-rtw8821c.c:warning:type-qualifiers-ignored-on-function-return-type
|-- ia64-allmodconfig
|   `-- drivers-net-wireless-realtek-rtw88-rtw8821c.c:warning:type-qualifiers-ignored-on-function-return-type
|-- ia64-allyesconfig
|   `-- drivers-net-wireless-realtek-rtw88-rtw8821c.c:warning:type-qualifiers-ignored-on-function-return-type
|-- mips-allmodconfig
|   `-- drivers-net-wireless-realtek-rtw88-rtw8821c.c:warning:type-qualifiers-ignored-on-function-return-type
|-- mips-allyesconfig
|   `-- drivers-net-wireless-realtek-rtw88-rtw8821c.c:warning:type-qualifiers-ignored-on-function-return-type
|-- parisc-allmodconfig
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
|-- sparc64-allmodconfig
|   `-- drivers-net-wireless-realtek-rtw88-rtw8821c.c:warning:type-qualifiers-ignored-on-function-return-type
|-- sparc64-allyesconfig
|   `-- drivers-net-wireless-realtek-rtw88-rtw8821c.c:warning:type-qualifiers-ignored-on-function-return-type
`-- xtensa-allyesconfig
    `-- drivers-net-wireless-realtek-rtw88-rtw8821c.c:warning:type-qualifiers-ignored-on-function-return-type

elapsed time: 723m

configs tested: 92
configs skipped: 3

arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                               allnoconfig
arm64                            allyesconfig
arm64                               defconfig
arm64                            allmodconfig
arm64                             allnoconfig
arc                          axs101_defconfig
c6x                        evmc6457_defconfig
sh                 kfr2r09-romimage_defconfig
powerpc                    gamecube_defconfig
arm                          lpd270_defconfig
sparc                            alldefconfig
mips                       capcella_defconfig
mips                        nlm_xlr_defconfig
powerpc                      pmac32_defconfig
arm                        clps711x_defconfig
arm                           corgi_defconfig
riscv                            allyesconfig
arm                         orion5x_defconfig
i386                              allnoconfig
i386                             allyesconfig
i386                                defconfig
i386                              debian-10.3
ia64                             allmodconfig
ia64                                defconfig
ia64                              allnoconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                              allnoconfig
m68k                           sun3_defconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
nios2                            allyesconfig
openrisc                            defconfig
c6x                              allyesconfig
c6x                               allnoconfig
openrisc                         allyesconfig
nds32                               defconfig
nds32                             allnoconfig
csky                             allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
h8300                            allmodconfig
xtensa                              defconfig
arc                                 defconfig
arc                              allyesconfig
sh                               allmodconfig
sh                                allnoconfig
microblaze                        allnoconfig
mips                             allyesconfig
mips                              allnoconfig
mips                             allmodconfig
parisc                            allnoconfig
parisc                              defconfig
parisc                           allyesconfig
parisc                           allmodconfig
powerpc                          allyesconfig
powerpc                          rhel-kconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
powerpc                             defconfig
i386                 randconfig-a016-20200715
i386                 randconfig-a011-20200715
i386                 randconfig-a015-20200715
i386                 randconfig-a012-20200715
i386                 randconfig-a013-20200715
i386                 randconfig-a014-20200715
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             allmodconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                                   rhel
x86_64                                    lkp
x86_64                              fedora-25

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
