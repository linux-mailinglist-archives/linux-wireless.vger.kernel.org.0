Return-Path: <linux-wireless+bounces-16284-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A109EDE88
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2024 05:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 573312807AF
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2024 04:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E90126BEE;
	Thu, 12 Dec 2024 04:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RUgTBK8X"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0904A15AAC1
	for <linux-wireless@vger.kernel.org>; Thu, 12 Dec 2024 04:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733977900; cv=none; b=Ys57vA+CbBSasQhqDaoGLbdFxlWdTchhu4xxNfbEJ+GtzAU6stO/+dB2AmAmOJ4WPGXuIi/wDbubKJ6NodCHa8F0xFO2JYz0WFJ/U/Sb0n8LjVs3QF8wyVTlxnT3IymAFa8cg9tagDCdUAa91x9uG19203dxivupEAm/W+aOioU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733977900; c=relaxed/simple;
	bh=5YZA2j3sUfOMpP0SPfYfSizTKfq/iiwV6Ec1/cBNMr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gcn73mV96bgs6rD/qMXgfjehG7VjZ/XEBIZb3l11xliMcyDxQnCJT7GjcHW7xCXKsl2k3Kx7rqyf5TeYKJvhfXPOyMiLBTS2Tur/wFcxRkU6yysW/t2avGm1K7VKrQ/k+Nl2vMyiuyKCb62x8CD2W99tC9z0ZIMun+QkdjJFhSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RUgTBK8X; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733977898; x=1765513898;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5YZA2j3sUfOMpP0SPfYfSizTKfq/iiwV6Ec1/cBNMr4=;
  b=RUgTBK8XzoW1oJa8Wxx/z/aoKMWe/D06tcg/IO8RHXDm1pPEbZzwZKs9
   L9UGduCxjq1Z9u+0bwEOzx7lyCXix9WjBk3kzvqRp8JJ/mOxpU/un5vRs
   H1rtH+/H63ble+id/E613Q/PfiLs/ea4aUuew0z/WQ/vmEzUyqtm1mSun
   U0QLoLO8yo2l88CyUfDkzyGKhAXaH7hVXpmQHCRUgHYc5xudYTENA2ykx
   Wd/AD2rMWdkixQkrtYNvRXtru8WLeU2pQOQ9MEQ9/5NGrFLaNzWf0edL/
   wq7Fz5QLhMv7kQlKbaTZ6SVJVDta9LggVFKYk65k3LUF6mixMqCdYuSt9
   Q==;
X-CSE-ConnectionGUID: pIZcPFbZQWyD18sBsK3d/g==
X-CSE-MsgGUID: jsIt75IuStmJvK/Io86jAw==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="34253916"
X-IronPort-AV: E=Sophos;i="6.12,227,1728975600"; 
   d="scan'208";a="34253916"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 20:31:37 -0800
X-CSE-ConnectionGUID: y7HqZ6/nRhmgxnByBUnGiw==
X-CSE-MsgGUID: iZW5l9gJRBqFExCC25+png==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,227,1728975600"; 
   d="scan'208";a="101114606"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 11 Dec 2024 20:31:35 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tLarN-0007Qr-0n;
	Thu, 12 Dec 2024 04:31:33 +0000
Date: Thu, 12 Dec 2024 12:30:40 +0800
From: kernel test robot <lkp@intel.com>
To: sean.wang@kernel.org, nbd@nbd.name, lorenzo.bianconi@redhat.com
Cc: oe-kbuild-all@lists.linux.dev, sean.wang@mediatek.com,
	deren.wu@mediatek.com, mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 12/17] wifi: mt76: mt7925: Update
 mt7925_unassign_vif_chanctx for per-link BSS
Message-ID: <202412121200.voBerw6W-lkp@intel.com>
References: <20241211011926.5002-12-sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211011926.5002-12-sean.wang@kernel.org>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on wireless-next/main]
[also build test WARNING on wireless/main linus/master v6.13-rc2 next-20241211]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/sean-wang-kernel-org/wifi-mt76-mt7925-Fix-incorrect-MLD-address-in-bss_mld_tlv-for-MLO-support/20241211-092359
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/20241211011926.5002-12-sean.wang%40kernel.org
patch subject: [PATCH 12/17] wifi: mt76: mt7925: Update mt7925_unassign_vif_chanctx for per-link BSS
config: sh-allyesconfig (https://download.01.org/0day-ci/archive/20241212/202412121200.voBerw6W-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241212/202412121200.voBerw6W-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412121200.voBerw6W-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/wireless/mediatek/mt76/mt7925/main.c: In function 'mt7925_unassign_vif_chanctx':
>> drivers/net/wireless/mediatek/mt76/mt7925/main.c:2082:36: warning: variable 'pri_link_conf' set but not used [-Wunused-but-set-variable]
    2082 |         struct ieee80211_bss_conf *pri_link_conf;
         |                                    ^~~~~~~~~~~~~


vim +/pri_link_conf +2082 drivers/net/wireless/mediatek/mt76/mt7925/main.c

621e9e22b8d031 Sean Wang      2024-07-06  2073  
621e9e22b8d031 Sean Wang      2024-07-06  2074  static void mt7925_unassign_vif_chanctx(struct ieee80211_hw *hw,
621e9e22b8d031 Sean Wang      2024-07-06  2075  					struct ieee80211_vif *vif,
621e9e22b8d031 Sean Wang      2024-07-06  2076  					struct ieee80211_bss_conf *link_conf,
621e9e22b8d031 Sean Wang      2024-07-06  2077  					struct ieee80211_chanctx_conf *ctx)
621e9e22b8d031 Sean Wang      2024-07-06  2078  {
621e9e22b8d031 Sean Wang      2024-07-06  2079  	struct mt792x_chanctx *mctx = (struct mt792x_chanctx *)ctx->drv_priv;
621e9e22b8d031 Sean Wang      2024-07-06  2080  	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
621e9e22b8d031 Sean Wang      2024-07-06  2081  	struct mt792x_dev *dev = mt792x_hw_dev(hw);
621e9e22b8d031 Sean Wang      2024-07-06 @2082  	struct ieee80211_bss_conf *pri_link_conf;
621e9e22b8d031 Sean Wang      2024-07-06  2083  	struct mt792x_bss_conf *mconf;
621e9e22b8d031 Sean Wang      2024-07-06  2084  
621e9e22b8d031 Sean Wang      2024-07-06  2085  	mutex_lock(&dev->mt76.mutex);
621e9e22b8d031 Sean Wang      2024-07-06  2086  
621e9e22b8d031 Sean Wang      2024-07-06  2087  	if (ieee80211_vif_is_mld(vif)) {
621e9e22b8d031 Sean Wang      2024-07-06  2088  		mconf = mt792x_vif_to_link(mvif, link_conf->link_id);
621e9e22b8d031 Sean Wang      2024-07-06  2089  		pri_link_conf = mt792x_vif_to_bss_conf(vif, mvif->deflink_id);
621e9e22b8d031 Sean Wang      2024-07-06  2090  
621e9e22b8d031 Sean Wang      2024-07-06  2091  		if (vif->type == NL80211_IFTYPE_STATION &&
621e9e22b8d031 Sean Wang      2024-07-06  2092  		    mconf == &mvif->bss_conf)
ef9f0dc93583f5 Ming Yen Hsieh 2024-12-10  2093  			mt7925_mcu_add_bss_info(&dev->phy, NULL, link_conf,
621e9e22b8d031 Sean Wang      2024-07-06  2094  						NULL, false);
621e9e22b8d031 Sean Wang      2024-07-06  2095  	} else {
621e9e22b8d031 Sean Wang      2024-07-06  2096  		mconf = &mvif->bss_conf;
621e9e22b8d031 Sean Wang      2024-07-06  2097  	}
621e9e22b8d031 Sean Wang      2024-07-06  2098  
621e9e22b8d031 Sean Wang      2024-07-06  2099  	mctx->bss_conf = NULL;
621e9e22b8d031 Sean Wang      2024-07-06  2100  	mconf->mt76.ctx = NULL;
621e9e22b8d031 Sean Wang      2024-07-06  2101  	mutex_unlock(&dev->mt76.mutex);
621e9e22b8d031 Sean Wang      2024-07-06  2102  }
621e9e22b8d031 Sean Wang      2024-07-06  2103  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

