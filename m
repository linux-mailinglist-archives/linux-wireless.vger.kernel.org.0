Return-Path: <linux-wireless+bounces-19074-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC1DA38F1C
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Feb 2025 23:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E31616A31A
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Feb 2025 22:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CF41A83E2;
	Mon, 17 Feb 2025 22:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R2i37QBN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC4846BF
	for <linux-wireless@vger.kernel.org>; Mon, 17 Feb 2025 22:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739831680; cv=none; b=tSJF5r/sadYcaRdRvCNTe8xTKD28VZGjYRtYusj2Y4mpskMjtwQqhkIf94qxDm/MF/jlp3Cukv7dACZjKHwS5NVBmCaJjYXGJ9LKEP130HBgz052E58TNTcOh3ppCrGWIfq1zJFUYiCW9/Z/50bzQgd1l7RST0cR51WJ2r+XTIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739831680; c=relaxed/simple;
	bh=V55d7Soaz7wVA9gFfrWsS0z9hYsXDi79Lx/oTQA1EUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N1/SZFdMu3GLOv9/YsLLRsX31aRThMCn4OsCedhtF7bWr9qTmFzr2YjRHYVtCPazeaph/CUZzYPaGDxb5jM4ZU8syTX6VngmdDZrw28hJEaPWFNh08rGDZAsJp8FMpnNwc/sMLJHLFQJRyBIR2KQcyibI5bvd6GUsD7kFdnzpkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R2i37QBN; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739831679; x=1771367679;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=V55d7Soaz7wVA9gFfrWsS0z9hYsXDi79Lx/oTQA1EUo=;
  b=R2i37QBN9sPKsWA3EN5u92S9mZoqeNbwNyW+hefiQ/A5cN3KU79UhOnw
   r/gMnCtIQ/EQYdZXFBSctPDzhcgs8NHZ9+lFFGqEdZ37VhdpKzRjbGY7r
   Eu8F1AkHRIETVit8fq0uopriy5cRTZkBcYTafHE21r6zJphc2nMexmGJl
   Vv5HSgyqV+s/ukdVZAZy4wpGsldGKdcdb3YEFxJcLA2ynZLy16JJq1r45
   jzOK6vVxyIW/0J7jzsjh2PGjGqN1DYIu/tkBvaMQOx6849jy5h1aB9VYY
   WIH4tzMHozHacmrMqhNXMjpji55MI4M5DmQkmRZ+c7ss1Um3yZEiKQAi3
   Q==;
X-CSE-ConnectionGUID: IJsBf+M2SJaADh/c5jM5eA==
X-CSE-MsgGUID: u/Q/Gz1bQQaGmjVIiB0/3Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="28116135"
X-IronPort-AV: E=Sophos;i="6.13,294,1732608000"; 
   d="scan'208";a="28116135"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 14:34:38 -0800
X-CSE-ConnectionGUID: 2F81YKVjQLqTaiSq4rmsiA==
X-CSE-MsgGUID: XFPj9ecaSKWINdsn38/JEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="119151365"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 17 Feb 2025 14:34:36 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tk9hB-001DeR-3D;
	Mon, 17 Feb 2025 22:34:33 +0000
Date: Tue, 18 Feb 2025 06:33:59 +0800
From: kernel test robot <lkp@intel.com>
To: Alexander Wetzel <Alexander@wetzel-home.de>,
	linux-wireless@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Johannes Berg <johannes@sipsolutions.net>,
	Alexander Wetzel <alexander@wetzel-home.de>
Subject: Re: [PATCH v2 05/10] wifi: mac80211: Stop using legacy TX path
Message-ID: <202502180650.CWCCOFGJ-lkp@intel.com>
References: <20250217081721.45110-6-Alexander@wetzel-home.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217081721.45110-6-Alexander@wetzel-home.de>

Hi Alexander,

kernel test robot noticed the following build warnings:

[auto build test WARNING on wireless-next/main]
[also build test WARNING on wireless/main ath/ath-next linus/master v6.14-rc3 next-20250217]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alexander-Wetzel/wifi-mac80211-move-rate-control-setup/20250217-162046
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/20250217081721.45110-6-Alexander%40wetzel-home.de
patch subject: [PATCH v2 05/10] wifi: mac80211: Stop using legacy TX path
config: x86_64-buildonly-randconfig-003-20250218 (https://download.01.org/0day-ci/archive/20250218/202502180650.CWCCOFGJ-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250218/202502180650.CWCCOFGJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502180650.CWCCOFGJ-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from net/mac80211/tx.c:15:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:8:
   In file included from include/linux/cacheflush.h:5:
   In file included from arch/x86/include/asm/cacheflush.h:5:
   In file included from include/linux/mm.h:2224:
   include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     505 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     512 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:524:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     525 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
>> net/mac80211/tx.c:4607:29: warning: variable 'hdr' is uninitialized when used here [-Wuninitialized]
    4607 |                 sta = sta_info_get(sdata, hdr->addr1);
         |                                           ^~~
   net/mac80211/tx.c:4579:27: note: initialize the variable 'hdr' to silence this warning
    4579 |         struct ieee80211_hdr *hdr;
         |                                  ^
         |                                   = NULL
   4 warnings generated.


vim +/hdr +4607 net/mac80211/tx.c

e2ebc74d7e3d716 Johannes Berg    2007-07-27  4572  
e8f495b5a04f5a6 Alexander Wetzel 2025-02-17  4573  static void ieee80211_tx_pending_skb(struct ieee80211_local *local,
cd8ffc800ce18e5 Johannes Berg    2009-03-23  4574  				     struct sk_buff *skb)
cd8ffc800ce18e5 Johannes Berg    2009-03-23  4575  {
cd8ffc800ce18e5 Johannes Berg    2009-03-23  4576  	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
cd8ffc800ce18e5 Johannes Berg    2009-03-23  4577  	struct ieee80211_sub_if_data *sdata;
cd8ffc800ce18e5 Johannes Berg    2009-03-23  4578  	struct sta_info *sta;
cd8ffc800ce18e5 Johannes Berg    2009-03-23  4579  	struct ieee80211_hdr *hdr;
55de908ab292c03 Johannes Berg    2012-07-26  4580  	struct ieee80211_chanctx_conf *chanctx_conf;
cd8ffc800ce18e5 Johannes Berg    2009-03-23  4581  
5061b0c2b9066de Johannes Berg    2009-07-14  4582  	sdata = vif_to_sdata(info->control.vif);
cd8ffc800ce18e5 Johannes Berg    2009-03-23  4583  
cc20ff2c6b5d3e2 Felix Fietkau    2020-09-08  4584  	if (info->control.flags & IEEE80211_TX_INTCFL_NEED_TXPROCESSING) {
eef25a6679adb3c Johannes Berg    2022-06-01  4585  		/* update band only for non-MLD */
f1871abd27641c0 Ilan Peer        2023-06-08  4586  		if (!ieee80211_vif_is_mld(&sdata->vif)) {
eef25a6679adb3c Johannes Berg    2022-06-01  4587  			chanctx_conf =
eef25a6679adb3c Johannes Berg    2022-06-01  4588  				rcu_dereference(sdata->vif.bss_conf.chanctx_conf);
55de908ab292c03 Johannes Berg    2012-07-26  4589  			if (unlikely(!chanctx_conf)) {
55de908ab292c03 Johannes Berg    2012-07-26  4590  				dev_kfree_skb(skb);
e8f495b5a04f5a6 Alexander Wetzel 2025-02-17  4591  				return;
55de908ab292c03 Johannes Berg    2012-07-26  4592  			}
73c4e195e6396ee Johannes Berg    2014-11-09  4593  			info->band = chanctx_conf->def.chan->band;
eef25a6679adb3c Johannes Berg    2022-06-01  4594  		}
e8f495b5a04f5a6 Alexander Wetzel 2025-02-17  4595  		ieee80211_tx(sdata, NULL, skb);
cc20ff2c6b5d3e2 Felix Fietkau    2020-09-08  4596  	} else if (info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP) {
50ff477a8639fa1 John Crispin     2019-11-25  4597  		if (ieee80211_lookup_ra_sta(sdata, skb, &sta)) {
50ff477a8639fa1 John Crispin     2019-11-25  4598  			dev_kfree_skb(skb);
e8f495b5a04f5a6 Alexander Wetzel 2025-02-17  4599  			return;
50ff477a8639fa1 John Crispin     2019-11-25  4600  		}
50ff477a8639fa1 John Crispin     2019-11-25  4601  
50ff477a8639fa1 John Crispin     2019-11-25  4602  		if (IS_ERR(sta) || (sta && !sta->uploaded))
50ff477a8639fa1 John Crispin     2019-11-25  4603  			sta = NULL;
50ff477a8639fa1 John Crispin     2019-11-25  4604  
e8f495b5a04f5a6 Alexander Wetzel 2025-02-17  4605  		ieee80211_queue_skb(local, sdata, sta, skb);
cd8ffc800ce18e5 Johannes Berg    2009-03-23  4606  	} else {
abe60632f311d51 Johannes Berg    2009-11-25 @4607  		sta = sta_info_get(sdata, hdr->addr1);
e8f495b5a04f5a6 Alexander Wetzel 2025-02-17  4608  		ieee80211_tx(sdata, sta, skb);
cd8ffc800ce18e5 Johannes Berg    2009-03-23  4609  	}
cd8ffc800ce18e5 Johannes Berg    2009-03-23  4610  }
cd8ffc800ce18e5 Johannes Berg    2009-03-23  4611  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

