Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4F5D606F22
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Oct 2022 07:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbiJUFIX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Oct 2022 01:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJUFIW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Oct 2022 01:08:22 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5798321E126
        for <linux-wireless@vger.kernel.org>; Thu, 20 Oct 2022 22:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666328899; x=1697864899;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=tYr+b8VhS2bMheGQZOhmUMPOoWkRuBdRzShgPrbFG3I=;
  b=b2je5sZUDdj0y2qtDN1ZGc3MxHsJaiN7e1YqkEJEmvWlHUgw469iGtkX
   Pltuu6DIvtm0Z41ES/taV/wqmK9kJVLI+U4Vbog6xQ1GlsjcN8SspVaBs
   Z/aZ42WB8Z5xNR73mLHVXvyoe6JX7Ke8QFLDOxI5NDg1twlyLRt+3Izps
   RqLx1hgUrVQ1zAUSXJl26Z14g7g1XyRVEQnCddqYWjyA8ZQlIeaiJHp5a
   ygfpyLZMHTAAWKYuyWDMWIN9fvynFdwOrycurUEmg/UILsmrNHJ+QAZY+
   9rcVWZXdf/A7dEnQlPHxutHO5yRuRMIV8XIuzkzX8qfCDO8tx8D0/5m7b
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="286630801"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="286630801"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 22:08:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="959411858"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="959411858"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 20 Oct 2022 22:08:17 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1olkGX-00029F-0G;
        Fri, 21 Oct 2022 05:08:17 +0000
Date:   Fri, 21 Oct 2022 13:07:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [wireless-next:main] BUILD SUCCESS
 55549d6a3052990e65727bfec158e1b0e7cec4e4
Message-ID: <6352291f.h3J4X+4rermj/IZZ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 55549d6a3052990e65727bfec158e1b0e7cec4e4  bcma: gpio: Convert to immutable gpio irqchip

elapsed time: 2821m

configs tested: 71
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
alpha                               defconfig
s390                             allmodconfig
s390                                defconfig
arc                  randconfig-r043-20221019
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a011
x86_64                         rhel-8.3-kunit
x86_64                        randconfig-a004
s390                             allyesconfig
i386                                defconfig
powerpc                           allnoconfig
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-kvm
x86_64                        randconfig-a015
powerpc                          allmodconfig
x86_64                        randconfig-a002
sh                               allmodconfig
x86_64                    rhel-8.3-kselftests
mips                             allyesconfig
i386                          randconfig-a014
x86_64                           rhel-8.3-syz
i386                          randconfig-a012
arc                              allyesconfig
x86_64                        randconfig-a013
alpha                            allyesconfig
i386                          randconfig-a016
x86_64                        randconfig-a006
i386                             allyesconfig
m68k                             allyesconfig
x86_64                              defconfig
arm                                 defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
arm                              allyesconfig
arm64                            allyesconfig
m68k                             allmodconfig
arc                  randconfig-r043-20221018
riscv                randconfig-r042-20221018
s390                 randconfig-r044-20221018
arc                  randconfig-r043-20221020
s390                 randconfig-r044-20221020
riscv                randconfig-r042-20221020

clang tested configs:
riscv                randconfig-r042-20221019
hexagon              randconfig-r045-20221019
hexagon              randconfig-r041-20221019
i386                          randconfig-a002
i386                          randconfig-a004
s390                 randconfig-r044-20221019
i386                          randconfig-a006
x86_64                        randconfig-a012
i386                          randconfig-a013
x86_64                        randconfig-a005
i386                          randconfig-a011
x86_64                        randconfig-a001
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a015
x86_64                        randconfig-a003
hexagon              randconfig-r041-20221018
hexagon              randconfig-r045-20221018
i386                 randconfig-a013-20221017
i386                 randconfig-a015-20221017
i386                 randconfig-a016-20221017
i386                 randconfig-a011-20221017
i386                 randconfig-a014-20221017
i386                 randconfig-a012-20221017

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
