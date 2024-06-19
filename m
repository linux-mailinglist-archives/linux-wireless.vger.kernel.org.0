Return-Path: <linux-wireless+bounces-9243-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D77A990ED5C
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Jun 2024 15:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B2CA281322
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Jun 2024 13:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107B413F435;
	Wed, 19 Jun 2024 13:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HxcrqM0m"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C0814375A
	for <linux-wireless@vger.kernel.org>; Wed, 19 Jun 2024 13:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718803031; cv=none; b=SGhs5qnPkHWIYBv85Hq1pPcSsAK6Aq5+lluBNvS3zMNOFhCrCo7mN9imYUr56Fxy34k/gixKeQTJ89FzPeya5NyVh98+EVYAY+nZWPmjVWgKOc98/+T4QhB1UNLDYZc2964JSdiyXB7j0m9do2pUVVwdCR/OiwYd2GephweNiZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718803031; c=relaxed/simple;
	bh=/Aq+rEEMRWIUXG5fyG/dppdpGwcK+saK65VLMF09w+o=;
	h=Date:From:To:Cc:Subject:Message-ID; b=chvro9iYDyOpr+7i6a5Wmkj2evPgtVqTq0ZhsuDOMYD8HYbu4Jp1FaCr1mXqUWpVfllIzJ/Txa4DPVN9oZXdCq00i+UoSBdXUHI91u/Z01/8z8pFBy1QjRIS1n4vdXGSo73nNabU4Wo+YHj2mA8KIVPVwnkC9YjkWakT3v5WzRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HxcrqM0m; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718803029; x=1750339029;
  h=date:from:to:cc:subject:message-id;
  bh=/Aq+rEEMRWIUXG5fyG/dppdpGwcK+saK65VLMF09w+o=;
  b=HxcrqM0mG+YqHbH9f6IMM4sD0jIRUw71cDZSn/zDMBJ2q2DGPLpUMZ7x
   gyKxWttZGsCa5VB9XrBMPUcZm2WYfEXH8q8Zy6MRjp7aAvsTo16eVpWl/
   l9BLtjXNwmf/DhDn3v/g1kDVbQy9J/wg+WD5yh4TwpqBwRx/Z4v0sdZjs
   xcoQz2h/OPC4RNtzxTbEc9mXxnkf/a7otSM82E6X/KGFGef1jkjvGdtJA
   xZmriBB523olTzpjjV3nyOpVPsDO6EQTSU5nLfEtz/Pra7Yhg5Uwuzfsr
   5hd0ot588Bh9YCcTR0UYNlVLAHw4TwJZzNassegMBxxPE1TAg176VRjZ4
   Q==;
X-CSE-ConnectionGUID: CvvTnB4IT+CBZxAfpKWfzw==
X-CSE-MsgGUID: JZRGdVztTZmUYrNyROMmbA==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="15453088"
X-IronPort-AV: E=Sophos;i="6.08,250,1712646000"; 
   d="scan'208";a="15453088"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 06:17:07 -0700
X-CSE-ConnectionGUID: CO3dqc1JQrGyFKfNtzFxvA==
X-CSE-MsgGUID: 6Wy5lxdzTg+aN47sy+43bQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,250,1712646000"; 
   d="scan'208";a="46368268"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 19 Jun 2024 06:17:05 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sJvBO-0006c6-0z;
	Wed, 19 Jun 2024 13:17:02 +0000
Date: Wed, 19 Jun 2024 21:16:02 +0800
From: kernel test robot <lkp@intel.com>
To: Kalle Valo <kvalo@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 5ad8897fd15a3716601509ed4a7bc47bf0cab661
Message-ID: <202406192158.DU3kCSyd-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 5ad8897fd15a3716601509ed4a7bc47bf0cab661  wifi: wilc1000: disable SDIO func IRQ before suspend

elapsed time: 1533m

configs tested: 59
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
arc                   randconfig-001-20240619   gcc-13.2.0
arc                   randconfig-002-20240619   gcc-13.2.0
arm                   randconfig-001-20240619   clang-19
arm                   randconfig-002-20240619   clang-19
arm                   randconfig-003-20240619   clang-19
arm                   randconfig-004-20240619   gcc-13.2.0
arm64                 randconfig-001-20240619   clang-19
arm64                 randconfig-002-20240619   clang-19
arm64                 randconfig-003-20240619   clang-19
arm64                 randconfig-004-20240619   clang-19
csky                  randconfig-001-20240619   gcc-13.2.0
csky                  randconfig-002-20240619   gcc-13.2.0
hexagon               randconfig-001-20240619   clang-15
hexagon               randconfig-002-20240619   clang-19
i386         buildonly-randconfig-001-20240619   clang-18
i386         buildonly-randconfig-002-20240619   clang-18
i386         buildonly-randconfig-003-20240619   clang-18
i386         buildonly-randconfig-004-20240619   clang-18
i386         buildonly-randconfig-005-20240619   gcc-7
i386         buildonly-randconfig-006-20240619   gcc-7
i386                  randconfig-001-20240619   gcc-7
i386                  randconfig-002-20240619   gcc-7
i386                  randconfig-003-20240619   clang-18
i386                  randconfig-004-20240619   gcc-7
i386                  randconfig-005-20240619   clang-18
i386                  randconfig-006-20240619   gcc-9
i386                  randconfig-011-20240619   clang-18
i386                  randconfig-012-20240619   clang-18
i386                  randconfig-013-20240619   gcc-13
i386                  randconfig-014-20240619   clang-18
i386                  randconfig-015-20240619   clang-18
i386                  randconfig-016-20240619   gcc-13
loongarch             randconfig-001-20240619   gcc-13.2.0
loongarch             randconfig-002-20240619   gcc-13.2.0
nios2                 randconfig-001-20240619   gcc-13.2.0
x86_64       buildonly-randconfig-001-20240619   clang-18
x86_64       buildonly-randconfig-002-20240619   clang-18
x86_64       buildonly-randconfig-003-20240619   gcc-11
x86_64       buildonly-randconfig-004-20240619   clang-18
x86_64       buildonly-randconfig-005-20240619   clang-18
x86_64       buildonly-randconfig-006-20240619   gcc-13
x86_64                randconfig-001-20240619   gcc-13
x86_64                randconfig-002-20240619   clang-18
x86_64                randconfig-003-20240619   gcc-8
x86_64                randconfig-004-20240619   clang-18
x86_64                randconfig-005-20240619   clang-18
x86_64                randconfig-006-20240619   gcc-13
x86_64                randconfig-011-20240619   gcc-13
x86_64                randconfig-012-20240619   gcc-13
x86_64                randconfig-013-20240619   gcc-13
x86_64                randconfig-014-20240619   clang-18
x86_64                randconfig-015-20240619   clang-18
x86_64                randconfig-016-20240619   gcc-11
x86_64                randconfig-071-20240619   clang-18
x86_64                randconfig-072-20240619   clang-18
x86_64                randconfig-073-20240619   gcc-9
x86_64                randconfig-074-20240619   gcc-9
x86_64                randconfig-075-20240619   clang-18
x86_64                randconfig-076-20240619   clang-18

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

