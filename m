Return-Path: <linux-wireless+bounces-12621-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA899700A8
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Sep 2024 09:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6CEC1C21DA6
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Sep 2024 07:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB9214A4F3;
	Sat,  7 Sep 2024 07:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B3ZF3tnH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EA413A86A;
	Sat,  7 Sep 2024 07:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725695337; cv=none; b=hBj9IjfLbwjAdEX+Ndtb9QaV20chsCNvIOcINA+3s9sDwsez76+anl+f55vscpUC6IPU9hN2QpNDfvl5FOyUIuv8P9zt9Qcm9RuZS45thKJINigm75RoIJKa1bgSRjsDwUlMByYVtl3q9rPBAzDDnDqPDGJ8CchIUXL19X7LPzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725695337; c=relaxed/simple;
	bh=b/4GyXcDXtCVSLSUOBHkRWIG2CZQW6PLXuduJKLwb60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gxFx70p5b9D2/5xTDP5h1EPt2VYFi1EpI0bqpWqBM0oz/jxt3G9f9VZ6W2qFACsXKEy80Ekqx1AG4b6SnUf083CYURiIBWEPE1fjKFwHjrR2Rr8KMreqFbEsYcPMW1991mAV64TblPdgU2EaXiyzJ0dR4m/bkTDDOIXIwl11y9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B3ZF3tnH; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725695336; x=1757231336;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=b/4GyXcDXtCVSLSUOBHkRWIG2CZQW6PLXuduJKLwb60=;
  b=B3ZF3tnHhhTVhe/2Hc+8DQ08wPPGlyAHPf81H1PBT5GoHFw7wgw9OLtA
   MCJwPjpSkVr8xwqw7I7rrJ4XtSusx8idiHAoiWdQkP742wtw2gtOQo5N3
   pLsboSUBo9YOsw7c1YFuFF9hhgQuE3RA3AFKcfa/B3ycyXSABWmbgLIYd
   cKAKuSsj3rUT2AYJtv1x2uZHhxJ5B/4n3SY/naP+PLpD0RFbVty7VknCc
   pweaLGPwVZxHuJTTPX5n8/lpc/I3O8v/JrYZajpRvXguCPTJwUq6Bwxcl
   u6Kkv591y/ckK6dWrqlrn9oKPPzaLHLlRDCEiIe5HtDNoT1rvsLISTAfG
   w==;
X-CSE-ConnectionGUID: uatO1zrYT9e/1z5aUzPJdA==
X-CSE-MsgGUID: feeS+9AxQ3Gw5HwA136qBg==
X-IronPort-AV: E=McAfee;i="6700,10204,11187"; a="35597747"
X-IronPort-AV: E=Sophos;i="6.10,210,1719903600"; 
   d="scan'208";a="35597747"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2024 00:48:55 -0700
X-CSE-ConnectionGUID: lJ+wlFbpSdaetA1wI7+gig==
X-CSE-MsgGUID: jpZCqYkVRRuTow0AGp+fTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,210,1719903600"; 
   d="scan'208";a="70572985"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 07 Sep 2024 00:48:52 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1smqBe-000CIb-0w;
	Sat, 07 Sep 2024 07:48:50 +0000
Date: Sat, 7 Sep 2024 15:47:57 +0800
From: kernel test robot <lkp@intel.com>
To: Rohit Chavan <roheetchavan@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Rohit Chavan <roheetchavan@gmail.com>
Subject: Re: [PATCH] lib80211: Use ERR_CAST() to return
Message-ID: <202409071405.Ze3koraa-lkp@intel.com>
References: <20240906114455.730559-1-roheetchavan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906114455.730559-1-roheetchavan@gmail.com>

Hi Rohit,

kernel test robot noticed the following build errors:

[auto build test ERROR on wireless-next/main]
[also build test ERROR on wireless/main linus/master v6.11-rc6 next-20240906]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Rohit-Chavan/lib80211-Use-ERR_CAST-to-return/20240906-194721
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/20240906114455.730559-1-roheetchavan%40gmail.com
patch subject: [PATCH] lib80211: Use ERR_CAST() to return
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20240907/202409071405.Ze3koraa-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240907/202409071405.Ze3koraa-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409071405.Ze3koraa-lkp@intel.com/

All errors (new ones prefixed by >>):

   net/wireless/lib80211.c: In function 'lib80211_crypt_null_init':
>> net/wireless/lib80211.c:230:25: error: passing argument 1 of 'ERR_CAST' makes pointer from integer without a cast [-Wint-conversion]
     230 |         return ERR_CAST(1);
         |                         ^
         |                         |
         |                         int
   In file included from include/linux/string.h:10,
                    from include/linux/bitmap.h:13,
                    from include/linux/cpumask.h:12,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/spinlock.h:63,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/umh.h:4,
                    from include/linux/kmod.h:9,
                    from include/linux/module.h:17,
                    from net/wireless/lib80211.c:19:
   include/linux/err.h:82:64: note: expected 'const void *' but argument is of type 'int'
      82 | static inline void * __must_check ERR_CAST(__force const void *ptr)
         |                                                    ~~~~~~~~~~~~^~~


vim +/ERR_CAST +230 net/wireless/lib80211.c

   227	
   228	static void *lib80211_crypt_null_init(int keyidx)
   229	{
 > 230		return ERR_CAST(1);
   231	}
   232	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

