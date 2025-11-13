Return-Path: <linux-wireless+bounces-28919-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3696FC588A2
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Nov 2025 16:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3E61B4EADD3
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Nov 2025 15:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F21261393;
	Thu, 13 Nov 2025 15:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UxvtT01t"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2311D9A54
	for <linux-wireless@vger.kernel.org>; Thu, 13 Nov 2025 15:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763047229; cv=none; b=A2zkhNUh08OVYEkRC5Idj54f2r/lL9nPX4OdnO4QgGwb5ZJoR96T/CmyfVvq0kJsvUUiW2xtV0pUa2exxnRsx9LqjGPKUEbSroH9XwV26HEZNG4dtUGMyDfigQOc4GTXSIk1v+Kwn8oB68NuDKseHn0UDrKhcLEgDhXhXrS6MU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763047229; c=relaxed/simple;
	bh=/OesxnN787FNQb+ILL040q4js/Y16xhtbLg3V2INic4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ljQf/nuyHbz8A5wV+bSKeQsc1BD4qBWqebW7V+grLCng8A5jxw5yrEK18fTooXvr+7thAYcGHTlh3CvwDYoE7J68B7j5qkRjwvNghrmCBMdW1csjgbpLvU2q2+1UouBu8ZrzUIBAxTtl4aw00vzEn5CjiGdqQv7YKK5IXQqZlmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UxvtT01t; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763047228; x=1794583228;
  h=date:from:to:cc:subject:message-id;
  bh=/OesxnN787FNQb+ILL040q4js/Y16xhtbLg3V2INic4=;
  b=UxvtT01t+0OgCIzEPWSOU6gLTuN58JKHgWpHLZPnIV9be3p4LvQwbcWv
   OefSFJHRdlrLaCh9EW0gj9XVltfzFEgL6i0LM2wMUs5Qrlo3MoAuI2czN
   tOHQ0JVDPQUAw3EYcXYrwESFGZ/OVAkZ5pvXe2uZs+gKwozMz2PuQ1EEU
   B8I9jWrJilYF/On9ALBeh0uFrX+JuF1PwdTiD8I88ss5HQ+oVXluD9dBV
   BCJnkG4kbyA8jqjtTY4LEydBd036tc1JAl252Mk7fhtNt7dcHDP32ub0R
   1nCgoNHbEDvUW1i+7Bt0fndGiWMxKCjfrQatfdmKpY2P8/DEos/o9hkaY
   A==;
X-CSE-ConnectionGUID: fNFf5np2RW+nD5grC8US9w==
X-CSE-MsgGUID: NcioteH4TMOeyVgnUmCR1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11612"; a="75741052"
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="75741052"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 07:20:28 -0800
X-CSE-ConnectionGUID: JQhkzmuRSb+qXcCWpZm2Ew==
X-CSE-MsgGUID: RsGMsmu5Ql68Lmob15lmfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="189792870"
Received: from lkp-server01.sh.intel.com (HELO 7b01c990427b) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 13 Nov 2025 07:20:27 -0800
Received: from kbuild by 7b01c990427b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vJZ7Y-0005TF-21;
	Thu, 13 Nov 2025 15:20:24 +0000
Date: Thu, 13 Nov 2025 23:19:24 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: linux-wireless@vger.kernel.org
Subject: [wireless:for-next] BUILD SUCCESS
 a35f64a216ca1c9e3c3f0f91fdb54ef9515a7fe7
Message-ID: <202511132319.MhLJ69wT-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git for-next
branch HEAD: a35f64a216ca1c9e3c3f0f91fdb54ef9515a7fe7  Merge tag 'iwlwifi-fixes-2025-11-12' of https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next

elapsed time: 1807m

configs tested: 105
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
arc                              alldefconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                   randconfig-001-20251113    gcc-8.5.0
arc                   randconfig-002-20251113    gcc-8.5.0
arm                               allnoconfig    clang-22
arm                     am200epdkit_defconfig    gcc-15.1.0
arm                         lpc18xx_defconfig    clang-22
arm                         orion5x_defconfig    clang-22
arm                   randconfig-001-20251113    gcc-10.5.0
arm                   randconfig-002-20251113    clang-22
arm                   randconfig-003-20251113    clang-22
arm                   randconfig-004-20251113    clang-22
arm                        spear6xx_defconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20251113    clang-16
arm64                 randconfig-002-20251113    clang-22
arm64                 randconfig-003-20251113    gcc-8.5.0
arm64                 randconfig-004-20251113    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20251113    gcc-9.5.0
csky                  randconfig-002-20251113    gcc-14.3.0
hexagon                           allnoconfig    clang-22
hexagon               randconfig-001-20251113    clang-22
hexagon               randconfig-002-20251113    clang-22
i386                              allnoconfig    gcc-14
i386        buildonly-randconfig-001-20251113    clang-20
i386        buildonly-randconfig-002-20251113    gcc-14
i386        buildonly-randconfig-003-20251113    gcc-14
i386        buildonly-randconfig-004-20251113    gcc-12
i386        buildonly-randconfig-005-20251113    gcc-14
i386                  randconfig-001-20251113    gcc-14
i386                  randconfig-002-20251113    clang-20
i386                  randconfig-003-20251113    clang-20
i386                  randconfig-004-20251113    gcc-14
i386                  randconfig-005-20251113    clang-20
i386                  randconfig-006-20251113    clang-20
i386                  randconfig-007-20251113    gcc-14
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251113    gcc-15.1.0
loongarch             randconfig-002-20251113    clang-22
m68k                              allnoconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
microblaze                      mmu_defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251113    gcc-8.5.0
nios2                 randconfig-002-20251113    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251113    gcc-8.5.0
parisc                randconfig-002-20251113    gcc-14.3.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                     ksi8560_defconfig    gcc-15.1.0
powerpc                      pmac32_defconfig    clang-22
powerpc               randconfig-001-20251113    clang-22
powerpc               randconfig-002-20251113    clang-22
powerpc64             randconfig-001-20251113    clang-22
powerpc64             randconfig-002-20251113    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                               defconfig    clang-22
riscv                 randconfig-001-20251113    gcc-8.5.0
riscv                 randconfig-002-20251113    gcc-11.5.0
s390                              allnoconfig    clang-22
s390                                defconfig    clang-22
s390                  randconfig-001-20251113    clang-22
s390                  randconfig-002-20251113    clang-17
sh                                allnoconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                               j2_defconfig    gcc-15.1.0
sh                    randconfig-001-20251113    gcc-15.1.0
sh                    randconfig-002-20251113    gcc-11.5.0
sh                        sh7763rdp_defconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251113    gcc-8.5.0
sparc                 randconfig-002-20251113    gcc-8.5.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251113    clang-20
sparc64               randconfig-002-20251113    clang-22
um                                allnoconfig    clang-22
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251113    gcc-14
um                    randconfig-002-20251113    clang-22
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64      buildonly-randconfig-001-20251113    gcc-14
x86_64      buildonly-randconfig-002-20251113    clang-20
x86_64      buildonly-randconfig-003-20251113    clang-20
x86_64      buildonly-randconfig-004-20251113    gcc-14
x86_64      buildonly-randconfig-005-20251113    gcc-12
x86_64      buildonly-randconfig-006-20251113    gcc-14
x86_64                              defconfig    gcc-14
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251113    gcc-15.1.0
xtensa                randconfig-002-20251113    gcc-13.4.0
xtensa                    xip_kc705_defconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

