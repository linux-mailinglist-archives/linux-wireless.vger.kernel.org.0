Return-Path: <linux-wireless+bounces-18841-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F263A325B3
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 13:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB0B0188B4AF
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 12:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9857420B217;
	Wed, 12 Feb 2025 12:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WAD4mK8v"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDCB271822
	for <linux-wireless@vger.kernel.org>; Wed, 12 Feb 2025 12:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739362371; cv=none; b=EcuhvO/OVdGgARKURK2J1bNCoo2u1cAWDYtv5LYEzq4XvqHIHCDGVfcfYa1Uju3VVlfIQ8vXNfAzzdinnO3+obPOZgNv+97qom35gJW6rIMIH+8IhJlomRsKBxNwABsdsg4qc++s0G7X7LcG/DTlJKaBbkk2kiPevi9xQZDO4Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739362371; c=relaxed/simple;
	bh=t0DcQjTfOGYhjoTsZQq8pANG+rpZnk2fhF13tfPvSq0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=C9mTPp2JrEp0XNL7VVaVvUFn1egLPw1IGdHahPEDUEqDi4KsuwADdTFdb0gigy4lwXryqZzGF+xPgfNfd2wt62tfeg7jXFo3zgB9FL1Q+8qba9FbNu3oT154hd1bxH7GvdzLwcnEbO6RB9sCJvLF85tM5Sf//2Zwqj6eSwxYkuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WAD4mK8v; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739362369; x=1770898369;
  h=date:from:to:cc:subject:message-id;
  bh=t0DcQjTfOGYhjoTsZQq8pANG+rpZnk2fhF13tfPvSq0=;
  b=WAD4mK8vt2kIK0GR/7+iFMUx4Q0HtL/EoHYehWZLUDby7f2+aLv4cPuO
   WQDQHMQIoJTkSiq/pRF5zhQuKc2o/HQOoxYqBO5ShlXot4QOdj+orUwfZ
   GrO5bt6K0AlpvzFBaE6JIyyaLTsKQtq5n9YmXLGrF9EArvCzcDPkLOdeK
   qa9NLQiZGuRBGvtI289wl5GB5CiTa8rY9g4l5Sw7lyWA9KDu7M75hDalf
   ytbF8RMkkQSNx9fLFH5OmZ577S37X+fL8VIcFDYpuC0i5o6JlrQmQ9bZF
   /jG1imJtIQM6LoE3KdA0vPEfoWwSCVMlYyXO1/zcaLkNdDlmEEOo4SL/b
   w==;
X-CSE-ConnectionGUID: PDxsax2NQwCYrQu2eiXHGg==
X-CSE-MsgGUID: vMmPPiddQM2JjxUvd+Wc6A==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="43778085"
X-IronPort-AV: E=Sophos;i="6.13,280,1732608000"; 
   d="scan'208";a="43778085"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 04:12:49 -0800
X-CSE-ConnectionGUID: RHsIMxuXRgO1b6D9exvDVA==
X-CSE-MsgGUID: 7ep+U3c7Q16gEcon5/SGhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,280,1732608000"; 
   d="scan'208";a="143657188"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 12 Feb 2025 04:12:48 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tiBbh-0015aJ-1V;
	Wed, 12 Feb 2025 12:12:45 +0000
Date: Wed, 12 Feb 2025 20:12:17 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: [wireless:for-next] BUILD SUCCESS
 3640dbc1f75ce15d128ea4af44226960d894f3fd
Message-ID: <202502122004.ZQeDWnuk-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git for-next
branch HEAD: 3640dbc1f75ce15d128ea4af44226960d894f3fd  wifi: iwlwifi: Fix A-MSDU TSO preparation

elapsed time: 1325m

configs tested: 151
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20250211    gcc-13.2.0
arc                   randconfig-001-20250212    gcc-13.2.0
arc                   randconfig-002-20250211    gcc-13.2.0
arc                   randconfig-002-20250212    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                   randconfig-001-20250211    gcc-14.2.0
arm                   randconfig-001-20250212    clang-18
arm                   randconfig-002-20250211    clang-21
arm                   randconfig-002-20250212    clang-16
arm                   randconfig-003-20250211    gcc-14.2.0
arm                   randconfig-003-20250212    clang-21
arm                   randconfig-004-20250211    gcc-14.2.0
arm                   randconfig-004-20250212    clang-16
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250211    clang-17
arm64                 randconfig-001-20250212    gcc-14.2.0
arm64                 randconfig-002-20250211    clang-19
arm64                 randconfig-002-20250212    gcc-14.2.0
arm64                 randconfig-003-20250211    gcc-14.2.0
arm64                 randconfig-003-20250212    clang-16
arm64                 randconfig-004-20250211    clang-19
arm64                 randconfig-004-20250212    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250211    gcc-14.2.0
csky                  randconfig-001-20250212    gcc-14.2.0
csky                  randconfig-002-20250211    gcc-14.2.0
csky                  randconfig-002-20250212    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250211    clang-18
hexagon               randconfig-001-20250212    clang-21
hexagon               randconfig-002-20250211    clang-21
hexagon               randconfig-002-20250212    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250211    gcc-12
i386        buildonly-randconfig-001-20250212    clang-19
i386        buildonly-randconfig-002-20250211    gcc-12
i386        buildonly-randconfig-002-20250212    gcc-12
i386        buildonly-randconfig-003-20250211    gcc-12
i386        buildonly-randconfig-003-20250212    gcc-12
i386        buildonly-randconfig-004-20250211    gcc-12
i386        buildonly-randconfig-004-20250212    gcc-12
i386        buildonly-randconfig-005-20250211    gcc-12
i386        buildonly-randconfig-005-20250212    gcc-12
i386        buildonly-randconfig-006-20250211    clang-19
i386        buildonly-randconfig-006-20250212    gcc-12
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250211    gcc-14.2.0
loongarch             randconfig-001-20250212    gcc-14.2.0
loongarch             randconfig-002-20250211    gcc-14.2.0
loongarch             randconfig-002-20250212    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
nios2                 randconfig-001-20250211    gcc-14.2.0
nios2                 randconfig-001-20250212    gcc-14.2.0
nios2                 randconfig-002-20250211    gcc-14.2.0
nios2                 randconfig-002-20250212    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                randconfig-001-20250211    gcc-14.2.0
parisc                randconfig-001-20250212    gcc-14.2.0
parisc                randconfig-002-20250211    gcc-14.2.0
parisc                randconfig-002-20250212    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc               randconfig-001-20250211    clang-15
powerpc               randconfig-001-20250212    gcc-14.2.0
powerpc               randconfig-002-20250211    clang-21
powerpc               randconfig-002-20250212    clang-16
powerpc               randconfig-003-20250211    clang-19
powerpc               randconfig-003-20250212    gcc-14.2.0
powerpc64             randconfig-001-20250211    clang-21
powerpc64             randconfig-001-20250212    clang-16
powerpc64             randconfig-002-20250211    gcc-14.2.0
powerpc64             randconfig-002-20250212    gcc-14.2.0
powerpc64             randconfig-003-20250211    clang-17
powerpc64             randconfig-003-20250212    gcc-14.2.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-21
riscv                 randconfig-001-20250211    gcc-14.2.0
riscv                 randconfig-001-20250212    clang-21
riscv                 randconfig-002-20250211    clang-19
riscv                 randconfig-002-20250212    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250211    clang-21
s390                  randconfig-001-20250212    clang-15
s390                  randconfig-002-20250211    gcc-14.2.0
s390                  randconfig-002-20250212    clang-17
sh                               allmodconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20250211    gcc-14.2.0
sh                    randconfig-001-20250212    gcc-14.2.0
sh                    randconfig-002-20250211    gcc-14.2.0
sh                    randconfig-002-20250212    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                 randconfig-001-20250211    gcc-14.2.0
sparc                 randconfig-001-20250212    gcc-14.2.0
sparc                 randconfig-002-20250211    gcc-14.2.0
sparc                 randconfig-002-20250212    gcc-14.2.0
sparc64               randconfig-001-20250211    gcc-14.2.0
sparc64               randconfig-001-20250212    gcc-14.2.0
sparc64               randconfig-002-20250211    gcc-14.2.0
sparc64               randconfig-002-20250212    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                    randconfig-001-20250211    clang-17
um                    randconfig-001-20250212    clang-16
um                    randconfig-002-20250211    clang-15
um                    randconfig-002-20250212    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250211    clang-19
x86_64      buildonly-randconfig-001-20250212    gcc-11
x86_64      buildonly-randconfig-002-20250211    gcc-12
x86_64      buildonly-randconfig-002-20250212    clang-19
x86_64      buildonly-randconfig-003-20250211    clang-19
x86_64      buildonly-randconfig-003-20250212    clang-19
x86_64      buildonly-randconfig-004-20250211    gcc-11
x86_64      buildonly-randconfig-004-20250212    clang-19
x86_64      buildonly-randconfig-005-20250211    clang-19
x86_64      buildonly-randconfig-005-20250212    gcc-12
x86_64      buildonly-randconfig-006-20250211    gcc-12
x86_64      buildonly-randconfig-006-20250212    clang-19
x86_64                              defconfig    gcc-11
xtensa                randconfig-001-20250211    gcc-14.2.0
xtensa                randconfig-001-20250212    gcc-14.2.0
xtensa                randconfig-002-20250211    gcc-14.2.0
xtensa                randconfig-002-20250212    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

