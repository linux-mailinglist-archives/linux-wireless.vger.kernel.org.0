Return-Path: <linux-wireless+bounces-30951-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 053C1D3A661
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Jan 2026 12:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D81363078D90
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Jan 2026 11:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1692B3590BF;
	Mon, 19 Jan 2026 11:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="R+zH1m9S"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAC82FDC52
	for <linux-wireless@vger.kernel.org>; Mon, 19 Jan 2026 11:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768820789; cv=none; b=B8AIj4g9rz3/EYQSNFu3rhUYvGqKo6t9ZCAFy326P6AlfDxBmNune01dPikF8dF1rsyFbqYh+y1EDGzqmWt4jHsJw39Cfg+Es06DLxMRUIHD0c88Prt27M3EYDtwjeZJrEGT3kF2TLGZ1p6ZVqFUV/bQ6IvR5jtRV1wP67k1EQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768820789; c=relaxed/simple;
	bh=fOlQGPrBFEHwIN3E1fGGZt9NqhG5Ej+OGlJro0xWSrY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cRPp6yRuf5iwrPRrotd078kJtFSxDF9ePxAsk6KDDPAXmZEGMpskeuODFBkIArbQj7PFPCEvuTXSIcJy8iwCRxMsTFIERoPJMwTW/hQCFQ961equskhyXGbq4wcFk8OiSbQE9kq+90RaPVf5wYKMKLiH9rt31yFZElN2iH1h8Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=R+zH1m9S; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=h6yWXAkElAZKSCNVALJur3hefTptdn5YP9bY0AvNYzQ=;
	t=1768820787; x=1770030387; b=R+zH1m9S5/F0f0Tdbyk8ZEcemK6Y8/ejBPe0LymLJELcoP5
	iAFGHYk94roJG3NdvQqFHlUYV+DiL3/98cTtP09BZu2vUNTn6TI65Fk/YWs85Ci7uIZWS59qyIAMA
	0nFUkbYuOOqCuKGKQUE/GmhMNn8QHG+QlCTjzZUHnndq8QqdGREtrmDRe2Af9x0/ZGB+aVhdTzCu2
	xKlUoi4O7zE4uaoMnQhopyaZbBtnfuTF9z/HDIt9QVgmxszEpLJxrzEIK3zNgOjomH5QbYVefIsmf
	x7EtHCmoIGFhFHUBxVBbbsH6sY3/Y5cwedfRxUSCuBxo84+ryre5DY5m1hUPOjSw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vhn5V-0000000FtrX-0mHB;
	Mon, 19 Jan 2026 12:06:25 +0100
Message-ID: <9c79c606f1e1a2ae0dfa3c97aa4af7c83684901e.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: wlcore: avoid oops when reading tsf from debugfs
From: Johannes Berg <johannes@sipsolutions.net>
To: Peter =?ISO-8859-1?Q?=C5strand?= <astrand@lysator.liu.se>
Cc: linux-wireless@vger.kernel.org
Date: Mon, 19 Jan 2026 12:06:24 +0100
In-Reply-To: <9945364c-ec4c-e2c9-a9cc-884e64b629d3@lysator.liu.se> (sfid-20260119_115908_210575_070FC903)
References: <ac98f15b-4f6e-95c4-534d-583419068ce0@lysator.liu.se>
	  (sfid-20260116_163710_192579_DC8B9783) <b408ac23d51bec80048c35055199176bd0377879.camel@sipsolutions.net>
	 <9945364c-ec4c-e2c9-a9cc-884e64b629d3@lysator.liu.se>
	 (sfid-20260119_115908_210575_070FC903)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Mon, 2026-01-19 at 11:59 +0100, Peter =C3=85strand wrote:

> Thanks. Yes, I was a bit unsure of this solution. It is easy to trigger=
=20
> with "cat" though:
>=20
> /sys/kernel/debug/ieee80211/phy0/netdev:wlan0# cat tsf
> [  182.282540] BUG: scheduling while atomic: cat/269/0x00000002
> [  182.288304] Modules linked in: cts wlcore_sdio wl18xx wlcore mac80211 =
cfg80211
> [  182.295785] CPU: 0 PID: 269 Comm: cat Tainted: G        W          6.6=
.52-g0cdede7dcaea #1
> [  182.304695] Hardware name: Freescale i.MX6 Ultralite (Device Tree)
> [  182.310902]  unwind_backtrace from show_stack+0x10/0x14
> [  182.316188]  show_stack from dump_stack_lvl+0x40/0x4c
> [  182.321293]  dump_stack_lvl from __schedule_bug+0x54/0x68
> [  182.326758]  __schedule_bug from __schedule+0x5ac/0x728
> [  182.332030]  __schedule from schedule+0x5c/0xb8
> [  182.336593]  schedule from schedule_hrtimeout_range_clock+0x10c/0x184
> [  182.343074]  schedule_hrtimeout_range_clock from schedule_hrtimeout_ra=
nge+0x1c/0x24
> [  182.350780]  schedule_hrtimeout_range from usleep_range_state+0x5c/0x8=
8
> [  182.357438]  usleep_range_state from sdhci_start_signal_voltage_switch=
+0xc4/0x2c0
> [  182.364971]  sdhci_start_signal_voltage_switch from sdhci_runtime_resu=
me_host+0x7c/0x268
> [  182.373106]  sdhci_runtime_resume_host from sdhci_esdhc_runtime_resume=
+0x168/0x1a0
> [  182.380727]  sdhci_esdhc_runtime_resume from __rpm_callback+0x3c/0x168
> [  182.387315]  __rpm_callback from rpm_callback+0x28/0x54
> [  182.392590]  rpm_callback from rpm_resume+0x438/0x5ec
> [  182.397690]  rpm_resume from __pm_runtime_resume+0x34/0x6c
> [  182.403226]  __pm_runtime_resume from __mmc_claim_host+0x1a8/0x1f4
> [  182.409460]  __mmc_claim_host from wl12xx_sdio_raw_write+0x4c/0x15c [w=
lcore_sdio]
> [  182.417019]  wl12xx_sdio_raw_write [wlcore_sdio] from wlcore_runtime_r=
esume+0xc8/0x218 [wlcore]
> [  182.426200]  wlcore_runtime_resume [wlcore] from __rpm_callback+0x3c/0=
x168
> [  182.433441]  __rpm_callback from rpm_callback+0x28/0x54
> [  182.438729]  rpm_callback from rpm_resume+0x438/0x5ec
> [  182.443835]  rpm_resume from __pm_runtime_resume+0x34/0x6c
> [  182.449375]  __pm_runtime_resume from wl1271_op_get_tsf+0x70/0x140 [wl=
core]
> [  182.456685]  wl1271_op_get_tsf [wlcore] from ieee80211_if_fmt_tsf+0x1c=
/0x44 [mac80211]

Looking at this, I think you have a much more general problem in this
driver - __pm_runtime_resume() will always do wlcore_runtime_resume()
under spinlock, and basically everything does that, so I don't see how
this is ever safe in the driver?

It may be that normally somehow it doesn't get into sdhci's rpm_resume?
But at best that's very fragile?

johannes

