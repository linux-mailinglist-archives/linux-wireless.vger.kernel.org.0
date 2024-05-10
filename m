Return-Path: <linux-wireless+bounces-7426-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 969E88C1DD0
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 07:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 022D31F21BA3
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 05:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D57D152790;
	Fri, 10 May 2024 05:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bnxDnORN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF213308A
	for <linux-wireless@vger.kernel.org>; Fri, 10 May 2024 05:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715320014; cv=none; b=RdcQW4hTWItnvj4gmw9trX+PKtYMgvTTuWqLG5wp3BcFM9VlimeTiP2C+GYr7NMC8Xbr6RxvoxJbelXftlG6G03QbWLI5l8dcO5/wpsahwNbX+tx6m5tl3eg7A2X9v42/50cN2EC0fDA8RF08ngaqiiQByBIz7jMQBR2TxNXzU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715320014; c=relaxed/simple;
	bh=rcPaPnKk+iFn9AnHFer/KKOc36I6qxypoUmBLcXj73g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sGukRxRXgpk7hiKPKygqjGftXipWWrUUsLFbe54BmQW5++DkUUNVAqajyhOOEJkKhhZDZ6hHnVQXGjT5t12I73RmGTAciocBS9HuGTnCKqJHjpPEW/I8h1U4m9REcBszn2GS5c7IDB9Lz05e7zQVOT6LdliyK14mPg3V6o61RMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bnxDnORN; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715320010; x=1746856010;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rcPaPnKk+iFn9AnHFer/KKOc36I6qxypoUmBLcXj73g=;
  b=bnxDnORN4U4xOG8sJ1sG7mI07E2muqKOmbqZ9wBsBhpJUQs4E0yp4I7w
   Q962J0sJwcu9LAmRlVIH729LlRYjjDcT8PTIUldewaaYH2EzFnyBJ+i1a
   DBoxocNkpC34JjCEXjfGVdl4NgOIDz42HkOnvpOfLjx1PADULQV9G8drv
   S3RjNmGMZ1GG4Ucz/y2qaahOaLzbgySO5j8wlcFGr5LXZQMQMdWBi3KnB
   QjfEDASq00T1i4rqes7Z822UPLXPczfmFA0MpIaRz7909I9ArwhegQMSf
   aIzazcea2qJzyHOJ6fZjWDWptPxFyl67YZOYxf2/Ks2+tUahNJ/dIstoK
   Q==;
X-CSE-ConnectionGUID: dhXkkmZJRDeRLWNl7XF+/Q==
X-CSE-MsgGUID: Q7wD7y04RCmKCHDZ83i5rg==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="22680664"
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="22680664"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2024 22:46:50 -0700
X-CSE-ConnectionGUID: tqNUfs8FRMedccdK213YrA==
X-CSE-MsgGUID: MgS7hzvdRU6FJvFuUKLZJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="60350491"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 09 May 2024 22:46:48 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s5J5h-0005mb-2G;
	Fri, 10 May 2024 05:46:45 +0000
Date: Fri, 10 May 2024 13:46:02 +0800
From: kernel test robot <lkp@intel.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Ping-Ke Shih <pkshih@realtek.com>,
	Larry Finger <Larry.Finger@lwfinger.net>,
	Stefan Lippers-Hollmann <s.l-h@gmx.de>,
	Christian Hewitt <chewitt@libreelec.tv>
Subject: Re: [PATCH v5 11/11] wifi: rtlwifi: Enable the new rtl8192du driver
Message-ID: <202405101334.ODz4AccN-lkp@intel.com>
References: <0fb5c4d9-d43c-4aa2-b483-c0104995fa9e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0fb5c4d9-d43c-4aa2-b483-c0104995fa9e@gmail.com>

Hi Bitterblue,

kernel test robot noticed the following build errors:

[auto build test ERROR on wireless-next/main]
[also build test ERROR on next-20240509]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bitterblue-Smith/wifi-rtlwifi-Add-rtl8192du-table-c-h/20240508-185621
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/0fb5c4d9-d43c-4aa2-b483-c0104995fa9e%40gmail.com
patch subject: [PATCH v5 11/11] wifi: rtlwifi: Enable the new rtl8192du driver
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20240510/202405101334.ODz4AccN-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240510/202405101334.ODz4AccN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405101334.ODz4AccN-lkp@intel.com/

All errors (new ones prefixed by >>):

   mips-linux-ld: drivers/net/wireless/realtek/rtlwifi/rtl8192du/fw.o: in function `rtl92d_download_fw':
>> fw.c:(.text.rtl92d_download_fw+0x0): multiple definition of `rtl92d_download_fw'; drivers/net/wireless/realtek/rtlwifi/rtl8192de/fw.o:fw.c:(.text.rtl92d_download_fw+0x0): first defined here
   mips-linux-ld: drivers/net/wireless/realtek/rtlwifi/rtl8192du/hw.o: in function `rtl92de_set_check_bssid':
>> hw.c:(.text.rtl92de_set_check_bssid+0x0): multiple definition of `rtl92de_set_check_bssid'; drivers/net/wireless/realtek/rtlwifi/rtl8192de/hw.o:hw.c:(.text.rtl92de_set_check_bssid+0x0): first defined here
   mips-linux-ld: drivers/net/wireless/realtek/rtlwifi/rtl8192du/hw.o: in function `rtl92de_set_network_type':
>> hw.c:(.text.rtl92de_set_network_type+0x0): multiple definition of `rtl92de_set_network_type'; drivers/net/wireless/realtek/rtlwifi/rtl8192de/hw.o:hw.c:(.text.rtl92de_set_network_type+0x0): first defined here
   mips-linux-ld: drivers/net/wireless/realtek/rtlwifi/rtl8192du/hw.o: in function `rtl92d_linked_set_reg':
>> hw.c:(.text.rtl92d_linked_set_reg+0x0): multiple definition of `rtl92d_linked_set_reg'; drivers/net/wireless/realtek/rtlwifi/rtl8192de/hw.o:hw.c:(.text.rtl92d_linked_set_reg+0x0): first defined here
   mips-linux-ld: drivers/net/wireless/realtek/rtlwifi/rtl8192du/hw.o: in function `rtl92de_enable_interrupt':
>> hw.c:(.text.rtl92de_enable_interrupt+0x0): multiple definition of `rtl92de_enable_interrupt'; drivers/net/wireless/realtek/rtlwifi/rtl8192de/hw.o:hw.c:(.text.rtl92de_enable_interrupt+0x0): first defined here
   mips-linux-ld: drivers/net/wireless/realtek/rtlwifi/rtl8192du/hw.o: in function `rtl92de_disable_interrupt':
>> hw.c:(.text.rtl92de_disable_interrupt+0x0): multiple definition of `rtl92de_disable_interrupt'; drivers/net/wireless/realtek/rtlwifi/rtl8192de/hw.o:hw.c:(.text.rtl92de_disable_interrupt+0x0): first defined here
   mips-linux-ld: drivers/net/wireless/realtek/rtlwifi/rtl8192du/hw.o: in function `rtl92de_set_beacon_related_registers':
>> hw.c:(.text.rtl92de_set_beacon_related_registers+0x0): multiple definition of `rtl92de_set_beacon_related_registers'; drivers/net/wireless/realtek/rtlwifi/rtl8192de/hw.o:hw.c:(.text.rtl92de_set_beacon_related_registers+0x0): first defined here
   mips-linux-ld: drivers/net/wireless/realtek/rtlwifi/rtl8192du/hw.o: in function `rtl92de_set_beacon_interval':
>> hw.c:(.text.rtl92de_set_beacon_interval+0x0): multiple definition of `rtl92de_set_beacon_interval'; drivers/net/wireless/realtek/rtlwifi/rtl8192de/hw.o:hw.c:(.text.rtl92de_set_beacon_interval+0x0): first defined here
   mips-linux-ld: drivers/net/wireless/realtek/rtlwifi/rtl8192du/hw.o: in function `rtl92de_update_interrupt_mask':
>> hw.c:(.text.rtl92de_update_interrupt_mask+0x0): multiple definition of `rtl92de_update_interrupt_mask'; drivers/net/wireless/realtek/rtlwifi/rtl8192de/hw.o:hw.c:(.text.rtl92de_update_interrupt_mask+0x0): first defined here
   mips-linux-ld: drivers/net/wireless/realtek/rtlwifi/rtl8192du/led.o: in function `rtl92de_led_control':
>> led.c:(.text.rtl92de_led_control+0x0): multiple definition of `rtl92de_led_control'; drivers/net/wireless/realtek/rtlwifi/rtl8192de/led.o:led.c:(.text.rtl92de_led_control+0x0): first defined here
   mips-linux-ld: drivers/net/wireless/realtek/rtlwifi/rtl8192du/phy.o: in function `rtl92d_phy_query_bb_reg':
>> phy.c:(.text.rtl92d_phy_query_bb_reg+0x0): multiple definition of `rtl92d_phy_query_bb_reg'; drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.o:phy.c:(.text.rtl92d_phy_query_bb_reg+0x0): first defined here
   mips-linux-ld: drivers/net/wireless/realtek/rtlwifi/rtl8192du/phy.o: in function `rtl92d_phy_set_bb_reg':
>> phy.c:(.text.rtl92d_phy_set_bb_reg+0x0): multiple definition of `rtl92d_phy_set_bb_reg'; drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.o:phy.c:(.text.rtl92d_phy_set_bb_reg+0x0): first defined here
   mips-linux-ld: drivers/net/wireless/realtek/rtlwifi/rtl8192du/phy.o: in function `rtl92d_phy_mac_config':
>> phy.c:(.text.rtl92d_phy_mac_config+0x0): multiple definition of `rtl92d_phy_mac_config'; drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.o:phy.c:(.text.rtl92d_phy_mac_config+0x0): first defined here
   mips-linux-ld: drivers/net/wireless/realtek/rtlwifi/rtl8192du/phy.o: in function `rtl92d_phy_bb_config':
>> phy.c:(.text.rtl92d_phy_bb_config+0x0): multiple definition of `rtl92d_phy_bb_config'; drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.o:phy.c:(.text.rtl92d_phy_bb_config+0x0): first defined here
   mips-linux-ld: drivers/net/wireless/realtek/rtlwifi/rtl8192du/phy.o: in function `rtl92d_phy_rf_config':
>> phy.c:(.text.rtl92d_phy_rf_config+0x0): multiple definition of `rtl92d_phy_rf_config'; drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.o:phy.c:(.text.rtl92d_phy_rf_config+0x0): first defined here
   mips-linux-ld: drivers/net/wireless/realtek/rtlwifi/rtl8192du/phy.o: in function `rtl92d_phy_config_rf_with_headerfile':
>> phy.c:(.text.rtl92d_phy_config_rf_with_headerfile+0x0): multiple definition of `rtl92d_phy_config_rf_with_headerfile'; drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.o:phy.c:(.text.rtl92d_phy_config_rf_with_headerfile+0x0): first defined here
   mips-linux-ld: drivers/net/wireless/realtek/rtlwifi/rtl8192du/phy.o: in function `rtl92d_phy_set_bw_mode':
>> phy.c:(.text.rtl92d_phy_set_bw_mode+0x0): multiple definition of `rtl92d_phy_set_bw_mode'; drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.o:phy.c:(.text.rtl92d_phy_set_bw_mode+0x0): first defined here
   mips-linux-ld: drivers/net/wireless/realtek/rtlwifi/rtl8192du/phy.o: in function `rtl92d_phy_iq_calibrate':
>> phy.c:(.text.rtl92d_phy_iq_calibrate+0x0): multiple definition of `rtl92d_phy_iq_calibrate'; drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.o:phy.c:(.text.rtl92d_phy_iq_calibrate+0x0): first defined here
   mips-linux-ld: drivers/net/wireless/realtek/rtlwifi/rtl8192du/phy.o: in function `rtl92d_phy_reload_iqk_setting':
>> phy.c:(.text.rtl92d_phy_reload_iqk_setting+0x0): multiple definition of `rtl92d_phy_reload_iqk_setting'; drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.o:phy.c:(.text.rtl92d_phy_reload_iqk_setting+0x0): first defined here
   mips-linux-ld: drivers/net/wireless/realtek/rtlwifi/rtl8192du/phy.o: in function `rtl92d_phy_lc_calibrate':
>> phy.c:(.text.rtl92d_phy_lc_calibrate+0x0): multiple definition of `rtl92d_phy_lc_calibrate'; drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.o:phy.c:(.text.rtl92d_phy_lc_calibrate+0x0): first defined here
   mips-linux-ld: drivers/net/wireless/realtek/rtlwifi/rtl8192du/phy.o: in function `rtl92d_phy_ap_calibrate':
   phy.c:(.text.rtl92d_phy_ap_calibrate+0x0): multiple definition of `rtl92d_phy_ap_calibrate'; drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.o:phy.c:(.text.rtl92d_phy_ap_calibrate+0x0): first defined here
   mips-linux-ld: drivers/net/wireless/realtek/rtlwifi/rtl8192du/phy.o: in function `rtl92d_phy_set_rf_power_state':
   phy.c:(.text.rtl92d_phy_set_rf_power_state+0x0): multiple definition of `rtl92d_phy_set_rf_power_state'; drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.o:phy.c:(.text.rtl92d_phy_set_rf_power_state+0x0): first defined here
   mips-linux-ld: drivers/net/wireless/realtek/rtlwifi/rtl8192du/phy.o: in function `rtl92d_phy_set_poweron':
   phy.c:(.text.rtl92d_phy_set_poweron+0x0): multiple definition of `rtl92d_phy_set_poweron'; drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.o:phy.c:(.text.rtl92d_phy_set_poweron+0x0): first defined here
   mips-linux-ld: drivers/net/wireless/realtek/rtlwifi/rtl8192du/phy.o: in function `rtl92d_update_bbrf_configuration':
   phy.c:(.text.rtl92d_update_bbrf_configuration+0x0): multiple definition of `rtl92d_update_bbrf_configuration'; drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.o:phy.c:(.text.rtl92d_update_bbrf_configuration+0x0): first defined here
   mips-linux-ld: drivers/net/wireless/realtek/rtlwifi/rtl8192du/phy.o: in function `rtl92d_phy_sw_chnl':
   phy.c:(.text.rtl92d_phy_sw_chnl+0x0): multiple definition of `rtl92d_phy_sw_chnl'; drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.o:phy.c:(.text.rtl92d_phy_sw_chnl+0x0): first defined here
   mips-linux-ld: drivers/net/wireless/realtek/rtlwifi/rtl8192du/phy.o: in function `rtl92d_phy_check_poweroff':
   phy.c:(.text.rtl92d_phy_check_poweroff+0x0): multiple definition of `rtl92d_phy_check_poweroff'; drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.o:phy.c:(.text.rtl92d_phy_check_poweroff+0x0): first defined here
   mips-linux-ld: drivers/net/wireless/realtek/rtlwifi/rtl8192du/rf.o: in function `rtl92d_phy_enable_anotherphy':
   rf.c:(.text.rtl92d_phy_enable_anotherphy+0x0): multiple definition of `rtl92d_phy_enable_anotherphy'; drivers/net/wireless/realtek/rtlwifi/rtl8192de/rf.o:rf.c:(.text.rtl92d_phy_enable_anotherphy+0x0): first defined here
   mips-linux-ld: drivers/net/wireless/realtek/rtlwifi/rtl8192du/rf.o: in function `rtl92d_phy_powerdown_anotherphy':
   rf.c:(.text.rtl92d_phy_powerdown_anotherphy+0x0): multiple definition of `rtl92d_phy_powerdown_anotherphy'; drivers/net/wireless/realtek/rtlwifi/rtl8192de/rf.o:rf.c:(.text.rtl92d_phy_powerdown_anotherphy+0x0): first defined here
   mips-linux-ld: drivers/net/wireless/realtek/rtlwifi/rtl8192du/rf.o: in function `rtl92d_phy_rf6052_config':
   rf.c:(.text.rtl92d_phy_rf6052_config+0x0): multiple definition of `rtl92d_phy_rf6052_config'; drivers/net/wireless/realtek/rtlwifi/rtl8192de/rf.o:rf.c:(.text.rtl92d_phy_rf6052_config+0x0): first defined here

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

