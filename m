Return-Path: <linux-wireless+bounces-24082-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7575DAD7E8B
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Jun 2025 00:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB9BE3B36FD
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 22:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F582222A0;
	Thu, 12 Jun 2025 22:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cua6nK7E"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A48192584;
	Thu, 12 Jun 2025 22:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749768372; cv=none; b=UBsKAIidbtpev69iG2oKXD+o4feJdNJRnFZ9LV7dDnlXxPxnnz8eND7okJg2IS5vsEUT0hzfW24QRU7hhjiRiNBKXRQ4bl5HldeoMVQP0lR+D+6ArgiuRsPl6wU2sekND746+oe5j1uqmhjXFPASh354a+KLvPHc2LG66kfc0kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749768372; c=relaxed/simple;
	bh=yBlwGGACujWXuF8os5bqI58U8p7ivNnrZt8Z2R+3XKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GV7mFlEc6n8VmklWqZLARbmfWC5FV9BGTz5XCRaAiyWX1WqmYk+aNHYD9aSrYuKCYy3WVtAZDh4IlSe/r0Hcvw2wjdniHaoFg/+xzItgOulKIXE/WL22MEAYJM0MRL5uy8EH+B/52NXs3CtMXgvJqpAjcxl0/zmCvthcac0f+xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cua6nK7E; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749768371; x=1781304371;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yBlwGGACujWXuF8os5bqI58U8p7ivNnrZt8Z2R+3XKI=;
  b=Cua6nK7Ed/9xhlmG+w1Hk92PS5WtY8gjCRZFBWt2Ved8PelqbfXGH4dI
   T2B35fwMYgdXIshKsXuskOglAUh7sr1rh3ZOH+guYT7a7GBmom2o1GKmU
   krrZjCQbq9ybLi8dUfLYxf+P/z7iVAlDEh+xbjeA/nlcmOr35jF4XntBP
   vzM7PjD5SsoQ2icKDcac3+tbyUGyxhjWLc+I7CTo5EjsKNh6M6b2bPD9t
   el7zFjUCMmaznQw0U3kfD/vJuudHZIAnHBD0ndxQN4oJgBIRjpKDDmSZ7
   lX2ymiHkMXEuFeDNaX44Ufmsi30D47p17nFlkh7jPKI4RgyqexgXUBjRW
   Q==;
X-CSE-ConnectionGUID: COh5U1QaS+O10PhczDKFtA==
X-CSE-MsgGUID: p+Le8OLfSdW59ZlBVA1XGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11462"; a="52061786"
X-IronPort-AV: E=Sophos;i="6.16,232,1744095600"; 
   d="scan'208";a="52061786"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 15:46:10 -0700
X-CSE-ConnectionGUID: kBeLs/2qQe+tSrlVSyu85A==
X-CSE-MsgGUID: NvEOFHdbSOSIifL/wP0uLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,232,1744095600"; 
   d="scan'208";a="148544889"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 12 Jun 2025 15:46:07 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uPqgO-000C0U-2Z;
	Thu, 12 Jun 2025 22:46:04 +0000
Date: Fri, 13 Jun 2025 06:45:06 +0800
From: kernel test robot <lkp@intel.com>
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev,
	Thomas Fourier <fourier.thomas@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drive/realtek/rtlwifi: fix possible memory leak
Message-ID: <202506130644.NKPuRVsI-lkp@intel.com>
References: <20250612090724.17777-1-fourier.thomas@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250612090724.17777-1-fourier.thomas@gmail.com>

Hi Thomas,

kernel test robot noticed the following build errors:

[auto build test ERROR on wireless-next/main]
[also build test ERROR on wireless/main linus/master v6.16-rc1 next-20250612]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Thomas-Fourier/drive-realtek-rtlwifi-fix-possible-memory-leak/20250612-171134
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/20250612090724.17777-1-fourier.thomas%40gmail.com
patch subject: [PATCH] drive/realtek/rtlwifi: fix possible memory leak
config: i386-randconfig-006-20250613 (https://download.01.org/0day-ci/archive/20250613/202506130644.NKPuRVsI-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250613/202506130644.NKPuRVsI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506130644.NKPuRVsI-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/wireless/realtek/rtlwifi/pci.c: In function '_rtl_pci_init_one_rxdesc':
>> drivers/net/wireless/realtek/rtlwifi/pci.c:577:39: error: expected ';' before 'return'
     577 |                         kfree_skb(skb)
         |                                       ^
         |                                       ;
     578 |                 return 0;
         |                 ~~~~~~                 


vim +577 drivers/net/wireless/realtek/rtlwifi/pci.c

   550	
   551	static int _rtl_pci_init_one_rxdesc(struct ieee80211_hw *hw,
   552					    struct sk_buff *new_skb, u8 *entry,
   553					    int rxring_idx, int desc_idx)
   554	{
   555		struct rtl_priv *rtlpriv = rtl_priv(hw);
   556		struct rtl_pci *rtlpci = rtl_pcidev(rtl_pcipriv(hw));
   557		u32 bufferaddress;
   558		u8 tmp_one = 1;
   559		struct sk_buff *skb;
   560	
   561		if (likely(new_skb)) {
   562			skb = new_skb;
   563			goto remap;
   564		}
   565		skb = dev_alloc_skb(rtlpci->rxbuffersize);
   566		if (!skb)
   567			return 0;
   568	
   569	remap:
   570		/* just set skb->cb to mapping addr for pci_unmap_single use */
   571		*((dma_addr_t *)skb->cb) =
   572			dma_map_single(&rtlpci->pdev->dev, skb_tail_pointer(skb),
   573				       rtlpci->rxbuffersize, DMA_FROM_DEVICE);
   574		bufferaddress = *((dma_addr_t *)skb->cb);
   575		if (dma_mapping_error(&rtlpci->pdev->dev, bufferaddress)) {
   576			if (!new_skb)
 > 577				kfree_skb(skb)
   578			return 0;
   579		}
   580		rtlpci->rx_ring[rxring_idx].rx_buf[desc_idx] = skb;
   581		if (rtlpriv->use_new_trx_flow) {
   582			/* skb->cb may be 64 bit address */
   583			rtlpriv->cfg->ops->set_desc(hw, (u8 *)entry, false,
   584						    HW_DESC_RX_PREPARE,
   585						    (u8 *)(dma_addr_t *)skb->cb);
   586		} else {
   587			rtlpriv->cfg->ops->set_desc(hw, (u8 *)entry, false,
   588						    HW_DESC_RXBUFF_ADDR,
   589						    (u8 *)&bufferaddress);
   590			rtlpriv->cfg->ops->set_desc(hw, (u8 *)entry, false,
   591						    HW_DESC_RXPKT_LEN,
   592						    (u8 *)&rtlpci->rxbuffersize);
   593			rtlpriv->cfg->ops->set_desc(hw, (u8 *)entry, false,
   594						    HW_DESC_RXOWN,
   595						    (u8 *)&tmp_one);
   596		}
   597		return 1;
   598	}
   599	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

