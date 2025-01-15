Return-Path: <linux-wireless+bounces-17554-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9CF1A126E7
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2025 16:08:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE5DB1613E8
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2025 15:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3DF97711F;
	Wed, 15 Jan 2025 15:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TSHrsBuW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F9720326
	for <linux-wireless@vger.kernel.org>; Wed, 15 Jan 2025 15:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736953701; cv=none; b=NG7U2ZbsBkJQawgSL5AUh+Zh0sQ0r4yVyMfe+T51sHFfj/tC9NrYsShdtZubFmOvJIXQM7AmyP6xwLTRIJ/voaHxx/7+2+yXzniHElnjlVwpQv9OZuIPmjd/4TIqUPdq+XdlP7cLPY/aArBH0jZwIIVsygDct6PnmBVGkQxSaxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736953701; c=relaxed/simple;
	bh=eER4h7BxA3yeAhNP2922kFbim8qsH0T0t7m2HpfziZY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=U8VQDbxVX9YVPJrtH9jDAxawo9VEn/+j7KlzPeX0RYh2cezRTATKZJXlwiupmuzG3b7E0oL8UDSbArhopI2BFn6ya47CYWUtXFyf2Im5bRj7XqWavqEFEhxNQyd+XRWk2YYka5oqsp00+RVaOcRB0XyLsfgRteyrlp3cpQeDt2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TSHrsBuW; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736953700; x=1768489700;
  h=date:from:to:cc:subject:message-id;
  bh=eER4h7BxA3yeAhNP2922kFbim8qsH0T0t7m2HpfziZY=;
  b=TSHrsBuW96YNHKCiiRB53HzjxErTh/uzKm6Ro4hasU5yyQuLvmdfBWmM
   zwDPKRpgw9L8fpbQ1rQg2I1t12IWoUNwyb3t19ePe3POFPqvAseYSnwJR
   puE20N7Gh4um8aw3a9baRv/lCheAgOyN152IiallLIlF30oBSWXto/2gw
   t9O5yf65D4KCAUdk6dDgSbi48XCfAfYIR3VXXlCEhje641AvOIlFq2KLi
   MRcoxVVrRiSFkX5AEnZ9YcjSD/hA/MlTz1WkUkJgH/QBs+Jo5mZK2zHW6
   W/11FN1rzCvwSx9Dh39g4Bj0Vp8q3DRdsyN/6Ywee4KU96t18WN1O3Cd0
   A==;
X-CSE-ConnectionGUID: G8IlilgISTCxIVeqT9O23g==
X-CSE-MsgGUID: X9bfxVqzSvec4/dbAJb3qw==
X-IronPort-AV: E=McAfee;i="6700,10204,11316"; a="41228813"
X-IronPort-AV: E=Sophos;i="6.13,206,1732608000"; 
   d="scan'208";a="41228813"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 07:08:19 -0800
X-CSE-ConnectionGUID: qs0HwrSdS/a9lEkUFNdreA==
X-CSE-MsgGUID: BQKgeoJGQSeFAVbmjs98Hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="109200994"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 15 Jan 2025 07:08:18 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tY50B-000QV7-3B;
	Wed, 15 Jan 2025 15:08:15 +0000
Date: Wed, 15 Jan 2025 23:07:24 +0800
From: kernel test robot <lkp@intel.com>
To: Kalle Valo <kvalo@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless@vger.kernel.org
Subject: [wireless-next:pending] BUILD SUCCESS
 3737936e2be920977aea7d9f7eb8cb4468d700d7
Message-ID: <202501152317.2PnBkFYM-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git pending
branch HEAD: 3737936e2be920977aea7d9f7eb8cb4468d700d7  Merge tag 'rtw-next-2025-01-12' of https://github.com/pkshih/rtw into pending

elapsed time: 1457m

configs tested: 91
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-14.2.0
alpha                           allyesconfig    gcc-14.2.0
arc                             allmodconfig    gcc-13.2.0
arc                              allnoconfig    gcc-13.2.0
arc                             allyesconfig    gcc-13.2.0
arc                  randconfig-001-20250115    gcc-13.2.0
arc                  randconfig-002-20250115    gcc-13.2.0
arm                             allmodconfig    gcc-14.2.0
arm                              allnoconfig    clang-17
arm                             allyesconfig    gcc-14.2.0
arm                  randconfig-001-20250115    clang-16
arm                  randconfig-002-20250115    clang-20
arm                  randconfig-003-20250115    clang-20
arm                  randconfig-004-20250115    clang-20
arm64                           allmodconfig    clang-18
arm64                            allnoconfig    gcc-14.2.0
arm64                randconfig-001-20250115    clang-20
arm64                randconfig-002-20250115    gcc-14.2.0
arm64                randconfig-003-20250115    clang-18
arm64                randconfig-004-20250115    gcc-14.2.0
csky                             allnoconfig    gcc-14.2.0
csky                 randconfig-001-20250115    gcc-14.2.0
csky                 randconfig-002-20250115    gcc-14.2.0
hexagon                         allmodconfig    clang-20
hexagon                          allnoconfig    clang-20
hexagon                         allyesconfig    clang-18
hexagon              randconfig-001-20250115    clang-20
hexagon              randconfig-002-20250115    clang-19
i386                            allmodconfig    gcc-12
i386                             allnoconfig    gcc-12
i386                            allyesconfig    gcc-12
i386       buildonly-randconfig-001-20250115    clang-19
i386       buildonly-randconfig-002-20250115    gcc-12
i386       buildonly-randconfig-003-20250115    gcc-12
i386       buildonly-randconfig-004-20250115    gcc-12
i386       buildonly-randconfig-005-20250115    gcc-12
i386       buildonly-randconfig-006-20250115    gcc-12
i386                               defconfig    clang-19
loongarch                        allnoconfig    gcc-14.2.0
loongarch            randconfig-001-20250115    gcc-14.2.0
loongarch            randconfig-002-20250115    gcc-14.2.0
nios2                randconfig-001-20250115    gcc-14.2.0
nios2                randconfig-002-20250115    gcc-14.2.0
openrisc                         allnoconfig    gcc-14.2.0
openrisc                        allyesconfig    gcc-14.2.0
parisc                          allmodconfig    gcc-14.2.0
parisc                           allnoconfig    gcc-14.2.0
parisc                          allyesconfig    gcc-14.2.0
parisc               randconfig-001-20250115    gcc-14.2.0
parisc               randconfig-002-20250115    gcc-14.2.0
powerpc                         allmodconfig    gcc-14.2.0
powerpc                          allnoconfig    gcc-14.2.0
powerpc              randconfig-001-20250115    gcc-14.2.0
powerpc              randconfig-002-20250115    gcc-14.2.0
powerpc              randconfig-003-20250115    gcc-14.2.0
powerpc64            randconfig-001-20250115    gcc-14.2.0
powerpc64            randconfig-002-20250115    gcc-14.2.0
powerpc64            randconfig-003-20250115    clang-18
riscv                            allnoconfig    gcc-14.2.0
riscv                randconfig-001-20250115    gcc-14.2.0
riscv                randconfig-002-20250115    clang-16
s390                            allmodconfig    clang-19
s390                             allnoconfig    clang-20
s390                            allyesconfig    gcc-14.2.0
s390                 randconfig-001-20250115    clang-20
s390                 randconfig-002-20250115    clang-15
sh                              allmodconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                   randconfig-001-20250115    gcc-14.2.0
sh                   randconfig-002-20250115    gcc-14.2.0
sparc                           allmodconfig    gcc-14.2.0
sparc                randconfig-001-20250115    gcc-14.2.0
sparc                randconfig-002-20250115    gcc-14.2.0
sparc64              randconfig-001-20250115    gcc-14.2.0
sparc64              randconfig-002-20250115    gcc-14.2.0
um                              allmodconfig    clang-20
um                               allnoconfig    clang-18
um                              allyesconfig    gcc-12
um                   randconfig-001-20250115    clang-18
um                   randconfig-002-20250115    gcc-12
x86_64                           allnoconfig    clang-19
x86_64                          allyesconfig    clang-19
x86_64     buildonly-randconfig-001-20250115    gcc-12
x86_64     buildonly-randconfig-002-20250115    gcc-12
x86_64     buildonly-randconfig-003-20250115    clang-19
x86_64     buildonly-randconfig-004-20250115    clang-19
x86_64     buildonly-randconfig-005-20250115    gcc-12
x86_64     buildonly-randconfig-006-20250115    clang-19
x86_64                             defconfig    gcc-11
xtensa               randconfig-001-20250115    gcc-14.2.0
xtensa               randconfig-002-20250115    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

