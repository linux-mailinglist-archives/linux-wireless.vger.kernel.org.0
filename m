Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1AD578F55
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Jul 2022 02:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233150AbiGSAeb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Jul 2022 20:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbiGSAea (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Jul 2022 20:34:30 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B50420BE3
        for <linux-wireless@vger.kernel.org>; Mon, 18 Jul 2022 17:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658190869; x=1689726869;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=BIdmT0A3HlqeqU2jYvzzWFvcS1Jus/aj6TaAZCkDr4g=;
  b=EmTpAl/Gsz2Cth5VI3EtQPrE0EUqZeBCVw85EJ1DSLMi5dEvef5yfUp+
   /TviKugiAjLY+MNBJj/UWaTgy5Tf+R13x02OhvdtHNo/U3jRm2keGxV6F
   5EbuLpB9oSnSEk8RUfoeS4QDRG+J8q79/ZJk0sbNHCN5DUH10r3f7Wk+B
   c9e/wwOrQlkAJk25NLmHYiV2Cb74zFlHMlyyWdbOfjU2OW3WRGPAenMB5
   3PvUQ/y8IiUN+OT2513NF4BxpyqSWz5BNIV+z+Z0ti6VCqsqS4DEdHgyg
   n3o1Jy9QM1d/1LThcvMO8tiyHkpEhiObcQPhMhCYVXt8StmEl3VEsTGzo
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10412"; a="287094822"
X-IronPort-AV: E=Sophos;i="5.92,282,1650956400"; 
   d="scan'208";a="287094822"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 17:34:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,282,1650956400"; 
   d="scan'208";a="624952265"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 18 Jul 2022 17:34:27 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oDbBz-00052U-5Y;
        Tue, 19 Jul 2022 00:34:27 +0000
Date:   Tue, 19 Jul 2022 08:34:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [wireless-next:main] BUILD SUCCESS
 f1cee996f1858ba07dce9e377559ea33f318af0f
Message-ID: <62d5fbfc.RlByl7tRszHf+s44%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: f1cee996f1858ba07dce9e377559ea33f318af0f  wifi: wl1251: fix repeated words in comments

elapsed time: 730m

configs tested: 88
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                 randconfig-c001-20220718
m68k                       m5249evb_defconfig
nios2                            allyesconfig
arm                           corgi_defconfig
powerpc                 mpc834x_mds_defconfig
arc                                 defconfig
arm                        spear6xx_defconfig
parisc                generic-32bit_defconfig
sh                   sh7770_generic_defconfig
xtensa                    xip_kc705_defconfig
ia64                      gensparse_defconfig
arm                            pleb_defconfig
arm                             pxa_defconfig
sh                   secureedge5410_defconfig
xtensa                  audio_kc705_defconfig
arm                           tegra_defconfig
nios2                               defconfig
powerpc                 mpc834x_itx_defconfig
sh                           se7619_defconfig
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
loongarch                           defconfig
ia64                             allmodconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
x86_64               randconfig-k001-20220718
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
sh                               allmodconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
i386                             allyesconfig
i386                                defconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
x86_64               randconfig-a014-20220718
x86_64               randconfig-a016-20220718
x86_64               randconfig-a012-20220718
x86_64               randconfig-a013-20220718
x86_64               randconfig-a015-20220718
x86_64               randconfig-a011-20220718
i386                 randconfig-a015-20220718
i386                 randconfig-a011-20220718
i386                 randconfig-a012-20220718
i386                 randconfig-a014-20220718
i386                 randconfig-a016-20220718
i386                 randconfig-a013-20220718
arc                  randconfig-r043-20220718
s390                 randconfig-r044-20220718
riscv                randconfig-r042-20220718
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit

clang tested configs:
mips                        qi_lb60_defconfig
arm                         bcm2835_defconfig
powerpc                    ge_imp3a_defconfig
arm                       aspeed_g4_defconfig
mips                     loongson1c_defconfig
mips                      bmips_stb_defconfig
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                 randconfig-a004-20220718
i386                 randconfig-a001-20220718
i386                 randconfig-a005-20220718
i386                 randconfig-a006-20220718
i386                 randconfig-a002-20220718
i386                 randconfig-a003-20220718
hexagon              randconfig-r041-20220718
hexagon              randconfig-r045-20220718

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
