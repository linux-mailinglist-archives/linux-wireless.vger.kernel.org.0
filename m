Return-Path: <linux-wireless+bounces-29346-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6F7C872FE
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Nov 2025 22:09:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D72563B69B5
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Nov 2025 21:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A102D7392;
	Tue, 25 Nov 2025 21:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IdksP4H7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E9C2E5B2D
	for <linux-wireless@vger.kernel.org>; Tue, 25 Nov 2025 21:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764104961; cv=none; b=tZmRZMkQiqSFMWsYILPyAwE2Hj1JQuUAV5Pvn76ANQhfoeqjjeR+xyyoXjKXgd4TQSlw2YI7VLS+SObD6zeknDKIJXMo2YEdniDWU16rm8uOQutGvZtcYGtijFOGbLwEQnvI622gQhnDsTdH7Je8vNpAQ/wrboxauCvkfl1gZQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764104961; c=relaxed/simple;
	bh=QzbNlCdnO2le+vDDF4HTzJdWMAQbyNJL3NeiVEE5Vxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rZw5A/D2apIHbPig3PRzsAIdwkNbDdSi0sBpluQhRTct1WEuStuTR5e/8arbN+PLyEzQXxcGMUnxkcBwbPKpX1J7CPH3drzMBEuYrVVN7yd/lv/vCkGPGj0J4AJhXmiwJOoPxU4k7X0V3UpNBc3X/X+e3L/LIY8qb0L/SgWyeFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IdksP4H7; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764104958; x=1795640958;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QzbNlCdnO2le+vDDF4HTzJdWMAQbyNJL3NeiVEE5Vxw=;
  b=IdksP4H7sr82J0op4vDd0w2SeB5noP911mKJJGfJO/lKPJw6cI05SVZo
   MY9lSc8amD3e67J82Txrb7Ta3hXjiVLBp2mNfc1yPjp76ZVC7gkiMgOlj
   LqjpQ1CkelbZKM4mhAawJe+Ho5z1O4KH3U66VtwWeReyrsLvWY+oYTFHh
   ryBUxdRzstK4zE0m1qnsXnGXUwWepS3dNcTsSi2P/MyfvUbZ99imPKwfF
   tI2LnBvXbcuxUK+9cPDvi1yBDpPbAmSkX4f9E57tir/gs+S9IkypyyExZ
   WhS753zX2pZ4lobNa+vR0VXKWtT2MoohkqQN7bD9u8pKpygw7QmF6UUoa
   Q==;
X-CSE-ConnectionGUID: LS3abha/Rv+xNB7Ovv/GXg==
X-CSE-MsgGUID: 7cP0cZpaQd2N6YNUycvaHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11624"; a="77245211"
X-IronPort-AV: E=Sophos;i="6.20,226,1758610800"; 
   d="scan'208";a="77245211"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 13:09:18 -0800
X-CSE-ConnectionGUID: WiZxaJKJTX+x09ZlkKpNsw==
X-CSE-MsgGUID: zXd9VnvpSc+uDYyLyBBfUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,226,1758610800"; 
   d="scan'208";a="223448171"
Received: from lkp-server01.sh.intel.com (HELO 4664bbef4914) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 25 Nov 2025 13:09:16 -0800
Received: from kbuild by 4664bbef4914 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vO0Hh-000000002GL-2D8l;
	Tue, 25 Nov 2025 21:09:13 +0000
Date: Wed, 26 Nov 2025 05:08:43 +0800
From: kernel test robot <lkp@intel.com>
To: Lachlan Hodges <lachlan.hodges@morsemicro.com>,
	johannes@sipsolutions.net
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-wireless@vger.kernel.org, arien.judge@morsemicro.com,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>
Subject: Re: [PATCH wireless-next 3/3] wifi: mac80211: allow sharing
 identical chanctx for S1G interfaces
Message-ID: <202511260404.HHDhZkqk-lkp@intel.com>
References: <20251125025927.245280-4-lachlan.hodges@morsemicro.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251125025927.245280-4-lachlan.hodges@morsemicro.com>

Hi Lachlan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on wireless-next/main]
[also build test WARNING on wireless/main linus/master v6.18-rc7 next-20251125]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lachlan-Hodges/wifi-cfg80211-include-s1g_primary_2mhz-when-sending-chandef/20251125-110125
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/20251125025927.245280-4-lachlan.hodges%40morsemicro.com
patch subject: [PATCH wireless-next 3/3] wifi: mac80211: allow sharing identical chanctx for S1G interfaces
config: arm-randconfig-001-20251126 (https://download.01.org/0day-ci/archive/20251126/202511260404.HHDhZkqk-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 9e9fe08b16ea2c4d9867fb4974edf2a3776d6ece)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251126/202511260404.HHDhZkqk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511260404.HHDhZkqk-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> net/mac80211/chan.c:671:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
     671 |         case NL80211_CHAN_WIDTH_20_NOHT:
         |         ^
   net/mac80211/chan.c:671:2: note: insert 'break;' to avoid fall-through
     671 |         case NL80211_CHAN_WIDTH_20_NOHT:
         |         ^
         |         break; 
   1 warning generated.


vim +671 net/mac80211/chan.c

52363af3a9c989 Johannes Berg       2025-11-05  643  
b72a455a2409fd Johannes Berg       2023-05-04  644  static void _ieee80211_change_chanctx(struct ieee80211_local *local,
d6c375095ade4e Mordechay Goodstein 2021-06-18  645  				      struct ieee80211_chanctx *ctx,
d6c375095ade4e Mordechay Goodstein 2021-06-18  646  				      struct ieee80211_chanctx *old_ctx,
6092077ad09ce8 Johannes Berg       2024-01-29  647  				      const struct ieee80211_chan_req *chanreq,
b72a455a2409fd Johannes Berg       2023-05-04  648  				      struct ieee80211_link_data *rsvd_for)
d6c375095ade4e Mordechay Goodstein 2021-06-18  649  {
6092077ad09ce8 Johannes Berg       2024-01-29  650  	const struct cfg80211_chan_def *chandef = &chanreq->oper;
761748f001800d Johannes Berg       2024-01-29  651  	struct ieee80211_chan_req ctx_req = {
761748f001800d Johannes Berg       2024-01-29  652  		.oper = ctx->conf.def,
761748f001800d Johannes Berg       2024-01-29  653  		.ap = ctx->conf.ap,
761748f001800d Johannes Berg       2024-01-29  654  	};
761748f001800d Johannes Berg       2024-01-29  655  	u32 changed = 0;
44b72ca8163b8c Ilan Peer           2020-12-06  656  
ffaa1f7cd953b4 Lachlan Hodges      2025-11-25  657  	/* 5/10 MHz not handled here */
44b72ca8163b8c Ilan Peer           2020-12-06  658  	switch (chandef->width) {
ffaa1f7cd953b4 Lachlan Hodges      2025-11-25  659  	case NL80211_CHAN_WIDTH_1:
ffaa1f7cd953b4 Lachlan Hodges      2025-11-25  660  	case NL80211_CHAN_WIDTH_2:
ffaa1f7cd953b4 Lachlan Hodges      2025-11-25  661  	case NL80211_CHAN_WIDTH_4:
ffaa1f7cd953b4 Lachlan Hodges      2025-11-25  662  	case NL80211_CHAN_WIDTH_8:
ffaa1f7cd953b4 Lachlan Hodges      2025-11-25  663  	case NL80211_CHAN_WIDTH_16:
ffaa1f7cd953b4 Lachlan Hodges      2025-11-25  664  		/*
ffaa1f7cd953b4 Lachlan Hodges      2025-11-25  665  		 * mac80211 currently only supports sharing identical
ffaa1f7cd953b4 Lachlan Hodges      2025-11-25  666  		 * chanctx's for S1G interfaces.
ffaa1f7cd953b4 Lachlan Hodges      2025-11-25  667  		 */
ffaa1f7cd953b4 Lachlan Hodges      2025-11-25  668  		if (ieee80211_chanreq_identical(&ctx_req, chanreq))
ffaa1f7cd953b4 Lachlan Hodges      2025-11-25  669  			return;
ffaa1f7cd953b4 Lachlan Hodges      2025-11-25  670  		WARN_ON(1);
44b72ca8163b8c Ilan Peer           2020-12-06 @671  	case NL80211_CHAN_WIDTH_20_NOHT:
44b72ca8163b8c Ilan Peer           2020-12-06  672  	case NL80211_CHAN_WIDTH_20:
44b72ca8163b8c Ilan Peer           2020-12-06  673  	case NL80211_CHAN_WIDTH_40:
44b72ca8163b8c Ilan Peer           2020-12-06  674  	case NL80211_CHAN_WIDTH_80:
44b72ca8163b8c Ilan Peer           2020-12-06  675  	case NL80211_CHAN_WIDTH_80P80:
44b72ca8163b8c Ilan Peer           2020-12-06  676  	case NL80211_CHAN_WIDTH_160:
5dca295dd76756 Ilan Peer           2022-02-14  677  	case NL80211_CHAN_WIDTH_320:
44b72ca8163b8c Ilan Peer           2020-12-06  678  		break;
44b72ca8163b8c Ilan Peer           2020-12-06  679  	default:
44b72ca8163b8c Ilan Peer           2020-12-06  680  		WARN_ON(1);
44b72ca8163b8c Ilan Peer           2020-12-06  681  	}
44b72ca8163b8c Ilan Peer           2020-12-06  682  
d6c375095ade4e Mordechay Goodstein 2021-06-18  683  	/* Check maybe BW narrowed - we do this _before_ calling recalc_chanctx_min_def
d6c375095ade4e Mordechay Goodstein 2021-06-18  684  	 * due to maybe not returning from it, e.g in case new context was added
d6c375095ade4e Mordechay Goodstein 2021-06-18  685  	 * first time with all parameters up to date.
d6c375095ade4e Mordechay Goodstein 2021-06-18  686  	 */
b27512368591fc Johannes Berg       2024-06-12  687  	ieee80211_chan_bw_change(local, old_ctx, false, true);
44b72ca8163b8c Ilan Peer           2020-12-06  688  
761748f001800d Johannes Berg       2024-01-29  689  	if (ieee80211_chanreq_identical(&ctx_req, chanreq)) {
52363af3a9c989 Johannes Berg       2025-11-05  690  		_ieee80211_recalc_chanctx_min_def(local, ctx, rsvd_for, false);
d6c375095ade4e Mordechay Goodstein 2021-06-18  691  		return;
d6c375095ade4e Mordechay Goodstein 2021-06-18  692  	}
d6c375095ade4e Mordechay Goodstein 2021-06-18  693  
761748f001800d Johannes Berg       2024-01-29  694  	WARN_ON(ieee80211_chanctx_refcount(local, ctx) > 1 &&
761748f001800d Johannes Berg       2024-01-29  695  		!cfg80211_chandef_compatible(&ctx->conf.def, &chanreq->oper));
d6c375095ade4e Mordechay Goodstein 2021-06-18  696  
d34be4310cbe3a Evan Quan           2023-12-11  697  	ieee80211_remove_wbrf(local, &ctx->conf.def);
d34be4310cbe3a Evan Quan           2023-12-11  698  
b82730bf57b548 Johannes Berg       2024-01-29  699  	if (!cfg80211_chandef_identical(&ctx->conf.def, &chanreq->oper)) {
b82730bf57b548 Johannes Berg       2024-01-29  700  		if (ctx->conf.def.width != chanreq->oper.width)
761748f001800d Johannes Berg       2024-01-29  701  			changed |= IEEE80211_CHANCTX_CHANGE_WIDTH;
b82730bf57b548 Johannes Berg       2024-01-29  702  		if (ctx->conf.def.punctured != chanreq->oper.punctured)
b82730bf57b548 Johannes Berg       2024-01-29  703  			changed |= IEEE80211_CHANCTX_CHANGE_PUNCTURING;
b82730bf57b548 Johannes Berg       2024-01-29  704  	}
761748f001800d Johannes Berg       2024-01-29  705  	if (!cfg80211_chandef_identical(&ctx->conf.ap, &chanreq->ap))
761748f001800d Johannes Berg       2024-01-29  706  		changed |= IEEE80211_CHANCTX_CHANGE_AP;
d6c375095ade4e Mordechay Goodstein 2021-06-18  707  	ctx->conf.def = *chandef;
761748f001800d Johannes Berg       2024-01-29  708  	ctx->conf.ap = chanreq->ap;
d6c375095ade4e Mordechay Goodstein 2021-06-18  709  
d6c375095ade4e Mordechay Goodstein 2021-06-18  710  	/* check if min chanctx also changed */
52363af3a9c989 Johannes Berg       2025-11-05  711  	changed |= __ieee80211_recalc_chanctx_min_def(local, ctx, rsvd_for,
52363af3a9c989 Johannes Berg       2025-11-05  712  						      false);
d34be4310cbe3a Evan Quan           2023-12-11  713  
d34be4310cbe3a Evan Quan           2023-12-11  714  	ieee80211_add_wbrf(local, &ctx->conf.def);
d34be4310cbe3a Evan Quan           2023-12-11  715  
d6c375095ade4e Mordechay Goodstein 2021-06-18  716  	drv_change_chanctx(local, ctx, changed);
55de908ab292c0 Johannes Berg       2012-07-26  717  
761748f001800d Johannes Berg       2024-01-29  718  	/* check if BW is wider */
b27512368591fc Johannes Berg       2024-06-12  719  	ieee80211_chan_bw_change(local, old_ctx, false, false);
0aaffa9b969989 Johannes Berg       2010-05-05  720  }
d01a1e658606a0 Michal Kazior       2012-06-26  721  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

