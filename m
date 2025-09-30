Return-Path: <linux-wireless+bounces-27716-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D39FBAAD81
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Sep 2025 03:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A76667A6E78
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Sep 2025 01:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666791547EE;
	Tue, 30 Sep 2025 01:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lOKun/7V"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3FB748F
	for <linux-wireless@vger.kernel.org>; Tue, 30 Sep 2025 01:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759194699; cv=none; b=b5lsNNY0X6W/UaNotHDGYCeBDDUy/kWYEVR0nZeTIabpYG2czeL9yRgCRxLq8E8RsJmLrumsH0stnv/bOGTAIi2YfrqJVfKMH4l005KpTeVOoRbms/0+aw8+sYosTfH1VzLrlrNw+O6S1zhjRGo7IPQHHFOAb+/a56ChwLyjUsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759194699; c=relaxed/simple;
	bh=j9TQe3PmjACBDcY1PwmYVGSudKyqJhI9tpY4ilSsVEk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=DIvl/vtKAtLeq5+zuoD4VmrH0IRXGPWzWzfFBGRvkotsqn5D+01UIMmGG4LEY2TXyZnzQ9n6i18WLkOwQ9TfmlwrznN//FxOPu+MAZessPEWYiPJT2IWn9JXU75ghNaZ3ENdVQk+7anywnNahv6tXnjNpdRNrIATCGz3Cx3lM+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lOKun/7V; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759194698; x=1790730698;
  h=date:from:to:cc:subject:message-id;
  bh=j9TQe3PmjACBDcY1PwmYVGSudKyqJhI9tpY4ilSsVEk=;
  b=lOKun/7VWm4l+kxnfyKa6r4UIdxa/6KQK7Hquo53t9lNLrd+xUTG5gws
   W8zKpFfAgk6/UaRO4E6mxs2vy3mQlg3opICXQ3oUNKKdBF2KGUBOGlsOd
   xo0A/Q1bNxc07FTHviHIWxtf5OkEUC8ExrczRQTPRY3xV5SfNmwIK8FGx
   yWNhn3t+TE74BwHDyQLF76NRf79a6lhQjtFzk55VBQPNoq5zEJ9PNZjdz
   1MrRZY5hwgjYJB4I1UcPFBaL0GIYYaulUWGEvaZJNZkebrly9PJsvu7wv
   I31wfIzsecbIkzZpEBR556UOJEI5H1y0kpJ/E5kEB1yLMBZiYsn+rufO9
   Q==;
X-CSE-ConnectionGUID: v0ByPv4aTNen04kdjt59KQ==
X-CSE-MsgGUID: fOHPFxnKSgyuwUdjQOn3Qg==
X-IronPort-AV: E=McAfee;i="6800,10657,11568"; a="78867532"
X-IronPort-AV: E=Sophos;i="6.18,302,1751266800"; 
   d="scan'208";a="78867532"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 18:11:38 -0700
X-CSE-ConnectionGUID: 67HCAiqATsuc9OK34RJBCA==
X-CSE-MsgGUID: EEhipNh/RguCuTKv49XtRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,302,1751266800"; 
   d="scan'208";a="183640142"
Received: from lkp-server01.sh.intel.com (HELO 2f2a1232a4e4) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 29 Sep 2025 18:11:35 -0700
Received: from kbuild by 2f2a1232a4e4 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v3Otx-0000nF-0n;
	Tue, 30 Sep 2025 01:11:33 +0000
Date: Tue, 30 Sep 2025 09:10:57 +0800
From: kernel test robot <lkp@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 94aced6ed9e2630bae0b5631e384a5302c4b6783
Message-ID: <202509300947.oIdN60i5-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 94aced6ed9e2630bae0b5631e384a5302c4b6783  Merge tag 'wireless-next-2025-09-25' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next

elapsed time: 967m

configs tested: 135
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250929    gcc-8.5.0
arc                   randconfig-002-20250929    gcc-8.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                          collie_defconfig    gcc-15.1.0
arm                         orion5x_defconfig    clang-22
arm                   randconfig-001-20250929    gcc-8.5.0
arm                   randconfig-002-20250929    gcc-14.3.0
arm                   randconfig-003-20250929    clang-22
arm                   randconfig-004-20250929    gcc-10.5.0
arm                          sp7021_defconfig    gcc-15.1.0
arm                       spear13xx_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250929    gcc-8.5.0
arm64                 randconfig-002-20250929    gcc-13.4.0
arm64                 randconfig-003-20250929    clang-22
arm64                 randconfig-004-20250929    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250929    gcc-9.5.0
csky                  randconfig-002-20250929    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250929    clang-22
hexagon               randconfig-002-20250929    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20250929    gcc-14
i386        buildonly-randconfig-002-20250929    clang-20
i386        buildonly-randconfig-003-20250929    gcc-14
i386        buildonly-randconfig-004-20250929    gcc-14
i386        buildonly-randconfig-005-20250929    gcc-14
i386        buildonly-randconfig-006-20250929    gcc-14
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250929    gcc-12.5.0
loongarch             randconfig-002-20250929    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                        m5307c3_defconfig    gcc-15.1.0
m68k                           virt_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                           ip30_defconfig    gcc-15.1.0
mips                           xway_defconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250929    gcc-11.5.0
nios2                 randconfig-002-20250929    gcc-9.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
openrisc                 simple_smp_defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250929    gcc-14.3.0
parisc                randconfig-002-20250929    gcc-14.3.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                 mpc837x_rdb_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250929    gcc-15.1.0
powerpc               randconfig-002-20250929    gcc-8.5.0
powerpc               randconfig-003-20250929    gcc-13.4.0
powerpc64             randconfig-001-20250929    clang-18
powerpc64             randconfig-002-20250929    clang-22
powerpc64             randconfig-003-20250929    clang-22
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20250929    gcc-9.5.0
riscv                 randconfig-002-20250929    gcc-11.5.0
s390                             alldefconfig    gcc-15.1.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20250929    gcc-11.5.0
s390                  randconfig-002-20250929    gcc-13.4.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                        dreamcast_defconfig    gcc-15.1.0
sh                    randconfig-001-20250929    gcc-15.1.0
sh                    randconfig-002-20250929    gcc-15.1.0
sh                           se7206_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250929    gcc-8.5.0
sparc                 randconfig-002-20250929    gcc-8.5.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20250929    clang-22
sparc64               randconfig-002-20250929    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20250929    gcc-14
um                    randconfig-002-20250929    gcc-14
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250929    gcc-14
x86_64      buildonly-randconfig-002-20250929    gcc-14
x86_64      buildonly-randconfig-003-20250929    clang-20
x86_64      buildonly-randconfig-004-20250929    gcc-14
x86_64      buildonly-randconfig-005-20250929    gcc-14
x86_64      buildonly-randconfig-006-20250929    gcc-14
x86_64                              defconfig    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250929    gcc-8.5.0
xtensa                randconfig-002-20250929    gcc-13.4.0
xtensa                    smp_lx200_defconfig    gcc-15.1.0
xtensa                    xip_kc705_defconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

