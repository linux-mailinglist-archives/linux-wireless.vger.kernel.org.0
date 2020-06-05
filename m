Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 415C41F0144
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jun 2020 22:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbgFEU5I (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 5 Jun 2020 16:57:08 -0400
Received: from mga06.intel.com ([134.134.136.31]:33031 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726664AbgFEU5H (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 5 Jun 2020 16:57:07 -0400
IronPort-SDR: cC7/LitIZ25QIIWGH35DaYM6+HLw0hFUI5RNR01/HMwTA1zCcmASWcjdPwtKS7Pd0hOaC1JAZD
 eMAafahd3/sg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2020 13:57:06 -0700
IronPort-SDR: TistD1obRFn6Mkl4J2by9CQMnFk6O31QB+Fg0RsKPQf5zx97UJSf6j7MQQe1wANNy4Io/4v7ht
 pjAV/yGMWfBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,477,1583222400"; 
   d="scan'208";a="472035752"
Received: from lkp-server02.sh.intel.com (HELO 85fa322b0eb2) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 05 Jun 2020 13:57:05 -0700
Received: from kbuild by 85fa322b0eb2 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jhJOi-0000O4-Pm; Fri, 05 Jun 2020 20:57:04 +0000
Date:   Sat, 06 Jun 2020 04:57:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org
Subject: [mac80211:master] BUILD SUCCESS
 523f3ec030aa5bf4818ec8dee35b2646abf367fa
Message-ID: <5edab19d.TCVJ43MG7EzhwHyH%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211.git  master
branch HEAD: 523f3ec030aa5bf4818ec8dee35b2646abf367fa  mac80211: initialize return flags in HE 6 GHz operation parsing

elapsed time: 502m

configs tested: 127
configs skipped: 9

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
m68k                       m5249evb_defconfig
sh                            titan_defconfig
xtensa                              defconfig
powerpc                        cell_defconfig
mips                         rt305x_defconfig
sh                          rsk7264_defconfig
arc                    vdk_hs38_smp_defconfig
mips                    maltaup_xpa_defconfig
arm                          badge4_defconfig
m68k                        m5272c3_defconfig
m68k                       m5475evb_defconfig
nios2                         10m50_defconfig
mips                      malta_kvm_defconfig
m68k                        mvme147_defconfig
arm                          imote2_defconfig
powerpc                          allyesconfig
powerpc                     mpc5200_defconfig
arc                        vdk_hs38_defconfig
sh                           se7724_defconfig
powerpc                     mpc512x_defconfig
sh                  sh7785lcr_32bit_defconfig
mips                           ip28_defconfig
sparc64                             defconfig
arm                         s5pv210_defconfig
mips                           ip32_defconfig
sh                          polaris_defconfig
mips                        jmr3927_defconfig
arm                           spitz_defconfig
m68k                         apollo_defconfig
arm                        magician_defconfig
arm                        spear3xx_defconfig
mips                         tb0287_defconfig
ia64                        generic_defconfig
arc                             nps_defconfig
s390                             alldefconfig
h8300                               defconfig
i386                              allnoconfig
arm                         shannon_defconfig
mips                malta_kvm_guest_defconfig
powerpc                      mgcoge_defconfig
mips                      bmips_stb_defconfig
arm                              alldefconfig
powerpc                      pasemi_defconfig
s390                              allnoconfig
arm                         lpc32xx_defconfig
riscv                             allnoconfig
mips                          ath79_defconfig
alpha                            alldefconfig
parisc                            allnoconfig
arm                        mvebu_v5_defconfig
mips                        qi_lb60_defconfig
arm                           h3600_defconfig
sh                           se7712_defconfig
mips                      pistachio_defconfig
powerpc                      pmac32_defconfig
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
c6x                              allyesconfig
c6x                               allnoconfig
openrisc                            defconfig
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
arc                                 defconfig
arc                              allyesconfig
sh                               allmodconfig
sh                                allnoconfig
microblaze                        allnoconfig
mips                             allyesconfig
mips                              allnoconfig
mips                             allmodconfig
parisc                              defconfig
parisc                           allyesconfig
parisc                           allmodconfig
powerpc                          rhel-kconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
powerpc                             defconfig
riscv                            allyesconfig
riscv                               defconfig
riscv                            allmodconfig
s390                             allyesconfig
s390                             allmodconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
um                                allnoconfig
um                                  defconfig
um                               allmodconfig
um                               allyesconfig
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
