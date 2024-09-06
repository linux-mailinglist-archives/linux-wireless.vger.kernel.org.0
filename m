Return-Path: <linux-wireless+bounces-12591-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF3396EE6C
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Sep 2024 10:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98196284A5E
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Sep 2024 08:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CFB6155741;
	Fri,  6 Sep 2024 08:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z5g4yKxK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7478E15278E
	for <linux-wireless@vger.kernel.org>; Fri,  6 Sep 2024 08:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725612177; cv=none; b=j4xJwiRBGfGicwdcxZdD+bC2kEQ1k5ycw9V79HXMUHjS4SsQOGg143RNekWqdLA1Y25Hqjj2VD/+/YZu6gGRJaQDXDXkIiE369ubGSsNcfFKmTtJS7eJiFMGl0t+mPI6Rsk0PzTutFuKvIkvRgguWf3tUgWEJoZdu2USvWs7Z9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725612177; c=relaxed/simple;
	bh=v76YgH4LWbdPsITzsdkvL86EOBWkVoAoIlXrcdFtZ5w=;
	h=Date:From:To:Cc:Subject:Message-ID; b=gLuCxsKlWtXT+mb7GKe63RGtu/+loMKP7Y4N/Dztnym4B+MCl0Ljupib7xNaI75N7Z1+tmkslUXKCEOb8Z6aqeqA0QPnHMAteLeqOZ1vN+JDIea54pj86RtmnTNUpN2R8g/Eqze5Dz8i8uYroneiQ7gRy++awGmvwSWStdNow8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z5g4yKxK; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725612175; x=1757148175;
  h=date:from:to:cc:subject:message-id;
  bh=v76YgH4LWbdPsITzsdkvL86EOBWkVoAoIlXrcdFtZ5w=;
  b=Z5g4yKxK1khkqtHEqIt16JVbMl2h0wIVhEeIYr7PI0L40/w8ZOm8ue1T
   p5S47N449akZd0Xdl1Ti3cGQ+2jOM86ORsgzjJlxptr0fPwjKuGBsWbs7
   pzV2pirGceO5U8rM0Urgqk2ur1zs3dVJFCcQzNiTqyETLzib72lNTCl2O
   upyk1/ZuHipRcCU4U8stvW1KA7jm9yB2XH5GDe5gkis2zp6V+zoFlAk+K
   IN3lankf95tjgtzFzmTNax7lz9dmj+S78+MlrZ3q6NB99TsXt0ZXLkZjI
   95j1ovNdczJvwr48h9kUg7105zcetvA0Y2Djf9JOTD7oA4ZmmmxorxIja
   w==;
X-CSE-ConnectionGUID: Dmo3N0tpRsa82rirKGVZsA==
X-CSE-MsgGUID: tYQZidaRSSicON/ZAeautQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11186"; a="41845331"
X-IronPort-AV: E=Sophos;i="6.10,207,1719903600"; 
   d="scan'208";a="41845331"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2024 01:42:54 -0700
X-CSE-ConnectionGUID: j3ZcbtoHTDS/EMFmINkrbg==
X-CSE-MsgGUID: gSl3xDmhTpm/jc9jPaFcrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,207,1719903600"; 
   d="scan'208";a="96605192"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 06 Sep 2024 01:42:53 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1smUYM-000Asd-2v;
	Fri, 06 Sep 2024 08:42:50 +0000
Date: Fri, 06 Sep 2024 16:41:55 +0800
From: kernel test robot <lkp@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 43b7724487109368363bb5cda034b3f600278d14
Message-ID: <202409061652.BKrlZ6Sc-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 43b7724487109368363bb5cda034b3f600278d14  Merge tag 'wireless-next-2024-09-04' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next

elapsed time: 1859m

configs tested: 173
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-14.1.0
alpha                            allyesconfig   clang-20
alpha                               defconfig   gcc-14.1.0
arc                              allmodconfig   clang-20
arc                               allnoconfig   gcc-14.1.0
arc                              allyesconfig   clang-20
arc                                 defconfig   gcc-14.1.0
arc                   randconfig-001-20240906   clang-20
arc                   randconfig-002-20240906   clang-20
arm                              allmodconfig   clang-20
arm                               allnoconfig   gcc-14.1.0
arm                              allyesconfig   clang-20
arm                         bcm2835_defconfig   clang-20
arm                                 defconfig   gcc-14.1.0
arm                      footbridge_defconfig   clang-20
arm                         nhk8815_defconfig   clang-20
arm                   randconfig-001-20240906   clang-20
arm                   randconfig-002-20240906   clang-20
arm                   randconfig-003-20240906   clang-20
arm                   randconfig-004-20240906   clang-20
arm                         s5pv210_defconfig   clang-20
arm64                            allmodconfig   clang-20
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-14.1.0
arm64                 randconfig-001-20240906   clang-20
arm64                 randconfig-002-20240906   clang-20
arm64                 randconfig-003-20240906   clang-20
arm64                 randconfig-004-20240906   clang-20
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-14.1.0
csky                  randconfig-001-20240906   clang-20
csky                  randconfig-002-20240906   clang-20
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   gcc-14.1.0
hexagon                          allyesconfig   clang-20
hexagon                             defconfig   gcc-14.1.0
hexagon               randconfig-001-20240906   clang-20
hexagon               randconfig-002-20240906   clang-20
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-12
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-12
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240906   gcc-12
i386         buildonly-randconfig-002-20240906   gcc-12
i386         buildonly-randconfig-003-20240906   gcc-12
i386         buildonly-randconfig-004-20240906   gcc-12
i386         buildonly-randconfig-005-20240906   gcc-12
i386         buildonly-randconfig-006-20240906   gcc-12
i386                                defconfig   clang-18
i386                  randconfig-001-20240906   gcc-12
i386                  randconfig-002-20240906   gcc-12
i386                  randconfig-003-20240906   gcc-12
i386                  randconfig-004-20240906   gcc-12
i386                  randconfig-005-20240906   gcc-12
i386                  randconfig-006-20240906   gcc-12
i386                  randconfig-011-20240906   gcc-12
i386                  randconfig-012-20240906   gcc-12
i386                  randconfig-013-20240906   gcc-12
i386                  randconfig-014-20240906   gcc-12
i386                  randconfig-015-20240906   gcc-12
i386                  randconfig-016-20240906   gcc-12
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-14.1.0
loongarch             randconfig-001-20240906   clang-20
loongarch             randconfig-002-20240906   clang-20
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-14.1.0
nios2                 randconfig-001-20240906   clang-20
nios2                 randconfig-002-20240906   clang-20
openrisc                          allnoconfig   clang-20
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-12
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   clang-20
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-12
parisc                randconfig-001-20240906   clang-20
parisc                randconfig-002-20240906   clang-20
parisc64                            defconfig   gcc-14.1.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   clang-20
powerpc                          allyesconfig   gcc-14.1.0
powerpc                      arches_defconfig   clang-20
powerpc                   bluestone_defconfig   clang-20
powerpc                 linkstation_defconfig   clang-20
powerpc                 mpc8315_rdb_defconfig   clang-20
powerpc                      ppc44x_defconfig   clang-20
powerpc               randconfig-002-20240906   clang-20
powerpc               randconfig-003-20240906   clang-20
powerpc                      tqm8xx_defconfig   clang-20
powerpc64             randconfig-001-20240906   clang-20
powerpc64             randconfig-002-20240906   clang-20
powerpc64             randconfig-003-20240906   clang-20
riscv                             allnoconfig   clang-20
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-12
riscv                 randconfig-001-20240906   clang-20
riscv                 randconfig-002-20240906   clang-20
s390                             allmodconfig   gcc-14.1.0
s390                              allnoconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-12
s390                  randconfig-001-20240906   clang-20
s390                  randconfig-002-20240906   clang-20
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-12
sh                          landisk_defconfig   clang-20
sh                    randconfig-001-20240906   clang-20
sh                    randconfig-002-20240906   clang-20
sh                          sdk7780_defconfig   clang-20
sh                             sh03_defconfig   clang-20
sh                     sh7710voipgw_defconfig   clang-20
sh                            titan_defconfig   clang-20
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-12
sparc64               randconfig-001-20240906   clang-20
sparc64               randconfig-002-20240906   clang-20
um                               allmodconfig   clang-20
um                                allnoconfig   clang-20
um                               allyesconfig   clang-20
um                                  defconfig   gcc-12
um                             i386_defconfig   gcc-12
um                    randconfig-001-20240906   clang-20
um                    randconfig-002-20240906   clang-20
um                           x86_64_defconfig   gcc-12
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240906   clang-18
x86_64       buildonly-randconfig-002-20240906   clang-18
x86_64       buildonly-randconfig-003-20240906   clang-18
x86_64       buildonly-randconfig-004-20240906   clang-18
x86_64       buildonly-randconfig-005-20240906   clang-18
x86_64       buildonly-randconfig-006-20240906   clang-18
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-11
x86_64                                  kexec   gcc-12
x86_64                randconfig-001-20240906   clang-18
x86_64                randconfig-002-20240906   clang-18
x86_64                randconfig-003-20240906   clang-18
x86_64                randconfig-004-20240906   clang-18
x86_64                randconfig-005-20240906   clang-18
x86_64                randconfig-006-20240906   clang-18
x86_64                randconfig-011-20240906   clang-18
x86_64                randconfig-012-20240906   clang-18
x86_64                randconfig-013-20240906   clang-18
x86_64                randconfig-014-20240906   clang-18
x86_64                randconfig-015-20240906   clang-18
x86_64                randconfig-016-20240906   clang-18
x86_64                randconfig-071-20240906   clang-18
x86_64                randconfig-072-20240906   clang-18
x86_64                randconfig-073-20240906   clang-18
x86_64                randconfig-074-20240906   clang-18
x86_64                randconfig-075-20240906   clang-18
x86_64                randconfig-076-20240906   clang-18
x86_64                          rhel-8.3-rust   clang-18
x86_64                               rhel-8.3   gcc-12
xtensa                            allnoconfig   gcc-14.1.0
xtensa                randconfig-001-20240906   clang-20
xtensa                randconfig-002-20240906   clang-20

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

