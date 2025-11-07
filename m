Return-Path: <linux-wireless+bounces-28688-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C60DC41ECC
	for <lists+linux-wireless@lfdr.de>; Sat, 08 Nov 2025 00:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9C7874ED3B1
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Nov 2025 23:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C1830AAD6;
	Fri,  7 Nov 2025 23:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nkdFP5vS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7436303A05
	for <linux-wireless@vger.kernel.org>; Fri,  7 Nov 2025 23:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762557520; cv=none; b=akc/vAMjMqOMrxkTC1USQF+w29+kbULts2045QkYpbIexkyiK5K7wge17OzncDxFhxI/lOH5URubuoeJwhD23vd2AY0hcGmqCcKMyLD3euPQY8YBUDiTDA1j7eStrUAouGQ7sJtfMnEJdvSbHNwzH3Q7yq3jF4zz4T/FP9EBdtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762557520; c=relaxed/simple;
	bh=ybhnIFBSUF/kBbYouBF5oVS2Of7SYlTE8HxyCkGwtGU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=jlMFMsuvTJ3587qNJFL3ffUfuI0Kd3dYG/iFm/f1NKNQXleJh+eheT4rX7a3okik47/byfpEv5Do7PH44QRNg43iqpGY6hSn5/e674dhsEsDpZk3VJZJCKaqgQRMh7fw17ekUPZXrHp77VRJBAt+sa4v21R4t78v15cigDZwKvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nkdFP5vS; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762557519; x=1794093519;
  h=date:from:to:cc:subject:message-id;
  bh=ybhnIFBSUF/kBbYouBF5oVS2Of7SYlTE8HxyCkGwtGU=;
  b=nkdFP5vSgrX4zrmeuZwspTBUxuPStRo6Odjjm1/f8ViBjfVTPvOcOQTO
   OnyFflD4JVTX5wWEa4N24bikJQNXI42v+iM7Xt9RK0aNOR7yfHvRXa2rX
   KnCRga70Lu4hS3k2N/CQ53JqOkqAKEkT0nvudsh1PtdhmzZHbn/DiHQy7
   I0A9CF3UPe9FK77DtkHMDWZVk5YJqR4FDN+hafka/krrJzSOD8z8h4svz
   nfJ3xEq/HK2h8RYaJV+NScRR86dIwWxkslve8lAJDUVKE6grAeKnxjCb0
   kYDcITpqgBX6o0DP3ZuICLdk7Nok/fmWW6dw44fPRPHU5v61WLcBQlUnl
   Q==;
X-CSE-ConnectionGUID: hHC1tMJ9S1yXCMhwhvrAYw==
X-CSE-MsgGUID: VrKMphgmQG2lMUU5vsdUxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11606"; a="64593284"
X-IronPort-AV: E=Sophos;i="6.19,288,1754982000"; 
   d="scan'208";a="64593284"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 15:18:39 -0800
X-CSE-ConnectionGUID: Ki3QWm9YR8WEfJdkpUSr/g==
X-CSE-MsgGUID: +TMpzo3/RJ+2p97SIzLmlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,288,1754982000"; 
   d="scan'208";a="193330903"
Received: from lkp-server01.sh.intel.com (HELO 6ef82f2de774) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 07 Nov 2025 15:18:37 -0800
Received: from kbuild by 6ef82f2de774 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vHVj1-0000Sp-07;
	Fri, 07 Nov 2025 23:18:35 +0000
Date: Sat, 08 Nov 2025 07:18:17 +0800
From: kernel test robot <lkp@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 1ec9871fbb80ba7db84f868f6aa40d38bc43f0e0
Message-ID: <202511080711.zFgqbvdw-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 1ec9871fbb80ba7db84f868f6aa40d38bc43f0e0  Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net

elapsed time: 1706m

configs tested: 109
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                   randconfig-001-20251107    gcc-8.5.0
arc                   randconfig-002-20251107    gcc-9.5.0
arm                               allnoconfig    clang-22
arm                         at91_dt_defconfig    clang-22
arm                        clps711x_defconfig    clang-22
arm                   randconfig-001-20251107    clang-17
arm                   randconfig-002-20251107    gcc-13.4.0
arm                   randconfig-003-20251107    clang-22
arm                   randconfig-004-20251107    gcc-8.5.0
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20251108    gcc-8.5.0
arm64                 randconfig-002-20251108    clang-22
arm64                 randconfig-003-20251108    clang-22
arm64                 randconfig-004-20251108    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20251108    gcc-15.1.0
csky                  randconfig-002-20251108    gcc-15.1.0
hexagon                           allnoconfig    clang-22
hexagon               randconfig-001-20251107    clang-22
hexagon               randconfig-002-20251107    clang-22
i386                              allnoconfig    gcc-14
i386        buildonly-randconfig-001-20251108    gcc-14
i386        buildonly-randconfig-002-20251108    gcc-14
i386        buildonly-randconfig-003-20251108    gcc-14
i386        buildonly-randconfig-004-20251108    gcc-14
i386        buildonly-randconfig-005-20251108    clang-20
i386        buildonly-randconfig-006-20251108    gcc-14
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251107    gcc-15.1.0
loongarch             randconfig-002-20251107    clang-19
m68k                              allnoconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
m68k                        stmark2_defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                      maltaaprp_defconfig    clang-22
mips                           mtx1_defconfig    clang-22
mips                           xway_defconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251107    gcc-11.5.0
nios2                 randconfig-002-20251107    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                randconfig-001-20251107    gcc-8.5.0
parisc                randconfig-002-20251107    gcc-12.5.0
parisc64                         alldefconfig    gcc-15.1.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                      cm5200_defconfig    clang-22
powerpc                 mpc834x_itx_defconfig    clang-16
powerpc                 mpc836x_rdk_defconfig    clang-22
powerpc                     mpc83xx_defconfig    clang-22
powerpc                      pcm030_defconfig    clang-22
powerpc               randconfig-001-20251107    clang-22
powerpc               randconfig-002-20251107    clang-22
powerpc64             randconfig-001-20251107    gcc-14.3.0
powerpc64             randconfig-002-20251107    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                 randconfig-001-20251107    clang-22
riscv                 randconfig-002-20251107    gcc-13.4.0
s390                             alldefconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                  randconfig-001-20251107    gcc-8.5.0
s390                  randconfig-002-20251107    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                 kfr2r09-romimage_defconfig    gcc-15.1.0
sh                    randconfig-001-20251107    gcc-13.4.0
sh                    randconfig-002-20251107    gcc-11.5.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20251108    gcc-14.3.0
sparc                 randconfig-002-20251108    gcc-8.5.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251108    clang-20
sparc64               randconfig-002-20251108    clang-20
um                                allnoconfig    clang-22
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251108    gcc-14
um                    randconfig-002-20251108    clang-22
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64      buildonly-randconfig-001-20251108    gcc-14
x86_64      buildonly-randconfig-002-20251108    gcc-12
x86_64      buildonly-randconfig-003-20251108    clang-20
x86_64      buildonly-randconfig-004-20251108    gcc-14
x86_64      buildonly-randconfig-005-20251108    gcc-14
x86_64      buildonly-randconfig-006-20251108    gcc-14
x86_64                              defconfig    gcc-14
x86_64                randconfig-011-20251108    clang-20
x86_64                randconfig-012-20251108    gcc-14
x86_64                randconfig-013-20251108    clang-20
x86_64                randconfig-014-20251108    clang-20
x86_64                randconfig-015-20251108    clang-20
x86_64                randconfig-016-20251108    gcc-14
x86_64                randconfig-071-20251108    gcc-14
x86_64                randconfig-072-20251108    clang-20
x86_64                randconfig-073-20251108    clang-20
x86_64                randconfig-074-20251108    clang-20
x86_64                randconfig-075-20251108    gcc-12
x86_64                randconfig-076-20251108    gcc-14
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251108    gcc-8.5.0
xtensa                randconfig-002-20251108    gcc-14.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

