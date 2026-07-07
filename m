Return-Path: <linux-wireless+bounces-38716-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZSxaGtNaTGo0jgEAu9opvQ
	(envelope-from <linux-wireless+bounces-38716-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Jul 2026 03:48:03 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF50716ABC
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Jul 2026 03:48:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=Gu+ProE7;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38716-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38716-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DD487302732E
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jul 2026 01:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF08B2FC037;
	Tue,  7 Jul 2026 01:47:59 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6611624DF
	for <linux-wireless@vger.kernel.org>; Tue,  7 Jul 2026 01:47:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783388879; cv=none; b=CfFsdC8PpWEdSRyqvn72ZfIzc8wG/AW7S89LGBYpiFdbLwB18APjtgrnqD8KwPaXK//yO0agdl+n+3BJr8drD31ZiyQsjNY11z2i/3alpGqqJ1QMotAO9b2Gc+gK8Qm61ChAwwltK5PpYPRnhE4OrhMWQZ21WH3UD/BLQiClEuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783388879; c=relaxed/simple;
	bh=j394IDDScrauKr9JXqZoL2SSwbrcc7FTzPWCE4XPAVw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=HRK2Kn9jZXhk29P/t4Ckn5r0bwH/QGXuTvpZgf45EsDcLQW/Y/SU61TwLAPSovBt4NiWkicSrwL8uRi580apPtlgMDN0MYVkhmb4hHnOufX0Fytvy9UpZBilaV4kudX+B8JIO2zmAq0F8vaEYUSAoqtK9THOZbaTwFfSNW0qWMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gu+ProE7; arc=none smtp.client-ip=198.175.65.16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783388877; x=1814924877;
  h=date:from:to:cc:subject:message-id;
  bh=j394IDDScrauKr9JXqZoL2SSwbrcc7FTzPWCE4XPAVw=;
  b=Gu+ProE7cnlA+VgFZzFKAX2hSzgYWeAauBg61octEF0A3Ayir5auCY7s
   ff8swgZ9y/accRb4o+2yHqbtgjZeUzXFonRbvDJ70BRzzYEg8y9xcGTnN
   7/s+IYCymLiQqkV9eTq52jXu9hhdPg4fbP+AleUYSTUvpFKJ8Rpdqh3dl
   60/X/xcwnAH8fNkRwNeJCTHFPek7T7ySWbSGWqWr14sGfJUoiO7F9Fy2r
   kDVSYmxJrC/BDLcnAf/2xoOo0EVA24ufLLxS7q6293+txVnAfCa6HxDiy
   hiaC6D2fk+wLGz3OHtiQhsgATqTUAcQc7hWd6+AgCBD6jNWLc02gl2Upf
   g==;
X-CSE-ConnectionGUID: qjNk3BoJQ12lmotAqCcdmw==
X-CSE-MsgGUID: trO2ZU3aQ+GDJNVwwrLQxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11839"; a="84218634"
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="84218634"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 18:47:57 -0700
X-CSE-ConnectionGUID: 12+a9ltjT0euq1WbWim/lQ==
X-CSE-MsgGUID: 4LMNmpLeQ7GmDJ/dE8Hk/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="253393303"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 06 Jul 2026 18:47:55 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wguue-00000000Evv-3PM1;
	Tue, 07 Jul 2026 01:47:52 +0000
Date: Tue, 07 Jul 2026 09:47:26 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: linux-wireless@vger.kernel.org
Subject: [wireless:for-next] BUILD SUCCESS
 4a360c6e18dfa9d70006c7247a6a8cc8dfe0d60f
Message-ID: <202607070914.3K8GP1aa-lkp@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38716-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:from_mime,intel.com:dkim,intel.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CCF50716ABC

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git for-next
branch HEAD: 4a360c6e18dfa9d70006c7247a6a8cc8dfe0d60f  wifi: mac80211: validate deauth frame length before reason access

elapsed time: 800m

configs tested: 148
configs skipped: 20

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-16.1.0
alpha                            allyesconfig    gcc-16.1.0
arc                              allmodconfig    gcc-16.1.0
arc                               allnoconfig    gcc-16.1.0
arc                              allyesconfig    gcc-16.1.0
arc                   randconfig-001-20260707    gcc-14.3.0
arc                   randconfig-002-20260707    gcc-12.5.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-16.1.0
arm                          pxa168_defconfig    clang-23
arm                   randconfig-001-20260707    gcc-8.5.0
arm                   randconfig-002-20260707    clang-17
arm                   randconfig-003-20260707    clang-17
arm                   randconfig-004-20260707    clang-23
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-16.1.0
arm64                 randconfig-001-20260707    clang-23
arm64                 randconfig-002-20260707    clang-18
arm64                 randconfig-003-20260707    clang-23
arm64                 randconfig-004-20260707    clang-17
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                  randconfig-001-20260707    gcc-16.1.0
csky                  randconfig-002-20260707    gcc-16.1.0
hexagon                          allmodconfig    clang-23
hexagon                           allnoconfig    clang-23
hexagon               randconfig-001-20260707    clang-23
hexagon               randconfig-002-20260707    clang-18
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-004-20260707    gcc-14
i386                           randconfig-001    clang-22
i386                  randconfig-001-20260707    gcc-13
i386                           randconfig-002    gcc-14
i386                  randconfig-002-20260707    clang-22
i386                           randconfig-003    gcc-14
i386                  randconfig-003-20260707    clang-22
i386                           randconfig-004    clang-22
i386                  randconfig-004-20260707    gcc-14
i386                           randconfig-005    gcc-14
i386                  randconfig-005-20260707    clang-22
i386                           randconfig-006    gcc-14
i386                  randconfig-006-20260707    clang-22
i386                           randconfig-007    gcc-14
i386                  randconfig-007-20260707    clang-22
i386                  randconfig-012-20260707    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-20
loongarch                           defconfig    clang-23
loongarch             randconfig-001-20260707    clang-18
loongarch             randconfig-002-20260707    clang-19
m68k                             allmodconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-16.1.0
m68k                             allyesconfig    gcc-16.1.0
m68k                                defconfig    gcc-16.1.0
microblaze                        allnoconfig    gcc-16.1.0
microblaze                       allyesconfig    gcc-16.1.0
microblaze                          defconfig    gcc-16.1.0
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                             allyesconfig    gcc-16.1.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260707    gcc-11.5.0
nios2                 randconfig-002-20260707    gcc-11.5.0
openrisc                         allmodconfig    gcc-16.1.0
openrisc                          allnoconfig    gcc-16.1.0
openrisc                            defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    gcc-16.1.0
parisc                           allyesconfig    gcc-16.1.0
parisc                              defconfig    gcc-16.1.0
parisc                randconfig-001-20260707    gcc-15.2.0
parisc                randconfig-002-20260707    gcc-9.5.0
parisc64                            defconfig    gcc-16.1.0
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    gcc-16.1.0
powerpc               randconfig-001-20260707    clang-23
powerpc               randconfig-002-20260707    gcc-14.3.0
powerpc64             randconfig-001-20260707    gcc-8.5.0
powerpc64             randconfig-002-20260707    clang-22
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    gcc-16.1.0
riscv                            allyesconfig    clang-23
riscv                               defconfig    clang-23
riscv             nommu_k210_sdcard_defconfig    gcc-16.1.0
riscv                          randconfig-001    gcc-13.4.0
riscv                 randconfig-001-20260707    gcc-14.3.0
riscv                          randconfig-002    clang-17
riscv                 randconfig-002-20260707    gcc-8.5.0
s390                             allmodconfig    clang-23
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    clang-18
s390                           randconfig-001    gcc-15.2.0
s390                  randconfig-001-20260707    clang-21
s390                           randconfig-002    clang-18
s390                  randconfig-002-20260707    gcc-13.4.0
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    gcc-16.1.0
sh                               allyesconfig    gcc-16.1.0
sh                                  defconfig    gcc-16.1.0
sh                             randconfig-001    gcc-14.3.0
sh                    randconfig-001-20260707    gcc-16.1.0
sh                             randconfig-002    gcc-9.5.0
sh                    randconfig-002-20260707    gcc-16.1.0
sparc                             allnoconfig    gcc-16.1.0
sparc                               defconfig    gcc-16.1.0
sparc                          randconfig-001    gcc-16.1.0
sparc                 randconfig-001-20260707    gcc-13.4.0
sparc                          randconfig-002    gcc-11.5.0
sparc                 randconfig-002-20260707    gcc-15.2.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    clang-23
sparc64                        randconfig-001    gcc-12.5.0
sparc64               randconfig-001-20260707    gcc-8.5.0
sparc64                        randconfig-002    clang-20
sparc64               randconfig-002-20260707    clang-23
um                               allmodconfig    clang-17
um                                allnoconfig    clang-17
um                               allyesconfig    gcc-14
um                                  defconfig    clang-23
um                             i386_defconfig    gcc-14
um                             randconfig-001    clang-23
um                    randconfig-001-20260707    clang-18
um                             randconfig-002    clang-23
um                    randconfig-002-20260707    clang-23
um                           x86_64_defconfig    clang-23
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-22
x86_64                              defconfig    gcc-14
x86_64                randconfig-011-20260707    clang-22
x86_64                randconfig-012-20260707    gcc-14
x86_64                randconfig-013-20260707    clang-22
x86_64                randconfig-014-20260707    gcc-14
x86_64                randconfig-015-20260707    gcc-14
x86_64                randconfig-016-20260707    clang-22
x86_64                randconfig-076-20260707    gcc-14
x86_64                          rhel-9.4-rust    clang-22
xtensa                            allnoconfig    gcc-16.1.0
xtensa                           allyesconfig    gcc-16.1.0
xtensa                         randconfig-001    gcc-8.5.0
xtensa                randconfig-001-20260707    gcc-8.5.0
xtensa                         randconfig-002    gcc-13.4.0
xtensa                randconfig-002-20260707    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

