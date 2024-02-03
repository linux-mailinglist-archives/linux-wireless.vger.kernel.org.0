Return-Path: <linux-wireless+bounces-3087-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B2C848904
	for <lists+linux-wireless@lfdr.de>; Sat,  3 Feb 2024 22:47:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B4D7B243ED
	for <lists+linux-wireless@lfdr.de>; Sat,  3 Feb 2024 21:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9AC12E43;
	Sat,  3 Feb 2024 21:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BkPsJW3g"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DE012B9A;
	Sat,  3 Feb 2024 21:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706996863; cv=none; b=VWyHwDAMfjSedScZVM7rN8A5VfWEFgt9NnBQUjaPtm3jAwomXjaSg9xSkc60Qtt2pr0+ORJa/VtWh7HDBoUW0cT78BOgO2TlBE7ct3/spU0A8SOtIm5MwS1esmEka+8tjOfzHMkEqjzX8+eOci/Og6AG5qosdsIeVoWGNGliobw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706996863; c=relaxed/simple;
	bh=eJYAaMsgL0ueSQnPT57fASVVRZAuwx4mNxup1pccJMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nol4lz5YzFQMbmDkA94DjcYe4dRN+KtxsJxJ/RJFfdFXpNOiIWEjqJvHBXCdEk5t5qiPn5vGM0pjfR0HFr4APrcusIc5WglUl7M++tL/oUbP1X7tpfU2qktIKtaIVPh/Lk6126F5tp++ypPOgtR9hJe9O8I3FqOMY0oUBNCiq4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BkPsJW3g; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706996862; x=1738532862;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eJYAaMsgL0ueSQnPT57fASVVRZAuwx4mNxup1pccJMw=;
  b=BkPsJW3g6jNU6UaHVCTESSHMdF8TLN+dJNdBWcCdw/rRh47WT0tM23pq
   MdbPwl+DrpD34W9v1lirN6hOd9jSSI9SkffnDlv011zYz9kZ0ogIGFv4/
   u/IqVeTpCz0PHzNW+gXgIEGW0leOtMdjJ86yNznOLHacpXcIETuixyPhY
   XN0hoEKMHaqlTVJijoovRuJynnp31OpV5Mk8rLlILmSGM8kP2KGAZdOx6
   fFZpOO7OaCHtRAfX2w00cC4K0ARzXN5AyunmxncyPEd/joj4KjTNKkA/Z
   A8vVM3CZ/5z7menojWxyQ8YbEFy8jVlkLe7DHa5W25r8MFa1RP4O+n9M9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10973"; a="17756611"
X-IronPort-AV: E=Sophos;i="6.05,241,1701158400"; 
   d="scan'208";a="17756611"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2024 13:47:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,241,1701158400"; 
   d="scan'208";a="373629"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 03 Feb 2024 13:47:38 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rWNrL-0005e5-1W;
	Sat, 03 Feb 2024 21:47:35 +0000
Date: Sun, 4 Feb 2024 05:47:00 +0800
From: kernel test robot <lkp@intel.com>
To: Fiona Klute <fiona.klute@gmx.de>, linux-wireless@vger.kernel.org,
	Ping-Ke Shih <pkshih@realtek.com>
Cc: oe-kbuild-all@lists.linux.dev, Kalle Valo <kvalo@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
	Pavel Machek <pavel@ucw.cz>,
	=?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>,
	Fiona Klute <fiona.klute@gmx.de>
Subject: Re: [PATCH 1/9] wifi: rtw88: Shared module for rtw8723x devices
Message-ID: <202402040512.CAqNtCtW-lkp@intel.com>
References: <20240202121050.977223-2-fiona.klute@gmx.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202121050.977223-2-fiona.klute@gmx.de>

Hi Fiona,

kernel test robot noticed the following build warnings:

[auto build test WARNING on wireless-next/main]
[also build test WARNING on wireless/main linus/master v6.8-rc2 next-20240202]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Fiona-Klute/wifi-rtw88-Shared-module-for-rtw8723x-devices/20240202-201428
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/20240202121050.977223-2-fiona.klute%40gmx.de
patch subject: [PATCH 1/9] wifi: rtw88: Shared module for rtw8723x devices
config: x86_64-randconfig-121-20240203 (https://download.01.org/0day-ci/archive/20240204/202402040512.CAqNtCtW-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240204/202402040512.CAqNtCtW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402040512.CAqNtCtW-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/net/wireless/realtek/rtw88/rtw8723x.c:156:6: sparse: sparse: symbol '__rtw8723x_cfg_ldo25' was not declared. Should it be static?

vim +/__rtw8723x_cfg_ldo25 +156 drivers/net/wireless/realtek/rtw88/rtw8723x.c

   155	
 > 156	void __rtw8723x_cfg_ldo25(struct rtw_dev *rtwdev, bool enable)
   157	{
   158		u8 ldo_pwr;
   159	
   160		ldo_pwr = rtw_read8(rtwdev, REG_LDO_EFUSE_CTRL + 3);
   161		if (enable) {
   162			ldo_pwr &= ~BIT_MASK_LDO25_VOLTAGE;
   163			ldo_pwr |= (BIT_LDO25_VOLTAGE_V25 << 4) | BIT_LDO25_EN;
   164		} else {
   165			ldo_pwr &= ~BIT_LDO25_EN;
   166		}
   167		rtw_write8(rtwdev, REG_LDO_EFUSE_CTRL + 3, ldo_pwr);
   168	}
   169	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

