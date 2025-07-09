Return-Path: <linux-wireless+bounces-25084-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9EC4AFE414
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 11:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A459C188FFB2
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 09:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A49285065;
	Wed,  9 Jul 2025 09:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TY69fjRo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6391721ABDB;
	Wed,  9 Jul 2025 09:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752053474; cv=none; b=M01qtJlvcegB8Xlz5AQKJAN+txELqdtiBJ0gyg+0HRdaNty3IfMCnrQDXq9V+4FoKa5N470L2OmXbJKPyNeR+k9PoiPxdbA62qxgcLJZ05UQAfmVxtLv9w5AHEgVvAdUtFfMxjzNafRxj6tjGFR/32DsK7bA2xo0M+xVSTbdPaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752053474; c=relaxed/simple;
	bh=NDIeKvKN6PhyGm+E4n56kqaD22eU91kCw5AVe3oMfyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tm9bbjb11Xw/ja+IE7497EWaUv1hwK6FIrsAgY+2hv3W6a+q7dFSubiKg3PjW6vr1OrzKgIF48VR94hoZqsZCbHJIBJC23K85b3d2ggXRFuCW3ZuArYg8fA9l37XEzz8loqNF4q+Vk2IU3kQjjR13mFLMJUg4Ng0o9RxhTqTu/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TY69fjRo; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752053472; x=1783589472;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NDIeKvKN6PhyGm+E4n56kqaD22eU91kCw5AVe3oMfyA=;
  b=TY69fjRo9VxIAF8Nxx76P2gqL3LVVGJVrwm7QZcZfuwGuPTbLpUEJHNw
   RnP3YK3/q08kjCxbMhFtkWcDqp+FnGtPwyMt4PEZvJsU2FsdP7OkTxEHm
   C20yoIkCDTyJsUA/XUWLsmd6mSeRlnj8k3gOYM1Ll4FXVe9NaH+s51JPZ
   +5PDrgJtnGLg33B/ixWu2XkoX+gmHlDTDymcde5ywnEm+PnWr2mMDhzY4
   JOJUys5liEUcA3XQlTV1FYRpenkqZeQWdCotcGsF40uFeTqqFIaGOnLzK
   JWZXjkzB1Ifu1SYisbq9AasmSp4dkS/pt6OArphUfE3EFiP5+xpVpO9zr
   Q==;
X-CSE-ConnectionGUID: bFNP7nVeRnqKOiYgMeW/dg==
X-CSE-MsgGUID: Opoe+V57SJ+bQrylKr+jEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="64556060"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="64556060"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 02:31:11 -0700
X-CSE-ConnectionGUID: EoIfbataRlSJM9AyKJtNYA==
X-CSE-MsgGUID: afWGX1HFQAapc7+fWbUdRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="156462685"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 09 Jul 2025 02:31:08 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uZR8s-0003M3-06;
	Wed, 09 Jul 2025 09:31:06 +0000
Date: Wed, 9 Jul 2025 17:30:36 +0800
From: kernel test robot <lkp@intel.com>
To: Rosen Penev <rosenp@gmail.com>, linux-wireless@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Johannes Berg <johannes@sipsolutions.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Stanislaw Gruszka <stf_xl@wp.pl>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Subject: Re: [PATCHv2 wireless-next 4/7] wifi: rt2800: move 2x00soc to 2800soc
Message-ID: <202507091735.YeYeU2tw-lkp@intel.com>
References: <20250708201745.5900-5-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708201745.5900-5-rosenp@gmail.com>

Hi Rosen,

kernel test robot noticed the following build errors:

[auto build test ERROR on wireless/main]
[also build test ERROR on next-20250708]
[cannot apply to wireless-next/main robh/for-next linus/master v6.16-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Rosen-Penev/wifi-rt2x00-add-COMPILE_TEST/20250709-042051
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git main
patch link:    https://lore.kernel.org/r/20250708201745.5900-5-rosenp%40gmail.com
patch subject: [PATCHv2 wireless-next 4/7] wifi: rt2800: move 2x00soc to 2800soc
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20250709/202507091735.YeYeU2tw-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250709/202507091735.YeYeU2tw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507091735.YeYeU2tw-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/wireless/ralink/rt2x00/rt2800soc.c:376:27: error: 'rt2x00soc_suspend' undeclared here (not in a function); did you mean 'rt2x00lib_suspend'?
     376 |         .suspend        = rt2x00soc_suspend,
         |                           ^~~~~~~~~~~~~~~~~
         |                           rt2x00lib_suspend
>> drivers/net/wireless/ralink/rt2x00/rt2800soc.c:377:27: error: 'rt2x00soc_resume' undeclared here (not in a function); did you mean 'rt2x00soc_remove'?
     377 |         .resume         = rt2x00soc_resume,
         |                           ^~~~~~~~~~~~~~~~
         |                           rt2x00soc_remove


vim +376 drivers/net/wireless/ralink/rt2x00/rt2800soc.c

90ce325a735fa7 drivers/net/wireless/ralink/rt2x00/rt2800soc.c Rosen Penev 2025-07-08  368  
fe7ef7c60c33fd drivers/net/wireless/rt2x00/rt2800soc.c        Gabor Juhos 2013-10-17  369  static struct platform_driver rt2800soc_driver = {
fe7ef7c60c33fd drivers/net/wireless/rt2x00/rt2800soc.c        Gabor Juhos 2013-10-17  370  	.driver		= {
fe7ef7c60c33fd drivers/net/wireless/rt2x00/rt2800soc.c        Gabor Juhos 2013-10-17  371  		.name		= "rt2800_wmac",
90ce325a735fa7 drivers/net/wireless/ralink/rt2x00/rt2800soc.c Rosen Penev 2025-07-08  372  		.of_match_table = rt2880_wmac_match,
fe7ef7c60c33fd drivers/net/wireless/rt2x00/rt2800soc.c        Gabor Juhos 2013-10-17  373  	},
fe7ef7c60c33fd drivers/net/wireless/rt2x00/rt2800soc.c        Gabor Juhos 2013-10-17  374  	.probe		= rt2800soc_probe,
fe7ef7c60c33fd drivers/net/wireless/rt2x00/rt2800soc.c        Gabor Juhos 2013-10-17  375  	.remove		= rt2x00soc_remove,
fe7ef7c60c33fd drivers/net/wireless/rt2x00/rt2800soc.c        Gabor Juhos 2013-10-17 @376  	.suspend	= rt2x00soc_suspend,
fe7ef7c60c33fd drivers/net/wireless/rt2x00/rt2800soc.c        Gabor Juhos 2013-10-17 @377  	.resume		= rt2x00soc_resume,
fe7ef7c60c33fd drivers/net/wireless/rt2x00/rt2800soc.c        Gabor Juhos 2013-10-17  378  };
fe7ef7c60c33fd drivers/net/wireless/rt2x00/rt2800soc.c        Gabor Juhos 2013-10-17  379  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

