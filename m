Return-Path: <linux-wireless+bounces-48-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BDE7F720E
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Nov 2023 11:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A9681C20993
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Nov 2023 10:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E851A928;
	Fri, 24 Nov 2023 10:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R6m4B8//"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1766E92
	for <linux-wireless@vger.kernel.org>; Fri, 24 Nov 2023 02:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700823050; x=1732359050;
  h=date:from:to:cc:subject:message-id;
  bh=qjxqwVX7ZMEKQzsE3jOTV9ZKSSUc9mUZ66wEsjL/pF0=;
  b=R6m4B8///hoXybWamCHh6nqxDPerTmWA00rPTm9mKYzCEdbEOFajUuxz
   +6d1i32Iz5BriTnQHotUNhae/gZ/gZoCHOlOeojZbbiRSae5q8PoIxeNb
   COeZ6NVd7anUPApttqfHbsqaNyn/uSzX5Wq0HZ3Nt/4GcXn6pT5eCZDUy
   G07LqpxBKnkBDQABg9cRjkSXBGuJjMvDai3RNur5TsQXe5dOeqYH0FxCh
   Ncg0Via5hTzepzqtdPJifLqQ+Qj9CrbN24nDi/5UC6j4zU+LaS+L6bOgY
   6CHeDaVETt5+OqJxiaU6qAxkSHp9aeeuErNIn4Sy8k8svey/OibLFvfD4
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="389557246"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="389557246"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 02:50:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="891031422"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="891031422"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 24 Nov 2023 02:50:48 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r6Tlk-0002TH-2p;
	Fri, 24 Nov 2023 10:50:44 +0000
Date: Fri, 24 Nov 2023 18:49:56 +0800
From: kernel test robot <lkp@intel.com>
To: Kalle Valo <kvalo@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 52471877a2e7211603f57c74102e8ba2aa06fe48
Message-ID: <202311241853.IOeBaN48-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 52471877a2e7211603f57c74102e8ba2aa06fe48  wifi: rtw89: 8922a: read efuse content from physical map

Warning ids grouped by kconfigs:

clang_recent_errors
|-- arm-randconfig-001-20231124
|   |-- drivers-net-ethernet-3com-typhoon.h:warning:field-within-struct-tx_desc-is-less-aligned-than-union-tx_desc::(anonymous-at-drivers-net-ethernet-3com-typhoon.h)-and-is-usually-due-to-struct-tx_desc-bein
|   |-- drivers-net-ethernet-aquantia-atlantic-aq_ring.h:warning:field-within-struct-aq_ring_buff_s-is-less-aligned-than-union-aq_ring_buff_s::(anonymous-at-drivers-net-ethernet-aquantia-atlantic-aq_ring.h)-a
|   |-- include-uapi-linux-if_pppox.h:warning:field-pppol2tp-within-struct-sockaddr_pppol2tp-is-less-aligned-than-struct-pppol2tp_addr-and-is-usually-due-to-struct-sockaddr_pppol2tp-being-packed-which-can-lea
|   |-- include-uapi-linux-if_pppox.h:warning:field-pppol2tp-within-struct-sockaddr_pppol2tpin6-is-less-aligned-than-struct-pppol2tpin6_addr-and-is-usually-due-to-struct-sockaddr_pppol2tpin6-being-packed-whic
|   |-- include-uapi-linux-if_pppox.h:warning:field-pppol2tp-within-struct-sockaddr_pppol2tpv3-is-less-aligned-than-struct-pppol2tpv3_addr-and-is-usually-due-to-struct-sockaddr_pppol2tpv3-being-packed-which-c
|   `-- include-uapi-linux-if_pppox.h:warning:field-pppol2tp-within-struct-sockaddr_pppol2tpv3in6-is-less-aligned-than-struct-pppol2tpv3in6_addr-and-is-usually-due-to-struct-sockaddr_pppol2tpv3in6-being-packe
|-- powerpc-randconfig-003-20231124
|   |-- arch-powerpc-platforms-amigaone-setup.c:warning:no-previous-prototype-for-function-amigaone_init_IRQ
|   |-- arch-powerpc-platforms-amigaone-setup.c:warning:no-previous-prototype-for-function-amigaone_restart
|   |-- arch-powerpc-platforms-amigaone-setup.c:warning:no-previous-prototype-for-function-amigaone_setup_arch
|   `-- arch-powerpc-platforms-amigaone-setup.c:warning:no-previous-prototype-for-function-amigaone_show_cpuinfo
`-- powerpc64-randconfig-002-20231124
    `-- drivers-net-wireless-intel-iwlegacy-rs.c:warning:unused-variable-il_rate_mcs

elapsed time: 2521m

configs tested: 113
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
arc                   randconfig-001-20231124   gcc  
arc                   randconfig-002-20231124   gcc  
arm                   randconfig-001-20231124   clang
arm                   randconfig-002-20231124   clang
arm                   randconfig-003-20231124   clang
arm                   randconfig-004-20231124   clang
arm64                 randconfig-001-20231124   clang
arm64                 randconfig-002-20231124   clang
arm64                 randconfig-003-20231124   clang
arm64                 randconfig-004-20231124   clang
csky                  randconfig-001-20231124   gcc  
csky                  randconfig-002-20231124   gcc  
hexagon               randconfig-001-20231124   clang
hexagon               randconfig-002-20231124   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20231123   gcc  
i386         buildonly-randconfig-002-20231123   gcc  
i386         buildonly-randconfig-003-20231123   gcc  
i386         buildonly-randconfig-004-20231123   gcc  
i386         buildonly-randconfig-005-20231123   gcc  
i386         buildonly-randconfig-006-20231123   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231123   gcc  
i386                  randconfig-002-20231123   gcc  
i386                  randconfig-003-20231123   gcc  
i386                  randconfig-004-20231123   gcc  
i386                  randconfig-005-20231123   gcc  
i386                  randconfig-006-20231123   gcc  
i386                  randconfig-011-20231123   clang
i386                  randconfig-012-20231123   clang
i386                  randconfig-013-20231123   clang
i386                  randconfig-014-20231123   clang
i386                  randconfig-015-20231123   clang
i386                  randconfig-016-20231123   clang
loongarch                        allmodconfig   gcc  
loongarch             randconfig-001-20231124   gcc  
loongarch             randconfig-002-20231124   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                       allyesconfig   gcc  
mips                             allyesconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                 randconfig-001-20231124   gcc  
nios2                 randconfig-002-20231124   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20231124   gcc  
parisc                randconfig-002-20231124   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc               randconfig-001-20231124   clang
powerpc               randconfig-002-20231124   clang
powerpc               randconfig-003-20231124   clang
powerpc64             randconfig-001-20231124   clang
powerpc64             randconfig-002-20231124   clang
powerpc64             randconfig-003-20231124   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231124   clang
riscv                 randconfig-002-20231124   clang
riscv                          rv32_defconfig   clang
s390                  randconfig-001-20231124   gcc  
s390                  randconfig-002-20231124   gcc  
sh                    randconfig-001-20231124   gcc  
sh                    randconfig-002-20231124   gcc  
sparc64               randconfig-001-20231124   gcc  
sparc64               randconfig-002-20231124   gcc  
um                    randconfig-001-20231124   clang
um                    randconfig-002-20231124   clang
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20231123   gcc  
x86_64       buildonly-randconfig-002-20231123   gcc  
x86_64       buildonly-randconfig-003-20231123   gcc  
x86_64       buildonly-randconfig-004-20231123   gcc  
x86_64       buildonly-randconfig-005-20231123   gcc  
x86_64       buildonly-randconfig-006-20231123   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20231123   clang
x86_64                randconfig-002-20231123   clang
x86_64                randconfig-003-20231123   clang
x86_64                randconfig-004-20231123   clang
x86_64                randconfig-005-20231123   clang
x86_64                randconfig-006-20231123   clang
x86_64                randconfig-011-20231123   gcc  
x86_64                randconfig-012-20231123   gcc  
x86_64                randconfig-013-20231123   gcc  
x86_64                randconfig-014-20231123   gcc  
x86_64                randconfig-015-20231123   gcc  
x86_64                randconfig-016-20231123   gcc  
x86_64                randconfig-071-20231123   gcc  
x86_64                randconfig-072-20231123   gcc  
x86_64                randconfig-073-20231123   gcc  
x86_64                randconfig-074-20231123   gcc  
x86_64                randconfig-075-20231123   gcc  
x86_64                randconfig-076-20231123   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                randconfig-001-20231124   gcc  
xtensa                randconfig-002-20231124   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

