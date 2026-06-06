Return-Path: <linux-wireless+bounces-37462-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EPPOJAqzJGr1+QEAu9opvQ
	(envelope-from <linux-wireless+bounces-37462-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 07 Jun 2026 01:53:46 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC99964E87A
	for <lists+linux-wireless@lfdr.de>; Sun, 07 Jun 2026 01:53:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=enuI2QLH;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37462-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37462-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 63048300BCBB
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Jun 2026 23:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55874071F5;
	Sat,  6 Jun 2026 23:53:07 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA584071C6
	for <linux-wireless@vger.kernel.org>; Sat,  6 Jun 2026 23:53:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780789987; cv=none; b=Fw0TVRZW21Q8MGetvYyTo3YcCA2YcdxuSoFLSnNkf4G32bdok/dVh+95zApeRHB2rOos66FYP7eWDx4jQE35mc5ZHhtXtVAS2qKeLcP29HFgj99sClpoE+8MvX1s1yo/UJIP5c2uhGT9HNAxJFNsNBL9M7m6FUEUDIhGHROcQyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780789987; c=relaxed/simple;
	bh=/o1nHoHQISgBaRZMytxDxVnqJNlLHyhc7glN/bm1UYg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=j+8wXz0cZZaW5Zwta+xPFQ2I9V2OG+EKLri0WqsfZY/hFbK52fhoeBHe8BfCkSN9yuAU+E+5kBi76Lhp8rMDsfTOYtMX4MkbMXILx5BKm0PeqJpzbCJRpzQ5J6Njiurx8I1O9Vh586Ioi2QymaFm98BGeeKIFTEe/ffaTeShU7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=enuI2QLH; arc=none smtp.client-ip=192.198.163.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780789986; x=1812325986;
  h=date:from:to:cc:subject:message-id;
  bh=/o1nHoHQISgBaRZMytxDxVnqJNlLHyhc7glN/bm1UYg=;
  b=enuI2QLHwInHIMksBVp1tRKsb/2FH+35y120tkNqY6HqsV4Ec4kdq3lM
   krPd+jpIBKx8CHkYfzNxCF9z3IaDG+xf8oc+VJZEcQMW0/k+6+0EM9179
   MV+0OUr+XefZE2WQU7tHkZtCqwV22zE4dqD6Fvpe7Ah/qhVQwKOnZkZHy
   jluXTBhw6nsoDis3HwxrVEe5XcOjy2II/DhBCnJmsDCX1SmqVQhzG3gBv
   TPG/4wwyyzDGp/RP9H3+3Z4cRzmtjrShiF0VXCRcuX7bdeKOOU9Uxkbl7
   hOM6Gk+EKXTdoXRmUcvJcLTqOFkM8+U0RpjH0otO1h/0TNEr6+GJeYN9z
   g==;
X-CSE-ConnectionGUID: SqXkY2AlTgO3AWG86eDq8g==
X-CSE-MsgGUID: rDDkW/F0Rii2vNt4FIR5fw==
X-IronPort-AV: E=McAfee;i="6800,10657,11809"; a="99154703"
X-IronPort-AV: E=Sophos;i="6.24,191,1774335600"; 
   d="scan'208";a="99154703"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2026 16:53:05 -0700
X-CSE-ConnectionGUID: VCdn4G1BRfK0zqPL1OqOqQ==
X-CSE-MsgGUID: uIN5NaFYSrmnUwfEYDOmZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,191,1774335600"; 
   d="scan'208";a="244314961"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 06 Jun 2026 16:53:03 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wW0p3-00000000HSM-001b;
	Sat, 06 Jun 2026 23:53:01 +0000
Date: Sun, 07 Jun 2026 07:52:54 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: linux-wireless@vger.kernel.org
Subject: [wireless-next:for-next] BUILD SUCCESS
 4cc0cc0b297c17c2b106d6892bd13d9c32fe66ce
Message-ID: <202606070745.9BuPrkig-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-37462-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[lkp@intel.com,linux-wireless@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS(0.00)[m:johannes.berg@intel.com,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:from_mime,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DC99964E87A

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git for-next
branch HEAD: 4cc0cc0b297c17c2b106d6892bd13d9c32fe66ce  wifi: mac80211: Add 802.3 multicast encapsulation offload support

elapsed time: 1597m

configs tested: 175
configs skipped: 15

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-16.1.0
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-16.1.0
arc                   randconfig-001-20260606    gcc-8.5.0
arc                   randconfig-002-20260606    gcc-8.5.0
arm                               allnoconfig    clang-23
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    clang-23
arm                   randconfig-001-20260606    clang-22
arm                   randconfig-002-20260606    gcc-16.1.0
arm                   randconfig-003-20260606    clang-23
arm                   randconfig-004-20260606    clang-23
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-16.1.0
arm64                          randconfig-001    gcc-8.5.0
arm64                 randconfig-001-20260606    gcc-10.5.0
arm64                          randconfig-002    gcc-14.3.0
arm64                 randconfig-002-20260606    gcc-8.5.0
arm64                          randconfig-003    clang-23
arm64                 randconfig-003-20260606    clang-23
arm64                          randconfig-004    clang-23
arm64                 randconfig-004-20260606    gcc-14.3.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-16.1.0
csky                           randconfig-001    gcc-10.5.0
csky                  randconfig-001-20260606    gcc-10.5.0
csky                           randconfig-002    gcc-10.5.0
csky                  randconfig-002-20260606    gcc-9.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-23
hexagon                             defconfig    clang-23
hexagon                        randconfig-001    clang-23
hexagon               randconfig-001-20260606    clang-23
hexagon                        randconfig-002    clang-23
hexagon               randconfig-002-20260606    clang-23
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260606    clang-20
i386        buildonly-randconfig-002-20260606    clang-20
i386        buildonly-randconfig-003-20260606    clang-20
i386        buildonly-randconfig-004-20260606    gcc-14
i386        buildonly-randconfig-005-20260606    clang-20
i386        buildonly-randconfig-006-20260606    gcc-13
i386                                defconfig    clang-22
i386                           randconfig-001    clang-20
i386                  randconfig-001-20260606    clang-20
i386                           randconfig-002    gcc-14
i386                  randconfig-002-20260606    gcc-14
i386                           randconfig-003    gcc-14
i386                  randconfig-003-20260606    clang-20
i386                           randconfig-004    clang-20
i386                  randconfig-004-20260606    clang-20
i386                           randconfig-005    gcc-14
i386                  randconfig-005-20260606    gcc-14
i386                           randconfig-006    gcc-14
i386                  randconfig-006-20260606    clang-20
i386                           randconfig-007    gcc-14
i386                  randconfig-007-20260606    clang-20
i386                  randconfig-011-20260606    clang-22
i386                  randconfig-012-20260606    gcc-14
i386                  randconfig-013-20260606    gcc-12
i386                  randconfig-014-20260606    clang-22
i386                  randconfig-015-20260606    clang-22
i386                  randconfig-016-20260606    gcc-14
i386                  randconfig-017-20260606    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-23
loongarch                      randconfig-001    clang-23
loongarch             randconfig-001-20260606    clang-23
loongarch                      randconfig-002    gcc-16.1.0
loongarch             randconfig-002-20260606    clang-23
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                          randconfig-001    gcc-11.5.0
nios2                 randconfig-001-20260606    gcc-11.5.0
nios2                          randconfig-002    gcc-8.5.0
nios2                 randconfig-002-20260606    gcc-8.5.0
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    gcc-15.2.0
parisc                              defconfig    gcc-16.1.0
parisc                         randconfig-001    gcc-13.4.0
parisc                randconfig-001-20260606    gcc-8.5.0
parisc                         randconfig-002    gcc-8.5.0
parisc                randconfig-002-20260606    gcc-10.5.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    gcc-15.2.0
powerpc                        randconfig-001    gcc-13.4.0
powerpc               randconfig-001-20260606    clang-23
powerpc                        randconfig-002    gcc-10.5.0
powerpc               randconfig-002-20260606    clang-23
powerpc64                      randconfig-001    clang-17
powerpc64             randconfig-001-20260606    gcc-15.2.0
powerpc64                      randconfig-002    clang-23
powerpc64             randconfig-002-20260606    gcc-8.5.0
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-23
riscv                 randconfig-001-20260606    gcc-12.5.0
riscv                 randconfig-002-20260606    gcc-8.5.0
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-18
s390                  randconfig-001-20260606    gcc-13.4.0
s390                  randconfig-002-20260606    gcc-8.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    gcc-15.2.0
sh                                  defconfig    gcc-16.1.0
sh                    randconfig-001-20260606    gcc-10.5.0
sh                    randconfig-002-20260606    gcc-16.1.0
sh                        sh7763rdp_defconfig    gcc-16.1.0
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-16.1.0
sparc                 randconfig-001-20260606    gcc-13.4.0
sparc                 randconfig-002-20260606    gcc-16.1.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    clang-23
sparc64               randconfig-001-20260606    gcc-12.5.0
sparc64               randconfig-002-20260606    gcc-8.5.0
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                                  defconfig    clang-23
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260606    clang-23
um                    randconfig-002-20260606    gcc-14
um                           x86_64_defconfig    clang-23
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64                              defconfig    gcc-14
x86_64                         randconfig-001    gcc-14
x86_64                randconfig-001-20260606    gcc-14
x86_64                         randconfig-002    gcc-14
x86_64                randconfig-002-20260606    gcc-14
x86_64                         randconfig-003    clang-20
x86_64                randconfig-003-20260606    gcc-14
x86_64                         randconfig-004    clang-20
x86_64                randconfig-004-20260606    gcc-14
x86_64                         randconfig-005    gcc-14
x86_64                randconfig-005-20260606    gcc-14
x86_64                         randconfig-006    clang-20
x86_64                randconfig-006-20260606    gcc-14
x86_64                randconfig-011-20260606    clang-22
x86_64                randconfig-012-20260606    clang-22
x86_64                randconfig-013-20260606    gcc-14
x86_64                randconfig-014-20260606    clang-22
x86_64                randconfig-015-20260606    clang-22
x86_64                randconfig-016-20260606    clang-22
x86_64                randconfig-071-20260606    clang-20
x86_64                randconfig-072-20260606    gcc-14
x86_64                randconfig-073-20260606    clang-20
x86_64                randconfig-074-20260606    clang-20
x86_64                randconfig-075-20260606    clang-20
x86_64                randconfig-076-20260606    gcc-13
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.2.0
xtensa                randconfig-001-20260606    gcc-8.5.0
xtensa                randconfig-002-20260606    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

