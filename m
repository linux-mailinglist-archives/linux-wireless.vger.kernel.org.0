Return-Path: <linux-wireless+bounces-3083-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F7D8486EF
	for <lists+linux-wireless@lfdr.de>; Sat,  3 Feb 2024 16:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15545B240BB
	for <lists+linux-wireless@lfdr.de>; Sat,  3 Feb 2024 15:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8FF71B5B7;
	Sat,  3 Feb 2024 15:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NVlBS4bu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35DF5EE91;
	Sat,  3 Feb 2024 15:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706972755; cv=none; b=Ul5yu8wDsMPehjmBpyWqfzWwWn0dEtlUAG0MsyJe6b72SuB+fzGhQ9Xqb/AsNXVP5eg2HCc7TnyQQScj1rhYumijppqUbVVUhaC7rNeV2ZAOFqRJg0u3MYguzDco5YaaW51zRwWwOFbki77uDtjOhI+OIJI8EBwWtGVvhdr6A9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706972755; c=relaxed/simple;
	bh=oN2Jtenyl16AJ73ZWHV33yxPWdeYESnQPTWfOUZIMcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JRwHaSAXMr86VfrTfulpX7CjvxTrKDCARV0ni5IM8SeA7+9nBL5aSXL74/YOcuX8T4RjkgD4IxKgY7H1wt14+9a+mKk/6z3i4WZx9SOFnO6bLdHCObk5hyq4hTBRPKeHlz0KT6AJoJGv6opTjr+YCfJUGnIqyprl0Z/o1lWzAXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NVlBS4bu; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706972754; x=1738508754;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oN2Jtenyl16AJ73ZWHV33yxPWdeYESnQPTWfOUZIMcQ=;
  b=NVlBS4buvGuM/8vDVk2ApmXbo1i1WRUofwAPo3Cnh4w+QXa/auzKuEXL
   oSJ3hQoFnJKPuJX6wcXU+9hZIEvDWJMpKHzNuHAmQtr43HtRCcoeAHO21
   LVc5NdlgrJ51mNE312IPKw8Zz9UPlJBqAano/Ut1ZrtIJNG6jpdST0oXW
   PrhZXAL6p/1IO27L51am9N4Upxsqz2xGtQC8T3s/lLm1hXzppKgFRNZ+K
   Ou2TYTnnNcdikQbmTh4FaPjG5hthHZZ/G36YWQayWU/RCrcQiUbxzDF0O
   RsFxPpO98NKFogZRB07+5PNztoSflK9XD3C3fcFELl2TJSsrcHxwaVbAh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10973"; a="555412"
X-IronPort-AV: E=Sophos;i="6.05,240,1701158400"; 
   d="scan'208";a="555412"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2024 07:05:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,240,1701158400"; 
   d="scan'208";a="23607843"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 03 Feb 2024 07:05:51 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rWHaV-0005DG-10;
	Sat, 03 Feb 2024 15:05:48 +0000
Date: Sat, 3 Feb 2024 23:04:49 +0800
From: kernel test robot <lkp@intel.com>
To: Fiona Klute <fiona.klute@gmx.de>, linux-wireless@vger.kernel.org,
	Ping-Ke Shih <pkshih@realtek.com>
Cc: oe-kbuild-all@lists.linux.dev, Kalle Valo <kvalo@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
	Pavel Machek <pavel@ucw.cz>,
	=?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>,
	Fiona Klute <fiona.klute@gmx.de>
Subject: Re: [PATCH 1/9] wifi: rtw88: Shared module for rtw8723x devices
Message-ID: <202402032249.cMZd6DxM-lkp@intel.com>
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
config: parisc-allmodconfig (https://download.01.org/0day-ci/archive/20240203/202402032249.cMZd6DxM-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240203/202402032249.cMZd6DxM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402032249.cMZd6DxM-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/wireless/realtek/rtw88/rtw8723x.c:156:6: warning: no previous prototype for '__rtw8723x_cfg_ldo25' [-Wmissing-prototypes]
     156 | void __rtw8723x_cfg_ldo25(struct rtw_dev *rtwdev, bool enable)
         |      ^~~~~~~~~~~~~~~~~~~~


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

