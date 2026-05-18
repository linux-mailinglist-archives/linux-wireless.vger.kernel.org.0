Return-Path: <linux-wireless+bounces-36562-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLEgMDJxCmqZ1QQAu9opvQ
	(envelope-from <linux-wireless+bounces-36562-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 03:53:54 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B76564E30
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 03:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 66F06301A166
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 01:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D331C860A;
	Mon, 18 May 2026 01:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mythread.it header.i=@mythread.it header.b="Gblx13SA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtpdh20-1.aruba.it (smtpdh20-1.aruba.it [62.149.155.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7936F1EB5E3
	for <linux-wireless@vger.kernel.org>; Mon, 18 May 2026 01:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.155.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779069221; cv=none; b=MKDcYGw3kdfRTMLiDSfBcen/fIHz/av4/+e2dQFEwKij0PE4wAgcj6sNrzq6WHXFpCldBirar4xqHg2H6vYN3+CV0pQGjLlxgEDnAyCyY9FDgOOP3Z/APV+upC/37djjty6GWsMdP1CsIwSYdyTzj5pawYqW3Ffpx/az5wtpA8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779069221; c=relaxed/simple;
	bh=f92PXsrNJbn1Pcjwgfmmj1GECyc39UkvGMf/+SXNDBk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=P/9jH9dK4lhSofh7ATig6Y8BNnxXrxoMb9IBnib2GdMonUvBHN+2ajr45aiUraA3cdNBCiF8vNjA4jS8rxZTfnnQuiv0wCi+sQJHFGS2NeA5JIvUJrzx2TRgpyUIJjngIEMzRVSdox4LfdxxeY2oEzqGzSMDDrIPCTl+dw7XQAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mythread.it; spf=pass smtp.mailfrom=mythread.it; dkim=pass (2048-bit key) header.d=mythread.it header.i=@mythread.it header.b=Gblx13SA; arc=none smtp.client-ip=62.149.155.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mythread.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mythread.it
Received: from [192.168.1.83] ([79.20.159.46])
	by Aruba SMTP with ESMTPSA
	id OnApwqtIQEZ9tOnApwfr4s; Mon, 18 May 2026 03:53:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mythread.it; s=a1;
	t=1779069219; bh=f92PXsrNJbn1Pcjwgfmmj1GECyc39UkvGMf/+SXNDBk=;
	h=Date:MIME-Version:Subject:From:To:Content-Type;
	b=Gblx13SAtEb9W8xwj8087xG2a/j+sSCNX8wC8QwXK2X77ILnJAXauLmcbwwSnPT0E
	 nQRzrSk1hFix9COeb24LiUW8rp0ApV6PjNzSe2rcfRnM4PhyeF2ZiGA9EdMF6ZDMyz
	 HH/VlgvueCypCCoIRNwwmvMYAIuuOPZYedQjm/yGrxwCvcM99/YrgMV7Mo8hmgS2kr
	 8M6bG8J/43zVQ3VJUd2lXJ+fs1LJXp9ePF+oHt4qJ8XyAIxrBx8GdGnsOkXQj2aU10
	 BFguf4ksdOmOrcba4o2UYI/AAZMYzS4CjgU2r3O/V+xPKZjY3DMCb071aoanASF61O
	 fJhg7bc95ni+Q==
Message-ID: <4581a48e-a6e4-46b1-853f-16db445d6890@mythread.it>
Date: Mon, 18 May 2026 03:53:38 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 4/6] b43: add IPA TX gain table for N-PHY r8 + radio 2057 r8
Content-Language: it
From: Alessio Ferri <alessio.ferri@mythread.it>
To: linux-wireless@vger.kernel.org
Cc: b43-dev@lists.infradead.org, kvalo@kernel.org,
 linux-kernel@vger.kernel.org
References: <8c0a07d2-9ec9-43d6-bdf7-f625bbb4a38a@mythread.it>
In-Reply-To: <8c0a07d2-9ec9-43d6-bdf7-f625bbb4a38a@mythread.it>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfAVt9958lNEGYmKhM3kGOm8jhgNbPjckyGJqChUkpjOijmN/r4gSxm686Gvv9Cs7gEXjeIOKzMAtVztZx4xXW06sW1u0FUVs/aYxIDSdnxMX7WdDcz6x
 W75fppm2wB1U2S7MNVGwfvYXWZEdqw1yuIs5+iRx0riBg1+OGWzOien0NzesK6utJvAcWSsNz6bSiIUw2ulETZ9Iwqh91PwA5nP99mLitbkyLcmYYaDFPKHa
 UwqniGIYyjMXytW2prRaqwW9KhCixmAGwcalWYy+6uE+/cNbcHNPaPzAHva9KnFHDHXzBIWrPuVaZgJxcMTGuw==
X-Rspamd-Queue-Id: 60B76564E30
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mythread.it,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[mythread.it:s=a1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mythread.it:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36562-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alessio.ferri@mythread.it,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mythread.it:email,mythread.it:mid,mythread.it:dkim]
X-Rspamd-Action: no action

Add the 2.4 GHz IPA TX gain table for N-PHY rev 8 paired with radio
2057 rev 8 and wire it to the existing dispatcher.

b43_nphy_get_ipa_gain_table() in tables_nphy.c currently handles
case 8 only for radio_rev == 5; radio_rev == 8 falls through and
the function logs:

    b43-phyX ERROR: No 2GHz IPA gain table available for this device
    b43-phyX ERROR: PHY init: Channel switch to default failed

leaving b43_phy_init() to return an error and core_init to abort
before the MAC is enabled.

The new b43_ntab_tx_gain_ipa_2057_rev8_2g[] is 128 u32 entries,
matching the layout of the existing b43_ntab_tx_gain_ipa_2057_
rev5_2g and b43_ntab_tx_gain_ipa_2057_rev9_2g siblings in this
file. Each entry packs five gain fields decoded by
wlc_phy_get_tx_gain_nphy in the proprietary driver, the same
encoding b43 uses for the other 2057 IPA tables.

The high byte of every entry differs from the rev 5 sibling (0x40
vs 0x30): different PAD-gain code prefix for the rev 8 front-end.
The low 24 bits coincide with rev 5 across the whole table - the
gain step amplitudes are the same, only the PAD-gain selector
prefix changes.

Values extracted from an MMIO dump of the proprietary Broadcom wl
driver running on BCM6362 silicon (wl driver 6.30.102.7).
Encoding cross-validated by re-deriving the in-tree rev 5 table
from the same source using the same extraction method - the
result matches b43_ntab_tx_gain_ipa_2057_rev5_2g byte-for-byte.

Signed-off-by: Alessio Ferri <alessio.ferri@mythread.it>
---
 .../net/wireless/broadcom/b43/tables_nphy.c   | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/net/wireless/broadcom/b43/tables_nphy.c b/drivers/net/wireless/broadcom/b43/tables_nphy.c
index 41a25d909..84e8d718d 100644
--- a/drivers/net/wireless/broadcom/b43/tables_nphy.c
+++ b/drivers/net/wireless/broadcom/b43/tables_nphy.c
@@ -2715,6 +2715,43 @@ static const u32 b43_ntab_tx_gain_ipa_2057_rev5_2g[] = {
 	0x300f0715, 0x300f0715, 0x300f0715, 0x300f0715,
 };
 
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
@@ -3651,6 +3688,8 @@ static const u32 *b43_nphy_get_ipa_gain_table(struct b43_wldev *dev)
 		case 8:
 			if (phy->radio_rev == 5)
 				return b43_ntab_tx_gain_ipa_2057_rev5_2g;
+			if (phy->radio_rev == 8)
+				return b43_ntab_tx_gain_ipa_2057_rev8_2g;
 			break;
 		case 6:
 			if (dev->dev->chip_id == BCMA_CHIP_ID_BCM47162)
-- 
2.43.0


