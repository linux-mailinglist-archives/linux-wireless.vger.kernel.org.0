Return-Path: <linux-wireless+bounces-36844-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QP/sCjx0E2psBQcAu9opvQ
	(envelope-from <linux-wireless+bounces-36844-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 24 May 2026 23:57:16 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A925C478E
	for <lists+linux-wireless@lfdr.de>; Sun, 24 May 2026 23:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 85B6430185B1
	for <lists+linux-wireless@lfdr.de>; Sun, 24 May 2026 21:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA8A37D113;
	Sun, 24 May 2026 21:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mythread.it header.i=@mythread.it header.b="YYGEqd2+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtpcmd15176.aruba.it (smtpcmd15176.aruba.it [62.149.156.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A34237BE6A
	for <linux-wireless@vger.kernel.org>; Sun, 24 May 2026 21:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779659790; cv=none; b=ob+55xrEXSoSDO3gzv6P9CY+1ZJvChLtHrFQIvAInFM7rrg2hHuS0PaZ3ZJafHWuMGIYp630ik4FEo2kb6HaoNq4PkLY6n2j5KXVl9Y5g0sTGp1ZayReExQ9ooXC/95gRP0L+069055oBDGcz1mCXJoNqtC54lIzjZ8/dhg0Lmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779659790; c=relaxed/simple;
	bh=zuFz+m6zZSoI9BcR9nzfQcGG2R0KeXY9466berBa7jw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=sPuH8QjtObKPsPJEfSE4pqaQaRdeen18VyUrRH41nEN6N7eupdU/YtYgX/pSpsmMp5yGtaHTRhOhw3ijAKp1AWx3s0xLoFF2p2Pw5m871gJRaOWiVSJziwkkdgD6V9IWK3jEuxJzlOXOz2g18SNMhpAF2oChTQgi6xZxPBz/oU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mythread.it; spf=pass smtp.mailfrom=mythread.it; dkim=pass (2048-bit key) header.d=mythread.it header.i=@mythread.it header.b=YYGEqd2+; arc=none smtp.client-ip=62.149.156.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mythread.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mythread.it
Received: from [192.168.1.237] ([94.34.125.0])
	by Aruba SMTP with ESMTPSA
	id RGo5wsRmcwf0DRGo6wFEWx; Sun, 24 May 2026 23:56:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mythread.it; s=a1;
	t=1779659786; bh=zuFz+m6zZSoI9BcR9nzfQcGG2R0KeXY9466berBa7jw=;
	h=From:Date:Subject:MIME-Version:Content-Type:To;
	b=YYGEqd2+4h7vvDvNA7O9/1to+0Um9u1P8OT3+BwFWXFWL+3FaejwbOnDbyRJt2FKS
	 3pA31gzoPMOqjav4YainG2wj6Gy3uSRjGgsULsgZR49aKNczPuQ6Pm3JqJra4WrdV0
	 lBdlM7zLUetZx6Lq7kgPyNWp+8hjK1jaBZVuIuZrxTwgHr3MZ16D1j/PAqKiTuvq8g
	 BXwkw4oBxe5wkSLU0MIKbGkHW51a47HMQjOvNnrINwkM1+LLpgrbsizJSrUFwjsnwi
	 YW2+bSse/mrad+QeeyD5ymFAKocI6ujgKFwyB9KE3/3i6UoaAkCYTYbVWcqBzlkHqr
	 Sivk7tDUnFTgg==
From: Alessio Ferri <alessio.ferri@mythread.it>
Date: Sun, 24 May 2026 23:56:24 +0200
Subject: [PATCH v3 7/7] b43: add RF power offset for N-PHY r8 + radio 2057
 r8
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260524-b43_complete_n_phy_rev_8_radio_2057_rev_8_support-v1-7-cdad2c8526c6@gmail.com>
References: <20260524-b43_complete_n_phy_rev_8_radio_2057_rev_8_support-v1-0-cdad2c8526c6@gmail.com>
In-Reply-To: <20260524-b43_complete_n_phy_rev_8_radio_2057_rev_8_support-v1-0-cdad2c8526c6@gmail.com>
To: linux-wireless@vger.kernel.org, b43-dev@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Alessio Ferri <alessio.ferri@mythread.it>
X-Mailer: b4 0.14.3
X-CMAE-Envelope: MS4xfA68BqaCkARgcDeF0kZ2UFl6SNlLG18wR+LQBV8qIB0LCxYN2/+rkKbov4N3NO6Mo6TWpaUKQz03uo0SF2PaeQYV16MzNF3ra8jTW86kg0CPBytWRzkp
 d8c2s4TVdBqBsWRw5aLGzkJ3ZMRxJn3QM6dOF/m1Z5un74VmOQoq5Fy0PtdOwp2ANnPjutzDk0UQCpQ9R73Z457QW7EuxL0C9LiMnROBOBTI0NLDNzutxWX7
 ejqX4QxUgegJG5GxuGyf2tfV2PUtuuNnd/IKPSECMhigZ/KnIfgFE/CruilI8wRTeJ4JjtNNb0IrIpHMupqlknExVmWS8fMZ9EPIYzusd3E=
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mythread.it,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[mythread.it:s=a1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alessio.ferri@mythread.it,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-36844-lists,linux-wireless=lfdr.de];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mythread.it:email,mythread.it:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[mythread.it:+]
X-Rspamd-Queue-Id: 99A925C478E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
TODO is a future, separate task.

Assisted-by: Claude:claude-4.7-opus
Signed-off-by: Alessio Ferri <alessio.ferri@mythread.it>
---
 drivers/net/wireless/broadcom/b43/tables_nphy.c | 19 +++++++++++++++++++
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
2.54.0


