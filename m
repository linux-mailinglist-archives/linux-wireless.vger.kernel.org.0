Return-Path: <linux-wireless+bounces-36513-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJh6KCeECGrntAMAu9opvQ
	(envelope-from <linux-wireless+bounces-36513-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 16 May 2026 16:50:15 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D6955C2E5
	for <lists+linux-wireless@lfdr.de>; Sat, 16 May 2026 16:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 01CAF300E265
	for <lists+linux-wireless@lfdr.de>; Sat, 16 May 2026 14:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1DD3E1696;
	Sat, 16 May 2026 14:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=david-bauer.net header.i=@david-bauer.net header.b="rF6s+3kZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgate02.uberspace.is (mailgate02.uberspace.is [185.26.156.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD052C326F
	for <linux-wireless@vger.kernel.org>; Sat, 16 May 2026 14:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.26.156.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778943011; cv=none; b=YLET+Jd9xX1qT/L2uqkO4sPmQtr1g1xxmjQL8SQJnTsRLgXHtHMLUdiX9YM5I2jxsuFAwsIMTZk6giFKwdxIR9ysjiLgD3mG+ZEGbTYkcUHSv8WDvZ92SJR2q/IuUYgIYTjOh/RY5TH+oUTlyErq3wt6evGK2fOvgnpqC2s2B7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778943011; c=relaxed/simple;
	bh=TZUxj+HbLt7zXr6JPNAew7gA5D1W4pXAgzIME0JuOv0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SLrCzDG3G8shTqslZRvYOVPWfuhLcHzGLQ4TwnVnq/HBpM8eS3cHFytnWQI1XwKMQhyTBgJ+B3xJKA3WNl1RP+aSmgN7Zj6RQ0Gtw9HA9hm9PQ7y6oZObxCamhT0Icnyw2fdmckaFahCLl9+cZ/AF8mCsC8X/yvEDu6mKtvDups=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=david-bauer.net; spf=pass smtp.mailfrom=david-bauer.net; dkim=pass (4096-bit key) header.d=david-bauer.net header.i=@david-bauer.net header.b=rF6s+3kZ; arc=none smtp.client-ip=185.26.156.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=david-bauer.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=david-bauer.net
Received: from perseus.uberspace.de (perseus.uberspace.de [95.143.172.134])
	by mailgate02.uberspace.is (Postfix) with ESMTPS id 4A5A9180364
	for <linux-wireless@vger.kernel.org>; Sat, 16 May 2026 16:49:58 +0200 (CEST)
Received: (qmail 30872 invoked by uid 988); 16 May 2026 14:49:58 -0000
Authentication-Results: perseus.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unknown) (::1)
	by perseus.uberspace.de (Haraka/3.1.1) with ESMTPSA; Sat, 16 May 2026 16:49:57 +0200
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
Subject: [PATCH mt76] wifi: mt76: mt7915: configure noise floor reporting on reset
Date: Sat, 16 May 2026 16:49:42 +0200
Message-ID: <20260516144944.2574053-1-mail@david-bauer.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: /
X-Rspamd-Report: SUSPICIOUS_RECIPS(1.5) BAYES_HAM(-2.999999) MID_CONTAINS_FROM(1) MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -0.099999
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=david-bauer.net; s=uberspace;
	h=from:to:cc:subject:date;
	bh=TZUxj+HbLt7zXr6JPNAew7gA5D1W4pXAgzIME0JuOv0=;
	b=rF6s+3kZW5JAJo2UVMEHPudnGH8BLyyu/LJ6Z3yRDoz4CPYROD1mZWp43F2WEe9Hrshd6AVFTh
	l+Ocd5j60/t8xwJgn4dsui5vBJ5EAyOkCi143tQX9d1yyqQs5UnTZrP8/hd24SfLj1vNHD5pq8dJ
	1UXyZ3owVLSI7IJNds4LPK9CAesXPMEpgHaQH2JLKxZsUPU/rhcE8lYdKBRLew/hSiCjw8Vds+fx
	nrnylafYd3B9HegA7MVpHQmDKX7i34fkFG4n/Iiib3RGkHGdGUiTIlQeVUgtHTsUcYGxFCzT5wU8
	TcCC1fzArxizcVqCKePMO8jS8AIUzJrzRxpe8/SnxgOtXwf0KOb0NfjJA60FnUCgLReBy4jJTqBH
	Al0ADRMoCrAFpzQowj5u7TcW02csq8KgiwIFeDq8e+m+fE1/2d4+hWshrR1pmuZ+iTn4MTPdDGBs
	dxPYM1Ldl2vcyr0Ayd1+euZB++x9J2zRnErP8Z0w/MkaKDXSP9GMWvY/yvDEZOcUVEBG3OvwusmM
	fzX4HqXEu4tPJkv/j9LBOhFrsM/08cN2UnxUJmJFyYOfD81gH1N70r5F+RcxloXpt96xIeF2L+/x
	KYve2sN89jLr2WL0MQEGcydimm4SpUxRCzsj1P7WmtiZA5hDSnHg4bqbEPakivE1S+RfRrTDPeiT
	M=
X-Rspamd-Queue-Id: 03D6955C2E5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[david-bauer.net,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[david-bauer.net:s=uberspace];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[nbd.name,kernel.org,mediatek.com,gmail.com,collabora.com];
	TAGGED_FROM(0.00)[bounces-36513-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mail@david-bauer.net,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[david-bauer.net:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

When performing a full system recovery of the MCU on a dual-phy
platform, band 0 (usually 2.4GHz) stops reading correct noise floor
data.

This is due to noise floor reporting only being configured correctly
for the second device PHY.

Configure the respective registers correctly after restarting the MCU
firmware to fix reported noise-floor values.

Signed-off-by: David Bauer <mail@david-bauer.net>
---
 drivers/net/wireless/mediatek/mt76/mt7915/main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index e1d83052aa6dd..b42c26d0d09a4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -25,11 +25,13 @@ int mt7915_run(struct ieee80211_hw *hw)
 	struct mt7915_dev *dev = mt7915_hw_dev(hw);
 	struct mt7915_phy *phy = mt7915_hw_phy(hw);
 	bool running;
+	bool reset;
 	int ret;
 
 	running = mt7915_dev_running(dev);
+	reset = test_bit(MT76_RESET, &phy->mt76->state);
 
-	if (!running) {
+	if (!running || (reset && phy == &dev->phy)) {
 		ret = mt76_connac_mcu_set_pm(&dev->mt76,
 					     dev->phy.mt76->band_idx, 0);
 		if (ret)
-- 
2.53.0


