Return-Path: <linux-wireless+bounces-24313-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E39AE2E4C
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Jun 2025 05:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B78DE3B5A4D
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Jun 2025 03:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6E4136352;
	Sun, 22 Jun 2025 03:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ie8yT0cq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1B08248C;
	Sun, 22 Jun 2025 03:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750564740; cv=none; b=bQ9P1FYhuWtOgctUJQRZLOBxPlUkO4yn+CfRfJWBpEiCzh29djLkIv9RvcVp7+rFYuXme4wf09wmIqWcJa2MckrDxb3lcPow1NyBZ+BOA1Ay3A7uTIa2xQK/cWvwTwV9DzP6aKcG2zzrorXFu4N8N37WZuQjGR0YxNnl6obKPYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750564740; c=relaxed/simple;
	bh=i3Hqyl3yk7xPW9bAXn+Uy8H+vf+lYt7fD+tsFFDmjgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=icMPEoYTJDV9ptZgidVgYOGKzmFVRdPo55f/nVGjaX6p/PTPR+vj0lYkbQdCSqanbmAlVK3DFSDPaGVbb5UoLOZE472v0BmdcewDkBB6vTk13w9GNLAZ+5/O5f+3x1JlE49rXcX0XnxmMLKCEprT+tAAAQFrOA3vDaizsC1OXuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ie8yT0cq; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750564738; x=1782100738;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=i3Hqyl3yk7xPW9bAXn+Uy8H+vf+lYt7fD+tsFFDmjgc=;
  b=ie8yT0cq7rjyNLsGv2dN4dpsgB8HZeoA0zpI9ukfDMHUbR4FzYtJP2Ut
   wW/plqPijTC5393+fiRAzGiBpFJex9bE2Ade6pPIhZWwqgawaBPL4Lhgr
   L+UPGR6vgsP4hiJ5wOZNlKCUzPSqO5E8I1vgdrNwkNvYdHlrnwVA6eFbl
   ukwNxJbxEF3S/vi5MvEYs2BsQ3A8FMr00J4NUKk+ORq3pCsEKIi71VtAr
   IserHVk5Rmt7sIgZqRaAtG6g1vlvjZnvrTI/caeGl2GveXRQ1AjjGZ0x7
   JVRRHIJy9Wz5nWViWlhQ2XWrOw9fSekFNDhbpTVWPV2dd/e+c5p6o6Hii
   A==;
X-CSE-ConnectionGUID: lTwtu2FRT02+ZdX+AuetJw==
X-CSE-MsgGUID: KEtEgytlSVuZzlR9ahsVoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11470"; a="52935543"
X-IronPort-AV: E=Sophos;i="6.16,255,1744095600"; 
   d="scan'208";a="52935543"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2025 20:58:57 -0700
X-CSE-ConnectionGUID: 3ce5oppVTwqvZV4/ascxpQ==
X-CSE-MsgGUID: DEizkX+sTpyysIWCTN590Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,255,1744095600"; 
   d="scan'208";a="157067337"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 21 Jun 2025 20:58:55 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uTBr2-000N2A-1I;
	Sun, 22 Jun 2025 03:58:52 +0000
Date: Sun, 22 Jun 2025 11:58:30 +0800
From: kernel test robot <lkp@intel.com>
To: Rouven Czerwinski <rouven@czerwinskis.de>,
	Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: oe-kbuild-all@lists.linux.dev, kernel@pengutronix.de,
	Rouven Czerwinski <rouven@czerwinskis.de>,
	linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] brcmfmac: remove always true variable and code
Message-ID: <202506221133.9JH31DNw-lkp@intel.com>
References: <20250621112912.180436-2-rouven@czerwinskis.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250621112912.180436-2-rouven@czerwinskis.de>

Hi Rouven,

kernel test robot noticed the following build warnings:

[auto build test WARNING on wireless-next/main]
[also build test WARNING on wireless/main linus/master v6.16-rc2 next-20250620]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Rouven-Czerwinski/brcmfmac-remove-always-true-variable-and-code/20250621-193706
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/20250621112912.180436-2-rouven%40czerwinskis.de
patch subject: [PATCH 2/2] brcmfmac: remove always true variable and code
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20250622/202506221133.9JH31DNw-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250622/202506221133.9JH31DNw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506221133.9JH31DNw-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c: In function 'brcmf_sdio_sendfromq':
>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c:2329:13: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
    2329 |         int ret = 0, prec_out, i;
         |             ^~~


vim +/ret +2329 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c

5b435de0d78686 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Arend van Spriel 2011-10-05  2324  
82d7f3c10cf41c drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Arend van Spriel 2013-12-12  2325  static uint brcmf_sdio_sendfromq(struct brcmf_sdio *bus, uint maxframes)
5b435de0d78686 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Arend van Spriel 2011-10-05  2326  {
5b435de0d78686 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Arend van Spriel 2011-10-05  2327  	struct sk_buff *pkt;
8da9d2c8688825 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Franky Lin       2013-11-29  2328  	struct sk_buff_head pktq;
8da9d2c8688825 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Franky Lin       2013-11-29 @2329  	int ret = 0, prec_out, i;
5b435de0d78686 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Arend van Spriel 2011-10-05  2330  	uint cnt = 0;
8da9d2c8688825 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Franky Lin       2013-11-29  2331  	u8 tx_prec_map, pkt_num;
5b435de0d78686 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Arend van Spriel 2011-10-05  2332  
5b435de0d78686 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Arend van Spriel 2011-10-05  2333  	brcmf_dbg(TRACE, "Enter\n");
5b435de0d78686 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Arend van Spriel 2011-10-05  2334  
5b435de0d78686 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Arend van Spriel 2011-10-05  2335  	tx_prec_map = ~bus->flowcontrol;
5b435de0d78686 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Arend van Spriel 2011-10-05  2336  
5b435de0d78686 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Arend van Spriel 2011-10-05  2337  	/* Send frames until the limit or some other event */
8da9d2c8688825 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Franky Lin       2013-11-29  2338  	for (cnt = 0; (cnt < maxframes) && data_ok(bus);) {
8da9d2c8688825 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Franky Lin       2013-11-29  2339  		pkt_num = 1;
8da9d2c8688825 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Franky Lin       2013-11-29  2340  		if (bus->txglom)
8da9d2c8688825 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Franky Lin       2013-11-29  2341  			pkt_num = min_t(u8, bus->tx_max - bus->tx_seq,
af1fa210f4fc6e drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Arend van Spriel 2014-02-27  2342  					bus->sdiodev->txglomsz);
8da9d2c8688825 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Franky Lin       2013-11-29  2343  		pkt_num = min_t(u32, pkt_num,
8da9d2c8688825 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Franky Lin       2013-11-29  2344  				brcmu_pktq_mlen(&bus->txq, ~bus->flowcontrol));
fed7ec44e7ef64 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Hante Meuleman   2014-03-15  2345  		__skb_queue_head_init(&pktq);
fed7ec44e7ef64 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Hante Meuleman   2014-03-15  2346  		spin_lock_bh(&bus->txq_lock);
8da9d2c8688825 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Franky Lin       2013-11-29  2347  		for (i = 0; i < pkt_num; i++) {
8da9d2c8688825 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Franky Lin       2013-11-29  2348  			pkt = brcmu_pktq_mdeq(&bus->txq, tx_prec_map,
8da9d2c8688825 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Franky Lin       2013-11-29  2349  					      &prec_out);
8da9d2c8688825 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Franky Lin       2013-11-29  2350  			if (pkt == NULL)
5b435de0d78686 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Arend van Spriel 2011-10-05  2351  				break;
8da9d2c8688825 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Franky Lin       2013-11-29  2352  			__skb_queue_tail(&pktq, pkt);
5b435de0d78686 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Arend van Spriel 2011-10-05  2353  		}
fed7ec44e7ef64 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Hante Meuleman   2014-03-15  2354  		spin_unlock_bh(&bus->txq_lock);
4dd8b26a40acf8 drivers/net/wireless/brcm80211/brcmfmac/sdio.c          Hante Meuleman   2015-01-25  2355  		if (i == 0)
8da9d2c8688825 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Franky Lin       2013-11-29  2356  			break;
5b435de0d78686 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Arend van Spriel 2011-10-05  2357  
82d7f3c10cf41c drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Arend van Spriel 2013-12-12  2358  		ret = brcmf_sdio_txpkt(bus, &pktq, SDPCM_DATA_CHANNEL);
fed7ec44e7ef64 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Hante Meuleman   2014-03-15  2359  
8da9d2c8688825 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Franky Lin       2013-11-29  2360  		cnt += i;
5b435de0d78686 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Arend van Spriel 2011-10-05  2361  	}
5b435de0d78686 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Arend van Spriel 2011-10-05  2362  
5b435de0d78686 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Arend van Spriel 2011-10-05  2363  	/* Deflow-control stack if needed */
a1ce7a0d6a4f1e drivers/net/wireless/brcm80211/brcmfmac/sdio.c          Arend van Spriel 2015-02-06  2364  	if ((bus->sdiodev->state == BRCMF_SDIOD_DATA) &&
c8bf34849f92c5 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Franky Lin       2011-12-16  2365  	    bus->txoff && (pktq_len(&bus->txq) < TXLOW)) {
90d03ff71b52ba drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Hante Meuleman   2012-09-11  2366  		bus->txoff = false;
20ec4f57498f87 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c Franky Lin       2017-03-10  2367  		brcmf_proto_bcdc_txflowblock(bus->sdiodev->dev, false);
c8bf34849f92c5 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Franky Lin       2011-12-16  2368  	}
5b435de0d78686 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Arend van Spriel 2011-10-05  2369  
5b435de0d78686 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Arend van Spriel 2011-10-05  2370  	return cnt;
5b435de0d78686 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Arend van Spriel 2011-10-05  2371  }
5b435de0d78686 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Arend van Spriel 2011-10-05  2372  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

