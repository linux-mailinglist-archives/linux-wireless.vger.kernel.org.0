Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A47BD5F037C
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Sep 2022 06:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbiI3EHd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 30 Sep 2022 00:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbiI3EHa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 30 Sep 2022 00:07:30 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FBF21FBCA5
        for <linux-wireless@vger.kernel.org>; Thu, 29 Sep 2022 21:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664510849; x=1696046849;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=ntXlgDRvQwznxDHtEEur5/jEG2gLhTu7M8IFrPFZOU4=;
  b=BjMxr12Z9F0kUlKJRabXDAWeM93ocTauFE6N9R+3w5ILwmo/LeaKSNPu
   jD9CzFVh+EPv8tKfdg9b5/oz1/N63Xu3HI7/tlwsomI7eFgmPbzmrDWBL
   C8QXGpvakZNgJ8NCl/ErIMG81E8JXMsXJpZ9mS25vxH8h+jg+iqhHRY+b
   l8JYiuYOi7ZG/+qkZVmZm2hZ6yDXHlKc0pIhKqopuGtgHd0xEp7jU2LEc
   nEhBlXUuaSGr6v1GHB+OyYnifWdCqARelHum3ioW7vjZBNLOfA3IKTYHi
   izV6MrYvxxGWGD1uvhkE5ewe2P3kKyZX6xxmmr04uaXcqx8abklWwBJqc
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="281807858"
X-IronPort-AV: E=Sophos;i="5.93,357,1654585200"; 
   d="scan'208";a="281807858"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 21:07:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="573726659"
X-IronPort-AV: E=Sophos;i="5.93,357,1654585200"; 
   d="scan'208";a="573726659"
Received: from lkp-server01.sh.intel.com (HELO 14cc182da2d0) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 29 Sep 2022 21:07:27 -0700
Received: from kbuild by 14cc182da2d0 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oe7J8-00002x-1Z;
        Fri, 30 Sep 2022 04:07:26 +0000
Date:   Fri, 30 Sep 2022 12:06:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [wireless-next:main] BUILD SUCCESS
 2fc6de5c6924aea5e84d2edaa40ed744f0720844
Message-ID: <63366b57.AGbNg1f7py5esAwP%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 2fc6de5c6924aea5e84d2edaa40ed744f0720844  wifi: rtl8xxxu: Improve rtl8xxxu_queue_select

elapsed time: 1240m

configs tested: 133
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
um                             i386_defconfig
x86_64                              defconfig
s390                             allyesconfig
um                           x86_64_defconfig
i386                                defconfig
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz
x86_64                               rhel-8.3
sh                               allmodconfig
x86_64                           allyesconfig
powerpc                          allmodconfig
mips                             allyesconfig
powerpc                           allnoconfig
i386                             allyesconfig
arc                  randconfig-r043-20220925
arc                  randconfig-r043-20220926
s390                 randconfig-r044-20220925
riscv                randconfig-r042-20220925
x86_64               randconfig-a001-20220926
x86_64               randconfig-a002-20220926
x86_64               randconfig-a003-20220926
x86_64               randconfig-a004-20220926
x86_64               randconfig-a006-20220926
i386                 randconfig-a001-20220926
arm                                 defconfig
i386                 randconfig-a004-20220926
i386                 randconfig-a006-20220926
x86_64               randconfig-a005-20220926
i386                 randconfig-a005-20220926
i386                 randconfig-a002-20220926
i386                 randconfig-a003-20220926
arm                              allyesconfig
arm64                            allyesconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
m68k                             allmodconfig
alpha                            allyesconfig
i386                          randconfig-c001
m68k                             allyesconfig
arc                              allyesconfig
m68k                          hp300_defconfig
arc                        vdk_hs38_defconfig
ia64                         bigsur_defconfig
m68k                             alldefconfig
powerpc                   motionpro_defconfig
m68k                         amcore_defconfig
mips                           xway_defconfig
sh                          lboxre2_defconfig
xtensa                  audio_kc705_defconfig
sh                         ap325rxa_defconfig
xtensa                generic_kc705_defconfig
sh                          urquell_defconfig
arm                         nhk8815_defconfig
loongarch                        alldefconfig
sh                        sh7757lcr_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
arm                         s3c6400_defconfig
sh                 kfr2r09-romimage_defconfig
m68k                        m5307c3_defconfig
arm                       omap2plus_defconfig
powerpc                     ep8248e_defconfig
arm                             ezx_defconfig
powerpc                       maple_defconfig
mips                       bmips_be_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
sh                           se7722_defconfig
powerpc                 mpc837x_mds_defconfig
sh                            migor_defconfig
xtensa                          iss_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220925
sh                   secureedge5410_defconfig
mips                      loongson3_defconfig
arc                            hsdk_defconfig
sh                     sh7710voipgw_defconfig
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
ia64                             allmodconfig

clang tested configs:
hexagon              randconfig-r045-20220925
hexagon              randconfig-r045-20220926
hexagon              randconfig-r041-20220925
riscv                randconfig-r042-20220926
s390                 randconfig-r044-20220926
hexagon              randconfig-r041-20220926
x86_64               randconfig-a016-20220926
x86_64               randconfig-a015-20220926
x86_64               randconfig-a013-20220926
x86_64               randconfig-a011-20220926
x86_64               randconfig-a012-20220926
x86_64               randconfig-a014-20220926
i386                 randconfig-a013-20220926
i386                 randconfig-a012-20220926
i386                 randconfig-a011-20220926
i386                 randconfig-a016-20220926
i386                 randconfig-a015-20220926
i386                 randconfig-a014-20220926
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-k001
hexagon              randconfig-r041-20220928
hexagon              randconfig-r045-20220928
riscv                randconfig-r042-20220928
s390                 randconfig-r044-20220928

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
