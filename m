Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 167151E9CFD
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jun 2020 07:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725876AbgFAFPS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 1 Jun 2020 01:15:18 -0400
Received: from mga05.intel.com ([192.55.52.43]:37072 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbgFAFPS (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 1 Jun 2020 01:15:18 -0400
IronPort-SDR: 2kw7XTk+N8FrVEM8H9ecYMfMI7qqoROJaNROQ+QQCdPBvNVqgd6/mSc/1nnk3L9Nbntlbzn8pw
 DjJcfBBwQkYw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2020 22:15:18 -0700
IronPort-SDR: 4QZ6AoTHX1qPg0ISFGYJZtSgF5nEhRw0L60IkDCuArEJ/iIOqvSGPLpnUs5dC/96RIzRJyGbXl
 rYq9cAnQkn5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,459,1583222400"; 
   d="scan'208";a="470167149"
Received: from lkp-server01.sh.intel.com (HELO 49d03d9b0ee7) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 31 May 2020 22:15:16 -0700
Received: from kbuild by 49d03d9b0ee7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jfcn6-0000BK-8i; Mon, 01 Jun 2020 05:15:16 +0000
Date:   Mon, 01 Jun 2020 13:14:32 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Subject: [wireless-drivers-next:pending] BUILD SUCCESS
 e43a73265a172b1b6a6769189a198947c7cedca7
Message-ID: <5ed48eb8.pYbUPIK4vEIV5o3r%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git  pending
branch HEAD: e43a73265a172b1b6a6769189a198947c7cedca7  Merge tag 'iwlwifi-next-for-kalle-2020-05-29' of git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next into pending

elapsed time: 3745m

configs tested: 138
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
arm                          pxa3xx_defconfig
arm                         palmz72_defconfig
sh                            shmin_defconfig
ia64                            zx1_defconfig
riscv                          rv32_defconfig
powerpc                      pasemi_defconfig
sparc                       sparc64_defconfig
mips                  decstation_64_defconfig
mips                          ath79_defconfig
powerpc                      mgcoge_defconfig
arm                         vf610m4_defconfig
arm                          pxa168_defconfig
sh                        sh7763rdp_defconfig
mips                         tb0226_defconfig
m68k                          multi_defconfig
powerpc                  mpc885_ads_defconfig
arm                       aspeed_g5_defconfig
mips                        maltaup_defconfig
arc                             nps_defconfig
sh                          rsk7269_defconfig
ia64                        generic_defconfig
arm                             pxa_defconfig
c6x                        evmc6678_defconfig
m68k                        m5407c3_defconfig
sh                               j2_defconfig
arm                        multi_v7_defconfig
arm                       mainstone_defconfig
arm                            hisi_defconfig
powerpc                     mpc83xx_defconfig
m68k                             allyesconfig
arm                        spear6xx_defconfig
sh                   sh7770_generic_defconfig
m68k                           sun3_defconfig
sh                           se7619_defconfig
sh                          rsk7264_defconfig
arm                         ebsa110_defconfig
arm                            lart_defconfig
sh                         microdev_defconfig
x86_64                              defconfig
arm                          badge4_defconfig
arm                        oxnas_v6_defconfig
powerpc                    adder875_defconfig
mips                            ar7_defconfig
ia64                              allnoconfig
arm                        keystone_defconfig
arm                           viper_defconfig
powerpc                             defconfig
arc                           tb10x_defconfig
arm                        mvebu_v7_defconfig
powerpc                mpc7448_hpc2_defconfig
xtensa                              defconfig
c6x                         dsk6455_defconfig
riscv                    nommu_virt_defconfig
sh                        apsh4ad0a_defconfig
sh                           se7343_defconfig
s390                       zfcpdump_defconfig
s390                             allyesconfig
arm                       cns3420vb_defconfig
arm                        spear3xx_defconfig
i386                              allnoconfig
i386                             allyesconfig
i386                                defconfig
i386                              debian-10.3
ia64                             allmodconfig
ia64                                defconfig
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
i386                 randconfig-a013-20200531
i386                 randconfig-a012-20200531
i386                 randconfig-a015-20200531
i386                 randconfig-a011-20200531
i386                 randconfig-a016-20200531
i386                 randconfig-a014-20200531
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
s390                              allnoconfig
s390                             allmodconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
um                                allnoconfig
um                                  defconfig
um                               allmodconfig
um                               allyesconfig
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
