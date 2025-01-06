Return-Path: <linux-wireless+bounces-17095-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D01A01DBA
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jan 2025 03:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 944EE160A04
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jan 2025 02:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B347FC0A;
	Mon,  6 Jan 2025 02:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h1nM/h55"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E1623B0
	for <linux-wireless@vger.kernel.org>; Mon,  6 Jan 2025 02:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736131114; cv=none; b=K2TpisyqprNuo98Q8NVSCBzVp3gqumZju+mCXevf07prVtUqgVKibHpKJpGBX17qB1gOJpcYY+OCl0guL2b4B8B0Pqze0HLRpETETcqRJJBlKUWACw2z2Z3v9iSEhiVnZzIxUXiePV5e0gN/nBW/dvm6dpIGFo/x1/ZjkQGBOQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736131114; c=relaxed/simple;
	bh=8kHWQIURExq8rie5aqd2YfCUFNM4Txf6KUHGGPLsLBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RN7Mbzup0y8PdQ5jPnUsnoyQrNhh9PHlu/o1AtDmhty091fq09VPF+eC0iK32FpjN6sSqHDg6OzeCmGb0UYgpw4UE/Va+6C3TM89ZF/rAiUNQUUHXD0BHlqNAG4no9BeApzDStj1OnTqmx0SrcwXE93idA1JbSoeCweN36sExoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h1nM/h55; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736131112; x=1767667112;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8kHWQIURExq8rie5aqd2YfCUFNM4Txf6KUHGGPLsLBA=;
  b=h1nM/h5542MlmiVnPrVcWCnSgUH2Z18V+erR2GE5ClTrxSd3U8TuScK4
   K002sBKn4JiDxVJVfHcs3S+8smVq73CIEMMPJ7JHb2zXZ3yUzMTs1Wkuv
   NSPzjOTixdlxT1ZnPYQ2PU5iulVU+sDNf+jRZY3K9dOdrFOBdWRluRwk5
   /lH5PEj7ThXfCUa18DrKI3eiSoQ57BepoBKoy24NQY9UIcCia5Ass0keF
   +ut3SrOc8RerEVFyv4bwjsbV+oGsopqYncEQsruHTeGoTf+dHZQj9TeoN
   KI4uvYZBc0x5pMN01nRdGWt6GuzSrqnqdGl2pGUC/FIQVtRTrRF/6Qx+n
   g==;
X-CSE-ConnectionGUID: HZO5y0cuT1S1ZCgxVLa67Q==
X-CSE-MsgGUID: U0sjSZgFTQqJ5rQtUC3shg==
X-IronPort-AV: E=McAfee;i="6700,10204,11306"; a="36151395"
X-IronPort-AV: E=Sophos;i="6.12,292,1728975600"; 
   d="scan'208";a="36151395"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2025 18:38:32 -0800
X-CSE-ConnectionGUID: h59wmlqWRjeT3213WkIRMA==
X-CSE-MsgGUID: 7mmpbYBGSzOjWbpgZJhMig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="102820252"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 05 Jan 2025 18:38:32 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tUd0e-000CB9-2j;
	Mon, 06 Jan 2025 02:38:28 +0000
Date: Mon, 6 Jan 2025 10:37:59 +0800
From: kernel test robot <lkp@intel.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Ping-Ke Shih <pkshih@realtek.com>
Subject: Re: [PATCH v2] wifi: rtw88: Add support for LED blinking
Message-ID: <202501061046.U1iOSkRv-lkp@intel.com>
References: <57c7d192-97ee-4da1-87a8-f040e9b8e3d1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57c7d192-97ee-4da1-87a8-f040e9b8e3d1@gmail.com>

Hi Bitterblue,

kernel test robot noticed the following build errors:

[auto build test ERROR on wireless-next/main]
[also build test ERROR on wireless/main linus/master v6.13-rc6 next-20241220]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bitterblue-Smith/wifi-rtw88-Add-support-for-LED-blinking/20250106-030830
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/57c7d192-97ee-4da1-87a8-f040e9b8e3d1%40gmail.com
patch subject: [PATCH v2] wifi: rtw88: Add support for LED blinking
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20250106/202501061046.U1iOSkRv-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250106/202501061046.U1iOSkRv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501061046.U1iOSkRv-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

>> drivers/net/wireless/realtek/rtw88/led.c:19:6: error: redefinition of 'rtw_led_init'
      19 | void rtw_led_init(struct rtw_dev *rtwdev)
         |      ^~~~~~~~~~~~
   In file included from drivers/net/wireless/realtek/rtw88/led.c:7:
   drivers/net/wireless/realtek/rtw88/led.h:15:13: note: previous definition of 'rtw_led_init' with type 'void(struct rtw_dev *)'
      15 | static void rtw_led_init(struct rtw_dev *rtwdev)
         |             ^~~~~~~~~~~~
>> drivers/net/wireless/realtek/rtw88/led.c:64:6: error: redefinition of 'rtw_led_deinit'
      64 | void rtw_led_deinit(struct rtw_dev *rtwdev)
         |      ^~~~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/led.h:19:13: note: previous definition of 'rtw_led_deinit' with type 'void(struct rtw_dev *)'
      19 | static void rtw_led_deinit(struct rtw_dev *rtwdev)
         |             ^~~~~~~~~~~~~~
>> drivers/net/wireless/realtek/rtw88/led.h:19:13: warning: 'rtw_led_deinit' defined but not used [-Wunused-function]
>> drivers/net/wireless/realtek/rtw88/led.h:15:13: warning: 'rtw_led_init' defined but not used [-Wunused-function]
      15 | static void rtw_led_init(struct rtw_dev *rtwdev)
         |             ^~~~~~~~~~~~


vim +/rtw_led_init +19 drivers/net/wireless/realtek/rtw88/led.c

    18	
  > 19	void rtw_led_init(struct rtw_dev *rtwdev)
    20	{
    21		static const struct ieee80211_tpt_blink rtw_tpt_blink[] = {
    22			{ .throughput = 0 * 1024, .blink_time = 334 },
    23			{ .throughput = 1 * 1024, .blink_time = 260 },
    24			{ .throughput = 5 * 1024, .blink_time = 220 },
    25			{ .throughput = 10 * 1024, .blink_time = 190 },
    26			{ .throughput = 20 * 1024, .blink_time = 170 },
    27			{ .throughput = 50 * 1024, .blink_time = 150 },
    28			{ .throughput = 70 * 1024, .blink_time = 130 },
    29			{ .throughput = 100 * 1024, .blink_time = 110 },
    30			{ .throughput = 200 * 1024, .blink_time = 80 },
    31			{ .throughput = 300 * 1024, .blink_time = 50 },
    32		};
    33		struct led_classdev *led = &rtwdev->led_cdev;
    34		int err;
    35	
    36		if (!rtwdev->chip->ops->led_set)
    37			return;
    38	
    39		if (rtw_hci_type(rtwdev) == RTW_HCI_TYPE_USB)
    40			led->brightness_set_blocking = rtw_led_set_blocking;
    41		else
    42			led->brightness_set = rtwdev->chip->ops->led_set;
    43	
    44		snprintf(rtwdev->led_name, sizeof(rtwdev->led_name),
    45			 "rtw88-%s", dev_name(rtwdev->dev));
    46	
    47		led->name = rtwdev->led_name;
    48		led->max_brightness = LED_ON;
    49		led->default_trigger =
    50			ieee80211_create_tpt_led_trigger(rtwdev->hw,
    51							 IEEE80211_TPT_LEDTRIG_FL_RADIO,
    52							 rtw_tpt_blink,
    53							 ARRAY_SIZE(rtw_tpt_blink));
    54	
    55		err = led_classdev_register(rtwdev->dev, led);
    56		if (err) {
    57			rtw_warn(rtwdev, "Failed to register the LED, error %d\n", err);
    58			return;
    59		}
    60	
    61		rtwdev->led_registered = true;
    62	}
    63	
  > 64	void rtw_led_deinit(struct rtw_dev *rtwdev)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

