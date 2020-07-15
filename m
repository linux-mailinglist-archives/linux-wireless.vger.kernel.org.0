Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E81D32202D6
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2020 05:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgGODQa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Jul 2020 23:16:30 -0400
Received: from mga11.intel.com ([192.55.52.93]:51847 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726624AbgGODQa (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Jul 2020 23:16:30 -0400
IronPort-SDR: jLtrKhpbAsQ3V6SUdUOkVUfsdxSiZfCOVVqxMFtEqZCeOlB0rjckL2kIH9YW0x7vUazlGJj2AU
 S9nhA0BTAx1Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9682"; a="147080791"
X-IronPort-AV: E=Sophos;i="5.75,353,1589266800"; 
   d="scan'208";a="147080791"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2020 20:16:29 -0700
IronPort-SDR: SbmZ06TrAx4ad/Lej0sFvNC0aLt21m1dsrDKmdsSFkA0WaVfG5ly+C1nNnIt+ujT04NNAwz8UD
 s15ekUAxIgZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,353,1589266800"; 
   d="scan'208";a="299745253"
Received: from lkp-server01.sh.intel.com (HELO e1edd1aee32c) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 14 Jul 2020 20:16:27 -0700
Received: from kbuild by e1edd1aee32c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jvXuF-000020-2j; Wed, 15 Jul 2020 03:16:27 +0000
Date:   Wed, 15 Jul 2020 11:16:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Subject: [wireless-drivers-next:master] BUILD SUCCESS
 b424808115cb0141da851082d84ede20caa2215c
Message-ID: <5f0e7503.SCXBNXrdFmUoFRvx%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git  master
branch HEAD: b424808115cb0141da851082d84ede20caa2215c  brcm80211: brcmsmac: Move LEDs to GPIO descriptors

elapsed time: 725m

configs tested: 104
configs skipped: 10

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
sh                           se7724_defconfig
sh                          sdk7786_defconfig
arm                          tango4_defconfig
sh                            migor_defconfig
sh                           se7206_defconfig
mips                malta_qemu_32r6_defconfig
sparc64                             defconfig
mips                      pistachio_defconfig
i386                             allyesconfig
arm                         s3c6400_defconfig
m68k                         amcore_defconfig
c6x                               allnoconfig
xtensa                generic_kc705_defconfig
mips                           ip27_defconfig
mips                  mips_paravirt_defconfig
c6x                        evmc6474_defconfig
powerpc                      pasemi_defconfig
sh                        dreamcast_defconfig
openrisc                         alldefconfig
m68k                        m5407c3_defconfig
arm                          ep93xx_defconfig
arm                          moxart_defconfig
sparc                               defconfig
mips                        maltaup_defconfig
mips                          rb532_defconfig
powerpc                mpc7448_hpc2_defconfig
mips                        nlm_xlp_defconfig
sh                 kfr2r09-romimage_defconfig
openrisc                            defconfig
xtensa                          iss_defconfig
arm                  colibri_pxa270_defconfig
ia64                      gensparse_defconfig
mips                      fuloong2e_defconfig
sh                          r7780mp_defconfig
ia64                                defconfig
powerpc                      ppc6xx_defconfig
i386                              allnoconfig
i386                                defconfig
i386                              debian-10.3
ia64                             allmodconfig
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
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             allmodconfig
s390                                defconfig
sparc                            allyesconfig
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
