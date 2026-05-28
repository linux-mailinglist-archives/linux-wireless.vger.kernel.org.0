Return-Path: <linux-wireless+bounces-37069-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JsTIEV+GGoskggAu9opvQ
	(envelope-from <linux-wireless+bounces-37069-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2026 19:41:25 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE0F5F5CA3
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2026 19:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8B92430E4954
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2026 17:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9733925B663;
	Thu, 28 May 2026 17:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mythread.it header.i=@mythread.it header.b="hXgZhLt+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtpweb146.aruba.it (smtpweb146.aruba.it [62.149.158.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1753FDBE7
	for <linux-wireless@vger.kernel.org>; Thu, 28 May 2026 17:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.158.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779989696; cv=none; b=Dm/Yp1y5aIS4RbXjAqX8FpQvCSjBg7bXLxXBOusMDcGONWxFJy+wtuVXfarFgegFsitZ/OryDxlh1YmiftnWJGAxmQCHGid+2XwaC8EbX2oUd7hb3hAalYxfART0jPMZUXw2I0m3j7SvpCqm4ajqKcIAc707h9hkHo2L5AQk2i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779989696; c=relaxed/simple;
	bh=7U2VRrCjLV3YsP3PE4UZxyswXXGxQcG+dcQvS3dsOgs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=E1AeA95tx1j7bxJNpPg4lE/KqcXIWVToh33T+8PKdN2JKlntpAcgJY+2lWtH4QKeivX5Y7PXNEWN+1kDWutfLkTTgharHHPk9s4a1T2UKJussQXWBU7WRbQY/AtdTFCh5M4GvWihB8axegBOHndmXnyoMlgCPdojUBQKCS9W+vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mythread.it; spf=pass smtp.mailfrom=mythread.it; dkim=pass (2048-bit key) header.d=mythread.it header.i=@mythread.it header.b=hXgZhLt+; arc=none smtp.client-ip=62.149.158.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mythread.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mythread.it
Received: from [192.168.1.237] ([94.34.125.0])
	by Aruba SMTP with ESMTPSA
	id Sea5wczvrrbJKSea6w6A3y; Thu, 28 May 2026 19:31:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mythread.it; s=a1;
	t=1779989502; bh=7U2VRrCjLV3YsP3PE4UZxyswXXGxQcG+dcQvS3dsOgs=;
	h=From:Date:Subject:MIME-Version:Content-Type:To;
	b=hXgZhLt+i1D4BGuy6uAHER1rhRJeSnxyveQHW+kddH3GhDXyQibVN1GrHzN7h8T87
	 pCCdZWA3aQECi2o1KtWu1BbzC3soljjfVKhQzoeFVDzZY70eUWfHwvC2/yFF0x85Cs
	 EP+aYFN4LuM1NY2a+dFaMHWxTvh3zYpQxMtY8+M4auiSKlRlF8MUcrCX7wPZtMmHP4
	 NwHImoReIWNINm1aIo6iuKTni3J/Y+QsJcwHmdN692jMM9Qlk8AkbXEZznoHsdXovC
	 YQDEgmN0QJgiNgLPGnqtZH53Gszhvmrt8DSqqZzVedxeQFgHXeoKuY9ZruAMLzf3/s
	 6bGzMwJjS7tPw==
From: Alessio Ferri <alessio.ferri@mythread.it>
Date: Thu, 28 May 2026 19:31:40 +0200
Subject: [PATCH v4 6/7] b43: add channel info table for N-PHY r8 + radio
 2057 r8
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260528-b43_complete_n_phy_rev_8_radio_2057_rev_8_support-v4-6-464566194d47@gmail.com>
References: <20260528-b43_complete_n_phy_rev_8_radio_2057_rev_8_support-v4-0-464566194d47@gmail.com>
In-Reply-To: <20260528-b43_complete_n_phy_rev_8_radio_2057_rev_8_support-v4-0-464566194d47@gmail.com>
To: linux-wireless@vger.kernel.org, b43-dev@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Alessio Ferri <alessio.ferri@mythread.it>
X-Mailer: b4 0.14.3
X-CMAE-Envelope: MS4xfOUW+OMsbislXLVfjghoLiIMSllfjXG3jKhyT1qtr1TPotfGmGoeb8vIdxFRzON3ha+X1I01ALnINSxjunIRNJpkd+hb2Tso3vfQ6c4Al8AAeBDPURzQ
 29rmtnLnULRa/0VO3EcRCGmWXrooQhLCSqu40xytABMkKlcKB3hRVoC95GKPgsnpJAd3K9lN6GO5nNKsx17R2Mutn7NSdr9S/uiqb1CtsCb/hg8E+yllqt/u
 ISNj8R6MRy9W4IQM8xcXYODVPcwBRGWI658r2/xDq9z4g/xbS34L7GLyOev25WmdqYS+z22dTV35Abi8K3uXSBOpyhKw+cyRTuLnPPUyqtk=
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mythread.it,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[mythread.it:s=a1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alessio.ferri@mythread.it,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-37069-lists,linux-wireless=lfdr.de];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mythread.it:email,mythread.it:dkim];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[mythread.it:+]
X-Rspamd-Queue-Id: 1CE0F5F5CA3
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
 drivers/net/wireless/broadcom/b43/radio_2057.c | 106 +++++++++++++++++++++++++
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
2.54.0


