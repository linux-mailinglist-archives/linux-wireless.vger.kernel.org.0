Return-Path: <linux-wireless+bounces-24507-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF4BAE933D
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 02:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 231E76A4C3F
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 00:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819AC156CA;
	Thu, 26 Jun 2025 00:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OSCt8WNh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1308F54
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 00:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750896529; cv=none; b=iNdFsK3o7mX1lEqT69kxVxDO6nqhqP1nzY4fbrEP77+S9E32QhglDaO4fPpABT7jRtFol2uKynYt3JCUb+itxg/OlzAloGz1Uusoli2mlBdO2Ha49waY/GpeKNsQzRgG8Z8NzNn3JZ5vrWWQAn5RY9/MkhXXMYn7l09zFBIU/A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750896529; c=relaxed/simple;
	bh=8Csu5MQmwXr+/C/Ir74nXjgYBSDDAOvJPZ0U367Hu0E=;
	h=Date:From:To:Cc:Subject:Message-ID; b=MHEjTKCWI7k7I8u26rxrdD0100ZsC6UWFvtnBvowNhoqNcMNLayo1+Lbj5BjRa6BUWJDFDLbjWWSSU8Zd5cu2ZUYgTkNkJbXTi71gxJh9GClj7Eo20DLsicaohzh5HDR9bOxFQqIfa0lmnmxofUorz9il5pJAVXaLFJF2D6NQho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OSCt8WNh; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750896529; x=1782432529;
  h=date:from:to:cc:subject:message-id;
  bh=8Csu5MQmwXr+/C/Ir74nXjgYBSDDAOvJPZ0U367Hu0E=;
  b=OSCt8WNhf8Ii4eCdsLZkYe7HFG1dOpz9Qc6wzHqM3FNAVx+/mQuLBlO8
   gABIj2s+Q9nE4MJDFRXepPSjpDhCAKmX9aqYg2HVsg8n1Uzrn9n1tL/iw
   EQ2IUeA7h7iPK7DR7UTPRpq858j5vCnDQBzZHebRd5gqHUE7lbuT8b0Wu
   7jrIh38qWFfIrUJUpm18KtNp2TE2U2F2nglfDDhyv0KrTwkdjQJC1V6hn
   2QUQP+sP/mcPWiWBxH3eoJtW7mhgRgPiza8rYCcPkd7fBNcFIaN/xK0r/
   x/4U91fv+m26fBm9IwvlC7SBFANDU9BEtTyX5aFyNvq+jzufkimCHscWn
   A==;
X-CSE-ConnectionGUID: cs+szIbTTMiv2GQ0NuzLJQ==
X-CSE-MsgGUID: cZUsrW6ISd+NjeOQ21O8EQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="64617077"
X-IronPort-AV: E=Sophos;i="6.16,266,1744095600"; 
   d="scan'208";a="64617077"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 17:08:48 -0700
X-CSE-ConnectionGUID: WdKcCxxES1erISJUa/QA5w==
X-CSE-MsgGUID: VkPmMybuTt+KrWpcxXB+eA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,266,1744095600"; 
   d="scan'208";a="152887073"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 25 Jun 2025 17:08:46 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uUaAW-000TYo-0d;
	Thu, 26 Jun 2025 00:08:44 +0000
Date: Thu, 26 Jun 2025 08:08:19 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: [wireless:for-next] BUILD SUCCESS
 95b922dd04f74a45fb86b34a25cda62f427a2b5c
Message-ID: <202506260809.kvfiAwWT-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git for-next
branch HEAD: 95b922dd04f74a45fb86b34a25cda62f427a2b5c  Merge tag 'iwlwifi-fixes-2025-06-25' of https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next

elapsed time: 924m

configs tested: 106
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    clang-19
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                   randconfig-001-20250625    gcc-11.5.0
arc                   randconfig-001-20250626    clang-20
arc                   randconfig-002-20250625    gcc-12.4.0
arc                   randconfig-002-20250626    clang-20
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-21
arm                               allnoconfig    gcc-15.1.0
arm                              allyesconfig    clang-19
arm                   randconfig-001-20250625    clang-21
arm                   randconfig-001-20250626    clang-20
arm                   randconfig-002-20250625    gcc-11.5.0
arm                   randconfig-002-20250626    clang-20
arm                   randconfig-003-20250625    gcc-13.3.0
arm                   randconfig-003-20250626    clang-20
arm                   randconfig-004-20250625    gcc-15.1.0
arm                   randconfig-004-20250626    clang-20
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250625    gcc-11.5.0
arm64                 randconfig-001-20250626    clang-20
arm64                 randconfig-002-20250625    clang-20
arm64                 randconfig-002-20250626    clang-20
arm64                 randconfig-003-20250625    gcc-12.3.0
arm64                 randconfig-003-20250626    clang-20
arm64                 randconfig-004-20250625    clang-20
arm64                 randconfig-004-20250626    clang-20
csky                              allnoconfig    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                           allnoconfig    gcc-15.1.0
hexagon                          allyesconfig    clang-21
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20250625    clang-20
i386        buildonly-randconfig-002-20250625    gcc-12
i386        buildonly-randconfig-003-20250625    gcc-12
i386        buildonly-randconfig-004-20250625    gcc-12
i386        buildonly-randconfig-005-20250625    clang-20
i386        buildonly-randconfig-006-20250625    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-15.1.0
loongarch                         allnoconfig    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-15.1.0
openrisc                          allnoconfig    clang-21
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-21
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-21
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    gcc-15.1.0
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    gcc-15.1.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250625    gcc-12
x86_64      buildonly-randconfig-001-20250626    clang-20
x86_64      buildonly-randconfig-002-20250625    clang-20
x86_64      buildonly-randconfig-002-20250626    clang-20
x86_64      buildonly-randconfig-003-20250625    clang-20
x86_64      buildonly-randconfig-003-20250626    clang-20
x86_64      buildonly-randconfig-004-20250625    clang-20
x86_64      buildonly-randconfig-004-20250626    clang-20
x86_64      buildonly-randconfig-005-20250625    clang-20
x86_64      buildonly-randconfig-005-20250626    clang-20
x86_64      buildonly-randconfig-006-20250625    clang-20
x86_64      buildonly-randconfig-006-20250626    clang-20
x86_64                              defconfig    clang-20
x86_64                                  kexec    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

