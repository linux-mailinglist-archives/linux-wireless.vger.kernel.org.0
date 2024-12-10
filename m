Return-Path: <linux-wireless+bounces-16158-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 249999EB155
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Dec 2024 13:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 871B2281D27
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Dec 2024 12:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1E01A76BB;
	Tue, 10 Dec 2024 12:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mPfIa0Uv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB381A3AB8
	for <linux-wireless@vger.kernel.org>; Tue, 10 Dec 2024 12:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733835343; cv=none; b=NeLB5NCUjnFqy2lQarYOiCPERabIyYkKUa0eiIP/yCkWhc6br7zoIKzlGkxnlaeXutyw9JPgtLsG96NPC9pvDSQcaYLH6dOQNeD9Zv2gdUgJZ/dOJ4k7twcOxUyW1jT2sRPuwfHGgCPLj3RpBidL1EacCuJJrNPZ8gf8ceWezOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733835343; c=relaxed/simple;
	bh=BRVna7d11/coQLVzEo7G1h5NJOM1d45phkJ1jbuwJKc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=FC7nre+25LvPoiTrOFUuovTviKUZYEKyYQgaRKVEwjkP9K0WsxJmZxxp9Kjz066LTN8nGa3xdNYNkPaafI7ACmS/fT7Xanv1ZOqwlafoq8pbuPBCg6/EXxURTqhfTQQgdM3evsoZ/mkoheyz6IsPrwb0Pis1sGNXK0LwAMMolNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mPfIa0Uv; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733835341; x=1765371341;
  h=date:from:to:cc:subject:message-id;
  bh=BRVna7d11/coQLVzEo7G1h5NJOM1d45phkJ1jbuwJKc=;
  b=mPfIa0Uv0Jpn47OBdQouAipv2O3NHEN/LJ+Etdekq7VJFzThnh3Xjl4u
   a8J3CRSoahFbnMvGchlUDbHxVerlXvQJBOyE5DbR2sjDP17A6OaVyY87T
   BnnK3ufWMwKgUOEH8ZsY61K42cthV+m+ABZShZY6mn8RTBubp5daaqW+h
   muQiRL/7dszJ/clQk8lKYJNUD3LS1k3htPUlOZ8n0/OOuJo8TvGV8IfPD
   3nDtgz8RKU8JUEl5n9VZJrya5DQgSngv9wuvQvMVyUpi+biJuTkSkzR4t
   RxPUA2M/Smk//NuEwm/DrgQ2U923/HNNWBZrv9GDUmwLB8B3eRNwmzHBi
   Q==;
X-CSE-ConnectionGUID: D/HfMzRzQhOTueFnCgcqcQ==
X-CSE-MsgGUID: wTG33EDJTbaDCGz+RgV3bw==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="45574881"
X-IronPort-AV: E=Sophos;i="6.12,222,1728975600"; 
   d="scan'208";a="45574881"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 04:55:41 -0800
X-CSE-ConnectionGUID: IsjcezFkQFqFRGWuoSvUoQ==
X-CSE-MsgGUID: O81DKUECQPao56iyi2k/ZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,222,1728975600"; 
   d="scan'208";a="100434918"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 10 Dec 2024 04:55:39 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tKzm5-0005YP-05;
	Tue, 10 Dec 2024 12:55:37 +0000
Date: Tue, 10 Dec 2024 20:55:12 +0800
From: kernel test robot <lkp@intel.com>
To: Kalle Valo <kvalo@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 b20821248e262a7d16882137419460030c1aead6
Message-ID: <202412102006.C5We5y1i-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: b20821248e262a7d16882137419460030c1aead6  Merge tag 'ath-next-20241209' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath

elapsed time: 1020m

configs tested: 119
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-20
arc                              allmodconfig    clang-18
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-18
arc                   randconfig-001-20241210    gcc-13.2.0
arc                   randconfig-002-20241210    gcc-13.2.0
arm                              allmodconfig    clang-18
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-18
arm                   randconfig-001-20241210    clang-20
arm                   randconfig-002-20241210    gcc-14.2.0
arm                   randconfig-003-20241210    clang-20
arm                   randconfig-004-20241210    clang-20
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20241210    clang-20
arm64                 randconfig-002-20241210    clang-20
arm64                 randconfig-003-20241210    clang-20
arm64                 randconfig-004-20241210    clang-20
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20241210    gcc-14.2.0
csky                  randconfig-002-20241210    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-20
hexagon               randconfig-001-20241210    clang-16
hexagon               randconfig-002-20241210    clang-14
i386                             allmodconfig    clang-19
i386                              allnoconfig    clang-19
i386                             allyesconfig    clang-19
i386        buildonly-randconfig-001-20241210    gcc-12
i386        buildonly-randconfig-002-20241210    clang-19
i386        buildonly-randconfig-003-20241210    gcc-12
i386        buildonly-randconfig-004-20241210    clang-19
i386        buildonly-randconfig-005-20241210    clang-19
i386        buildonly-randconfig-006-20241210    clang-19
i386                                defconfig    clang-19
i386                  randconfig-001-20241210    clang-19
i386                  randconfig-002-20241210    clang-19
i386                  randconfig-003-20241210    clang-19
i386                  randconfig-004-20241210    clang-19
i386                  randconfig-005-20241210    clang-19
i386                  randconfig-006-20241210    clang-19
i386                  randconfig-007-20241210    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20241210    gcc-14.2.0
loongarch             randconfig-002-20241210    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20241210    gcc-14.2.0
nios2                 randconfig-002-20241210    gcc-14.2.0
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.2.0
parisc                randconfig-001-20241210    gcc-14.2.0
parisc                randconfig-002-20241210    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    clang-16
powerpc                          allyesconfig    gcc-14.2.0
powerpc               randconfig-001-20241210    clang-20
powerpc               randconfig-002-20241210    clang-20
powerpc               randconfig-003-20241210    clang-20
powerpc64             randconfig-001-20241210    gcc-14.2.0
powerpc64             randconfig-002-20241210    gcc-14.2.0
powerpc64             randconfig-003-20241210    gcc-14.2.0
riscv                            allmodconfig    clang-20
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    clang-20
riscv                            allyesconfig    gcc-14.2.0
riscv                 randconfig-001-20241210    clang-19
riscv                 randconfig-002-20241210    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20241210    gcc-14.2.0
s390                  randconfig-002-20241210    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20241210    gcc-14.2.0
sh                    randconfig-002-20241210    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20241210    gcc-14.2.0
sparc                 randconfig-002-20241210    gcc-14.2.0
sparc64               randconfig-001-20241210    gcc-14.2.0
sparc64               randconfig-002-20241210    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                    randconfig-001-20241210    clang-20
um                    randconfig-002-20241210    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241210    gcc-12
x86_64      buildonly-randconfig-002-20241210    clang-19
x86_64      buildonly-randconfig-003-20241210    clang-19
x86_64      buildonly-randconfig-004-20241210    gcc-12
x86_64      buildonly-randconfig-005-20241210    gcc-12
x86_64      buildonly-randconfig-006-20241210    clang-19
x86_64                              defconfig    clang-19
x86_64                                  kexec    clang-19
x86_64                               rhel-9.4    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20241210    gcc-14.2.0
xtensa                randconfig-002-20241210    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

