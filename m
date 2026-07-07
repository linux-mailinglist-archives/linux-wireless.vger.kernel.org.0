Return-Path: <linux-wireless+bounces-38771-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +dp/L8SHTWrR1gEAu9opvQ
	(envelope-from <linux-wireless+bounces-38771-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Jul 2026 01:12:04 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 09091720557
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Jul 2026 01:12:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=Bk8ynB8w;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38771-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38771-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5E2830330B1
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jul 2026 23:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6468301719;
	Tue,  7 Jul 2026 23:11:38 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CA742087C
	for <linux-wireless@vger.kernel.org>; Tue,  7 Jul 2026 23:11:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783465898; cv=none; b=QQLGR38ENb3lkdNloi1HTM3iSHtHdlM8UoaeTsQCsod6OZ6iaH6fkeyrIcdMUFsZE4XxQM/P9EPu2cD4Dujh3uGkYOIilPCOoApFBAB8NG5Cf4NOzVKG1ISQMG+Pm23+hRDfTTJ5lSJ7NEC3fp98q6U9W0Uqwc/FvHYpb8X3fuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783465898; c=relaxed/simple;
	bh=rdkJVCA6IBYLdyP+37rOTXMdWjUCwR7Jn9SreOKRmBM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=M0vXc9tjT4XuYD3ZL5spKUT2SjfKPFteSalyHBoRtFsqfVL5Q484K7LL4TLxaLcD7E3v47h7kHFoVKxglU5Pi4ZnxEMs7nWonA4sQ50z4MhtxPUq0fxC+M3VP+5ZbrdWNkON63as4Qb18oRVHQD5HES4439eSpc9okSMy6mjmEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bk8ynB8w; arc=none smtp.client-ip=198.175.65.18
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783465898; x=1815001898;
  h=date:from:to:cc:subject:message-id;
  bh=rdkJVCA6IBYLdyP+37rOTXMdWjUCwR7Jn9SreOKRmBM=;
  b=Bk8ynB8wDtfjxSh92usUa+zn4KTRaOVOlCUHJvFkwU40hem3+ztnmpCw
   7usDXUS9o+smRTW59H6OZibK7gq5B26mHmDhkQLNsB8K6SikakyF37uYq
   MmhvXLJgdQKzsZyTQ4zmLT2PvRq+Yi5zrAEEYSBVSJBrojUTU3kQWwn+a
   oifOMeZgSJJzwv+XK9ZpCt4G/usgNoMyw5ejhVI4yYLFf15dnVO9zkEjw
   wszlsjMo4oErRJHXTvUzaosZ5v/uJ8EpxFItTSBl+g0ju0kqppf1n+zOU
   2uJgKctDebtITo8YEKZUIVgbFRAKpuGtAV07cylFIlOOc/yZXtJB7px4g
   g==;
X-CSE-ConnectionGUID: nO+8pAU3QBaJf64K3eHGAQ==
X-CSE-MsgGUID: zRUF9rosQd6cvcXkGrErJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="84219760"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="84219760"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 16:11:37 -0700
X-CSE-ConnectionGUID: A/J5ZS/5QWu5cHEb5fD5Vw==
X-CSE-MsgGUID: +IAm96/+R9iCaoNaG1SySA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="292312307"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 07 Jul 2026 16:11:35 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1whEwq-00000000FkZ-3rbN;
	Tue, 07 Jul 2026 23:11:30 +0000
Date: Wed, 08 Jul 2026 07:10:30 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 ac798f757d6475dc6fee2ec899980d6740714596
Message-ID: <202607080719.vj2RY8Zq-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38771-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:johannes.berg@intel.com,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lkp@intel.com,linux-wireless@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:from_mime,intel.com:dkim,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 09091720557

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: ac798f757d6475dc6fee2ec899980d6740714596  wifi: mac80211: Route (Re)association req/response to per-STA queue

elapsed time: 874m

configs tested: 224
configs skipped: 59

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-16.1.0
alpha                            allyesconfig    gcc-16.1.0
alpha                               defconfig    gcc-16.1.0
arc                              alldefconfig    gcc-16.1.0
arc                              allmodconfig    clang-23
arc                              allmodconfig    gcc-16.1.0
arc                               allnoconfig    gcc-16.1.0
arc                              allyesconfig    clang-23
arc                              allyesconfig    gcc-16.1.0
arc                                 defconfig    gcc-16.1.0
arc                   randconfig-001-20260708    gcc-13.4.0
arc                   randconfig-002-20260708    gcc-13.4.0
arm                               allnoconfig    clang-17
arm                               allnoconfig    gcc-16.1.0
arm                              allyesconfig    clang-23
arm                              allyesconfig    gcc-16.1.0
arm                                 defconfig    gcc-16.1.0
arm                   randconfig-001-20260708    gcc-13.4.0
arm                   randconfig-002-20260708    gcc-13.4.0
arm                   randconfig-003-20260708    gcc-13.4.0
arm                   randconfig-004-20260708    gcc-13.4.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                 randconfig-001-20260708    clang-23
arm64                 randconfig-001-20260708    gcc-9.5.0
arm64                 randconfig-002-20260708    clang-23
arm64                 randconfig-002-20260708    gcc-9.5.0
arm64                 randconfig-003-20260708    gcc-9.5.0
arm64                 randconfig-004-20260708    gcc-15.2.0
arm64                 randconfig-004-20260708    gcc-9.5.0
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                  randconfig-001-20260708    gcc-9.5.0
csky                  randconfig-002-20260708    gcc-9.5.0
hexagon                          allmodconfig    clang-23
hexagon                          allmodconfig    gcc-16.1.0
hexagon                           allnoconfig    gcc-16.1.0
hexagon                             defconfig    gcc-16.1.0
hexagon               randconfig-001-20260707    clang-18
hexagon               randconfig-001-20260708    gcc-13.4.0
hexagon               randconfig-002-20260707    clang-18
hexagon               randconfig-002-20260708    gcc-13.4.0
i386                             allmodconfig    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-16.1.0
i386                             allyesconfig    clang-22
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260707    clang-22
i386        buildonly-randconfig-001-20260708    clang-22
i386        buildonly-randconfig-002-20260707    clang-22
i386        buildonly-randconfig-002-20260708    clang-22
i386        buildonly-randconfig-003-20260707    clang-22
i386        buildonly-randconfig-003-20260708    clang-22
i386        buildonly-randconfig-004-20260707    clang-22
i386        buildonly-randconfig-004-20260708    clang-22
i386        buildonly-randconfig-005-20260707    clang-22
i386        buildonly-randconfig-005-20260708    clang-22
i386        buildonly-randconfig-006-20260707    clang-22
i386        buildonly-randconfig-006-20260708    clang-22
i386                                defconfig    gcc-16.1.0
i386                  randconfig-001-20260708    clang-22
i386                  randconfig-002-20260708    clang-22
i386                  randconfig-003-20260708    clang-22
i386                  randconfig-004-20260708    clang-22
i386                  randconfig-005-20260708    clang-22
i386                  randconfig-006-20260708    clang-22
i386                  randconfig-007-20260708    clang-22
i386                           randconfig-011    gcc-14
i386                  randconfig-011-20260707    gcc-14
i386                           randconfig-012    gcc-14
i386                  randconfig-012-20260707    gcc-14
i386                           randconfig-013    gcc-14
i386                  randconfig-013-20260707    gcc-14
i386                           randconfig-014    gcc-14
i386                  randconfig-014-20260707    gcc-14
i386                           randconfig-015    gcc-14
i386                  randconfig-015-20260707    gcc-14
i386                           randconfig-016    gcc-14
i386                  randconfig-016-20260707    gcc-14
i386                           randconfig-017    gcc-14
i386                  randconfig-017-20260707    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    gcc-16.1.0
loongarch                           defconfig    clang-23
loongarch             randconfig-001-20260707    clang-18
loongarch             randconfig-001-20260708    gcc-13.4.0
loongarch             randconfig-002-20260707    clang-18
loongarch             randconfig-002-20260708    gcc-13.4.0
m68k                             allmodconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-16.1.0
m68k                             allyesconfig    clang-23
m68k                             allyesconfig    gcc-16.1.0
m68k                                defconfig    clang-23
microblaze                        allnoconfig    gcc-16.1.0
microblaze                       allyesconfig    gcc-16.1.0
microblaze                          defconfig    clang-23
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                             allyesconfig    gcc-16.1.0
nios2                            allmodconfig    clang-20
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-23
nios2                 randconfig-001-20260707    clang-18
nios2                 randconfig-001-20260708    gcc-13.4.0
nios2                 randconfig-002-20260707    clang-18
nios2                 randconfig-002-20260708    gcc-13.4.0
openrisc                         allmodconfig    clang-20
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-16.1.0
openrisc                            defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-16.1.0
parisc                           allyesconfig    clang-17
parisc                           allyesconfig    gcc-16.1.0
parisc                              defconfig    gcc-16.1.0
parisc                randconfig-001-20260707    clang-22
parisc                randconfig-001-20260708    clang-22
parisc                randconfig-002-20260707    clang-22
parisc                randconfig-002-20260708    clang-22
parisc64                            defconfig    clang-23
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-16.1.0
powerpc                      bamboo_defconfig    clang-21
powerpc               randconfig-001-20260707    clang-22
powerpc               randconfig-001-20260708    clang-22
powerpc               randconfig-002-20260707    clang-22
powerpc               randconfig-002-20260708    clang-22
powerpc64             randconfig-001-20260707    clang-22
powerpc64             randconfig-001-20260708    clang-22
powerpc64             randconfig-002-20260707    clang-22
powerpc64             randconfig-002-20260708    clang-22
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-16.1.0
riscv                            allyesconfig    clang-23
riscv                               defconfig    gcc-16.1.0
riscv                 randconfig-001-20260708    clang-23
riscv                 randconfig-002-20260708    clang-23
s390                             allmodconfig    clang-17
s390                             allmodconfig    clang-23
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    gcc-16.1.0
s390                  randconfig-001-20260708    clang-23
s390                  randconfig-002-20260708    clang-23
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-16.1.0
sh                               allyesconfig    clang-17
sh                               allyesconfig    gcc-16.1.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260708    clang-23
sh                    randconfig-002-20260708    clang-23
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-16.1.0
sparc                               defconfig    gcc-16.1.0
sparc                 randconfig-001-20260708    gcc-8.5.0
sparc                 randconfig-002-20260708    gcc-8.5.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260708    gcc-8.5.0
sparc64               randconfig-002-20260708    gcc-8.5.0
um                               allmodconfig    clang-17
um                                allnoconfig    clang-17
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-16.1.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260708    gcc-8.5.0
um                    randconfig-002-20260708    gcc-8.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-22
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-22
x86_64      buildonly-randconfig-001-20260708    gcc-12
x86_64      buildonly-randconfig-002-20260708    gcc-12
x86_64      buildonly-randconfig-003-20260708    gcc-12
x86_64      buildonly-randconfig-004-20260708    gcc-12
x86_64      buildonly-randconfig-005-20260708    gcc-12
x86_64      buildonly-randconfig-006-20260708    gcc-12
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20260708    gcc-14
x86_64                randconfig-002-20260708    gcc-14
x86_64                randconfig-003-20260708    gcc-14
x86_64                randconfig-004-20260708    gcc-14
x86_64                randconfig-005-20260708    gcc-14
x86_64                randconfig-006-20260708    gcc-14
x86_64                randconfig-011-20260707    clang-22
x86_64                randconfig-011-20260708    clang-22
x86_64                randconfig-012-20260707    clang-22
x86_64                randconfig-012-20260708    clang-22
x86_64                randconfig-013-20260707    clang-22
x86_64                randconfig-013-20260708    clang-22
x86_64                randconfig-014-20260707    clang-22
x86_64                randconfig-014-20260708    clang-22
x86_64                randconfig-015-20260707    clang-22
x86_64                randconfig-015-20260708    clang-22
x86_64                randconfig-016-20260707    clang-22
x86_64                randconfig-016-20260708    clang-22
x86_64                randconfig-071-20260708    clang-22
x86_64                randconfig-072-20260708    clang-22
x86_64                randconfig-073-20260708    clang-22
x86_64                randconfig-074-20260708    clang-22
x86_64                randconfig-075-20260708    clang-22
x86_64                randconfig-076-20260708    clang-22
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-22
xtensa                            allnoconfig    clang-23
xtensa                            allnoconfig    gcc-16.1.0
xtensa                           allyesconfig    clang-20
xtensa                          iss_defconfig    gcc-16.1.0
xtensa                randconfig-001-20260708    gcc-8.5.0
xtensa                randconfig-002-20260708    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

