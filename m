Return-Path: <linux-wireless+bounces-1750-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08DD882B52E
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jan 2024 20:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8116728269A
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jan 2024 19:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426DF54BF2;
	Thu, 11 Jan 2024 19:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GLwHQb4d"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6037F52F9F
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jan 2024 19:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705001089; x=1736537089;
  h=date:from:to:cc:subject:message-id;
  bh=K9K6c4JFwSGlLBgCMLLCJSC3LfaBH+WFbUO62cqzLzk=;
  b=GLwHQb4dlWJar3MYuujdzgC3bJJF1oOOeo3Kp5Dl5dr5FiR8yXALSBPs
   ykT5t7DmBi67EXKkVLEWTW7lGLKUWHQLB38g3Bh3nLt+/SDUwStSEIgpF
   6Jz1JJCfApczCWivgqXroeRiMG1UB144nITbEThXqf/+tlsFqj5g7CSfr
   5OD8aAG8uI7QuWg3ra5R+0vKxoGA++lVq7dYbb5Du8NXAVvlWOM0lrQ6z
   TJhTde3GnRTMiPHm4ryOpHYn/8GXgjCpuCT2zvQIOyF0Ew1iGid7kuH/8
   pvrIvVGlOdKoh4itrrSvudRkLrh14m4mIOCSROig70rr9H92i+jfyXJww
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="5690473"
X-IronPort-AV: E=Sophos;i="6.04,187,1695711600"; 
   d="scan'208";a="5690473"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 11:24:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="873130700"
X-IronPort-AV: E=Sophos;i="6.04,187,1695711600"; 
   d="scan'208";a="873130700"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Jan 2024 11:24:35 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rO0fJ-0008eU-00;
	Thu, 11 Jan 2024 19:24:33 +0000
Date: Fri, 12 Jan 2024 03:23:38 +0800
From: kernel test robot <lkp@intel.com>
To: Kalle Valo <kvalo@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 09795bded2e725443fe4a4803cae2079cdaf7b26
Message-ID: <202401120335.Ieb0svqH-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 09795bded2e725443fe4a4803cae2079cdaf7b26  wifi: b43: Disable QoS for bcm4331

elapsed time: 1687m

configs tested: 109
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240111   gcc  
arc                   randconfig-002-20240111   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                   milbeaut_m10v_defconfig   clang
arm                            mmp2_defconfig   clang
arm                   randconfig-001-20240111   gcc  
arm                   randconfig-002-20240111   gcc  
arm                   randconfig-003-20240111   gcc  
arm                   randconfig-004-20240111   gcc  
arm                        spear6xx_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240111   gcc  
arm64                 randconfig-002-20240111   gcc  
arm64                 randconfig-003-20240111   gcc  
arm64                 randconfig-004-20240111   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240111   gcc  
csky                  randconfig-002-20240111   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240111   clang
hexagon               randconfig-002-20240111   clang
i386                             alldefconfig   gcc  
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20240111   gcc  
i386         buildonly-randconfig-002-20240111   gcc  
i386         buildonly-randconfig-003-20240111   gcc  
i386         buildonly-randconfig-004-20240111   gcc  
i386         buildonly-randconfig-005-20240111   gcc  
i386         buildonly-randconfig-006-20240111   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20240111   gcc  
i386                  randconfig-002-20240111   gcc  
i386                  randconfig-003-20240111   gcc  
i386                  randconfig-004-20240111   gcc  
i386                  randconfig-005-20240111   gcc  
i386                  randconfig-006-20240111   gcc  
i386                  randconfig-011-20240111   clang
i386                  randconfig-012-20240111   clang
i386                  randconfig-013-20240111   clang
i386                  randconfig-014-20240111   clang
i386                  randconfig-015-20240111   clang
i386                  randconfig-016-20240111   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240111   gcc  
loongarch             randconfig-002-20240111   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
mips                          ath25_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240111   gcc  
nios2                 randconfig-002-20240111   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240111   gcc  
parisc                randconfig-002-20240111   gcc  
parisc64                            defconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc               randconfig-001-20240111   gcc  
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

