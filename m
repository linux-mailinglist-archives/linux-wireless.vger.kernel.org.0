Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B58DF1E9D11
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jun 2020 07:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbgFAFQf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 1 Jun 2020 01:16:35 -0400
Received: from mga17.intel.com ([192.55.52.151]:47163 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbgFAFQe (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 1 Jun 2020 01:16:34 -0400
IronPort-SDR: /HuHhz3D1F792/QfgbBFOXH73JqKIWgc/OmMW46ymFx8oqmHbuE+8gnsf8iBjA0kjHncFcwZH9
 PGtvlpoCyKpA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2020 22:16:34 -0700
IronPort-SDR: 0KQvFl8Om5fMyVKrtDikR3QWwky7T/fOV18aDLrCiXsy3eJTSdRBoRtFVEVYA+HSpQLr2TgZjx
 RWBTDnNLzt/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,459,1583222400"; 
   d="scan'208";a="444161748"
Received: from lkp-server01.sh.intel.com (HELO 49d03d9b0ee7) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 31 May 2020 22:16:32 -0700
Received: from kbuild by 49d03d9b0ee7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jfcoK-0000CO-2v; Mon, 01 Jun 2020 05:16:32 +0000
Date:   Mon, 01 Jun 2020 13:15:50 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Subject: [wireless-drivers-next:master] BUILD SUCCESS
 e948ed0427991d197c861fcac4961e699b978d5d
Message-ID: <5ed48f06.gDmIblPGKFIBGzgO%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git  master
branch HEAD: e948ed0427991d197c861fcac4961e699b978d5d  Merge ath-next from git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git

elapsed time: 2146m

configs tested: 110
configs skipped: 10

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
powerpc                      mgcoge_defconfig
arm                         vf610m4_defconfig
arm                          pxa168_defconfig
arm                         shannon_defconfig
powerpc                      ppc6xx_defconfig
powerpc64                        alldefconfig
microblaze                    nommu_defconfig
arm                       mainstone_defconfig
arm                            hisi_defconfig
powerpc                     mpc83xx_defconfig
m68k                          multi_defconfig
m68k                             allyesconfig
sh                          rsk7264_defconfig
arm                        spear6xx_defconfig
sh                   sh7770_generic_defconfig
m68k                           sun3_defconfig
sh                           se7619_defconfig
powerpc                     pseries_defconfig
arm                            dove_defconfig
h8300                            alldefconfig
c6x                         dsk6455_defconfig
riscv                    nommu_virt_defconfig
sh                        apsh4ad0a_defconfig
sh                           se7343_defconfig
mips                          rm200_defconfig
arm                        mvebu_v5_defconfig
arm                         assabet_defconfig
xtensa                           alldefconfig
powerpc                      tqm8xx_defconfig
sh                           se7750_defconfig
xtensa                         virt_defconfig
sh                            shmin_defconfig
arm                        multi_v5_defconfig
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
powerpc                           allnoconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
s390                             allyesconfig
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
