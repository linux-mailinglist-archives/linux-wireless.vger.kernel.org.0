Return-Path: <linux-wireless+bounces-9505-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50CFC915352
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Jun 2024 18:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8BCF1F209AF
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Jun 2024 16:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23CD19DF45;
	Mon, 24 Jun 2024 16:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="SALSTwqv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E24142625;
	Mon, 24 Jun 2024 16:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719246028; cv=none; b=Tveoqx2HkrmanavA/TTxLDmdmQwAum5tvYLgJydFw3mWkK2YMCbTJtj3BvfQtraNhgqb41MlCAOOXiwaefxTIU/HRCVlNlkAeDftgq0NvIvX9edi5GAwHzO+OvdNHAHR9WFvyRRRgVkUB6HIRuh4dUbhI7PFc+kHhrV9qWp0Ibs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719246028; c=relaxed/simple;
	bh=8NGGI5KHfKfsVqNnW0q/3aibm0KPOD/au9dg3nJsN+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lj8B2R56Gl+Yyq7O1MHblEisnSSMTCuESi5Z6Mw5EXRuxZUbR04c/USno13UKsw/3OLKywIiXixxeQ5LBDlGNhSRf0g/85yysFsN2Kjrjk6SdBpeTiKHK3kPuA9NY24GPeHOTR1/XjJMoX6nKqqWZOHUsvbARqPIupby3V7aVH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=SALSTwqv; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 52D731FE39;
	Mon, 24 Jun 2024 18:20:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1719246015;
	bh=Omlv3Moxi4pv2704XG/wDQ1PjHBLAkc9T4XMBPrTpYw=;
	h=Received:From:To:Subject;
	b=SALSTwqv4K+nXEUqHu2q7lax/LLyIX+/siRqeyCbNgaXqIuW10mkT127Hov9ctSzF
	 X99SBxsj8YF1lXq8ldqYN5ZDbx5+qKuc3kPanXA2JGoUqA5lLDB56WeAycLvSabpXO
	 2AwVduHE9iJRCkxzHHIP+LUnFU7L+Rm72GHOI8Ma+Foc8OghBxPew63DOtjxlcuyI3
	 kpgE/S31xteKr5M2gBFJZLBV3/yy0i55BVjp+uDLnHQifgx0Fxxe7JOM+qzid0sUGk
	 uriyV+cpEvwKu6IKFMe3aXrT2RT4uKkuCRVamD9DH4sv48M3QkFmeDpj1+q9QgRQKA
	 WMIMGFmpeIRfQ==
Received: by gaggiata.pivistrello.it (Postfix, from userid 1000)
	id EE64A7F9AA; Mon, 24 Jun 2024 18:20:14 +0200 (CEST)
Date: Mon, 24 Jun 2024 18:20:14 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Brian Norris <briannorris@chromium.org>, Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	David Lin <yu-hao.lin@nxp.com>,
	Francesco Dolcini <francesco@dolcini.it>
Subject: Re: [PATCH] [RFC] mwifiex: Fix NULL pointer deref
Message-ID: <ZnmcvsXZHnQ36auI@gaggiata.pivistrello.it>
References: <20240619070824.537856-1-s.hauer@pengutronix.de>
 <87wmmll5mf.fsf@kernel.org>
 <ZnSHcZttq79cJS3l@google.com>
 <ZnVCzx3-pvbcYQLm@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnVCzx3-pvbcYQLm@pengutronix.de>

Hello Sascha,

On Fri, Jun 21, 2024 at 11:07:27AM +0200, Sascha Hauer wrote:
> On Thu, Jun 20, 2024 at 12:48:01PM -0700, Brian Norris wrote:
> > Hi Sascha,
> > 
> > On Wed, Jun 19, 2024 at 11:05:28AM +0300, Kalle Valo wrote:
> > > Sascha Hauer <s.hauer@pengutronix.de> writes:
> > > 
> > > > When an Access Point is repeatedly started it happens that the
> > > > interrupts handler is called with priv->wdev.wiphy being NULL, but
> > > > dereferenced in mwifiex_parse_single_response_buf() resulting in:
> > > >
> > > > | Unable to handle kernel NULL pointer dereference at virtual address 0000000000000140
> > ...
> > > > | pc : mwifiex_get_cfp+0xd8/0x15c [mwifiex]
> > > > | lr : mwifiex_get_cfp+0x34/0x15c [mwifiex]
> > > > | sp : ffff8000818b3a70
> > > > | x29: ffff8000818b3a70 x28: ffff000006bfd8a5 x27: 0000000000000004
> > > > | x26: 000000000000002c x25: 0000000000001511 x24: 0000000002e86bc9
> > > > | x23: ffff000006bfd996 x22: 0000000000000004 x21: ffff000007bec000
> > > > | x20: 000000000000002c x19: 0000000000000000 x18: 0000000000000000
> > > > | x17: 000000040044ffff x16: 00500072b5503510 x15: ccc283740681e517
> > > > | x14: 0201000101006d15 x13: 0000000002e8ff43 x12: 002c01000000ffb1
> > > > | x11: 0100000000000000 x10: 02e8ff43002c0100 x9 : 0000ffb100100157
> > > > | x8 : ffff000003d20000 x7 : 00000000000002f1 x6 : 00000000ffffe124
> > > > | x5 : 0000000000000001 x4 : 0000000000000003 x3 : 0000000000000000
> > > > | x2 : 0000000000000000 x1 : 0001000000011001 x0 : 0000000000000000
> > > > | Call trace:
> > > > |  mwifiex_get_cfp+0xd8/0x15c [mwifiex]
> > > > |  mwifiex_parse_single_response_buf+0x1d0/0x504 [mwifiex]
> > > > |  mwifiex_handle_event_ext_scan_report+0x19c/0x2f8 [mwifiex]
> > > > |  mwifiex_process_sta_event+0x298/0xf0c [mwifiex]
> > > > |  mwifiex_process_event+0x110/0x238 [mwifiex]
> > > > |  mwifiex_main_process+0x428/0xa44 [mwifiex]
> > > > |  mwifiex_sdio_interrupt+0x64/0x12c [mwifiex_sdio]
> > > > |  process_sdio_pending_irqs+0x64/0x1b8
> > > > |  sdio_irq_work+0x4c/0x7c
> > > > |  process_one_work+0x148/0x2a0
> > > > |  worker_thread+0x2fc/0x40c
> > > > |  kthread+0x110/0x114
> > > > |  ret_from_fork+0x10/0x20
> > > > | Code: a94153f3 a8c37bfd d50323bf d65f03c0 (f940a000)
> > > > | ---[ end trace 0000000000000000 ]---
> > > >
> > > > Fix this by adding a NULL check before dereferencing this pointer.
> > > >
> > > > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > > >
> > > > ---
> > > >
> > > > This is the most obvious fix for this problem, but I am not sure if we
> > > > might want to catch priv->wdev.wiphy being NULL earlier in the call
> > > > chain.
> > > 
> > > I haven't looked at the call but the symptoms sound like that either we
> > > are enabling the interrupts too early or there's some kind of locking
> > > problem so that an other cpu doesn't see the change.
> > 
> > I agree with Kalle that there's a different underlying bug involved, and
> > (my conclusion:) we shouldn't whack-a-mole the NULL pointer without
> > addressing the underlying problem.
> > 
> > Looking a bit closer (and without much other context to go on): I believe 
> > that one potential underlying problem is the complete lack of locking
> > between cfg80211 entry points (such as mwifiex_add_virtual_intf() or
> > mwifiex_cfg80211_change_virtual_intf()) and most stuff in the main loop
> > (mwifiex_main_process()). The former call sites only hold the wiphy
> > lock, and the latter tends to ... mostly not hold any locks, but rely on
> > sequentialization with itself, and using its |main_proc_lock| for setup
> > and teardown. It's all really bad and ready to fall down like a house of
> > cards at any moment. Unfortunately, no one has spent time on
> > rearchitecting this driver.
> > 
> > So it's possible that mwifiex_process_event() (mwifiex_get_priv_by_id()
> > / mwifiex_get_priv()) is getting a hold of a not-fully-initialized
> > 'priv' structure.
> > 
> > BTW, in case I can reproduce and poke at your scenario, what exactly
> > is your test case? Are you just starting / killing / restarting hostapd
> > in a loop?
> 
> I am running plain wpa_supplicant -i mlan0 with this config:
> 
> network={
>         ssid="somessid"
>         mode=2
>         frequency=2412
>         key_mgmt=WPA-PSK WPA-PSK-SHA256
>         proto=RSN
>         group=CCMP
>         pairwise=CCMP
>         psk="12345678"
> }
> 
> wait for the AP to be established, <ctrl-c> wpa_supplicant and start it
> again.
> 
> It doesn't seem to be a locking problem, see the patch below which fixes
> my problem. At some point during incoming events the correct adapter->priv[]
> is selected based on bss_num and bss_type. when adapter->priv[0] is used
> for AP mode then an incoming event with type MWIFIEX_BSS_TYPE_STA leads
> to adapter->priv[1] being picked which is unused and doesn't have a
> wiphy attached to it.
> 
> Sascha
> 
> -------------------------8<----------------------------
> 
> From 3357963821294ff7de26259a154a1cb5bab760cb Mon Sep 17 00:00:00 2001
> From: Sascha Hauer <s.hauer@pengutronix.de>
> Date: Tue, 18 Jun 2024 12:20:20 +0200
> Subject: [PATCH] mwifiex: Do not return unused priv in
>  mwifiex_get_priv_by_id()
> 
> mwifiex_get_priv_by_id() returns the priv pointer corresponding to the
> bss_num and bss_type, but without checking if the priv is actually
> currently in use.
> Unused priv pointers do not have a wiphy attached to them which can lead
> to NULL pointer dereferences further down the callstack.
> Fix this by returning only used priv pointers which have priv->bss_mode
> set to something else than NL80211_IFTYPE_UNSPECIFIED.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/net/wireless/marvell/mwifiex/main.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/wireless/marvell/mwifiex/main.h b/drivers/net/wireless/marvell/mwifiex/main.h
> index 175882485a195..c5164ae41b547 100644
> --- a/drivers/net/wireless/marvell/mwifiex/main.h
> +++ b/drivers/net/wireless/marvell/mwifiex/main.h
> @@ -1287,6 +1287,9 @@ mwifiex_get_priv_by_id(struct mwifiex_adapter *adapter,
>  
>  	for (i = 0; i < adapter->priv_num; i++) {
>  		if (adapter->priv[i]) {
> +			if (adapter->priv[i]->bss_mode == NL80211_IFTYPE_UNSPECIFIED)
> +				continue;
> +
>  			if ((adapter->priv[i]->bss_num == bss_num) &&
>  			    (adapter->priv[i]->bss_type == bss_type))
>  				break;

The change looks fine to me.

I am just wondering if this might have anything to do with
commit a17b9f590f6e ("wifi: mwifiex: Fix interface type change"), maybe you have already looked into it?
Before that commit a wrong priv pointer was picked (different scenario from what you describe however).

Francesco



