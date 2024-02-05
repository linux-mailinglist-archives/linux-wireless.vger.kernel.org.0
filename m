Return-Path: <linux-wireless+bounces-3126-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 266908497F0
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Feb 2024 11:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 831DCB28342
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Feb 2024 10:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429A417575;
	Mon,  5 Feb 2024 10:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dIQp31PU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444C018C28
	for <linux-wireless@vger.kernel.org>; Mon,  5 Feb 2024 10:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707129687; cv=none; b=keQCdM+gJM/3SYCVv0ABepwKJXDuiWSsvpK8h12l/f3+k+aaA/MvJEOZRsYrr3YH2eVQNVvC2zPbh6a6dpxOYWIqIEDMyZ1cODcu4F2Y9hyDboQ89tASAn02v3CCE4U42fKvsDCVwrTqjWpXztS2HF7+i9pOp/6psLHwzcG08fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707129687; c=relaxed/simple;
	bh=fnHk5HesSwZ3WU8kqzFEB962e+2upPMhuBcyWAtYOPk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=VIUmvH0KGlID7CHiIb/jQhzz5vFjc4ODs34wLekL8QSwCB4F8OTmGCmER5fcXheMuM52kh4q0s6PaxEjd6eaTOEVyesjJSw8HK4EYVf38AmLFkdQykUMOYmnaHv4xKMfx6KE/kYsbOJ8Exi6z4ZjhI/g4MpavwtMVeArKkE73QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dIQp31PU; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707129685; x=1738665685;
  h=date:from:to:cc:subject:message-id;
  bh=fnHk5HesSwZ3WU8kqzFEB962e+2upPMhuBcyWAtYOPk=;
  b=dIQp31PUrqpTVWcv4G86oazqV4SI+ZOn/87NHqX+GPp13HhTbqSj9xWV
   ATo+HSBDhLkR6/2QAnIBQAjPH3r2FW24Tb0KIOO36KFcray6Vm+8tFHZ/
   LdIbw7oOO7esibvhykCSxbbW2tZ6YtJpTHoywDtLlKsID4eZ1Yazu7uNo
   kwrz9O0R6wlJtd29okVGhNXxR1DiXPAzSPfECzi05+GDUOGdzYaikwPbY
   AtnWNTYIBP2S/imtjQsGUQ55H07Lenhr0PPzY7FjD6PxzXUUmNbDy61nx
   ALoXezw0Ns9m92kDNFKPbwrRLijd8A7xL6031OYV+TlGe+Ev7Ij3buOAo
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="4309790"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="4309790"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 02:41:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="688645"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 05 Feb 2024 02:41:23 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rWwPg-0000OO-2J;
	Mon, 05 Feb 2024 10:41:20 +0000
Date: Mon, 05 Feb 2024 18:40:23 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 679dd27b4ef33d4f596cbf450a3b2742fc54962a
Message-ID: <202402051819.1IRL0asv-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 679dd27b4ef33d4f596cbf450a3b2742fc54962a  wifi: cfg80211: fix kunit exports

elapsed time: 1450m

configs tested: 204
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
arc                      axs103_smp_defconfig   gcc  
arc                                 defconfig   gcc  
arc                        nsimosci_defconfig   gcc  
arc                   randconfig-001-20240204   gcc  
arc                   randconfig-002-20240204   gcc  
arc                           tb10x_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                           imxrt_defconfig   clang
arm                      integrator_defconfig   clang
arm                            mmp2_defconfig   gcc  
arm                          moxart_defconfig   gcc  
arm                       netwinder_defconfig   gcc  
arm                          pxa3xx_defconfig   clang
arm                   randconfig-001-20240204   gcc  
arm                   randconfig-002-20240204   clang
arm                   randconfig-003-20240204   clang
arm                   randconfig-004-20240204   gcc  
arm                             rpc_defconfig   clang
arm                         s5pv210_defconfig   gcc  
arm                         socfpga_defconfig   gcc  
arm                          sp7021_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240204   gcc  
arm64                 randconfig-002-20240204   clang
arm64                 randconfig-003-20240204   gcc  
arm64                 randconfig-004-20240204   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240204   gcc  
csky                  randconfig-002-20240204   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240204   clang
hexagon               randconfig-002-20240204   clang
i386                             alldefconfig   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240204   gcc  
i386         buildonly-randconfig-002-20240204   gcc  
i386         buildonly-randconfig-003-20240204   gcc  
i386         buildonly-randconfig-004-20240204   gcc  
i386         buildonly-randconfig-005-20240204   gcc  
i386         buildonly-randconfig-006-20240204   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240204   clang
i386                  randconfig-002-20240204   clang
i386                  randconfig-003-20240204   clang
i386                  randconfig-004-20240204   gcc  
i386                  randconfig-005-20240204   clang
i386                  randconfig-006-20240204   gcc  
i386                  randconfig-011-20240204   clang
i386                  randconfig-012-20240204   gcc  
i386                  randconfig-013-20240204   clang
i386                  randconfig-014-20240204   clang
i386                  randconfig-015-20240204   clang
i386                  randconfig-016-20240204   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240204   gcc  
loongarch             randconfig-002-20240204   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        m5272c3_defconfig   gcc  
m68k                       m5275evb_defconfig   gcc  
m68k                          multi_defconfig   gcc  
m68k                        stmark2_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                       bmips_be_defconfig   gcc  
mips                     cu1000-neo_defconfig   gcc  
mips                       lemote2f_defconfig   gcc  
mips                      loongson3_defconfig   gcc  
mips                        qi_lb60_defconfig   clang
nios2                         10m50_defconfig   gcc  
nios2                         3c120_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240204   gcc  
nios2                 randconfig-002-20240204   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240204   gcc  
parisc                randconfig-002-20240204   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                        fsp2_defconfig   gcc  
powerpc                   microwatt_defconfig   gcc  
powerpc                 mpc834x_itx_defconfig   clang
powerpc               mpc834x_itxgp_defconfig   clang
powerpc                     ppa8548_defconfig   gcc  
powerpc                      ppc64e_defconfig   gcc  
powerpc                         ps3_defconfig   gcc  
powerpc               randconfig-001-20240204   gcc  
powerpc               randconfig-002-20240204   gcc  
powerpc               randconfig-003-20240204   gcc  
powerpc                     redwood_defconfig   clang
powerpc64             randconfig-001-20240204   gcc  
powerpc64             randconfig-002-20240204   clang
powerpc64             randconfig-003-20240204   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240204   clang
riscv                 randconfig-002-20240204   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240204   clang
s390                  randconfig-002-20240204   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                        dreamcast_defconfig   gcc  
sh                        edosk7705_defconfig   gcc  
sh                            migor_defconfig   gcc  
sh                          polaris_defconfig   gcc  
sh                    randconfig-001-20240204   gcc  
sh                    randconfig-002-20240204   gcc  
sh                           se7619_defconfig   gcc  
sh                     sh7710voipgw_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240204   gcc  
sparc64               randconfig-002-20240204   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                    randconfig-001-20240204   gcc  
um                    randconfig-002-20240204   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240204   clang
x86_64       buildonly-randconfig-002-20240204   clang
x86_64       buildonly-randconfig-003-20240204   gcc  
x86_64       buildonly-randconfig-004-20240204   gcc  
x86_64       buildonly-randconfig-005-20240204   clang
x86_64       buildonly-randconfig-006-20240204   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240204   gcc  
x86_64                randconfig-002-20240204   gcc  
x86_64                randconfig-003-20240204   clang
x86_64                randconfig-004-20240204   clang
x86_64                randconfig-005-20240204   gcc  
x86_64                randconfig-006-20240204   gcc  
x86_64                randconfig-011-20240204   gcc  
x86_64                randconfig-012-20240204   gcc  
x86_64                randconfig-013-20240204   gcc  
x86_64                randconfig-014-20240204   gcc  
x86_64                randconfig-015-20240204   clang
x86_64                randconfig-016-20240204   clang
x86_64                randconfig-071-20240204   gcc  
x86_64                randconfig-072-20240204   gcc  
x86_64                randconfig-073-20240204   gcc  
x86_64                randconfig-074-20240204   clang
x86_64                randconfig-075-20240204   clang
x86_64                randconfig-076-20240204   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                  nommu_kc705_defconfig   gcc  
xtensa                randconfig-001-20240204   gcc  
xtensa                randconfig-002-20240204   gcc  
xtensa                    smp_lx200_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

