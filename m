Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE5501FD912
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2020 00:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbgFQWkx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 17 Jun 2020 18:40:53 -0400
Received: from mga11.intel.com ([192.55.52.93]:39726 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726761AbgFQWkx (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 17 Jun 2020 18:40:53 -0400
IronPort-SDR: /uY2uFR7nAgXslpA+J2c0bZLIIL+TmQyuQA4dU+zdtnVn/wSM+5ahPVn/nSP1cy1ul7mB9Yj5X
 Kn88G7xb7rQg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2020 15:40:53 -0700
IronPort-SDR: L1S6wUtNoyVsDKjLwHZFQmLONd6yLYX+lhANgkXCBAJRMQTpnX7DnsSpIdTqTdBBs65HK1N2lZ
 CMgg2qWp0Rlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,523,1583222400"; 
   d="scan'208";a="263433119"
Received: from lkp-server02.sh.intel.com (HELO cd649bb48ab3) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 17 Jun 2020 15:40:51 -0700
Received: from kbuild by cd649bb48ab3 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jlgjj-00007N-2r; Wed, 17 Jun 2020 22:40:51 +0000
Date:   Thu, 18 Jun 2020 06:40:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org
Subject: [mac80211-next:iosm] BUILD SUCCESS
 633227907f2e033bfad2cba5e662a5b690846822
Message-ID: <5eea9bca.kcH0ioy9box9krwv%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211-next.git  iosm
branch HEAD: 633227907f2e033bfad2cba5e662a5b690846822  wwan_iosm: fix up Kconfig

elapsed time: 724m

configs tested: 107
configs skipped: 3

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
arc                      axs103_smp_defconfig
sh                   secureedge5410_defconfig
powerpc                      pmac32_defconfig
openrisc                    or1ksim_defconfig
mips                           ip28_defconfig
xtensa                    xip_kc705_defconfig
m68k                        mvme16x_defconfig
arm                            mmp2_defconfig
arm                          ep93xx_defconfig
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
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          rhel-kconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a006-20200617
i386                 randconfig-a002-20200617
i386                 randconfig-a001-20200617
i386                 randconfig-a004-20200617
i386                 randconfig-a005-20200617
i386                 randconfig-a003-20200617
x86_64               randconfig-a015-20200617
x86_64               randconfig-a011-20200617
x86_64               randconfig-a016-20200617
x86_64               randconfig-a014-20200617
x86_64               randconfig-a012-20200617
x86_64               randconfig-a013-20200617
i386                 randconfig-a015-20200617
i386                 randconfig-a011-20200617
i386                 randconfig-a014-20200617
i386                 randconfig-a016-20200617
i386                 randconfig-a013-20200617
i386                 randconfig-a012-20200617
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
um                               allyesconfig
um                                  defconfig
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
