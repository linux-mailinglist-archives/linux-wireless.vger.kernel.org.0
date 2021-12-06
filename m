Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55929468E30
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Dec 2021 01:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241356AbhLFAKR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 5 Dec 2021 19:10:17 -0500
Received: from mga04.intel.com ([192.55.52.120]:59742 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229567AbhLFAKQ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 5 Dec 2021 19:10:16 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10189"; a="235955909"
X-IronPort-AV: E=Sophos;i="5.87,290,1631602800"; 
   d="scan'208";a="235955909"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2021 16:06:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,290,1631602800"; 
   d="scan'208";a="611058348"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 05 Dec 2021 16:06:47 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mu1Wo-000Kcf-Gu; Mon, 06 Dec 2021 00:06:46 +0000
Date:   Mon, 06 Dec 2021 08:06:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org
Subject: [kvalo-wireless-drivers-next:master] BUILD SUCCESS
 fe6db7eda9306d665f7b8fc3decdb556ec10fb85
Message-ID: <61ad540f.2SeGiEQWQWcdzIU4%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git master
branch HEAD: fe6db7eda9306d665f7b8fc3decdb556ec10fb85  iwlwifi: mei: fix linking when tracing is not enabled

elapsed time: 723m

configs tested: 214
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arc                        vdk_hs38_defconfig
sh                          landisk_defconfig
arm                       imx_v6_v7_defconfig
mips                           ip32_defconfig
arm                           tegra_defconfig
mips                         tb0287_defconfig
arm                          pxa3xx_defconfig
sh                          rsk7269_defconfig
powerpc               mpc834x_itxgp_defconfig
powerpc                      ppc64e_defconfig
arm                         lubbock_defconfig
arm                            hisi_defconfig
arm                  colibri_pxa300_defconfig
arm                           spitz_defconfig
x86_64                              defconfig
arc                          axs103_defconfig
sparc                            allyesconfig
powerpc                    klondike_defconfig
arm                             rpc_defconfig
nds32                            alldefconfig
powerpc                     tqm8541_defconfig
arm                        shmobile_defconfig
h8300                    h8300h-sim_defconfig
powerpc                    amigaone_defconfig
arm                           h3600_defconfig
arm                   milbeaut_m10v_defconfig
arm                        mvebu_v7_defconfig
ia64                            zx1_defconfig
powerpc                      tqm8xx_defconfig
m68k                         amcore_defconfig
arm                        cerfcube_defconfig
xtensa                          iss_defconfig
powerpc                     kilauea_defconfig
arm                     eseries_pxa_defconfig
powerpc                 xes_mpc85xx_defconfig
m68k                       m5208evb_defconfig
powerpc                     pseries_defconfig
powerpc                     sequoia_defconfig
powerpc64                           defconfig
arm                           stm32_defconfig
arm                         palmz72_defconfig
powerpc                mpc7448_hpc2_defconfig
sh                  sh7785lcr_32bit_defconfig
powerpc                     asp8347_defconfig
mips                    maltaup_xpa_defconfig
powerpc                    gamecube_defconfig
mips                            e55_defconfig
powerpc                 linkstation_defconfig
powerpc                     akebono_defconfig
arm                            xcep_defconfig
i386                                defconfig
arm                           viper_defconfig
powerpc                  iss476-smp_defconfig
sh                           se7343_defconfig
arm                  colibri_pxa270_defconfig
powerpc                 mpc8272_ads_defconfig
powerpc                     rainier_defconfig
m68k                             allmodconfig
sh                 kfr2r09-romimage_defconfig
openrisc                  or1klitex_defconfig
sparc                            alldefconfig
arm                        oxnas_v6_defconfig
arc                 nsimosci_hs_smp_defconfig
s390                             allyesconfig
arm                          lpd270_defconfig
powerpc                 mpc836x_mds_defconfig
sh                          r7780mp_defconfig
csky                                defconfig
h8300                            alldefconfig
arm                         shannon_defconfig
nios2                            alldefconfig
arm                           sama5_defconfig
arm                            mmp2_defconfig
arm                          simpad_defconfig
powerpc                      cm5200_defconfig
sparc64                          alldefconfig
powerpc                      ppc40x_defconfig
s390                       zfcpdump_defconfig
openrisc                         alldefconfig
um                           x86_64_defconfig
sh                        sh7757lcr_defconfig
sh                           se7721_defconfig
sh                           se7206_defconfig
m68k                        mvme16x_defconfig
arc                        nsim_700_defconfig
arm                           sunxi_defconfig
arm                        multi_v5_defconfig
arm                           corgi_defconfig
powerpc                    mvme5100_defconfig
powerpc                        warp_defconfig
sh                         apsh4a3a_defconfig
m68k                          atari_defconfig
powerpc                          g5_defconfig
sh                            migor_defconfig
powerpc                     pq2fads_defconfig
nios2                         10m50_defconfig
powerpc                 mpc832x_mds_defconfig
powerpc                   currituck_defconfig
sh                          rsk7201_defconfig
sh                           se7712_defconfig
arm                          pxa910_defconfig
arm                          gemini_defconfig
m68k                         apollo_defconfig
powerpc                 mpc8313_rdb_defconfig
riscv                          rv32_defconfig
arm                  randconfig-c002-20211205
arm                  randconfig-c002-20211206
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
arc                              allyesconfig
nds32                             allnoconfig
nios2                               defconfig
nds32                               defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                               defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20211205
i386                 randconfig-a005-20211205
i386                 randconfig-a003-20211205
i386                 randconfig-a002-20211205
i386                 randconfig-a006-20211205
i386                 randconfig-a004-20211205
x86_64               randconfig-a016-20211206
x86_64               randconfig-a011-20211206
x86_64               randconfig-a013-20211206
x86_64               randconfig-a014-20211206
x86_64               randconfig-a012-20211206
x86_64               randconfig-a015-20211206
i386                 randconfig-a016-20211206
i386                 randconfig-a013-20211206
i386                 randconfig-a011-20211206
i386                 randconfig-a014-20211206
i386                 randconfig-a012-20211206
i386                 randconfig-a015-20211206
x86_64               randconfig-a001-20211205
x86_64               randconfig-a002-20211205
x86_64               randconfig-a004-20211205
x86_64               randconfig-a003-20211205
x86_64               randconfig-a006-20211205
x86_64               randconfig-a005-20211205
arc                  randconfig-r043-20211205
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-c007-20211205
arm                  randconfig-c002-20211205
riscv                randconfig-c006-20211205
mips                 randconfig-c004-20211205
i386                 randconfig-c001-20211205
powerpc              randconfig-c003-20211205
s390                 randconfig-c005-20211205
x86_64               randconfig-a006-20211206
x86_64               randconfig-a005-20211206
x86_64               randconfig-a001-20211206
x86_64               randconfig-a002-20211206
x86_64               randconfig-a004-20211206
x86_64               randconfig-a003-20211206
i386                 randconfig-a001-20211206
i386                 randconfig-a005-20211206
i386                 randconfig-a002-20211206
i386                 randconfig-a003-20211206
i386                 randconfig-a006-20211206
i386                 randconfig-a004-20211206
x86_64               randconfig-a011-20211205
x86_64               randconfig-a013-20211205
x86_64               randconfig-a015-20211205
x86_64               randconfig-a012-20211205
x86_64               randconfig-a014-20211205
x86_64               randconfig-a016-20211205
i386                 randconfig-a013-20211205
i386                 randconfig-a016-20211205
i386                 randconfig-a011-20211205
i386                 randconfig-a014-20211205
i386                 randconfig-a012-20211205
i386                 randconfig-a015-20211205
hexagon              randconfig-r045-20211205
s390                 randconfig-r044-20211205
riscv                randconfig-r042-20211205
hexagon              randconfig-r041-20211205
hexagon              randconfig-r045-20211206
hexagon              randconfig-r041-20211206

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
