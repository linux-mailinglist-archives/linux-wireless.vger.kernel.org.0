Return-Path: <linux-wireless+bounces-22728-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D11DEAAF40F
	for <lists+linux-wireless@lfdr.de>; Thu,  8 May 2025 08:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 122EF1BC6E42
	for <lists+linux-wireless@lfdr.de>; Thu,  8 May 2025 06:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9B813AA3E;
	Thu,  8 May 2025 06:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zkte0lHr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4872B9AA
	for <linux-wireless@vger.kernel.org>; Thu,  8 May 2025 06:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746686912; cv=none; b=tIXRFNV0g4YViUIFBBrSBuVb7hy+Qlmt5Zq9shCi1ouG33i6wvMdyd4pE85zE6pbALL2Ulmv26r9fDkZ9F6De6F8vq/oUO/v5WFvhsZYdzpmc7Ez5fSlprz59KU7oAav3GnUSGzs5piek2HkItUQF6IXMEUUbXsi1cM5u65mNrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746686912; c=relaxed/simple;
	bh=UMpxepMiwQcHjWaDLbn9SQqsVOK+bpHEHkokyOyhpk4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Qn648u5BClyPmKiKeXViwjyLSZ2wkf3utosD5Sb3olQcumqWhQ8BxeIiBLgnFbdpCAi6ssYFReLPPzTZFEwSXiCDuRILEOdXJqKbVYzcjHnSCzQQSE4CZZQCMcEsEEzBH/mWFNT0MeHs92F7+bmus2Dy0K5IpWgNS4DEE1q5nXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zkte0lHr; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746686910; x=1778222910;
  h=date:from:to:cc:subject:message-id;
  bh=UMpxepMiwQcHjWaDLbn9SQqsVOK+bpHEHkokyOyhpk4=;
  b=Zkte0lHrJetIqlkPx4p6zghla6pdrYCRkXq8JnGJZs4+rJ7NgYvEGoJu
   A3k31rrTRbbX1eYEnnRdwASlYGJxzyLkNXTWVU6EHfbsBaHmq8AYbQkuh
   egafcrxSqbj9l+OT+dqBBkiP9rGhuVDn/eutpDk6KCRlMXol3d5hdOY3s
   xp53JS/omwSHIoCWG11OnGOUKlPEI5BRWrH6kFfVlaT6J6rRBGc5KQg57
   y2elDqGcY+7Wfdk61Er/HNgINQO7qa+RQdxpUGP78CkeACEIgu8Veyd9Z
   mDMYujsKp6cMBynjd0fpIViNBhtZTvDLG+suai83oalRXITWP5nI9wV0X
   w==;
X-CSE-ConnectionGUID: T+nVl6k+R5mrsxEvGIY+4g==
X-CSE-MsgGUID: yPfEPxsCSoOUviAZLkEc4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="48320092"
X-IronPort-AV: E=Sophos;i="6.15,271,1739865600"; 
   d="scan'208";a="48320092"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 23:48:29 -0700
X-CSE-ConnectionGUID: q1BYWtDiQ/iN7hJRsgtR9w==
X-CSE-MsgGUID: bxygPpE6QYWgFC8VIqxYsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,271,1739865600"; 
   d="scan'208";a="136697865"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 07 May 2025 23:48:28 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uCv3R-000AiT-2H;
	Thu, 08 May 2025 06:48:25 +0000
Date: Thu, 08 May 2025 14:47:45 +0800
From: kernel test robot <lkp@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 9daaf197860055aa26c06d273d317c18c6e3621a
Message-ID: <202505081439.gEPW9Ox4-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 9daaf197860055aa26c06d273d317c18c6e3621a  Merge tag 'wireless-next-2025-05-06' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next

elapsed time: 1694m

configs tested: 79
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha               allnoconfig    gcc-14.2.0
alpha              allyesconfig    clang-19
alpha              allyesconfig    gcc-14.2.0
arc                allmodconfig    clang-19
arc                allmodconfig    gcc-14.2.0
arc                 allnoconfig    gcc-14.2.0
arc                allyesconfig    clang-19
arc                allyesconfig    gcc-14.2.0
arm                allmodconfig    clang-19
arm                allmodconfig    gcc-14.2.0
arm                 allnoconfig    clang-21
arm                 allnoconfig    gcc-14.2.0
arm                allyesconfig    clang-19
arm                allyesconfig    gcc-14.2.0
arm64              allmodconfig    clang-19
arm64               allnoconfig    gcc-14.2.0
csky                allnoconfig    gcc-14.2.0
hexagon            allmodconfig    clang-17
hexagon            allmodconfig    clang-19
hexagon             allnoconfig    clang-21
hexagon             allnoconfig    gcc-14.2.0
hexagon            allyesconfig    clang-19
hexagon            allyesconfig    clang-21
i386               allmodconfig    clang-20
i386               allmodconfig    gcc-12
i386                allnoconfig    clang-20
i386                allnoconfig    gcc-12
i386               allyesconfig    clang-20
i386               allyesconfig    gcc-12
i386                  defconfig    clang-20
loongarch          allmodconfig    gcc-14.2.0
loongarch           allnoconfig    gcc-14.2.0
m68k               allmodconfig    gcc-14.2.0
m68k                allnoconfig    gcc-14.2.0
m68k               allyesconfig    gcc-14.2.0
microblaze         allmodconfig    gcc-14.2.0
microblaze          allnoconfig    gcc-14.2.0
microblaze         allyesconfig    gcc-14.2.0
mips                allnoconfig    gcc-14.2.0
nios2               allnoconfig    gcc-14.2.0
openrisc            allnoconfig    gcc-14.2.0
openrisc           allyesconfig    gcc-14.2.0
parisc             allmodconfig    gcc-14.2.0
parisc              allnoconfig    gcc-14.2.0
parisc             allyesconfig    gcc-14.2.0
powerpc            allmodconfig    gcc-14.2.0
powerpc             allnoconfig    gcc-14.2.0
powerpc            allyesconfig    clang-21
powerpc            allyesconfig    gcc-14.2.0
riscv              allmodconfig    clang-21
riscv              allmodconfig    gcc-14.2.0
riscv               allnoconfig    gcc-14.2.0
riscv              allyesconfig    clang-16
riscv              allyesconfig    gcc-14.2.0
s390               allmodconfig    clang-18
s390               allmodconfig    gcc-14.2.0
s390                allnoconfig    clang-21
s390               allyesconfig    gcc-14.2.0
sh                 allmodconfig    gcc-14.2.0
sh                  allnoconfig    gcc-14.2.0
sh                 allyesconfig    gcc-14.2.0
sparc              allmodconfig    gcc-14.2.0
sparc               allnoconfig    gcc-14.2.0
um                 allmodconfig    clang-19
um                  allnoconfig    clang-21
um                 allyesconfig    clang-19
um                 allyesconfig    gcc-12
x86_64              allnoconfig    clang-20
x86_64             allyesconfig    clang-20
x86_64                defconfig    clang-20
x86_64                defconfig    gcc-11
x86_64                    kexec    clang-20
x86_64                 rhel-9.4    clang-20
x86_64             rhel-9.4-bpf    clang-18
x86_64      rhel-9.4-kselftests    clang-20
x86_64           rhel-9.4-kunit    clang-18
x86_64             rhel-9.4-ltp    clang-18
x86_64            rhel-9.4-rust    clang-18
xtensa              allnoconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

