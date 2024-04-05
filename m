Return-Path: <linux-wireless+bounces-5886-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEAA189941E
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Apr 2024 06:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C02D1F25CDC
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Apr 2024 04:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C4614273;
	Fri,  5 Apr 2024 04:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k+k8LZnz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D638256D
	for <linux-wireless@vger.kernel.org>; Fri,  5 Apr 2024 04:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712291610; cv=none; b=BIAYQ0YiY2+wIqU1uhcUcFyjsQls81Yls5JJbFHsePgX0h57UHHPpYpeot1WsHgs0Uni4KdXhbBUYDVLgLjnraZ8fQ1aXtRaH3RxUubGpsIQwSrgaTUeuqASVw4rvpm3gL5ub6ChbjpyQc0vrxb4ZQZAZEgPMSYVUmZFz2zSYdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712291610; c=relaxed/simple;
	bh=DrTuInCd3MC+CuEoQx8UpP/77sCTU6SikvBXgcojOuk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=UiUh/VFls/V0UIIR0Z3isX2UdXMC5FVJYi197axa/xwjdflfBneQR05sScWzw91IIlcqSrFYsvtWfJR1ujECJHZjeRfyqdHCQntyTpdn2QLnMG3rhjLO5Pcjv5HRL/iJVLNr4H0SR6xkiBLgjOajqfBhyV9IpZTnZfM3EOvaVgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k+k8LZnz; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712291608; x=1743827608;
  h=date:from:to:cc:subject:message-id;
  bh=DrTuInCd3MC+CuEoQx8UpP/77sCTU6SikvBXgcojOuk=;
  b=k+k8LZnz91WoBO5/MT2OH17dSVmHCdKI7nEWn4MT4qvKOr47uKAW+azz
   CTKwQR22y7IaYKhWvV1jBZfMDIY+SQOXdOjD4C8JNpqaFzFvjKK2VjlmS
   jutEXhG+86n28XSv5IeZMXGih8pH6c2L5RhvXbZeDnFZF+WzIxpdYyCM7
   3lqGR8oMOIUEYjKodi4vXf7lDRMa5+ErQVuKwHnKmcqlFUTHx3LrY92iF
   lh1S4lAdZZXMralz6ZhJ4KMfJ7SkfC88rmdyaisvxv0dwDAZ5eRRZ5JPD
   TuXEY9fqNOO/RbTvKmQtuJBgv6zbdOT0UM5jDfcA6qUbuNtRNba6LTN+6
   A==;
X-CSE-ConnectionGUID: b4fISGCySdWAibGXahwLmQ==
X-CSE-MsgGUID: H6nOIdsmTtKmPTP50S36fg==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="7474731"
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208";a="7474731"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 21:33:28 -0700
X-CSE-ConnectionGUID: uE066LkFQtqBs5zdVLqpQg==
X-CSE-MsgGUID: lptMcooVRui8cRKAcNtsaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208";a="23770488"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 04 Apr 2024 21:33:27 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rsbGW-0001t4-0e;
	Fri, 05 Apr 2024 04:33:24 +0000
Date: Fri, 05 Apr 2024 12:32:55 +0800
From: kernel test robot <lkp@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 57a03d83f229126b0aab6f305821358755c7b130
Message-ID: <202404051252.UhVnwA15-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 57a03d83f229126b0aab6f305821358755c7b130  Merge branch 'mlxsw-preparations-for-improving-performance'

elapsed time: 1519m

configs tested: 212
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
arc                         haps_hs_defconfig   gcc  
arc                        nsim_700_defconfig   gcc  
arc                   randconfig-001-20240404   gcc  
arc                   randconfig-002-20240404   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                            hisi_defconfig   gcc  
arm                            mmp2_defconfig   gcc  
arm                        neponset_defconfig   gcc  
arm                   randconfig-001-20240404   gcc  
arm                   randconfig-002-20240404   gcc  
arm                   randconfig-003-20240404   clang
arm                   randconfig-004-20240404   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240404   gcc  
arm64                 randconfig-002-20240404   gcc  
arm64                 randconfig-003-20240404   clang
arm64                 randconfig-004-20240404   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240404   gcc  
csky                  randconfig-002-20240404   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240404   clang
hexagon               randconfig-002-20240404   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240404   gcc  
i386         buildonly-randconfig-002-20240404   clang
i386         buildonly-randconfig-003-20240404   clang
i386         buildonly-randconfig-003-20240405   clang
i386         buildonly-randconfig-004-20240404   gcc  
i386         buildonly-randconfig-005-20240404   clang
i386         buildonly-randconfig-005-20240405   clang
i386         buildonly-randconfig-006-20240404   gcc  
i386         buildonly-randconfig-006-20240405   clang
i386                                defconfig   clang
i386                  randconfig-001-20240404   gcc  
i386                  randconfig-001-20240405   clang
i386                  randconfig-002-20240404   clang
i386                  randconfig-003-20240404   clang
i386                  randconfig-003-20240405   clang
i386                  randconfig-004-20240404   gcc  
i386                  randconfig-004-20240405   clang
i386                  randconfig-005-20240404   clang
i386                  randconfig-005-20240405   clang
i386                  randconfig-006-20240404   clang
i386                  randconfig-011-20240404   gcc  
i386                  randconfig-011-20240405   clang
i386                  randconfig-012-20240404   clang
i386                  randconfig-013-20240404   gcc  
i386                  randconfig-014-20240404   clang
i386                  randconfig-015-20240404   gcc  
i386                  randconfig-016-20240404   gcc  
i386                  randconfig-016-20240405   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240404   gcc  
loongarch             randconfig-002-20240404   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                         amcore_defconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                     cu1830-neo_defconfig   gcc  
mips                 decstation_r4k_defconfig   gcc  
mips                malta_qemu_32r6_defconfig   gcc  
nios2                         3c120_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240404   gcc  
nios2                 randconfig-002-20240404   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-32bit_defconfig   gcc  
parisc                randconfig-001-20240404   gcc  
parisc                randconfig-002-20240404   gcc  
parisc64                         alldefconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                        cell_defconfig   gcc  
powerpc                    ge_imp3a_defconfig   gcc  
powerpc                     kmeter1_defconfig   gcc  
powerpc                     powernv_defconfig   gcc  
powerpc                         ps3_defconfig   gcc  
powerpc               randconfig-001-20240404   gcc  
powerpc               randconfig-002-20240404   gcc  
powerpc               randconfig-003-20240404   clang
powerpc                    socrates_defconfig   gcc  
powerpc                      walnut_defconfig   gcc  
powerpc64             randconfig-001-20240404   gcc  
powerpc64             randconfig-002-20240404   clang
powerpc64             randconfig-003-20240404   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240404   clang
riscv                 randconfig-002-20240404   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                          debug_defconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240404   gcc  
s390                  randconfig-002-20240404   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                         apsh4a3a_defconfig   gcc  
sh                                  defconfig   gcc  
sh                ecovec24-romimage_defconfig   gcc  
sh                             espt_defconfig   gcc  
sh                            hp6xx_defconfig   gcc  
sh                          kfr2r09_defconfig   gcc  
sh                    randconfig-001-20240404   gcc  
sh                    randconfig-002-20240404   gcc  
sh                          rsk7201_defconfig   gcc  
sh                          rsk7264_defconfig   gcc  
sh                   rts7751r2dplus_defconfig   gcc  
sh                          sdk7786_defconfig   gcc  
sh                           sh2007_defconfig   gcc  
sh                   sh7770_generic_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                       sparc32_defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240404   gcc  
sparc64               randconfig-002-20240404   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240404   clang
um                    randconfig-002-20240404   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240404   gcc  
x86_64       buildonly-randconfig-002-20240404   gcc  
x86_64       buildonly-randconfig-003-20240404   gcc  
x86_64       buildonly-randconfig-004-20240404   clang
x86_64       buildonly-randconfig-005-20240404   clang
x86_64       buildonly-randconfig-006-20240404   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240404   clang
x86_64                randconfig-002-20240404   gcc  
x86_64                randconfig-003-20240404   clang
x86_64                randconfig-004-20240404   gcc  
x86_64                randconfig-005-20240404   gcc  
x86_64                randconfig-006-20240404   gcc  
x86_64                randconfig-011-20240404   clang
x86_64                randconfig-012-20240404   clang
x86_64                randconfig-013-20240404   clang
x86_64                randconfig-014-20240404   clang
x86_64                randconfig-015-20240404   gcc  
x86_64                randconfig-016-20240404   gcc  
x86_64                randconfig-071-20240404   gcc  
x86_64                randconfig-072-20240404   clang
x86_64                randconfig-073-20240404   clang
x86_64                randconfig-074-20240404   gcc  
x86_64                randconfig-075-20240404   clang
x86_64                randconfig-076-20240404   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                generic_kc705_defconfig   gcc  
xtensa                  nommu_kc705_defconfig   gcc  
xtensa                randconfig-001-20240404   gcc  
xtensa                randconfig-002-20240404   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

