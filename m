Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A67B5244121
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Aug 2020 00:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgHMWKH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Aug 2020 18:10:07 -0400
Received: from mga18.intel.com ([134.134.136.126]:1927 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726205AbgHMWKG (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Aug 2020 18:10:06 -0400
IronPort-SDR: 1QudTga/56MnoYBzDOBWTrzrhJtioc+U6KpmsSOXY6j+KuK2rRXKAaVwexUmOI+QSF0lR5r52T
 6whmKEu8pBlQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9712"; a="141953326"
X-IronPort-AV: E=Sophos;i="5.76,309,1592895600"; 
   d="scan'208";a="141953326"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2020 15:10:05 -0700
IronPort-SDR: JaXG4MnLMAOZE7VuE0e8IjW2hcrhCT+mTjcqmglZ3fGpJw/H6PvdZQIJJOOSSsFxBtbswLCi9r
 NIntTzYTQlsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,309,1592895600"; 
   d="scan'208";a="327703339"
Received: from lkp-server01.sh.intel.com (HELO 7f1ebb311643) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 13 Aug 2020 15:10:04 -0700
Received: from kbuild by 7f1ebb311643 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k6LQB-0000qQ-QG; Thu, 13 Aug 2020 22:10:03 +0000
Date:   Fri, 14 Aug 2020 06:09:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org
Subject: [mac80211-next:um-orc-unwind] BUILD SUCCESS
 2706859f698a7e6042cfa59b1dd81040db1eeae0
Message-ID: <5f35ba2d.uIYxZ4xJlVKwXJzw%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211-next.git  um-orc-unwind
branch HEAD: 2706859f698a7e6042cfa59b1dd81040db1eeae0  try ARCH=um ORC unwinder

elapsed time: 725m

configs tested: 135
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                            xcep_defconfig
mips                          ath25_defconfig
sh                           se7619_defconfig
powerpc                        cell_defconfig
m68k                          multi_defconfig
arm                           corgi_defconfig
arm                   milbeaut_m10v_defconfig
arm                            dove_defconfig
openrisc                    or1ksim_defconfig
powerpc                           allnoconfig
m68k                          atari_defconfig
openrisc                            defconfig
sh                        sh7763rdp_defconfig
arm                      pxa255-idp_defconfig
sh                           se7750_defconfig
m68k                         apollo_defconfig
mips                        maltaup_defconfig
powerpc                     pseries_defconfig
arc                          axs103_defconfig
h8300                     edosk2674_defconfig
sh                         ap325rxa_defconfig
arm                            pleb_defconfig
sh                           se7780_defconfig
xtensa                    xip_kc705_defconfig
csky                             alldefconfig
m68k                       bvme6000_defconfig
mips                malta_kvm_guest_defconfig
sh                           se7722_defconfig
powerpc                             defconfig
mips                      malta_kvm_defconfig
mips                         mpc30x_defconfig
arm                          ixp4xx_defconfig
sh                          landisk_defconfig
sh                          urquell_defconfig
mips                      pic32mzda_defconfig
arm                           viper_defconfig
nds32                            alldefconfig
powerpc                 mpc8272_ads_defconfig
powerpc                mpc7448_hpc2_defconfig
c6x                        evmc6472_defconfig
arm                     eseries_pxa_defconfig
arc                    vdk_hs38_smp_defconfig
arm                            hisi_defconfig
xtensa                          iss_defconfig
mips                     decstation_defconfig
sh                             sh03_defconfig
powerpc                     mpc512x_defconfig
sh                          lboxre2_defconfig
arc                          axs101_defconfig
arm                        shmobile_defconfig
arm                             mxs_defconfig
sparc64                          alldefconfig
arm                          lpd270_defconfig
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
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64               randconfig-a006-20200813
x86_64               randconfig-a001-20200813
x86_64               randconfig-a005-20200813
x86_64               randconfig-a003-20200813
x86_64               randconfig-a004-20200813
x86_64               randconfig-a002-20200813
i386                 randconfig-a005-20200813
i386                 randconfig-a001-20200813
i386                 randconfig-a002-20200813
i386                 randconfig-a003-20200813
i386                 randconfig-a006-20200813
i386                 randconfig-a004-20200813
i386                 randconfig-a005-20200811
i386                 randconfig-a001-20200811
i386                 randconfig-a002-20200811
i386                 randconfig-a003-20200811
i386                 randconfig-a006-20200811
i386                 randconfig-a004-20200811
i386                 randconfig-a016-20200812
i386                 randconfig-a011-20200812
i386                 randconfig-a013-20200812
i386                 randconfig-a015-20200812
i386                 randconfig-a012-20200812
i386                 randconfig-a014-20200812
i386                 randconfig-a016-20200811
i386                 randconfig-a011-20200811
i386                 randconfig-a015-20200811
i386                 randconfig-a013-20200811
i386                 randconfig-a012-20200811
i386                 randconfig-a014-20200811
i386                 randconfig-a016-20200813
i386                 randconfig-a011-20200813
i386                 randconfig-a013-20200813
i386                 randconfig-a015-20200813
i386                 randconfig-a012-20200813
i386                 randconfig-a014-20200813
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

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
