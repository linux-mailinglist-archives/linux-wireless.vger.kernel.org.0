Return-Path: <linux-wireless+bounces-10091-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D501F92ADB8
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jul 2024 03:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83DD4281D5E
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jul 2024 01:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A132837D;
	Tue,  9 Jul 2024 01:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JoOs9wLH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3035273FD
	for <linux-wireless@vger.kernel.org>; Tue,  9 Jul 2024 01:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720487624; cv=none; b=P6rI6EcPNlaYHeVmp3CCOtSActuKkQ7mDk6UQAkm2uix+WyddRRnmSkZCFtcKJLoD7aOitfnYnZ32GZJoOH7jhi2PHjmEr/f6OjZCnrihaj9miEu/CIh2FhIAyDa8m90B+qakUcNhPLF8bGEp5McUytp+LvCxW4Q2jINMb657eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720487624; c=relaxed/simple;
	bh=RL2nzavEFmTdPgytejsONtIPz++Im7ZHpcYJyZperJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IScTuNegkfTPxCZdkBgqicBmkO/dgIi7hNrNeYC6upSpA9NqYPEhQADX5h4wFohUxAWF/8e71OVprMpEdCtg5z5G3YBIyUN/bUBj+kdCn/KdhMBKu94CGQTd+XQHO8DAd0JxiOot8z3hABUyxYRwHhuseLz+B6f7Ux+LRYorBQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JoOs9wLH; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720487622; x=1752023622;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RL2nzavEFmTdPgytejsONtIPz++Im7ZHpcYJyZperJ0=;
  b=JoOs9wLHb1vfDHpkcdV2vs9Tyw6rQ5ld+KKXFyWkpK3PXxMWN/WmbcGR
   88lwkT4Q/pdiniD8tDmXEz3T4XNGdE+0uSV0FDwwqV8cKO39BGbH+di3X
   qzncAhWYdD9ILHkJj4s7z2LIUngcrP6ZEjBg5TTMsuMIsOrqXQFbbTkFg
   lHK1BA0GqwphGTqoDkxyu1QEgKqmWd5hBj69c0T3jwKDU3ghjhsR+cquc
   nbPeWiaxBZ1tuQmkdnKMJf7hcD5XYc2nwDslV9FGRelKHl7gkSTYMp4la
   sPaCkxQWAu5qEwfzXOjzegfxIsC+Mzroh9zBzAM+gRQn+Nf8F0OuFAVh0
   g==;
X-CSE-ConnectionGUID: z5XgoTsUSY+CdYk6Wk8haw==
X-CSE-MsgGUID: dCIM31bcSxmjRy5nHWFU/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="17587886"
X-IronPort-AV: E=Sophos;i="6.09,193,1716274800"; 
   d="scan'208";a="17587886"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 18:13:42 -0700
X-CSE-ConnectionGUID: iEtsmX5oRdK6p+U8978hog==
X-CSE-MsgGUID: PI6vWzClTHmzq3OeE42Lag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,193,1716274800"; 
   d="scan'208";a="47607816"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 08 Jul 2024 18:13:40 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sQzQI-000WBy-0x;
	Tue, 09 Jul 2024 01:13:38 +0000
Date: Tue, 9 Jul 2024 09:13:12 +0800
From: kernel test robot <lkp@intel.com>
To: En-Wei Wu <en-wei.wu@canonical.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Johannes Berg <johannes@sipsolutions.net>,
	Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [wireless-next:main 24/27]
 drivers/net/wireless/virtual/virt_wifi.c:151:10: error: initializer element
 is not a compile-time constant
Message-ID: <202407090944.mpwLHGt9-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
head:   b3603133d3b727b0b07a7094ab74cf27c8aee3bd
commit: b5d14b0c6716fad7f0c94ac6e1d6f60a49f985c7 [24/27] wifi: virt_wifi: avoid reporting connection success with wrong SSID
config: i386-randconfig-015-20240709 (https://download.01.org/0day-ci/archive/20240709/202407090944.mpwLHGt9-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240709/202407090944.mpwLHGt9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407090944.mpwLHGt9-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/wireless/virtual/virt_wifi.c:151:10: error: initializer element is not a compile-time constant
     151 |                 .len = strlen(VIRT_WIFI_SSID),
         |                        ^~~~~~~~~~~~~~~~~~~~~~
   1 error generated.


vim +151 drivers/net/wireless/virtual/virt_wifi.c

   140	
   141	static void virt_wifi_inform_bss(struct wiphy *wiphy)
   142	{
   143		u64 tsf = div_u64(ktime_get_boottime_ns(), 1000);
   144		struct cfg80211_bss *informed_bss;
   145		static const struct {
   146			u8 tag;
   147			u8 len;
   148			u8 ssid[8];
   149		} __packed ssid = {
   150			.tag = WLAN_EID_SSID,
 > 151			.len = strlen(VIRT_WIFI_SSID),
   152			.ssid = VIRT_WIFI_SSID,
   153		};
   154	
   155		informed_bss = cfg80211_inform_bss(wiphy, &channel_5ghz,
   156						   CFG80211_BSS_FTYPE_PRESP,
   157						   fake_router_bssid, tsf,
   158						   WLAN_CAPABILITY_ESS, 0,
   159						   (void *)&ssid, sizeof(ssid),
   160						   DBM_TO_MBM(-50), GFP_KERNEL);
   161		cfg80211_put_bss(wiphy, informed_bss);
   162	}
   163	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

