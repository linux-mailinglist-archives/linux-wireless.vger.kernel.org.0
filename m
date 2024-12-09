Return-Path: <linux-wireless+bounces-16005-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 678039E8A27
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 05:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21F1A281114
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 04:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB30157493;
	Mon,  9 Dec 2024 04:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eMdiyGnK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E546156C6F
	for <linux-wireless@vger.kernel.org>; Mon,  9 Dec 2024 04:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733717474; cv=none; b=uvEj0+YVEZtgvBwtB+0QbWy7YcYT5RyU/A9bZv91yIXtseExrxTHGaDHCS0tuvTx9PS8SeIciVATH6ZwkhDt0e3XWK2eyR+2wfo1FjQKvJ0RKRL4XsqQaLkqpiNCFT+VtxUtC6kyynA68imeGAAZGOdEoOKQBLdiES9g7scROS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733717474; c=relaxed/simple;
	bh=3q6mGylu6FW+f0kFijxV5nWrm1Nnck+Lvc/vZ5ppUT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t/XTuCHt5RynTPNUrSa8Hx8cC/4wzoZL8mNlhRCrqsi8EFXQnuMDfRzLaY1V9hg7TKglZ7kty+E4o5PiXhrhTeIUvFVdoDIss/09lEJVb0//3ufJ9x/H0DXSU5AutwQQUDECFQWDSNPlevbLBo4c1iHyySOa9i2NJr463rfEef0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eMdiyGnK; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733717473; x=1765253473;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3q6mGylu6FW+f0kFijxV5nWrm1Nnck+Lvc/vZ5ppUT4=;
  b=eMdiyGnKOC5ANtK/BD0SJZvevhVA2yOrpklrI7EPRt0YJiYs8ZJ+btDN
   sBa5KYQrL4w4noEud9XqDRwfv2XrGYKJGEDSfUoWzx0rrDrD2r4IPZRTg
   JS0SqGepoEjNXonqbS+cID2kecUm3Jc6PbnNrv6NyKVrawtuqyQm7g/kU
   pwzuiIhxaPxrZlHMoneyZthC6pje48JGkin18PW6bEl4TsiaBzyXSjhOf
   +8e5O3o9+3oXQTOfbnm1nanlpIobdAuNVrcftIHnok3wiFnqrMaqyNMNs
   9YrkG4y7RqHaZrbEKe0vPpuXcTzJckyCeZpnS/qo67knVMjEVOgBuxZpL
   g==;
X-CSE-ConnectionGUID: jlpHmnvASNOz6lqxx7wE5g==
X-CSE-MsgGUID: xWcvLk5rR0iLIitMNEvozQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11280"; a="33330654"
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="33330654"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2024 20:11:12 -0800
X-CSE-ConnectionGUID: 7067EjQeRFSAwrOZR6V2Kg==
X-CSE-MsgGUID: K7jptP4CRROTw0m+f7TTiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="100003655"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 08 Dec 2024 20:11:08 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tKV6v-0003nl-0f;
	Mon, 09 Dec 2024 04:11:05 +0000
Date: Mon, 9 Dec 2024 12:10:17 +0800
From: kernel test robot <lkp@intel.com>
To: Allan Wang <allan.wang@mediatek.com>, nbd@nbd.name, lorenzo@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com, Sean.Wang@mediatek.com,
	Soul.Huang@mediatek.com, Leon.Yen@mediatek.com,
	Michael.Lo@mediatek.com, Eric-SY.Chang@mediatek.com,
	km.lin@mediatek.com, robin.chiu@mediatek.com, ch.yeh@mediatek.com,
	posh.sun@mediatek.com, Quan.Zhou@mediatek.com,
	Ryder.Lee@mediatek.com, Shayne.Chen@mediatek.com,
	linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org,
	Allan Wang <allan.wang@mediatek.com>
Subject: Re: [PATCH] wifi: mt76: mt7921: add rfkill_poll for hardware rfkill
Message-ID: <202412071431.tF1EfPaT-lkp@intel.com>
References: <20241206014355.32426-1-allan.wang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206014355.32426-1-allan.wang@mediatek.com>

Hi Allan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on wireless-next/main]
[also build test WARNING on wireless/main linus/master v6.13-rc1 next-20241206]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Allan-Wang/wifi-mt76-mt7921-add-rfkill_poll-for-hardware-rfkill/20241206-094523
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/20241206014355.32426-1-allan.wang%40mediatek.com
patch subject: [PATCH] wifi: mt76: mt7921: add rfkill_poll for hardware rfkill
config: powerpc-randconfig-r113-20241207 (https://download.01.org/0day-ci/archive/20241207/202412071431.tF1EfPaT-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 592c0fe55f6d9a811028b5f3507be91458ab2713)
reproduce: (https://download.01.org/0day-ci/archive/20241207/202412071431.tF1EfPaT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412071431.tF1EfPaT-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/net/wireless/mediatek/mt76/mt7921/mcu.c:69:28: sparse: sparse: cast to restricted __le32

vim +69 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c

    17	
    18	int mt7921_mcu_parse_response(struct mt76_dev *mdev, int cmd,
    19				      struct sk_buff *skb, int seq)
    20	{
    21		int mcu_cmd = FIELD_GET(__MCU_CMD_FIELD_ID, cmd);
    22		struct mt76_connac2_mcu_rxd *rxd;
    23		int ret = 0;
    24	
    25		if (!skb) {
    26			dev_err(mdev->dev, "Message %08x (seq %d) timeout\n",
    27				cmd, seq);
    28			mt792x_reset(mdev);
    29	
    30			return -ETIMEDOUT;
    31		}
    32	
    33		rxd = (struct mt76_connac2_mcu_rxd *)skb->data;
    34		if (seq != rxd->seq)
    35			return -EAGAIN;
    36	
    37		if (cmd == MCU_CMD(PATCH_SEM_CONTROL) ||
    38		    cmd == MCU_CMD(PATCH_FINISH_REQ)) {
    39			skb_pull(skb, sizeof(*rxd) - 4);
    40			ret = *skb->data;
    41		} else if (cmd == MCU_EXT_CMD(THERMAL_CTRL)) {
    42			skb_pull(skb, sizeof(*rxd) + 4);
    43			ret = le32_to_cpu(*(__le32 *)skb->data);
    44		} else if (cmd == MCU_UNI_CMD(DEV_INFO_UPDATE) ||
    45			   cmd == MCU_UNI_CMD(BSS_INFO_UPDATE) ||
    46			   cmd == MCU_UNI_CMD(STA_REC_UPDATE) ||
    47			   cmd == MCU_UNI_CMD(HIF_CTRL) ||
    48			   cmd == MCU_UNI_CMD(OFFLOAD) ||
    49			   cmd == MCU_UNI_CMD(SUSPEND)) {
    50			struct mt76_connac_mcu_uni_event *event;
    51	
    52			skb_pull(skb, sizeof(*rxd));
    53			event = (struct mt76_connac_mcu_uni_event *)skb->data;
    54			ret = le32_to_cpu(event->status);
    55			/* skip invalid event */
    56			if (mcu_cmd != event->cid)
    57				ret = -EAGAIN;
    58		} else if (cmd == MCU_CE_QUERY(REG_READ)) {
    59			struct mt76_connac_mcu_reg_event *event;
    60	
    61			skb_pull(skb, sizeof(*rxd));
    62			event = (struct mt76_connac_mcu_reg_event *)skb->data;
    63			ret = (int)le32_to_cpu(event->val);
    64		} else if (cmd == MCU_EXT_CMD(WF_RF_PIN_CTRL)) {
    65			struct mt7921_wf_rf_pin_ctrl_event *event;
    66	
    67			skb_pull(skb, sizeof(*rxd));
    68			event = (struct mt7921_wf_rf_pin_ctrl_event *)skb->data;
  > 69			ret = (int)le32_to_cpu(event->result);
    70		} else {
    71			skb_pull(skb, sizeof(struct mt76_connac2_mcu_rxd));
    72		}
    73	
    74		return ret;
    75	}
    76	EXPORT_SYMBOL_GPL(mt7921_mcu_parse_response);
    77	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

