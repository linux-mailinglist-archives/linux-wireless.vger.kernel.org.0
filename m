Return-Path: <linux-wireless+bounces-19659-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61886A4AC44
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Mar 2025 15:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38AEC17238B
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Mar 2025 14:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41351E25ED;
	Sat,  1 Mar 2025 14:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WqipW6TB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCFF19D8A7
	for <linux-wireless@vger.kernel.org>; Sat,  1 Mar 2025 14:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740839661; cv=none; b=IPJRxKdZK+J3dadf6UPMm2LxSdKpug1GZwClcoa4MLVaUdyAqvjovPC/5A7MoTWRznmbHrplltaGJ5T7hnTLMvBMYYagLX5CJ6BSi7rCvFgPIPMOQ2XGFkMTfSh5rhyANFPKrZZ+H6OOz8Qyp7JjtTn0wyC5+DgbGNZ1IEzvJaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740839661; c=relaxed/simple;
	bh=aEN41t3EjeoHDDbRJFPEKXVVy3icY3tMrZ7Vf15MjBM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=qxQ5P5RpQc+7ee48oDXWaAgG1z+mLFk87pkF2vTMXu4xPFXXKZaL9F0X0jM4HEvHf8bqNof8zjf5soIsdh2mzF1TMSVzJCXoYS2uPg7rTv5CBdIP5YFy4oWBYtRxoqqyPgH5kyz2mfj3lHsyKp+mFMD/4BBxBeeIKQFpLKliSvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WqipW6TB; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740839660; x=1772375660;
  h=date:from:to:cc:subject:message-id;
  bh=aEN41t3EjeoHDDbRJFPEKXVVy3icY3tMrZ7Vf15MjBM=;
  b=WqipW6TB01DURqmqNWwdoKdKypTeA2Fd0+ZUyCp6SxIht6ZSG2JTU5xv
   ZmARhBJI/p4AJJtmf7Eu8tLo6DtAtba0pT26eI6nsKfboRqpGXMtmRX8E
   uJ3QHzR7n7399HyiJPZxdHF9JAqSpqi1zxdqWhKQd7V7LFv6D5jpImwgq
   fzqV19F+MgwYP+1XmzEdv9uh+MCYkBd4PKNCC2ACLWCbsBIAqCLNEyzdt
   LT43oFww+RUUPydrTuYTBQfor97FisWmij2692PHWjlgwJPVDaC6U3tCJ
   jJNUSfBlBfM3lEBUzkwilYrKFJeQZG+W/3I0egSlKomHQscgvjQX37QuQ
   A==;
X-CSE-ConnectionGUID: jk4G7s79SGyVh2O8gyvg5A==
X-CSE-MsgGUID: TblEDPatTGyL0i3pEBddmQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11359"; a="59171031"
X-IronPort-AV: E=Sophos;i="6.13,325,1732608000"; 
   d="scan'208";a="59171031"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2025 06:34:20 -0800
X-CSE-ConnectionGUID: +Kfey+lyRKKx54/hrSu1dw==
X-CSE-MsgGUID: NDXIr4ZdQkqYpzVc4vzkPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,325,1732608000"; 
   d="scan'208";a="117582765"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 01 Mar 2025 06:34:18 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1toNuK-000GKI-28;
	Sat, 01 Mar 2025 14:33:45 +0000
Date: Sat, 01 Mar 2025 22:33:14 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 e5328c14590d034dc586e56aaab88e966d06efa7
Message-ID: <202503012206.gXDsqFoa-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: e5328c14590d034dc586e56aaab88e966d06efa7  wifi: mac80211: refactor populating mesh related fields in sinfo

elapsed time: 1445m

configs tested: 76
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                           allyesconfig    gcc-14.2.0
arc                             allmodconfig    gcc-13.2.0
arc                             allyesconfig    gcc-13.2.0
arc                  randconfig-001-20250301    gcc-13.2.0
arc                  randconfig-002-20250301    gcc-13.2.0
arm                             allmodconfig    gcc-14.2.0
arm                             allyesconfig    gcc-14.2.0
arm                  randconfig-001-20250301    gcc-14.2.0
arm                  randconfig-002-20250301    gcc-14.2.0
arm                  randconfig-003-20250301    clang-21
arm                  randconfig-004-20250301    clang-21
arm64                randconfig-001-20250301    gcc-14.2.0
arm64                randconfig-002-20250301    clang-21
arm64                randconfig-003-20250301    clang-15
arm64                randconfig-004-20250301    clang-17
csky                 randconfig-001-20250301    gcc-14.2.0
csky                 randconfig-002-20250301    gcc-14.2.0
hexagon                         allmodconfig    clang-21
hexagon                         allyesconfig    clang-18
hexagon              randconfig-001-20250301    clang-21
hexagon              randconfig-002-20250301    clang-21
i386       buildonly-randconfig-001-20250301    clang-19
i386       buildonly-randconfig-002-20250301    clang-19
i386       buildonly-randconfig-003-20250301    clang-19
i386       buildonly-randconfig-004-20250301    clang-19
i386       buildonly-randconfig-005-20250301    gcc-12
i386       buildonly-randconfig-006-20250301    clang-19
loongarch            randconfig-001-20250301    gcc-14.2.0
loongarch            randconfig-002-20250301    gcc-14.2.0
nios2                randconfig-001-20250301    gcc-14.2.0
nios2                randconfig-002-20250301    gcc-14.2.0
openrisc                         allnoconfig    gcc-14.2.0
openrisc                        allyesconfig    gcc-14.2.0
parisc                          allmodconfig    gcc-14.2.0
parisc                           allnoconfig    gcc-14.2.0
parisc                          allyesconfig    gcc-14.2.0
parisc               randconfig-001-20250301    gcc-14.2.0
parisc               randconfig-002-20250301    gcc-14.2.0
powerpc                         allmodconfig    gcc-14.2.0
powerpc                          allnoconfig    gcc-14.2.0
powerpc              randconfig-001-20250301    clang-17
powerpc              randconfig-002-20250301    clang-19
powerpc              randconfig-003-20250301    clang-21
powerpc64            randconfig-001-20250301    gcc-14.2.0
powerpc64            randconfig-002-20250301    clang-21
powerpc64            randconfig-003-20250301    gcc-14.2.0
riscv                            allnoconfig    gcc-14.2.0
riscv                randconfig-001-20250301    gcc-14.2.0
riscv                randconfig-002-20250301    gcc-14.2.0
s390                            allmodconfig    clang-19
s390                             allnoconfig    clang-15
s390                            allyesconfig    gcc-14.2.0
s390                 randconfig-001-20250301    clang-15
s390                 randconfig-002-20250301    gcc-14.2.0
sh                              allmodconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                   randconfig-001-20250301    gcc-14.2.0
sh                   randconfig-002-20250301    gcc-14.2.0
sparc                           allmodconfig    gcc-14.2.0
sparc                randconfig-001-20250301    gcc-14.2.0
sparc                randconfig-002-20250301    gcc-14.2.0
sparc64              randconfig-001-20250301    gcc-14.2.0
sparc64              randconfig-002-20250301    gcc-14.2.0
um                              allmodconfig    clang-21
um                               allnoconfig    clang-18
um                              allyesconfig    gcc-12
um                   randconfig-001-20250301    gcc-12
um                   randconfig-002-20250301    gcc-12
x86_64     buildonly-randconfig-001-20250228    clang-19
x86_64     buildonly-randconfig-002-20250228    clang-19
x86_64     buildonly-randconfig-003-20250228    gcc-12
x86_64     buildonly-randconfig-004-20250228    clang-19
x86_64     buildonly-randconfig-005-20250228    gcc-12
x86_64     buildonly-randconfig-006-20250228    gcc-12
xtensa               randconfig-001-20250301    gcc-14.2.0
xtensa               randconfig-002-20250301    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

