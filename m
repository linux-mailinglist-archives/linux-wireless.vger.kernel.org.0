Return-Path: <linux-wireless+bounces-2279-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C7F8330D0
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jan 2024 23:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE7231F20F49
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jan 2024 22:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F1356475;
	Fri, 19 Jan 2024 22:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XvEGXHsc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF911E48B
	for <linux-wireless@vger.kernel.org>; Fri, 19 Jan 2024 22:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705704201; cv=none; b=srTesZwFvFoD2kCcXgazr9demIvqVxhlKXnj1mJELX7rN3vnG3WCjnXR+KUtact+aQFgG6Lhx2sKO8Jo+TM+bxY/+LWz4me10PcnvKIXtIhUF1DUU7ULZQo2S2pbOlSqOh6uAZPBuUE9jqcnwrUJodp1uU4/0UdLvbvVHAXPoNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705704201; c=relaxed/simple;
	bh=3MQIlYTLfWCCZEfbnbqC0083N8ztRtoAxrDplvsA0+8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=P7pnObtoDmrfDfM6feRwSFU1t6yPjacbwdD+2uz58cZxdRFeDHF4Wq+VM3u33H9TznnOid1djlK/IhVAv1lbNYqASASSp3LaTB1pgxDhkNomYgQ/yOwpRCh5tokeh/rreefOq9+QsrN/dgLQzsZXazsuMzQPBUCwACS5AgGi5XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XvEGXHsc; arc=none smtp.client-ip=134.134.136.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705704199; x=1737240199;
  h=date:from:to:cc:subject:message-id;
  bh=3MQIlYTLfWCCZEfbnbqC0083N8ztRtoAxrDplvsA0+8=;
  b=XvEGXHscgRbcO/PjLvswreNxFhejB1ocKsyiCmwygjPbFXeMYBo2sNhm
   4msSBbwvjQzejH67Pz210OakX4/BmbTqhRZKIyM0IFIpMXsXkHAF0JitH
   9Qhv5LtzQjU2HTrcfGNDBr/FbdG431BACBBSOkYZjv0WvdkYhczZGUrXk
   o48E08QgW0GtY1IB6qYJtqC31ZdMjO6HKWHSh+ApP1aYilRK2eEILZZ2H
   nTGBmwl5SIrB3pmATt3L6mP/fND3aRjjx39DE8awGy6nkkqIEtdpH6+y9
   HsmX5nUp/V2lmEMpEbncYxVWqlSxxjZhkS247znrgFpp+I9oCXwBW4FTY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="391298097"
X-IronPort-AV: E=Sophos;i="6.05,206,1701158400"; 
   d="scan'208";a="391298097"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 14:43:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,206,1701158400"; 
   d="scan'208";a="19503477"
Received: from lkp-server01.sh.intel.com (HELO 961aaaa5b03c) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 19 Jan 2024 14:43:16 -0800
Received: from kbuild by 961aaaa5b03c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rQxZy-0004To-2S;
	Fri, 19 Jan 2024 22:43:14 +0000
Date: Sat, 20 Jan 2024 06:42:28 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: [wireless:for-next] BUILD SUCCESS
 bcbc84af1183c8cf3d1ca9b78540c2185cd85e7f
Message-ID: <202401200625.Jun3FRzP-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git for-next
branch HEAD: bcbc84af1183c8cf3d1ca9b78540c2185cd85e7f  wifi: mac80211: fix race condition on enabling fast-xmit

elapsed time: 1895m

configs tested: 65
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
arc                   randconfig-001-20240120   gcc  
arc                   randconfig-002-20240120   gcc  
arm                   randconfig-001-20240120   clang
arm                   randconfig-002-20240120   clang
arm                   randconfig-003-20240120   clang
arm                   randconfig-004-20240120   clang
arm64                 randconfig-001-20240120   clang
arm64                 randconfig-002-20240120   clang
arm64                 randconfig-003-20240120   clang
arm64                 randconfig-004-20240120   clang
csky                  randconfig-001-20240120   gcc  
csky                  randconfig-002-20240120   gcc  
hexagon               randconfig-001-20240120   clang
hexagon               randconfig-002-20240120   clang
i386         buildonly-randconfig-001-20240119   gcc  
i386         buildonly-randconfig-002-20240119   gcc  
i386         buildonly-randconfig-003-20240119   gcc  
i386         buildonly-randconfig-004-20240119   gcc  
i386         buildonly-randconfig-005-20240119   gcc  
i386         buildonly-randconfig-006-20240119   gcc  
i386                  randconfig-001-20240119   gcc  
i386                  randconfig-002-20240119   gcc  
i386                  randconfig-003-20240119   gcc  
i386                  randconfig-004-20240119   gcc  
i386                  randconfig-005-20240119   gcc  
i386                  randconfig-006-20240119   gcc  
i386                  randconfig-011-20240119   clang
i386                  randconfig-012-20240119   clang
i386                  randconfig-013-20240119   clang
i386                  randconfig-014-20240119   clang
i386                  randconfig-015-20240119   clang
i386                  randconfig-016-20240119   clang
loongarch             randconfig-001-20240120   gcc  
loongarch             randconfig-002-20240120   gcc  
nios2                 randconfig-001-20240120   gcc  
nios2                 randconfig-002-20240120   gcc  
parisc                randconfig-001-20240120   gcc  
parisc                randconfig-002-20240120   gcc  
powerpc               randconfig-001-20240120   clang
powerpc               randconfig-002-20240120   clang
powerpc               randconfig-003-20240120   clang
x86_64       buildonly-randconfig-001-20240120   clang
x86_64       buildonly-randconfig-002-20240120   clang
x86_64       buildonly-randconfig-003-20240120   clang
x86_64       buildonly-randconfig-004-20240120   clang
x86_64       buildonly-randconfig-005-20240120   clang
x86_64       buildonly-randconfig-006-20240120   clang
x86_64                randconfig-001-20240120   gcc  
x86_64                randconfig-002-20240120   gcc  
x86_64                randconfig-003-20240120   gcc  
x86_64                randconfig-004-20240120   gcc  
x86_64                randconfig-005-20240120   gcc  
x86_64                randconfig-006-20240120   gcc  
x86_64                randconfig-011-20240120   clang
x86_64                randconfig-012-20240120   clang
x86_64                randconfig-013-20240120   clang
x86_64                randconfig-014-20240120   clang
x86_64                randconfig-015-20240120   clang
x86_64                randconfig-016-20240120   clang
x86_64                randconfig-071-20240120   clang
x86_64                randconfig-072-20240120   clang
x86_64                randconfig-073-20240120   clang
x86_64                randconfig-074-20240120   clang
x86_64                randconfig-075-20240120   clang
x86_64                randconfig-076-20240120   clang

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

