Return-Path: <linux-wireless+bounces-9523-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60FCE915DC2
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2024 06:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9396C1C21554
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2024 04:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDBD043AB2;
	Tue, 25 Jun 2024 04:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OthhM3tb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6F720330
	for <linux-wireless@vger.kernel.org>; Tue, 25 Jun 2024 04:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719290772; cv=none; b=uW8wB4FATXocn0ZtuSLvhMZlCKj0Cq6iF+hhrUV1w3NwKXhE07p1VPlLOZ14b+0lkOUcZYhqPX2QVK6QD3b7VsqdLfJTKaNya/qNi0kIEv+rc9NslhiGRqrVA9pbJvpbcpJBKsNz1CqnA0tC/xf0vKfbpEfpNAGVFB/F0jiYelY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719290772; c=relaxed/simple;
	bh=6ybpDk0m5qk1ZWIgS+8NhVrcO85QomR7Y8n38PvURg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AzASJv8PsH2ZRQow9UUtt2+NLX48GULWrf1eIA7ylXZDyavLiSK7afNzQI/yEEKbUIxF5aea7Z8kdtTY62whMGU4DlbfweyUWqWlm7cOy7U/JWoI8kcTXWIwHE+Ed0OutNP54h87d/3IJaGQqtTb6liatJ7Q6wmWLR+HHhwVBHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OthhM3tb; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719290771; x=1750826771;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6ybpDk0m5qk1ZWIgS+8NhVrcO85QomR7Y8n38PvURg0=;
  b=OthhM3tbv3BPy4z/CAN/9j6AqBurXa8Jc+nBhM/l/i5i4zZHCvX+miEw
   0vjMqYXP7ue4hEPbu1Eg/1Z+5a+y+ImiYr2sjLzJRmWncgm/vk7OoR9TE
   yCHnShObrb6AGMHOX0slC/NgvnuKzoHiZlMkWo6wNkZycnuaAbKKQvNyL
   74gpigGj7T91AxoW/1ROqpdsNvawHSD4Sh2R/r6o7Z8yj5FDmr7FB4OIZ
   ODiSS22OpLxyaaKFzUCuSjJLEiEgMzQLyDuITyVdsJPsInSWGhoe2x3lJ
   lh2L+qJQbEkkg5T2yK9v3DdgUPm2OkTAKAyFke8DtYnOMam2op+eqvqEn
   w==;
X-CSE-ConnectionGUID: PRKpZ46OSLyQBwtPNQ7xYg==
X-CSE-MsgGUID: P4AdhtuHSOWupprxRyHTJQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="33744660"
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="33744660"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 21:46:10 -0700
X-CSE-ConnectionGUID: HsMMPJ4pTxizg9kXnrh1Ig==
X-CSE-MsgGUID: NU7OacjETbeycu62XTto/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="43386497"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 24 Jun 2024 21:46:08 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sLy4E-000E4X-1e;
	Tue, 25 Jun 2024 04:46:06 +0000
Date: Tue, 25 Jun 2024 12:45:17 +0800
From: kernel test robot <lkp@intel.com>
To: Ping-Ke Shih <pkshih@realtek.com>, linux-wireless@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	gary.chang@realtek.com
Subject: Re: [PATCH 1/7] wifi: rtw89: wow: append security header offset for
 different cipher
Message-ID: <202406251226.QBy2sVKF-lkp@intel.com>
References: <20240620055825.17592-2-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620055825.17592-2-pkshih@realtek.com>

Hi Ping-Ke,

kernel test robot noticed the following build errors:

[auto build test ERROR on wireless-next/main]
[also build test ERROR on wireless/main linus/master v6.10-rc5 next-20240624]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ping-Ke-Shih/wifi-rtw89-wow-append-security-header-offset-for-different-cipher/20240624-152444
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/20240620055825.17592-2-pkshih%40realtek.com
patch subject: [PATCH 1/7] wifi: rtw89: wow: append security header offset for different cipher
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20240625/202406251226.QBy2sVKF-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240625/202406251226.QBy2sVKF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406251226.QBy2sVKF-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/net/wireless/realtek/rtw89/core.c:21:
>> drivers/net/wireless/realtek/rtw89/wow.h:82:45: error: call to undeclared function 'rtw89_is_rtl885xb'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      82 |         if (!(rtwdev->chip->chip_id == RTL8852A || rtw89_is_rtl885xb(rtwdev)))
         |                                                    ^
   1 error generated.


vim +/rtw89_is_rtl885xb +82 drivers/net/wireless/realtek/rtw89/wow.h

    77	
    78	static inline int rtw89_wow_get_sec_hdr_len(struct rtw89_dev *rtwdev)
    79	{
    80		struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
    81	
  > 82		if (!(rtwdev->chip->chip_id == RTL8852A || rtw89_is_rtl885xb(rtwdev)))
    83			return 0;
    84	
    85		switch (rtw_wow->ptk_alg) {
    86		case RTW89_WOW_FW_ALG_WEP40:
    87			return 4;
    88		case RTW89_WOW_FW_ALG_TKIP:
    89		case RTW89_WOW_FW_ALG_CCMP:
    90		case RTW89_WOW_FW_ALG_GCMP_256:
    91			return 8;
    92		default:
    93			return 0;
    94		}
    95	}
    96	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

