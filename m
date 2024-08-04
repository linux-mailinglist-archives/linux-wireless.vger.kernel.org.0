Return-Path: <linux-wireless+bounces-10882-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC6A946BFC
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Aug 2024 04:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A5311F21ABE
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Aug 2024 02:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF68933D8;
	Sun,  4 Aug 2024 02:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sb/nVSCk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B99A28EF;
	Sun,  4 Aug 2024 02:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722739576; cv=none; b=dXXHG9J9FlbH/E3pnW6MZfYBzdH0WGmrIB8RZSFNrScyTMGtVXFYBv+ntIL1iAGkHhzuyKhuozVQHjQvhZMG8AJOx8fjUqFp/LR/b844miuyQ2m7opetDR3xWssLP6YNk9MKMy5dFf9pjbKXvV764LFCH72GGj+jI9Og62Wdj5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722739576; c=relaxed/simple;
	bh=UZPIB9k/6HryMcopKOFaXfW3Di8l2l4XGoixC2YRSz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W8KZSQRIr0SVfKYqwpWsJflsgjdo8FNLOBZOaJsAeq/GO+7OoI/KQq54YgsPiXwO85+QGcj/AlaHxfNb1VIhIeIuIc5ZuTYDlb/4rx/fkgO86AKn2KacxAWVRRdBIYTaj+WPJ/caOlFL9m6kmPJzDV0t51P0QQU+Cc3C6j6Sb0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sb/nVSCk; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722739573; x=1754275573;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UZPIB9k/6HryMcopKOFaXfW3Di8l2l4XGoixC2YRSz8=;
  b=Sb/nVSCkTlydEKJl1+rwoP7rt0JTQEbJtAQ99JYWIiCg65fSG0SIaALC
   DCPkgb8pP3vWOW6QmjR8d4ltPaApo23amwMa2TxwyE407Qugb30YnL6EG
   fwXsyAtTflXdlh9QNYEf+xjYD++V+BmDWRAqHDx7JSjECccJmwt0YBs07
   iTrMnxT9OfTIUU2Vz0IZbQ9Cbmu2PrXXO8ZTN9Yjr8B+Cdsn+rkG3kxHB
   mRtiyFZkb905iU7Hp/HnFNrlXlngrJZCmgc/UJNeseueB+98Y7sx3eDOL
   +aUVZXvOoP/PmUf/TR1kxNhEHajmmeS+wu54lFgZd7VsLDCkS/QWGhT5r
   w==;
X-CSE-ConnectionGUID: xseB8woXTOKmyBFRvGT3Aw==
X-CSE-MsgGUID: t4hP2ZjKR2ykS7w9Usy1VA==
X-IronPort-AV: E=McAfee;i="6700,10204,11153"; a="31305308"
X-IronPort-AV: E=Sophos;i="6.09,261,1716274800"; 
   d="scan'208";a="31305308"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2024 19:46:12 -0700
X-CSE-ConnectionGUID: tUdbOXShQoy0NydWwrTSUQ==
X-CSE-MsgGUID: oWFehfiCQXOYzSahTnzoKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,261,1716274800"; 
   d="scan'208";a="55909432"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 03 Aug 2024 19:46:08 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1saRG1-000163-1x;
	Sun, 04 Aug 2024 02:46:05 +0000
Date: Sun, 4 Aug 2024 10:43:33 +0800
From: kernel test robot <lkp@intel.com>
To: Shengyu Qu <wiagn233@outlook.com>, nbd@nbd.name, lorenzo@kernel.org,
	ryder.lee@mediatek.com, shayne.chen@mediatek.com,
	sean.wang@mediatek.com, kvalo@kernel.org, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com, chui-hao.chiu@mediatek.com,
	emmanuel.grumbach@intel.com, StanleyYP.Wang@mediatek.com,
	meichia.chiu@mediatek.com, johannes.berg@intel.com,
	quic_adisi@quicinc.com, allen.ye@mediatek.com, bo.jiao@mediatek.com,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev, Shengyu Qu <wiagn233@outlook.com>,
	Sujuan Chen <sujuan.chen@mediatek.com>
Subject: Re: [PATCH v5] wifi: mt76: mt7915: add wds support when wed is
 enabled
Message-ID: <202408041039.BqVRJOqp-lkp@intel.com>
References: <TY3P286MB2611CB2F4F5FA27D782AA80A98BC2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TY3P286MB2611CB2F4F5FA27D782AA80A98BC2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>

Hi Shengyu,

kernel test robot noticed the following build errors:

[auto build test ERROR on wireless-next/main]
[also build test ERROR on wireless/main linus/master v6.11-rc1 next-20240802]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Shengyu-Qu/wifi-mt76-mt7915-add-wds-support-when-wed-is-enabled/20240803-231632
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/TY3P286MB2611CB2F4F5FA27D782AA80A98BC2%40TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
patch subject: [PATCH v5] wifi: mt76: mt7915: add wds support when wed is enabled
config: x86_64-buildonly-randconfig-003-20240804 (https://download.01.org/0day-ci/archive/20240804/202408041039.BqVRJOqp-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240804/202408041039.BqVRJOqp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408041039.BqVRJOqp-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/wireless/mediatek/mt76/mt7915/mcu.c: In function 'mt7915_mcu_init_firmware':
>> drivers/net/wireless/mediatek/mt76/mt7915/mcu.c:2363:67: error: 'struct mtk_wed_device' has no member named 'rev_id'
    2363 |                                                 dev->mt76.mmio.wed.rev_id, 0);
         |                                                                   ^


vim +2363 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c

  2322	
  2323	int mt7915_mcu_init_firmware(struct mt7915_dev *dev)
  2324	{
  2325		int ret;
  2326	
  2327		/* force firmware operation mode into normal state,
  2328		 * which should be set before firmware download stage.
  2329		 */
  2330		mt76_wr(dev, MT_SWDEF_MODE, MT_SWDEF_NORMAL_MODE);
  2331	
  2332		ret = mt7915_driver_own(dev, 0);
  2333		if (ret)
  2334			return ret;
  2335		/* set driver own for band1 when two hif exist */
  2336		if (dev->hif2) {
  2337			ret = mt7915_driver_own(dev, 1);
  2338			if (ret)
  2339				return ret;
  2340		}
  2341	
  2342		ret = mt7915_load_firmware(dev);
  2343		if (ret)
  2344			return ret;
  2345	
  2346		set_bit(MT76_STATE_MCU_RUNNING, &dev->mphy.state);
  2347		ret = mt7915_mcu_fw_log_2_host(dev, MCU_FW_LOG_WM, 0);
  2348		if (ret)
  2349			return ret;
  2350	
  2351		ret = mt7915_mcu_fw_log_2_host(dev, MCU_FW_LOG_WA, 0);
  2352		if (ret)
  2353			return ret;
  2354	
  2355		if (mtk_wed_device_active(&dev->mt76.mmio.wed)) {
  2356			if (is_mt7915(&dev->mt76) ||
  2357			    !mtk_wed_get_rx_capa(&dev->mt76.mmio.wed))
  2358				ret = mt7915_mcu_wa_cmd(dev, MCU_WA_PARAM_CMD(CAPABILITY),
  2359							0, 0, 0);
  2360			else
  2361				ret = mt7915_mcu_wa_cmd(dev, MCU_WA_PARAM_CMD(SET),
  2362							MCU_WA_PARAM_WED_VERSION,
> 2363							dev->mt76.mmio.wed.rev_id, 0);
  2364			if (ret)
  2365				return ret;
  2366		}
  2367	
  2368		ret = mt7915_mcu_set_mwds(dev, 1);
  2369		if (ret)
  2370			return ret;
  2371	
  2372		ret = mt7915_mcu_set_muru_ctrl(dev, MURU_SET_PLATFORM_TYPE,
  2373					       MURU_PLATFORM_TYPE_PERF_LEVEL_2);
  2374		if (ret)
  2375			return ret;
  2376	
  2377		ret = mt7915_mcu_init_rx_airtime(dev);
  2378		if (ret)
  2379			return ret;
  2380	
  2381		return mt7915_mcu_set_red(dev, mtk_wed_device_active(&dev->mt76.mmio.wed));
  2382	}
  2383	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

