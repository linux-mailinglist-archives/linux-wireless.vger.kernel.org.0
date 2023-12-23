Return-Path: <linux-wireless+bounces-1266-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6203781D48A
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Dec 2023 15:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9395F1C209C3
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Dec 2023 14:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5ECDDB7;
	Sat, 23 Dec 2023 14:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d2YLNJal"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673C5DDD9
	for <linux-wireless@vger.kernel.org>; Sat, 23 Dec 2023 14:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703341213; x=1734877213;
  h=date:from:to:cc:subject:message-id;
  bh=K2oh0CK3+ByvqeIlIAPvvIf+pJZyF+RRseNgU6FsyQs=;
  b=d2YLNJalsAWS9UQO9OeN7s3bMgPoJNPwGjDUBxjR9krKiRB5hGPolBem
   CTJTORQjGCrwtI3Sb62rkIdVQxFUEp/PNES3iYta3jRcMt7JET8SNDWdL
   lqKjAIxIxkiYAFbeiECYuwVYOe8XK4prAEddoUpwQ59HFyEAsQXZC1InW
   1LJWOvHrwqr4m2ChmFHwi9chUeI2fw2nptA8PDzd936/WUfPhij8Kldiw
   oupQFV3BNIT+03M/+FASgg0ial9ui1E6mxFuczWa0fycSa2MVOSNyllju
   mc46vPQqnWIqmo1w45pGmSycMVJHI9Sdve4ZC/07e6j+leUkVZYZVYhUd
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10933"; a="14877882"
X-IronPort-AV: E=Sophos;i="6.04,299,1695711600"; 
   d="scan'208";a="14877882"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2023 06:20:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10933"; a="806275199"
X-IronPort-AV: E=Sophos;i="6.04,299,1695711600"; 
   d="scan'208";a="806275199"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 23 Dec 2023 06:20:09 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rH2r6-000B6m-37;
	Sat, 23 Dec 2023 14:19:59 +0000
Date: Sat, 23 Dec 2023 22:18:53 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 968509128207f122d7177ffb6ff51c9c6fa7e13d
Message-ID: <202312232250.wa6XAvM4-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 968509128207f122d7177ffb6ff51c9c6fa7e13d  wifi: iwlwifi: replace ENOTSUPP with EOPNOTSUPP

elapsed time: 2530m

configs tested: 47
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
arc                   randconfig-001-20231223   gcc  
arc                   randconfig-002-20231223   gcc  
arm                   randconfig-001-20231223   clang
arm                   randconfig-002-20231223   clang
arm                   randconfig-003-20231223   clang
arm                   randconfig-004-20231223   clang
arm64                 randconfig-001-20231223   clang
arm64                 randconfig-002-20231223   clang
arm64                 randconfig-003-20231223   clang
arm64                 randconfig-004-20231223   clang
csky                  randconfig-001-20231223   gcc  
csky                  randconfig-002-20231223   gcc  
hexagon               randconfig-001-20231223   clang
hexagon               randconfig-002-20231223   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20231223   clang
i386         buildonly-randconfig-002-20231223   clang
i386         buildonly-randconfig-003-20231223   clang
i386         buildonly-randconfig-004-20231223   clang
i386         buildonly-randconfig-005-20231223   clang
i386         buildonly-randconfig-006-20231223   clang
i386                                defconfig   gcc  
i386                  randconfig-001-20231223   clang
i386                  randconfig-002-20231223   clang
i386                  randconfig-003-20231223   clang
i386                  randconfig-004-20231223   clang
i386                  randconfig-005-20231223   clang
i386                  randconfig-006-20231223   clang
i386                  randconfig-011-20231223   gcc  
i386                  randconfig-012-20231223   gcc  
i386                  randconfig-013-20231223   gcc  
i386                  randconfig-014-20231223   gcc  
i386                  randconfig-015-20231223   gcc  
i386                  randconfig-016-20231223   gcc  
loongarch             randconfig-001-20231223   gcc  
loongarch             randconfig-002-20231223   gcc  
nios2                 randconfig-001-20231223   gcc  
nios2                 randconfig-002-20231223   gcc  
parisc                randconfig-001-20231223   gcc  
parisc                randconfig-002-20231223   gcc  
powerpc               randconfig-001-20231223   clang
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

