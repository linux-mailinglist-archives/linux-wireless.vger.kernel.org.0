Return-Path: <linux-wireless+bounces-5505-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 376D5890EAB
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 00:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EB951C24F41
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 23:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B805A5025C;
	Thu, 28 Mar 2024 23:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XsD+k0lI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AA84D5AC
	for <linux-wireless@vger.kernel.org>; Thu, 28 Mar 2024 23:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711669411; cv=none; b=MCu3x2heXLQxtXo0gYG0eDy/RYwzOeuqMLzsq8oYFujk2X2Py9adVgoH9XRDn+fy/e5iRhFB9EHCe6RjXLawBOvA41zyMy+OXUR0/PfrBwTsYUjwREtIqmQFihl8nYLMKBnudSbb+kOho2VIxwRM913ulicE7nWN2JASpK/BGyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711669411; c=relaxed/simple;
	bh=I/WZfIyNxjJxFKhS5s+O6KXilxr0kqvm8WeoL63ejdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hdvt7EuQEApqxMIXPFHp3yk1sqiXlplc+jwPRFCyAJx9fNgytbDRhA/TlCHrYnltrjlwENIJ4sDqBsIBHSDiMDIzf67VeXap5D+F6U7tylqutusHq31U4Tjs69TX6CwIyNF4ahU1zU2DHa7n6hqVBdek74VpExLWKX0NIIUFtzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XsD+k0lI; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711669410; x=1743205410;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=I/WZfIyNxjJxFKhS5s+O6KXilxr0kqvm8WeoL63ejdo=;
  b=XsD+k0lIZ/T5yrHrLAtV+lMcgb34Qj1ahphb+hrWxY2M+D7lUFBA10zJ
   bm0mfXARN5eSGL0irmQ12dhmbRB6dVSfmYo0UdumFitu1NVygU0QeClVQ
   8Ac07+AGuy3C+S84Nsh31Tzs4Ud4M9wr+F5mm3BfOwtNhmluez1Q67Qb+
   wiar0au+MABZFvv9LSvGNKSzYKlHlnzEc8a4AAJHtiC6psD0HugwBwCyL
   9SMffL3SQuUxLQsLibPtzkIFVFo23Pp0d1/1GciMtJjRGdthEGZoZ/u63
   geozC1hV4y97/GDwtFRXKxGAArBlaydvi4IQu7wPtjJAIAwxHdt0eLppa
   Q==;
X-CSE-ConnectionGUID: 6ajyutm9SoSRVKWOJcALPw==
X-CSE-MsgGUID: lelYHI8ZTmG2L4a6QNxdcw==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="6689759"
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="6689759"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 16:43:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="47777412"
Received: from lkp-server01.sh.intel.com (HELO be39aa325d23) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 28 Mar 2024 16:43:27 -0700
Received: from kbuild by be39aa325d23 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rpzP2-0002d0-15;
	Thu, 28 Mar 2024 23:43:24 +0000
Date: Fri, 29 Mar 2024 07:42:41 +0800
From: kernel test robot <lkp@intel.com>
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
	ath12k@lists.infradead.org, johannes@sipsolutions.net
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-wireless@vger.kernel.org,
	Harshitha Prem <quic_hprem@quicinc.com>,
	Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Subject: Re: [PATCH 13/13] wifi: ath12k: Advertise multi hardware iface
 combination
Message-ID: <202403290724.p8vSV474-lkp@intel.com>
References: <20240328072916.1164195-14-quic_periyasa@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328072916.1164195-14-quic_periyasa@quicinc.com>

Hi Karthikeyan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on d69aef8084cc72df7b0f2583096d9b037c647ec8]

url:    https://github.com/intel-lab-lkp/linux/commits/Karthikeyan-Periyasamy/wifi-cfg80211-Add-provision-to-advertise-multiple-radio-in-one-wiphy/20240328-153303
base:   d69aef8084cc72df7b0f2583096d9b037c647ec8
patch link:    https://lore.kernel.org/r/20240328072916.1164195-14-quic_periyasa%40quicinc.com
patch subject: [PATCH 13/13] wifi: ath12k: Advertise multi hardware iface combination
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20240329/202403290724.p8vSV474-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 79ba323bdd0843275019e16b6e9b35133677c514)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240329/202403290724.p8vSV474-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403290724.p8vSV474-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/net/wireless/ath/ath12k/mac.c:7:
   In file included from include/net/mac80211.h:18:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:8:
   In file included from include/linux/cacheflush.h:5:
   In file included from arch/arm64/include/asm/cacheflush.h:11:
   In file included from include/linux/kgdb.h:19:
   In file included from include/linux/kprobes.h:28:
   In file included from include/linux/ftrace.h:13:
   In file included from include/linux/kallsyms.h:13:
   In file included from include/linux/mm.h:2188:
   include/linux/vmstat.h:508:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     508 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     509 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:515:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     515 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     516 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:522:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:527:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     527 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     528 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:536:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     536 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     537 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
>> drivers/net/wireless/ath/ath12k/mac.c:7795:11: warning: variable 'band' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
    7795 |         else if (ar->pdev->cap.supported_bands & WMI_HOST_WLAN_5G_CAP &&
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    7796 |                  ar->supports_6ghz)
         |                  ~~~~~~~~~~~~~~~~~
   drivers/net/wireless/ath/ath12k/mac.c:7799:44: note: uninitialized use occurs here
    7799 |         chans = kzalloc(struct_size(chans, chans, band->n_channels),
         |                                                   ^~~~
   include/linux/overflow.h:294:53: note: expanded from macro 'struct_size'
     294 |                 size_add(sizeof(*(p)), flex_array_size(p, member, count)))
         |                                                                   ^~~~~
   include/linux/overflow.h:278:12: note: expanded from macro 'flex_array_size'
     278 |                 size_mul(count, sizeof(*(p)->member) + __must_be_array((p)->member)))
         |                          ^~~~~
   drivers/net/wireless/ath/ath12k/mac.c:7795:7: note: remove the 'if' if its condition is always true
    7795 |         else if (ar->pdev->cap.supported_bands & WMI_HOST_WLAN_5G_CAP &&
         |              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    7796 |                  ar->supports_6ghz)
         |                  ~~~~~~~~~~~~~~~~~~
    7797 |                 band = &ar->mac.sbands[NL80211_BAND_6GHZ];
>> drivers/net/wireless/ath/ath12k/mac.c:7795:11: warning: variable 'band' is used uninitialized whenever '&&' condition is false [-Wsometimes-uninitialized]
    7795 |         else if (ar->pdev->cap.supported_bands & WMI_HOST_WLAN_5G_CAP &&
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/wireless/ath/ath12k/mac.c:7799:44: note: uninitialized use occurs here
    7799 |         chans = kzalloc(struct_size(chans, chans, band->n_channels),
         |                                                   ^~~~
   include/linux/overflow.h:294:53: note: expanded from macro 'struct_size'
     294 |                 size_add(sizeof(*(p)), flex_array_size(p, member, count)))
         |                                                                   ^~~~~
   include/linux/overflow.h:278:12: note: expanded from macro 'flex_array_size'
     278 |                 size_mul(count, sizeof(*(p)->member) + __must_be_array((p)->member)))
         |                          ^~~~~
   drivers/net/wireless/ath/ath12k/mac.c:7795:11: note: remove the '&&' if its condition is always true
    7795 |         else if (ar->pdev->cap.supported_bands & WMI_HOST_WLAN_5G_CAP &&
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/wireless/ath/ath12k/mac.c:7788:39: note: initialize the variable 'band' to silence this warning
    7788 |         struct ieee80211_supported_band *band;
         |                                              ^
         |                                               = NULL
   7 warnings generated.


vim +7795 drivers/net/wireless/ath/ath12k/mac.c

  7783	
  7784	static
  7785	struct ieee80211_chans_per_hw *ath12k_setup_per_hw_chan(struct ath12k *ar)
  7786	{
  7787		struct ieee80211_chans_per_hw *chans;
  7788		struct ieee80211_supported_band *band;
  7789	
  7790		if (ar->pdev->cap.supported_bands & WMI_HOST_WLAN_2G_CAP)
  7791			band = &ar->mac.sbands[NL80211_BAND_2GHZ];
  7792		else if (ar->pdev->cap.supported_bands & WMI_HOST_WLAN_5G_CAP &&
  7793			 !ar->supports_6ghz)
  7794			band = &ar->mac.sbands[NL80211_BAND_5GHZ];
> 7795		else if (ar->pdev->cap.supported_bands & WMI_HOST_WLAN_5G_CAP &&
  7796			 ar->supports_6ghz)
  7797			band = &ar->mac.sbands[NL80211_BAND_6GHZ];
  7798	
  7799		chans = kzalloc(struct_size(chans, chans, band->n_channels),
  7800				GFP_KERNEL);
  7801		if (!chans)
  7802			return NULL;
  7803	
  7804		memcpy(chans->chans, band->channels,
  7805		       sizeof(*band->channels) * band->n_channels);
  7806		chans->n_chans = band->n_channels;
  7807	
  7808		return chans;
  7809	}
  7810	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

