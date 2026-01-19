Return-Path: <linux-wireless+bounces-30950-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A01D3A60C
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Jan 2026 12:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CBF1E305B1F7
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Jan 2026 10:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7417B3502BF;
	Mon, 19 Jan 2026 10:59:16 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.lysator.liu.se (mail.lysator.liu.se [130.236.254.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013533033DB
	for <linux-wireless@vger.kernel.org>; Mon, 19 Jan 2026 10:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.236.254.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768820356; cv=none; b=Re7g6U7hgLa8ux63jh4bOrPPswd0kOLr4Wss6lWSu9lkUVV1gSZQ2gDwm9qWpHXQ/j8k62uZgyPmjOpg7pA18zwJCpezRDz+BtoRgPOKrCwAHeAKuijzhllT2XAloqoB5Q36q5vfgk3YzrD0vxZZ/PZ0SEBudmLw2HSp7U9PoIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768820356; c=relaxed/simple;
	bh=uA0cTDxuyYkyrwtwypLCdjgwZLHHbyJytgMeinxeVgc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=bUxYAeOQNpeCJZmUf4lNiOlyeVN3PxXKDD2y299y9H6ZDkOaXFghjto3JvA3wIQOAggQP2ypAYfbx0Iktnm8mKk0uNzjmZ6EGC6OEmSjYru9EtfDuvaf+GuiNdcOZai++ZHx/F9gtGSMwNFFhPJhdBM0xbeiS3iJ78JKKUFMVlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lysator.liu.se; spf=pass smtp.mailfrom=lysator.liu.se; arc=none smtp.client-ip=130.236.254.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lysator.liu.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lysator.liu.se
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 3D0EE1D44E
	for <linux-wireless@vger.kernel.org>; Mon, 19 Jan 2026 11:59:06 +0100 (CET)
Received: by mail.lysator.liu.se (Postfix, from userid 1004)
	id 0E0CD1D44D; Mon, 19 Jan 2026 11:59:06 +0100 (CET)
X-Spam-Level: 
X-Spam-Score: -1.0
Received: from sara (h-62-63-215-216.A163.priv.bahnhof.se [62.63.215.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTPSA id 899091D4A7;
	Mon, 19 Jan 2026 11:59:04 +0100 (CET)
Date: Mon, 19 Jan 2026 11:59:04 +0100 (CET)
From: =?UTF-8?Q?Peter_=C3=85strand?= <astrand@lysator.liu.se>
To: Johannes Berg <johannes@sipsolutions.net>
cc: linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wifi: wlcore: avoid oops when reading tsf from debugfs
In-Reply-To: <b408ac23d51bec80048c35055199176bd0377879.camel@sipsolutions.net>
Message-ID: <9945364c-ec4c-e2c9-a9cc-884e64b629d3@lysator.liu.se>
References: <ac98f15b-4f6e-95c4-534d-583419068ce0@lysator.liu.se>  (sfid-20260116_163710_192579_DC8B9783) <b408ac23d51bec80048c35055199176bd0377879.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-430754851-1768820344=:47999"
X-Virus-Scanned: ClamAV using ClamSMTP

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-430754851-1768820344=:47999
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT


On Mon, 19 Jan 2026, Johannes Berg wrote:

> On Fri, 2026-01-16 at 16:31 +0100, Peter Åstrand wrote:
> > In this case, read lock on dev_base_lock is active so calling pm_runtime_resume_and_get
> > or wl12xx_acx_tsf_info will cause Oops like:
> > 
> > [  182.282540] BUG: scheduling while atomic: cat/269/0x00000002
> 
> I guess I get what you're trying to do, but ...
> 
> > @@ -4988,6 +4989,10 @@ static u64 wl1271_op_get_tsf(struct ieee80211_hw *hw,
> >  
> >  	wl1271_debug(DEBUG_MAC80211, "mac80211 get tsf");
> >  
> > +	/* Return cached value to debugfs */
> > +	if (!preemptible())
> > +		return wlvif->debug_tsf;
> 
> 
> No. We're not going to merge such a thing.
> 
> I'm not sure I see how _debugfs_ actually could trigger this, since
> mac80211 doesn't enter any atomic context? It even documents "The
> callback can sleep", so under which circumstances would it not be able
> to?

Thanks. Yes, I was a bit unsure of this solution. It is easy to trigger 
with "cat" though:

/sys/kernel/debug/ieee80211/phy0/netdev:wlan0# cat tsf
[  182.282540] BUG: scheduling while atomic: cat/269/0x00000002
[  182.288304] Modules linked in: cts wlcore_sdio wl18xx wlcore mac80211 cfg80211
[  182.295785] CPU: 0 PID: 269 Comm: cat Tainted: G        W          6.6.52-g0cdede7dcaea #1
[  182.304695] Hardware name: Freescale i.MX6 Ultralite (Device Tree)
[  182.310902]  unwind_backtrace from show_stack+0x10/0x14
[  182.316188]  show_stack from dump_stack_lvl+0x40/0x4c
[  182.321293]  dump_stack_lvl from __schedule_bug+0x54/0x68
[  182.326758]  __schedule_bug from __schedule+0x5ac/0x728
[  182.332030]  __schedule from schedule+0x5c/0xb8
[  182.336593]  schedule from schedule_hrtimeout_range_clock+0x10c/0x184
[  182.343074]  schedule_hrtimeout_range_clock from schedule_hrtimeout_range+0x1c/0x24
[  182.350780]  schedule_hrtimeout_range from usleep_range_state+0x5c/0x88
[  182.357438]  usleep_range_state from sdhci_start_signal_voltage_switch+0xc4/0x2c0
[  182.364971]  sdhci_start_signal_voltage_switch from sdhci_runtime_resume_host+0x7c/0x268
[  182.373106]  sdhci_runtime_resume_host from sdhci_esdhc_runtime_resume+0x168/0x1a0
[  182.380727]  sdhci_esdhc_runtime_resume from __rpm_callback+0x3c/0x168
[  182.387315]  __rpm_callback from rpm_callback+0x28/0x54
[  182.392590]  rpm_callback from rpm_resume+0x438/0x5ec
[  182.397690]  rpm_resume from __pm_runtime_resume+0x34/0x6c
[  182.403226]  __pm_runtime_resume from __mmc_claim_host+0x1a8/0x1f4
[  182.409460]  __mmc_claim_host from wl12xx_sdio_raw_write+0x4c/0x15c [wlcore_sdio]
[  182.417019]  wl12xx_sdio_raw_write [wlcore_sdio] from wlcore_runtime_resume+0xc8/0x218 [wlcore]
[  182.426200]  wlcore_runtime_resume [wlcore] from __rpm_callback+0x3c/0x168
[  182.433441]  __rpm_callback from rpm_callback+0x28/0x54
[  182.438729]  rpm_callback from rpm_resume+0x438/0x5ec
[  182.443835]  rpm_resume from __pm_runtime_resume+0x34/0x6c
[  182.449375]  __pm_runtime_resume from wl1271_op_get_tsf+0x70/0x140 [wlcore]
[  182.456685]  wl1271_op_get_tsf [wlcore] from ieee80211_if_fmt_tsf+0x1c/0x44 [mac80211]
[  182.465943]  ieee80211_if_fmt_tsf [mac80211] from ieee80211_if_read+0x58/0xb4 [mac80211]
[  182.475359]  ieee80211_if_read [mac80211] from ieee80211_if_read_tsf+0x1c/0x24 [mac80211]
[  182.484764]  ieee80211_if_read_tsf [mac80211] from full_proxy_read+0x54/0x84
[  182.492486]  full_proxy_read from vfs_read+0x90/0x288
[  182.497592]  vfs_read from ksys_read+0x70/0xf0
[  182.502075]  ksys_read from ret_fast_syscall+0x0/0x64


Best regards,
Peter 

--8323329-430754851-1768820344=:47999--

