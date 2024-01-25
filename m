Return-Path: <linux-wireless+bounces-2470-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1038883C044
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jan 2024 12:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 354281C20DFC
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jan 2024 11:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D852C1B5;
	Thu, 25 Jan 2024 10:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RTKryJxJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23C732C90
	for <linux-wireless@vger.kernel.org>; Thu, 25 Jan 2024 10:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706180078; cv=none; b=gxgIFIgwGPhR1jy/uuKfI2recx6fuOUzd3XWUYGMP766q8ACE6Sw64AYgF1mmCPQQieufzRWVliUu74NRyPBW/DjV5aZJjp662LY+h0KS+Q3OUSNetTNQv5PDpp/vOHnrzUVuBUW9yt72pSjvRJkUVyqdrqJjrwE0jOxm71nO44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706180078; c=relaxed/simple;
	bh=Xo3qgh8sk2I5NsQguf5eohkyqUDthbYbrLJ4A5f6tDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CXkuj8VyvAMG37XfoMzxw+fnJT3TtZmTPJgZjKJ7ENG0LLyp2drBAub3vsGyhdjZA1KHA+NDzU5ghd8ZVmd8+kQBFFpr8Z9/bO/ADlHSxEsngs+p+rQlASkf7LcJcZz9+TiuPAbqafjmBVTk4bbrInTPTRIEpu3tfhuLGxQ+6bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RTKryJxJ; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706180076; x=1737716076;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Xo3qgh8sk2I5NsQguf5eohkyqUDthbYbrLJ4A5f6tDg=;
  b=RTKryJxJZsQLKpVxhUBFcivFsAOCZZhmSg4LQhNHQGVWHOBZdknbKS3b
   FqiclXZnkCt9IZDb8sONIbs/BMKaFesKtgQPbHyJ/GU5fdzU2pXQkJ98T
   5SEG1nEeEJHpVz1D2SpomiRx+KVYrrQF5IE4peuDJ4e1AxlRDxZqsS3Vq
   t9K9wihlaVOaWSCSrCe3b4uUMDAhgmpEFhhU8uFKm3XsBcH24BVtGce1g
   7c/WHflG1efmL+3ilyWC4nNkRqDQcly7JP+RGEQGfFSoJKgv9pQbQ84Y9
   wZiCG9jCzYFvVf5ZvMfcJhEl7Wun2Fpe08R28nvXiNrQSKgot8wkkFw+d
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="9506766"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="9506766"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 02:54:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="21025762"
Received: from lkp-server01.sh.intel.com (HELO 961aaaa5b03c) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 25 Jan 2024 02:54:33 -0800
Received: from kbuild by 961aaaa5b03c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rSxNO-0008uz-2B;
	Thu, 25 Jan 2024 10:54:30 +0000
Date: Thu, 25 Jan 2024 18:54:01 +0800
From: kernel test robot <lkp@intel.com>
To: Aditya Kumar Singh <quic_adisi@quicinc.com>, johannes@sipsolutions.net
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-wireless@vger.kernel.org,
	Aditya Kumar Singh <quic_adisi@quicinc.com>
Subject: Re: [PATCH v4 2/3] wifi: mac80211: add support for AP channel switch
 with MLO
Message-ID: <202401251832.Nz3Re4bq-lkp@intel.com>
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
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20240125/202401251832.Nz3Re4bq-lkp@intel.com/config)
compiler: clang version 18.0.0git (https://github.com/llvm/llvm-project a31a60074717fc40887cfe132b77eec93bedd307)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240125/202401251832.Nz3Re4bq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401251832.Nz3Re4bq-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c:24:
   In file included from include/linux/usb.h:16:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:337:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     547 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     560 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c:24:
   In file included from include/linux/usb.h:16:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:337:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c:24:
   In file included from include/linux/usb.h:16:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:337:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     584 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     594 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     604 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
>> drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c:5740:28: error: too few arguments to function call, expected 2, have 1
    5740 |                         ieee80211_csa_finish(vif);
         |                         ~~~~~~~~~~~~~~~~~~~~    ^
   include/net/mac80211.h:5491:6: note: 'ieee80211_csa_finish' declared here
    5491 | void ieee80211_csa_finish(struct ieee80211_vif *vif, unsigned int link_id);
         |      ^                    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   6 warnings and 1 error generated.
--
   In file included from drivers/net/wireless/marvell/mwifiex/cfg80211.c:8:
   In file included from drivers/net/wireless/marvell/mwifiex/cfg80211.h:11:
   In file included from include/net/cfg80211.h:13:
   In file included from include/linux/ethtool.h:18:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:337:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     547 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     560 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from drivers/net/wireless/marvell/mwifiex/cfg80211.c:8:
   In file included from drivers/net/wireless/marvell/mwifiex/cfg80211.h:11:
   In file included from include/net/cfg80211.h:13:
   In file included from include/linux/ethtool.h:18:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:337:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from drivers/net/wireless/marvell/mwifiex/cfg80211.c:8:
   In file included from drivers/net/wireless/marvell/mwifiex/cfg80211.h:11:
   In file included from include/net/cfg80211.h:13:
   In file included from include/linux/ethtool.h:18:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:337:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     584 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     594 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     604 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
>> drivers/net/wireless/marvell/mwifiex/cfg80211.c:4260:20: error: incompatible function pointer types initializing 'int (*)(struct wiphy *, struct net_device *, struct cfg80211_csa_settings *)' with an expression of type 'int (struct wiphy *, struct net_device *, struct cfg80211_csa_settings *, unsigned int)' [-Wincompatible-function-pointer-types]
    4260 |         .channel_switch = mwifiex_cfg80211_channel_switch,
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   6 warnings and 1 error generated.


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

