Return-Path: <linux-wireless+bounces-38306-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ur2NAWq2QmpFAAoAu9opvQ
	(envelope-from <linux-wireless+bounces-38306-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 20:16:10 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB036DDF46
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 20:16:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=schwarzvogel.de header.s=x header.b=Srpshzp0;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38306-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38306-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=schwarzvogel.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B7A63073963
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 18:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2CD33EB06;
	Mon, 29 Jun 2026 18:12:47 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.schwarzvogel.de (skade.schwarzvogel.de [157.90.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3CA381B0A
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 18:12:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782756767; cv=none; b=fY3i03FJVcWYCvIMESMbQhxxX9N+ndIsHNynlMzfQ5ka522psB2TaBvBgf9WrbWw0Bex988zjna5kUi0d63bvcQE3fk5gMMGhs6E7aw37UymVEdsM/k4NcIA1pkJa6xli/2k/n26/NMWDLLZY+7SNe5vL6zrsJNRaDNDqMfxDgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782756767; c=relaxed/simple;
	bh=yU5GolFefwIFXusM1k+677bQ3wlhaYgh9g5qHEYylWg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ekH921rFgXFybcsPMXAH6WNyZOvlC0POT9XD7ysiTI17+L/DS9f7wxGkX48lmmqXn6Lz9F93gla6Gk7Nt9IU9W96AXNhhntdkd3gfyik2A4EZTploBSH+o/0Vul3DbVG8gIskiMnk//kpBZaAXc4Oxrkic7Es3Gaqf8LTwILhfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schwarzvogel.de; spf=pass smtp.mailfrom=schwarzvogel.de; dkim=pass (2048-bit key) header.d=schwarzvogel.de header.i=@schwarzvogel.de header.b=Srpshzp0; arc=none smtp.client-ip=157.90.210.195
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=schwarzvogel.de; s=x; h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:In-Reply-To:References;
	bh=PnkTGV/nH6e70Wn8noO3/L4aE2s/K8jiLLk5T/vfk5c=; b=Srpshzp0Kx7hCZ42t/jyKztTKe
	OeVumzx6BwASHi7o1/wfpSde/GdT/YTxABgXFsziUMXqklcNzSdP+3qKKwiEt8qq98XEaAO4KpoGp
	e7mimrUpGUxdW+r70NemY3PQ10XTUQCh0MlXL+zp//wrz8yG74mJ5/95qqHrQ31hazplX8COT5xi/
	N4Y8qrW5FWzzbyyCcoJeadNr/TnER867+Tw9H6vtStuYbGoSXiBbHx27LdiTP2po0cCdJD0KWIA0B
	W+R7+30PEGnLI0aory2IN37m6wvJOd1gc+l9rHb1G0+dP4puuBEE7oFmVBJOqyWiJXG3Ih/oo3NY+
	Pk6+F6vw==;
Received: from klausman by mail.schwarzvogel.de with local (Exim 4.99.4)
	(envelope-from <klausman@schwarzvogel.de>)
	id 1weGJ4-000000003k2-1g7D;
	Mon, 29 Jun 2026 20:02:06 +0200
Date: Mon, 29 Jun 2026 20:02:06 +0200
From: Tobias Klausmann <klausman@schwarzvogel.de>
To: linux-mediatek@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>
Subject: mt76 newly rejects formerly working MAC from EPROM
Message-ID: <30a90714-02d8-45f2-a7f1-4cfe0627d50b@skade.local>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[schwarzvogel.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[schwarzvogel.de:s=x];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38306-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-mediatek@lists.infradead.org,m:linux-wireless@vger.kernel.org,m:nbd@nbd.name,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[klausman@schwarzvogel.de,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[klausman@schwarzvogel.de,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[schwarzvogel.de:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,msgid.link:url,skade.local:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1FB036DDF46

Hi!

As of 7.2-rc1, my mediatek USB wifi dongle no longer works the way it
used to. I now get an error about its MAC being wrong:

usbcore: registered new interface driver mt7921u
mt7921u 8-1:1.0: HW/SW Version: 0x8a108a10, Build Time: 20260224110909a
mt7921u 8-1:1.0: WM Firmware Version: ____010000, Build Time: 20260224110949
mt7921u 8-1:1.0: Invalid MAC address, using random address c2:4d:ae:23:29:38
mt7921u 8-1:1.0 wlxc24dae232938: renamed from wlan0

This naturally breaks my udev rules, interface naming etc etc.

So I bisected it, and this is the commit that started it:

commit 31ee1582717e220cc5a3fa8f3940d5693c5c9169 (HEAD)
Author: Rosen Penev <rosenp@gmail.com>
Date:   Sun Apr 26 22:17:46 2026 -0700

    wifi: mt76: fix of_get_mac_address error handling
    
    Check return value instead of is_valid_ether_addr. The latter is handled
    by the former.
    
    Signed-off-by: Rosen Penev <rosenp@gmail.com>
    Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
    Link: https://patch.msgid.link/20260427051746.954704-1-rosenp@gmail.com
    Signed-off-by: Felix Fietkau <nbd@nbd.name>

diff --git a/drivers/net/wireless/mediatek/mt76/eeprom.c b/drivers/net/wireless/mediatek/mt76/eeprom.c
index afdb73661866e..b99d7452800fd 100644
--- a/drivers/net/wireless/mediatek/mt76/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/eeprom.c
@@ -181,7 +181,7 @@ mt76_eeprom_override(struct mt76_phy *phy)
        if (err == -EPROBE_DEFER)
                return err;
 
-       if (!is_valid_ether_addr(phy->macaddr)) {
+       if (err) {
                eth_random_addr(phy->macaddr);
                dev_info(dev->dev,
                         "Invalid MAC address, using random address %pM\n",

SO I thought that maybe my device had had a broken MAC all this time,
and I just didn't notice. I changed the code a bit to emit the erroneous
MAC and the value of err, which resulted in:

usbcore: registered new interface driver mt7921u
mt7921u 8-1:1.0: HW/SW Version: 0x8a108a10, Build Time: 20260224110909a
mt7921u 8-1:1.0: WM Firmware Version: ____010000, Build Time: 20260224110949
mt7921u 8-1:1.0: Invalid MAC address e0:e1:a9:38:96:29 err: -19
mt7921u 8-1:1.0: Using random address 3a:ca:1d:51:83:f2
mt7921u 8-1:1.0 wlx3aca1d5183f2: renamed from wlan0

To me, e0:e1:a9:38:96:29 looks like a perfectly valid MAC, so at a
minimum, the current code's wording is misleading: it assumes the only
way of_get_mac_address() can ever return a nonzero value is if the MAC
is invalid. However, looking at its code, I only see one nonzero return
statement, which returns ENODEV, which seems at odds with "broken MAC".

Either way, I am looking for a way to get a stable MAC again, either by
fixing this commit (if it is indeed a bug) or fixing my hardware (if the
bug is there.

Best,
Tobias Klausmann

