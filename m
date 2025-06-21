Return-Path: <linux-wireless+bounces-24309-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 114E3AE2768
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Jun 2025 06:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 982D31759B9
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Jun 2025 04:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A92B7FD;
	Sat, 21 Jun 2025 04:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FfGkHvis"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D268F5B
	for <linux-wireless@vger.kernel.org>; Sat, 21 Jun 2025 04:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750480990; cv=none; b=tXVOXu9hQ6jlxuY0ng10dfRzzGwqZX65gcmrnsyStnfoaZRxttfspEmHNfz8dyEIJZBcOIs0NAOUOuQotzbaB2Yhgszv+yLnPEhVS8IWMtr86G+ThhiC/O0OISyO1khIsJ83HLBn7bDcaagnCsBBNi4+6ffiEv6fP8hsB2nBx0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750480990; c=relaxed/simple;
	bh=oMSCo6dfybQgfSBNuBDrJ+nRp9qk/ZgFisEOYbFI/Hw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=P1MPzCz0eqCdLkfSAp6460uHyNIF5lhKm1PrRbvT+Ex5dIewWV/q+NYsrkzAtAiJop8Lfn9EIje5GV9LcfHZzi5SToFgQR0VlpXjoWG4mKNkqmE/fkxwNyI4AFffCv7Mv+xkPO4vqCPnIhlRUnrgsHC7BfWq07Xu7ZZczgHQxq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FfGkHvis; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750480988; x=1782016988;
  h=date:from:to:cc:subject:message-id;
  bh=oMSCo6dfybQgfSBNuBDrJ+nRp9qk/ZgFisEOYbFI/Hw=;
  b=FfGkHvisbY6A9dZbNN0iOZMwhWHCokKnw6SdHluuxu/jhc+b0ewFlxTs
   36/xYdDKQwczdApBflOtjS+i/8F7RvYTNUcdTFMquDMQaoEXlU6eLoyHa
   /j4hB8pb+RyYu4NFIRkG+L/9QXu+PI/vTZfAvWFbMYkOv2AqigZsNoFaz
   SffFVjWGo2hsraCzbw8U+QOjT/d5fX7SNvm3AQ26xkDGZPqYeUg5/V1xV
   YHwxQeS0+1kdpWoQcH4Y0XsEVPNDmwiwML7/5ESZ/Z06NKNpFTNpJ8e52
   uLyYjgVv6hX01IdjngdAckgt8aM9MBtvj7hHceWwO0NoM0jREiS1gTsvR
   w==;
X-CSE-ConnectionGUID: KNKIIAYPSXuoDs7qi5gzTQ==
X-CSE-MsgGUID: QL2xTf14TcKfJ5gNt0MrXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="52890606"
X-IronPort-AV: E=Sophos;i="6.16,253,1744095600"; 
   d="scan'208";a="52890606"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2025 21:43:08 -0700
X-CSE-ConnectionGUID: buECdlFRQLayJan6vKV4gA==
X-CSE-MsgGUID: Jo98ohUuSVC0U0AQRkVZeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,253,1744095600"; 
   d="scan'208";a="151614908"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 20 Jun 2025 21:43:07 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uSq4G-000MMs-2i;
	Sat, 21 Jun 2025 04:43:04 +0000
Date: Sat, 21 Jun 2025 12:42:29 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 757259db79fc6054780e07bb284f768b01cf8fa9
Message-ID: <202506211219.TbGp7qan-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 757259db79fc6054780e07bb284f768b01cf8fa9  ssb: use new GPIO line value setter callbacks

elapsed time: 1094m

configs tested: 173
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250620    gcc-8.5.0
arc                   randconfig-002-20250620    gcc-11.5.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                          pxa168_defconfig    clang-19
arm                   randconfig-001-20250620    clang-21
arm                   randconfig-002-20250620    clang-21
arm                   randconfig-003-20250620    clang-21
arm                   randconfig-004-20250620    clang-21
arm                             rpc_defconfig    clang-18
arm                           tegra_defconfig    gcc-15.1.0
arm64                            alldefconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250620    gcc-9.5.0
arm64                 randconfig-002-20250620    gcc-8.5.0
arm64                 randconfig-003-20250620    gcc-11.5.0
arm64                 randconfig-004-20250620    clang-21
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250620    gcc-13.3.0
csky                  randconfig-002-20250620    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250620    clang-21
hexagon               randconfig-002-20250620    clang-21
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250620    clang-20
i386        buildonly-randconfig-002-20250620    clang-20
i386        buildonly-randconfig-003-20250620    clang-20
i386        buildonly-randconfig-004-20250620    clang-20
i386        buildonly-randconfig-005-20250620    clang-20
i386        buildonly-randconfig-006-20250620    gcc-12
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-15.1.0
loongarch                         allnoconfig    gcc-15.1.0
loongarch             randconfig-001-20250620    gcc-14.3.0
loongarch             randconfig-002-20250620    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                       m5249evb_defconfig    gcc-15.1.0
microblaze                       alldefconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                      maltaaprp_defconfig    clang-21
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250620    gcc-8.5.0
nios2                 randconfig-002-20250620    gcc-10.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                generic-64bit_defconfig    gcc-15.1.0
parisc                randconfig-001-20250620    gcc-10.5.0
parisc                randconfig-002-20250620    gcc-12.4.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-21
powerpc                          allyesconfig    gcc-15.1.0
powerpc                    amigaone_defconfig    gcc-15.1.0
powerpc                      chrp32_defconfig    clang-19
powerpc                        fsp2_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250620    clang-21
powerpc               randconfig-002-20250620    gcc-11.5.0
powerpc               randconfig-003-20250620    clang-21
powerpc64             randconfig-001-20250620    gcc-14.3.0
powerpc64             randconfig-002-20250620    clang-21
powerpc64             randconfig-003-20250620    clang-19
riscv                            allmodconfig    clang-21
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-15.1.0
riscv                 randconfig-001-20250620    gcc-14.3.0
riscv                 randconfig-001-20250621    clang-21
riscv                 randconfig-002-20250620    clang-21
riscv                 randconfig-002-20250621    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250620    gcc-9.3.0
s390                  randconfig-001-20250621    clang-21
s390                  randconfig-002-20250620    clang-21
s390                  randconfig-002-20250621    clang-21
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                          landisk_defconfig    gcc-15.1.0
sh                          polaris_defconfig    gcc-15.1.0
sh                    randconfig-001-20250620    gcc-15.1.0
sh                    randconfig-001-20250621    gcc-15.1.0
sh                    randconfig-002-20250620    gcc-15.1.0
sh                    randconfig-002-20250621    gcc-15.1.0
sh                          sdk7780_defconfig    gcc-15.1.0
sh                           se7705_defconfig    gcc-15.1.0
sh                           se7721_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20250620    gcc-8.5.0
sparc                 randconfig-001-20250621    gcc-15.1.0
sparc                 randconfig-002-20250620    gcc-10.3.0
sparc                 randconfig-002-20250621    gcc-15.1.0
sparc64               randconfig-001-20250620    gcc-13.3.0
sparc64               randconfig-001-20250621    gcc-8.5.0
sparc64               randconfig-002-20250620    gcc-8.5.0
sparc64               randconfig-002-20250621    gcc-13.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                    randconfig-001-20250620    clang-21
um                    randconfig-001-20250621    clang-21
um                    randconfig-002-20250620    clang-21
um                    randconfig-002-20250621    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250620    gcc-12
x86_64      buildonly-randconfig-001-20250621    gcc-12
x86_64      buildonly-randconfig-002-20250620    gcc-12
x86_64      buildonly-randconfig-002-20250621    gcc-12
x86_64      buildonly-randconfig-003-20250620    clang-20
x86_64      buildonly-randconfig-003-20250621    gcc-12
x86_64      buildonly-randconfig-004-20250620    gcc-12
x86_64      buildonly-randconfig-004-20250621    gcc-12
x86_64      buildonly-randconfig-005-20250620    gcc-12
x86_64      buildonly-randconfig-005-20250621    gcc-12
x86_64      buildonly-randconfig-006-20250620    clang-20
x86_64      buildonly-randconfig-006-20250621    gcc-12
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-071-20250621    gcc-12
x86_64                randconfig-072-20250621    gcc-12
x86_64                randconfig-073-20250621    gcc-12
x86_64                randconfig-074-20250621    gcc-12
x86_64                randconfig-075-20250621    gcc-12
x86_64                randconfig-076-20250621    gcc-12
x86_64                randconfig-077-20250621    gcc-12
x86_64                randconfig-078-20250621    gcc-12
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-18
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250620    gcc-8.5.0
xtensa                randconfig-001-20250621    gcc-12.4.0
xtensa                randconfig-002-20250620    gcc-13.3.0
xtensa                randconfig-002-20250621    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

