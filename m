Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A381527970
	for <lists+linux-wireless@lfdr.de>; Sun, 15 May 2022 21:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238383AbiEOTWf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 15 May 2022 15:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiEOTWe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 15 May 2022 15:22:34 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCFB322BD7
        for <linux-wireless@vger.kernel.org>; Sun, 15 May 2022 12:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652642553; x=1684178553;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=L423Nc+0s9W4OIhmaTybKmHZki+QBuh1vQ2fQQ5jdjc=;
  b=KdTt/9brHZ1h1yz4WTTV415lZ2vm8psknZbpUMJximNgC20zak42GbkJ
   D49VERRGl0xjcrwcORrE/0KfQvP9OkekqiWzYCv2uyk0hPnr+nu/w+KXH
   QpfYZgcUb7Ab7XlntWim8b0RjvgBkMu1ZX42samLStJgzUEaS0j19i2Tx
   +yWcBIZCLXcOWoIHtrctdR1jvxBT13bqgPZB+nunMq5HmUSaguX0yMAg+
   6iW0GAUMRRbezanzQNEnPhKqMRHcNbm5DSYIMs4+r8mXcwLFRZyfw7qzs
   Bn2c84dwSGR7vGBw6CDB1FUOPY1L4J8QrgCuLveKDVHjxt+R9Gihug182
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10348"; a="270367240"
X-IronPort-AV: E=Sophos;i="5.91,228,1647327600"; 
   d="scan'208";a="270367240"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2022 12:22:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,228,1647327600"; 
   d="scan'208";a="699242091"
Received: from lkp-server01.sh.intel.com (HELO d1462bc4b09b) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 15 May 2022 12:22:29 -0700
Received: from kbuild by d1462bc4b09b with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nqJoy-0001vV-9I;
        Sun, 15 May 2022 19:22:28 +0000
Date:   Mon, 16 May 2022 03:22:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>
Subject: [wireless-next:mld] BUILD SUCCESS
 e530de7bdb0bff462c9b8c7f4ac36df378a21d23
Message-ID: <628152e0.SavnwxafMUWyTm5Z%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git mld
branch HEAD: e530de7bdb0bff462c9b8c7f4ac36df378a21d23  mac80211: move interface config to new struct

elapsed time: 4530m

configs tested: 116
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                              allmodconfig
arm                              allyesconfig
arm                                 defconfig
arm64                               defconfig
arm64                            allyesconfig
i386                          randconfig-c001
h8300                     edosk2674_defconfig
mips                        bcm47xx_defconfig
arm                            hisi_defconfig
sh                      rts7751r2d1_defconfig
sh                              ul2_defconfig
sh                           se7712_defconfig
arm                         axm55xx_defconfig
nios2                         3c120_defconfig
m68k                       bvme6000_defconfig
i386                             alldefconfig
sh                         ecovec24_defconfig
ia64                         bigsur_defconfig
m68k                        mvme147_defconfig
mips                       capcella_defconfig
arm                     eseries_pxa_defconfig
parisc                generic-64bit_defconfig
arm                        cerfcube_defconfig
mips                           gcw0_defconfig
parisc                generic-32bit_defconfig
sh                            hp6xx_defconfig
sh                           se7751_defconfig
sh                          rsk7264_defconfig
sh                        sh7763rdp_defconfig
powerpc                     stx_gp3_defconfig
arm                  randconfig-c002-20220512
x86_64                        randconfig-c001
ia64                             allmodconfig
ia64                             allyesconfig
ia64                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
alpha                               defconfig
csky                                defconfig
nios2                            allyesconfig
alpha                            allyesconfig
sh                               allmodconfig
arc                                 defconfig
h8300                            allyesconfig
xtensa                           allyesconfig
s390                                defconfig
s390                             allmodconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                             allyesconfig
sparc                               defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220512
riscv                randconfig-r042-20220512
s390                 randconfig-r044-20220512
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                            allyesconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                                  kexec
x86_64                           rhel-8.3-syz
x86_64                          rhel-8.3-func
x86_64                               rhel-8.3
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests

clang tested configs:
powerpc                     tqm5200_defconfig
powerpc                      ppc64e_defconfig
x86_64                           allyesconfig
arm                         orion5x_defconfig
arm                      pxa255-idp_defconfig
mips                      pic32mzda_defconfig
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r041-20220512
hexagon              randconfig-r045-20220512

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
