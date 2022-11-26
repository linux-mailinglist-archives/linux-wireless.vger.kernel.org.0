Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F33863982D
	for <lists+linux-wireless@lfdr.de>; Sat, 26 Nov 2022 20:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbiKZTzB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 26 Nov 2022 14:55:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiKZTzA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 26 Nov 2022 14:55:00 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B7D23E
        for <linux-wireless@vger.kernel.org>; Sat, 26 Nov 2022 11:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669492497; x=1701028497;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=mNIpcM6y8s3UxkfoZggmYXqItSKnOKKhfiwTmJGAkos=;
  b=MJrEKWDCYWjYId90ZTDkm6C+Woa5vGpoCNrfpNLFsITQ+jreNW/e1G/b
   6duJfm+uahbeplDavZFywLMs/TtZs/aJfoPvgvA2C0RLuubzCs6vxR/JD
   tKiQVn4Hg7dxiXlVcVdueUnA46Myyig+0ysTLenfXR1QumNkGPDbjHkA/
   BG2aDeIKp1FbfzT9bY1G1XEwcPe6TA9BcedRIjWnzpo57ldvWOsINL66t
   YSXHVZEIMj6cCXuJeo5J2zz6CLUZdhqw8rn++xjEGAIj2RH5KCTtwZS6F
   Ypswp9aB5hFpcwVCiIVHWQVccjVRueheq4aYAcWta28/AX28Gj8avDvtk
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10543"; a="314655630"
X-IronPort-AV: E=Sophos;i="5.96,196,1665471600"; 
   d="scan'208";a="314655630"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2022 11:54:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10543"; a="642976192"
X-IronPort-AV: E=Sophos;i="5.96,196,1665471600"; 
   d="scan'208";a="642976192"
Received: from lkp-server01.sh.intel.com (HELO 64a2d449c951) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 26 Nov 2022 11:54:55 -0800
Received: from kbuild by 64a2d449c951 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oz1GI-0006ZB-2E;
        Sat, 26 Nov 2022 19:54:54 +0000
Date:   Sun, 27 Nov 2022 03:54:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>
Subject: [wireless:for-next] BUILD SUCCESS
 3e8f7abcc3473bc9603323803aeaed4ffcc3a2ab
Message-ID: <63826eed.Yo/Brar8e/rmtSjO%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git for-next
branch HEAD: 3e8f7abcc3473bc9603323803aeaed4ffcc3a2ab  wifi: mac8021: fix possible oob access in ieee80211_get_rate_duration

elapsed time: 1829m

configs tested: 68
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                  randconfig-r043-20221124
arc                                 defconfig
alpha                               defconfig
um                             i386_defconfig
arc                  randconfig-r043-20221125
um                           x86_64_defconfig
s390                 randconfig-r044-20221125
riscv                randconfig-r042-20221125
s390                                defconfig
s390                             allmodconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
s390                             allyesconfig
ia64                             allmodconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
arc                              allyesconfig
sh                               allmodconfig
alpha                            allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                        randconfig-a015
x86_64                           allyesconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a002
x86_64                        randconfig-a006
x86_64                        randconfig-a004
i386                          randconfig-a005
i386                          randconfig-a001
i386                          randconfig-a003
i386                                defconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
i386                             allyesconfig
x86_64                            allnoconfig
i386                          randconfig-c001
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig

clang tested configs:
riscv                randconfig-r042-20221124
hexagon              randconfig-r041-20221124
hexagon              randconfig-r045-20221124
s390                 randconfig-r044-20221124
hexagon              randconfig-r045-20221125
hexagon              randconfig-r041-20221125
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a012
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a004
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                        randconfig-k001
arm                        mvebu_v5_defconfig
powerpc                     akebono_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
