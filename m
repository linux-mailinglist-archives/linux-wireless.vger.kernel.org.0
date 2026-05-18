Return-Path: <linux-wireless+bounces-36566-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2D5mD4FxCmqZ1QQAu9opvQ
	(envelope-from <linux-wireless+bounces-36566-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 03:55:13 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 73964564E6D
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 03:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 747DA3004053
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 01:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7911FC10C;
	Mon, 18 May 2026 01:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mythread.it header.i=@mythread.it header.b="QoK0UFx9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtpdh20-1.aruba.it (smtpdh20-1.aruba.it [62.149.155.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537FF481DD
	for <linux-wireless@vger.kernel.org>; Mon, 18 May 2026 01:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.155.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779069302; cv=none; b=N8bAHvObZfvdxSeBIEPT5nAdZgd00kLzTeZ1o5jc8TK0UOygzQoMCw4pBjAr5o/BZr1TPU7DJQjamvz4j6HoLDwNsdb5JzJvxhrVk5PqIzjYGlbbeSfb6SCXuYAFSSMcCpQKuVMsOIFVpR9HMsgyDR5YJFkMz3SFCAZLj51xyPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779069302; c=relaxed/simple;
	bh=5gwCkCWIBz50Rn5n49EQqgUTxuK9Jjy1Zr54t/an8fM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=BgXvO9Ong3I/nc+cBeVe18zZN4rO48ksbQd+N6QHkLUXTdGn65tju+/6Tzudf5hnmKzzU6lmu6O/eWG7kbVpjKQ70julDNHPaCzQJ6QUioR+Y+l/hebQyircq33qirFO5t+uhzzg6xi6YdBuFSIpOQEJ8T/IRg5UoKErBdHa3P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mythread.it; spf=pass smtp.mailfrom=mythread.it; dkim=pass (2048-bit key) header.d=mythread.it header.i=@mythread.it header.b=QoK0UFx9; arc=none smtp.client-ip=62.149.155.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mythread.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mythread.it
Received: from [192.168.1.83] ([79.20.159.46])
	by Aruba SMTP with ESMTPSA
	id OnC7wqtkaEZ9tOnC7wfrBg; Mon, 18 May 2026 03:55:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mythread.it; s=a1;
	t=1779069300; bh=5gwCkCWIBz50Rn5n49EQqgUTxuK9Jjy1Zr54t/an8fM=;
	h=Date:MIME-Version:Subject:From:To:Content-Type;
	b=QoK0UFx9wJBHKuzxTUgsWprSb5m8MSzlQDJDXT3Vb8e7q6r2mhPBI2kNSqJqPDUaw
	 MjnhKziAe+YikNnayFfCClJINbU/VL/TvIgTrvSxTXlTrAJ4LH8Ki+KSxMUVMrwxna
	 KqZ9gMi+rUXLM1JTFgOBKR7gxHG+z0Pg0yyd+PWYXOwCUJFcBwjJ8NKkikiyuiS6ua
	 ZXpXQ7emxKoLPKlas3zLSsCBZl7EsLNKK9RW9lxTPbe4GzNbdAbEkXQ3n2R1J882pJ
	 iuCqWMZIhRnCVzJonI2av8Y7LN+bdnlqcKZMO8BkiQdjWsXsaOaawAJgLtKuHuG5rG
	 Go9k92aPURUgg==
Message-ID: <b6865fd7-e4fd-4d99-870e-5c7ff103663b@mythread.it>
Date: Mon, 18 May 2026 03:54:59 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 6/6] b43: add RF power offset for N-PHY r8 + radio 2057 r8
Content-Language: it
From: Alessio Ferri <alessio.ferri@mythread.it>
To: linux-wireless@vger.kernel.org
Cc: b43-dev@lists.infradead.org, kvalo@kernel.org,
 linux-kernel@vger.kernel.org
References: <8c0a07d2-9ec9-43d6-bdf7-f625bbb4a38a@mythread.it>
In-Reply-To: <8c0a07d2-9ec9-43d6-bdf7-f625bbb4a38a@mythread.it>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfEV+FgEZjDr7wElVwNDrVsoho3D+ICj7D1FAxO1boKBXEYtpuzP1fti743QcggKEnr7SWguIQaAmTCUIs2XYTNEOJDOsmAoL1RQDWU0Ze1/6051S10Xl
 UoakDMDOdbnwe8kuEsHiye7r1yUnQrRZzqtcpOpsLqLFZwST7cvPfh6Qo+3roPtHicAu0Ds32hIjxNj1LWgC2Zyk3FTsf/1Rxbof3fbGXSzW45n5OCiRWSuT
 djoQruKfmINP5dw80xvSWuprSFlsEiOFTD3IQ4yI3bFYDyc1uUHkQHxRxWfMxxDTRNv0gbafSxvYFpp7tYr8/g==
X-Rspamd-Queue-Id: 73964564E6D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mythread.it,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[mythread.it:s=a1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mythread.it:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36566-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alessio.ferri@mythread.it,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mythread.it:email,mythread.it:mid,mythread.it:dkim]
X-Rspamd-Action: no action

Add the 2.4 GHz RF power offset table for N-PHY rev 8 paired with
radio 2057 rev 8 and wire it to the existing dispatcher.

b43_ntab_get_rf_pwr_offset_table() currently dispatches on phy->rev
== 17 (radio_rev 14) and phy->rev == 16 (radio_rev 9) for 2.4 GHz.
phy->rev == 8 falls through and the function logs:

    b43-phyX ERROR: No 2GHz RF power table available for this device

Add a phy->rev == 8 / radio_rev == 8 case returning the new table.

The values are sourced from the proprietary Broadcom wl driver's
nphy_papd_padgain_dlt_2g_2057rev5 array. Reusing the rev 5 values
is structurally appropriate: the IPA TX gain table added by the
preceding patch in this series shares the low 24 bits of every
entry with rev 5 - same gain step amplitudes, only the PAD-gain
selector byte differs. b43's pad_gain extraction in
b43_nphy_tx_pwr_ctl_init() reads bits 19..23 of the gain entry,
which sit in the shared low-24-bit range; the same gain index
therefore maps to the same physical PAD gain code on both
revisions and warrants the same per-index dB offset.

Note that b43_nphy_tx_gain_table_upload() currently has a "TODO:
Enable this once we have gains configured" early-return for
phy->rev >= 7. With that early-return in place, this table is
fetched (silencing the b43err that would otherwise abort PHY
init) but its values are not yet written to MMIO. Resolving the
TODO is a separate investigation outside the scope of this
series; the values supplied here are documented now so that, once
the upload path is enabled, the correct rev 8 offsets are
already in tree.

Signed-off-by: Alessio Ferri <alessio.ferri@mythread.it>
---
 .../net/wireless/broadcom/b43/tables_nphy.c   | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/net/wireless/broadcom/b43/tables_nphy.c b/drivers/net/wireless/broadcom/b43/tables_nphy.c
index 84e8d718d..ecd660b9c 100644
--- a/drivers/net/wireless/broadcom/b43/tables_nphy.c
+++ b/drivers/net/wireless/broadcom/b43/tables_nphy.c
@@ -2923,6 +2923,21 @@ static const s16 b43_ntab_rf_pwr_offset_2057_rev9_5g[] = {
 	0,
 };
 
+/* Sourced from the rev 5 sibling: the rev 8 IPA TX gain table
+ * shares the low 24 bits of every entry with rev 5 (only the
+ * PAD-gain selector byte differs), so the same gain index maps to
+ * the same physical PAD gain code on both revisions.
+ */
+static const s16 b43_ntab_rf_pwr_offset_2057_rev8_2g[] = {
+	-109, -109, -82, -68, -58,
+	-50,  -44, -39, -35, -31,
+	-28,  -26, -23, -21, -19,
+	-17,  -16, -14, -13, -11,
+	-10,   -9,  -8,  -7,  -5,
+	 -5,   -4,  -3,  -2,  -1,
+	 -1,    0,
+};
+
 /* Extracted from MMIO dump of 6.30.223.248
  * Entries: 0, 26, 28, 29, 30, 31 were guessed
  */
@@ -3782,6 +3797,10 @@ const s16 *b43_ntab_get_rf_pwr_offset_table(struct b43_wldev *dev)
 			if (phy->radio_rev == 9)
 				return b43_ntab_rf_pwr_offset_2057_rev9_2g;
 			break;
+		case 8:
+			if (phy->radio_rev == 8)
+				return b43_ntab_rf_pwr_offset_2057_rev8_2g;
+			break;
 		}
 
 		b43err(dev->wl,
-- 
2.43.0


