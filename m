Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2644025A107
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Sep 2020 23:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728563AbgIAVxo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Sep 2020 17:53:44 -0400
Received: from mga04.intel.com ([192.55.52.120]:55453 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728254AbgIAVxn (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Sep 2020 17:53:43 -0400
IronPort-SDR: 7Am80JUFjNHS28mN7EXb67bjFhPqJya6b34/Be905Di5f7HYo1nf/9xlz3BuO1JCgu74Jeos8x
 glZTDXctWSMA==
X-IronPort-AV: E=McAfee;i="6000,8403,9731"; a="154679439"
X-IronPort-AV: E=Sophos;i="5.76,380,1592895600"; 
   d="scan'208";a="154679439"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2020 14:53:40 -0700
IronPort-SDR: zcZH6FXzMTEjO0mjPe99jGyiyau85v/s1KVbQ/4UwaMvmTz9S3OmkYeRlvI4gEF8396tYr1f5Y
 7lIK7kDbRMVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,380,1592895600"; 
   d="scan'208";a="314888197"
Received: from lkp-server02.sh.intel.com (HELO f796b30506bf) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 01 Sep 2020 14:53:39 -0700
Received: from kbuild by f796b30506bf with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kDEDi-00007T-CZ; Tue, 01 Sep 2020 21:53:38 +0000
Date:   Wed, 02 Sep 2020 05:52:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Subject: [wireless-drivers-next:pending] BUILD SUCCESS WITH WARNING
 391ddee90739538e99cb73bd26d7a90452d37f30
Message-ID: <5f4ec2b5.suKoQfIRp7FcCViA%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git  pending
branch HEAD: 391ddee90739538e99cb73bd26d7a90452d37f30  rtlwifi: Remove temporary definition of RT_TRACE

Warning in current branch:

drivers/net/wireless/broadcom/brcm80211/brcmsmac/ampdu.c:1027:20: warning: variable 'scb_ampdu' set but not used [-Wunused-but-set-variable]

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allmodconfig
|   `-- drivers-net-wireless-broadcom-brcm80211-brcmsmac-ampdu.c:warning:variable-scb_ampdu-set-but-not-used
|-- alpha-allyesconfig
|   `-- drivers-net-wireless-broadcom-brcm80211-brcmsmac-ampdu.c:warning:variable-scb_ampdu-set-but-not-used
|-- arc-allyesconfig
|   `-- drivers-net-wireless-broadcom-brcm80211-brcmsmac-ampdu.c:warning:variable-scb_ampdu-set-but-not-used
|-- arm-allmodconfig
|   `-- drivers-net-wireless-broadcom-brcm80211-brcmsmac-ampdu.c:warning:variable-scb_ampdu-set-but-not-used
|-- arm-allyesconfig
|   `-- drivers-net-wireless-broadcom-brcm80211-brcmsmac-ampdu.c:warning:variable-scb_ampdu-set-but-not-used
|-- arm64-allmodconfig
|   `-- drivers-net-wireless-broadcom-brcm80211-brcmsmac-ampdu.c:warning:variable-scb_ampdu-set-but-not-used
|-- arm64-allyesconfig
|   `-- drivers-net-wireless-broadcom-brcm80211-brcmsmac-ampdu.c:warning:variable-scb_ampdu-set-but-not-used
|-- c6x-allyesconfig
|   `-- drivers-net-wireless-broadcom-brcm80211-brcmsmac-ampdu.c:warning:variable-scb_ampdu-set-but-not-used
|-- c6x-randconfig-r035-20200901
|   `-- drivers-net-wireless-broadcom-brcm80211-brcmsmac-ampdu.c:warning:variable-scb_ampdu-set-but-not-used
|-- h8300-allyesconfig
|   `-- drivers-net-wireless-broadcom-brcm80211-brcmsmac-ampdu.c:warning:variable-scb_ampdu-set-but-not-used
|-- i386-allyesconfig
|   `-- drivers-net-wireless-broadcom-brcm80211-brcmsmac-ampdu.c:warning:variable-scb_ampdu-set-but-not-used
|-- i386-randconfig-r015-20200901
|   `-- drivers-net-wireless-broadcom-brcm80211-brcmsmac-ampdu.c:warning:variable-scb_ampdu-set-but-not-used
|-- ia64-allmodconfig
|   `-- drivers-net-wireless-broadcom-brcm80211-brcmsmac-ampdu.c:warning:variable-scb_ampdu-set-but-not-used
|-- ia64-allyesconfig
|   `-- drivers-net-wireless-broadcom-brcm80211-brcmsmac-ampdu.c:warning:variable-scb_ampdu-set-but-not-used
|-- ia64-randconfig-p001-20200901
|   `-- drivers-net-wireless-broadcom-brcm80211-brcmsmac-ampdu.c:warning:variable-scb_ampdu-set-but-not-used
|-- m68k-allmodconfig
|   `-- drivers-net-wireless-broadcom-brcm80211-brcmsmac-ampdu.c:warning:variable-scb_ampdu-set-but-not-used
|-- m68k-allyesconfig
|   `-- drivers-net-wireless-broadcom-brcm80211-brcmsmac-ampdu.c:warning:variable-scb_ampdu-set-but-not-used
|-- mips-allmodconfig
|   `-- drivers-net-wireless-broadcom-brcm80211-brcmsmac-ampdu.c:warning:variable-scb_ampdu-set-but-not-used
|-- mips-allyesconfig
|   `-- drivers-net-wireless-broadcom-brcm80211-brcmsmac-ampdu.c:warning:variable-scb_ampdu-set-but-not-used
|-- nds32-allyesconfig
|   `-- drivers-net-wireless-broadcom-brcm80211-brcmsmac-ampdu.c:warning:variable-scb_ampdu-set-but-not-used
|-- nios2-allmodconfig
|   `-- drivers-net-wireless-broadcom-brcm80211-brcmsmac-ampdu.c:warning:variable-scb_ampdu-set-but-not-used
|-- nios2-allyesconfig
|   `-- drivers-net-wireless-broadcom-brcm80211-brcmsmac-ampdu.c:warning:variable-scb_ampdu-set-but-not-used
|-- nios2-randconfig-r016-20200901
|   `-- drivers-net-wireless-broadcom-brcm80211-brcmsmac-ampdu.c:warning:variable-scb_ampdu-set-but-not-used
|-- openrisc-allmodconfig
|   `-- drivers-net-wireless-broadcom-brcm80211-brcmsmac-ampdu.c:warning:variable-scb_ampdu-set-but-not-used
|-- parisc-allyesconfig
|   `-- drivers-net-wireless-broadcom-brcm80211-brcmsmac-ampdu.c:warning:variable-scb_ampdu-set-but-not-used
|-- powerpc-allmodconfig
|   `-- drivers-net-wireless-broadcom-brcm80211-brcmsmac-ampdu.c:warning:variable-scb_ampdu-set-but-not-used
|-- powerpc-allyesconfig
|   `-- drivers-net-wireless-broadcom-brcm80211-brcmsmac-ampdu.c:warning:variable-scb_ampdu-set-but-not-used
|-- powerpc64-allmodconfig
|   `-- drivers-net-wireless-broadcom-brcm80211-brcmsmac-ampdu.c:warning:variable-scb_ampdu-set-but-not-used
|-- riscv-allmodconfig
|   `-- drivers-net-wireless-broadcom-brcm80211-brcmsmac-ampdu.c:warning:variable-scb_ampdu-set-but-not-used
|-- riscv-allyesconfig
|   `-- drivers-net-wireless-broadcom-brcm80211-brcmsmac-ampdu.c:warning:variable-scb_ampdu-set-but-not-used
|-- sparc-allyesconfig
|   `-- drivers-net-wireless-broadcom-brcm80211-brcmsmac-ampdu.c:warning:variable-scb_ampdu-set-but-not-used
|-- x86_64-allyesconfig
|   `-- drivers-net-wireless-broadcom-brcm80211-brcmsmac-ampdu.c:warning:variable-scb_ampdu-set-but-not-used
|-- xtensa-allyesconfig
|   `-- drivers-net-wireless-broadcom-brcm80211-brcmsmac-ampdu.c:warning:variable-scb_ampdu-set-but-not-used
`-- xtensa-randconfig-p002-20200901
    `-- drivers-net-wireless-broadcom-brcm80211-brcmsmac-ampdu.c:warning:variable-scb_ampdu-set-but-not-used

elapsed time: 726m

configs tested: 128
configs skipped: 13

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
nds32                            alldefconfig
arm                       omap2plus_defconfig
m68k                        mvme16x_defconfig
arm                             mxs_defconfig
sh                ecovec24-romimage_defconfig
mips                        nlm_xlp_defconfig
mips                           ip28_defconfig
sparc64                             defconfig
sparc                       sparc32_defconfig
powerpc                          allmodconfig
sh                           se7750_defconfig
nios2                         3c120_defconfig
ia64                      gensparse_defconfig
mips                 decstation_r4k_defconfig
s390                       zfcpdump_defconfig
arm                             pxa_defconfig
arm                          gemini_defconfig
microblaze                    nommu_defconfig
powerpc                     pq2fads_defconfig
i386                                defconfig
mips                      loongson3_defconfig
mips                  maltasmvp_eva_defconfig
mips                      bmips_stb_defconfig
mips                        maltaup_defconfig
arm                        vexpress_defconfig
m68k                        m5407c3_defconfig
mips                         db1xxx_defconfig
arm                          ixp4xx_defconfig
sh                              ul2_defconfig
sh                         ecovec24_defconfig
s390                          debug_defconfig
mips                         tb0219_defconfig
sh                     sh7710voipgw_defconfig
powerpc                      chrp32_defconfig
arm                         socfpga_defconfig
um                             i386_defconfig
arm                         s5pv210_defconfig
arm                         mv78xx0_defconfig
powerpc                     skiroot_defconfig
powerpc                  mpc866_ads_defconfig
arm                         lubbock_defconfig
arm                            lart_defconfig
sh                         microdev_defconfig
sh                            titan_defconfig
arm                        mvebu_v7_defconfig
mips                         bigsur_defconfig
nios2                         10m50_defconfig
x86_64                           alldefconfig
mips                           rs90_defconfig
um                            kunit_defconfig
m68k                         amcore_defconfig
powerpc                     mpc83xx_defconfig
ia64                             allyesconfig
riscv                    nommu_virt_defconfig
arm                          exynos_defconfig
arm                        neponset_defconfig
m68k                        stmark2_defconfig
mips                          rm200_defconfig
arm                          prima2_defconfig
ia64                             allmodconfig
ia64                                defconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
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
mips                             allyesconfig
mips                             allmodconfig
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20200901
x86_64               randconfig-a006-20200901
x86_64               randconfig-a003-20200901
x86_64               randconfig-a005-20200901
x86_64               randconfig-a001-20200901
x86_64               randconfig-a002-20200901
i386                 randconfig-a004-20200901
i386                 randconfig-a005-20200901
i386                 randconfig-a006-20200901
i386                 randconfig-a002-20200901
i386                 randconfig-a001-20200901
i386                 randconfig-a003-20200901
i386                 randconfig-a016-20200901
i386                 randconfig-a015-20200901
i386                 randconfig-a011-20200901
i386                 randconfig-a013-20200901
i386                 randconfig-a014-20200901
i386                 randconfig-a012-20200901
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

clang tested configs:
x86_64               randconfig-a013-20200901
x86_64               randconfig-a016-20200901
x86_64               randconfig-a011-20200901
x86_64               randconfig-a012-20200901
x86_64               randconfig-a015-20200901
x86_64               randconfig-a014-20200901

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
