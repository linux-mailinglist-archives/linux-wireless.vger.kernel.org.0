Return-Path: <linux-wireless+bounces-25174-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B3AAFFF6A
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 12:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEDCC562D6A
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 10:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4469D2D9796;
	Thu, 10 Jul 2025 10:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cK4P+SXR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED13246788
	for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 10:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752143878; cv=none; b=o092SiGu9FIx/sDiD2wCXQleTY8qFHgZpQmY37uuXpWso7xozEHUF+Ta+iuZkik0zbd7If0s7usnga09h32RvBLRK1sLokBRgTiPrhQfR/dG02EalStN2USzwOzGcgVtnufMtV6HhlAfEmHsaADsjvHkr7nPCX8VJZOlbGyCN+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752143878; c=relaxed/simple;
	bh=X6ZUllq6/im6t2W7Tc/3gzK85y1Ah6hEyYrKAelkwIU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=gxLGn+M3IT6Ds5vtrUpJexc/ewCGW8KrJwdmLD2shrDEWmnCLKiMK88taDh04T7DnVqSiKwuMCPflgiA+R+VAXhdUKntnj+fgW+/F3DmDLc19+Pnwyr6pXY2Vsa7U+uGq/lBe08oWFEq6cZGbZ59vwyD047594B9cQuoOeg42o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cK4P+SXR; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752143876; x=1783679876;
  h=date:from:to:cc:subject:message-id;
  bh=X6ZUllq6/im6t2W7Tc/3gzK85y1Ah6hEyYrKAelkwIU=;
  b=cK4P+SXRVBLMAPZicS12rn4b9HHljPEv9HPJUx2vW94cAokIY7QG6Q0z
   AEhRiD1CbAYA48ZC4J9E8O//2UAATb9VMBJiev+afuDumIquSLoObZJgQ
   seJtW61D7x8ASLMVp+f3pfKC8vYcighUXzrQ602i3G/q8ds9RhTbrz/W1
   GJBy5KoRPTfMdC/LSnf97dap0j19Tor8+83V4h8KSqePw7FSqeTFVp/eQ
   IUcK5FEwO9vD9XGhHTO0CuqDX5/8RNLwkvj2eER7LO8SWUYXQAUjNOutM
   L9Wa2Y4bO7f2TKJFgURcmtFjvCyJlQzIeuSSe8CYR7+DzSVYHiyCgXSyu
   Q==;
X-CSE-ConnectionGUID: bJmMnmXzT7O1t3DrLJUamA==
X-CSE-MsgGUID: m5OtEggcTLG0YFiVzmUFKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="54514454"
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="54514454"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 03:37:55 -0700
X-CSE-ConnectionGUID: Wa33l3EzRPuTi14zKtIgMA==
X-CSE-MsgGUID: jcYxRhy+RpOd28Y0UJmxLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="155447726"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 10 Jul 2025 03:37:54 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uZof1-0004vh-25;
	Thu, 10 Jul 2025 10:37:51 +0000
Date: Thu, 10 Jul 2025 18:37:12 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 6b04716cdcac37bdbacde34def08bc6fdb5fc4e2
Message-ID: <202507101800.JWbGNr5A-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 6b04716cdcac37bdbacde34def08bc6fdb5fc4e2  wifi: mac80211: don't complete management TX on SAE commit

elapsed time: 1447m

configs tested: 152
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250709    gcc-8.5.0
arc                   randconfig-001-20250710    gcc-15.1.0
arc                   randconfig-002-20250709    gcc-11.5.0
arc                   randconfig-002-20250710    gcc-12.4.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-15.1.0
arm                   randconfig-001-20250709    gcc-12.4.0
arm                   randconfig-001-20250710    gcc-8.5.0
arm                   randconfig-002-20250709    gcc-10.5.0
arm                   randconfig-002-20250710    clang-21
arm                   randconfig-003-20250709    clang-21
arm                   randconfig-003-20250710    clang-21
arm                   randconfig-004-20250709    clang-21
arm                   randconfig-004-20250710    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250709    clang-21
arm64                 randconfig-001-20250710    clang-21
arm64                 randconfig-002-20250709    gcc-15.1.0
arm64                 randconfig-002-20250710    clang-21
arm64                 randconfig-003-20250709    clang-21
arm64                 randconfig-003-20250710    gcc-8.5.0
arm64                 randconfig-004-20250709    gcc-10.5.0
arm64                 randconfig-004-20250710    clang-21
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250709    gcc-15.1.0
csky                  randconfig-001-20250710    gcc-15.1.0
csky                  randconfig-002-20250709    gcc-15.1.0
csky                  randconfig-002-20250710    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250709    clang-19
hexagon               randconfig-001-20250710    clang-21
hexagon               randconfig-002-20250709    clang-21
hexagon               randconfig-002-20250710    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250709    gcc-12
i386        buildonly-randconfig-002-20250709    clang-20
i386        buildonly-randconfig-003-20250709    clang-20
i386        buildonly-randconfig-004-20250709    clang-20
i386        buildonly-randconfig-005-20250709    gcc-12
i386        buildonly-randconfig-006-20250709    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-21
loongarch             randconfig-001-20250709    gcc-15.1.0
loongarch             randconfig-001-20250710    gcc-14.3.0
loongarch             randconfig-002-20250709    gcc-12.4.0
loongarch             randconfig-002-20250710    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250709    gcc-14.2.0
nios2                 randconfig-001-20250710    gcc-9.3.0
nios2                 randconfig-002-20250709    gcc-14.2.0
nios2                 randconfig-002-20250710    gcc-12.4.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250709    gcc-15.1.0
parisc                randconfig-001-20250710    gcc-8.5.0
parisc                randconfig-002-20250709    gcc-14.3.0
parisc                randconfig-002-20250710    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-21
powerpc               randconfig-001-20250709    gcc-8.5.0
powerpc               randconfig-001-20250710    gcc-12.4.0
powerpc               randconfig-002-20250709    clang-21
powerpc               randconfig-002-20250710    gcc-9.3.0
powerpc               randconfig-003-20250709    clang-21
powerpc               randconfig-003-20250710    gcc-8.5.0
powerpc64             randconfig-001-20250709    gcc-10.5.0
powerpc64             randconfig-001-20250710    gcc-11.5.0
powerpc64             randconfig-002-20250709    gcc-10.5.0
powerpc64             randconfig-002-20250710    clang-17
powerpc64             randconfig-003-20250709    clang-21
powerpc64             randconfig-003-20250710    gcc-14.3.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                 randconfig-001-20250709    gcc-10.5.0
riscv                 randconfig-001-20250710    gcc-15.1.0
riscv                 randconfig-002-20250709    clang-21
riscv                 randconfig-002-20250710    gcc-10.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250709    clang-17
s390                  randconfig-001-20250710    gcc-14.3.0
s390                  randconfig-002-20250709    clang-21
s390                  randconfig-002-20250710    clang-17
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                    randconfig-001-20250709    gcc-10.5.0
sh                    randconfig-001-20250710    gcc-15.1.0
sh                    randconfig-002-20250709    gcc-14.3.0
sh                    randconfig-002-20250710    gcc-13.4.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250709    gcc-15.1.0
sparc                 randconfig-001-20250710    gcc-13.4.0
sparc                 randconfig-002-20250709    gcc-10.3.0
sparc                 randconfig-002-20250710    gcc-14.3.0
sparc64               randconfig-001-20250709    clang-21
sparc64               randconfig-001-20250710    gcc-8.5.0
sparc64               randconfig-002-20250709    clang-21
sparc64               randconfig-002-20250710    gcc-15.1.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                    randconfig-001-20250709    clang-17
um                    randconfig-001-20250710    gcc-11
um                    randconfig-002-20250709    gcc-12
um                    randconfig-002-20250710    clang-16
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250709    gcc-12
x86_64      buildonly-randconfig-002-20250709    clang-20
x86_64      buildonly-randconfig-003-20250709    gcc-12
x86_64      buildonly-randconfig-004-20250709    gcc-12
x86_64      buildonly-randconfig-005-20250709    clang-20
x86_64      buildonly-randconfig-006-20250709    gcc-12
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250709    gcc-8.5.0
xtensa                randconfig-001-20250710    gcc-12.4.0
xtensa                randconfig-002-20250709    gcc-11.5.0
xtensa                randconfig-002-20250710    gcc-14.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

