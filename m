Return-Path: <linux-wireless+bounces-27670-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDCE7BA313B
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Sep 2025 11:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83160626C61
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Sep 2025 09:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273FD272803;
	Fri, 26 Sep 2025 09:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T79m080o"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524D813FEE
	for <linux-wireless@vger.kernel.org>; Fri, 26 Sep 2025 09:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758877755; cv=none; b=ZNTw7PKcE3bOGB/8qKGJmGII34K0nNMJWLVHY+Q8H3I+apzC1cJ9zTdziFNImLpdjEW6iqT9TSAw7RSevpAuC0WqNf1hPWhHJYjsykMZvfcqLTrPOLpx+JzNOOCK6D6tfNrP2L2A8Wpu6CIXk16cF9uMLbD0NrAmis8TCIHdaA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758877755; c=relaxed/simple;
	bh=AYnyFP17lVEdQciJT64/V5F7GFz3iaRC29aGrVqWZW8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=qW6pWvs8GdlukiuJRm+BGLBlJ9TLzzHwYdHEY+V4L1dlLW6bkJNNUbQyy/M5Sybp1zrA6TpUw2+S0VM5nOAFXFNevvV800uCzMgtb5PS6FUtCBKY9R3ePsJdnZ2nOHUjo8A9nWkK+SpReJf1qf44IeHteKx6AWXCPxiewa1obCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T79m080o; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758877753; x=1790413753;
  h=date:from:to:cc:subject:message-id;
  bh=AYnyFP17lVEdQciJT64/V5F7GFz3iaRC29aGrVqWZW8=;
  b=T79m080oEGoA2Kxd0QqzG1QFC5MtR7fr76n2vbgj3R03d22CzDe6RkVP
   r3sUEkY2DfTF1k86gqr6flek0hlLZhbRh2z+5tWo3f/Rf/u7BlXmDTpyr
   MqXDthcd71HfRy85fZM2BjjsQ2jIDls0WoNUJaJuuMLPsa7vdn2tZx16s
   nQ9X9jmDuxzRfHIjCo07ELpNfiqn1OnINboRmLwQ6VFdhHkVhb7QqPOPs
   1ObxOfOtVI6E6n+8bK5agp15vpNdQgNV+BMEGzXlCRlSWkuN7wUcVYvsF
   76ER4vg2jsn//TZtrd0UAB74H7EPFi8NSJxyynI0lIw68LMyKRQazYC5I
   A==;
X-CSE-ConnectionGUID: Gzgpu1/mSGOkDxrM5fVOfQ==
X-CSE-MsgGUID: 0nmAtSQKSYa5yMdXzWc2XA==
X-IronPort-AV: E=McAfee;i="6800,10657,11564"; a="63842966"
X-IronPort-AV: E=Sophos;i="6.18,294,1751266800"; 
   d="scan'208";a="63842966"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 02:09:12 -0700
X-CSE-ConnectionGUID: WSoKkKoBSaOvOVdxeWW67g==
X-CSE-MsgGUID: LMggW64JQMGRQBKlu895IA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,294,1751266800"; 
   d="scan'208";a="201252363"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 26 Sep 2025 02:09:11 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v24Ro-00064M-0z;
	Fri, 26 Sep 2025 09:09:02 +0000
Date: Fri, 26 Sep 2025 17:07:53 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 56d9de46715245c9cc46dbe16830e431056abbc3
Message-ID: <202509261745.WmTfyerv-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 56d9de46715245c9cc46dbe16830e431056abbc3  wifi: libertas: add WQ_UNBOUND to alloc_workqueue users

elapsed time: 1466m

configs tested: 123
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                          axs101_defconfig    gcc-15.1.0
arc                   randconfig-001-20250925    gcc-13.4.0
arc                   randconfig-002-20250925    gcc-15.1.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                         nhk8815_defconfig    clang-22
arm                   randconfig-001-20250925    gcc-11.5.0
arm                   randconfig-002-20250925    gcc-10.5.0
arm                   randconfig-003-20250925    gcc-8.5.0
arm                   randconfig-004-20250925    gcc-14.3.0
arm                        shmobile_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250925    gcc-11.5.0
arm64                 randconfig-002-20250925    gcc-15.1.0
arm64                 randconfig-003-20250925    clang-19
arm64                 randconfig-004-20250925    gcc-8.5.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250925    gcc-14.3.0
csky                  randconfig-002-20250925    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250925    clang-22
hexagon               randconfig-002-20250925    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20250925    clang-20
i386        buildonly-randconfig-002-20250925    clang-20
i386        buildonly-randconfig-003-20250925    gcc-14
i386        buildonly-randconfig-004-20250925    gcc-14
i386        buildonly-randconfig-005-20250925    clang-20
i386        buildonly-randconfig-006-20250925    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250925    clang-18
loongarch             randconfig-002-20250925    gcc-12.5.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                      maltaaprp_defconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250925    gcc-8.5.0
nios2                 randconfig-002-20250925    gcc-10.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                generic-64bit_defconfig    gcc-15.1.0
parisc                randconfig-001-20250925    gcc-8.5.0
parisc                randconfig-002-20250925    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                          g5_defconfig    gcc-15.1.0
powerpc                      mgcoge_defconfig    clang-22
powerpc                   motionpro_defconfig    clang-22
powerpc                 mpc832x_rdb_defconfig    gcc-15.1.0
powerpc                    mvme5100_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250925    clang-22
powerpc               randconfig-002-20250925    gcc-8.5.0
powerpc               randconfig-003-20250925    gcc-8.5.0
powerpc64             randconfig-001-20250925    clang-22
powerpc64             randconfig-002-20250925    gcc-14.3.0
powerpc64             randconfig-003-20250925    gcc-8.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                 randconfig-001-20250925    clang-22
riscv                 randconfig-002-20250925    clang-22
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250925    gcc-15.1.0
s390                  randconfig-002-20250925    gcc-13.4.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                             espt_defconfig    gcc-15.1.0
sh                          landisk_defconfig    gcc-15.1.0
sh                          r7780mp_defconfig    gcc-15.1.0
sh                    randconfig-001-20250925    gcc-15.1.0
sh                    randconfig-002-20250925    gcc-13.4.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20250925    gcc-15.1.0
sparc                 randconfig-002-20250925    gcc-12.5.0
sparc64               randconfig-001-20250925    gcc-10.5.0
sparc64               randconfig-002-20250925    gcc-10.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                    randconfig-001-20250925    gcc-14
um                    randconfig-002-20250925    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250925    clang-20
x86_64      buildonly-randconfig-002-20250925    gcc-14
x86_64      buildonly-randconfig-003-20250925    gcc-14
x86_64      buildonly-randconfig-004-20250925    clang-20
x86_64      buildonly-randconfig-005-20250925    clang-20
x86_64      buildonly-randconfig-006-20250925    gcc-14
x86_64                              defconfig    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                generic_kc705_defconfig    gcc-15.1.0
xtensa                  nommu_kc705_defconfig    gcc-15.1.0
xtensa                randconfig-001-20250925    gcc-12.5.0
xtensa                randconfig-002-20250925    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

