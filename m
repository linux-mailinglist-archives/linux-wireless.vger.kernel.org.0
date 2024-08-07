Return-Path: <linux-wireless+bounces-11077-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A50BC94A589
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 12:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61095281535
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 10:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212E71DD3AB;
	Wed,  7 Aug 2024 10:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MLqvX7Fa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434E31D1F46
	for <linux-wireless@vger.kernel.org>; Wed,  7 Aug 2024 10:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723026704; cv=none; b=AYSFcTJzLKTnreJl8LKCxT6MZsLZx/DcE24/atC+hzPBokR16q33toSKIYKnWudTwf2ZWpR7rcnLmuhQlKTvfCaonmLSgoNnli5SefpdOlXeMs6fWSo2eZXenvbuKjBsciEEdXQCoazyBPF82ZQWUn0OVe3Dbcx8BheJVbqICDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723026704; c=relaxed/simple;
	bh=o4RJIfQu8jD6IlIKkusj8fggtx8aXzj5VhDTUypt+6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JF0p96ZA/HL5b0MDQVDePS7KaTEZsr1wV+CnlIb3eFkm12VMbG+bI3pz0d/tNUQ2cOJjYoiXiiKbOCNUCMVU8Gc4uQJHASI6qPGhpqutCyAfbp3NdayVQe78XnwCR1c6273laIZYXpImYcuDSwoJ9Gs9KXPNLLyhK2AO/RClgog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MLqvX7Fa; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723026702; x=1754562702;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=o4RJIfQu8jD6IlIKkusj8fggtx8aXzj5VhDTUypt+6U=;
  b=MLqvX7FaYtg77TUZYPY8A6qys5KcCSVq9rIE2stzxFE/k4c5DMw9zBJR
   T+b2QE7GYJuuNWABnVqdJdnZ/vFyHCOdV6f2H9zTg4JcJMvdyrbky5fCF
   G/yR7Lbh5b+gPNQx2G9Mn9D49x9afRRndJ1LNk/AsilxBydailIt7nKRK
   8AwQ7Lxtb8qtAbzpnS8NbRRmljgZI43paP7BvYWwFwVkxApj97lfJq5Lb
   090JdiqYw3arSXY25cgpS77TpYUgiAtvXgec6vxPArC/E6KtCuf/xToF9
   DQUegenokPPvs1BJ+1XRQ08SQbjW7AEsJKtTnlHTlM8HVEDu1YQqPvuoy
   A==;
X-CSE-ConnectionGUID: gkkWJOHESv+Y9rkIkStTaA==
X-CSE-MsgGUID: C0DaBPiPRK+Ms1ituYEejA==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="21229763"
X-IronPort-AV: E=Sophos;i="6.09,269,1716274800"; 
   d="scan'208";a="21229763"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 03:31:41 -0700
X-CSE-ConnectionGUID: IuxhhdMXTLCVZ6qMB3OBTg==
X-CSE-MsgGUID: 6+uSkC7AQbikRAqOHvFg0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,269,1716274800"; 
   d="scan'208";a="61745157"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 07 Aug 2024 03:31:40 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sbdxA-0005I0-2r;
	Wed, 07 Aug 2024 10:31:36 +0000
Date: Wed, 7 Aug 2024 18:31:09 +0800
From: kernel test robot <lkp@intel.com>
To: David Ruth <druth@chromium.org>, nbd@nbd.name, lorenzo@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-wireless@vger.kernel.org,
	timvp@chromium.org, sean.wang@mediatek.com, ryder.lee@mediatek.com,
	shayne.chen@mediatek.com, David Ruth <druth@chromium.org>
Subject: Re: [PATCH] wifi: mt76: mt7921: Cancel scan work on unregister.
Message-ID: <202408071730.Ux9Cr643-lkp@intel.com>
References: <20240806222113.2689446-1-druth@chromium.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806222113.2689446-1-druth@chromium.org>

Hi David,

kernel test robot noticed the following build errors:

[auto build test ERROR on wireless-next/main]
[also build test ERROR on wireless/main linus/master v6.11-rc2 next-20240807]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Ruth/wifi-mt76-mt7921-Cancel-scan-work-on-unregister/20240807-065202
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/20240806222113.2689446-1-druth%40chromium.org
patch subject: [PATCH] wifi: mt76: mt7921: Cancel scan work on unregister.
config: loongarch-allmodconfig (https://download.01.org/0day-ci/archive/20240807/202408071730.Ux9Cr643-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240807/202408071730.Ux9Cr643-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408071730.Ux9Cr643-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/wireless/mediatek/mt76/mt7921/pci.c: In function 'mt7921e_unregister_device':
>> drivers/net/wireless/mediatek/mt76/mt7921/pci.c:45:47: error: invalid type argument of '->' (have 'struct mt76_phy')
      45 |         struct mt792x_phy *phy = dev->mt76.phy->priv;
         |                                               ^~


vim +45 drivers/net/wireless/mediatek/mt76/mt7921/pci.c

    40	
    41	static void mt7921e_unregister_device(struct mt792x_dev *dev)
    42	{
    43		int i;
    44		struct mt76_connac_pm *pm = &dev->pm;
  > 45		struct mt792x_phy *phy = dev->mt76.phy->priv;
    46	
    47		cancel_delayed_work_sync(&phy->scan_work);
    48		cancel_work_sync(&dev->init_work);
    49		mt76_unregister_device(&dev->mt76);
    50		mt76_for_each_q_rx(&dev->mt76, i)
    51			napi_disable(&dev->mt76.napi[i]);
    52		cancel_delayed_work_sync(&pm->ps_work);
    53		cancel_work_sync(&pm->wake_work);
    54		cancel_work_sync(&dev->reset_work);
    55	
    56		mt76_connac2_tx_token_put(&dev->mt76);
    57		__mt792x_mcu_drv_pmctrl(dev);
    58		mt792x_dma_cleanup(dev);
    59		mt792x_wfsys_reset(dev);
    60		skb_queue_purge(&dev->mt76.mcu.res_q);
    61	
    62		tasklet_disable(&dev->mt76.irq_tasklet);
    63	}
    64	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

