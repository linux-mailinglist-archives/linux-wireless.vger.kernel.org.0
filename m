Return-Path: <linux-wireless+bounces-26010-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CCBB1156F
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Jul 2025 02:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19268AC807C
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Jul 2025 00:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2402381C4;
	Fri, 25 Jul 2025 00:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G+kQFN0G"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D48BA3D
	for <linux-wireless@vger.kernel.org>; Fri, 25 Jul 2025 00:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753404930; cv=none; b=qpu2AVZlRoH8ZDqFo6C104xV6VKD9FGMQ4CMq0cvUhRMiXsfn+n2rP5h2STfANVx8560DZPVmuvtOBGvtn/gd4MV6eed5JWJi53EZPOCl1eXnPw76NJLPVxAz40Zj47ecbLreyHz246vTpwcX6jAgXwzgflgvVikYIgp5mmnPG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753404930; c=relaxed/simple;
	bh=T0tjDyY6v8MUPqBDCp1Bo8rQ6fB5OGUdUBz95iLWW3g=;
	h=Date:From:To:Cc:Subject:Message-ID; b=GPK0QVuoCYdXhE/SPFzONyLFl0h10uI64gYAGzotAb1NEhnM5kg6Eidr1UMX7VTp+Jvw/jW1Z6h9voD6XSvoPfMvbLStIXY7nTcZh7dddTXLgDVgBJdZGS2hFk22FM3cWJDuJUh+tcPwKV6z1QEQCLaKUagcC+evDppc2rOthng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G+kQFN0G; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753404929; x=1784940929;
  h=date:from:to:cc:subject:message-id;
  bh=T0tjDyY6v8MUPqBDCp1Bo8rQ6fB5OGUdUBz95iLWW3g=;
  b=G+kQFN0GSyxN0gbLCIdHVMZivN6TbO+SqYYG+OcRtkBC8rHMilEckPvC
   tdZxWiY5YtooY97y92xDXZy7tBF67mtFH6jGrdoqIOd7JOT2OW2ED/B0M
   NHV4G+Hg4GjI/Q5cztfYiriOdORskDoXcfZjc/9uqtUCfNqJlkaTpFOzM
   C5DVfWWdNIXMgZO1qC67l6570cNwvA0xD0fT4m3tGA0ygV4OOGKcl1scD
   H1PewQIwHcsW9lisZ1ze0yfe9f/zujotJ7qKLMCDomkgoeS9xbrAI8HuB
   O3NiNHexMPcbjlifzHd+YeryochwPxWzSz7gSVVNZFMI56wc7/mCDQdVH
   Q==;
X-CSE-ConnectionGUID: xwAssb2bQ4a3Vx+XPUoEcw==
X-CSE-MsgGUID: zwTXrUP7R5GJmuvyWtTolA==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="67176909"
X-IronPort-AV: E=Sophos;i="6.16,338,1744095600"; 
   d="scan'208";a="67176909"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 17:55:28 -0700
X-CSE-ConnectionGUID: Xo8GqZjCT1Sz54GbJT5AfQ==
X-CSE-MsgGUID: +ncdCe7vTkS94dhU++wMPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,338,1744095600"; 
   d="scan'208";a="165980204"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 24 Jul 2025 17:55:27 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uf6ia-000Kxv-2R;
	Fri, 25 Jul 2025 00:55:24 +0000
Date: Fri, 25 Jul 2025 08:54:29 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 55c172c13718b93300d3808b65ec326b5287c766
Message-ID: <202507250817.hRW8CFMp-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 55c172c13718b93300d3808b65ec326b5287c766  ssb: use new GPIO line value setter callbacks for the second GPIO chip

elapsed time: 984m

configs tested: 109
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250724    gcc-13.4.0
arc                   randconfig-002-20250724    gcc-15.1.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                   randconfig-001-20250724    gcc-10.5.0
arm                   randconfig-002-20250724    clang-22
arm                   randconfig-003-20250724    gcc-8.5.0
arm                   randconfig-004-20250724    gcc-12.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250724    gcc-8.5.0
arm64                 randconfig-002-20250724    clang-22
arm64                 randconfig-003-20250724    gcc-13.4.0
arm64                 randconfig-004-20250724    clang-22
csky                  randconfig-001-20250724    gcc-13.4.0
csky                  randconfig-002-20250724    gcc-10.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250724    clang-22
hexagon               randconfig-002-20250724    clang-22
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250724    gcc-12
i386        buildonly-randconfig-002-20250724    clang-20
i386        buildonly-randconfig-003-20250724    clang-20
i386        buildonly-randconfig-004-20250724    clang-20
i386        buildonly-randconfig-005-20250724    clang-20
i386        buildonly-randconfig-006-20250724    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch             randconfig-001-20250724    clang-22
loongarch             randconfig-002-20250724    gcc-13.4.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250724    gcc-11.5.0
nios2                 randconfig-002-20250724    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250724    gcc-14.3.0
parisc                randconfig-002-20250724    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc               randconfig-001-20250724    clang-22
powerpc               randconfig-002-20250724    gcc-8.5.0
powerpc               randconfig-003-20250724    clang-22
powerpc64             randconfig-001-20250724    clang-22
powerpc64             randconfig-002-20250724    gcc-13.4.0
powerpc64             randconfig-003-20250724    gcc-15.1.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                 randconfig-001-20250724    gcc-13.4.0
riscv                 randconfig-002-20250724    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250724    clang-22
s390                  randconfig-002-20250724    gcc-10.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                    randconfig-001-20250724    gcc-13.4.0
sh                    randconfig-002-20250724    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250724    gcc-15.1.0
sparc                 randconfig-002-20250724    gcc-8.5.0
sparc64               randconfig-001-20250724    gcc-8.5.0
sparc64               randconfig-002-20250724    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-12
um                    randconfig-001-20250724    clang-22
um                    randconfig-002-20250724    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250724    gcc-12
x86_64      buildonly-randconfig-002-20250724    clang-20
x86_64      buildonly-randconfig-003-20250724    gcc-12
x86_64      buildonly-randconfig-004-20250724    gcc-12
x86_64      buildonly-randconfig-005-20250724    clang-20
x86_64      buildonly-randconfig-006-20250724    gcc-12
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250724    gcc-12.5.0
xtensa                randconfig-002-20250724    gcc-12.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

