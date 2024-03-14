Return-Path: <linux-wireless+bounces-4775-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A558C87C4B7
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Mar 2024 22:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00462B22AD5
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Mar 2024 21:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E54B768FE;
	Thu, 14 Mar 2024 21:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nF/plaJa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AA57641F
	for <linux-wireless@vger.kernel.org>; Thu, 14 Mar 2024 21:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710451309; cv=none; b=GmjuMPG2meu33GkpYlYsAaqIXcIh4hNqO93NZLnUSHQAJHVfFsaSrLOI6zaUD97G8l1nbBUZpYzj2+NUZMGIV0CGvHncK/B6lVqjn9sZQESKuRhI9iFlXICvh+UkOIN4FwNUw+eqqGhRYnE9NPmurta5yyg30dGxA9ktk/Lh/8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710451309; c=relaxed/simple;
	bh=SuqZJCbRjFyhmJAtfGhwg4lJCOBA4b3+ZTarEZyxbfc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=uvNlwKWCw17ScORuonA0uEgt6o1ECsT/qj5qy4iXRvVmYF5R00CxJJuLJJ7aoVojl1Dhm2lImoxWJhGDaChd4GKtD61t7/kyMKr4WSHtvj+mAFzo7knFNzYPexf0ezk24LUSdhW2nO/aRB3eh/00z2AWAjkAEvRD2PwYwa/gkYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nF/plaJa; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710451307; x=1741987307;
  h=date:from:to:cc:subject:message-id;
  bh=SuqZJCbRjFyhmJAtfGhwg4lJCOBA4b3+ZTarEZyxbfc=;
  b=nF/plaJal57j9E8i55hQRGBU2IaIGj3srMNPNiGipq1MR48Lj0wFwNna
   sWeUCyr3tZEQub3yonNLjKMDHUc3uQtAFCh4HoCozHSZekwjyQz/HH/KZ
   KeHusBCaMsxUwprpCcUW4vJPDZfSadsNwnuNQ8B+v9SlR9R1ehUeRlOPj
   M1yYJcjcZRMWYACP7Ihnbc/M6c9u/TPyxJwonrNYZh2tnBfSaeHKQkT3q
   OxWQ75gPGeJGh6BUWBCfdhodAetSY1qR93T6S9v2VPcy6f2MsDTb6Onkh
   YyAclv929F9B7YaXnR7l6GBV/m1jMcUU76tpT4PxRxOv+HhgndN0QsypA
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="5157817"
X-IronPort-AV: E=Sophos;i="6.07,126,1708416000"; 
   d="scan'208";a="5157817"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 14:21:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,126,1708416000"; 
   d="scan'208";a="12515297"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 14 Mar 2024 14:21:45 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rksWE-000Dnr-1o;
	Thu, 14 Mar 2024 21:21:42 +0000
Date: Fri, 15 Mar 2024 05:21:13 +0800
From: kernel test robot <lkp@intel.com>
To: Kalle Valo <kvalo@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 64be03575f9e9772ebdebc7f067d533348602083
Message-ID: <202403150508.QTJvg1QC-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 64be03575f9e9772ebdebc7f067d533348602083  wifi: rtw88: SDIO device driver for RTL8723CS

elapsed time: 728m

configs tested: 155
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                        nsim_700_defconfig   gcc  
arc                   randconfig-001-20240314   gcc  
arc                   randconfig-002-20240314   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                          ixp4xx_defconfig   gcc  
arm                        neponset_defconfig   gcc  
arm                   randconfig-001-20240314   gcc  
arm                   randconfig-002-20240314   gcc  
arm                   randconfig-003-20240314   clang
arm                   randconfig-004-20240314   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240314   gcc  
arm64                 randconfig-002-20240314   gcc  
arm64                 randconfig-003-20240314   clang
arm64                 randconfig-004-20240314   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240314   gcc  
csky                  randconfig-002-20240314   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240314   clang
hexagon               randconfig-002-20240314   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240314   clang
i386         buildonly-randconfig-001-20240315   clang
i386         buildonly-randconfig-002-20240314   clang
i386         buildonly-randconfig-002-20240315   clang
i386         buildonly-randconfig-003-20240314   gcc  
i386         buildonly-randconfig-004-20240314   gcc  
i386         buildonly-randconfig-004-20240315   clang
i386         buildonly-randconfig-005-20240314   gcc  
i386         buildonly-randconfig-006-20240314   clang
i386                                defconfig   clang
i386                  randconfig-001-20240314   gcc  
i386                  randconfig-002-20240314   clang
i386                  randconfig-002-20240315   clang
i386                  randconfig-003-20240314   gcc  
i386                  randconfig-003-20240315   clang
i386                  randconfig-004-20240314   clang
i386                  randconfig-004-20240315   clang
i386                  randconfig-005-20240314   gcc  
i386                  randconfig-006-20240314   gcc  
i386                  randconfig-006-20240315   clang
i386                  randconfig-011-20240314   clang
i386                  randconfig-011-20240315   clang
i386                  randconfig-012-20240314   gcc  
i386                  randconfig-013-20240314   clang
i386                  randconfig-014-20240314   gcc  
i386                  randconfig-014-20240315   clang
i386                  randconfig-015-20240314   clang
i386                  randconfig-016-20240314   clang
i386                  randconfig-016-20240315   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240314   gcc  
loongarch             randconfig-002-20240314   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                           ip28_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240314   gcc  
nios2                 randconfig-002-20240314   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                  or1klitex_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240314   gcc  
parisc                randconfig-002-20240314   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                    amigaone_defconfig   gcc  
powerpc                        fsp2_defconfig   gcc  
powerpc               randconfig-001-20240314   gcc  
powerpc               randconfig-002-20240314   gcc  
powerpc               randconfig-003-20240314   clang
powerpc64             randconfig-001-20240314   gcc  
powerpc64             randconfig-002-20240314   clang
powerpc64             randconfig-003-20240314   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240314   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                              ul2_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240315   gcc  
x86_64       buildonly-randconfig-002-20240315   gcc  
x86_64       buildonly-randconfig-003-20240315   gcc  
x86_64       buildonly-randconfig-004-20240315   gcc  
x86_64       buildonly-randconfig-005-20240315   clang
x86_64       buildonly-randconfig-006-20240315   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240315   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                  cadence_csp_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

