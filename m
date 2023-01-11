Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54F50665166
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jan 2023 02:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232858AbjAKB4l (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Jan 2023 20:56:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231853AbjAKB4k (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Jan 2023 20:56:40 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01468F10
        for <linux-wireless@vger.kernel.org>; Tue, 10 Jan 2023 17:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673402199; x=1704938199;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=6dsoOqqGfTwvvAPrqWdYmewiN7ii1qoujOW8+AdHaJY=;
  b=CXG8kcH1IbB258pNWwFKxAdQ/ZHAOPBRTRhap55mrdBhEUNcdezgxLjX
   I9hKOiCRnYGPCrlPmSw/+g3kNMjbYOS1zXvKNXuLqe/M4TR25ePpBwaGy
   m+vnAwWTrI2fThfC7tRa6Aolu5E/nG38u6XuU5GBCJqgeBOgPBWY7UIeU
   8xw2Q9p31YgT45SHQHSt1XggEn+uVCS1WLjxRQHTdV78vZarlAmzR0nFW
   53RS9AUaQ2y0U37suBvpFUdiwRuztWWifnz341TSEB+4vuSTL0A+Ifp6V
   NZ4k/6o7CefDDR6GO6XOZH7HkZtvtRLdawsBygW5CGOFlz6iqiXUo8nXX
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="387769408"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="387769408"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 17:56:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="799655479"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="799655479"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 10 Jan 2023 17:56:36 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pFQM0-0008bL-0c;
        Wed, 11 Jan 2023 01:56:36 +0000
Date:   Wed, 11 Jan 2023 09:56:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>
Subject: [wireless:for-next] BUILD SUCCESS
 f216033d770f7ca0eda491fe01a9f02e7af59576
Message-ID: <63be173e.hw7djO4d3zGZWxcN%lkp@intel.com>
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
branch HEAD: f216033d770f7ca0eda491fe01a9f02e7af59576  wifi: mac80211: fix MLO + AP_VLAN check

elapsed time: 731m

configs tested: 55
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
x86_64                           rhel-8.3-bpf
i386                          randconfig-a001
powerpc                           allnoconfig
x86_64                           rhel-8.3-syz
i386                          randconfig-a003
m68k                             allyesconfig
powerpc                          allmodconfig
x86_64                         rhel-8.3-kunit
m68k                             allmodconfig
sh                               allmodconfig
x86_64                           rhel-8.3-kvm
arc                              allyesconfig
mips                             allyesconfig
um                           x86_64_defconfig
alpha                            allyesconfig
um                             i386_defconfig
ia64                             allmodconfig
i386                          randconfig-a005
x86_64                              defconfig
x86_64                               rhel-8.3
arc                  randconfig-r043-20230110
x86_64                        randconfig-a004
x86_64                        randconfig-a002
s390                 randconfig-r044-20230110
riscv                randconfig-r042-20230110
x86_64                        randconfig-a006
x86_64                           allyesconfig
i386                             allyesconfig
i386                                defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
arc                                 defconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
alpha                               defconfig
s390                                defconfig
s390                             allmodconfig
s390                             allyesconfig

clang tested configs:
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
hexagon              randconfig-r041-20230110
arm                  randconfig-r046-20230110
x86_64                        randconfig-a001
hexagon              randconfig-r045-20230110
x86_64                        randconfig-a003
x86_64                        randconfig-a005
x86_64                          rhel-8.3-rust
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-k001
mips                malta_qemu_32r6_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
