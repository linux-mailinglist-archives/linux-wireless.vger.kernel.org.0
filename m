Return-Path: <linux-wireless+bounces-33451-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8F16I5V/u2k2kwIAu9opvQ
	(envelope-from <linux-wireless+bounces-33451-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 05:46:13 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 673792C6001
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 05:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 187D43070AE5
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 04:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC041F16B;
	Thu, 19 Mar 2026 04:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LHjfpOCE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256B063CB
	for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 04:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773895570; cv=none; b=gF5KhoxMynhogHha9r5m0dmi1XIVksm5N78DdSs0YQLe2R1tWKDvUy6r0vdHoV9754bByuQrCkGlDghNeXKMUBOx9kRBRQuWyEGzgpUkIywOrHzgloZ2qkU+rSHdtXL09vJnBhfiikjBtQ6+Sk50XFqTX3pBCoTmXy6Ed3dp+Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773895570; c=relaxed/simple;
	bh=h2RgSlM+2wPzQZ0eGuRzKM5RKKGiMi3v7uyBXMcyQ3Y=;
	h=Date:From:To:Cc:Subject:Message-ID; b=dAgB2c/Rdnx1vpfG5a+ft+RHOCtTGO6PaVaebiPH2IoJ8paz+69OUR+OlgyaEjkA/U+Ah8cCWOvCDEtCwHhJx7A6Ya4g7rPybhoSOBqQXSXbTiWxN7KMrzQpguAr/g4daRp+VRraE7Dc2OELmu8oj3wOnjUP7G4WVdfMI1VZWZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LHjfpOCE; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773895568; x=1805431568;
  h=date:from:to:cc:subject:message-id;
  bh=h2RgSlM+2wPzQZ0eGuRzKM5RKKGiMi3v7uyBXMcyQ3Y=;
  b=LHjfpOCEOU3kvtXUUFACtrY+dLb709n58LSu2fYj4g/rSVd+9u13ObOH
   PUYGIpdwWGxd7PJDKokiBG1eP5d2ylnyGBNL87L870Uv1G7fk6+tOaj/l
   u+0Wo0cPmlECOhm96bZ/HdMVTgZ78jUOV3xbr+AO4chkMWrawluRZdaDG
   mypk7irKu51f2c+PPZtKdXqumKBsqe5ETK9oov4SEYjLJaVUIObqL1hDV
   7ShMVOqnsFTrNrGPe7jdnEoGOJzg2dylYXz1FSrmjDF4IbwO5kaNkhMRk
   nzLGkPtzB80271Yf9O3do/utmCrz9fQ9ERgyGMTbzgGLit9qWzKFFj4wG
   A==;
X-CSE-ConnectionGUID: MwbDGG2iS0euYU2ToR2JQg==
X-CSE-MsgGUID: ELDXRHxxRD2bh9Vrr96zEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="75146128"
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; 
   d="scan'208";a="75146128"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 21:46:07 -0700
X-CSE-ConnectionGUID: UWR2Jm3URLCXBYbLd/CWHw==
X-CSE-MsgGUID: cnpEGtPYTpyBlgu3OVAV4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; 
   d="scan'208";a="227330876"
Received: from lkp-server02.sh.intel.com (HELO a51c2a36b9df) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 18 Mar 2026 21:46:06 -0700
Received: from kbuild by a51c2a36b9df with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w35Gl-000000000KJ-33nx;
	Thu, 19 Mar 2026 04:46:03 +0000
Date: Thu, 19 Mar 2026 12:42:03 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: linux-wireless@vger.kernel.org
Subject: [wireless:for-next] BUILD SUCCESS
 d5ad6ab61cbd89afdb60881f6274f74328af3ee9
Message-ID: <202603191258.Tsf3E1iE-lkp@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33451-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.987];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: 673792C6001
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git for-next
branch HEAD: d5ad6ab61cbd89afdb60881f6274f74328af3ee9  wifi: mac80211: always free skb on ieee80211_tx_prepare_skb() failure

elapsed time: 754m

configs tested: 163
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-23
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260319    gcc-11.5.0
arc                   randconfig-002-20260319    gcc-11.5.0
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                                 defconfig    gcc-15.2.0
arm                   randconfig-001-20260319    gcc-11.5.0
arm                   randconfig-002-20260319    gcc-11.5.0
arm                   randconfig-003-20260319    gcc-11.5.0
arm                   randconfig-004-20260319    gcc-11.5.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260319    gcc-15.2.0
arm64                 randconfig-002-20260319    gcc-15.2.0
arm64                 randconfig-003-20260319    gcc-15.2.0
arm64                 randconfig-004-20260319    gcc-15.2.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260319    gcc-15.2.0
csky                  randconfig-002-20260319    gcc-15.2.0
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260319    gcc-11.5.0
hexagon               randconfig-002-20260319    gcc-11.5.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260319    gcc-14
i386        buildonly-randconfig-002-20260319    gcc-14
i386        buildonly-randconfig-003-20260319    gcc-14
i386        buildonly-randconfig-004-20260319    gcc-14
i386        buildonly-randconfig-005-20260319    gcc-14
i386        buildonly-randconfig-006-20260319    gcc-14
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260319    gcc-14
i386                  randconfig-002-20260319    gcc-14
i386                  randconfig-003-20260319    gcc-14
i386                  randconfig-004-20260319    gcc-14
i386                  randconfig-005-20260319    gcc-14
i386                  randconfig-006-20260319    gcc-14
i386                  randconfig-007-20260319    gcc-14
i386                  randconfig-011-20260319    clang-20
i386                  randconfig-012-20260319    clang-20
i386                  randconfig-013-20260319    clang-20
i386                  randconfig-014-20260319    clang-20
i386                  randconfig-015-20260319    clang-20
i386                  randconfig-016-20260319    clang-20
i386                  randconfig-017-20260319    clang-20
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260319    gcc-11.5.0
loongarch             randconfig-002-20260319    gcc-11.5.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                                defconfig    clang-19
m68k                            mac_defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            allmodconfig    clang-23
nios2                             allnoconfig    clang-23
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260319    gcc-11.5.0
nios2                 randconfig-002-20260319    gcc-11.5.0
openrisc                         allmodconfig    clang-23
openrisc                          allnoconfig    clang-23
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260319    clang-19
parisc                randconfig-002-20260319    clang-19
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                      chrp32_defconfig    clang-19
powerpc               randconfig-001-20260319    clang-19
powerpc               randconfig-002-20260319    clang-19
powerpc64             randconfig-001-20260319    clang-19
powerpc64             randconfig-002-20260319    clang-19
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sparc                             allnoconfig    clang-23
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260319    gcc-8.5.0
sparc                 randconfig-002-20260319    gcc-8.5.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260319    gcc-8.5.0
sparc64               randconfig-002-20260319    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260319    gcc-8.5.0
um                    randconfig-002-20260319    gcc-8.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260319    clang-20
x86_64      buildonly-randconfig-002-20260319    clang-20
x86_64      buildonly-randconfig-003-20260319    clang-20
x86_64      buildonly-randconfig-004-20260319    clang-20
x86_64      buildonly-randconfig-005-20260319    clang-20
x86_64      buildonly-randconfig-006-20260319    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260319    gcc-14
x86_64                randconfig-002-20260319    gcc-14
x86_64                randconfig-003-20260319    gcc-14
x86_64                randconfig-004-20260319    gcc-14
x86_64                randconfig-005-20260319    gcc-14
x86_64                randconfig-006-20260319    gcc-14
x86_64                randconfig-011-20260319    gcc-13
x86_64                randconfig-012-20260319    gcc-13
x86_64                randconfig-013-20260319    gcc-13
x86_64                randconfig-014-20260319    gcc-13
x86_64                randconfig-015-20260319    gcc-13
x86_64                randconfig-016-20260319    gcc-13
x86_64                randconfig-071-20260319    clang-20
x86_64                randconfig-072-20260319    clang-20
x86_64                randconfig-073-20260319    clang-20
x86_64                randconfig-074-20260319    clang-20
x86_64                randconfig-075-20260319    clang-20
x86_64                randconfig-076-20260319    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                           allyesconfig    clang-23
xtensa                randconfig-001-20260319    gcc-8.5.0
xtensa                randconfig-002-20260319    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

