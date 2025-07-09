Return-Path: <linux-wireless+bounces-25101-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA88AFEDD5
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 17:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF010481E7A
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 15:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1312E7BB6;
	Wed,  9 Jul 2025 15:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hdrhrda1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE81E2E6127;
	Wed,  9 Jul 2025 15:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752075289; cv=none; b=c8+5DSZwFPbA8MI1Mnfapzv+38DZHoJgEL19Bh0lusox12zfGmCrf/rqD5J4h4HunYMdjz4W23+sRYGNPGSeKfSZ1hZCbFDs+bHSbFmSwOw/7XWavw4kKxrxJ9DvEPlZrp7/1vcpCD3UW006k9p1fh3CU96mtLLPw9/FD8cL+6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752075289; c=relaxed/simple;
	bh=GARUNpM9H4+xNBBzYx9lXk4Njm6ZssGnZSUDn36uSlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=byjfYtWTtKOkToDhSfua3rcHGvtY/s2I3eX/dsVltQfM+VIMKrE59cW30EysIJEdkfXIW/A0uIpA7zYUV5dEJmSiS5tFDjeSY/NtT6uj5zTjXRxK808l596+L6mIvNNtNMDPqvchxfIiAMPvz6gueecPDaFmp3vWqaCnIuUbTO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hdrhrda1; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752075288; x=1783611288;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GARUNpM9H4+xNBBzYx9lXk4Njm6ZssGnZSUDn36uSlA=;
  b=hdrhrda1s34kQjgqYmZP03FcF2UzeFE3re6yCZ/kWKcqTMrcuExT/fbQ
   4Fa72c1SYZCof+KRpRLPAP28sV45OkhAC9bw85kL8skPyGmtLoT5Hn1sc
   GPDE2dQhlzyuskRd8vFZ4asbnoFTU9Bx0Z9IzYN5EE6px4UZysLeXymg0
   d2Vpv8+wX916HojHr3e6WSZocVl05qTr9Vxbpt/A7GkyX4fwaXkWehTRo
   1COZHip72X6p2MtlKFgJPRXoO5lpttDU/P98BZgm9m7yWlsbqc3j8eZ8I
   MMwPiv94VtFAa8cyUCnDZzAqQeEaTfiSwf68yUiwRuSvMS62uzWgGn97B
   g==;
X-CSE-ConnectionGUID: KSfqR9XYSQKIx/uj2/dNzw==
X-CSE-MsgGUID: V0fvVmtgRBOBTm4tha6CIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="54312170"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="54312170"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 08:34:47 -0700
X-CSE-ConnectionGUID: mY03xM4IRxauD+4+tnfP1w==
X-CSE-MsgGUID: qXLM07ZQRV2rU23uJAT5NA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="159836384"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 09 Jul 2025 08:34:43 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uZWoi-0003g7-2m;
	Wed, 09 Jul 2025 15:34:40 +0000
Date: Wed, 9 Jul 2025 23:34:09 +0800
From: kernel test robot <lkp@intel.com>
To: Rosen Penev <rosenp@gmail.com>, linux-wireless@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Johannes Berg <johannes@sipsolutions.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Stanislaw Gruszka <stf_xl@wp.pl>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Subject: Re: [PATCHv2 wireless-next 5/7] wifi: rt2x00: soc: modernize probe
Message-ID: <202507092348.YnsHKi8x-lkp@intel.com>
References: <20250708201745.5900-6-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708201745.5900-6-rosenp@gmail.com>

Hi Rosen,

kernel test robot noticed the following build errors:

[auto build test ERROR on wireless/main]
[also build test ERROR on next-20250709]
[cannot apply to wireless-next/main robh/for-next linus/master v6.16-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Rosen-Penev/wifi-rt2x00-add-COMPILE_TEST/20250709-042051
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git main
patch link:    https://lore.kernel.org/r/20250708201745.5900-6-rosenp%40gmail.com
patch subject: [PATCHv2 wireless-next 5/7] wifi: rt2x00: soc: modernize probe
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20250709/202507092348.YnsHKi8x-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250709/202507092348.YnsHKi8x-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507092348.YnsHKi8x-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/wireless/ralink/rt2x00/rt2800soc.c:347:13: error: use of undeclared identifier 'rt2x00soc_suspend'; did you mean 'rt2x00lib_suspend'?
     347 |         .suspend        = rt2x00soc_suspend,
         |                           ^~~~~~~~~~~~~~~~~
         |                           rt2x00lib_suspend
   drivers/net/wireless/ralink/rt2x00/rt2x00.h:1504:5: note: 'rt2x00lib_suspend' declared here
    1504 | int rt2x00lib_suspend(struct rt2x00_dev *rt2x00dev);
         |     ^
   drivers/net/wireless/ralink/rt2x00/rt2800soc.c:348:13: error: use of undeclared identifier 'rt2x00soc_resume'; did you mean 'rt2x00lib_resume'?
     348 |         .resume         = rt2x00soc_resume,
         |                           ^~~~~~~~~~~~~~~~
         |                           rt2x00lib_resume
   drivers/net/wireless/ralink/rt2x00/rt2x00.h:1505:5: note: 'rt2x00lib_resume' declared here
    1505 | int rt2x00lib_resume(struct rt2x00_dev *rt2x00dev);
         |     ^
>> drivers/net/wireless/ralink/rt2x00/rt2800soc.c:347:13: error: incompatible function pointer types initializing 'int (*)(struct platform_device *, pm_message_t)' (aka 'int (*)(struct platform_device *, struct pm_message)') with an expression of type 'int (struct rt2x00_dev *)' [-Wincompatible-function-pointer-types]
     347 |         .suspend        = rt2x00soc_suspend,
         |                           ^~~~~~~~~~~~~~~~~
>> drivers/net/wireless/ralink/rt2x00/rt2800soc.c:348:13: error: incompatible function pointer types initializing 'int (*)(struct platform_device *)' with an expression of type 'int (struct rt2x00_dev *)' [-Wincompatible-function-pointer-types]
     348 |         .resume         = rt2x00soc_resume,
         |                           ^~~~~~~~~~~~~~~~
   4 errors generated.


vim +347 drivers/net/wireless/ralink/rt2x00/rt2800soc.c

90ce325a735fa7 drivers/net/wireless/ralink/rt2x00/rt2800soc.c Rosen Penev 2025-07-08  339  
fe7ef7c60c33fd drivers/net/wireless/rt2x00/rt2800soc.c        Gabor Juhos 2013-10-17  340  static struct platform_driver rt2800soc_driver = {
fe7ef7c60c33fd drivers/net/wireless/rt2x00/rt2800soc.c        Gabor Juhos 2013-10-17  341  	.driver		= {
fe7ef7c60c33fd drivers/net/wireless/rt2x00/rt2800soc.c        Gabor Juhos 2013-10-17  342  		.name		= "rt2800_wmac",
90ce325a735fa7 drivers/net/wireless/ralink/rt2x00/rt2800soc.c Rosen Penev 2025-07-08  343  		.of_match_table = rt2880_wmac_match,
fe7ef7c60c33fd drivers/net/wireless/rt2x00/rt2800soc.c        Gabor Juhos 2013-10-17  344  	},
fe7ef7c60c33fd drivers/net/wireless/rt2x00/rt2800soc.c        Gabor Juhos 2013-10-17  345  	.probe		= rt2800soc_probe,
115321558169cc drivers/net/wireless/ralink/rt2x00/rt2800soc.c Rosen Penev 2025-07-08  346  	.remove		= rt2800soc_remove,
fe7ef7c60c33fd drivers/net/wireless/rt2x00/rt2800soc.c        Gabor Juhos 2013-10-17 @347  	.suspend	= rt2x00soc_suspend,
fe7ef7c60c33fd drivers/net/wireless/rt2x00/rt2800soc.c        Gabor Juhos 2013-10-17 @348  	.resume		= rt2x00soc_resume,
fe7ef7c60c33fd drivers/net/wireless/rt2x00/rt2800soc.c        Gabor Juhos 2013-10-17  349  };
fe7ef7c60c33fd drivers/net/wireless/rt2x00/rt2800soc.c        Gabor Juhos 2013-10-17  350  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

