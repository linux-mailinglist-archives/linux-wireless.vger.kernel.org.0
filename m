Return-Path: <linux-wireless+bounces-22012-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21529A9B5F7
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 20:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2F9C3AD7C3
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 18:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE688190664;
	Thu, 24 Apr 2025 18:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ltnn8AKb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD7428B4E1
	for <linux-wireless@vger.kernel.org>; Thu, 24 Apr 2025 18:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745518061; cv=none; b=jUAWbxpZ5gEMs12xQ+UudzGys4srBLvFTKTv3/3/mCShTps9wGwfhV2q0T301chbmiYmopIQlHgzy/MTKROAr7lY06Zl1IQsmLKFj+jiBpNc4+7gKc5jPM9M9/5VoB/dSkZXEdE4lfAW79L7d5Bvf8QtSwcq1i311rPbHshaI54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745518061; c=relaxed/simple;
	bh=37cz90cUNsz9PThJa5HQyMTwKHoEOS3HANpDuEmfWiM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=uWuA8pKfgGGtPr4WnAohaWwdPbZPWd3eg/aENdwWYXBxv4QFTDlxdGrGfIfHkxYVP0gipHLrAR9ge63SqHDji+KxNqkAz3DB6fTpioHBFOIChVS7Z/J7R/Dq3U+svhpIZ/VAoCDj3FwKY8/7QcCy89xGV6fz2GFXbJzmBJZ6k+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ltnn8AKb; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745518060; x=1777054060;
  h=date:from:to:cc:subject:message-id;
  bh=37cz90cUNsz9PThJa5HQyMTwKHoEOS3HANpDuEmfWiM=;
  b=Ltnn8AKbI2N2hLZyg5b4l0b4pDn66cCYFpguG3aQ4IOy4tgUw3Glp8Xg
   SR/smQIcnOrTlDyAHB4tEFWwzRHuL6AEFc9//yYrW6p6HxuSkBcH22Ll5
   3ElpLvHjMkobwnBkAL0MFe+tS/g3CtbLgVQZ3kGCXmz2V67m12EPYzm7c
   z/alBXcuki12SGJq4sa1YZKHuz2SItCahVTreP0lreUWq4t3hJandmMvL
   WJvOIsxQoUUcLroUtlUwEJemFiKP5+smgmvVQxKDXVmbkdBBqS0KSCDI5
   op5jMfjmBFOTy/9EHeC9CvOhZLomPIU1ArUyPG62glBzC/Q/pS9gvd/Bi
   w==;
X-CSE-ConnectionGUID: kzVaCFX5S8Kta7AeWOVsoA==
X-CSE-MsgGUID: t3rBkbCfRpym7zUPhTHNQA==
X-IronPort-AV: E=McAfee;i="6700,10204,11413"; a="47051322"
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="47051322"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 11:07:39 -0700
X-CSE-ConnectionGUID: hgmtLklyRtuI2tQXscE19A==
X-CSE-MsgGUID: EcIRzcb4SlaC8CsVmCS/Ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="133211670"
Received: from lkp-server01.sh.intel.com (HELO 050dd05385d1) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 24 Apr 2025 11:07:38 -0700
Received: from kbuild by 050dd05385d1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u80z1-0004PC-0v;
	Thu, 24 Apr 2025 18:07:35 +0000
Date: Fri, 25 Apr 2025 02:07:15 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 f600832794c91d7021d7337104734246b02a2b86
Message-ID: <202504250206.38xb1tmQ-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: f600832794c91d7021d7337104734246b02a2b86  wifi: mac80211: restructure tx profile retrieval for MLO MBSSID

elapsed time: 1445m

configs tested: 212
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    gcc-14.2.0
arc                   randconfig-001-20250424    gcc-14.2.0
arc                   randconfig-001-20250424    gcc-8.5.0
arc                   randconfig-002-20250424    gcc-14.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-14.2.0
arm                       aspeed_g4_defconfig    gcc-14.2.0
arm                   randconfig-001-20250424    gcc-14.2.0
arm                   randconfig-001-20250424    gcc-7.5.0
arm                   randconfig-002-20250424    gcc-14.2.0
arm                   randconfig-002-20250424    gcc-7.5.0
arm                   randconfig-003-20250424    clang-21
arm                   randconfig-003-20250424    gcc-14.2.0
arm                   randconfig-004-20250424    clang-21
arm                   randconfig-004-20250424    gcc-14.2.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250424    clang-21
arm64                 randconfig-001-20250424    gcc-14.2.0
arm64                 randconfig-002-20250424    gcc-14.2.0
arm64                 randconfig-002-20250424    gcc-8.5.0
arm64                 randconfig-003-20250424    clang-21
arm64                 randconfig-003-20250424    gcc-14.2.0
arm64                 randconfig-004-20250424    gcc-14.2.0
arm64                 randconfig-004-20250424    gcc-8.5.0
csky                             alldefconfig    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250424    gcc-12.4.0
csky                  randconfig-001-20250424    gcc-9.3.0
csky                  randconfig-002-20250424    gcc-14.2.0
csky                  randconfig-002-20250424    gcc-9.3.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250424    clang-21
hexagon               randconfig-001-20250424    gcc-9.3.0
hexagon               randconfig-002-20250424    clang-21
hexagon               randconfig-002-20250424    gcc-9.3.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250424    gcc-12
i386        buildonly-randconfig-002-20250424    clang-20
i386        buildonly-randconfig-002-20250424    gcc-12
i386        buildonly-randconfig-003-20250424    clang-20
i386        buildonly-randconfig-003-20250424    gcc-12
i386        buildonly-randconfig-004-20250424    clang-20
i386        buildonly-randconfig-004-20250424    gcc-12
i386        buildonly-randconfig-005-20250424    gcc-12
i386        buildonly-randconfig-006-20250424    clang-20
i386        buildonly-randconfig-006-20250424    gcc-12
i386                                defconfig    clang-20
i386                  randconfig-001-20250424    clang-20
i386                  randconfig-002-20250424    clang-20
i386                  randconfig-003-20250424    clang-20
i386                  randconfig-004-20250424    clang-20
i386                  randconfig-005-20250424    clang-20
i386                  randconfig-006-20250424    clang-20
i386                  randconfig-007-20250424    clang-20
i386                  randconfig-011-20250424    gcc-12
i386                  randconfig-012-20250424    gcc-12
i386                  randconfig-013-20250424    gcc-12
i386                  randconfig-014-20250424    gcc-12
i386                  randconfig-015-20250424    gcc-12
i386                  randconfig-016-20250424    gcc-12
i386                  randconfig-017-20250424    gcc-12
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250424    gcc-14.2.0
loongarch             randconfig-001-20250424    gcc-9.3.0
loongarch             randconfig-002-20250424    gcc-12.4.0
loongarch             randconfig-002-20250424    gcc-9.3.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                        stmark2_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                           ci20_defconfig    gcc-14.2.0
mips                           ip32_defconfig    gcc-14.2.0
mips                   sb1250_swarm_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250424    gcc-10.5.0
nios2                 randconfig-001-20250424    gcc-9.3.0
nios2                 randconfig-002-20250424    gcc-10.5.0
nios2                 randconfig-002-20250424    gcc-9.3.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250424    gcc-9.3.0
parisc                randconfig-002-20250424    gcc-7.5.0
parisc                randconfig-002-20250424    gcc-9.3.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc                      pmac32_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250424    clang-21
powerpc               randconfig-001-20250424    gcc-9.3.0
powerpc               randconfig-002-20250424    clang-17
powerpc               randconfig-002-20250424    gcc-9.3.0
powerpc               randconfig-003-20250424    clang-21
powerpc               randconfig-003-20250424    gcc-9.3.0
powerpc                     taishan_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20250424    clang-21
powerpc64             randconfig-001-20250424    gcc-9.3.0
powerpc64             randconfig-002-20250424    clang-21
powerpc64             randconfig-002-20250424    gcc-9.3.0
powerpc64             randconfig-003-20250424    clang-21
powerpc64             randconfig-003-20250424    gcc-9.3.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250424    clang-21
riscv                 randconfig-002-20250424    clang-21
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250424    clang-21
s390                  randconfig-001-20250424    gcc-9.3.0
s390                  randconfig-002-20250424    clang-21
s390                  randconfig-002-20250424    gcc-9.3.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                        edosk7760_defconfig    gcc-14.2.0
sh                          r7780mp_defconfig    gcc-14.2.0
sh                    randconfig-001-20250424    clang-21
sh                    randconfig-001-20250424    gcc-12.4.0
sh                    randconfig-002-20250424    clang-21
sh                    randconfig-002-20250424    gcc-6.5.0
sh                          sdk7780_defconfig    gcc-14.2.0
sh                           se7721_defconfig    gcc-14.2.0
sh                           se7722_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250424    clang-21
sparc                 randconfig-001-20250424    gcc-10.3.0
sparc                 randconfig-002-20250424    clang-21
sparc                 randconfig-002-20250424    gcc-11.5.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250424    clang-21
sparc64               randconfig-001-20250424    gcc-9.3.0
sparc64               randconfig-002-20250424    clang-21
sparc64               randconfig-002-20250424    gcc-7.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250424    clang-21
um                    randconfig-002-20250424    clang-21
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250424    gcc-12
x86_64      buildonly-randconfig-002-20250424    clang-20
x86_64      buildonly-randconfig-002-20250424    gcc-12
x86_64      buildonly-randconfig-003-20250424    gcc-12
x86_64      buildonly-randconfig-004-20250424    clang-20
x86_64      buildonly-randconfig-004-20250424    gcc-12
x86_64      buildonly-randconfig-005-20250424    clang-20
x86_64      buildonly-randconfig-005-20250424    gcc-12
x86_64      buildonly-randconfig-006-20250424    gcc-12
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250424    gcc-12
x86_64                randconfig-002-20250424    gcc-12
x86_64                randconfig-003-20250424    gcc-12
x86_64                randconfig-004-20250424    gcc-12
x86_64                randconfig-005-20250424    gcc-12
x86_64                randconfig-006-20250424    gcc-12
x86_64                randconfig-007-20250424    gcc-12
x86_64                randconfig-008-20250424    gcc-12
x86_64                randconfig-071-20250424    clang-20
x86_64                randconfig-072-20250424    clang-20
x86_64                randconfig-073-20250424    clang-20
x86_64                randconfig-074-20250424    clang-20
x86_64                randconfig-075-20250424    clang-20
x86_64                randconfig-076-20250424    clang-20
x86_64                randconfig-077-20250424    clang-20
x86_64                randconfig-078-20250424    clang-20
x86_64                               rhel-9.4    clang-20
xtensa                            allnoconfig    gcc-14.2.0
xtensa                  cadence_csp_defconfig    gcc-14.2.0
xtensa                          iss_defconfig    gcc-14.2.0
xtensa                randconfig-001-20250424    clang-21
xtensa                randconfig-001-20250424    gcc-14.2.0
xtensa                randconfig-002-20250424    clang-21
xtensa                randconfig-002-20250424    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

