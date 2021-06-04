Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE84F39B021
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Jun 2021 04:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbhFDCEy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Jun 2021 22:04:54 -0400
Received: from mga14.intel.com ([192.55.52.115]:44081 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229576AbhFDCEx (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Jun 2021 22:04:53 -0400
IronPort-SDR: IXeNuQxtA7fB9ALzee1m/Id8pn97QIpjv3LIYGQU3NmODyDfBpM4c648rviel3x3YV6WcdVCPH
 yzJTDo7vD/Lw==
X-IronPort-AV: E=McAfee;i="6200,9189,10004"; a="204016466"
X-IronPort-AV: E=Sophos;i="5.83,246,1616482800"; 
   d="scan'208";a="204016466"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2021 19:01:38 -0700
IronPort-SDR: ZKK3ziXMedLFlW3ke9dCel+pJNVJa2NQxHVcVNWmZ9m936OEazQGDWbu2ZvVs8gIlb0Yj/Ek+1
 T8MX/aS0V2AQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,246,1616482800"; 
   d="scan'208";a="468178992"
Received: from lkp-server02.sh.intel.com (HELO 1ec8406c5392) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 03 Jun 2021 19:01:37 -0700
Received: from kbuild by 1ec8406c5392 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1loz9U-0006a4-He; Fri, 04 Jun 2021 02:01:36 +0000
Date:   Fri, 04 Jun 2021 10:00:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org
Subject: [mac80211-next:iosm] BUILD REGRESSION
 400a4588283d05861c0b8ab54c8ab195f7752e6c
Message-ID: <60b9894b.ic89T6R/OeuwlYk2%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211-next.git iosm
branch HEAD: 400a4588283d05861c0b8ab54c8ab195f7752e6c  iosm: convert to generic wwan ops

Error/Warning in current branch:

error: include/uapi/linux/wwan.h: missing "WITH Linux-syscall-note" for SPDX-License-Identifier

Error/Warning ids grouped by kconfigs:

clang_recent_errors
|-- arm-randconfig-r003-20210526
|   `-- error:include-uapi-linux-wwan.h:missing-WITH-Linux-syscall-note-for-SPDX-License-Identifier
|-- arm-randconfig-r004-20210526
|   `-- error:include-uapi-linux-wwan.h:missing-WITH-Linux-syscall-note-for-SPDX-License-Identifier
|-- arm-randconfig-r036-20210526
|   `-- error:include-uapi-linux-wwan.h:missing-WITH-Linux-syscall-note-for-SPDX-License-Identifier
|-- arm64-randconfig-r015-20210528
|   `-- error:include-uapi-linux-wwan.h:missing-WITH-Linux-syscall-note-for-SPDX-License-Identifier
|-- arm64-randconfig-r023-20210526
|   `-- error:include-uapi-linux-wwan.h:missing-WITH-Linux-syscall-note-for-SPDX-License-Identifier
|-- arm64-randconfig-r034-20210527
|   `-- error:include-uapi-linux-wwan.h:missing-WITH-Linux-syscall-note-for-SPDX-License-Identifier
|-- mips-randconfig-r001-20210526
|   `-- error:include-uapi-linux-wwan.h:missing-WITH-Linux-syscall-note-for-SPDX-License-Identifier
|-- mips-randconfig-r002-20210526
|   `-- error:include-uapi-linux-wwan.h:missing-WITH-Linux-syscall-note-for-SPDX-License-Identifier
|-- mips-randconfig-r004-20210526
|   `-- error:include-uapi-linux-wwan.h:missing-WITH-Linux-syscall-note-for-SPDX-License-Identifier
|-- mips-randconfig-r005-20210526
|   `-- error:include-uapi-linux-wwan.h:missing-WITH-Linux-syscall-note-for-SPDX-License-Identifier
|-- mips-randconfig-r013-20210527
|   `-- error:include-uapi-linux-wwan.h:missing-WITH-Linux-syscall-note-for-SPDX-License-Identifier
|-- mips-randconfig-r026-20210527
|   `-- error:include-uapi-linux-wwan.h:missing-WITH-Linux-syscall-note-for-SPDX-License-Identifier
|-- mips-randconfig-r031-20210526
|   `-- error:include-uapi-linux-wwan.h:missing-WITH-Linux-syscall-note-for-SPDX-License-Identifier
|-- powerpc-randconfig-r015-20210526
|   `-- error:include-uapi-linux-wwan.h:missing-WITH-Linux-syscall-note-for-SPDX-License-Identifier
|-- powerpc-randconfig-r021-20210526
|   `-- error:include-uapi-linux-wwan.h:missing-WITH-Linux-syscall-note-for-SPDX-License-Identifier
|-- powerpc64-randconfig-r032-20210527
|   `-- error:include-uapi-linux-wwan.h:missing-WITH-Linux-syscall-note-for-SPDX-License-Identifier
|-- riscv-randconfig-r014-20210528
|   `-- error:include-uapi-linux-wwan.h:missing-WITH-Linux-syscall-note-for-SPDX-License-Identifier
|-- riscv-randconfig-r024-20210526
|   `-- error:include-uapi-linux-wwan.h:missing-WITH-Linux-syscall-note-for-SPDX-License-Identifier
|-- riscv-randconfig-r033-20210527
|   `-- error:include-uapi-linux-wwan.h:missing-WITH-Linux-syscall-note-for-SPDX-License-Identifier
|-- s390-randconfig-r022-20210526
|   `-- error:include-uapi-linux-wwan.h:missing-WITH-Linux-syscall-note-for-SPDX-License-Identifier
|-- s390-randconfig-r023-20210526
|   `-- error:include-uapi-linux-wwan.h:missing-WITH-Linux-syscall-note-for-SPDX-License-Identifier
|-- s390-randconfig-r026-20210528
|   `-- error:include-uapi-linux-wwan.h:missing-WITH-Linux-syscall-note-for-SPDX-License-Identifier
|-- s390-randconfig-r033-20210527
|   `-- error:include-uapi-linux-wwan.h:missing-WITH-Linux-syscall-note-for-SPDX-License-Identifier
|-- x86_64-randconfig-a011-20210526
|   `-- error:include-uapi-linux-wwan.h:missing-WITH-Linux-syscall-note-for-SPDX-License-Identifier
|-- x86_64-randconfig-a012-20210526
|   `-- error:include-uapi-linux-wwan.h:missing-WITH-Linux-syscall-note-for-SPDX-License-Identifier
|-- x86_64-randconfig-a013-20210526
|   `-- error:include-uapi-linux-wwan.h:missing-WITH-Linux-syscall-note-for-SPDX-License-Identifier
|-- x86_64-randconfig-a014-20210526
|   `-- error:include-uapi-linux-wwan.h:missing-WITH-Linux-syscall-note-for-SPDX-License-Identifier
|-- x86_64-randconfig-a015-20210526
|   `-- error:include-uapi-linux-wwan.h:missing-WITH-Linux-syscall-note-for-SPDX-License-Identifier
|-- x86_64-randconfig-a016-20210526
|   `-- error:include-uapi-linux-wwan.h:missing-WITH-Linux-syscall-note-for-SPDX-License-Identifier
|-- x86_64-randconfig-b001-20210527
|   `-- error:include-uapi-linux-wwan.h:missing-WITH-Linux-syscall-note-for-SPDX-License-Identifier
|-- x86_64-randconfig-r025-20210526
|   `-- error:include-uapi-linux-wwan.h:missing-WITH-Linux-syscall-note-for-SPDX-License-Identifier
|-- x86_64-randconfig-r026-20210526
|   `-- error:include-uapi-linux-wwan.h:missing-WITH-Linux-syscall-note-for-SPDX-License-Identifier
`-- x86_64-randconfig-r032-20210527
    `-- error:include-uapi-linux-wwan.h:missing-WITH-Linux-syscall-note-for-SPDX-License-Identifier

elapsed time: 11043m

configs tested: 233
configs skipped: 3

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                          pcm027_defconfig
powerpc                          g5_defconfig
mips                       capcella_defconfig
powerpc                     tqm8555_defconfig
arm                             ezx_defconfig
mips                           ip32_defconfig
m68k                         amcore_defconfig
mips                        jmr3927_defconfig
powerpc                      ppc44x_defconfig
mips                        nlm_xlp_defconfig
powerpc                  iss476-smp_defconfig
arc                          axs101_defconfig
xtensa                generic_kc705_defconfig
arm                         s3c6400_defconfig
m68k                       m5249evb_defconfig
sh                  sh7785lcr_32bit_defconfig
arm                              alldefconfig
powerpc                  mpc866_ads_defconfig
xtensa                         virt_defconfig
arm                          ep93xx_defconfig
sh                           se7705_defconfig
powerpc                       maple_defconfig
arc                 nsimosci_hs_smp_defconfig
arm                     davinci_all_defconfig
mips                         bigsur_defconfig
mips                            ar7_defconfig
arm                         s5pv210_defconfig
m68k                            mac_defconfig
powerpc                     ppa8548_defconfig
powerpc                    sam440ep_defconfig
sh                        edosk7760_defconfig
arm                          iop32x_defconfig
arm                         lpc32xx_defconfig
arm                          ixp4xx_defconfig
sh                          lboxre2_defconfig
mips                        workpad_defconfig
powerpc                   bluestone_defconfig
sh                         apsh4a3a_defconfig
arc                    vdk_hs38_smp_defconfig
arm                        mvebu_v5_defconfig
nds32                            alldefconfig
arm                            hisi_defconfig
mips                         mpc30x_defconfig
powerpc                      ppc40x_defconfig
sh                          rsk7201_defconfig
m68k                       m5475evb_defconfig
m68k                        m5307c3_defconfig
m68k                         apollo_defconfig
sh                           se7712_defconfig
arm                        keystone_defconfig
mips                  maltasmvp_eva_defconfig
arm                      footbridge_defconfig
mips                  decstation_64_defconfig
openrisc                 simple_smp_defconfig
arm                         axm55xx_defconfig
powerpc                 mpc834x_itx_defconfig
nios2                            allyesconfig
arm                           spitz_defconfig
arm                     am200epdkit_defconfig
powerpc                 mpc8313_rdb_defconfig
arc                     nsimosci_hs_defconfig
sh                            shmin_defconfig
arm                          collie_defconfig
mips                         tb0287_defconfig
arm64                            alldefconfig
mips                        bcm47xx_defconfig
h8300                               defconfig
sh                     sh7710voipgw_defconfig
mips                           ip22_defconfig
um                           x86_64_defconfig
mips                      malta_kvm_defconfig
um                             i386_defconfig
xtensa                       common_defconfig
powerpc                    amigaone_defconfig
mips                    maltaup_xpa_defconfig
mips                        maltaup_defconfig
arm                        realview_defconfig
um                                  defconfig
m68k                        stmark2_defconfig
arm                         lpc18xx_defconfig
arc                            hsdk_defconfig
powerpc                 xes_mpc85xx_defconfig
powerpc                       ebony_defconfig
mips                        vocore2_defconfig
openrisc                  or1klitex_defconfig
arm                        spear6xx_defconfig
powerpc                      arches_defconfig
arm                         orion5x_defconfig
powerpc                      bamboo_defconfig
arm                           u8500_defconfig
arm                         s3c2410_defconfig
parisc                           allyesconfig
arm                         shannon_defconfig
arc                     haps_hs_smp_defconfig
powerpc64                        alldefconfig
sh                          r7780mp_defconfig
m68k                          amiga_defconfig
powerpc                    mvme5100_defconfig
mips                          ath79_defconfig
arm                          lpd270_defconfig
powerpc                   lite5200b_defconfig
powerpc                mpc7448_hpc2_defconfig
powerpc                     tqm8548_defconfig
arm                        multi_v5_defconfig
mips                            e55_defconfig
sh                          rsk7269_defconfig
powerpc64                           defconfig
sh                          r7785rp_defconfig
mips                          ath25_defconfig
powerpc                     stx_gp3_defconfig
powerpc                    ge_imp3a_defconfig
sh                          polaris_defconfig
powerpc                      obs600_defconfig
powerpc                        fsp2_defconfig
arm                        multi_v7_defconfig
nios2                         3c120_defconfig
sh                          kfr2r09_defconfig
arc                      axs103_smp_defconfig
arm                        cerfcube_defconfig
mips                           ci20_defconfig
xtensa                  cadence_csp_defconfig
m68k                       m5208evb_defconfig
mips                     decstation_defconfig
powerpc                    klondike_defconfig
mips                           jazz_defconfig
arm                       omap2plus_defconfig
powerpc                     mpc83xx_defconfig
microblaze                          defconfig
powerpc                  mpc885_ads_defconfig
arm                            mmp2_defconfig
powerpc                   currituck_defconfig
sh                     magicpanelr2_defconfig
arm                            qcom_defconfig
arm                       cns3420vb_defconfig
arc                        nsim_700_defconfig
m68k                        mvme147_defconfig
mips                        nlm_xlr_defconfig
powerpc                   motionpro_defconfig
arm                          exynos_defconfig
mips                     cu1830-neo_defconfig
arm                           corgi_defconfig
mips                     cu1000-neo_defconfig
parisc                generic-64bit_defconfig
s390                          debug_defconfig
mips                           xway_defconfig
m68k                          sun3x_defconfig
sparc                       sparc32_defconfig
powerpc               mpc834x_itxgp_defconfig
arm                         hackkit_defconfig
mips                        qi_lb60_defconfig
sparc                       sparc64_defconfig
x86_64                            allnoconfig
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
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
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
x86_64               randconfig-a005-20210526
x86_64               randconfig-a001-20210526
x86_64               randconfig-a006-20210526
x86_64               randconfig-a003-20210526
x86_64               randconfig-a004-20210526
x86_64               randconfig-a002-20210526
i386                 randconfig-a001-20210526
i386                 randconfig-a002-20210526
i386                 randconfig-a005-20210526
i386                 randconfig-a004-20210526
i386                 randconfig-a003-20210526
i386                 randconfig-a006-20210526
x86_64               randconfig-a013-20210527
x86_64               randconfig-a012-20210527
x86_64               randconfig-a014-20210527
x86_64               randconfig-a016-20210527
x86_64               randconfig-a015-20210527
x86_64               randconfig-a011-20210527
i386                 randconfig-a011-20210526
i386                 randconfig-a016-20210526
i386                 randconfig-a015-20210526
i386                 randconfig-a012-20210526
i386                 randconfig-a014-20210526
i386                 randconfig-a013-20210526
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                            kunit_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210527
x86_64               randconfig-b001-20210526
x86_64               randconfig-a013-20210526
x86_64               randconfig-a012-20210526
x86_64               randconfig-a014-20210526
x86_64               randconfig-a016-20210526
x86_64               randconfig-a015-20210526
x86_64               randconfig-a011-20210526

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
