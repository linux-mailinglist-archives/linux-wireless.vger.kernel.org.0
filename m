Return-Path: <linux-wireless+bounces-2518-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9DC983D4C9
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jan 2024 09:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3C131F23BE5
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jan 2024 08:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8222B1CF9C;
	Fri, 26 Jan 2024 06:34:47 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B091CF8D
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jan 2024 06:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706250887; cv=none; b=jDwwVDHwZugowMfLgceLLYoUEDziuDcpgiBekUsROy+q+FSHneDhVx9sJxtivyglZvC/Ad5jONBcM3nVmqz9TpIR11vlCXlK/oINCO4VLPsWKYIkUGdqNieCL6k9cSS8Mwxp0qhpX4gwBcW1XYtXjTatVSSTo4E5rKWpV6AubvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706250887; c=relaxed/simple;
	bh=QQz8rPyxhKzIuAc5iUTeVfbx+huK5RVB9mubD0SovCo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nYTpBdYaGvO0epK7nmbc8ijNVlhgcyAQjGEq3l0oy+Qw4d34Py6L7/ry/1TOM3N+Ssa7XaMvpJy8Jm/0ZWQIAi7L3wHxlH+BgoV9P3Lw31XHeoTk8P64ScsiT9GqQ370jZH841qPisFb6Bnt3XFSElopFNU0R2To9bCGv5mipNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 40Q6YcfjE2085608, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 40Q6YcfjE2085608
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jan 2024 14:34:38 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Fri, 26 Jan 2024 14:34:39 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 26 Jan
 2024 14:34:38 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <timlee@realtek.com>, <phhuang@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 3/7] wifi: rtw89: prepare scan leaf functions for wifi 7 ICs
Date: Fri, 26 Jan 2024 14:33:52 +0800
Message-ID: <20240126063356.17857-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240126063356.17857-1-pkshih@realtek.com>
References: <20240126063356.17857-1-pkshih@realtek.com>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

From: Po-Hao Huang <phhuang@realtek.com>

The channel field slightly differs between WiFi 6 and WiFi 7.
So we prepare some required functions in advance, this doesn't change
existing wifi 6 ICs behavior. This H2C prepares the channel list
to be scanned for. With layout as the following:

+--------+--------------------+-------------------+-----------------------+
| header | number of channels | channel info size | channel_info * number |
+--------+--------------------+-------------------+-----------------------+

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c     | 220 +++++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/fw.h     |  79 ++++++-
 drivers/net/wireless/realtek/rtw89/mac.c    |   2 +
 drivers/net/wireless/realtek/rtw89/mac.h    |   3 +
 drivers/net/wireless/realtek/rtw89/mac_be.c |   2 +
 5 files changed, 302 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 43fe9333d3e7..ea308244b303 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -4078,6 +4078,102 @@ int rtw89_fw_h2c_scan_list_offload(struct rtw89_dev *rtwdev, int ch_num,
 	return 0;
 }
 
+int rtw89_fw_h2c_scan_list_offload_be(struct rtw89_dev *rtwdev, int ch_num,
+				      struct list_head *chan_list)
+{
+	struct rtw89_wait_info *wait = &rtwdev->mac.fw_ofld_wait;
+	struct rtw89_h2c_chinfo_elem_be *elem;
+	struct rtw89_mac_chinfo_be *ch_info;
+	struct rtw89_h2c_chinfo *h2c;
+	struct sk_buff *skb;
+	unsigned int cond;
+	int skb_len;
+	int ret;
+
+	static_assert(sizeof(*elem) == RTW89_MAC_CHINFO_SIZE);
+
+	skb_len = struct_size(h2c, elem, ch_num);
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, skb_len);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for h2c scan list\n");
+		return -ENOMEM;
+	}
+
+	skb_put(skb, sizeof(*h2c));
+	h2c = (struct rtw89_h2c_chinfo *)skb->data;
+
+	h2c->ch_num = ch_num;
+	h2c->elem_size = sizeof(*elem) / 4; /* in unit of 4 bytes */
+	h2c->arg = u8_encode_bits(RTW89_PHY_0, RTW89_H2C_CHINFO_ARG_MAC_IDX_MASK);
+
+	list_for_each_entry(ch_info, chan_list, list) {
+		elem = (struct rtw89_h2c_chinfo_elem_be *)skb_put(skb, sizeof(*elem));
+
+		elem->w0 = le32_encode_bits(ch_info->period, RTW89_H2C_CHINFO_BE_W0_PERIOD) |
+			   le32_encode_bits(ch_info->dwell_time, RTW89_H2C_CHINFO_BE_W0_DWELL) |
+			   le32_encode_bits(ch_info->central_ch,
+					    RTW89_H2C_CHINFO_BE_W0_CENTER_CH) |
+			   le32_encode_bits(ch_info->pri_ch, RTW89_H2C_CHINFO_BE_W0_PRI_CH);
+
+		elem->w1 = le32_encode_bits(ch_info->bw, RTW89_H2C_CHINFO_BE_W1_BW) |
+			   le32_encode_bits(ch_info->ch_band, RTW89_H2C_CHINFO_BE_W1_CH_BAND) |
+			   le32_encode_bits(ch_info->dfs_ch, RTW89_H2C_CHINFO_BE_W1_DFS) |
+			   le32_encode_bits(ch_info->pause_data,
+					    RTW89_H2C_CHINFO_BE_W1_PAUSE_DATA) |
+			   le32_encode_bits(ch_info->tx_null, RTW89_H2C_CHINFO_BE_W1_TX_NULL) |
+			   le32_encode_bits(ch_info->rand_seq_num,
+					    RTW89_H2C_CHINFO_BE_W1_RANDOM) |
+			   le32_encode_bits(ch_info->notify_action,
+					    RTW89_H2C_CHINFO_BE_W1_NOTIFY) |
+			   le32_encode_bits(ch_info->probe_id != 0xff ? 1 : 0,
+					    RTW89_H2C_CHINFO_BE_W1_PROBE) |
+			   le32_encode_bits(ch_info->leave_crit,
+					    RTW89_H2C_CHINFO_BE_W1_EARLY_LEAVE_CRIT) |
+			   le32_encode_bits(ch_info->chkpt_timer,
+					    RTW89_H2C_CHINFO_BE_W1_CHKPT_TIMER);
+
+		elem->w2 = le32_encode_bits(ch_info->leave_time,
+					    RTW89_H2C_CHINFO_BE_W2_EARLY_LEAVE_TIME) |
+			   le32_encode_bits(ch_info->leave_th,
+					    RTW89_H2C_CHINFO_BE_W2_EARLY_LEAVE_TH) |
+			   le32_encode_bits(ch_info->tx_pkt_ctrl,
+					    RTW89_H2C_CHINFO_BE_W2_TX_PKT_CTRL);
+
+		elem->w3 = le32_encode_bits(ch_info->pkt_id[0], RTW89_H2C_CHINFO_BE_W3_PKT0) |
+			   le32_encode_bits(ch_info->pkt_id[1], RTW89_H2C_CHINFO_BE_W3_PKT1) |
+			   le32_encode_bits(ch_info->pkt_id[2], RTW89_H2C_CHINFO_BE_W3_PKT2) |
+			   le32_encode_bits(ch_info->pkt_id[3], RTW89_H2C_CHINFO_BE_W3_PKT3);
+
+		elem->w4 = le32_encode_bits(ch_info->pkt_id[4], RTW89_H2C_CHINFO_BE_W4_PKT4) |
+			   le32_encode_bits(ch_info->pkt_id[5], RTW89_H2C_CHINFO_BE_W4_PKT5) |
+			   le32_encode_bits(ch_info->pkt_id[6], RTW89_H2C_CHINFO_BE_W4_PKT6) |
+			   le32_encode_bits(ch_info->pkt_id[7], RTW89_H2C_CHINFO_BE_W4_PKT7);
+
+		elem->w5 = le32_encode_bits(ch_info->sw_def, RTW89_H2C_CHINFO_BE_W5_SW_DEF) |
+			   le32_encode_bits(ch_info->fw_probe0_ssids,
+					    RTW89_H2C_CHINFO_BE_W5_FW_PROBE0_SSIDS);
+
+		elem->w6 = le32_encode_bits(ch_info->fw_probe0_shortssids,
+					    RTW89_H2C_CHINFO_BE_W6_FW_PROBE0_SHORTSSIDS) |
+			   le32_encode_bits(ch_info->fw_probe0_bssids,
+					    RTW89_H2C_CHINFO_BE_W6_FW_PROBE0_BSSIDS);
+	}
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_MAC, H2C_CL_MAC_FW_OFLD,
+			      H2C_FUNC_ADD_SCANOFLD_CH, 1, 1, skb_len);
+
+	cond = RTW89_SCANOFLD_WAIT_COND_ADD_CH;
+
+	ret = rtw89_h2c_tx_and_wait(rtwdev, skb, wait, cond);
+	if (ret) {
+		rtw89_debug(rtwdev, RTW89_DBG_FW, "failed to add scan ofld ch\n");
+		return ret;
+	}
+
+	return 0;
+}
+
 int rtw89_fw_h2c_scan_offload(struct rtw89_dev *rtwdev,
 			      struct rtw89_scan_option *option,
 			      struct rtw89_vif *rtwvif)
@@ -4769,8 +4865,66 @@ static void rtw89_hw_scan_add_chan(struct rtw89_dev *rtwdev, int chan_type,
 	}
 }
 
-static int rtw89_hw_scan_add_chan_list(struct rtw89_dev *rtwdev,
-				       struct rtw89_vif *rtwvif, bool connected)
+static void rtw89_hw_scan_add_chan_be(struct rtw89_dev *rtwdev, int chan_type,
+				      int ssid_num,
+				      struct rtw89_mac_chinfo_be *ch_info)
+{
+	struct rtw89_hw_scan_info *scan_info = &rtwdev->scan_info;
+	struct ieee80211_vif *vif = rtwdev->scan_info.scanning_vif;
+	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
+	struct cfg80211_scan_request *req = rtwvif->scan_req;
+	struct rtw89_pktofld_info *info;
+	u8 band, probe_count = 0, i;
+
+	ch_info->notify_action = RTW89_SCANOFLD_DEBUG_MASK;
+	ch_info->dfs_ch = chan_type == RTW89_CHAN_DFS;
+	ch_info->bw = RTW89_SCAN_WIDTH;
+	ch_info->tx_null = false;
+	ch_info->pause_data = false;
+	ch_info->probe_id = RTW89_SCANOFLD_PKT_NONE;
+
+	if (ssid_num) {
+		band = rtw89_hw_to_nl80211_band(ch_info->ch_band);
+
+		list_for_each_entry(info, &scan_info->pkt_list[band], list) {
+			if (info->channel_6ghz &&
+			    ch_info->pri_ch != info->channel_6ghz)
+				continue;
+			ch_info->pkt_id[probe_count++] = info->id;
+			if (probe_count >= RTW89_SCANOFLD_MAX_SSID)
+				break;
+		}
+	}
+
+	if (ch_info->ch_band == RTW89_BAND_6G) {
+		if ((ssid_num == 1 && req->ssids[0].ssid_len == 0) ||
+		    !ch_info->is_psc) {
+			ch_info->probe_id = RTW89_SCANOFLD_PKT_NONE;
+			if (!req->duration_mandatory)
+				ch_info->period -= RTW89_DWELL_TIME_6G;
+		}
+	}
+
+	for (i = probe_count; i < RTW89_SCANOFLD_MAX_SSID; i++)
+		ch_info->pkt_id[i] = RTW89_SCANOFLD_PKT_NONE;
+
+	switch (chan_type) {
+	case RTW89_CHAN_DFS:
+		if (ch_info->ch_band != RTW89_BAND_6G)
+			ch_info->period =
+				max_t(u8, ch_info->period, RTW89_DFS_CHAN_TIME);
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
+int rtw89_hw_scan_add_chan_list(struct rtw89_dev *rtwdev,
+				struct rtw89_vif *rtwvif, bool connected)
 {
 	struct cfg80211_scan_request *req = rtwvif->scan_req;
 	struct rtw89_mac_chinfo	*ch_info, *tmp;
@@ -4846,9 +5000,69 @@ static int rtw89_hw_scan_add_chan_list(struct rtw89_dev *rtwdev,
 	return ret;
 }
 
+int rtw89_hw_scan_add_chan_list_be(struct rtw89_dev *rtwdev,
+				   struct rtw89_vif *rtwvif, bool connected)
+{
+	struct cfg80211_scan_request *req = rtwvif->scan_req;
+	struct rtw89_mac_chinfo_be *ch_info, *tmp;
+	struct ieee80211_channel *channel;
+	struct list_head chan_list;
+	enum rtw89_chan_type type;
+	int list_len, ret;
+	bool random_seq;
+	u32 idx;
+
+	random_seq = !!(req->flags & NL80211_SCAN_FLAG_RANDOM_SN);
+	INIT_LIST_HEAD(&chan_list);
+
+	for (idx = rtwdev->scan_info.last_chan_idx, list_len = 0;
+	     idx < req->n_channels && list_len < RTW89_SCAN_LIST_LIMIT;
+	     idx++, list_len++) {
+		channel = req->channels[idx];
+		ch_info = kzalloc(sizeof(*ch_info), GFP_KERNEL);
+		if (!ch_info) {
+			ret = -ENOMEM;
+			goto out;
+		}
+
+		if (req->duration_mandatory)
+			ch_info->period = req->duration;
+		else if (channel->band == NL80211_BAND_6GHZ)
+			ch_info->period = RTW89_CHANNEL_TIME_6G + RTW89_DWELL_TIME_6G;
+		else
+			ch_info->period = RTW89_CHANNEL_TIME;
+
+		ch_info->ch_band = rtw89_nl80211_to_hw_band(channel->band);
+		ch_info->central_ch = channel->hw_value;
+		ch_info->pri_ch = channel->hw_value;
+		ch_info->rand_seq_num = random_seq;
+		ch_info->is_psc = cfg80211_channel_is_psc(channel);
+
+		if (channel->flags & (IEEE80211_CHAN_RADAR | IEEE80211_CHAN_NO_IR))
+			type = RTW89_CHAN_DFS;
+		else
+			type = RTW89_CHAN_ACTIVE;
+		rtw89_hw_scan_add_chan_be(rtwdev, type, req->n_ssids, ch_info);
+
+		list_add_tail(&ch_info->list, &chan_list);
+	}
+
+	rtwdev->scan_info.last_chan_idx = idx;
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
 static int rtw89_hw_scan_prehandle(struct rtw89_dev *rtwdev,
 				   struct rtw89_vif *rtwvif, bool connected)
 {
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	int ret;
 
 	ret = rtw89_hw_scan_update_probe_req(rtwdev, rtwvif);
@@ -4856,7 +5070,7 @@ static int rtw89_hw_scan_prehandle(struct rtw89_dev *rtwdev,
 		rtw89_err(rtwdev, "Update probe request failed\n");
 		goto out;
 	}
-	ret = rtw89_hw_scan_add_chan_list(rtwdev, rtwvif, connected);
+	ret = mac->add_chan_list(rtwdev, rtwvif, connected);
 out:
 	return ret;
 }
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index cb5b7bf88177..132809ea05bf 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -297,6 +297,34 @@ struct rtw89_mac_chinfo {
 	bool is_psc;
 };
 
+struct rtw89_mac_chinfo_be {
+	u8 period;
+	u8 dwell_time;
+	u8 central_ch;
+	u8 pri_ch;
+	u8 bw:3;
+	u8 ch_band:2;
+	u8 dfs_ch:1;
+	u8 pause_data:1;
+	u8 tx_null:1;
+	u8 rand_seq_num:1;
+	u8 notify_action:5;
+	u8 probe_id;
+	u8 leave_crit;
+	u8 chkpt_timer;
+	u8 leave_time;
+	u8 leave_th;
+	u16 tx_pkt_ctrl;
+	u8 pkt_id[RTW89_SCANOFLD_MAX_SSID];
+	u8 sw_def;
+	u16 fw_probe0_ssids;
+	u16 fw_probe0_shortssids;
+	u16 fw_probe0_bssids;
+
+	struct list_head list;
+	bool is_psc;
+};
+
 struct rtw89_scan_option {
 	bool enable;
 	bool target_ch_mode;
@@ -2708,14 +2736,57 @@ struct rtw89_h2c_chinfo_elem {
 #define RTW89_H2C_CHINFO_W3_PKT7 GENMASK(31, 24)
 #define RTW89_H2C_CHINFO_W4_POWER_IDX GENMASK(15, 0)
 
+struct rtw89_h2c_chinfo_elem_be {
+	__le32 w0;
+	__le32 w1;
+	__le32 w2;
+	__le32 w3;
+	__le32 w4;
+	__le32 w5;
+	__le32 w6;
+} __packed;
+
+#define RTW89_H2C_CHINFO_BE_W0_PERIOD GENMASK(7, 0)
+#define RTW89_H2C_CHINFO_BE_W0_DWELL GENMASK(15, 8)
+#define RTW89_H2C_CHINFO_BE_W0_CENTER_CH GENMASK(23, 16)
+#define RTW89_H2C_CHINFO_BE_W0_PRI_CH GENMASK(31, 24)
+#define RTW89_H2C_CHINFO_BE_W1_BW GENMASK(2, 0)
+#define RTW89_H2C_CHINFO_BE_W1_CH_BAND GENMASK(4, 3)
+#define RTW89_H2C_CHINFO_BE_W1_DFS BIT(5)
+#define RTW89_H2C_CHINFO_BE_W1_PAUSE_DATA BIT(6)
+#define RTW89_H2C_CHINFO_BE_W1_TX_NULL BIT(7)
+#define RTW89_H2C_CHINFO_BE_W1_RANDOM BIT(8)
+#define RTW89_H2C_CHINFO_BE_W1_NOTIFY GENMASK(13, 9)
+#define RTW89_H2C_CHINFO_BE_W1_PROBE BIT(14)
+#define RTW89_H2C_CHINFO_BE_W1_EARLY_LEAVE_CRIT GENMASK(17, 15)
+#define RTW89_H2C_CHINFO_BE_W1_CHKPT_TIMER GENMASK(31, 24)
+#define RTW89_H2C_CHINFO_BE_W2_EARLY_LEAVE_TIME GENMASK(7, 0)
+#define RTW89_H2C_CHINFO_BE_W2_EARLY_LEAVE_TH GENMASK(15, 8)
+#define RTW89_H2C_CHINFO_BE_W2_TX_PKT_CTRL GENMASK(31, 16)
+#define RTW89_H2C_CHINFO_BE_W3_PKT0 GENMASK(7, 0)
+#define RTW89_H2C_CHINFO_BE_W3_PKT1 GENMASK(15, 8)
+#define RTW89_H2C_CHINFO_BE_W3_PKT2 GENMASK(23, 16)
+#define RTW89_H2C_CHINFO_BE_W3_PKT3 GENMASK(31, 24)
+#define RTW89_H2C_CHINFO_BE_W4_PKT4 GENMASK(7, 0)
+#define RTW89_H2C_CHINFO_BE_W4_PKT5 GENMASK(15, 8)
+#define RTW89_H2C_CHINFO_BE_W4_PKT6 GENMASK(23, 16)
+#define RTW89_H2C_CHINFO_BE_W4_PKT7 GENMASK(31, 24)
+#define RTW89_H2C_CHINFO_BE_W5_SW_DEF GENMASK(7, 0)
+#define RTW89_H2C_CHINFO_BE_W5_FW_PROBE0_SSIDS GENMASK(31, 16)
+#define RTW89_H2C_CHINFO_BE_W6_FW_PROBE0_SHORTSSIDS GENMASK(15, 0)
+#define RTW89_H2C_CHINFO_BE_W6_FW_PROBE0_BSSIDS GENMASK(31, 16)
+
 struct rtw89_h2c_chinfo {
 	u8 ch_num;
 	u8 elem_size;
+	u8 arg;
 	u8 rsvd0;
-	u8 rsvd1;
 	struct rtw89_h2c_chinfo_elem elem[] __counted_by(ch_num);
 } __packed;
 
+#define RTW89_H2C_CHINFO_ARG_MAC_IDX_MASK BIT(0)
+#define RTW89_H2C_CHINFO_ARG_APPEND_MASK BIT(1)
+
 struct rtw89_h2c_scanofld {
 	__le32 w0;
 	__le32 w1;
@@ -3933,6 +4004,8 @@ int rtw89_fw_h2c_add_pkt_offload(struct rtw89_dev *rtwdev, u8 *id,
 				 struct sk_buff *skb_ofld);
 int rtw89_fw_h2c_scan_list_offload(struct rtw89_dev *rtwdev, int ch_num,
 				   struct list_head *chan_list);
+int rtw89_fw_h2c_scan_list_offload_be(struct rtw89_dev *rtwdev, int ch_num,
+				      struct list_head *chan_list);
 int rtw89_fw_h2c_scan_offload(struct rtw89_dev *rtwdev,
 			      struct rtw89_scan_option *opt,
 			      struct rtw89_vif *vif);
@@ -3975,6 +4048,10 @@ void rtw89_hw_scan_complete(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
 int rtw89_hw_scan_offload(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
 			  bool enable);
 void rtw89_hw_scan_abort(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif);
+int rtw89_hw_scan_add_chan_list(struct rtw89_dev *rtwdev,
+				struct rtw89_vif *rtwvif, bool connected);
+int rtw89_hw_scan_add_chan_list_be(struct rtw89_dev *rtwdev,
+				   struct rtw89_vif *rtwvif, bool connected);
 int rtw89_fw_h2c_trigger_cpu_exception(struct rtw89_dev *rtwdev);
 int rtw89_fw_h2c_pkt_drop(struct rtw89_dev *rtwdev,
 			  const struct rtw89_pkt_drop_params *params);
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 6d29a1d7b85f..ba2157bdd1d1 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -6224,5 +6224,7 @@ const struct rtw89_mac_gen_def rtw89_mac_gen_ax = {
 	.dump_err_status = rtw89_mac_dump_err_status_ax,
 
 	.is_txq_empty = mac_is_txq_empty_ax,
+
+	.add_chan_list = rtw89_hw_scan_add_chan_list,
 };
 EXPORT_SYMBOL(rtw89_mac_gen_ax);
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 181d03d1f78a..8948ea4422b4 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -952,6 +952,9 @@ struct rtw89_mac_gen_def {
 				enum mac_ax_err_info err);
 
 	bool (*is_txq_empty)(struct rtw89_dev *rtwdev);
+
+	int (*add_chan_list)(struct rtw89_dev *rtwdev,
+			     struct rtw89_vif *rtwvif, bool connected);
 };
 
 extern const struct rtw89_mac_gen_def rtw89_mac_gen_ax;
diff --git a/drivers/net/wireless/realtek/rtw89/mac_be.c b/drivers/net/wireless/realtek/rtw89/mac_be.c
index 4befbe06cd15..177d87c998df 100644
--- a/drivers/net/wireless/realtek/rtw89/mac_be.c
+++ b/drivers/net/wireless/realtek/rtw89/mac_be.c
@@ -2268,5 +2268,7 @@ const struct rtw89_mac_gen_def rtw89_mac_gen_be = {
 	.dump_err_status = rtw89_mac_dump_err_status_be,
 
 	.is_txq_empty = mac_is_txq_empty_be,
+
+	.add_chan_list = rtw89_hw_scan_add_chan_list_be,
 };
 EXPORT_SYMBOL(rtw89_mac_gen_be);
-- 
2.25.1


