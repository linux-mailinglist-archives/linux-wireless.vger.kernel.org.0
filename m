Return-Path: <linux-wireless+bounces-35889-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GmVM+Ru+Wl+8gIAu9opvQ
	(envelope-from <linux-wireless+bounces-35889-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 06:15:32 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB544C6550
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 06:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF910301DBB0
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2026 04:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C953A5E6F;
	Tue,  5 May 2026 04:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hlO3SPzx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0620A34DCD9
	for <linux-wireless@vger.kernel.org>; Tue,  5 May 2026 04:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777954530; cv=none; b=TtjPahJWEXXpiv3BOcGqI4w4At8shtqdLWsaQmOCx/AzKF4GJ94DQ1e7JBcQTSC3Krb2mz7MN2fScoGwTY10YU17OzW485IMwoTUzCv9W2pqWNsP/XmC3dIgJnYJdi3iGuY5imZ1cHW0DjleMqf9PHlccyson5XhXqGy5fCvO3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777954530; c=relaxed/simple;
	bh=UGVZEtvrhoXGXmIq/OpYDEQmvTbE+ISk5rmKudTMvaM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=S7/DNwCnTYRmfHQifE+oU7C3DjFMSDkrvVlwfy8TID3n+9+nTscS1TrFZFCjEPGiODHE1zYmhFNMq0v1J3y/sXdZeUDxs5MqT0hq3wfegfSO4T5yndU+O5dvkJsWSGUnHZIgUpEX28XbYCWMY/QB/jvui96UQTKd29Vl8A5ssT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hlO3SPzx; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777954528; x=1809490528;
  h=date:from:to:cc:subject:message-id;
  bh=UGVZEtvrhoXGXmIq/OpYDEQmvTbE+ISk5rmKudTMvaM=;
  b=hlO3SPzxhe+tz1gUJWpmWcniV10A4jYbJNtjhdZWwBEyqM9kilxbYAbd
   Th5ztgEhZO8LyIPwRtF4w0sMn/4lata9K7g0GK8YA6ZuIcrUH5XEE2myv
   urif33ieKH9dRoH2EMHTLm5/6cHraNZ56ulwJTS3KaeBBQiCaY/L08uRq
   15Jtt+axO7Bn3NmZD1OgwM3s4HsgTdFYd3r7IbYmsdLJ17kg8SOVyIJHv
   n9FS3qSY19G3wyx3j/+YnvVXKh8WSXMRHfouL5PrwPBeBbblIK7SCLhuZ
   HtwenGzFLlVpSBv/DyziVicDx9mmK1bQqftDf/yqDoNECFQdQEkB4YVmu
   Q==;
X-CSE-ConnectionGUID: XOFyOa+GRjiQvgPBgp697g==
X-CSE-MsgGUID: wJSP70tUTkyeAX7DpuUzgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="78680850"
X-IronPort-AV: E=Sophos;i="6.23,216,1770624000"; 
   d="scan'208";a="78680850"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 21:15:27 -0700
X-CSE-ConnectionGUID: kbNF6Z6RSlab8XeGp/11AA==
X-CSE-MsgGUID: Vvps7zHjRW2lJCf8vEp06Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,216,1770624000"; 
   d="scan'208";a="273822930"
Received: from lkp-server01.sh.intel.com (HELO 781826d00641) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 04 May 2026 21:15:26 -0700
Received: from kbuild by 781826d00641 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wK7Bm-000000004FF-3iGx;
	Tue, 05 May 2026 04:15:20 +0000
Date: Tue, 05 May 2026 12:15:11 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: linux-wireless@vger.kernel.org
Subject: [wireless:for-next] BUILD SUCCESS
 65493f27a6008bf84bd11bd41c5e1ea6b0bf3c3d
Message-ID: <202605051203.lGFT4wSs-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 3FB544C6550
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35889-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git for-next
branch HEAD: 65493f27a6008bf84bd11bd41c5e1ea6b0bf3c3d  wifi: cw1200: Revert "Fix locking in error paths"

elapsed time: 1262m

configs tested: 408
configs skipped: 97

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    clang-23
arc                                 defconfig    gcc-15.2.0
arc                            randconfig-001    gcc-8.5.0
arc                   randconfig-001-20260504    gcc-13.4.0
arc                   randconfig-001-20260504    gcc-8.5.0
arc                   randconfig-001-20260505    gcc-8.5.0
arc                            randconfig-002    gcc-8.5.0
arc                   randconfig-002-20260504    gcc-13.4.0
arc                   randconfig-002-20260504    gcc-8.5.0
arc                   randconfig-002-20260505    gcc-8.5.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                       aspeed_g4_defconfig    clang-23
arm                     davinci_all_defconfig    clang-19
arm                                 defconfig    clang-23
arm                                 defconfig    gcc-15.2.0
arm                        mvebu_v5_defconfig    gcc-15.2.0
arm                            randconfig-001    gcc-8.5.0
arm                   randconfig-001-20260504    gcc-13.4.0
arm                   randconfig-001-20260504    gcc-8.5.0
arm                   randconfig-001-20260505    gcc-8.5.0
arm                            randconfig-002    gcc-8.5.0
arm                   randconfig-002-20260504    gcc-13.4.0
arm                   randconfig-002-20260504    gcc-8.5.0
arm                   randconfig-002-20260505    gcc-8.5.0
arm                            randconfig-003    gcc-8.5.0
arm                   randconfig-003-20260504    gcc-13.4.0
arm                   randconfig-003-20260504    gcc-8.5.0
arm                   randconfig-003-20260505    gcc-8.5.0
arm                            randconfig-004    gcc-8.5.0
arm                   randconfig-004-20260504    gcc-13.4.0
arm                   randconfig-004-20260504    gcc-8.5.0
arm                   randconfig-004-20260505    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260504    gcc-15.2.0
arm64                 randconfig-001-20260505    gcc-14.3.0
arm64                 randconfig-002-20260504    gcc-15.2.0
arm64                 randconfig-002-20260505    gcc-14.3.0
arm64                 randconfig-003-20260504    gcc-15.2.0
arm64                 randconfig-003-20260505    gcc-14.3.0
arm64                 randconfig-004-20260504    gcc-15.2.0
arm64                 randconfig-004-20260505    gcc-14.3.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260504    gcc-15.2.0
csky                  randconfig-001-20260505    gcc-14.3.0
csky                  randconfig-002-20260504    gcc-15.2.0
csky                  randconfig-002-20260505    gcc-14.3.0
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    clang-23
hexagon                             defconfig    gcc-15.2.0
hexagon                        randconfig-001    gcc-11.5.0
hexagon               randconfig-001-20260504    clang-23
hexagon               randconfig-001-20260505    clang-23
hexagon               randconfig-001-20260505    gcc-11.5.0
hexagon                        randconfig-002    gcc-11.5.0
hexagon               randconfig-002-20260504    clang-23
hexagon               randconfig-002-20260505    clang-23
hexagon               randconfig-002-20260505    gcc-11.5.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386                 buildonly-randconfig-001    gcc-14
i386        buildonly-randconfig-001-20260504    gcc-14
i386        buildonly-randconfig-001-20260505    gcc-14
i386                 buildonly-randconfig-002    gcc-14
i386        buildonly-randconfig-002-20260504    gcc-14
i386        buildonly-randconfig-002-20260505    gcc-14
i386                 buildonly-randconfig-003    gcc-14
i386        buildonly-randconfig-003-20260504    gcc-14
i386        buildonly-randconfig-003-20260505    gcc-14
i386                 buildonly-randconfig-004    gcc-14
i386        buildonly-randconfig-004-20260504    gcc-14
i386        buildonly-randconfig-004-20260505    gcc-14
i386                 buildonly-randconfig-005    gcc-14
i386        buildonly-randconfig-005-20260504    gcc-14
i386        buildonly-randconfig-005-20260505    gcc-14
i386                 buildonly-randconfig-006    gcc-14
i386        buildonly-randconfig-006-20260504    gcc-14
i386        buildonly-randconfig-006-20260505    gcc-14
i386                                defconfig    clang-20
i386                                defconfig    gcc-15.2.0
i386                           randconfig-001    clang-20
i386                  randconfig-001-20260504    clang-20
i386                  randconfig-001-20260505    clang-20
i386                           randconfig-002    clang-20
i386                           randconfig-002    gcc-14
i386                  randconfig-002-20260504    clang-20
i386                  randconfig-002-20260504    gcc-14
i386                  randconfig-002-20260505    clang-20
i386                           randconfig-003    clang-20
i386                           randconfig-003    gcc-14
i386                  randconfig-003-20260504    clang-20
i386                  randconfig-003-20260504    gcc-14
i386                  randconfig-003-20260505    clang-20
i386                           randconfig-004    clang-20
i386                  randconfig-004-20260504    clang-20
i386                  randconfig-004-20260504    gcc-14
i386                  randconfig-004-20260505    clang-20
i386                           randconfig-005    clang-20
i386                           randconfig-005    gcc-14
i386                  randconfig-005-20260504    clang-20
i386                  randconfig-005-20260504    gcc-14
i386                  randconfig-005-20260505    clang-20
i386                           randconfig-006    clang-20
i386                           randconfig-006    gcc-14
i386                  randconfig-006-20260504    clang-20
i386                  randconfig-006-20260505    clang-20
i386                           randconfig-007    clang-20
i386                           randconfig-007    gcc-14
i386                  randconfig-007-20260504    clang-20
i386                  randconfig-007-20260505    clang-20
i386                  randconfig-011-20260504    clang-20
i386                  randconfig-011-20260505    clang-20
i386                  randconfig-011-20260505    gcc-14
i386                  randconfig-012-20260504    clang-20
i386                  randconfig-012-20260505    clang-20
i386                  randconfig-013-20260504    clang-20
i386                  randconfig-013-20260505    clang-20
i386                  randconfig-014-20260504    clang-20
i386                  randconfig-014-20260505    clang-20
i386                  randconfig-015-20260504    clang-20
i386                  randconfig-015-20260505    clang-20
i386                  randconfig-015-20260505    gcc-14
i386                  randconfig-016-20260504    clang-20
i386                  randconfig-016-20260505    clang-20
i386                  randconfig-017-20260504    clang-20
i386                  randconfig-017-20260505    clang-20
i386                  randconfig-017-20260505    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch                      randconfig-001    gcc-11.5.0
loongarch             randconfig-001-20260504    clang-18
loongarch             randconfig-001-20260504    clang-23
loongarch             randconfig-001-20260505    clang-23
loongarch             randconfig-001-20260505    gcc-11.5.0
loongarch                      randconfig-002    gcc-11.5.0
loongarch             randconfig-002-20260504    clang-23
loongarch             randconfig-002-20260505    clang-18
loongarch             randconfig-002-20260505    clang-23
loongarch             randconfig-002-20260505    gcc-11.5.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    clang-19
m68k                                defconfig    gcc-15.2.0
m68k                          hp300_defconfig    gcc-15.2.0
m68k                       m5249evb_defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
microblaze                          defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                  decstation_64_defconfig    gcc-15.2.0
mips                           rs90_defconfig    gcc-15.2.0
nios2                            allmodconfig    clang-23
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-15.2.0
nios2                               defconfig    clang-19
nios2                               defconfig    gcc-11.5.0
nios2                          randconfig-001    gcc-11.5.0
nios2                 randconfig-001-20260504    clang-23
nios2                 randconfig-001-20260504    gcc-11.5.0
nios2                 randconfig-001-20260505    clang-18
nios2                 randconfig-001-20260505    clang-23
nios2                 randconfig-001-20260505    gcc-11.5.0
nios2                          randconfig-002    gcc-11.5.0
nios2                 randconfig-002-20260504    clang-23
nios2                 randconfig-002-20260504    gcc-11.5.0
nios2                 randconfig-002-20260505    clang-18
nios2                 randconfig-002-20260505    clang-23
nios2                 randconfig-002-20260505    gcc-11.5.0
openrisc                         allmodconfig    clang-23
openrisc                         allmodconfig    gcc-11.5.0
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                generic-64bit_defconfig    gcc-15.2.0
parisc                         randconfig-001    gcc-13.4.0
parisc                         randconfig-001    gcc-14.3.0
parisc                randconfig-001-20260504    gcc-13.4.0
parisc                randconfig-001-20260505    gcc-14.3.0
parisc                         randconfig-002    gcc-13.4.0
parisc                         randconfig-002    gcc-14.3.0
parisc                         randconfig-002    gcc-8.5.0
parisc                randconfig-002-20260504    gcc-13.4.0
parisc                randconfig-002-20260504    gcc-8.5.0
parisc                randconfig-002-20260505    gcc-14.3.0
parisc64                            defconfig    clang-19
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc                      pmac32_defconfig    clang-23
powerpc                        randconfig-001    gcc-13.4.0
powerpc                        randconfig-001    gcc-14.3.0
powerpc               randconfig-001-20260504    gcc-12.5.0
powerpc               randconfig-001-20260504    gcc-13.4.0
powerpc               randconfig-001-20260505    gcc-14.3.0
powerpc                        randconfig-002    gcc-10.5.0
powerpc                        randconfig-002    gcc-13.4.0
powerpc                        randconfig-002    gcc-14.3.0
powerpc               randconfig-002-20260504    clang-23
powerpc               randconfig-002-20260504    gcc-13.4.0
powerpc               randconfig-002-20260505    gcc-14.3.0
powerpc                     tqm8560_defconfig    gcc-15.2.0
powerpc64                      randconfig-001    clang-17
powerpc64                      randconfig-001    gcc-13.4.0
powerpc64                      randconfig-001    gcc-14.3.0
powerpc64             randconfig-001-20260504    gcc-10.5.0
powerpc64             randconfig-001-20260504    gcc-13.4.0
powerpc64             randconfig-001-20260505    gcc-14.3.0
powerpc64                      randconfig-002    clang-23
powerpc64                      randconfig-002    gcc-13.4.0
powerpc64                      randconfig-002    gcc-14.3.0
powerpc64             randconfig-002-20260504    clang-23
powerpc64             randconfig-002-20260504    gcc-13.4.0
powerpc64             randconfig-002-20260505    gcc-14.3.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-23
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260504    gcc-8.5.0
riscv                 randconfig-001-20260505    gcc-10.5.0
riscv                 randconfig-002-20260504    gcc-8.5.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-23
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260504    gcc-8.5.0
s390                  randconfig-002-20260504    gcc-8.5.0
s390                  randconfig-002-20260505    gcc-10.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                          lboxre2_defconfig    gcc-15.2.0
sh                    randconfig-001-20260504    gcc-8.5.0
sh                    randconfig-001-20260505    gcc-10.5.0
sh                    randconfig-002-20260504    gcc-8.5.0
sh                    randconfig-002-20260505    gcc-10.5.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                          randconfig-001    gcc-8.5.0
sparc                 randconfig-001-20260504    gcc-15.2.0
sparc                 randconfig-001-20260504    gcc-8.5.0
sparc                 randconfig-001-20260505    gcc-15.2.0
sparc                          randconfig-002    gcc-15.2.0
sparc                 randconfig-002-20260504    gcc-8.5.0
sparc                 randconfig-002-20260505    gcc-15.2.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64                        randconfig-001    gcc-8.5.0
sparc64               randconfig-001-20260504    clang-23
sparc64               randconfig-001-20260504    gcc-8.5.0
sparc64               randconfig-001-20260505    gcc-15.2.0
sparc64                        randconfig-002    clang-23
sparc64               randconfig-002-20260504    gcc-8.5.0
sparc64               randconfig-002-20260505    gcc-15.2.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                             randconfig-001    clang-23
um                    randconfig-001-20260504    clang-19
um                    randconfig-001-20260504    gcc-8.5.0
um                    randconfig-001-20260505    gcc-15.2.0
um                             randconfig-002    clang-23
um                    randconfig-002-20260504    gcc-14
um                    randconfig-002-20260504    gcc-8.5.0
um                    randconfig-002-20260505    gcc-15.2.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                            allnoconfig    gcc-15.2.0
x86_64                           allyesconfig    clang-20
x86_64               buildonly-randconfig-001    gcc-12
x86_64      buildonly-randconfig-001-20260504    gcc-12
x86_64      buildonly-randconfig-001-20260505    clang-20
x86_64               buildonly-randconfig-002    gcc-12
x86_64      buildonly-randconfig-002-20260504    gcc-12
x86_64      buildonly-randconfig-002-20260505    clang-20
x86_64               buildonly-randconfig-003    gcc-12
x86_64      buildonly-randconfig-003-20260504    gcc-12
x86_64      buildonly-randconfig-003-20260505    clang-20
x86_64               buildonly-randconfig-004    gcc-12
x86_64      buildonly-randconfig-004-20260504    gcc-12
x86_64      buildonly-randconfig-004-20260505    clang-20
x86_64               buildonly-randconfig-005    gcc-12
x86_64      buildonly-randconfig-005-20260504    gcc-12
x86_64      buildonly-randconfig-005-20260505    clang-20
x86_64               buildonly-randconfig-006    gcc-12
x86_64      buildonly-randconfig-006-20260504    gcc-12
x86_64      buildonly-randconfig-006-20260505    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260504    gcc-14
x86_64                randconfig-001-20260505    clang-20
x86_64                randconfig-002-20260504    gcc-14
x86_64                randconfig-002-20260505    clang-20
x86_64                randconfig-002-20260505    gcc-14
x86_64                randconfig-003-20260504    gcc-14
x86_64                randconfig-003-20260505    clang-20
x86_64                randconfig-004-20260504    gcc-14
x86_64                randconfig-004-20260505    clang-20
x86_64                randconfig-005-20260504    gcc-14
x86_64                randconfig-005-20260505    clang-20
x86_64                randconfig-006-20260504    gcc-14
x86_64                randconfig-006-20260505    clang-20
x86_64                         randconfig-011    gcc-14
x86_64                randconfig-011-20260504    gcc-14
x86_64                randconfig-011-20260505    clang-20
x86_64                         randconfig-012    gcc-14
x86_64                randconfig-012-20260504    gcc-14
x86_64                randconfig-012-20260505    clang-20
x86_64                         randconfig-013    gcc-14
x86_64                randconfig-013-20260504    gcc-14
x86_64                randconfig-013-20260505    clang-20
x86_64                         randconfig-014    gcc-14
x86_64                randconfig-014-20260504    gcc-14
x86_64                randconfig-014-20260505    clang-20
x86_64                         randconfig-015    gcc-14
x86_64                randconfig-015-20260504    gcc-14
x86_64                randconfig-015-20260505    clang-20
x86_64                         randconfig-016    gcc-14
x86_64                randconfig-016-20260504    gcc-14
x86_64                randconfig-016-20260505    clang-20
x86_64                         randconfig-071    clang-20
x86_64                randconfig-071-20260504    clang-20
x86_64                randconfig-071-20260505    clang-20
x86_64                randconfig-071-20260505    gcc-14
x86_64                         randconfig-072    clang-20
x86_64                randconfig-072-20260504    clang-20
x86_64                randconfig-072-20260505    clang-20
x86_64                         randconfig-073    clang-20
x86_64                randconfig-073-20260504    clang-20
x86_64                randconfig-073-20260505    clang-20
x86_64                randconfig-073-20260505    gcc-14
x86_64                         randconfig-074    clang-20
x86_64                randconfig-074-20260504    clang-20
x86_64                randconfig-074-20260505    clang-20
x86_64                randconfig-074-20260505    gcc-14
x86_64                         randconfig-075    clang-20
x86_64                randconfig-075-20260504    clang-20
x86_64                randconfig-075-20260505    clang-20
x86_64                         randconfig-076    clang-20
x86_64                randconfig-076-20260504    clang-20
x86_64                randconfig-076-20260505    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    clang-23
xtensa                           allyesconfig    gcc-11.5.0
xtensa                generic_kc705_defconfig    gcc-15.2.0
xtensa                         randconfig-001    gcc-8.5.0
xtensa                randconfig-001-20260504    gcc-8.5.0
xtensa                randconfig-001-20260504    gcc-9.5.0
xtensa                randconfig-001-20260505    gcc-15.2.0
xtensa                         randconfig-002    gcc-8.5.0
xtensa                randconfig-002-20260504    gcc-13.4.0
xtensa                randconfig-002-20260504    gcc-8.5.0
xtensa                randconfig-002-20260505    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

