Return-Path: <linux-wireless+bounces-19545-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAEDAA485EE
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Feb 2025 17:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C33293ACD32
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Feb 2025 16:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1DE61DB122;
	Thu, 27 Feb 2025 16:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cjHgFlgB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92231D5AD8
	for <linux-wireless@vger.kernel.org>; Thu, 27 Feb 2025 16:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740675526; cv=none; b=T1+AQglo18ShZhosMI+9WUGEbMKVQ330FcpdQDCLQBC9ZVvt5+ZItanXAx15WCEBK4mdQ2Bt0lq0o+DylPXyCgrM/fJAjPkXFDitg5j7H3qFz+CgfasCYH4S0t3O8Xoq82Qsh3noHUOMVWA6fLxjfa8xWgJ2AWiabmrew472W+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740675526; c=relaxed/simple;
	bh=Ka0GeCxgzVds9Ruyvk8MlD348gcxLUWEeQeptHXOCko=;
	h=Date:From:To:Cc:Subject:Message-ID; b=F0ns2V1lq4DtSwuWDBHyQBRqkLZFxGYeVXIyyfty3qwXGJb87fL2MkzmW7NteGBZSL+EHKEIQ+OUIw72moHaien7dMGGAGnMPfRwn/WvkXarZcpZYVo+M8G0AaEOSqUn3g/7D83k+2ix4s13nt5XMQszkGnaAPA2TbrHtikZfqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cjHgFlgB; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740675525; x=1772211525;
  h=date:from:to:cc:subject:message-id;
  bh=Ka0GeCxgzVds9Ruyvk8MlD348gcxLUWEeQeptHXOCko=;
  b=cjHgFlgBMm1/eFYWu/BAZtrZ5If+MwB+hJQOPustAuPH82wxd+Jy88CA
   UwhvGEP3p4R6XJA0vaEqgt46v4E+Bf1d5cCZAWxAuKseSncaJgibxsgb3
   sahCV0cCdcUSenerTFQXvP8CF4/DX9IfXWQE2vaareXZTb04igxTiNYZE
   TaCA6Z/XC4sKDp2PKg0GCnAdtz8j8FwKZmkcNOxuBnwr9tQz/Y2o4iIB5
   AMFaJR/Vqf2UfG3UzLSp2Ny/yyzE9i+B3DdgMt7mJOFN6DOoOOQe92h9b
   TKhEHf2f91JX14sH65X3VIkBHmDoUW8VTp2/2vq4g/inEUfs3RbQfP3yQ
   g==;
X-CSE-ConnectionGUID: on5RTtJBROm+iZFcfh3LwQ==
X-CSE-MsgGUID: AYX7JC4wTyCJS1MI8IcOpg==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="41834107"
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="41834107"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 08:58:44 -0800
X-CSE-ConnectionGUID: XVwP0SUxRwKekfRI38+LfQ==
X-CSE-MsgGUID: 9O5WF+6QS8OelTjiK51noA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="117077654"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 27 Feb 2025 08:58:43 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tnhDc-000Djy-2P;
	Thu, 27 Feb 2025 16:58:40 +0000
Date: Fri, 28 Feb 2025 00:58:05 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 95da92e7c6ffd63aa0c30d20963793dae4ae94ef
Message-ID: <202502280059.uwr5JpEX-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 95da92e7c6ffd63aa0c30d20963793dae4ae94ef  wifi: iwlwifi: add Debug Host Command APIs

elapsed time: 1446m

configs tested: 178
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-21
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              alldefconfig    gcc-14.2.0
arc                              allmodconfig    clang-18
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-18
arc                   randconfig-001-20250227    clang-17
arc                   randconfig-001-20250227    gcc-13.2.0
arc                   randconfig-002-20250227    clang-17
arc                   randconfig-002-20250227    gcc-13.2.0
arm                              allmodconfig    clang-18
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-18
arm                          pxa3xx_defconfig    gcc-14.2.0
arm                   randconfig-001-20250227    clang-17
arm                   randconfig-001-20250227    gcc-14.2.0
arm                   randconfig-002-20250227    clang-17
arm                   randconfig-003-20250227    clang-17
arm                   randconfig-003-20250227    gcc-14.2.0
arm                   randconfig-004-20250227    clang-17
arm                   randconfig-004-20250227    clang-21
arm                         socfpga_defconfig    gcc-14.2.0
arm                        spear6xx_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250227    clang-17
arm64                 randconfig-001-20250227    gcc-14.2.0
arm64                 randconfig-002-20250227    clang-17
arm64                 randconfig-002-20250227    clang-19
arm64                 randconfig-003-20250227    clang-17
arm64                 randconfig-003-20250227    gcc-14.2.0
arm64                 randconfig-004-20250227    clang-17
arm64                 randconfig-004-20250227    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250227    gcc-14.2.0
csky                  randconfig-002-20250227    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-18
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250227    clang-14
hexagon               randconfig-001-20250227    gcc-14.2.0
hexagon               randconfig-002-20250227    clang-16
hexagon               randconfig-002-20250227    gcc-14.2.0
i386                             allmodconfig    clang-19
i386                              allnoconfig    clang-19
i386                             allyesconfig    clang-19
i386        buildonly-randconfig-001-20250227    gcc-12
i386        buildonly-randconfig-002-20250227    gcc-11
i386        buildonly-randconfig-002-20250227    gcc-12
i386        buildonly-randconfig-003-20250227    clang-19
i386        buildonly-randconfig-003-20250227    gcc-12
i386        buildonly-randconfig-004-20250227    gcc-12
i386        buildonly-randconfig-005-20250227    gcc-11
i386        buildonly-randconfig-005-20250227    gcc-12
i386        buildonly-randconfig-006-20250227    clang-19
i386        buildonly-randconfig-006-20250227    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20250227    clang-19
i386                  randconfig-002-20250227    clang-19
i386                  randconfig-003-20250227    clang-19
i386                  randconfig-004-20250227    clang-19
i386                  randconfig-005-20250227    clang-19
i386                  randconfig-006-20250227    clang-19
i386                  randconfig-007-20250227    clang-19
i386                  randconfig-011-20250227    gcc-12
i386                  randconfig-012-20250227    gcc-12
i386                  randconfig-013-20250227    gcc-12
i386                  randconfig-014-20250227    gcc-12
i386                  randconfig-015-20250227    gcc-12
i386                  randconfig-016-20250227    gcc-12
i386                  randconfig-017-20250227    gcc-12
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250227    gcc-14.2.0
loongarch             randconfig-002-20250227    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                        mvme16x_defconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                        bcm63xx_defconfig    gcc-14.2.0
mips                          eyeq5_defconfig    gcc-14.2.0
mips                       rbtx49xx_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250227    gcc-14.2.0
nios2                 randconfig-002-20250227    gcc-14.2.0
openrisc                          allnoconfig    clang-15
openrisc                            defconfig    gcc-12
parisc                            allnoconfig    clang-15
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250227    gcc-14.2.0
parisc                randconfig-002-20250227    gcc-14.2.0
powerpc                           allnoconfig    clang-15
powerpc                      bamboo_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250227    clang-19
powerpc               randconfig-001-20250227    gcc-14.2.0
powerpc               randconfig-002-20250227    gcc-14.2.0
powerpc               randconfig-003-20250227    clang-19
powerpc               randconfig-003-20250227    gcc-14.2.0
powerpc64             randconfig-001-20250227    clang-17
powerpc64             randconfig-001-20250227    gcc-14.2.0
powerpc64             randconfig-002-20250227    clang-21
powerpc64             randconfig-002-20250227    gcc-14.2.0
powerpc64             randconfig-003-20250227    gcc-14.2.0
riscv                             allnoconfig    clang-15
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250227    gcc-14.2.0
riscv                 randconfig-002-20250227    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250227    clang-18
s390                  randconfig-001-20250227    gcc-14.2.0
s390                  randconfig-002-20250227    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20250227    gcc-14.2.0
sh                    randconfig-002-20250227    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250227    gcc-14.2.0
sparc                 randconfig-002-20250227    gcc-14.2.0
sparc                       sparc32_defconfig    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250227    gcc-14.2.0
sparc64               randconfig-002-20250227    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-15
um                               allyesconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250227    clang-17
um                    randconfig-001-20250227    gcc-14.2.0
um                    randconfig-002-20250227    gcc-12
um                    randconfig-002-20250227    gcc-14.2.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250227    clang-19
x86_64      buildonly-randconfig-002-20250227    clang-19
x86_64      buildonly-randconfig-003-20250227    clang-19
x86_64      buildonly-randconfig-003-20250227    gcc-12
x86_64      buildonly-randconfig-004-20250227    clang-19
x86_64      buildonly-randconfig-004-20250227    gcc-12
x86_64      buildonly-randconfig-005-20250227    clang-19
x86_64      buildonly-randconfig-006-20250227    clang-19
x86_64      buildonly-randconfig-006-20250227    gcc-12
x86_64                              defconfig    clang-19
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20250227    gcc-12
x86_64                randconfig-002-20250227    gcc-12
x86_64                randconfig-003-20250227    gcc-12
x86_64                randconfig-004-20250227    gcc-12
x86_64                randconfig-005-20250227    gcc-12
x86_64                randconfig-006-20250227    gcc-12
x86_64                randconfig-007-20250227    gcc-12
x86_64                randconfig-008-20250227    gcc-12
x86_64                randconfig-071-20250227    gcc-12
x86_64                randconfig-072-20250227    gcc-12
x86_64                randconfig-073-20250227    gcc-12
x86_64                randconfig-074-20250227    gcc-12
x86_64                randconfig-075-20250227    gcc-12
x86_64                randconfig-076-20250227    gcc-12
x86_64                randconfig-077-20250227    gcc-12
x86_64                randconfig-078-20250227    gcc-12
x86_64                               rhel-9.4    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                          iss_defconfig    gcc-14.2.0
xtensa                  nommu_kc705_defconfig    gcc-14.2.0
xtensa                randconfig-001-20250227    gcc-14.2.0
xtensa                randconfig-002-20250227    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

