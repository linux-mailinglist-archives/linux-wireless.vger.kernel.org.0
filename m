Return-Path: <linux-wireless+bounces-2226-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05323832581
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jan 2024 09:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B27ED283A7C
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jan 2024 08:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA9228E07;
	Fri, 19 Jan 2024 08:15:44 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F76288CF
	for <linux-wireless@vger.kernel.org>; Fri, 19 Jan 2024 08:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705652144; cv=none; b=ozLV+/4lh2eV6HbM661YbsHdxTsCGBXoVZMdyxX+Jgb3tabhN3gOEgQvBssPHVoaZMmYHFQpiiKO2CY+fJRN2bLSb84WypF1rHuK/f7/xTFgyLO2Deh1qDD4Wyndh8YDRIZtl3bU48hptt0RlUcHsjTkN7ppQxTsd2UXSGpPUV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705652144; c=relaxed/simple;
	bh=/x+oNL0FRDBIolQouzxwSnMbz9CvEoK/cF2ccL8eJbQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tz7X6I6WzklMhIlyUyJXjUt+iky/e3NHHyC0dlaITgEvkxOcfsABhEH4kIf3VbUrKSWpkO6OmGqxRjIzn1bLqrEm5kBBg8sHLGkdQt2Az9iKoqF7YjgrG3LG7fNH1f6IZZbaOk5s7634sg7edihccpTpubOKbLyNtB45zGZDM94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 40J8FTXA02212422, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 40J8FTXA02212422
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jan 2024 16:15:29 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Fri, 19 Jan 2024 16:15:29 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 19 Jan
 2024 16:15:29 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <gary.chang@realtek.com>, <phhuang@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/8] wifi: rtw89: refine add_chan H2C command to encode_bits
Date: Fri, 19 Jan 2024 16:14:54 +0800
Message-ID: <20240119081501.25223-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240119081501.25223-1-pkshih@realtek.com>
References: <20240119081501.25223-1-pkshih@realtek.com>
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

Use struct filling style instead of pointer casting.
This does not change the original behavior.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c |  71 +++++-----
 drivers/net/wireless/realtek/rtw89/fw.h | 171 ++++++------------------
 2 files changed, 80 insertions(+), 162 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 362ea2e228d2..d967120a8813 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -3996,55 +3996,60 @@ int rtw89_fw_h2c_add_pkt_offload(struct rtw89_dev *rtwdev, u8 *id,
 	return 0;
 }
 
-#define H2C_LEN_SCAN_LIST_OFFLOAD 4
-int rtw89_fw_h2c_scan_list_offload(struct rtw89_dev *rtwdev, int len,
+int rtw89_fw_h2c_scan_list_offload(struct rtw89_dev *rtwdev, int ch_num,
 				   struct list_head *chan_list)
 {
 	struct rtw89_wait_info *wait = &rtwdev->mac.fw_ofld_wait;
+	struct rtw89_h2c_chinfo_elem *elem;
 	struct rtw89_mac_chinfo *ch_info;
+	struct rtw89_h2c_chinfo *h2c;
 	struct sk_buff *skb;
-	int skb_len = H2C_LEN_SCAN_LIST_OFFLOAD + len * RTW89_MAC_CHINFO_SIZE;
 	unsigned int cond;
-	u8 *cmd;
+	int skb_len;
 	int ret;
 
+	static_assert(sizeof(*elem) == RTW89_MAC_CHINFO_SIZE);
+
+	skb_len = struct_size(h2c, elem, ch_num);
 	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, skb_len);
 	if (!skb) {
 		rtw89_err(rtwdev, "failed to alloc skb for h2c scan list\n");
 		return -ENOMEM;
 	}
-	skb_put(skb, H2C_LEN_SCAN_LIST_OFFLOAD);
-	cmd = skb->data;
+	skb_put(skb, sizeof(*h2c));
+	h2c = (struct rtw89_h2c_chinfo *)skb->data;
 
-	RTW89_SET_FWCMD_SCANOFLD_CH_NUM(cmd, len);
-	/* in unit of 4 bytes */
-	RTW89_SET_FWCMD_SCANOFLD_CH_SIZE(cmd, RTW89_MAC_CHINFO_SIZE / 4);
+	h2c->ch_num = ch_num;
+	h2c->elem_size = sizeof(*elem) / 4; /* in unit of 4 bytes */
 
 	list_for_each_entry(ch_info, chan_list, list) {
-		cmd = skb_put(skb, RTW89_MAC_CHINFO_SIZE);
-
-		RTW89_SET_FWCMD_CHINFO_PERIOD(cmd, ch_info->period);
-		RTW89_SET_FWCMD_CHINFO_DWELL(cmd, ch_info->dwell_time);
-		RTW89_SET_FWCMD_CHINFO_CENTER_CH(cmd, ch_info->central_ch);
-		RTW89_SET_FWCMD_CHINFO_PRI_CH(cmd, ch_info->pri_ch);
-		RTW89_SET_FWCMD_CHINFO_BW(cmd, ch_info->bw);
-		RTW89_SET_FWCMD_CHINFO_ACTION(cmd, ch_info->notify_action);
-		RTW89_SET_FWCMD_CHINFO_NUM_PKT(cmd, ch_info->num_pkt);
-		RTW89_SET_FWCMD_CHINFO_TX(cmd, ch_info->tx_pkt);
-		RTW89_SET_FWCMD_CHINFO_PAUSE_DATA(cmd, ch_info->pause_data);
-		RTW89_SET_FWCMD_CHINFO_BAND(cmd, ch_info->ch_band);
-		RTW89_SET_FWCMD_CHINFO_PKT_ID(cmd, ch_info->probe_id);
-		RTW89_SET_FWCMD_CHINFO_DFS(cmd, ch_info->dfs_ch);
-		RTW89_SET_FWCMD_CHINFO_TX_NULL(cmd, ch_info->tx_null);
-		RTW89_SET_FWCMD_CHINFO_RANDOM(cmd, ch_info->rand_seq_num);
-		RTW89_SET_FWCMD_CHINFO_PKT0(cmd, ch_info->pkt_id[0]);
-		RTW89_SET_FWCMD_CHINFO_PKT1(cmd, ch_info->pkt_id[1]);
-		RTW89_SET_FWCMD_CHINFO_PKT2(cmd, ch_info->pkt_id[2]);
-		RTW89_SET_FWCMD_CHINFO_PKT3(cmd, ch_info->pkt_id[3]);
-		RTW89_SET_FWCMD_CHINFO_PKT4(cmd, ch_info->pkt_id[4]);
-		RTW89_SET_FWCMD_CHINFO_PKT5(cmd, ch_info->pkt_id[5]);
-		RTW89_SET_FWCMD_CHINFO_PKT6(cmd, ch_info->pkt_id[6]);
-		RTW89_SET_FWCMD_CHINFO_PKT7(cmd, ch_info->pkt_id[7]);
+		elem = (struct rtw89_h2c_chinfo_elem *)skb_put(skb, sizeof(*elem));
+
+		elem->w0 = le32_encode_bits(ch_info->period, RTW89_H2C_CHINFO_W0_PERIOD) |
+			   le32_encode_bits(ch_info->dwell_time, RTW89_H2C_CHINFO_W0_DWELL) |
+			   le32_encode_bits(ch_info->central_ch, RTW89_H2C_CHINFO_W0_CENTER_CH) |
+			   le32_encode_bits(ch_info->pri_ch, RTW89_H2C_CHINFO_W0_PRI_CH);
+
+		elem->w1 = le32_encode_bits(ch_info->bw, RTW89_H2C_CHINFO_W1_BW) |
+			   le32_encode_bits(ch_info->notify_action, RTW89_H2C_CHINFO_W1_ACTION) |
+			   le32_encode_bits(ch_info->num_pkt, RTW89_H2C_CHINFO_W1_NUM_PKT) |
+			   le32_encode_bits(ch_info->tx_pkt, RTW89_H2C_CHINFO_W1_TX) |
+			   le32_encode_bits(ch_info->pause_data, RTW89_H2C_CHINFO_W1_PAUSE_DATA) |
+			   le32_encode_bits(ch_info->ch_band, RTW89_H2C_CHINFO_W1_BAND) |
+			   le32_encode_bits(ch_info->probe_id, RTW89_H2C_CHINFO_W1_PKT_ID) |
+			   le32_encode_bits(ch_info->dfs_ch, RTW89_H2C_CHINFO_W1_DFS) |
+			   le32_encode_bits(ch_info->tx_null, RTW89_H2C_CHINFO_W1_TX_NULL) |
+			   le32_encode_bits(ch_info->rand_seq_num, RTW89_H2C_CHINFO_W1_RANDOM);
+
+		elem->w2 = le32_encode_bits(ch_info->pkt_id[0], RTW89_H2C_CHINFO_W2_PKT0) |
+			   le32_encode_bits(ch_info->pkt_id[1], RTW89_H2C_CHINFO_W2_PKT1) |
+			   le32_encode_bits(ch_info->pkt_id[2], RTW89_H2C_CHINFO_W2_PKT2) |
+			   le32_encode_bits(ch_info->pkt_id[3], RTW89_H2C_CHINFO_W2_PKT3);
+
+		elem->w3 = le32_encode_bits(ch_info->pkt_id[4], RTW89_H2C_CHINFO_W3_PKT4) |
+			   le32_encode_bits(ch_info->pkt_id[5], RTW89_H2C_CHINFO_W3_PKT5) |
+			   le32_encode_bits(ch_info->pkt_id[6], RTW89_H2C_CHINFO_W3_PKT6) |
+			   le32_encode_bits(ch_info->pkt_id[7], RTW89_H2C_CHINFO_W3_PKT7);
 	}
 
 	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 7a80f45ce27b..c5f1fdff9fe0 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -2659,135 +2659,48 @@ static inline void RTW89_SET_FWCMD_PACKET_OFLD_PKT_LENGTH(void *cmd, u32 val)
 	le32p_replace_bits((__le32 *)((u8 *)(cmd)), val, GENMASK(31, 16));
 }
 
-static inline void RTW89_SET_FWCMD_SCANOFLD_CH_NUM(void *cmd, u32 val)
-{
-	le32p_replace_bits((__le32 *)((u8 *)(cmd)), val, GENMASK(7, 0));
-}
-
-static inline void RTW89_SET_FWCMD_SCANOFLD_CH_SIZE(void *cmd, u32 val)
-{
-	le32p_replace_bits((__le32 *)((u8 *)(cmd)), val, GENMASK(15, 8));
-}
-
-static inline void RTW89_SET_FWCMD_CHINFO_PERIOD(void *cmd, u32 val)
-{
-	le32p_replace_bits((__le32 *)((u8 *)(cmd)), val, GENMASK(7, 0));
-}
-
-static inline void RTW89_SET_FWCMD_CHINFO_DWELL(void *cmd, u32 val)
-{
-	le32p_replace_bits((__le32 *)((u8 *)(cmd)), val, GENMASK(15, 8));
-}
-
-static inline void RTW89_SET_FWCMD_CHINFO_CENTER_CH(void *cmd, u32 val)
-{
-	le32p_replace_bits((__le32 *)((u8 *)(cmd)), val, GENMASK(23, 16));
-}
-
-static inline void RTW89_SET_FWCMD_CHINFO_PRI_CH(void *cmd, u32 val)
-{
-	le32p_replace_bits((__le32 *)((u8 *)(cmd)), val, GENMASK(31, 24));
-}
-
-static inline void RTW89_SET_FWCMD_CHINFO_BW(void *cmd, u32 val)
-{
-	le32p_replace_bits((__le32 *)((u8 *)(cmd) + 4), val, GENMASK(2, 0));
-}
-
-static inline void RTW89_SET_FWCMD_CHINFO_ACTION(void *cmd, u32 val)
-{
-	le32p_replace_bits((__le32 *)((u8 *)(cmd) + 4), val, GENMASK(7, 3));
-}
-
-static inline void RTW89_SET_FWCMD_CHINFO_NUM_PKT(void *cmd, u32 val)
-{
-	le32p_replace_bits((__le32 *)((u8 *)(cmd) + 4), val, GENMASK(11, 8));
-}
-
-static inline void RTW89_SET_FWCMD_CHINFO_TX(void *cmd, u32 val)
-{
-	le32p_replace_bits((__le32 *)((u8 *)(cmd) + 4), val, BIT(12));
-}
-
-static inline void RTW89_SET_FWCMD_CHINFO_PAUSE_DATA(void *cmd, u32 val)
-{
-	le32p_replace_bits((__le32 *)((u8 *)(cmd) + 4), val, BIT(13));
-}
-
-static inline void RTW89_SET_FWCMD_CHINFO_BAND(void *cmd, u32 val)
-{
-	le32p_replace_bits((__le32 *)((u8 *)(cmd) + 4), val, GENMASK(15, 14));
-}
-
-static inline void RTW89_SET_FWCMD_CHINFO_PKT_ID(void *cmd, u32 val)
-{
-	le32p_replace_bits((__le32 *)((u8 *)(cmd) + 4), val, GENMASK(23, 16));
-}
-
-static inline void RTW89_SET_FWCMD_CHINFO_DFS(void *cmd, u32 val)
-{
-	le32p_replace_bits((__le32 *)((u8 *)(cmd) + 4), val, BIT(24));
-}
-
-static inline void RTW89_SET_FWCMD_CHINFO_TX_NULL(void *cmd, u32 val)
-{
-	le32p_replace_bits((__le32 *)((u8 *)(cmd) + 4), val, BIT(25));
-}
-
-static inline void RTW89_SET_FWCMD_CHINFO_RANDOM(void *cmd, u32 val)
-{
-	le32p_replace_bits((__le32 *)((u8 *)(cmd) + 4), val, BIT(26));
-}
-
-static inline void RTW89_SET_FWCMD_CHINFO_CFG_TX(void *cmd, u32 val)
-{
-	le32p_replace_bits((__le32 *)((u8 *)(cmd) + 4), val, BIT(27));
-}
-
-static inline void RTW89_SET_FWCMD_CHINFO_PKT0(void *cmd, u32 val)
-{
-	le32p_replace_bits((__le32 *)((u8 *)(cmd) + 8), val, GENMASK(7, 0));
-}
-
-static inline void RTW89_SET_FWCMD_CHINFO_PKT1(void *cmd, u32 val)
-{
-	le32p_replace_bits((__le32 *)((u8 *)(cmd) + 8), val, GENMASK(15, 8));
-}
-
-static inline void RTW89_SET_FWCMD_CHINFO_PKT2(void *cmd, u32 val)
-{
-	le32p_replace_bits((__le32 *)((u8 *)(cmd) + 8), val, GENMASK(23, 16));
-}
-
-static inline void RTW89_SET_FWCMD_CHINFO_PKT3(void *cmd, u32 val)
-{
-	le32p_replace_bits((__le32 *)((u8 *)(cmd) + 8), val, GENMASK(31, 24));
-}
-
-static inline void RTW89_SET_FWCMD_CHINFO_PKT4(void *cmd, u32 val)
-{
-	le32p_replace_bits((__le32 *)((u8 *)(cmd) + 12), val, GENMASK(7, 0));
-}
-
-static inline void RTW89_SET_FWCMD_CHINFO_PKT5(void *cmd, u32 val)
-{
-	le32p_replace_bits((__le32 *)((u8 *)(cmd) + 12), val, GENMASK(15, 8));
-}
-
-static inline void RTW89_SET_FWCMD_CHINFO_PKT6(void *cmd, u32 val)
-{
-	le32p_replace_bits((__le32 *)((u8 *)(cmd) + 12), val, GENMASK(23, 16));
-}
-
-static inline void RTW89_SET_FWCMD_CHINFO_PKT7(void *cmd, u32 val)
-{
-	le32p_replace_bits((__le32 *)((u8 *)(cmd) + 12), val, GENMASK(31, 24));
-}
+struct rtw89_h2c_chinfo_elem {
+	__le32 w0;
+	__le32 w1;
+	__le32 w2;
+	__le32 w3;
+	__le32 w4;
+	__le32 w5;
+	__le32 w6;
+} __packed;
 
-static inline void RTW89_SET_FWCMD_CHINFO_POWER_IDX(void *cmd, u32 val)
-{
-	le32p_replace_bits((__le32 *)((u8 *)(cmd) + 16), val, GENMASK(15, 0));
-}
+#define RTW89_H2C_CHINFO_W0_PERIOD GENMASK(7, 0)
+#define RTW89_H2C_CHINFO_W0_DWELL GENMASK(15, 8)
+#define RTW89_H2C_CHINFO_W0_CENTER_CH GENMASK(23, 16)
+#define RTW89_H2C_CHINFO_W0_PRI_CH GENMASK(31, 24)
+#define RTW89_H2C_CHINFO_W1_BW GENMASK(2, 0)
+#define RTW89_H2C_CHINFO_W1_ACTION GENMASK(7, 3)
+#define RTW89_H2C_CHINFO_W1_NUM_PKT GENMASK(11, 8)
+#define RTW89_H2C_CHINFO_W1_TX BIT(12)
+#define RTW89_H2C_CHINFO_W1_PAUSE_DATA BIT(13)
+#define RTW89_H2C_CHINFO_W1_BAND GENMASK(15, 14)
+#define RTW89_H2C_CHINFO_W1_PKT_ID GENMASK(23, 16)
+#define RTW89_H2C_CHINFO_W1_DFS BIT(24)
+#define RTW89_H2C_CHINFO_W1_TX_NULL BIT(25)
+#define RTW89_H2C_CHINFO_W1_RANDOM BIT(26)
+#define RTW89_H2C_CHINFO_W1_CFG_TX BIT(27)
+#define RTW89_H2C_CHINFO_W2_PKT0 GENMASK(7, 0)
+#define RTW89_H2C_CHINFO_W2_PKT1 GENMASK(15, 8)
+#define RTW89_H2C_CHINFO_W2_PKT2 GENMASK(23, 16)
+#define RTW89_H2C_CHINFO_W2_PKT3 GENMASK(31, 24)
+#define RTW89_H2C_CHINFO_W3_PKT4 GENMASK(7, 0)
+#define RTW89_H2C_CHINFO_W3_PKT5 GENMASK(15, 8)
+#define RTW89_H2C_CHINFO_W3_PKT6 GENMASK(23, 16)
+#define RTW89_H2C_CHINFO_W3_PKT7 GENMASK(31, 24)
+#define RTW89_H2C_CHINFO_W4_POWER_IDX GENMASK(15, 0)
+
+struct rtw89_h2c_chinfo {
+	u8 ch_num;
+	u8 elem_size;
+	u8 rsvd0;
+	u8 rsvd1;
+	struct rtw89_h2c_chinfo_elem elem[] __counted_by(ch_num);
+} __packed;
 
 struct rtw89_h2c_scanofld {
 	__le32 w0;
@@ -3990,7 +3903,7 @@ int rtw89_fw_h2c_cxdrv_rfk(struct rtw89_dev *rtwdev);
 int rtw89_fw_h2c_del_pkt_offload(struct rtw89_dev *rtwdev, u8 id);
 int rtw89_fw_h2c_add_pkt_offload(struct rtw89_dev *rtwdev, u8 *id,
 				 struct sk_buff *skb_ofld);
-int rtw89_fw_h2c_scan_list_offload(struct rtw89_dev *rtwdev, int len,
+int rtw89_fw_h2c_scan_list_offload(struct rtw89_dev *rtwdev, int ch_num,
 				   struct list_head *chan_list);
 int rtw89_fw_h2c_scan_offload(struct rtw89_dev *rtwdev,
 			      struct rtw89_scan_option *opt,
-- 
2.25.1


