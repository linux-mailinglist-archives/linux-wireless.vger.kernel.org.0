Return-Path: <linux-wireless+bounces-36836-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YCYlIqdvE2oCBAcAu9opvQ
	(envelope-from <linux-wireless+bounces-36836-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 24 May 2026 23:37:43 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB2D5C466C
	for <lists+linux-wireless@lfdr.de>; Sun, 24 May 2026 23:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51B1F3001B65
	for <lists+linux-wireless@lfdr.de>; Sun, 24 May 2026 21:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D479931F9A7;
	Sun, 24 May 2026 21:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mythread.it header.i=@mythread.it header.b="fF1B7Oyv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtpcmd15176.aruba.it (smtpcmd15176.aruba.it [62.149.156.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8F93090C6
	for <linux-wireless@vger.kernel.org>; Sun, 24 May 2026 21:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779658570; cv=none; b=qdrufTkvnI/OO5DCwMmtRPI+iMhmU9SeZtqdUDkmaGcnP9dnsycXSYsIT8swdoMVpgz+gLuldklr0PtWLYKnOKqlGLcuIT1c0kR5R/6bOVeLUXoNBs4N+5rax9Jy0C4ReCWtMsY5pMGh5Dzp+OSWNcFHIeB/qxrsTHZ2dmr/OU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779658570; c=relaxed/simple;
	bh=wbM/JgD8I6itU6S+v2S2x/PXv3phPTudmplnz5ZPVJY=;
	h=Date:From:To:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fSW/le5unNIwje7NZMvVLnklvJdqnAmnp6acsP+K04jexQ/f8tQ+zmFZE7UahhtQ6avAuLs5eubDslaLTmUfZSn46dWcHhh9jY2hyy1OYqGUO1MeJ8YFLwwBGWXuORpbkZ6IDctBKVhDVJ0r7WvzC7jQTH1WAKWHNh2Q6vKmDG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mythread.it; spf=pass smtp.mailfrom=mythread.it; dkim=pass (2048-bit key) header.d=mythread.it header.i=@mythread.it header.b=fF1B7Oyv; arc=none smtp.client-ip=62.149.156.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mythread.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mythread.it
Received: from fedora ([94.34.125.0])
	by Aruba SMTP with ESMTPSA
	id RGTUwsB8kwf0DRGTUwFACr; Sun, 24 May 2026 23:35:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mythread.it; s=a1;
	t=1779658509; bh=wbM/JgD8I6itU6S+v2S2x/PXv3phPTudmplnz5ZPVJY=;
	h=Date:From:To:Subject:MIME-Version:Content-Type;
	b=fF1B7Oyv6b7U/h+4QFPdUyT589sWMF7+VZzYLsDjiAO+qrXdJO8K3JCXl7SvaU/BC
	 gPZUI/hLDh0VC22TmzmNzizfQcpRA+NtBxWoVGztvQg3pNfQugo4KIqoFHDUpcR/E+
	 RG8e4TYkcZB/kJ0M+Qbsgv+UvZgxor64gAYLDOPt7ixPHHWd++XwIubolBxbJfzsMh
	 ZpDoXhxfpiuLvLS/U2KWfgbaz+7q9yLsagDMDp6AFAc9yIiwUhrBmaqoSCEWcO5mj8
	 yKGCYxY7rTbqzOxT6ihg2plSozAF8CE+sDb7GvoiaHsDuCqLIXXTTSq4VnLo490LGo
	 42n8MD5JGTcKg==
Date: Sun, 24 May 2026 23:35:08 +0200
From: Alessio Ferri <alessio.ferri@mythread.it>
To: linux-wireless@vger.kernel.org, b43-dev@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] b43: complete N-PHY rev 8 + radio 2057 rev 8
Message-ID: <20260524233508.03ebe015@fedora>
In-Reply-To: <20260524233228.06b38dba@fedora>
References: <20260524233228.06b38dba@fedora>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfCb8tLfP+v/0FHl21J6n+mFQEOKJIQZJXtDxvuhP6dSW7odXfZZYgfvX88Th9JF74CHxyLURlNJzjbnaEGoLZBeFTOYflEbdyTBdcXkjlCMF7Dnp/TXw
 CIHtwC/35Pg41DTtIoWMVYIuSri0+rEyV5x+apa/KrDgFwLeRURozdht4cPlYWXd5MqrJd390hvWEi8WrhMX+YvfQrLDV+VKEXhX+hESmFMv5o07nZYvuIF6
 U3/zjWZrZUD5z+8Cvr1JrkZZ/y8Y1jbmH7Aiy5UYcHk=
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mythread.it,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[mythread.it:s=a1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[mythread.it:+];
	TAGGED_FROM(0.00)[bounces-36836-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alessio.ferri@mythread.it,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mythread.it:email,mythread.it:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: DBB2D5C466C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


Add the 2.4 GHz IPA TX gain table for N-PHY rev 8 paired with radio
2057 rev 8 and wire it to the existing dispatcher.

b43_nphy_get_ipa_gain_table() in tables_nphy.c currently handles
case 8 only for radio_rev == 5; radio_rev == 8 falls through and
the function logs:

    b43-phyX ERROR: No 2GHz IPA gain table available for this device
    b43-phyX ERROR: PHY init: Channel switch to default failed

leaving b43_phy_init() to return an error and core_init to abort
before the MAC is enabled.

The high byte of every entry differs from the rev 5 sibling (0x40
vs 0x30): different PAD-gain code prefix for the rev 8 front-end.
The low 24 bits coincide with rev 5 across the whole table - the
gain step amplitudes are the same, only the PAD-gain selector
prefix changes.

Values extracted from an MMIO dump of the proprietary Broadcom wl
driver running on BCM6362 silicon (wl driver 6.30.102.7).

Assisted-by: Claude:claude-4.7-opus
Signed-off-by: Alessio Ferri <alessio.ferri@mythread.it>
---
 drivers/net/wireless/broadcom/b43/tables_nphy.c | 39
+++++++++++++++++++++++++ 1 file changed, 39 insertions(+)

diff --git a/drivers/net/wireless/broadcom/b43/tables_nphy.c
b/drivers/net/wireless/broadcom/b43/tables_nphy.c index
41a25d909..84e8d718d 100644 ---
a/drivers/net/wireless/broadcom/b43/tables_nphy.c +++
b/drivers/net/wireless/broadcom/b43/tables_nphy.c @@ -2715,6 +2715,43
@@ static const u32 b43_ntab_tx_gain_ipa_2057_rev5_2g[] = { 0x300f0715,
0x300f0715, 0x300f0715, 0x300f0715, };
 
+/* Extracted from MMIO dump of 6.30.102.7 */
+static const u32 b43_ntab_tx_gain_ipa_2057_rev8_2g[] = {
+	0x40ff0031, 0x40e70031, 0x40e7002e, 0x40cf002e,
+	0x40bf002e, 0x40af002e, 0x409f002f, 0x407f0033,
+	0x407f0031, 0x407f002e, 0x4077002e, 0x406f002e,
+	0x4067002e, 0x405f002f, 0x40570030, 0x4057002d,
+	0x404f002e, 0x40470031, 0x4047002e, 0x4047002c,
+	0x40470029, 0x403f002c, 0x403f0029, 0x4037002d,
+	0x4037002a, 0x40370028, 0x402f002c, 0x402f002a,
+	0x402f0028, 0x402f0026, 0x4027002c, 0x40270029,
+	0x40270027, 0x40270025, 0x40270023, 0x401f002c,
+	0x401f002a, 0x401f0028, 0x401f0025, 0x401f0024,
+	0x401f0022, 0x401f001f, 0x4017002d, 0x4017002b,
+	0x40170028, 0x40170026, 0x40170024, 0x40170022,
+	0x40170020, 0x4017001e, 0x4017001d, 0x4017001b,
+	0x4017001a, 0x40170018, 0x40170017, 0x40170015,
+	0x400f002c, 0x400f0029, 0x400f0027, 0x400f0024,
+	0x400f0022, 0x400f0021, 0x400f001f, 0x400f001d,
+	0x400f001b, 0x400f001a, 0x400f0018, 0x400f0017,
+	0x400f0016, 0x400f0015, 0x400f0115, 0x400f0215,
+	0x400f0315, 0x400f0415, 0x400f0515, 0x400f0615,
+	0x400f0715, 0x400f0715, 0x400f0715, 0x400f0715,
+	0x400f0715, 0x400f0715, 0x400f0715, 0x400f0715,
+	0x400f0715, 0x400f0715, 0x400f0715, 0x400f0715,
+	0x400f0715, 0x400f0715, 0x400f0715, 0x400f0715,
+	0x400f0715, 0x400f0715, 0x400f0715, 0x400f0715,
+	0x400f0715, 0x400f0715, 0x400f0715, 0x400f0715,
+	0x400f0715, 0x400f0715, 0x400f0715, 0x400f0715,
+	0x400f0715, 0x400f0715, 0x400f0715, 0x400f0715,
+	0x400f0715, 0x400f0715, 0x400f0715, 0x400f0715,
+	0x400f0715, 0x400f0715, 0x400f0715, 0x400f0715,
+	0x400f0715, 0x400f0715, 0x400f0715, 0x400f0715,
+	0x400f0715, 0x400f0715, 0x400f0715, 0x400f0715,
+	0x400f0715, 0x400f0715, 0x400f0715, 0x400f0715,
+};
+
+
 /* Extracted from MMIO dump of 6.30.223.141 */
 static const u32 b43_ntab_tx_gain_ipa_2057_rev9_2g[] = {
 	0x60ff0031, 0x60e7002c, 0x60cf002a, 0x60c70029,
@@ -3651,6 +3688,8 @@ static const u32
*b43_nphy_get_ipa_gain_table(struct b43_wldev *dev) case 8:
 			if (phy->radio_rev == 5)
 				return
b43_ntab_tx_gain_ipa_2057_rev5_2g;
+			if (phy->radio_rev == 8)
+				return
b43_ntab_tx_gain_ipa_2057_rev8_2g; break;
 		case 6:
 			if (dev->dev->chip_id == BCMA_CHIP_ID_BCM47162)

-- 
2.54.0

