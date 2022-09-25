Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 670595E90A9
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Sep 2022 03:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbiIYBfY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 24 Sep 2022 21:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiIYBfX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 24 Sep 2022 21:35:23 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C052738464
        for <linux-wireless@vger.kernel.org>; Sat, 24 Sep 2022 18:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664069722; x=1695605722;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=eVDmcQkz89yfZzDi5dv/MGYivdAXt+aQJSEuYnSz0vI=;
  b=GGXl1HbDv6FrNB8Q7QsnEfLAc71uuNybgJEYaSlEXI7bBampWRt9eh7D
   T5dzzjyaGkm5WdrMB5n0b/dq5kd0Rif3qU7uBrPcetP2P7c7+gSbhXV0N
   JKKPgLMRyedQb523Pih863YgB0B8i1Yy+uoxq5dnjaqG9P2hTZuTepiB9
   CdQWUPOeM/XS33smG0fjZy+zI+RDMBrtCEGpNH1vbqyUpO4CAYgBE+9zg
   ueUdD7GngQ5DEGa7vm6X2YWauJKDu4ofRchXBg3l91H9vB7xTQmuNW4OC
   GNjBO4dL4c0YtTOas4jvIyIAEgt/8lmR9nNkS1+XjO0/4LGCYvmM4Psw5
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10480"; a="302281315"
X-IronPort-AV: E=Sophos;i="5.93,343,1654585200"; 
   d="scan'208";a="302281315"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2022 18:35:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,343,1654585200"; 
   d="scan'208";a="571800673"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 24 Sep 2022 18:35:20 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ocGYC-0007EQ-0N;
        Sun, 25 Sep 2022 01:35:20 +0000
Date:   Sun, 25 Sep 2022 09:35:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [wireless-next:main] BUILD SUCCESS
 f3d8232331a3f4eaac1ab9a8679e5aedb2c33758
Message-ID: <632fb054.Pb9s8Z98khSSE+hd%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: f3d8232331a3f4eaac1ab9a8679e5aedb2c33758  wifi: rtw89: support for enable/disable MSDU aggregation

elapsed time: 725m

configs tested: 63
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
arc                                 defconfig
um                             i386_defconfig
i386                                defconfig
alpha                               defconfig
s390                                defconfig
x86_64                        randconfig-a002
s390                             allmodconfig
x86_64                              defconfig
arm                                 defconfig
x86_64                               rhel-8.3
x86_64                        randconfig-a004
m68k                             allyesconfig
alpha                            allyesconfig
s390                             allyesconfig
arc                  randconfig-r043-20220923
x86_64                           allyesconfig
x86_64                        randconfig-a013
s390                 randconfig-r044-20220923
arc                              allyesconfig
m68k                             allmodconfig
x86_64                          rhel-8.3-func
x86_64                        randconfig-a011
i386                             allyesconfig
i386                          randconfig-a001
x86_64                        randconfig-a006
i386                          randconfig-a005
i386                          randconfig-a003
i386                          randconfig-a014
x86_64                    rhel-8.3-kselftests
riscv                randconfig-r042-20220923
arm64                            allyesconfig
arm                              allyesconfig
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a016
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
ia64                             allmodconfig
sh                               allmodconfig
arc                  randconfig-r043-20220925
riscv                randconfig-r042-20220925
s390                 randconfig-r044-20220925
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm

clang tested configs:
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a013
hexagon              randconfig-r041-20220923
hexagon              randconfig-r045-20220923
x86_64                        randconfig-a016
x86_64                        randconfig-a012
i386                          randconfig-a002
i386                          randconfig-a011
i386                          randconfig-a004
i386                          randconfig-a015
i386                          randconfig-a006
x86_64                        randconfig-a014
hexagon              randconfig-r045-20220925
hexagon              randconfig-r041-20220925

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
