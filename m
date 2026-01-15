Return-Path: <linux-wireless+bounces-30851-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C1656D292C6
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 00:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DDCDD304B4D1
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Jan 2026 23:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364443101B4;
	Thu, 15 Jan 2026 23:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t32smtp-sign002.email header.i=@t32smtp-sign002.email header.b="iHuBXemt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail56.out.titan.email (mail56.out.titan.email [209.209.25.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23D731A7F7
	for <linux-wireless@vger.kernel.org>; Thu, 15 Jan 2026 23:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.209.25.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768518327; cv=none; b=Np2X/Sgqdr0ijDYwpvp8dWrHGQtB85kgHAIqXRjTJMH/Lj5fejjbpOqRMfGOmt+ghkhx6QUf7SmsvwvpoRKRMpNCId+U2BIfZe6FC0XveeXshkYQXlpuFpkczrkcSMhVhtkNu5V7cl9rNPxscKA/sMX9+kZam/ZxPZUL0QPyrFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768518327; c=relaxed/simple;
	bh=YwmKoAkdTAKIMOgN2uTW3TH3/f4t+bcBoxpEwoNJe9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TeNXEEbT9Nc1tqq0MlECbZ975EqHZ4WKZAJPrmHu1Z9mq2c5N4k6vaXl/AkO3KnipsFJtio/gdHtja0exfejiJYH+US4ddcgIw02dxBy4cxEQatC2pyKU5gXsZMy8MIYvfcDX5NH+pKNgsTJPCpn+0X+G2/n2LSWyFMzsWK7b2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=justthetip.ca; spf=pass smtp.mailfrom=justthetip.ca; dkim=pass (1024-bit key) header.d=t32smtp-sign002.email header.i=@t32smtp-sign002.email header.b=iHuBXemt; arc=none smtp.client-ip=209.209.25.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=justthetip.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justthetip.ca
Received: from localhost (localhost [127.0.0.1])
	by smtp-out.flockmail.com (Postfix) with ESMTP id 4dsdqn0BCXz9rwd;
	Thu, 15 Jan 2026 23:05:25 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=cjkBafFbBmMQUcxZvG0jspd6n5DeCWoUh4SJiiYLVDo=;
	c=relaxed/relaxed; d=t32smtp-sign002.email;
	h=references:mime-version:cc:subject:to:message-id:from:date:in-reply-to:from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
	q=dns/txt; s=titan1; t=1768518324; v=1;
	b=iHuBXemtUtPn8u3v7RVk5XXdswbWLqgXzNuYTtrnSnqqfPrIhAYDvKoU2mlpC6OhED7ciYlt
	w5ucddjkR0biQvhKjQPljVDKTzpInXMZopnENC0QUHtQnaGUSikkpHMsyr14h1uK/NIahCMtaTi
	LFfwVwHIP9fixFMINY8J6FLk=
Received: from fedora (unknown [94.156.148.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp-out.flockmail.com (Postfix) with ESMTPSA id 4dsdql5knJz9rwN;
	Thu, 15 Jan 2026 23:05:23 +0000 (UTC)
Feedback-ID: :lucid_duck@justthetip.ca:justthetip.ca:flockmailId
From: Lucid Duck <lucid_duck@justthetip.ca>
To: nbd@nbd.name,
	lorenzo.bianconi83@gmail.com
Cc: linux-wireless@vger.kernel.org,
	lucid_duck@justthetip.ca
Subject: [PATCH 2/3] wifi: mt76: mt7921: convert to MLO callbacks and fix txpower reporting
Date: Thu, 15 Jan 2026 15:02:51 -0800
Message-ID: <20260115230252.43391-3-lucid_duck@justthetip.ca>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115230252.43391-1-lucid_duck@justthetip.ca>
References: <20260115230252.43391-1-lucid_duck@justthetip.ca>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1768518324835501919.13754.6597062167564737560@prod-use1-smtp-out1003.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=TPG/S0la c=1 sm=1 tr=0 ts=696972b4
	a=rfUqlbiNABtMf1sfwYNRFA==:117 a=rfUqlbiNABtMf1sfwYNRFA==:17
	a=CEWIc4RMnpUA:10 a=ThxqNdz_AAAA:8 a=YFdQBhzBV15eEDGu7wwA:9
	a=X5WbqfxFh8zCdCUNm0Nt:22

Kernel 6.18's mac80211 MLO support requires splitting bss_info_changed
into vif_cfg_changed (VIF-wide) and link_info_changed (per-link).

Additionally, handle the case where bss_conf.txpower is not populated
(INT_MIN) when the interface is unassociated. This is intentional
mac80211 behavior - __ieee80211_recalc_txpower() returns early when
chanctx_conf is NULL.

When bss_conf.txpower is unset, fall back to the channel's regulatory
maximum for REPORTING purposes. This does NOT change actual RF power
(controlled by firmware) - only nl80211 reporting accuracy.

Changes:
- Split bss_info_changed into vif_cfg_changed + link_info_changed
- Route VIF-wide changes (ASSOC, PS, ARP_FILTER) to vif_cfg_changed
- Route per-link changes (ERP_SLOT, BEACON, TXPOWER) to link_info_changed
- Handle unset txpower gracefully for unassociated interfaces

Tested on Alfa AWUS036AXML (MT7921AU):
- Kernel 6.18.3 (Kali): Associated and unassociated tests pass
- Kernel 6.18.4 (Fedora): Associated and unassociated tests pass

Signed-off-by: Lucid Duck <lucid_duck@justthetip.ca>
---
 mt7921/main.c | 84 +++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 64 insertions(+), 20 deletions(-)

diff --git a/mt7921/main.c b/mt7921/main.c
index 66051b0..391fafe 100644
--- a/mt7921/main.c
+++ b/mt7921/main.c
@@ -371,7 +371,7 @@ void mt7921_roc_abort_sync(struct mt792x_dev *dev)
 {
 	struct mt792x_phy *phy = &dev->phy;
 
-	del_timer_sync(&phy->roc_timer);
+	timer_delete_sync(&phy->roc_timer);
 	cancel_work_sync(&phy->roc_work);
 	if (test_and_clear_bit(MT76_STATE_ROC, &phy->mt76->state))
 		ieee80211_iterate_interfaces(mt76_hw(dev),
@@ -402,7 +402,7 @@ static int mt7921_abort_roc(struct mt792x_phy *phy, struct mt792x_vif *vif)
 {
 	int err = 0;
 
-	del_timer_sync(&phy->roc_timer);
+	timer_delete_sync(&phy->roc_timer);
 	cancel_work_sync(&phy->roc_work);
 
 	mt792x_mutex_acquire(phy->dev);
@@ -687,10 +687,49 @@ static void mt7921_configure_filter(struct ieee80211_hw *hw,
 	*total_flags &= (FIF_OTHER_BSS | FIF_FCSFAIL | FIF_CONTROL);
 }
 
-static void mt7921_bss_info_changed(struct ieee80211_hw *hw,
-				    struct ieee80211_vif *vif,
-				    struct ieee80211_bss_conf *info,
-				    u64 changed)
+/*
+ * mt7921_vif_cfg_changed - handle VIF-wide configuration changes
+ *
+ * In kernel 6.18+, mac80211 splits bss_info_changed into vif_cfg_changed
+ * (VIF-wide) and link_info_changed (per-link). This handles VIF-wide changes.
+ */
+static void mt7921_vif_cfg_changed(struct ieee80211_hw *hw,
+				   struct ieee80211_vif *vif,
+				   u64 changed)
+{
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+
+	mt792x_mutex_acquire(dev);
+
+	if (changed & BSS_CHANGED_PS)
+		mt7921_mcu_uni_bss_ps(dev, vif);
+
+	if (changed & BSS_CHANGED_ASSOC) {
+		mt7921_mcu_sta_update(dev, NULL, vif, true,
+				      MT76_STA_INFO_STATE_ASSOC);
+		mt7921_mcu_set_beacon_filter(dev, vif, vif->cfg.assoc);
+	}
+
+	if (changed & BSS_CHANGED_ARP_FILTER) {
+		struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+
+		mt76_connac_mcu_update_arp_filter(&dev->mt76, &mvif->bss_conf.mt76,
+						  &vif->bss_conf);
+	}
+
+	mt792x_mutex_release(dev);
+}
+
+/*
+ * mt7921_link_info_changed - handle per-link BSS information changes
+ *
+ * In kernel 6.18+, mac80211 uses link_info_changed callback for per-link
+ * BSS changes including TX power, ERP slot, beacon, QOS, etc.
+ */
+static void mt7921_link_info_changed(struct ieee80211_hw *hw,
+				     struct ieee80211_vif *vif,
+				     struct ieee80211_bss_conf *info,
+				     u64 changed)
 {
 	struct mt792x_phy *phy = mt792x_hw_phy(hw);
 	struct mt792x_dev *dev = mt792x_hw_dev(hw);
@@ -715,23 +754,27 @@ static void mt7921_bss_info_changed(struct ieee80211_hw *hw,
 	if (changed & (BSS_CHANGED_QOS | BSS_CHANGED_BEACON_ENABLED))
 		mt7921_mcu_set_tx(dev, vif);
 
-	if (changed & BSS_CHANGED_PS)
-		mt7921_mcu_uni_bss_ps(dev, vif);
-
 	if (changed & BSS_CHANGED_CQM)
 		mt7921_mcu_set_rssimonitor(dev, vif);
 
-	if (changed & BSS_CHANGED_ASSOC) {
-		mt7921_mcu_sta_update(dev, NULL, vif, true,
-				      MT76_STA_INFO_STATE_ASSOC);
-		mt7921_mcu_set_beacon_filter(dev, vif, vif->cfg.assoc);
-	}
+	if (changed & BSS_CHANGED_TXPOWER) {
+		int tx_power = info->txpower;
 
-	if (changed & BSS_CHANGED_ARP_FILTER) {
-		struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+		/*
+		 * Workaround for kernel 6.18+: bss_conf.txpower may not be
+		 * populated (INT_MIN) even when BSS_CHANGED_TXPOWER is set.
+		 * In this case, use the channel's max regulatory power.
+		 */
+		if (tx_power == INT_MIN || tx_power <= 0) {
+			struct ieee80211_channel *chan = phy->mt76->chandef.chan;
 
-		mt76_connac_mcu_update_arp_filter(&dev->mt76, &mvif->bss_conf.mt76,
-						  info);
+			if (chan)
+				tx_power = chan->max_reg_power;
+		}
+
+		/* txpower is in dBm, txpower_cur is in 0.5dBm units */
+		if (tx_power > 0 && tx_power < 127)
+			phy->mt76->txpower_cur = tx_power * 2;
 	}
 
 	mt792x_mutex_release(dev);
@@ -1494,7 +1537,7 @@ static void mt7921_abort_channel_switch(struct ieee80211_hw *hw,
 {
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 
-	del_timer_sync(&mvif->csa_timer);
+	timer_delete_sync(&mvif->csa_timer);
 	cancel_work_sync(&mvif->csa_work);
 }
 
@@ -1535,7 +1578,8 @@ const struct ieee80211_ops mt7921_ops = {
 	.config = mt7921_config,
 	.conf_tx = mt792x_conf_tx,
 	.configure_filter = mt7921_configure_filter,
-	.bss_info_changed = mt7921_bss_info_changed,
+	.vif_cfg_changed = mt7921_vif_cfg_changed,
+	.link_info_changed = mt7921_link_info_changed,
 	.start_ap = mt7921_start_ap,
 	.stop_ap = mt7921_stop_ap,
 	.sta_state = mt7921_sta_state,
-- 
2.52.0


