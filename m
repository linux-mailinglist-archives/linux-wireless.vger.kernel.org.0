Return-Path: <linux-wireless+bounces-33313-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CAXGMaZ0uGn5dgEAu9opvQ
	(envelope-from <linux-wireless+bounces-33313-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 22:22:46 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A01A2A0D24
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 22:22:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6DB8630ACA32
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 21:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81F3371D11;
	Mon, 16 Mar 2026 21:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jde+p1F1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6929936494D
	for <linux-wireless@vger.kernel.org>; Mon, 16 Mar 2026 21:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773695734; cv=none; b=KoVD+UwsiFb4oPD6dwYpfS2coq+z4uT+hOWj323t0s1+fa5hKtYyNhUX0sLUVCN4yr8yVaQDq315zdeYTZurqrLlpJmiHZ5NM9GeMODhfrQsaC6bFf0sxyypFP6O+14VUt4yjPw7WPNa6YfDyCfTBDaSgoUvXRu73QRbsSlelWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773695734; c=relaxed/simple;
	bh=jgnAZgjMynDUGmD285tA9bee9VPgjf7KUnewHMETqnc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Zpd9y6fGxHXsj92XWbDbqmY77Ez32iC9M81PQV5+UF7KZzezOHl0xqXSJGviXIorAMQjfB43bjxM9QH3W1UeRG5bbkROuDuVv8i8S7CB1vo7ndQ9Y/sdkTjw5nm7A3WWMwac46Mqwgzbb4y8oiit2n0RvNA7sLw1Y4Bg4fIbaqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jde+p1F1; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773695734; x=1805231734;
  h=date:from:to:cc:subject:message-id;
  bh=jgnAZgjMynDUGmD285tA9bee9VPgjf7KUnewHMETqnc=;
  b=Jde+p1F1ZLIfmDJC5J35T5FRy+rtA/WKZ3yFnVpnTM6U43U4cGd/RIXw
   WqbxVG0Xf2b1+GplHrQL9VncsJiEWt+WYn/zmaydhv4j8cRVwTe2Zb+Wp
   QRA8bgHe3X58Ws9ODryeDpzZHexftnJW8wJ2yAFcO/mpibYATpiwYlVWG
   ezuu2rxhv+PZHcssC/6+xqkrqyns175OC45tFJU6Ti2rYIhAyoHcBUvUt
   mX6+43fAGwiubIq3eEcZFBkTAy8K3Rip0eTsdbKoBI8AneNgweXZM73r2
   IJte0RllX2/xMyKjQTL0+XaZdjGpd25lMwhKMLpqtTJ0lMNDOs9uipXCn
   w==;
X-CSE-ConnectionGUID: 2phCiGI0Qlq4P4YCH68MaA==
X-CSE-MsgGUID: dWjCP8mqRtaq+PVC/DIsSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="74695017"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="74695017"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 14:15:33 -0700
X-CSE-ConnectionGUID: 3ERiKmyfRtiyL/krYH3w5Q==
X-CSE-MsgGUID: O8Kiq82KTKWE/n6Wizgr4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="226494364"
Received: from lkp-server01.sh.intel.com (HELO 892944969b78) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 16 Mar 2026 14:15:32 -0700
Received: from kbuild by 892944969b78 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w2FHd-000000001Ik-1TMW;
	Mon, 16 Mar 2026 21:15:29 +0000
Date: Tue, 17 Mar 2026 05:15:29 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 d3947aac97c3e57ee2f85fd1bef8e7674e609c45
Message-ID: <202603170523.EZjcgfto-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-33313-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 6A01A2A0D24
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: d3947aac97c3e57ee2f85fd1bef8e7674e609c45  wifi: nl80211: reject S1G/60G with HT chantype

elapsed time: 1560m

configs tested: 144
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    gcc-15.2.0
arc                   randconfig-001-20260317    gcc-9.5.0
arc                   randconfig-002-20260317    gcc-13.4.0
arm                               allnoconfig    clang-23
arm                              allyesconfig    gcc-15.2.0
arm                       netwinder_defconfig    gcc-15.2.0
arm                   randconfig-001-20260317    clang-23
arm                   randconfig-002-20260317    clang-23
arm                   randconfig-003-20260317    clang-23
arm                   randconfig-004-20260317    clang-23
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.2.0
arm64                 randconfig-001-20260317    clang-23
arm64                 randconfig-002-20260317    clang-23
arm64                 randconfig-003-20260317    clang-23
arm64                 randconfig-004-20260317    clang-16
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                  randconfig-001-20260317    gcc-15.2.0
csky                  randconfig-002-20260317    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-23
hexagon               randconfig-001-20260317    clang-23
hexagon               randconfig-002-20260317    clang-23
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260317    clang-20
i386        buildonly-randconfig-002-20260317    clang-20
i386        buildonly-randconfig-003-20260317    clang-20
i386        buildonly-randconfig-004-20260317    clang-20
i386        buildonly-randconfig-005-20260317    clang-20
i386        buildonly-randconfig-006-20260317    clang-20
i386                  randconfig-001-20260316    gcc-14
i386                  randconfig-002-20260316    clang-20
i386                  randconfig-003-20260316    gcc-14
i386                  randconfig-004-20260316    gcc-14
i386                  randconfig-005-20260316    clang-20
i386                  randconfig-006-20260316    gcc-12
i386                  randconfig-007-20260316    gcc-14
i386                  randconfig-011-20260317    gcc-14
i386                  randconfig-012-20260317    gcc-14
i386                  randconfig-013-20260317    gcc-14
i386                  randconfig-014-20260317    clang-20
i386                  randconfig-015-20260317    clang-20
i386                  randconfig-016-20260317    gcc-14
i386                  randconfig-017-20260317    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-23
loongarch             randconfig-001-20260317    clang-23
loongarch             randconfig-002-20260317    clang-18
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
nios2                 randconfig-001-20260317    gcc-8.5.0
nios2                 randconfig-002-20260317    gcc-11.5.0
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260316    gcc-8.5.0
parisc                randconfig-001-20260317    gcc-11.5.0
parisc                randconfig-002-20260316    gcc-12.5.0
parisc                randconfig-002-20260317    gcc-14.3.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260316    clang-23
powerpc               randconfig-001-20260317    gcc-8.5.0
powerpc               randconfig-002-20260316    clang-23
powerpc               randconfig-002-20260317    clang-23
powerpc64             randconfig-001-20260316    gcc-13.4.0
powerpc64             randconfig-001-20260317    gcc-8.5.0
powerpc64             randconfig-002-20260316    gcc-8.5.0
powerpc64             randconfig-002-20260317    clang-23
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-23
riscv                 randconfig-001-20260317    clang-23
riscv                 randconfig-002-20260317    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-23
s390                  randconfig-001-20260317    gcc-15.2.0
s390                  randconfig-002-20260317    clang-23
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-15.2.0
sh                    randconfig-001-20260317    gcc-15.2.0
sh                    randconfig-002-20260317    gcc-10.5.0
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260316    gcc-8.5.0
sparc                 randconfig-002-20260316    gcc-12.5.0
sparc64                          allmodconfig    clang-23
sparc64               randconfig-001-20260316    gcc-8.5.0
sparc64               randconfig-002-20260316    gcc-15.2.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                                  defconfig    clang-23
um                    randconfig-001-20260316    gcc-14
um                    randconfig-002-20260316    clang-23
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260317    clang-20
x86_64      buildonly-randconfig-002-20260317    gcc-14
x86_64      buildonly-randconfig-003-20260317    clang-20
x86_64      buildonly-randconfig-004-20260317    clang-20
x86_64      buildonly-randconfig-005-20260317    clang-20
x86_64      buildonly-randconfig-006-20260317    gcc-14
x86_64                randconfig-011-20260317    gcc-14
x86_64                randconfig-012-20260317    clang-20
x86_64                randconfig-013-20260317    clang-20
x86_64                randconfig-014-20260317    gcc-14
x86_64                randconfig-015-20260317    clang-20
x86_64                randconfig-016-20260317    clang-20
x86_64                randconfig-071-20260316    gcc-12
x86_64                randconfig-072-20260316    gcc-14
x86_64                randconfig-073-20260316    gcc-14
x86_64                randconfig-074-20260316    gcc-14
x86_64                randconfig-075-20260316    clang-20
x86_64                randconfig-076-20260316    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    gcc-15.2.0
xtensa                randconfig-001-20260316    gcc-15.2.0
xtensa                randconfig-002-20260316    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

