Return-Path: <linux-wireless+bounces-11263-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8406C94DE7E
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Aug 2024 22:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8AC51C21570
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Aug 2024 20:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B68813D512;
	Sat, 10 Aug 2024 20:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MWK/a331"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E460433DD;
	Sat, 10 Aug 2024 20:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723320358; cv=none; b=P1Tos2PkWaObpmpfTf+GFj22+uCyC+CKNI2TwwrR3+EzAOVFZ+S+qUyiOWjm/mejcYY9ILAFWSAuLDOOjrQ1x314fRYmyND8QBsWle5okDYiBhczvegfuV6XQDRe013M1aTmTOT31TRs5OL3w19bX5UsBvyF8tY/lkE8eTcMtf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723320358; c=relaxed/simple;
	bh=/0lQasp91D+kBrslK0ue8j6f66yAubgt4IwOH2uM4cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NPVBEeL8ydCMQaamIMPUhI8a/Zm6PfxnbJOPF25xU3VK2kyU3RWfxndU8MNJFqd0Ww2v+bZuk+7mH3INEhzcbTlUpJjZVImeNtuvky+glFtbg0ez3ygTTgxPZj8ZFylPNLuk4PixNGygRqlgR7exIkCkpLHV4oefe0oM+d9lgL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MWK/a331; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723320356; x=1754856356;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/0lQasp91D+kBrslK0ue8j6f66yAubgt4IwOH2uM4cs=;
  b=MWK/a331PoVVRlV9mPSvCr0svPWyvjFxKWjTPGoov1SsHpAFdDvjG6V3
   KfOljtYQgXK39awlUo5JAHKtgkneT+36t+OT0BF94j5kABwMssw0V2cq+
   Z+wFGGXQ7e3N2aKUUKfntW9QkI1xay2/vfzBzBFNg3rDTTdB+JwnCPSlS
   gDT2F5vCt4ypMTZR9uN8PLwFZDsA3TO7JS79AFhVeq/u57UkYTQhVUKTi
   4OwGdBe2m4teS7OJPgFBm4RxKjy97wt5ScYeWL8rO0FTXzaFXlj/MvHSG
   m1goDEHKC8tyN/RD79QEOktLZrd6E0MvMoiXD3QD7AQIYS8nIaj5nMaof
   g==;
X-CSE-ConnectionGUID: ldrrqHZzSdOMAciiV+39vw==
X-CSE-MsgGUID: oYmi/6okQEKyhGpBZ95xlg==
X-IronPort-AV: E=McAfee;i="6700,10204,11160"; a="25336716"
X-IronPort-AV: E=Sophos;i="6.09,279,1716274800"; 
   d="scan'208";a="25336716"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2024 13:05:55 -0700
X-CSE-ConnectionGUID: WdQRY8y3RSmcjzlCH8qENA==
X-CSE-MsgGUID: Mev2OkZ5QcWfEW0J5goX0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,279,1716274800"; 
   d="scan'208";a="62272713"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 10 Aug 2024 13:05:52 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1scsLW-000AGN-2n;
	Sat, 10 Aug 2024 20:05:50 +0000
Date: Sun, 11 Aug 2024 04:05:49 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Kalle Valo <kvalo@kernel.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2][next] wifi: iwlwifi: mvm: Use __counted_by() and
 avoid -Wfamnae warnings
Message-ID: <202408110304.CRXk8u09-lkp@intel.com>
References: <ZrZs5KL5Pz9tIinr@cute>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrZs5KL5Pz9tIinr@cute>

Hi Gustavo,

kernel test robot noticed the following build errors:

[auto build test ERROR on wireless-next/main]
[also build test ERROR on wireless/main linus/master v6.11-rc2 next-20240809]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Gustavo-A-R-Silva/wifi-iwlwifi-mvm-Use-__counted_by-and-avoid-Wfamnae-warnings/20240810-103759
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/ZrZs5KL5Pz9tIinr%40cute
patch subject: [PATCH v2][next] wifi: iwlwifi: mvm: Use __counted_by() and avoid -Wfamnae warnings
config: sparc-allmodconfig (https://download.01.org/0day-ci/archive/20240811/202408110304.CRXk8u09-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240811/202408110304.CRXk8u09-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408110304.CRXk8u09-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <command-line>:
   drivers/net/wireless/intel/iwlwifi/mvm/d3.c: In function 'iwl_mvm_gtk_rekey':
>> include/linux/compiler_types.h:510:45: error: call to '__compiletime_assert_821' declared with attribute error: BUILD_BUG_ON failed: conf->keylen < WLAN_KEY_LEN_CCMP
     510 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:491:25: note: in definition of macro '__compiletime_assert'
     491 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:510:9: note: in expansion of macro '_compiletime_assert'
     510 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   drivers/net/wireless/intel/iwlwifi/mvm/d3.c:2148:9: note: in expansion of macro 'BUILD_BUG_ON'
    2148 |         BUILD_BUG_ON(conf->keylen < WLAN_KEY_LEN_CCMP);
         |         ^~~~~~~~~~~~
>> include/linux/compiler_types.h:510:45: error: call to '__compiletime_assert_822' declared with attribute error: BUILD_BUG_ON failed: conf->keylen < WLAN_KEY_LEN_GCMP_256
     510 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:491:25: note: in definition of macro '__compiletime_assert'
     491 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:510:9: note: in expansion of macro '_compiletime_assert'
     510 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   drivers/net/wireless/intel/iwlwifi/mvm/d3.c:2149:9: note: in expansion of macro 'BUILD_BUG_ON'
    2149 |         BUILD_BUG_ON(conf->keylen < WLAN_KEY_LEN_GCMP_256);
         |         ^~~~~~~~~~~~


vim +/__compiletime_assert_821 +510 include/linux/compiler_types.h

eb5c2d4b45e3d2 Will Deacon 2020-07-21  496  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  497  #define _compiletime_assert(condition, msg, prefix, suffix) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21  498  	__compiletime_assert(condition, msg, prefix, suffix)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  499  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  500  /**
eb5c2d4b45e3d2 Will Deacon 2020-07-21  501   * compiletime_assert - break build and emit msg if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  502   * @condition: a compile-time constant condition to check
eb5c2d4b45e3d2 Will Deacon 2020-07-21  503   * @msg:       a message to emit if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  504   *
eb5c2d4b45e3d2 Will Deacon 2020-07-21  505   * In tradition of POSIX assert, this macro will break the build if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  506   * supplied condition is *false*, emitting the supplied error message if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  507   * compiler has support to do so.
eb5c2d4b45e3d2 Will Deacon 2020-07-21  508   */
eb5c2d4b45e3d2 Will Deacon 2020-07-21  509  #define compiletime_assert(condition, msg) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21 @510  	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  511  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

