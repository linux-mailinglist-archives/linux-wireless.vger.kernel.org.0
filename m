Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EFB25F1F82
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Oct 2022 22:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbiJAUs4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 1 Oct 2022 16:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiJAUsz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 1 Oct 2022 16:48:55 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC32564C5
        for <linux-wireless@vger.kernel.org>; Sat,  1 Oct 2022 13:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664657334; x=1696193334;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=t/Lhd0RDMgMPnL3bJzgqXdjzLfGK7D0HoQY3hl+z3QQ=;
  b=h3f6/f2rJTndiaRVO4hgTinG9EgAb1UBlF9lJYINXnOAw3dZQtdnTgsN
   /gO2dbIrT7edRy9W1EwmcAeCh3/2jSip3WyeKGCm5lnWSSrSR8dihWvWo
   /uGwCyc6lK2c8rbaO/Df2YIXE1G6519C68hxYUY53bqXGCf5v+0S3iCCa
   8ub9tgDReYpDQ711yPhQVU4TiVKfGiMo9ixgcL24jHImhwwy4Smmo6k/z
   CMA1fnSo4wekoIP0lJMkg7B4mgyj/am8yzTNQD6DgWnXokz4dp0J1wdZP
   /2WZUGfpr3MUAPsVHmStFz+jm8Qq0abIsmFwa247p6+iTjZfz8CF9p61/
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10487"; a="303903627"
X-IronPort-AV: E=Sophos;i="5.93,361,1654585200"; 
   d="scan'208";a="303903627"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2022 13:48:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10487"; a="653928607"
X-IronPort-AV: E=Sophos;i="5.93,361,1654585200"; 
   d="scan'208";a="653928607"
Received: from lkp-server01.sh.intel.com (HELO 14cc182da2d0) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 01 Oct 2022 13:48:52 -0700
Received: from kbuild by 14cc182da2d0 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oejPn-0002hT-1u;
        Sat, 01 Oct 2022 20:48:51 +0000
Date:   Sun, 02 Oct 2022 04:48:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [wireless-next:main] BUILD SUCCESS
 915b96c52763e2988e6368b538b487a7138b8fa4
Message-ID: <6338a786.wdeRti92+28qGZCE%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,LONGWORDS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 915b96c52763e2988e6368b538b487a7138b8fa4  Merge tag 'wireless-next-2022-09-30' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next

elapsed time: 1584m

configs tested: 132
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
s390                                defconfig
x86_64                           rhel-8.3-syz
powerpc                           allnoconfig
x86_64                         rhel-8.3-kunit
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-kvm
i386                                defconfig
m68k                             allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
sh                               allmodconfig
x86_64                           allyesconfig
mips                             allyesconfig
i386                             allyesconfig
i386                 randconfig-a001-20220926
powerpc                          allmodconfig
i386                 randconfig-a002-20220926
i386                 randconfig-a003-20220926
riscv                randconfig-r042-20220925
i386                 randconfig-a006-20220926
arc                  randconfig-r043-20220925
i386                 randconfig-a004-20220926
arm                                 defconfig
i386                 randconfig-a005-20220926
arc                  randconfig-r043-20220926
arc                  randconfig-r043-20220928
s390                 randconfig-r044-20220925
arm64                            allyesconfig
arm                              allyesconfig
x86_64                        randconfig-a002
x86_64               randconfig-a004-20220926
x86_64                        randconfig-a004
x86_64                        randconfig-a013
x86_64               randconfig-a001-20220926
x86_64               randconfig-a006-20220926
x86_64               randconfig-a003-20220926
x86_64               randconfig-a005-20220926
x86_64               randconfig-a002-20220926
x86_64                        randconfig-a015
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                        randconfig-a011
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
i386                          randconfig-c001
arm                         lpc18xx_defconfig
arm                       aspeed_g5_defconfig
mips                  maltasmvp_eva_defconfig
arm                           h5000_defconfig
m68k                          atari_defconfig
powerpc                      chrp32_defconfig
sh                        edosk7705_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
loongarch                           defconfig
loongarch                         allnoconfig
loongarch                        allmodconfig
arm                           stm32_defconfig
powerpc                mpc7448_hpc2_defconfig
arc                    vdk_hs38_smp_defconfig
arm                            xcep_defconfig
arm                          simpad_defconfig
m68k                           sun3_defconfig
sh                      rts7751r2d1_defconfig
alpha                            alldefconfig
m68k                        m5307c3_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220925
powerpc                        warp_defconfig
arc                      axs103_smp_defconfig
ia64                             allmodconfig

clang tested configs:
hexagon              randconfig-r045-20220925
hexagon              randconfig-r045-20220926
hexagon              randconfig-r041-20220926
hexagon              randconfig-r041-20220925
hexagon              randconfig-r045-20220928
riscv                randconfig-r042-20220926
s390                 randconfig-r044-20220928
s390                 randconfig-r044-20220926
i386                 randconfig-a016-20220926
x86_64               randconfig-a014-20220926
i386                 randconfig-a015-20220926
i386                 randconfig-a012-20220926
hexagon              randconfig-r041-20220928
i386                 randconfig-a011-20220926
riscv                randconfig-r042-20220928
x86_64               randconfig-a013-20220926
i386                 randconfig-a013-20220926
x86_64               randconfig-a011-20220926
x86_64               randconfig-a012-20220926
x86_64               randconfig-a016-20220926
i386                 randconfig-a014-20220926
x86_64                        randconfig-a001
x86_64               randconfig-a015-20220926
x86_64                        randconfig-a003
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-k001
riscv                    nommu_virt_defconfig
powerpc                        icon_defconfig
x86_64                        randconfig-a016
arm                          pxa168_defconfig
powerpc                 mpc832x_mds_defconfig
x86_64                        randconfig-a005

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
