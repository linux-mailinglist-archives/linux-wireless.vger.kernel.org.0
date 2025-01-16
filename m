Return-Path: <linux-wireless+bounces-17608-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92579A14060
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jan 2025 18:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 132413A1B25
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jan 2025 17:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CAF37081E;
	Thu, 16 Jan 2025 17:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gp5pA1Rc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511BA22A7F9
	for <linux-wireless@vger.kernel.org>; Thu, 16 Jan 2025 17:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737047436; cv=none; b=NwDVv6LeBO5EEgF4jEHyC8DqDM/u/SY2d+9vGo+gJ6yUuNr2TWdH7yBulCMqd0oUKRyQBqOMapnfga5HXrb6OR+d5b8V+ViTwP/GjAv7XUQYTqbNrTMKkuvnMgb1ROAeBHuvii54xwIKnEDwPbYf9BF7/sBQTyRg3VkzvMcSQHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737047436; c=relaxed/simple;
	bh=nZTEmW58afZduP/Bl1OC9BmItgtyvqBM9sinM2bOTQU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=b7uhwIseZNANAAlHoOX5BjB7FAyvl5c5VY9FCMfhf6oDPt/6TUTbhDu8ii1lvsdNWbXW22bn+x8MxtJ1JcySGvWa0LsoxCEbV01aXX6IOCr1T316Zkz/aZ1SiSI9mxc7v7AeSyFJghqxbq6jwWX6/sRA+pyIX1iQOoMGXtWuEAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gp5pA1Rc; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737047435; x=1768583435;
  h=date:from:to:cc:subject:message-id;
  bh=nZTEmW58afZduP/Bl1OC9BmItgtyvqBM9sinM2bOTQU=;
  b=gp5pA1Rc63yZfGvYlNmsLI21LvH5+uMbrPCkzzWT3utPkZ6JROHBpA7U
   nD2ovOeoi8A2Y33FODEm/8HS8E6fxeUnO0HwLUkFn47FJSCaRNV0k9Bxp
   mWFqZfKtZuX6xm5kgGotrjPybbtWonqIjB8/+DPbczvqSF3BOjirclqxz
   1aDT+unLvXcwm/0TyTH+bhfv0gZvvGZRgl3BK+dpnc/6FnfPS5BYiqwsR
   BIvKd9GKxMkufzol2CktrqNT++qH5Uq/XIkaMaSjl66164sjKEtGoiRJz
   Q+bMqv1YYCk81pDsPzGTWT9HhbPkstukqMwfgYgglPcwNyxTphEDamGnt
   g==;
X-CSE-ConnectionGUID: fUHtnP3HTjysERzD4tpPqw==
X-CSE-MsgGUID: wXBrARnZQR2AoOiqByhQrQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11317"; a="41385469"
X-IronPort-AV: E=Sophos;i="6.13,210,1732608000"; 
   d="scan'208";a="41385469"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 09:10:34 -0800
X-CSE-ConnectionGUID: 0bDqPdDZQaqB/v0r9vKgig==
X-CSE-MsgGUID: SIu0CM1VRDWrk8x708OqXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,210,1732608000"; 
   d="scan'208";a="110554170"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 16 Jan 2025 09:10:32 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tYTO1-000SC1-2C;
	Thu, 16 Jan 2025 17:10:29 +0000
Date: Fri, 17 Jan 2025 01:09:47 +0800
From: kernel test robot <lkp@intel.com>
To: Kalle Valo <kvalo@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 89d62bcd250125fefe48fc26490ae10a5698fb9a
Message-ID: <202501170141.n6wIbNpG-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 89d62bcd250125fefe48fc26490ae10a5698fb9a  Merge tag 'ath-next-20250114' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath

elapsed time: 1451m

configs tested: 88
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-14.2.0
alpha                           allyesconfig    gcc-14.2.0
arc                             allmodconfig    gcc-13.2.0
arc                              allnoconfig    gcc-13.2.0
arc                             allyesconfig    gcc-13.2.0
arc                  randconfig-001-20250116    gcc-13.2.0
arc                  randconfig-002-20250116    gcc-13.2.0
arm                             allmodconfig    gcc-14.2.0
arm                              allnoconfig    clang-17
arm                             allyesconfig    gcc-14.2.0
arm                  randconfig-001-20250116    gcc-14.2.0
arm                  randconfig-002-20250116    clang-15
arm                  randconfig-003-20250116    gcc-14.2.0
arm                  randconfig-004-20250116    gcc-14.2.0
arm64                           allmodconfig    clang-18
arm64                            allnoconfig    gcc-14.2.0
arm64                randconfig-001-20250116    gcc-14.2.0
arm64                randconfig-002-20250116    gcc-14.2.0
arm64                randconfig-003-20250116    clang-15
arm64                randconfig-004-20250116    clang-20
csky                             allnoconfig    gcc-14.2.0
csky                 randconfig-001-20250116    gcc-14.2.0
csky                 randconfig-002-20250116    gcc-14.2.0
hexagon                         allmodconfig    clang-20
hexagon                          allnoconfig    clang-20
hexagon                         allyesconfig    clang-18
hexagon              randconfig-001-20250116    clang-20
hexagon              randconfig-002-20250116    clang-20
i386                            allmodconfig    gcc-12
i386                             allnoconfig    gcc-12
i386       buildonly-randconfig-001-20250116    clang-19
i386       buildonly-randconfig-002-20250116    clang-19
i386       buildonly-randconfig-003-20250116    clang-19
i386       buildonly-randconfig-004-20250116    clang-19
i386       buildonly-randconfig-005-20250116    clang-19
i386       buildonly-randconfig-006-20250116    clang-19
loongarch                        allnoconfig    gcc-14.2.0
loongarch            randconfig-001-20250116    gcc-14.2.0
loongarch            randconfig-002-20250116    gcc-14.2.0
nios2                randconfig-001-20250116    gcc-14.2.0
nios2                randconfig-002-20250116    gcc-14.2.0
openrisc                         allnoconfig    gcc-14.2.0
openrisc                        allyesconfig    gcc-14.2.0
parisc                          allmodconfig    gcc-14.2.0
parisc                           allnoconfig    gcc-14.2.0
parisc                          allyesconfig    gcc-14.2.0
parisc               randconfig-001-20250116    gcc-14.2.0
parisc               randconfig-002-20250116    gcc-14.2.0
powerpc                         allmodconfig    gcc-14.2.0
powerpc                          allnoconfig    gcc-14.2.0
powerpc              randconfig-001-20250116    clang-20
powerpc              randconfig-002-20250116    gcc-14.2.0
powerpc              randconfig-003-20250116    clang-20
powerpc64            randconfig-001-20250116    clang-19
powerpc64            randconfig-002-20250116    clang-20
powerpc64            randconfig-003-20250116    clang-15
riscv                            allnoconfig    gcc-14.2.0
riscv                randconfig-001-20250116    gcc-14.2.0
riscv                randconfig-002-20250116    gcc-14.2.0
s390                            allmodconfig    clang-19
s390                             allnoconfig    clang-20
s390                            allyesconfig    gcc-14.2.0
s390                 randconfig-001-20250116    gcc-14.2.0
s390                 randconfig-002-20250116    clang-18
sh                              allmodconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                   randconfig-001-20250116    gcc-14.2.0
sh                   randconfig-002-20250116    gcc-14.2.0
sparc                           allmodconfig    gcc-14.2.0
sparc                randconfig-001-20250116    gcc-14.2.0
sparc                randconfig-002-20250116    gcc-14.2.0
sparc64              randconfig-001-20250116    gcc-14.2.0
sparc64              randconfig-002-20250116    gcc-14.2.0
um                              allmodconfig    clang-20
um                               allnoconfig    clang-18
um                              allyesconfig    gcc-12
um                   randconfig-001-20250116    clang-19
um                   randconfig-002-20250116    gcc-12
x86_64                           allnoconfig    clang-19
x86_64     buildonly-randconfig-001-20250116    gcc-12
x86_64     buildonly-randconfig-002-20250116    gcc-12
x86_64     buildonly-randconfig-003-20250116    gcc-12
x86_64     buildonly-randconfig-004-20250116    clang-19
x86_64     buildonly-randconfig-005-20250116    clang-19
x86_64     buildonly-randconfig-006-20250116    clang-19
x86_64                             defconfig    gcc-11
xtensa               randconfig-001-20250116    gcc-14.2.0
xtensa               randconfig-002-20250116    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

