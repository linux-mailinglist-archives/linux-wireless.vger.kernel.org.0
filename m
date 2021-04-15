Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 690BA361568
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Apr 2021 00:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235613AbhDOWWo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Apr 2021 18:22:44 -0400
Received: from mga12.intel.com ([192.55.52.136]:60998 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236585AbhDOWWn (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Apr 2021 18:22:43 -0400
IronPort-SDR: TVw3UQVaY4dAGGn1H7EU53FlpJuzN3I+Xfk+Amwx9oLZOlTPyAYG90oa8O969MofiCbCMqF4k0
 CsbALFyo1XDA==
X-IronPort-AV: E=McAfee;i="6200,9189,9955"; a="174447715"
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="174447715"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 15:22:02 -0700
IronPort-SDR: b+hUUlN9w038pfZo5z+ayxg1RQNa77I7zuXnAxC3ZXt8shsToP94xvrNhk1qK6u2oiZw1niIdS
 AhmdKLP3kWnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,225,1613462400"; 
   d="scan'208";a="522524478"
Received: from lkp-server02.sh.intel.com (HELO fa9c8fcc3464) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 15 Apr 2021 15:22:01 -0700
Received: from kbuild by fa9c8fcc3464 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lXAN7-000196-1e; Thu, 15 Apr 2021 22:22:01 +0000
Date:   Fri, 16 Apr 2021 06:21:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Subject: [wireless-drivers-next:pending] BUILD SUCCESS
 a6c34cb6110dfe978d2336bd34448e85d4896180
Message-ID: <6078bc7a.HlLbdBB9VSb2L5gm%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git pending
branch HEAD: a6c34cb6110dfe978d2336bd34448e85d4896180  Merge tag 'iwlwifi-next-for-kalle-2021-04-12-v2' of git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next into pending

elapsed time: 721m

configs tested: 157
configs skipped: 3

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
arm                       aspeed_g4_defconfig
xtensa                         virt_defconfig
arm                          gemini_defconfig
h8300                            alldefconfig
arm                         socfpga_defconfig
powerpc                 mpc8272_ads_defconfig
arm                           sama5_defconfig
riscv                               defconfig
m68k                             alldefconfig
arc                         haps_hs_defconfig
powerpc                      ppc64e_defconfig
powerpc                 mpc834x_mds_defconfig
powerpc                      makalu_defconfig
sh                          rsk7269_defconfig
arm                        realview_defconfig
mips                      maltaaprp_defconfig
h8300                     edosk2674_defconfig
powerpc                     tqm5200_defconfig
powerpc                    klondike_defconfig
mips                     cu1000-neo_defconfig
powerpc                 mpc832x_mds_defconfig
sparc64                          alldefconfig
arm                         shannon_defconfig
arm                         lpc32xx_defconfig
m68k                           sun3_defconfig
powerpc                      ppc44x_defconfig
arm                           corgi_defconfig
powerpc                     ep8248e_defconfig
arm                       netwinder_defconfig
powerpc                      katmai_defconfig
arm                       multi_v4t_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                       ebony_defconfig
mips                            ar7_defconfig
m68k                        m5272c3_defconfig
powerpc                     tqm8560_defconfig
powerpc                     redwood_defconfig
powerpc                        fsp2_defconfig
arm                       versatile_defconfig
mips                           ci20_defconfig
sh                          lboxre2_defconfig
sh                           se7705_defconfig
mips                        maltaup_defconfig
ia64                         bigsur_defconfig
um                               alldefconfig
arm                       mainstone_defconfig
sh                          sdk7786_defconfig
arm                        neponset_defconfig
arm                      integrator_defconfig
arm                        multi_v7_defconfig
powerpc                  mpc885_ads_defconfig
powerpc                 xes_mpc85xx_defconfig
powerpc                      arches_defconfig
powerpc                        icon_defconfig
arm                          moxart_defconfig
sh                            titan_defconfig
arm                        magician_defconfig
powerpc                     skiroot_defconfig
sh                        sh7757lcr_defconfig
powerpc                    sam440ep_defconfig
mips                           ip32_defconfig
mips                  decstation_64_defconfig
powerpc                        cell_defconfig
sh                     sh7710voipgw_defconfig
powerpc               mpc834x_itxgp_defconfig
mips                        nlm_xlr_defconfig
arm                  colibri_pxa270_defconfig
arm                      jornada720_defconfig
arc                        vdk_hs38_defconfig
powerpc                    mvme5100_defconfig
mips                       capcella_defconfig
arm                          ixp4xx_defconfig
sh                        edosk7705_defconfig
powerpc                   motionpro_defconfig
powerpc                 mpc834x_itx_defconfig
mips                         db1xxx_defconfig
sh                   rts7751r2dplus_defconfig
sh                           se7751_defconfig
arm                          pcm027_defconfig
powerpc                     kilauea_defconfig
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
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a003-20210415
x86_64               randconfig-a002-20210415
x86_64               randconfig-a005-20210415
x86_64               randconfig-a001-20210415
x86_64               randconfig-a006-20210415
x86_64               randconfig-a004-20210415
i386                 randconfig-a003-20210415
i386                 randconfig-a006-20210415
i386                 randconfig-a001-20210415
i386                 randconfig-a005-20210415
i386                 randconfig-a004-20210415
i386                 randconfig-a002-20210415
i386                 randconfig-a015-20210415
i386                 randconfig-a014-20210415
i386                 randconfig-a013-20210415
i386                 randconfig-a012-20210415
i386                 randconfig-a016-20210415
i386                 randconfig-a011-20210415
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a014-20210415
x86_64               randconfig-a015-20210415
x86_64               randconfig-a011-20210415
x86_64               randconfig-a013-20210415
x86_64               randconfig-a012-20210415
x86_64               randconfig-a016-20210415

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
