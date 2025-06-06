Return-Path: <linux-wireless+bounces-23791-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 673F5ACFBF9
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Jun 2025 06:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB775189658B
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Jun 2025 04:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AAF0322B;
	Fri,  6 Jun 2025 04:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZhjEcRFU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0287FD
	for <linux-wireless@vger.kernel.org>; Fri,  6 Jun 2025 04:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749184273; cv=none; b=dAjMN4mS2nrrTOgiBYQPuxOiOGFe3HmIKB0jB/srs0KYN+XaQyrRK8c+hv7Nj/Q9S4o27s0Ug4PpZVV4HXdpGohPNqmpPR9KNf463L2NhH0ACJQXjimDrMXFa9DkRwQj/PiGQoGDol2+sf9kHyYRqC1jwxTJu9mTCEpp7mMPN24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749184273; c=relaxed/simple;
	bh=zbhc96J5CEAI0sSb8yaJ/zZpaoZZexGnOMGAYcS5jao=;
	h=Date:From:To:Cc:Subject:Message-ID; b=M7Ao2SJiNTWeP/Tj+LEaQqZqBxqaYFTWL1f4e4IIB3MO/ZNUJQU9zVA7Voje54SLVatGhuP25zDmbtylDqREEQ69lCTtE+yrc0U03CS2hW0d8ppWzfr1dcgiPKphtDnEKsOYSBNo4/LgLfbTaAe2IdViJXYnP+ZdSAAMoi0jv1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZhjEcRFU; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749184271; x=1780720271;
  h=date:from:to:cc:subject:message-id;
  bh=zbhc96J5CEAI0sSb8yaJ/zZpaoZZexGnOMGAYcS5jao=;
  b=ZhjEcRFU6pzsDfJeXkyKax4DqYE0Q9GysNoBwGlxSomp5S14pTf25sco
   b2jEUO85utkd1RT9k5KnYyskh3Wrnz7v5u0XtEmKLdAL6bAcSwJRRwerh
   iQMCf8kS9EVAGjnVGKPtv9O/vtoMib8/01b8gyxDHqmZOZaByIfpXwAOp
   NFO+mXl4bZo4KMUodALmZimRwluzsdpJwDXo8zS2YbqfL+d7QozarPD+V
   oOfcoxBhNEHICQE5zLddTLWYOX4zteAGU/Phv1RYCJNKPD31URfo3xr2x
   /sCcuzreimJ+PlmH3dDFTCWVRnipoRve10vfOHEmOB9DA3ZFmcZU3StM3
   g==;
X-CSE-ConnectionGUID: SMAgdMaOTTmqGrFfLdvydg==
X-CSE-MsgGUID: vUBg3iInSx+XCwNMBH5rVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11455"; a="51425216"
X-IronPort-AV: E=Sophos;i="6.16,214,1744095600"; 
   d="scan'208";a="51425216"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2025 21:31:10 -0700
X-CSE-ConnectionGUID: SObkiW+dR9WxfwL1NcJ4ig==
X-CSE-MsgGUID: 6OqtjYy9RTqoxBgd4VmxBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,214,1744095600"; 
   d="scan'208";a="145733743"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 05 Jun 2025 21:31:08 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uNOjR-0004k1-1R;
	Fri, 06 Jun 2025 04:31:05 +0000
Date: Fri, 06 Jun 2025 12:30:18 +0800
From: kernel test robot <lkp@intel.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: [wireless:for-next] BUILD SUCCESS
 4d401c5534ab132a44f9afbf18a6d861b1320c98
Message-ID: <202506061207.JpkgZVFX-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git for-next
branch HEAD: 4d401c5534ab132a44f9afbf18a6d861b1320c98  Merge tag 'wireless-2025-06-05' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless

elapsed time: 896m

configs tested: 274
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                         haps_hs_defconfig    gcc-12
arc                   randconfig-001-20250606    gcc-15.1.0
arc                   randconfig-001-20250606    gcc-8.5.0
arc                   randconfig-002-20250606    gcc-10.5.0
arc                   randconfig-002-20250606    gcc-15.1.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-21
arm                               allnoconfig    gcc-15.1.0
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    gcc-15.1.0
arm                   randconfig-001-20250606    clang-21
arm                   randconfig-001-20250606    gcc-15.1.0
arm                   randconfig-002-20250606    gcc-11.5.0
arm                   randconfig-002-20250606    gcc-15.1.0
arm                   randconfig-003-20250606    clang-21
arm                   randconfig-003-20250606    gcc-15.1.0
arm                   randconfig-004-20250606    gcc-11.5.0
arm                   randconfig-004-20250606    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                            allyesconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20250606    clang-21
arm64                 randconfig-001-20250606    gcc-15.1.0
arm64                 randconfig-002-20250606    gcc-15.1.0
arm64                 randconfig-003-20250606    clang-21
arm64                 randconfig-003-20250606    gcc-15.1.0
arm64                 randconfig-004-20250606    clang-21
arm64                 randconfig-004-20250606    gcc-15.1.0
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                             allyesconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20250605    gcc-10.5.0
csky                  randconfig-001-20250606    gcc-13.3.0
csky                  randconfig-002-20250605    gcc-15.1.0
csky                  randconfig-002-20250606    gcc-13.3.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-21
hexagon                           allnoconfig    gcc-15.1.0
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    gcc-15.1.0
hexagon               randconfig-001-20250605    clang-21
hexagon               randconfig-001-20250606    gcc-13.3.0
hexagon               randconfig-002-20250605    clang-20
hexagon               randconfig-002-20250606    gcc-13.3.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250605    gcc-12
i386        buildonly-randconfig-001-20250606    clang-20
i386        buildonly-randconfig-001-20250606    gcc-12
i386        buildonly-randconfig-002-20250605    clang-20
i386        buildonly-randconfig-002-20250606    gcc-12
i386        buildonly-randconfig-003-20250605    gcc-12
i386        buildonly-randconfig-003-20250606    gcc-12
i386        buildonly-randconfig-004-20250605    clang-20
i386        buildonly-randconfig-004-20250606    gcc-12
i386        buildonly-randconfig-005-20250605    clang-20
i386        buildonly-randconfig-005-20250606    gcc-12
i386        buildonly-randconfig-006-20250605    gcc-11
i386        buildonly-randconfig-006-20250606    gcc-11
i386        buildonly-randconfig-006-20250606    gcc-12
i386                                defconfig    clang-20
i386                  randconfig-001-20250606    clang-20
i386                  randconfig-002-20250606    clang-20
i386                  randconfig-003-20250606    clang-20
i386                  randconfig-004-20250606    clang-20
i386                  randconfig-005-20250606    clang-20
i386                  randconfig-006-20250606    clang-20
i386                  randconfig-007-20250606    clang-20
i386                  randconfig-011-20250606    clang-20
i386                  randconfig-012-20250606    clang-20
i386                  randconfig-013-20250606    clang-20
i386                  randconfig-014-20250606    clang-20
i386                  randconfig-015-20250606    clang-20
i386                  randconfig-016-20250606    clang-20
i386                  randconfig-017-20250606    clang-20
loongarch                        allmodconfig    gcc-15.1.0
loongarch                         allnoconfig    gcc-15.1.0
loongarch                        allyesconfig    gcc-15.1.0
loongarch                           defconfig    gcc-15.1.0
loongarch             randconfig-001-20250605    gcc-12.4.0
loongarch             randconfig-001-20250606    gcc-13.3.0
loongarch             randconfig-002-20250605    gcc-15.1.0
loongarch             randconfig-002-20250606    gcc-13.3.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
mips                     decstation_defconfig    gcc-12
mips                           ip22_defconfig    gcc-15.1.0
mips                           ip30_defconfig    gcc-15.1.0
mips                           mtx1_defconfig    gcc-12
mips                           rs90_defconfig    gcc-15.1.0
mips                         rt305x_defconfig    gcc-12
nios2                            allmodconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-15.1.0
nios2                            allyesconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250605    gcc-14.2.0
nios2                 randconfig-001-20250606    gcc-13.3.0
nios2                 randconfig-002-20250605    gcc-11.5.0
nios2                 randconfig-002-20250606    gcc-13.3.0
openrisc                         allmodconfig    gcc-15.1.0
openrisc                          allnoconfig    clang-21
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-21
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250605    gcc-9.3.0
parisc                randconfig-001-20250606    gcc-13.3.0
parisc                randconfig-002-20250605    gcc-11.5.0
parisc                randconfig-002-20250606    gcc-13.3.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-21
powerpc                          allyesconfig    clang-21
powerpc                          allyesconfig    gcc-15.1.0
powerpc                        icon_defconfig    gcc-12
powerpc                  mpc885_ads_defconfig    gcc-15.1.0
powerpc                         ps3_defconfig    gcc-12
powerpc               randconfig-001-20250605    clang-21
powerpc               randconfig-001-20250606    gcc-13.3.0
powerpc               randconfig-002-20250605    clang-21
powerpc               randconfig-002-20250606    gcc-13.3.0
powerpc               randconfig-003-20250605    clang-21
powerpc               randconfig-003-20250606    gcc-13.3.0
powerpc                     tqm8541_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20250605    clang-18
powerpc64             randconfig-001-20250606    gcc-13.3.0
powerpc64             randconfig-002-20250605    clang-21
powerpc64             randconfig-002-20250606    gcc-13.3.0
powerpc64             randconfig-003-20250605    clang-21
powerpc64             randconfig-003-20250606    gcc-13.3.0
riscv                            allmodconfig    clang-21
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-21
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250605    clang-21
riscv                 randconfig-001-20250606    gcc-11.5.0
riscv                 randconfig-001-20250606    gcc-12
riscv                 randconfig-002-20250605    clang-21
riscv                 randconfig-002-20250606    gcc-12
riscv                 randconfig-002-20250606    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250605    clang-21
s390                  randconfig-001-20250606    clang-21
s390                  randconfig-001-20250606    gcc-12
s390                  randconfig-002-20250605    clang-21
s390                  randconfig-002-20250606    clang-18
s390                  randconfig-002-20250606    gcc-12
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                          landisk_defconfig    gcc-15.1.0
sh                    randconfig-001-20250605    gcc-12.4.0
sh                    randconfig-001-20250606    gcc-12
sh                    randconfig-001-20250606    gcc-12.4.0
sh                    randconfig-002-20250605    gcc-12.4.0
sh                    randconfig-002-20250606    gcc-10.5.0
sh                    randconfig-002-20250606    gcc-12
sh                           se7751_defconfig    gcc-15.1.0
sh                  sh7785lcr_32bit_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                            allyesconfig    gcc-15.1.0
sparc                 randconfig-001-20250605    gcc-11.5.0
sparc                 randconfig-001-20250606    gcc-12
sparc                 randconfig-001-20250606    gcc-8.5.0
sparc                 randconfig-002-20250605    gcc-7.5.0
sparc                 randconfig-002-20250606    gcc-12
sparc                 randconfig-002-20250606    gcc-8.5.0
sparc64                          allmodconfig    gcc-15.1.0
sparc64                          allyesconfig    gcc-15.1.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250605    gcc-12.4.0
sparc64               randconfig-001-20250606    gcc-12
sparc64               randconfig-001-20250606    gcc-12.4.0
sparc64               randconfig-002-20250605    gcc-15.1.0
sparc64               randconfig-002-20250606    gcc-12
sparc64               randconfig-002-20250606    gcc-15.1.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250605    clang-21
um                    randconfig-001-20250606    gcc-12
um                    randconfig-002-20250605    clang-21
um                    randconfig-002-20250606    gcc-12
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250605    clang-20
x86_64      buildonly-randconfig-001-20250606    clang-20
x86_64      buildonly-randconfig-001-20250606    gcc-12
x86_64      buildonly-randconfig-002-20250605    gcc-12
x86_64      buildonly-randconfig-002-20250606    gcc-12
x86_64      buildonly-randconfig-003-20250605    clang-20
x86_64      buildonly-randconfig-003-20250606    gcc-12
x86_64      buildonly-randconfig-004-20250605    clang-20
x86_64      buildonly-randconfig-004-20250606    gcc-12
x86_64      buildonly-randconfig-005-20250605    gcc-12
x86_64      buildonly-randconfig-005-20250606    gcc-12
x86_64      buildonly-randconfig-006-20250605    clang-20
x86_64      buildonly-randconfig-006-20250606    gcc-12
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250606    gcc-11
x86_64                randconfig-002-20250606    gcc-11
x86_64                randconfig-003-20250606    gcc-11
x86_64                randconfig-004-20250606    gcc-11
x86_64                randconfig-005-20250606    gcc-11
x86_64                randconfig-006-20250606    gcc-11
x86_64                randconfig-007-20250606    gcc-11
x86_64                randconfig-008-20250606    gcc-11
x86_64                randconfig-071-20250606    gcc-12
x86_64                randconfig-072-20250606    gcc-12
x86_64                randconfig-073-20250606    gcc-12
x86_64                randconfig-074-20250606    gcc-12
x86_64                randconfig-075-20250606    gcc-12
x86_64                randconfig-076-20250606    gcc-12
x86_64                randconfig-077-20250606    gcc-12
x86_64                randconfig-078-20250606    gcc-12
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-18
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                           allyesconfig    gcc-15.1.0
xtensa                randconfig-001-20250605    gcc-7.5.0
xtensa                randconfig-001-20250606    gcc-12
xtensa                randconfig-001-20250606    gcc-9.3.0
xtensa                randconfig-002-20250605    gcc-12.4.0
xtensa                randconfig-002-20250606    gcc-12
xtensa                randconfig-002-20250606    gcc-12.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

