Return-Path: <linux-wireless+bounces-18148-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D84FA2203E
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2025 16:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46E663A8A77
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2025 15:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECD21D934D;
	Wed, 29 Jan 2025 15:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BIBXPbqB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D641DDA17
	for <linux-wireless@vger.kernel.org>; Wed, 29 Jan 2025 15:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738164435; cv=none; b=dmQ9TVj8UlYvk0YDEHXDwjXlMdFL7BZt1JxBuQ1du/sjkWKOEv6s6k8XOIdAc6YSsksIXIxlCyJepyLiB9GlsxALd9ZxR6N9EJ4TVDfn+pF6++LloVk1S0vU/moSo7EJlOgVTOXKYMKj8cTRyxv6nEcfbCG5mpPJWd2GWEyTUac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738164435; c=relaxed/simple;
	bh=FF5nUNYpqkYIqHPWu2tOfjDjTVXXPvZYP0vbjckmSWw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=JzQus7E3mp39wrMBQluR7LjNlzbjz/9VRjBFLFRpmMhA3PL+nPE3aHZ+xeaFLic+6KKfyl1MoCl6ZTUCiHRjMiWWXC+2O3R0z2krXptupzjzGXo3EhgE3fcALdh1Q4NA2WQ92Ry1XC7KOfZfd1IOcPPy6cTMT66jTEOidghD+AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BIBXPbqB; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738164434; x=1769700434;
  h=date:from:to:cc:subject:message-id;
  bh=FF5nUNYpqkYIqHPWu2tOfjDjTVXXPvZYP0vbjckmSWw=;
  b=BIBXPbqBj1eyWm2uZNbvtcDhcBrdxwZfssQm/oCs2C8mmn2mfaxA/aM0
   UUYCjRTsL9wQZK3euNE4vThLXRbragv+uklmrGgSAzFxQQjbe/DNlIiDe
   3b0bFYQy0mT5Z5j6LvfxamfUkLoy1AVO384/TKG6E9U1//AItH5dA0oM0
   KDnkh7vt7g40OnRF1Mu+pUnZAFhxb2HbNk5bDEgwB/hX3NgegkUT5f0wS
   ayvoi6hRPD7IxfmTVPwcYYUS0b/1c/dYSYrST3mPxbbHiD+9y3SiX6hVP
   r/tbhbWjeCgU3dhSUGQLi/pu3l9pC1VMfuYPbDnBdxsHJpM7I1EYJgm3l
   g==;
X-CSE-ConnectionGUID: gk0t7SOeRVuGFd8r9xBSFA==
X-CSE-MsgGUID: FDP41YliSAuXmK9a/1NNsA==
X-IronPort-AV: E=McAfee;i="6700,10204,11330"; a="26285568"
X-IronPort-AV: E=Sophos;i="6.13,243,1732608000"; 
   d="scan'208";a="26285568"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2025 07:27:13 -0800
X-CSE-ConnectionGUID: RWAkyX2jTlqmwWmrpnXRIQ==
X-CSE-MsgGUID: 1P6khOI4SkS0drJxkC+VAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,243,1732608000"; 
   d="scan'208";a="109173611"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 29 Jan 2025 07:27:11 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1td9y9-000j4C-1d;
	Wed, 29 Jan 2025 15:27:09 +0000
Date: Wed, 29 Jan 2025 23:26:54 +0800
From: kernel test robot <lkp@intel.com>
To: Kalle Valo <kvalo@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 22f3551b60be7d126db9233998d262edfc577d0b
Message-ID: <202501292348.YjejBmNj-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 22f3551b60be7d126db9233998d262edfc577d0b  wifi: ipw2x00: Remove unused libipw_rx_any()

elapsed time: 1258m

configs tested: 211
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-20
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    clang-18
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-18
arc                              allyesconfig    gcc-13.2.0
arc                     nsimosci_hs_defconfig    gcc-13.2.0
arc                   randconfig-001-20250129    gcc-13.2.0
arc                   randconfig-001-20250129    gcc-14.2.0
arc                   randconfig-002-20250129    gcc-13.2.0
arc                   randconfig-002-20250129    gcc-14.2.0
arc                    vdk_hs38_smp_defconfig    gcc-13.2.0
arm                              allmodconfig    clang-18
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-18
arm                              allyesconfig    gcc-14.2.0
arm                         orion5x_defconfig    clang-20
arm                          pxa168_defconfig    clang-16
arm                   randconfig-001-20250129    gcc-14.2.0
arm                   randconfig-002-20250129    clang-20
arm                   randconfig-002-20250129    gcc-14.2.0
arm                   randconfig-003-20250129    gcc-14.2.0
arm                   randconfig-004-20250129    gcc-14.2.0
arm64                            alldefconfig    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250129    gcc-14.2.0
arm64                 randconfig-002-20250129    gcc-14.2.0
arm64                 randconfig-003-20250129    gcc-14.2.0
arm64                 randconfig-004-20250129    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250129    gcc-14.2.0
csky                  randconfig-002-20250129    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-18
hexagon                          allyesconfig    clang-20
hexagon               randconfig-001-20250129    clang-19
hexagon               randconfig-001-20250129    gcc-14.2.0
hexagon               randconfig-002-20250129    clang-20
hexagon               randconfig-002-20250129    gcc-14.2.0
i386                             allmodconfig    clang-19
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-19
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-19
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250129    clang-19
i386        buildonly-randconfig-001-20250129    gcc-12
i386        buildonly-randconfig-002-20250129    gcc-12
i386        buildonly-randconfig-003-20250129    clang-19
i386        buildonly-randconfig-003-20250129    gcc-12
i386        buildonly-randconfig-004-20250129    clang-19
i386        buildonly-randconfig-004-20250129    gcc-12
i386        buildonly-randconfig-005-20250129    clang-19
i386        buildonly-randconfig-005-20250129    gcc-12
i386        buildonly-randconfig-006-20250129    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20250129    gcc-12
i386                  randconfig-002-20250129    gcc-12
i386                  randconfig-003-20250129    gcc-12
i386                  randconfig-004-20250129    gcc-12
i386                  randconfig-005-20250129    gcc-12
i386                  randconfig-006-20250129    gcc-12
i386                  randconfig-007-20250129    gcc-12
i386                  randconfig-011-20250129    gcc-12
i386                  randconfig-012-20250129    gcc-12
i386                  randconfig-013-20250129    gcc-12
i386                  randconfig-014-20250129    gcc-12
i386                  randconfig-015-20250129    gcc-12
i386                  randconfig-016-20250129    gcc-12
i386                  randconfig-017-20250129    gcc-12
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250129    gcc-14.2.0
loongarch             randconfig-002-20250129    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                            q40_defconfig    gcc-13.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                        bcm47xx_defconfig    clang-17
mips                  cavium_octeon_defconfig    gcc-14.2.0
mips                           ip28_defconfig    gcc-14.2.0
mips                           ip30_defconfig    gcc-13.2.0
mips                          rb532_defconfig    clang-17
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250129    gcc-14.2.0
nios2                 randconfig-002-20250129    gcc-14.2.0
openrisc                          allnoconfig    clang-20
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-20
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250129    gcc-14.2.0
parisc                randconfig-002-20250129    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                      arches_defconfig    clang-17
powerpc                   currituck_defconfig    clang-17
powerpc                      pcm030_defconfig    gcc-13.2.0
powerpc               randconfig-001-20250129    clang-20
powerpc               randconfig-001-20250129    gcc-14.2.0
powerpc               randconfig-002-20250129    clang-20
powerpc               randconfig-002-20250129    gcc-14.2.0
powerpc               randconfig-003-20250129    gcc-14.2.0
powerpc                     sequoia_defconfig    clang-17
powerpc                      tqm8xx_defconfig    clang-17
powerpc64             randconfig-001-20250129    clang-16
powerpc64             randconfig-001-20250129    gcc-14.2.0
powerpc64             randconfig-002-20250129    clang-18
powerpc64             randconfig-002-20250129    gcc-14.2.0
powerpc64             randconfig-003-20250129    clang-20
powerpc64             randconfig-003-20250129    gcc-14.2.0
riscv                            alldefconfig    gcc-13.2.0
riscv                            allmodconfig    clang-20
riscv                             allnoconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250129    gcc-14.2.0
riscv                 randconfig-002-20250129    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250129    clang-20
s390                  randconfig-002-20250129    clang-17
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                          kfr2r09_defconfig    clang-17
sh                          r7785rp_defconfig    clang-17
sh                    randconfig-001-20250129    gcc-14.2.0
sh                    randconfig-002-20250129    gcc-14.2.0
sh                           se7751_defconfig    clang-17
sh                           sh2007_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250129    gcc-14.2.0
sparc                 randconfig-002-20250129    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250129    gcc-14.2.0
sparc64               randconfig-002-20250129    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-18
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250129    gcc-12
um                    randconfig-002-20250129    gcc-12
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250129    clang-19
x86_64      buildonly-randconfig-002-20250129    clang-19
x86_64      buildonly-randconfig-002-20250129    gcc-12
x86_64      buildonly-randconfig-003-20250129    clang-19
x86_64      buildonly-randconfig-003-20250129    gcc-12
x86_64      buildonly-randconfig-004-20250129    clang-19
x86_64      buildonly-randconfig-004-20250129    gcc-12
x86_64      buildonly-randconfig-005-20250129    clang-19
x86_64      buildonly-randconfig-005-20250129    gcc-12
x86_64      buildonly-randconfig-006-20250129    clang-19
x86_64                              defconfig    clang-19
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20250129    clang-19
x86_64                randconfig-002-20250129    clang-19
x86_64                randconfig-003-20250129    clang-19
x86_64                randconfig-004-20250129    clang-19
x86_64                randconfig-005-20250129    clang-19
x86_64                randconfig-006-20250129    clang-19
x86_64                randconfig-007-20250129    clang-19
x86_64                randconfig-008-20250129    clang-19
x86_64                randconfig-071-20250129    clang-19
x86_64                randconfig-072-20250129    clang-19
x86_64                randconfig-073-20250129    clang-19
x86_64                randconfig-074-20250129    clang-19
x86_64                randconfig-075-20250129    clang-19
x86_64                randconfig-076-20250129    clang-19
x86_64                randconfig-077-20250129    clang-19
x86_64                randconfig-078-20250129    clang-19
x86_64                               rhel-9.4    clang-19
x86_64                           rhel-9.4-bpf    clang-19
x86_64                         rhel-9.4-kunit    clang-19
x86_64                           rhel-9.4-ltp    clang-19
x86_64                          rhel-9.4-rust    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                  cadence_csp_defconfig    gcc-13.2.0
xtensa                       common_defconfig    gcc-13.2.0
xtensa                randconfig-001-20250129    gcc-14.2.0
xtensa                randconfig-002-20250129    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

