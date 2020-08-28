Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DBD625528E
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Aug 2020 03:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbgH1Bct (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Aug 2020 21:32:49 -0400
Received: from mga17.intel.com ([192.55.52.151]:17675 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728177AbgH1Bct (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Aug 2020 21:32:49 -0400
IronPort-SDR: wHXCX/fcLYl7iIlO5auvQE5AFosmLN+6dhgs+IPqclAAwJdcIe1cMWY2aKr2OJzxpObum1K/a7
 IB8VKXI982MQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9726"; a="136655432"
X-IronPort-AV: E=Sophos;i="5.76,361,1592895600"; 
   d="scan'208";a="136655432"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2020 18:29:47 -0700
IronPort-SDR: I4VdTqkfyJs49ECVHuo9rR78JUpNsDb3rT0nCEZxW4LB8uO3brzrvoroFQMg+8Xp1UltqJQBvp
 iX0DYko9K1kQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,361,1592895600"; 
   d="scan'208";a="500325160"
Received: from lkp-server01.sh.intel.com (HELO 4f455964fc6c) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 27 Aug 2020 18:29:45 -0700
Received: from kbuild by 4f455964fc6c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kBTD6-0002Pu-U0; Fri, 28 Aug 2020 01:29:44 +0000
Date:   Fri, 28 Aug 2020 09:29:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Subject: [wireless-drivers-next:master] BUILD SUCCESS WITH WARNING
 26721b02466e396efaca6807b52916478c4f9197
Message-ID: <5f485ddd.Ajylb5U3LE36BLDy%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git  master
branch HEAD: 26721b02466e396efaca6807b52916478c4f9197  zd1211rw: convert tasklets to use new tasklet_setup() API

Warning in current branch:

drivers/net/wireless/realtek/rtlwifi/usb.c:313:33: warning: cast between incompatible function types from 'void (*)(struct tasklet_struct *)' to 'void (*)(long unsigned int)' [-Wcast-function-type]
drivers/net/wireless/zydas/zd1211rw/zd_usb.c:1181:33: warning: cast between incompatible function types from 'void (*)(struct tasklet_struct *)' to 'void (*)(long unsigned int)' [-Wcast-function-type]

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allmodconfig
|   |-- drivers-net-wireless-realtek-rtlwifi-usb.c:warning:cast-between-incompatible-function-types-from-void-(-)(struct-tasklet_struct-)-to-void-(-)(long-unsigned-int)
|   `-- drivers-net-wireless-zydas-zd1211rw-zd_usb.c:warning:cast-between-incompatible-function-types-from-void-(-)(struct-tasklet_struct-)-to-void-(-)(long-unsigned-int)
|-- alpha-allyesconfig
|   |-- drivers-net-wireless-realtek-rtlwifi-usb.c:warning:cast-between-incompatible-function-types-from-void-(-)(struct-tasklet_struct-)-to-void-(-)(long-unsigned-int)
|   `-- drivers-net-wireless-zydas-zd1211rw-zd_usb.c:warning:cast-between-incompatible-function-types-from-void-(-)(struct-tasklet_struct-)-to-void-(-)(long-unsigned-int)
|-- arc-allyesconfig
|   |-- drivers-net-wireless-realtek-rtlwifi-usb.c:warning:cast-between-incompatible-function-types-from-void-(-)(struct-tasklet_struct-)-to-void-(-)(long-unsigned-int)
|   `-- drivers-net-wireless-zydas-zd1211rw-zd_usb.c:warning:cast-between-incompatible-function-types-from-void-(-)(struct-tasklet_struct-)-to-void-(-)(long-unsigned-int)
|-- arm-allmodconfig
|   |-- drivers-net-wireless-realtek-rtlwifi-usb.c:warning:cast-between-incompatible-function-types-from-void-(-)(struct-tasklet_struct-)-to-void-(-)(long-unsigned-int)
|   `-- drivers-net-wireless-zydas-zd1211rw-zd_usb.c:warning:cast-between-incompatible-function-types-from-void-(-)(struct-tasklet_struct-)-to-void-(-)(long-unsigned-int)
|-- arm-allyesconfig
|   |-- drivers-net-wireless-realtek-rtlwifi-usb.c:warning:cast-between-incompatible-function-types-from-void-(-)(struct-tasklet_struct-)-to-void-(-)(long-unsigned-int)
|   `-- drivers-net-wireless-zydas-zd1211rw-zd_usb.c:warning:cast-between-incompatible-function-types-from-void-(-)(struct-tasklet_struct-)-to-void-(-)(long-unsigned-int)
|-- arm-at91_dt_defconfig
|   `-- drivers-net-wireless-realtek-rtlwifi-usb.c:warning:cast-between-incompatible-function-types-from-void-(-)(struct-tasklet_struct-)-to-void-(-)(long-unsigned-int)
|-- arm-randconfig-r012-20200827
|   |-- drivers-net-wireless-realtek-rtlwifi-usb.c:warning:cast-between-incompatible-function-types-from-void-(-)(struct-tasklet_struct-)-to-void-(-)(long-unsigned-int)
|   `-- drivers-net-wireless-zydas-zd1211rw-zd_usb.c:warning:cast-between-incompatible-function-types-from-void-(-)(struct-tasklet_struct-)-to-void-(-)(long-unsigned-int)
|-- arm64-allyesconfig
|   |-- drivers-net-wireless-realtek-rtlwifi-usb.c:warning:cast-between-incompatible-function-types-from-void-(-)(struct-tasklet_struct-)-to-void-(-)(long-unsigned-int)
|   `-- drivers-net-wireless-zydas-zd1211rw-zd_usb.c:warning:cast-between-incompatible-function-types-from-void-(-)(struct-tasklet_struct-)-to-void-(-)(long-unsigned-int)
|-- c6x-allyesconfig
|   |-- drivers-net-wireless-realtek-rtlwifi-usb.c:warning:cast-between-incompatible-function-types-from-void-(-)(struct-tasklet_struct-)-to-void-(-)(long-unsigned-int)
|   `-- drivers-net-wireless-zydas-zd1211rw-zd_usb.c:warning:cast-between-incompatible-function-types-from-void-(-)(struct-tasklet_struct-)-to-void-(-)(long-unsigned-int)
|-- h8300-allyesconfig
|   |-- drivers-net-wireless-realtek-rtlwifi-usb.c:warning:cast-between-incompatible-function-types-from-void-(-)(struct-tasklet_struct-)-to-void-(-)(long-unsigned-int)
|   `-- drivers-net-wireless-zydas-zd1211rw-zd_usb.c:warning:cast-between-incompatible-function-types-from-void-(-)(struct-tasklet_struct-)-to-void-(-)(long-unsigned-int)
|-- i386-allyesconfig
|   |-- drivers-net-wireless-realtek-rtlwifi-usb.c:warning:cast-between-incompatible-function-types-from-void-(-)(struct-tasklet_struct-)-to-void-(-)(long-unsigned-int)
|   `-- drivers-net-wireless-zydas-zd1211rw-zd_usb.c:warning:cast-between-incompatible-function-types-from-void-(-)(struct-tasklet_struct-)-to-void-(-)(long-unsigned-int)
|-- ia64-allmodconfig
|   |-- drivers-net-wireless-realtek-rtlwifi-usb.c:warning:cast-between-incompatible-function-types-from-void-(-)(struct-tasklet_struct-)-to-void-(-)(long-unsigned-int)
|   `-- drivers-net-wireless-zydas-zd1211rw-zd_usb.c:warning:cast-between-incompatible-function-types-from-void-(-)(struct-tasklet_struct-)-to-void-(-)(long-unsigned-int)
|-- ia64-allyesconfig
|   |-- drivers-net-wireless-realtek-rtlwifi-usb.c:warning:cast-between-incompatible-function-types-from-void-(-)(struct-tasklet_struct-)-to-void-(-)(long-unsigned-int)
|   `-- drivers-net-wireless-zydas-zd1211rw-zd_usb.c:warning:cast-between-incompatible-function-types-from-void-(-)(struct-tasklet_struct-)-to-void-(-)(long-unsigned-int)
|-- m68k-allmodconfig
|   |-- drivers-net-wireless-realtek-rtlwifi-usb.c:warning:cast-between-incompatible-function-types-from-void-(-)(struct-tasklet_struct-)-to-void-(-)(long-unsigned-int)
|   `-- drivers-net-wireless-zydas-zd1211rw-zd_usb.c:warning:cast-between-incompatible-function-types-from-void-(-)(struct-tasklet_struct-)-to-void-(-)(long-unsigned-int)
|-- m68k-allyesconfig
|   |-- drivers-net-wireless-realtek-rtlwifi-usb.c:warning:cast-between-incompatible-function-types-from-void-(-)(struct-tasklet_struct-)-to-void-(-)(long-unsigned-int)
|   `-- drivers-net-wireless-zydas-zd1211rw-zd_usb.c:warning:cast-between-incompatible-function-types-from-void-(-)(struct-tasklet_struct-)-to-void-(-)(long-unsigned-int)
|-- mips-allmodconfig
|   |-- drivers-net-wireless-realtek-rtlwifi-usb.c:warning:cast-between-incompatible-function-types-from-void-(-)(struct-tasklet_struct-)-to-void-(-)(long-unsigned-int)
|   `-- drivers-net-wireless-zydas-zd1211rw-zd_usb.c:warning:cast-between-incompatible-function-types-from-void-(-)(struct-tasklet_struct-)-to-void-(-)(long-unsigned-int)
|-- mips-allyesconfig
|   |-- drivers-net-wireless-realtek-rtlwifi-usb.c:warning:cast-between-incompatible-function-types-from-void-(-)(struct-tasklet_struct-)-to-void-(-)(long-unsigned-int)
|   `-- drivers-net-wireless-zydas-zd1211rw-zd_usb.c:warning:cast-between-incompatible-function-types-from-void-(-)(struct-tasklet_struct-)-to-void-(-)(long-unsigned-int)
|-- nds32-allyesconfig
|   |-- drivers-net-wireless-realtek-rtlwifi-usb.c:warning:cast-between-incompatible-function-types-from-void-(-)(struct-tasklet_struct-)-to-void-(-)(long-unsigned-int)
|   `-- drivers-net-wireless-zydas-zd1211rw-zd_usb.c:warning:cast-between-incompatible-function-types-from-void-(-)(struct-tasklet_struct-)-to-void-(-)(long-unsigned-int)
|-- nios2-allyesconfig
|   |-- drivers-net-wireless-realtek-rtlwifi-usb.c:warning:cast-between-incompatible-function-types-from-void-(-)(struct-tasklet_struct-)-to-void-(-)(long-unsigned-int)
|   `-- drivers-net-wireless-zydas-zd1211rw-zd_usb.c:warning:cast-between-incompatible-function-types-from-void-(-)(struct-tasklet_struct-)-to-void-(-)(long-unsigned-int)
|-- parisc-allyesconfig
|   |-- drivers-net-wireless-realtek-rtlwifi-usb.c:warning:cast-between-incompatible-function-types-from-void-(-)(struct-tasklet_struct-)-to-void-(-)(long-unsigned-int)
|   `-- drivers-net-wireless-zydas-zd1211rw-zd_usb.c:warning:cast-between-incompatible-function-types-from-void-(-)(struct-tasklet_struct-)-to-void-(-)(long-unsigned-int)
|-- powerpc-allmodconfig
|   |-- drivers-net-wireless-realtek-rtlwifi-usb.c:warning:cast-between-incompatible-function-types-from-void-(-)(struct-tasklet_struct-)-to-void-(-)(long-unsigned-int)
|   `-- drivers-net-wireless-zydas-zd1211rw-zd_usb.c:warning:cast-between-incompatible-function-types-from-void-(-)(struct-tasklet_struct-)-to-void-(-)(long-unsigned-int)
|-- powerpc-allyesconfig
|   |-- drivers-net-wireless-realtek-rtlwifi-usb.c:warning:cast-between-incompatible-function-types-from-void-(-)(struct-tasklet_struct-)-to-void-(-)(long-unsigned-int)
|   `-- drivers-net-wireless-zydas-zd1211rw-zd_usb.c:warning:cast-between-incompatible-function-types-from-void-(-)(struct-tasklet_struct-)-to-void-(-)(long-unsigned-int)
|-- riscv-allmodconfig
|   |-- drivers-net-wireless-realtek-rtlwifi-usb.c:warning:cast-between-incompatible-function-types-from-void-(-)(struct-tasklet_struct-)-to-void-(-)(long-unsigned-int)
|   `-- drivers-net-wireless-zydas-zd1211rw-zd_usb.c:warning:cast-between-incompatible-function-types-from-void-(-)(struct-tasklet_struct-)-to-void-(-)(long-unsigned-int)
|-- riscv-allyesconfig
|   |-- drivers-net-wireless-realtek-rtlwifi-usb.c:warning:cast-between-incompatible-function-types-from-void-(-)(struct-tasklet_struct-)-to-void-(-)(long-unsigned-int)
|   `-- drivers-net-wireless-zydas-zd1211rw-zd_usb.c:warning:cast-between-incompatible-function-types-from-void-(-)(struct-tasklet_struct-)-to-void-(-)(long-unsigned-int)
|-- sh-allmodconfig
|   |-- drivers-net-wireless-realtek-rtlwifi-usb.c:warning:cast-between-incompatible-function-types-from-void-(-)(struct-tasklet_struct-)-to-void-(-)(long-unsigned-int)
|   `-- drivers-net-wireless-zydas-zd1211rw-zd_usb.c:warning:cast-between-incompatible-function-types-from-void-(-)(struct-tasklet_struct-)-to-void-(-)(long-unsigned-int)
|-- sparc-allyesconfig
|   |-- drivers-net-wireless-realtek-rtlwifi-usb.c:warning:cast-between-incompatible-function-types-from-void-(-)(struct-tasklet_struct-)-to-void-(-)(long-unsigned-int)
|   `-- drivers-net-wireless-zydas-zd1211rw-zd_usb.c:warning:cast-between-incompatible-function-types-from-void-(-)(struct-tasklet_struct-)-to-void-(-)(long-unsigned-int)
|-- x86_64-allyesconfig
|   |-- drivers-net-wireless-realtek-rtlwifi-usb.c:warning:cast-between-incompatible-function-types-from-void-(-)(struct-tasklet_struct-)-to-void-(-)(long-unsigned-int)
|   `-- drivers-net-wireless-zydas-zd1211rw-zd_usb.c:warning:cast-between-incompatible-function-types-from-void-(-)(struct-tasklet_struct-)-to-void-(-)(long-unsigned-int)
`-- xtensa-allyesconfig
    |-- drivers-net-wireless-realtek-rtlwifi-usb.c:warning:cast-between-incompatible-function-types-from-void-(-)(struct-tasklet_struct-)-to-void-(-)(long-unsigned-int)
    `-- drivers-net-wireless-zydas-zd1211rw-zd_usb.c:warning:cast-between-incompatible-function-types-from-void-(-)(struct-tasklet_struct-)-to-void-(-)(long-unsigned-int)

elapsed time: 723m

configs tested: 106
configs skipped: 12

arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
riscv                    nommu_k210_defconfig
mips                     decstation_defconfig
arm                   milbeaut_m10v_defconfig
powerpc                mpc7448_hpc2_defconfig
sh                              ul2_defconfig
sh                ecovec24-romimage_defconfig
arm                      pxa255-idp_defconfig
mips                           ip32_defconfig
sh                           se7721_defconfig
arm                           u8500_defconfig
alpha                               defconfig
arm                          badge4_defconfig
m68k                           sun3_defconfig
arm                          ixp4xx_defconfig
m68k                          multi_defconfig
powerpc                         ps3_defconfig
arm                             rpc_defconfig
sh                            shmin_defconfig
arm                         s3c2410_defconfig
m68k                        m5272c3_defconfig
sh                            migor_defconfig
arm                        multi_v7_defconfig
sparc64                          alldefconfig
arm                          pxa168_defconfig
sh                        sh7763rdp_defconfig
arm                         orion5x_defconfig
mips                         mpc30x_defconfig
powerpc                      ppc40x_defconfig
parisc                           allyesconfig
arm                    vt8500_v6_v7_defconfig
arc                              allyesconfig
sh                             sh03_defconfig
arm                         mv78xx0_defconfig
s390                       zfcpdump_defconfig
mips                      pic32mzda_defconfig
arm                       netwinder_defconfig
arm                         at91_dt_defconfig
sh                          kfr2r09_defconfig
arm                          pcm027_defconfig
powerpc                      ppc6xx_defconfig
nds32                            alldefconfig
c6x                         dsk6455_defconfig
arm                         lpc32xx_defconfig
riscv                               defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
nios2                               defconfig
nds32                             allnoconfig
c6x                              allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
powerpc                             defconfig
x86_64               randconfig-a003-20200827
x86_64               randconfig-a002-20200827
x86_64               randconfig-a001-20200827
x86_64               randconfig-a005-20200827
x86_64               randconfig-a006-20200827
x86_64               randconfig-a004-20200827
i386                 randconfig-a002-20200827
i386                 randconfig-a004-20200827
i386                 randconfig-a003-20200827
i386                 randconfig-a005-20200827
i386                 randconfig-a006-20200827
i386                 randconfig-a001-20200827
i386                 randconfig-a013-20200827
i386                 randconfig-a012-20200827
i386                 randconfig-a011-20200827
i386                 randconfig-a016-20200827
i386                 randconfig-a015-20200827
i386                 randconfig-a014-20200827
riscv                            allyesconfig
riscv                             allnoconfig
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
