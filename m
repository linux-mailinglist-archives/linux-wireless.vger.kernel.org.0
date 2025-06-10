Return-Path: <linux-wireless+bounces-23925-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F16AD355D
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Jun 2025 13:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06A67175448
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Jun 2025 11:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A1A229B2B;
	Tue, 10 Jun 2025 11:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lP+F2td/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44632288C3
	for <linux-wireless@vger.kernel.org>; Tue, 10 Jun 2025 11:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749556570; cv=none; b=Dip3Qef4oi/wPF++5LWWjy+MHqenWuADXU1IV9UX4DDXCFN5wrGSFUBmE82OelTpR+nMu+W7eQpfv2GwlpBp8tRgCXKObjegqD0FctTl3nezji/542mmqK788Cv6zALrvbjW4mXM6rWkc2dqkcdVayi4bmjQEYwl4qVJw1GKgXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749556570; c=relaxed/simple;
	bh=zxAz+dMcvZ+ywC1iMO5sYUPbLxvHiurLWur4uytCCqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a65DwAOGyt0BlO1etjjmpvToc+JVM4e4vZQgO0zclFmKM81809cSgxAkwL/Yk2RTUu3qBGa+3XC8mprE4/h3V20X9MiBPvaXyJ+91lku5UJvxNCr4b7+jNwWzws5kFWjeARvB89ie8oRBbu3tiWQkD/kIj2PxS4wjW04AoLbW6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lP+F2td/; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749556566; x=1781092566;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zxAz+dMcvZ+ywC1iMO5sYUPbLxvHiurLWur4uytCCqk=;
  b=lP+F2td/+/fo7LJTIWucPPtFSwy3TCmRC1ka+tPdPq6SGC1E4jTS7tmN
   kgQxqlsUlVv3G7AMvz95p1iQSftgiJmJ3ygx3aKOf7Eyh3LxvUb8K0GDu
   nxOFvPZBGsh+f3cVjh0fLdOPVByjpozg0e3NwPq+fnMx0pLBW6EUfKHhZ
   6T2CqB7ZtG8Z3LVudS9MMKdt8IGjRGvDN4XOFjKaQZ2/eYQ4H/XHY0y3Y
   DVQqaReljrxQvgqSmC999MaagmBbfHtBF+QnODMmAg8jeoW+FIaVWidJy
   Jt3eMYHLpmayUDc63Wpng7KQk+nOrokPuTx79TZktOxAAVm0SqE9bOMQh
   Q==;
X-CSE-ConnectionGUID: afdgebnUThKF0lMSsQz0JQ==
X-CSE-MsgGUID: xWyrArNsS32/QbByvNfQmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="51803146"
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; 
   d="scan'208";a="51803146"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 04:56:05 -0700
X-CSE-ConnectionGUID: viw+LNQmSaedU/cJOvR4hg==
X-CSE-MsgGUID: evbliLw5QRa2vk/aWLX6wQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; 
   d="scan'208";a="177750199"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 10 Jun 2025 04:56:03 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uOxaD-00089t-0h;
	Tue, 10 Jun 2025 11:56:01 +0000
Date: Tue, 10 Jun 2025 19:55:52 +0800
From: kernel test robot <lkp@intel.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Ping-Ke Shih <pkshih@realtek.com>
Subject: Re: [PATCH rtw-next v2 14/14] wifi: rtw89: Enable the new USB modules
Message-ID: <202506101956.cNXM2Qvb-lkp@intel.com>
References: <663044d3-0816-4b1b-874d-776835e774e9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <663044d3-0816-4b1b-874d-776835e774e9@gmail.com>

Hi Bitterblue,

kernel test robot noticed the following build errors:

[auto build test ERROR on wireless-next/main]
[also build test ERROR on wireless/main linus/master v6.16-rc1 next-20250610]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bitterblue-Smith/wifi-rtw89-8851b-Accept-USB-devices-and-load-their-MAC-address/20250610-033543
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/663044d3-0816-4b1b-874d-776835e774e9%40gmail.com
patch subject: [PATCH rtw-next v2 14/14] wifi: rtw89: Enable the new USB modules
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20250610/202506101956.cNXM2Qvb-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250610/202506101956.cNXM2Qvb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506101956.cNXM2Qvb-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/wireless/realtek/rtw89/rtw8851b.c:523:47: error: use of undeclared identifier 'B_AX_SOP_EDSWR'
     523 |                 rtw89_write32_clr(rtwdev, R_AX_SYS_PW_CTRL, B_AX_SOP_EDSWR);
         |                                                             ^
   1 error generated.


vim +/B_AX_SOP_EDSWR +523 drivers/net/wireless/realtek/rtw89/rtw8851b.c

31df6df89f9394 Ping-Ke Shih     2023-05-12  477  
31df6df89f9394 Ping-Ke Shih     2023-05-12  478  static int rtw8851b_pwr_off_func(struct rtw89_dev *rtwdev)
31df6df89f9394 Ping-Ke Shih     2023-05-12  479  {
31df6df89f9394 Ping-Ke Shih     2023-05-12  480  	u32 val32;
66595e31988626 Ping-Ke Shih     2024-10-09  481  	int ret;
31df6df89f9394 Ping-Ke Shih     2023-05-12  482  
31df6df89f9394 Ping-Ke Shih     2023-05-12  483  	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_ANAPAR_WL, XTAL_SI_RFC2RF,
31df6df89f9394 Ping-Ke Shih     2023-05-12  484  				      XTAL_SI_RFC2RF);
31df6df89f9394 Ping-Ke Shih     2023-05-12  485  	if (ret)
31df6df89f9394 Ping-Ke Shih     2023-05-12  486  		return ret;
31df6df89f9394 Ping-Ke Shih     2023-05-12  487  	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_ANAPAR_WL, 0, XTAL_SI_OFF_EI);
31df6df89f9394 Ping-Ke Shih     2023-05-12  488  	if (ret)
31df6df89f9394 Ping-Ke Shih     2023-05-12  489  		return ret;
31df6df89f9394 Ping-Ke Shih     2023-05-12  490  	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_ANAPAR_WL, 0, XTAL_SI_OFF_WEI);
31df6df89f9394 Ping-Ke Shih     2023-05-12  491  	if (ret)
31df6df89f9394 Ping-Ke Shih     2023-05-12  492  		return ret;
31df6df89f9394 Ping-Ke Shih     2023-05-12  493  	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_WL_RFC_S0, 0, XTAL_SI_RF00);
31df6df89f9394 Ping-Ke Shih     2023-05-12  494  	if (ret)
31df6df89f9394 Ping-Ke Shih     2023-05-12  495  		return ret;
31df6df89f9394 Ping-Ke Shih     2023-05-12  496  	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_ANAPAR_WL, XTAL_SI_SRAM2RFC,
31df6df89f9394 Ping-Ke Shih     2023-05-12  497  				      XTAL_SI_SRAM2RFC);
31df6df89f9394 Ping-Ke Shih     2023-05-12  498  	if (ret)
31df6df89f9394 Ping-Ke Shih     2023-05-12  499  		return ret;
31df6df89f9394 Ping-Ke Shih     2023-05-12  500  	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_ANAPAR_WL, 0, XTAL_SI_PON_EI);
31df6df89f9394 Ping-Ke Shih     2023-05-12  501  	if (ret)
31df6df89f9394 Ping-Ke Shih     2023-05-12  502  		return ret;
31df6df89f9394 Ping-Ke Shih     2023-05-12  503  	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_ANAPAR_WL, 0, XTAL_SI_PON_WEI);
31df6df89f9394 Ping-Ke Shih     2023-05-12  504  	if (ret)
31df6df89f9394 Ping-Ke Shih     2023-05-12  505  		return ret;
31df6df89f9394 Ping-Ke Shih     2023-05-12  506  
31df6df89f9394 Ping-Ke Shih     2023-05-12  507  	rtw89_write32_set(rtwdev, R_AX_WLAN_XTAL_SI_CONFIG,
31df6df89f9394 Ping-Ke Shih     2023-05-12  508  			  B_AX_XTAL_SI_ADDR_NOT_CHK);
31df6df89f9394 Ping-Ke Shih     2023-05-12  509  	rtw89_write32_set(rtwdev, R_AX_SYS_PW_CTRL, B_AX_EN_WLON);
31df6df89f9394 Ping-Ke Shih     2023-05-12  510  	rtw89_write32_clr(rtwdev, R_AX_WLRF_CTRL, B_AX_AFC_AFEDIG);
31df6df89f9394 Ping-Ke Shih     2023-05-12  511  	rtw89_write8_clr(rtwdev, R_AX_SYS_FUNC_EN, B_AX_FEN_BB_GLB_RSTN | B_AX_FEN_BBRSTB);
31df6df89f9394 Ping-Ke Shih     2023-05-12  512  
31df6df89f9394 Ping-Ke Shih     2023-05-12  513  	rtw89_write32_set(rtwdev, R_AX_SYS_PW_CTRL, B_AX_APFM_OFFMAC);
31df6df89f9394 Ping-Ke Shih     2023-05-12  514  
31df6df89f9394 Ping-Ke Shih     2023-05-12  515  	ret = read_poll_timeout(rtw89_read32, val32, !(val32 & B_AX_APFM_OFFMAC),
31df6df89f9394 Ping-Ke Shih     2023-05-12  516  				1000, 20000, false, rtwdev, R_AX_SYS_PW_CTRL);
31df6df89f9394 Ping-Ke Shih     2023-05-12  517  	if (ret)
31df6df89f9394 Ping-Ke Shih     2023-05-12  518  		return ret;
31df6df89f9394 Ping-Ke Shih     2023-05-12  519  
cb97e6b5232342 Bitterblue Smith 2025-06-09  520  	if (rtwdev->hci.type == RTW89_HCI_TYPE_PCIE)
31df6df89f9394 Ping-Ke Shih     2023-05-12  521  		rtw89_write32(rtwdev, R_AX_WLLPS_CTRL, SW_LPS_OPTION);
cb97e6b5232342 Bitterblue Smith 2025-06-09  522  	else if (rtwdev->hci.type == RTW89_HCI_TYPE_USB)
cb97e6b5232342 Bitterblue Smith 2025-06-09 @523  		rtw89_write32_clr(rtwdev, R_AX_SYS_PW_CTRL, B_AX_SOP_EDSWR);
31df6df89f9394 Ping-Ke Shih     2023-05-12  524  
31df6df89f9394 Ping-Ke Shih     2023-05-12  525  	if (rtwdev->hal.cv == CHIP_CAV) {
31df6df89f9394 Ping-Ke Shih     2023-05-12  526  		rtw8851b_patch_swr_pfm2pwm(rtwdev);
31df6df89f9394 Ping-Ke Shih     2023-05-12  527  	} else {
31df6df89f9394 Ping-Ke Shih     2023-05-12  528  		rtw89_write32_set(rtwdev, R_AX_SPSLDO_ON_CTRL1, B_AX_FPWMDELAY);
31df6df89f9394 Ping-Ke Shih     2023-05-12  529  		rtw89_write32_set(rtwdev, R_AX_SPSANA_ON_CTRL1, B_AX_FPWMDELAY);
31df6df89f9394 Ping-Ke Shih     2023-05-12  530  	}
31df6df89f9394 Ping-Ke Shih     2023-05-12  531  
cb97e6b5232342 Bitterblue Smith 2025-06-09  532  	if (rtwdev->hci.type == RTW89_HCI_TYPE_PCIE) {
31df6df89f9394 Ping-Ke Shih     2023-05-12  533  		rtw89_write32_set(rtwdev, R_AX_SYS_PW_CTRL, B_AX_APFM_SWLPS);
cb97e6b5232342 Bitterblue Smith 2025-06-09  534  	} else if (rtwdev->hci.type == RTW89_HCI_TYPE_USB) {
cb97e6b5232342 Bitterblue Smith 2025-06-09  535  		val32 = rtw89_read32(rtwdev, R_AX_SYS_PW_CTRL);
cb97e6b5232342 Bitterblue Smith 2025-06-09  536  		val32 &= ~B_AX_AFSM_PCIE_SUS_EN;
cb97e6b5232342 Bitterblue Smith 2025-06-09  537  		val32 |= B_AX_AFSM_WLSUS_EN;
cb97e6b5232342 Bitterblue Smith 2025-06-09  538  		rtw89_write32(rtwdev, R_AX_SYS_PW_CTRL, val32);
cb97e6b5232342 Bitterblue Smith 2025-06-09  539  	}
31df6df89f9394 Ping-Ke Shih     2023-05-12  540  
31df6df89f9394 Ping-Ke Shih     2023-05-12  541  	return 0;
31df6df89f9394 Ping-Ke Shih     2023-05-12  542  }
31df6df89f9394 Ping-Ke Shih     2023-05-12  543  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

