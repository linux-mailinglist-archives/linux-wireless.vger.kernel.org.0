Return-Path: <linux-wireless+bounces-2488-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD01083C3F9
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jan 2024 14:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1CA31C247D3
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jan 2024 13:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BE45787E;
	Thu, 25 Jan 2024 13:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SrYilLh/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFC956B72
	for <linux-wireless@vger.kernel.org>; Thu, 25 Jan 2024 13:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706190295; cv=none; b=XCKsWESWWLQEWx9BBee0Zzdqp9DhD1I8M+sP+OQc5vp9bv4ZlO8cnS5WPTZWFfJNsnyuwTh91KQRnVYmpKI5i7xGVApkyTjzITSQR3Z6+y1AYXOYdi5wSZvPxCDFZLppEJkVH/kRGENebuxypqlAPovuI7mOYbtfsW8TgyBUfbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706190295; c=relaxed/simple;
	bh=1IH/66F2o5ZOle40wUE+C0tzRP4hiUvga1BAI9N3Phw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=om62e75f1G/g7nYrF0I3t7uGiGZeUpe7bIdEGOt5ZxthNJRhyojPdda97/LpkR+KbJaRePM8AwJ0IJH3CDBxhbaeg3Xm4jHoF3C5r5/K4msJvM4oMUOfNHGb8hQ2Jt1n1H7q3WIaCdDaukKiggVv7JifDmsdqz/YjyA6b2Y0mLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SrYilLh/; arc=none smtp.client-ip=192.55.52.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706190292; x=1737726292;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1IH/66F2o5ZOle40wUE+C0tzRP4hiUvga1BAI9N3Phw=;
  b=SrYilLh/UphHThOp4hxv2EysMGxBlgxBlL0K/hK379QMGMTHt5P9LJ27
   tKwhmoifUP21sGMTec5oTKnBiT5Q9xM0Fo7aprAhU/Q0Ht+iACsjKP0MC
   hLpH0o/vI+f2V1+9cZoF90pp88m0achgxUjQOkL0igNavoDi7y2sEkvnW
   MIWVlWcHtBXYzzowyu0XRcvUDAicr2F78ZQOQoT61M8Bvml+P0nhqI3Sc
   R+HxB/zwtcl8iZEN8wGSAwhQHOYeuVb2kBqvrSqJkgCmIkPi/6jxpdTRz
   9u8Fisa/GXsB251XYu3Yxc6Rar7PiDwBa5L0DQnTHDGHchA0jnkulSYFW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="401014829"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="401014829"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 05:44:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2249625"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 25 Jan 2024 05:44:50 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rT02C-00001f-0d;
	Thu, 25 Jan 2024 13:44:48 +0000
Date: Thu, 25 Jan 2024 21:44:47 +0800
From: kernel test robot <lkp@intel.com>
To: Aditya Kumar Singh <quic_adisi@quicinc.com>, johannes@sipsolutions.net
Cc: oe-kbuild-all@lists.linux.dev, linux-wireless@vger.kernel.org,
	Aditya Kumar Singh <quic_adisi@quicinc.com>
Subject: Re: [PATCH v4 2/3] wifi: mac80211: add support for AP channel switch
 with MLO
Message-ID: <202401252118.VhbB1Yqf-lkp@intel.com>
References: <20240125055039.826200-3-quic_adisi@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125055039.826200-3-quic_adisi@quicinc.com>

Hi Aditya,

kernel test robot noticed the following build errors:

[auto build test ERROR on acf868ff60b1cd1f2e597f0b15aee2ff43f9fcd3]

url:    https://github.com/intel-lab-lkp/linux/commits/Aditya-Kumar-Singh/wifi-cfg80211-send-link-id-in-channel_switch-ops/20240125-135353
base:   acf868ff60b1cd1f2e597f0b15aee2ff43f9fcd3
patch link:    https://lore.kernel.org/r/20240125055039.826200-3-quic_adisi%40quicinc.com
patch subject: [PATCH v4 2/3] wifi: mac80211: add support for AP channel switch with MLO
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20240125/202401252118.VhbB1Yqf-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240125/202401252118.VhbB1Yqf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401252118.VhbB1Yqf-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/wireless/marvell/mwifiex/cfg80211.c:4260:27: error: initialization of 'int (*)(struct wiphy *, struct net_device *, struct cfg80211_csa_settings *)' from incompatible pointer type 'int (*)(struct wiphy *, struct net_device *, struct cfg80211_csa_settings *, unsigned int)' [-Werror=incompatible-pointer-types]
    4260 |         .channel_switch = mwifiex_cfg80211_channel_switch,
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/wireless/marvell/mwifiex/cfg80211.c:4260:27: note: (near initialization for 'mwifiex_cfg80211_ops.channel_switch')
   cc1: some warnings being treated as errors
--
   drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c: In function 'rtl8xxxu_update_beacon_work_callback':
>> drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c:5740:25: error: too few arguments to function 'ieee80211_csa_finish'
    5740 |                         ieee80211_csa_finish(vif);
         |                         ^~~~~~~~~~~~~~~~~~~~
   In file included from drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c:31:
   include/net/mac80211.h:5491:6: note: declared here
    5491 | void ieee80211_csa_finish(struct ieee80211_vif *vif, unsigned int link_id);
         |      ^~~~~~~~~~~~~~~~~~~~


vim +4260 drivers/net/wireless/marvell/mwifiex/cfg80211.c

1f4dfd8a1e911c drivers/net/wireless/mwifiex/cfg80211.c         Avinash Patil            2014-02-07  4207  
5e6e3a92b9a4c9 drivers/net/wireless/mwifiex/cfg80211.c         Bing Zhao                2011-03-21  4208  /* station cfg80211 operations */
5e6e3a92b9a4c9 drivers/net/wireless/mwifiex/cfg80211.c         Bing Zhao                2011-03-21  4209  static struct cfg80211_ops mwifiex_cfg80211_ops = {
93a1df48d22429 drivers/net/wireless/mwifiex/cfg80211.c         Yogesh Ashok Powar       2011-09-26  4210  	.add_virtual_intf = mwifiex_add_virtual_intf,
93a1df48d22429 drivers/net/wireless/mwifiex/cfg80211.c         Yogesh Ashok Powar       2011-09-26  4211  	.del_virtual_intf = mwifiex_del_virtual_intf,
5e6e3a92b9a4c9 drivers/net/wireless/mwifiex/cfg80211.c         Bing Zhao                2011-03-21  4212  	.change_virtual_intf = mwifiex_cfg80211_change_virtual_intf,
5e6e3a92b9a4c9 drivers/net/wireless/mwifiex/cfg80211.c         Bing Zhao                2011-03-21  4213  	.scan = mwifiex_cfg80211_scan,
5e6e3a92b9a4c9 drivers/net/wireless/mwifiex/cfg80211.c         Bing Zhao                2011-03-21  4214  	.connect = mwifiex_cfg80211_connect,
5e6e3a92b9a4c9 drivers/net/wireless/mwifiex/cfg80211.c         Bing Zhao                2011-03-21  4215  	.disconnect = mwifiex_cfg80211_disconnect,
5e6e3a92b9a4c9 drivers/net/wireless/mwifiex/cfg80211.c         Bing Zhao                2011-03-21  4216  	.get_station = mwifiex_cfg80211_get_station,
f85aae6bec6707 drivers/net/wireless/mwifiex/cfg80211.c         Amitkumar Karwar         2012-03-15  4217  	.dump_station = mwifiex_cfg80211_dump_station,
6bc6c49f1e2f3a drivers/net/wireless/mwifiex/cfg80211.c         Xinming Hu               2014-10-31  4218  	.dump_survey = mwifiex_cfg80211_dump_survey,
5e6e3a92b9a4c9 drivers/net/wireless/mwifiex/cfg80211.c         Bing Zhao                2011-03-21  4219  	.set_wiphy_params = mwifiex_cfg80211_set_wiphy_params,
5e6e3a92b9a4c9 drivers/net/wireless/mwifiex/cfg80211.c         Bing Zhao                2011-03-21  4220  	.join_ibss = mwifiex_cfg80211_join_ibss,
5e6e3a92b9a4c9 drivers/net/wireless/mwifiex/cfg80211.c         Bing Zhao                2011-03-21  4221  	.leave_ibss = mwifiex_cfg80211_leave_ibss,
5e6e3a92b9a4c9 drivers/net/wireless/mwifiex/cfg80211.c         Bing Zhao                2011-03-21  4222  	.add_key = mwifiex_cfg80211_add_key,
5e6e3a92b9a4c9 drivers/net/wireless/mwifiex/cfg80211.c         Bing Zhao                2011-03-21  4223  	.del_key = mwifiex_cfg80211_del_key,
89951db2be5310 drivers/net/wireless/marvell/mwifiex/cfg80211.c Ganapathi Bhat           2016-09-20  4224  	.set_default_mgmt_key = mwifiex_cfg80211_set_default_mgmt_key,
e39faa73ef14f6 drivers/net/wireless/mwifiex/cfg80211.c         Stone Piao               2012-09-25  4225  	.mgmt_tx = mwifiex_cfg80211_mgmt_tx,
6cd536fe62ef58 drivers/net/wireless/marvell/mwifiex/cfg80211.c Johannes Berg            2020-04-17  4226  	.update_mgmt_frame_registrations =
6cd536fe62ef58 drivers/net/wireless/marvell/mwifiex/cfg80211.c Johannes Berg            2020-04-17  4227  		mwifiex_cfg80211_update_mgmt_frame_registrations,
7feb4c48313d58 drivers/net/wireless/mwifiex/cfg80211.c         Stone Piao               2012-09-25  4228  	.remain_on_channel = mwifiex_cfg80211_remain_on_channel,
7feb4c48313d58 drivers/net/wireless/mwifiex/cfg80211.c         Stone Piao               2012-09-25  4229  	.cancel_remain_on_channel = mwifiex_cfg80211_cancel_remain_on_channel,
5e6e3a92b9a4c9 drivers/net/wireless/mwifiex/cfg80211.c         Bing Zhao                2011-03-21  4230  	.set_default_key = mwifiex_cfg80211_set_default_key,
5e6e3a92b9a4c9 drivers/net/wireless/mwifiex/cfg80211.c         Bing Zhao                2011-03-21  4231  	.set_power_mgmt = mwifiex_cfg80211_set_power_mgmt,
5e6e3a92b9a4c9 drivers/net/wireless/mwifiex/cfg80211.c         Bing Zhao                2011-03-21  4232  	.set_tx_power = mwifiex_cfg80211_set_tx_power,
7d54bacadce17f drivers/net/wireless/marvell/mwifiex/cfg80211.c Javier Martinez Canillas 2016-06-06  4233  	.get_tx_power = mwifiex_cfg80211_get_tx_power,
5d82c53a380ca9 drivers/net/wireless/mwifiex/cfg80211.c         Yogesh Ashok Powar       2011-07-11  4234  	.set_bitrate_mask = mwifiex_cfg80211_set_bitrate_mask,
12190c5d80bd3c drivers/net/wireless/mwifiex/cfg80211.c         Avinash Patil            2012-05-08  4235  	.start_ap = mwifiex_cfg80211_start_ap,
12190c5d80bd3c drivers/net/wireless/mwifiex/cfg80211.c         Avinash Patil            2012-05-08  4236  	.stop_ap = mwifiex_cfg80211_stop_ap,
5370c83684d9e7 drivers/net/wireless/mwifiex/cfg80211.c         Avinash Patil            2012-06-28  4237  	.change_beacon = mwifiex_cfg80211_change_beacon,
fa444bf88ce2ba drivers/net/wireless/mwifiex/cfg80211.c         Amitkumar Karwar         2012-03-15  4238  	.set_cqm_rssi_config = mwifiex_cfg80211_set_cqm_rssi_config,
8a279d5b4dc128 drivers/net/wireless/mwifiex/cfg80211.c         Amitkumar Karwar         2012-07-02  4239  	.set_antenna = mwifiex_cfg80211_set_antenna,
3ee712857958c2 drivers/net/wireless/marvell/mwifiex/cfg80211.c Shengzhen Li             2016-06-06  4240  	.get_antenna = mwifiex_cfg80211_get_antenna,
0f9e9b8ba72bc7 drivers/net/wireless/mwifiex/cfg80211.c         Avinash Patil            2013-05-17  4241  	.del_station = mwifiex_cfg80211_del_station,
0c9b7f22e8e1f3 drivers/net/wireless/marvell/mwifiex/cfg80211.c Xinming Hu               2016-01-13  4242  	.sched_scan_start = mwifiex_cfg80211_sched_scan_start,
0c9b7f22e8e1f3 drivers/net/wireless/marvell/mwifiex/cfg80211.c Xinming Hu               2016-01-13  4243  	.sched_scan_stop = mwifiex_cfg80211_sched_scan_stop,
7da060c1c01b10 drivers/net/wireless/mwifiex/cfg80211.c         Amitkumar Karwar         2013-03-04  4244  #ifdef CONFIG_PM
7da060c1c01b10 drivers/net/wireless/mwifiex/cfg80211.c         Amitkumar Karwar         2013-03-04  4245  	.suspend = mwifiex_cfg80211_suspend,
7da060c1c01b10 drivers/net/wireless/mwifiex/cfg80211.c         Amitkumar Karwar         2013-03-04  4246  	.resume = mwifiex_cfg80211_resume,
7da060c1c01b10 drivers/net/wireless/mwifiex/cfg80211.c         Amitkumar Karwar         2013-03-04  4247  	.set_wakeup = mwifiex_cfg80211_set_wakeup,
f6b1cbe029f682 drivers/net/wireless/marvell/mwifiex/cfg80211.c Ganapathi Bhat           2016-04-05  4248  	.set_rekey_data = mwifiex_set_rekey_data,
7da060c1c01b10 drivers/net/wireless/mwifiex/cfg80211.c         Amitkumar Karwar         2013-03-04  4249  #endif
d1e2586f484dfc drivers/net/wireless/mwifiex/cfg80211.c         Bing Zhao                2013-08-09  4250  	.set_coalesce = mwifiex_cfg80211_set_coalesce,
b23bce29656801 drivers/net/wireless/mwifiex/cfg80211.c         Avinash Patil            2014-02-07  4251  	.tdls_mgmt = mwifiex_cfg80211_tdls_mgmt,
429d90d2212b56 drivers/net/wireless/mwifiex/cfg80211.c         Avinash Patil            2014-02-07  4252  	.tdls_oper = mwifiex_cfg80211_tdls_oper,
b04975970676d7 drivers/net/wireless/mwifiex/cfg80211.c         Xinming Hu               2015-06-22  4253  	.tdls_channel_switch = mwifiex_cfg80211_tdls_chan_switch,
b04975970676d7 drivers/net/wireless/mwifiex/cfg80211.c         Xinming Hu               2015-06-22  4254  	.tdls_cancel_channel_switch = mwifiex_cfg80211_tdls_cancel_chan_switch,
e48e0de0053f07 drivers/net/wireless/mwifiex/cfg80211.c         Avinash Patil            2014-02-07  4255  	.add_station = mwifiex_cfg80211_add_station,
1f4dfd8a1e911c drivers/net/wireless/mwifiex/cfg80211.c         Avinash Patil            2014-02-07  4256  	.change_station = mwifiex_cfg80211_change_station,
3935ccc14d2c68 drivers/net/wireless/marvell/mwifiex/cfg80211.c Xinming Hu               2016-09-02  4257  	CFG80211_TESTMODE_CMD(mwifiex_tm_cmd)
7ee38bf4edeac8 drivers/net/wireless/mwifiex/cfg80211.c         Xinming Hu               2015-06-03  4258  	.get_channel = mwifiex_cfg80211_get_channel,
85afb18621be39 drivers/net/wireless/mwifiex/cfg80211.c         Avinash Patil            2015-01-28  4259  	.start_radar_detection = mwifiex_cfg80211_start_radar_detection,
7d652034d1a08b drivers/net/wireless/mwifiex/cfg80211.c         Avinash Patil            2015-01-28 @4260  	.channel_switch = mwifiex_cfg80211_channel_switch,
5e6e3a92b9a4c9 drivers/net/wireless/mwifiex/cfg80211.c         Bing Zhao                2011-03-21  4261  };
5e6e3a92b9a4c9 drivers/net/wireless/mwifiex/cfg80211.c         Bing Zhao                2011-03-21  4262  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

