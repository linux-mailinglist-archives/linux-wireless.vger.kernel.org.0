Return-Path: <linux-wireless+bounces-10374-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D5D937362
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jul 2024 07:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1FE41C20B58
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jul 2024 05:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79EA439855;
	Fri, 19 Jul 2024 05:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RgPmuE6R"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE326A35
	for <linux-wireless@vger.kernel.org>; Fri, 19 Jul 2024 05:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721368571; cv=none; b=KxDc9v1vil0Hy36CIe90Gm7adNFazSUclSr8bgUzYsAse0XFipksx5S+uYDuqupZTejR3bsqOdtuf4STLQNZeA1u5S7o5cbBfbZzo4JIXZ1yuufuKF/hVA0oRkkhMAiZHdx/SbD5o9/hQJc5TyJygqmgNqJqH0aLgb6r15Aji8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721368571; c=relaxed/simple;
	bh=m291lLYQByox1UF+M0VKiLSfd6+13Ez+PBkHvwlB5qQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cQMA86KgTsm9AtQ8/3Nk3fhE27mu8sox7IJAfsmWY04bv4eagAFGAbTZACh7yTG0yhpujXdKwuGwwxKQn3lFPQzV4ti//NfgtuBKeRywkjBJ2XQD+j34/pLgzz7ZLGVD64SrTeCKdlOPl2RYiVzExo2ym2qOCAqlNbEaeeFMe4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RgPmuE6R; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721368569; x=1752904569;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=m291lLYQByox1UF+M0VKiLSfd6+13Ez+PBkHvwlB5qQ=;
  b=RgPmuE6RRMWbMuxhGCwnzribawXwb3bNrHOplWGFbWHOWWc9Jdmg7OWe
   GeHHSW6F0xF6wnPWRGjD2v3INlk+65l0EX8RFEp0REo+WXSbLFwWumfL3
   QPDCUDmnxzxKoVpUFMWDSZ8LjwkGb7dC+PpZbCVopqyUJJGtpqqfh2S9d
   Ma7aFQ3+f2hgZ25y5urMUonFqH+D/ScsxfDNTAqdmqrcTLnSGYSLFYTZX
   XwlHIkH2JIX+XFA3avEkgYEYwnwnxoKa5AwHiD+qJDPzQUxNm/05X4DoA
   d2f7DmW3I+Ang5gfQr/pyDHu98lbpSmJ6NyKwGPawuLi2ZLu27y7vTAvl
   g==;
X-CSE-ConnectionGUID: ja5Q+EOFTLSg3CxMzfJpDg==
X-CSE-MsgGUID: cPNTP6yVS0SdMwqTOu8sUg==
X-IronPort-AV: E=McAfee;i="6700,10204,11137"; a="22776113"
X-IronPort-AV: E=Sophos;i="6.09,220,1716274800"; 
   d="scan'208";a="22776113"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2024 22:56:09 -0700
X-CSE-ConnectionGUID: +eAZlyHgQzi9eUknmyn9gg==
X-CSE-MsgGUID: f3QHGlNjQU6OflAzlNzk2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,220,1716274800"; 
   d="scan'208";a="51289361"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 18 Jul 2024 22:56:07 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sUgb6-000htq-2f;
	Fri, 19 Jul 2024 05:56:04 +0000
Date: Fri, 19 Jul 2024 13:55:06 +0800
From: kernel test robot <lkp@intel.com>
To: Ping-Ke Shih <pkshih@realtek.com>, linux-wireless@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 6/6] wifi: rtw89: 8852bt: add 8852BE-VT to Makefile and
 Kconfig
Message-ID: <202407191347.UQSKNzbG-lkp@intel.com>
References: <20240718025138.18777-7-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240718025138.18777-7-pkshih@realtek.com>

Hi Ping-Ke,

kernel test robot noticed the following build errors:

[auto build test ERROR on wireless-next/main]
[also build test ERROR on linus/master next-20240718]
[cannot apply to wireless/main v6.10]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ping-Ke-Shih/wifi-rtw89-8852bt-add-set_channel_rf/20240718-105447
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/20240718025138.18777-7-pkshih%40realtek.com
patch subject: [PATCH 6/6] wifi: rtw89: 8852bt: add 8852BE-VT to Makefile and Kconfig
config: um-allyesconfig (https://download.01.org/0day-ci/archive/20240719/202407191347.UQSKNzbG-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240719/202407191347.UQSKNzbG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407191347.UQSKNzbG-lkp@intel.com/

All errors (new ones prefixed by >>):

>> /usr/bin/ld: drivers/net/wireless/realtek/rtw89/rtw8852bte.o:(.rodata+0x50): undefined reference to `rtw8852bt_chip_info'
   collect2: error: ld returned 1 exit status

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

