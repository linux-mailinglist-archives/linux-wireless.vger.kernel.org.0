Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FCD41C8082
	for <lists+linux-wireless@lfdr.de>; Thu,  7 May 2020 05:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725869AbgEGDaW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 May 2020 23:30:22 -0400
Received: from mga04.intel.com ([192.55.52.120]:8102 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbgEGDaW (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 May 2020 23:30:22 -0400
IronPort-SDR: znOSPcUwQWxnbIsr1hD68dn3w18CZyqqGAFhejdjL+Q746j9N1pV8FIytZsdKTIHuaaTXUT0rF
 XCUTZ4jxKoDg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2020 20:30:22 -0700
IronPort-SDR: X3/04kop1Z8P1eCYEPSQw7si7zihHbMtlrpORD6GwihYQ3aEEe57sWF48d7ps9yKwMfWcjEn3W
 FC+tqXpZt+/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,361,1583222400"; 
   d="scan'208";a="369993268"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 06 May 2020 20:30:21 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jWXEq-0000fb-EE; Thu, 07 May 2020 11:30:20 +0800
Date:   Thu, 07 May 2020 11:30:17 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Subject: [wireless-drivers-next:master] BUILD SUCCESS
 7f65f6118a53eeb3cd9baa0ceb5519b478758cd9
Message-ID: <5eb380c9.xu93ls5losy75NT5%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git  master
branch HEAD: 7f65f6118a53eeb3cd9baa0ceb5519b478758cd9  Merge ath-next from git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git

elapsed time: 1093m

configs tested: 143
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

arm64                            allyesconfig
arm                              allyesconfig
arm64                            allmodconfig
arm                              allmodconfig
arm64                             allnoconfig
arm                               allnoconfig
sparc                            allyesconfig
m68k                             allyesconfig
ia64                             allyesconfig
m68k                             allmodconfig
mips                             allyesconfig
ia64                              allnoconfig
um                               allyesconfig
nds32                               defconfig
ia64                             allmodconfig
c6x                               allnoconfig
parisc                           allyesconfig
alpha                               defconfig
alpha                            allyesconfig
powerpc                           allnoconfig
powerpc                             defconfig
s390                             alldefconfig
csky                                defconfig
ia64                             alldefconfig
um                             i386_defconfig
um                                  defconfig
sparc64                          allmodconfig
microblaze                        allnoconfig
i386                                defconfig
s390                                defconfig
s390                             allyesconfig
i386                              allnoconfig
i386                             allyesconfig
i386                             alldefconfig
i386                              debian-10.3
ia64                                defconfig
m68k                           sun3_defconfig
m68k                          multi_defconfig
m68k                                defconfig
nios2                               defconfig
nios2                            allyesconfig
openrisc                            defconfig
c6x                              allyesconfig
openrisc                         allyesconfig
nds32                             allnoconfig
csky                             allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
h8300                            allmodconfig
xtensa                              defconfig
arc                                 defconfig
arc                              allyesconfig
microblaze                       allyesconfig
sh                               allmodconfig
sh                                allnoconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                           32r2_defconfig
mips                             allmodconfig
parisc                            allnoconfig
parisc                           allmodconfig
powerpc                          allyesconfig
powerpc                          alldefconfig
powerpc                          rhel-kconfig
powerpc                          allmodconfig
m68k                 randconfig-a001-20200506
mips                 randconfig-a001-20200506
nds32                randconfig-a001-20200506
parisc               randconfig-a001-20200506
alpha                randconfig-a001-20200506
riscv                randconfig-a001-20200506
h8300                randconfig-a001-20200506
nios2                randconfig-a001-20200506
microblaze           randconfig-a001-20200506
c6x                  randconfig-a001-20200506
sparc64              randconfig-a001-20200506
s390                 randconfig-a001-20200506
xtensa               randconfig-a001-20200506
sh                   randconfig-a001-20200506
openrisc             randconfig-a001-20200506
csky                 randconfig-a001-20200506
xtensa               randconfig-a001-20200507
sh                   randconfig-a001-20200507
openrisc             randconfig-a001-20200507
csky                 randconfig-a001-20200507
i386                 randconfig-b003-20200506
i386                 randconfig-b001-20200506
x86_64               randconfig-b001-20200506
x86_64               randconfig-b003-20200506
i386                 randconfig-b002-20200506
i386                 randconfig-e003-20200506
x86_64               randconfig-e003-20200506
x86_64               randconfig-e001-20200506
i386                 randconfig-e002-20200506
i386                 randconfig-e001-20200506
x86_64               randconfig-a003-20200506
x86_64               randconfig-a001-20200506
x86_64               randconfig-a002-20200506
i386                 randconfig-a001-20200506
i386                 randconfig-a002-20200506
i386                 randconfig-a003-20200506
i386                 randconfig-f003-20200506
x86_64               randconfig-f001-20200506
x86_64               randconfig-f003-20200506
x86_64               randconfig-f002-20200506
i386                 randconfig-f001-20200506
i386                 randconfig-f002-20200506
x86_64               randconfig-g003-20200506
i386                 randconfig-g003-20200506
i386                 randconfig-g002-20200506
x86_64               randconfig-g001-20200506
i386                 randconfig-g001-20200506
x86_64               randconfig-g002-20200506
i386                 randconfig-h002-20200506
i386                 randconfig-h001-20200506
i386                 randconfig-h003-20200506
x86_64               randconfig-h002-20200506
x86_64               randconfig-h003-20200506
x86_64               randconfig-h001-20200506
arm64                randconfig-a001-20200506
arc                  randconfig-a001-20200506
powerpc              randconfig-a001-20200506
arm                  randconfig-a001-20200506
sparc                randconfig-a001-20200506
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
s390                              allnoconfig
s390                             allmodconfig
sparc                               defconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
um                               allmodconfig
um                           x86_64_defconfig
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
