Return-Path: <linux-wireless+bounces-33354-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEqUEU6QuWk5KQIAu9opvQ
	(envelope-from <linux-wireless+bounces-33354-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 18:33:02 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B5E2AFC7D
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 18:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CCCD2303EF9E
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 17:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4319637998A;
	Tue, 17 Mar 2026 17:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b="KEYfGPXh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C9D1A6820
	for <linux-wireless@vger.kernel.org>; Tue, 17 Mar 2026 17:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773768632; cv=none; b=j5aBNlNNCpRph2uSidYUSmzGQEiaG3wpFgJgr/HbKEhtl2n96fvJ1E3AzZ22FxowB+tBEfN8SOF0+x2z2Ep7C0o7DV8KGu7+jVtzDfYVRsyqZhQcDtsKTtBRkfi76KW7yzl+K5kh+KMGhfptej4xeNac+53PM4tshx4by22Hb+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773768632; c=relaxed/simple;
	bh=ZLM8JlT4gWHzo6JpQLH/igkQh2XIDLodYhACrufzsq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FMU4RbP7zyxZpgXaVUD2C26Z26I3wMwmhZ6imgJqHTTw00V9RHFAYUceTQYwSj3HJ2j+Af8nILrcFI1rCh+wVD52Ffkf4nROUy6I7m+KEiYo7j/9ZYi1KR33mPrdEqabCkk8Zh87WEYMHJwM4S0626IbFIpirE29B4cOFQOMUnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca; spf=pass smtp.mailfrom=justthetip.ca; dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b=KEYfGPXh; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justthetip.ca
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=justthetip.ca;
	s=key1; t=1773768628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y1Sa/OI14235f1o3BnTehycDoIrodctjm5BQzxUDkn0=;
	b=KEYfGPXhOTukL2f/O139Z4+EwlxumRNfGlocS2yKOwqsdK2I7vXICDP/na3srp+ARKhSx4
	+8XQy1//DHXr8tPZV/0jT2P8/Sg34A5DrP5ApZjI1F01iqwNv3W9aZdHeIAGEJTrWJl52R
	t+c6Qip6VebFt83TFRyGRwUub1DG5dmjVbh7I+U5WIaCEzOBr5mZceDZ6wOsobW0KrYJZy
	T0dbwsUeGxaYw+e77Ef87KY1vS+MOG0dAS4g6j77mvd1aiB8cgqo6fg2DzNCoDeLd+2Ejs
	HiE+P3Tvgsx2v//p/mrc2HM7LBwKi2PfgTaRXisK5/Bx+0IMYo91bLVSN0/HHw==
From: Lucid Duck <lucid_duck@justthetip.ca>
To: linux-wireless@vger.kernel.org
Cc: nbd@nbd.name,
	sean.wang@kernel.org,
	lorenzo@kernel.org,
	linux-mediatek@lists.infradead.org,
	morrownr@gmail.com,
	Lucid Duck <lucid_duck@justthetip.ca>
Subject: [PATCH v3 1/1] wifi: mt76: mt7921: fix txpower reporting from rate power configuration
Date: Tue, 17 Mar 2026 10:30:16 -0700
Message-ID: <20260317173016.136975-2-lucid_duck@justthetip.ca>
In-Reply-To: <20260317173016.136975-1-lucid_duck@justthetip.ca>
References: <20260317173016.136975-1-lucid_duck@justthetip.ca>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[justthetip.ca:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nbd.name,kernel.org,lists.infradead.org,gmail.com,justthetip.ca];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33354-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[justthetip.ca:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucid_duck@justthetip.ca,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sku_tlbv.channel:url,justthetip.ca:dkim,justthetip.ca:email,justthetip.ca:mid]
X-Rspamd-Queue-Id: 86B5E2AFC7D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The mt7921 driver never updates phy->txpower_cur
when TX power rate configuration is sent to firmware. This causes
mt76_get_txpower() to report bogus values to userspace (typically
3 dBm) regardless of actual regulatory or SAR limits. User-set
txpower limits via iw are also not reflected.

Three root causes are addressed:

1. The rate power loop in mt76_connac_mcu_rate_txpower_band() computes
   the correct bounded TX power for each channel but discards the return
   value of mt76_get_rate_power_limits(). Fix: capture the return value
   and store it to phy->txpower_cur when processing the current channel.

2. mt7921 uses the chanctx model but its add_chanctx callback bypasses
   the common mt76_phy_update_channel(), leaving phy->chandef stale.
   Fix: update phy->chandef from ctx->def in both add_chanctx and
   change_chanctx, and trigger the rate power path to refresh
   txpower_cur. Also trigger on IEEE80211_CONF_CHANGE_CHANNEL in
   config(), matching mt7915.

3. For chanctx drivers, mac80211 routes user txpower changes through
   BSS_CHANGED_TXPOWER in bss_info_changed() -- not through
   IEEE80211_CONF_CHANGE_POWER in config(). hw->conf.power_level is
   never updated. Fix: handle BSS_CHANGED_TXPOWER in
   mt7921_bss_info_changed(), bridge bss_conf.txpower to
   hw->conf.power_level, and re-trigger the rate power path.

Tested on Alfa AWUS036AXML (MT7921AU), kernel 6.17.1-300.fc43:

  Before: iw dev wlan0 info shows "txpower 3.00 dBm" (wrong)
  After:  correct per-band values, user limits reflected

Test results (regulatory domain: Canada/CA):
  - 2.4GHz ch6:  33 dBm (30 dBm limit + 3 dBm 2x2 path delta)
  - 5GHz ch36:   26 dBm (23 dBm limit + 3 dBm path delta)
  - 6GHz ch5:    15 dBm (12 dBm limit + 3 dBm path delta)
  - Band switch: 100 cycles, 0 failures
  - Module reload: 50 cycles, 0 failures
  - 2-hour soak: 480 samples, zero drift
  - Regdomain switching: 10 countries, all correct
  - User txpower limits: reflected on all bands
  - Monitor mode: correct on all tested channels

Signed-off-by: Lucid Duck <lucid_duck@justthetip.ca>
---
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  | 12 +++++++---
 .../net/wireless/mediatek/mt76/mt7921/main.c  | 22 ++++++++++++++++++-
 2 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 16db0f208..5856924a9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -2193,14 +2193,20 @@ mt76_connac_mcu_rate_txpower_band(struct mt76_phy *phy,
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
+				phy->txpower_cur = max_power;
 
 			tx_power_tlv.last_msg = ch_list[idx] == last_ch;
 			sku_tlbv.channel = ch_list[idx];
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 5881040ac..38a59c6f2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -638,7 +638,8 @@ static int mt7921_config(struct ieee80211_hw *hw, int radio_idx, u32 changed)
 
 	mt792x_mutex_acquire(dev);
 
-	if (changed & IEEE80211_CONF_CHANGE_POWER) {
+	if (changed & (IEEE80211_CONF_CHANGE_POWER |
+		       IEEE80211_CONF_CHANGE_CHANNEL)) {
 		ret = mt7921_set_tx_sar_pwr(hw, NULL);
 		if (ret)
 			goto out;
@@ -719,6 +720,14 @@ static void mt7921_bss_info_changed(struct ieee80211_hw *hw,
 	if (changed & BSS_CHANGED_CQM)
 		mt7921_mcu_set_rssimonitor(dev, vif);
 
+	if (changed & BSS_CHANGED_TXPOWER) {
+		int tx_power = info->txpower;
+
+		if (tx_power != INT_MIN && tx_power > 0)
+			hw->conf.power_level = tx_power;
+		mt7921_set_tx_sar_pwr(hw, NULL);
+	}
+
 	if (changed & BSS_CHANGED_ASSOC) {
 		mt7921_mcu_sta_update(dev, NULL, vif, true,
 				      MT76_STA_INFO_STATE_ASSOC);
@@ -1360,8 +1369,15 @@ mt7921_add_chanctx(struct ieee80211_hw *hw,
 		   struct ieee80211_chanctx_conf *ctx)
 {
 	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+	struct mt76_phy *mphy = hw->priv;
 
 	dev->new_ctx = ctx;
+	mphy->chandef = ctx->def;
+
+	mt792x_mutex_acquire(dev);
+	mt7921_set_tx_sar_pwr(hw, NULL);
+	mt792x_mutex_release(dev);
+
 	return 0;
 }
 
@@ -1396,6 +1412,10 @@ mt7921_change_chanctx(struct ieee80211_hw *hw,
 		mt7921_mcu_config_sniffer(mvif, ctx);
 	else
 		mt76_connac_mcu_uni_set_chctx(mvif->phy->mt76, &mvif->bss_conf.mt76, ctx);
+
+	phy->mt76->chandef = ctx->def;
+	mt7921_set_tx_sar_pwr(hw, NULL);
+
 	mt792x_mutex_release(phy->dev);
 }
 
-- 
2.51.0


