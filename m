Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C014E1D6E20
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2020 01:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbgEQXyQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 17 May 2020 19:54:16 -0400
Received: from mga12.intel.com ([192.55.52.136]:28028 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726656AbgEQXyQ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 17 May 2020 19:54:16 -0400
IronPort-SDR: 8PR/29MD6C1V2yhi2KMmssz1gXqG5RiDiXWZLErq4Ame4hKcFbCP355lu5KbEEFH69YXpw3JC4
 s7yGyhCHbpXw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2020 16:54:15 -0700
IronPort-SDR: P3Y5iPDoQRfso7UaC03ZQpdU6pg6sPHCxl35ZvMgvWU6wr1RUljZLSOe6QumGNLe6D3rKQM8nR
 nJ1gltpVu7hA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,405,1583222400"; 
   d="scan'208";a="252909743"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 17 May 2020 16:54:14 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jaT6k-0001KG-71; Mon, 18 May 2020 07:54:14 +0800
Date:   Mon, 18 May 2020 07:53:36 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Subject: [wireless-drivers-next:pending] BUILD SUCCESS
 56584a11973d1cb0f7e582e61ecd3fa84affe69d
Message-ID: <5ec1ce80.bL8FxMu4e7jwb0iW%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git  pending
branch HEAD: 56584a11973d1cb0f7e582e61ecd3fa84affe69d  mt76: mt7915: fix sparse warnings: incorrect type initializer

elapsed time: 484m

configs tested: 123
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                               allnoconfig
arm64                            allyesconfig
arm64                               defconfig
arm64                            allmodconfig
arm64                             allnoconfig
sparc                            allyesconfig
mips                             allyesconfig
m68k                             allyesconfig
mips                  cavium_octeon_defconfig
microblaze                          defconfig
powerpc64                        alldefconfig
arm                      integrator_defconfig
arc                     nsimosci_hs_defconfig
s390                                defconfig
parisc                           alldefconfig
powerpc64                           defconfig
arm                        vexpress_defconfig
sh                         ecovec24_defconfig
um                            kunit_defconfig
arm                  colibri_pxa300_defconfig
arm                        clps711x_defconfig
mips                  maltasmvp_eva_defconfig
arm                        magician_defconfig
sh                                allnoconfig
mips                          malta_defconfig
arm                         assabet_defconfig
arm                          exynos_defconfig
m68k                                defconfig
sparc64                             defconfig
arm                       multi_v4t_defconfig
sh                        dreamcast_defconfig
powerpc                     skiroot_defconfig
powerpc                    amigaone_defconfig
mips                           mtx1_defconfig
parisc                generic-64bit_defconfig
c6x                         dsk6455_defconfig
sh                           sh2007_defconfig
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
x86_64               randconfig-a005-20200517
x86_64               randconfig-a003-20200517
x86_64               randconfig-a006-20200517
x86_64               randconfig-a004-20200517
x86_64               randconfig-a001-20200517
x86_64               randconfig-a002-20200517
i386                 randconfig-a006-20200517
i386                 randconfig-a005-20200517
i386                 randconfig-a003-20200517
i386                 randconfig-a001-20200517
i386                 randconfig-a004-20200517
i386                 randconfig-a002-20200517
i386                 randconfig-a012-20200517
i386                 randconfig-a016-20200517
i386                 randconfig-a014-20200517
i386                 randconfig-a011-20200517
i386                 randconfig-a013-20200517
i386                 randconfig-a015-20200517
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             allmodconfig
x86_64                              defconfig
sparc                               defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
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
