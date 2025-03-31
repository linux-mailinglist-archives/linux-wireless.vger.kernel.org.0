Return-Path: <linux-wireless+bounces-21003-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 725EFA765C2
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Mar 2025 14:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C68B83A9DAF
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Mar 2025 12:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 413D97E107;
	Mon, 31 Mar 2025 12:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="CZtiW88D"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856701E2853
	for <linux-wireless@vger.kernel.org>; Mon, 31 Mar 2025 12:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743423978; cv=none; b=eP30UZgt7DO+CC5kfLkxdW4hwJxzdClQ9bcSTOadS8zjWGjCYjVgdBbPStPp4Q3HyTYSwKcIBgDpdtNMXVN4z9B4KGIq1jXv+m7qvcIHJnWtXIug+RjbNZQdCqqXmTC/1SS9hVKEjvEx7dSz1QFTzqXvWwkjwhOHgOUMOlku2Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743423978; c=relaxed/simple;
	bh=RvRbCeX//OWJD9uWBBBHoRjuCPB1C1wWzIdU7/iXUzA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KOo3iFnj0BYFL4Oj/7YCiaG6zsssJE1YPo96QchQHwuGuQyW6HRuLjnpVHW9WtocQvm+e7rqlS5AxNpQX5ad6tcAkHA/kJJsjGWTfSo5+VA/bS0eXTzl2IaR1NHajYBsoK7qF43JQfPAZbNJ2Vlxn/wtGvQQ2+KWPhHoTDmtK7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=CZtiW88D; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1743423963; bh=RvRbCeX//OWJD9uWBBBHoRjuCPB1C1wWzIdU7/iXUzA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=CZtiW88DMNRFYH9n1a5IQy8jDSy85AjHvn5Nvft7sBHfhp4wF3lHRyqpAoc4jkq+8
	 r6VVZytMyhW1godBEWO5OvnedtFkkEcSu9BtXZb3wAadJin5P2Tk5XWXVyAevHox/D
	 RUWZO3zz3EikVLt++qYVR3S+6TBUEpjDd7yd3+Rqas13hGRHwvPdR9th9zEOiWWOLT
	 XuVChN4PvjSnVk1GW5WKG+FwNCbgFgYXRVnNj91Qg0c/iV9pJtbvSlBQsoqtLGe7eR
	 mHeteBDUMxaoBjyhJ5cCgP9QeFVSOZYXOekQ2JbMk76RDh4LRl8hFQHkTzFRzFvoLb
	 1PR2Ex1gueHrg==
To: rtm@csail.mit.edu
Cc: linux-wireless@vger.kernel.org
Subject: Re: divide by zero in ath9k_htc_choose_bslot()
In-Reply-To: <88967.1743099372@localhost>
References: <88967.1743099372@localhost>
Date: Mon, 31 Mar 2025 14:26:02 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87semtgzdx.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

rtm@csail.mit.edu writes:

> The attached demo uses usbip to pretend to be a USB device for 
>
>   drivers/net/wireless/ath/ath9k/
>
> It sets up the wifi interface, and then maliciously generates a frame
> that claims to be on the USB endpoint that ath9k_htc_rx_msg() passes to
> ath9k_wmi_ctrl_rx(). The cmd_id in the frame is 0x1002, or
> WMI_SWBA_EVENTID, which causes ath9k_wmi_ctrl_rx() to wake up the
> ath9k_wmi_event_tasklet. Which calls ath9k_htc_swba(), which calls
> ath9k_htc_choose_bslot(), which says
>
>         intval = priv->cur_beacon_conf.beacon_interval;
>         tsf = be64_to_cpu(swba->tsf);
>         tsftu = TSF_TO_TU(tsf >> 32, tsf);
>         slot = ((tsftu % intval) * ATH9K_HTC_MAX_BCN_VIF) / intval;
>         slot = ATH9K_HTC_MAX_BCN_VIF - slot - 1;
>
> At this point beacon_interval is zero, so this divides by zero. On an
> amd64, a fault. On a RISC-V, which produces -1 for divide by zero,
> slot ends up as 2, which is too large; later on, slot=2 causes
> ath9k_htc_send_buffered() to index off the end of the bslot array;
> ieee80211_get_buffered_bc() then dereferences the resulting bad vif
> pointer.
>
>         vif = priv->beacon.bslot[slot];
>         skb = ieee80211_get_buffered_bc(priv->hw, vif);
>
> Changing ath9k_htc_choose_bslot() to return zero if intval is zero makes
> the crash go away. I don't know if that would be correct with a real
> Atheros device, but it probably doesn't matter since I imagine this
> would only ever arise with a broken or malicious USB device.

Thank you for the report, and the thorough analysis!

So I guess this happens because your malicious device sends the SWBA
command before beacons have actually been enabled (and
ath9k_htc_beacon_config() called to set the inverval)? In which case I
think a patch like the below makes more sense than relying on
ath9k_htc_choose_bslot() returning 0. WDYT?

-Toke

diff --git i/drivers/net/wireless/ath/ath9k/htc_drv_beacon.c w/drivers/net/wireless/ath/ath9k/htc_drv_beacon.c
index 547634f82183..81fa7cbad892 100644
--- i/drivers/net/wireless/ath/ath9k/htc_drv_beacon.c
+++ w/drivers/net/wireless/ath/ath9k/htc_drv_beacon.c
@@ -290,6 +290,9 @@ void ath9k_htc_swba(struct ath9k_htc_priv *priv,
        struct ath_common *common = ath9k_hw_common(priv->ah);
        int slot;
 
+       if (!priv->cur_beacon_conf.enable_beacon)
+               return;
+
        if (swba->beacon_pending != 0) {
                priv->beacon.bmisscnt++;
                if (priv->beacon.bmisscnt > BSTUCK_THRESHOLD) {

