Return-Path: <linux-wireless+bounces-16693-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C45419F9F57
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Dec 2024 09:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF812188C243
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Dec 2024 08:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619231DC997;
	Sat, 21 Dec 2024 08:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GBC0ZpIg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACDC25949C
	for <linux-wireless@vger.kernel.org>; Sat, 21 Dec 2024 08:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734770057; cv=none; b=gk6PcHsSpC++Y3Psn7ieTWYb126Q+igWhS8+9JfIghfCIMQqxZEI3/pIOYMcQF9jvsoKFoOB8ZJNWkK5FwIZOXQpoQNyEDSUJSdCWuEcJfsokqSLZiKnIBtJDyXPzk+RzPt3/GLxU75BA76Ib2896V6bJ4Wn+4Hc9yx9JtBEHsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734770057; c=relaxed/simple;
	bh=P/1LiBHOVuK5DKEVUM1xblym7ltGBK8q8eCLk0uq9CA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ghJY+mfjOMLz50AH42g72SdhZLNs6YjyshOS6T9g9KbJ7GUt8s2yGJ5wWE6ZRXikBXP7ieE+/E+b1vONQfHvyc0WpNQlmgihno4uwH++z1AS4UJoQeV8fhq4ES5d0wNZq4cf+Teu3iU+IYGtsPZdtzMfUkmPdVXUwOqwkQBQ9ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GBC0ZpIg; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734770055; x=1766306055;
  h=date:from:to:cc:subject:message-id;
  bh=P/1LiBHOVuK5DKEVUM1xblym7ltGBK8q8eCLk0uq9CA=;
  b=GBC0ZpIgMxIc0fnZKuJe/3GAfExrxNUfgGgTI6ElcheGixEyJDqSVG5C
   aG46gLXkRPKGgC/TFxZGtzL88bzRbeGoZB+iaiP7pceIvQ18v7kgZVjnh
   gO2O0lqJrcxHkMqOcqDuyOuZEc07En7kObv5FvIh8KYNSjMjLfGgA4QpN
   Bzi4OlZmT+Kf1qKJ64irwWqdMaiOpMjDu6GcB1XI5YraRBTt/C75PBBd7
   p/1R1rwePFaRGk7gsdPZkGR0MQYMi8CP5i2Q4w8S/KyR03lAfqxUlGe7o
   qZk9JOynaF6+LbdP8LY4x6EcN8Dy6HnIqZMipwhVm23WavmxLQoslEe9P
   w==;
X-CSE-ConnectionGUID: UGZqPwxuQGSOXjXmkWXuwA==
X-CSE-MsgGUID: a3LD3IvBRzOOBNyOJRWVZw==
X-IronPort-AV: E=McAfee;i="6700,10204,11292"; a="35205975"
X-IronPort-AV: E=Sophos;i="6.12,253,1728975600"; 
   d="scan'208";a="35205975"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2024 00:34:15 -0800
X-CSE-ConnectionGUID: /m+vw/hGR7SZJfX+s3wVLg==
X-CSE-MsgGUID: qAU67wjiQoeSV22ANKGDTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="136072928"
Received: from lkp-server01.sh.intel.com (HELO a46f226878e0) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 21 Dec 2024 00:34:13 -0800
Received: from kbuild by a46f226878e0 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tOuw7-00025K-0Z;
	Sat, 21 Dec 2024 08:34:11 +0000
Date: Sat, 21 Dec 2024 16:34:04 +0800
From: kernel test robot <lkp@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 b73e56f16250c6124f8975636f1844472f6fd450
Message-ID: <202412211658.3ApEKolC-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: b73e56f16250c6124f8975636f1844472f6fd450  Merge branch 'xdp-a-fistful-of-generic-changes-pt-iii'

elapsed time: 1656m

configs tested: 196
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20241220    gcc-13.2.0
arc                   randconfig-001-20241221    gcc-13.2.0
arc                   randconfig-002-20241220    gcc-13.2.0
arc                   randconfig-002-20241221    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                           omap1_defconfig    gcc-14.2.0
arm                         orion5x_defconfig    clang-20
arm                   randconfig-001-20241220    clang-19
arm                   randconfig-001-20241221    gcc-14.2.0
arm                   randconfig-002-20241220    gcc-14.2.0
arm                   randconfig-002-20241221    gcc-14.2.0
arm                   randconfig-003-20241220    gcc-14.2.0
arm                   randconfig-003-20241221    gcc-14.2.0
arm                   randconfig-004-20241220    clang-20
arm                   randconfig-004-20241221    clang-18
arm                        realview_defconfig    clang-19
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20241220    clang-17
arm64                 randconfig-001-20241221    clang-18
arm64                 randconfig-002-20241220    clang-19
arm64                 randconfig-002-20241221    clang-16
arm64                 randconfig-003-20241220    clang-20
arm64                 randconfig-003-20241221    clang-20
arm64                 randconfig-004-20241220    clang-19
arm64                 randconfig-004-20241221    gcc-14.2.0
csky                             alldefconfig    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20241220    gcc-14.2.0
csky                  randconfig-001-20241221    gcc-14.2.0
csky                  randconfig-002-20241220    gcc-14.2.0
csky                  randconfig-002-20241221    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20241220    clang-20
hexagon               randconfig-001-20241221    clang-17
hexagon               randconfig-002-20241220    clang-20
hexagon               randconfig-002-20241221    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241220    gcc-12
i386        buildonly-randconfig-001-20241221    gcc-12
i386        buildonly-randconfig-002-20241220    gcc-12
i386        buildonly-randconfig-002-20241221    gcc-12
i386        buildonly-randconfig-003-20241220    gcc-12
i386        buildonly-randconfig-003-20241221    clang-19
i386        buildonly-randconfig-004-20241220    clang-19
i386        buildonly-randconfig-004-20241221    clang-19
i386        buildonly-randconfig-005-20241220    gcc-12
i386        buildonly-randconfig-005-20241221    clang-19
i386        buildonly-randconfig-006-20241220    gcc-12
i386        buildonly-randconfig-006-20241221    clang-19
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20241220    gcc-14.2.0
loongarch             randconfig-001-20241221    gcc-14.2.0
loongarch             randconfig-002-20241220    gcc-14.2.0
loongarch             randconfig-002-20241221    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                       bvme6000_defconfig    gcc-14.2.0
m68k                       m5475evb_defconfig    gcc-14.2.0
m68k                        stmark2_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                           jazz_defconfig    clang-20
mips                           mtx1_defconfig    clang-20
mips                        vocore2_defconfig    clang-15
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20241220    gcc-14.2.0
nios2                 randconfig-001-20241221    gcc-14.2.0
nios2                 randconfig-002-20241220    gcc-14.2.0
nios2                 randconfig-002-20241221    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20241220    gcc-14.2.0
parisc                randconfig-001-20241221    gcc-14.2.0
parisc                randconfig-002-20241220    gcc-14.2.0
parisc                randconfig-002-20241221    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                      ep88xc_defconfig    gcc-14.2.0
powerpc                      katmai_defconfig    clang-18
powerpc                     kmeter1_defconfig    gcc-14.2.0
powerpc                   lite5200b_defconfig    clang-20
powerpc                 mpc8315_rdb_defconfig    clang-20
powerpc                     mpc83xx_defconfig    clang-20
powerpc                     ppa8548_defconfig    gcc-14.2.0
powerpc                      ppc44x_defconfig    clang-20
powerpc               randconfig-001-20241220    clang-15
powerpc               randconfig-001-20241221    gcc-14.2.0
powerpc               randconfig-002-20241220    gcc-14.2.0
powerpc               randconfig-002-20241221    gcc-14.2.0
powerpc               randconfig-003-20241220    gcc-14.2.0
powerpc               randconfig-003-20241221    gcc-14.2.0
powerpc                     tqm8548_defconfig    clang-19
powerpc64             randconfig-001-20241220    gcc-14.2.0
powerpc64             randconfig-001-20241221    gcc-14.2.0
powerpc64             randconfig-002-20241220    clang-19
powerpc64             randconfig-002-20241221    gcc-14.2.0
powerpc64             randconfig-003-20241220    gcc-14.2.0
powerpc64             randconfig-003-20241221    clang-18
riscv                            allmodconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                               defconfig    clang-19
riscv                 randconfig-001-20241220    gcc-14.2.0
riscv                 randconfig-001-20241221    gcc-14.2.0
riscv                 randconfig-002-20241220    clang-19
riscv                 randconfig-002-20241221    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                  randconfig-001-20241220    gcc-14.2.0
s390                  randconfig-001-20241221    gcc-14.2.0
s390                  randconfig-002-20241220    gcc-14.2.0
s390                  randconfig-002-20241221    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                         apsh4a3a_defconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                        dreamcast_defconfig    gcc-14.2.0
sh                          kfr2r09_defconfig    gcc-14.2.0
sh                            migor_defconfig    gcc-14.2.0
sh                    randconfig-001-20241220    gcc-14.2.0
sh                    randconfig-001-20241221    gcc-14.2.0
sh                    randconfig-002-20241220    gcc-14.2.0
sh                    randconfig-002-20241221    gcc-14.2.0
sh                          rsk7201_defconfig    gcc-14.2.0
sh                             sh03_defconfig    gcc-14.2.0
sh                           sh2007_defconfig    gcc-14.2.0
sh                   sh7724_generic_defconfig    gcc-14.2.0
sh                        sh7763rdp_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20241220    gcc-14.2.0
sparc                 randconfig-001-20241221    gcc-14.2.0
sparc                 randconfig-002-20241220    gcc-14.2.0
sparc                 randconfig-002-20241221    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20241220    gcc-14.2.0
sparc64               randconfig-001-20241221    gcc-14.2.0
sparc64               randconfig-002-20241220    gcc-14.2.0
sparc64               randconfig-002-20241221    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                                  defconfig    clang-20
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241220    clang-20
um                    randconfig-001-20241221    clang-18
um                    randconfig-002-20241220    clang-20
um                    randconfig-002-20241221    gcc-12
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241220    gcc-12
x86_64      buildonly-randconfig-001-20241221    gcc-12
x86_64      buildonly-randconfig-002-20241220    clang-19
x86_64      buildonly-randconfig-002-20241221    gcc-12
x86_64      buildonly-randconfig-003-20241220    gcc-12
x86_64      buildonly-randconfig-003-20241221    gcc-12
x86_64      buildonly-randconfig-004-20241220    gcc-12
x86_64      buildonly-randconfig-004-20241221    gcc-12
x86_64      buildonly-randconfig-005-20241220    clang-19
x86_64      buildonly-randconfig-005-20241221    gcc-11
x86_64      buildonly-randconfig-006-20241220    gcc-12
x86_64      buildonly-randconfig-006-20241221    gcc-12
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20241220    gcc-14.2.0
xtensa                randconfig-001-20241221    gcc-14.2.0
xtensa                randconfig-002-20241220    gcc-14.2.0
xtensa                randconfig-002-20241221    gcc-14.2.0
xtensa                    xip_kc705_defconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

