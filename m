Return-Path: <linux-wireless+bounces-14795-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B4959B87FF
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Nov 2024 01:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9AFF1F2245F
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Nov 2024 00:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA5CAD23;
	Fri,  1 Nov 2024 00:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RulMTE1s"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F81C43AB9
	for <linux-wireless@vger.kernel.org>; Fri,  1 Nov 2024 00:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730422628; cv=none; b=RKa4MJwZKizP7u1vukA4aAGFW4ag+x63yRDMSAzkRTFuO1Fp7m7k21Xydyy3bRHv4Q9SCjvgdAe4Gq86O3kBGTGa+SHplilsNfxPMRrS3qSN4vfMqdUy63rrYhzthUBx4bFlzLYlxIivER6qHXGK60q/diMAnFg24SWkdZudkHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730422628; c=relaxed/simple;
	bh=8BpUH32LfRDTBTGmQ9TcFwwIyQ5IW4sWCjQLe8uz7xw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PyfBgyFOQey51t0za5QFhLojhh9gLiFDXgi8vqd7xSJUjkqf7e0dzr+aSBJXCdxq4c9B4xraPQy+vQngn1thjZbdzWUl1qPbs8sUW8UHAxUHzpkh67VSpbSoE9hYszpeVjFIVw7ks7/h76h+EvnlIRgOqeR2dJgs5Xm58I4JI4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RulMTE1s; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730422620; x=1761958620;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8BpUH32LfRDTBTGmQ9TcFwwIyQ5IW4sWCjQLe8uz7xw=;
  b=RulMTE1szN14Ktl1k+UazRfkbYHylBfbr2YCaGg7NN4R3OYAqfrYLtnB
   z9aT4oFjVwR0VLoM+EZteEHTZGMTX+Wp6F5uSuyPX41KfWUuV+Vu6IyI5
   WiEd5sVnpYK4zLyk951UQK5qN2Pq7VRMTe33B2845AABjHGCIg2MGgmb/
   bxW8gh52PbX/5BvEdnEclaUSR6SZnn9s2b7HiBxuw8QZEKp8asinkCqz5
   xZv1ZT3WXfsWXvNfMxQAHyPf0iMQMjC6x2AgGuQj5943fUNZpmJ+cuJQi
   Re6g7MynutPBRklaU237OXFLpEqD7mqU1WZ2u+Un6QFEV0rAjv5EyulXn
   w==;
X-CSE-ConnectionGUID: f1ZSEpoaRTiTavFP4NXC6w==
X-CSE-MsgGUID: ozGVdfRrTFCwNVeruTZbkQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11242"; a="30303962"
X-IronPort-AV: E=Sophos;i="6.11,248,1725346800"; 
   d="scan'208";a="30303962"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 17:56:59 -0700
X-CSE-ConnectionGUID: hWnYYU3WSN+TQa3C8WcFwA==
X-CSE-MsgGUID: YRIQEDsyT/+5yyig34eNNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,248,1725346800"; 
   d="scan'208";a="87934781"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 31 Oct 2024 17:56:56 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t6fy9-000gwW-32;
	Fri, 01 Nov 2024 00:56:53 +0000
Date: Fri, 1 Nov 2024 08:56:34 +0800
From: kernel test robot <lkp@intel.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Ping-Ke Shih <pkshih@realtek.com>
Subject: Re: [PATCH v4 7/7] wifi: rtw88: Enable the new RTL8821AU/RTL8812AU
 drivers
Message-ID: <202411010808.yxK25k9f-lkp@intel.com>
References: <0b8e8093-8103-4999-86bf-0055ec52ea64@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b8e8093-8103-4999-86bf-0055ec52ea64@gmail.com>

Hi Bitterblue,

kernel test robot noticed the following build errors:

[auto build test ERROR on wireless-next/main]
[also build test ERROR on wireless/main linus/master v6.12-rc5 next-20241031]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bitterblue-Smith/wifi-rtw88-Add-rtw8812a_table-c-h/20241031-023323
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/0b8e8093-8103-4999-86bf-0055ec52ea64%40gmail.com
patch subject: [PATCH v4 7/7] wifi: rtw88: Enable the new RTL8821AU/RTL8812AU drivers
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20241101/202411010808.yxK25k9f-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241101/202411010808.yxK25k9f-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411010808.yxK25k9f-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/net/wireless/realtek/rtw88/rtw88xxa.c: In function 'rtw88xxa_read_usb_type':
>> drivers/net/wireless/realtek/rtw88/rtw88xxa.c:137:33: error: 'RTW_CHIP_TYPE_8821A' undeclared (first use in this function); did you mean 'RTW_CHIP_TYPE_8821C'?
     137 |         if (rtwdev->chip->id == RTW_CHIP_TYPE_8821A)
         |                                 ^~~~~~~~~~~~~~~~~~~
         |                                 RTW_CHIP_TYPE_8821C
   drivers/net/wireless/realtek/rtw88/rtw88xxa.c:137:33: note: each undeclared identifier is reported only once for each function it appears in
   drivers/net/wireless/realtek/rtw88/rtw88xxa.c: In function 'rtw88xxa_read_efuse':
>> drivers/net/wireless/realtek/rtw88/rtw88xxa.c:207:25: error: 'RTW_CHIP_TYPE_8812A' undeclared (first use in this function); did you mean 'RTW_CHIP_TYPE_8821C'?
     207 |         if (chip->id == RTW_CHIP_TYPE_8812A)
         |                         ^~~~~~~~~~~~~~~~~~~
         |                         RTW_CHIP_TYPE_8821C
   drivers/net/wireless/realtek/rtw88/rtw88xxa.c:243:25: error: 'RTW_CHIP_TYPE_8821A' undeclared (first use in this function); did you mean 'RTW_CHIP_TYPE_8821C'?
     243 |         if (chip->id == RTW_CHIP_TYPE_8821A)
         |                         ^~~~~~~~~~~~~~~~~~~
         |                         RTW_CHIP_TYPE_8821C
   drivers/net/wireless/realtek/rtw88/rtw88xxa.c: In function 'rtw88xxa_reset_8051':
   drivers/net/wireless/realtek/rtw88/rtw88xxa.c:285:25: error: 'RTW_CHIP_TYPE_8812A' undeclared (first use in this function); did you mean 'RTW_CHIP_TYPE_8821C'?
     285 |         if (chip->id == RTW_CHIP_TYPE_8812A)
         |                         ^~~~~~~~~~~~~~~~~~~
         |                         RTW_CHIP_TYPE_8821C
   drivers/net/wireless/realtek/rtw88/rtw88xxa.c: In function 'rtw88xxau_hw_reset':
>> drivers/net/wireless/realtek/rtw88/rtw88xxa.c:315:33: error: 'REG_FPGA0_XCD_RF_PARA' undeclared (first use in this function)
     315 |         rtw_write32_set(rtwdev, REG_FPGA0_XCD_RF_PARA, BIT(6));
         |                                 ^~~~~~~~~~~~~~~~~~~~~
>> drivers/net/wireless/realtek/rtw88/rtw88xxa.c:327:32: error: 'REG_APS_FSMCO' undeclared (first use in this function)
     327 |         rtw_write8_set(rtwdev, REG_APS_FSMCO + 1, APS_FSMCO_MAC_OFF >> 8);
         |                                ^~~~~~~~~~~~~
>> drivers/net/wireless/realtek/rtw88/rtw88xxa.c:327:51: error: 'APS_FSMCO_MAC_OFF' undeclared (first use in this function)
     327 |         rtw_write8_set(rtwdev, REG_APS_FSMCO + 1, APS_FSMCO_MAC_OFF >> 8);
         |                                                   ^~~~~~~~~~~~~~~~~
>> drivers/net/wireless/realtek/rtw88/rtw88xxa.c:337:17: error: 'APS_FSMCO_MAC_ENABLE' undeclared (first use in this function)
     337 |         val8 |= APS_FSMCO_MAC_ENABLE >> 8;
         |                 ^~~~~~~~~~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw88xxa.c: In function 'rtw88xxau_init_power_on':
>> drivers/net/wireless/realtek/rtw88/rtw88xxa.c:350:15: error: implicit declaration of function 'rtw_pwr_seq_parser' [-Werror=implicit-function-declaration]
     350 |         ret = rtw_pwr_seq_parser(rtwdev, chip->pwr_on_seq);
         |               ^~~~~~~~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw88xxa.c:362:25: error: 'RTW_CHIP_TYPE_8821A' undeclared (first use in this function); did you mean 'RTW_CHIP_TYPE_8821C'?
     362 |         if (chip->id == RTW_CHIP_TYPE_8821A) {
         |                         ^~~~~~~~~~~~~~~~~~~
         |                         RTW_CHIP_TYPE_8821C
   drivers/net/wireless/realtek/rtw88/rtw88xxa.c: In function 'rtw88xxa_llt_write':
>> drivers/net/wireless/realtek/rtw88/rtw88xxa.c:372:21: error: 'BIT_LLT_WRITE_ACCESS' undeclared (first use in this function)
     372 |         u32 value = BIT_LLT_WRITE_ACCESS | (address << 8) | data;
         |                     ^~~~~~~~~~~~~~~~~~~~
>> drivers/net/wireless/realtek/rtw88/rtw88xxa.c:375:29: error: 'REG_LLT_INIT' undeclared (first use in this function)
     375 |         rtw_write32(rtwdev, REG_LLT_INIT, value);
         |                             ^~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw88xxa.c: In function 'rtw88xxau_tx_aggregation':
   drivers/net/wireless/realtek/rtw88/rtw88xxa.c:552:25: error: 'RTW_CHIP_TYPE_8821A' undeclared (first use in this function); did you mean 'RTW_CHIP_TYPE_8821C'?
     552 |         if (chip->id == RTW_CHIP_TYPE_8821A)
         |                         ^~~~~~~~~~~~~~~~~~~
         |                         RTW_CHIP_TYPE_8821C
>> drivers/net/wireless/realtek/rtw88/rtw88xxa.c:553:36: error: 'REG_DWBCN1_CTRL' undeclared (first use in this function); did you mean 'REG_DWBCN0_CTRL'?
     553 |                 rtw_write8(rtwdev, REG_DWBCN1_CTRL,
         |                                    ^~~~~~~~~~~~~~~
         |                                    REG_DWBCN0_CTRL
   drivers/net/wireless/realtek/rtw88/rtw88xxa.c: In function 'rtw88xxa_init_beacon_parameters':
>> drivers/net/wireless/realtek/rtw88/rtw88xxa.c:569:29: error: 'REG_BCNTCFG' undeclared (first use in this function)
     569 |         rtw_write16(rtwdev, REG_BCNTCFG, 0x4413);
         |                             ^~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw88xxa.c: In function 'rtw88xxa_phy_bb_config':
>> drivers/net/wireless/realtek/rtw88/rtw88xxa.c:578:17: error: 'BIT_FEN_USBA' undeclared (first use in this function); did you mean 'BIT_FEN_ELDR'?
     578 |         val8 |= BIT_FEN_USBA;
         |                 ^~~~~~~~~~~~
         |                 BIT_FEN_ELDR
>> drivers/net/wireless/realtek/rtw88/rtw88xxa.c:587:28: error: 'REG_RF_B_CTRL' undeclared (first use in this function); did you mean 'REG_RF_CTRL'?
     587 |         rtw_write8(rtwdev, REG_RF_B_CTRL,
         |                            ^~~~~~~~~~~~~
         |                            REG_RF_CTRL
   drivers/net/wireless/realtek/rtw88/rtw88xxa.c:594:33: error: 'RTW_CHIP_TYPE_8812A' undeclared (first use in this function); did you mean 'RTW_CHIP_TYPE_8821C'?
     594 |         if (rtwdev->chip->id == RTW_CHIP_TYPE_8812A)
         |                                 ^~~~~~~~~~~~~~~~~~~
         |                                 RTW_CHIP_TYPE_8821C
   drivers/net/wireless/realtek/rtw88/rtw88xxa.c: In function 'rtw8812a_config_1t':
>> drivers/net/wireless/realtek/rtw88/rtw88xxa.c:613:34: error: 'REG_RXPSEL' undeclared (first use in this function); did you mean 'REG_RQPN'?
     613 |         rtw_write32_mask(rtwdev, REG_RXPSEL, 0xff, 0x11);
         |                                  ^~~~~~~~~~
         |                                  REG_RQPN
>> drivers/net/wireless/realtek/rtw88/rtw88xxa.c:616:34: error: 'REG_TXPSEL' undeclared (first use in this function); did you mean 'REG_TXPAUSE'?
     616 |         rtw_write32_mask(rtwdev, REG_TXPSEL, MASKLWORD, 0x1111);
         |                                  ^~~~~~~~~~
         |                                  REG_TXPAUSE
>> drivers/net/wireless/realtek/rtw88/rtw88xxa.c:619:34: error: 'REG_CCK_RX' undeclared (first use in this function)
     619 |         rtw_write32_mask(rtwdev, REG_CCK_RX, 0x0c000000, 0x0);
         |                                  ^~~~~~~~~~
>> drivers/net/wireless/realtek/rtw88/rtw88xxa.c:622:34: error: 'REG_RX_MCS_LIMIT' undeclared (first use in this function); did you mean 'REG_RX_PKT_LIMIT'?
     622 |         rtw_write32_mask(rtwdev, REG_RX_MCS_LIMIT, 0xc0000060, 0x4);
         |                                  ^~~~~~~~~~~~~~~~
         |                                  REG_RX_PKT_LIMIT
>> drivers/net/wireless/realtek/rtw88/rtw88xxa.c:625:34: error: 'REG_3WIRE_SWB' undeclared (first use in this function)
     625 |         rtw_write32_mask(rtwdev, REG_3WIRE_SWB, 0xf, 0x4);
         |                                  ^~~~~~~~~~~~~
>> drivers/net/wireless/realtek/rtw88/rtw88xxa.c:628:34: error: 'REG_LSSI_WRITE_B' undeclared (first use in this function)
     628 |         rtw_write32_mask(rtwdev, REG_LSSI_WRITE_B, MASKDWORD, 0);
         |                                  ^~~~~~~~~~~~~~~~
>> drivers/net/wireless/realtek/rtw88/rtw88xxa.c:631:34: error: 'REG_AFE_PWR1_B' undeclared (first use in this function); did you mean 'REG_AFE_CTRL_4'?
     631 |         rtw_write32_mask(rtwdev, REG_AFE_PWR1_B, MASKDWORD, 0);
         |                                  ^~~~~~~~~~~~~~
         |                                  REG_AFE_CTRL_4
   drivers/net/wireless/realtek/rtw88/rtw88xxa.c:632:34: error: 'REG_AFE_PWR2_B' undeclared (first use in this function); did you mean 'REG_AFE_CTRL_4'?
     632 |         rtw_write32_mask(rtwdev, REG_AFE_PWR2_B, MASKDWORD, 0);
         |                                  ^~~~~~~~~~~~~~
         |                                  REG_AFE_CTRL_4
   drivers/net/wireless/realtek/rtw88/rtw88xxa.c: In function 'rtw88xxa_pwrtrack_init':
   drivers/net/wireless/realtek/rtw88/rtw88xxa.c:684:33: error: 'RTW_CHIP_TYPE_8821A' undeclared (first use in this function); did you mean 'RTW_CHIP_TYPE_8821C'?
     684 |         if (rtwdev->chip->id == RTW_CHIP_TYPE_8821A)
         |                                 ^~~~~~~~~~~~~~~~~~~
         |                                 RTW_CHIP_TYPE_8821C
   drivers/net/wireless/realtek/rtw88/rtw88xxa.c: In function 'rtw88xxa_power_off':
   drivers/net/wireless/realtek/rtw88/rtw88xxa.c:721:40: error: 'REG_USB_MOD' undeclared (first use in this function)
     721 |                 rtw_write8_set(rtwdev, REG_USB_MOD, 0x18);
         |                                        ^~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw88xxa.c:723:29: error: 'REG_HISR0' undeclared (first use in this function); did you mean 'REG_ARFR0'?
     723 |         rtw_write32(rtwdev, REG_HISR0, 0xffffffff);
         |                             ^~~~~~~~~
         |                             REG_ARFR0
   drivers/net/wireless/realtek/rtw88/rtw88xxa.c:724:29: error: 'REG_HISR1' undeclared (first use in this function); did you mean 'REG_FWISR'?
     724 |         rtw_write32(rtwdev, REG_HISR1, 0xffffffff);
         |                             ^~~~~~~~~
         |                             REG_FWISR
   drivers/net/wireless/realtek/rtw88/rtw88xxa.c:725:29: error: 'REG_HIMR0' undeclared (first use in this function); did you mean 'REG_FWIMR'?
     725 |         rtw_write32(rtwdev, REG_HIMR0, 0);
         |                             ^~~~~~~~~
         |                             REG_FWIMR
   drivers/net/wireless/realtek/rtw88/rtw88xxa.c:726:29: error: 'REG_HIMR1' undeclared (first use in this function); did you mean 'REG_FWIMR'?
     726 |         rtw_write32(rtwdev, REG_HIMR1, 0);
         |                             ^~~~~~~~~
         |                             REG_FWIMR
   drivers/net/wireless/realtek/rtw88/rtw88xxa.c:731:40: error: 'REG_APS_FSMCO' undeclared (first use in this function)
     731 |         ori_fsmc0 = rtw_read16(rtwdev, REG_APS_FSMCO);
         |                                        ^~~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw88xxa.c:732:57: error: 'APS_FSMCO_HW_POWERDOWN' undeclared (first use in this function)
     732 |         rtw_write16(rtwdev, REG_APS_FSMCO, ori_fsmc0 & ~APS_FSMCO_HW_POWERDOWN);
         |                                                         ^~~~~~~~~~~~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw88xxa.c:735:32: error: 'REG_TX_RPT_CTRL' undeclared (first use in this function); did you mean 'REG_TX_PTCL_CTRL'?
     735 |         rtw_write8_clr(rtwdev, REG_TX_RPT_CTRL, BIT(1));
         |                                ^~~~~~~~~~~~~~~
         |                                REG_TX_PTCL_CTRL
   drivers/net/wireless/realtek/rtw88/rtw88xxa.c: In function 'rtw88xxa_set_channel_bb_swing':
   drivers/net/wireless/realtek/rtw88/rtw88xxa.c:759:34: error: 'REG_TXSCALE_A' undeclared (first use in this function)
     759 |         rtw_write32_mask(rtwdev, REG_TXSCALE_A, BB_SWING_MASK,
         |                                  ^~~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw88xxa.c:759:49: error: 'BB_SWING_MASK' undeclared (first use in this function)
     759 |         rtw_write32_mask(rtwdev, REG_TXSCALE_A, BB_SWING_MASK,
         |                                                 ^~~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw88xxa.c:761:34: error: 'REG_TXSCALE_B' undeclared (first use in this function)
     761 |         rtw_write32_mask(rtwdev, REG_TXSCALE_B, BB_SWING_MASK,
         |                                  ^~~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw88xxa.c: In function 'rtw8821a_set_ext_band_switch':
   drivers/net/wireless/realtek/rtw88/rtw88xxa.c:770:34: error: 'REG_RFE_INV_A' undeclared (first use in this function); did you mean 'REG_RFE_INV16'?
     770 |         rtw_write32_mask(rtwdev, REG_RFE_INV_A, 0xf, 7);
         |                                  ^~~~~~~~~~~~~
         |                                  REG_RFE_INV16
   drivers/net/wireless/realtek/rtw88/rtw88xxa.c: In function 'rtw8821a_phy_set_rfe_reg_24g':
   drivers/net/wireless/realtek/rtw88/rtw88xxa.c:786:34: error: 'REG_RFE_PINMUX_A' undeclared (first use in this function); did you mean 'REG_RFE_INV16'?
     786 |         rtw_write32_mask(rtwdev, REG_RFE_PINMUX_A, 0xF000, 0x7);
         |                                  ^~~~~~~~~~~~~~~~
         |                                  REG_RFE_INV16
   drivers/net/wireless/realtek/rtw88/rtw88xxa.c:792:42: error: 'REG_RFE_INV_A' undeclared (first use in this function); did you mean 'REG_RFE_INV16'?
     792 |                 rtw_write32_mask(rtwdev, REG_RFE_INV_A, BIT(20), 1);
         |                                          ^~~~~~~~~~~~~
         |                                          REG_RFE_INV16
   drivers/net/wireless/realtek/rtw88/rtw88xxa.c: In function 'rtw8821a_phy_set_rfe_reg_5g':
   drivers/net/wireless/realtek/rtw88/rtw88xxa.c:810:34: error: 'REG_RFE_PINMUX_A' undeclared (first use in this function); did you mean 'REG_RFE_INV16'?
     810 |         rtw_write32_mask(rtwdev, REG_RFE_PINMUX_A, 0xF000, 0x5);
         |                                  ^~~~~~~~~~~~~~~~
         |                                  REG_RFE_INV16
   drivers/net/wireless/realtek/rtw88/rtw88xxa.c:815:34: error: 'REG_RFE_INV_A' undeclared (first use in this function); did you mean 'REG_RFE_INV16'?
     815 |         rtw_write32_mask(rtwdev, REG_RFE_INV_A, BIT(20), 0);
         |                                  ^~~~~~~~~~~~~
         |                                  REG_RFE_INV16
   drivers/net/wireless/realtek/rtw88/rtw88xxa.c: In function 'rtw8812a_phy_set_rfe_reg_24g':
   drivers/net/wireless/realtek/rtw88/rtw88xxa.c:826:37: error: 'REG_RFE_PINMUX_A' undeclared (first use in this function); did you mean 'REG_RFE_INV16'?
     826 |                 rtw_write32(rtwdev, REG_RFE_PINMUX_A, 0x77777777);
         |                                     ^~~~~~~~~~~~~~~~
         |                                     REG_RFE_INV16
   drivers/net/wireless/realtek/rtw88/rtw88xxa.c:827:37: error: 'REG_RFE_PINMUX_B' undeclared (first use in this function); did you mean 'REG_RFE_INV16'?
     827 |                 rtw_write32(rtwdev, REG_RFE_PINMUX_B, 0x77777777);
         |                                     ^~~~~~~~~~~~~~~~
         |                                     REG_RFE_INV16
   drivers/net/wireless/realtek/rtw88/rtw88xxa.c:828:42: error: 'REG_RFE_INV_A' undeclared (first use in this function); did you mean 'REG_RFE_INV16'?
     828 |                 rtw_write32_mask(rtwdev, REG_RFE_INV_A, RFE_INV_MASK, 0x000);
         |                                          ^~~~~~~~~~~~~
         |                                          REG_RFE_INV16
   drivers/net/wireless/realtek/rtw88/rtw88xxa.c:828:57: error: 'RFE_INV_MASK' undeclared (first use in this function)
     828 |                 rtw_write32_mask(rtwdev, REG_RFE_INV_A, RFE_INV_MASK, 0x000);
         |                                                         ^~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw88xxa.c:829:42: error: 'REG_RFE_INV_B' undeclared (first use in this function); did you mean 'REG_RFE_INV16'?
     829 |                 rtw_write32_mask(rtwdev, REG_RFE_INV_B, RFE_INV_MASK, 0x000);
         |                                          ^~~~~~~~~~~~~
         |                                          REG_RFE_INV16
   drivers/net/wireless/realtek/rtw88/rtw88xxa.c:849:42: error: 'REG_ANTSEL_SW' undeclared (first use in this function)
     849 |                 rtw_write32_mask(rtwdev, REG_ANTSEL_SW, 0x00000303, 0x1);
         |                                          ^~~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw88xxa.c: In function 'rtw8812a_phy_set_rfe_reg_5g':
   drivers/net/wireless/realtek/rtw88/rtw88xxa.c:878:37: error: 'REG_RFE_PINMUX_A' undeclared (first use in this function); did you mean 'REG_RFE_INV16'?
--
   drivers/net/wireless/realtek/rtw88/rtw8821a.c: In function 'rtw8821a_iqk_backup_rf':
>> drivers/net/wireless/realtek/rtw88/rtw8821a.c:63:34: error: 'REG_CCASEL' undeclared (first use in this function)
      63 |         rtw_write32_mask(rtwdev, REG_CCASEL, BIT(31), 0x0);
         |                                  ^~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:63:34: note: each undeclared identifier is reported only once for each function it appears in
   drivers/net/wireless/realtek/rtw88/rtw8821a.c: In function 'rtw8821a_iqk_restore_rf':
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:78:34: error: 'REG_CCASEL' undeclared (first use in this function)
      78 |         rtw_write32_mask(rtwdev, REG_CCASEL, BIT(31), 0x0);
         |                                  ^~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8821a.c: In function 'rtw8821a_iqk_restore_afe':
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:91:34: error: 'REG_CCASEL' undeclared (first use in this function)
      91 |         rtw_write32_mask(rtwdev, REG_CCASEL, BIT(31), 0x0);
         |                                  ^~~~~~~~~~
>> drivers/net/wireless/realtek/rtw88/rtw8821a.c:100:29: error: 'REG_OFDM0_XA_TX_IQ_IMBALANCE' undeclared (first use in this function)
     100 |         rtw_write32(rtwdev, REG_OFDM0_XA_TX_IQ_IMBALANCE, 0x0);
         |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/net/wireless/realtek/rtw88/rtw8821a.c:101:29: error: 'REG_OFDM0_A_TX_AFE' undeclared (first use in this function)
     101 |         rtw_write32(rtwdev, REG_OFDM0_A_TX_AFE, 0x0);
         |                             ^~~~~~~~~~~~~~~~~~
>> drivers/net/wireless/realtek/rtw88/rtw8821a.c:102:29: error: 'REG_OFDM0_XB_TX_IQ_IMBALANCE' undeclared (first use in this function)
     102 |         rtw_write32(rtwdev, REG_OFDM0_XB_TX_IQ_IMBALANCE, 0x0);
         |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/net/wireless/realtek/rtw88/rtw8821a.c:103:29: error: 'REG_TSSI_TRK_SW' undeclared (first use in this function)
     103 |         rtw_write32(rtwdev, REG_TSSI_TRK_SW, 0x3c000000);
         |                             ^~~~~~~~~~~~~~~
>> drivers/net/wireless/realtek/rtw88/rtw8821a.c:104:29: error: 'REG_LSSI_WRITE_A' undeclared (first use in this function)
     104 |         rtw_write32(rtwdev, REG_LSSI_WRITE_A, 0x00000080);
         |                             ^~~~~~~~~~~~~~~~
>> drivers/net/wireless/realtek/rtw88/rtw8821a.c:105:29: error: 'REG_TXAGCIDX' undeclared (first use in this function)
     105 |         rtw_write32(rtwdev, REG_TXAGCIDX, 0x00000000);
         |                             ^~~~~~~~~~~~
>> drivers/net/wireless/realtek/rtw88/rtw8821a.c:106:29: error: 'REG_IQK_DPD_CFG' undeclared (first use in this function)
     106 |         rtw_write32(rtwdev, REG_IQK_DPD_CFG, 0x20040000);
         |                             ^~~~~~~~~~~~~~~
>> drivers/net/wireless/realtek/rtw88/rtw8821a.c:107:29: error: 'REG_CFG_PMPD' undeclared (first use in this function)
     107 |         rtw_write32(rtwdev, REG_CFG_PMPD, 0x20000000);
         |                             ^~~~~~~~~~~~
>> drivers/net/wireless/realtek/rtw88/rtw8821a.c:108:29: error: 'REG_RFECTL_A' undeclared (first use in this function); did you mean 'REG_RFE_CTRL_E'?
     108 |         rtw_write32(rtwdev, REG_RFECTL_A, 0x0);
         |                             ^~~~~~~~~~~~
         |                             REG_RFE_CTRL_E
   drivers/net/wireless/realtek/rtw88/rtw8821a.c: In function 'rtw8821a_iqk_rx_fill':
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:115:34: error: 'REG_CCASEL' undeclared (first use in this function)
     115 |         rtw_write32_mask(rtwdev, REG_CCASEL, BIT(31), 0x0);
         |                                  ^~~~~~~~~~
>> drivers/net/wireless/realtek/rtw88/rtw8821a.c:117:34: error: 'REG_RX_IQC_AB_A' undeclared (first use in this function)
     117 |         rtw_write32_mask(rtwdev, REG_RX_IQC_AB_A,
         |                                  ^~~~~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8821a.c: In function 'rtw8821a_iqk_tx_fill':
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:127:34: error: 'REG_CCASEL' undeclared (first use in this function)
     127 |         rtw_write32_mask(rtwdev, REG_CCASEL, BIT(31), 0x1);
         |                                  ^~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:129:29: error: 'REG_LSSI_WRITE_A' undeclared (first use in this function)
     129 |         rtw_write32(rtwdev, REG_LSSI_WRITE_A, 0x00000080);
         |                             ^~~~~~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:130:29: error: 'REG_IQK_DPD_CFG' undeclared (first use in this function)
     130 |         rtw_write32(rtwdev, REG_IQK_DPD_CFG, 0x20040000);
         |                             ^~~~~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:131:29: error: 'REG_CFG_PMPD' undeclared (first use in this function)
     131 |         rtw_write32(rtwdev, REG_CFG_PMPD, 0x20000000);
         |                             ^~~~~~~~~~~~
>> drivers/net/wireless/realtek/rtw88/rtw8821a.c:132:34: error: 'REG_IQC_Y' undeclared (first use in this function)
     132 |         rtw_write32_mask(rtwdev, REG_IQC_Y, 0x000007ff, tx_y);
         |                                  ^~~~~~~~~
>> drivers/net/wireless/realtek/rtw88/rtw8821a.c:133:34: error: 'REG_IQC_X' undeclared (first use in this function)
     133 |         rtw_write32_mask(rtwdev, REG_IQC_X, 0x000007ff, tx_x);
         |                                  ^~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8821a.c: In function 'rtw8821a_iqk_tx_vdf_true':
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:149:45: error: 'REG_OFDM0_XA_TX_IQ_IMBALANCE' undeclared (first use in this function)
     149 |                         rtw_write32(rtwdev, REG_OFDM0_XA_TX_IQ_IMBALANCE,
         |                                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:152:45: error: 'REG_OFDM0_A_TX_AFE' undeclared (first use in this function)
     152 |                         rtw_write32(rtwdev, REG_OFDM0_A_TX_AFE, 0x38008c38);
         |                                             ^~~~~~~~~~~~~~~~~~
>> drivers/net/wireless/realtek/rtw88/rtw8821a.c:153:50: error: 'REG_INTPO_SETA' undeclared (first use in this function)
     153 |                         rtw_write32_mask(rtwdev, REG_INTPO_SETA, BIT(31), 0x0);
         |                                                  ^~~~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:188:37: error: 'REG_RFECTL_A' undeclared (first use in this function); did you mean 'REG_RFE_CTRL_E'?
     188 |                 rtw_write32(rtwdev, REG_RFECTL_A, 0x00100000);
         |                                     ^~~~~~~~~~~~
         |                                     REG_RFE_CTRL_E
>> drivers/net/wireless/realtek/rtw88/rtw8821a.c:192:45: error: 'REG_IQK_COM64' undeclared (first use in this function)
     192 |                         rtw_write32(rtwdev, REG_IQK_COM64, 0xfa000000);
         |                                             ^~~~~~~~~~~~~
>> drivers/net/wireless/realtek/rtw88/rtw8821a.c:201:61: error: 'REG_IQKA_END' undeclared (first use in this function)
     201 |                                                             REG_IQKA_END,
         |                                                             ^~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:245:58: error: 'REG_IQC_Y' undeclared (first use in this function)
     245 |                                 rtw_write32_mask(rtwdev, REG_IQC_Y,
         |                                                          ^~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:247:58: error: 'REG_IQC_X' undeclared (first use in this function)
     247 |                                 rtw_write32_mask(rtwdev, REG_IQC_X,
         |                                                          ^~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8821a.c: In function 'rtw8821a_iqk_tx_vdf_false':
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:269:29: error: 'REG_OFDM0_XA_TX_IQ_IMBALANCE' undeclared (first use in this function)
     269 |         rtw_write32(rtwdev, REG_OFDM0_XA_TX_IQ_IMBALANCE, 0x18008c10);
         |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:271:29: error: 'REG_OFDM0_A_TX_AFE' undeclared (first use in this function)
     271 |         rtw_write32(rtwdev, REG_OFDM0_A_TX_AFE, 0x38008c10);
         |                             ^~~~~~~~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:272:29: error: 'REG_RFECTL_A' undeclared (first use in this function); did you mean 'REG_RFE_CTRL_E'?
     272 |         rtw_write32(rtwdev, REG_RFECTL_A, 0x00100000);
         |                             ^~~~~~~~~~~~
         |                             REG_RFE_CTRL_E
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:276:37: error: 'REG_IQK_COM64' undeclared (first use in this function)
     276 |                 rtw_write32(rtwdev, REG_IQK_COM64, 0xfa000000);
         |                                     ^~~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:283:61: error: 'REG_IQKA_END' undeclared (first use in this function)
     283 |                         iqk_ready = rtw_read32_mask(rtwdev, REG_IQKA_END, BIT(10));
         |                                                             ^~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:320:50: error: 'REG_IQC_Y' undeclared (first use in this function)
     320 |                         rtw_write32_mask(rtwdev, REG_IQC_Y, 0x000007ff, 0x0);
         |                                                  ^~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:321:50: error: 'REG_IQC_X' undeclared (first use in this function)
     321 |                         rtw_write32_mask(rtwdev, REG_IQC_X, 0x000007ff, 0x200);
         |                                                  ^~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8821a.c: In function 'rtw8821a_iqk_rx':
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:334:29: error: 'REG_RFECTL_A' undeclared (first use in this function); did you mean 'REG_RFE_CTRL_E'?
     334 |         rtw_write32(rtwdev, REG_RFECTL_A, 0x00100000);
         |                             ^~~~~~~~~~~~
         |                             REG_RFE_CTRL_E
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:338:37: error: 'REG_IQK_COM64' undeclared (first use in this function)
     338 |                 rtw_write32(rtwdev, REG_IQK_COM64, 0xfa000000);
         |                                     ^~~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:346:61: error: 'REG_IQKA_END' undeclared (first use in this function)
     346 |                         iqk_ready = rtw_read32_mask(rtwdev, REG_IQKA_END, BIT(10));
         |                                                             ^~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:377:50: error: 'REG_RX_IQC_AB_A' undeclared (first use in this function)
     377 |                         rtw_write32_mask(rtwdev, REG_RX_IQC_AB_A,
         |                                                  ^~~~~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8821a.c: In function 'rtw8821a_iqk':
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:415:42: error: 'REG_CCASEL' undeclared (first use in this function)
     415 |                 rtw_write32_mask(rtwdev, REG_CCASEL, BIT(31), 0x0);
         |                                          ^~~~~~~~~~
>> drivers/net/wireless/realtek/rtw88/rtw8821a.c:419:37: error: 'REG_AFE_PWR1_A' undeclared (first use in this function); did you mean 'REG_AFE_CTRL_4'?
     419 |                 rtw_write32(rtwdev, REG_AFE_PWR1_A, 0x77777777);
         |                                     ^~~~~~~~~~~~~~
         |                                     REG_AFE_CTRL_4
>> drivers/net/wireless/realtek/rtw88/rtw8821a.c:420:37: error: 'REG_AFE_PWR2_A' undeclared (first use in this function); did you mean 'REG_AFE_CTRL_4'?
     420 |                 rtw_write32(rtwdev, REG_AFE_PWR2_A, 0x77777777);
         |                                     ^~~~~~~~~~~~~~
         |                                     REG_AFE_CTRL_4
>> drivers/net/wireless/realtek/rtw88/rtw8821a.c:422:37: error: 'REG_RX_WAIT_CCA_TX_CCK_RFON_A' undeclared (first use in this function)
     422 |                 rtw_write32(rtwdev, REG_RX_WAIT_CCA_TX_CCK_RFON_A, 0x19791979);
         |                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/net/wireless/realtek/rtw88/rtw8821a.c:425:42: error: 'REG_3WIRE_SWA' undeclared (first use in this function)
     425 |                 rtw_write32_mask(rtwdev, REG_3WIRE_SWA, 0xf, 0x4);
         |                                          ^~~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:430:42: error: 'REG_CK_MONHA' undeclared (first use in this function)
     430 |                 rtw_write32_mask(rtwdev, REG_CK_MONHA, GENMASK(26, 24), 0x7);
         |                                          ^~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:435:49: error: 'RF_MODE_TABLE_ADDR' undeclared (first use in this function)
     435 |                 rtw_write_rf(rtwdev, RF_PATH_A, RF_MODE_TABLE_ADDR, RFREG_MASK,
         |                                                 ^~~~~~~~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:437:49: error: 'RF_MODE_TABLE_DATA0' undeclared (first use in this function)
     437 |                 rtw_write_rf(rtwdev, RF_PATH_A, RF_MODE_TABLE_DATA0, RFREG_MASK,
         |                                                 ^~~~~~~~~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:439:49: error: 'RF_MODE_TABLE_DATA1' undeclared (first use in this function)
     439 |                 rtw_write_rf(rtwdev, RF_PATH_A, RF_MODE_TABLE_DATA1, RFREG_MASK,
         |                                                 ^~~~~~~~~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:442:49: error: 'RF_TXA_PREPAD' undeclared (first use in this function)
     442 |                 rtw_write_rf(rtwdev, RF_PATH_A, RF_TXA_PREPAD, RFREG_MASK,
         |                                                 ^~~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:444:49: error: 'RF_RXBB2' undeclared (first use in this function)
     444 |                 rtw_write_rf(rtwdev, RF_PATH_A, RF_RXBB2, RFREG_MASK, 0x8a001);
         |                                                 ^~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:445:37: error: 'REG_DAC_RSTB' undeclared (first use in this function)
     445 |                 rtw_write32(rtwdev, REG_DAC_RSTB, 0x00008000);
         |                                     ^~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:446:42: error: 'REG_TXAGCIDX' undeclared (first use in this function)
     446 |                 rtw_write32_mask(rtwdev, REG_TXAGCIDX, BIT(0), 0x1);
         |                                          ^~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:448:37: error: 'REG_IQK_COM00' undeclared (first use in this function)
     448 |                 rtw_write32(rtwdev, REG_IQK_COM00, 0x29002000);
         |                                     ^~~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:450:37: error: 'REG_IQK_COM32' undeclared (first use in this function)
     450 |                 rtw_write32(rtwdev, REG_IQK_COM32, 0xa9002000);
         |                                     ^~~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:452:37: error: 'REG_IQK_COM96' undeclared (first use in this function)
     452 |                 rtw_write32(rtwdev, REG_IQK_COM96, 0x00462910);
         |                                     ^~~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:458:45: error: 'REG_OFDM0_XB_TX_IQ_IMBALANCE' undeclared (first use in this function)
     458 |                         rtw_write32(rtwdev, REG_OFDM0_XB_TX_IQ_IMBALANCE,
         |                                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:465:45: error: 'REG_TSSI_TRK_SW' undeclared (first use in this function)
     465 |                         rtw_write32(rtwdev, REG_TSSI_TRK_SW, 0x68163e96);
         |                                             ^~~~~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:470:37: error: 'REG_OFDM0_XA_TX_IQ_IMBALANCE' undeclared (first use in this function)
     470 |                 rtw_write32(rtwdev, REG_OFDM0_XA_TX_IQ_IMBALANCE, 0x18008c10);
         |                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:472:37: error: 'REG_OFDM0_A_TX_AFE' undeclared (first use in this function)
     472 |                 rtw_write32(rtwdev, REG_OFDM0_A_TX_AFE, 0x38008c10);
         |                                     ^~~~~~~~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:473:37: error: 'REG_RFECTL_A' undeclared (first use in this function); did you mean 'REG_RFE_CTRL_E'?
     473 |                 rtw_write32(rtwdev, REG_RFECTL_A, 0x00100000);
         |                                     ^~~~~~~~~~~~
         |                                     REG_RFE_CTRL_E
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:474:37: error: 'REG_IQK_COM64' undeclared (first use in this function)
     474 |                 rtw_write32(rtwdev, REG_IQK_COM64, 0xfa000000);
         |                                     ^~~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:482:49: error: 'RF_TXMOD' undeclared (first use in this function)
     482 |                 rtw_write_rf(rtwdev, RF_PATH_A, RF_TXMOD, 0x7fe00,
         |                                                 ^~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8821a.c: In function 'rtw8821a_coex_cfg_ant_switch':
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:751:40: error: 'REG_GNT_BT' undeclared (first use in this function)
     751 |                 rtw_write8_set(rtwdev, REG_GNT_BT, BIT_PTA_SW_CTL);
         |                                        ^~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:751:52: error: 'BIT_PTA_SW_CTL' undeclared (first use in this function)
     751 |                 rtw_write8_set(rtwdev, REG_GNT_BT, BIT_PTA_SW_CTL);
         |                                                    ^~~~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:754:40: error: 'PTA_CTRL_PIN' undeclared (first use in this function)
     754 |                            share_ant ? PTA_CTRL_PIN : DPDT_CTRL_PIN);
         |                                        ^~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:754:55: error: 'DPDT_CTRL_PIN' undeclared (first use in this function)
     754 |                            share_ant ? PTA_CTRL_PIN : DPDT_CTRL_PIN);
         |                                                       ^~~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8821a.c: At top level:
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:836:10: error: 'const struct rtw_chip_ops' has no member named 'power_on'
     836 |         .power_on               = rtw88xxa_power_on,
         |          ^~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:837:10: error: 'const struct rtw_chip_ops' has no member named 'power_off'
     837 |         .power_off              = rtw8821a_power_off,
         |          ^~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:837:35: error: initialization of 'int (*)(struct rtw_dev *)' from incompatible pointer type 'void (*)(struct rtw_dev *)' [-Werror=incompatible-pointer-types]
     837 |         .power_off              = rtw8821a_power_off,
         |                                   ^~~~~~~~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:837:35: note: (near initialization for 'rtw8821a_ops.dump_fw_crash')
   In file included from include/uapi/linux/posix_types.h:5,
                    from include/uapi/linux/types.h:14,
                    from include/linux/types.h:6,
                    from include/linux/kcsan-checks.h:14,
                    from include/asm-generic/barrier.h:17,
                    from arch/alpha/include/asm/barrier.h:21,
                    from arch/alpha/include/asm/rwonce.h:10,
                    from include/linux/compiler.h:317,
                    from include/linux/export.h:5,
                    from include/linux/linkage.h:7,
                    from arch/alpha/include/asm/bug.h:5,
                    from include/linux/bug.h:5,
                    from include/net/mac80211.h:16,
                    from drivers/net/wireless/realtek/rtw88/main.h:8,
                    from drivers/net/wireless/realtek/rtw88/rtw8821a.c:5:
   include/linux/stddef.h:8:14: warning: initialized field overwritten [-Woverride-init]
       8 | #define NULL ((void *)0)
         |              ^
   drivers/net/wireless/realtek/rtw88/rtw8821a.c:842:35: note: in expansion of macro 'NULL'
..


vim +137 drivers/net/wireless/realtek/rtw88/rtw88xxa.c

0810de4fd8fcd8 Bitterblue Smith 2024-10-30  123  
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  124  static void rtw88xxa_read_usb_type(struct rtw_dev *rtwdev)
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  125  {
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  126  	struct rtw_efuse *efuse = &rtwdev->efuse;
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  127  	struct rtw_hal *hal = &rtwdev->hal;
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  128  	u8 antenna = 0;
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  129  	u8 wmode = 0;
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  130  	u8 val8, i;
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  131  
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  132  	efuse->hw_cap.bw = BIT(RTW_CHANNEL_WIDTH_20) |
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  133  			   BIT(RTW_CHANNEL_WIDTH_40) |
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  134  			   BIT(RTW_CHANNEL_WIDTH_80);
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  135  	efuse->hw_cap.ptcl = EFUSE_HW_CAP_PTCL_VHT;
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  136  
0810de4fd8fcd8 Bitterblue Smith 2024-10-30 @137  	if (rtwdev->chip->id == RTW_CHIP_TYPE_8821A)
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  138  		efuse->hw_cap.nss = 1;
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  139  	else
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  140  		efuse->hw_cap.nss = 2;
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  141  
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  142  	if (rtwdev->chip->id == RTW_CHIP_TYPE_8821A)
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  143  		goto print_hw_cap;
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  144  
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  145  	for (i = 0; i < 2; i++) {
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  146  		rtw_read8_physical_efuse(rtwdev, 1019 - i, &val8);
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  147  
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  148  		antenna = u8_get_bits(val8, GENMASK(7, 5));
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  149  		if (antenna)
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  150  			break;
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  151  		antenna = u8_get_bits(val8, GENMASK(3, 1));
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  152  		if (antenna)
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  153  			break;
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  154  	}
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  155  
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  156  	for (i = 0; i < 2; i++) {
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  157  		rtw_read8_physical_efuse(rtwdev, 1021 - i, &val8);
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  158  
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  159  		wmode = u8_get_bits(val8, GENMASK(3, 2));
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  160  		if (wmode)
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  161  			break;
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  162  	}
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  163  
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  164  	if (antenna == 1) {
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  165  		rtw_info(rtwdev, "This RTL8812AU says it is 1T1R.\n");
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  166  
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  167  		efuse->hw_cap.nss = 1;
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  168  		hal->rf_type = RF_1T1R;
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  169  		hal->rf_path_num = 1;
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  170  		hal->rf_phy_num = 1;
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  171  		hal->antenna_tx = BB_PATH_A;
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  172  		hal->antenna_rx = BB_PATH_A;
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  173  	} else {
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  174  		/* Override rtw_chip_parameter_setup(). It detects 8812au as 1T1R. */
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  175  		efuse->hw_cap.nss = 2;
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  176  		hal->rf_type = RF_2T2R;
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  177  		hal->rf_path_num = 2;
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  178  		hal->rf_phy_num = 2;
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  179  		hal->antenna_tx = BB_PATH_AB;
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  180  		hal->antenna_rx = BB_PATH_AB;
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  181  
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  182  		if (antenna == 2 && wmode == 2) {
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  183  			rtw_info(rtwdev, "This RTL8812AU says it can't do VHT.\n");
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  184  
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  185  			/* Can't be EFUSE_HW_CAP_IGNORE and can't be
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  186  			 * EFUSE_HW_CAP_PTCL_VHT, so make it 1.
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  187  			 */
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  188  			efuse->hw_cap.ptcl = 1;
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  189  			efuse->hw_cap.bw &= ~BIT(RTW_CHANNEL_WIDTH_80);
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  190  		}
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  191  	}
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  192  
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  193  print_hw_cap:
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  194  	rtw_dbg(rtwdev, RTW_DBG_EFUSE,
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  195  		"hw cap: hci=0x%02x, bw=0x%02x, ptcl=0x%02x, ant_num=%d, nss=%d\n",
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  196  		efuse->hw_cap.hci, efuse->hw_cap.bw, efuse->hw_cap.ptcl,
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  197  		efuse->hw_cap.ant_num, efuse->hw_cap.nss);
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  198  }
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  199  
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  200  int rtw88xxa_read_efuse(struct rtw_dev *rtwdev, u8 *log_map)
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  201  {
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  202  	const struct rtw_chip_info *chip = rtwdev->chip;
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  203  	struct rtw_efuse *efuse = &rtwdev->efuse;
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  204  	struct rtw88xxa_efuse *map;
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  205  	int i;
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  206  
0810de4fd8fcd8 Bitterblue Smith 2024-10-30 @207  	if (chip->id == RTW_CHIP_TYPE_8812A)
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  208  		rtwdev->hal.cut_version += 1;
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  209  
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  210  	if (rtw_dbg_is_enabled(rtwdev, RTW_DBG_EFUSE))
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  211  		print_hex_dump(KERN_INFO, "", DUMP_PREFIX_OFFSET, 16, 1,
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  212  			       log_map, chip->log_efuse_size, true);
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  213  
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  214  	map = (struct rtw88xxa_efuse *)log_map;
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  215  
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  216  	efuse->rf_board_option = map->rf_board_option;
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  217  	efuse->crystal_cap = map->xtal_k;
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  218  	if (efuse->crystal_cap == 0xff)
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  219  		efuse->crystal_cap = 0x20;
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  220  	efuse->pa_type_2g = map->pa_type;
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  221  	efuse->pa_type_5g = map->pa_type;
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  222  	efuse->lna_type_2g = map->lna_type_2g;
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  223  	efuse->lna_type_5g = map->lna_type_5g;
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  224  	if (chip->id == RTW_CHIP_TYPE_8812A) {
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  225  		rtw8812a_read_amplifier_type(rtwdev);
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  226  		rtw8812a_read_rfe_type(rtwdev, map);
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  227  
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  228  		efuse->usb_mode_switch = u8_get_bits(map->usb_mode, BIT(1));
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  229  	}
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  230  	efuse->channel_plan = map->channel_plan;
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  231  	efuse->country_code[0] = map->country_code[0];
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  232  	efuse->country_code[1] = map->country_code[1];
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  233  	efuse->bt_setting = map->rf_bt_setting;
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  234  	efuse->regd = map->rf_board_option & 0x7;
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  235  	efuse->thermal_meter[0] = map->thermal_meter;
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  236  	efuse->thermal_meter[1] = map->thermal_meter;
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  237  	efuse->thermal_meter_k = map->thermal_meter;
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  238  	efuse->tx_bb_swing_setting_2g = map->tx_bb_swing_setting_2g;
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  239  	efuse->tx_bb_swing_setting_5g = map->tx_bb_swing_setting_5g;
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  240  
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  241  	rtw88xxa_read_usb_type(rtwdev);
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  242  
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  243  	if (chip->id == RTW_CHIP_TYPE_8821A)
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  244  		efuse->btcoex = rtw_read32_mask(rtwdev, REG_WL_BT_PWR_CTRL,
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  245  						BIT_BT_FUNC_EN);
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  246  	else
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  247  		efuse->btcoex = (map->rf_board_option & 0xe0) == 0x20;
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  248  	efuse->share_ant = !!(efuse->bt_setting & BIT(0));
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  249  
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  250  	/* No antenna diversity because it's disabled in the vendor driver */
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  251  	efuse->ant_div_cfg = 0;
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  252  
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  253  	efuse->ant_div_type = map->rf_antenna_option;
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  254  	if (efuse->ant_div_type == 0xff)
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  255  		efuse->ant_div_type = 0x3;
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  256  
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  257  	for (i = 0; i < 4; i++)
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  258  		efuse->txpwr_idx_table[i] = map->txpwr_idx_table[i];
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  259  
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  260  	switch (rtw_hci_type(rtwdev)) {
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  261  	case RTW_HCI_TYPE_USB:
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  262  		if (chip->id == RTW_CHIP_TYPE_8821A)
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  263  			ether_addr_copy(efuse->addr, map->rtw8821au.mac_addr);
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  264  		else
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  265  			ether_addr_copy(efuse->addr, map->rtw8812au.mac_addr);
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  266  		break;
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  267  	case RTW_HCI_TYPE_PCIE:
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  268  	case RTW_HCI_TYPE_SDIO:
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  269  	default:
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  270  		/* unsupported now */
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  271  		return -EOPNOTSUPP;
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  272  	}
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  273  
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  274  	return 0;
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  275  }
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  276  EXPORT_SYMBOL(rtw88xxa_read_efuse);
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  277  
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  278  static void rtw88xxa_reset_8051(struct rtw_dev *rtwdev)
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  279  {
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  280  	const struct rtw_chip_info *chip = rtwdev->chip;
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  281  	u8 val8;
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  282  
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  283  	/* Reset MCU IO Wrapper */
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  284  	rtw_write8_clr(rtwdev, REG_RSV_CTRL, BIT(1));
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  285  	if (chip->id == RTW_CHIP_TYPE_8812A)
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  286  		rtw_write8_clr(rtwdev, REG_RSV_CTRL + 1, BIT(3));
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  287  	else
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  288  		rtw_write8_clr(rtwdev, REG_RSV_CTRL + 1, BIT(0));
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  289  
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  290  	val8 = rtw_read8(rtwdev, REG_SYS_FUNC_EN + 1);
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  291  	rtw_write8(rtwdev, REG_SYS_FUNC_EN + 1, val8 & ~BIT(2));
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  292  
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  293  	/* Enable MCU IO Wrapper */
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  294  	rtw_write8_clr(rtwdev, REG_RSV_CTRL, BIT(1));
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  295  	if (chip->id == RTW_CHIP_TYPE_8812A)
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  296  		rtw_write8_set(rtwdev, REG_RSV_CTRL + 1, BIT(3));
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  297  	else
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  298  		rtw_write8_set(rtwdev, REG_RSV_CTRL + 1, BIT(0));
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  299  
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  300  	rtw_write8(rtwdev, REG_SYS_FUNC_EN + 1, val8 | BIT(2));
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  301  }
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  302  
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  303  /* A lightweight deinit function */
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  304  static void rtw88xxau_hw_reset(struct rtw_dev *rtwdev)
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  305  {
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  306  	u8 val8;
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  307  
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  308  	if (!(rtw_read8(rtwdev, REG_MCUFW_CTRL) & BIT_RAM_DL_SEL))
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  309  		return;
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  310  
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  311  	rtw88xxa_reset_8051(rtwdev);
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  312  	rtw_write8(rtwdev, REG_MCUFW_CTRL, 0x00);
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  313  
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  314  	/* before BB reset should do clock gated */
0810de4fd8fcd8 Bitterblue Smith 2024-10-30 @315  	rtw_write32_set(rtwdev, REG_FPGA0_XCD_RF_PARA, BIT(6));
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  316  
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  317  	/* reset BB */
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  318  	rtw_write8_clr(rtwdev, REG_SYS_FUNC_EN, BIT(0) | BIT(1));
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  319  
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  320  	/* reset RF */
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  321  	rtw_write8(rtwdev, REG_RF_CTRL, 0);
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  322  
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  323  	/* reset TRX path */
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  324  	rtw_write16(rtwdev, REG_CR, 0);
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  325  
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  326  	/* reset MAC, reg0x5[1], auto FSM off */
0810de4fd8fcd8 Bitterblue Smith 2024-10-30 @327  	rtw_write8_set(rtwdev, REG_APS_FSMCO + 1, APS_FSMCO_MAC_OFF >> 8);
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  328  
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  329  	/* check if reg0x5[1] auto cleared */
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  330  	if (read_poll_timeout_atomic(rtw_read8, val8,
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  331  				     !(val8 & (APS_FSMCO_MAC_OFF >> 8)),
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  332  				     1, 5000, false,
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  333  				     rtwdev, REG_APS_FSMCO + 1))
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  334  		rtw_err(rtwdev, "%s: timed out waiting for 0x5[1]\n", __func__);
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  335  
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  336  	/* reg0x5[0], auto FSM on */
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  337  	val8 |= APS_FSMCO_MAC_ENABLE >> 8;
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  338  	rtw_write8(rtwdev, REG_APS_FSMCO + 1, val8);
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  339  
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  340  	rtw_write8_clr(rtwdev, REG_SYS_FUNC_EN + 1, BIT(4) | BIT(7));
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  341  	rtw_write8_set(rtwdev, REG_SYS_FUNC_EN + 1, BIT(4) | BIT(7));
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  342  }
0810de4fd8fcd8 Bitterblue Smith 2024-10-30  343  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

