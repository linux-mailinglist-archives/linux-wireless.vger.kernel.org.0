Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8DE5477DE
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jun 2022 01:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiFKWuw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 11 Jun 2022 18:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiFKWuu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 11 Jun 2022 18:50:50 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19FC36AA4F
        for <linux-wireless@vger.kernel.org>; Sat, 11 Jun 2022 15:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654987850; x=1686523850;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=CuCeoguGctaO9ftlnqR7iJG0ODbf2ZmWUp8hnOK/RD4=;
  b=i5omBIukgCN95kDxpo9Z3/AaZnVmpkWaOVmTHn5vCJ9kS/kyiO1twn8W
   x/kwrKJPBFXlR864Un1E1ERpnM8I2YgAvjK3bt0jH2c6VKqwhI4DwfjpQ
   FfOJhRglN0X+0wjplYQsQc1oZU46gAm7/zdLW27OTwbIG1/z2dvsK9cYb
   homA7PEvir2QGoBxQz3MhH/rw05RAwj6dZIQEO5Gci15VZjt+VOPDWVrc
   y6qMPiWcrFMOKdKzNHiNxo5HID2Ln/ieqJQyU1Hvddo8sswdFIw3E9xpg
   GQ9iOj5D8eVGkjnqo6whgMXvDDQypx99ItGND7Ggtb7pQpRB1oSv+++pq
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10375"; a="303343587"
X-IronPort-AV: E=Sophos;i="5.91,294,1647327600"; 
   d="scan'208";a="303343587"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2022 15:50:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,294,1647327600"; 
   d="scan'208";a="672555533"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Jun 2022 15:50:47 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o09wN-000JOH-0n;
        Sat, 11 Jun 2022 22:50:47 +0000
Date:   Sun, 12 Jun 2022 06:49:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [wireless-next:main] BUILD SUCCESS
 b97dcb85750b7e8bc5aaed5403ddf4b0552c7993
Message-ID: <62a51c15.GkEQRHU46GspnOWf%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: b97dcb85750b7e8bc5aaed5403ddf4b0552c7993  Merge tag 'wireless-next-2022-06-10' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next

elapsed time: 1702m

configs tested: 130
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
ia64                         bigsur_defconfig
m68k                        m5272c3_defconfig
sh                            titan_defconfig
powerpc                 mpc837x_mds_defconfig
mips                         tb0226_defconfig
powerpc64                           defconfig
sh                          rsk7201_defconfig
powerpc                 canyonlands_defconfig
sh                          lboxre2_defconfig
xtensa                           allyesconfig
sh                           se7780_defconfig
mips                         cobalt_defconfig
xtensa                generic_kc705_defconfig
powerpc                      makalu_defconfig
powerpc                        cell_defconfig
s390                          debug_defconfig
powerpc                      tqm8xx_defconfig
h8300                            allyesconfig
arm                           h5000_defconfig
mips                       capcella_defconfig
riscv             nommu_k210_sdcard_defconfig
sh                   secureedge5410_defconfig
powerpc                      ep88xc_defconfig
powerpc                       maple_defconfig
sh                     magicpanelr2_defconfig
arm                          badge4_defconfig
riscv                    nommu_k210_defconfig
sparc64                             defconfig
sh                           se7750_defconfig
arm64                            alldefconfig
sh                           sh2007_defconfig
arm                            pleb_defconfig
m68k                        m5307c3_defconfig
powerpc                     ep8248e_defconfig
powerpc                      mgcoge_defconfig
nios2                               defconfig
m68k                          amiga_defconfig
sh                         microdev_defconfig
um                           x86_64_defconfig
sh                   sh7770_generic_defconfig
arc                    vdk_hs38_smp_defconfig
powerpc                    adder875_defconfig
openrisc                  or1klitex_defconfig
arm                             pxa_defconfig
powerpc                      ppc40x_defconfig
xtensa                           alldefconfig
mips                          rb532_defconfig
arm                          pxa3xx_defconfig
sh                            shmin_defconfig
powerpc                     tqm8541_defconfig
sh                                  defconfig
sh                        sh7785lcr_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220611
ia64                                defconfig
riscv                             allnoconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
arc                              allyesconfig
alpha                               defconfig
csky                                defconfig
alpha                            allyesconfig
nios2                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
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
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                randconfig-r042-20220611
arc                  randconfig-r043-20220611
s390                 randconfig-r044-20220611
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                            allyesconfig
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
hexagon                          alldefconfig
arm                          ep93xx_defconfig
x86_64                        randconfig-k001
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

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
