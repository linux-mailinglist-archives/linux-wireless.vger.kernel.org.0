Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B44A1E03B2
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2020 00:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388412AbgEXWgd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 24 May 2020 18:36:33 -0400
Received: from mga07.intel.com ([134.134.136.100]:35553 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388316AbgEXWgc (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 24 May 2020 18:36:32 -0400
IronPort-SDR: uOJDdLpx8gKXbhFxweEgQ1jL59bIMHJ+qVaPLeKJJ+MX0al+6Mm+FL4BR/dTG/Wcemzn7V0F12
 m1Pl0Twxe4cQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2020 15:36:32 -0700
IronPort-SDR: rEUBDAcfkZycTOG/2pHvLV/9nmXcHNM4eB3u72DKaDgCuIt/Pnlg7unVgciyJSfczGDrgPqfcm
 LZzNma8V9HOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,431,1583222400"; 
   d="scan'208";a="269585641"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 24 May 2020 15:36:31 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jczEM-000H2Z-IF; Mon, 25 May 2020 06:36:30 +0800
Date:   Mon, 25 May 2020 06:35:49 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Subject: [wireless-drivers-next:master] BUILD SUCCESS
 472f0a240250df443ffc4f39835e829916193ca1
Message-ID: <5ecaf6c5.X/8DDKuI8lvvOZ0Z%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git  master
branch HEAD: 472f0a240250df443ffc4f39835e829916193ca1  mt76: mt7915: Fix build error

elapsed time: 3408m

configs tested: 104
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

arm64                            allyesconfig
arm64                               defconfig
arm64                            allmodconfig
arm64                             allnoconfig
arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                               allnoconfig
sparc                            allyesconfig
m68k                             allyesconfig
mips                             allyesconfig
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
mips                              allnoconfig
mips                             allmodconfig
parisc                            allnoconfig
parisc                              defconfig
parisc                           allyesconfig
parisc                           allmodconfig
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          rhel-kconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20200524
i386                 randconfig-a004-20200524
i386                 randconfig-a006-20200524
i386                 randconfig-a003-20200524
i386                 randconfig-a002-20200524
i386                 randconfig-a005-20200524
x86_64               randconfig-a013-20200524
x86_64               randconfig-a015-20200524
x86_64               randconfig-a016-20200524
x86_64               randconfig-a012-20200524
x86_64               randconfig-a014-20200524
x86_64               randconfig-a011-20200524
x86_64               randconfig-a015-20200522
x86_64               randconfig-a013-20200522
x86_64               randconfig-a016-20200522
x86_64               randconfig-a012-20200522
x86_64               randconfig-a014-20200522
x86_64               randconfig-a011-20200522
i386                 randconfig-a013-20200524
i386                 randconfig-a015-20200524
i386                 randconfig-a012-20200524
i386                 randconfig-a011-20200524
i386                 randconfig-a016-20200524
i386                 randconfig-a014-20200524
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             allmodconfig
s390                                defconfig
x86_64                              defconfig
sparc                               defconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
um                               allyesconfig
um                                allnoconfig
um                                  defconfig
um                               allmodconfig
x86_64                                   rhel
x86_64                               rhel-7.6
x86_64                    rhel-7.6-kselftests
x86_64                         rhel-7.2-clear
x86_64                                    lkp
x86_64                              fedora-25
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
