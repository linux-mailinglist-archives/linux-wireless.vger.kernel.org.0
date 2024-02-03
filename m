Return-Path: <linux-wireless+bounces-3081-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FB78486AA
	for <lists+linux-wireless@lfdr.de>; Sat,  3 Feb 2024 15:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99BA51C22052
	for <lists+linux-wireless@lfdr.de>; Sat,  3 Feb 2024 14:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7AC5DF25;
	Sat,  3 Feb 2024 14:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AfpCzIPj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E1F5DF16;
	Sat,  3 Feb 2024 14:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706970097; cv=none; b=lgraUIGHSJ6gurGX/ncI8EBNq82cSl5YPSSLmptXJtCssRRQ9ABgX6AD2lJLZREQou9sGEyKTAsrjBboCkS1CpxXx/uSqQQEQEkw55ofgEoO4/F/A+f6KxV6JvfXhlJ+sEqs5E0qIsuAGQ2qBRg8dlCO3HDiu9E/P6OL28z2AeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706970097; c=relaxed/simple;
	bh=jbe1RCokte3s+lwYFj+Qw2J1gC36MNGy/9NJXF7DZPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tX1vnHbl5BVkJmVDSsegJiBJ3UKmnmGrhFxq9R3KNHmP3TUhToRJySFg/ZGSjbo9wenIqE5haXcnPWc+iKtLbNq9HDMs7Ig3zZJn/qM3CLx12BdFGC131ar0IAleMixmy02nd1Iij2XUw0qoXJx993X/b/5zbs1tmAmiz3rkjdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AfpCzIPj; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706970096; x=1738506096;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jbe1RCokte3s+lwYFj+Qw2J1gC36MNGy/9NJXF7DZPs=;
  b=AfpCzIPjOhlcfh1BTZm8txynmklamMqvWCwYNMCqSEtI8G24YLq/s90P
   f2d7HxmuIETQJo6YjpfqgjZEewAAYDMWJM72S3DWmzz0May0JStw+7Dej
   YHgD1AQ9AkK9Xz50kw5IgAV2/Rb1lqKmDVRbtlkmZgzR8/VCUzksDifW4
   MwoxV3Vlnq462JgG9Ec+cBQiZI1AvbXGsesuU+vQHZYeBPwFPJ+7IVRug
   JVReaO6mPcGECHTOxhgxjlHfksqYHBgkJYxn5SIeEsEWj5jZ/Jbp0+A3n
   B/b+zTLJsWVeLUlXQF5JGkDZGnHZqFYLulUFRmD7qfvydaUK4cUSF1DJO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10973"; a="11680506"
X-IronPort-AV: E=Sophos;i="6.05,240,1701158400"; 
   d="scan'208";a="11680506"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2024 06:21:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,240,1701158400"; 
   d="scan'208";a="540616"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 03 Feb 2024 06:21:32 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rWGtd-00059M-28;
	Sat, 03 Feb 2024 14:21:29 +0000
Date: Sat, 3 Feb 2024 22:20:51 +0800
From: kernel test robot <lkp@intel.com>
To: Fiona Klute <fiona.klute@gmx.de>, linux-wireless@vger.kernel.org,
	Ping-Ke Shih <pkshih@realtek.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Kalle Valo <kvalo@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
	=?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>,
	Fiona Klute <fiona.klute@gmx.de>
Subject: Re: [PATCH 1/9] wifi: rtw88: Shared module for rtw8723x devices
Message-ID: <202402032222.kwUrsH9V-lkp@intel.com>
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
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20240203/202402032222.kwUrsH9V-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240203/202402032222.kwUrsH9V-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402032222.kwUrsH9V-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/wireless/realtek/rtw88/rtw8723x.c:156:6: warning: no previous prototype for function '__rtw8723x_cfg_ldo25' [-Wmissing-prototypes]
     156 | void __rtw8723x_cfg_ldo25(struct rtw_dev *rtwdev, bool enable)
         |      ^
   drivers/net/wireless/realtek/rtw88/rtw8723x.c:156:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     156 | void __rtw8723x_cfg_ldo25(struct rtw_dev *rtwdev, bool enable)
         | ^
         | static 
   1 warning generated.


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

