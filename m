Return-Path: <linux-wireless+bounces-23941-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6E2AD3ADD
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Jun 2025 16:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B551C7A6147
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Jun 2025 14:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDEE828D8FE;
	Tue, 10 Jun 2025 14:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XTrWZXQ2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F185829CB4B
	for <linux-wireless@vger.kernel.org>; Tue, 10 Jun 2025 14:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749564742; cv=none; b=HVlyE0rywZpgacMDguIPUn1aI7yFSDW3uxDwfbS91Hh/WBGB4fgUHyeGyyLi2z4pqjdXMZ6jemrUm/NOuqn2+ZymVWug8Fv41DRhRDFyEOTdhOdHNk+RuAt4q54FAGVpSw9WIndUDqfjvJj6dKO/3PGhGW0Z6CWZazymjd8SAnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749564742; c=relaxed/simple;
	bh=0xDWz6BS61zO0acJLmxRTJIzULpVZThwsUJJWP+IKro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FMXcdBJoObIYm7sCO64Hcgdd7D8I76mH6sDT/9b5bNHPJgNAMmgBnSngEKWrZM4I3jWTonx1umRUB9MEecmkrCj293AXzWD1M95TLSuKh5s1WBoycFEfhUSb3eOAeuJiFoitW/vheqL9IF20emeN1dFSxngu1R5q7ZKt64ku02Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XTrWZXQ2; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749564740; x=1781100740;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0xDWz6BS61zO0acJLmxRTJIzULpVZThwsUJJWP+IKro=;
  b=XTrWZXQ2GGSFIGMMVdVL6v0jT/EGVgpkdYThJoP1fvyDmmwx7EkO3fMb
   LGo2dXafOmwZqB+J8vQTr5iW6EQ7WvchuDDYPZcOPeQxlmfrwfGPqClKf
   uC/I1KwlpK7M6o8eVKX+WdavUBR+wfo2gsyAbvOsb8vSAh8grH3+U9DAK
   Fqjd2ekKSYUCyJJ3Ygx3WbdqUKS46cMt8O9JcN0RIyGw5rhJAcTZywDpW
   a3KafB+wTlTwZkWZa3XqG2NEbwaFS3HyXnJJCf4zW/kslc7aPQvxP4pMQ
   kwwRNciTHrQwcmQmz2DQxsCRkuXli3F0wEw23OUoYWx418Zo+/xqYqdM0
   g==;
X-CSE-ConnectionGUID: QzvPVe4yTuOPtmaXfhYfNQ==
X-CSE-MsgGUID: hbeNVQZ8TH2ySqz2j6HBOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="50785517"
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; 
   d="scan'208";a="50785517"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 07:12:19 -0700
X-CSE-ConnectionGUID: kZxW7cYYSVSINC/iVpU36Q==
X-CSE-MsgGUID: ei5h4Pa6Q0GJYGhfRJoE3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; 
   d="scan'208";a="150697388"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 10 Jun 2025 07:12:19 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uOzi4-0008KH-03;
	Tue, 10 Jun 2025 14:12:16 +0000
Date: Tue, 10 Jun 2025 22:11:57 +0800
From: kernel test robot <lkp@intel.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Ping-Ke Shih <pkshih@realtek.com>
Subject: Re: [PATCH rtw-next v2 09/14] wifi: rtw89: 8851b: Modify
 rtw8851b_pwr_{on,off}_func() for USB
Message-ID: <202506102119.fyp9p96Z-lkp@intel.com>
References: <c1ff2155-ef01-466e-9c34-4437ee57656c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1ff2155-ef01-466e-9c34-4437ee57656c@gmail.com>

Hi Bitterblue,

kernel test robot noticed the following build errors:

[auto build test ERROR on wireless-next/main]
[also build test ERROR on wireless/main linus/master v6.16-rc1 next-20250610]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bitterblue-Smith/wifi-rtw89-8851b-Accept-USB-devices-and-load-their-MAC-address/20250610-033543
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/c1ff2155-ef01-466e-9c34-4437ee57656c%40gmail.com
patch subject: [PATCH rtw-next v2 09/14] wifi: rtw89: 8851b: Modify rtw8851b_pwr_{on,off}_func() for USB
config: loongarch-loongson3_defconfig (https://download.01.org/0day-ci/archive/20250610/202506102119.fyp9p96Z-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250610/202506102119.fyp9p96Z-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506102119.fyp9p96Z-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/wireless/realtek/rtw89/rtw8851b.c: In function 'rtw8851b_pwr_off_func':
>> drivers/net/wireless/realtek/rtw89/rtw8851b.c:523:61: error: 'B_AX_SOP_EDSWR' undeclared (first use in this function); did you mean 'B_BE_SOP_EDSWR'?
     523 |                 rtw89_write32_clr(rtwdev, R_AX_SYS_PW_CTRL, B_AX_SOP_EDSWR);
         |                                                             ^~~~~~~~~~~~~~
         |                                                             B_BE_SOP_EDSWR
   drivers/net/wireless/realtek/rtw89/rtw8851b.c:523:61: note: each undeclared identifier is reported only once for each function it appears in


vim +523 drivers/net/wireless/realtek/rtw89/rtw8851b.c

   477	
   478	static int rtw8851b_pwr_off_func(struct rtw89_dev *rtwdev)
   479	{
   480		u32 val32;
   481		int ret;
   482	
   483		ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_ANAPAR_WL, XTAL_SI_RFC2RF,
   484					      XTAL_SI_RFC2RF);
   485		if (ret)
   486			return ret;
   487		ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_ANAPAR_WL, 0, XTAL_SI_OFF_EI);
   488		if (ret)
   489			return ret;
   490		ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_ANAPAR_WL, 0, XTAL_SI_OFF_WEI);
   491		if (ret)
   492			return ret;
   493		ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_WL_RFC_S0, 0, XTAL_SI_RF00);
   494		if (ret)
   495			return ret;
   496		ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_ANAPAR_WL, XTAL_SI_SRAM2RFC,
   497					      XTAL_SI_SRAM2RFC);
   498		if (ret)
   499			return ret;
   500		ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_ANAPAR_WL, 0, XTAL_SI_PON_EI);
   501		if (ret)
   502			return ret;
   503		ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_ANAPAR_WL, 0, XTAL_SI_PON_WEI);
   504		if (ret)
   505			return ret;
   506	
   507		rtw89_write32_set(rtwdev, R_AX_WLAN_XTAL_SI_CONFIG,
   508				  B_AX_XTAL_SI_ADDR_NOT_CHK);
   509		rtw89_write32_set(rtwdev, R_AX_SYS_PW_CTRL, B_AX_EN_WLON);
   510		rtw89_write32_clr(rtwdev, R_AX_WLRF_CTRL, B_AX_AFC_AFEDIG);
   511		rtw89_write8_clr(rtwdev, R_AX_SYS_FUNC_EN, B_AX_FEN_BB_GLB_RSTN | B_AX_FEN_BBRSTB);
   512	
   513		rtw89_write32_set(rtwdev, R_AX_SYS_PW_CTRL, B_AX_APFM_OFFMAC);
   514	
   515		ret = read_poll_timeout(rtw89_read32, val32, !(val32 & B_AX_APFM_OFFMAC),
   516					1000, 20000, false, rtwdev, R_AX_SYS_PW_CTRL);
   517		if (ret)
   518			return ret;
   519	
   520		if (rtwdev->hci.type == RTW89_HCI_TYPE_PCIE)
   521			rtw89_write32(rtwdev, R_AX_WLLPS_CTRL, SW_LPS_OPTION);
   522		else if (rtwdev->hci.type == RTW89_HCI_TYPE_USB)
 > 523			rtw89_write32_clr(rtwdev, R_AX_SYS_PW_CTRL, B_AX_SOP_EDSWR);
   524	
   525		if (rtwdev->hal.cv == CHIP_CAV) {
   526			rtw8851b_patch_swr_pfm2pwm(rtwdev);
   527		} else {
   528			rtw89_write32_set(rtwdev, R_AX_SPSLDO_ON_CTRL1, B_AX_FPWMDELAY);
   529			rtw89_write32_set(rtwdev, R_AX_SPSANA_ON_CTRL1, B_AX_FPWMDELAY);
   530		}
   531	
   532		if (rtwdev->hci.type == RTW89_HCI_TYPE_PCIE) {
   533			rtw89_write32_set(rtwdev, R_AX_SYS_PW_CTRL, B_AX_APFM_SWLPS);
   534		} else if (rtwdev->hci.type == RTW89_HCI_TYPE_USB) {
   535			val32 = rtw89_read32(rtwdev, R_AX_SYS_PW_CTRL);
   536			val32 &= ~B_AX_AFSM_PCIE_SUS_EN;
   537			val32 |= B_AX_AFSM_WLSUS_EN;
   538			rtw89_write32(rtwdev, R_AX_SYS_PW_CTRL, val32);
   539		}
   540	
   541		return 0;
   542	}
   543	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

