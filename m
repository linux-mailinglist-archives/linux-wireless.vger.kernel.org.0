Return-Path: <linux-wireless+bounces-13027-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF65397CF34
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Sep 2024 00:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4953B22DF5
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Sep 2024 22:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6331A125A9;
	Thu, 19 Sep 2024 22:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UGRNymHF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7950D13B5A0
	for <linux-wireless@vger.kernel.org>; Thu, 19 Sep 2024 22:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726784490; cv=none; b=edglvTLzcLw/gYmQCOgZ00+5MiIcIwuKGz5XX+9j1ICXXAQBfWlZlZKkN13V9wLzE4Zk+pBg+voeSjk7s/zExU1y6W2PZROHSZAgv8sVOoL4cNdClub1FN6eYbGXHw0gdxDQN2hJwc26o+FS9aVAjXRlhL/ji1BOmtaUqfPBb38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726784490; c=relaxed/simple;
	bh=ORghBtT539o8ux8jAcOkdZmPZ5X9U4gnM343/a93AbQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=pJSSXb2ei3XMj3sJKR55IbiFqH4X2rgEPCVAL4NL1cmO4GtXlhQpwpz3lvuLU4hP2aAb3jZErpj1UD7S02ImOvZuTIjpJUEA0wjVkxuL9miqR/if/avl/54h8w0VF/eWNNEL59wzlrCQihSyFgpKDUpOnD3bGM5vHSqQXttPCxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UGRNymHF; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726784489; x=1758320489;
  h=date:from:to:cc:subject:message-id;
  bh=ORghBtT539o8ux8jAcOkdZmPZ5X9U4gnM343/a93AbQ=;
  b=UGRNymHFjloRsLi6uOUfrnHQN4hoSbgNdr3b2sdr2Y1bDvD4Gp104Ufy
   Oc5sefGyQ+JCjQDXvnkYFtXD6Ol0iSynqAVJVBIuFjuLFuUvm8tipliVD
   41vMYqDoqyzETZ37GtdGh7ZosVvWEjwAZHUlZIyngieHq/znreuCDpHmy
   C7TJ9Jajog1tRbyNbf75c9uCej1JItLE5kcgX4zVjPlIaQgxrqndctjnv
   1Qv21DtrcceUu4zXE9m23IH7OhJgCLgw5ls8rhIC0UjQNbOi498HZyzh8
   Omn/yi6zOzAn2vWpeKkGKxqIZhvmF7fUTfLh/pdmcCuAbmWQcH0kZX05T
   g==;
X-CSE-ConnectionGUID: BYXvRhXgTP23ZUfYudOrkg==
X-CSE-MsgGUID: WJGJ3RPFSzqa4bl012D9bg==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="37141901"
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; 
   d="scan'208";a="37141901"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 15:21:28 -0700
X-CSE-ConnectionGUID: 7RLQUAuvSlqNDisTKzPxDw==
X-CSE-MsgGUID: 1dOsqveZS+SYYNi3LXwD3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; 
   d="scan'208";a="74872562"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 19 Sep 2024 15:21:27 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1srPWe-000Dke-0D;
	Thu, 19 Sep 2024 22:21:24 +0000
Date: Fri, 20 Sep 2024 06:20:47 +0800
From: kernel test robot <lkp@intel.com>
To: Kalle Valo <kvalo@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless@vger.kernel.org
Subject: [wireless:for-next] BUILD SUCCESS
 d4cdc46ca16a5c78b36c5b9b6ad8cac09d6130a0
Message-ID: <202409200642.ZgqItqM7-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git for-next
branch HEAD: d4cdc46ca16a5c78b36c5b9b6ad8cac09d6130a0  wifi: iwlegacy: Fix "field-spanning write" warning in il_enqueue_hcmd()

elapsed time: 785m

configs tested: 167
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
alpha                               defconfig    gcc-14.1.0
arc                              alldefconfig    gcc-14.1.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                                 defconfig    gcc-14.1.0
arc                        nsim_700_defconfig    gcc-14.1.0
arc                   randconfig-001-20240919    gcc-13.2.0
arc                   randconfig-002-20240919    gcc-13.2.0
arc                    vdk_hs38_smp_defconfig    gcc-14.1.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                                 defconfig    gcc-14.1.0
arm                         lpc18xx_defconfig    gcc-14.1.0
arm                       multi_v4t_defconfig    gcc-14.1.0
arm                   randconfig-001-20240919    gcc-13.2.0
arm                   randconfig-002-20240919    gcc-13.2.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
arm64                 randconfig-001-20240919    gcc-13.2.0
arm64                 randconfig-004-20240919    gcc-13.2.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
csky                  randconfig-001-20240919    gcc-13.2.0
csky                  randconfig-002-20240919    gcc-13.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
hexagon               randconfig-001-20240919    gcc-13.2.0
hexagon               randconfig-002-20240919    gcc-13.2.0
i386                             allmodconfig    clang-18
i386                              allnoconfig    clang-18
i386                             allyesconfig    clang-18
i386        buildonly-randconfig-001-20240920    gcc-12
i386        buildonly-randconfig-002-20240920    gcc-12
i386        buildonly-randconfig-003-20240920    gcc-12
i386        buildonly-randconfig-004-20240920    gcc-12
i386        buildonly-randconfig-005-20240920    gcc-12
i386        buildonly-randconfig-006-20240920    gcc-12
i386                                defconfig    clang-18
i386                  randconfig-001-20240920    gcc-12
i386                  randconfig-002-20240920    gcc-12
i386                  randconfig-003-20240920    gcc-12
i386                  randconfig-004-20240920    gcc-12
i386                  randconfig-005-20240920    gcc-12
i386                  randconfig-006-20240920    gcc-12
i386                  randconfig-011-20240920    gcc-12
i386                  randconfig-012-20240920    gcc-12
i386                  randconfig-013-20240920    gcc-12
i386                  randconfig-014-20240920    gcc-12
i386                  randconfig-015-20240920    gcc-12
i386                  randconfig-016-20240920    gcc-12
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
loongarch             randconfig-001-20240919    gcc-13.2.0
loongarch             randconfig-002-20240919    gcc-13.2.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                          amiga_defconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                  maltasmvp_eva_defconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
nios2                 randconfig-001-20240919    gcc-13.2.0
nios2                 randconfig-002-20240919    gcc-13.2.0
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
openrisc                 simple_smp_defconfig    gcc-14.1.0
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc                generic-32bit_defconfig    gcc-14.1.0
parisc                randconfig-001-20240919    gcc-13.2.0
parisc                randconfig-002-20240919    gcc-13.2.0
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    gcc-14.1.0
powerpc                 mpc837x_rdb_defconfig    gcc-14.1.0
powerpc                       ppc64_defconfig    gcc-14.1.0
powerpc               randconfig-001-20240919    gcc-13.2.0
powerpc               randconfig-002-20240919    gcc-13.2.0
powerpc               randconfig-003-20240919    gcc-13.2.0
powerpc64             randconfig-001-20240919    gcc-13.2.0
powerpc64             randconfig-002-20240919    gcc-13.2.0
powerpc64             randconfig-003-20240919    gcc-13.2.0
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20240919    gcc-13.2.0
riscv                 randconfig-002-20240919    gcc-13.2.0
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20240919    gcc-13.2.0
s390                  randconfig-002-20240919    gcc-13.2.0
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                            migor_defconfig    gcc-14.1.0
sh                    randconfig-001-20240919    gcc-13.2.0
sh                    randconfig-002-20240919    gcc-13.2.0
sh                           se7206_defconfig    gcc-14.1.0
sh                            titan_defconfig    gcc-14.1.0
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20240919    gcc-13.2.0
sparc64               randconfig-002-20240919    gcc-13.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-002-20240919    gcc-13.2.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64      buildonly-randconfig-001-20240919    clang-18
x86_64      buildonly-randconfig-002-20240919    clang-18
x86_64      buildonly-randconfig-003-20240919    clang-18
x86_64      buildonly-randconfig-004-20240919    clang-18
x86_64      buildonly-randconfig-005-20240919    clang-18
x86_64      buildonly-randconfig-006-20240919    clang-18
x86_64                              defconfig    clang-18
x86_64                                  kexec    clang-18
x86_64                                  kexec    gcc-12
x86_64                randconfig-001-20240919    clang-18
x86_64                randconfig-002-20240919    clang-18
x86_64                randconfig-003-20240919    clang-18
x86_64                randconfig-004-20240919    clang-18
x86_64                randconfig-005-20240919    clang-18
x86_64                randconfig-006-20240919    clang-18
x86_64                randconfig-011-20240919    clang-18
x86_64                randconfig-012-20240919    clang-18
x86_64                randconfig-013-20240919    clang-18
x86_64                randconfig-014-20240919    clang-18
x86_64                randconfig-015-20240919    clang-18
x86_64                randconfig-016-20240919    clang-18
x86_64                randconfig-071-20240919    clang-18
x86_64                randconfig-072-20240919    clang-18
x86_64                randconfig-073-20240919    clang-18
x86_64                randconfig-074-20240919    clang-18
x86_64                randconfig-075-20240919    clang-18
x86_64                randconfig-076-20240919    clang-18
x86_64                               rhel-8.3    gcc-12
x86_64                          rhel-8.3-rust    clang-18
xtensa                            allnoconfig    gcc-14.1.0
xtensa                randconfig-001-20240919    gcc-13.2.0
xtensa                randconfig-002-20240919    gcc-13.2.0
xtensa                    smp_lx200_defconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

