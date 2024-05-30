Return-Path: <linux-wireless+bounces-8322-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5B98D4FB4
	for <lists+linux-wireless@lfdr.de>; Thu, 30 May 2024 18:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AD501F22E03
	for <lists+linux-wireless@lfdr.de>; Thu, 30 May 2024 16:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3EC187577;
	Thu, 30 May 2024 16:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MESgrYNe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4163B18755C
	for <linux-wireless@vger.kernel.org>; Thu, 30 May 2024 16:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717085850; cv=none; b=lOwwsRSARKRJdKS4Ae8EkyBb8ywSfUAHSa8pPJ39eOMJie7jL28pUMz+GClQIcqQ3F5wLT76dQuWIJ4Ai8fRcJK3N1ReeWR1aDjqIdhpKQMS+FcrStIWZ+HPx/J4PJriZf/Zq3pJXh6svIur7R0ZqSqd/ZKk0aKRnm3Zd6iocus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717085850; c=relaxed/simple;
	bh=7oTxNCVf8BgWgRJ9PA48zQ+bewmKW6w/6aodFwwmi4Q=;
	h=Date:From:To:Cc:Subject:Message-ID; b=NVRT0a1aqddzvTG1dg6b3aZ+Qm6Ko/CcW5zwQXBHrJmFIJuNzLG2Dj04fOMzJkcTf46dFkuJkZY8zek3n3uF35D4qwKl/EtGG1Kumw9tBhnydLMSSJGwn0qTpYuX9BYoJOcBuhpW6RfqZPRyxUC8SP/ndkJIMuLP8HmaTK4O1dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MESgrYNe; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717085849; x=1748621849;
  h=date:from:to:cc:subject:message-id;
  bh=7oTxNCVf8BgWgRJ9PA48zQ+bewmKW6w/6aodFwwmi4Q=;
  b=MESgrYNes2r2W0703QN+FDcMPmHn/Q/ixTHc8QYZhloNKnZA9UeT3bqP
   Qa+Bo32CnIXHz9pAbFE+b4F8SgwUbLQ6TmH/eWzIZPU1xoXpOFB7+PUgi
   aS2E6dvX1sOCr0/d7aO192tl4Rr6pPe+0aPHAmqyxSM3GJLSMLVjre5Xw
   ervBBbhTz5h+KTvoy9WLgwJthGWXn8UVP924WoRLYZyhiM0GKkrEGJguE
   kLUF6jnlyjD/YfkV75X2RowVTpTihs97OZ0f0Pij8hwLUBJqoNCasHWvD
   Q5H/4PqUMOdxmnb5a0FDxVRD5yMFHySy4maI26qU7PlefwnDUjRhYBUDo
   Q==;
X-CSE-ConnectionGUID: mo21MSxtQIyhTTW89yGokQ==
X-CSE-MsgGUID: PQFHwAAvTW6wDsDOXBdbLA==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="24203669"
X-IronPort-AV: E=Sophos;i="6.08,201,1712646000"; 
   d="scan'208";a="24203669"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 09:17:28 -0700
X-CSE-ConnectionGUID: itZNUr6PSYOlzsOOp53Gpg==
X-CSE-MsgGUID: lp/8ocz2T4O/3QX9STmB9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,201,1712646000"; 
   d="scan'208";a="73341402"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 30 May 2024 09:17:26 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sCiSS-000FgO-0o;
	Thu, 30 May 2024 16:17:01 +0000
Date: Fri, 31 May 2024 00:11:04 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: [wireless:for-next] BUILD SUCCESS
 92ecbb3ac6f3fe8ae9edf3226c76aa17b6800699
Message-ID: <202405310001.r7J2i8PO-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git for-next
branch HEAD: 92ecbb3ac6f3fe8ae9edf3226c76aa17b6800699  wifi: mac80211: fix UBSAN noise in ieee80211_prep_hw_scan()

elapsed time: 1456m

configs tested: 160
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                          axs101_defconfig   gcc  
arc                                 defconfig   gcc  
arc                         haps_hs_defconfig   gcc  
arc                   randconfig-001-20240530   gcc  
arc                   randconfig-002-20240530   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                          ep93xx_defconfig   clang
arm                       imx_v4_v5_defconfig   clang
arm                   randconfig-002-20240530   gcc  
arm                   randconfig-004-20240530   gcc  
arm                         s5pv210_defconfig   gcc  
arm                          sp7021_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-002-20240530   gcc  
arm64                 randconfig-003-20240530   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240530   gcc  
csky                  randconfig-002-20240530   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-003-20240530   clang
i386         buildonly-randconfig-004-20240530   clang
i386         buildonly-randconfig-005-20240530   clang
i386         buildonly-randconfig-006-20240530   clang
i386                                defconfig   clang
i386                  randconfig-002-20240530   clang
i386                  randconfig-004-20240530   clang
i386                  randconfig-011-20240530   clang
i386                  randconfig-013-20240530   clang
i386                  randconfig-014-20240530   clang
i386                  randconfig-016-20240530   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240530   gcc  
loongarch             randconfig-002-20240530   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        mvme16x_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
microblaze                      mmu_defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                      loongson3_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240530   gcc  
nios2                 randconfig-002-20240530   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                       virt_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240530   gcc  
parisc                randconfig-002-20240530   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                      arches_defconfig   gcc  
powerpc               randconfig-001-20240530   gcc  
powerpc               randconfig-003-20240530   gcc  
powerpc                     taishan_defconfig   clang
powerpc64             randconfig-001-20240530   gcc  
riscv                            alldefconfig   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-002-20240530   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                        apsh4ad0a_defconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240530   gcc  
sh                    randconfig-002-20240530   gcc  
sh                          rsk7201_defconfig   gcc  
sh                           se7712_defconfig   gcc  
sh                           se7724_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240530   gcc  
sparc64               randconfig-002-20240530   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240530   gcc  
um                    randconfig-002-20240530   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240530   clang
x86_64       buildonly-randconfig-002-20240530   clang
x86_64       buildonly-randconfig-003-20240530   gcc  
x86_64       buildonly-randconfig-004-20240530   gcc  
x86_64       buildonly-randconfig-005-20240530   clang
x86_64       buildonly-randconfig-006-20240530   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240530   clang
x86_64                randconfig-002-20240530   clang
x86_64                randconfig-003-20240530   clang
x86_64                randconfig-004-20240530   clang
x86_64                randconfig-005-20240530   clang
x86_64                randconfig-006-20240530   clang
x86_64                randconfig-011-20240530   clang
x86_64                randconfig-012-20240530   gcc  
x86_64                randconfig-013-20240530   gcc  
x86_64                randconfig-014-20240530   gcc  
x86_64                randconfig-015-20240530   clang
x86_64                randconfig-016-20240530   gcc  
x86_64                randconfig-071-20240530   clang
x86_64                randconfig-072-20240530   clang
x86_64                randconfig-073-20240530   clang
x86_64                randconfig-074-20240530   clang
x86_64                randconfig-075-20240530   gcc  
x86_64                randconfig-076-20240530   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240530   gcc  
xtensa                randconfig-002-20240530   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

