Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F37284BD262
	for <lists+linux-wireless@lfdr.de>; Sun, 20 Feb 2022 23:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245184AbiBTWnV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 20 Feb 2022 17:43:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245198AbiBTWnT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 20 Feb 2022 17:43:19 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272DA23BC0
        for <linux-wireless@vger.kernel.org>; Sun, 20 Feb 2022 14:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645396978; x=1676932978;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=jZXYoitMwHOAWjKMwEYMaPtrbmIfR9dO9bppXvJJaQE=;
  b=fbbZgDX2uU3MP56Up1eg52lSvCaaq2tJSexs6HPKmYa2vCGj3+zD1XtJ
   Hi7osdxnZqCsZdKFJoDMGyYk3IEZYubytXsN9eRrdNmAl0qGw2uGnmJgf
   3L9f4dUgno2V0umcya9ItPtnRxxsp2hATTZj4dm5tZ3j/y/OUPjWlKcDg
   Sv8k+Bkkh9J8xLTO2pmgBwvk/qnyyEwKn42rgazYhz3i1snv9A5IXIqvK
   vrq8uzwUB8V9WzL57t467EBpkhBv2m2c1R4ztFKcZBRc8C5O2k8WKfie1
   abXRBJBXietSVEw8xCSY6XUAcRjvvhkgVdtPSv0zPnLn2FJns24HPRnn3
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10264"; a="251159055"
X-IronPort-AV: E=Sophos;i="5.88,384,1635231600"; 
   d="scan'208";a="251159055"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2022 14:42:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,384,1635231600"; 
   d="scan'208";a="531628742"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 20 Feb 2022 14:42:56 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nLuut-0000xT-Gk; Sun, 20 Feb 2022 22:42:55 +0000
Date:   Mon, 21 Feb 2022 06:42:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [wireless-next:pending] BUILD SUCCESS
 5b0209e5d955f7af5afcd6b73626bcbfdcb68bcb
Message-ID: <6212c3e1.tsH/XCjydyskrUQt%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git pending
branch HEAD: 5b0209e5d955f7af5afcd6b73626bcbfdcb68bcb  Merge tag 'iwlwifi-next-for-kalle-2022-02-18' of git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next into pending

elapsed time: 812m

configs tested: 112
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                               defconfig
arm                              allmodconfig
arm                              allyesconfig
arm64                            allyesconfig
i386                          randconfig-c001
sh                          landisk_defconfig
powerpc                     redwood_defconfig
arm                          badge4_defconfig
arm                           u8500_defconfig
m68k                        stmark2_defconfig
mips                     decstation_defconfig
arm                       multi_v4t_defconfig
sh                                  defconfig
sh                          rsk7269_defconfig
ia64                                defconfig
sh                         apsh4a3a_defconfig
sh                   sh7770_generic_defconfig
m68k                        m5272c3_defconfig
powerpc                    klondike_defconfig
alpha                               defconfig
xtensa                              defconfig
powerpc                      pcm030_defconfig
mips                       bmips_be_defconfig
h8300                            alldefconfig
um                           x86_64_defconfig
sh                           se7751_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220220
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                            allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
arc                                 defconfig
sh                               allmodconfig
h8300                            allyesconfig
xtensa                           allyesconfig
parisc                              defconfig
parisc64                            defconfig
s390                             allmodconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
i386                          randconfig-a003
i386                          randconfig-a005
i386                          randconfig-a001
x86_64                        randconfig-a011
x86_64                        randconfig-a015
x86_64                        randconfig-a013
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220220
riscv                randconfig-r042-20220220
s390                 randconfig-r044-20220220
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
powerpc              randconfig-c003-20220220
x86_64                        randconfig-c007
arm                  randconfig-c002-20220220
mips                 randconfig-c004-20220220
i386                          randconfig-c001
riscv                randconfig-c006-20220220
arm                            dove_defconfig
powerpc                          allyesconfig
arm                         shannon_defconfig
mips                           ip28_defconfig
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a015
i386                          randconfig-a011
i386                          randconfig-a013
hexagon              randconfig-r045-20220220
hexagon              randconfig-r041-20220220

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
