Return-Path: <linux-wireless+bounces-1575-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF60826A5C
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jan 2024 10:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 550711C21B2C
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jan 2024 09:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7660B12B6C;
	Mon,  8 Jan 2024 09:12:01 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4D8101F1
	for <linux-wireless@vger.kernel.org>; Mon,  8 Jan 2024 09:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4089Bq0pA3872872, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4089Bq0pA3872872
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Jan 2024 17:11:52 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 8 Jan 2024 17:11:52 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXDAG02.realtek.com.tw
 (172.21.6.101) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 8 Jan 2024
 17:11:52 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH 01/10] wifi: rtw89: add firmware H2C command of BA CAM V1
Date: Mon, 8 Jan 2024 17:11:25 +0800
Message-ID: <20240108091134.67007-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240108091134.67007-1-pkshih@realtek.com>
References: <20240108091134.67007-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXDAG02.realtek.com.tw (172.21.6.101)
X-KSE-ServerInfo: RTEXDAG02.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

BA CAM is used to generate BA frame for received AMPDU packets. To support
WiFi 7, change format from V0 to have more fields and enlarge entry number
for new need.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 74 +++++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/fw.h | 20 +++++++
 2 files changed, 94 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 09684cea9731..4cda96f15ecc 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -1609,6 +1609,80 @@ void rtw89_fw_h2c_init_dynamic_ba_cam_v0_ext(struct rtw89_dev *rtwdev)
 	}
 }
 
+int rtw89_fw_h2c_ba_cam_v1(struct rtw89_dev *rtwdev, struct rtw89_sta *rtwsta,
+			   bool valid, struct ieee80211_ampdu_params *params)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	struct rtw89_vif *rtwvif = rtwsta->rtwvif;
+	struct rtw89_h2c_ba_cam_v1 *h2c;
+	u8 macid = rtwsta->mac_id;
+	u32 len = sizeof(*h2c);
+	struct sk_buff *skb;
+	u8 entry_idx;
+	u8 bmap_size;
+	int ret;
+
+	ret = valid ?
+	      rtw89_core_acquire_sta_ba_entry(rtwdev, rtwsta, params->tid, &entry_idx) :
+	      rtw89_core_release_sta_ba_entry(rtwdev, rtwsta, params->tid, &entry_idx);
+	if (ret) {
+		/* it still works even if we don't have static BA CAM, because
+		 * hardware can create dynamic BA CAM automatically.
+		 */
+		rtw89_debug(rtwdev, RTW89_DBG_TXRX,
+			    "failed to %s entry tid=%d for h2c ba cam\n",
+			    valid ? "alloc" : "free", params->tid);
+		return 0;
+	}
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for h2c ba cam\n");
+		return -ENOMEM;
+	}
+	skb_put(skb, len);
+	h2c = (struct rtw89_h2c_ba_cam_v1 *)skb->data;
+
+	if (params->buf_size > 512)
+		bmap_size = 10;
+	else if (params->buf_size > 256)
+		bmap_size = 8;
+	else if (params->buf_size > 64)
+		bmap_size = 4;
+	else
+		bmap_size = 0;
+
+	h2c->w0 = le32_encode_bits(valid, RTW89_H2C_BA_CAM_V1_W0_VALID) |
+		  le32_encode_bits(1, RTW89_H2C_BA_CAM_V1_W0_INIT_REQ) |
+		  le32_encode_bits(macid, RTW89_H2C_BA_CAM_V1_W0_MACID_MASK) |
+		  le32_encode_bits(params->tid, RTW89_H2C_BA_CAM_V1_W0_TID_MASK) |
+		  le32_encode_bits(bmap_size, RTW89_H2C_BA_CAM_V1_W0_BMAP_SIZE_MASK) |
+		  le32_encode_bits(params->ssn, RTW89_H2C_BA_CAM_V1_W0_SSN_MASK);
+
+	entry_idx += chip->bacam_dynamic_num; /* std entry right after dynamic ones */
+	h2c->w1 = le32_encode_bits(entry_idx, RTW89_H2C_BA_CAM_V1_W1_ENTRY_IDX_MASK) |
+		  le32_encode_bits(1, RTW89_H2C_BA_CAM_V1_W1_STD_ENTRY_EN) |
+		  le32_encode_bits(!!rtwvif->mac_idx, RTW89_H2C_BA_CAM_V1_W1_BAND_SEL);
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_MAC,
+			      H2C_CL_BA_CAM,
+			      H2C_FUNC_MAC_BA_CAM_V1, 0, 1,
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
+
 #define H2C_LOG_CFG_LEN 12
 int rtw89_fw_h2c_fw_log(struct rtw89_dev *rtwdev, bool enable)
 {
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 01016588b1fc..b7f564d30378 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -1796,6 +1796,23 @@ static inline void SET_BA_CAM_ENTRY_IDX_V1(void *h2c, u32 val)
 	le32p_replace_bits((__le32 *)h2c + 1, val, GENMASK(31, 28));
 }
 
+struct rtw89_h2c_ba_cam_v1 {
+	__le32 w0;
+	__le32 w1;
+} __packed;
+
+#define RTW89_H2C_BA_CAM_V1_W0_VALID BIT(0)
+#define RTW89_H2C_BA_CAM_V1_W0_INIT_REQ BIT(1)
+#define RTW89_H2C_BA_CAM_V1_W0_TID_MASK GENMASK(7, 4)
+#define RTW89_H2C_BA_CAM_V1_W0_MACID_MASK GENMASK(15, 8)
+#define RTW89_H2C_BA_CAM_V1_W0_BMAP_SIZE_MASK GENMASK(19, 16)
+#define RTW89_H2C_BA_CAM_V1_W0_SSN_MASK GENMASK(31, 20)
+#define RTW89_H2C_BA_CAM_V1_W1_UID_VALUE_MASK GENMASK(7, 0)
+#define RTW89_H2C_BA_CAM_V1_W1_STD_ENTRY_EN BIT(8)
+#define RTW89_H2C_BA_CAM_V1_W1_BAND_SEL BIT(9)
+#define RTW89_H2C_BA_CAM_V1_W1_MLD_EN BIT(10)
+#define RTW89_H2C_BA_CAM_V1_W1_ENTRY_IDX_MASK GENMASK(31, 24)
+
 static inline void SET_LPS_PARM_MACID(void *h2c, u32 val)
 {
 	le32p_replace_bits((__le32 *)h2c, val, GENMASK(7, 0));
@@ -3690,6 +3707,7 @@ enum rtw89_fw_ofld_h2c_func {
 /* CLASS 12 - BA CAM */
 #define H2C_CL_BA_CAM			0xc
 #define H2C_FUNC_MAC_BA_CAM		0x0
+#define H2C_FUNC_MAC_BA_CAM_V1		0x1
 
 /* CLASS 14 - MCC */
 #define H2C_CL_MCC			0xe
@@ -3898,6 +3916,8 @@ void rtw89_fw_release_general_pkt_list_vif(struct rtw89_dev *rtwdev,
 void rtw89_fw_release_general_pkt_list(struct rtw89_dev *rtwdev, bool notify_fw);
 int rtw89_fw_h2c_ba_cam(struct rtw89_dev *rtwdev, struct rtw89_sta *rtwsta,
 			bool valid, struct ieee80211_ampdu_params *params);
+int rtw89_fw_h2c_ba_cam_v1(struct rtw89_dev *rtwdev, struct rtw89_sta *rtwsta,
+			   bool valid, struct ieee80211_ampdu_params *params);
 void rtw89_fw_h2c_init_dynamic_ba_cam_v0_ext(struct rtw89_dev *rtwdev);
 
 int rtw89_fw_h2c_lps_parm(struct rtw89_dev *rtwdev,
-- 
2.25.1


