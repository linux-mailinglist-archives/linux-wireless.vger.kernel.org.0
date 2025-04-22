Return-Path: <linux-wireless+bounces-21839-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D0BA96906
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Apr 2025 14:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DAE01886B56
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Apr 2025 12:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F0D27CB21;
	Tue, 22 Apr 2025 12:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ck4Bh+cf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB0A202960;
	Tue, 22 Apr 2025 12:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745324550; cv=none; b=dkkZRkqhwFo0fIPEvM0vJfp+PzO7UnXh0tfC8Xw2wnj2DHXDpPv25cKiNJoWsqItoopq9iUqpTmQ5QGiC/hqAXu3lfurFynjNvmLNQt73n8Hwif4zS9Tw7l2NvzhuCvTZLPXMLjga/bCxakmEHXNub0YJsNFdnkWoRAaEpaK17E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745324550; c=relaxed/simple;
	bh=70Z7M8gAwv96dWVPcFakq4o174ktL1rBuZUJ3c9nwxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eLuvJ4kpsG6IGHou8vODruWhONvXfyNo3D/HuyVhYICn6SeO2mTz+gcdRYKQGvWWUPzzzxlFqehPcdviz964SSPhdi2/9roFWeVtz1CASkHvTwB28y4kqeoB1y9sHyWJEHpDjIiWU+KZGxEMjIJ63guMe09AwJCo5a+8nlM0VQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ck4Bh+cf; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745324548; x=1776860548;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=70Z7M8gAwv96dWVPcFakq4o174ktL1rBuZUJ3c9nwxA=;
  b=Ck4Bh+cf37g6G+Hw93o4S2ZbVKHO+NBSFCh/uhlX/uDMmlsTvV8Luv1z
   eBxPFL93NHUjA1I2HQg5vhfWgM1t0LrESIfQ6lmRavh2fJbwVnSeCD+eQ
   wspC6ZzxuSidyfEHVuiVUSOQt26xrHD8IPXrhvLHPt409oQ+aGPg9vtWR
   uZaT/8u2h2a/f+byMvAcYf0mEFCoou+svy7VQYNXgKBxVdSVb/BbhBF6j
   eMivzxgFoXjnbDIUCISETNG1QW8PqKIgj6BU49BD4R3TEANxoHr5Ziio2
   9kPOxudfXPYKQsGYknNy9W3jfsSLBT3RhUXTjNeO0lkHsh8kEFCCyVa/Y
   A==;
X-CSE-ConnectionGUID: x6m3GbFpRjuseujOa6cISA==
X-CSE-MsgGUID: CQeDelzfQLi4ua1mlU6SPA==
X-IronPort-AV: E=McAfee;i="6700,10204,11410"; a="58247426"
X-IronPort-AV: E=Sophos;i="6.15,231,1739865600"; 
   d="scan'208";a="58247426"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 05:22:28 -0700
X-CSE-ConnectionGUID: k3jKTv9tSDe00YUNTeRVQg==
X-CSE-MsgGUID: ubwMRoJITN6a4c+A1vZu2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,231,1739865600"; 
   d="scan'208";a="132948364"
Received: from lkp-server01.sh.intel.com (HELO 050dd05385d1) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 22 Apr 2025 05:22:26 -0700
Received: from kbuild by 050dd05385d1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u7Cdq-0000xH-3C;
	Tue, 22 Apr 2025 12:22:23 +0000
Date: Tue, 22 Apr 2025 20:22:18 +0800
From: kernel test robot <lkp@intel.com>
To: Wentao Liang <vulab@iscas.ac.cn>, miriam.rachel.korenblit@intel.com,
	kvalo@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, johannes.berg@intel.com,
	emmanuel.grumbach@intel.com, golan.ben.ami@intel.com,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>
Subject: Re: [PATCH v2 RESEND] wifi: iwlwifi: mvm: Add error logging for
 iwl_finish_nic_init()
Message-ID: <202504222012.DGGkXYWx-lkp@intel.com>
References: <20250422023234.1992-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422023234.1992-1-vulab@iscas.ac.cn>

Hi Wentao,

kernel test robot noticed the following build errors:

[auto build test ERROR on wireless-next/main]
[also build test ERROR on wireless/main linus/master v6.15-rc3 next-20250417]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Wentao-Liang/wifi-iwlwifi-mvm-Add-error-logging-for-iwl_finish_nic_init/20250422-104110
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/20250422023234.1992-1-vulab%40iscas.ac.cn
patch subject: [PATCH v2 RESEND] wifi: iwlwifi: mvm: Add error logging for iwl_finish_nic_init()
config: arm-randconfig-001-20250422 (https://download.01.org/0day-ci/archive/20250422/202504222012.DGGkXYWx-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250422/202504222012.DGGkXYWx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504222012.DGGkXYWx-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <command-line>:
   drivers/net/wireless/intel/iwlwifi/pcie/drv.c: In function '_iwl_pci_resume':
>> include/linux/compiler_types.h:557:38: error: call to '__compiletime_assert_671' declared with attribute error: BUILD_BUG_ON failed: "NIC initialization failed after power-off (error %d)."[sizeof("NIC initialization failed after power-off (error %d).") - 2] != '\n'
     _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
                                         ^
   include/linux/compiler_types.h:538:4: note: in definition of macro '__compiletime_assert'
       prefix ## suffix();    \
       ^~~~~~
   include/linux/compiler_types.h:557:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
     ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                        ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
     ^~~~~~~~~~~~~~~~
   drivers/net/wireless/intel/iwlwifi/iwl-debug.h:40:30: note: in expansion of macro 'BUILD_BUG_ON'
    #define CHECK_FOR_NEWLINE(f) BUILD_BUG_ON(f[sizeof(f) - 2] != '\n')
                                 ^~~~~~~~~~~~
   drivers/net/wireless/intel/iwlwifi/iwl-debug.h:45:3: note: in expansion of macro 'CHECK_FOR_NEWLINE'
      CHECK_FOR_NEWLINE(f);     \
      ^~~~~~~~~~~~~~~~~
   drivers/net/wireless/intel/iwlwifi/iwl-debug.h:49:2: note: in expansion of macro '__IWL_ERR_DEV'
     __IWL_ERR_DEV(d, IWL_ERR_MODE_REGULAR, f, ## a)
     ^~~~~~~~~~~~~
   drivers/net/wireless/intel/iwlwifi/iwl-debug.h:51:2: note: in expansion of macro 'IWL_ERR_DEV'
     IWL_ERR_DEV((m)->dev, f, ## a)
     ^~~~~~~~~~~
   drivers/net/wireless/intel/iwlwifi/pcie/drv.c:1777:4: note: in expansion of macro 'IWL_ERR'
       IWL_ERR(trans,
       ^~~~~~~
--
   In file included from <command-line>:
   pcie/drv.c: In function '_iwl_pci_resume':
>> include/linux/compiler_types.h:557:38: error: call to '__compiletime_assert_671' declared with attribute error: BUILD_BUG_ON failed: "NIC initialization failed after power-off (error %d)."[sizeof("NIC initialization failed after power-off (error %d).") - 2] != '\n'
     _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
                                         ^
   include/linux/compiler_types.h:538:4: note: in definition of macro '__compiletime_assert'
       prefix ## suffix();    \
       ^~~~~~
   include/linux/compiler_types.h:557:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
     ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                        ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
     ^~~~~~~~~~~~~~~~
   ././iwl-debug.h:40:30: note: in expansion of macro 'BUILD_BUG_ON'
    #define CHECK_FOR_NEWLINE(f) BUILD_BUG_ON(f[sizeof(f) - 2] != '\n')
                                 ^~~~~~~~~~~~
   ././iwl-debug.h:45:3: note: in expansion of macro 'CHECK_FOR_NEWLINE'
      CHECK_FOR_NEWLINE(f);     \
      ^~~~~~~~~~~~~~~~~
   ././iwl-debug.h:49:2: note: in expansion of macro '__IWL_ERR_DEV'
     __IWL_ERR_DEV(d, IWL_ERR_MODE_REGULAR, f, ## a)
     ^~~~~~~~~~~~~
   ././iwl-debug.h:51:2: note: in expansion of macro 'IWL_ERR_DEV'
     IWL_ERR_DEV((m)->dev, f, ## a)
     ^~~~~~~~~~~
   pcie/drv.c:1777:4: note: in expansion of macro 'IWL_ERR'
       IWL_ERR(trans,
       ^~~~~~~


vim +557 include/linux/compiler_types.h

eb5c2d4b45e3d2d Will Deacon 2020-07-21  543  
eb5c2d4b45e3d2d Will Deacon 2020-07-21  544  #define _compiletime_assert(condition, msg, prefix, suffix) \
eb5c2d4b45e3d2d Will Deacon 2020-07-21  545  	__compiletime_assert(condition, msg, prefix, suffix)
eb5c2d4b45e3d2d Will Deacon 2020-07-21  546  
eb5c2d4b45e3d2d Will Deacon 2020-07-21  547  /**
eb5c2d4b45e3d2d Will Deacon 2020-07-21  548   * compiletime_assert - break build and emit msg if condition is false
eb5c2d4b45e3d2d Will Deacon 2020-07-21  549   * @condition: a compile-time constant condition to check
eb5c2d4b45e3d2d Will Deacon 2020-07-21  550   * @msg:       a message to emit if condition is false
eb5c2d4b45e3d2d Will Deacon 2020-07-21  551   *
eb5c2d4b45e3d2d Will Deacon 2020-07-21  552   * In tradition of POSIX assert, this macro will break the build if the
eb5c2d4b45e3d2d Will Deacon 2020-07-21  553   * supplied condition is *false*, emitting the supplied error message if the
eb5c2d4b45e3d2d Will Deacon 2020-07-21  554   * compiler has support to do so.
eb5c2d4b45e3d2d Will Deacon 2020-07-21  555   */
eb5c2d4b45e3d2d Will Deacon 2020-07-21  556  #define compiletime_assert(condition, msg) \
eb5c2d4b45e3d2d Will Deacon 2020-07-21 @557  	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
eb5c2d4b45e3d2d Will Deacon 2020-07-21  558  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

