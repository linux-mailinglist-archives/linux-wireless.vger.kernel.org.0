Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 637A453014F
	for <lists+linux-wireless@lfdr.de>; Sun, 22 May 2022 08:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241164AbiEVGnR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 22 May 2022 02:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239713AbiEVGnO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 22 May 2022 02:43:14 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD1620BFE
        for <linux-wireless@vger.kernel.org>; Sat, 21 May 2022 23:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653201793; x=1684737793;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Z5C2UtSTeOx+GIjf46PODJKpHJuMawy2gL6z4OJ/in8=;
  b=NvuPVLd4jWUFe9c71Tsy2Ocgi5x8U0IG9442NrrG4YOekubg/1cbMt/Q
   7WvU81rXq2/IghiV3AYzgLb32J0HNlTxdYouGYgTR0/35E/E0wZ9ujxBu
   SpF47O5kL/T4CXJyI0l0ysi6tNqgS0ZKxsEv/GC7fWAg3naBrPuTN1m64
   mHgMar8OUKv3Fdg/7lt+hRuySSoDUSrRr+9tsf6P09Awge5FJZLtVoBTy
   U8Sx4JnB+eeth/PUJMk0k2BkXS4mgiahtcCU2D8yjeHfXv33vjV3h7xl9
   1QXS8gFIjYnf8EV/Df+/k+l5MkwFSbpyYIarHwbswEFsrB7x7tEqjw9jp
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10354"; a="333585062"
X-IronPort-AV: E=Sophos;i="5.91,243,1647327600"; 
   d="scan'208";a="333585062"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2022 23:43:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,243,1647327600"; 
   d="scan'208";a="716213135"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 21 May 2022 23:43:12 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nsfJ1-00006d-Dz;
        Sun, 22 May 2022 06:43:11 +0000
Date:   Sun, 22 May 2022 14:42:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [wireless-next:main] BUILD SUCCESS
 805cb5aadc2a88c453cfe620b28e12ff2fac27a6
Message-ID: <6289db62.UHAKRwQo66lHE/8R%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 805cb5aadc2a88c453cfe620b28e12ff2fac27a6  Merge git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next

elapsed time: 2983m

configs tested: 170
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
powerpc64                           defconfig
arc                                 defconfig
powerpc                     asp8347_defconfig
m68k                            mac_defconfig
ia64                            zx1_defconfig
ia64                      gensparse_defconfig
arm                            pleb_defconfig
sh                               j2_defconfig
mips                           ci20_defconfig
xtensa                          iss_defconfig
s390                             allyesconfig
arm                        mini2440_defconfig
xtensa                           allyesconfig
m68k                            q40_defconfig
sh                           se7721_defconfig
arm                           tegra_defconfig
arm                        cerfcube_defconfig
arm                           corgi_defconfig
xtensa                  audio_kc705_defconfig
arm                            lart_defconfig
sh                          r7785rp_defconfig
sh                        sh7763rdp_defconfig
powerpc                     sequoia_defconfig
sh                         microdev_defconfig
riscv                            allyesconfig
arm                      jornada720_defconfig
um                                  defconfig
powerpc                        cell_defconfig
sh                                  defconfig
powerpc                    klondike_defconfig
arm                       imx_v6_v7_defconfig
sh                           se7206_defconfig
powerpc                         wii_defconfig
mips                        bcm47xx_defconfig
powerpc                     taishan_defconfig
um                           x86_64_defconfig
arm                           h3600_defconfig
parisc                generic-64bit_defconfig
sh                           se7619_defconfig
arm                           h5000_defconfig
arm                        multi_v7_defconfig
ia64                         bigsur_defconfig
sh                          landisk_defconfig
alpha                            allyesconfig
powerpc                      ep88xc_defconfig
h8300                       h8s-sim_defconfig
powerpc                     mpc83xx_defconfig
powerpc                 mpc834x_mds_defconfig
m68k                       m5208evb_defconfig
mips                  decstation_64_defconfig
m68k                       bvme6000_defconfig
mips                             allyesconfig
x86_64                           alldefconfig
powerpc                 canyonlands_defconfig
m68k                          hp300_defconfig
mips                         mpc30x_defconfig
powerpc                        warp_defconfig
powerpc                 mpc837x_mds_defconfig
arm                           viper_defconfig
sh                          sdk7786_defconfig
powerpc                 mpc837x_rdb_defconfig
arm                        keystone_defconfig
openrisc                 simple_smp_defconfig
xtensa                generic_kc705_defconfig
powerpc                       holly_defconfig
powerpc                      mgcoge_defconfig
mips                     loongson1b_defconfig
arc                         haps_hs_defconfig
sh                               allmodconfig
m68k                           sun3_defconfig
powerpc                     rainier_defconfig
arm                           sama5_defconfig
m68k                          sun3x_defconfig
sh                        sh7757lcr_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220519
arm                  randconfig-c002-20220522
ia64                                defconfig
riscv                             allnoconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
nios2                            allyesconfig
alpha                               defconfig
h8300                            allyesconfig
s390                                defconfig
s390                             allmodconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
sparc                               defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a003
i386                          randconfig-a005
i386                          randconfig-a001
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220519
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
arm                  randconfig-c002-20220522
x86_64                        randconfig-c007
i386                          randconfig-c001
powerpc              randconfig-c003-20220522
riscv                randconfig-c006-20220522
mips                 randconfig-c004-20220522
mips                      pic32mzda_defconfig
mips                     loongson2k_defconfig
mips                      malta_kvm_defconfig
arm                              alldefconfig
arm                          ixp4xx_defconfig
powerpc                     tqm5200_defconfig
i386                             allyesconfig
powerpc                          g5_defconfig
powerpc                    socrates_defconfig
mips                           ip22_defconfig
arm                       spear13xx_defconfig
mips                           rs90_defconfig
arm                        mvebu_v5_defconfig
powerpc                  mpc885_ads_defconfig
powerpc                    gamecube_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220519
riscv                randconfig-r042-20220519
hexagon              randconfig-r041-20220519
s390                 randconfig-r044-20220519

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
