Return-Path: <linux-wireless+bounces-37684-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rt9lIxcxK2oH4AMAu9opvQ
	(envelope-from <linux-wireless+bounces-37684-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 00:05:11 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E3A675898
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 00:05:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=david-bauer.net header.s=uberspace header.b=dPdTPapx;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37684-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37684-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=david-bauer.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BE18030FDDAB
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 22:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5473446BE;
	Thu, 11 Jun 2026 22:05:06 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgate02.uberspace.is (mailgate02.uberspace.is [185.26.156.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3248C24336D
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jun 2026 22:05:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781215506; cv=none; b=tyWMMIjDe1spqh5J3Ql40WGnZcS7zHviJuUYggdgMtvSae82tPh90tMPcnAtEueuBJ8pt7TiVBxnXWZUItjUOf9694avxIV0Dw0u/G7j6qeUtuHpP+UugSsPJn+knY97ZY2idr34ouIaIlPNrGBbGpWLghTAMoA72h56RI/vemU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781215506; c=relaxed/simple;
	bh=WZ6/0RV6JrkCzvhVDyitGRXoseIDmTlrOiFDgXdCe/s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BNXbR6o6Fsa8qX/1NjapKRdZCXRHlPjYODSJIqpa/7goUTFNfrNlULVRXxRaSefvwJrALzMCFzLi5dUnL01vDSXv2SH3GXSOcqN32O6t6Vca1IUgiEjDXvYuM0KrUfaTYmegK/HeoYiiVyG8ieJQ21BCRLT666HuMgkbUNo/e1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=david-bauer.net; spf=pass smtp.mailfrom=david-bauer.net; dkim=pass (4096-bit key) header.d=david-bauer.net header.i=@david-bauer.net header.b=dPdTPapx; arc=none smtp.client-ip=185.26.156.114
Received: from perseus.uberspace.de (perseus.uberspace.de [95.143.172.134])
	by mailgate02.uberspace.is (Postfix) with ESMTPS id 03CB81800E2
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jun 2026 23:57:17 +0200 (CEST)
Received: (qmail 27404 invoked by uid 988); 11 Jun 2026 21:57:16 -0000
Received: from unknown (HELO unknown) (::1)
	by perseus.uberspace.de (Haraka/3.1.1) with ESMTPSA; Thu, 11 Jun 2026 23:57:16 +0200
From: David Bauer <mail@david-bauer.net>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH mt76] wifi: mt76: mt7603: free beacon SKB on error
Date: Thu, 11 Jun 2026 23:56:56 +0200
Message-ID: <20260611215658.259324-1-mail@david-bauer.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: /
X-Rspamd-Report: SUSPICIOUS_RECIPS(1.5) BAYES_HAM(-3) MID_CONTAINS_FROM(1) MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -0.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=david-bauer.net; s=uberspace;
	h=from:to:cc:subject:date;
	bh=WZ6/0RV6JrkCzvhVDyitGRXoseIDmTlrOiFDgXdCe/s=;
	b=dPdTPapxPuPS2rFw/gDhACjtqykW0KPKzIt8/5eWrBPAxFJUq/qXo12E7+mwbBF//IKM8aYwek
	CmU5c7WElzSM4PlIVGLy8Ng+ODHhpWNRer2uS7ybvIFqwonRCYmJQDu6BqoyYIm3qEFbtWr7UfuS
	55AgYTMFUZKyCVwfKMP3V7UxPRMTn9wCT2QoON58TNE5vK0Hi/xP0AAkIWeioH4Y7ZgsOpyqRt90
	fBITw0XfQcroaHukIq+C6wDzCw78IKd4r66S3p86z/LoBylKuisUTiERoPvL0UasiCjdNeK7pbUN
	8NHWZwQC3rQYBwnmvxB8PQOP6aQFLwNmn0fgHWadTa8OQWv95mO5iCB/SRuIJT9mAb4TtU1eszsq
	ds31fwj9wx4i+Rp7KwhxLNluj+quRntE/XqeePRU5uSATNwbDRW/orwXbK66fRRCEDTHA5rkWoq5
	PYiu/KjTwKd8USi/jLmNBLULQfvJw4fqUkOLvXlIh07EdggOU6MMxc8wi6YfZ5Cv0ovIRSqRty1x
	K5HDt4vDIk1bb2l0bnVhTiHaF+uukMnqRDV9ZRW1Jax4nogF4goTnFZA2hkIS/+fPPSHdVZAb7Iq
	xE7Yj/7Xzn1LQTNKW/xmSyb4p+TeBYhoMjqRZJ3CUL64Q3/dTJE5LnPhDuexd/dssqNkGqgYwftZ
	0=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[david-bauer.net,none];
	R_DKIM_ALLOW(-0.20)[david-bauer.net:s=uberspace];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nbd@nbd.name,m:lorenzo@kernel.org,m:ryder.lee@mediatek.com,m:shayne.chen@mediatek.com,m:sean.wang@mediatek.com,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[mail@david-bauer.net,linux-wireless@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37684-lists,linux-wireless=lfdr.de];
	FREEMAIL_TO(0.00)[nbd.name,kernel.org,mediatek.com,gmail.com,collabora.com];
	DKIM_TRACE(0.00)[david-bauer.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mail@david-bauer.net,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E8E3A675898

The SKB containing the generated beacon is not freed when the beacon
queue is deected stuck and scheduled for recovery.

Fixes potential memory leaks in case the beacon queue is detected stuck.

Signed-off-by: David Bauer <mail@david-bauer.net>
---
 drivers/net/wireless/mediatek/mt76/mt7603/beacon.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/beacon.c b/drivers/net/wireless/mediatek/mt76/mt7603/beacon.c
index 300a7f9c2ef11..acca98139f92e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/beacon.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/beacon.c
@@ -56,6 +56,7 @@ mt7603_update_beacon_iter(void *priv, u8 *mac, struct ieee80211_vif *vif)
 		FIELD_PREP(MT_DMA_FQCR0_TARGET_QID, MT_TX_HW_QUEUE_BCN));
 	if (!mt76_poll(dev, MT_DMA_FQCR0, MT_DMA_FQCR0_BUSY, 0, 5000)) {
 		dev->beacon_check = MT7603_WATCHDOG_TIMEOUT;
+		dev_kfree_skb(skb);
 		goto out;
 	}
 
@@ -63,6 +64,7 @@ mt7603_update_beacon_iter(void *priv, u8 *mac, struct ieee80211_vif *vif)
 		FIELD_PREP(MT_DMA_FQCR0_TARGET_QID, MT_TX_HW_QUEUE_BMC));
 	if (!mt76_poll(dev, MT_DMA_FQCR0, MT_DMA_FQCR0_BUSY, 0, 5000)) {
 		dev->beacon_check = MT7603_WATCHDOG_TIMEOUT;
+		dev_kfree_skb(skb);
 		goto out;
 	}
 
-- 
2.53.0


