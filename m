Return-Path: <linux-wireless+bounces-23137-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF88ABB5E2
	for <lists+linux-wireless@lfdr.de>; Mon, 19 May 2025 09:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B431177F16
	for <lists+linux-wireless@lfdr.de>; Mon, 19 May 2025 07:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575FD266B52;
	Mon, 19 May 2025 07:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hmxJHsqX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C331F1507;
	Mon, 19 May 2025 07:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747638781; cv=none; b=Mz7C+D6PbUo8q9mgCOkJWem3w2khQvCTfI91jQfbNqXZS0WKOrSUWnrWZ8/9NMuhtuzJ82TxXxarMOTL+YN9FdyUDh5TQd45HN1GnA2mE6ZLkP+yANeiwRCpCdAVWJM6MrkbFTZf7n5E1KSJ0bIwOvmJvOV5RnczgFqmgg8QBZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747638781; c=relaxed/simple;
	bh=7/SWLXW5Hy6DaiAx0ceb1uY2JzdxPxmqQ8x1Y1jN5VE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jl5+E6k3qCWGAg+5A/fcSnqfm2QTrlrRdAfDoUWBR5V6cwMzNUqvcYEI+eFsERiKT8cwy/noWwfG12m+/IGiutbDqHFIctrmdlTpdDNhCiKtke1ew6WUB1bJvmHYcoLe2fJTJ5QtdmuxcihKNRtPY8kF7b6/2ddDaD3Hboiv/aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hmxJHsqX; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747638780; x=1779174780;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7/SWLXW5Hy6DaiAx0ceb1uY2JzdxPxmqQ8x1Y1jN5VE=;
  b=hmxJHsqXrJwZV/ar1cPbNDdWTuz2eGKFeiuMN8+558eqJgnMrzkp7Iy4
   9A5465w6nrEcP/0pyBpCZPQK8yFpRABlCcRF+wrJHqcF74YJRoUGAmpVB
   nwkQUd6yBKcInW5UqVMKTcyDRO57woBRm3ZUzdEo9NIAmFvcC5ogQq8P2
   yuB+7uVXEAVEQwKFE42/QcS93C2hiBYnNYRjVZTXJWndNM/CuutkSptz9
   izzCMEnx0ZuFW76s0AkPbZuuhbI2qW2gevBWBgn3aM+uTkSIrjyMGEOIu
   XN5WOg37q4qFC+HswLDYVhVZgeWX5jovAFbMi9ZuJ9t0M1EjY5hoP5s2L
   A==;
X-CSE-ConnectionGUID: ZUqo5DFwTCObKj/5c5PLAw==
X-CSE-MsgGUID: 068ZW2KNSpOX4xhOrmAcXA==
X-IronPort-AV: E=McAfee;i="6700,10204,11437"; a="37142812"
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="37142812"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 00:12:59 -0700
X-CSE-ConnectionGUID: TPxZaDTwQjG4bRil4Fs00A==
X-CSE-MsgGUID: 3XDW3SxGQiOJ1pnp0+rzZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="139700215"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 19 May 2025 00:12:56 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uGugA-000LFH-0G;
	Mon, 19 May 2025 07:12:54 +0000
Date: Mon, 19 May 2025 15:12:32 +0800
From: kernel test robot <lkp@intel.com>
To: Wentao Liang <vulab@iscas.ac.cn>, ajay.kathat@microchip.com,
	claudiu.beznea@tuxon.dev, kvalo@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>, stable@vger.kernel.org
Subject: Re: [PATCH v2] wifi: wilc1000: Add error handling for
 wilc_sdio_cmd52()
Message-ID: <202505191448.OycntzLM-lkp@intel.com>
References: <20250519014434.901-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250519014434.901-1-vulab@iscas.ac.cn>

Hi Wentao,

kernel test robot noticed the following build errors:

[auto build test ERROR on wireless-next/main]
[also build test ERROR on wireless/main linus/master v6.15-rc7 next-20250516]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Wentao-Liang/wifi-wilc1000-Add-error-handling-for-wilc_sdio_cmd52/20250519-094706
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/20250519014434.901-1-vulab%40iscas.ac.cn
patch subject: [PATCH v2] wifi: wilc1000: Add error handling for wilc_sdio_cmd52()
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20250519/202505191448.OycntzLM-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250519/202505191448.OycntzLM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505191448.OycntzLM-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/wireless/microchip/wilc1000/sdio.c:789:2: error: use of undeclared identifier 'ret'
     789 |         ret = wilc_sdio_cmd52(wilc, &cmd);
         |         ^
   drivers/net/wireless/microchip/wilc1000/sdio.c:790:6: error: use of undeclared identifier 'ret'
     790 |         if (ret) {
         |             ^
   drivers/net/wireless/microchip/wilc1000/sdio.c:792:10: error: use of undeclared identifier 'ret'
     792 |                 return ret;
         |                        ^
   drivers/net/wireless/microchip/wilc1000/sdio.c:798:2: error: use of undeclared identifier 'ret'
     798 |         ret = wilc_sdio_cmd52(wilc, &cmd);
         |         ^
   drivers/net/wireless/microchip/wilc1000/sdio.c:799:6: error: use of undeclared identifier 'ret'
     799 |         if (ret) {
         |             ^
   drivers/net/wireless/microchip/wilc1000/sdio.c:801:10: error: use of undeclared identifier 'ret'
     801 |                 return ret;
         |                        ^
   6 errors generated.


vim +/ret +789 drivers/net/wireless/microchip/wilc1000/sdio.c

   774	
   775	static int wilc_sdio_read_size(struct wilc *wilc, u32 *size)
   776	{
   777		u32 tmp;
   778		struct sdio_cmd52 cmd;
   779		struct sdio_func *func = dev_to_sdio_func(wilc->dev);
   780	
   781		/**
   782		 *      Read DMA count in words
   783		 **/
   784		cmd.read_write = 0;
   785		cmd.function = 0;
   786		cmd.raw = 0;
   787		cmd.address = WILC_SDIO_INTERRUPT_DATA_SZ_REG;
   788		cmd.data = 0;
 > 789		ret = wilc_sdio_cmd52(wilc, &cmd);
   790		if (ret) {
   791			dev_err(&func->dev, "Fail cmd 52, interrupt data register...\n");
   792			return ret;
   793		}
   794		tmp = cmd.data;
   795	
   796		cmd.address = WILC_SDIO_INTERRUPT_DATA_SZ_REG + 1;
   797		cmd.data = 0;
   798		ret = wilc_sdio_cmd52(wilc, &cmd);
   799		if (ret) {
   800			dev_err(&func->dev, "Fail cmd 52, interrupt data register...\n");
   801			return ret;
   802		}
   803		tmp |= (cmd.data << 8);
   804	
   805		*size = tmp;
   806		return 0;
   807	}
   808	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

