Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B36E66875A
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jan 2023 23:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240609AbjALWyT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Jan 2023 17:54:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240676AbjALWyO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Jan 2023 17:54:14 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B3DF73
        for <linux-wireless@vger.kernel.org>; Thu, 12 Jan 2023 14:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673564054; x=1705100054;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=qcobSLvOVi7G5vYUSODvH3W48HreL7TBsy3n76KMEOw=;
  b=fMss3R26gQ/kFBkkCWbe026Iad8xiQgZdAzcITc8XXzaUHRUCosn284Y
   C9QAoNqqwzq62uytpPF2NuefClu9J8rSdhjYfhDPCtfpMxzcncTzQLtc0
   dRJDKcoSHVvtcpzGQOp8vsrdPByq5s3sGchen/1EuSdlhtheqBBh9NFia
   q7GRPs/v4lpY0DqLSa2UfkFtk+UM1y1sYr1o9k/XGbLqxq895W+wx6KA6
   ulWwHFtZzV9SE0dH4+uOCAUC6JoeGblBlIApvYntCGq2LXv7qMGi0NKFu
   aE6OmOGMVEOuQz3M1+hWQ80pY9KYpfX0qALrNifg6Q5OAFqjDxZsNwwEJ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="325111773"
X-IronPort-AV: E=Sophos;i="5.97,212,1669104000"; 
   d="scan'208";a="325111773"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 14:54:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="746716956"
X-IronPort-AV: E=Sophos;i="5.97,212,1669104000"; 
   d="scan'208";a="746716956"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Jan 2023 14:54:10 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pG6SX-000AUa-2x;
        Thu, 12 Jan 2023 22:54:09 +0000
Date:   Fri, 13 Jan 2023 06:53:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>
Subject: [wireless-next:main] BUILD SUCCESS
 d64c732dfc9edcd57feb693c23162117737e426b
Message-ID: <63c08f83.J43MDl5LqgUXBmJ/%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: d64c732dfc9edcd57feb693c23162117737e426b  net: rfkill: gpio: add DT support

elapsed time: 729m

configs tested: 82
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
arc                                 defconfig
s390                             allmodconfig
i386                                defconfig
x86_64                          rhel-8.3-func
x86_64                              defconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3
arm                                 defconfig
i386                          randconfig-a014
x86_64                        randconfig-a013
x86_64                    rhel-8.3-kselftests
ia64                             allmodconfig
i386                          randconfig-a001
x86_64                        randconfig-a011
i386                          randconfig-a003
x86_64                           allyesconfig
x86_64                           rhel-8.3-kvm
arc                  randconfig-r043-20230112
s390                 randconfig-r044-20230112
x86_64                           rhel-8.3-bpf
i386                          randconfig-a012
x86_64                        randconfig-a015
i386                          randconfig-a016
riscv                randconfig-r042-20230112
i386                          randconfig-a005
i386                             allyesconfig
arm64                            allyesconfig
arm                              allyesconfig
um                           x86_64_defconfig
um                             i386_defconfig
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
powerpc                           allnoconfig
alpha                               defconfig
s390                                defconfig
sh                               allmodconfig
s390                             allyesconfig
mips                             allyesconfig
powerpc                          allmodconfig
m68k                             allmodconfig
m68k                             allyesconfig
alpha                            allyesconfig
arc                              allyesconfig
arm                          exynos_defconfig
mips                         rt305x_defconfig
sh                         microdev_defconfig
arc                     nsimosci_hs_defconfig
arm                      integrator_defconfig
sh                           se7721_defconfig
m68k                          atari_defconfig
arc                          axs103_defconfig
m68k                       bvme6000_defconfig
x86_64                        randconfig-a004

clang tested configs:
i386                          randconfig-a013
i386                          randconfig-a015
x86_64                          rhel-8.3-rust
arm                  randconfig-r046-20230112
x86_64                        randconfig-a016
i386                          randconfig-a011
hexagon              randconfig-r041-20230112
x86_64                        randconfig-a012
i386                          randconfig-a002
hexagon              randconfig-r045-20230112
x86_64                        randconfig-a014
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
arm                        spear3xx_defconfig
arm                          pcm027_defconfig
mips                           ip22_defconfig
powerpc                          g5_defconfig
mips                          malta_defconfig
powerpc                 mpc8272_ads_defconfig
powerpc               mpc834x_itxgp_defconfig
mips                      maltaaprp_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
