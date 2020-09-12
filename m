Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95F58267845
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Sep 2020 08:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725824AbgILGnk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 12 Sep 2020 02:43:40 -0400
Received: from mga06.intel.com ([134.134.136.31]:35323 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725814AbgILGnk (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 12 Sep 2020 02:43:40 -0400
IronPort-SDR: JZPMtZ1nNTLmTPPnGPQBaf+x9Bw+9D56DlTgDwY/QYOnmGLmQnHaESIVatP11U6DadcPEGYDA+
 ExDllGpJeenQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9741"; a="220451069"
X-IronPort-AV: E=Sophos;i="5.76,419,1592895600"; 
   d="scan'208";a="220451069"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 23:43:37 -0700
IronPort-SDR: /r5AULYZZ6ntIosuUGVdsqp06GkUXSmSeSeSilo3QI3LiaKCY3FDZ00PHb1n1tX/GQdPjtCWF/
 gf4fJKy+nhyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,419,1592895600"; 
   d="scan'208";a="305506259"
Received: from lkp-server01.sh.intel.com (HELO a75722977aa5) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 11 Sep 2020 23:43:35 -0700
Received: from kbuild by a75722977aa5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kGzG3-0000Uw-79; Sat, 12 Sep 2020 06:43:35 +0000
Date:   Sat, 12 Sep 2020 14:42:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Subject: [wireless-drivers-next:master] BUILD SUCCESS WITH WARNING
 5941d003f0a60877a956cc3cae6e3850b46fad0a
Message-ID: <5f5c6dea.3xmWL2C6tMcaE42z%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git  master
branch HEAD: 5941d003f0a60877a956cc3cae6e3850b46fad0a  Merge ath-next from git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git

Warning in current branch:

drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c:361:25: warning: unused variable 'lcnphy_rx_iqcomp_table_rev0' [-Wunused-const-variable]
drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phytbl_lcn.c:108:18: warning: unused variable 'dot11lcn_gain_tbl_rev1' [-Wunused-const-variable]

Warning ids grouped by kconfigs:

clang_recent_errors
`-- powerpc-randconfig-r015-20200909
    |-- drivers-net-wireless-broadcom-brcm80211-brcmsmac-phy-phy_lcn.c:warning:unused-variable-lcnphy_rx_iqcomp_table_rev0
    `-- drivers-net-wireless-broadcom-brcm80211-brcmsmac-phy-phytbl_lcn.c:warning:unused-variable-dot11lcn_gain_tbl_rev1

elapsed time: 720m

configs tested: 141
configs skipped: 2

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                  mpc866_ads_defconfig
powerpc                      pcm030_defconfig
arm                          gemini_defconfig
mips                      malta_kvm_defconfig
sh                            titan_defconfig
mips                           ci20_defconfig
powerpc                 mpc8540_ads_defconfig
sh                          r7780mp_defconfig
xtensa                          iss_defconfig
sh                        sh7757lcr_defconfig
mips                        nlm_xlp_defconfig
arm                            qcom_defconfig
powerpc                    amigaone_defconfig
arm                            pleb_defconfig
sparc64                             defconfig
arm                        mini2440_defconfig
xtensa                    xip_kc705_defconfig
mips                         db1xxx_defconfig
sh                        sh7763rdp_defconfig
powerpc                      ppc6xx_defconfig
sh                   sh7770_generic_defconfig
arm                           efm32_defconfig
arm                              zx_defconfig
mips                          malta_defconfig
arc                             nps_defconfig
alpha                            allyesconfig
sh                           se7750_defconfig
sh                          rsk7203_defconfig
mips                         tb0219_defconfig
mips                     decstation_defconfig
arm                        vexpress_defconfig
arm                     eseries_pxa_defconfig
arm                        mvebu_v5_defconfig
sh                           sh2007_defconfig
arm                        trizeps4_defconfig
arc                        vdk_hs38_defconfig
arc                            hsdk_defconfig
powerpc                        icon_defconfig
powerpc                      ppc44x_defconfig
powerpc                 mpc85xx_cds_defconfig
powerpc                     mpc5200_defconfig
sh                         apsh4a3a_defconfig
ia64                        generic_defconfig
mips                       rbtx49xx_defconfig
arm                         socfpga_defconfig
c6x                        evmc6472_defconfig
powerpc                      pmac32_defconfig
sh                           se7722_defconfig
powerpc                 mpc836x_rdk_defconfig
m68k                       m5249evb_defconfig
riscv                          rv32_defconfig
c6x                        evmc6474_defconfig
sh                          lboxre2_defconfig
ia64                             allmodconfig
ia64                                defconfig
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
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a004-20200911
i386                 randconfig-a006-20200911
i386                 randconfig-a001-20200911
i386                 randconfig-a003-20200911
i386                 randconfig-a002-20200911
i386                 randconfig-a005-20200911
i386                 randconfig-a004-20200912
i386                 randconfig-a006-20200912
i386                 randconfig-a003-20200912
i386                 randconfig-a001-20200912
i386                 randconfig-a002-20200912
i386                 randconfig-a005-20200912
x86_64               randconfig-a014-20200911
x86_64               randconfig-a011-20200911
x86_64               randconfig-a012-20200911
x86_64               randconfig-a016-20200911
x86_64               randconfig-a015-20200911
x86_64               randconfig-a013-20200911
x86_64               randconfig-a006-20200912
x86_64               randconfig-a004-20200912
x86_64               randconfig-a003-20200912
x86_64               randconfig-a002-20200912
x86_64               randconfig-a005-20200912
x86_64               randconfig-a001-20200912
i386                 randconfig-a015-20200911
i386                 randconfig-a014-20200911
i386                 randconfig-a011-20200911
i386                 randconfig-a013-20200911
i386                 randconfig-a016-20200911
i386                 randconfig-a012-20200911
i386                 randconfig-a015-20200912
i386                 randconfig-a014-20200912
i386                 randconfig-a011-20200912
i386                 randconfig-a013-20200912
i386                 randconfig-a016-20200912
i386                 randconfig-a012-20200912
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
x86_64               randconfig-a004-20200911
x86_64               randconfig-a006-20200911
x86_64               randconfig-a003-20200911
x86_64               randconfig-a002-20200911
x86_64               randconfig-a005-20200911
x86_64               randconfig-a001-20200911

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
