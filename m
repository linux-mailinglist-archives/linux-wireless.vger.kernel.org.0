Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 276875F4A90
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Oct 2022 22:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbiJDU7l (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 4 Oct 2022 16:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJDU7k (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 4 Oct 2022 16:59:40 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA73D1141
        for <linux-wireless@vger.kernel.org>; Tue,  4 Oct 2022 13:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664917176; x=1696453176;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=LyC2RpaogA3vFzitbbaOTDLxhJsDhyXIJZtQxiN9RBM=;
  b=a/epDVK/rIhR6POU+CN5g3Xp6Se0wERj3cwSMw4JUZQwwOdagB+8kV4f
   WB1AC+X+KoLj6f1T/qf8ii+sX7+L/HtbSq41xrM2894zKcnrNbLtshbAi
   4Z3pzV3mXNt6+A/AkNbJx7Jlg691/DM/l/QfjVLdRcEioBr27F+prgNhf
   ZGc4eI7/pQJ1oTvypm11J1K+1P+WASPtSEWYb3Q7gCyo8GYd/GVs6sCs/
   XTnomrt6YG2yrJ4m6rB+fV0t8TRpPlAhqXDoD3w04Gk+eos+1XbxUNOB+
   phQn1BiUHInxDXjlRLJbYijZSvXvbroziZyTjWXXZiK3jULqYFbDybCig
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="304592954"
X-IronPort-AV: E=Sophos;i="5.95,158,1661842800"; 
   d="scan'208";a="304592954"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 13:59:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="952935083"
X-IronPort-AV: E=Sophos;i="5.95,158,1661842800"; 
   d="scan'208";a="952935083"
Received: from lkp-server01.sh.intel.com (HELO d4f44333118a) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 04 Oct 2022 13:59:34 -0700
Received: from kbuild by d4f44333118a with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ofp0o-0000XF-0v;
        Tue, 04 Oct 2022 20:59:34 +0000
Date:   Wed, 05 Oct 2022 04:59:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [wireless-next:main] BUILD SUCCESS
 5671c8b56c320e17c9d61e8578dc7e6fa4a704ed
Message-ID: <633c9eb4.mzSneAiO5DYm19J9%lkp@intel.com>
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
branch HEAD: 5671c8b56c320e17c9d61e8578dc7e6fa4a704ed  brcmfmac: dump dongle memory when attaching failed

elapsed time: 721m

configs tested: 57
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-kvm
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
i386                                defconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
i386                 randconfig-a011-20221003
i386                 randconfig-a016-20221003
i386                 randconfig-a012-20221003
i386                 randconfig-a014-20221003
i386                 randconfig-a015-20221003
i386                 randconfig-a013-20221003
x86_64               randconfig-a011-20221003
x86_64               randconfig-a016-20221003
x86_64               randconfig-a014-20221003
x86_64               randconfig-a013-20221003
x86_64               randconfig-a012-20221003
x86_64               randconfig-a015-20221003
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
riscv                randconfig-r042-20221003
arc                  randconfig-r043-20221003
arc                  randconfig-r043-20221002
s390                 randconfig-r044-20221003
i386                             allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
ia64                             allmodconfig

clang tested configs:
i386                 randconfig-a001-20221003
i386                 randconfig-a006-20221003
i386                 randconfig-a002-20221003
i386                 randconfig-a003-20221003
i386                 randconfig-a005-20221003
i386                 randconfig-a004-20221003
x86_64               randconfig-a003-20221003
x86_64               randconfig-a005-20221003
x86_64               randconfig-a001-20221003
x86_64               randconfig-a004-20221003
x86_64               randconfig-a002-20221003
x86_64               randconfig-a006-20221003

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
