Return-Path: <linux-wireless+bounces-12133-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 218B296222C
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 10:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 792C11F21FB7
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 08:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198BB15B103;
	Wed, 28 Aug 2024 08:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LGrHmquO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87506156C76;
	Wed, 28 Aug 2024 08:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724833135; cv=none; b=rvGClujkgby0DilW2SAzwcVbGlwwV0jirRryvcyMGVz/KecTeE/Q3zEByvEF8sRwAiXIABmxqFAQJcDArII1OgtiBvwqST2TzDhuVErlnfwzi+b6r9Ui4ijz6M/DpUqnHVwrDBCAyNOjnVYd67FMTW6aFjhZHbOXMwcgTx5A50c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724833135; c=relaxed/simple;
	bh=67B6v/6kWDCPcgu7Pcf8hglMBU4sht72HbJJzGDX+hM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h0JJzD6Dl1IZGwANrX+IbfBwCCn5bD806xnem8fd11s+m1PTCkYD1kNb8+tMgG9b8ucj7RxRs66so9YPROgQumm8wlnfAxq9pq6Md+YitPf9clltM+B45ClEV13jYwblFJF8d3rBwd9kjgCmkf1pKsodm092V8dHK3M1ON//p5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LGrHmquO; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724833132; x=1756369132;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=67B6v/6kWDCPcgu7Pcf8hglMBU4sht72HbJJzGDX+hM=;
  b=LGrHmquOn5zT9TVFHIU4sxfg1UM5XkQb4kaNytYQL7UsN0xpED2iBDLY
   RYJ6DjZqGAFczZdm3+0k17z1+V7yvO1/crpnEgon2A4C8Nb1roZa7Mbbo
   GIbF4EuWD4PkVYqzDinEZGyRRsfs0aO2LL7Zmo6Hr0mr0ld2UKr+T6CuB
   lvP5Df0qozQXmQeE2yidEWKix2JkXjBywkt9T2OZAPcqgOqqW0GiRDBkp
   ROfbDKvNUlmgxE2XZHj8MlnZnUMm+oLhxqNKyO7eHXhk7ib6U/M99ZMEW
   YPBqfHFpvkR6KJLEeEDZVVpYiz+HxUtTqndGOGNwwEJVRKnXdGZ8HHxSt
   g==;
X-CSE-ConnectionGUID: aYzC4WEDRtqg929oIcwbHw==
X-CSE-MsgGUID: MF6627CcTSmr7Pqid5IbtA==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="27116297"
X-IronPort-AV: E=Sophos;i="6.10,182,1719903600"; 
   d="scan'208";a="27116297"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 01:18:49 -0700
X-CSE-ConnectionGUID: /m5d2NY2SqGMdEIBjX52gw==
X-CSE-MsgGUID: EXNrMRjESJuptaz/EpjDPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,182,1719903600"; 
   d="scan'208";a="63141243"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 28 Aug 2024 01:18:46 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sjDt5-000KeU-2Q;
	Wed, 28 Aug 2024 08:18:43 +0000
Date: Wed, 28 Aug 2024 16:17:50 +0800
From: kernel test robot <lkp@intel.com>
To: Hongbo Li <lihongbo22@huawei.com>, johannes@sipsolutions.net,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, allison.henderson@oracle.com, dsahern@kernel.org,
	pshelar@ovn.org
Cc: oe-kbuild-all@lists.linux.dev, linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org, rds-devel@oss.oracle.com,
	dccp@vger.kernel.org, dev@openvswitch.org,
	linux-afs@lists.infradead.org, lihongbo22@huawei.com
Subject: Re: [PATCH net-next 4/8] net/core: Use min()/max() to simplify the
 code
Message-ID: <202408281628.FtNGguag-lkp@intel.com>
References: <20240824074033.2134514-5-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240824074033.2134514-5-lihongbo22@huawei.com>

Hi Hongbo,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Hongbo-Li/net-mac80211-use-max-to-simplify-the-code/20240826-154029
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240824074033.2134514-5-lihongbo22%40huawei.com
patch subject: [PATCH net-next 4/8] net/core: Use min()/max() to simplify the code
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20240828/202408281628.FtNGguag-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240828/202408281628.FtNGguag-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408281628.FtNGguag-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <command-line>:
   net/core/pktgen.c: In function 'pktgen_finalize_skb':
>> include/linux/compiler_types.h:510:45: error: call to '__compiletime_assert_991' declared with attribute error: min(datalen/frags, (1UL << 16)) signedness error
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
   include/linux/minmax.h:100:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     100 |         BUILD_BUG_ON_MSG(!__types_ok(x,y,ux,uy),        \
         |         ^~~~~~~~~~~~~~~~
   include/linux/minmax.h:105:9: note: in expansion of macro '__careful_cmp_once'
     105 |         __careful_cmp_once(op, x, y, __UNIQUE_ID(x_), __UNIQUE_ID(y_))
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:129:25: note: in expansion of macro '__careful_cmp'
     129 | #define min(x, y)       __careful_cmp(min, x, y)
         |                         ^~~~~~~~~~~~~
   net/core/pktgen.c:2796:28: note: in expansion of macro 'min'
    2796 |                 frag_len = min(datalen/frags, PAGE_SIZE);
         |                            ^~~


vim +/__compiletime_assert_991 +510 include/linux/compiler_types.h

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

