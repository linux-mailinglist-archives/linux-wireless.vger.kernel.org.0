Return-Path: <linux-wireless+bounces-31608-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wI6WNaINhWms7wMAu9opvQ
	(envelope-from <linux-wireless+bounces-31608-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Feb 2026 22:37:38 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31613F7B5E
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Feb 2026 22:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B612D3010DBC
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Feb 2026 21:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D74331A49;
	Thu,  5 Feb 2026 21:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fl9jR8Ow"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757A12FDC47
	for <linux-wireless@vger.kernel.org>; Thu,  5 Feb 2026 21:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770327455; cv=none; b=p9wfkCyIeMnSbK7NfFee3rhtUP52K/uSiGcY3vVEUDDesJydR/q6rNITWOXK2EeKUEB85rgeYgzoAlT0wLSsQyHIDCTWTIyDz1va2Z9iHGO9647X2h1lJ2CO0NCGNv/nU6igsU+pS3hx/me9WtfFaYXP1Mw14FZ/YlPGSrkR1wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770327455; c=relaxed/simple;
	bh=Twb0SprjF0yOLUk9dx16/7nkJqqmpPtXMzLS51GogHE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Jd3qOgb5nObvXIuCJ3SUDQ2LD/X55A/F2tTzzPNUdaJ/LPToma5hbICctMKXXg6BXwnEhF2oeNZNk2YN+VkUT9sMwIZC0ACAsO19B5Nx1IWROnt+TKI/jZjnFGLvJicXf1oM6Et8FMVuscNJbfpE/6d5bS0vREVj2112Zv94588=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fl9jR8Ow; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770327455; x=1801863455;
  h=date:from:to:cc:subject:message-id;
  bh=Twb0SprjF0yOLUk9dx16/7nkJqqmpPtXMzLS51GogHE=;
  b=fl9jR8OwYbLodSMZMvVIqjofi40+IUNrk+5cKyOSJ5vBWoYBF8rsYXqM
   8DqkKzYwPCC7zrdrGBqIhWFQ7eP26IPShKF5BoflIuLuV7Vle2Vo9UUHL
   QW3pM00pSNnEY++Ba1CrxtvG84DoiEE/Dvwk2ijKFArunQNJPVKe+sh7H
   TTIdCmC7fZmqo/VOkXQ9xcTwdaTE3wnX5gYMXDszY+aojopJTYRnSN1LY
   LmQYu2YXAr+dRysrzL3FoLpvgRoI4Owy60Sr7rPdqsgPJGF/Eo2ifbXTF
   OeXWTflwnA2SPrP4mlrVaoFrksBzhTG0EBlb8D9rsgfnjS/q9qfkYcPVd
   w==;
X-CSE-ConnectionGUID: CW3NT3sOTYeRjaZihTpz+Q==
X-CSE-MsgGUID: EyMZlw93T72wwdgjk0PiQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11692"; a="59108941"
X-IronPort-AV: E=Sophos;i="6.21,275,1763452800"; 
   d="scan'208";a="59108941"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 13:37:35 -0800
X-CSE-ConnectionGUID: gHc6dQXuTNOj9QLU+67cjQ==
X-CSE-MsgGUID: HJUzqlRQS6apMxh18XLGCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,275,1763452800"; 
   d="scan'208";a="241360532"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 05 Feb 2026 13:37:33 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vo72Y-00000000kEi-3adk;
	Thu, 05 Feb 2026 21:37:30 +0000
Date: Fri, 06 Feb 2026 05:37:23 +0800
From: kernel test robot <lkp@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 333225e1e9ead7b06e5363389403bdac72ba3046
Message-ID: <202602060514.zWf7M185-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31608-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 31613F7B5E
X-Rspamd-Action: no action

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 333225e1e9ead7b06e5363389403bdac72ba3046  Merge tag 'wireless-next-2026-02-04' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next

elapsed time: 722m

configs tested: 352
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-22
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260205    gcc-8.5.0
arc                   randconfig-001-20260206    gcc-8.5.0
arc                   randconfig-002-20260205    gcc-8.5.0
arc                   randconfig-002-20260206    gcc-8.5.0
arm                               allnoconfig    clang-22
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    clang-22
arm                                 defconfig    gcc-15.2.0
arm                          ep93xx_defconfig    clang-22
arm                      jornada720_defconfig    clang-22
arm                       multi_v4t_defconfig    gcc-15.2.0
arm                   randconfig-001-20260205    clang-22
arm                   randconfig-001-20260205    gcc-8.5.0
arm                   randconfig-001-20260206    gcc-8.5.0
arm                   randconfig-002-20260205    gcc-8.5.0
arm                   randconfig-002-20260206    gcc-8.5.0
arm                   randconfig-003-20260205    clang-22
arm                   randconfig-003-20260205    gcc-8.5.0
arm                   randconfig-003-20260206    gcc-8.5.0
arm                   randconfig-004-20260205    gcc-8.5.0
arm                   randconfig-004-20260206    gcc-8.5.0
arm                          sp7021_defconfig    gcc-15.2.0
arm                       spear13xx_defconfig    gcc-15.2.0
arm                           sunxi_defconfig    clang-22
arm                         vf610m4_defconfig    clang-22
arm                    vt8500_v6_v7_defconfig    clang-22
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260205    clang-22
arm64                 randconfig-001-20260205    gcc-10.5.0
arm64                 randconfig-001-20260206    gcc-13.4.0
arm64                 randconfig-002-20260205    gcc-10.5.0
arm64                 randconfig-002-20260206    gcc-13.4.0
arm64                 randconfig-003-20260205    clang-22
arm64                 randconfig-003-20260205    gcc-10.5.0
arm64                 randconfig-003-20260206    gcc-13.4.0
arm64                 randconfig-004-20260205    clang-19
arm64                 randconfig-004-20260205    gcc-10.5.0
arm64                 randconfig-004-20260206    gcc-13.4.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260205    gcc-10.5.0
csky                  randconfig-001-20260205    gcc-9.5.0
csky                  randconfig-001-20260206    gcc-13.4.0
csky                  randconfig-002-20260205    gcc-10.5.0
csky                  randconfig-002-20260206    gcc-13.4.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-22
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    clang-22
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260205    clang-22
hexagon               randconfig-001-20260205    gcc-15.2.0
hexagon               randconfig-001-20260206    clang-22
hexagon               randconfig-002-20260205    clang-22
hexagon               randconfig-002-20260205    gcc-15.2.0
hexagon               randconfig-002-20260206    clang-22
i386                             alldefconfig    clang-22
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260205    gcc-13
i386        buildonly-randconfig-001-20260205    gcc-14
i386        buildonly-randconfig-001-20260206    clang-20
i386        buildonly-randconfig-002-20260205    clang-20
i386        buildonly-randconfig-002-20260205    gcc-14
i386        buildonly-randconfig-002-20260206    clang-20
i386        buildonly-randconfig-003-20260205    clang-20
i386        buildonly-randconfig-003-20260205    gcc-14
i386        buildonly-randconfig-003-20260206    clang-20
i386        buildonly-randconfig-004-20260205    clang-20
i386        buildonly-randconfig-004-20260205    gcc-14
i386        buildonly-randconfig-004-20260206    clang-20
i386        buildonly-randconfig-005-20260205    gcc-14
i386        buildonly-randconfig-005-20260206    clang-20
i386        buildonly-randconfig-006-20260205    gcc-14
i386        buildonly-randconfig-006-20260206    clang-20
i386                                defconfig    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260205    gcc-13
i386                  randconfig-001-20260205    gcc-14
i386                  randconfig-001-20260206    gcc-14
i386                  randconfig-002-20260205    clang-20
i386                  randconfig-002-20260205    gcc-13
i386                  randconfig-002-20260206    gcc-14
i386                  randconfig-003-20260205    gcc-13
i386                  randconfig-003-20260206    gcc-14
i386                  randconfig-004-20260205    gcc-13
i386                  randconfig-004-20260205    gcc-14
i386                  randconfig-004-20260206    gcc-14
i386                  randconfig-005-20260205    clang-20
i386                  randconfig-005-20260205    gcc-13
i386                  randconfig-005-20260206    gcc-14
i386                  randconfig-006-20260205    gcc-13
i386                  randconfig-006-20260206    gcc-14
i386                  randconfig-007-20260205    gcc-13
i386                  randconfig-007-20260205    gcc-14
i386                  randconfig-007-20260206    gcc-14
i386                  randconfig-011-20260205    clang-20
i386                  randconfig-011-20260205    gcc-14
i386                  randconfig-011-20260206    clang-20
i386                  randconfig-012-20260205    clang-20
i386                  randconfig-012-20260206    clang-20
i386                  randconfig-013-20260205    clang-20
i386                  randconfig-013-20260205    gcc-14
i386                  randconfig-013-20260206    clang-20
i386                  randconfig-014-20260205    clang-20
i386                  randconfig-014-20260206    clang-20
i386                  randconfig-015-20260205    clang-20
i386                  randconfig-015-20260205    gcc-14
i386                  randconfig-015-20260206    clang-20
i386                  randconfig-016-20260205    clang-20
i386                  randconfig-016-20260206    clang-20
i386                  randconfig-017-20260205    clang-20
i386                  randconfig-017-20260205    gcc-14
i386                  randconfig-017-20260206    clang-20
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    clang-22
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260205    clang-22
loongarch             randconfig-001-20260205    gcc-15.2.0
loongarch             randconfig-001-20260206    clang-22
loongarch             randconfig-002-20260205    gcc-15.2.0
loongarch             randconfig-002-20260206    clang-22
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                         apollo_defconfig    gcc-15.2.0
m68k                          atari_defconfig    gcc-15.2.0
m68k                                defconfig    clang-19
m68k                                defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
microblaze                          defconfig    gcc-15.2.0
microblaze                      mmu_defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                  cavium_octeon_defconfig    clang-22
mips                           ip22_defconfig    clang-22
mips                malta_qemu_32r6_defconfig    gcc-15.2.0
mips                        maltaup_defconfig    gcc-15.2.0
nios2                            allmodconfig    clang-22
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260205    gcc-11.5.0
nios2                 randconfig-001-20260205    gcc-15.2.0
nios2                 randconfig-001-20260206    clang-22
nios2                 randconfig-002-20260205    gcc-11.5.0
nios2                 randconfig-002-20260205    gcc-15.2.0
nios2                 randconfig-002-20260206    clang-22
openrisc                         allmodconfig    clang-22
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
openrisc                       virt_defconfig    clang-22
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260205    gcc-9.5.0
parisc                randconfig-001-20260206    gcc-8.5.0
parisc                randconfig-002-20260205    gcc-8.5.0
parisc                randconfig-002-20260205    gcc-9.5.0
parisc                randconfig-002-20260206    gcc-8.5.0
parisc64                            defconfig    clang-19
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.2.0
powerpc                     asp8347_defconfig    clang-22
powerpc                 canyonlands_defconfig    clang-22
powerpc                   currituck_defconfig    clang-22
powerpc                       eiger_defconfig    gcc-15.2.0
powerpc                  iss476-smp_defconfig    clang-22
powerpc                 mpc832x_rdb_defconfig    gcc-15.2.0
powerpc                      pmac32_defconfig    clang-22
powerpc                         ps3_defconfig    gcc-15.2.0
powerpc               randconfig-001-20260205    gcc-15.2.0
powerpc               randconfig-001-20260205    gcc-9.5.0
powerpc               randconfig-001-20260206    gcc-8.5.0
powerpc               randconfig-002-20260205    clang-16
powerpc               randconfig-002-20260205    gcc-9.5.0
powerpc               randconfig-002-20260206    gcc-8.5.0
powerpc                      tqm8xx_defconfig    clang-22
powerpc64             randconfig-001-20260205    clang-22
powerpc64             randconfig-001-20260205    gcc-9.5.0
powerpc64             randconfig-001-20260206    gcc-8.5.0
powerpc64             randconfig-002-20260205    clang-22
powerpc64             randconfig-002-20260205    gcc-9.5.0
powerpc64             randconfig-002-20260206    gcc-8.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260205    clang-19
riscv                 randconfig-001-20260206    clang-22
riscv                 randconfig-002-20260205    clang-19
riscv                 randconfig-002-20260205    clang-22
riscv                 randconfig-002-20260206    clang-22
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260205    clang-18
s390                  randconfig-001-20260205    clang-19
s390                  randconfig-001-20260206    clang-22
s390                  randconfig-002-20260205    clang-19
s390                  randconfig-002-20260205    clang-22
s390                  randconfig-002-20260206    clang-22
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-22
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260205    clang-19
sh                    randconfig-001-20260205    gcc-15.2.0
sh                    randconfig-001-20260206    clang-22
sh                    randconfig-002-20260205    clang-19
sh                    randconfig-002-20260205    gcc-10.5.0
sh                    randconfig-002-20260206    clang-22
sh                   secureedge5410_defconfig    gcc-15.2.0
sh                            shmin_defconfig    clang-22
sparc                            alldefconfig    gcc-15.2.0
sparc                             allnoconfig    clang-22
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260205    gcc-12.5.0
sparc                 randconfig-001-20260205    gcc-15.2.0
sparc                 randconfig-001-20260206    gcc-12.5.0
sparc                 randconfig-002-20260205    gcc-12.5.0
sparc                 randconfig-002-20260206    gcc-12.5.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260205    gcc-12.5.0
sparc64               randconfig-001-20260205    gcc-8.5.0
sparc64               randconfig-001-20260206    gcc-12.5.0
sparc64               randconfig-002-20260205    gcc-12.5.0
sparc64               randconfig-002-20260205    gcc-8.5.0
sparc64               randconfig-002-20260206    gcc-12.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260205    clang-22
um                    randconfig-001-20260205    gcc-12.5.0
um                    randconfig-001-20260206    gcc-12.5.0
um                    randconfig-002-20260205    gcc-12.5.0
um                    randconfig-002-20260205    gcc-13
um                    randconfig-002-20260206    gcc-12.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260205    clang-20
x86_64      buildonly-randconfig-001-20260205    gcc-14
x86_64      buildonly-randconfig-001-20260206    gcc-14
x86_64      buildonly-randconfig-002-20260205    clang-20
x86_64      buildonly-randconfig-002-20260205    gcc-14
x86_64      buildonly-randconfig-002-20260206    gcc-14
x86_64      buildonly-randconfig-003-20260205    gcc-14
x86_64      buildonly-randconfig-003-20260206    gcc-14
x86_64      buildonly-randconfig-004-20260205    clang-20
x86_64      buildonly-randconfig-004-20260205    gcc-14
x86_64      buildonly-randconfig-004-20260206    gcc-14
x86_64      buildonly-randconfig-005-20260205    clang-20
x86_64      buildonly-randconfig-005-20260205    gcc-14
x86_64      buildonly-randconfig-005-20260206    gcc-14
x86_64      buildonly-randconfig-006-20260205    gcc-14
x86_64      buildonly-randconfig-006-20260206    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260205    clang-20
x86_64                randconfig-001-20260205    gcc-12
x86_64                randconfig-002-20260205    clang-20
x86_64                randconfig-003-20260205    clang-20
x86_64                randconfig-004-20260205    clang-20
x86_64                randconfig-005-20260205    clang-20
x86_64                randconfig-005-20260205    gcc-14
x86_64                randconfig-006-20260205    clang-20
x86_64                randconfig-011-20260205    clang-20
x86_64                randconfig-012-20260205    clang-20
x86_64                randconfig-012-20260205    gcc-14
x86_64                randconfig-013-20260205    clang-20
x86_64                randconfig-013-20260205    gcc-14
x86_64                randconfig-014-20260205    clang-20
x86_64                randconfig-015-20260205    clang-20
x86_64                randconfig-015-20260205    gcc-14
x86_64                randconfig-016-20260205    clang-20
x86_64                randconfig-071-20260205    clang-20
x86_64                randconfig-071-20260206    gcc-14
x86_64                randconfig-072-20260205    clang-20
x86_64                randconfig-072-20260206    gcc-14
x86_64                randconfig-073-20260205    clang-20
x86_64                randconfig-073-20260206    gcc-14
x86_64                randconfig-074-20260205    clang-20
x86_64                randconfig-074-20260206    gcc-14
x86_64                randconfig-075-20260205    clang-20
x86_64                randconfig-075-20260206    gcc-14
x86_64                randconfig-076-20260205    clang-20
x86_64                randconfig-076-20260206    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-22
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    clang-22
xtensa                           allyesconfig    gcc-15.2.0
xtensa                  cadence_csp_defconfig    clang-22
xtensa                randconfig-001-20260205    gcc-12.5.0
xtensa                randconfig-001-20260205    gcc-8.5.0
xtensa                randconfig-001-20260206    gcc-12.5.0
xtensa                randconfig-002-20260205    gcc-12.5.0
xtensa                randconfig-002-20260206    gcc-12.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

