Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4663866D55E
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jan 2023 05:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235248AbjAQE3D (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Jan 2023 23:29:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234974AbjAQE3B (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Jan 2023 23:29:01 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C195658A
        for <linux-wireless@vger.kernel.org>; Mon, 16 Jan 2023 20:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673929740; x=1705465740;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=aVLDfBqjtuBbo+FH3wU8NHFyYTRpU8TivHQE6NPOIms=;
  b=AVMVACdVs7LiVTPWzQMstU1vNW9Lp2GGujFnNeHjHSLqGjAjznULie6c
   Bkbv6wP12C8FnWj65bYrgmn9HebX7nDfoFF7K26fhQFcRCYvGMf0qw5yz
   VHdoQb5DQ3zF86wie2mM8YgqvRbE6MkaY/IZc6jRszp04ky3YFxYwzDhB
   dBXEYHnkiSUORgfHk9BMuyQxZfYwYyIWWYo/XbcxaOuhR4HNK4zX6n10+
   B1LwAibv41RohNT5xDIia3Gnusd82rXI7WSLLUzJvOAhbnCgZowWR9i5i
   MraFGtjtOAfBx4xm/iyotnM2FFZd/qJIiCgFOSnfQ+bbA07iT6wz2OWim
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="326674309"
X-IronPort-AV: E=Sophos;i="5.97,222,1669104000"; 
   d="scan'208";a="326674309"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2023 20:28:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="783106482"
X-IronPort-AV: E=Sophos;i="5.97,222,1669104000"; 
   d="scan'208";a="783106482"
Received: from lkp-server02.sh.intel.com (HELO f57cd993bc73) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 16 Jan 2023 20:28:57 -0800
Received: from kbuild by f57cd993bc73 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pHdag-0000x0-32;
        Tue, 17 Jan 2023 04:28:55 +0000
Date:   Tue, 17 Jan 2023 12:28:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [wireless:for-next] BUILD SUCCESS
 80f8a66dede0a4b4e9e846765a97809c6fe49ce5
Message-ID: <63c623fa.Gs84YT41Lpzuuz/J%lkp@intel.com>
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
branch HEAD: 80f8a66dede0a4b4e9e846765a97809c6fe49ce5  Revert "wifi: mac80211: fix memory leak in ieee80211_if_add()"

elapsed time: 727m

configs tested: 109
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
powerpc                           allnoconfig
um                             i386_defconfig
s390                                defconfig
arc                                 defconfig
um                           x86_64_defconfig
i386                                defconfig
alpha                               defconfig
x86_64                              defconfig
x86_64                           rhel-8.3-syz
i386                 randconfig-a016-20230116
arc                  randconfig-r043-20230116
x86_64               randconfig-a011-20230116
i386                 randconfig-a014-20230116
sh                               allmodconfig
m68k                             allmodconfig
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3
x86_64               randconfig-a013-20230116
i386                 randconfig-a013-20230116
arm                                 defconfig
i386                 randconfig-a012-20230116
s390                 randconfig-r044-20230116
x86_64                           rhel-8.3-kvm
i386                 randconfig-a015-20230116
x86_64               randconfig-a012-20230116
x86_64                           allyesconfig
riscv                randconfig-r042-20230116
x86_64               randconfig-a015-20230116
x86_64                           rhel-8.3-bpf
x86_64                          rhel-8.3-func
powerpc                          allmodconfig
m68k                             allyesconfig
arc                  randconfig-r043-20230115
mips                             allyesconfig
arc                              allyesconfig
x86_64               randconfig-a014-20230116
x86_64               randconfig-a016-20230116
alpha                            allyesconfig
arm                              allyesconfig
i386                 randconfig-a011-20230116
x86_64                    rhel-8.3-kselftests
s390                             allmodconfig
arm                  randconfig-r046-20230115
arm64                            allyesconfig
i386                             allyesconfig
ia64                             allmodconfig
s390                             allyesconfig
mips                           jazz_defconfig
powerpc                      ep88xc_defconfig
powerpc                  storcenter_defconfig
arm                             ezx_defconfig
sh                        sh7785lcr_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
powerpc                       ppc64_defconfig
arm                         lpc18xx_defconfig
powerpc                 mpc834x_itx_defconfig
riscv                            allyesconfig
powerpc                       holly_defconfig
m68k                         apollo_defconfig
um                               alldefconfig
mips                         db1xxx_defconfig
powerpc                 mpc837x_rdb_defconfig
sh                 kfr2r09-romimage_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
sh                        sh7763rdp_defconfig
sh                         ap325rxa_defconfig
alpha                            alldefconfig
arc                         haps_hs_defconfig
sh                  sh7785lcr_32bit_defconfig
xtensa                    smp_lx200_defconfig
arm                         assabet_defconfig
arc                            hsdk_defconfig

clang tested configs:
arm                  randconfig-r046-20230116
hexagon              randconfig-r045-20230116
i386                 randconfig-a002-20230116
i386                 randconfig-a006-20230116
hexagon              randconfig-r041-20230116
x86_64               randconfig-a006-20230116
i386                 randconfig-a004-20230116
x86_64                          rhel-8.3-rust
hexagon              randconfig-r045-20230115
i386                 randconfig-a003-20230116
riscv                randconfig-r042-20230115
i386                 randconfig-a005-20230116
s390                 randconfig-r044-20230115
i386                 randconfig-a001-20230116
hexagon              randconfig-r041-20230115
x86_64               randconfig-a005-20230116
x86_64               randconfig-a001-20230116
x86_64               randconfig-a002-20230116
x86_64               randconfig-a004-20230116
x86_64               randconfig-a003-20230116
arm                        vexpress_defconfig
powerpc                 mpc8315_rdb_defconfig
arm                     am200epdkit_defconfig
mips                           mtx1_defconfig
powerpc                     pseries_defconfig
i386                              allnoconfig
powerpc                   lite5200b_defconfig
mips                  cavium_octeon_defconfig
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
