Return-Path: <linux-wireless+bounces-30961-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D0921D3AB6F
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Jan 2026 15:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5440330019CE
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Jan 2026 14:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BBB3793C2;
	Mon, 19 Jan 2026 14:15:56 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.lysator.liu.se (mail.lysator.liu.se [130.236.254.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C9D37A4B9
	for <linux-wireless@vger.kernel.org>; Mon, 19 Jan 2026 14:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.236.254.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768832156; cv=none; b=dvrL7GyrhClXbgMGbYZ204vFmNEjzpsJnsPY22WqxdQmcsTrWUcRr4rHFaJP/WldrGLZRFrOVY0dPti7E52z9MhG17cIlxEWvrawe8C4FjYAu7iBaPyxep19rHz/K7lAteEYFX86wlDvVjWBKNXFNv+BP3UTuVE4x/ZyPRREpB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768832156; c=relaxed/simple;
	bh=bUApM/MWCbUyDgmm9yd6EeGfi8b0hSJhxIImlz4XuMA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=tEvYCXiTbiCmE/T3BYG/QKRklqQ+igfNoQEfW4ts69vHxodTeFeLSAtQUbhZ6zk5SpTTiE16yNDb5rCpo6+t1BFUC7vL4cbLPBMRjrjyi63fWWbtx8s2hRbNYf8f3rZ9TQoA3Uw8wRbsg2Vm433rxPizctNEKa+Lupgu1qvZ5O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lysator.liu.se; spf=pass smtp.mailfrom=lysator.liu.se; arc=none smtp.client-ip=130.236.254.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lysator.liu.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lysator.liu.se
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id C2C511DD6E
	for <linux-wireless@vger.kernel.org>; Mon, 19 Jan 2026 15:15:51 +0100 (CET)
Received: by mail.lysator.liu.se (Postfix, from userid 1004)
	id A68B51DE5F; Mon, 19 Jan 2026 15:15:51 +0100 (CET)
X-Spam-Level: 
X-Spam-Score: -1.0
Received: from sara (h-62-63-215-216.A163.priv.bahnhof.se [62.63.215.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTPSA id DA0991DED2;
	Mon, 19 Jan 2026 15:15:48 +0100 (CET)
Date: Mon, 19 Jan 2026 15:15:48 +0100 (CET)
From: =?UTF-8?Q?Peter_=C3=85strand?= <astrand@lysator.liu.se>
To: Johannes Berg <johannes@sipsolutions.net>
cc: linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wifi: wlcore: avoid oops when reading tsf from debugfs
In-Reply-To: <9c79c606f1e1a2ae0dfa3c97aa4af7c83684901e.camel@sipsolutions.net>
Message-ID: <e29e09b0-7ccb-4348-f28f-1bf71765ac74@lysator.liu.se>
References: <ac98f15b-4f6e-95c4-534d-583419068ce0@lysator.liu.se>   (sfid-20260116_163710_192579_DC8B9783) <b408ac23d51bec80048c35055199176bd0377879.camel@sipsolutions.net>  <9945364c-ec4c-e2c9-a9cc-884e64b629d3@lysator.liu.se>  (sfid-20260119_115908_210575_070FC903)
 <9c79c606f1e1a2ae0dfa3c97aa4af7c83684901e.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Virus-Scanned: ClamAV using ClamSMTP

> > Thanks. Yes, I was a bit unsure of this solution. It is easy to trigger 
> > with "cat" though:
> > 
> > /sys/kernel/debug/ieee80211/phy0/netdev:wlan0# cat tsf
> > [  182.282540] BUG: scheduling while atomic: cat/269/0x00000002
>... 
> Looking at this, I think you have a much more general problem in this
> driver - __pm_runtime_resume() will always do wlcore_runtime_resume()
> under spinlock, and basically everything does that, so I don't see how
> this is ever safe in the driver?
> 
> It may be that normally somehow it doesn't get into sdhci's rpm_resume?
> But at best that's very fragile?

The driver is kind of stable for us nowadays; on i.IMX6ULL. On large 
systems, we see warnings such as:

[ 5565.989689] wlcore: WARNING Unable to flush all TX buffers, timed out 
(timeout 500 ms

[221279.491607] ieee80211 phy0: Hardware restart was requested

[135493.012941] wlcore: WARNING corrupted packet in RX: status: 0x1 len: 
112

Also, TSF reception seems to be unstable, this has been reported here:
https://e2e.ti.com/support/wireless-connectivity/wi-fi-group/wifi/f/wi-fi-forum/1602281/wl1837mod-large-toffset-in-mesh-network-kernel-oops-when-reading-sys-kernel-debug-ieee80211-phy0-netdev-wlan0_mesh-tsf/6186063

But never any "scheduling while atomic" in normal use. Agree that driver 
is probably fragile. Unfortunately I don't know enough about the Linux RPM 
subsystem and this driver in order to attempt a real fix, but if there is 
something that I can test, just let me know. (In addition to our custom 
platform, we can also test on i.MX6 14x14 EVK and Beaglebone Green 
Wireless.)

Br,
Peter

