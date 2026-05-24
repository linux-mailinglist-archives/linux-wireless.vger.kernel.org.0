Return-Path: <linux-wireless+bounces-36837-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFbFHVVvE2oCBAcAu9opvQ
	(envelope-from <linux-wireless+bounces-36837-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 24 May 2026 23:36:21 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE375C4637
	for <lists+linux-wireless@lfdr.de>; Sun, 24 May 2026 23:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1DE29300250B
	for <lists+linux-wireless@lfdr.de>; Sun, 24 May 2026 21:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFAF31F9A7;
	Sun, 24 May 2026 21:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mythread.it header.i=@mythread.it header.b="QdwciU4v"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtpcmd15176.aruba.it (smtpcmd15176.aruba.it [62.149.156.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A8433D6E1
	for <linux-wireless@vger.kernel.org>; Sun, 24 May 2026 21:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779658574; cv=none; b=LLMuNBkIPJtb4hv8STCeR5yuPduh6d3SwBDDKu0bS4PKnlhHv3NuZmR+Usbe16TPjBsLuFQ812g2FSV/j3Q/9MDwFWKokaHLNTfFYXJSJ9Aa25yaZHg5MMtJ11LbaVnDbgP6jtLx2lmL8hV/9D3d/XtDjMY0H9uuS38a+UianGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779658574; c=relaxed/simple;
	bh=puWOPnW6DK1aPT9XGMhxSGX/gTDMx9Trn+CpctvI92E=;
	h=Date:From:To:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jVIbuVu7CLSE9O1zugYJcW4lpl7/1XSq8hrFRfI0Xq5NY/84NpLKjJbt+++yZQ4e2UtjCG9Y/elrFHDjWP9+OAXh4/HunjZF4cwb1kx3XLmqHvCPIpqDMmNejohS7w2gQpyvz+iu0eZLAHxalDy+Y7eF446ZtNk+ITIId6ThxbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mythread.it; spf=pass smtp.mailfrom=mythread.it; dkim=pass (2048-bit key) header.d=mythread.it header.i=@mythread.it header.b=QdwciU4v; arc=none smtp.client-ip=62.149.156.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mythread.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mythread.it
Received: from fedora ([94.34.125.0])
	by Aruba SMTP with ESMTPSA
	id RGUWwsCGRwf0DRGUWwFAdO; Sun, 24 May 2026 23:36:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mythread.it; s=a1;
	t=1779658573; bh=puWOPnW6DK1aPT9XGMhxSGX/gTDMx9Trn+CpctvI92E=;
	h=Date:From:To:Subject:MIME-Version:Content-Type;
	b=QdwciU4vat++y2AfMWdBUACI4D8MAByTZf6Ygj0PE+D3PQ7PcpuKMUK/K6VUINkKk
	 uwpKW2ioTIRAQY336r5lb1H3MjHaOwdt84csCxuJ/sGzC+rn6dO+9gx4jGyC4JkvMG
	 OHmC59dXCZXAAwvJIkfaFzQ1DqZqooEnr1zzmICMQSxL41Uv9RhmNJ2rZbyli0aZj7
	 0idr0gMHc4Oe9vYjucAGiq/dY38KLtkB6D0ZhxH7TXseaLLMP7gpxBieh9Jw+We5Vy
	 6wKFBrAunYIP4PszV2KXgb+Vf0vBiyu6MboCYb8FA6PNKkEcdZoiOqZNwONColQC1d
	 D2Skp0QvzkvNg==
Date: Sun, 24 May 2026 23:36:12 +0200
From: Alessio Ferri <alessio.ferri@mythread.it>
To: linux-wireless@vger.kernel.org, b43-dev@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/7] b43: complete N-PHY rev 8 + radio 2057 rev 8
Message-ID: <20260524233612.4d0e87f7@fedora>
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
X-CMAE-Envelope: MS4xfByFKf31Q/ssCwsoRl0p3b86fXEnF0LFLMJgn0SkmstqLPT4/It6qbghhQ73Y/cBbgNcgldg6zCWU/fGgrVYQZJl99rHBM6MaVP4DFCLiN49X6ktHoD0
 NXzHi6lsH/qcf/Npuc2+oeu9EEu+CdoXmnL3TWH9EbcO2iLxxQ/dD9xFXewv/670c/QmLXPtUHQ/05/5gdl5LneOW8JRZt61QIev9G+wHO8ecxqbeJQftc5z
 OqM44gc7+KWUReP0ZD8YV+0Vernv8nJbns2H/1LuLlQ=
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mythread.it,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[mythread.it:s=a1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[mythread.it:+];
	TAGGED_FROM(0.00)[bounces-36837-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alessio.ferri@mythread.it,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7EE375C4637
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
 drivers/net/wireless/broadcom/b43/tables_nphy.c | 19
+++++++++++++++++++ 1 file changed, 19 insertions(+)

diff --git a/drivers/net/wireless/broadcom/b43/tables_nphy.c
b/drivers/net/wireless/broadcom/b43/tables_nphy.c index
84e8d718d..ecd660b9c 100644 ---
a/drivers/net/wireless/broadcom/b43/tables_nphy.c +++
b/drivers/net/wireless/broadcom/b43/tables_nphy.c @@ -2923,6 +2923,21
@@ static const s16 b43_ntab_rf_pwr_offset_2057_rev9_5g[] = { 0,
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
@@ -3782,6 +3797,10 @@ const s16
*b43_ntab_get_rf_pwr_offset_table(struct b43_wldev *dev) if
(phy->radio_rev == 9) return b43_ntab_rf_pwr_offset_2057_rev9_2g;
 			break;
+		case 8:
+			if (phy->radio_rev == 8)
+				return
b43_ntab_rf_pwr_offset_2057_rev8_2g;
+			break;
 		}
 
 		b43err(dev->wl,

-- 
2.54.0

