Return-Path: <linux-wireless+bounces-583-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3200B80A9EB
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Dec 2023 18:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A28DB209ED
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Dec 2023 17:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED3D32C7A;
	Fri,  8 Dec 2023 17:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZAxn9AuF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3833910F1
	for <linux-wireless@vger.kernel.org>; Fri,  8 Dec 2023 09:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702054811; x=1733590811;
  h=date:from:to:cc:subject:message-id;
  bh=xSQD3kjEJcy9nbYKMktsJ7hzXqshhJGBVjG+ZX7dX98=;
  b=ZAxn9AuFCHX1QMAzrF0c6itrlGqTKHUFqagzh9HunxYfGbfs85dDXX/e
   arL/CINfBmfjWslt7YyN2HxWZNp1Zwi7RMMnKkAzLRibQkZf5ZxrtaEAO
   qck4Phiq9bJeM0rNa1OMLHsHvFD5whL73DDavSXunFbli+/VE8T0kaiaG
   5Yg1qEQihSM2XiY9IYEf8qKYpUnkSad1tK7/ejX4vD0TsgvgV7EhuiyOQ
   yjAriWVhJq1Eu7Hd6NsJPJpDP1cmR4ZFWSGputUNsmbn5+dCdX/C0g1vu
   KxrbPrAkCgjJT7DY3Xs7hWSBVXboxur6wGBb3S61c57demzOAITGfYihD
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="397226129"
X-IronPort-AV: E=Sophos;i="6.04,261,1695711600"; 
   d="scan'208";a="397226129"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 09:00:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="721916065"
X-IronPort-AV: E=Sophos;i="6.04,261,1695711600"; 
   d="scan'208";a="721916065"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 08 Dec 2023 09:00:09 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rBeCt-000E2W-1L;
	Fri, 08 Dec 2023 17:00:07 +0000
Date: Sat, 09 Dec 2023 00:59:40 +0800
From: kernel test robot <lkp@intel.com>
To: Kalle Valo <kvalo@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD REGRESSION
 db7fac15eaf0f09d675730d7002edabe27fe9e1d
Message-ID: <202312090036.jwmcWv2Y-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: db7fac15eaf0f09d675730d7002edabe27fe9e1d  wifi: rtw89: mac: refine SER setting during WiFi CPU power on

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
`-- mips-allyesconfig
    |-- (.ref.text):relocation-truncated-to-fit:R_MIPS_26-against-start_secondary
    |-- (.text):relocation-truncated-to-fit:R_MIPS_26-against-kernel_entry
    |-- main.c:(.init.text):relocation-truncated-to-fit:R_MIPS_26-against-__sanitizer_cov_trace_pc
    `-- main.c:(.init.text):relocation-truncated-to-fit:R_MIPS_26-against-_mcount

elapsed time: 1467m

configs tested: 35
configs skipped: 0

tested configs:
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20231208   clang
i386         buildonly-randconfig-002-20231208   clang
i386         buildonly-randconfig-003-20231208   clang
i386         buildonly-randconfig-004-20231208   clang
i386         buildonly-randconfig-005-20231208   clang
i386         buildonly-randconfig-006-20231208   clang
i386                                defconfig   gcc  
i386                  randconfig-001-20231208   clang
i386                  randconfig-002-20231208   clang
i386                  randconfig-003-20231208   clang
i386                  randconfig-004-20231208   clang
i386                  randconfig-005-20231208   clang
i386                  randconfig-006-20231208   clang
i386                  randconfig-011-20231208   gcc  
i386                  randconfig-012-20231208   gcc  
i386                  randconfig-013-20231208   gcc  
i386                  randconfig-014-20231208   gcc  
i386                  randconfig-015-20231208   gcc  
i386                  randconfig-016-20231208   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
sh                               allmodconfig   gcc  
sh                               allyesconfig   gcc  
sparc                            allmodconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
um                               allmodconfig   clang
um                               allyesconfig   clang
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

