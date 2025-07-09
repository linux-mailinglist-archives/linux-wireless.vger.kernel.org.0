Return-Path: <linux-wireless+bounces-25081-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06480AFE387
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 11:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98B6A3BB0EC
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 09:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A4E283FDB;
	Wed,  9 Jul 2025 09:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QSpX862a"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE7379DA
	for <linux-wireless@vger.kernel.org>; Wed,  9 Jul 2025 09:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752051910; cv=none; b=NfJ1BH2X2C0JkUhLV1b9j+CNS3ZReCSsWNxzl5UCQ0AKafKopPZD93vI8xl3j+xr8jGb/WJpiMYWdi7EyAULzzGf17Fp4vBpautJVL/U2aD0NpMpRwLJCveErwgVpR5bXtNvEXmKiaSopFuYVEwRsgJHab7bosLwt4C9/SrfIUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752051910; c=relaxed/simple;
	bh=ftUmRnOrM6vfulrF3hDUU99XPN1PFvpzdjwGMftHEnc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=BwTeUOPUHuN61yOLXTETyVyPXcgWnU49rxqyJ/2vHsYagE4Zpng4kwls32RsW+qKHKp3/1coqsW3iIgSG700eXroptg6Qfr9DSIvkDuDSildjtZt2QCnhYpPLPmPi9Tugvm6Y8zHEPibcq8yNHTVu5B7V0eDoJRc2Mf2qDHo2Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QSpX862a; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752051908; x=1783587908;
  h=date:from:to:cc:subject:message-id;
  bh=ftUmRnOrM6vfulrF3hDUU99XPN1PFvpzdjwGMftHEnc=;
  b=QSpX862aByFyKnFt0wBpUIrvTcf498B/5Kkw9S9MoWdJ5eL8OZ3m2s3c
   KxBILDMRrRtyhnx9xvIJN9zAEvYrlfgdpNLO7DyPJDNRrteC3srOsPHlM
   Ajih8hgpj3870U2oTQHlbWa184/lpP2S/7YxLZWpEQ4DhmVK11oklHYp3
   A78MtRHnbYyQ4OSYTelMwKPrh9pZB2Hei6H4uXVTYpr6qnCHJYoPXVaWI
   8vaixgs4SNBwNjXVCht5oEzyjgBySaNFDcM1uuB+lS5thzk/0qLghigVf
   3cbE15g987bJ/qqQUqVGlX/0SLTgaBFTlKeX6xw0CzPUZ9f/kO1ovb5Lh
   w==;
X-CSE-ConnectionGUID: hw7vaM+MSwGqJuVqbclZow==
X-CSE-MsgGUID: 2UtYHDmmQ2CDIKmcwyXcRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="79744508"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="79744508"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 02:05:08 -0700
X-CSE-ConnectionGUID: 568K7YlTSj++KUmXkeyHzg==
X-CSE-MsgGUID: 48C2ck6fQIiyLXhw7aYVAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="155142368"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 09 Jul 2025 02:05:06 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uZQjg-0003KZ-0P;
	Wed, 09 Jul 2025 09:05:04 +0000
Date: Wed, 09 Jul 2025 17:04:51 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 cc2b722132893164bcb3cee4f08ed056e126eb6c
Message-ID: <202507091739.l1QQWT1J-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: cc2b722132893164bcb3cee4f08ed056e126eb6c  wifi: mac80211: fix rx link assignment for non-MLO stations

elapsed time: 1198m

configs tested: 141
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250708    gcc-13.4.0
arc                   randconfig-002-20250708    gcc-8.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-15.1.0
arm                         orion5x_defconfig    clang-21
arm                   randconfig-001-20250708    clang-21
arm                   randconfig-002-20250708    clang-17
arm                   randconfig-003-20250708    gcc-10.5.0
arm                   randconfig-004-20250708    clang-21
arm                           sama5_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250708    gcc-9.5.0
arm64                 randconfig-002-20250708    clang-19
arm64                 randconfig-003-20250708    clang-21
arm64                 randconfig-004-20250708    gcc-8.5.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250708    gcc-13.4.0
csky                  randconfig-002-20250708    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250708    clang-21
hexagon               randconfig-002-20250708    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250708    clang-20
i386        buildonly-randconfig-002-20250708    clang-20
i386        buildonly-randconfig-003-20250708    clang-20
i386        buildonly-randconfig-004-20250708    gcc-12
i386        buildonly-randconfig-005-20250708    clang-20
i386        buildonly-randconfig-006-20250708    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-21
loongarch             randconfig-001-20250708    clang-21
loongarch             randconfig-002-20250708    clang-21
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                          atari_defconfig    gcc-15.1.0
m68k                       m5275evb_defconfig    gcc-15.1.0
m68k                           sun3_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                           ip32_defconfig    clang-21
mips                           jazz_defconfig    clang-17
mips                         rt305x_defconfig    clang-21
nios2                            alldefconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250708    gcc-8.5.0
nios2                 randconfig-002-20250708    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250708    gcc-9.3.0
parisc                randconfig-002-20250708    gcc-14.3.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-21
powerpc                     asp8347_defconfig    clang-21
powerpc                 mpc8313_rdb_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250708    gcc-8.5.0
powerpc               randconfig-002-20250708    clang-19
powerpc               randconfig-003-20250708    clang-21
powerpc64             randconfig-001-20250708    clang-21
powerpc64             randconfig-002-20250708    clang-21
powerpc64             randconfig-003-20250708    clang-21
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-21
riscv                    nommu_k210_defconfig    clang-21
riscv                 randconfig-001-20250708    clang-16
riscv                 randconfig-002-20250708    gcc-11.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-21
s390                  randconfig-001-20250708    gcc-14.3.0
s390                  randconfig-002-20250708    gcc-9.3.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                        apsh4ad0a_defconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20250708    gcc-11.5.0
sh                    randconfig-002-20250708    gcc-15.1.0
sh                           sh2007_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250708    gcc-13.4.0
sparc                 randconfig-002-20250708    gcc-13.4.0
sparc                       sparc64_defconfig    gcc-15.1.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20250708    clang-21
sparc64               randconfig-002-20250708    gcc-15.1.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250708    clang-21
um                    randconfig-002-20250708    clang-17
um                           x86_64_defconfig    clang-21
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250708    gcc-12
x86_64      buildonly-randconfig-001-20250709    gcc-12
x86_64      buildonly-randconfig-002-20250708    gcc-12
x86_64      buildonly-randconfig-002-20250709    clang-20
x86_64      buildonly-randconfig-003-20250708    clang-20
x86_64      buildonly-randconfig-003-20250709    gcc-12
x86_64      buildonly-randconfig-004-20250708    gcc-12
x86_64      buildonly-randconfig-004-20250709    gcc-12
x86_64      buildonly-randconfig-005-20250708    clang-20
x86_64      buildonly-randconfig-005-20250709    clang-20
x86_64      buildonly-randconfig-006-20250708    clang-20
x86_64      buildonly-randconfig-006-20250709    gcc-12
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250708    gcc-8.5.0
xtensa                randconfig-002-20250708    gcc-9.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

