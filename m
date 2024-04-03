Return-Path: <linux-wireless+bounces-5790-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9705896617
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Apr 2024 09:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33A221F275EC
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Apr 2024 07:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ABA55B20F;
	Wed,  3 Apr 2024 07:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lUeBQXEc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926174D133
	for <linux-wireless@vger.kernel.org>; Wed,  3 Apr 2024 07:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712128885; cv=none; b=qQOe0Af9cETNTJuxR1y0iZRSPacJBeIPloktauT1koIcENP+gkXvGeTkNBSSq4QSsThY1sQeU7KZCytJGowgY4vo7RLWR3hQBgBXS1WGTeYVEqUBsKflZ9Wj6TWgpUBjTNiYlKK2/N6W9+VNzORxc6W6yQgFV5yzCrgBYpGRnUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712128885; c=relaxed/simple;
	bh=ghx3jBwq2BVVRIGqVMblvr5594CqaEH821rnxpbPMYM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=PkfJ+8GKJ8oc19PPrHYMW7fz7sryk2W8CEs5zxU/LUeAZHj1we/N4UbQhyifIUJi6vzDTykg7opQQ2Y7dv7nUF/zhp5hD+ixXBKA6PZ5jeoaP/jeWbjVp96XYSPjaZ3BaIcKpfefjlm4rPyUs6ZuoIp+gr63tqHf7SqM8C50dxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lUeBQXEc; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712128883; x=1743664883;
  h=date:from:to:cc:subject:message-id;
  bh=ghx3jBwq2BVVRIGqVMblvr5594CqaEH821rnxpbPMYM=;
  b=lUeBQXEc+qK2bQhDLXDxMRUoTGt0gq6zmSzAde0KPP9AkH0Ila/n7PtQ
   Z3Gi9ovKsFS6t9WztBwIVUi8aA1Mf3oDHq5Q1cQTIsnhNdYo9dfQJuTxQ
   UjusFoLfErLGyR7X9fYIqTLSHhTiKH2n8mYAiMsp/OEvcihzeDerh/f3u
   nVtLcS5+fDdKfB1cIXnqP9rLBu5qRqTlhEeFjK53+6jDfaZU/Q1u9cJo7
   OQnwHr0HK+CrF7vwpxBndawtSn62DZy1KsSSWQ+zJMKfH0kBcDCdFSYmS
   llb8KymOlQPMjtaT17UnD+UTbbBKjoUgAsJHIW0Nnjix4b2Z1rgvurmmd
   g==;
X-CSE-ConnectionGUID: APPp2JjwTcGR/1qLoK5WVw==
X-CSE-MsgGUID: h4F2/q9cQ/CzQVaV/iFIuQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="7240078"
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="7240078"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 00:21:21 -0700
X-CSE-ConnectionGUID: VfN/qCnvQmmIp/VL186h9w==
X-CSE-MsgGUID: aHMkuV14QvKMMEZofKdyHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="18443350"
Received: from lkp-server02.sh.intel.com (HELO 90ee3aa53dbd) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 03 Apr 2024 00:21:19 -0700
Received: from kbuild by 90ee3aa53dbd with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rruvj-0001yd-1Z;
	Wed, 03 Apr 2024 07:21:09 +0000
Date: Wed, 03 Apr 2024 15:20:13 +0800
From: kernel test robot <lkp@intel.com>
To: Kalle Valo <kvalo@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 0ccf50df61f98a9f98d46524be4baa00c88c499d
Message-ID: <202404031510.zOTSPY7C-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 0ccf50df61f98a9f98d46524be4baa00c88c499d  Merge tag 'ath-next-20240402' of git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath

elapsed time: 741m

configs tested: 112
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
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   clang
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-002-20240403   clang
i386         buildonly-randconfig-003-20240403   clang
i386         buildonly-randconfig-004-20240403   clang
i386         buildonly-randconfig-006-20240403   clang
i386                                defconfig   clang
i386                  randconfig-002-20240403   clang
i386                  randconfig-005-20240403   clang
i386                  randconfig-012-20240403   clang
i386                  randconfig-014-20240403   clang
i386                  randconfig-016-20240403   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
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
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
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
x86_64       buildonly-randconfig-001-20240403   gcc  
x86_64       buildonly-randconfig-002-20240403   gcc  
x86_64       buildonly-randconfig-004-20240403   gcc  
x86_64       buildonly-randconfig-006-20240403   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240403   gcc  
x86_64                randconfig-003-20240403   gcc  
x86_64                randconfig-004-20240403   gcc  
x86_64                randconfig-005-20240403   gcc  
x86_64                randconfig-011-20240403   gcc  
x86_64                randconfig-012-20240403   gcc  
x86_64                randconfig-013-20240403   gcc  
x86_64                randconfig-014-20240403   gcc  
x86_64                randconfig-015-20240403   gcc  
x86_64                randconfig-016-20240403   gcc  
x86_64                randconfig-072-20240403   gcc  
x86_64                randconfig-074-20240403   gcc  
x86_64                randconfig-075-20240403   gcc  
x86_64                randconfig-076-20240403   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

