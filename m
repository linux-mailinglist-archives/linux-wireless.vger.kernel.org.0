Return-Path: <linux-wireless+bounces-1991-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CBA982F442
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jan 2024 19:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB3F61F24A1F
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jan 2024 18:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372F61D52A;
	Tue, 16 Jan 2024 18:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CDkCS1EA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836341CFB6
	for <linux-wireless@vger.kernel.org>; Tue, 16 Jan 2024 18:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705429767; cv=none; b=kMWIq/dEmCMiT/m9hkSAGmHtArLmcrq7Ntcwy3YyMYlOgCDoW87G6HLkby673AZj4ruVGjNHtXoHD1PUTt6q81lsPsb9HviZdVBy82yrHQJBJWN7+D7oOCPFaXiMTOz6z3xP3wzdr2PnRj45VvUyQP3ZPRMKpIKueqvn7FezrsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705429767; c=relaxed/simple;
	bh=t4P3/ieqK/MQ/GDUsqlL6golU2f0TNURyu9gAo9iJrs=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:X-IronPort-AV:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:User-Agent; b=kSEaGz6JgnyZcfWV4A5hNdhb6TUz6uq9pU593o+K9mTiAyhbdKiOJt1z6uqngioZO/JtMDQZ1RkLMljybDQEJytgiyQzVdeSYWRWwPrX7SY115sbh7KUBve0inwrW2shOUPkFuf7cWfA+4OvJc6xxgrz+AO3HZSKlxxenE/vOmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CDkCS1EA; arc=none smtp.client-ip=192.198.163.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705429766; x=1736965766;
  h=date:from:to:cc:subject:message-id;
  bh=t4P3/ieqK/MQ/GDUsqlL6golU2f0TNURyu9gAo9iJrs=;
  b=CDkCS1EA+qo5jIxwuzyOLF1VNSVJi/UWurbzzsm+RaLHslGbTZgkgSws
   9dNmu0Lm6FEPrs0cz4HdOLsqeli51RIH+oO3jsR8vJV8BKKvIRvo77imQ
   khpa84d0S4MXu2wHTYp67Kcm6Q5nS57VWo1xUDAczIkVtKaf850hP0+Cq
   RVzE9mkQArxBZoFVqMevxAaul9gy6Ga4apvmrFas6/aqwhwOIYvdZn8/f
   k3fMbd/bVzDv1e18xfrUZMkYCoSSbOBDfX8Qz5xSbFxs0Kfg4lsjrIGgq
   6KQ4tTPIpwvto5i+zYKgrGPR5ef4v1BbD29/JanKz22jeymsWf1Cn+qWg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="13446710"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="13446710"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 10:29:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="818257702"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="818257702"
Received: from lkp-server01.sh.intel.com (HELO 961aaaa5b03c) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 16 Jan 2024 10:29:24 -0800
Received: from kbuild by 961aaaa5b03c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rPoBd-00014b-2X;
	Tue, 16 Jan 2024 18:29:21 +0000
Date: Wed, 17 Jan 2024 02:29:09 +0800
From: kernel test robot <lkp@intel.com>
To: Kalle Valo <kvalo@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 ece90a8622320bf5a24d3326da1f8e109891573c
Message-ID: <202401170207.u9RUlJLP-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: ece90a8622320bf5a24d3326da1f8e109891573c  wifi: rtl8xxxu: enable channel switch support

elapsed time: 2771m

configs tested: 89
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240117   gcc  
arc                   randconfig-002-20240117   gcc  
arm                               allnoconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240117   gcc  
arm                   randconfig-002-20240117   gcc  
arm                   randconfig-003-20240117   gcc  
arm                   randconfig-004-20240117   gcc  
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240117   gcc  
arm64                 randconfig-002-20240117   gcc  
arm64                 randconfig-003-20240117   gcc  
arm64                 randconfig-004-20240117   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240117   gcc  
csky                  randconfig-002-20240117   gcc  
hexagon                           allnoconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240117   clang
hexagon               randconfig-002-20240117   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20240115   gcc  
i386         buildonly-randconfig-002-20240115   gcc  
i386         buildonly-randconfig-003-20240115   gcc  
i386         buildonly-randconfig-004-20240115   gcc  
i386         buildonly-randconfig-005-20240115   gcc  
i386         buildonly-randconfig-006-20240115   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20240115   gcc  
i386                  randconfig-002-20240115   gcc  
i386                  randconfig-003-20240115   gcc  
i386                  randconfig-004-20240115   gcc  
i386                  randconfig-005-20240115   gcc  
i386                  randconfig-006-20240115   gcc  
i386                  randconfig-011-20240115   clang
i386                  randconfig-012-20240115   clang
i386                  randconfig-013-20240115   clang
i386                  randconfig-014-20240115   clang
i386                  randconfig-015-20240115   clang
i386                  randconfig-016-20240115   clang
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240117   gcc  
loongarch             randconfig-002-20240117   gcc  
m68k                              allnoconfig   gcc  
m68k                                defconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   clang
nios2                 randconfig-001-20240117   gcc  
nios2                 randconfig-002-20240117   gcc  
openrisc                         allyesconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                randconfig-001-20240117   gcc  
parisc                randconfig-002-20240117   gcc  
powerpc                          allmodconfig   clang
powerpc                          allyesconfig   clang
powerpc               randconfig-001-20240117   gcc  
powerpc               randconfig-002-20240117   gcc  
powerpc               randconfig-003-20240117   gcc  
powerpc64             randconfig-001-20240117   gcc  
powerpc64             randconfig-002-20240117   gcc  
powerpc64             randconfig-003-20240117   gcc  
riscv                 randconfig-001-20240117   gcc  
riscv                 randconfig-002-20240117   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                  randconfig-001-20240117   clang
s390                  randconfig-002-20240117   clang
sh                               allmodconfig   gcc  
sh                               allyesconfig   gcc  
sparc                            allmodconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
um                               allmodconfig   clang
um                               allyesconfig   clang
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

