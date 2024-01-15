Return-Path: <linux-wireless+bounces-1906-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1634582D365
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jan 2024 04:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D549A1C20DE5
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jan 2024 03:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006E01FDC;
	Mon, 15 Jan 2024 03:38:14 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14571FCA
	for <linux-wireless@vger.kernel.org>; Mon, 15 Jan 2024 03:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 40F3c4lhD3528764, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 40F3c4lhD3528764
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jan 2024 11:38:04 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Mon, 15 Jan 2024 11:38:05 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 15 Jan
 2024 11:38:04 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/8] wifi: rtw89: fw: add H2C command to update security CAM v2
Date: Mon, 15 Jan 2024 11:37:35 +0800
Message-ID: <20240115033742.16372-2-pkshih@realtek.com>
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

To have secure connection, set key information into security CAM including
key index, entry index and valid map. This new introduced H2C command can
support MLO, but currently not implement yet.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/cam.c      | 61 ++++++++++++
 drivers/net/wireless/realtek/rtw89/cam.h      | 96 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/fw.c       | 39 ++++++++
 drivers/net/wireless/realtek/rtw89/fw.h       |  4 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |  1 +
 5 files changed, 201 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/cam.c b/drivers/net/wireless/realtek/rtw89/cam.c
index 914c94988b2f..11fbdd142162 100644
--- a/drivers/net/wireless/realtek/rtw89/cam.c
+++ b/drivers/net/wireless/realtek/rtw89/cam.c
@@ -777,3 +777,64 @@ void rtw89_cam_fill_dctl_sec_cam_info_v1(struct rtw89_dev *rtwdev,
 	SET_DCTL_SEC_ENT5_V1(cmd, addr_cam->sec_ent[5]);
 	SET_DCTL_SEC_ENT6_V1(cmd, addr_cam->sec_ent[6]);
 }
+
+void rtw89_cam_fill_dctl_sec_cam_info_v2(struct rtw89_dev *rtwdev,
+					 struct rtw89_vif *rtwvif,
+					 struct rtw89_sta *rtwsta,
+					 struct rtw89_h2c_dctlinfo_ud_v2 *h2c)
+{
+	struct rtw89_addr_cam_entry *addr_cam = rtw89_get_addr_cam_of(rtwvif, rtwsta);
+
+	h2c->c0 = le32_encode_bits(rtwsta ? rtwsta->mac_id : rtwvif->mac_id,
+				   DCTLINFO_V2_C0_MACID) |
+		  le32_encode_bits(1, DCTLINFO_V2_C0_OP);
+
+	h2c->w4 = le32_encode_bits(addr_cam->sec_ent_keyid[0],
+				   DCTLINFO_V2_W4_SEC_ENT0_KEYID) |
+		  le32_encode_bits(addr_cam->sec_ent_keyid[1],
+				   DCTLINFO_V2_W4_SEC_ENT1_KEYID) |
+		  le32_encode_bits(addr_cam->sec_ent_keyid[2],
+				   DCTLINFO_V2_W4_SEC_ENT2_KEYID) |
+		  le32_encode_bits(addr_cam->sec_ent_keyid[3],
+				   DCTLINFO_V2_W4_SEC_ENT3_KEYID) |
+		  le32_encode_bits(addr_cam->sec_ent_keyid[4],
+				   DCTLINFO_V2_W4_SEC_ENT4_KEYID) |
+		  le32_encode_bits(addr_cam->sec_ent_keyid[5],
+				   DCTLINFO_V2_W4_SEC_ENT5_KEYID) |
+		  le32_encode_bits(addr_cam->sec_ent_keyid[6],
+				   DCTLINFO_V2_W4_SEC_ENT6_KEYID);
+	h2c->m4 = cpu_to_le32(DCTLINFO_V2_W4_SEC_ENT0_KEYID |
+			      DCTLINFO_V2_W4_SEC_ENT1_KEYID |
+			      DCTLINFO_V2_W4_SEC_ENT2_KEYID |
+			      DCTLINFO_V2_W4_SEC_ENT3_KEYID |
+			      DCTLINFO_V2_W4_SEC_ENT4_KEYID |
+			      DCTLINFO_V2_W4_SEC_ENT5_KEYID |
+			      DCTLINFO_V2_W4_SEC_ENT6_KEYID);
+
+	h2c->w5 = le32_encode_bits(addr_cam->sec_cam_map[0],
+				   DCTLINFO_V2_W5_SEC_ENT_VALID_V1) |
+		  le32_encode_bits(addr_cam->sec_ent[0],
+				   DCTLINFO_V2_W5_SEC_ENT0_V1);
+	h2c->m5 = cpu_to_le32(DCTLINFO_V2_W5_SEC_ENT_VALID_V1 |
+			      DCTLINFO_V2_W5_SEC_ENT0_V1);
+
+	h2c->w6 = le32_encode_bits(addr_cam->sec_ent[1],
+				   DCTLINFO_V2_W6_SEC_ENT1_V1) |
+		  le32_encode_bits(addr_cam->sec_ent[2],
+				   DCTLINFO_V2_W6_SEC_ENT2_V1) |
+		  le32_encode_bits(addr_cam->sec_ent[3],
+				   DCTLINFO_V2_W6_SEC_ENT3_V1) |
+		  le32_encode_bits(addr_cam->sec_ent[4],
+				   DCTLINFO_V2_W6_SEC_ENT4_V1);
+	h2c->m6 = cpu_to_le32(DCTLINFO_V2_W6_SEC_ENT1_V1 |
+			      DCTLINFO_V2_W6_SEC_ENT2_V1 |
+			      DCTLINFO_V2_W6_SEC_ENT3_V1 |
+			      DCTLINFO_V2_W6_SEC_ENT4_V1);
+
+	h2c->w7 = le32_encode_bits(addr_cam->sec_ent[5],
+				   DCTLINFO_V2_W7_SEC_ENT5_V1) |
+		  le32_encode_bits(addr_cam->sec_ent[6],
+				   DCTLINFO_V2_W7_SEC_ENT6_V1);
+	h2c->m7 = cpu_to_le32(DCTLINFO_V2_W7_SEC_ENT5_V1 |
+			      DCTLINFO_V2_W7_SEC_ENT6_V1);
+}
diff --git a/drivers/net/wireless/realtek/rtw89/cam.h b/drivers/net/wireless/realtek/rtw89/cam.h
index 83c160a614e6..9a2dd5999edb 100644
--- a/drivers/net/wireless/realtek/rtw89/cam.h
+++ b/drivers/net/wireless/realtek/rtw89/cam.h
@@ -352,6 +352,98 @@ static inline void FWCMD_SET_ADDR_BSSID_BSSID5(void *cmd, u32 value)
 	le32p_replace_bits((__le32 *)(cmd) + 14, value, GENMASK(31, 24));
 }
 
+struct rtw89_h2c_dctlinfo_ud_v2 {
+	__le32 c0;
+	__le32 w0;
+	__le32 w1;
+	__le32 w2;
+	__le32 w3;
+	__le32 w4;
+	__le32 w5;
+	__le32 w6;
+	__le32 w7;
+	__le32 w8;
+	__le32 w9;
+	__le32 w10;
+	__le32 w11;
+	__le32 w12;
+	__le32 w13;
+	__le32 w14;
+	__le32 w15;
+	__le32 m0;
+	__le32 m1;
+	__le32 m2;
+	__le32 m3;
+	__le32 m4;
+	__le32 m5;
+	__le32 m6;
+	__le32 m7;
+	__le32 m8;
+	__le32 m9;
+	__le32 m10;
+	__le32 m11;
+	__le32 m12;
+	__le32 m13;
+	__le32 m14;
+	__le32 m15;
+} __packed;
+
+#define DCTLINFO_V2_C0_MACID GENMASK(6, 0)
+#define DCTLINFO_V2_C0_OP BIT(7)
+
+#define DCTLINFO_V2_W0_QOS_FIELD_H GENMASK(7, 0)
+#define DCTLINFO_V2_W0_HW_EXSEQ_MACID GENMASK(14, 8)
+#define DCTLINFO_V2_W0_QOS_DATA BIT(15)
+#define DCTLINFO_V2_W0_AES_IV_L GENMASK(31, 16)
+#define DCTLINFO_V2_W1_AES_IV_H GENMASK(31, 0)
+#define DCTLINFO_V2_W2_SEQ0 GENMASK(11, 0)
+#define DCTLINFO_V2_W2_SEQ1 GENMASK(23, 12)
+#define DCTLINFO_V2_W2_AMSDU_MAX_LEN GENMASK(26, 24)
+#define DCTLINFO_V2_W2_STA_AMSDU_EN BIT(27)
+#define DCTLINFO_V2_W2_CHKSUM_OFLD_EN BIT(28)
+#define DCTLINFO_V2_W2_WITH_LLC BIT(29)
+#define DCTLINFO_V2_W2_NAT25_EN BIT(30)
+#define DCTLINFO_V2_W2_IS_MLD BIT(31)
+#define DCTLINFO_V2_W3_SEQ2 GENMASK(11, 0)
+#define DCTLINFO_V2_W3_SEQ3 GENMASK(23, 12)
+#define DCTLINFO_V2_W3_TGT_IND GENMASK(27, 24)
+#define DCTLINFO_V2_W3_TGT_IND_EN BIT(28)
+#define DCTLINFO_V2_W3_HTC_LB GENMASK(31, 29)
+#define DCTLINFO_V2_W4_VLAN_TAG_SEL GENMASK(7, 5)
+#define DCTLINFO_V2_W4_HTC_ORDER BIT(8)
+#define DCTLINFO_V2_W4_SEC_KEY_ID GENMASK(10, 9)
+#define DCTLINFO_V2_W4_VLAN_RX_DYNAMIC_PCP_EN BIT(11)
+#define DCTLINFO_V2_W4_VLAN_RX_PKT_DROP BIT(12)
+#define DCTLINFO_V2_W4_VLAN_RX_VALID BIT(13)
+#define DCTLINFO_V2_W4_VLAN_TX_VALID BIT(14)
+#define DCTLINFO_V2_W4_WAPI BIT(15)
+#define DCTLINFO_V2_W4_SEC_ENT_MODE GENMASK(17, 16)
+#define DCTLINFO_V2_W4_SEC_ENT0_KEYID GENMASK(19, 18)
+#define DCTLINFO_V2_W4_SEC_ENT1_KEYID GENMASK(21, 20)
+#define DCTLINFO_V2_W4_SEC_ENT2_KEYID GENMASK(23, 22)
+#define DCTLINFO_V2_W4_SEC_ENT3_KEYID GENMASK(25, 24)
+#define DCTLINFO_V2_W4_SEC_ENT4_KEYID GENMASK(27, 26)
+#define DCTLINFO_V2_W4_SEC_ENT5_KEYID GENMASK(29, 28)
+#define DCTLINFO_V2_W4_SEC_ENT6_KEYID GENMASK(31, 30)
+#define DCTLINFO_V2_W5_SEC_ENT7_KEYID GENMASK(1, 0)
+#define DCTLINFO_V2_W5_SEC_ENT8_KEYID GENMASK(3, 2)
+#define DCTLINFO_V2_W5_SEC_ENT_VALID_V1 GENMASK(23, 8)
+#define DCTLINFO_V2_W5_SEC_ENT0_V1 GENMASK(31, 24)
+#define DCTLINFO_V2_W6_SEC_ENT1_V1 GENMASK(7, 0)
+#define DCTLINFO_V2_W6_SEC_ENT2_V1 GENMASK(15, 8)
+#define DCTLINFO_V2_W6_SEC_ENT3_V1 GENMASK(23, 16)
+#define DCTLINFO_V2_W6_SEC_ENT4_V1 GENMASK(31, 24)
+#define DCTLINFO_V2_W7_SEC_ENT5_V1 GENMASK(7, 0)
+#define DCTLINFO_V2_W7_SEC_ENT6_V1 GENMASK(15, 8)
+#define DCTLINFO_V2_W7_SEC_ENT7 GENMASK(23, 16)
+#define DCTLINFO_V2_W7_SEC_ENT8 GENMASK(31, 24)
+#define DCTLINFO_V2_W8_MLD_SMA_L_V1 GENMASK(31, 0)
+#define DCTLINFO_V2_W9_MLD_SMA_H_V1 GENMASK(15, 0)
+#define DCTLINFO_V2_W9_MLD_TMA_L_V1 GENMASK(31, 16)
+#define DCTLINFO_V2_W10_MLD_TMA_H_V1 GENMASK(31, 0)
+#define DCTLINFO_V2_W11_MLD_TA_BSSID_L_V1 GENMASK(31, 0)
+#define DCTLINFO_V2_W12_MLD_TA_BSSID_H_V1 GENMASK(15, 0)
+
 int rtw89_cam_init(struct rtw89_dev *rtwdev, struct rtw89_vif *vif);
 void rtw89_cam_deinit(struct rtw89_dev *rtwdev, struct rtw89_vif *vif);
 int rtw89_cam_init_addr_cam(struct rtw89_dev *rtwdev,
@@ -373,6 +465,10 @@ void rtw89_cam_fill_dctl_sec_cam_info_v1(struct rtw89_dev *rtwdev,
 					 struct rtw89_vif *rtwvif,
 					 struct rtw89_sta *rtwsta,
 					 u8 *cmd);
+void rtw89_cam_fill_dctl_sec_cam_info_v2(struct rtw89_dev *rtwdev,
+					 struct rtw89_vif *rtwvif,
+					 struct rtw89_sta *rtwsta,
+					 struct rtw89_h2c_dctlinfo_ud_v2 *h2c);
 int rtw89_cam_fill_bssid_cam_info(struct rtw89_dev *rtwdev,
 				  struct rtw89_vif *rtwvif,
 				  struct rtw89_sta *rtwsta, u8 *cmd);
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 55a9f4eb47be..bc4c09939160 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -1486,6 +1486,45 @@ int rtw89_fw_h2c_dctl_sec_cam_v1(struct rtw89_dev *rtwdev,
 }
 EXPORT_SYMBOL(rtw89_fw_h2c_dctl_sec_cam_v1);
 
+int rtw89_fw_h2c_dctl_sec_cam_v2(struct rtw89_dev *rtwdev,
+				 struct rtw89_vif *rtwvif,
+				 struct rtw89_sta *rtwsta)
+{
+	struct rtw89_h2c_dctlinfo_ud_v2 *h2c;
+	u32 len = sizeof(*h2c);
+	struct sk_buff *skb;
+	int ret;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for dctl sec cam\n");
+		return -ENOMEM;
+	}
+	skb_put(skb, len);
+	h2c = (struct rtw89_h2c_dctlinfo_ud_v2 *)skb->data;
+
+	rtw89_cam_fill_dctl_sec_cam_info_v2(rtwdev, rtwvif, rtwsta, h2c);
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_MAC,
+			      H2C_CL_MAC_FR_EXCHG,
+			      H2C_FUNC_MAC_DCTLINFO_UD_V2, 0, 0,
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
+EXPORT_SYMBOL(rtw89_fw_h2c_dctl_sec_cam_v2);
+
 int rtw89_fw_h2c_ba_cam(struct rtw89_dev *rtwdev, struct rtw89_sta *rtwsta,
 			bool valid, struct ieee80211_ampdu_params *params)
 {
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 7fa7cd11c495..7ff04472fbdc 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -3618,6 +3618,7 @@ struct rtw89_fw_h2c_rf_reg_info {
 #define H2C_FUNC_MAC_BCN_UPD		0x5
 #define H2C_FUNC_MAC_DCTLINFO_UD_V1	0x9
 #define H2C_FUNC_MAC_CCTLINFO_UD_V1	0xa
+#define H2C_FUNC_MAC_DCTLINFO_UD_V2	0xc
 #define H2C_FUNC_MAC_BCN_UPD_BE		0xd
 
 /* CLASS 6 - Address CAM */
@@ -3822,6 +3823,9 @@ int rtw89_fw_h2c_cam(struct rtw89_dev *rtwdev, struct rtw89_vif *vif,
 int rtw89_fw_h2c_dctl_sec_cam_v1(struct rtw89_dev *rtwdev,
 				 struct rtw89_vif *rtwvif,
 				 struct rtw89_sta *rtwsta);
+int rtw89_fw_h2c_dctl_sec_cam_v2(struct rtw89_dev *rtwdev,
+				 struct rtw89_vif *rtwvif,
+				 struct rtw89_sta *rtwsta);
 void rtw89_fw_c2h_irqsafe(struct rtw89_dev *rtwdev, struct sk_buff *c2h);
 void rtw89_fw_c2h_work(struct work_struct *work);
 int rtw89_fw_h2c_role_maintain(struct rtw89_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index 7f6dde384223..806ab51caed6 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -822,6 +822,7 @@ static const struct rtw89_chip_ops rtw8922a_chip_ops = {
 	.read_phycap		= rtw8922a_read_phycap,
 	.pwr_on_func		= rtw8922a_pwr_on_func,
 	.pwr_off_func		= rtw8922a_pwr_off_func,
+	.h2c_dctl_sec_cam	= rtw89_fw_h2c_dctl_sec_cam_v2,
 	.h2c_update_beacon	= rtw89_fw_h2c_update_beacon_be,
 	.h2c_ba_cam		= rtw89_fw_h2c_ba_cam_v1,
 };
-- 
2.25.1


