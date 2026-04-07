Return-Path: <linux-wireless+bounces-34406-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mF/SF3xh1GnltQcAu9opvQ
	(envelope-from <linux-wireless+bounces-34406-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 03:44:28 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B35593A8C80
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 03:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35E023006B62
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Apr 2026 01:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7102B9A4;
	Tue,  7 Apr 2026 01:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mvDDZoe1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FEA22083
	for <linux-wireless@vger.kernel.org>; Tue,  7 Apr 2026 01:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775526252; cv=none; b=q0WrspY9KzHPcgBd9/k8mA9cXrzCTpBYBEnjaMOGKxBP/erUOMyhKHkbKtnNPU45v+PkNRmUFUzNOE8rNMIYAnjq3M6+Z+wcUcpPrnw89e12VZKM8Ri7cQOIZ8leBm1AP9/rUVoi8SL0iyPqDu3tfN9IrsLM1D/R6f9oUXNzq5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775526252; c=relaxed/simple;
	bh=bAphpwgSRn/KS5XsZpvbeEeBJrCaZu9pasUoORsKAL4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S0vC8aUMa3uxJipvbmYINi1ldWTR9q0b6zS7pPW74szLM9+OXzq8S4XCk163Rap6yup4bSRU2I7MUoyFdks/NkyCxwqmmlP1X8FZamsA1QxZGq1LEYFW1m1WrIAAk6vDnXST2dpo8RClMD4OzFIanDDidoOk6fKX9F0fSvBJHQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mvDDZoe1; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-79a60975dc5so42010287b3.0
        for <linux-wireless@vger.kernel.org>; Mon, 06 Apr 2026 18:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775526250; x=1776131050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q/2q4nHNGvrjKAMm5iU+mbOXkGGZO8zoMXFW2SLHD/o=;
        b=mvDDZoe1Cdm6X09tWiUZgeMHUPpXTGHzAjWO2a1F2/mf4Dmp91AhACooSRAwHovfGn
         UMn8Ff5/rZd+nezNvAyqQGCs1116QoSKjvaa8U132O+PAI/IxHuCEnEQ2QQdGir1modU
         5/r1LxOo+JlbaeUHxxR5ubdJXWYVfTPkPN9WFsoEPckE6UteuXxVmN3hzDhGO1xSJlRF
         rgJotkEVIR/WXNLXmqUe3dTs9nZS8BmIqatIPBAqdMjPSOhjcmEdpeJEY02gPCsJpjL+
         wmyM4IPMUjXvJQmrdGN928rZSVLINccIFb3v/OeZvJtXq1S/mddpMye05MypqKHp9Yx+
         T+Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775526250; x=1776131050;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q/2q4nHNGvrjKAMm5iU+mbOXkGGZO8zoMXFW2SLHD/o=;
        b=YcaYZL7NooBqxrnjZHg9q05d5AtxUaL557FpQxulTBpdxaNGIXNPidOXIKbzKVCOwf
         1YSEVCqNoSUC0QV7h0rXB6SfH2X7LvimVnqmYJeT/lNz84WA7l7nqkJYsym5k74YsXkl
         wwXABSq0SUZq6s0dUn6mmZ9/xRhkGUmfeB0oVUQZ39mfzgi8+U0FbbGxMB33pyn6eGTQ
         SoQ/z22r5Gfs+qzW0N/0S2v9qOkBMbEYAvsDdKAN0TQ8rm2hgk3yMwIOEYEWbbBGJLhd
         /SfkZVRLuAI3DBQlzd0ewIJESZo9xdn0jM8l/RAm4kErIAKkz37rYLbnCCWkEeCONiVT
         QDrw==
X-Gm-Message-State: AOJu0YzisDO9Qw97vWHpyfNxrOrH4EBwnXhLIbr5bwugFwxpSo/thUU8
	WY0cYVrsW1nB3H0duY8AUw81Q7TNkhY0FBVovvtrkYHYi0gz/Y3wz2ZmqMLieWoQ
X-Gm-Gg: AeBDieuM4bOIRQ8mNONb3rltvLcdtPKUxiNJtTYYi+bDsFQlwOtvvOkraa4YcJPzuN3
	KLOEEkpeb1nBkOyDDSAndhiUI/x/2dSPlU7MCP9EZqrpxiRieP0jO+L/jWn6nFSmCdRVuj8jbM6
	IpyaRSCKmN30bxgOQJcbbncqwfCtQ+HrArq8KfGpc0vplPZCA33OhHb4qyzjC2UGYnxNBpKG0So
	j+nziLGfw6NOzKoZysntxTV8Hlur2OFk4UHA/ZCrBLNQSBYgL/FxY+59KOd3R6oNqSkgRet3sz2
	ihFeLrxyTHR32TW2jcmeSDZkR8ErhWXj1Laj9c+v/oNF/Vce/6p41yzR380Evki32MBoSXMMia4
	BiC9FfzKCFNqGEgpws7Cc31bv5U4dqA+JErywygalYgSwtKD6zCXdRbpQ0Txzagk3z4K6S7r+QZ
	R1iT///ETBWh60mNhIZyY8/ElrMbqwe/UZSZbEH64l55hABNnDAkLhRUHZVaUj
X-Received: by 2002:a05:690c:c507:b0:7a3:fcaf:a893 with SMTP id 00721157ae682-7a4d556d88fmr146557777b3.35.1775526249672;
        Mon, 06 Apr 2026 18:44:09 -0700 (PDT)
Received: from DEV.lan (c-75-74-152-49.hsd1.fl.comcast.net. [75.74.152.49])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7a36b55266asm61709887b3.0.2026.04.06.18.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 18:44:09 -0700 (PDT)
From: Joshua Klinesmith <joshuaklinesmith@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	Joshua Klinesmith <joshuaklinesmith@gmail.com>
Subject: [PATCH wireless] wifi: mt76: mt7915: expose all physical chains via available_antennas
Date: Mon,  6 Apr 2026 21:43:55 -0400
Message-ID: <20260407014355.45896-1-joshuaklinesmith@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[nbd.name,kernel.org,mediatek.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-34406-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuaklinesmith@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B35593A8C80
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On MT7916/MT7981 3T3R variants with 2 spatial streams on the 5 GHz
band, wiphy->available_antennas_{tx,rx} is set from antenna_mask which
is derived from NSS, reporting only 2 available antennas. This
contradicts get_antenna() which already returns the full 3-chain
chainmask, causing a mismatch visible in "iw list":

  Available Antennas: TX 0x3 RX 0x3
  Configured Antennas: TX 0x1c RX 0x1c

Station signal reporting also only includes 2 per-chain RSSI values
instead of all 3.

Set available_antennas from chainmask instead of antenna_mask, matching
the approach used by the mt7996 driver. Save the original antenna_mask
at EEPROM parse time so set_antenna can cap it to preserve correct
HT/VHT/HE stream capability announcements. The existing 3T3R special
case in set_antenna becomes unnecessary with all chains exposed.

Update RX status chain reporting and ACK signal aggregation to use
the physical chain count so all receive chains contribute. Vendor
driver analysis confirms the hardware populates all RCPI fields in
the P-RXV unconditionally.

Fixes: a7ec8bcf0003 ("wifi: mt76: mt7915: rework eeprom tx paths and streams init")
Link: https://github.com/openwrt/openwrt/issues/19323
Signed-off-by: Joshua Klinesmith <joshuaklinesmith@gmail.com>
---
 .../net/wireless/mediatek/mt76/mt7915/eeprom.c    |  1 +
 drivers/net/wireless/mediatek/mt76/mt7915/init.c  |  4 ++--
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c   |  5 +++--
 drivers/net/wireless/mediatek/mt76/mt7915/main.c  | 15 ++++-----------
 .../net/wireless/mediatek/mt76/mt7915/mt7915.h    |  2 ++
 5 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
index eb92cbf1a284..db6788a7ebc3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
@@ -260,6 +260,7 @@ void mt7915_eeprom_parse_hw_cap(struct mt7915_dev *dev,
 	if (band)
 		mphy->chainmask <<= dev->chainshift;
 	mphy->antenna_mask = BIT(nss) - 1;
+	phy->orig_antenna_mask = mphy->antenna_mask;
 	dev->chainmask |= mphy->chainmask;
 	dev->chainshift = hweight8(dev->mphy.chainmask);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index 22443cbc74ad..ffcd3871e289 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -470,8 +470,8 @@ mt7915_init_wiphy(struct mt7915_phy *phy)
 	mt7915_set_stream_he_caps(phy);
 	mt7915_init_txpower(phy);
 
-	wiphy->available_antennas_rx = phy->mt76->antenna_mask;
-	wiphy->available_antennas_tx = phy->mt76->antenna_mask;
+	wiphy->available_antennas_rx = phy->mt76->chainmask;
+	wiphy->available_antennas_tx = phy->mt76->chainmask;
 
 	/* init led callbacks */
 	if (IS_ENABLED(CONFIG_MT76_LEDS)) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index cefe56c05731..34a0690c5864 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -224,7 +224,8 @@ static void mt7915_mac_sta_poll(struct mt7915_dev *dev)
 		rssi[3] = to_rssi(GENMASK(31, 14), val);
 
 		msta->ack_signal =
-			mt76_rx_signal(msta->vif->phy->mt76->antenna_mask, rssi);
+			mt76_rx_signal(BIT(hweight16(msta->vif->phy->mt76->chainmask)) - 1,
+				       rssi);
 
 		ewma_avg_signal_add(&msta->avg_ack_signal, -msta->ack_signal);
 	}
@@ -450,7 +451,7 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb,
 		if (v0 & MT_PRXV_HT_AD_CODE)
 			status->enc_flags |= RX_ENC_FLAG_LDPC;
 
-		status->chains = mphy->antenna_mask;
+		status->chains = BIT(hweight16(mphy->chainmask)) - 1;
 		status->chain_signal[0] = to_rssi(MT_PRXV_RCPI0, v1);
 		status->chain_signal[1] = to_rssi(MT_PRXV_RCPI1, v1);
 		status->chain_signal[2] = to_rssi(MT_PRXV_RCPI2, v1);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 90d5e79fbf74..a47b9cca3b46 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -1121,23 +1121,16 @@ mt7915_set_antenna(struct ieee80211_hw *hw, int radio_idx, u32 tx_ant, u32 rx_an
 {
 	struct mt7915_dev *dev = mt7915_hw_dev(hw);
 	struct mt7915_phy *phy = mt7915_hw_phy(hw);
-	int max_nss = hweight8(hw->wiphy->available_antennas_tx);
-	u8 chainshift = dev->chainshift;
 	u8 band = phy->mt76->band_idx;
+	u8 shift = dev->chainshift * band;
 
-	if (!tx_ant || tx_ant != rx_ant || ffs(tx_ant) > max_nss)
+	if (!tx_ant || tx_ant != rx_ant)
 		return -EINVAL;
 
 	mutex_lock(&dev->mt76.mutex);
 
-	phy->mt76->antenna_mask = tx_ant;
-
-	/* handle a variant of mt7916/mt7981 which has 3T3R but nss2 on 5 GHz band */
-	if ((is_mt7916(&dev->mt76) || is_mt7981(&dev->mt76)) &&
-	    band && hweight8(tx_ant) == max_nss)
-		phy->mt76->chainmask = (dev->chainmask >> chainshift) << chainshift;
-	else
-		phy->mt76->chainmask = tx_ant << (chainshift * band);
+	phy->mt76->chainmask = tx_ant;
+	phy->mt76->antenna_mask = (tx_ant >> shift) & phy->orig_antenna_mask;
 
 	mt76_set_stream_caps(phy->mt76, true);
 	mt7915_set_stream_vht_txbf_caps(phy);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index b5c06201b707..69fdedaa61fb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -208,6 +208,8 @@ struct mt7915_phy {
 	u8 throttle_state;
 	u32 throttle_temp[2]; /* 0: critical high, 1: maximum */
 
+	u8 orig_antenna_mask;
+
 	u32 rxfilter;
 	u64 omac_mask;
 
-- 
2.43.0


