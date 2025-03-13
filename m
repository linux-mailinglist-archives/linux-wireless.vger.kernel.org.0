Return-Path: <linux-wireless+bounces-20301-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B34A5EF73
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Mar 2025 10:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F0023A9B60
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Mar 2025 09:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72CF9262D35;
	Thu, 13 Mar 2025 09:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nic2NUy4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC49261398
	for <linux-wireless@vger.kernel.org>; Thu, 13 Mar 2025 09:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741857703; cv=none; b=RBYH/uQqgq4tQE3rik8sFkXnBm7LqhgRExvSsPI+mR6/F2pzFyRY+fT+RdGePFQu1aqRQWvw0bRoG3g69W4k5vREfZpE1D+z47F95+RYMU9LgfSrIVwtkuHi92fI6x9FugbapVFNG71TkIALpXRRad0ZEy2hCtcZpgd2O/yGl78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741857703; c=relaxed/simple;
	bh=kxdQjPYAsvPGHs0qy8lVL9SL9t9OxUtVCPDUXMcOojw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tV6e/nYnc58o269xaZZTk9ld6chIUm1v5GUAKV8RWKBKzT2Akzzix70qCsRb6eg9SmhnL7v17IHRnxdaWMw48sjEateLWp8XBaxPxe4ax7d+sDgiI9r6TuWL+IyIvx/48mUTGVVEWZaqaT6XqnzlPWk7XpXBr1YjNUDbh/OCpHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nic2NUy4; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741857701; x=1773393701;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kxdQjPYAsvPGHs0qy8lVL9SL9t9OxUtVCPDUXMcOojw=;
  b=nic2NUy4krfcxbVv4uzjpoZgdqyac0T7Hrf3HNAX/NlN2zTOo8oRm/jM
   TLEwlJOQ4pxVEvWfOHe3/cN+FkrAHXl8OSUBh9zo8G4UKUw4Qa4muziPF
   lLqvtxbgbzbyCiYB/2YXGm5rHqrxVGWyZa2XHk1NFlSSsmG8NCdd7ptDj
   jAFiznV9p9BlLF6DPHZXoSYOVSlRm8QC2hCwAxtbh+aZBuzS+ApvgtLBj
   ZeOXEnr53mNC7RL0M1DrvppfNXW5FQTQGAFc8K1XRO7YxiSVr1EjJis6o
   QNspzl6TJ4AgsUIAJNv0r91BxASKjhxegx0sgWEw/v69XvBvmQPu1i2KY
   A==;
X-CSE-ConnectionGUID: iZNTB9nFSuGe8Vb9ruF33A==
X-CSE-MsgGUID: rqQ9WcWfTmmPQ/FSwgSJ0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="46869758"
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="46869758"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 02:21:40 -0700
X-CSE-ConnectionGUID: 7IGeVyv2QhmRHb0tsYLb1Q==
X-CSE-MsgGUID: JSjegJHFT0iqB8kRLD1xWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="121819970"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 13 Mar 2025 02:21:38 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tsekx-0009HJ-2p;
	Thu, 13 Mar 2025 09:21:35 +0000
Date: Thu, 13 Mar 2025 17:21:15 +0800
From: kernel test robot <lkp@intel.com>
To: Sarika Sharma <quic_sarishar@quicinc.com>, johannes@sipsolutions.net
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-wireless@vger.kernel.org,
	Sarika Sharma <quic_sarishar@quicinc.com>
Subject: Re: [PATCH wireless-next v5 04/11] wifi: cfg80211: reorg sinfo
 structure elements for MLO
Message-ID: <202503131702.EHtf3ZYe-lkp@intel.com>
References: <20250312065132.3397726-5-quic_sarishar@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312065132.3397726-5-quic_sarishar@quicinc.com>

Hi Sarika,

kernel test robot noticed the following build errors:

[auto build test ERROR on 9324731b9985478faf7f77713cc5e5fee811716e]

url:    https://github.com/intel-lab-lkp/linux/commits/Sarika-Sharma/wifi-mac80211-add-support-towards-MLO-handling-of-station-statistics/20250312-145356
base:   9324731b9985478faf7f77713cc5e5fee811716e
patch link:    https://lore.kernel.org/r/20250312065132.3397726-5-quic_sarishar%40quicinc.com
patch subject: [PATCH wireless-next v5 04/11] wifi: cfg80211: reorg sinfo structure elements for MLO
config: um-allmodconfig (https://download.01.org/0day-ci/archive/20250313/202503131702.EHtf3ZYe-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project e15545cad8297ec7555f26e5ae74a9f0511203e7)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250313/202503131702.EHtf3ZYe-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503131702.EHtf3ZYe-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/net/wireless/intel/iwlwifi/mld/mac80211.c:6:
   In file included from include/net/mac80211.h:18:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:549:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     549 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:567:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     567 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from drivers/net/wireless/intel/iwlwifi/mld/mac80211.c:6:
   In file included from include/net/mac80211.h:18:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:585:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     585 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from drivers/net/wireless/intel/iwlwifi/mld/mac80211.c:6:
   In file included from include/net/mac80211.h:18:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:601:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     601 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:616:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     616 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:631:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     631 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:724:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     724 |         readsb(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:737:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     737 |         readsw(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:750:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     750 |         readsl(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:764:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     764 |         writesb(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:778:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     778 |         writesw(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:792:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     792 |         writesl(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
>> drivers/net/wireless/intel/iwlwifi/mld/mac80211.c:2637:3: error: field designator 'sta_statistics' does not refer to any field in type 'const struct ieee80211_ops'
    2637 |         .sta_statistics = iwl_mld_mac80211_sta_statistics,
         |         ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   12 warnings and 1 error generated.
--
   In file included from drivers/net/wireless/intel/iwlwifi/mld/stats.c:6:
   In file included from drivers/net/wireless/intel/iwlwifi/mld/mld.h:9:
   In file included from include/net/mac80211.h:18:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:549:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     549 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:567:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     567 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from drivers/net/wireless/intel/iwlwifi/mld/stats.c:6:
   In file included from drivers/net/wireless/intel/iwlwifi/mld/mld.h:9:
   In file included from include/net/mac80211.h:18:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:585:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     585 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from drivers/net/wireless/intel/iwlwifi/mld/stats.c:6:
   In file included from drivers/net/wireless/intel/iwlwifi/mld/mld.h:9:
   In file included from include/net/mac80211.h:18:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:601:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     601 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:616:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     616 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:631:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     631 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:724:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     724 |         readsb(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:737:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     737 |         readsw(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:750:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     750 |         readsl(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:764:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     764 |         writesb(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:778:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     778 |         writesw(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:792:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     792 |         writesl(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
>> drivers/net/wireless/intel/iwlwifi/mld/stats.c:67:9: error: no member named 'signal_avg' in 'struct station_info'
      67 |         sinfo->signal_avg = mld_link_sta->signal_avg;
         |         ~~~~~  ^
   drivers/net/wireless/intel/iwlwifi/mld/stats.c:169:36: error: no member named 'txrate' in 'struct station_info'
     169 |         struct rate_info *rinfo = &sinfo->txrate;
         |                                    ~~~~~  ^
   12 warnings and 2 errors generated.


vim +2637 drivers/net/wireless/intel/iwlwifi/mld/mac80211.c

d1e879ec600f9b3 Miri Korenblit 2025-02-16  2608  
d1e879ec600f9b3 Miri Korenblit 2025-02-16  2609  const struct ieee80211_ops iwl_mld_hw_ops = {
d1e879ec600f9b3 Miri Korenblit 2025-02-16  2610  	.tx = iwl_mld_mac80211_tx,
d1e879ec600f9b3 Miri Korenblit 2025-02-16  2611  	.start = iwl_mld_mac80211_start,
d1e879ec600f9b3 Miri Korenblit 2025-02-16  2612  	.stop = iwl_mld_mac80211_stop,
d1e879ec600f9b3 Miri Korenblit 2025-02-16  2613  	.config = iwl_mld_mac80211_config,
d1e879ec600f9b3 Miri Korenblit 2025-02-16  2614  	.add_interface = iwl_mld_mac80211_add_interface,
d1e879ec600f9b3 Miri Korenblit 2025-02-16  2615  	.remove_interface = iwl_mld_mac80211_remove_interface,
d1e879ec600f9b3 Miri Korenblit 2025-02-16  2616  	.conf_tx = iwl_mld_mac80211_conf_tx,
d1e879ec600f9b3 Miri Korenblit 2025-02-16  2617  	.prepare_multicast = iwl_mld_mac80211_prepare_multicast,
d1e879ec600f9b3 Miri Korenblit 2025-02-16  2618  	.configure_filter = iwl_mld_mac80211_configure_filter,
d1e879ec600f9b3 Miri Korenblit 2025-02-16  2619  	.reconfig_complete = iwl_mld_mac80211_reconfig_complete,
d1e879ec600f9b3 Miri Korenblit 2025-02-16  2620  	.wake_tx_queue = iwl_mld_mac80211_wake_tx_queue,
d1e879ec600f9b3 Miri Korenblit 2025-02-16  2621  	.add_chanctx = iwl_mld_add_chanctx,
d1e879ec600f9b3 Miri Korenblit 2025-02-16  2622  	.remove_chanctx = iwl_mld_remove_chanctx,
d1e879ec600f9b3 Miri Korenblit 2025-02-16  2623  	.change_chanctx = iwl_mld_change_chanctx,
d1e879ec600f9b3 Miri Korenblit 2025-02-16  2624  	.assign_vif_chanctx = iwl_mld_assign_vif_chanctx,
d1e879ec600f9b3 Miri Korenblit 2025-02-16  2625  	.unassign_vif_chanctx = iwl_mld_unassign_vif_chanctx,
d1e879ec600f9b3 Miri Korenblit 2025-02-16  2626  	.set_rts_threshold = iwl_mld_mac80211_set_rts_threshold,
d1e879ec600f9b3 Miri Korenblit 2025-02-16  2627  	.link_info_changed = iwl_mld_mac80211_link_info_changed,
d1e879ec600f9b3 Miri Korenblit 2025-02-16  2628  	.vif_cfg_changed = iwl_mld_mac80211_vif_cfg_changed,
d1e879ec600f9b3 Miri Korenblit 2025-02-16  2629  	.set_key = iwl_mld_mac80211_set_key,
d1e879ec600f9b3 Miri Korenblit 2025-02-16  2630  	.hw_scan = iwl_mld_mac80211_hw_scan,
d1e879ec600f9b3 Miri Korenblit 2025-02-16  2631  	.cancel_hw_scan = iwl_mld_mac80211_cancel_hw_scan,
d1e879ec600f9b3 Miri Korenblit 2025-02-16  2632  	.sched_scan_start = iwl_mld_mac80211_sched_scan_start,
d1e879ec600f9b3 Miri Korenblit 2025-02-16  2633  	.sched_scan_stop = iwl_mld_mac80211_sched_scan_stop,
d1e879ec600f9b3 Miri Korenblit 2025-02-16  2634  	.mgd_prepare_tx = iwl_mld_mac80211_mgd_prepare_tx,
d1e879ec600f9b3 Miri Korenblit 2025-02-16  2635  	.mgd_complete_tx = iwl_mld_mac_mgd_complete_tx,
d1e879ec600f9b3 Miri Korenblit 2025-02-16  2636  	.sta_state = iwl_mld_mac80211_sta_state,
d1e879ec600f9b3 Miri Korenblit 2025-02-16 @2637  	.sta_statistics = iwl_mld_mac80211_sta_statistics,

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

