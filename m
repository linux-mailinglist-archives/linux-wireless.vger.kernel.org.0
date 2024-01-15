Return-Path: <linux-wireless+bounces-1909-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE7282D368
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jan 2024 04:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7B741C20A2E
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jan 2024 03:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE6D256A;
	Mon, 15 Jan 2024 03:38:28 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439392568
	for <linux-wireless@vger.kernel.org>; Mon, 15 Jan 2024 03:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 40F3cKE213528810, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 40F3cKE213528810
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jan 2024 11:38:20 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Mon, 15 Jan 2024 11:38:21 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 15 Jan
 2024 11:38:20 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH 4/8] wifi: rtw89: fw: update TX AMPDU parameter to CMAC table
Date: Mon, 15 Jan 2024 11:37:38 +0800
Message-ID: <20240115033742.16372-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240115033742.16372-1-pkshih@realtek.com>
References: <20240115033742.16372-1-pkshih@realtek.com>
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

The CMAC table is used to define how hardware TX a certain packet, and
we can specify TX AMPDU size, so hardware can prepare proper retry window
buffer. Otherwise, it can't transmit with expected aggregation number.
Since each TID could have different aggregation number, the smallest number
is adopted to prevent over peer's receiving buffer.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     |  4 ++
 drivers/net/wireless/realtek/rtw89/fw.c       | 66 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/fw.h       | 15 +++++
 drivers/net/wireless/realtek/rtw89/mac80211.c |  4 ++
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |  1 +
 9 files changed, 94 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 3a56fcaf892a..8f4be9184427 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2933,6 +2933,7 @@ struct rtw89_sta {
 	struct ewma_evm evm_min[RF_PATH_MAX];
 	struct ewma_evm evm_max[RF_PATH_MAX];
 	struct rtw89_ampdu_params ampdu_params[IEEE80211_NUM_TIDS];
+	DECLARE_BITMAP(ampdu_map, IEEE80211_NUM_TIDS);
 	struct ieee80211_rx_status rx_status;
 	u16 rx_hw_rate;
 	__le32 htc_template;
@@ -3200,6 +3201,9 @@ struct rtw89_chip_ops {
 	int (*h2c_assoc_cmac_tbl)(struct rtw89_dev *rtwdev,
 				  struct ieee80211_vif *vif,
 				  struct ieee80211_sta *sta);
+	int (*h2c_ampdu_cmac_tbl)(struct rtw89_dev *rtwdev,
+				  struct ieee80211_vif *vif,
+				  struct ieee80211_sta *sta);
 	int (*h2c_update_beacon)(struct rtw89_dev *rtwdev,
 				 struct rtw89_vif *rtwvif);
 	int (*h2c_ba_cam)(struct rtw89_dev *rtwdev, struct rtw89_sta *rtwsta,
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index fc1295d5d8e8..3181cde5ab93 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -2404,6 +2404,72 @@ int rtw89_fw_h2c_assoc_cmac_tbl_g7(struct rtw89_dev *rtwdev,
 }
 EXPORT_SYMBOL(rtw89_fw_h2c_assoc_cmac_tbl_g7);
 
+int rtw89_fw_h2c_ampdu_cmac_tbl_g7(struct rtw89_dev *rtwdev,
+				   struct ieee80211_vif *vif,
+				   struct ieee80211_sta *sta)
+{
+	struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
+	struct rtw89_h2c_cctlinfo_ud_g7 *h2c;
+	u32 len = sizeof(*h2c);
+	struct sk_buff *skb;
+	u16 agg_num = 0;
+	u8 ba_bmap = 0;
+	int ret;
+	u8 tid;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for ampdu cmac g7\n");
+		return -ENOMEM;
+	}
+	skb_put(skb, len);
+	h2c = (struct rtw89_h2c_cctlinfo_ud_g7 *)skb->data;
+
+	for_each_set_bit(tid, rtwsta->ampdu_map, IEEE80211_NUM_TIDS) {
+		if (agg_num == 0)
+			agg_num = rtwsta->ampdu_params[tid].agg_num;
+		else
+			agg_num = min(agg_num, rtwsta->ampdu_params[tid].agg_num);
+	}
+
+	if (agg_num <= 0x20)
+		ba_bmap = 3;
+	else if (agg_num > 0x20 && agg_num <= 0x40)
+		ba_bmap = 0;
+	else if (agg_num > 0x40 && agg_num <= 0x80)
+		ba_bmap = 1;
+	else if (agg_num > 0x80 && agg_num <= 0x100)
+		ba_bmap = 2;
+	else if (agg_num > 0x100 && agg_num <= 0x200)
+		ba_bmap = 4;
+	else if (agg_num > 0x200 && agg_num <= 0x400)
+		ba_bmap = 5;
+
+	h2c->c0 = le32_encode_bits(rtwsta->mac_id, CCTLINFO_G7_C0_MACID) |
+		  le32_encode_bits(1, CCTLINFO_G7_C0_OP);
+
+	h2c->w3 = le32_encode_bits(ba_bmap, CCTLINFO_G7_W3_BA_BMAP);
+	h2c->m3 = cpu_to_le32(CCTLINFO_G7_W3_BA_BMAP);
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_MAC, H2C_CL_MAC_FR_EXCHG,
+			      H2C_FUNC_MAC_CCTLINFO_UD_G7, 0, 0,
+			      len);
+
+	ret = rtw89_h2c_tx(rtwdev, skb, false);
+	if (ret) {
+		rtw89_err(rtwdev, "failed to send h2c\n");
+		goto fail;
+	}
+
+	return 0;
+fail:
+	dev_kfree_skb_any(skb);
+
+	return ret;
+}
+EXPORT_SYMBOL(rtw89_fw_h2c_ampdu_cmac_tbl_g7);
+
 int rtw89_fw_h2c_txtime_cmac_tbl(struct rtw89_dev *rtwdev,
 				 struct rtw89_sta *rtwsta)
 {
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index f1f119358b28..b9159278dd4b 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -3946,6 +3946,9 @@ int rtw89_fw_h2c_assoc_cmac_tbl(struct rtw89_dev *rtwdev,
 int rtw89_fw_h2c_assoc_cmac_tbl_g7(struct rtw89_dev *rtwdev,
 				   struct ieee80211_vif *vif,
 				   struct ieee80211_sta *sta);
+int rtw89_fw_h2c_ampdu_cmac_tbl_g7(struct rtw89_dev *rtwdev,
+				   struct ieee80211_vif *vif,
+				   struct ieee80211_sta *sta);
 int rtw89_fw_h2c_txtime_cmac_tbl(struct rtw89_dev *rtwdev,
 				 struct rtw89_sta *rtwsta);
 int rtw89_fw_h2c_txpath_cmac_tbl(struct rtw89_dev *rtwdev,
@@ -4103,6 +4106,18 @@ static inline int rtw89_chip_h2c_assoc_cmac_tbl(struct rtw89_dev *rtwdev,
 	return chip->ops->h2c_assoc_cmac_tbl(rtwdev, vif, sta);
 }
 
+static inline int rtw89_chip_h2c_ampdu_cmac_tbl(struct rtw89_dev *rtwdev,
+						struct ieee80211_vif *vif,
+						struct ieee80211_sta *sta)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+
+	if (chip->ops->h2c_ampdu_cmac_tbl)
+		return chip->ops->h2c_ampdu_cmac_tbl(rtwdev, vif, sta);
+
+	return 0;
+}
+
 static inline
 int rtw89_chip_h2c_ba_cam(struct rtw89_dev *rtwdev, struct rtw89_sta *rtwsta,
 			  bool valid, struct ieee80211_ampdu_params *params)
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index 71d5e6f7bb64..21b42984fd8a 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -660,6 +660,8 @@ static int rtw89_ops_ampdu_action(struct ieee80211_hw *hw,
 	case IEEE80211_AMPDU_TX_STOP_FLUSH_CONT:
 		mutex_lock(&rtwdev->mutex);
 		clear_bit(RTW89_TXQ_F_AMPDU, &rtwtxq->flags);
+		clear_bit(tid, rtwsta->ampdu_map);
+		rtw89_chip_h2c_ampdu_cmac_tbl(rtwdev, vif, sta);
 		mutex_unlock(&rtwdev->mutex);
 		ieee80211_stop_tx_ba_cb_irqsafe(vif, sta->addr, tid);
 		break;
@@ -668,7 +670,9 @@ static int rtw89_ops_ampdu_action(struct ieee80211_hw *hw,
 		set_bit(RTW89_TXQ_F_AMPDU, &rtwtxq->flags);
 		rtwsta->ampdu_params[tid].agg_num = params->buf_size;
 		rtwsta->ampdu_params[tid].amsdu = params->amsdu;
+		set_bit(tid, rtwsta->ampdu_map);
 		rtw89_leave_ps_mode(rtwdev);
+		rtw89_chip_h2c_ampdu_cmac_tbl(rtwdev, vif, sta);
 		mutex_unlock(&rtwdev->mutex);
 		break;
 	case IEEE80211_AMPDU_RX_START:
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index 2a4e7bd53e89..ed9d47ff6d97 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -2335,6 +2335,7 @@ static const struct rtw89_chip_ops rtw8851b_chip_ops = {
 	.resume_sch_tx		= rtw89_mac_resume_sch_tx,
 	.h2c_dctl_sec_cam	= NULL,
 	.h2c_assoc_cmac_tbl	= rtw89_fw_h2c_assoc_cmac_tbl,
+	.h2c_ampdu_cmac_tbl	= NULL,
 	.h2c_update_beacon	= rtw89_fw_h2c_update_beacon,
 	.h2c_ba_cam		= rtw89_fw_h2c_ba_cam,
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 3190268dcea9..df6299800ba1 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2079,6 +2079,7 @@ static const struct rtw89_chip_ops rtw8852a_chip_ops = {
 	.resume_sch_tx		= rtw89_mac_resume_sch_tx,
 	.h2c_dctl_sec_cam	= NULL,
 	.h2c_assoc_cmac_tbl	= rtw89_fw_h2c_assoc_cmac_tbl,
+	.h2c_ampdu_cmac_tbl	= NULL,
 	.h2c_update_beacon	= rtw89_fw_h2c_update_beacon,
 	.h2c_ba_cam		= rtw89_fw_h2c_ba_cam,
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index 4f312e61a88e..0ace2accb663 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -2504,6 +2504,7 @@ static const struct rtw89_chip_ops rtw8852b_chip_ops = {
 	.resume_sch_tx		= rtw89_mac_resume_sch_tx,
 	.h2c_dctl_sec_cam	= NULL,
 	.h2c_assoc_cmac_tbl	= rtw89_fw_h2c_assoc_cmac_tbl,
+	.h2c_ampdu_cmac_tbl	= NULL,
 	.h2c_update_beacon	= rtw89_fw_h2c_update_beacon,
 	.h2c_ba_cam		= rtw89_fw_h2c_ba_cam,
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 6b660a6660bd..124b5e38f13e 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -2849,6 +2849,7 @@ static const struct rtw89_chip_ops rtw8852c_chip_ops = {
 	.resume_sch_tx		= rtw89_mac_resume_sch_tx_v1,
 	.h2c_dctl_sec_cam	= rtw89_fw_h2c_dctl_sec_cam_v1,
 	.h2c_assoc_cmac_tbl	= rtw89_fw_h2c_assoc_cmac_tbl,
+	.h2c_ampdu_cmac_tbl	= NULL,
 	.h2c_update_beacon	= rtw89_fw_h2c_update_beacon,
 	.h2c_ba_cam		= rtw89_fw_h2c_ba_cam,
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index abcf9d604cac..ff166654d9b0 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -824,6 +824,7 @@ static const struct rtw89_chip_ops rtw8922a_chip_ops = {
 	.pwr_off_func		= rtw8922a_pwr_off_func,
 	.h2c_dctl_sec_cam	= rtw89_fw_h2c_dctl_sec_cam_v2,
 	.h2c_assoc_cmac_tbl	= rtw89_fw_h2c_assoc_cmac_tbl_g7,
+	.h2c_ampdu_cmac_tbl	= rtw89_fw_h2c_ampdu_cmac_tbl_g7,
 	.h2c_update_beacon	= rtw89_fw_h2c_update_beacon_be,
 	.h2c_ba_cam		= rtw89_fw_h2c_ba_cam_v1,
 };
-- 
2.25.1


