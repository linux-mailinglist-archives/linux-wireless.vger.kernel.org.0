Return-Path: <linux-wireless+bounces-9564-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B52917537
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2024 02:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 233D328463C
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2024 00:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BF6522A;
	Wed, 26 Jun 2024 00:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="np9iFzKL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D93D1FDA;
	Wed, 26 Jun 2024 00:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719361523; cv=none; b=NYnHABCqv7prrKVpcgNSGIHGcaUjQNnhcCN7exfHcmiy/tVBzip3jVRfSHGcxnqDRNTnVVRoiBfkZMLNNTUgp8gN8K6uLaT+C04Ffe3AzrHvt/AFzLTFGH+sG6yvMwJCZprTVWcN5y+4Uv+pCIWb5qeTtVO1Cub8J96kaMX08mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719361523; c=relaxed/simple;
	bh=pdvH9UYQ/SqS+nHU6W6FNxWXK9lUyuz9ljcuqj5ktlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WCtNjbA2VoKm24pJfUjjOn9WdW/k8O2DGowQeSuzLkR7IzzX3cgUv+pufXEznEhk4Pmfa+Mr6jqz64Nuxu9dCgh9AxBwZ8vT7rY3BwTeXNHd4sMAh3mqlNa9LuHfXCPbSq6fRl2XZhWq+nRgigcTqWXwrkTa8+KwnGvynORN2+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=np9iFzKL; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719361521; x=1750897521;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pdvH9UYQ/SqS+nHU6W6FNxWXK9lUyuz9ljcuqj5ktlg=;
  b=np9iFzKLsFz1QS3GA1bSSOTYKOAZvdMVVx2kzMNFtJdvdIyyTfWQwzoT
   7b12z0O2fQg9sGeflfF202c2asQnvbcqwNaIJ7a9SGdFmlFKMao9Vsbmv
   RXzZvOMo1mn2/Iy6CaLrcSc1/WRTh5YKL55AjuLHIYm750DPiTSxzAxQF
   gLZe7ycyVagkzd8MJgn6S4TjUpjabyqNHQYzsef9lhSHT+jgRJGJXiEKU
   wZk4ykHcCnHrFWv4Ioyi86yOsLw2yjEH+jC/QbkRQxK4sSGnJyW4rBrQG
   olA5fxap7sfHpp2hezHUcIq7WybzHiBk6d5Vp9yA52bOffnteaJeXF/+X
   A==;
X-CSE-ConnectionGUID: Gqj4rdvCQMSlShS+0dgkLg==
X-CSE-MsgGUID: L1yRYoHEQnSBVSxmE7f96A==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="27551453"
X-IronPort-AV: E=Sophos;i="6.08,265,1712646000"; 
   d="scan'208";a="27551453"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 17:25:21 -0700
X-CSE-ConnectionGUID: VFKVk0CLRoyaeAVqjy9c6g==
X-CSE-MsgGUID: Or6R2Nf1SCmTOt4t1u9WuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,265,1712646000"; 
   d="scan'208";a="43919377"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 25 Jun 2024 17:25:18 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sMGTM-000Ept-1f;
	Wed, 26 Jun 2024 00:25:16 +0000
Date: Wed, 26 Jun 2024 08:24:23 +0800
From: kernel test robot <lkp@intel.com>
To: David Lin <yu-hao.lin@nxp.com>, linux-wireless@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	briannorris@chromium.org, kvalo@kernel.org, francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com, David Lin <yu-hao.lin@nxp.com>
Subject: Re: [PATCH 42/43] wifi: nxpwifi: add Makefile and Kconfig files for
 nxpwifi compilation
Message-ID: <202406260848.0pH4xjvI-lkp@intel.com>
References: <20240621075208.513497-43-yu-hao.lin@nxp.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621075208.513497-43-yu-hao.lin@nxp.com>

Hi David,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 238d636723a30311e20fde0a361662e829fe488b]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Lin/wifi-nxpwifi-add-11ac-c/20240625-161306
base:   238d636723a30311e20fde0a361662e829fe488b
patch link:    https://lore.kernel.org/r/20240621075208.513497-43-yu-hao.lin%40nxp.com
patch subject: [PATCH 42/43] wifi: nxpwifi: add Makefile and Kconfig files for nxpwifi compilation
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20240626/202406260848.0pH4xjvI-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240626/202406260848.0pH4xjvI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406260848.0pH4xjvI-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/wireless/nxp/nxpwifi/11n_rxreorder.c: In function 'nxpwifi_11n_dispatch_amsdu_pkt':
>> drivers/net/wireless/nxp/nxpwifi/11n_rxreorder.c:40:47: warning: variable 'rx_hdr' set but not used [-Wunused-but-set-variable]
      40 |                         struct rx_packet_hdr *rx_hdr;
         |                                               ^~~~~~
--
   drivers/net/wireless/nxp/nxpwifi/sta_event.c: In function 'nxpwifi_sta_event_link_lost':
>> drivers/net/wireless/nxp/nxpwifi/sta_event.c:21:13: warning: variable 'reason_code' set but not used [-Wunused-but-set-variable]
      21 |         u16 reason_code;
         |             ^~~~~~~~~~~
--
   drivers/net/wireless/nxp/nxpwifi/sta_rx.c: In function 'nxpwifi_process_rx_packet':
>> drivers/net/wireless/nxp/nxpwifi/sta_rx.c:78:25: warning: variable 'rx_pkt_len' set but not used [-Wunused-but-set-variable]
      78 |         u16 rx_pkt_off, rx_pkt_len;
         |                         ^~~~~~~~~~


vim +/rx_hdr +40 drivers/net/wireless/nxp/nxpwifi/11n_rxreorder.c

148be2798f7a0c David Lin 2024-06-21  17  
148be2798f7a0c David Lin 2024-06-21  18  /* This function will dispatch amsdu packet and forward it to kernel/upper
148be2798f7a0c David Lin 2024-06-21  19   * layer.
148be2798f7a0c David Lin 2024-06-21  20   */
148be2798f7a0c David Lin 2024-06-21  21  static int nxpwifi_11n_dispatch_amsdu_pkt(struct nxpwifi_private *priv,
148be2798f7a0c David Lin 2024-06-21  22  					  struct sk_buff *skb)
148be2798f7a0c David Lin 2024-06-21  23  {
148be2798f7a0c David Lin 2024-06-21  24  	struct rxpd *local_rx_pd = (struct rxpd *)(skb->data);
148be2798f7a0c David Lin 2024-06-21  25  	int ret;
148be2798f7a0c David Lin 2024-06-21  26  
148be2798f7a0c David Lin 2024-06-21  27  	if (le16_to_cpu(local_rx_pd->rx_pkt_type) == PKT_TYPE_AMSDU) {
148be2798f7a0c David Lin 2024-06-21  28  		struct sk_buff_head list;
148be2798f7a0c David Lin 2024-06-21  29  		struct sk_buff *rx_skb;
148be2798f7a0c David Lin 2024-06-21  30  
148be2798f7a0c David Lin 2024-06-21  31  		__skb_queue_head_init(&list);
148be2798f7a0c David Lin 2024-06-21  32  
148be2798f7a0c David Lin 2024-06-21  33  		skb_pull(skb, le16_to_cpu(local_rx_pd->rx_pkt_offset));
148be2798f7a0c David Lin 2024-06-21  34  		skb_trim(skb, le16_to_cpu(local_rx_pd->rx_pkt_length));
148be2798f7a0c David Lin 2024-06-21  35  
148be2798f7a0c David Lin 2024-06-21  36  		ieee80211_amsdu_to_8023s(skb, &list, priv->curr_addr,
148be2798f7a0c David Lin 2024-06-21  37  					 priv->wdev.iftype, 0, NULL, NULL, false);
148be2798f7a0c David Lin 2024-06-21  38  
148be2798f7a0c David Lin 2024-06-21  39  		while (!skb_queue_empty(&list)) {
148be2798f7a0c David Lin 2024-06-21 @40  			struct rx_packet_hdr *rx_hdr;
148be2798f7a0c David Lin 2024-06-21  41  
148be2798f7a0c David Lin 2024-06-21  42  			rx_skb = __skb_dequeue(&list);
148be2798f7a0c David Lin 2024-06-21  43  			rx_hdr = (struct rx_packet_hdr *)rx_skb->data;
148be2798f7a0c David Lin 2024-06-21  44  
148be2798f7a0c David Lin 2024-06-21  45  			if (priv->bss_role == NXPWIFI_BSS_ROLE_UAP)
148be2798f7a0c David Lin 2024-06-21  46  				ret = nxpwifi_uap_recv_packet(priv, rx_skb);
148be2798f7a0c David Lin 2024-06-21  47  			else
148be2798f7a0c David Lin 2024-06-21  48  				ret = nxpwifi_recv_packet(priv, rx_skb);
148be2798f7a0c David Lin 2024-06-21  49  			if (ret == -1)
148be2798f7a0c David Lin 2024-06-21  50  				nxpwifi_dbg(priv->adapter, ERROR,
148be2798f7a0c David Lin 2024-06-21  51  					    "Rx of A-MSDU failed");
148be2798f7a0c David Lin 2024-06-21  52  		}
148be2798f7a0c David Lin 2024-06-21  53  		return 0;
148be2798f7a0c David Lin 2024-06-21  54  	}
148be2798f7a0c David Lin 2024-06-21  55  
148be2798f7a0c David Lin 2024-06-21  56  	return -1;
148be2798f7a0c David Lin 2024-06-21  57  }
148be2798f7a0c David Lin 2024-06-21  58  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

