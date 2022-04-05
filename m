Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA5994F3042
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Apr 2022 14:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346530AbiDEJzL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 Apr 2022 05:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347990AbiDEJ3A (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 Apr 2022 05:29:00 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6335DFF9E
        for <linux-wireless@vger.kernel.org>; Tue,  5 Apr 2022 02:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649150157; x=1680686157;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=ErHXiJAgPHy14hHLapHHdqwUIsS5VH7Das9sv9pl0+Y=;
  b=DrbaXN7uQvYw4qmWOgC4SLPiyPDdI2v5bXeB8BAx51kGyn3kavvHC0aF
   I1Q9FZ2qqPJgNWwl+nYFAAMJywT+Bip3sr6KFkIdWTJEhh16Iwooj3Zt7
   Qr8HZyOrBOS2vXvXIt+6LSmnmqvqnpDbLcbCTp8fkMqK67wIq4KdJiX/4
   mX0hiwzgg90yt3FaFErqz/kUyfPxFIW1YYzvI+V7mS6+LpKFHZQle7Gdw
   1KjhPxJBorQt4yxE3Ed7k0Ov60sCEjwhK9Luqa//XZKflPqrE3e+5tM73
   vgspFTxc0NlcYo9hsIq0wbfvUiCWpPT4YN5lgdf+JVKGfG5gTg+y8b0Kv
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10307"; a="323878009"
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="323878009"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 02:15:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="721977604"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 05 Apr 2022 02:15:55 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nbfI2-0002v5-E8;
        Tue, 05 Apr 2022 09:15:54 +0000
Date:   Tue, 05 Apr 2022 17:14:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [wireless:main] BUILD SUCCESS
 10cb21f4ff3f9cb36d1e1c39bf80426f02f4986a
Message-ID: <624c0893.H+pcHax2I33777uS%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git main
branch HEAD: 10cb21f4ff3f9cb36d1e1c39bf80426f02f4986a  Revert "ath11k: mesh: add support for 256 bitmap in blockack frames in 11ax"

elapsed time: 829m

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
arm                         s3c6400_defconfig
mips                         db1xxx_defconfig
openrisc                 simple_smp_defconfig
arm                         at91_dt_defconfig
arm                         lpc18xx_defconfig
sh                           se7343_defconfig
sh                         ap325rxa_defconfig
arm                       imx_v6_v7_defconfig
arc                        vdk_hs38_defconfig
sh                           se7751_defconfig
m68k                       m5475evb_defconfig
arc                           tb10x_defconfig
sh                          sdk7786_defconfig
powerpc                        cell_defconfig
powerpc                      chrp32_defconfig
csky                             alldefconfig
mips                    maltaup_xpa_defconfig
arm                           stm32_defconfig
powerpc                     pq2fads_defconfig
powerpc                 mpc837x_mds_defconfig
ia64                          tiger_defconfig
powerpc                     stx_gp3_defconfig
parisc                           alldefconfig
powerpc                  storcenter_defconfig
powerpc                      tqm8xx_defconfig
mips                       capcella_defconfig
mips                     loongson1b_defconfig
arm                          pxa910_defconfig
openrisc                  or1klitex_defconfig
mips                           jazz_defconfig
sh                ecovec24-romimage_defconfig
sh                     magicpanelr2_defconfig
sh                        edosk7760_defconfig
powerpc                  iss476-smp_defconfig
sh                           se7750_defconfig
powerpc                      pcm030_defconfig
sh                  sh7785lcr_32bit_defconfig
xtensa                generic_kc705_defconfig
m68k                       m5249evb_defconfig
m68k                       m5275evb_defconfig
sh                     sh7710voipgw_defconfig
powerpc                      pasemi_defconfig
powerpc                      arches_defconfig
i386                                defconfig
sh                            migor_defconfig
sh                 kfr2r09-romimage_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220405
ia64                             allmodconfig
ia64                             allyesconfig
ia64                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                                defconfig
s390                             allmodconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                             allyesconfig
sparc                               defconfig
sparc                            allyesconfig
i386                             allyesconfig
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
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                            allyesconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3

clang tested configs:
x86_64                        randconfig-c007
i386                          randconfig-c001
powerpc              randconfig-c003-20220405
riscv                randconfig-c006-20220405
mips                 randconfig-c004-20220405
arm                  randconfig-c002-20220405
arm                         lpc32xx_defconfig
powerpc                     ksi8560_defconfig
arm                  colibri_pxa300_defconfig
mips                     loongson1c_defconfig
arm                        neponset_defconfig
mips                         tb0219_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a006
i386                          randconfig-a002
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
hexagon              randconfig-r045-20220405
riscv                randconfig-r042-20220405
hexagon              randconfig-r041-20220405

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
