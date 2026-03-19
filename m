Return-Path: <linux-wireless+bounces-33512-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBc1EedgvGlxxQIAu9opvQ
	(envelope-from <linux-wireless+bounces-33512-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 21:47:35 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EFF02D25CF
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 21:47:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB8C6315E478
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 20:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513593F7A86;
	Thu, 19 Mar 2026 20:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b="w5aW9Ald"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92423A63F6
	for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 20:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773952784; cv=none; b=r08cA3LgF/ORqHzUBGritMBZbanmkgvSp1s7oPw3+9+GzClcyMKoHyLTcSxcfOYFm/UsD4fcslj+b8JIEO21nFxfcCnazBlM+birs64gAmXX0O6x2zODrJXTRGqzcviBVItfDLPoW8w8CBRDfgxeNpBiiwccBhFyNZrGcKUz0jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773952784; c=relaxed/simple;
	bh=AAaWsMidyTXPKg0XjqzCwQXP2HbpDF9J7jvc5kDMbzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BzxQOsWjwIxDt+4nyg4z4m5foKaR7cuYCwccu2lZXAeXDnOJU+0vw65o679jbI+HJLRJpt9KNjp+R4ZxQJumTFXe181zRgEzFclXGyutoEYrPWCS5BHBI6rEkEmEMBOT9+aA9zOeTVtmOPCeNh+QFEG419hiDtZ9MVhBTvOJ2js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca; spf=pass smtp.mailfrom=justthetip.ca; dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b=w5aW9Ald; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justthetip.ca
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=justthetip.ca;
	s=key1; t=1773952779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eaWYm+Ogi+l2RIh2pnwzTgW1KAd3MUkqgb1vx7KhlRU=;
	b=w5aW9AldFPWHFL45KWDzamzXf7XNc5HY9Iqr2yV5WIzonrrcHpCd0wvlZvkeBH8atuJAfO
	sNFNqIuw/FPBlUHmmKWX9WL5OWpmKGd9uAGvJ98jU52zhpJud7B335R5VBXy84/vvhQb/9
	YitnH9sqS4z9R1gUY/lhm9OVLnOHSKh3jgkVII9Y9t4eotMED2T4oTJqzeGz5FEnTnjIQE
	Ra/n+WL2Qh8AFOCigmxmOqteJPwD/rlFYWQhh8LIUb6TyIOqSRTcKbmS4wEBpqRdcolo2R
	YWhO+8YaBOAYKHzuTXrX+9s+OihAXJl5zujEp5qSPyDeMLlNIQKJ40wU/Jb++Q==
From: Lucid Duck <lucid_duck@justthetip.ca>
To: Sean Wang <sean.wang@kernel.org>
Cc: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	morrownr@gmail.com,
	Lucid Duck <lucid_duck@justthetip.ca>,
	stable@vger.kernel.org
Subject: [PATCH v4] wifi: mt76: mt7921: fix txpower reporting from rate power configuration
Date: Thu, 19 Mar 2026 13:38:54 -0700
Message-ID: <20260319203854.30479-1-lucid_duck@justthetip.ca>
In-Reply-To: <CAGp9LzqLbdEb25ocObMMuFPZitrL-UnC7uhaLOkYQN=TgSTmnA@mail.gmail.com>
References: <CAGp9LzqLbdEb25ocObMMuFPZitrL-UnC7uhaLOkYQN=TgSTmnA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[justthetip.ca,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[justthetip.ca:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nbd.name,kernel.org,vger.kernel.org,lists.infradead.org,gmail.com,justthetip.ca];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33512-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[justthetip.ca:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucid_duck@justthetip.ca,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.834];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sku_tlbv.channel:url,justthetip.ca:dkim,justthetip.ca:email,justthetip.ca:mid]
X-Rspamd-Queue-Id: 9EFF02D25CF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The mt7921 driver never updates phy->txpower_cur from the rate power
configuration sent to firmware, causing mt76_get_txpower() to report
bogus values to userspace (typically 3 dBm) regardless of actual
regulatory or SAR limits.

Two issues are addressed:

1. The rate power loop in mt76_connac_mcu_rate_txpower_band() computes
   the correct bounded TX power per channel via
   mt76_get_rate_power_limits() but discards the return value. Capture
   it and store to phy->txpower_cur when processing the current
   channel, matching how mt7915 handles this in
   mt7915_mcu_set_txpower_sku(). Subtract the multi-chain path delta
   before storing, since mt76_get_txpower() adds it back when
   reporting -- consistent with mt7915's use of mt76_get_power_bound()
   which performs the same subtraction.

2. mt7921 uses the chanctx model but its add_chanctx callback does not
   update phy->chandef, leaving it stale after association. The rate
   power loop's channel comparison then fails silently. Sync
   phy->chandef from ctx->def in add_chanctx and change_chanctx, and
   recompute txpower_cur via a lightweight helper that performs the
   same bounded power calculation for the current channel without
   reprogramming firmware rate tables.

Tested on Alfa AWUS036AXML (MT7921AU), kernel 6.19.8, Canada:

  Before: iw dev wlan0 info shows "txpower 3.00 dBm" (wrong)
  After:  2.4GHz 36 dBm, 5GHz 23 dBm, 6GHz 12 dBm (match regulatory)

Cc: stable@vger.kernel.org
Fixes: 1c099ab44727 ("mt76: mt7921: add MAC support")
Signed-off-by: Lucid Duck <lucid_duck@justthetip.ca>
---
Changes since v3:
- Removed mt7921_set_tx_sar_pwr() from add_chanctx and change_chanctx.
  Channel transitions don't change underlying power constraints, so
  reprogramming the full rate table is unnecessary. Replaced with a
  lightweight helper that recomputes txpower_cur locally.
- Removed IEEE80211_CONF_CHANGE_CHANNEL trigger from config().
- Removed BSS_CHANGED_TXPOWER handler from bss_info_changed(). Writing
  per-vif txpower into per-HW hw->conf.power_level breaks multi-vif
  semantics. User txpower limits need a different approach (follow-up).
- Subtracted path delta before storing txpower_cur. The connac rate
  loop stores total bounded power, but mt76_get_txpower() adds the
  multi-chain path delta when reporting. mt7915 accounts for this via
  mt76_get_power_bound(), which subtracts the delta before storing.
  Without the same subtraction, reported values were inflated by 3 dBm
  on 2x2 devices.

 .../wireless/mediatek/mt76/mt76_connac_mcu.c  | 14 +++++++--
 .../net/wireless/mediatek/mt76/mt7921/main.c  | 30 +++++++++++++++++++
 2 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 16db0f208..e26a2cb39 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -2193,14 +2193,22 @@ mt76_connac_mcu_rate_txpower_band(struct mt76_phy *phy,
 				.hw_value = ch_list[idx],
 				.band = band,
 			};
-			s8 reg_power, sar_power;
+			s8 reg_power, sar_power, max_power;
 
 			reg_power = mt76_connac_get_ch_power(phy, &chan,
 							     tx_power);
 			sar_power = mt76_get_sar_power(phy, &chan, reg_power);
 
-			mt76_get_rate_power_limits(phy, &chan, limits,
-						   sar_power);
+			max_power = mt76_get_rate_power_limits(phy, &chan,
+							       limits,
+							       sar_power);
+
+			if (phy->chandef.chan &&
+			    phy->chandef.chan->hw_value == ch_list[idx] &&
+			    phy->chandef.chan->band == band)
+				phy->txpower_cur = max_power -
+					mt76_tx_power_path_delta(
+						hweight16(phy->chainmask));
 
 			tx_power_tlv.last_msg = ch_list[idx] == last_ch;
 			sku_tlbv.channel = ch_list[idx];
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 5881040ac..a77ae5791 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -1355,13 +1355,39 @@ mt7921_stop_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	mt792x_mutex_release(dev);
 }
 
+static void mt7921_update_txpower_cur(struct mt76_phy *phy)
+{
+	struct mt76_power_limits limits;
+	struct ieee80211_channel *chan = phy->chandef.chan;
+	int n_chains = hweight16(phy->chainmask);
+	s8 reg_power, sar_power, max_power;
+	int tx_power;
+
+	if (!chan)
+		return;
+
+	tx_power = 2 * phy->hw->conf.power_level;
+	if (!tx_power)
+		tx_power = 127;
+
+	reg_power = mt76_connac_get_ch_power(phy, chan, tx_power);
+	sar_power = mt76_get_sar_power(phy, chan, reg_power);
+	max_power = mt76_get_rate_power_limits(phy, chan, &limits, sar_power);
+
+	phy->txpower_cur = max_power - mt76_tx_power_path_delta(n_chains);
+}
+
 static int
 mt7921_add_chanctx(struct ieee80211_hw *hw,
 		   struct ieee80211_chanctx_conf *ctx)
 {
 	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+	struct mt76_phy *mphy = hw->priv;
 
 	dev->new_ctx = ctx;
+	mphy->chandef = ctx->def;
+	mt7921_update_txpower_cur(mphy);
+
 	return 0;
 }
 
@@ -1396,6 +1422,10 @@ mt7921_change_chanctx(struct ieee80211_hw *hw,
 		mt7921_mcu_config_sniffer(mvif, ctx);
 	else
 		mt76_connac_mcu_uni_set_chctx(mvif->phy->mt76, &mvif->bss_conf.mt76, ctx);
+
+	phy->mt76->chandef = ctx->def;
+	mt7921_update_txpower_cur(phy->mt76);
+
 	mt792x_mutex_release(phy->dev);
 }
 
-- 
2.53.0


