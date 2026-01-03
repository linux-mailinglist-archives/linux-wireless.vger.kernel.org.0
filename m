Return-Path: <linux-wireless+bounces-30311-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 34502CF0147
	for <lists+linux-wireless@lfdr.de>; Sat, 03 Jan 2026 15:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2E295300D90D
	for <lists+linux-wireless@lfdr.de>; Sat,  3 Jan 2026 14:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE6E41C72;
	Sat,  3 Jan 2026 14:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EY1T74pL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C303FF1
	for <linux-wireless@vger.kernel.org>; Sat,  3 Jan 2026 14:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767451883; cv=none; b=fFXAH7s4Ol43KPPx4468nYvxPTxjFz0YKxGk3Mm5jpnlQMwhwu2HAPTz66B6otwgvl97pLPaLuEi+dQCOSwDXhSFoSbArI3zF1OP5+LVxvHRKVhhqVmItZBSHErzdcxzyzjdXWbFF9nAJe/EomWeZb11UfIc8rE5n84mqVCySSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767451883; c=relaxed/simple;
	bh=HokdTjQTkH/K8hLydFkoA+NfRpl0yYW4PerQ8Z6efms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zs3+P1DV3HZFHoSMFqirwrSLUKaS67FiR22VUmVoqMO1TqvMJNJgV0U0w4x9gb93SuqeYe2qN6DIIE4A31WNAmlNg+y8DL5uDgEtbBtM329PPt11cVEN2w2o6F+2i+A7nY3OZVER2AVs3E6aUoCUyNsC0UYmMQMYFJ6ziC4gC10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EY1T74pL; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767451880; x=1798987880;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HokdTjQTkH/K8hLydFkoA+NfRpl0yYW4PerQ8Z6efms=;
  b=EY1T74pLtpqgmOOesgNCCnW+9Qvx0Oi1uH/ArBlyiwIsC5E83K0nFUCA
   DzueaRHv/OO+luZssQsQKWmGdeWvNXNVNePcHiqVM3LNPI58zSGWPaZB3
   bsNwgaACgz7FbrZH0tWjsIy07iQeID7RN7dzNGWoyU13jCryWa/fVy3Xz
   NYWusqGy3O1/3esNblniCqmLyGuLBHZFEOZXiyY793EdZH4ogxgAsnCwH
   KG811UaE3FF43sLSZ1NDD9FAhxM3GU8kyAcwi4utm8bAtCNj8rKq/yyqy
   7fbOxLnByFmidpzDxC6EFU1ProvaNpV7ASrGeh/T1IHSIQLqhBm61e1Dh
   A==;
X-CSE-ConnectionGUID: HHLNI0p3RN6doBUI1xyviw==
X-CSE-MsgGUID: gwDtReIZTleDhnpKjBui5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11659"; a="68809608"
X-IronPort-AV: E=Sophos;i="6.21,198,1763452800"; 
   d="scan'208";a="68809608"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2026 06:51:20 -0800
X-CSE-ConnectionGUID: cGiK4lpsRyOLgYgIZWPWEA==
X-CSE-MsgGUID: izYlD1ayT9SQdOZKt0cHYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,198,1763452800"; 
   d="scan'208";a="239469131"
Received: from igk-lkp-server01.igk.intel.com (HELO 92b2e8bd97aa) ([10.211.93.152])
  by orviesa001.jf.intel.com with ESMTP; 03 Jan 2026 06:51:19 -0800
Received: from kbuild by 92b2e8bd97aa with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vc2yK-000000000iT-3ZTY;
	Sat, 03 Jan 2026 14:51:16 +0000
Date: Sat, 3 Jan 2026 15:50:29 +0100
From: kernel test robot <lkp@intel.com>
To: Ping-Ke Shih <pkshih@realtek.com>, linux-wireless@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH rtw-next 04/10] wifi: rtw89: fw: add CMAC H2C command to
 initialize default value for RTL8922D
Message-ID: <202601031501.eUFh59B7-lkp@intel.com>
References: <20260102070840.62047-5-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260102070840.62047-5-pkshih@realtek.com>

Hi Ping-Ke,

kernel test robot noticed the following build errors:

[auto build test ERROR on wireless-next/main]
[also build test ERROR on wireless/main linus/master v6.19-rc3 next-20251219]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ping-Ke-Shih/wifi-rtw89-update-TXWD-v3-for-RTL8922D/20260102-152315
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/20260102070840.62047-5-pkshih%40realtek.com
patch subject: [PATCH rtw-next 04/10] wifi: rtw89: fw: add CMAC H2C command to initialize default value for RTL8922D
config: x86_64-rhel-9.4-ltp (https://download.01.org/0day-ci/archive/20260103/202601031501.eUFh59B7-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260103/202601031501.eUFh59B7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601031501.eUFh59B7-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/net/wireless/realtek/rtw89/core.c:14:
   drivers/net/wireless/realtek/rtw89/mac.h: In function 'rtw89_mac_chk_preload_allow':
>> drivers/net/wireless/realtek/rtw89/mac.h:1728:61: error: 'struct rtw89_hal' has no member named 'cid'
    1728 |         if (rtwdev->chip->chip_id == RTL8922D && rtwdev->hal.cid == RTL8922D_CID7090)
         |                                                             ^
>> drivers/net/wireless/realtek/rtw89/mac.h:1728:69: error: 'RTL8922D_CID7090' undeclared (first use in this function)
    1728 |         if (rtwdev->chip->chip_id == RTL8922D && rtwdev->hal.cid == RTL8922D_CID7090)
         |                                                                     ^~~~~~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw89/mac.h:1728:69: note: each undeclared identifier is reported only once for each function it appears in


vim +1728 drivers/net/wireless/realtek/rtw89/mac.h

  1722	
  1723	static inline bool rtw89_mac_chk_preload_allow(struct rtw89_dev *rtwdev)
  1724	{
  1725		if (rtwdev->hci.type != RTW89_HCI_TYPE_PCIE)
  1726			return false;
  1727	
> 1728		if (rtwdev->chip->chip_id == RTL8922D && rtwdev->hal.cid == RTL8922D_CID7090)
  1729			return true;
  1730	
  1731		return false;
  1732	}
  1733	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

