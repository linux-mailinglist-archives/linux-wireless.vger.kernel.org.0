Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCC0B319C1A
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Feb 2021 10:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbhBLJro (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Feb 2021 04:47:44 -0500
Received: from mga04.intel.com ([192.55.52.120]:58732 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230259AbhBLJrb (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Feb 2021 04:47:31 -0500
IronPort-SDR: lAGE3hzQFv1gNmkrg8IvjahZDywu4t2fdGB/PlmK0tTKNXhlK1qSBrggPd6o1ofaB1ooEOMVif
 s/LDVJ6MrLIQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9892"; a="179829325"
X-IronPort-AV: E=Sophos;i="5.81,173,1610438400"; 
   d="scan'208";a="179829325"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2021 01:46:50 -0800
IronPort-SDR: jsuprrSXzjzTMHyR33vqEtiwZuK87iaZ+uy4tcpRDKm2MoaJ1bL7FxAtUhk78YsBuf5ELzoLr9
 adSG1ZteU+MQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,173,1610438400"; 
   d="scan'208";a="490848390"
Received: from lkp-server02.sh.intel.com (HELO cd560a204411) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 12 Feb 2021 01:46:48 -0800
Received: from kbuild by cd560a204411 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lAV2G-0004Yf-72; Fri, 12 Feb 2021 09:46:48 +0000
Date:   Fri, 12 Feb 2021 17:46:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Subject: [wireless-drivers-next:pending] BUILD SUCCESS
 06432d6642b68e8cc1f0d0201e1d333d8322b8fa
Message-ID: <60264e6b.Thabv8zZqzrUouDo%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git pending
branch HEAD: 06432d6642b68e8cc1f0d0201e1d333d8322b8fa  Merge tag 'iwlwifi-next-for-kalle-2021-02-10' of git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next into pending

elapsed time: 724m

configs tested: 129
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
riscv                    nommu_k210_defconfig
alpha                            alldefconfig
arc                     haps_hs_smp_defconfig
sh                               j2_defconfig
powerpc                      ppc64e_defconfig
arm                       netwinder_defconfig
arm                  colibri_pxa300_defconfig
powerpc                    ge_imp3a_defconfig
m68k                          atari_defconfig
mips                      bmips_stb_defconfig
powerpc                     stx_gp3_defconfig
arm                           sunxi_defconfig
arm                          prima2_defconfig
sh                ecovec24-romimage_defconfig
arm                          pcm027_defconfig
arm                        neponset_defconfig
sh                           se7780_defconfig
mips                     cu1830-neo_defconfig
mips                         tb0219_defconfig
sh                          rsk7264_defconfig
arm                            u300_defconfig
openrisc                            defconfig
arm                      tct_hammer_defconfig
arm                       aspeed_g5_defconfig
arm                         vf610m4_defconfig
arm                          lpd270_defconfig
arm                           corgi_defconfig
um                             i386_defconfig
arm                             rpc_defconfig
powerpc                    amigaone_defconfig
mips                        omega2p_defconfig
arm                         s5pv210_defconfig
powerpc                 mpc837x_rdb_defconfig
powerpc                 mpc836x_rdk_defconfig
mips                           ip28_defconfig
sh                                  defconfig
powerpc                mpc7448_hpc2_defconfig
powerpc                      pmac32_defconfig
arm                         shannon_defconfig
powerpc                      chrp32_defconfig
arc                        vdk_hs38_defconfig
sparc                       sparc32_defconfig
mips                            e55_defconfig
mips                malta_kvm_guest_defconfig
arm                           spitz_defconfig
ia64                      gensparse_defconfig
arm                              alldefconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
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
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20210209
x86_64               randconfig-a001-20210209
x86_64               randconfig-a005-20210209
x86_64               randconfig-a004-20210209
x86_64               randconfig-a002-20210209
x86_64               randconfig-a003-20210209
i386                 randconfig-a001-20210209
i386                 randconfig-a005-20210209
i386                 randconfig-a003-20210209
i386                 randconfig-a002-20210209
i386                 randconfig-a006-20210209
i386                 randconfig-a004-20210209
i386                 randconfig-a016-20210209
i386                 randconfig-a013-20210209
i386                 randconfig-a012-20210209
i386                 randconfig-a014-20210209
i386                 randconfig-a011-20210209
i386                 randconfig-a015-20210209
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a003-20210211
x86_64               randconfig-a002-20210211
x86_64               randconfig-a001-20210211
x86_64               randconfig-a004-20210211
x86_64               randconfig-a005-20210211
x86_64               randconfig-a006-20210211
x86_64               randconfig-a013-20210209
x86_64               randconfig-a014-20210209
x86_64               randconfig-a015-20210209
x86_64               randconfig-a012-20210209
x86_64               randconfig-a016-20210209
x86_64               randconfig-a011-20210209

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
