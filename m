Return-Path: <linux-wireless+bounces-5310-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA57188D390
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Mar 2024 01:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20ED9B23711
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Mar 2024 00:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76827FBF3;
	Wed, 27 Mar 2024 00:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UMALPRtg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEF828EC
	for <linux-wireless@vger.kernel.org>; Wed, 27 Mar 2024 00:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711501151; cv=none; b=nEouhKK6+WVj0oMwtjdcVoBJhcKljYB+nl1DX1VWX/cREYzKTILG5V8wn1zmwlZLfQBxD6W0+zASNFOq48U17FCdaLccT0A523e6lnUbEkp/hi0EHGwoDCv5wADHTK3Krw9HM4j4NZ1sM/rPN0PCbfERW+e4Jqcp22D8nEPhtYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711501151; c=relaxed/simple;
	bh=77gOOmsSViGurKEL6K6afIF8bBaUCQg91wAe1haihNk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=j5LGXe0ldaE5+Fxcwdu1s4s/BOsbzJeGmseEnQC0KhZEc36hLuaPoGKcCANXz4SwitP6OfexRm/c7IttmAAy0go9mk4hQnQ9N8rvzUl0Qaiq/3HSTFc3pKcOyYLWrBSMEEOnwNuS/mS6aMT50ukLmh8g/XLE46jvpMXTjBBG0Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UMALPRtg; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711501149; x=1743037149;
  h=date:from:to:cc:subject:message-id;
  bh=77gOOmsSViGurKEL6K6afIF8bBaUCQg91wAe1haihNk=;
  b=UMALPRtgLWOqfmJc3RqnNfwfcIjLaPvfVNne+AJet8rVg3mM09Mo18Sd
   G1jy+Hg75zuerJcJBUG6DT/ukYR/7NqPOBoOATwNvL7lGqf0GX5OVHjOE
   b2jZHypMk40pMedix+0TgP/l0sfTH19LOPNOqSQfuTZy7uKF2NYRX/Dli
   kDoE0jtSHLHA/kcCNLr7syjQ8KNUQEO3VlmkTOVa9Jbt7ZSaaeJ4Kexnp
   f0dI09lHCVZwD7ltU8f8T9+LNYxr2gQM4CvR2pIpX+ITcfx7J6trP50Uf
   avJR51zZttcDzVdU9tVCDikfmSO/qG6IV3/vDOsNYsaxhgQIOqTsyxEq9
   A==;
X-CSE-ConnectionGUID: B6m5T2yZREG0tD+Une5WKw==
X-CSE-MsgGUID: Hd4pmyQ/RTakZemvLigY1Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="10361141"
X-IronPort-AV: E=Sophos;i="6.07,157,1708416000"; 
   d="scan'208";a="10361141"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 17:59:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,157,1708416000"; 
   d="scan'208";a="20675867"
Received: from lkp-server01.sh.intel.com (HELO be39aa325d23) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 26 Mar 2024 17:59:06 -0700
Received: from kbuild by be39aa325d23 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rpHdA-0000aF-0t;
	Wed, 27 Mar 2024 00:59:04 +0000
Date: Wed, 27 Mar 2024 08:58:24 +0800
From: kernel test robot <lkp@intel.com>
To: Kalle Valo <kvalo@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless@vger.kernel.org
Subject: [wireless:for-next] BUILD SUCCESS
 8ea3f4f1a1b4242d5fc273f41aa7c86f6b40178c
Message-ID: <202403270820.vru0Jx56-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git for-next
branch HEAD: 8ea3f4f1a1b4242d5fc273f41aa7c86f6b40178c  MAINTAINERS: wifi: mwifiex: add Francesco as reviewer

elapsed time: 741m

configs tested: 181
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
arc                   randconfig-001-20240326   gcc  
arc                   randconfig-002-20240326   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240326   gcc  
arm                   randconfig-002-20240326   gcc  
arm                   randconfig-003-20240326   gcc  
arm                   randconfig-004-20240326   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240326   clang
arm64                 randconfig-002-20240326   clang
arm64                 randconfig-003-20240326   gcc  
arm64                 randconfig-004-20240326   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240326   gcc  
csky                  randconfig-002-20240326   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240326   clang
hexagon               randconfig-002-20240326   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240326   gcc  
i386         buildonly-randconfig-001-20240327   gcc  
i386         buildonly-randconfig-002-20240326   clang
i386         buildonly-randconfig-002-20240327   gcc  
i386         buildonly-randconfig-003-20240326   clang
i386         buildonly-randconfig-003-20240327   clang
i386         buildonly-randconfig-004-20240326   gcc  
i386         buildonly-randconfig-004-20240327   clang
i386         buildonly-randconfig-005-20240326   gcc  
i386         buildonly-randconfig-005-20240327   clang
i386         buildonly-randconfig-006-20240326   gcc  
i386         buildonly-randconfig-006-20240327   clang
i386                                defconfig   clang
i386                  randconfig-001-20240326   gcc  
i386                  randconfig-001-20240327   gcc  
i386                  randconfig-002-20240326   gcc  
i386                  randconfig-002-20240327   gcc  
i386                  randconfig-003-20240326   gcc  
i386                  randconfig-003-20240327   clang
i386                  randconfig-004-20240326   clang
i386                  randconfig-004-20240327   gcc  
i386                  randconfig-005-20240326   gcc  
i386                  randconfig-005-20240327   clang
i386                  randconfig-006-20240326   clang
i386                  randconfig-006-20240327   gcc  
i386                  randconfig-011-20240326   clang
i386                  randconfig-011-20240327   gcc  
i386                  randconfig-012-20240326   gcc  
i386                  randconfig-012-20240327   clang
i386                  randconfig-013-20240326   clang
i386                  randconfig-013-20240327   gcc  
i386                  randconfig-014-20240326   clang
i386                  randconfig-014-20240327   clang
i386                  randconfig-015-20240326   clang
i386                  randconfig-015-20240327   gcc  
i386                  randconfig-016-20240326   clang
i386                  randconfig-016-20240327   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240326   gcc  
loongarch             randconfig-002-20240326   gcc  
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
nios2                 randconfig-001-20240326   gcc  
nios2                 randconfig-002-20240326   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240326   gcc  
parisc                randconfig-002-20240326   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc               randconfig-001-20240326   clang
powerpc               randconfig-002-20240326   gcc  
powerpc               randconfig-003-20240326   clang
powerpc64             randconfig-001-20240326   gcc  
powerpc64             randconfig-002-20240326   gcc  
powerpc64             randconfig-003-20240326   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240326   gcc  
riscv                 randconfig-002-20240326   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240326   clang
s390                  randconfig-002-20240326   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240326   gcc  
sh                    randconfig-002-20240326   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240326   gcc  
sparc64               randconfig-002-20240326   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240326   gcc  
um                    randconfig-002-20240326   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240327   gcc  
x86_64       buildonly-randconfig-002-20240327   gcc  
x86_64       buildonly-randconfig-003-20240327   gcc  
x86_64       buildonly-randconfig-004-20240327   clang
x86_64       buildonly-randconfig-005-20240327   gcc  
x86_64       buildonly-randconfig-006-20240327   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240327   clang
x86_64                randconfig-002-20240327   gcc  
x86_64                randconfig-003-20240327   gcc  
x86_64                randconfig-004-20240327   gcc  
x86_64                randconfig-005-20240327   clang
x86_64                randconfig-006-20240327   clang
x86_64                randconfig-011-20240327   gcc  
x86_64                randconfig-012-20240327   clang
x86_64                randconfig-013-20240327   clang
x86_64                randconfig-014-20240327   clang
x86_64                randconfig-015-20240327   clang
x86_64                randconfig-016-20240327   clang
x86_64                randconfig-071-20240327   gcc  
x86_64                randconfig-072-20240327   clang
x86_64                randconfig-073-20240327   clang
x86_64                randconfig-074-20240327   clang
x86_64                randconfig-075-20240327   clang
x86_64                randconfig-076-20240327   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240326   gcc  
xtensa                randconfig-002-20240326   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

