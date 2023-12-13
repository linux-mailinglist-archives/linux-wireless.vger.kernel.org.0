Return-Path: <linux-wireless+bounces-720-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB398810700
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Dec 2023 01:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A4BE1C20E0F
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Dec 2023 00:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBD310F0;
	Wed, 13 Dec 2023 00:52:21 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF0C99
	for <linux-wireless@vger.kernel.org>; Tue, 12 Dec 2023 16:52:17 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3BD0q9mE53838291, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3BD0q9mE53838291
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Dec 2023 08:52:09 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Wed, 13 Dec 2023 08:52:09 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 13 Dec
 2023 08:52:08 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 1/6] wifi: rtw89: fw: load TX power track tables from fw_element
Date: Wed, 13 Dec 2023 08:50:49 +0800
Message-ID: <20231213005054.10568-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231213005054.10568-1-pkshih@realtek.com>
References: <20231213005054.10568-1-pkshih@realtek.com>
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
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

The TX power track tables are used to define compensation power reflected
to thermal value. Currently, we have 16 (2 * 4 * 2) tables made by
combinations of
  {negative/positive thermal value, 2GHz/2GHz-CCK/5GHz/6GHz, path A/B}

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h |  4 ++
 drivers/net/wireless/realtek/rtw89/fw.c   | 71 +++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/fw.h   | 60 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/phy.h  |  2 -
 4 files changed, 135 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index b1e498ad149e..e5dd51f79a6f 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -17,6 +17,7 @@ struct rtw89_pci_info;
 struct rtw89_mac_gen_def;
 struct rtw89_phy_gen_def;
 struct rtw89_efuse_block_cfg;
+struct rtw89_fw_txpwr_track_cfg;
 
 extern const struct ieee80211_ops rtw89_ops;
 
@@ -38,6 +39,8 @@ extern const struct ieee80211_ops rtw89_ops;
 #define RSSI_FACTOR 1
 #define RTW89_RSSI_RAW_TO_DBM(rssi) ((s8)((rssi) >> RSSI_FACTOR) - MAX_RSSI)
 #define RTW89_TX_DIV_RSSI_RAW_TH (2 << RSSI_FACTOR)
+#define DELTA_SWINGIDX_SIZE 30
+
 #define RTW89_RADIOTAP_ROOM_HE sizeof(struct ieee80211_radiotap_he)
 #define RTW89_RADIOTAP_ROOM_EHT \
 	(sizeof(struct ieee80211_radiotap_tlv) + \
@@ -3948,6 +3951,7 @@ struct rtw89_fw_elm_info {
 	struct rtw89_phy_table *bb_gain;
 	struct rtw89_phy_table *rf_radio[RF_PATH_MAX];
 	struct rtw89_phy_table *rf_nctl;
+	struct rtw89_fw_txpwr_track_cfg *txpwr_trk;
 };
 
 struct rtw89_fw_info {
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 81034b6ce4b0..f9727c00d8b9 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -659,6 +659,72 @@ int rtw89_fw_recognize_txpwr_from_elm(struct rtw89_dev *rtwdev,
 	return 0;
 }
 
+static
+int rtw89_build_txpwr_trk_tbl_from_elm(struct rtw89_dev *rtwdev,
+				       const struct rtw89_fw_element_hdr *elm,
+				       const union rtw89_fw_element_arg arg)
+{
+	struct rtw89_fw_elm_info *elm_info = &rtwdev->fw.elm_info;
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	u32 needed_bitmap = 0;
+	u32 offset = 0;
+	int subband;
+	u32 bitmap;
+	int type;
+
+	if (chip->support_bands & BIT(NL80211_BAND_6GHZ))
+		needed_bitmap |= RTW89_DEFAULT_NEEDED_FW_TXPWR_TRK_6GHZ;
+	if (chip->support_bands & BIT(NL80211_BAND_5GHZ))
+		needed_bitmap |= RTW89_DEFAULT_NEEDED_FW_TXPWR_TRK_5GHZ;
+	if (chip->support_bands & BIT(NL80211_BAND_2GHZ))
+		needed_bitmap |= RTW89_DEFAULT_NEEDED_FW_TXPWR_TRK_2GHZ;
+
+	bitmap = le32_to_cpu(elm->u.txpwr_trk.bitmap);
+
+	if ((bitmap & needed_bitmap) != needed_bitmap) {
+		rtw89_warn(rtwdev, "needed txpwr trk bitmap %08x but %0x8x\n",
+			   needed_bitmap, bitmap);
+		return -ENOENT;
+	}
+
+	elm_info->txpwr_trk = kzalloc(sizeof(*elm_info->txpwr_trk), GFP_KERNEL);
+	if (!elm_info->txpwr_trk)
+		return -ENOMEM;
+
+	for (type = 0; bitmap; type++, bitmap >>= 1) {
+		if (!(bitmap & BIT(0)))
+			continue;
+
+		if (type >= __RTW89_FW_TXPWR_TRK_TYPE_6GHZ_START &&
+		    type <= __RTW89_FW_TXPWR_TRK_TYPE_6GHZ_MAX)
+			subband = 4;
+		else if (type >= __RTW89_FW_TXPWR_TRK_TYPE_5GHZ_START &&
+			 type <= __RTW89_FW_TXPWR_TRK_TYPE_5GHZ_MAX)
+			subband = 3;
+		else if (type >= __RTW89_FW_TXPWR_TRK_TYPE_2GHZ_START &&
+			 type <= __RTW89_FW_TXPWR_TRK_TYPE_2GHZ_MAX)
+			subband = 1;
+		else
+			break;
+
+		elm_info->txpwr_trk->delta[type] = &elm->u.txpwr_trk.contents[offset];
+
+		offset += subband;
+		if (offset * DELTA_SWINGIDX_SIZE > le32_to_cpu(elm->size))
+			goto err;
+	}
+
+	return 0;
+
+err:
+	rtw89_warn(rtwdev, "unexpected txpwr trk offset %d over size %d\n",
+		   offset, le32_to_cpu(elm->size));
+	kfree(elm_info->txpwr_trk);
+	elm_info->txpwr_trk = NULL;
+
+	return -EFAULT;
+}
+
 static const struct rtw89_fw_element_handler __fw_element_handlers[] = {
 	[RTW89_FW_ELEMENT_ID_BBMCU0] = {__rtw89_fw_recognize_from_elm,
 					{ .fw_type = RTW89_FW_BBMCU0 }, NULL},
@@ -711,6 +777,9 @@ static const struct rtw89_fw_element_handler __fw_element_handlers[] = {
 		rtw89_fw_recognize_txpwr_from_elm,
 		{ .offset = offsetof(struct rtw89_rfe_data, tx_shape_lmt_ru.conf) }, NULL,
 	},
+	[RTW89_FW_ELEMENT_ID_TXPWR_TRK] = {
+		rtw89_build_txpwr_trk_tbl_from_elm, {}, "PWR_TRK",
+	},
 };
 
 int rtw89_fw_recognize_elements(struct rtw89_dev *rtwdev)
@@ -1144,6 +1213,8 @@ static void rtw89_unload_firmware_elements(struct rtw89_dev *rtwdev)
 	for (i = 0; i < ARRAY_SIZE(elm_info->rf_radio); i++)
 		rtw89_free_phy_tbl_from_elm(elm_info->rf_radio[i]);
 	rtw89_free_phy_tbl_from_elm(elm_info->rf_nctl);
+
+	kfree(elm_info->txpwr_trk);
 }
 
 void rtw89_unload_firmware(struct rtw89_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 2b2d14284465..033ea4467876 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -3426,6 +3426,7 @@ enum rtw89_fw_element_id {
 	RTW89_FW_ELEMENT_ID_TXPWR_LMT_RU_6GHZ = 15,
 	RTW89_FW_ELEMENT_ID_TX_SHAPE_LMT = 16,
 	RTW89_FW_ELEMENT_ID_TX_SHAPE_LMT_RU = 17,
+	RTW89_FW_ELEMENT_ID_TXPWR_TRK = 18,
 
 	RTW89_FW_ELEMENT_ID_NUM,
 };
@@ -3446,6 +3447,7 @@ enum rtw89_fw_element_id {
 					     BIT(RTW89_FW_ELEMENT_ID_RADIO_A) | \
 					     BIT(RTW89_FW_ELEMENT_ID_RADIO_B) | \
 					     BIT(RTW89_FW_ELEMENT_ID_RF_NCTL) | \
+					     BIT(RTW89_FW_ELEMENT_ID_TXPWR_TRK) | \
 					     BITS_OF_RTW89_TXPWR_FW_ELEMENTS)
 
 struct __rtw89_fw_txpwr_element {
@@ -3457,6 +3459,59 @@ struct __rtw89_fw_txpwr_element {
 	u8 content[];
 } __packed;
 
+enum rtw89_fw_txpwr_trk_type {
+	__RTW89_FW_TXPWR_TRK_TYPE_6GHZ_START = 0,
+	RTW89_FW_TXPWR_TRK_TYPE_6GB_N = 0,
+	RTW89_FW_TXPWR_TRK_TYPE_6GB_P = 1,
+	RTW89_FW_TXPWR_TRK_TYPE_6GA_N = 2,
+	RTW89_FW_TXPWR_TRK_TYPE_6GA_P = 3,
+	__RTW89_FW_TXPWR_TRK_TYPE_6GHZ_MAX = 3,
+
+	__RTW89_FW_TXPWR_TRK_TYPE_5GHZ_START = 4,
+	RTW89_FW_TXPWR_TRK_TYPE_5GB_N = 4,
+	RTW89_FW_TXPWR_TRK_TYPE_5GB_P = 5,
+	RTW89_FW_TXPWR_TRK_TYPE_5GA_N = 6,
+	RTW89_FW_TXPWR_TRK_TYPE_5GA_P = 7,
+	__RTW89_FW_TXPWR_TRK_TYPE_5GHZ_MAX = 7,
+
+	__RTW89_FW_TXPWR_TRK_TYPE_2GHZ_START = 8,
+	RTW89_FW_TXPWR_TRK_TYPE_2GB_N = 8,
+	RTW89_FW_TXPWR_TRK_TYPE_2GB_P = 9,
+	RTW89_FW_TXPWR_TRK_TYPE_2GA_N = 10,
+	RTW89_FW_TXPWR_TRK_TYPE_2GA_P = 11,
+	RTW89_FW_TXPWR_TRK_TYPE_2G_CCK_B_N = 12,
+	RTW89_FW_TXPWR_TRK_TYPE_2G_CCK_B_P = 13,
+	RTW89_FW_TXPWR_TRK_TYPE_2G_CCK_A_N = 14,
+	RTW89_FW_TXPWR_TRK_TYPE_2G_CCK_A_P = 15,
+	__RTW89_FW_TXPWR_TRK_TYPE_2GHZ_MAX = 15,
+
+	RTW89_FW_TXPWR_TRK_TYPE_NR,
+};
+
+struct rtw89_fw_txpwr_track_cfg {
+	const s8 (*delta[RTW89_FW_TXPWR_TRK_TYPE_NR])[DELTA_SWINGIDX_SIZE];
+};
+
+#define RTW89_DEFAULT_NEEDED_FW_TXPWR_TRK_6GHZ \
+	(BIT(RTW89_FW_TXPWR_TRK_TYPE_6GB_N) | \
+	 BIT(RTW89_FW_TXPWR_TRK_TYPE_6GB_P) | \
+	 BIT(RTW89_FW_TXPWR_TRK_TYPE_6GA_N) | \
+	 BIT(RTW89_FW_TXPWR_TRK_TYPE_6GA_P))
+#define RTW89_DEFAULT_NEEDED_FW_TXPWR_TRK_5GHZ \
+	(BIT(RTW89_FW_TXPWR_TRK_TYPE_5GB_N) | \
+	 BIT(RTW89_FW_TXPWR_TRK_TYPE_5GB_P) | \
+	 BIT(RTW89_FW_TXPWR_TRK_TYPE_5GA_N) | \
+	 BIT(RTW89_FW_TXPWR_TRK_TYPE_5GA_P))
+#define RTW89_DEFAULT_NEEDED_FW_TXPWR_TRK_2GHZ \
+	(BIT(RTW89_FW_TXPWR_TRK_TYPE_2GB_N) | \
+	 BIT(RTW89_FW_TXPWR_TRK_TYPE_2GB_P) | \
+	 BIT(RTW89_FW_TXPWR_TRK_TYPE_2GA_N) | \
+	 BIT(RTW89_FW_TXPWR_TRK_TYPE_2GA_P) | \
+	 BIT(RTW89_FW_TXPWR_TRK_TYPE_2G_CCK_B_N) | \
+	 BIT(RTW89_FW_TXPWR_TRK_TYPE_2G_CCK_B_P) | \
+	 BIT(RTW89_FW_TXPWR_TRK_TYPE_2G_CCK_A_N) | \
+	 BIT(RTW89_FW_TXPWR_TRK_TYPE_2G_CCK_A_P))
+
 struct rtw89_fw_element_hdr {
 	__le32 id; /* enum rtw89_fw_element_id */
 	__le32 size; /* exclude header size */
@@ -3477,6 +3532,11 @@ struct rtw89_fw_element_hdr {
 				__le32 data;
 			} __packed regs[];
 		} __packed reg2;
+		struct {
+			__le32 bitmap; /* bitmap of enum rtw89_fw_txpwr_trk_type */
+			__le32 rsvd;
+			s8 contents[][DELTA_SWINGIDX_SIZE];
+		} __packed txpwr_trk;
 		struct __rtw89_fw_txpwr_element txpwr;
 	} __packed u;
 } __packed;
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index d6363defcde6..6792b73e9ca3 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -291,8 +291,6 @@ struct rtw89_txpwr_byrate_cfg {
 	u32 data;
 };
 
-#define DELTA_SWINGIDX_SIZE 30
-
 struct rtw89_txpwr_track_cfg {
 	const s8 (*delta_swingidx_6gb_n)[DELTA_SWINGIDX_SIZE];
 	const s8 (*delta_swingidx_6gb_p)[DELTA_SWINGIDX_SIZE];
-- 
2.25.1


