Return-Path: <linux-wireless+bounces-36834-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNkRJjpvE2oCBAcAu9opvQ
	(envelope-from <linux-wireless+bounces-36834-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 24 May 2026 23:35:54 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7035C4629
	for <lists+linux-wireless@lfdr.de>; Sun, 24 May 2026 23:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B3540300954B
	for <lists+linux-wireless@lfdr.de>; Sun, 24 May 2026 21:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540C132B125;
	Sun, 24 May 2026 21:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mythread.it header.i=@mythread.it header.b="GXCRO8N1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtpcmd15176.aruba.it (smtpcmd15176.aruba.it [62.149.156.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BE2309DCF
	for <linux-wireless@vger.kernel.org>; Sun, 24 May 2026 21:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779658548; cv=none; b=fFfvrHhsjBxEzQncpDmyR42IAMMQWtDdgVA/tGh72PXOAys/uGdE8pIfxpFI6/xQw2liiAK+7TDZKMsQeUDavqOBMxj34IYEGXKeaQcU41lGRlDZHPGoIliftYzZKf0zWC/DZ0QG7djsld8qKFgRtKrJ6hCJEIlCEyJ2vDoiXtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779658548; c=relaxed/simple;
	bh=STmUpo43UaZjqQlIEne12bBwKZYpAXO6nyF1WrjjbAc=;
	h=Date:From:To:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A0hfe/5YbKTmevYcAFkSRo88RnsVnTtACbVW9QOdMtypK3Tz4azlqsoqnQrebyahF9lDG3WKAU0MoRwoE7boFiRhiut+XGODS3q6A3wBVBLBnwgMFnYhQeXdGcCOIHpkF1Es1GT5LUS8+PDtelwZ/LoHRo53lhyRMFeRILtz6rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mythread.it; spf=pass smtp.mailfrom=mythread.it; dkim=pass (2048-bit key) header.d=mythread.it header.i=@mythread.it header.b=GXCRO8N1; arc=none smtp.client-ip=62.149.156.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mythread.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mythread.it
Received: from fedora ([94.34.125.0])
	by Aruba SMTP with ESMTPSA
	id RGU4wsBoHwf0DRGU4wFAUo; Sun, 24 May 2026 23:35:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mythread.it; s=a1;
	t=1779658544; bh=STmUpo43UaZjqQlIEne12bBwKZYpAXO6nyF1WrjjbAc=;
	h=Date:From:To:Subject:MIME-Version:Content-Type;
	b=GXCRO8N1Bqh5Rw6+K0Lk1cg1EuC2hzd+Noa/oZLg98pUm4QXDELipqwwDQWZHru57
	 rMQ/shAyUV52vEB9kMLmE9hWjSueg3NBKy30RG/G1uXgohIGFtFADEXWyK/7s9cAJl
	 dZYQn7mNyvxgzRo7F0EFcEREcVWjBXNFh7j2bFNEbxTf9eS+R8JnewfRatKMhmKrc8
	 kEt9YomX17nnoL803XpNB4f0cdVLZs8zjE9dI0K+OhEUq32GSGfajarHHB/PBlAit4
	 O8H6W5CCpe8ON6R8QASdpk1Nvhdaw3mvXmFQ3t9vbT3/FNnceR8XyJVBJSEMl/cwaP
	 rQj0zJ1PF6+RQ==
Date: Sun, 24 May 2026 23:35:43 +0200
From: Alessio Ferri <alessio.ferri@mythread.it>
To: linux-wireless@vger.kernel.org, b43-dev@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/7] b43: complete N-PHY rev 8 + radio 2057 rev 8
Message-ID: <20260524233543.2ff6b55f@fedora>
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
X-CMAE-Envelope: MS4xfJge7a7RX9yX7YjLmGqyYiWMCGv2zYwRXnyZvkJYtDiGbxabYNQ0tg+mOHxr4IUX+y2zAhQFez97H1paPAN9z+aur7GqVv2yxBoNcPCZ/29qkf+jPZrj
 2JuTzVjsus0udAbovq3mmBk+d9lvMoOQSHvieOMYXIxp1DkC7j65RSywZL+dkJU+HpQCvlxXhptTqaAyDjERcROIRy1lIDUx2Nn2GZvYBb8y0QHdmjUdLfCY
 qgpb6BXGq1XxuSK6PS2OK3XYAxcfXTQpHIkGCnrs0Lo=
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mythread.it,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[mythread.it:s=a1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[mythread.it:+];
	TAGGED_FROM(0.00)[bounces-36834-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alessio.ferri@mythread.it,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4D7035C4629
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


Add the 2.4 GHz channel info table for N-PHY rev 8 paired with
radio 2057 rev 8 and wire it to the existing dispatcher in
r2057_get_chantabent_rev7().

The dispatcher's case 8 currently handles radio_rev == 5 only.
For radio_rev == 8 both output pointers stay NULL,
b43_nphy_set_channel() returns an error and channel switch to
the default channel fails.

The new b43_nphy_chantab_phy_rev8_radio_rev8[] is 14 entries
covering the standard 2.4 GHz channel set (2412..2472 in 5 MHz
steps, plus 2484 for channel 14).

Values extracted from an MMIO dump of the proprietary Broadcom wl
driver running on BCM6362 silicon (wl driver 6.30.102.7).

Assisted-by: Claude:claude-4.7-opus
Signed-off-by: Alessio Ferri <alessio.ferri@mythread.it>
---
 drivers/net/wireless/broadcom/b43/radio_2057.c | 106
+++++++++++++++++++++++++ 1 file changed, 106 insertions(+)

diff --git a/drivers/net/wireless/broadcom/b43/radio_2057.c
b/drivers/net/wireless/broadcom/b43/radio_2057.c index
9f693d92b..e761f899b 100644 ---
a/drivers/net/wireless/broadcom/b43/radio_2057.c +++
b/drivers/net/wireless/broadcom/b43/radio_2057.c @@ -445,6 +445,109 @@
static const struct b43_nphy_chantabent_rev7_2g
b43_nphy_chantab_phy_rev17_radio }, };
 
+/* Extracted from MMIO dump of 6.30.102.7 */
+static const struct b43_nphy_chantabent_rev7_2g
b43_nphy_chantab_phy_rev8_radio_rev8[] = {
+	{
+		.freq			= 2412,
+		RADIOREGS7_2G(0x48, 0x16, 0x30, 0x1b, 0x0a, 0x0a,
0x30, 0x6c,
+			      0x09, 0x0f, 0x09, 0x07, 0x61, 0x73,
0xf0, 0x61,
+			      0x73, 0xf0),
+		PHYREGS(0x03c9, 0x03c5, 0x03c1, 0x043a, 0x043f,
0x0443),
+	},
+	{
+		.freq			= 2417,
+		RADIOREGS7_2G(0x4b, 0x16, 0x30, 0x1b, 0x0a, 0x0a,
0x30, 0x71,
+			      0x09, 0x0f, 0x09, 0x07, 0x61, 0x73,
0xf0, 0x61,
+			      0x73, 0xf0),
+		PHYREGS(0x03cb, 0x03c7, 0x03c3, 0x0438, 0x043d,
0x0441),
+	},
+	{
+		.freq			= 2422,
+		RADIOREGS7_2G(0x4e, 0x16, 0x30, 0x1b, 0x0a, 0x0a,
0x30, 0x76,
+			      0x09, 0x0f, 0x09, 0x06, 0x61, 0x73,
0xf0, 0x61,
+			      0x73, 0xf0),
+		PHYREGS(0x03cd, 0x03c9, 0x03c5, 0x0436, 0x043a,
0x043f),
+	},
+	{
+		.freq			= 2427,
+		RADIOREGS7_2G(0x52, 0x16, 0x30, 0x1b, 0x0a, 0x0a,
0x30, 0x7b,
+			      0x09, 0x0f, 0x09, 0x06, 0x61, 0x73,
0xf0, 0x61,
+			      0x73, 0xf0),
+		PHYREGS(0x03cf, 0x03cb, 0x03c7, 0x0434, 0x0438,
0x043d),
+	},
+	{
+		.freq			= 2432,
+		RADIOREGS7_2G(0x55, 0x16, 0x30, 0x1b, 0x0a, 0x0a,
0x30, 0x80,
+			      0x09, 0x0f, 0x09, 0x06, 0x61, 0x73,
0xf0, 0x61,
+			      0x73, 0xf0),
+		PHYREGS(0x03d1, 0x03cd, 0x03c9, 0x0431, 0x0436,
0x043a),
+	},
+	{
+		.freq			= 2437,
+		RADIOREGS7_2G(0x58, 0x16, 0x30, 0x1b, 0x0a, 0x0a,
0x30, 0x85,
+			      0x09, 0x0f, 0x09, 0x06, 0x61, 0x73,
0xf0, 0x61,
+			      0x73, 0xf0),
+		PHYREGS(0x03d3, 0x03cf, 0x03cb, 0x042f, 0x0434,
0x0438),
+	},
+	{
+		.freq			= 2442,
+		RADIOREGS7_2G(0x5c, 0x16, 0x30, 0x1b, 0x0a, 0x0a,
0x30, 0x8a,
+			      0x09, 0x0f, 0x08, 0x05, 0x61, 0x73,
0xf0, 0x61,
+			      0x73, 0xf0),
+		PHYREGS(0x03d5, 0x03d1, 0x03cd, 0x042d, 0x0431,
0x0436),
+	},
+	{
+		.freq			= 2447,
+		RADIOREGS7_2G(0x5f, 0x16, 0x30, 0x1b, 0x0a, 0x0a,
0x30, 0x8f,
+			      0x09, 0x0f, 0x08, 0x05, 0x61, 0x73,
0xf0, 0x61,
+			      0x73, 0xf0),
+		PHYREGS(0x03d7, 0x03d3, 0x03cf, 0x042b, 0x042f,
0x0434),
+	},
+	{
+		.freq			= 2452,
+		RADIOREGS7_2G(0x62, 0x16, 0x30, 0x1b, 0x0a, 0x0a,
0x30, 0x94,
+			      0x09, 0x0f, 0x08, 0x05, 0x61, 0x73,
0xf0, 0x61,
+			      0x73, 0xf0),
+		PHYREGS(0x03d9, 0x03d5, 0x03d1, 0x0429, 0x042d,
0x0431),
+	},
+	{
+		.freq			= 2457,
+		RADIOREGS7_2G(0x66, 0x16, 0x30, 0x1b, 0x0a, 0x0a,
0x30, 0x99,
+			      0x09, 0x0f, 0x08, 0x05, 0x61, 0x73,
0xf0, 0x61,
+			      0x73, 0xf0),
+		PHYREGS(0x03db, 0x03d7, 0x03d3, 0x0427, 0x042b,
0x042f),
+	},
+	{
+		.freq			= 2462,
+		RADIOREGS7_2G(0x69, 0x16, 0x30, 0x1b, 0x0a, 0x0a,
0x30, 0x9e,
+			      0x09, 0x0f, 0x08, 0x05, 0x61, 0x73,
0xf0, 0x61,
+			      0x73, 0xf0),
+		PHYREGS(0x03dd, 0x03d9, 0x03d5, 0x0424, 0x0429,
0x042d),
+	},
+	{
+		.freq			= 2467,
+		RADIOREGS7_2G(0x6c, 0x16, 0x30, 0x1b, 0x0a, 0x0a,
0x30, 0xa3,
+			      0x09, 0x0f, 0x07, 0x04, 0x61, 0x73,
0xf0, 0x61,
+			      0x73, 0xf0),
+		PHYREGS(0x03df, 0x03db, 0x03d7, 0x0422, 0x0427,
0x042b),
+	},
+	{
+		.freq			= 2472,
+		RADIOREGS7_2G(0x70, 0x16, 0x30, 0x1b, 0x0a, 0x0a,
0x30, 0xa8,
+			      0x09, 0x0f, 0x07, 0x04, 0x61, 0x73,
0xf0, 0x61,
+			      0x73, 0xf0),
+		PHYREGS(0x03e1, 0x03dd, 0x03d9, 0x0420, 0x0424,
0x0429),
+	},
+	{
+		.freq			= 2484,
+		RADIOREGS7_2G(0x78, 0x16, 0x30, 0x1b, 0x0a, 0x0a,
0x30, 0xb4,
+			      0x09, 0x0f, 0x07, 0x04, 0x61, 0x73,
0xe0, 0x61,
+			      0x73, 0xe0),
+		PHYREGS(0x03e6, 0x03e2, 0x03de, 0x041b, 0x041f,
0x0424),
+	}
+};
+
+
 /* Extracted from MMIO dump of 6.30.223.141 */
 static const struct b43_nphy_chantabent_rev7
b43_nphy_chantab_phy_rev16_radio_rev9[] = { {
@@ -678,6 +781,9 @@ void r2057_get_chantabent_rev7(struct b43_wldev
*dev, u16 freq, if (phy->radio_rev == 5) {
 			e_r7_2g = b43_nphy_chantab_phy_rev8_radio_rev5;
 			len =
ARRAY_SIZE(b43_nphy_chantab_phy_rev8_radio_rev5);
+		} else if (phy->radio_rev == 8) {
+			e_r7_2g = b43_nphy_chantab_phy_rev8_radio_rev8;
+			len =
ARRAY_SIZE(b43_nphy_chantab_phy_rev8_radio_rev8); }
 		break;
 	case 16:

-- 
2.54.0

