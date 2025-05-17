Return-Path: <linux-wireless+bounces-23118-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12443ABAC78
	for <lists+linux-wireless@lfdr.de>; Sat, 17 May 2025 22:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E71771B6010C
	for <lists+linux-wireless@lfdr.de>; Sat, 17 May 2025 20:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8B0215063;
	Sat, 17 May 2025 20:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l+kQUxFO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A521A1A8F84;
	Sat, 17 May 2025 20:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747514122; cv=none; b=V94lmHi2SEy7Xaz1NbbK+UNiHOtHZzM/KzQnwpTyYTMtQl8GJDDeyxfZiQAPoKqRIQWV9hDTvpf5o6/O3B3RexxJTARpzXoJa9qSYxN8LWpl52ibzvkPXw+uvYF8Gviia5dpDAc0D1p9t8YchLh0bYEP8sIVuC0sTdvJTZNyWf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747514122; c=relaxed/simple;
	bh=A1adUe+cYOvArGNE/hSK4EzFP4GP4YO5FYj9H98ZZGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c0RsxcR6owJAf0IrqH1PbPa/dkeUHG87SzqBr0O2sdS1p0YicnyyEx9VMJ7Y3yJOBap8FVBivVkDFI0jyRcjufWib/tCDQFGhNLbk30qlX/ionRSrOypRw5p0SuUZSkdZEzqAN1IgIM7ZqBYVNrH9coHdY0KURtxcauCpyLLPjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l+kQUxFO; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747514120; x=1779050120;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=A1adUe+cYOvArGNE/hSK4EzFP4GP4YO5FYj9H98ZZGQ=;
  b=l+kQUxFOF7H1XamjgfipG/v+EmIA4uqrrPtcyeH9+RZMPRjfPHTth5K+
   nrsisM4lBfzAA+FkDju4d4NwEObmus/5NtnGCsJYqqRgyQCrxBBY7SJf2
   7nc5EwTa7O+NDANIlHG+IxgRc7nj49NDmaJx94Jw32n6z9iXqdBFNdrY4
   pRzO7LV87br1MPfEzRSNBi8LnqjqMUjCCrwHOpImrEny1NTB2dSxj2EEe
   lRBfuJ1ZbJzMrXhYDaM1amKP+jwD1JJ3SMeSn7SdCMeh4q+aNBFtz2gJi
   q0wIB+9c8MU6RECWvITcoo06XZubGJhHkU5Dxl92piBlRjLgVdMNYsMQd
   A==;
X-CSE-ConnectionGUID: /RjZoGvsQGaiKHiwOzJUYw==
X-CSE-MsgGUID: gqbxTUJbSYmIBUGFuSGtYw==
X-IronPort-AV: E=McAfee;i="6700,10204,11436"; a="71961248"
X-IronPort-AV: E=Sophos;i="6.15,297,1739865600"; 
   d="scan'208";a="71961248"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2025 13:35:19 -0700
X-CSE-ConnectionGUID: KuzKdv50RgmVX84J2pgSQg==
X-CSE-MsgGUID: SE9CoXYGRI+xOotZOC8XOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,297,1739865600"; 
   d="scan'208";a="139402611"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 17 May 2025 13:35:17 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uGOFW-000KQF-0H;
	Sat, 17 May 2025 20:35:14 +0000
Date: Sun, 18 May 2025 04:35:03 +0800
From: kernel test robot <lkp@intel.com>
To: Wentao Liang <vulab@iscas.ac.cn>, ajay.kathat@microchip.com,
	claudiu.beznea@tuxon.dev, kvalo@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: Re: [PATCH] wifi: wilc1000: Add error handling for wilc_sdio_cmd52()
Message-ID: <202505180440.dyQDHWJJ-lkp@intel.com>
References: <20250516083842.903-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250516083842.903-1-vulab@iscas.ac.cn>

Hi Wentao,

kernel test robot noticed the following build errors:

[auto build test ERROR on wireless-next/main]
[also build test ERROR on wireless/main linus/master v6.15-rc6 next-20250516]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Wentao-Liang/wifi-wilc1000-Add-error-handling-for-wilc_sdio_cmd52/20250516-163959
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/20250516083842.903-1-vulab%40iscas.ac.cn
patch subject: [PATCH] wifi: wilc1000: Add error handling for wilc_sdio_cmd52()
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20250518/202505180440.dyQDHWJJ-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250518/202505180440.dyQDHWJJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505180440.dyQDHWJJ-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/device.h:15,
                    from include/linux/mmc/sdio_func.h:11,
                    from drivers/net/wireless/microchip/wilc1000/sdio.c:8:
   drivers/net/wireless/microchip/wilc1000/sdio.c: In function 'wilc_sdio_read_size':
>> drivers/net/wireless/microchip/wilc1000/sdio.c:792:32: error: 'struct sdio_func' has no member named 'devm'; did you mean 'dev'?
     792 |                 dev_err(&func->devm, "Fail cmd 52, interrupt data register...\n");
         |                                ^~~~
   include/linux/dev_printk.h:110:25: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                         ^~~
   drivers/net/wireless/microchip/wilc1000/sdio.c:792:17: note: in expansion of macro 'dev_err'
     792 |                 dev_err(&func->devm, "Fail cmd 52, interrupt data register...\n");
         |                 ^~~~~~~
   drivers/net/wireless/microchip/wilc1000/sdio.c:801:32: error: 'struct sdio_func' has no member named 'devm'; did you mean 'dev'?
     801 |                 dev_err(&func->devm, "Fail cmd 52, interrupt data register...\n");
         |                                ^~~~
   include/linux/dev_printk.h:110:25: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                         ^~~
   drivers/net/wireless/microchip/wilc1000/sdio.c:801:17: note: in expansion of macro 'dev_err'
     801 |                 dev_err(&func->devm, "Fail cmd 52, interrupt data register...\n");
         |                 ^~~~~~~


vim +792 drivers/net/wireless/microchip/wilc1000/sdio.c

   774	
   775	static int wilc_sdio_read_size(struct wilc *wilc, u32 *size)
   776	{
   777		u32 tmp;
   778		struct sdio_cmd52 cmd;
   779		struct sdio_func *func = dev_to_sdio_func(wilc->dev);
   780		int ret;
   781	
   782		/**
   783		 *      Read DMA count in words
   784		 **/
   785		cmd.read_write = 0;
   786		cmd.function = 0;
   787		cmd.raw = 0;
   788		cmd.address = WILC_SDIO_INTERRUPT_DATA_SZ_REG;
   789		cmd.data = 0;
   790		ret = wilc_sdio_cmd52(wilc, &cmd);
   791		if (ret) {
 > 792			dev_err(&func->devm, "Fail cmd 52, interrupt data register...\n");
   793			return ret;
   794		}
   795		tmp = cmd.data;
   796	
   797		cmd.address = WILC_SDIO_INTERRUPT_DATA_SZ_REG + 1;
   798		cmd.data = 0;
   799		ret = wilc_sdio_cmd52(wilc, &cmd);
   800		if (ret) {
   801			dev_err(&func->devm, "Fail cmd 52, interrupt data register...\n");
   802			return ret;
   803		}
   804		tmp |= (cmd.data << 8);
   805	
   806		*size = tmp;
   807		return 0;
   808	}
   809	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

