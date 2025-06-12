Return-Path: <linux-wireless+bounces-24077-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 578F2AD773F
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 17:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C5DE1885D5F
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 15:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09EB2206BB;
	Thu, 12 Jun 2025 15:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PCFBvybb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A992989A4
	for <linux-wireless@vger.kernel.org>; Thu, 12 Jun 2025 15:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749743373; cv=none; b=qnJLV2q0fIhjKZ1Q/HB3BApQESnM8CtvK+GKnJOH7ZrCXxn3uHrr/XNdkw1O3pmt6Veh2EIM8E/4ZCILcEkt/JKXIVighihpTXJ4/NVPMb0hblyf8bDoIXI68CrT5t3+KROnSMeT9aomcngDyzktP1wh+q8K0fdcKGubOQrXegU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749743373; c=relaxed/simple;
	bh=jF0XxsmuubFxAy4UNgnAiE5vZHGNFHwnV3gPfSAamX0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=a0q4wd+PGaeOsZy67SUQzvnCbD69pHwfCK8wOLfNOUXPLo8XW8ZHGOF4UlfcwXQVZfoZdD6rCNBGCBAcAlw2yV3pJ2EauJCUilC7OM5NTr79MFICDnZzL5QPKeN67eM7YG3meMoVRoZYumbR9+4h+TwJpf2JNxUwqhJMwbhlfJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PCFBvybb; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749743372; x=1781279372;
  h=date:from:to:cc:subject:message-id;
  bh=jF0XxsmuubFxAy4UNgnAiE5vZHGNFHwnV3gPfSAamX0=;
  b=PCFBvybbX3bcnSNmkO6l6o1+vnLOQLQpmRphSHZQIjkvCiES/JxhjvBM
   uJXFFx4Kit3ETBVi46yBEHcZQ2GsWUjBYw0tCdwZ66BjSxPXFuu9Ai3g3
   Hi/ytorx4Jfz6mq1AgUn+xhO8rlSTpHbVwN65j80xQxcuFX9li5qNyXl0
   UvXhnCm/r1QTnuPsKiOtgED3lgM3dgx5SuB4uomsx3CSmNIFynU3gq1EA
   9IXr6iF2gD7RuC6qIVIi2WYIxREVOeEaXJk2KUi8QIv76osEo/oxkl6Xh
   ej+r6oJa1o1fd2PaDGpzGjlXZQTDW+oe6V+zlaltEQnYrt3klBOIwXFfT
   Q==;
X-CSE-ConnectionGUID: Qfkhn8yjRmqa3640sHRFcg==
X-CSE-MsgGUID: JEQGYl4FQSewvULldoMMXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11462"; a="69501044"
X-IronPort-AV: E=Sophos;i="6.16,231,1744095600"; 
   d="scan'208";a="69501044"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 08:49:31 -0700
X-CSE-ConnectionGUID: DdfSpxTYRICrf+7G9b31jA==
X-CSE-MsgGUID: QUyZUbqvRBmWfAjnHznW9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,231,1744095600"; 
   d="scan'208";a="148114436"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 12 Jun 2025 08:49:29 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uPkBD-000BjR-0T;
	Thu, 12 Jun 2025 15:49:27 +0000
Date: Thu, 12 Jun 2025 23:49:19 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: [wireless:for-next] BUILD SUCCESS
 f87586598fffac31afc1141471b789251b030a76
Message-ID: <202506122309.jIq75pRd-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git for-next
branch HEAD: f87586598fffac31afc1141471b789251b030a76  wifi: cfg80211: use kfree_sensitive() for connkeys cleanup

elapsed time: 1452m

configs tested: 254
configs skipped: 14

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-15.1.0
arc                      axs103_smp_defconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20250612    gcc-8.5.0
arc                   randconfig-002-20250612    gcc-10.5.0
arc                   randconfig-002-20250612    gcc-8.5.0
arc                        vdk_hs38_defconfig    clang-21
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-21
arm                               allnoconfig    gcc-15.1.0
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                         assabet_defconfig    clang-21
arm                         bcm2835_defconfig    clang-21
arm                                 defconfig    gcc-15.1.0
arm                         lpc18xx_defconfig    clang-21
arm                            mmp2_defconfig    clang-21
arm                         nhk8815_defconfig    clang-21
arm                   randconfig-001-20250612    clang-21
arm                   randconfig-001-20250612    gcc-8.5.0
arm                   randconfig-002-20250612    clang-18
arm                   randconfig-002-20250612    gcc-8.5.0
arm                   randconfig-003-20250612    clang-21
arm                   randconfig-003-20250612    gcc-8.5.0
arm                   randconfig-004-20250612    clang-21
arm                   randconfig-004-20250612    gcc-8.5.0
arm                         vf610m4_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20250612    clang-19
arm64                 randconfig-001-20250612    gcc-8.5.0
arm64                 randconfig-002-20250612    clang-17
arm64                 randconfig-002-20250612    gcc-8.5.0
arm64                 randconfig-003-20250612    clang-21
arm64                 randconfig-003-20250612    gcc-8.5.0
arm64                 randconfig-004-20250612    clang-18
arm64                 randconfig-004-20250612    gcc-8.5.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20250612    gcc-10.5.0
csky                  randconfig-001-20250612    gcc-11.5.0
csky                  randconfig-002-20250612    gcc-10.5.0
csky                  randconfig-002-20250612    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                           allnoconfig    gcc-15.1.0
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    gcc-15.1.0
hexagon               randconfig-001-20250612    clang-21
hexagon               randconfig-001-20250612    gcc-10.5.0
hexagon               randconfig-002-20250612    clang-21
hexagon               randconfig-002-20250612    gcc-10.5.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250612    clang-20
i386        buildonly-randconfig-002-20250612    clang-20
i386        buildonly-randconfig-002-20250612    gcc-12
i386        buildonly-randconfig-003-20250612    clang-20
i386        buildonly-randconfig-004-20250612    clang-20
i386        buildonly-randconfig-005-20250612    clang-20
i386        buildonly-randconfig-006-20250612    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250612    gcc-12
i386                  randconfig-002-20250612    gcc-12
i386                  randconfig-003-20250612    gcc-12
i386                  randconfig-004-20250612    gcc-12
i386                  randconfig-005-20250612    gcc-12
i386                  randconfig-006-20250612    gcc-12
i386                  randconfig-007-20250612    gcc-12
i386                  randconfig-011-20250612    gcc-12
i386                  randconfig-012-20250612    gcc-12
i386                  randconfig-013-20250612    gcc-12
i386                  randconfig-014-20250612    gcc-12
i386                  randconfig-015-20250612    gcc-12
i386                  randconfig-016-20250612    gcc-12
i386                  randconfig-017-20250612    gcc-12
loongarch                        allmodconfig    gcc-15.1.0
loongarch                         allnoconfig    gcc-15.1.0
loongarch                           defconfig    gcc-15.1.0
loongarch             randconfig-001-20250612    gcc-10.5.0
loongarch             randconfig-001-20250612    gcc-13.3.0
loongarch             randconfig-002-20250612    gcc-10.5.0
loongarch             randconfig-002-20250612    gcc-12.4.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
m68k                        m5307c3_defconfig    gcc-15.1.0
m68k                        mvme147_defconfig    gcc-15.1.0
m68k                        stmark2_defconfig    clang-21
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                           gcw0_defconfig    clang-21
mips                           ip28_defconfig    clang-21
mips                           jazz_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250612    gcc-10.5.0
nios2                 randconfig-001-20250612    gcc-14.2.0
nios2                 randconfig-002-20250612    gcc-10.5.0
nios2                 randconfig-002-20250612    gcc-8.5.0
openrisc                          allnoconfig    clang-21
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-21
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-12
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250612    gcc-10.5.0
parisc                randconfig-001-20250612    gcc-8.5.0
parisc                randconfig-002-20250612    gcc-10.5.0
parisc64                         alldefconfig    gcc-15.1.0
parisc64                            defconfig    gcc-15.1.0
powerpc                     akebono_defconfig    clang-21
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-21
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-21
powerpc                          allyesconfig    gcc-15.1.0
powerpc                 mpc8313_rdb_defconfig    clang-21
powerpc               mpc834x_itxgp_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250612    clang-21
powerpc               randconfig-001-20250612    gcc-10.5.0
powerpc               randconfig-002-20250612    gcc-10.5.0
powerpc               randconfig-002-20250612    gcc-8.5.0
powerpc               randconfig-003-20250612    clang-17
powerpc               randconfig-003-20250612    gcc-10.5.0
powerpc                  storcenter_defconfig    clang-21
powerpc                     taishan_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20250612    gcc-10.5.0
powerpc64             randconfig-001-20250612    gcc-12.4.0
powerpc64             randconfig-002-20250612    clang-21
powerpc64             randconfig-002-20250612    gcc-10.5.0
powerpc64             randconfig-003-20250612    clang-21
powerpc64             randconfig-003-20250612    gcc-10.5.0
riscv                            allmodconfig    clang-21
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    clang-21
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250612    clang-21
riscv                 randconfig-001-20250612    gcc-12.4.0
riscv                 randconfig-002-20250612    clang-21
riscv                 randconfig-002-20250612    gcc-12.4.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-21
s390                                defconfig    gcc-12
s390                  randconfig-001-20250612    clang-21
s390                  randconfig-001-20250612    gcc-12.4.0
s390                  randconfig-002-20250612    gcc-11.5.0
s390                  randconfig-002-20250612    gcc-12.4.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20250612    gcc-12.4.0
sh                    randconfig-002-20250612    gcc-12.4.0
sh                    randconfig-002-20250612    gcc-15.1.0
sh                           se7751_defconfig    gcc-15.1.0
sh                   sh7770_generic_defconfig    clang-21
sh                            titan_defconfig    clang-21
sh                          urquell_defconfig    clang-21
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20250612    gcc-12.4.0
sparc                 randconfig-001-20250612    gcc-14.3.0
sparc                 randconfig-002-20250612    gcc-10.3.0
sparc                 randconfig-002-20250612    gcc-12.4.0
sparc64                             defconfig    gcc-12
sparc64                             defconfig    gcc-15.1.0
sparc64               randconfig-001-20250612    gcc-12.4.0
sparc64               randconfig-001-20250612    gcc-13.3.0
sparc64               randconfig-002-20250612    gcc-12.4.0
sparc64               randconfig-002-20250612    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250612    clang-17
um                    randconfig-001-20250612    gcc-12.4.0
um                    randconfig-002-20250612    clang-21
um                    randconfig-002-20250612    gcc-12.4.0
um                           x86_64_defconfig    clang-21
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250612    clang-20
x86_64      buildonly-randconfig-001-20250612    gcc-12
x86_64      buildonly-randconfig-002-20250612    clang-20
x86_64      buildonly-randconfig-003-20250612    clang-20
x86_64      buildonly-randconfig-003-20250612    gcc-12
x86_64      buildonly-randconfig-004-20250612    clang-20
x86_64      buildonly-randconfig-004-20250612    gcc-12
x86_64      buildonly-randconfig-005-20250612    clang-20
x86_64      buildonly-randconfig-006-20250612    clang-20
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250612    clang-20
x86_64                randconfig-002-20250612    clang-20
x86_64                randconfig-003-20250612    clang-20
x86_64                randconfig-004-20250612    clang-20
x86_64                randconfig-005-20250612    clang-20
x86_64                randconfig-006-20250612    clang-20
x86_64                randconfig-007-20250612    clang-20
x86_64                randconfig-008-20250612    clang-20
x86_64                randconfig-071-20250612    gcc-12
x86_64                randconfig-072-20250612    gcc-12
x86_64                randconfig-073-20250612    gcc-12
x86_64                randconfig-074-20250612    gcc-12
x86_64                randconfig-075-20250612    gcc-12
x86_64                randconfig-076-20250612    gcc-12
x86_64                randconfig-077-20250612    gcc-12
x86_64                randconfig-078-20250612    gcc-12
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-18
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250612    gcc-10.5.0
xtensa                randconfig-001-20250612    gcc-12.4.0
xtensa                randconfig-002-20250612    gcc-12.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

