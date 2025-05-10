Return-Path: <linux-wireless+bounces-22812-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D70C3AB23F3
	for <lists+linux-wireless@lfdr.de>; Sat, 10 May 2025 15:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28A804C450E
	for <lists+linux-wireless@lfdr.de>; Sat, 10 May 2025 13:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7311EA7D6;
	Sat, 10 May 2025 13:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NlvOkbfw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2D938385
	for <linux-wireless@vger.kernel.org>; Sat, 10 May 2025 13:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746884303; cv=none; b=Smx0erZmUkBOkasklmKnLRdmrrqnJzxI8Nu4lG3/jhHjKlJPmMpJDRoUbFUtI9iP6NJC5ybiuQZ19vVc4+Zu+sGHpKIwnZW/DiLmD02XD6Nzw5yIOi/dFzj3BatodARHucUzY07Cue2X4NYHpP8FjpjQN2y+kr1EiUxCbkqtVVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746884303; c=relaxed/simple;
	bh=N5m2C8fR9ZknTZ3A7QvMU08+G+c0tdzcFjr6VMADeJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YehuC2UlFL56Mp3gFfxvTbxH/VkXb8zokXwjOUg0tS/14LpMzbSIpK/yZPeDPZGw8Gy3sv+vaK4T2iBOiWFuaQwT+MlEp/dBWxr14lZgzvWfZCeVRmdWhDvUfHDBl1VlPLZ2RMfwGDf5C73VWxRl4u9OJVNYfhh+aKA3F3/X4j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NlvOkbfw; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746884301; x=1778420301;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=N5m2C8fR9ZknTZ3A7QvMU08+G+c0tdzcFjr6VMADeJM=;
  b=NlvOkbfwBy+KCfiOFakzsTbgxO5D+hkIvk1jX+7UPizzS1hZLTuKmaga
   2JECJZTgm2O3O2wwfpOV0yRLSzTGNWcCcVMFW7zTvxb7PF+wUEFK3CYE0
   zWed0DqzFW3ytp55jn9OsfsZaXGUQmZQMQboeYzBQ6IY9/TZrgW40dGhm
   793PwmBwI609N5DDQ2EreAYyQWJgimURHluvrDfkBlLzUic+ixLgDT4ym
   dhdABrKp16zpIg4DQKhSDnISR6wssw2CU5QEj0R38Pal7SuEHvAj0reYD
   pQVifpSyCuLsiTWXoqJwUjtjYKSb3YqN2OZq5FMx+Za5QYYMIrhcoYb5x
   A==;
X-CSE-ConnectionGUID: hQaEu+bvSp2VnEwICfja+A==
X-CSE-MsgGUID: X+42XO8MTTibDL994L1HSA==
X-IronPort-AV: E=McAfee;i="6700,10204,11429"; a="48862860"
X-IronPort-AV: E=Sophos;i="6.15,278,1739865600"; 
   d="scan'208";a="48862860"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2025 06:38:21 -0700
X-CSE-ConnectionGUID: xkKtXl9kTkONJvPSU+8ARA==
X-CSE-MsgGUID: 2epkTEa2RyifNRsgD4J+rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,278,1739865600"; 
   d="scan'208";a="136585522"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 10 May 2025 06:38:18 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uDkPA-000D6x-1T;
	Sat, 10 May 2025 13:38:16 +0000
Date: Sat, 10 May 2025 21:37:53 +0800
From: kernel test robot <lkp@intel.com>
To: sean.wang@kernel.org, nbd@nbd.name, lorenzo.bianconi@redhat.com
Cc: oe-kbuild-all@lists.linux.dev, sean.wang@mediatek.com,
	deren.wu@mediatek.com, mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org,
	Michael Lo <michael.lo@mediatek.com>
Subject: Re: [PATCH 2/2] wifi: mt76: mt7925: add test mode support
Message-ID: <202505102153.oOZ0YXsZ-lkp@intel.com>
References: <20250505233618.1951021-2-sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250505233618.1951021-2-sean.wang@kernel.org>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on wireless-next/main]
[also build test WARNING on wireless/main linus/master v6.15-rc5 next-20250509]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/sean-wang-kernel-org/wifi-mt76-mt7925-add-test-mode-support/20250506-115641
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/20250505233618.1951021-2-sean.wang%40kernel.org
patch subject: [PATCH 2/2] wifi: mt76: mt7925: add test mode support
config: loongarch-allyesconfig (https://download.01.org/0day-ci/archive/20250510/202505102153.oOZ0YXsZ-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250510/202505102153.oOZ0YXsZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505102153.oOZ0YXsZ-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/wireless/mediatek/mt76/mt7925/testmode.c: In function 'mt7925_tm_query':
>> drivers/net/wireless/mediatek/mt76/mt7925/testmode.c:92:38: warning: variable 'evt' set but not used [-Wunused-but-set-variable]
      92 |         struct uni_cmd_testmode_evt *evt;
         |                                      ^~~


vim +/evt +92 drivers/net/wireless/mediatek/mt76/mt7925/testmode.c

    85	
    86	static int
    87	mt7925_tm_query(struct mt792x_dev *dev, struct mt7925_tm_cmd *req,
    88			char *evt_resp)
    89	{
    90		struct mt7925_rftest_cmd cmd;
    91		char *pcmd = (char *)&cmd;
  > 92		struct uni_cmd_testmode_evt *evt;
    93		struct sk_buff *skb = NULL;
    94		int ret = 1;
    95	
    96		memset(pcmd, 0, sizeof(*pcmd));
    97		memcpy(pcmd + 4, (char *)&req->c, sizeof(struct uni_cmd_testmode_ctrl));
    98	
    99		if (*((uint16_t *)req->padding) == MCU_UNI_CMD_TESTMODE_CTRL)
   100			ret = mt76_mcu_send_and_get_msg(&dev->mt76, MCU_UNI_QUERY(TESTMODE_CTRL),
   101							&cmd, sizeof(cmd), true, &skb);
   102		else if (*((uint16_t *)req->padding) == MCU_UNI_CMD_TESTMODE_RX_STAT)
   103			ret = mt76_mcu_send_and_get_msg(&dev->mt76, MCU_UNI_QUERY(TESTMODE_RX_STAT),
   104							&cmd, sizeof(cmd), true, &skb);
   105	
   106		if (ret)
   107			goto out;
   108	
   109		evt = (struct uni_cmd_testmode_evt *)skb->data;
   110	
   111		memcpy((char *)evt_resp, (char *)skb->data + 8, MT7925_EVT_RSP_LEN);
   112	
   113	out:
   114		dev_kfree_skb(skb);
   115	
   116		return ret;
   117	}
   118	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

