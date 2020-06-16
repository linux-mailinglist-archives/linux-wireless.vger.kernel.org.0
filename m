Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FEE81FA5A9
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jun 2020 03:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbgFPBcU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 Jun 2020 21:32:20 -0400
Received: from mga18.intel.com ([134.134.136.126]:59233 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbgFPBcU (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 Jun 2020 21:32:20 -0400
IronPort-SDR: M5Fv967aN6MIyabDUsB+izy6g5O/dHDByv9t+9oqhgj1cLADFJCyUmVKGWnBR0POnX1pSuOV21
 sAbUG0KITg0Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2020 18:32:03 -0700
IronPort-SDR: tjMFBE9L3O2EeVxZg9aDYscTVE8FxaK3ioYVYUe1S+WThyjs/dQKiFkzJKI7nFeYLvWtr8i1me
 HhtXp55iQuFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,517,1583222400"; 
   d="scan'208";a="449615011"
Received: from lkp-server02.sh.intel.com (HELO ec7aa6149bd9) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 15 Jun 2020 18:31:51 -0700
Received: from kbuild by ec7aa6149bd9 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jl0S6-0000Jo-Sw; Tue, 16 Jun 2020 01:31:50 +0000
Date:   Tue, 16 Jun 2020 09:31:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Subject: [wireless-drivers-next:master] BUILD SUCCESS
 a15a20acc980342c97d804c5fae1cfc0cd7712a9
Message-ID: <5ee820f7.fP2w+bklgjkqamME%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git  master
branch HEAD: a15a20acc980342c97d804c5fae1cfc0cd7712a9  Merge tag 'iwlwifi-next-for-kalle-2020-06-11' of git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next

elapsed time: 485m

configs tested: 106
configs skipped: 2

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
arm                         axm55xx_defconfig
mips                         bigsur_defconfig
mips                      bmips_stb_defconfig
c6x                              allyesconfig
sh                            migor_defconfig
arm                             pxa_defconfig
um                           x86_64_defconfig
mips                      pic32mzda_defconfig
arm                       versatile_defconfig
ia64                      gensparse_defconfig
mips                           ip28_defconfig
mips                           ip27_defconfig
c6x                        evmc6678_defconfig
arm                       netwinder_defconfig
sh                           se7721_defconfig
i386                             allyesconfig
i386                                defconfig
i386                              debian-10.3
i386                              allnoconfig
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
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          rhel-kconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a006-20200615
i386                 randconfig-a002-20200615
i386                 randconfig-a001-20200615
i386                 randconfig-a004-20200615
i386                 randconfig-a005-20200615
i386                 randconfig-a003-20200615
i386                 randconfig-a015-20200615
i386                 randconfig-a011-20200615
i386                 randconfig-a014-20200615
i386                 randconfig-a013-20200615
i386                 randconfig-a016-20200615
i386                 randconfig-a012-20200615
riscv                            allyesconfig
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
um                               allmodconfig
um                                allnoconfig
um                                  defconfig
um                               allyesconfig
x86_64                               rhel-7.6
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                                   rhel
x86_64                         rhel-7.2-clear
x86_64                                    lkp
x86_64                              fedora-25

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
