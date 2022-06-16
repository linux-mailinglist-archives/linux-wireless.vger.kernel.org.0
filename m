Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DBF554D9DD
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jun 2022 07:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356444AbiFPFkO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Jun 2022 01:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358775AbiFPFkG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Jun 2022 01:40:06 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBBDD5A2F2
        for <linux-wireless@vger.kernel.org>; Wed, 15 Jun 2022 22:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655357990; x=1686893990;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=IgDZQlcEQFw6BHRvowZn+s+A00xn0820Ki94srvKfbs=;
  b=V/y5Theqi9pwI5S+PcTTOQ65m2SAMVcPu+vkt4MKCbT+NCEZaD9zjrCY
   CdDt5mMHNhJnkqOUd75iX54n1WjdBdXzWuDWYMrK1uXfyyaO0w87Hrb7Q
   BL8STiXSbcWR42bboE9IJZNcGCMaWWdjQkgJP9UR089UyxyQdx1krhM+X
   63kJk7ufBHL5wYABiFD5jGb4lyJyXkm3ySp8QaECk6+aR5Y73zSNSDckQ
   rCbmi6htCx7WCtqi9Tlvgrtza2VCaxiI/1eGm3Sxz9AWcYAwnlfUmn3O0
   pDbhXxYPmrzqj3Jlhs7bHapLBr8fA01MLPUXQSv47hAn9aebHfpTvpFC8
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10379"; a="259025312"
X-IronPort-AV: E=Sophos;i="5.91,304,1647327600"; 
   d="scan'208";a="259025312"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 22:39:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,304,1647327600"; 
   d="scan'208";a="713233752"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 15 Jun 2022 22:39:48 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o1iEO-000O6L-7G;
        Thu, 16 Jun 2022 05:39:48 +0000
Date:   Thu, 16 Jun 2022 13:39:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [wireless-next:main] BUILD SUCCESS
 8092a0eed4080a33a4c8681f4231c40c0bb7cb5c
Message-ID: <62aac1f8.JiZYUSFegbME8vSl%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 8092a0eed4080a33a4c8681f4231c40c0bb7cb5c  Merge ath-next from git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git

elapsed time: 970m

configs tested: 52
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
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
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
parisc64                            defconfig
s390                             allmodconfig
s390                                defconfig
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
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                            allyesconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
