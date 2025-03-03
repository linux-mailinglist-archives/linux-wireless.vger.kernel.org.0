Return-Path: <linux-wireless+bounces-19720-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2878A4C724
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Mar 2025 17:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E849918822A4
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Mar 2025 16:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0ED2144B8;
	Mon,  3 Mar 2025 16:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SjvXHrwv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7503D212B3D;
	Mon,  3 Mar 2025 16:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019323; cv=none; b=ary+z9A6zTtiggtXcAKqmJztwh7109Zv99gq8jfpk0h/yxOJMoscAb0nWx/icv8TXsixYisGKPbz9uqgeoAc2TsNDQp4e62zq0j58aowIq/q1LqlygsJLJxiwDm8xIeZYvDL8J/Mn9gG3aEybFug/UHNdau7O7w30LD0aY7DVgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019323; c=relaxed/simple;
	bh=J5EtA/Az2layFK05Zi38pVT1Q9DK/AR0BrKgNVOOc18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mgdRvT/DJ5/p7etrQYwWWNKBCDnJ3KWChM+JezZnlqb0IXalTNwTDR3MvCmJtjNza/EA/Ag7Po8zre9qk6CojJzZ5BE/3ZBTQah0OsqvuhnT1e/pYqZ1KRasB5bWQRor8cdTs4RIGZkfaJ7dgPnPOsaaLkojaiKMkXKRxTI2ans=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SjvXHrwv; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741019321; x=1772555321;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=J5EtA/Az2layFK05Zi38pVT1Q9DK/AR0BrKgNVOOc18=;
  b=SjvXHrwvRdaNu28D5lC8hUa8I9NZTZGBhhHZUTPXge00drcX6x256Swp
   OFyQ3h7n2wJv1G3fGHfx9MtvRuRuhFSHuJtsCTHhIl2nMiqqx8v3oskmp
   MGOmrSvgDD0jYlE7al527WVYDXCe67n4RNtLdW2oXjTYeMCBNgie3bGGn
   pLVeVrdH9fp+8yZm47Ici/qkfwdVFOwj0ag6/6Sz79wMrQT9Yb1/srVkB
   if6VlnSoM4T1+Js5fd6jhv0UlT50bM27m1EtETRDGf49zfdLLBx08af6p
   g+bjZu/F7XXyv3ejMi6KekhemHwwA9pVHMB0XK+DxGYYbaSlcn/uFHmHK
   g==;
X-CSE-ConnectionGUID: 7pOwtDWAQlGLZEQ4nDSCvw==
X-CSE-MsgGUID: ynd1arjsR5KcSjTyklwrxQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="45678100"
X-IronPort-AV: E=Sophos;i="6.13,330,1732608000"; 
   d="scan'208";a="45678100"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 08:28:41 -0800
X-CSE-ConnectionGUID: L4NPymhCQkiV0f3PQEDx/g==
X-CSE-MsgGUID: vdQYtlmNTOKwDcV7NkYQLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="155262530"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 03 Mar 2025 08:28:39 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tp8ef-000IiN-0N;
	Mon, 03 Mar 2025 16:28:34 +0000
Date: Tue, 4 Mar 2025 00:28:14 +0800
From: kernel test robot <lkp@intel.com>
To: =?iso-8859-1?B?Suly9G1l?= Pouiller <jerome.pouiller@silabs.com>,
	linux-wireless@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Kalle Valo <kvalo@kernel.org>, linux-devel@silabs.com,
	=?iso-8859-1?B?Suly9G1l?= Pouiller <jerome.pouiller@silabs.com>
Subject: Re: [PATCH v2 2/5] wifi: wfx: declare support for WoWLAN
Message-ID: <202503032358.4QbNFRfz-lkp@intel.com>
References: <20250302144731.117409-3-jerome.pouiller@silabs.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250302144731.117409-3-jerome.pouiller@silabs.com>

Hi Jérôme,

kernel test robot noticed the following build warnings:

[auto build test WARNING on wireless-next/main]
[also build test WARNING on wireless/main linus/master v6.14-rc5 next-20250303]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/J-r-me-Pouiller/wifi-wfx-align-declarations-between-bus_spi-c-and-bus_sdio-c/20250302-231700
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/20250302144731.117409-3-jerome.pouiller%40silabs.com
patch subject: [PATCH v2 2/5] wifi: wfx: declare support for WoWLAN
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20250303/202503032358.4QbNFRfz-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250303/202503032358.4QbNFRfz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503032358.4QbNFRfz-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/wireless/silabs/wfx/main.c:124:42: warning: 'wfx_wowlan_support' defined but not used [-Wunused-const-variable=]
     124 | static const struct wiphy_wowlan_support wfx_wowlan_support = {
         |                                          ^~~~~~~~~~~~~~~~~~


vim +/wfx_wowlan_support +124 drivers/net/wireless/silabs/wfx/main.c

   123	
 > 124	static const struct wiphy_wowlan_support wfx_wowlan_support = {
   125		.flags = WIPHY_WOWLAN_ANY | WIPHY_WOWLAN_DISCONNECT,
   126	};
   127	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

