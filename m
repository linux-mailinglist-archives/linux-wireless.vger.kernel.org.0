Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B25025A2A3
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Sep 2020 03:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbgIBB3O (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Sep 2020 21:29:14 -0400
Received: from mga07.intel.com ([134.134.136.100]:43084 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726122AbgIBB3N (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Sep 2020 21:29:13 -0400
IronPort-SDR: NZ9mt65f2w2aOH1OzzHtl7+8+Eg7+GV/j2cXq4pTzy9E+SYz1qzgaXXXmkZ0wUu8KaV6ygc24o
 EzbbWiaGX5Kg==
X-IronPort-AV: E=McAfee;i="6000,8403,9731"; a="221518531"
X-IronPort-AV: E=Sophos;i="5.76,381,1592895600"; 
   d="scan'208";a="221518531"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2020 18:29:12 -0700
IronPort-SDR: n6Li/fGfhiiu6o2jNLQJdsXla3p3qhg5lq5VvRHpohEXAMlzpgB/IddMWAniYQx8Viw08pgqpL
 WCPn6ZtPZbGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,381,1592895600"; 
   d="scan'208";a="446345596"
Received: from lkp-server02.sh.intel.com (HELO f796b30506bf) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 01 Sep 2020 18:29:11 -0700
Received: from kbuild by f796b30506bf with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kDHaI-0000Bg-OH; Wed, 02 Sep 2020 01:29:10 +0000
Date:   Wed, 02 Sep 2020 09:28:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Subject: [wireless-drivers-next:master] BUILD SUCCESS WITH WARNING
 2c92790b12033797474b9ba1b2e56a95360f66cd
Message-ID: <5f4ef52b.YVDwtbgr7fKkgZSW%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git  master
branch HEAD: 2c92790b12033797474b9ba1b2e56a95360f66cd  libertas_tf: Remove unused macro QOS_CONTROL_LEN

Warning in current branch:

drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c:361:25: warning: unused variable 'lcnphy_rx_iqcomp_table_rev0' [-Wunused-const-variable]
drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phytbl_lcn.c:108:18: warning: unused variable 'dot11lcn_gain_tbl_rev1' [-Wunused-const-variable]

Warning ids grouped by kconfigs:

clang_recent_errors
`-- arm64-randconfig-r012-20200901
    |-- drivers-net-wireless-broadcom-brcm80211-brcmsmac-phy-phy_lcn.c:warning:unused-variable-lcnphy_rx_iqcomp_table_rev0
    `-- drivers-net-wireless-broadcom-brcm80211-brcmsmac-phy-phytbl_lcn.c:warning:unused-variable-dot11lcn_gain_tbl_rev1

elapsed time: 725m

configs tested: 137
configs skipped: 11

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                      bmips_stb_defconfig
sh                             espt_defconfig
mips                           rs90_defconfig
c6x                        evmc6474_defconfig
powerpc                           allnoconfig
arm                         shannon_defconfig
arm                     eseries_pxa_defconfig
arm                      footbridge_defconfig
riscv                             allnoconfig
sh                            migor_defconfig
mips                           ip28_defconfig
mips                           mtx1_defconfig
s390                       zfcpdump_defconfig
arm                             pxa_defconfig
arm                          gemini_defconfig
microblaze                    nommu_defconfig
h8300                       h8s-sim_defconfig
powerpc                  storcenter_defconfig
arm                   milbeaut_m10v_defconfig
mips                            e55_defconfig
arm                        spear6xx_defconfig
sh                        apsh4ad0a_defconfig
ia64                            zx1_defconfig
powerpc                     pq2fads_defconfig
m68k                        mvme16x_defconfig
i386                                defconfig
mips                      loongson3_defconfig
arm                           efm32_defconfig
sh                          rsk7269_defconfig
ia64                                defconfig
sh                  sh7785lcr_32bit_defconfig
arm                            lart_defconfig
arm                      pxa255-idp_defconfig
arm                         mv78xx0_defconfig
arm                         s3c2410_defconfig
arm                              alldefconfig
riscv                    nommu_k210_defconfig
nios2                         3c120_defconfig
m68k                             alldefconfig
m68k                       m5475evb_defconfig
sh                ecovec24-romimage_defconfig
mips                         tb0287_defconfig
mips                     cu1000-neo_defconfig
mips                          malta_defconfig
powerpc                    gamecube_defconfig
mips                      malta_kvm_defconfig
m68k                       m5249evb_defconfig
x86_64                              defconfig
sh                          kfr2r09_defconfig
c6x                                 defconfig
arm                       aspeed_g5_defconfig
m68k                        stmark2_defconfig
nds32                            alldefconfig
mips                 pnx8335_stb225_defconfig
mips                    maltaup_xpa_defconfig
arm                            dove_defconfig
powerpc                     mpc512x_defconfig
arm                            qcom_defconfig
mips                          rm200_defconfig
arc                         haps_hs_defconfig
powerpc                      ppc64e_defconfig
arm                          ixp4xx_defconfig
mips                         cobalt_defconfig
powerpc                       maple_defconfig
arm                          simpad_defconfig
sh                          rsk7201_defconfig
arm                         nhk8815_defconfig
mips                         bigsur_defconfig
arm                        realview_defconfig
arm                        magician_defconfig
ia64                             allmodconfig
ia64                             allyesconfig
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
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                             defconfig
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
riscv                               defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
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
