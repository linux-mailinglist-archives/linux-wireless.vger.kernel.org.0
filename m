Return-Path: <linux-wireless+bounces-1576-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57DD3826A5D
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jan 2024 10:12:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05F0C2821C0
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jan 2024 09:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5528713AE2;
	Mon,  8 Jan 2024 09:12:04 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499F6134AC
	for <linux-wireless@vger.kernel.org>; Mon,  8 Jan 2024 09:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4089BuJvA3872875, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4089BuJvA3872875
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Jan 2024 17:11:56 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 8 Jan 2024 17:11:56 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXDAG02.realtek.com.tw
 (172.21.6.101) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 8 Jan 2024
 17:11:56 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH 02/10] wifi: rtw89: mac: add feature_init to initialize BA CAM V1
Date: Mon, 8 Jan 2024 17:11:26 +0800
Message-ID: <20240108091134.67007-3-pkshih@realtek.com>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

Add a call of feature_init() when bringing interface up. For now, the
feature is to reset BA CAM V1 that is only used by upcoming 8922A.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c  | 39 ++++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/fw.h  | 11 +++++++
 drivers/net/wireless/realtek/rtw89/mac.c | 26 ++++++++++++++++
 3 files changed, 76 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 4cda96f15ecc..28bf8108a177 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -1683,6 +1683,45 @@ int rtw89_fw_h2c_ba_cam_v1(struct rtw89_dev *rtwdev, struct rtw89_sta *rtwsta,
 	return ret;
 }
 
+int rtw89_fw_h2c_init_ba_cam_users(struct rtw89_dev *rtwdev, u8 users,
+				   u8 offset, u8 mac_idx)
+{
+	struct rtw89_h2c_ba_cam_init *h2c;
+	u32 len = sizeof(*h2c);
+	struct sk_buff *skb;
+	int ret;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for h2c ba cam init\n");
+		return -ENOMEM;
+	}
+	skb_put(skb, len);
+	h2c = (struct rtw89_h2c_ba_cam_init *)skb->data;
+
+	h2c->w0 = le32_encode_bits(users, RTW89_H2C_BA_CAM_INIT_USERS_MASK) |
+		  le32_encode_bits(offset, RTW89_H2C_BA_CAM_INIT_OFFSET_MASK) |
+		  le32_encode_bits(mac_idx, RTW89_H2C_BA_CAM_INIT_BAND_SEL);
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_MAC,
+			      H2C_CL_BA_CAM,
+			      H2C_FUNC_MAC_BA_CAM_INIT, 0, 1,
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
index b7f564d30378..687623fb7e1d 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -1813,6 +1813,14 @@ struct rtw89_h2c_ba_cam_v1 {
 #define RTW89_H2C_BA_CAM_V1_W1_MLD_EN BIT(10)
 #define RTW89_H2C_BA_CAM_V1_W1_ENTRY_IDX_MASK GENMASK(31, 24)
 
+struct rtw89_h2c_ba_cam_init {
+	__le32 w0;
+} __packed;
+
+#define RTW89_H2C_BA_CAM_INIT_USERS_MASK GENMASK(7, 0)
+#define RTW89_H2C_BA_CAM_INIT_OFFSET_MASK GENMASK(19, 12)
+#define RTW89_H2C_BA_CAM_INIT_BAND_SEL BIT(24)
+
 static inline void SET_LPS_PARM_MACID(void *h2c, u32 val)
 {
 	le32p_replace_bits((__le32 *)h2c, val, GENMASK(7, 0));
@@ -3708,6 +3716,7 @@ enum rtw89_fw_ofld_h2c_func {
 #define H2C_CL_BA_CAM			0xc
 #define H2C_FUNC_MAC_BA_CAM		0x0
 #define H2C_FUNC_MAC_BA_CAM_V1		0x1
+#define H2C_FUNC_MAC_BA_CAM_INIT	0x2
 
 /* CLASS 14 - MCC */
 #define H2C_CL_MCC			0xe
@@ -3919,6 +3928,8 @@ int rtw89_fw_h2c_ba_cam(struct rtw89_dev *rtwdev, struct rtw89_sta *rtwsta,
 int rtw89_fw_h2c_ba_cam_v1(struct rtw89_dev *rtwdev, struct rtw89_sta *rtwsta,
 			   bool valid, struct ieee80211_ampdu_params *params);
 void rtw89_fw_h2c_init_dynamic_ba_cam_v0_ext(struct rtw89_dev *rtwdev);
+int rtw89_fw_h2c_init_ba_cam_users(struct rtw89_dev *rtwdev, u8 users,
+				   u8 offset, u8 mac_idx);
 
 int rtw89_fw_h2c_lps_parm(struct rtw89_dev *rtwdev,
 			  struct rtw89_lps_parm *lps_param);
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index c485ef2cc3d3..0d5f91d4adee 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -3676,6 +3676,28 @@ static int trx_init_ax(struct rtw89_dev *rtwdev)
 	return 0;
 }
 
+static int rtw89_mac_feat_init(struct rtw89_dev *rtwdev)
+{
+#define BACAM_1024BMP_OCC_ENTRY 4
+#define BACAM_MAX_RU_SUPPORT_B0_STA 1
+#define BACAM_MAX_RU_SUPPORT_B1_STA 1
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	u8 users, offset;
+
+	if (chip->bacam_ver != RTW89_BACAM_V1)
+		return 0;
+
+	offset = 0;
+	users = BACAM_MAX_RU_SUPPORT_B0_STA;
+	rtw89_fw_h2c_init_ba_cam_users(rtwdev, users, offset, RTW89_MAC_0);
+
+	offset += users * BACAM_1024BMP_OCC_ENTRY;
+	users = BACAM_MAX_RU_SUPPORT_B1_STA;
+	rtw89_fw_h2c_init_ba_cam_users(rtwdev, users, offset, RTW89_MAC_1);
+
+	return 0;
+}
+
 static void rtw89_disable_fw_watchdog(struct rtw89_dev *rtwdev)
 {
 	enum rtw89_core_chip_id chip_id = rtwdev->chip->chip_id;
@@ -3910,6 +3932,10 @@ int rtw89_mac_init(struct rtw89_dev *rtwdev)
 	if (ret)
 		goto fail;
 
+	ret = rtw89_mac_feat_init(rtwdev);
+	if (ret)
+		goto fail;
+
 	if (rtwdev->hci.ops->mac_post_init) {
 		ret = rtwdev->hci.ops->mac_post_init(rtwdev);
 		if (ret)
-- 
2.25.1


