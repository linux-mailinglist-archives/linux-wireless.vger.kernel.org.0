Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCC9F64D50C
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Dec 2022 02:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbiLOBih (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Dec 2022 20:38:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiLOBig (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Dec 2022 20:38:36 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD421FF94
        for <linux-wireless@vger.kernel.org>; Wed, 14 Dec 2022 17:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671068315; x=1702604315;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=62rw4zWRNNaJlvChX3jYjS8GrrUvQxHXqJ/9iWf0Obo=;
  b=Dzn/ReWmoS3uvsicYrd3f2vvllAkmi8EK8r0EpZuoYBCI6tKJ6mGuohE
   Pg24R0R8XCR0RMGQauQmnXqlHx22sbsCXlG/LelXFCB5XCYPkejOcRzZJ
   vHni3JrSdXPBGDSdWLPmmTKyAn6lkW1WtKuJuKUmHmoZhLRWJ76YmNY89
   hWvydCpqblz7D9FxEBgi/TRQen5DxR7NfT/s+0G+GWE11TLBJlokKyOks
   UTeVDUTOR4D8Qr0swM37rqV8v1zm/dlJ4rBb/x5y1vWGu5/tdiNZBH9uf
   TVJGae9ol6W8g08isMc1RTx9czZVb6XiyKs4Usgz47Q+3ZwpfHbF7KIBb
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10561"; a="382862693"
X-IronPort-AV: E=Sophos;i="5.96,246,1665471600"; 
   d="scan'208";a="382862693"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2022 17:38:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10561"; a="894539200"
X-IronPort-AV: E=Sophos;i="5.96,246,1665471600"; 
   d="scan'208";a="894539200"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 14 Dec 2022 17:38:34 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p5dCj-0005wg-1P;
        Thu, 15 Dec 2022 01:38:33 +0000
Date:   Thu, 15 Dec 2022 09:37:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [wireless-next:main] BUILD SUCCESS
 117dbeda22ec5ea0918254d03b540ef8b8a64d53
Message-ID: <639a7a61.P/3sNzEBae1vYMXX%lkp@intel.com>
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
branch HEAD: 117dbeda22ec5ea0918254d03b540ef8b8a64d53  wifi: rtlwifi: Fix global-out-of-bounds bug in _rtl8812ae_phy_set_txpower_limit()

elapsed time: 720m

configs tested: 83
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
ia64                             allmodconfig
arc                  randconfig-r043-20221214
x86_64                        randconfig-a004
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a002
i386                          randconfig-a014
x86_64                        randconfig-a015
s390                 randconfig-r044-20221214
i386                          randconfig-a012
i386                          randconfig-a016
i386                          randconfig-a001
riscv                randconfig-r042-20221214
i386                          randconfig-a003
x86_64                        randconfig-a006
i386                          randconfig-a005
um                           x86_64_defconfig
um                             i386_defconfig
i386                             allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-rust
x86_64                            allnoconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
powerpc                           allnoconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-bpf
x86_64                         rhel-8.3-kunit
sh                               allmodconfig
powerpc                         wii_defconfig
arm                          pxa3xx_defconfig
sh                                  defconfig
powerpc                     rainier_defconfig
sh                           se7705_defconfig
powerpc                          allmodconfig
mips                             allyesconfig
arc                                 defconfig
s390                             allmodconfig
i386                                defconfig
alpha                               defconfig
s390                                defconfig
s390                             allyesconfig
sh                           se7751_defconfig
arm64                            alldefconfig
sh                           sh2007_defconfig
powerpc                   currituck_defconfig
arc                         haps_hs_defconfig
i386                          randconfig-c001
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
xtensa                         virt_defconfig
sparc                       sparc64_defconfig
mips                             allmodconfig

clang tested configs:
arm                  randconfig-r046-20221214
x86_64                        randconfig-a014
i386                          randconfig-a013
x86_64                        randconfig-a012
hexagon              randconfig-r041-20221214
x86_64                        randconfig-a001
hexagon              randconfig-r045-20221214
i386                          randconfig-a011
x86_64                        randconfig-a003
x86_64                        randconfig-a016
i386                          randconfig-a015
x86_64                        randconfig-a005
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
