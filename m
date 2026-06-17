Return-Path: <linux-wireless+bounces-37872-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Z3ItKqAVM2og9QUAu9opvQ
	(envelope-from <linux-wireless+bounces-37872-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jun 2026 23:46:08 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B07F69C8FA
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jun 2026 23:46:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mythread.it header.s=a1 header.b=jM0IUaCv;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37872-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37872-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=mythread.it;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 782DD301D336
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jun 2026 21:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A733AFB18;
	Wed, 17 Jun 2026 21:46:04 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtpcmd14162.aruba.it (smtpcmd14162.aruba.it [62.149.156.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BFB3932C2
	for <linux-wireless@vger.kernel.org>; Wed, 17 Jun 2026 21:46:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781732764; cv=none; b=pZTpoNgCXBIH3Fzo93PV/s8Rn329BlFz9s1wX+XPqg2hxL5LC4QZKhbhL7bLQydCu+Bja0UB1CWT1p0qEmDZGNNbTMUJXBy3kNFut+3LZrSVixmCjA+PW23AaQ6FlVaaEezvpWRnxY+IjTFveUrhKP1rKSeOgn7970KG3jg1nQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781732764; c=relaxed/simple;
	bh=RemSfhcYBv9IVakI5chxNmWExg0Vjzc0TBsj1lPl7VE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f+XLze1BkPtw7hfINvI5/AKL8cHPzBD3hnwe3xXJX9XtgQZXfsMin65vevf33ryXpR/NU03ID4fOjEQMTUDPwf/jZgnCQPNaOOLKS1HE/cS68NvLYctrongSBbamNwe4ubD0M6bLAqwfPTvK2yUMesLAkfkRnsW/VL3J+zJHy1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mythread.it; spf=pass smtp.mailfrom=mythread.it; dkim=pass (2048-bit key) header.d=mythread.it header.i=@mythread.it header.b=jM0IUaCv; arc=none smtp.client-ip=62.149.156.162
Received: from [192.168.1.237] ([94.34.125.0])
	by Aruba SMTP with ESMTPSA
	id Zy28wJnjp4OeoZy29w469l; Wed, 17 Jun 2026 23:42:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mythread.it; s=a1;
	t=1781732573; bh=RemSfhcYBv9IVakI5chxNmWExg0Vjzc0TBsj1lPl7VE=;
	h=From:Date:Subject:MIME-Version:Content-Type:To;
	b=jM0IUaCv+UpqTDEf9wPrzPIQ1qWtMUb/qidcdGLVgc8OQcJZnqeNeft0IkxpB6fum
	 kdSJV2/IrUva+nPHwyPC63LhM2+wc6vDVK6rNDc2guhkVUjp9VvCHGqVis91sdYBpU
	 nOG2JshjMsjWuBEJCqi4BWB3EX1YRPGnAxzhFYFgvLYIcXCkBz7FTdOsk1cdjXUUYf
	 nRpTvLW8uRQMOGR51PX1dkgbFEZORB37NgwLrNHqefo2NawtubEemVK/z/Iih3Fuo/
	 Z9QMO1wctJZO09EgFeL/gAmhql8GSbyiTTCjns3hoyD/Q1wFkXbUChIpYeYnJRhCM/
	 0Htc5iTFQaAmg==
From: Alessio Ferri <alessio.ferri@mythread.it>
Date: Wed, 17 Jun 2026 23:42:10 +0200
Subject: [PATCH 3/4] ssb: bcma: add SPROM revision 11 extraction
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-b43-add-4352-wip-v1-3-c81323496720@gmail.com>
References: <20260617-b43-add-4352-wip-v1-0-c81323496720@gmail.com>
In-Reply-To: <20260617-b43-add-4352-wip-v1-0-c81323496720@gmail.com>
To: =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>, 
 Michael Buesch <m@bues.ch>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 b43-dev@lists.infradead.org, Alessio Ferri <alessio.ferri@mythread.it>, 
 Alessio Ferri <alessio.ferri.3012@gmail.com>
X-Mailer: b4 0.14.3
X-CMAE-Envelope: MS4xfPga/+jcvE7OuVVkZZs2F7agCubGjDhtcpV1hH4MibJtEXcWFUoXf4T1Rcg46b/cSooFJI1uB+/CcAr/9DA2GnTTvr//ENtbOm4ZlZw14Hbjw+y03/8N
 i44DKnR74un2GonNyUEQSXpwwq/KsP0PseoIwO0fk9zgo2Y9wNj5nojY1FVIJ9Ib6fRVKLYs9RwK8D3eYFjibOy5IqEA6ec+2lisEMwSiQwiwWjH2/zN87eW
 pJYLaqmC4TX4aKJKhW2DnSD9+Qx5bCTexrywcCV81yUW0vva/8k/WRabCymJEErXpUPCB4SGuhMH9JhqKLdoZThVJi5iGOAeYeNaj5ar55WytF6pCt6C9vOf
 IFxNgFy2C4Vhx+LQbfeqHKI7f/Due0rsxajeRDiqdC4loLp7fhhxNHhS8H/OrJgZGypV1R8i
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_MATCH_TO(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[mythread.it,none];
	R_DKIM_ALLOW(-0.20)[mythread.it:s=a1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37872-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,bues.ch];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:zajec5@gmail.com,m:m@bues.ch,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:b43-dev@lists.infradead.org,m:alessio.ferri@mythread.it,m:alessio.ferri.3012@gmail.com,m:alessioferri3012@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[alessio.ferri@mythread.it,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mythread.it:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alessio.ferri@mythread.it,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,mythread.it,gmail.com];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0B07F69C8FA

From: Alessio Ferri <alessio.ferri.3012@gmail.com>

SPROM revision 11 is needed with the BCM4352/BCM4360 family. Extend
struct ssb_sprom with the rev-11 fields actually parsed (per-band rxgains,
per-chain maxp/pa power info, 80/160 MHz MCS power offsets, pdoffset40ma)
and add bcma_sprom_extract_r11(), dispatched from bcma_sprom_get() when the
SPROM revision word reads as 11. bcma_sprom_get() already probes the rev-11
buffer size, and bcma_sprom_valid() populates bus->sprom.revision before
the dispatch. Revisions <= 10 keep the extract_r8 path.

Header fields (IL0MAC/ANTAVAIL/TXRXC/CCODE) reuse the rev-8 masks/shifts;
only the absolute offsets moved. CCODE uses 0x96, since rev-8 0x92 collides
with the middle word of the rev-11 IL0MAC block.

Assisted-by: Claude:claude-Opus-4.8
Signed-off-by: Alessio Ferri <alessio.ferri@mythread.it>
---
 drivers/bcma/sprom.c         | 100 ++++++++++++++++++++++++++++++++++++++++++-
 include/linux/ssb/ssb.h      |  31 ++++++++++++++
 include/linux/ssb/ssb_regs.h |  44 +++++++++++++++++++
 3 files changed, 174 insertions(+), 1 deletion(-)

diff --git a/drivers/bcma/sprom.c b/drivers/bcma/sprom.c
index e668ad7963fc..514c8149dbe7 100644
--- a/drivers/bcma/sprom.c
+++ b/drivers/bcma/sprom.c
@@ -474,6 +474,101 @@ static void bcma_sprom_extract_r8(struct bcma_bus *bus, const u16 *sprom)
 	     SSB_SPROM8_TEMPDELTA_HYSTERESIS_SHIFT);
 }
 
+static void bcma_sprom_unpack_rxgains(struct ssb_sprom_rxgains *out,
+				      int chain, u8 packed)
+{
+	out->trelnabyp[chain] = (packed >> 7) & 0x01;
+	out->triso[chain]     = (packed >> 3) & 0x0f;
+	out->elnagain[chain]  =  packed       & 0x07;
+}
+
+static void bcma_sprom_extract_r11(struct bcma_bus *bus, const u16 *sprom)
+{
+	static const u16 pwr_info_offset[] = {
+		SSB_SPROM11_PWR_INFO_CORE0,
+		SSB_SPROM11_PWR_INFO_CORE1,
+		SSB_SPROM11_PWR_INFO_CORE2,
+	};
+	u16 v;
+	int i, j;
+
+	BUILD_BUG_ON(ARRAY_SIZE(pwr_info_offset) >
+		     ARRAY_SIZE(bus->sprom.core_pwr_info));
+
+	/* Header: rev-11 offsets, rev-8 masks/shifts. */
+	for (i = 0; i < 3; i++) {
+		v = sprom[SPOFF(SSB_SPROM11_IL0MAC) + i];
+		*(((__be16 *)bus->sprom.il0mac) + i) = cpu_to_be16(v);
+	}
+
+	SPEX(board_rev, SSB_SPROM8_BOARDREV, ~0, 0);
+	SPEX(board_type, SSB_SPROM1_SPID, ~0, 0);
+
+	SPEX(country_code, SSB_SPROM11_CCODE, ~0, 0);
+	SPEX(ant_available_a, SSB_SPROM11_ANTAVAIL, SSB_SPROM8_ANTAVAIL_A,
+	     SSB_SPROM8_ANTAVAIL_A_SHIFT);
+	SPEX(ant_available_bg, SSB_SPROM11_ANTAVAIL, SSB_SPROM8_ANTAVAIL_BG,
+	     SSB_SPROM8_ANTAVAIL_BG_SHIFT);
+	SPEX(txchain, SSB_SPROM11_TXRXC, SSB_SPROM8_TXRXC_TXCHAIN,
+	     SSB_SPROM8_TXRXC_TXCHAIN_SHIFT);
+	SPEX(rxchain, SSB_SPROM11_TXRXC, SSB_SPROM8_TXRXC_RXCHAIN,
+	     SSB_SPROM8_TXRXC_RXCHAIN_SHIFT);
+	SPEX(antswitch, SSB_SPROM11_TXRXC, SSB_SPROM8_TXRXC_SWITCH,
+	     SSB_SPROM8_TXRXC_SWITCH_SHIFT);
+	SPEX(subband5gver, SSB_SPROM11_SUBBAND5GVER, 0x00ff, 0);
+
+	/* Per-chain power info. */
+	for (i = 0; i < ARRAY_SIZE(pwr_info_offset); i++) {
+		struct ssb_sprom_core_pwr_info *p = &bus->sprom.core_pwr_info[i];
+		u16 base = pwr_info_offset[i];
+
+		p->maxp2ga = sprom[SPOFF(base + SSB_SPROM11_PWR_MAXP2GA)] & 0xff;
+
+		for (j = 0; j < 3; j++)
+			p->pa2ga[j] = sprom[SPOFF(base + SSB_SPROM11_PWR_PA2GA) + j];
+
+		v = sprom[SPOFF(base + SSB_SPROM11_PWR_MAXP5GA)];
+		p->maxp5ga[0] = v & 0xff;
+		p->maxp5ga[1] = (v >> 8) & 0xff;
+		v = sprom[SPOFF(base + SSB_SPROM11_PWR_MAXP5GA) + 1];
+		p->maxp5ga[2] = v & 0xff;
+		p->maxp5ga[3] = (v >> 8) & 0xff;
+
+		for (j = 0; j < 12; j++)
+			p->pa5ga[j] = sprom[SPOFF(base + SSB_SPROM11_PWR_PA5GA) + j];
+
+		v = sprom[SPOFF(base + SSB_SPROM11_PWR_RXGAINS0)];
+		bcma_sprom_unpack_rxgains(&bus->sprom.rxgains_5gm, i,  v       & 0xff);
+		bcma_sprom_unpack_rxgains(&bus->sprom.rxgains_5gh, i, (v >> 8) & 0xff);
+		v = sprom[SPOFF(base + SSB_SPROM11_PWR_RXGAINS1)];
+		bcma_sprom_unpack_rxgains(&bus->sprom.rxgains_2g,  i,  v       & 0xff);
+		bcma_sprom_unpack_rxgains(&bus->sprom.rxgains_5gl, i, (v >> 8) & 0xff);
+	}
+
+	for (i = 0; i < 3; i++)
+		bus->sprom.pdoffset40ma[i] =
+			sprom[SPOFF(SSB_SPROM11_PDOFFSET40MA) + i];
+
+	SPEX(cckbw202gpo,           SSB_SPROM11_CCKBW202GPO,           ~0, 0);
+	SPEX(cckbw20ul2gpo,         SSB_SPROM11_CCKBW20UL2GPO,         ~0, 0);
+	SPEX32(mcsbw202gpo,         SSB_SPROM11_MCSBW202GPO,           ~0, 0);
+	SPEX32(mcsbw402gpo,         SSB_SPROM11_MCSBW402GPO,           ~0, 0);
+	SPEX(dot11agofdmhrbw202gpo, SSB_SPROM11_DOT11AGOFDMHRBW202GPO, ~0, 0);
+	SPEX(ofdmlrbw202gpo,        SSB_SPROM11_OFDMLRBW202GPO,        ~0, 0);
+	SPEX32(mcsbw205glpo,        SSB_SPROM11_MCSBW205GLPO,          ~0, 0);
+	SPEX32(mcsbw405glpo,        SSB_SPROM11_MCSBW405GLPO,          ~0, 0);
+	SPEX32(mcsbw805glpo,        SSB_SPROM11_MCSBW805GLPO,          ~0, 0);
+	SPEX32(mcsbw1605glpo,       SSB_SPROM11_MCSBW1605GLPO,         ~0, 0);
+	SPEX32(mcsbw205gmpo,        SSB_SPROM11_MCSBW205GMPO,          ~0, 0);
+	SPEX32(mcsbw405gmpo,        SSB_SPROM11_MCSBW405GMPO,          ~0, 0);
+	SPEX32(mcsbw805gmpo,        SSB_SPROM11_MCSBW805GMPO,          ~0, 0);
+	SPEX32(mcsbw1605gmpo,       SSB_SPROM11_MCSBW1605GMPO,         ~0, 0);
+	SPEX32(mcsbw205ghpo,        SSB_SPROM11_MCSBW205GHPO,          ~0, 0);
+	SPEX32(mcsbw405ghpo,        SSB_SPROM11_MCSBW405GHPO,          ~0, 0);
+	SPEX32(mcsbw805ghpo,        SSB_SPROM11_MCSBW805GHPO,          ~0, 0);
+	SPEX32(mcsbw1605ghpo,       SSB_SPROM11_MCSBW1605GHPO,         ~0, 0);
+}
+
 /*
  * Indicates the presence of external SPROM.
  */
@@ -640,7 +735,10 @@ int bcma_sprom_get(struct bcma_bus *bus)
 		bcma_warn(bus, "Invalid SPROM read from the PCIe card, trying to use fallback SPROM\n");
 		err = bcma_fill_sprom_with_fallback(bus, &bus->sprom);
 	} else {
-		bcma_sprom_extract_r8(bus, sprom);
+		if (bus->sprom.revision == 11)
+			bcma_sprom_extract_r11(bus, sprom);
+		else
+			bcma_sprom_extract_r8(bus, sprom);
 		kfree(sprom);
 	}
 
diff --git a/include/linux/ssb/ssb.h b/include/linux/ssb/ssb.h
index e1fb11e0f12c..9d4a13c4eca3 100644
--- a/include/linux/ssb/ssb.h
+++ b/include/linux/ssb/ssb.h
@@ -23,6 +23,19 @@ struct ssb_sprom_core_pwr_info {
 	u8 itssi_2g, itssi_5g;
 	u8 maxpwr_2g, maxpwr_5gl, maxpwr_5g, maxpwr_5gh;
 	u16 pa_2g[4], pa_5gl[4], pa_5g[4], pa_5gh[4];
+
+	/* SROM rev 11 */
+	u8 maxp2ga;
+	u8 maxp5ga[4];
+	u16 pa2ga[3];
+	u16 pa5ga[12];
+};
+
+/* Per-band rx gain context, one value per RF chain. SROM rev 11. */
+struct ssb_sprom_rxgains {
+	u8 elnagain[3];
+	u8 triso[3];
+	u8 trelnabyp[3];
 };
 
 struct ssb_sprom {
@@ -192,6 +205,24 @@ struct ssb_sprom {
 	u16 legofdm40duppo;
 	u8 sar2g;
 	u8 sar5g;
+
+	/* SROM rev 11. Populated only by the rev 11 extractor; zero on
+	 * rev <= 10 boards.
+	 */
+	struct ssb_sprom_rxgains rxgains_2g;
+	struct ssb_sprom_rxgains rxgains_5gl;
+	struct ssb_sprom_rxgains rxgains_5gm;
+	struct ssb_sprom_rxgains rxgains_5gh;
+	u8 subband5gver;
+	u16 dot11agofdmhrbw202gpo;
+	u16 ofdmlrbw202gpo;
+	u32 mcsbw805glpo;
+	u32 mcsbw805gmpo;
+	u32 mcsbw805ghpo;
+	u32 mcsbw1605glpo;
+	u32 mcsbw1605gmpo;
+	u32 mcsbw1605ghpo;
+	u16 pdoffset40ma[3];
 };
 
 /* Information about the PCB the circuitry is soldered on. */
diff --git a/include/linux/ssb/ssb_regs.h b/include/linux/ssb/ssb_regs.h
index 210f46494065..9fedf5dcdccd 100644
--- a/include/linux/ssb/ssb_regs.h
+++ b/include/linux/ssb/ssb_regs.h
@@ -606,6 +606,50 @@
 #define SSB_SPROM8_BW40PO		0x0196
 #define SSB_SPROM8_BWDUPPO		0x0198
 
+/* SROM revision 11. Only the header fields whose absolute offset moved
+ * are redefined; the bitfield masks/shifts are reused from rev 8.
+ */
+#define SSB_SPROM11_IL0MAC		0x0090	/* 6 byte MAC address */
+#define SSB_SPROM11_CCODE		0x0096	/* 2 byte country code */
+#define SSB_SPROM11_ANTAVAIL		0x00A0
+#define SSB_SPROM11_TXRXC		0x00A8
+#define SSB_SPROM11_PDOFFSET40MA	0x00CA	/* 3 x u16, one per chain */
+#define SSB_SPROM11_SUBBAND5GVER	0x00D6
+
+/* Per-chain power info blocks. Stride 0x28 bytes; field layout given by
+ * SSB_SPROM11_PWR_* below.
+ */
+#define SSB_SPROM11_PWR_INFO_CORE0	0x00D8
+#define SSB_SPROM11_PWR_INFO_CORE1	0x0100
+#define SSB_SPROM11_PWR_INFO_CORE2	0x0128
+
+#define SSB_SPROM11_PWR_MAXP2GA		0x0000	/* u8 in low byte */
+#define SSB_SPROM11_PWR_PA2GA		0x0002	/* 3 x u16 */
+#define SSB_SPROM11_PWR_RXGAINS0	0x0008	/* 5gm (lo) / 5gh (hi) */
+#define SSB_SPROM11_PWR_RXGAINS1	0x000A	/* 2g  (lo) / 5gl (hi) */
+#define SSB_SPROM11_PWR_MAXP5GA		0x000C	/* 2 x u16 -> 4 x u8 */
+#define SSB_SPROM11_PWR_PA5GA		0x0010	/* 12 x u16 */
+
+/* Power-per-rate region. */
+#define SSB_SPROM11_CCKBW202GPO		0x0150
+#define SSB_SPROM11_CCKBW20UL2GPO	0x0152
+#define SSB_SPROM11_MCSBW202GPO		0x0154
+#define SSB_SPROM11_MCSBW402GPO		0x0158
+#define SSB_SPROM11_DOT11AGOFDMHRBW202GPO 0x015C
+#define SSB_SPROM11_OFDMLRBW202GPO	0x015E
+#define SSB_SPROM11_MCSBW205GLPO	0x0160
+#define SSB_SPROM11_MCSBW405GLPO	0x0164
+#define SSB_SPROM11_MCSBW805GLPO	0x0168
+#define SSB_SPROM11_MCSBW1605GLPO	0x016C
+#define SSB_SPROM11_MCSBW205GMPO	0x0170
+#define SSB_SPROM11_MCSBW405GMPO	0x0174
+#define SSB_SPROM11_MCSBW805GMPO	0x0178
+#define SSB_SPROM11_MCSBW1605GMPO	0x017C
+#define SSB_SPROM11_MCSBW205GHPO	0x0180
+#define SSB_SPROM11_MCSBW405GHPO	0x0184
+#define SSB_SPROM11_MCSBW805GHPO	0x0188
+#define SSB_SPROM11_MCSBW1605GHPO	0x018C
+
 /* Values for boardflags_lo read from SPROM */
 #define SSB_BFL_BTCOEXIST		0x0001	/* implements Bluetooth coexistance */
 #define SSB_BFL_PACTRL			0x0002	/* GPIO 9 controlling the PA */

-- 
2.54.0


