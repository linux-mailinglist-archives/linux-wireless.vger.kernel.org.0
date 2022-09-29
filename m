Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8655EEB98
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Sep 2022 04:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234455AbiI2CUK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Sep 2022 22:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234289AbiI2CUH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Sep 2022 22:20:07 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A756585AB6
        for <linux-wireless@vger.kernel.org>; Wed, 28 Sep 2022 19:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664418003; x=1695954003;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=j2EIwAPKqDNQYDQ9f2k70CCuUONqiie0cz1pFCrdp9U=;
  b=lUOaInbJ34WmSzYQ/y8hC/Z7H6SqviJihNkxue+j70MxnQjZSl7COSPL
   xuV5HvAp0gi+PQIFw8LmYCOEpf8s6ZXmqQn+K9ugb2vZU09KwDAcfBmiQ
   ndz0/j7+RYRoQw+JwL+npmtH9ZdQYquRIbxhFRLq1U/Padm4MZxTCM2Or
   ZNDdD3Lsl21WDGh6POzuLT3XzTRZ5LAgKxOmvv7A/5AJswNanjhZ9GFKs
   JJRRBRxPsUnp9saOL/NTA2Znm7ktjUp9+taHQuiTLvOWCJ50OAPk2Egc3
   8j/yjxWJFYeaUFdhHsPmlw6AvUA5NLiAaFP+UEKAw0INpck/42s5c/G3H
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="282136611"
X-IronPort-AV: E=Sophos;i="5.93,353,1654585200"; 
   d="scan'208";a="282136611"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 19:20:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="950938511"
X-IronPort-AV: E=Sophos;i="5.93,353,1654585200"; 
   d="scan'208";a="950938511"
Received: from lkp-server01.sh.intel.com (HELO 6126f2790925) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 28 Sep 2022 19:19:53 -0700
Received: from kbuild by 6126f2790925 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1odj9U-0000RC-25;
        Thu, 29 Sep 2022 02:19:52 +0000
Date:   Thu, 29 Sep 2022 10:19:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [wireless:for-next] BUILD SUCCESS
 44d70bb561dac9363f45787aa93dfca36877ee01
Message-ID: <633500b4.q41TkxMoAv661lX0%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git for-next
branch HEAD: 44d70bb561dac9363f45787aa93dfca36877ee01  Merge tag 'wireless-2022-09-27' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless

elapsed time: 1523m

configs tested: 181
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
alpha                               defconfig
um                             i386_defconfig
um                           x86_64_defconfig
s390                                defconfig
s390                             allmodconfig
s390                             allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
i386                             allyesconfig
i386                                defconfig
i386                 randconfig-a003-20220926
i386                 randconfig-a001-20220926
i386                 randconfig-a006-20220926
i386                 randconfig-a004-20220926
i386                 randconfig-a005-20220926
i386                 randconfig-a002-20220926
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
x86_64               randconfig-a002-20220926
x86_64               randconfig-a001-20220926
x86_64               randconfig-a004-20220926
x86_64               randconfig-a006-20220926
x86_64               randconfig-a005-20220926
x86_64               randconfig-a003-20220926
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
i386                          randconfig-c001
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
arc                  randconfig-r043-20220927
riscv                randconfig-r042-20220927
s390                 randconfig-r044-20220927
arc                  randconfig-r043-20220925
arc                  randconfig-r043-20220926
riscv                randconfig-r042-20220925
s390                 randconfig-r044-20220925
arm                         s3c6400_defconfig
m68k                        m5272c3_defconfig
arm                           stm32_defconfig
arm                           u8500_defconfig
ia64                             alldefconfig
powerpc                   currituck_defconfig
powerpc                     asp8347_defconfig
i386                          randconfig-a001
i386                          randconfig-a005
i386                          randconfig-a003
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
arm                            lart_defconfig
sh                          sdk7786_defconfig
arm                        cerfcube_defconfig
sh                     sh7710voipgw_defconfig
arc                     nsimosci_hs_defconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
m68k                         amcore_defconfig
mips                           xway_defconfig
sh                          lboxre2_defconfig
arm                        mini2440_defconfig
powerpc                     sequoia_defconfig
s390                       zfcpdump_defconfig
sh                           se7750_defconfig
powerpc                      mgcoge_defconfig
riscv                            allyesconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220925
xtensa                  audio_kc705_defconfig
sh                         ap325rxa_defconfig
xtensa                generic_kc705_defconfig
sh                          urquell_defconfig
arm                         nhk8815_defconfig
arm                        multi_v7_defconfig
m68k                          amiga_defconfig
arm                            xcep_defconfig
mips                          rb532_defconfig
nios2                            alldefconfig
sh                          landisk_defconfig
sh                           sh2007_defconfig
sh                            hp6xx_defconfig
sh                      rts7751r2d1_defconfig
loongarch                           defconfig
loongarch                         allnoconfig
loongarch                        allmodconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a015
x86_64                        randconfig-a011
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
m68k                        m5407c3_defconfig
powerpc                      chrp32_defconfig
powerpc                 mpc8540_ads_defconfig
m68k                            q40_defconfig
loongarch                        alldefconfig
powerpc                   motionpro_defconfig
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
ia64                             allmodconfig

clang tested configs:
x86_64                        randconfig-k001
powerpc                 mpc8560_ads_defconfig
powerpc                    ge_imp3a_defconfig
powerpc               mpc834x_itxgp_defconfig
arm                         lpc32xx_defconfig
hexagon              randconfig-r041-20220927
hexagon              randconfig-r045-20220927
arm                            mmp2_defconfig
riscv                             allnoconfig
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
hexagon              randconfig-r041-20220928
hexagon              randconfig-r045-20220928
riscv                randconfig-r042-20220928
s390                 randconfig-r044-20220928
i386                 randconfig-a011-20220926
i386                 randconfig-a013-20220926
i386                 randconfig-a012-20220926
arm                       mainstone_defconfig
mips                        qi_lb60_defconfig
mips                           rs90_defconfig
hexagon              randconfig-r041-20220925
hexagon              randconfig-r041-20220926
hexagon              randconfig-r045-20220925
hexagon              randconfig-r045-20220926
riscv                randconfig-r042-20220926
s390                 randconfig-r044-20220926
i386                 randconfig-a014-20220926
i386                 randconfig-a016-20220926
i386                 randconfig-a015-20220926
x86_64               randconfig-a016-20220926
x86_64               randconfig-a012-20220926
x86_64               randconfig-a014-20220926
x86_64               randconfig-a013-20220926
x86_64               randconfig-a011-20220926
x86_64               randconfig-a015-20220926
powerpc                   microwatt_defconfig
mips                           ip28_defconfig
arm                     davinci_all_defconfig
mips                           ip22_defconfig
hexagon                          alldefconfig
mips                      malta_kvm_defconfig
hexagon                             defconfig
powerpc                     akebono_defconfig
arm                     am200epdkit_defconfig
powerpc                 mpc8313_rdb_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
