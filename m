Return-Path: <linux-wireless+bounces-23928-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DC1AD38A8
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Jun 2025 15:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF0BE9E63B6
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Jun 2025 13:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05BD82D8DA6;
	Tue, 10 Jun 2025 13:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="vcofD3hV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01AC2DFA3B
	for <linux-wireless@vger.kernel.org>; Tue, 10 Jun 2025 13:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749560468; cv=none; b=K2Xkzz6h/9frsBC7yScOMZXM6KEdGAEB55P+NwUXvPuxs4c/lXBnndjd3vVNyTRDEFRzA6kHNlG4H8DrMWTdL+USnt/2ykFBU86AkYeiI46RAzKDwpd78afPFhf43p1PqQmoygqDkpqROJXxXyuRzj7mdQE4FUJsfHf1YRZPE5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749560468; c=relaxed/simple;
	bh=v9neStw+3ArDCHxCxBKrYiQgClZd/1OffmhWS/s6G+A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YVGYXbkSKlxIjzjdiMJxej/xmGW2jkp9uoj24OE4DByPX8KBXQPfBhy4GeoinN4CJIi43ctYnupQkFKd+dLNRVKcmfMR2KxDLigmSOXlMQ204YV3LjWi15Dzca7C6O+OVpGuzpYclX0WIlTiw+wOdksALXuAZLHncH2mPjgMJos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=vcofD3hV; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55AD11Mx82995421, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1749560461; bh=edRrvRTSakc63m2r5JHcROVAWy/hOXPkLfwHNqyjsoQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=vcofD3hVdUKYH9djHC8T1JgyeTIzB9rPZSxpXwBIewblAFf92GCkSCzPvivbsM1L/
	 EBSaz+nz1GBqV2PtHYbPUao/Fb0Oa7UmnTzL/okzDXXxgrKwQTEqZsazkHfLUOVjvK
	 CmLhSU/8iiycCA1ejerjRXn82AS0ZodZjSf/AAzvNiQXpx1DaH+RFL6a/4pGDvwiv6
	 qJ0Z+2+5aPnRZ6JnAiNP+6jRQXhQYWIvgSMbI0MGUgj4ZK05z1iLjaIk/BX3uLkN18
	 12HsYqLVkZ1vn9NradCka0r3sAv5gOsWF2gF1TdjSRWk+fEUClVHSyHkKM+0Dcrzga
	 WAMxTK2If5zSg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55AD11Mx82995421
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 10 Jun 2025 21:01:01 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 10 Jun 2025 21:01:01 +0800
Received: from [127.0.1.1] (10.22.225.18) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 10 Jun
 2025 21:01:00 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 01/12] wifi: rtw89: extend HW scan of WiFi 6 chips for extra OP chan when concurrency
Date: Tue, 10 Jun 2025 21:00:23 +0800
Message-ID: <20250610130034.14692-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250610130034.14692-1-pkshih@realtek.com>
References: <20250610130034.14692-1-pkshih@realtek.com>
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

From: Zong-Zhe Yang <kevin_yang@realtek.com>

HW scan flow has considered the timing when to get back op for the scanning
interface. But, when concurrency, there are two interfaces with connection.
The OP channel of another one was not back originally. It then easily lead
to connection loss when scanning during concurrency. So, HW scan flow is
extended to deal with second OP channel. And, H2C command is also extended
to fill second MAC ID.

The changes mentioned above are done for WiFi 6 chips first. HW scan has
different handling architectures including FW and driver on WiFi 7 chips.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h |   8 ++
 drivers/net/wireless/realtek/rtw89/fw.c   | 136 +++++++++++++++++++---
 drivers/net/wireless/realtek/rtw89/fw.h   |   7 +-
 drivers/net/wireless/realtek/rtw89/mac.c  |  66 +++++++++--
 4 files changed, 191 insertions(+), 26 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index c93d3ea2b0a4..dca76b1c1029 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4524,6 +4524,7 @@ enum rtw89_fw_feature {
 	RTW89_FW_FEATURE_NO_PHYCAP_P1,
 	RTW89_FW_FEATURE_NO_POWER_DIFFERENCE,
 	RTW89_FW_FEATURE_BEACON_LOSS_COUNT_V1,
+	RTW89_FW_FEATURE_SCAN_OFFLOAD_EXTRA_OP,
 };
 
 struct rtw89_fw_suit {
@@ -5451,11 +5452,18 @@ struct rtw89_early_h2c {
 	u16 h2c_len;
 };
 
+struct rtw89_hw_scan_extra_op {
+	bool set;
+	u8 macid;
+	struct rtw89_chan chan;
+};
+
 struct rtw89_hw_scan_info {
 	struct rtw89_vif_link *scanning_vif;
 	struct list_head pkt_list[NUM_NL80211_BANDS];
 	struct list_head chan_list;
 	struct rtw89_chan op_chan;
+	struct rtw89_hw_scan_extra_op extra_op;
 	bool connected;
 	bool abort;
 };
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 95865eafb2cd..06fb97a05a89 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -5363,6 +5363,7 @@ static
 int rtw89_fw_h2c_scan_list_offload_ax(struct rtw89_dev *rtwdev, int ch_num,
 				      struct list_head *chan_list)
 {
+	struct rtw89_hw_scan_info *scan_info = &rtwdev->scan_info;
 	struct rtw89_wait_info *wait = &rtwdev->mac.fw_ofld_wait;
 	struct rtw89_h2c_chinfo_elem *elem;
 	struct rtw89_mac_chinfo_ax *ch_info;
@@ -5405,6 +5406,10 @@ int rtw89_fw_h2c_scan_list_offload_ax(struct rtw89_dev *rtwdev, int ch_num,
 			   le32_encode_bits(ch_info->tx_null, RTW89_H2C_CHINFO_W1_TX_NULL) |
 			   le32_encode_bits(ch_info->rand_seq_num, RTW89_H2C_CHINFO_W1_RANDOM);
 
+		if (scan_info->extra_op.set)
+			elem->w1 |= le32_encode_bits(ch_info->macid_tx,
+						     RTW89_H2C_CHINFO_W1_MACID_TX);
+
 		elem->w2 = le32_encode_bits(ch_info->pkt_id[0], RTW89_H2C_CHINFO_W2_PKT0) |
 			   le32_encode_bits(ch_info->pkt_id[1], RTW89_H2C_CHINFO_W2_PKT1) |
 			   le32_encode_bits(ch_info->pkt_id[2], RTW89_H2C_CHINFO_W2_PKT2) |
@@ -5545,6 +5550,7 @@ int rtw89_fw_h2c_scan_offload_ax(struct rtw89_dev *rtwdev,
 				 struct rtw89_vif_link *rtwvif_link,
 				 bool wowlan)
 {
+	struct rtw89_hw_scan_info *scan_info = &rtwdev->scan_info;
 	struct rtw89_wait_info *wait = &rtwdev->mac.fw_ofld_wait;
 	struct rtw89_chan *op = &rtwdev->scan_info.op_chan;
 	enum rtw89_scan_mode scan_mode = RTW89_SCAN_IMMEDIATE;
@@ -5604,6 +5610,10 @@ int rtw89_fw_h2c_scan_offload_ax(struct rtw89_dev *rtwdev,
 	h2c->tsf_low = le32_encode_bits(lower_32_bits(tsf),
 					RTW89_H2C_SCANOFLD_W4_TSF_LOW);
 
+	if (scan_info->extra_op.set)
+		h2c->w6 = le32_encode_bits(scan_info->extra_op.macid,
+					   RTW89_H2C_SCANOFLD_W6_SECOND_MACID);
+
 	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
 			      H2C_CAT_MAC, H2C_CL_MAC_FW_OFLD,
 			      H2C_FUNC_SCANOFLD, 1, 1,
@@ -6933,6 +6943,7 @@ static void rtw89_hw_scan_add_chan_ax(struct rtw89_dev *rtwdev, int chan_type,
 {
 	struct rtw89_hw_scan_info *scan_info = &rtwdev->scan_info;
 	struct rtw89_vif_link *rtwvif_link = rtwdev->scan_info.scanning_vif;
+	const struct rtw89_hw_scan_extra_op *ext = &scan_info->extra_op;
 	struct rtw89_vif *rtwvif = rtwvif_link->rtwvif;
 	struct ieee80211_scan_ies *ies = rtwvif->scan_ies;
 	struct cfg80211_scan_request *req = rtwvif->scan_req;
@@ -7003,6 +7014,15 @@ static void rtw89_hw_scan_add_chan_ax(struct rtw89_dev *rtwdev, int chan_type,
 	case RTW89_CHAN_ACTIVE:
 		ch_info->pause_data = true;
 		break;
+	case RTW89_CHAN_EXTRA_OP:
+		ch_info->central_ch = ext->chan.channel;
+		ch_info->pri_ch = ext->chan.primary_channel;
+		ch_info->ch_band = ext->chan.band_type;
+		ch_info->bw = ext->chan.band_width;
+		ch_info->tx_null = true;
+		ch_info->num_pkt = 0;
+		ch_info->macid_tx = true;
+		break;
 	default:
 		rtw89_err(rtwdev, "Channel type out of bound\n");
 	}
@@ -7161,10 +7181,45 @@ int rtw89_pno_scan_add_chan_list_ax(struct rtw89_dev *rtwdev,
 	return ret;
 }
 
+static int rtw89_hw_scan_add_op_types_ax(struct rtw89_dev *rtwdev,
+					 enum rtw89_chan_type type,
+					 struct list_head *chan_list,
+					 struct cfg80211_scan_request *req,
+					 int *off_chan_time)
+{
+	struct rtw89_mac_chinfo_ax *tmp;
+
+	tmp = kzalloc(sizeof(*tmp), GFP_KERNEL);
+	if (!tmp)
+		return -ENOMEM;
+
+	switch (type) {
+	case RTW89_CHAN_OPERATE:
+		tmp->period = req->duration_mandatory ?
+			      req->duration : RTW89_CHANNEL_TIME;
+		*off_chan_time = 0;
+		break;
+	case RTW89_CHAN_EXTRA_OP:
+		tmp->period = RTW89_CHANNEL_TIME_EXTRA_OP;
+		/* still calc @off_chan_time for scan op */
+		*off_chan_time += tmp->period;
+		break;
+	default:
+		kfree(tmp);
+		return -EINVAL;
+	}
+
+	rtw89_hw_scan_add_chan_ax(rtwdev, type, 0, tmp);
+	list_add_tail(&tmp->list, chan_list);
+
+	return 0;
+}
+
 int rtw89_hw_scan_prep_chan_list_ax(struct rtw89_dev *rtwdev,
 				    struct rtw89_vif_link *rtwvif_link)
 {
 	struct rtw89_hw_scan_info *scan_info = &rtwdev->scan_info;
+	const struct rtw89_hw_scan_extra_op *ext = &scan_info->extra_op;
 	struct rtw89_vif *rtwvif = rtwvif_link->rtwvif;
 	struct cfg80211_scan_request *req = rtwvif->scan_req;
 	struct rtw89_mac_chinfo_ax *ch_info, *tmp;
@@ -7207,22 +7262,28 @@ int rtw89_hw_scan_prep_chan_list_ax(struct rtw89_dev *rtwdev,
 			type = RTW89_CHAN_ACTIVE;
 		rtw89_hw_scan_add_chan_ax(rtwdev, type, req->n_ssids, ch_info);
 
-		if (scan_info->connected &&
-		    off_chan_time + ch_info->period > RTW89_OFF_CHAN_TIME) {
-			tmp = kzalloc(sizeof(*tmp), GFP_KERNEL);
-			if (!tmp) {
-				ret = -ENOMEM;
-				kfree(ch_info);
-				goto out;
-			}
+		if (!(scan_info->connected &&
+		      off_chan_time + ch_info->period > RTW89_OFF_CHAN_TIME))
+			goto next;
 
-			type = RTW89_CHAN_OPERATE;
-			tmp->period = req->duration_mandatory ?
-				      req->duration : RTW89_CHANNEL_TIME;
-			rtw89_hw_scan_add_chan_ax(rtwdev, type, 0, tmp);
-			list_add_tail(&tmp->list, &chan_list);
-			off_chan_time = 0;
+		ret = rtw89_hw_scan_add_op_types_ax(rtwdev, RTW89_CHAN_OPERATE,
+						    &chan_list, req, &off_chan_time);
+		if (ret) {
+			kfree(ch_info);
+			goto out;
 		}
+
+		if (!ext->set)
+			goto next;
+
+		ret = rtw89_hw_scan_add_op_types_ax(rtwdev, RTW89_CHAN_EXTRA_OP,
+						    &chan_list, req, &off_chan_time);
+		if (ret) {
+			kfree(ch_info);
+			goto out;
+		}
+
+next:
 		list_add_tail(&ch_info->list, &chan_list);
 		off_chan_time += ch_info->period;
 	}
@@ -7524,6 +7585,47 @@ static void rtw89_hw_scan_update_beacon_noa(struct rtw89_dev *rtwdev,
 	}
 }
 
+static void rtw89_hw_scan_set_extra_op_info(struct rtw89_dev *rtwdev,
+					    struct rtw89_vif *scan_rtwvif,
+					    const struct rtw89_chan *scan_op)
+{
+	struct rtw89_entity_mgnt *mgnt = &rtwdev->hal.entity_mgnt;
+	struct rtw89_hw_scan_info *scan_info = &rtwdev->scan_info;
+	struct rtw89_hw_scan_extra_op *ext = &scan_info->extra_op;
+	struct rtw89_vif *tmp;
+
+	ext->set = false;
+	if (!RTW89_CHK_FW_FEATURE(SCAN_OFFLOAD_EXTRA_OP, &rtwdev->fw))
+		return;
+
+	list_for_each_entry(tmp, &mgnt->active_list, mgnt_entry) {
+		const struct rtw89_chan *tmp_chan;
+		struct rtw89_vif_link *tmp_link;
+
+		if (tmp == scan_rtwvif)
+			continue;
+
+		tmp_link = rtw89_vif_get_link_inst(tmp, 0);
+		if (unlikely(!tmp_link)) {
+			rtw89_debug(rtwdev, RTW89_DBG_HW_SCAN,
+				    "hw scan: no HW-0 link for extra op\n");
+			continue;
+		}
+
+		tmp_chan = rtw89_chan_get(rtwdev, tmp_link->chanctx_idx);
+		*ext = (struct rtw89_hw_scan_extra_op){
+			.set = true,
+			.macid = tmp_link->mac_id,
+			.chan = *tmp_chan,
+		};
+
+		rtw89_debug(rtwdev, RTW89_DBG_HW_SCAN,
+			    "hw scan: extra op: center %d primary %d\n",
+			    ext->chan.channel, ext->chan.primary_channel);
+		break;
+	}
+}
+
 int rtw89_hw_scan_start(struct rtw89_dev *rtwdev,
 			struct rtw89_vif_link *rtwvif_link,
 			struct ieee80211_scan_request *scan_req)
@@ -7546,6 +7648,12 @@ int rtw89_hw_scan_start(struct rtw89_dev *rtwdev,
 	/* clone op and keep it during scan */
 	rtwdev->scan_info.op_chan = *chan;
 
+	rtw89_debug(rtwdev, RTW89_DBG_HW_SCAN,
+		    "hw scan: op: center %d primary %d\n",
+		    chan->channel, chan->primary_channel);
+
+	rtw89_hw_scan_set_extra_op_info(rtwdev, rtwvif, chan);
+
 	rtwdev->scan_info.connected = rtw89_is_any_vif_connected_or_connecting(rtwdev);
 	rtwdev->scan_info.scanning_vif = rtwvif_link;
 	rtwdev->scan_info.abort = false;
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 14f55b10be2e..36abf1b59240 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -237,6 +237,7 @@ enum rtw89_chan_type {
 	RTW89_CHAN_OPERATE = 0,
 	RTW89_CHAN_ACTIVE,
 	RTW89_CHAN_DFS,
+	RTW89_CHAN_EXTRA_OP,
 };
 
 enum rtw89_p2pps_action {
@@ -316,6 +317,7 @@ struct rtw89_fw_macid_pause_sleep_grp {
 #define RTW89_H2C_MAX_SIZE 2048
 #define RTW89_CHANNEL_TIME 45
 #define RTW89_CHANNEL_TIME_6G 20
+#define RTW89_CHANNEL_TIME_EXTRA_OP 30
 #define RTW89_DFS_CHAN_TIME 105
 #define RTW89_OFF_CHAN_TIME 100
 #define RTW89_DWELL_TIME 20
@@ -352,7 +354,8 @@ struct rtw89_mac_chinfo_ax {
 	u8 tx_null:1;
 	u8 rand_seq_num:1;
 	u8 cfg_tx_pwr:1;
-	u8 rsvd0: 4;
+	u8 macid_tx: 1;
+	u8 rsvd0: 3;
 	u8 pkt_id[RTW89_SCANOFLD_MAX_SSID];
 	u16 tx_pwr_idx;
 	u8 rsvd1;
@@ -2674,6 +2677,7 @@ struct rtw89_h2c_chinfo_elem {
 #define RTW89_H2C_CHINFO_W1_TX_NULL BIT(25)
 #define RTW89_H2C_CHINFO_W1_RANDOM BIT(26)
 #define RTW89_H2C_CHINFO_W1_CFG_TX BIT(27)
+#define RTW89_H2C_CHINFO_W1_MACID_TX BIT(29)
 #define RTW89_H2C_CHINFO_W2_PKT0 GENMASK(7, 0)
 #define RTW89_H2C_CHINFO_W2_PKT1 GENMASK(15, 8)
 #define RTW89_H2C_CHINFO_W2_PKT2 GENMASK(23, 16)
@@ -2773,6 +2777,7 @@ struct rtw89_h2c_scanofld {
 #define RTW89_H2C_SCANOFLD_W2_SLOW_PD GENMASK(23, 16)
 #define RTW89_H2C_SCANOFLD_W3_TSF_HIGH GENMASK(31, 0)
 #define RTW89_H2C_SCANOFLD_W4_TSF_LOW GENMASK(31, 0)
+#define RTW89_H2C_SCANOFLD_W6_SECOND_MACID GENMASK(31, 24)
 
 struct rtw89_h2c_scanofld_be_macc_role {
 	__le32 w0;
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 4bd5e2728ce5..8ec86e1fa9d6 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -4388,7 +4388,33 @@ static void rtw89_mac_port_cfg_tx_sw_by_nettype(struct rtw89_dev *rtwdev,
 	rtw89_mac_port_cfg_tx_sw(rtwdev, rtwvif_link, en);
 }
 
-void rtw89_mac_enable_beacon_for_ap_vifs(struct rtw89_dev *rtwdev, bool en)
+static void rtw89_mac_enable_ap_bcn_by_chan(struct rtw89_dev *rtwdev,
+					    struct rtw89_vif_link *rtwvif_link,
+					    const struct rtw89_chan *to_match,
+					    bool en)
+{
+	const struct rtw89_chan *chan;
+
+	if (rtwvif_link->net_type != RTW89_NET_TYPE_AP_MODE)
+		return;
+
+	if (!to_match)
+		goto doit;
+
+	/* @to_match may not be in the same domain as return of calling
+	 * rtw89_chan_get(). So, cannot compare their addresses directly.
+	 */
+	chan = rtw89_chan_get(rtwdev, rtwvif_link->chanctx_idx);
+	if (chan->channel != to_match->channel)
+		return;
+
+doit:
+	rtw89_mac_port_cfg_tx_sw(rtwdev, rtwvif_link, en);
+}
+
+static void rtw89_mac_enable_aps_bcn_by_chan(struct rtw89_dev *rtwdev,
+					     const struct rtw89_chan *to_match,
+					     bool en)
 {
 	struct rtw89_vif_link *rtwvif_link;
 	struct rtw89_vif *rtwvif;
@@ -4396,8 +4422,13 @@ void rtw89_mac_enable_beacon_for_ap_vifs(struct rtw89_dev *rtwdev, bool en)
 
 	rtw89_for_each_rtwvif(rtwdev, rtwvif)
 		rtw89_vif_for_each_link(rtwvif, rtwvif_link, link_id)
-			if (rtwvif_link->net_type == RTW89_NET_TYPE_AP_MODE)
-				rtw89_mac_port_cfg_tx_sw(rtwdev, rtwvif_link, en);
+			rtw89_mac_enable_ap_bcn_by_chan(rtwdev, rtwvif_link,
+							to_match, en);
+}
+
+void rtw89_mac_enable_beacon_for_ap_vifs(struct rtw89_dev *rtwdev, bool en)
+{
+	rtw89_mac_enable_aps_bcn_by_chan(rtwdev, NULL, en);
 }
 
 static void rtw89_mac_port_cfg_bcn_intv(struct rtw89_dev *rtwdev,
@@ -4891,11 +4922,22 @@ rtw89_mac_c2h_macid_pause(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 len
 {
 }
 
-static bool rtw89_is_op_chan(struct rtw89_dev *rtwdev, u8 band, u8 channel)
+static const struct rtw89_chan *
+rtw89_hw_scan_search_op_chan(struct rtw89_dev *rtwdev, u8 band, u8 channel)
 {
+	struct rtw89_hw_scan_info *scan_info = &rtwdev->scan_info;
 	const struct rtw89_chan *op = &rtwdev->scan_info.op_chan;
 
-	return band == op->band_type && channel == op->primary_channel;
+	if (band == op->band_type && channel == op->primary_channel)
+		return op;
+
+	if (scan_info->extra_op.set) {
+		op = &scan_info->extra_op.chan;
+		if (band == op->band_type && channel == op->primary_channel)
+			return op;
+	}
+
+	return NULL;
 }
 
 static void
@@ -4905,6 +4947,7 @@ rtw89_mac_c2h_scanofld_rsp(struct rtw89_dev *rtwdev, struct sk_buff *skb,
 	const struct rtw89_c2h_scanofld *c2h =
 		(const struct rtw89_c2h_scanofld *)skb->data;
 	struct rtw89_vif_link *rtwvif_link = rtwdev->scan_info.scanning_vif;
+	const struct rtw89_chan *op_chan;
 	struct rtw89_vif *rtwvif;
 	struct rtw89_chan new;
 	u16 actual_period, expect_period;
@@ -4960,8 +5003,9 @@ rtw89_mac_c2h_scanofld_rsp(struct rtw89_dev *rtwdev, struct sk_buff *skb,
 	switch (reason) {
 	case RTW89_SCAN_LEAVE_OP_NOTIFY:
 	case RTW89_SCAN_LEAVE_CH_NOTIFY:
-		if (rtw89_is_op_chan(rtwdev, band, chan)) {
-			rtw89_mac_enable_beacon_for_ap_vifs(rtwdev, false);
+		op_chan = rtw89_hw_scan_search_op_chan(rtwdev, band, chan);
+		if (op_chan) {
+			rtw89_mac_enable_aps_bcn_by_chan(rtwdev, op_chan, false);
 			ieee80211_stop_queues(rtwdev->hw);
 		}
 		return;
@@ -4982,10 +5026,10 @@ rtw89_mac_c2h_scanofld_rsp(struct rtw89_dev *rtwdev, struct sk_buff *skb,
 		break;
 	case RTW89_SCAN_ENTER_OP_NOTIFY:
 	case RTW89_SCAN_ENTER_CH_NOTIFY:
-		if (rtw89_is_op_chan(rtwdev, band, chan)) {
-			rtw89_assign_entity_chan(rtwdev, rtwvif_link->chanctx_idx,
-						 &rtwdev->scan_info.op_chan);
-			rtw89_mac_enable_beacon_for_ap_vifs(rtwdev, true);
+		op_chan = rtw89_hw_scan_search_op_chan(rtwdev, band, chan);
+		if (op_chan) {
+			rtw89_assign_entity_chan(rtwdev, rtwvif_link->chanctx_idx, op_chan);
+			rtw89_mac_enable_aps_bcn_by_chan(rtwdev, op_chan, true);
 			ieee80211_wake_queues(rtwdev->hw);
 		} else {
 			rtw89_chan_create(&new, chan, chan, band,
-- 
2.25.1


