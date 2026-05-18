Return-Path: <linux-wireless+bounces-36564-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aLzSJnhxCmqZ1QQAu9opvQ
	(envelope-from <linux-wireless+bounces-36564-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 03:55:04 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32235564E63
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 03:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 31A1C3026C30
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 01:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58261FC10C;
	Mon, 18 May 2026 01:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mythread.it header.i=@mythread.it header.b="hgfrmLWJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtpdh20-1.aruba.it (smtpdh20-1.aruba.it [62.149.155.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121042459C5
	for <linux-wireless@vger.kernel.org>; Mon, 18 May 2026 01:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.155.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779069264; cv=none; b=Cb4zBrKGS9OZdk+4REQnJlJnLpplUnge0k4L1bkXWn7RBVgMGA/m2tqsNR0/5nkO3fP3nbEJuLEszoPv+AaJnCL+gYHHnyrQKmLj9DXU7iDPNjRyOdWN1fPHkXrKUp9qfE8HRl6uTeKKE3DSSSlcIw+Z09J2ElA7AUYdrLF9QzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779069264; c=relaxed/simple;
	bh=hz7MrT7mnFSUTsm2B+ndFKrzdRHLoKRmLnkAUnEZNKI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=JoXmALOejgs/uZ7d3AOE9gn1oMlLESBY48PkCW2kkLK+E2GRRyLxQeTIxhDYaYKiyx69WdXlE5RM9EMnDR9qdyZ8c5Opk6D2ABjt+lrTgxEhNiOIEWflyI0EzTmwpwsFDY+JMjEWzV2ZczoU0N2p8fd88yncOjQWPKJTh3ubbgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mythread.it; spf=pass smtp.mailfrom=mythread.it; dkim=pass (2048-bit key) header.d=mythread.it header.i=@mythread.it header.b=hgfrmLWJ; arc=none smtp.client-ip=62.149.155.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mythread.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mythread.it
Received: from [192.168.1.83] ([79.20.159.46])
	by Aruba SMTP with ESMTPSA
	id OnBUwqtX3EZ9tOnBUwfr8L; Mon, 18 May 2026 03:54:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mythread.it; s=a1;
	t=1779069260; bh=hz7MrT7mnFSUTsm2B+ndFKrzdRHLoKRmLnkAUnEZNKI=;
	h=Date:MIME-Version:Subject:From:To:Content-Type;
	b=hgfrmLWJfeq/1e0q5sH8l6jYHr0al9qgWAGX+Np6ZeoQ/zZz7ZDUI9TKvFcFjURu6
	 zfVALkVx9zN6MeFIHX+mYkyREq35CX7LxzQ0yR+5dLtbibbAq6tQYdfJTK7WpO6w71
	 Q/Cv1mVaQdWkJE155738nMT5g5hstT6dy1YLf8MzmbJLavdQ8IoWx1Aje58wAN2nyE
	 n4WZh0DiqxrNvnEypdnn9wMpFSBZ+ELVbMT8Jsq1XsbzV4S8/hGxT5/Twfqe5I+kzu
	 ItsKchJGl9mo7QX0C+b5jDhK7Kjqvix0utGM8cyx3mbYc07MWC7zjv7+IwXArrU3Zg
	 nZGmJLb+nblLQ==
Message-ID: <c38ef41c-0358-413f-bf7b-c01f994111b0@mythread.it>
Date: Mon, 18 May 2026 03:54:20 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 5/6] b43: add channel info table for N-PHY r8 + radio 2057 r8
Content-Language: it
From: Alessio Ferri <alessio.ferri@mythread.it>
To: linux-wireless@vger.kernel.org
Cc: b43-dev@lists.infradead.org, kvalo@kernel.org,
 linux-kernel@vger.kernel.org
References: <8c0a07d2-9ec9-43d6-bdf7-f625bbb4a38a@mythread.it>
In-Reply-To: <8c0a07d2-9ec9-43d6-bdf7-f625bbb4a38a@mythread.it>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfMCgR4Gon6FZwgrDF8ToEOuNGr5G3q0NfMcJLls6O8z5zig+VDn8IWhLmoUIMR1nYVA3mLbDnJbDA0+lwj4VStL96HInPH9HA2AqQXChiRLM0G/0f5VM
 2Djnnk4CYNAUyx/g+u+1ZnIMy1OOLd89os5KUFD0M+pyXz7jd7c0GrsCcLyCdcKtshYmN8w3OvQRf+dXdtM3SSLYcztCDNQwzdkQqsf/WqWJqvtd7qNfuhF5
 LQ2eu09PyB6fU9EzbnpMWdKgOUGBO+M/11VBgTMlDFqlVsAq4hBcY/pU8lgK8Sfq69A1+pNwp1BAXeDkqQmOFA==
X-Rspamd-Queue-Id: 32235564E63
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mythread.it,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[mythread.it:s=a1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mythread.it:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36564-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alessio.ferri@mythread.it,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mythread.it:email,mythread.it:mid,mythread.it:dkim]
X-Rspamd-Action: no action

Add the 2.4 GHz channel info table for N-PHY rev 8 paired with
radio 2057 rev 8 and wire it to the existing dispatcher in
r2057_get_chantabent_rev7().

The dispatcher's case 8 currently handles radio_rev == 5 only.
For radio_rev == 8 both output pointers stay NULL,
b43_nphy_set_channel() returns an error and channel switch to
the default channel fails.

The new b43_nphy_chantab_phy_rev8_radio_rev8[] is 14 entries
covering the standard 2.4 GHz channel set (2412..2472 in 5 MHz
steps, plus 2484 for channel 14). Each entry uses the
b43_nphy_chantabent_rev7_2g struct layout already defined in this
file: 18 RADIOREGS7_2G fields followed by 6 PHYREGS (SFO config).

Values extracted from an MMIO dump of the proprietary Broadcom wl
driver running on BCM6362 silicon (wl driver 6.30.102.7). Field
ordering and encoding cross-validated by re-deriving the in-tree
b43_nphy_chantab_phy_rev8_radio_rev5 table from the same source
through the same extraction - the result matches the existing
in-tree table byte-for-byte.

Signed-off-by: Alessio Ferri <alessio.ferri@mythread.it>
---
 .../net/wireless/broadcom/b43/radio_2057.c    | 106 ++++++++++++++++++
 1 file changed, 106 insertions(+)

diff --git a/drivers/net/wireless/broadcom/b43/radio_2057.c b/drivers/net/wireless/broadcom/b43/radio_2057.c
index 9f693d92b..e761f899b 100644
--- a/drivers/net/wireless/broadcom/b43/radio_2057.c
+++ b/drivers/net/wireless/broadcom/b43/radio_2057.c
@@ -445,6 +445,109 @@ static const struct b43_nphy_chantabent_rev7_2g b43_nphy_chantab_phy_rev17_radio
 	},
 };
 
+/* Extracted from MMIO dump of 6.30.102.7 */
+static const struct b43_nphy_chantabent_rev7_2g b43_nphy_chantab_phy_rev8_radio_rev8[] = {
+	{
+		.freq			= 2412,
+		RADIOREGS7_2G(0x48, 0x16, 0x30, 0x1b, 0x0a, 0x0a, 0x30, 0x6c,
+			      0x09, 0x0f, 0x09, 0x07, 0x61, 0x73, 0xf0, 0x61,
+			      0x73, 0xf0),
+		PHYREGS(0x03c9, 0x03c5, 0x03c1, 0x043a, 0x043f, 0x0443),
+	},
+	{
+		.freq			= 2417,
+		RADIOREGS7_2G(0x4b, 0x16, 0x30, 0x1b, 0x0a, 0x0a, 0x30, 0x71,
+			      0x09, 0x0f, 0x09, 0x07, 0x61, 0x73, 0xf0, 0x61,
+			      0x73, 0xf0),
+		PHYREGS(0x03cb, 0x03c7, 0x03c3, 0x0438, 0x043d, 0x0441),
+	},
+	{
+		.freq			= 2422,
+		RADIOREGS7_2G(0x4e, 0x16, 0x30, 0x1b, 0x0a, 0x0a, 0x30, 0x76,
+			      0x09, 0x0f, 0x09, 0x06, 0x61, 0x73, 0xf0, 0x61,
+			      0x73, 0xf0),
+		PHYREGS(0x03cd, 0x03c9, 0x03c5, 0x0436, 0x043a, 0x043f),
+	},
+	{
+		.freq			= 2427,
+		RADIOREGS7_2G(0x52, 0x16, 0x30, 0x1b, 0x0a, 0x0a, 0x30, 0x7b,
+			      0x09, 0x0f, 0x09, 0x06, 0x61, 0x73, 0xf0, 0x61,
+			      0x73, 0xf0),
+		PHYREGS(0x03cf, 0x03cb, 0x03c7, 0x0434, 0x0438, 0x043d),
+	},
+	{
+		.freq			= 2432,
+		RADIOREGS7_2G(0x55, 0x16, 0x30, 0x1b, 0x0a, 0x0a, 0x30, 0x80,
+			      0x09, 0x0f, 0x09, 0x06, 0x61, 0x73, 0xf0, 0x61,
+			      0x73, 0xf0),
+		PHYREGS(0x03d1, 0x03cd, 0x03c9, 0x0431, 0x0436, 0x043a),
+	},
+	{
+		.freq			= 2437,
+		RADIOREGS7_2G(0x58, 0x16, 0x30, 0x1b, 0x0a, 0x0a, 0x30, 0x85,
+			      0x09, 0x0f, 0x09, 0x06, 0x61, 0x73, 0xf0, 0x61,
+			      0x73, 0xf0),
+		PHYREGS(0x03d3, 0x03cf, 0x03cb, 0x042f, 0x0434, 0x0438),
+	},
+	{
+		.freq			= 2442,
+		RADIOREGS7_2G(0x5c, 0x16, 0x30, 0x1b, 0x0a, 0x0a, 0x30, 0x8a,
+			      0x09, 0x0f, 0x08, 0x05, 0x61, 0x73, 0xf0, 0x61,
+			      0x73, 0xf0),
+		PHYREGS(0x03d5, 0x03d1, 0x03cd, 0x042d, 0x0431, 0x0436),
+	},
+	{
+		.freq			= 2447,
+		RADIOREGS7_2G(0x5f, 0x16, 0x30, 0x1b, 0x0a, 0x0a, 0x30, 0x8f,
+			      0x09, 0x0f, 0x08, 0x05, 0x61, 0x73, 0xf0, 0x61,
+			      0x73, 0xf0),
+		PHYREGS(0x03d7, 0x03d3, 0x03cf, 0x042b, 0x042f, 0x0434),
+	},
+	{
+		.freq			= 2452,
+		RADIOREGS7_2G(0x62, 0x16, 0x30, 0x1b, 0x0a, 0x0a, 0x30, 0x94,
+			      0x09, 0x0f, 0x08, 0x05, 0x61, 0x73, 0xf0, 0x61,
+			      0x73, 0xf0),
+		PHYREGS(0x03d9, 0x03d5, 0x03d1, 0x0429, 0x042d, 0x0431),
+	},
+	{
+		.freq			= 2457,
+		RADIOREGS7_2G(0x66, 0x16, 0x30, 0x1b, 0x0a, 0x0a, 0x30, 0x99,
+			      0x09, 0x0f, 0x08, 0x05, 0x61, 0x73, 0xf0, 0x61,
+			      0x73, 0xf0),
+		PHYREGS(0x03db, 0x03d7, 0x03d3, 0x0427, 0x042b, 0x042f),
+	},
+	{
+		.freq			= 2462,
+		RADIOREGS7_2G(0x69, 0x16, 0x30, 0x1b, 0x0a, 0x0a, 0x30, 0x9e,
+			      0x09, 0x0f, 0x08, 0x05, 0x61, 0x73, 0xf0, 0x61,
+			      0x73, 0xf0),
+		PHYREGS(0x03dd, 0x03d9, 0x03d5, 0x0424, 0x0429, 0x042d),
+	},
+	{
+		.freq			= 2467,
+		RADIOREGS7_2G(0x6c, 0x16, 0x30, 0x1b, 0x0a, 0x0a, 0x30, 0xa3,
+			      0x09, 0x0f, 0x07, 0x04, 0x61, 0x73, 0xf0, 0x61,
+			      0x73, 0xf0),
+		PHYREGS(0x03df, 0x03db, 0x03d7, 0x0422, 0x0427, 0x042b),
+	},
+	{
+		.freq			= 2472,
+		RADIOREGS7_2G(0x70, 0x16, 0x30, 0x1b, 0x0a, 0x0a, 0x30, 0xa8,
+			      0x09, 0x0f, 0x07, 0x04, 0x61, 0x73, 0xf0, 0x61,
+			      0x73, 0xf0),
+		PHYREGS(0x03e1, 0x03dd, 0x03d9, 0x0420, 0x0424, 0x0429),
+	},
+	{
+		.freq			= 2484,
+		RADIOREGS7_2G(0x78, 0x16, 0x30, 0x1b, 0x0a, 0x0a, 0x30, 0xb4,
+			      0x09, 0x0f, 0x07, 0x04, 0x61, 0x73, 0xe0, 0x61,
+			      0x73, 0xe0),
+		PHYREGS(0x03e6, 0x03e2, 0x03de, 0x041b, 0x041f, 0x0424),
+	}
+};
+
+
 /* Extracted from MMIO dump of 6.30.223.141 */
 static const struct b43_nphy_chantabent_rev7 b43_nphy_chantab_phy_rev16_radio_rev9[] = {
 	{
@@ -678,6 +781,9 @@ void r2057_get_chantabent_rev7(struct b43_wldev *dev, u16 freq,
 		if (phy->radio_rev == 5) {
 			e_r7_2g = b43_nphy_chantab_phy_rev8_radio_rev5;
 			len = ARRAY_SIZE(b43_nphy_chantab_phy_rev8_radio_rev5);
+		} else if (phy->radio_rev == 8) {
+			e_r7_2g = b43_nphy_chantab_phy_rev8_radio_rev8;
+			len = ARRAY_SIZE(b43_nphy_chantab_phy_rev8_radio_rev8);
 		}
 		break;
 	case 16:
-- 
2.43.0


