Return-Path: <linux-wireless+bounces-29380-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9103AC8E017
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Nov 2025 12:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5BD124E7680
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Nov 2025 11:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9028432C33D;
	Thu, 27 Nov 2025 11:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DdkGhBVo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6066032D0D1
	for <linux-wireless@vger.kernel.org>; Thu, 27 Nov 2025 11:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764242375; cv=none; b=lvHMl/un9O52Udo1JwvV0oSRZx+qKAWrTT2yIsZr6miRD3NxaDp4nQdAj7MWuMIvSZnZ2H4ZL6PgwzP1ZTi2m+1OYk8ViDDbfJfyWPDMVgK2z1/UpF02mlRrXVpn07TDEENg3lEVrWIxDcyZ+1addyHF96B2jCirC2JRkCxyv8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764242375; c=relaxed/simple;
	bh=mdibD/rC8JyGCEoA/vhgZd/IHTACIW6qYJ9IdXq6sxg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=HqtkrXToE5UwygdVkmoeohOzcdFrPiLvJyNDL2ILhZ1zmM6h5L1vDzcKTB6UI5PQAkt4BQ7SCBXUw0CqqGsKm1fYnAiIAY/G/hrmnQCCoBj5YBOjuXssjKSXYa8iFiA9RDaM72le9Nk0Cht7EDkVRkXQ//ozDFLdRGaXfT8OzKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DdkGhBVo; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764242373; x=1795778373;
  h=date:from:to:cc:subject:message-id;
  bh=mdibD/rC8JyGCEoA/vhgZd/IHTACIW6qYJ9IdXq6sxg=;
  b=DdkGhBVo70mdFSKLzdXL4NkYEJK8ieN7VW/OdPMC2hIbQk2EY8dp4COu
   uUDR7mjGhvWrx/PvxjpE8BXuJzp6xyOsl2cSXxYAWrGR+dvHp5EduhA7d
   Fj9fNjXo+tauOgMTKECQv5m+tt/sv9wVz6utSWtyFFVh2rlW8oZK8aKji
   2+xOA1DvNkC51keWMLsKmCFXOsnwoybhYuzXMOymdZt+hUUzhatm1Yf6w
   28cy9p7yS/GnJ7Rwd+ZG0Rh/P9vZfmS5PMwXITzK+o/2GPLdcEzJdg9v7
   qU3vBETRQj3jSL7K2KbxOR66NfaPHCijXB0DQSLaUZj5PkGogRcJaDxZu
   w==;
X-CSE-ConnectionGUID: O+5KGaKCQ2mFlyxMQSVMDg==
X-CSE-MsgGUID: oom52oL/RHmxfg7xg8iCTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11625"; a="70148983"
X-IronPort-AV: E=Sophos;i="6.20,231,1758610800"; 
   d="scan'208";a="70148983"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2025 03:19:32 -0800
X-CSE-ConnectionGUID: E9XTKuJvT/K7/44QArVW9w==
X-CSE-MsgGUID: vZzag+hWTkOAQbBQ2FbNvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,231,1758610800"; 
   d="scan'208";a="198149974"
Received: from lkp-server01.sh.intel.com (HELO 4664bbef4914) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 27 Nov 2025 03:19:31 -0800
Received: from kbuild by 4664bbef4914 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vOa25-000000004fH-1ykw;
	Thu, 27 Nov 2025 11:19:29 +0000
Date: Thu, 27 Nov 2025 19:18:56 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 f9e788c5fd3a23edecd808ebb354e2cb1aef87c3
Message-ID: <202511271950.Px3SLgM4-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: f9e788c5fd3a23edecd808ebb354e2cb1aef87c3  wifi: mac80211: allow sharing identical chanctx for S1G interfaces

elapsed time: 1494m

configs tested: 181
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20251126    gcc-13.4.0
arc                   randconfig-001-20251127    clang-22
arc                   randconfig-002-20251126    gcc-11.5.0
arc                   randconfig-002-20251127    clang-22
arm                               allnoconfig    clang-22
arm                               allnoconfig    gcc-15.1.0
arm                         axm55xx_defconfig    clang-19
arm                                 defconfig    gcc-15.1.0
arm                            mmp2_defconfig    clang-19
arm                         mv78xx0_defconfig    clang-19
arm                   randconfig-001-20251126    clang-22
arm                   randconfig-001-20251127    clang-22
arm                   randconfig-002-20251126    clang-22
arm                   randconfig-002-20251127    clang-22
arm                   randconfig-003-20251126    clang-19
arm                   randconfig-003-20251127    clang-22
arm                   randconfig-004-20251126    clang-22
arm                   randconfig-004-20251127    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251127    gcc-15.1.0
arm64                 randconfig-002-20251127    gcc-15.1.0
arm64                 randconfig-003-20251127    gcc-15.1.0
arm64                 randconfig-004-20251127    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251127    gcc-15.1.0
csky                  randconfig-002-20251127    gcc-15.1.0
hexagon                           allnoconfig    clang-22
hexagon                           allnoconfig    gcc-15.1.0
hexagon                             defconfig    gcc-15.1.0
hexagon               randconfig-001-20251126    clang-22
hexagon               randconfig-001-20251127    gcc-15.1.0
hexagon               randconfig-002-20251126    clang-22
hexagon               randconfig-002-20251127    gcc-15.1.0
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.1.0
i386        buildonly-randconfig-001-20251127    clang-20
i386        buildonly-randconfig-002-20251127    clang-20
i386        buildonly-randconfig-003-20251127    clang-20
i386        buildonly-randconfig-004-20251127    clang-20
i386        buildonly-randconfig-005-20251127    clang-20
i386        buildonly-randconfig-006-20251127    clang-20
i386                                defconfig    gcc-15.1.0
i386                  randconfig-001-20251127    clang-20
i386                  randconfig-002-20251127    clang-20
i386                  randconfig-003-20251127    clang-20
i386                  randconfig-004-20251127    clang-20
i386                  randconfig-005-20251127    clang-20
i386                  randconfig-006-20251127    clang-20
i386                  randconfig-007-20251127    clang-20
i386                  randconfig-011-20251127    clang-20
i386                  randconfig-012-20251127    clang-20
i386                  randconfig-013-20251127    clang-20
i386                  randconfig-014-20251127    clang-20
i386                  randconfig-015-20251127    clang-20
i386                  randconfig-016-20251127    clang-20
i386                  randconfig-017-20251127    clang-20
loongarch                         allnoconfig    clang-22
loongarch                         allnoconfig    gcc-15.1.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251126    gcc-15.1.0
loongarch             randconfig-001-20251127    gcc-15.1.0
loongarch             randconfig-002-20251126    clang-22
loongarch             randconfig-002-20251127    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                                defconfig    clang-19
microblaze                        allnoconfig    gcc-15.1.0
microblaze                          defconfig    clang-19
mips                              allnoconfig    gcc-15.1.0
mips                          ath79_defconfig    clang-19
nios2                             allnoconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20251126    gcc-11.5.0
nios2                 randconfig-001-20251127    gcc-15.1.0
nios2                 randconfig-002-20251126    gcc-9.5.0
nios2                 randconfig-002-20251127    gcc-15.1.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251127    gcc-13.4.0
parisc                randconfig-001-20251127    gcc-8.5.0
parisc                randconfig-002-20251127    gcc-13.4.0
parisc                randconfig-002-20251127    gcc-15.1.0
parisc64                            defconfig    clang-19
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc               randconfig-001-20251127    clang-22
powerpc               randconfig-001-20251127    gcc-13.4.0
powerpc               randconfig-002-20251127    gcc-13.4.0
powerpc                      tqm8xx_defconfig    clang-19
powerpc                        warp_defconfig    clang-19
powerpc64             randconfig-001-20251127    clang-20
powerpc64             randconfig-001-20251127    gcc-13.4.0
powerpc64             randconfig-002-20251127    gcc-13.4.0
powerpc64             randconfig-002-20251127    gcc-14.3.0
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                               defconfig    clang-22
riscv                               defconfig    gcc-15.1.0
riscv                 randconfig-001-20251126    gcc-10.5.0
riscv                 randconfig-001-20251127    gcc-12.5.0
riscv                 randconfig-002-20251126    clang-22
riscv                 randconfig-002-20251127    gcc-12.5.0
s390                              allnoconfig    clang-22
s390                                defconfig    clang-22
s390                                defconfig    gcc-15.1.0
s390                  randconfig-001-20251126    gcc-8.5.0
s390                  randconfig-001-20251127    gcc-12.5.0
s390                  randconfig-002-20251126    gcc-8.5.0
s390                  randconfig-002-20251127    gcc-12.5.0
sh                                allnoconfig    clang-22
sh                                allnoconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20251126    gcc-14.3.0
sh                    randconfig-001-20251127    gcc-12.5.0
sh                    randconfig-002-20251126    gcc-11.5.0
sh                    randconfig-002-20251127    gcc-12.5.0
sh                   secureedge5410_defconfig    clang-19
sparc                             allnoconfig    clang-22
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251127    clang-22
sparc                 randconfig-001-20251127    gcc-13.4.0
sparc                 randconfig-002-20251127    clang-22
sparc                 randconfig-002-20251127    gcc-11.5.0
sparc64                             defconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20251127    clang-22
sparc64               randconfig-001-20251127    gcc-15.1.0
sparc64               randconfig-002-20251127    clang-20
sparc64               randconfig-002-20251127    clang-22
um                                allnoconfig    clang-22
um                                  defconfig    clang-22
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251127    clang-22
um                    randconfig-001-20251127    gcc-14
um                    randconfig-002-20251127    clang-22
um                           x86_64_defconfig    clang-22
um                           x86_64_defconfig    gcc-14
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64      buildonly-randconfig-001-20251127    clang-20
x86_64      buildonly-randconfig-002-20251127    clang-20
x86_64      buildonly-randconfig-003-20251127    clang-20
x86_64      buildonly-randconfig-004-20251127    clang-20
x86_64      buildonly-randconfig-005-20251127    clang-20
x86_64      buildonly-randconfig-006-20251127    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20251127    gcc-14
x86_64                randconfig-002-20251127    gcc-14
x86_64                randconfig-003-20251127    gcc-14
x86_64                randconfig-004-20251127    gcc-14
x86_64                randconfig-005-20251127    gcc-14
x86_64                randconfig-006-20251127    gcc-14
x86_64                randconfig-071-20251127    gcc-14
x86_64                randconfig-072-20251127    gcc-14
x86_64                randconfig-073-20251127    gcc-14
x86_64                randconfig-074-20251127    gcc-14
x86_64                randconfig-075-20251127    gcc-14
x86_64                randconfig-076-20251127    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
xtensa                            allnoconfig    clang-22
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251127    clang-22
xtensa                randconfig-001-20251127    gcc-11.5.0
xtensa                randconfig-002-20251127    clang-22
xtensa                randconfig-002-20251127    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

