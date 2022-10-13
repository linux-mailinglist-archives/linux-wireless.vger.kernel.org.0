Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B493B5FE505
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Oct 2022 00:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiJMWLy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Oct 2022 18:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiJMWLx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Oct 2022 18:11:53 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5085186D5C
        for <linux-wireless@vger.kernel.org>; Thu, 13 Oct 2022 15:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665699112; x=1697235112;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=5auVZB3QaHg+vFHQ/gGtAmmJ8s0rJdgn3KA5itSaNq8=;
  b=CBo7QeuOSg6AyuQgfWesBcdzFZAflXeggtOx6q3L5IrTxGMOAZql/WI+
   eGoRP3Cxrg68KFSdKjLO6xsh2DSwq+gu+0afE2spuguJgBeJ1EP2lgoPb
   cNrHA65X2KMvbHLTdJhN3IhY7109MVvrCrdtGd9gyhwviXK3Kwp/wG0e9
   zK5k47RFZBmQECkAQZMpymxnhwDk9irG2tphwd5ardbWFvcrHWQ4gcztk
   JHGMeOmhUZh2+VdgPwlWTlM+FHIqC0HfVgfyax+CcRefwNcxUzLCkPWXU
   2Yz6ed9RHMnC0eXjSTsKRgWi8y5Dmt3p4MYFBHmnUgCqjGZTwdr243SPQ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="306870638"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="306870638"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2022 15:11:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="696069066"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="696069066"
Received: from lkp-server01.sh.intel.com (HELO 2af0a69ca4e0) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 13 Oct 2022 15:11:50 -0700
Received: from kbuild by 2af0a69ca4e0 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oj6Qg-0005dD-0A;
        Thu, 13 Oct 2022 22:11:50 +0000
Date:   Fri, 14 Oct 2022 06:10:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>
Subject: [wireless:for-next] BUILD SUCCESS
 e7ad651c31c5e1289323e6c680be6e582a593b26
Message-ID: <63488cf3.hdAwzDNy1oPKI3YC%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git for-next
branch HEAD: e7ad651c31c5e1289323e6c680be6e582a593b26  Merge branch 'cve-fixes-2022-10-13'

elapsed time: 722m

configs tested: 75
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                  randconfig-r043-20221012
x86_64                          rhel-8.3-func
riscv                randconfig-r042-20221012
x86_64                              defconfig
x86_64                    rhel-8.3-kselftests
s390                 randconfig-r044-20221012
x86_64                           allyesconfig
powerpc                          allmodconfig
x86_64                               rhel-8.3
mips                             allyesconfig
powerpc                           allnoconfig
arc                                 defconfig
arm                                 defconfig
alpha                               defconfig
sh                               allmodconfig
s390                             allmodconfig
s390                                defconfig
i386                                defconfig
arc                              allyesconfig
x86_64                           rhel-8.3-syz
s390                             allyesconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
alpha                            allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                        randconfig-a015
x86_64                           rhel-8.3-kvm
m68k                             allmodconfig
i386                          randconfig-a014
x86_64                        randconfig-a013
arm64                            allyesconfig
m68k                             allyesconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a011
i386                          randconfig-a012
arm                              allyesconfig
i386                          randconfig-a016
i386                          randconfig-a005
i386                             allyesconfig
ia64                             allmodconfig
i386                          randconfig-a001
i386                          randconfig-a003
powerpc                  iss476-smp_defconfig
powerpc                       maple_defconfig
s390                       zfcpdump_defconfig
alpha                            alldefconfig
arc                               allnoconfig
powerpc                 mpc834x_mds_defconfig
arc                     haps_hs_smp_defconfig
powerpc                     tqm8548_defconfig
openrisc                         alldefconfig
openrisc                    or1ksim_defconfig
i386                          randconfig-c001

clang tested configs:
hexagon              randconfig-r041-20221012
hexagon              randconfig-r045-20221012
x86_64                        randconfig-a005
x86_64                        randconfig-a016
x86_64                        randconfig-a001
i386                          randconfig-a011
x86_64                        randconfig-a003
x86_64                        randconfig-a012
i386                          randconfig-a013
i386                          randconfig-a015
x86_64                        randconfig-a014
i386                          randconfig-a006
i386                          randconfig-a002
i386                          randconfig-a004
mips                        qi_lb60_defconfig
mips                     cu1000-neo_defconfig
x86_64                        randconfig-k001
powerpc                     akebono_defconfig
arm                        vexpress_defconfig
mips                           ip28_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
