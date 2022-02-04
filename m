Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89C094A9D15
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Feb 2022 17:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376615AbiBDQlO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Feb 2022 11:41:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233928AbiBDQlO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Feb 2022 11:41:14 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7393C061714
        for <linux-wireless@vger.kernel.org>; Fri,  4 Feb 2022 08:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=8RtYWFv8A5tN+eYb99CcKI31oeiu6BO+pgCwheViDUc=; t=1643992873; x=1645202473; 
        b=MAAhu74CCFN8WJ2U2dqaXK6Si8XX22voKzMO0iDCRHTqtQbDkAlDXkDzIKWReynlJtPHQOZy2T6
        E7acAwtum90PIbqONQLATVOvI4nskieQciLwYBg5nCKQUW4ueLSuc9V8HG2gNlvwJhlapm6osijpY
        Yau040UQWXz4E7ne8rK7vz0cB7IYhDB2K5ARBsOcVWh4azV0sE8aOhBd6/xNsYV58wKd0D8D7cMxw
        sRFkUkkLHdqXky+7GsofLfCw8FLkyDIn5d7FEP+6UyIUdSiDNjDmd7wPQ7urL/Io4mrN6KM4zPEWN
        pi283L2Qd33LH8dZt0W3fB+Mt3goLBIBOy/w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nG1e2-00EXvr-LY;
        Fri, 04 Feb 2022 17:41:10 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] mac80211_hwsim: check TX and STA bandwidth
Date:   Fri,  4 Feb 2022 17:41:06 +0100
Message-Id: <20220204174105.5026d3892bf6.Ia0cd152357a373149bab017d479ab7d5ded289c0@changeid>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Add checks to hwsim to validate that neither TX nor any
station's configured bandwidth can exceed the channel
(context) configuration previously requested.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/mac80211_hwsim.c | 90 ++++++++++++++++++++++++++-
 1 file changed, 87 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index 8d54f9face2f..1fcc2000950b 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -652,6 +652,7 @@ struct mac80211_hwsim_data {
 		      ARRAY_SIZE(hwsim_channels_6ghz)];
 
 	struct ieee80211_channel *channel;
+	enum nl80211_chan_width bw;
 	u64 beacon_int	/* beacon interval in us */;
 	unsigned int rx_filter;
 	bool started, idle, scanning;
@@ -803,6 +804,38 @@ extern int hwsim_tx_virtio(struct mac80211_hwsim_data *data,
 #define hwsim_virtio_enabled false
 #endif
 
+static int hwsim_get_chanwidth(enum nl80211_chan_width bw)
+{
+	switch (bw) {
+	case NL80211_CHAN_WIDTH_20_NOHT:
+	case NL80211_CHAN_WIDTH_20:
+		return 20;
+	case NL80211_CHAN_WIDTH_40:
+		return 40;
+	case NL80211_CHAN_WIDTH_80:
+		return 80;
+	case NL80211_CHAN_WIDTH_80P80:
+	case NL80211_CHAN_WIDTH_160:
+		return 160;
+	case NL80211_CHAN_WIDTH_5:
+		return 5;
+	case NL80211_CHAN_WIDTH_10:
+		return 10;
+	case NL80211_CHAN_WIDTH_1:
+		return 1;
+	case NL80211_CHAN_WIDTH_2:
+		return 2;
+	case NL80211_CHAN_WIDTH_4:
+		return 4;
+	case NL80211_CHAN_WIDTH_8:
+		return 8;
+	case NL80211_CHAN_WIDTH_16:
+		return 16;
+	}
+
+	return INT_MAX;
+}
+
 static void mac80211_hwsim_tx_frame(struct ieee80211_hw *hw,
 				    struct sk_buff *skb,
 				    struct ieee80211_channel *chan);
@@ -1595,7 +1628,8 @@ static void mac80211_hwsim_tx(struct ieee80211_hw *hw,
 	struct ieee80211_chanctx_conf *chanctx_conf;
 	struct ieee80211_channel *channel;
 	bool ack;
-	u32 _portid;
+	enum nl80211_chan_width confbw = NL80211_CHAN_WIDTH_20_NOHT;
+	u32 _portid, i;
 
 	if (WARN_ON(skb->len < 10)) {
 		/* Should not happen; just a sanity check for addr1 use */
@@ -1605,14 +1639,17 @@ static void mac80211_hwsim_tx(struct ieee80211_hw *hw,
 
 	if (!data->use_chanctx) {
 		channel = data->channel;
+		confbw = data->bw;
 	} else if (txi->hw_queue == 4) {
 		channel = data->tmp_chan;
 	} else {
 		chanctx_conf = rcu_dereference(txi->control.vif->chanctx_conf);
-		if (chanctx_conf)
+		if (chanctx_conf) {
 			channel = chanctx_conf->def.chan;
-		else
+			confbw = chanctx_conf->def.width;
+		} else {
 			channel = NULL;
+		}
 	}
 
 	if (WARN(!channel, "TX w/o channel - queue = %d\n", txi->hw_queue)) {
@@ -1636,6 +1673,25 @@ static void mac80211_hwsim_tx(struct ieee80211_hw *hw,
 				       txi->control.rates,
 				       ARRAY_SIZE(txi->control.rates));
 
+	for (i = 0; i < ARRAY_SIZE(txi->control.rates); i++) {
+		u16 rflags = txi->control.rates[i].flags;
+		/* initialize to data->bw for 5/10 MHz handling */
+		enum nl80211_chan_width bw = data->bw;
+
+		if (txi->control.rates[i].idx == -1)
+			break;
+
+		if (rflags & IEEE80211_TX_RC_40_MHZ_WIDTH)
+			bw = NL80211_CHAN_WIDTH_40;
+		else if (rflags & IEEE80211_TX_RC_80_MHZ_WIDTH)
+			bw = NL80211_CHAN_WIDTH_80;
+		else if (rflags & IEEE80211_TX_RC_160_MHZ_WIDTH)
+			bw = NL80211_CHAN_WIDTH_160;
+
+		if (WARN_ON(hwsim_get_chanwidth(bw) > hwsim_get_chanwidth(data->bw)))
+			return;
+	}
+
 	if (skb->len >= 24 + 8 &&
 	    ieee80211_is_probe_resp(hdr->frame_control)) {
 		/* fake header transmission time */
@@ -1935,6 +1991,7 @@ static int mac80211_hwsim_config(struct ieee80211_hw *hw, u32 changed)
 		}
 
 		data->channel = conf->chandef.chan;
+		data->bw = conf->chandef.width;
 
 		for (idx = 0; idx < ARRAY_SIZE(data->survey_data); idx++) {
 			if (data->survey_data[idx].channel &&
@@ -1946,6 +2003,7 @@ static int mac80211_hwsim_config(struct ieee80211_hw *hw, u32 changed)
 		}
 	} else {
 		data->channel = conf->chandef.chan;
+		data->bw = conf->chandef.width;
 	}
 	mutex_unlock(&data->mutex);
 
@@ -2077,12 +2135,37 @@ static void mac80211_hwsim_bss_info_changed(struct ieee80211_hw *hw,
 		wiphy_dbg(hw->wiphy, "  TX Power: %d dBm\n", info->txpower);
 }
 
+static void
+mac80211_hwsim_sta_rc_update(struct ieee80211_hw *hw,
+			     struct ieee80211_vif *vif,
+			     struct ieee80211_sta *sta,
+			     u32 changed)
+{
+	struct mac80211_hwsim_data *data = hw->priv;
+	u32 bw = U32_MAX;
+
+	switch (sta->bandwidth) {
+#define C(_bw) case IEEE80211_STA_RX_BW_##_bw: bw = _bw; break
+	C(20);
+	C(40);
+	C(80);
+	C(160);
+#undef C
+	}
+
+	WARN(bw > hwsim_get_chanwidth(data->bw),
+	     "intf %pM: bad STA %pM bandwidth %d MHz (%d) > channel config %d MHz (%d)\n",
+	     vif->addr, sta->addr, bw, sta->bandwidth,
+	     hwsim_get_chanwidth(data->bw), data->bw);
+}
+
 static int mac80211_hwsim_sta_add(struct ieee80211_hw *hw,
 				  struct ieee80211_vif *vif,
 				  struct ieee80211_sta *sta)
 {
 	hwsim_check_magic(vif);
 	hwsim_set_sta_magic(sta);
+	mac80211_hwsim_sta_rc_update(hw, vif, sta, 0);
 
 	return 0;
 }
@@ -2649,6 +2732,7 @@ static int mac80211_hwsim_tx_last_beacon(struct ieee80211_hw *hw)
 	.sta_add = mac80211_hwsim_sta_add,			\
 	.sta_remove = mac80211_hwsim_sta_remove,		\
 	.sta_notify = mac80211_hwsim_sta_notify,		\
+	.sta_rc_update = mac80211_hwsim_sta_rc_update,		\
 	.set_tim = mac80211_hwsim_set_tim,			\
 	.conf_tx = mac80211_hwsim_conf_tx,			\
 	.get_survey = mac80211_hwsim_get_survey,		\
-- 
2.34.1

