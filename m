Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4D457EAF7
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Jul 2022 03:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236191AbiGWBHv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Jul 2022 21:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiGWBHu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Jul 2022 21:07:50 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703CB165B6
        for <linux-wireless@vger.kernel.org>; Fri, 22 Jul 2022 18:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658538470; x=1690074470;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=39SvezPEcd3lhw/EVikU/PjuLvirGx1slk23UhDKN8k=;
  b=AwZsT6UT3Fjn8KiTc1ZjEaE05M2NNGLr13P2qI1P+d0SMbwFs7YrcbVw
   Pw/GZuWZG9iBXAVGFLxCuQ/2ZJiPMY0EWxunYHEqfIRg/nOiVb150XFQ2
   INjdRWcNte+fkEe/MkmaNOOa+hHMkHiYOc4z/S1hZfTLTPZxG+iF8uYDj
   MYxzcDE3EIxZVeMUuQ5pLQyBxMntuWqK9ZhEj3bC6eFa+jLmrE16bohOK
   qx2P1jzFW58UfXDyHOFYfwCJ5IpHbdd4bG/lYsCCon0aF6A9TI1ovZrjs
   S3lEXhg4A3j1jo1Aek66IneB+pYGYTVM9qkmjxQn9BXzbjzYaA12qrI7b
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10416"; a="267827810"
X-IronPort-AV: E=Sophos;i="5.93,186,1654585200"; 
   d="scan'208";a="267827810"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2022 18:07:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,186,1654585200"; 
   d="scan'208";a="657418184"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 22 Jul 2022 18:07:48 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oF3cS-00020F-0w;
        Sat, 23 Jul 2022 01:07:48 +0000
Date:   Sat, 23 Jul 2022 09:07:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>
Subject: [wireless-next:main] BUILD SUCCESS
 fa28981b35128132aeb69a0a2ea2ff1c49bea6d9
Message-ID: <62db49bd.T01bdupViJLcrJRC%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: fa28981b35128132aeb69a0a2ea2ff1c49bea6d9  wifi: mac80211: fix link data leak

elapsed time: 722m

configs tested: 100
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
arc                        nsim_700_defconfig
sparc                       sparc64_defconfig
s390                             allmodconfig
m68k                       bvme6000_defconfig
m68k                          atari_defconfig
sh                          r7785rp_defconfig
m68k                                defconfig
powerpc                 mpc834x_itx_defconfig
m68k                             allyesconfig
arm                        realview_defconfig
sh                             sh03_defconfig
xtensa                           alldefconfig
powerpc                     sequoia_defconfig
sh                        apsh4ad0a_defconfig
csky                             alldefconfig
mips                           ip32_defconfig
arm                            xcep_defconfig
arm                           h5000_defconfig
mips                         db1xxx_defconfig
mips                            ar7_defconfig
loongarch                           defconfig
m68k                            mac_defconfig
powerpc                       ppc64_defconfig
csky                                defconfig
arm                          gemini_defconfig
powerpc                      mgcoge_defconfig
sh                           se7751_defconfig
arc                    vdk_hs38_smp_defconfig
alpha                               defconfig
parisc64                         alldefconfig
s390                                defconfig
arc                                 defconfig
s390                             allyesconfig
loongarch                         allnoconfig
ia64                             allmodconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
i386                                defconfig
i386                             allyesconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a002
x86_64                        randconfig-a004
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
x86_64                        randconfig-a006
arc                  randconfig-r043-20220721
arc                  randconfig-r043-20220722
riscv                randconfig-r042-20220722
s390                 randconfig-r044-20220722
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
arm                          ixp4xx_defconfig
powerpc                  mpc866_ads_defconfig
arm                         hackkit_defconfig
arm                  colibri_pxa300_defconfig
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
i386                          randconfig-a015
i386                          randconfig-a013
i386                          randconfig-a011
hexagon              randconfig-r041-20220721
hexagon              randconfig-r045-20220721
riscv                randconfig-r042-20220721
hexagon              randconfig-r041-20220722
hexagon              randconfig-r045-20220722
s390                 randconfig-r044-20220721

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
