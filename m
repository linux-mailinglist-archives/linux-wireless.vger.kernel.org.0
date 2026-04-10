Return-Path: <linux-wireless+bounces-34565-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ankbDraG2GmoeggAu9opvQ
	(envelope-from <linux-wireless+bounces-34565-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 07:12:22 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C330D3D23CB
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 07:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1BC6F3014689
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 05:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136772E8DEF;
	Fri, 10 Apr 2026 05:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="km1Pz1cj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8F22E6CA6
	for <linux-wireless@vger.kernel.org>; Fri, 10 Apr 2026 05:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775797938; cv=none; b=c2aYePHifKHKb0oUvejfFVAPhmTcfcVrwpWgmzHANpiO7LGfykEtvuEdm9GZUsdTxRx5EL8rqeMWSFsJN4PUwf9VufHHoYJIiGNs7OFfDMIq/7rkplfVT7grM9dvfrxXCXMur/R7USj1yLQhgCifzoR5CmxlTTwXUFKf76eKIvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775797938; c=relaxed/simple;
	bh=v5ZitDrASkfOFDTAZtYVEHjMxuc1Eph3I0i78yDsmIw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=XE316N11ATHaVYmHCOcdLtz3sR9MStY5UqZK6+VQKzc+DWSK14KTA4Fq31dMJ0RfPv75fGsb+3sylSnj3IoOZA7pqznJ9cMsegcZxf5v+dR0xwzODhCIXTMb3sLg/CoIfM3Uhj+k1j2ooAbevNX11Ice43FQmUjp6l5M1VNZRVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=km1Pz1cj; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775797936; x=1807333936;
  h=date:from:to:cc:subject:message-id;
  bh=v5ZitDrASkfOFDTAZtYVEHjMxuc1Eph3I0i78yDsmIw=;
  b=km1Pz1cjZDaIz8e36TzeuKQXP4v1Yjbm8pQP5ZoCWCjdtmbI2qFYyeh9
   8Bv0paxIKAviVIBmv+X+S+/pfScAIoFNwBuNcElf6CSd20IosoycFQBdX
   b5HjCOjk0eT6C19VyuE/y4zG89JLANj4mRTrTh09wrno9nVWy+4bBLgua
   lDCy9Y+b+hZQ0yaaJDlHIkD1Tmp3m+DA/CgNy3nK1ZA5gYu+WvnMWPX/n
   A5blbQJYTQkHees6U6OvxKu5fMKfgzbJKb6sEhyg9swUuuFemC3fQHyZN
   3QEmXPyAGdcnSRkGMFBbphgDjCXpUN48HYdqWiZwkAMSrv/nrnXZbFT/4
   A==;
X-CSE-ConnectionGUID: AepKVLJ6SeO7VB9/Keqb2A==
X-CSE-MsgGUID: 15G4TdmiTEKWkKXBcvgcMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11754"; a="88256595"
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="88256595"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 22:12:16 -0700
X-CSE-ConnectionGUID: YywCyFkTQUSaJIeI9dYzlA==
X-CSE-MsgGUID: ix3qA2KoS4upvKDYyDvgdA==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO 6449335cace3) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 09 Apr 2026 22:12:14 -0700
Received: from kbuild by 6449335cace3 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wB4A8-000000001n0-1kb9;
	Fri, 10 Apr 2026 05:12:12 +0000
Date: Fri, 10 Apr 2026 13:11:35 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 8c6d03b7a249ffe85ba2bda09a2a7614c0ff03db
Message-ID: <202604101330.0Qtyp7jK-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34565-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: C330D3D23CB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 8c6d03b7a249ffe85ba2bda09a2a7614c0ff03db  crypto: Remove michael_mic from crypto_shash API

elapsed time: 2681m

configs tested: 131
configs skipped: 20

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260408    gcc-8.5.0
arc                   randconfig-002-20260408    gcc-8.5.0
arm                               allnoconfig    clang-23
arm                              allyesconfig    gcc-15.2.0
arm                   randconfig-001-20260408    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-002-20260409    gcc-15.2.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260409    gcc-15.2.0
csky                  randconfig-002-20260409    gcc-11.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-23
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260409    clang-20
i386        buildonly-randconfig-002-20260409    clang-20
i386        buildonly-randconfig-003-20260409    gcc-14
i386        buildonly-randconfig-004-20260409    gcc-14
i386                                defconfig    clang-20
i386                  randconfig-011-20260409    clang-20
i386                  randconfig-012-20260409    clang-20
i386                  randconfig-013-20260409    clang-20
i386                  randconfig-014-20260409    gcc-14
i386                  randconfig-015-20260409    gcc-14
i386                  randconfig-016-20260409    clang-20
i386                  randconfig-017-20260409    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-23
loongarch             randconfig-001-20260409    clang-18
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260409    gcc-11.5.0
nios2                 randconfig-002-20260409    gcc-10.5.0
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260409    gcc-11.5.0
parisc                randconfig-002-20260409    gcc-11.5.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    gcc-15.2.0
powerpc                       ppc64_defconfig    clang-23
powerpc               randconfig-001-20260409    clang-16
powerpc               randconfig-002-20260409    gcc-8.5.0
powerpc64             randconfig-001-20260409    gcc-14.3.0
powerpc64             randconfig-002-20260409    gcc-10.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-23
riscv                 randconfig-001-20260409    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-15.2.0
sh                    randconfig-001-20260409    gcc-15.2.0
sh                    randconfig-002-20260409    gcc-13.4.0
sparc                             allnoconfig    gcc-15.2.0
sparc                 randconfig-001-20260409    gcc-8.5.0
sparc                 randconfig-002-20260409    gcc-11.5.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    clang-20
sparc64               randconfig-002-20260409    gcc-9.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                                  defconfig    clang-23
um                             i386_defconfig    gcc-14
um                    randconfig-002-20260409    gcc-14
um                           x86_64_defconfig    clang-23
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260409    clang-20
x86_64      buildonly-randconfig-002-20260409    clang-20
x86_64      buildonly-randconfig-003-20260409    clang-20
x86_64      buildonly-randconfig-004-20260409    clang-20
x86_64      buildonly-randconfig-005-20260409    gcc-14
x86_64      buildonly-randconfig-006-20260409    gcc-14
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20260408    gcc-14
x86_64                randconfig-002-20260408    gcc-14
x86_64                randconfig-003-20260408    gcc-14
x86_64                randconfig-004-20260408    gcc-14
x86_64                randconfig-005-20260408    gcc-14
x86_64                randconfig-011-20260409    clang-20
x86_64                randconfig-012-20260409    gcc-14
x86_64                randconfig-013-20260409    gcc-14
x86_64                randconfig-014-20260409    clang-20
x86_64                randconfig-015-20260409    gcc-14
x86_64                randconfig-016-20260409    gcc-14
x86_64                randconfig-071-20260408    clang-20
x86_64                randconfig-072-20260408    clang-20
x86_64                randconfig-073-20260408    clang-20
x86_64                randconfig-074-20260408    gcc-14
x86_64                randconfig-075-20260408    gcc-14
x86_64                randconfig-076-20260408    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    gcc-15.2.0
xtensa                randconfig-001-20260409    gcc-12.5.0
xtensa                randconfig-002-20260409    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

