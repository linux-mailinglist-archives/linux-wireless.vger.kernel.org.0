Return-Path: <linux-wireless+bounces-37686-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5s/eMFFTK2pz6wMAu9opvQ
	(envelope-from <linux-wireless+bounces-37686-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 02:31:13 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83383675EFB
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 02:31:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=dkh5OvW8;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37686-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37686-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6F53830BBB16
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 00:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369C61FB1;
	Fri, 12 Jun 2026 00:31:09 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086F0184
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jun 2026 00:31:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781224269; cv=none; b=XZx2k2sEKUYYtL2Od1LFFdN40ggwVTNXWd9WqLvDeoLLp+BB+w2ezyYQ7jTfgqAEBQX0NTvAswzptXZ0x5mbduKVGv20r3kMmjQUIbWvgoWNw0ONRKXq1DkriEXWimic2P9+04lpfgSmlhDyUw07c0OnO0KW1W5413SxHcVQxS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781224269; c=relaxed/simple;
	bh=mcgH97x/sNip0VFXRKfUK8P+dZ31uCkoHg8ZRLyivOk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=LmjQ+9fLzoGid+/cxViads3IU87lSXraEoYOsdOqGyczhCktScvuOVKRAS8RuR+kk5nWuI2emkledE14LHxEErUvDeoltvyL356T81xyOYPwvaXvjivghDzkKJMHViwhHDZ+xlFZuk1kaq1r3gR9gZccPpi6UtggAd3XoS9CUFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dkh5OvW8; arc=none smtp.client-ip=192.198.163.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781224267; x=1812760267;
  h=date:from:to:cc:subject:message-id;
  bh=mcgH97x/sNip0VFXRKfUK8P+dZ31uCkoHg8ZRLyivOk=;
  b=dkh5OvW8hAr5qj+MRmoLHZ82u7efmgIbUNdhWJ8UFXYlsgB5v3o5A7sg
   CUXvFuwLG/J/is7aWp4Q8yssF1xyo5V4+oS/qlQEl6eVTSJT2ReYnjYnk
   1KTLxlKnjdcakF+tZVvksfpK7cwWi/WnSoeD02ZG4hg7bSpVTZfkiuks+
   cdl+SP0CCAmTHHvA5yLIXufCV2B+5EnueYfoc41bf8MIXBf9DKrell1Z9
   D8ZFyjLinPoq6i+ilQAkAaXfS9d6LH7bPjvEuUWdY2gYcQFwD1nKfbc/T
   nawjzrwH7LlsxgQeEFvZeRgqcHgot45qwid3qzbjgt3KlZ4Dgku1B4jie
   w==;
X-CSE-ConnectionGUID: oSTB/r4USw23u0ldyPCf5Q==
X-CSE-MsgGUID: d5h5J8G+QgeP18LdWjYVjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="99632450"
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="99632450"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 17:31:06 -0700
X-CSE-ConnectionGUID: LWx2UvcfTJ+OAT7cqb0CxA==
X-CSE-MsgGUID: rrsnLUKCQVaSmhGdNRljYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="246742798"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 11 Jun 2026 17:31:04 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wXpnZ-00000000O4q-2iiV;
	Fri, 12 Jun 2026 00:31:01 +0000
Date: Fri, 12 Jun 2026 08:30:39 +0800
From: kernel test robot <lkp@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 972c4dd19cb92e03d75b66c426cfade07582a1ba
Message-ID: <202606120830.NTQlnkuk-lkp@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37686-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[lkp@intel.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,intel.com:dkim,intel.com:mid,intel.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 83383675EFB

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 972c4dd19cb92e03d75b66c426cfade07582a1ba  Merge tag 'wireless-next-2026-06-10' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next

elapsed time: 749m

configs tested: 271
configs skipped: 105

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-16.1.0
alpha                            allyesconfig    gcc-16.1.0
alpha                               defconfig    gcc-16.1.0
arc                              allmodconfig    clang-23
arc                              allmodconfig    gcc-16.1.0
arc                               allnoconfig    gcc-16.1.0
arc                              allyesconfig    clang-23
arc                              allyesconfig    gcc-16.1.0
arc                                 defconfig    gcc-16.1.0
arc                            randconfig-001    gcc-13.4.0
arc                   randconfig-001-20260611    gcc-14.3.0
arc                   randconfig-001-20260612    gcc-13.4.0
arc                            randconfig-002    gcc-13.4.0
arc                   randconfig-002-20260611    gcc-14.3.0
arc                   randconfig-002-20260612    gcc-13.4.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-16.1.0
arm                              allyesconfig    clang-23
arm                              allyesconfig    gcc-16.1.0
arm                         at91_dt_defconfig    clang-17
arm                                 defconfig    clang-23
arm                                 defconfig    gcc-16.1.0
arm                            randconfig-001    gcc-13.4.0
arm                   randconfig-001-20260611    gcc-14.3.0
arm                   randconfig-001-20260612    gcc-11.5.0
arm                   randconfig-001-20260612    gcc-13.4.0
arm                            randconfig-002    gcc-13.4.0
arm                   randconfig-002-20260611    gcc-14.3.0
arm                   randconfig-002-20260612    gcc-10.5.0
arm                   randconfig-002-20260612    gcc-13.4.0
arm                            randconfig-003    gcc-13.4.0
arm                   randconfig-003-20260611    gcc-14.3.0
arm                   randconfig-003-20260612    gcc-11.5.0
arm                   randconfig-003-20260612    gcc-13.4.0
arm                            randconfig-004    gcc-13.4.0
arm                   randconfig-004-20260611    gcc-14.3.0
arm                   randconfig-004-20260612    gcc-13.4.0
arm                       spear13xx_defconfig    gcc-16.1.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                 randconfig-001-20260611    gcc-14.3.0
arm64                 randconfig-001-20260612    gcc-13.4.0
arm64                 randconfig-002-20260611    gcc-14.3.0
arm64                 randconfig-002-20260612    clang-23
arm64                 randconfig-002-20260612    gcc-13.4.0
arm64                 randconfig-003-20260611    gcc-14.3.0
arm64                 randconfig-003-20260612    gcc-13.4.0
arm64                 randconfig-003-20260612    gcc-9.5.0
arm64                 randconfig-004-20260611    gcc-14.3.0
arm64                 randconfig-004-20260612    gcc-11.5.0
arm64                 randconfig-004-20260612    gcc-13.4.0
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                  randconfig-001-20260611    gcc-14.3.0
csky                  randconfig-001-20260612    gcc-13.4.0
csky                  randconfig-002-20260611    gcc-14.3.0
csky                  randconfig-002-20260612    gcc-13.4.0
hexagon                          allmodconfig    clang-23
hexagon                          allmodconfig    gcc-16.1.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-16.1.0
hexagon                             defconfig    gcc-16.1.0
hexagon               randconfig-001-20260611    clang-17
hexagon               randconfig-001-20260612    clang-23
hexagon               randconfig-002-20260611    clang-17
hexagon               randconfig-002-20260612    clang-23
i386                             allmodconfig    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-16.1.0
i386                             allyesconfig    clang-22
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260612    gcc-14
i386        buildonly-randconfig-002-20260612    gcc-14
i386        buildonly-randconfig-003-20260612    gcc-14
i386        buildonly-randconfig-004-20260612    gcc-14
i386        buildonly-randconfig-005-20260612    gcc-14
i386        buildonly-randconfig-006-20260612    gcc-14
i386                                defconfig    clang-22
i386                                defconfig    gcc-16.1.0
i386                  randconfig-001-20260612    clang-22
i386                  randconfig-002-20260612    clang-22
i386                  randconfig-003-20260612    clang-22
i386                  randconfig-004-20260612    clang-22
i386                  randconfig-005-20260612    clang-22
i386                  randconfig-006-20260612    clang-22
i386                  randconfig-007-20260612    clang-22
i386                  randconfig-011-20260611    gcc-14
i386                  randconfig-012-20260611    gcc-14
i386                  randconfig-013-20260611    gcc-14
i386                  randconfig-014-20260611    gcc-14
i386                  randconfig-015-20260611    gcc-14
i386                  randconfig-016-20260611    gcc-14
i386                  randconfig-017-20260611    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-20
loongarch                         allnoconfig    gcc-16.1.0
loongarch                           defconfig    clang-23
loongarch             randconfig-001-20260611    clang-17
loongarch             randconfig-001-20260612    clang-23
loongarch             randconfig-002-20260611    clang-17
loongarch             randconfig-002-20260612    clang-23
m68k                             allmodconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-16.1.0
m68k                             allyesconfig    clang-23
m68k                             allyesconfig    gcc-16.1.0
m68k                                defconfig    clang-23
m68k                        m5272c3_defconfig    gcc-16.1.0
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
nios2                 randconfig-001-20260611    clang-17
nios2                 randconfig-001-20260612    clang-23
nios2                 randconfig-002-20260611    clang-17
nios2                 randconfig-002-20260612    clang-23
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
parisc                         randconfig-001    gcc-13.4.0
parisc                randconfig-001-20260611    gcc-13.4.0
parisc                         randconfig-002    gcc-13.4.0
parisc                randconfig-002-20260611    gcc-13.4.0
parisc64                            defconfig    clang-23
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-16.1.0
powerpc                        randconfig-001    gcc-13.4.0
powerpc               randconfig-001-20260611    gcc-13.4.0
powerpc                        randconfig-002    gcc-13.4.0
powerpc               randconfig-002-20260611    gcc-13.4.0
powerpc64                      randconfig-001    gcc-13.4.0
powerpc64             randconfig-001-20260611    gcc-13.4.0
powerpc64                      randconfig-002    gcc-13.4.0
powerpc64             randconfig-002-20260611    gcc-13.4.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-16.1.0
riscv                            allyesconfig    clang-23
riscv                               defconfig    gcc-16.1.0
riscv                 randconfig-001-20260611    gcc-12.5.0
riscv                 randconfig-001-20260612    gcc-11.5.0
riscv                 randconfig-002-20260611    gcc-12.5.0
riscv                 randconfig-002-20260612    gcc-11.5.0
s390                             allmodconfig    clang-17
s390                             allmodconfig    clang-23
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    gcc-16.1.0
s390                  randconfig-001-20260611    gcc-12.5.0
s390                  randconfig-001-20260612    gcc-11.5.0
s390                  randconfig-002-20260611    gcc-12.5.0
s390                  randconfig-002-20260612    gcc-11.5.0
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-16.1.0
sh                               allyesconfig    clang-17
sh                               allyesconfig    gcc-16.1.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260611    gcc-12.5.0
sh                    randconfig-001-20260612    gcc-11.5.0
sh                    randconfig-002-20260611    gcc-12.5.0
sh                    randconfig-002-20260612    gcc-11.5.0
sh                             shx3_defconfig    gcc-16.1.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-16.1.0
sparc                               defconfig    gcc-16.1.0
sparc                 randconfig-001-20260611    gcc-15.2.0
sparc                 randconfig-001-20260612    gcc-8.5.0
sparc                 randconfig-002-20260611    gcc-15.2.0
sparc                 randconfig-002-20260612    gcc-8.5.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260611    gcc-15.2.0
sparc64               randconfig-001-20260612    gcc-8.5.0
sparc64               randconfig-002-20260611    gcc-15.2.0
sparc64               randconfig-002-20260612    gcc-8.5.0
um                               allmodconfig    clang-17
um                               allmodconfig    clang-23
um                                allnoconfig    clang-16
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-16.1.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260611    gcc-15.2.0
um                    randconfig-001-20260612    gcc-8.5.0
um                    randconfig-002-20260611    gcc-15.2.0
um                    randconfig-002-20260612    gcc-8.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-22
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-22
x86_64      buildonly-randconfig-001-20260611    gcc-14
x86_64      buildonly-randconfig-001-20260612    clang-22
x86_64      buildonly-randconfig-002-20260611    gcc-14
x86_64      buildonly-randconfig-002-20260612    gcc-14
x86_64      buildonly-randconfig-003-20260611    gcc-14
x86_64      buildonly-randconfig-004-20260611    gcc-14
x86_64      buildonly-randconfig-005-20260611    gcc-14
x86_64      buildonly-randconfig-006-20260611    gcc-14
x86_64      buildonly-randconfig-006-20260612    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-22
x86_64                randconfig-001-20260611    gcc-14
x86_64                randconfig-001-20260612    clang-22
x86_64                randconfig-002-20260611    gcc-14
x86_64                randconfig-002-20260612    clang-22
x86_64                randconfig-003-20260611    gcc-14
x86_64                randconfig-003-20260612    clang-22
x86_64                randconfig-004-20260611    gcc-14
x86_64                randconfig-004-20260612    clang-22
x86_64                randconfig-005-20260611    gcc-14
x86_64                randconfig-005-20260612    clang-22
x86_64                randconfig-006-20260611    gcc-14
x86_64                randconfig-006-20260612    clang-22
x86_64                         randconfig-011    clang-22
x86_64                randconfig-011-20260611    clang-22
x86_64                         randconfig-012    clang-22
x86_64                randconfig-012-20260611    clang-22
x86_64                         randconfig-013    clang-22
x86_64                randconfig-013-20260611    clang-22
x86_64                         randconfig-014    clang-22
x86_64                randconfig-014-20260611    clang-22
x86_64                         randconfig-015    clang-22
x86_64                randconfig-015-20260611    clang-22
x86_64                         randconfig-016    clang-22
x86_64                randconfig-016-20260611    clang-22
x86_64                randconfig-071-20260611    clang-22
x86_64                randconfig-071-20260612    gcc-14
x86_64                randconfig-072-20260611    clang-22
x86_64                randconfig-072-20260612    gcc-14
x86_64                randconfig-073-20260611    clang-22
x86_64                randconfig-073-20260612    gcc-14
x86_64                randconfig-074-20260611    clang-22
x86_64                randconfig-074-20260612    gcc-14
x86_64                randconfig-075-20260611    clang-22
x86_64                randconfig-075-20260612    gcc-14
x86_64                randconfig-076-20260611    clang-22
x86_64                randconfig-076-20260612    gcc-14
x86_64                               rhel-9.4    clang-22
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-22
x86_64                    rhel-9.4-kselftests    clang-22
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-22
xtensa                            allnoconfig    clang-23
xtensa                            allnoconfig    gcc-16.1.0
xtensa                           allyesconfig    clang-20
xtensa                randconfig-001-20260611    gcc-15.2.0
xtensa                randconfig-001-20260612    gcc-8.5.0
xtensa                randconfig-002-20260611    gcc-15.2.0
xtensa                randconfig-002-20260612    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

