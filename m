Return-Path: <linux-wireless+bounces-6587-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 871318AB604
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Apr 2024 22:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E8C32814A2
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Apr 2024 20:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB7010A35;
	Fri, 19 Apr 2024 20:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DIHdCY8Q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EA864F
	for <linux-wireless@vger.kernel.org>; Fri, 19 Apr 2024 20:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713558799; cv=none; b=X/VMPjuZFmYnOUX39nog89B9/lyuQez9bSEQS2Vdbpm+6/rrsi2DQle7vqJgYT+vNyRDCZ86D0f67VWaa79DLOTx7t/pD0UuBeyqGt3iJhrhilILt6fkEf0iY+c1sUrpdqb088zNqgBkyyz55+1PRsDo+ntBjZkgzAodTMSsHDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713558799; c=relaxed/simple;
	bh=Y7C5Qsy+MKs3IMaytxzL1ezCaEJCW5luX3oBKresaY4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ZWyAmSW0Ae+z0Kkq2V2APxfBcDbgTpcrgfjcLjT64GXmrokIcQwex/dZhWbrbh+nToJT4AGnPeDrc/13a4mCKdgo50NIvvqXgIu7CI7f3SHWxrt6AiiUHo5ll28AMxncaq6TorUr76SAlZGrsBJKF73EFvRA0OyV6+VAGYYuhmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DIHdCY8Q; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713558798; x=1745094798;
  h=date:from:to:cc:subject:message-id;
  bh=Y7C5Qsy+MKs3IMaytxzL1ezCaEJCW5luX3oBKresaY4=;
  b=DIHdCY8QRbJFkqNHUrhBDGDtsqyV3w6t0/3vtfJcB+sDgLgrbka03Rsn
   Nu7+edrR+N8dIczfx87V1/VAnD16rZ1ymStpg/nb2xw94AlmTtj8eMM17
   orh9k+1gEs4/rCtgV6NzFFY/Bvyg32Us9gPy35zDFfLO1WkD90ArCSFnE
   AUT16eZmfr4uylhFm3T0fFem6kUK/NRG+JztiUXyje3CdWDzwkm/445KA
   v5kL0mvI2SFtf4hT81pF1sDvnP5TmmmbNUjl+ra8KZfnAXJfwcvcAtVXw
   hUhoklV+ye6j2ZS72BQCKg2IpZa5mw3Z7uldY43vPcG2IA4GrlZtiUgSJ
   Q==;
X-CSE-ConnectionGUID: 84Yfy2DhQr63yJchjnxhGg==
X-CSE-MsgGUID: 1gXd3L5fQxaw9W95NpvYzg==
X-IronPort-AV: E=McAfee;i="6600,9927,11049"; a="12971365"
X-IronPort-AV: E=Sophos;i="6.07,214,1708416000"; 
   d="scan'208";a="12971365"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 13:33:18 -0700
X-CSE-ConnectionGUID: x45tfajtSrGndwt1qAXV2w==
X-CSE-MsgGUID: vInArVV0RgyxCFSGWpEL0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,214,1708416000"; 
   d="scan'208";a="23878803"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 19 Apr 2024 13:33:17 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rxuv3-000ARs-32;
	Fri, 19 Apr 2024 20:33:13 +0000
Date: Sat, 20 Apr 2024 04:32:16 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: [wireless:for-next] BUILD SUCCESS
 c53d8a59351e4347452e263e2e5d7446ec93da83
Message-ID: <202404200413.4aEiHsaW-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git for-next
branch HEAD: c53d8a59351e4347452e263e2e5d7446ec93da83  wifi: mac80211: fix unaligned le16 access

elapsed time: 723m

configs tested: 139
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
arc                                 defconfig   gcc  
arc                   randconfig-001-20240419   gcc  
arc                   randconfig-002-20240419   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240419   gcc  
arm                   randconfig-002-20240419   clang
arm                   randconfig-003-20240419   gcc  
arm                   randconfig-004-20240419   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240419   clang
arm64                 randconfig-002-20240419   clang
arm64                 randconfig-003-20240419   clang
arm64                 randconfig-004-20240419   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240419   gcc  
csky                  randconfig-002-20240419   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240419   clang
hexagon               randconfig-002-20240419   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240419   clang
i386         buildonly-randconfig-002-20240419   gcc  
i386         buildonly-randconfig-003-20240419   gcc  
i386         buildonly-randconfig-004-20240419   gcc  
i386         buildonly-randconfig-005-20240419   gcc  
i386         buildonly-randconfig-006-20240419   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240419   clang
i386                  randconfig-002-20240419   clang
i386                  randconfig-003-20240419   clang
i386                  randconfig-004-20240419   gcc  
i386                  randconfig-005-20240419   clang
i386                  randconfig-006-20240419   clang
i386                  randconfig-011-20240419   gcc  
i386                  randconfig-012-20240419   clang
i386                  randconfig-013-20240419   gcc  
i386                  randconfig-014-20240419   clang
i386                  randconfig-015-20240419   gcc  
i386                  randconfig-016-20240419   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240419   gcc  
loongarch             randconfig-002-20240419   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240419   gcc  
nios2                 randconfig-002-20240419   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240419   gcc  
parisc                randconfig-002-20240419   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc               randconfig-001-20240419   gcc  
powerpc               randconfig-002-20240419   gcc  
powerpc               randconfig-003-20240419   gcc  
powerpc64             randconfig-001-20240419   gcc  
powerpc64             randconfig-002-20240419   gcc  
powerpc64             randconfig-003-20240419   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240419   clang
riscv                 randconfig-002-20240419   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240419   clang
s390                  randconfig-002-20240419   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240419   gcc  
sh                    randconfig-002-20240419   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240419   gcc  
sparc64               randconfig-002-20240419   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240419   gcc  
um                    randconfig-002-20240419   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240419   gcc  
xtensa                randconfig-002-20240419   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

