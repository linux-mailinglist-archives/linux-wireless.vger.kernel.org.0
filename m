Return-Path: <linux-wireless+bounces-16393-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 322269F1F2E
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Dec 2024 15:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F20216491C
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Dec 2024 14:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1FE11712;
	Sat, 14 Dec 2024 14:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DJBq2Igw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873F0D53C
	for <linux-wireless@vger.kernel.org>; Sat, 14 Dec 2024 14:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734185044; cv=none; b=SwVZSPW4zyOS+aCZNuqkEBkqagYlg4Tbi7aVZGYDTW8KP93DghLB4S4217Sm8T1fKXTYkVkS/cwCFhLBGO/A6QgUhuQpm8KgJ4XD+DkzrV761sI2mBrPQWSVItpWO74VrBpAsflLJfhazhTphesnnKmqdR6iXCRLZj2n/XM5+Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734185044; c=relaxed/simple;
	bh=PhPL47qvjkdnAjoyAcqUBJjkDmBEz8/yre+OMKu5QnM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=XB2QOP2HNKI9sy6kXc54P83TxJbiUWIenguFDYswYs045+pjkSatwWyv7sbbr+xHzllGUX3QzZBHxYyx59a6xOjBnlotARB5GgW6+z9skSu4bzRaPf3BFZYRc/mxjbHwfXHjRu1Pr95ym5QVOiNEu1STmYgp/PqCar9mU8RAkbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DJBq2Igw; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734185043; x=1765721043;
  h=date:from:to:cc:subject:message-id;
  bh=PhPL47qvjkdnAjoyAcqUBJjkDmBEz8/yre+OMKu5QnM=;
  b=DJBq2Igw75nBsjBgyPba8ax2aiEN3qTuEULyQP+3H1p0BTPsE+S4UikI
   CuvoHkrbTO6cO1fbj396i41OJjjuwY9ygqpXLv+OXvIYsJVr0uGbdPBD3
   aiBKtW257LIFDEHlssn1mj5eSPUr2/qRMcvfjl2JG7iYZZ7ABaJaj6JYu
   uDEDouPmfY6W43HBORXTVXPFHGTvX7bn9rGLfgH/Mp4uhzi7Q6yK3GuGP
   xU920Bb7dXdsTPWnzn75/esVuQCSeV5x4icx3oUsn8ZPBxZNWT5u+Y/gt
   0Dngbhp4GjdpVmY8MModaLg3EJED4LuKd/t8bYvu3maY2bo0wHUgh3WBL
   A==;
X-CSE-ConnectionGUID: XiIdKE5bRhirn8o+MrWn5A==
X-CSE-MsgGUID: FOTju717SmOkknxz9p7tbA==
X-IronPort-AV: E=McAfee;i="6700,10204,11286"; a="34773479"
X-IronPort-AV: E=Sophos;i="6.12,234,1728975600"; 
   d="scan'208";a="34773479"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2024 06:04:02 -0800
X-CSE-ConnectionGUID: AdQemE56TWq6WnnTZ05WPg==
X-CSE-MsgGUID: qRUCrT+SQhOo5R9pHuEO4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="97219372"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 14 Dec 2024 06:04:01 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tMSkQ-000Cy3-0K;
	Sat, 14 Dec 2024 14:03:58 +0000
Date: Sat, 14 Dec 2024 22:03:20 +0800
From: kernel test robot <lkp@intel.com>
To: Kalle Valo <kvalo@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 104372ff359486b26b5a2db33b8e1dc6bfb39812
Message-ID: <202412142214.J8NfOQoA-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 104372ff359486b26b5a2db33b8e1dc6bfb39812  Merge tag 'rtw-next-2024-12-12' of https://github.com/pkshih/rtw

elapsed time: 1452m

configs tested: 62
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
arc                             allmodconfig    gcc-13.2.0
arc                             allyesconfig    gcc-13.2.0
arc                  randconfig-001-20241214    gcc-13.2.0
arc                  randconfig-002-20241214    gcc-13.2.0
arm                             allmodconfig    gcc-14.2.0
arm                             allyesconfig    gcc-14.2.0
arm                  randconfig-001-20241214    gcc-14.2.0
arm                  randconfig-002-20241214    clang-15
arm                  randconfig-003-20241214    gcc-14.2.0
arm                  randconfig-004-20241214    gcc-14.2.0
arm64                           allmodconfig    clang-18
arm64                randconfig-001-20241214    clang-15
arm64                randconfig-002-20241214    clang-20
arm64                randconfig-003-20241214    clang-15
arm64                randconfig-004-20241214    gcc-14.2.0
csky                 randconfig-001-20241214    gcc-14.2.0
csky                 randconfig-002-20241214    gcc-14.2.0
hexagon              randconfig-001-20241214    clang-20
hexagon              randconfig-002-20241214    clang-14
i386       buildonly-randconfig-001-20241213    clang-19
i386       buildonly-randconfig-002-20241213    gcc-12
i386       buildonly-randconfig-003-20241213    gcc-12
i386       buildonly-randconfig-004-20241213    clang-19
i386       buildonly-randconfig-005-20241213    gcc-12
i386       buildonly-randconfig-006-20241213    gcc-12
loongarch            randconfig-001-20241214    gcc-14.2.0
loongarch            randconfig-002-20241214    gcc-14.2.0
nios2                randconfig-001-20241214    gcc-14.2.0
nios2                randconfig-002-20241214    gcc-14.2.0
parisc               randconfig-001-20241214    gcc-14.2.0
parisc               randconfig-002-20241214    gcc-14.2.0
powerpc              randconfig-001-20241214    clang-20
powerpc              randconfig-002-20241214    clang-15
powerpc              randconfig-003-20241214    clang-20
powerpc64            randconfig-001-20241214    gcc-14.2.0
powerpc64            randconfig-002-20241214    gcc-14.2.0
powerpc64            randconfig-003-20241214    clang-20
riscv                randconfig-001-20241213    gcc-14.2.0
riscv                randconfig-002-20241213    gcc-14.2.0
s390                            allmodconfig    clang-19
s390                            allyesconfig    gcc-14.2.0
s390                 randconfig-001-20241213    gcc-14.2.0
s390                 randconfig-002-20241213    clang-19
sh                              allmodconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                   randconfig-001-20241213    gcc-14.2.0
sh                   randconfig-002-20241213    gcc-14.2.0
sparc                           allmodconfig    gcc-14.2.0
sparc                randconfig-001-20241213    gcc-14.2.0
sparc                randconfig-002-20241213    gcc-14.2.0
sparc64              randconfig-001-20241213    gcc-14.2.0
sparc64              randconfig-002-20241213    gcc-14.2.0
um                   randconfig-001-20241213    gcc-12
um                   randconfig-002-20241213    clang-16
x86_64     buildonly-randconfig-001-20241214    gcc-11
x86_64     buildonly-randconfig-002-20241214    clang-19
x86_64     buildonly-randconfig-003-20241214    gcc-12
x86_64     buildonly-randconfig-004-20241214    gcc-12
x86_64     buildonly-randconfig-005-20241214    gcc-12
x86_64     buildonly-randconfig-006-20241214    clang-19
xtensa               randconfig-001-20241213    gcc-14.2.0
xtensa               randconfig-002-20241213    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

