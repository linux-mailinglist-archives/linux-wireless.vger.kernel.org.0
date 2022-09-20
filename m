Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 601855BE387
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Sep 2022 12:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbiITKmL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Sep 2022 06:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbiITKlm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Sep 2022 06:41:42 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141E8FEE
        for <linux-wireless@vger.kernel.org>; Tue, 20 Sep 2022 03:40:57 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id cc5so3568410wrb.6
        for <linux-wireless@vger.kernel.org>; Tue, 20 Sep 2022 03:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=71JvCY9hgY10LiiLd71AtmPSNCGGzVdnNkKqejmhPBk=;
        b=Z+R2s0t/b/CkXejYcrJTnLcr18Jgqe6CBf8Q8bF3QAcJHVz/Zw0V650sYOQeZ2Bika
         7vQOoGEMlVWaSzQ09FX+CPvJ5d/HNYY6mhK+vfgClKL0DuQ/JEpwId8SRLgqzKQ+Tayn
         8d3scmuo+vtIt+NDpSII5aq1O7JDh7JyWX4SRwXe/n/uK0QeKZ+xIcfIeLn4mh2nYlrm
         N19vNZnXaC1EFEW+XufzBPdUJYdR8ZYRn8yuXqwOgvvBQ3QFLuthwKMlpLl/JZfod5ej
         +51GdbShqWTxncPVHCILw++49RoMRY8dBVSdGJMYcVQ9hYwP+FJ+CutwlVhHGTZydt+z
         U8TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=71JvCY9hgY10LiiLd71AtmPSNCGGzVdnNkKqejmhPBk=;
        b=MKjUKxbKsCL65fgkCzVhVj7VF37Nmfyc2EBuWXwOtfWGc6+db/Po0TqE3B7ke2bcYr
         JDX6xq6evSF1VXb/1Cw4KnlcMO/8X0Bw+r9NqH0XjcJcLDnsYShkUhgw0b6fE/2t6O6Z
         qXZrI1uJAVw45wKJJ4YO9p7QGzlTByy6oBIQ6V2B+OVfMcxeArIrOvGU0HfARFRhlUIM
         vY+MUbfBjqkqwCHkYZsm4Ap+/nPVNWgqSDnjZvcT2Z/TF6LPVwUVh/3TMrwHDVraprBX
         kt0UsFyaOWmaKCJ3T7iXM2Yvrl5m4X81Zpw9q6/EOtM2zzDS0+TgYTA6LXc1R4qWccSN
         AGCQ==
X-Gm-Message-State: ACrzQf1jMqm8kpi9Rd/2qzXMEImKOTordvQi+pemamm2DMIA+ITx0sz1
        myOtT3+2lYhjRt/+PslGxS5Fk7Bhq2aK4g==
X-Google-Smtp-Source: AMsMyM4oBFvmuDgPpXhnt1n8ileoFUS6IA3mZrTOPKi9/07F9V06Ffl9A72/tu9/f59y1Dk55CTICw==
X-Received: by 2002:adf:ff85:0:b0:228:c365:de29 with SMTP id j5-20020adfff85000000b00228c365de29mr13144541wrr.415.1663670455445;
        Tue, 20 Sep 2022 03:40:55 -0700 (PDT)
Received: from build-server.fritz.box (p200300c56f1d4500880d3dfffedefb04.dip0.t-ipconnect.de. [2003:c5:6f1d:4500:880d:3dff:fede:fb04])
        by smtp.googlemail.com with ESMTPSA id o2-20020a05600c4fc200b003a5fa79007fsm2182018wmq.7.2022.09.20.03.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 03:40:54 -0700 (PDT)
From:   Jonas Jelonek <jelonek.jonas@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net, nbd@nbd.name,
        Jonas Jelonek <jelonek.jonas@gmail.com>
Subject: [RFC v2 5/6] mac80211_hwsim: add TPC per packet support
Date:   Tue, 20 Sep 2022 12:40:31 +0200
Message-Id: <20220920104032.496697-6-jelonek.jonas@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220920104032.496697-1-jelonek.jonas@gmail.com>
References: <20220920104032.496697-1-jelonek.jonas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Enable RC_TABLE in hwsim for TPC support and replace the
ieee80211_tx_status_irqsafe calls with regular ieee80211_tx_status_ext
calls to be able to pass additional information, i.e., tx-power.
Add some variables, members and functions in both tx control and tx
status path to pass and process tx-power.

Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>
---
 drivers/net/wireless/mac80211_hwsim.c | 175 ++++++++++++++++++++++++--
 drivers/net/wireless/mac80211_hwsim.h |   1 +
 2 files changed, 168 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index df51b5b1f171..a56fb2505047 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -57,10 +57,15 @@ static bool paged_rx = false;
 module_param(paged_rx, bool, 0644);
 MODULE_PARM_DESC(paged_rx, "Use paged SKBs for RX instead of linear ones");
 
-static bool rctbl = false;
+static bool rctbl = true;
 module_param(rctbl, bool, 0444);
 MODULE_PARM_DESC(rctbl, "Handle rate control table");
 
+static int tpc = 0;
+module_param(tpc, int, 0444);
+MODULE_PARM_DESC(tpc, "Support transmit power control (TPC) (0 = no,\
+		1 = per packet, 2 = per mrr stage)");
+
 static bool support_p2p_device = true;
 module_param(support_p2p_device, bool, 0444);
 MODULE_PARM_DESC(support_p2p_device, "Support P2P-Device interface type");
@@ -196,6 +201,15 @@ static const struct ieee80211_regdomain *hwsim_world_regdom_custom[] = {
 	&hwsim_world_regdom_custom_03,
 };
 
+#define MAC80211_HWSIM_MAX_POWER 30
+
+struct ieee80211_hw_txpower_range hwsim_txpower_range = {
+	.start_idx = 0,
+	.n_levels = 31,
+	.start_pwr = 0,
+	.pwr_step = 1
+};
+
 struct hwsim_vif_priv {
 	u32 magic;
 	u8 bssid[ETH_ALEN];
@@ -1364,10 +1378,105 @@ static inline u16 trans_tx_rate_flags_ieee2hwsim(struct ieee80211_tx_rate *rate)
 	return result;
 }
 
+static inline u8
+hwsim_rate_get_vht_mcs(const struct hwsim_tx_rate *rate) {
+	return rate->idx & 0xf;
+}
+
+static inline u8
+hwsim_rate_get_vht_nss(const struct hwsim_tx_rate *rate) {
+	return (rate->idx >> 4) + 1;
+}
+
+static void trans_tx_rate_to_rate_info(const struct hwsim_tx_rate *rate,
+				       const struct hwsim_tx_rate_flag *rate_flags,
+				       struct wiphy *wiphy, u8 band,
+				       struct rate_info *rate_info)
+{
+	memset(rate_info, 0, sizeof(struct rate_info));
+
+	if (rate_flags->flags & MAC80211_HWSIM_TX_RC_MCS) { /* 802.11n */
+		rate_info->flags |= RATE_INFO_FLAGS_MCS;
+		rate_info->mcs = rate->idx;
+	} else if (rate_flags->flags & MAC80211_HWSIM_TX_RC_VHT_MCS) { /* 802.11ac */
+		rate_info->flags |= RATE_INFO_FLAGS_VHT_MCS;
+		rate_info->mcs = hwsim_rate_get_vht_mcs(rate);
+		rate_info->nss = hwsim_rate_get_vht_nss(rate);
+	} else { /* 802.11a/b/g */
+		rate_info->legacy = wiphy->bands[band]->bitrates[rate->idx].bitrate;
+		rate_info->bw = RATE_INFO_BW_20;
+		return;
+	}
+
+	if (rate_flags->flags & MAC80211_HWSIM_TX_RC_40_MHZ_WIDTH)
+		rate_info->bw = RATE_INFO_BW_40;
+	else if (rate_flags->flags & MAC80211_HWSIM_TX_RC_80_MHZ_WIDTH)
+		rate_info->bw = RATE_INFO_BW_80;
+	else if (rate_flags->flags & MAC80211_HWSIM_TX_RC_160_MHZ_WIDTH)
+		rate_info->bw = RATE_INFO_BW_160;
+	else
+		rate_info->bw = RATE_INFO_BW_20;
+
+	if (rate_flags->flags & MAC80211_HWSIM_TX_RC_SHORT_GI)
+		rate_info->flags |= RATE_INFO_FLAGS_SHORT_GI;
+}
+
+static void mac80211_hwsim_get_txpower(struct ieee80211_hw *hw,
+				       struct ieee80211_sta *sta,
+				       struct sk_buff *skb,
+				       s16 *txpower)
+{
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
+	bool tpc_per_pkt = ieee80211_hw_check(hw, SUPPORTS_TPC_PER_PACKET);
+	bool tpc_per_mrr = ieee80211_hw_check(hw, SUPPORTS_TPC_PER_MRR);
+	u8 i = 0;
+
+	if (sta && sta->rates && !info->control.skip_table &&
+	    ieee80211_hw_check(hw, SUPPORTS_RC_TABLE))
+	{
+		struct ieee80211_sta_rates *ratetbl = rcu_dereference(sta->rates);
+
+		for (; i < IEEE80211_TX_MAX_RATES; i++) {
+			int txpwr_val = -1;
+			if (info->control.rates[i].idx < 0 ||
+			    info->control.rates[i].count == 0)
+				break;
+
+			if (tpc_per_mrr)
+				txpwr_val = ratetbl->rate[i].txpower_idx;
+			else if (tpc_per_pkt)
+				txpwr_val = ratetbl->rate[0].txpower_idx;
+
+			if (txpwr_val < 0)
+				txpower[i] = MAC80211_HWSIM_MAX_POWER;
+			else
+				txpower[i] = txpwr_val;
+		}
+	} else {
+		for (; i < IEEE80211_TX_MAX_RATES; i++) {
+			int txpwr_val = -1;
+			if (info->control.rates[i].idx < 0 ||
+			    info->control.rates[i].count == 0)
+				break;
+
+			if (tpc_per_pkt || tpc_per_mrr)
+				txpwr_val = info->control.txpower_idx;
+
+			if (txpwr_val < 0)
+				txpower[i] = MAC80211_HWSIM_MAX_POWER;
+			else
+				txpower[i] = txpwr_val;
+		}
+	}
+	return;
+}
+
 static void mac80211_hwsim_tx_frame_nl(struct ieee80211_hw *hw,
 				       struct sk_buff *my_skb,
 				       int dst_portid,
-				       struct ieee80211_channel *channel)
+				       struct ieee80211_channel *channel,
+				       struct ieee80211_sta *sta,
+				       s16 *txpower)
 {
 	struct sk_buff *skb;
 	struct mac80211_hwsim_data *data = hw->priv;
@@ -1434,6 +1543,8 @@ static void mac80211_hwsim_tx_frame_nl(struct ieee80211_hw *hw,
 		tx_attempts_flags[i].flags =
 				trans_tx_rate_flags_ieee2hwsim(
 						&info->status.rates[i]);
+
+		tx_attempts[i].txpower_idx = txpower[i];
 	}
 
 	if (nla_put(skb, HWSIM_ATTR_TX_INFO,
@@ -1449,6 +1560,7 @@ static void mac80211_hwsim_tx_frame_nl(struct ieee80211_hw *hw,
 	/* We create a cookie to identify this skb */
 	cookie = atomic_inc_return(&data->pending_cookie);
 	info->rate_driver_data[0] = (void *)cookie;
+	info->rate_driver_data[1] = (void *)sta;
 	if (nla_put_u64_64bit(skb, HWSIM_ATTR_COOKIE, cookie, HWSIM_ATTR_PAD))
 		goto nla_put_failure;
 
@@ -1792,6 +1904,9 @@ static void mac80211_hwsim_tx(struct ieee80211_hw *hw,
 	struct ieee80211_hdr *hdr = (void *)skb->data;
 	struct ieee80211_chanctx_conf *chanctx_conf;
 	struct ieee80211_channel *channel;
+	struct ieee80211_tx_status status = {0};
+	struct ieee80211_rate_status rate;
+	s16 txpower[IEEE80211_TX_MAX_RATES];
 	bool ack;
 	enum nl80211_chan_width confbw = NL80211_CHAN_WIDTH_20_NOHT;
 	u32 _portid, i;
@@ -1897,6 +2012,8 @@ static void mac80211_hwsim_tx(struct ieee80211_hw *hw,
 			return;
 	}
 
+	mac80211_hwsim_get_txpower(hw, control->sta, skb, &txpower[0]);
+
 	if (skb->len >= 24 + 8 &&
 	    ieee80211_is_probe_resp(hdr->frame_control)) {
 		/* fake header transmission time */
@@ -1922,7 +2039,8 @@ static void mac80211_hwsim_tx(struct ieee80211_hw *hw,
 	_portid = READ_ONCE(data->wmediumd);
 
 	if (_portid || hwsim_virtio_enabled)
-		return mac80211_hwsim_tx_frame_nl(hw, skb, _portid, channel);
+		return mac80211_hwsim_tx_frame_nl(hw, skb, _portid, channel,
+				control->sta, &txpower[0]);
 
 	/* NO wmediumd detected, perfect medium simulation */
 	data->tx_pkts++;
@@ -1938,9 +2056,21 @@ static void mac80211_hwsim_tx(struct ieee80211_hw *hw,
 	txi->control.rates[0].count = 1;
 	txi->control.rates[1].idx = -1;
 
+	status.sta = control->sta;
+	status.info = txi;
+	status.skb = skb;
+	status.n_rates = 1;
+	rate.try_count = 1;
+	rate.tx_power_idx = txpower[0];
+
+	ieee80211_rate_get_rate_info(&txi->control.rates[0], hw->wiphy,
+				     txi->band, &rate.rate_idx);
+	status.rates = &rate;
+
 	if (!(txi->flags & IEEE80211_TX_CTL_NO_ACK) && ack)
 		txi->flags |= IEEE80211_TX_STAT_ACK;
-	ieee80211_tx_status_irqsafe(hw, skb);
+
+	ieee80211_tx_status_ext(hw, &status);
 }
 
 
@@ -2030,6 +2160,7 @@ static void mac80211_hwsim_tx_frame(struct ieee80211_hw *hw,
 {
 	struct mac80211_hwsim_data *data = hw->priv;
 	u32 _pid = READ_ONCE(data->wmediumd);
+	s16 txpower[IEEE80211_TX_MAX_RATES];
 
 	if (ieee80211_hw_check(hw, SUPPORTS_RC_TABLE)) {
 		struct ieee80211_tx_info *txi = IEEE80211_SKB_CB(skb);
@@ -2037,11 +2168,13 @@ static void mac80211_hwsim_tx_frame(struct ieee80211_hw *hw,
 				       txi->control.rates,
 				       ARRAY_SIZE(txi->control.rates));
 	}
+	mac80211_hwsim_get_txpower(hw, NULL, skb, &txpower[0]);
 
 	mac80211_hwsim_monitor_rx(hw, skb, chan);
 
 	if (_pid || hwsim_virtio_enabled)
-		return mac80211_hwsim_tx_frame_nl(hw, skb, _pid, chan);
+		return mac80211_hwsim_tx_frame_nl(hw, skb, _pid, chan,
+						  NULL, &txpower[0]);
 
 	data->tx_pkts++;
 	data->tx_bytes += skb->len;
@@ -4395,6 +4528,8 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 
 	hw->queues = 5;
 	hw->offchannel_tx_hw_queue = 4;
+	hw->txpower_ranges = &hwsim_txpower_range;
+	hw->n_txpower_ranges = 1;
 
 	ieee80211_hw_set(hw, SUPPORT_FAST_XMIT);
 	ieee80211_hw_set(hw, CHANCTX_STA_CSA);
@@ -4408,6 +4543,10 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 	ieee80211_hw_set(hw, REPORTS_TX_ACK_STATUS);
 	ieee80211_hw_set(hw, TDLS_WIDER_BW);
 	ieee80211_hw_set(hw, SUPPORTS_MULTI_BSSID);
+	if (tpc == 1)
+		ieee80211_hw_set(hw, SUPPORTS_TPC_PER_PACKET);
+	else if (tpc == 2)
+		ieee80211_hw_set(hw, SUPPORTS_TPC_PER_MRR);
 
 	if (param->mlo) {
 		hw->wiphy->flags |= WIPHY_FLAG_SUPPORTS_MLO;
@@ -4784,11 +4923,14 @@ static void hwsim_register_wmediumd(struct net *net, u32 portid)
 static int hwsim_tx_info_frame_received_nl(struct sk_buff *skb_2,
 					   struct genl_info *info)
 {
-
 	struct ieee80211_hdr *hdr;
 	struct mac80211_hwsim_data *data2;
 	struct ieee80211_tx_info *txi;
 	struct hwsim_tx_rate *tx_attempts;
+	struct hwsim_tx_rate_flag *tx_attempts_flags;
+	struct ieee80211_sta *sta;
+	struct ieee80211_tx_status status = {0};
+	struct ieee80211_rate_status rates[IEEE80211_TX_MAX_RATES];
 	u64 ret_skb_cookie;
 	struct sk_buff *skb, *tmp;
 	const u8 *src;
@@ -4801,7 +4943,8 @@ static int hwsim_tx_info_frame_received_nl(struct sk_buff *skb_2,
 	    !info->attrs[HWSIM_ATTR_FLAGS] ||
 	    !info->attrs[HWSIM_ATTR_COOKIE] ||
 	    !info->attrs[HWSIM_ATTR_SIGNAL] ||
-	    !info->attrs[HWSIM_ATTR_TX_INFO])
+	    !info->attrs[HWSIM_ATTR_TX_INFO] ||
+	    !info->attrs[HWSIM_ATTR_TX_INFO_FLAGS])
 		goto out;
 
 	src = (void *)nla_data(info->attrs[HWSIM_ATTR_ADDR_TRANSMITTER]);
@@ -4846,16 +4989,32 @@ static int hwsim_tx_info_frame_received_nl(struct sk_buff *skb_2,
 
 	tx_attempts = (struct hwsim_tx_rate *)nla_data(
 		       info->attrs[HWSIM_ATTR_TX_INFO]);
+	tx_attempts_flags = (struct hwsim_tx_rate_flag *)nla_data(
+			     info->attrs[HWSIM_ATTR_TX_INFO_FLAGS]);
+	sta = (struct ieee80211_sta *)txi->rate_driver_data[1];
 
 	/* now send back TX status */
 	txi = IEEE80211_SKB_CB(skb);
 
 	ieee80211_tx_info_clear_status(txi);
 
+	status.sta = sta;
+	status.info = txi;
+	status.skb = skb;
+	status.n_rates = 0;
+
 	for (i = 0; i < IEEE80211_TX_MAX_RATES; i++) {
+		if (tx_attempts[i].idx < 0 || tx_attempts[i].count == 0)
+			break;
+
+		trans_tx_rate_to_rate_info(&tx_attempts[i], &tx_attempts_flags[i],
+					   data2->hw->wiphy, txi->band,
+					   &rates[i].rate_idx);
+		status.n_rates++;
 		txi->status.rates[i].idx = tx_attempts[i].idx;
 		txi->status.rates[i].count = tx_attempts[i].count;
 	}
+	status.rates = &rates[0];
 
 	txi->status.ack_signal = nla_get_u32(info->attrs[HWSIM_ATTR_SIGNAL]);
 
@@ -4872,7 +5031,7 @@ static int hwsim_tx_info_frame_received_nl(struct sk_buff *skb_2,
 	if (hwsim_flags & HWSIM_TX_CTL_NO_ACK)
 		txi->flags |= IEEE80211_TX_STAT_NOACK_TRANSMITTED;
 
-	ieee80211_tx_status_irqsafe(data2->hw, skb);
+	ieee80211_tx_status_ext(data2->hw, &status);
 	return 0;
 out:
 	return -EINVAL;
diff --git a/drivers/net/wireless/mac80211_hwsim.h b/drivers/net/wireless/mac80211_hwsim.h
index 527799b2de0f..31b425216c8e 100644
--- a/drivers/net/wireless/mac80211_hwsim.h
+++ b/drivers/net/wireless/mac80211_hwsim.h
@@ -193,6 +193,7 @@ enum {
 struct hwsim_tx_rate {
 	s8 idx;
 	u8 count;
+	u8 txpower_idx;
 } __packed;
 
 /**
-- 
2.30.2

