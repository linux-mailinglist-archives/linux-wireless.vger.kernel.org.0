Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABF9242BC5
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Aug 2020 17:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgHLPBK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Aug 2020 11:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbgHLPBA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Aug 2020 11:01:00 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42921C061383
        for <linux-wireless@vger.kernel.org>; Wed, 12 Aug 2020 08:01:00 -0700 (PDT)
Received: from [149.224.82.90] (helo=localhost.localdomain)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1k5sFN-0002OP-SK; Wed, 12 Aug 2020 17:00:57 +0200
From:   John Crispin <john@phrozen.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        John Crispin <john@phrozen.org>
Subject: [PATCH V3 4/9] mac80211: add multiple bssid/ema support to bcn templating
Date:   Wed, 12 Aug 2020 17:00:45 +0200
Message-Id: <20200812150050.2683396-5-john@phrozen.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200812150050.2683396-1-john@phrozen.org>
References: <20200812150050.2683396-1-john@phrozen.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Extend ieee80211_beacon_get_template() to allow generation of EMA beacons.
Drivers for hardware that does not support ema offloading can use this
function to update their becaons after they receive beacon completion
events from the hardware.

Signed-off-by: John Crispin <john@phrozen.org>
---
 include/net/mac80211.h     | 27 +++++++++++++++++++++
 net/mac80211/ieee80211_i.h |  1 +
 net/mac80211/tx.c          | 49 ++++++++++++++++++++++++++++++++++----
 3 files changed, 73 insertions(+), 4 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index a2145092697f..5b2fa0b3b34c 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -4792,12 +4792,17 @@ void ieee80211_report_low_ack(struct ieee80211_sta *sta, u32 num_packets);
  * @cntdwn_counter_offs: array of IEEE80211_MAX_CNTDWN_COUNTERS_NUM offsets
  *	to countdown counters.  This array can contain zero values which
  *	should be ignored.
+ * @multiple_bssid_offset: position of the multiple bssid element
+ * @multiple_bssid_length: size of the multiple bssid element
  */
 struct ieee80211_mutable_offsets {
 	u16 tim_offset;
 	u16 tim_length;
 
 	u16 cntdwn_counter_offs[IEEE80211_MAX_CNTDWN_COUNTERS_NUM];
+
+	u16 multiple_bssid_offset;
+	u16 multiple_bssid_length;
 };
 
 /**
@@ -4824,6 +4829,28 @@ ieee80211_beacon_get_template(struct ieee80211_hw *hw,
 			      struct ieee80211_vif *vif,
 			      struct ieee80211_mutable_offsets *offs);
 
+/**
+ * ieee80211_beacon_get_template - beacon template generation function
+ * @hw: pointer obtained from ieee80211_alloc_hw().
+ * @vif: &struct ieee80211_vif pointer from the add_interface callback.
+ * @offs: &struct ieee80211_mutable_offsets pointer to struct that will
+ *	receive the offsets that may be updated by the driver.
+ *
+ * This function differs from ieee80211_beacon_get_template in the sense that
+ * it generates EMA VAP templates. When we use multiple_bssid, the beacons can
+ * get very large costing a lot of airtime. To work around this, we iterate
+ * over the multiple bssid elements and only send one inside the beacon for 1..n.
+ *
+ * This function needs to follow the same rules as ieee80211_beacon_get_template
+ *
+ * Return: The beacon template. %NULL on error.
+ */
+
+struct sk_buff *
+ieee80211_beacon_get_template_ema(struct ieee80211_hw *hw,
+				  struct ieee80211_vif *vif,
+				  struct ieee80211_mutable_offsets *offs);
+
 /**
  * ieee80211_beacon_get_tim - beacon generation function
  * @hw: pointer obtained from ieee80211_alloc_hw().
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 016bed63e74e..33f1cf33fb54 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -269,6 +269,7 @@ struct beacon_data {
 	u16 cntdwn_counter_offsets[IEEE80211_MAX_CNTDWN_COUNTERS_NUM];
 	u8 cntdwn_current_counter;
 	struct cfg80211_multiple_bssid_data multiple_bssid;
+	u16 ema_index;
 	struct rcu_head rcu_head;
 };
 
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 481dd7cc36d3..95c2593437ca 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -4735,11 +4735,26 @@ static int ieee80211_beacon_protect(struct sk_buff *skb,
 	return 0;
 }
 
+static void
+ieee80211_beacon_add_multiple_bssid_config(struct ieee80211_vif *vif, struct sk_buff *skb,
+					   struct cfg80211_multiple_bssid_data *config)
+{
+	u8 *pos = skb_put(skb, 6);
+
+	*pos++ = WLAN_EID_EXTENSION;
+	*pos++ = 4;
+	*pos++ = WLAN_EID_EXT_MULTIPLE_BSSID_CONFIGURATION;
+	*pos++ = 2;
+	*pos++ = vif->bss_conf.multiple_bssid.count;
+	*pos++ = config->cnt;
+}
+
 static struct sk_buff *
 __ieee80211_beacon_get(struct ieee80211_hw *hw,
 		       struct ieee80211_vif *vif,
 		       struct ieee80211_mutable_offsets *offs,
-		       bool is_template)
+		       bool is_template,
+		       bool is_ema)
 {
 	struct ieee80211_local *local = hw_to_local(hw);
 	struct beacon_data *beacon = NULL;
@@ -4767,6 +4782,8 @@ __ieee80211_beacon_get(struct ieee80211_hw *hw,
 
 		beacon = rcu_dereference(ap->beacon);
 		if (beacon) {
+			int ema_len = 0;
+
 			if (beacon->cntdwn_counter_offsets[0]) {
 				if (!is_template)
 					ieee80211_beacon_update_cntdwn(vif);
@@ -4774,6 +4791,9 @@ __ieee80211_beacon_get(struct ieee80211_hw *hw,
 				ieee80211_set_beacon_cntdwn(sdata, beacon);
 			}
 
+			if (is_ema && beacon->multiple_bssid.cnt)
+				ema_len = beacon->multiple_bssid.len[beacon->ema_index];
+
 			/*
 			 * headroom, head length,
 			 * tail length and maximum TIM length
@@ -4781,7 +4801,8 @@ __ieee80211_beacon_get(struct ieee80211_hw *hw,
 			skb = dev_alloc_skb(local->tx_headroom +
 					    beacon->head_len +
 					    beacon->tail_len + 256 +
-					    local->hw.extra_beacon_tailroom);
+					    local->hw.extra_beacon_tailroom +
+					    ema_len);
 			if (!skb)
 				goto out;
 
@@ -4800,6 +4821,17 @@ __ieee80211_beacon_get(struct ieee80211_hw *hw,
 				csa_off_base = skb->len;
 			}
 
+			if (ema_len) {
+				ieee80211_beacon_add_multiple_bssid_config(vif, skb,
+									   &beacon->multiple_bssid);
+				skb_put_data(skb, beacon->multiple_bssid.ies[beacon->ema_index],
+					     beacon->multiple_bssid.len[beacon->ema_index]);
+				if (offs)
+					offs->multiple_bssid_offset = skb->len - ema_len;
+				beacon->ema_index++;
+				beacon->ema_index %= beacon->multiple_bssid.cnt;
+			}
+
 			if (beacon->tail)
 				skb_put_data(skb, beacon->tail,
 					     beacon->tail_len);
@@ -4928,16 +4960,25 @@ ieee80211_beacon_get_template(struct ieee80211_hw *hw,
 			      struct ieee80211_vif *vif,
 			      struct ieee80211_mutable_offsets *offs)
 {
-	return __ieee80211_beacon_get(hw, vif, offs, true);
+	return __ieee80211_beacon_get(hw, vif, offs, true, false);
 }
 EXPORT_SYMBOL(ieee80211_beacon_get_template);
 
+struct sk_buff *
+ieee80211_beacon_get_template_ema(struct ieee80211_hw *hw,
+				  struct ieee80211_vif *vif,
+				  struct ieee80211_mutable_offsets *offs)
+{
+	return __ieee80211_beacon_get(hw, vif, offs, true, true);
+}
+EXPORT_SYMBOL(ieee80211_beacon_get_template_ema);
+
 struct sk_buff *ieee80211_beacon_get_tim(struct ieee80211_hw *hw,
 					 struct ieee80211_vif *vif,
 					 u16 *tim_offset, u16 *tim_length)
 {
 	struct ieee80211_mutable_offsets offs = {};
-	struct sk_buff *bcn = __ieee80211_beacon_get(hw, vif, &offs, false);
+	struct sk_buff *bcn = __ieee80211_beacon_get(hw, vif, &offs, false, false);
 	struct sk_buff *copy;
 	struct ieee80211_supported_band *sband;
 	int shift;
-- 
2.25.1

