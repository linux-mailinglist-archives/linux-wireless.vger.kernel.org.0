Return-Path: <linux-wireless+bounces-23105-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A5CEBABA665
	for <lists+linux-wireless@lfdr.de>; Sat, 17 May 2025 01:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23C067BC948
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 23:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C4ACA6B;
	Fri, 16 May 2025 23:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d0r4f3jK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B0A236426
	for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 23:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747437100; cv=none; b=Yr+2sIi7R3COHbW5nXb/sICcUbLu4Kjx5iaHkHILUoAb4Uh/nap7sxF6bvF1k/93g3D0r6Mo3Fy2UIwTZLo6dOSni4SAq+xKUixulfZOHNkV2eUyHLHZa6wvJIwQxvQd1Tja2AwWdxU+v768eoJUslKLUOUtKL7ngY2dispXBkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747437100; c=relaxed/simple;
	bh=b5zTVswfaJWjTAlxw2VHo/CRkmG0GXkOX3Xomqtl0T0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=POemW0kV0/fDeL9pdXPxOAj9S66VTOXIFAEqLK/pGxBzXu3GpKfI//yAgrMvtHHhN/Jv33shEXGTTR94Yrdv9PWK49PqV1vY0r/2DefjBaLxXUp1E8dhqFZu2LwIrmUe83KrgNAX9TS/vqW4/4BTzgLlU9xwYqG8aEvsKFCaP0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d0r4f3jK; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747437099; x=1778973099;
  h=date:from:to:cc:subject:message-id;
  bh=b5zTVswfaJWjTAlxw2VHo/CRkmG0GXkOX3Xomqtl0T0=;
  b=d0r4f3jKMdLy1gMEvz992IABQz1QOd8Z6lGnguL4AMewmCAB2tW4UN1N
   H5+mj5YBe7J6CBlcI/nFlOi+UVucrkv3BlAz+G3P0uZXRFhYNgf/xSnOS
   C6BubJ/mm0hjQ/L2FRJiRqIXyVRtWwwEg2j9B5dv0SC7RBkYhocHjlhYC
   SaLj8Wg5/iUc3jQsCsFMMJSnSGi6nHuAa9RuNqbSWTn7iXluT1QcoUONf
   0VE6keT/BbRrSk3KmTN4NlIL6R7nVdkBGsRmOSLhDKDPDALEzu99IjRtd
   VwJ+GbIQH6PuNzs3aY4pXf/4JsLfYRVnWao9vnnwq67/upYGPAKPsVsJ7
   g==;
X-CSE-ConnectionGUID: sxWTtZOoQWqCHDHCTESFCA==
X-CSE-MsgGUID: V7PFIQelReeCVz4PeS9jNA==
X-IronPort-AV: E=McAfee;i="6700,10204,11435"; a="59651799"
X-IronPort-AV: E=Sophos;i="6.15,295,1739865600"; 
   d="scan'208";a="59651799"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 16:11:38 -0700
X-CSE-ConnectionGUID: H1WXVYBLQCOTxYIsU7YEEg==
X-CSE-MsgGUID: XZPyJyefSvGxWSvGz3UZIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,295,1739865600"; 
   d="scan'208";a="139314437"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 16 May 2025 16:11:36 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uG4DG-000JmB-0V;
	Fri, 16 May 2025 23:11:34 +0000
Date: Sat, 17 May 2025 07:10:55 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 68b44b05f4c880c42109a91d2e0e7faa94f40529
Message-ID: <202505170744.3SbR3yYC-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 68b44b05f4c880c42109a91d2e0e7faa94f40529  wifi: mac80211: handle non-MLO mode as well in ieee80211_num_beaconing_links()

elapsed time: 851m

configs tested: 266
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-19
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-19
arc                                 defconfig    gcc-14.2.0
arc                     haps_hs_smp_defconfig    clang-21
arc                 nsimosci_hs_smp_defconfig    clang-21
arc                   randconfig-001-20250516    gcc-13.3.0
arc                   randconfig-001-20250517    gcc-10.5.0
arc                   randconfig-001-20250517    gcc-8.5.0
arc                   randconfig-002-20250516    gcc-13.3.0
arc                   randconfig-002-20250517    gcc-14.2.0
arc                   randconfig-002-20250517    gcc-8.5.0
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-21
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-19
arm                         assabet_defconfig    clang-21
arm                                 defconfig    gcc-14.2.0
arm                          pxa910_defconfig    clang-21
arm                            qcom_defconfig    clang-21
arm                   randconfig-001-20250516    gcc-7.5.0
arm                   randconfig-001-20250517    clang-21
arm                   randconfig-001-20250517    gcc-8.5.0
arm                   randconfig-002-20250516    clang-21
arm                   randconfig-002-20250517    gcc-8.5.0
arm                   randconfig-003-20250516    clang-21
arm                   randconfig-003-20250517    gcc-8.5.0
arm                   randconfig-004-20250516    clang-21
arm                   randconfig-004-20250517    clang-21
arm                   randconfig-004-20250517    gcc-8.5.0
arm                        realview_defconfig    clang-21
arm                         wpcm450_defconfig    clang-21
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                            allyesconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250516    gcc-9.5.0
arm64                 randconfig-001-20250517    clang-17
arm64                 randconfig-001-20250517    gcc-8.5.0
arm64                 randconfig-002-20250516    gcc-9.5.0
arm64                 randconfig-002-20250517    clang-16
arm64                 randconfig-002-20250517    gcc-8.5.0
arm64                 randconfig-003-20250516    gcc-5.5.0
arm64                 randconfig-003-20250517    gcc-6.5.0
arm64                 randconfig-003-20250517    gcc-8.5.0
arm64                 randconfig-004-20250516    gcc-9.5.0
arm64                 randconfig-004-20250517    gcc-8.5.0
csky                             allmodconfig    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                             allyesconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250516    gcc-14.2.0
csky                  randconfig-001-20250517    clang-21
csky                  randconfig-002-20250516    gcc-14.2.0
csky                  randconfig-002-20250517    clang-21
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-21
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20250516    clang-19
hexagon               randconfig-001-20250517    clang-21
hexagon               randconfig-002-20250516    clang-21
hexagon               randconfig-002-20250517    clang-21
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250516    clang-20
i386        buildonly-randconfig-001-20250517    clang-20
i386        buildonly-randconfig-002-20250516    gcc-12
i386        buildonly-randconfig-002-20250517    clang-20
i386        buildonly-randconfig-003-20250516    clang-20
i386        buildonly-randconfig-003-20250517    clang-20
i386        buildonly-randconfig-004-20250516    clang-20
i386        buildonly-randconfig-004-20250517    clang-20
i386        buildonly-randconfig-005-20250516    clang-20
i386        buildonly-randconfig-005-20250517    clang-20
i386        buildonly-randconfig-006-20250516    gcc-12
i386        buildonly-randconfig-006-20250517    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250517    clang-20
i386                  randconfig-002-20250517    clang-20
i386                  randconfig-003-20250517    clang-20
i386                  randconfig-004-20250517    clang-20
i386                  randconfig-005-20250517    clang-20
i386                  randconfig-006-20250517    clang-20
i386                  randconfig-007-20250517    clang-20
i386                  randconfig-011-20250517    gcc-12
i386                  randconfig-012-20250517    gcc-12
i386                  randconfig-013-20250517    gcc-12
i386                  randconfig-014-20250517    gcc-12
i386                  randconfig-015-20250517    gcc-12
i386                  randconfig-016-20250517    gcc-12
i386                  randconfig-017-20250517    gcc-12
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                        allyesconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250516    gcc-14.2.0
loongarch             randconfig-001-20250517    clang-21
loongarch             randconfig-002-20250516    gcc-14.2.0
loongarch             randconfig-002-20250517    clang-21
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                          atari_defconfig    clang-21
m68k                                defconfig    gcc-14.2.0
m68k                       m5475evb_defconfig    clang-21
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
microblaze                      mmu_defconfig    clang-21
mips                             allmodconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                             allyesconfig    gcc-14.2.0
mips                           mtx1_defconfig    clang-21
nios2                            allmodconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                            allyesconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250516    gcc-13.3.0
nios2                 randconfig-001-20250517    clang-21
nios2                 randconfig-002-20250516    gcc-13.3.0
nios2                 randconfig-002-20250517    clang-21
openrisc                         allmodconfig    gcc-14.2.0
openrisc                          allnoconfig    clang-21
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-21
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250516    gcc-10.5.0
parisc                randconfig-001-20250517    clang-21
parisc                randconfig-002-20250516    gcc-12.4.0
parisc                randconfig-002-20250517    clang-21
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-21
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    gcc-14.2.0
powerpc                          g5_defconfig    clang-21
powerpc                      pmac32_defconfig    clang-21
powerpc               randconfig-001-20250516    gcc-5.5.0
powerpc               randconfig-001-20250517    clang-21
powerpc               randconfig-002-20250516    gcc-5.5.0
powerpc               randconfig-002-20250517    clang-21
powerpc               randconfig-003-20250516    clang-17
powerpc               randconfig-003-20250517    clang-21
powerpc                     tqm8548_defconfig    clang-21
powerpc64             randconfig-001-20250516    clang-21
powerpc64             randconfig-001-20250517    clang-21
powerpc64             randconfig-002-20250516    clang-21
powerpc64             randconfig-002-20250517    clang-21
powerpc64             randconfig-003-20250516    clang-21
powerpc64             randconfig-003-20250517    clang-21
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250516    gcc-7.5.0
riscv                 randconfig-001-20250517    gcc-9.3.0
riscv                 randconfig-002-20250516    gcc-14.2.0
riscv                 randconfig-002-20250517    gcc-9.3.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250516    gcc-7.5.0
s390                  randconfig-001-20250517    gcc-9.3.0
s390                  randconfig-002-20250516    gcc-7.5.0
s390                  randconfig-002-20250517    gcc-9.3.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                         ecovec24_defconfig    clang-21
sh                    randconfig-001-20250516    gcc-7.5.0
sh                    randconfig-001-20250517    gcc-9.3.0
sh                    randconfig-002-20250516    gcc-9.3.0
sh                    randconfig-002-20250517    gcc-9.3.0
sh                   sh7770_generic_defconfig    clang-21
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                            allyesconfig    gcc-14.2.0
sparc                 randconfig-001-20250516    gcc-8.5.0
sparc                 randconfig-001-20250517    gcc-9.3.0
sparc                 randconfig-002-20250516    gcc-8.5.0
sparc                 randconfig-002-20250517    gcc-9.3.0
sparc64                          allmodconfig    gcc-14.2.0
sparc64                          allyesconfig    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250516    gcc-12.4.0
sparc64               randconfig-001-20250517    gcc-9.3.0
sparc64               randconfig-002-20250516    gcc-14.2.0
sparc64               randconfig-002-20250517    gcc-9.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250516    clang-21
um                    randconfig-001-20250517    gcc-9.3.0
um                    randconfig-002-20250516    gcc-12
um                    randconfig-002-20250517    gcc-9.3.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250516    clang-20
x86_64      buildonly-randconfig-001-20250517    clang-20
x86_64      buildonly-randconfig-002-20250516    gcc-12
x86_64      buildonly-randconfig-002-20250517    clang-20
x86_64      buildonly-randconfig-003-20250516    clang-20
x86_64      buildonly-randconfig-003-20250517    clang-20
x86_64      buildonly-randconfig-004-20250516    clang-20
x86_64      buildonly-randconfig-004-20250517    clang-20
x86_64      buildonly-randconfig-005-20250516    gcc-12
x86_64      buildonly-randconfig-005-20250517    clang-20
x86_64      buildonly-randconfig-006-20250516    gcc-12
x86_64      buildonly-randconfig-006-20250517    clang-20
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250517    gcc-11
x86_64                randconfig-002-20250517    gcc-11
x86_64                randconfig-003-20250517    gcc-11
x86_64                randconfig-004-20250517    gcc-11
x86_64                randconfig-005-20250517    gcc-11
x86_64                randconfig-006-20250517    gcc-11
x86_64                randconfig-007-20250517    gcc-11
x86_64                randconfig-008-20250517    gcc-11
x86_64                randconfig-071-20250517    gcc-12
x86_64                randconfig-072-20250517    gcc-12
x86_64                randconfig-073-20250517    gcc-12
x86_64                randconfig-074-20250517    gcc-12
x86_64                randconfig-075-20250517    gcc-12
x86_64                randconfig-076-20250517    gcc-12
x86_64                randconfig-077-20250517    gcc-12
x86_64                randconfig-078-20250517    gcc-12
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-18
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-14.2.0
xtensa                           allyesconfig    gcc-14.2.0
xtensa                randconfig-001-20250516    gcc-10.5.0
xtensa                randconfig-001-20250517    gcc-9.3.0
xtensa                randconfig-002-20250516    gcc-10.5.0
xtensa                randconfig-002-20250517    gcc-9.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

