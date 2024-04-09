Return-Path: <linux-wireless+bounces-5998-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE7689D603
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Apr 2024 11:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF7E81C215E9
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Apr 2024 09:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB3D7FBC7;
	Tue,  9 Apr 2024 09:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R0FoJJDy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E89680038
	for <linux-wireless@vger.kernel.org>; Tue,  9 Apr 2024 09:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712656384; cv=none; b=bAGrI/mwe9sjP3Ok4joK3oD2vv/xdM4tDsqI5d9pcoBhL2fSZGS+BaNPkoRITIxMtx793CSlHCKZ8cIwQbR5ODZHULtGbKKAPoUnQVUhMUR/RLx5Yk8mGeNQLaRjW9hDhlu9KwVtsl4ARoBLSJBoSG40tuhth1l7YYFpDnqk5Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712656384; c=relaxed/simple;
	bh=UPynYD+HTLehGVqahN3UGQStsW8eaHuVH4OC91DGxI8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=s48OMDtEc1379D7xI4D1WpYEn0M96Fa8VHzU+Nml7ZB2th7u+CoZ+WQnooBIftRNO+8zUZsTmb0v2SdZDllMTsTu3GkZstgu3hHsJRzN0BsBQtIk0t/Eg8tKQQPhCgbQ88M7ysFa8b+2DW9SNqJIFCHH1821s5mmMXPJqSmVQsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R0FoJJDy; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712656382; x=1744192382;
  h=date:from:to:cc:subject:message-id;
  bh=UPynYD+HTLehGVqahN3UGQStsW8eaHuVH4OC91DGxI8=;
  b=R0FoJJDyPGFw7PanW5tfSV4fNMMHUVCoK1cr0cDZQG/QW+8vSLNjbCFJ
   zuK1Ge00dsJLpgWN+Nsxar9hRQQpB39/Ir0YKB05CCqUFwynUoUTvbNDv
   H4gm7KVZN8+RtbZrnugoTjKZkCgU+THFvfrlE9SxqoYqzylSlJQDyozPo
   YclDaQPGt96W2MHqPGuBdwcY3TxZPlEKJJwopnzOwxOBT1wp35hbhlBTW
   7kTLjw5FnbQFi1ImYutGN9QMF4UO9gbEYiT1f3k5bHdmXJx4JMsSJLwFG
   txlglLtFKlHQxHpvKw+pdpoy2pKeNMkKYWAzZPifw9s1QWSUOSrP6iOHs
   g==;
X-CSE-ConnectionGUID: sah9MUjHSCGVu6o0XAyRhg==
X-CSE-MsgGUID: 8qXAuowgTQuwlJaIHBbMeg==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="19394008"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="19394008"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 02:53:01 -0700
X-CSE-ConnectionGUID: uoiu7DQZQmu4CosepgQzlA==
X-CSE-MsgGUID: yX/wWyE7Sr+Nq2+/hJt3kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="43379099"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 09 Apr 2024 02:53:00 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ru89y-0005yk-0B;
	Tue, 09 Apr 2024 09:52:58 +0000
Date: Tue, 09 Apr 2024 17:52:20 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: [wireless:for-next] BUILD SUCCESS
 9ef369973cd2c97cce3388d2c0c7e3c056656e8a
Message-ID: <202404091718.mS50StGm-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git for-next
branch HEAD: 9ef369973cd2c97cce3388d2c0c7e3c056656e8a  wifi: cfg80211: fix the order of arguments for trace events of the tx_rx_evt class

elapsed time: 869m

configs tested: 140
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
arc                   randconfig-001-20240409   gcc  
arc                   randconfig-002-20240409   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240409   gcc  
arm                   randconfig-002-20240409   clang
arm                   randconfig-003-20240409   clang
arm                   randconfig-004-20240409   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240409   gcc  
arm64                 randconfig-002-20240409   gcc  
arm64                 randconfig-003-20240409   clang
arm64                 randconfig-004-20240409   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240409   gcc  
csky                  randconfig-002-20240409   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240409   clang
hexagon               randconfig-002-20240409   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240409   clang
i386         buildonly-randconfig-002-20240409   clang
i386         buildonly-randconfig-003-20240409   gcc  
i386         buildonly-randconfig-004-20240409   clang
i386         buildonly-randconfig-005-20240409   gcc  
i386         buildonly-randconfig-006-20240409   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240409   clang
i386                  randconfig-002-20240409   gcc  
i386                  randconfig-003-20240409   clang
i386                  randconfig-004-20240409   gcc  
i386                  randconfig-005-20240409   gcc  
i386                  randconfig-006-20240409   clang
i386                  randconfig-011-20240409   gcc  
i386                  randconfig-012-20240409   clang
i386                  randconfig-013-20240409   clang
i386                  randconfig-014-20240409   clang
i386                  randconfig-015-20240409   gcc  
i386                  randconfig-016-20240409   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240409   gcc  
loongarch             randconfig-002-20240409   gcc  
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
nios2                 randconfig-001-20240409   gcc  
nios2                 randconfig-002-20240409   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240409   gcc  
parisc                randconfig-002-20240409   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc               randconfig-001-20240409   clang
powerpc               randconfig-002-20240409   gcc  
powerpc               randconfig-003-20240409   clang
powerpc64             randconfig-001-20240409   gcc  
powerpc64             randconfig-002-20240409   clang
powerpc64             randconfig-003-20240409   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240409   clang
riscv                 randconfig-002-20240409   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240409   gcc  
s390                  randconfig-002-20240409   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240409   gcc  
sh                    randconfig-002-20240409   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240409   gcc  
sparc64               randconfig-002-20240409   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240409   clang
um                    randconfig-002-20240409   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240409   gcc  
xtensa                randconfig-002-20240409   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

