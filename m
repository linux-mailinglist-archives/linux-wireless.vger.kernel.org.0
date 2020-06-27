Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16F6F20BD98
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jun 2020 03:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgF0BeZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Jun 2020 21:34:25 -0400
Received: from mga05.intel.com ([192.55.52.43]:9164 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725997AbgF0BeZ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Jun 2020 21:34:25 -0400
IronPort-SDR: j0LjsicKunfOIzXUNG+3ENrTL1eDkf11+LMNV+GVpUsbDo5lgzW4F+80pFcWZNUbe8GLaj+03p
 UQIKFDDT2tnw==
X-IronPort-AV: E=McAfee;i="6000,8403,9664"; a="230321405"
X-IronPort-AV: E=Sophos;i="5.75,285,1589266800"; 
   d="scan'208";a="230321405"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2020 18:34:24 -0700
IronPort-SDR: Waw2STFgqLcA1dji5JdjxwJUGTxtHhdMQ6UYaruEhEKh88dSA2e6PN/za7T4z492ly+50s8urf
 tEk7Ixq4ReCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,285,1589266800"; 
   d="scan'208";a="302492336"
Received: from lkp-server01.sh.intel.com (HELO 538b5e3c8319) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 26 Jun 2020 18:34:23 -0700
Received: from kbuild by 538b5e3c8319 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jozjb-0002XS-1i; Sat, 27 Jun 2020 01:34:23 +0000
Date:   Sat, 27 Jun 2020 09:34:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org
Subject: [mac80211:master] BUILD SUCCESS
 60a0121f8fa64b0f4297aa6fef8207500483a874
Message-ID: <5ef6a214.7mRLD9m0u8LFZkFt%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211.git  master
branch HEAD: 60a0121f8fa64b0f4297aa6fef8207500483a874  nl80211: fix memory leak when parsing NL80211_ATTR_HE_BSS_COLOR

elapsed time: 721m

configs tested: 97
configs skipped: 4

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
arc                     haps_hs_smp_defconfig
powerpc                          g5_defconfig
mips                        jmr3927_defconfig
sh                           se7751_defconfig
arm                       imx_v6_v7_defconfig
arm                            xcep_defconfig
arm                      pxa255-idp_defconfig
arm                          tango4_defconfig
h8300                            allyesconfig
arc                                 defconfig
m68k                          atari_defconfig
arm                        mini2440_defconfig
arm                          pxa168_defconfig
arm                            lart_defconfig
arm                             pxa_defconfig
arm                         lpc18xx_defconfig
mips                           ip27_defconfig
arm                     eseries_pxa_defconfig
mips                      loongson3_defconfig
parisc                            allnoconfig
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
h8300                            allmodconfig
xtensa                              defconfig
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
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          rhel-kconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
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
