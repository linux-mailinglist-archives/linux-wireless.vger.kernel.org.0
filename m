Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB954B563E
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Feb 2022 17:30:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356377AbiBNQaT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Feb 2022 11:30:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356367AbiBNQaT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Feb 2022 11:30:19 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A9185FF0B
        for <linux-wireless@vger.kernel.org>; Mon, 14 Feb 2022 08:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=4x1Sqw+tWByIJULfq0kazHyZMMmvojgfCuF6XSLAz0o=; t=1644856211; x=1646065811; 
        b=Xyq5e6ygiVRxHMSx0PUydhX1qX9CL8k/ywwPvM20MMP9oYgfIYhkQElgJJuu0KAAHmaqoNFgFRe
        Obt9aWMbmWUAqgfKbZIXnDr+OO4vcPHyVROPYqGISe8ecni00uOs/HIpaAZeZAxC90J1CGzh1Ixhf
        vW1g/Ve1sISpn3SZ6sFQatPsKYjbyKUminIzFse8qRDS9Ji/GBYv07oStolDdZLC7Haq686IGztSz
        gdt+XNbYxeJxhNZRvyvAYwGkqD7dhakyfRmuKwvU7FF4X9HV7gNLm41mccz9F/m9XCdO5NucX3imw
        d5i3LHS1abLql1GW3ByELd2yoj2xhz0pX/Eg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nJeEq-0011mw-FM;
        Mon, 14 Feb 2022 17:30:08 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v3 01/19] mac80211_hwsim: check TX and STA bandwidth
Date:   Mon, 14 Feb 2022 17:29:48 +0100
Message-Id: <20220214173004.9fd154d2c3c2.Ia0cd152357a373149bab017d479ab7d5ded289c0@changeid>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Add checks to hwsim to validate that neither TX nor any
station's configured bandwidth can exceed the channel
(context) configuration previously requested.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/mac80211_hwsim.c | 101 +++++++++++++++++++++++++-
 1 file changed, 98 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index ac1caf659e0b..2cf328344cb5 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -654,6 +654,7 @@ struct mac80211_hwsim_data {
 		      ARRAY_SIZE(hwsim_channels_6ghz)];
 
 	struct ieee80211_channel *channel;
+	enum nl80211_chan_width bw;
 	u64 beacon_int	/* beacon interval in us */;
 	unsigned int rx_filter;
 	bool started, idle, scanning;
@@ -808,6 +809,38 @@ extern int hwsim_tx_virtio(struct mac80211_hwsim_data *data,
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
@@ -1623,7 +1656,8 @@ static void mac80211_hwsim_tx(struct ieee80211_hw *hw,
 	struct ieee80211_chanctx_conf *chanctx_conf;
 	struct ieee80211_channel *channel;
 	bool ack;
-	u32 _portid;
+	enum nl80211_chan_width confbw = NL80211_CHAN_WIDTH_20_NOHT;
+	u32 _portid, i;
 
 	if (WARN_ON(skb->len < 10)) {
 		/* Should not happen; just a sanity check for addr1 use */
@@ -1633,14 +1667,17 @@ static void mac80211_hwsim_tx(struct ieee80211_hw *hw,
 
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
@@ -1664,6 +1701,25 @@ static void mac80211_hwsim_tx(struct ieee80211_hw *hw,
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
+		if (WARN_ON(hwsim_get_chanwidth(bw) > hwsim_get_chanwidth(confbw)))
+			return;
+	}
+
 	if (skb->len >= 24 + 8 &&
 	    ieee80211_is_probe_resp(hdr->frame_control)) {
 		/* fake header transmission time */
@@ -1963,6 +2019,7 @@ static int mac80211_hwsim_config(struct ieee80211_hw *hw, u32 changed)
 		}
 
 		data->channel = conf->chandef.chan;
+		data->bw = conf->chandef.width;
 
 		for (idx = 0; idx < ARRAY_SIZE(data->survey_data); idx++) {
 			if (data->survey_data[idx].channel &&
@@ -1974,6 +2031,7 @@ static int mac80211_hwsim_config(struct ieee80211_hw *hw, u32 changed)
 		}
 	} else {
 		data->channel = conf->chandef.chan;
+		data->bw = conf->chandef.width;
 	}
 	mutex_unlock(&data->mutex);
 
@@ -2105,12 +2163,48 @@ static void mac80211_hwsim_bss_info_changed(struct ieee80211_hw *hw,
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
+	enum nl80211_chan_width confbw = NL80211_CHAN_WIDTH_20_NOHT;
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
+	if (!data->use_chanctx) {
+		confbw = data->bw;
+	} else {
+		struct ieee80211_chanctx_conf *chanctx_conf =
+			rcu_dereference(vif->chanctx_conf);
+
+		if (!WARN_ON(!chanctx_conf))
+			confbw = chanctx_conf->def.width;
+	}
+
+	WARN(bw > hwsim_get_chanwidth(confbw),
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
@@ -2677,6 +2771,7 @@ static int mac80211_hwsim_tx_last_beacon(struct ieee80211_hw *hw)
 	.sta_add = mac80211_hwsim_sta_add,			\
 	.sta_remove = mac80211_hwsim_sta_remove,		\
 	.sta_notify = mac80211_hwsim_sta_notify,		\
+	.sta_rc_update = mac80211_hwsim_sta_rc_update,		\
 	.set_tim = mac80211_hwsim_set_tim,			\
 	.conf_tx = mac80211_hwsim_conf_tx,			\
 	.get_survey = mac80211_hwsim_get_survey,		\
-- 
2.34.1

