Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE4071D3F94
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2020 23:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbgENVGA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 May 2020 17:06:00 -0400
Received: from mga01.intel.com ([192.55.52.88]:25139 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727122AbgENVF7 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 May 2020 17:05:59 -0400
IronPort-SDR: pkNTUdphG1dASq33KKEPTJjFdAEngiKJRpPvestycwL2UYnrn1I15JLU6uS9zLcUb9H/EVF6ai
 BTLf1j6C3pkw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2020 14:05:59 -0700
IronPort-SDR: 5QLP1bGQ1f4ZpXutp10086vyO3iCIQk2zh13WNdNZVmG2yGU8HeHVINZSiJIgJU5HWX0Y540co
 zoKiTYU3/O0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,392,1583222400"; 
   d="scan'208";a="410222070"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 14 May 2020 14:05:57 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jZL3F-000AS0-5c; Fri, 15 May 2020 05:05:57 +0800
Date:   Fri, 15 May 2020 05:05:32 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Subject: [wireless-drivers-next:pending] BUILD SUCCESS
 753ceba172801313f4fd9ebcfe19c18989ea382b
Message-ID: <5ebdb29c.Q7Fsb9UaTGSTki/3%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git  pending
branch HEAD: 753ceba172801313f4fd9ebcfe19c18989ea382b  Merge tag 'mt76-for-kvalo-2020-05-14' of https://github.com/nbd168/wireless into pending

elapsed time: 482m

configs tested: 167
configs skipped: 8

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
sparc                            allyesconfig
m68k                             allyesconfig
arc                 nsimosci_hs_smp_defconfig
mips                          malta_defconfig
arm                          exynos_defconfig
powerpc                      pmac32_defconfig
mips                         rt305x_defconfig
arm                           corgi_defconfig
m68k                       m5208evb_defconfig
powerpc                       holly_defconfig
arm                        oxnas_v6_defconfig
powerpc                           allnoconfig
m68k                            q40_defconfig
sh                          sdk7780_defconfig
riscv                            alldefconfig
sh                             espt_defconfig
m68k                         amcore_defconfig
mips                           ip27_defconfig
sparc                            alldefconfig
mips                  decstation_64_defconfig
mips                            e55_defconfig
m68k                          multi_defconfig
sh                          polaris_defconfig
arc                     haps_hs_smp_defconfig
mips                           jazz_defconfig
powerpc                          g5_defconfig
arm                  colibri_pxa300_defconfig
arm                            qcom_defconfig
mips                          lasat_defconfig
ia64                        generic_defconfig
arm                        magician_defconfig
arm                          imote2_defconfig
s390                       zfcpdump_defconfig
powerpc                       maple_defconfig
sh                           se7722_defconfig
sh                          r7785rp_defconfig
h8300                            alldefconfig
powerpc                      tqm8xx_defconfig
mips                           ip28_defconfig
arm                        clps711x_defconfig
m68k                           sun3_defconfig
mips                   sb1250_swarm_defconfig
arm                           efm32_defconfig
nios2                         3c120_defconfig
um                             i386_defconfig
arm                         lubbock_defconfig
arm                       multi_v4t_defconfig
arc                          axs103_defconfig
arc                      axs103_smp_defconfig
arm                         cm_x2xx_defconfig
arm                         palmz72_defconfig
sh                 kfr2r09-romimage_defconfig
c6x                        evmc6678_defconfig
sh                            shmin_defconfig
arm                        neponset_defconfig
sh                         microdev_defconfig
x86_64                              defconfig
arm                         s3c2410_defconfig
arm                        multi_v7_defconfig
arm                        shmobile_defconfig
sh                        sh7763rdp_defconfig
arm                             ezx_defconfig
powerpc                mpc7448_hpc2_defconfig
mips                         cobalt_defconfig
arm                          iop32x_defconfig
arm                         vf610m4_defconfig
mips                        nlm_xlr_defconfig
mips                        nlm_xlp_defconfig
arm                      jornada720_defconfig
sh                          rsk7264_defconfig
m68k                        m5407c3_defconfig
sh                ecovec24-romimage_defconfig
sh                            titan_defconfig
riscv                    nommu_virt_defconfig
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
m68k                                defconfig
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
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          rhel-kconfig
powerpc                          allmodconfig
i386                 randconfig-a006-20200514
i386                 randconfig-a005-20200514
i386                 randconfig-a003-20200514
i386                 randconfig-a001-20200514
i386                 randconfig-a004-20200514
i386                 randconfig-a002-20200514
x86_64               randconfig-a014-20200514
x86_64               randconfig-a012-20200514
x86_64               randconfig-a016-20200514
x86_64               randconfig-a015-20200514
x86_64               randconfig-a013-20200514
x86_64               randconfig-a011-20200514
i386                 randconfig-a012-20200514
i386                 randconfig-a016-20200514
i386                 randconfig-a014-20200514
i386                 randconfig-a011-20200514
i386                 randconfig-a013-20200514
i386                 randconfig-a015-20200514
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             allmodconfig
s390                                defconfig
sparc                               defconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                                   rhel
x86_64                               rhel-7.6
x86_64                    rhel-7.6-kselftests
x86_64                         rhel-7.2-clear
x86_64                                    lkp
x86_64                              fedora-25
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
