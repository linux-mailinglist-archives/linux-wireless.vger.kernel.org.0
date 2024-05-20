Return-Path: <linux-wireless+bounces-7848-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ACA18CA13C
	for <lists+linux-wireless@lfdr.de>; Mon, 20 May 2024 19:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 776721C20EA8
	for <lists+linux-wireless@lfdr.de>; Mon, 20 May 2024 17:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D729753E13;
	Mon, 20 May 2024 17:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mqhSv7ub"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B70711184
	for <linux-wireless@vger.kernel.org>; Mon, 20 May 2024 17:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716225826; cv=none; b=TzHBaofwucn0QvDX03XUL+kudh+Qv7wMPTLXUcWatqdk1hu4dGX9VTI05XqoejwU+dWFZuiuWGVoFvBig13oXwmenfJZk4/SEj42Es/56E9ismguwlwe4aOg6aNJO38vQD9lAb0jf8etQsigPY5xdpZr1UXsBlWu9t0WTgZEJOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716225826; c=relaxed/simple;
	bh=ZewBcP35uHqL3Mchnci1l0hBRPgyEz+RCSMC1htigqg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=NYFYtGiF1WXyhhG5CxFn5qotzcUlw4tijZy4rxdFTzbRIfYZ4KboeT+rlJUlcrtAOTj2PsEpUx/XZj0cZDvbVGNA6juncWkEncI/kzYqKSm99k+Qaaci89xfVSCWvqdXfHITdkW6r2XHD02sqbIGgpUjjnFSZg9HwmKPs4ykCKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mqhSv7ub; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716225824; x=1747761824;
  h=date:from:to:cc:subject:message-id;
  bh=ZewBcP35uHqL3Mchnci1l0hBRPgyEz+RCSMC1htigqg=;
  b=mqhSv7ubxI6iWO7RTBrhIBc4Z920perKCfCQIORHB0lDlB5OUIwHM69M
   0Z9NhTRDX261E0hYq2ZhnhvQge/HdWSiCsMYVKpcKWEG3L/4lUMtGUCyT
   FfVkDKY+wjU4jdNrDj+iKZ3xZhyg0EC1eN4upFwb7hPvqi+x3m+QVexvO
   XSsHIa7qUPP2oVMzIHD3VF5Kk6+pIrfULektJYQ++zouypHlakbWSMrcQ
   UZiBkv7RBQykas7mk+K2bIEGIs16KR/JllXfG0FfOSMgW6Np46Hi/s16b
   ZfRJmwsi0lwTy1MuYplSM6ES1xIoFp2FBWCFChSv7841hI4hkT5gF7eGx
   w==;
X-CSE-ConnectionGUID: p0L8SpjoSCOOAAq3Obu4eg==
X-CSE-MsgGUID: HW3JlWQMT1iSzVizxRr5MA==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="12166876"
X-IronPort-AV: E=Sophos;i="6.08,175,1712646000"; 
   d="scan'208";a="12166876"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 10:23:43 -0700
X-CSE-ConnectionGUID: QEsoyrwhQPWF5UzFr35QKA==
X-CSE-MsgGUID: 0DQFphA0SOy0zMtPwCMPSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,175,1712646000"; 
   d="scan'208";a="36997076"
Received: from unknown (HELO 108735ec233b) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 20 May 2024 10:23:42 -0700
Received: from kbuild by 108735ec233b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s96jc-00050W-0J;
	Mon, 20 May 2024 17:23:40 +0000
Date: Tue, 21 May 2024 01:23:08 +0800
From: kernel test robot <lkp@intel.com>
To: Kalle Valo <kvalo@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 2785ea9673a7305abeea87111849a4e04b0f4626
Message-ID: <202405210105.nHsFQreY-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 2785ea9673a7305abeea87111849a4e04b0f4626  wifi: rt2x00: remove unused delayed work data from link description

elapsed time: 723m

configs tested: 177
configs skipped: 3

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
arc                   randconfig-001-20240520   gcc  
arc                   randconfig-002-20240520   gcc  
arc                    vdk_hs38_smp_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                         at91_dt_defconfig   clang
arm                                 defconfig   clang
arm                          ixp4xx_defconfig   gcc  
arm                            qcom_defconfig   clang
arm                   randconfig-001-20240520   clang
arm                   randconfig-002-20240520   clang
arm                   randconfig-003-20240520   gcc  
arm                   randconfig-004-20240520   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240520   clang
arm64                 randconfig-002-20240520   clang
arm64                 randconfig-003-20240520   clang
arm64                 randconfig-004-20240520   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240520   gcc  
csky                  randconfig-002-20240520   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240520   clang
hexagon               randconfig-002-20240520   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240520   clang
i386         buildonly-randconfig-002-20240520   clang
i386         buildonly-randconfig-003-20240520   clang
i386         buildonly-randconfig-004-20240520   clang
i386         buildonly-randconfig-005-20240520   clang
i386         buildonly-randconfig-006-20240520   clang
i386                                defconfig   clang
i386                  randconfig-001-20240520   clang
i386                  randconfig-002-20240520   clang
i386                  randconfig-003-20240520   gcc  
i386                  randconfig-004-20240520   gcc  
i386                  randconfig-005-20240520   clang
i386                  randconfig-006-20240520   gcc  
i386                  randconfig-011-20240520   gcc  
i386                  randconfig-012-20240520   gcc  
i386                  randconfig-013-20240520   clang
i386                  randconfig-014-20240520   gcc  
i386                  randconfig-015-20240520   clang
i386                  randconfig-016-20240520   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240520   gcc  
loongarch             randconfig-002-20240520   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5208evb_defconfig   gcc  
m68k                          multi_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                           ip22_defconfig   gcc  
mips                      maltaaprp_defconfig   clang
mips                       rbtx49xx_defconfig   gcc  
nios2                            alldefconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240520   gcc  
nios2                 randconfig-002-20240520   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-32bit_defconfig   gcc  
parisc                randconfig-001-20240520   gcc  
parisc                randconfig-002-20240520   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                      ppc6xx_defconfig   gcc  
powerpc               randconfig-001-20240520   gcc  
powerpc               randconfig-002-20240520   clang
powerpc               randconfig-003-20240520   clang
powerpc                        warp_defconfig   gcc  
powerpc64             randconfig-001-20240520   clang
powerpc64             randconfig-002-20240520   gcc  
powerpc64             randconfig-003-20240520   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240520   gcc  
riscv                 randconfig-002-20240520   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240520   gcc  
s390                  randconfig-002-20240520   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240520   gcc  
sh                    randconfig-002-20240520   gcc  
sh                           se7721_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240520   gcc  
sparc64               randconfig-002-20240520   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240520   clang
um                    randconfig-002-20240520   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240520   clang
x86_64       buildonly-randconfig-002-20240520   gcc  
x86_64       buildonly-randconfig-003-20240520   gcc  
x86_64       buildonly-randconfig-004-20240520   gcc  
x86_64       buildonly-randconfig-005-20240520   gcc  
x86_64       buildonly-randconfig-006-20240520   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240520   clang
x86_64                randconfig-002-20240520   gcc  
x86_64                randconfig-003-20240520   gcc  
x86_64                randconfig-004-20240520   gcc  
x86_64                randconfig-005-20240520   gcc  
x86_64                randconfig-006-20240520   clang
x86_64                randconfig-011-20240520   clang
x86_64                randconfig-012-20240520   gcc  
x86_64                randconfig-013-20240520   clang
x86_64                randconfig-014-20240520   clang
x86_64                randconfig-015-20240520   gcc  
x86_64                randconfig-016-20240520   gcc  
x86_64                randconfig-071-20240520   clang
x86_64                randconfig-072-20240520   gcc  
x86_64                randconfig-073-20240520   clang
x86_64                randconfig-074-20240520   gcc  
x86_64                randconfig-075-20240520   clang
x86_64                randconfig-076-20240520   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240520   gcc  
xtensa                randconfig-002-20240520   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

