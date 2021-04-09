Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 282A9359303
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Apr 2021 05:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232937AbhDID3D (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Apr 2021 23:29:03 -0400
Received: from mga17.intel.com ([192.55.52.151]:37829 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232918AbhDID3C (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Apr 2021 23:29:02 -0400
IronPort-SDR: CkHU13yqgtku0QZJ76j3/Dzhm8hCvM2Uc++D2rDoWAXK6r+BtrbYKuHR29SWEdGbQP5+TIIuzv
 ExtjrYPX7zKg==
X-IronPort-AV: E=McAfee;i="6000,8403,9948"; a="173765012"
X-IronPort-AV: E=Sophos;i="5.82,208,1613462400"; 
   d="scan'208";a="173765012"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2021 20:28:47 -0700
IronPort-SDR: uNJXPwp5mbGVFXXXJBbAySevuNtyCSXXxco8Bt7eZAfucytgkn9aSu1mtsnUTclEXQyzRwb8Zb
 1c4Ni3eOqtUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,208,1613462400"; 
   d="scan'208";a="397336957"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 08 Apr 2021 20:28:45 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lUhp6-000G9j-Ag; Fri, 09 Apr 2021 03:28:44 +0000
Date:   Fri, 09 Apr 2021 11:27:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org
Subject: [mac80211:master] BUILD SUCCESS
 9a6847ba1747858ccac53c5aba3e25c54fbdf846
Message-ID: <606fc9be.SBU62KDNZhPYL5yc%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211.git master
branch HEAD: 9a6847ba1747858ccac53c5aba3e25c54fbdf846  nl80211: fix beacon head validation

elapsed time: 726m

configs tested: 172
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
x86_64                           allyesconfig
riscv                            allmodconfig
i386                             allyesconfig
riscv                            allyesconfig
mips                         rt305x_defconfig
um                                allnoconfig
sh                          urquell_defconfig
sh                            titan_defconfig
arm                             ezx_defconfig
arm                        oxnas_v6_defconfig
powerpc                     akebono_defconfig
arm                     eseries_pxa_defconfig
arm                            pleb_defconfig
m68k                         amcore_defconfig
sparc                       sparc32_defconfig
powerpc                     ppa8548_defconfig
powerpc                      mgcoge_defconfig
powerpc                 linkstation_defconfig
sh                            migor_defconfig
mips                       lemote2f_defconfig
m68k                        m5407c3_defconfig
arm                            lart_defconfig
arm                           spitz_defconfig
arm                         palmz72_defconfig
arm                         lpc32xx_defconfig
ia64                             alldefconfig
powerpc                 mpc832x_mds_defconfig
powerpc                      ppc6xx_defconfig
sh                   sh7770_generic_defconfig
sh                           sh2007_defconfig
xtensa                  cadence_csp_defconfig
arm                        clps711x_defconfig
xtensa                    xip_kc705_defconfig
m68k                       bvme6000_defconfig
h8300                            alldefconfig
arc                     nsimosci_hs_defconfig
powerpc                 mpc836x_rdk_defconfig
powerpc                  storcenter_defconfig
arm                         s5pv210_defconfig
ia64                         bigsur_defconfig
arm                         orion5x_defconfig
m68k                        stmark2_defconfig
mips                     loongson1b_defconfig
arm                        multi_v5_defconfig
mips                  decstation_64_defconfig
powerpc                      ppc64e_defconfig
mips                          rb532_defconfig
powerpc                     kmeter1_defconfig
powerpc                 mpc834x_mds_defconfig
sh                          landisk_defconfig
powerpc                      arches_defconfig
riscv                               defconfig
parisc                           allyesconfig
m68k                          hp300_defconfig
s390                          debug_defconfig
sh                 kfr2r09-romimage_defconfig
arm                             mxs_defconfig
mips                          malta_defconfig
arm                           u8500_defconfig
um                           x86_64_defconfig
arc                    vdk_hs38_smp_defconfig
arm                          ixp4xx_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                           se7722_defconfig
mips                  maltasmvp_eva_defconfig
sh                             shx3_defconfig
sh                   rts7751r2dplus_defconfig
arm                          pxa3xx_defconfig
powerpc                           allnoconfig
arm                            zeus_defconfig
arm                      footbridge_defconfig
powerpc                        warp_defconfig
mips                           ip22_defconfig
m68k                          multi_defconfig
sh                          lboxre2_defconfig
arm64                            alldefconfig
arc                        vdk_hs38_defconfig
sh                           se7751_defconfig
mips                      pic32mzda_defconfig
arm                   milbeaut_m10v_defconfig
arm                           h5000_defconfig
powerpc                     mpc5200_defconfig
powerpc                      ep88xc_defconfig
m68k                          amiga_defconfig
arm                  colibri_pxa270_defconfig
arm                            xcep_defconfig
ia64                            zx1_defconfig
sh                          r7780mp_defconfig
mips                    maltaup_xpa_defconfig
powerpc                     mpc83xx_defconfig
arm                            dove_defconfig
powerpc                 mpc85xx_cds_defconfig
arm                         shannon_defconfig
powerpc                 xes_mpc85xx_defconfig
arm                         at91_dt_defconfig
alpha                            allyesconfig
arm                        realview_defconfig
x86_64                           alldefconfig
arm                        mvebu_v7_defconfig
arm                          collie_defconfig
powerpc                         ps3_defconfig
arm                          gemini_defconfig
arm                          iop32x_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
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
s390                             allmodconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64               randconfig-a005-20210408
x86_64               randconfig-a003-20210408
x86_64               randconfig-a001-20210408
x86_64               randconfig-a004-20210408
x86_64               randconfig-a002-20210408
x86_64               randconfig-a006-20210408
i386                 randconfig-a006-20210408
i386                 randconfig-a003-20210408
i386                 randconfig-a001-20210408
i386                 randconfig-a004-20210408
i386                 randconfig-a005-20210408
i386                 randconfig-a002-20210408
i386                 randconfig-a014-20210408
i386                 randconfig-a016-20210408
i386                 randconfig-a011-20210408
i386                 randconfig-a012-20210408
i386                 randconfig-a013-20210408
i386                 randconfig-a015-20210408
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
um                               allmodconfig
um                               allyesconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a014-20210408
x86_64               randconfig-a015-20210408
x86_64               randconfig-a012-20210408
x86_64               randconfig-a011-20210408
x86_64               randconfig-a013-20210408
x86_64               randconfig-a016-20210408

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
