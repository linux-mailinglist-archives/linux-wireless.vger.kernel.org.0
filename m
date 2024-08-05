Return-Path: <linux-wireless+bounces-10949-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 273679477DF
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 11:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2F741F22829
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 09:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA1C15443F;
	Mon,  5 Aug 2024 09:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="g90I4ijh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1B0153803
	for <linux-wireless@vger.kernel.org>; Mon,  5 Aug 2024 09:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722848474; cv=none; b=FGTyPzdVQV1vMPJxnPgz8feEeAZ088lDFCjGJzs3hd3kkcjSdkkWCkVQxDIHqIBlGvCJXQyhVZ9nx8sjpDf/CxNmnGO1HFkbN9JZ4nKd1CQ1R7GvZ+0l1JxJE/h6wHd16SqzquXGTAc6JqxLcAqma1BkNPY/IaZwtmca4M0LsU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722848474; c=relaxed/simple;
	bh=nTricasA2qgxspbp6AX2p1zJTnRK0vSDYnT508D4A1g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kSTyhMIBl9QwRyRUeQ76NI98AXA3kOkT20BHZpyxbswBs+WOKyd83bwGGy9URWNJWsXpKW2+HjLDhb3uf8GDKQ1Qu3kpFtG9WPzMYsipNw7rwA3NNtDuZYee0W14Fyqjo/o45OP1JaKmh3rN6dXAj7H5EcVTPBOqpaTF19uac3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=g90I4ijh; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 475919Gn83834741, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1722848469; bh=nTricasA2qgxspbp6AX2p1zJTnRK0vSDYnT508D4A1g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=g90I4ijhnI6SDC5mEiE9EB0svXMniE1Dc78H9v7IDtJb5dCNKWXBYbo0Si+HMnvbw
	 aNrbr2ry5PFPuUaadkbxLmIJtHb2N7VW11lQkW82XvIxMjDrvsclXfhD6Ae5I7oA1Q
	 FUsb8h80lH28k3yt4S5ef13KYBKtVQTZta7Y6pISipQHVefkE71783O7uHLTre4ayR
	 wGD4zuLWx7GR4OegguP+iuDE2Wme8nU614FZGju9zS/MrrreKt7s3JY2JIGTi/A36G
	 qSvQn63eS5goQwG53bwZL5FxfOMHvlvuQAICijIw641k2PR6H7b4dHYMX8E45evBMS
	 JduLrj8oUNTpA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 475919Gn83834741
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 5 Aug 2024 17:01:09 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 5 Aug 2024 17:01:09 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 5 Aug
 2024 17:01:08 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>
Subject: [PATCH 3/5] wifi: rtw89: wow: add WoWLAN net-detect support
Date: Mon, 5 Aug 2024 17:00:26 +0800
Message-ID: <20240805090028.27768-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240805090028.27768-1-pkshih@realtek.com>
References: <20240805090028.27768-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

From: Chin-Yen Lee <timlee@realtek.com>

Net-detect is an option of WoWLAN to allow the device to
be woken up from suspend mode when configured network is detected.

When user enables net-detect and lets the device enter suspend
state, WoWLAN firmware will periodically scan until beacon or
probe response of configured networks are received. If configured
networks are detected, WoWLAN firmware will trigger resume process.

Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c   |   1 +
 drivers/net/wireless/realtek/rtw89/core.h   |   6 +
 drivers/net/wireless/realtek/rtw89/fw.c     | 277 +++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/fw.h     |  43 ++-
 drivers/net/wireless/realtek/rtw89/mac.c    |   5 +-
 drivers/net/wireless/realtek/rtw89/mac.h    |   5 +-
 drivers/net/wireless/realtek/rtw89/mac_be.c |   1 +
 drivers/net/wireless/realtek/rtw89/wow.c    | 301 ++++++++++++++++----
 drivers/net/wireless/realtek/rtw89/wow.h    |   7 +
 9 files changed, 568 insertions(+), 78 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index a71c1147d3ce..7b28f2c2a08e 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -4688,6 +4688,7 @@ static int rtw89_core_register_hw(struct rtw89_dev *rtwdev)
 
 #ifdef CONFIG_PM
 	hw->wiphy->wowlan = rtwdev->chip->wowlan_stub;
+	hw->wiphy->max_sched_scan_ssids = RTW89_SCANOFLD_MAX_SSID;
 #endif
 
 	hw->wiphy->tid_config_support.vif |= BIT(NL80211_TID_CONFIG_ATTR_AMPDU_CTRL);
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index ecef3b154f3e..f40475a94d11 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -927,10 +927,12 @@ enum rtw89_sc_offset {
 	RTW89_SC_40_LOWER	= 10,
 };
 
+/* only mgd features can be added to the enum */
 enum rtw89_wow_flags {
 	RTW89_WOW_FLAG_EN_MAGIC_PKT,
 	RTW89_WOW_FLAG_EN_REKEY_PKT,
 	RTW89_WOW_FLAG_EN_DISCONNECT,
+	RTW89_WOW_FLAG_EN_PATTERN,
 	RTW89_WOW_FLAG_NUM,
 };
 
@@ -5308,6 +5310,10 @@ struct rtw89_wow_param {
 	u8 gtk_alg;
 	u8 ptk_keyidx;
 	u8 akm;
+
+	bool pno_inited;
+	struct list_head pno_pkt_list;
+	struct cfg80211_sched_scan_request *nd_config;
 };
 
 struct rtw89_mcc_limit {
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index e545d2a7fb49..2a55f47a0ac8 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -4808,9 +4808,10 @@ int rtw89_fw_h2c_scan_list_offload_be(struct rtw89_dev *rtwdev, int ch_num,
 	return 0;
 }
 
-int rtw89_fw_h2c_scan_offload(struct rtw89_dev *rtwdev,
-			      struct rtw89_scan_option *option,
-			      struct rtw89_vif *rtwvif)
+int rtw89_fw_h2c_scan_offload_ax(struct rtw89_dev *rtwdev,
+				 struct rtw89_scan_option *option,
+				 struct rtw89_vif *rtwvif,
+				 bool wowlan)
 {
 	struct rtw89_wait_info *wait = &rtwdev->mac.fw_ofld_wait;
 	struct rtw89_chan *op = &rtwdev->scan_info.op_chan;
@@ -4838,7 +4839,10 @@ int rtw89_fw_h2c_scan_offload(struct rtw89_dev *rtwdev,
 				   RTW89_H2C_SCANOFLD_W1_TARGET_CH_MODE) |
 		  le32_encode_bits(RTW89_SCAN_IMMEDIATE,
 				   RTW89_H2C_SCANOFLD_W1_START_MODE) |
-		  le32_encode_bits(RTW89_SCAN_ONCE, RTW89_H2C_SCANOFLD_W1_SCAN_TYPE);
+		  le32_encode_bits(option->repeat, RTW89_H2C_SCANOFLD_W1_SCAN_TYPE);
+
+	h2c->w2 = le32_encode_bits(option->norm_pd, RTW89_H2C_SCANOFLD_W2_NORM_PD) |
+		  le32_encode_bits(option->slow_pd, RTW89_H2C_SCANOFLD_W2_SLOW_PD);
 
 	if (option->target_ch_mode) {
 		h2c->w1 |= le32_encode_bits(op->band_width,
@@ -4894,7 +4898,8 @@ static void rtw89_scan_get_6g_disabled_chan(struct rtw89_dev *rtwdev,
 
 int rtw89_fw_h2c_scan_offload_be(struct rtw89_dev *rtwdev,
 				 struct rtw89_scan_option *option,
-				 struct rtw89_vif *rtwvif)
+				 struct rtw89_vif *rtwvif,
+				 bool wowlan)
 {
 	struct rtw89_hw_scan_info *scan_info = &rtwdev->scan_info;
 	struct rtw89_wait_info *wait = &rtwdev->mac.fw_ofld_wait;
@@ -4930,11 +4935,13 @@ int rtw89_fw_h2c_scan_offload_be(struct rtw89_dev *rtwdev,
 
 	memset(probe_id, RTW89_SCANOFLD_PKT_NONE, sizeof(probe_id));
 
-	list_for_each_entry(pkt_info, &scan_info->pkt_list[NL80211_BAND_6GHZ], list) {
-		if (pkt_info->wildcard_6ghz) {
-			/* Provide wildcard as template */
-			probe_id[NL80211_BAND_6GHZ] = pkt_info->id;
-			break;
+	if (!wowlan) {
+		list_for_each_entry(pkt_info, &scan_info->pkt_list[NL80211_BAND_6GHZ], list) {
+			if (pkt_info->wildcard_6ghz) {
+				/* Provide wildcard as template */
+				probe_id[NL80211_BAND_6GHZ] = pkt_info->id;
+				break;
+			}
 		}
 	}
 
@@ -4973,7 +4980,7 @@ int rtw89_fw_h2c_scan_offload_be(struct rtw89_dev *rtwdev,
 				   RTW89_H2C_SCANOFLD_BE_W6_CHAN_PROHIB_LOW);
 	h2c->w7 = le32_encode_bits(option->prohib_chan >> 32,
 				   RTW89_H2C_SCANOFLD_BE_W7_CHAN_PROHIB_HIGH);
-	if (req->no_cck) {
+	if (!wowlan && req->no_cck) {
 		h2c->w0 |= le32_encode_bits(true, RTW89_H2C_SCANOFLD_BE_W0_PROBE_WITH_RATE);
 		h2c->w8 = le32_encode_bits(RTW89_HW_RATE_OFDM6,
 					   RTW89_H2C_SCANOFLD_BE_W8_PROBE_RATE_2GHZ) |
@@ -5966,6 +5973,56 @@ static int rtw89_update_6ghz_rnr_chan(struct rtw89_dev *rtwdev,
 	return ret;
 }
 
+static void rtw89_pno_scan_add_chan_ax(struct rtw89_dev *rtwdev,
+				       int chan_type, int ssid_num,
+				       struct rtw89_mac_chinfo *ch_info)
+{
+	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
+	struct rtw89_pktofld_info *info;
+	u8 probe_count = 0;
+
+	ch_info->notify_action = RTW89_SCANOFLD_DEBUG_MASK;
+	ch_info->dfs_ch = chan_type == RTW89_CHAN_DFS;
+	ch_info->bw = RTW89_SCAN_WIDTH;
+	ch_info->tx_pkt = true;
+	ch_info->cfg_tx_pwr = false;
+	ch_info->tx_pwr_idx = 0;
+	ch_info->tx_null = false;
+	ch_info->pause_data = false;
+	ch_info->probe_id = RTW89_SCANOFLD_PKT_NONE;
+
+	if (ssid_num) {
+		list_for_each_entry(info, &rtw_wow->pno_pkt_list, list) {
+			if (info->channel_6ghz &&
+			    ch_info->pri_ch != info->channel_6ghz)
+				continue;
+			else if (info->channel_6ghz && probe_count != 0)
+				ch_info->period += RTW89_CHANNEL_TIME_6G;
+
+			if (info->wildcard_6ghz)
+				continue;
+
+			ch_info->pkt_id[probe_count++] = info->id;
+			if (probe_count >= RTW89_SCANOFLD_MAX_SSID)
+				break;
+		}
+		ch_info->num_pkt = probe_count;
+	}
+
+	switch (chan_type) {
+	case RTW89_CHAN_DFS:
+		if (ch_info->ch_band != RTW89_BAND_6G)
+			ch_info->period = max_t(u8, ch_info->period,
+						RTW89_DFS_CHAN_TIME);
+		ch_info->dwell_time = RTW89_DWELL_TIME;
+		break;
+	case RTW89_CHAN_ACTIVE:
+		break;
+	default:
+		rtw89_err(rtwdev, "Channel type out of bound\n");
+	}
+}
+
 static void rtw89_hw_scan_add_chan(struct rtw89_dev *rtwdev, int chan_type,
 				   int ssid_num,
 				   struct rtw89_mac_chinfo *ch_info)
@@ -6044,6 +6101,45 @@ static void rtw89_hw_scan_add_chan(struct rtw89_dev *rtwdev, int chan_type,
 	}
 }
 
+static void rtw89_pno_scan_add_chan_be(struct rtw89_dev *rtwdev, int chan_type,
+				       int ssid_num,
+				       struct rtw89_mac_chinfo_be *ch_info)
+{
+	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
+	struct rtw89_pktofld_info *info;
+	u8 probe_count = 0, i;
+
+	ch_info->notify_action = RTW89_SCANOFLD_DEBUG_MASK;
+	ch_info->dfs_ch = chan_type == RTW89_CHAN_DFS;
+	ch_info->bw = RTW89_SCAN_WIDTH;
+	ch_info->tx_null = false;
+	ch_info->pause_data = false;
+	ch_info->probe_id = RTW89_SCANOFLD_PKT_NONE;
+
+	if (ssid_num) {
+		list_for_each_entry(info, &rtw_wow->pno_pkt_list, list) {
+			ch_info->pkt_id[probe_count++] = info->id;
+			if (probe_count >= RTW89_SCANOFLD_MAX_SSID)
+				break;
+		}
+	}
+
+	for (i = probe_count; i < RTW89_SCANOFLD_MAX_SSID; i++)
+		ch_info->pkt_id[i] = RTW89_SCANOFLD_PKT_NONE;
+
+	switch (chan_type) {
+	case RTW89_CHAN_DFS:
+		ch_info->period = max_t(u8, ch_info->period, RTW89_DFS_CHAN_TIME);
+		ch_info->dwell_time = RTW89_DWELL_TIME;
+		break;
+	case RTW89_CHAN_ACTIVE:
+		break;
+	default:
+		rtw89_warn(rtwdev, "Channel type out of bound\n");
+		break;
+	}
+}
+
 static void rtw89_hw_scan_add_chan_be(struct rtw89_dev *rtwdev, int chan_type,
 				      int ssid_num,
 				      struct rtw89_mac_chinfo_be *ch_info)
@@ -6106,8 +6202,58 @@ static void rtw89_hw_scan_add_chan_be(struct rtw89_dev *rtwdev, int chan_type,
 	}
 }
 
-int rtw89_hw_scan_add_chan_list(struct rtw89_dev *rtwdev,
-				struct rtw89_vif *rtwvif, bool connected)
+int rtw89_pno_scan_add_chan_list_ax(struct rtw89_dev *rtwdev,
+				    struct rtw89_vif *rtwvif)
+{
+	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
+	struct cfg80211_sched_scan_request *nd_config = rtw_wow->nd_config;
+	struct rtw89_mac_chinfo	*ch_info, *tmp;
+	struct ieee80211_channel *channel;
+	struct list_head chan_list;
+	int list_len;
+	enum rtw89_chan_type type;
+	int ret = 0;
+	u32 idx;
+
+	INIT_LIST_HEAD(&chan_list);
+	for (idx = 0, list_len = 0;
+	     idx < nd_config->n_channels && list_len < RTW89_SCAN_LIST_LIMIT;
+	     idx++, list_len++) {
+		channel = nd_config->channels[idx];
+		ch_info = kzalloc(sizeof(*ch_info), GFP_KERNEL);
+		if (!ch_info) {
+			ret = -ENOMEM;
+			goto out;
+		}
+
+		ch_info->period = RTW89_CHANNEL_TIME;
+		ch_info->ch_band = rtw89_nl80211_to_hw_band(channel->band);
+		ch_info->central_ch = channel->hw_value;
+		ch_info->pri_ch = channel->hw_value;
+		ch_info->is_psc = cfg80211_channel_is_psc(channel);
+
+		if (channel->flags &
+		    (IEEE80211_CHAN_RADAR | IEEE80211_CHAN_NO_IR))
+			type = RTW89_CHAN_DFS;
+		else
+			type = RTW89_CHAN_ACTIVE;
+
+		rtw89_pno_scan_add_chan_ax(rtwdev, type, nd_config->n_match_sets, ch_info);
+		list_add_tail(&ch_info->list, &chan_list);
+	}
+	ret = rtw89_fw_h2c_scan_list_offload(rtwdev, list_len, &chan_list);
+
+out:
+	list_for_each_entry_safe(ch_info, tmp, &chan_list, list) {
+		list_del(&ch_info->list);
+		kfree(ch_info);
+	}
+
+	return ret;
+}
+
+int rtw89_hw_scan_add_chan_list_ax(struct rtw89_dev *rtwdev,
+				   struct rtw89_vif *rtwvif, bool connected)
 {
 	struct cfg80211_scan_request *req = rtwvif->scan_req;
 	struct rtw89_mac_chinfo	*ch_info, *tmp;
@@ -6183,6 +6329,58 @@ int rtw89_hw_scan_add_chan_list(struct rtw89_dev *rtwdev,
 	return ret;
 }
 
+int rtw89_pno_scan_add_chan_list_be(struct rtw89_dev *rtwdev,
+				    struct rtw89_vif *rtwvif)
+{
+	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
+	struct cfg80211_sched_scan_request *nd_config = rtw_wow->nd_config;
+	struct rtw89_mac_chinfo_be *ch_info, *tmp;
+	struct ieee80211_channel *channel;
+	struct list_head chan_list;
+	enum rtw89_chan_type type;
+	int list_len, ret;
+	u32 idx;
+
+	INIT_LIST_HEAD(&chan_list);
+
+	for (idx = 0, list_len = 0;
+	     idx < nd_config->n_channels && list_len < RTW89_SCAN_LIST_LIMIT;
+	     idx++, list_len++) {
+		channel = nd_config->channels[idx];
+		ch_info = kzalloc(sizeof(*ch_info), GFP_KERNEL);
+		if (!ch_info) {
+			ret = -ENOMEM;
+			goto out;
+		}
+
+		ch_info->period = RTW89_CHANNEL_TIME;
+		ch_info->ch_band = rtw89_nl80211_to_hw_band(channel->band);
+		ch_info->central_ch = channel->hw_value;
+		ch_info->pri_ch = channel->hw_value;
+		ch_info->is_psc = cfg80211_channel_is_psc(channel);
+
+		if (channel->flags &
+		    (IEEE80211_CHAN_RADAR | IEEE80211_CHAN_NO_IR))
+			type = RTW89_CHAN_DFS;
+		else
+			type = RTW89_CHAN_ACTIVE;
+
+		rtw89_pno_scan_add_chan_be(rtwdev, type,
+					   nd_config->n_match_sets, ch_info);
+		list_add_tail(&ch_info->list, &chan_list);
+	}
+
+	ret = rtw89_fw_h2c_scan_list_offload_be(rtwdev, list_len, &chan_list);
+
+out:
+	list_for_each_entry_safe(ch_info, tmp, &chan_list, list) {
+		list_del(&ch_info->list);
+		kfree(ch_info);
+	}
+
+	return ret;
+}
+
 int rtw89_hw_scan_add_chan_list_be(struct rtw89_dev *rtwdev,
 				   struct rtw89_vif *rtwvif, bool connected)
 {
@@ -6392,7 +6590,7 @@ int rtw89_hw_scan_offload(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
 		opt.opch_end = connected ? 0 : RTW89_CHAN_INVALID;
 	}
 
-	ret = mac->scan_offload(rtwdev, &opt, rtwvif);
+	ret = mac->scan_offload(rtwdev, &opt, rtwvif, false);
 out:
 	return ret;
 }
@@ -6642,6 +6840,57 @@ int rtw89_fw_h2c_disconnect_detect(struct rtw89_dev *rtwdev,
 	return ret;
 }
 
+int rtw89_fw_h2c_cfg_pno(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
+			 bool enable)
+{
+	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
+	struct cfg80211_sched_scan_request *nd_config = rtw_wow->nd_config;
+	struct rtw89_h2c_cfg_nlo *h2c;
+	u32 len = sizeof(*h2c);
+	struct sk_buff *skb;
+	int ret, i;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for nlo\n");
+		return -ENOMEM;
+	}
+
+	skb_put(skb, len);
+	h2c = (struct rtw89_h2c_cfg_nlo *)skb->data;
+
+	h2c->w0 = le32_encode_bits(enable, RTW89_H2C_NLO_W0_ENABLE) |
+		  le32_encode_bits(enable, RTW89_H2C_NLO_W0_IGNORE_CIPHER) |
+		  le32_encode_bits(rtwvif->mac_id, RTW89_H2C_NLO_W0_MACID);
+
+	if (enable) {
+		h2c->nlo_cnt = nd_config->n_match_sets;
+		for (i = 0 ; i < nd_config->n_match_sets; i++) {
+			h2c->ssid_len[i] = nd_config->match_sets[i].ssid.ssid_len;
+			memcpy(h2c->ssid[i], nd_config->match_sets[i].ssid.ssid,
+			       nd_config->match_sets[i].ssid.ssid_len);
+		}
+	}
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_MAC,
+			      H2C_CL_MAC_WOW,
+			      H2C_FUNC_NLO, 0, 1,
+			      len);
+
+	ret = rtw89_h2c_tx(rtwdev, skb, false);
+	if (ret) {
+		rtw89_err(rtwdev, "failed to send h2c\n");
+		goto fail;
+	}
+
+	return 0;
+
+fail:
+	dev_kfree_skb_any(skb);
+	return ret;
+}
+
 int rtw89_fw_h2c_wow_global(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 			    bool enable)
 {
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 1bbdf0613ca4..d45355e5b2e8 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -1898,6 +1898,24 @@ struct rtw89_h2c_wow_global {
 #define RTW89_H2C_WOW_GLOBAL_W0_PAIRWISE_SEC_ALGO GENMASK(23, 16)
 #define RTW89_H2C_WOW_GLOBAL_W0_GROUP_SEC_ALGO GENMASK(31, 24)
 
+#define RTW89_MAX_SUPPORT_NL_NUM	16
+struct rtw89_h2c_cfg_nlo {
+	__le32 w0;
+	u8 nlo_cnt;
+	u8 rsvd[3];
+	__le32 patterncheck;
+	__le32 rsvd1;
+	__le32 rsvd2;
+	u8 ssid_len[RTW89_MAX_SUPPORT_NL_NUM];
+	u8 chiper[RTW89_MAX_SUPPORT_NL_NUM];
+	u8 rsvd3[24];
+	u8 ssid[RTW89_MAX_SUPPORT_NL_NUM][IEEE80211_MAX_SSID_LEN];
+} __packed;
+
+#define RTW89_H2C_NLO_W0_ENABLE BIT(0)
+#define RTW89_H2C_NLO_W0_IGNORE_CIPHER BIT(2)
+#define RTW89_H2C_NLO_W0_MACID GENMASK(31, 24)
+
 static inline void RTW89_SET_WOW_WAKEUP_CTRL_PATTERN_MATCH_ENABLE(void *h2c, u32 val)
 {
 	le32p_replace_bits((__le32 *)h2c, val, BIT(0));
@@ -2093,6 +2111,10 @@ enum rtw89_scan_mode {
 
 enum rtw89_scan_type {
 	RTW89_SCAN_ONCE,
+	RTW89_SCAN_NORMAL,
+	RTW89_SCAN_NORMAL_SLOW,
+	RTW89_SCAN_SEAMLESS,
+	RTW89_SCAN_MAX,
 };
 
 static inline void RTW89_SET_FWCMD_CXHDR_TYPE(void *cmd, u8 val)
@@ -3958,6 +3980,7 @@ enum rtw89_wow_h2c_func {
 	H2C_FUNC_WOW_GLOBAL		= 0x2,
 	H2C_FUNC_GTK_OFLD		= 0x3,
 	H2C_FUNC_ARP_OFLD		= 0x4,
+	H2C_FUNC_NLO			= 0x7,
 	H2C_FUNC_WAKEUP_CTRL		= 0x8,
 	H2C_FUNC_WOW_CAM_UPD		= 0xC,
 	H2C_FUNC_AOAC_REPORT_REQ	= 0xD,
@@ -4412,12 +4435,14 @@ int rtw89_fw_h2c_scan_list_offload(struct rtw89_dev *rtwdev, int ch_num,
 				   struct list_head *chan_list);
 int rtw89_fw_h2c_scan_list_offload_be(struct rtw89_dev *rtwdev, int ch_num,
 				      struct list_head *chan_list);
-int rtw89_fw_h2c_scan_offload(struct rtw89_dev *rtwdev,
-			      struct rtw89_scan_option *opt,
-			      struct rtw89_vif *vif);
+int rtw89_fw_h2c_scan_offload_ax(struct rtw89_dev *rtwdev,
+				 struct rtw89_scan_option *opt,
+				 struct rtw89_vif *vif,
+				 bool wowlan);
 int rtw89_fw_h2c_scan_offload_be(struct rtw89_dev *rtwdev,
 				 struct rtw89_scan_option *opt,
-				 struct rtw89_vif *vif);
+				 struct rtw89_vif *vif,
+				 bool wowlan);
 int rtw89_fw_h2c_rf_reg(struct rtw89_dev *rtwdev,
 			struct rtw89_fw_h2c_rf_reg_info *info,
 			u16 len, u8 page);
@@ -4470,10 +4495,14 @@ void rtw89_hw_scan_complete(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
 int rtw89_hw_scan_offload(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
 			  bool enable);
 void rtw89_hw_scan_abort(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif);
-int rtw89_hw_scan_add_chan_list(struct rtw89_dev *rtwdev,
-				struct rtw89_vif *rtwvif, bool connected);
+int rtw89_hw_scan_add_chan_list_ax(struct rtw89_dev *rtwdev,
+				   struct rtw89_vif *rtwvif, bool connected);
+int rtw89_pno_scan_add_chan_list_ax(struct rtw89_dev *rtwdev,
+				    struct rtw89_vif *rtwvif);
 int rtw89_hw_scan_add_chan_list_be(struct rtw89_dev *rtwdev,
 				   struct rtw89_vif *rtwvif, bool connected);
+int rtw89_pno_scan_add_chan_list_be(struct rtw89_dev *rtwdev,
+				    struct rtw89_vif *rtwvif);
 int rtw89_fw_h2c_trigger_cpu_exception(struct rtw89_dev *rtwdev);
 int rtw89_fw_h2c_pkt_drop(struct rtw89_dev *rtwdev,
 			  const struct rtw89_pkt_drop_params *params);
@@ -4486,6 +4515,8 @@ int rtw89_fw_h2c_wow_global(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 			    bool enable);
 int rtw89_fw_h2c_wow_wakeup_ctrl(struct rtw89_dev *rtwdev,
 				 struct rtw89_vif *rtwvif, bool enable);
+int rtw89_fw_h2c_cfg_pno(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
+			 bool enable);
 int rtw89_fw_h2c_keep_alive(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 			    bool enable);
 int rtw89_fw_h2c_arp_offload(struct rtw89_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 149fb1b16239..89875f59d722 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -6527,8 +6527,9 @@ const struct rtw89_mac_gen_def rtw89_mac_gen_ax = {
 
 	.is_txq_empty = mac_is_txq_empty_ax,
 
-	.add_chan_list = rtw89_hw_scan_add_chan_list,
-	.scan_offload = rtw89_fw_h2c_scan_offload,
+	.add_chan_list = rtw89_hw_scan_add_chan_list_ax,
+	.add_chan_list_pno = rtw89_pno_scan_add_chan_list_ax,
+	.scan_offload = rtw89_fw_h2c_scan_offload_ax,
 
 	.wow_config_mac = rtw89_wow_config_mac_ax,
 };
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 02052fbbec1a..9d3be36ffb6e 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -1006,9 +1006,12 @@ struct rtw89_mac_gen_def {
 
 	int (*add_chan_list)(struct rtw89_dev *rtwdev,
 			     struct rtw89_vif *rtwvif, bool connected);
+	int (*add_chan_list_pno)(struct rtw89_dev *rtwdev,
+				 struct rtw89_vif *rtwvif);
 	int (*scan_offload)(struct rtw89_dev *rtwdev,
 			    struct rtw89_scan_option *option,
-			    struct rtw89_vif *rtwvif);
+			    struct rtw89_vif *rtwvif,
+			    bool wowlan);
 
 	int (*wow_config_mac)(struct rtw89_dev *rtwdev, bool enable_wow);
 };
diff --git a/drivers/net/wireless/realtek/rtw89/mac_be.c b/drivers/net/wireless/realtek/rtw89/mac_be.c
index f212b67771d5..31f0a5225b11 100644
--- a/drivers/net/wireless/realtek/rtw89/mac_be.c
+++ b/drivers/net/wireless/realtek/rtw89/mac_be.c
@@ -2599,6 +2599,7 @@ const struct rtw89_mac_gen_def rtw89_mac_gen_be = {
 	.is_txq_empty = mac_is_txq_empty_be,
 
 	.add_chan_list = rtw89_hw_scan_add_chan_list_be,
+	.add_chan_list_pno = rtw89_pno_scan_add_chan_list_be,
 	.scan_offload = rtw89_fw_h2c_scan_offload_be,
 
 	.wow_config_mac = rtw89_wow_config_mac_be,
diff --git a/drivers/net/wireless/realtek/rtw89/wow.c b/drivers/net/wireless/realtek/rtw89/wow.c
index fa7fd6571051..3bf563998ddf 100644
--- a/drivers/net/wireless/realtek/rtw89/wow.c
+++ b/drivers/net/wireless/realtek/rtw89/wow.c
@@ -794,17 +794,22 @@ static void rtw89_wow_vif_iter(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvi
 	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
 	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif);
 
-	/* Current wowlan function support setting of only one STATION vif.
-	 * So when one suitable vif is found, stop the iteration.
+	/* Current WoWLAN function support setting of only vif in
+	 * infra mode or no link mode. When one suitable vif is found,
+	 * stop the iteration.
 	 */
 	if (rtw_wow->wow_vif || vif->type != NL80211_IFTYPE_STATION)
 		return;
 
 	switch (rtwvif->net_type) {
 	case RTW89_NET_TYPE_INFRA:
-		rtw_wow->wow_vif = vif;
+		if (rtw_wow_has_mgd_features(rtwdev))
+			rtw_wow->wow_vif = vif;
 		break;
 	case RTW89_NET_TYPE_NO_LINK:
+		if (rtw_wow->pno_inited)
+			rtw_wow->wow_vif = vif;
+		break;
 	default:
 		break;
 	}
@@ -1038,6 +1043,23 @@ static void rtw89_wow_clear_wakeups(struct rtw89_dev *rtwdev)
 	rtw_wow->wow_vif = NULL;
 	rtw89_core_release_all_bits_map(rtw_wow->flags, RTW89_WOW_FLAG_NUM);
 	rtw_wow->pattern_cnt = 0;
+	rtw_wow->pno_inited = false;
+}
+
+static void rtw89_wow_init_pno(struct rtw89_dev *rtwdev,
+			       struct cfg80211_sched_scan_request *nd_config)
+{
+	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
+
+	if (!nd_config->n_match_sets || !nd_config->n_channels)
+		return;
+
+	rtw_wow->nd_config = nd_config;
+	rtw_wow->pno_inited = true;
+
+	INIT_LIST_HEAD(&rtw_wow->pno_pkt_list);
+
+	rtw89_debug(rtwdev, RTW89_DBG_WOW, "WOW: net-detect is enabled\n");
 }
 
 static int rtw89_wow_set_wakeups(struct rtw89_dev *rtwdev,
@@ -1050,6 +1072,11 @@ static int rtw89_wow_set_wakeups(struct rtw89_dev *rtwdev,
 		set_bit(RTW89_WOW_FLAG_EN_DISCONNECT, rtw_wow->flags);
 	if (wowlan->magic_pkt)
 		set_bit(RTW89_WOW_FLAG_EN_MAGIC_PKT, rtw_wow->flags);
+	if (wowlan->n_patterns && wowlan->patterns)
+		set_bit(RTW89_WOW_FLAG_EN_PATTERN, rtw_wow->flags);
+
+	if (wowlan->nd_config)
+		rtw89_wow_init_pno(rtwdev, wowlan->nd_config);
 
 	rtw89_for_each_rtwvif(rtwdev, rtwvif)
 		rtw89_wow_vif_iter(rtwdev, rtwvif);
@@ -1061,6 +1088,34 @@ static int rtw89_wow_set_wakeups(struct rtw89_dev *rtwdev,
 	return rtw89_wow_parse_patterns(rtwdev, rtwvif, wowlan);
 }
 
+static int rtw89_wow_cfg_wake_pno(struct rtw89_dev *rtwdev, bool wow)
+{
+	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
+	struct ieee80211_vif *wow_vif = rtw_wow->wow_vif;
+	struct rtw89_vif *rtwvif = (struct rtw89_vif *)wow_vif->drv_priv;
+	int ret;
+
+	ret = rtw89_fw_h2c_cfg_pno(rtwdev, rtwvif, true);
+	if (ret) {
+		rtw89_err(rtwdev, "failed to config pno\n");
+		return ret;
+	}
+
+	ret = rtw89_fw_h2c_wow_wakeup_ctrl(rtwdev, rtwvif, wow);
+	if (ret) {
+		rtw89_err(rtwdev, "failed to fw wow wakeup ctrl\n");
+		return ret;
+	}
+
+	ret = rtw89_fw_h2c_wow_global(rtwdev, rtwvif, wow);
+	if (ret) {
+		rtw89_err(rtwdev, "failed to fw wow global\n");
+		return ret;
+	}
+
+	return 0;
+}
+
 static int rtw89_wow_cfg_wake(struct rtw89_dev *rtwdev, bool wow)
 {
 	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
@@ -1321,100 +1376,236 @@ static int rtw89_wow_disable_trx_post(struct rtw89_dev *rtwdev)
 	return ret;
 }
 
-static int rtw89_wow_fw_start(struct rtw89_dev *rtwdev)
+static void rtw89_fw_release_pno_pkt_list(struct rtw89_dev *rtwdev,
+					  struct rtw89_vif *rtwvif)
 {
 	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
-	struct rtw89_vif *rtwvif = (struct rtw89_vif *)rtw_wow->wow_vif->drv_priv;
+	struct list_head *pkt_list = &rtw_wow->pno_pkt_list;
+	struct rtw89_pktofld_info *info, *tmp;
+
+	list_for_each_entry_safe(info, tmp, pkt_list, list) {
+		rtw89_fw_h2c_del_pkt_offload(rtwdev, info->id);
+		list_del(&info->list);
+		kfree(info);
+	}
+}
+
+static int rtw89_pno_scan_update_probe_req(struct rtw89_dev *rtwdev,
+					   struct rtw89_vif *rtwvif)
+{
+	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
+	struct cfg80211_sched_scan_request *nd_config = rtw_wow->nd_config;
+	u8 num = nd_config->n_match_sets, i;
+	struct rtw89_pktofld_info *info;
+	struct sk_buff *skb;
 	int ret;
 
-	rtw89_wow_pattern_write(rtwdev);
-	rtw89_wow_construct_key_info(rtwdev);
+	for (i = 0; i < num; i++) {
+		skb = ieee80211_probereq_get(rtwdev->hw, rtwvif->mac_addr,
+					     nd_config->match_sets[i].ssid.ssid,
+					     nd_config->match_sets[i].ssid.ssid_len,
+					     nd_config->ie_len);
+		if (!skb)
+			return -ENOMEM;
+
+		skb_put_data(skb, nd_config->ie, nd_config->ie_len);
+
+		info = kzalloc(sizeof(*info), GFP_KERNEL);
+		if (!info) {
+			kfree_skb(skb);
+			rtw89_fw_release_pno_pkt_list(rtwdev, rtwvif);
+			return -ENOMEM;
+		}
 
-	ret = rtw89_fw_h2c_keep_alive(rtwdev, rtwvif, true);
-	if (ret) {
-		rtw89_err(rtwdev, "wow: failed to enable keep alive\n");
-		return ret;
+		ret = rtw89_fw_h2c_add_pkt_offload(rtwdev, &info->id, skb);
+		if (ret) {
+			kfree_skb(skb);
+			kfree(info);
+			rtw89_fw_release_pno_pkt_list(rtwdev, rtwvif);
+			return ret;
+		}
+
+		list_add_tail(&info->list, &rtw_wow->pno_pkt_list);
+		kfree_skb(skb);
 	}
 
-	ret = rtw89_fw_h2c_disconnect_detect(rtwdev, rtwvif, true);
-	if (ret) {
-		rtw89_err(rtwdev, "wow: failed to enable disconnect detect\n");
-		goto out;
+	return 0;
+}
+
+static int rtw89_pno_scan_offload(struct rtw89_dev *rtwdev, bool enable)
+{
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
+	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
+	struct ieee80211_vif *wow_vif = rtw_wow->wow_vif;
+	struct rtw89_vif *rtwvif = (struct rtw89_vif *)wow_vif->drv_priv;
+	struct rtw89_scan_option opt = {};
+	int ret;
+
+	if (enable) {
+		ret = rtw89_pno_scan_update_probe_req(rtwdev, rtwvif);
+		if (ret) {
+			rtw89_err(rtwdev, "Update probe request failed\n");
+			return ret;
+		}
+
+		ret = mac->add_chan_list_pno(rtwdev, rtwvif);
+		if (ret) {
+			rtw89_err(rtwdev, "Update channel list failed\n");
+			return ret;
+		}
 	}
 
-	ret = rtw89_fw_h2c_wow_gtk_ofld(rtwdev, rtwvif, true);
-	if (ret) {
-		rtw89_err(rtwdev, "wow: failed to enable GTK offload\n");
-		goto out;
+	opt.enable = enable;
+	opt.repeat = RTW89_SCAN_NORMAL;
+	opt.norm_pd = 10; /* in unit of 100ms */
+	if (rtwdev->chip->chip_gen == RTW89_CHIP_BE) {
+		opt.operation = enable ? RTW89_SCAN_OP_START : RTW89_SCAN_OP_STOP;
+		opt.scan_mode = RTW89_SCAN_MODE_SA;
+		opt.band = RTW89_PHY_0;
+		opt.num_macc_role = 0;
+		opt.mlo_mode = rtwdev->mlo_dbcc_mode;
+		opt.num_opch = 0;
+		opt.opch_end = RTW89_CHAN_INVALID;
 	}
 
-	ret = rtw89_fw_h2c_arp_offload(rtwdev, rtwvif, true);
-	if (ret)
-		rtw89_warn(rtwdev, "wow: failed to enable arp offload\n");
+	mac->scan_offload(rtwdev, &opt, rtwvif, true);
 
-	ret = rtw89_wow_cfg_wake(rtwdev, true);
-	if (ret) {
-		rtw89_err(rtwdev, "wow: failed to config wake\n");
-		goto out;
+	return 0;
+}
+
+static int rtw89_wow_fw_start(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
+	struct ieee80211_vif *wow_vif = rtw_wow->wow_vif;
+	struct rtw89_vif *rtwvif = (struct rtw89_vif *)wow_vif->drv_priv;
+	int ret;
+
+	if (rtw89_wow_no_link(rtwdev)) {
+		ret = rtw89_pno_scan_offload(rtwdev, false);
+		if (ret) {
+			rtw89_err(rtwdev, "wow: failed to disable pno scan offload\n");
+			return ret;
+		}
+
+		ret = rtw89_pno_scan_offload(rtwdev, true);
+		if (ret) {
+			rtw89_err(rtwdev, "wow: failed to enable pno scan offload\n");
+			return ret;
+		}
+	} else {
+		rtw89_wow_pattern_write(rtwdev);
+		rtw89_wow_construct_key_info(rtwdev);
+
+		ret = rtw89_fw_h2c_keep_alive(rtwdev, rtwvif, true);
+		if (ret) {
+			rtw89_err(rtwdev, "wow: failed to enable keep alive\n");
+			return ret;
+		}
+
+		ret = rtw89_fw_h2c_disconnect_detect(rtwdev, rtwvif, true);
+		if (ret) {
+			rtw89_err(rtwdev, "wow: failed to enable disconnect detect\n");
+			return ret;
+		}
+
+		ret = rtw89_fw_h2c_wow_gtk_ofld(rtwdev, rtwvif, true);
+		if (ret) {
+			rtw89_err(rtwdev, "wow: failed to enable GTK offload\n");
+			return ret;
+		}
+
+		ret = rtw89_fw_h2c_arp_offload(rtwdev, rtwvif, true);
+		if (ret)
+			rtw89_warn(rtwdev, "wow: failed to enable arp offload\n");
+	}
+
+	if (rtw89_wow_no_link(rtwdev)) {
+		ret = rtw89_wow_cfg_wake_pno(rtwdev, true);
+		if (ret) {
+			rtw89_err(rtwdev, "wow: failed to config wake PNO\n");
+			return ret;
+		}
+	} else {
+		ret = rtw89_wow_cfg_wake(rtwdev, true);
+		if (ret) {
+			rtw89_err(rtwdev, "wow: failed to config wake\n");
+			return ret;
+		}
 	}
 
 	ret = rtw89_wow_check_fw_status(rtwdev, true);
 	if (ret) {
 		rtw89_err(rtwdev, "wow: failed to check enable fw ready\n");
-		goto out;
+		return ret;
 	}
 
-out:
-	return ret;
+	return 0;
 }
 
 static int rtw89_wow_fw_stop(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
-	struct rtw89_vif *rtwvif = (struct rtw89_vif *)rtw_wow->wow_vif->drv_priv;
+	struct ieee80211_vif *wow_vif = rtw_wow->wow_vif;
+	struct rtw89_vif *rtwvif = (struct rtw89_vif *)wow_vif->drv_priv;
 	int ret;
 
-	rtw89_wow_pattern_clear(rtwdev);
+	if (rtw89_wow_no_link(rtwdev)) {
+		ret = rtw89_pno_scan_offload(rtwdev, false);
+		if (ret) {
+			rtw89_err(rtwdev, "wow: failed to disable pno scan offload\n");
+			return ret;
+		}
 
-	ret = rtw89_fw_h2c_keep_alive(rtwdev, rtwvif, false);
-	if (ret) {
-		rtw89_err(rtwdev, "wow: failed to disable keep alive\n");
-		goto out;
-	}
+		ret = rtw89_fw_h2c_cfg_pno(rtwdev, rtwvif, false);
+		if (ret) {
+			rtw89_err(rtwdev, "wow: failed to disable pno\n");
+			return ret;
+		}
 
-	ret = rtw89_fw_h2c_disconnect_detect(rtwdev, rtwvif, false);
-	if (ret) {
-		rtw89_err(rtwdev, "wow: failed to disable disconnect detect\n");
-		goto out;
-	}
+		rtw89_fw_release_pno_pkt_list(rtwdev, rtwvif);
+	} else {
+		rtw89_wow_pattern_clear(rtwdev);
 
-	ret = rtw89_fw_h2c_wow_gtk_ofld(rtwdev, rtwvif, false);
-	if (ret) {
-		rtw89_err(rtwdev, "wow: failed to disable GTK offload\n");
-		goto out;
-	}
+		ret = rtw89_fw_h2c_keep_alive(rtwdev, rtwvif, false);
+		if (ret) {
+			rtw89_err(rtwdev, "wow: failed to disable keep alive\n");
+			return ret;
+		}
 
-	ret = rtw89_fw_h2c_arp_offload(rtwdev, rtwvif, false);
-	if (ret)
-		rtw89_warn(rtwdev, "wow: failed to disable arp offload\n");
+		ret = rtw89_fw_h2c_disconnect_detect(rtwdev, rtwvif, false);
+		if (ret) {
+			rtw89_err(rtwdev, "wow: failed to disable disconnect detect\n");
+			return ret;
+		}
+
+		ret = rtw89_fw_h2c_wow_gtk_ofld(rtwdev, rtwvif, false);
+		if (ret) {
+			rtw89_err(rtwdev, "wow: failed to disable GTK offload\n");
+			return ret;
+		}
+
+		ret = rtw89_fw_h2c_arp_offload(rtwdev, rtwvif, false);
+		if (ret)
+			rtw89_warn(rtwdev, "wow: failed to disable arp offload\n");
+
+		rtw89_wow_key_clear(rtwdev);
+		rtw89_fw_release_general_pkt_list(rtwdev, true);
+	}
 
-	rtw89_wow_key_clear(rtwdev);
-	rtw89_fw_release_general_pkt_list(rtwdev, true);
 
 	ret = rtw89_wow_cfg_wake(rtwdev, false);
 	if (ret) {
 		rtw89_err(rtwdev, "wow: failed to disable config wake\n");
-		goto out;
+		return ret;
 	}
 
 	ret = rtw89_wow_check_fw_status(rtwdev, false);
 	if (ret) {
 		rtw89_err(rtwdev, "wow: failed to check disable fw ready\n");
-		goto out;
+		return ret;
 	}
 
-out:
-	return ret;
+	return 0;
 }
 
 static int rtw89_wow_enable(struct rtw89_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw89/wow.h b/drivers/net/wireless/realtek/rtw89/wow.h
index 5eff3084119b..3fbc2b87c058 100644
--- a/drivers/net/wireless/realtek/rtw89/wow.h
+++ b/drivers/net/wireless/realtek/rtw89/wow.h
@@ -111,6 +111,13 @@ static inline bool rtw89_wow_no_link(struct rtw89_dev *rtwdev)
 	return rtwvif->net_type == RTW89_NET_TYPE_NO_LINK;
 }
 
+static inline bool rtw_wow_has_mgd_features(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
+
+	return !bitmap_empty(rtw_wow->flags, RTW89_WOW_FLAG_NUM);
+}
+
 int rtw89_wow_suspend(struct rtw89_dev *rtwdev, struct cfg80211_wowlan *wowlan);
 int rtw89_wow_resume(struct rtw89_dev *rtwdev);
 void rtw89_wow_parse_akm(struct rtw89_dev *rtwdev, struct sk_buff *skb);
-- 
2.25.1


