Return-Path: <linux-wireless+bounces-6838-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC02C8B2031
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 13:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63E7F289301
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 11:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF64712A16C;
	Thu, 25 Apr 2024 11:29:06 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B79683CCD
	for <linux-wireless@vger.kernel.org>; Thu, 25 Apr 2024 11:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714044546; cv=none; b=f+AsVML/vRowcVTWfB5Gsewkfv4n6x82S3GI1jZfQeyd86yY93q0BrJAh6EoTby3smSZ0iLPOOAMuQCkECu2CJgvBviOpTFz6y1l9v1C1bkiSDpcvM1jBGqG1na+1B09mpA4EFOARhPztcNc9syi7IzTpnRWmfV2t3Kth0jDwbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714044546; c=relaxed/simple;
	bh=uQugdfdw1LcQSYcYhXQb6KKhchAZqpaateWtl72KyPQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eot9uxnj6Bs1ivLaQTQNcw4zEKBgmat4satmOqJTj3wCr8w/xWRceg3imIk3RXTbv3ZkP6CnUZX1gKudXkf6ybyUuMVGm6Uyd1OKOENKDq/gzxEyqlFpgSy2M1OrIXRcANMYWVZEefGTIRau1cysmIt53nQseHlQYsJJOslLbP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43PBT2Zj83482298, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43PBT2Zj83482298
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 25 Apr 2024 19:29:02 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 25 Apr 2024 19:29:02 +0800
Received: from [127.0.1.1] (172.16.16.129) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 25 Apr
 2024 19:29:01 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <timlee@realtek.com>
Subject: [PATCH 05/12] wifi: rtw89: use struct to access firmware command h2c_dctl_sec_cam_v1
Date: Thu, 25 Apr 2024 19:28:09 +0800
Message-ID: <20240425112816.26431-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240425112816.26431-1-pkshih@realtek.com>
References: <20240425112816.26431-1-pkshih@realtek.com>
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

From: Chih-Kang Chang <gary.chang@realtek.com>

This H2C command set key information into security CAM including key
index, entry index and valid map. No logic is changed.

Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/cam.c |  72 ++++--
 drivers/net/wireless/realtek/rtw89/cam.h |  71 +++++-
 drivers/net/wireless/realtek/rtw89/fw.c  |  12 +-
 drivers/net/wireless/realtek/rtw89/fw.h  | 302 -----------------------
 4 files changed, 129 insertions(+), 328 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/cam.c b/drivers/net/wireless/realtek/rtw89/cam.c
index 11fbdd142162..9581cd108298 100644
--- a/drivers/net/wireless/realtek/rtw89/cam.c
+++ b/drivers/net/wireless/realtek/rtw89/cam.c
@@ -753,29 +753,61 @@ void rtw89_cam_fill_addr_cam_info(struct rtw89_dev *rtwdev,
 void rtw89_cam_fill_dctl_sec_cam_info_v1(struct rtw89_dev *rtwdev,
 					 struct rtw89_vif *rtwvif,
 					 struct rtw89_sta *rtwsta,
-					 u8 *cmd)
+					 struct rtw89_h2c_dctlinfo_ud_v1 *h2c)
 {
 	struct rtw89_addr_cam_entry *addr_cam = rtw89_get_addr_cam_of(rtwvif, rtwsta);
 
-	SET_DCTL_MACID_V1(cmd, rtwsta ? rtwsta->mac_id : rtwvif->mac_id);
-	SET_DCTL_OPERATION_V1(cmd, 1);
-
-	SET_DCTL_SEC_ENT0_KEYID_V1(cmd, addr_cam->sec_ent_keyid[0]);
-	SET_DCTL_SEC_ENT1_KEYID_V1(cmd, addr_cam->sec_ent_keyid[1]);
-	SET_DCTL_SEC_ENT2_KEYID_V1(cmd, addr_cam->sec_ent_keyid[2]);
-	SET_DCTL_SEC_ENT3_KEYID_V1(cmd, addr_cam->sec_ent_keyid[3]);
-	SET_DCTL_SEC_ENT4_KEYID_V1(cmd, addr_cam->sec_ent_keyid[4]);
-	SET_DCTL_SEC_ENT5_KEYID_V1(cmd, addr_cam->sec_ent_keyid[5]);
-	SET_DCTL_SEC_ENT6_KEYID_V1(cmd, addr_cam->sec_ent_keyid[6]);
-
-	SET_DCTL_SEC_ENT_VALID_V1(cmd, addr_cam->sec_cam_map[0] & 0xff);
-	SET_DCTL_SEC_ENT0_V1(cmd, addr_cam->sec_ent[0]);
-	SET_DCTL_SEC_ENT1_V1(cmd, addr_cam->sec_ent[1]);
-	SET_DCTL_SEC_ENT2_V1(cmd, addr_cam->sec_ent[2]);
-	SET_DCTL_SEC_ENT3_V1(cmd, addr_cam->sec_ent[3]);
-	SET_DCTL_SEC_ENT4_V1(cmd, addr_cam->sec_ent[4]);
-	SET_DCTL_SEC_ENT5_V1(cmd, addr_cam->sec_ent[5]);
-	SET_DCTL_SEC_ENT6_V1(cmd, addr_cam->sec_ent[6]);
+	h2c->c0 = le32_encode_bits(rtwsta ? rtwsta->mac_id : rtwvif->mac_id,
+				   DCTLINFO_V1_C0_MACID) |
+		  le32_encode_bits(1, DCTLINFO_V1_C0_OP);
+
+	h2c->w4 = le32_encode_bits(addr_cam->sec_ent_keyid[0],
+				   DCTLINFO_V1_W4_SEC_ENT0_KEYID) |
+		  le32_encode_bits(addr_cam->sec_ent_keyid[1],
+				   DCTLINFO_V1_W4_SEC_ENT1_KEYID) |
+		  le32_encode_bits(addr_cam->sec_ent_keyid[2],
+				   DCTLINFO_V1_W4_SEC_ENT2_KEYID) |
+		  le32_encode_bits(addr_cam->sec_ent_keyid[3],
+				   DCTLINFO_V1_W4_SEC_ENT3_KEYID) |
+		  le32_encode_bits(addr_cam->sec_ent_keyid[4],
+				   DCTLINFO_V1_W4_SEC_ENT4_KEYID) |
+		  le32_encode_bits(addr_cam->sec_ent_keyid[5],
+				   DCTLINFO_V1_W4_SEC_ENT5_KEYID) |
+		  le32_encode_bits(addr_cam->sec_ent_keyid[6],
+				   DCTLINFO_V1_W4_SEC_ENT6_KEYID);
+	h2c->m4 = cpu_to_le32(DCTLINFO_V1_W4_SEC_ENT0_KEYID |
+			      DCTLINFO_V1_W4_SEC_ENT1_KEYID |
+			      DCTLINFO_V1_W4_SEC_ENT2_KEYID |
+			      DCTLINFO_V1_W4_SEC_ENT3_KEYID |
+			      DCTLINFO_V1_W4_SEC_ENT4_KEYID |
+			      DCTLINFO_V1_W4_SEC_ENT5_KEYID |
+			      DCTLINFO_V1_W4_SEC_ENT6_KEYID);
+
+	h2c->w5 = le32_encode_bits(addr_cam->sec_cam_map[0] & 0xff,
+				   DCTLINFO_V1_W5_SEC_ENT_VALID) |
+		  le32_encode_bits(addr_cam->sec_ent[0],
+				   DCTLINFO_V1_W5_SEC_ENT0) |
+		  le32_encode_bits(addr_cam->sec_ent[1],
+				   DCTLINFO_V1_W5_SEC_ENT1) |
+		  le32_encode_bits(addr_cam->sec_ent[2],
+				   DCTLINFO_V1_W5_SEC_ENT2);
+	h2c->m5 = cpu_to_le32(DCTLINFO_V1_W5_SEC_ENT_VALID |
+			      DCTLINFO_V1_W5_SEC_ENT0      |
+			      DCTLINFO_V1_W5_SEC_ENT1      |
+			      DCTLINFO_V1_W5_SEC_ENT2);
+
+	h2c->w6 = le32_encode_bits(addr_cam->sec_ent[3],
+				   DCTLINFO_V1_W6_SEC_ENT3) |
+		  le32_encode_bits(addr_cam->sec_ent[4],
+				   DCTLINFO_V1_W6_SEC_ENT4) |
+		  le32_encode_bits(addr_cam->sec_ent[5],
+				   DCTLINFO_V1_W6_SEC_ENT5) |
+		  le32_encode_bits(addr_cam->sec_ent[6],
+				   DCTLINFO_V1_W6_SEC_ENT6);
+	h2c->m6 = cpu_to_le32(DCTLINFO_V1_W6_SEC_ENT3 |
+			      DCTLINFO_V1_W6_SEC_ENT4 |
+			      DCTLINFO_V1_W6_SEC_ENT5 |
+			      DCTLINFO_V1_W6_SEC_ENT6);
 }
 
 void rtw89_cam_fill_dctl_sec_cam_info_v2(struct rtw89_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/cam.h b/drivers/net/wireless/realtek/rtw89/cam.h
index fa09d11c345c..5d7b624c2dd4 100644
--- a/drivers/net/wireless/realtek/rtw89/cam.h
+++ b/drivers/net/wireless/realtek/rtw89/cam.h
@@ -352,6 +352,75 @@ static inline void FWCMD_SET_ADDR_BSSID_BSSID5(void *cmd, u32 value)
 	le32p_replace_bits((__le32 *)(cmd) + 14, value, GENMASK(31, 24));
 }
 
+struct rtw89_h2c_dctlinfo_ud_v1 {
+	__le32 c0;
+	__le32 w0;
+	__le32 w1;
+	__le32 w2;
+	__le32 w3;
+	__le32 w4;
+	__le32 w5;
+	__le32 w6;
+	__le32 w7;
+	__le32 m0;
+	__le32 m1;
+	__le32 m2;
+	__le32 m3;
+	__le32 m4;
+	__le32 m5;
+	__le32 m6;
+	__le32 m7;
+} __packed;
+
+#define DCTLINFO_V1_C0_MACID GENMASK(6, 0)
+#define DCTLINFO_V1_C0_OP BIT(7)
+
+#define DCTLINFO_V1_W0_QOS_FIELD_H GENMASK(7, 0)
+#define DCTLINFO_V1_W0_HW_EXSEQ_MACID GENMASK(14, 8)
+#define DCTLINFO_V1_W0_QOS_DATA BIT(15)
+#define DCTLINFO_V1_W0_AES_IV_L GENMASK(31, 16)
+#define DCTLINFO_V1_W0_ALL GENMASK(31, 0)
+#define DCTLINFO_V1_W1_AES_IV_H GENMASK(31, 0)
+#define DCTLINFO_V1_W1_ALL GENMASK(31, 0)
+#define DCTLINFO_V1_W2_SEQ0 GENMASK(11, 0)
+#define DCTLINFO_V1_W2_SEQ1 GENMASK(23, 12)
+#define DCTLINFO_V1_W2_AMSDU_MAX_LEN GENMASK(26, 24)
+#define DCTLINFO_V1_W2_STA_AMSDU_EN BIT(27)
+#define DCTLINFO_V1_W2_CHKSUM_OFLD_EN BIT(28)
+#define DCTLINFO_V1_W2_WITH_LLC BIT(29)
+#define DCTLINFO_V1_W2_ALL GENMASK(29, 0)
+#define DCTLINFO_V1_W3_SEQ2 GENMASK(11, 0)
+#define DCTLINFO_V1_W3_SEQ3 GENMASK(23, 12)
+#define DCTLINFO_V1_W3_TGT_IND GENMASK(27, 24)
+#define DCTLINFO_V1_W3_TGT_IND_EN BIT(28)
+#define DCTLINFO_V1_W3_HTC_LB GENMASK(31, 29)
+#define DCTLINFO_V1_W3_ALL GENMASK(31, 0)
+#define DCTLINFO_V1_W4_MHDR_LEN GENMASK(4, 0)
+#define DCTLINFO_V1_W4_VLAN_TAG_VALID BIT(5)
+#define DCTLINFO_V1_W4_VLAN_TAG_SEL GENMASK(7, 6)
+#define DCTLINFO_V1_W4_HTC_ORDER BIT(8)
+#define DCTLINFO_V1_W4_SEC_KEY_ID GENMASK(10, 9)
+#define DCTLINFO_V1_W4_WAPI BIT(15)
+#define DCTLINFO_V1_W4_SEC_ENT_MODE GENMASK(17, 16)
+#define DCTLINFO_V1_W4_SEC_ENT0_KEYID GENMASK(19, 18)
+#define DCTLINFO_V1_W4_SEC_ENT1_KEYID GENMASK(21, 20)
+#define DCTLINFO_V1_W4_SEC_ENT2_KEYID GENMASK(23, 22)
+#define DCTLINFO_V1_W4_SEC_ENT3_KEYID GENMASK(25, 24)
+#define DCTLINFO_V1_W4_SEC_ENT4_KEYID GENMASK(27, 26)
+#define DCTLINFO_V1_W4_SEC_ENT5_KEYID GENMASK(29, 28)
+#define DCTLINFO_V1_W4_SEC_ENT6_KEYID GENMASK(31, 30)
+#define DCTLINFO_V1_W4_ALL (GENMASK(31, 15) | GENMASK(10, 0))
+#define DCTLINFO_V1_W5_SEC_ENT_VALID GENMASK(7, 0)
+#define DCTLINFO_V1_W5_SEC_ENT0 GENMASK(15, 8)
+#define DCTLINFO_V1_W5_SEC_ENT1 GENMASK(23, 16)
+#define DCTLINFO_V1_W5_SEC_ENT2 GENMASK(31, 24)
+#define DCTLINFO_V1_W5_ALL GENMASK(31, 0)
+#define DCTLINFO_V1_W6_SEC_ENT3 GENMASK(7, 0)
+#define DCTLINFO_V1_W6_SEC_ENT4 GENMASK(15, 8)
+#define DCTLINFO_V1_W6_SEC_ENT5 GENMASK(23, 16)
+#define DCTLINFO_V1_W6_SEC_ENT6 GENMASK(31, 24)
+#define DCTLINFO_V1_W6_ALL GENMASK(31, 0)
+
 struct rtw89_h2c_dctlinfo_ud_v2 {
 	__le32 c0;
 	__le32 w0;
@@ -477,7 +546,7 @@ void rtw89_cam_fill_addr_cam_info(struct rtw89_dev *rtwdev,
 void rtw89_cam_fill_dctl_sec_cam_info_v1(struct rtw89_dev *rtwdev,
 					 struct rtw89_vif *rtwvif,
 					 struct rtw89_sta *rtwsta,
-					 u8 *cmd);
+					 struct rtw89_h2c_dctlinfo_ud_v1 *h2c);
 void rtw89_cam_fill_dctl_sec_cam_info_v2(struct rtw89_dev *rtwdev,
 					 struct rtw89_vif *rtwvif,
 					 struct rtw89_sta *rtwsta,
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 0bc7fcd5b27d..ce12638da3e6 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -1726,28 +1726,30 @@ int rtw89_fw_h2c_cam(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 	return ret;
 }
 
-#define H2C_DCTL_SEC_CAM_LEN 68
 int rtw89_fw_h2c_dctl_sec_cam_v1(struct rtw89_dev *rtwdev,
 				 struct rtw89_vif *rtwvif,
 				 struct rtw89_sta *rtwsta)
 {
+	struct rtw89_h2c_dctlinfo_ud_v1 *h2c;
+	u32 len = sizeof(*h2c);
 	struct sk_buff *skb;
 	int ret;
 
-	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, H2C_DCTL_SEC_CAM_LEN);
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
 	if (!skb) {
 		rtw89_err(rtwdev, "failed to alloc skb for dctl sec cam\n");
 		return -ENOMEM;
 	}
-	skb_put(skb, H2C_DCTL_SEC_CAM_LEN);
+	skb_put(skb, len);
+	h2c = (struct rtw89_h2c_dctlinfo_ud_v1 *)skb->data;
 
-	rtw89_cam_fill_dctl_sec_cam_info_v1(rtwdev, rtwvif, rtwsta, skb->data);
+	rtw89_cam_fill_dctl_sec_cam_info_v1(rtwdev, rtwvif, rtwsta, h2c);
 
 	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
 			      H2C_CAT_MAC,
 			      H2C_CL_MAC_FR_EXCHG,
 			      H2C_FUNC_MAC_DCTLINFO_UD_V1, 0, 0,
-			      H2C_DCTL_SEC_CAM_LEN);
+			      len);
 
 	ret = rtw89_h2c_tx(rtwdev, skb, false);
 	if (ret) {
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index d247fe4b3bb1..dc5b44a0b375 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -1433,308 +1433,6 @@ struct rtw89_h2c_cctlinfo_ud_g7 {
 #define CCTLINFO_G7_W15_MGNT_CURR_RATE GENMASK(27, 16)
 #define CCTLINFO_G7_W15_ALL GENMASK(27, 0)
 
-static inline void SET_DCTL_MACID_V1(void *table, u32 val)
-{
-	le32p_replace_bits((__le32 *)(table) + 0, val, GENMASK(6, 0));
-}
-
-static inline void SET_DCTL_OPERATION_V1(void *table, u32 val)
-{
-	le32p_replace_bits((__le32 *)(table) + 0, val, BIT(7));
-}
-
-#define SET_DCTL_MASK_QOS_FIELD_V1 GENMASK(7, 0)
-static inline void SET_DCTL_QOS_FIELD_V1(void *table, u32 val)
-{
-	le32p_replace_bits((__le32 *)(table) + 1, val, GENMASK(7, 0));
-	le32p_replace_bits((__le32 *)(table) + 9, SET_DCTL_MASK_QOS_FIELD_V1,
-			   GENMASK(7, 0));
-}
-
-#define SET_DCTL_MASK_SET_DCTL_HW_EXSEQ_MACID GENMASK(6, 0)
-static inline void SET_DCTL_HW_EXSEQ_MACID_V1(void *table, u32 val)
-{
-	le32p_replace_bits((__le32 *)(table) + 1, val, GENMASK(14, 8));
-	le32p_replace_bits((__le32 *)(table) + 9, SET_DCTL_MASK_SET_DCTL_HW_EXSEQ_MACID,
-			   GENMASK(14, 8));
-}
-
-#define SET_DCTL_MASK_QOS_DATA BIT(0)
-static inline void SET_DCTL_QOS_DATA_V1(void *table, u32 val)
-{
-	le32p_replace_bits((__le32 *)(table) + 1, val, BIT(15));
-	le32p_replace_bits((__le32 *)(table) + 9, SET_DCTL_MASK_QOS_DATA,
-			   BIT(15));
-}
-
-#define SET_DCTL_MASK_AES_IV_L GENMASK(15, 0)
-static inline void SET_DCTL_AES_IV_L_V1(void *table, u32 val)
-{
-	le32p_replace_bits((__le32 *)(table) + 1, val, GENMASK(31, 16));
-	le32p_replace_bits((__le32 *)(table) + 9, SET_DCTL_MASK_AES_IV_L,
-			   GENMASK(31, 16));
-}
-
-#define SET_DCTL_MASK_AES_IV_H GENMASK(31, 0)
-static inline void SET_DCTL_AES_IV_H_V1(void *table, u32 val)
-{
-	le32p_replace_bits((__le32 *)(table) + 2, val, GENMASK(31, 0));
-	le32p_replace_bits((__le32 *)(table) + 10, SET_DCTL_MASK_AES_IV_H,
-			   GENMASK(31, 0));
-}
-
-#define SET_DCTL_MASK_SEQ0 GENMASK(11, 0)
-static inline void SET_DCTL_SEQ0_V1(void *table, u32 val)
-{
-	le32p_replace_bits((__le32 *)(table) + 3, val, GENMASK(11, 0));
-	le32p_replace_bits((__le32 *)(table) + 11, SET_DCTL_MASK_SEQ0,
-			   GENMASK(11, 0));
-}
-
-#define SET_DCTL_MASK_SEQ1 GENMASK(11, 0)
-static inline void SET_DCTL_SEQ1_V1(void *table, u32 val)
-{
-	le32p_replace_bits((__le32 *)(table) + 3, val, GENMASK(23, 12));
-	le32p_replace_bits((__le32 *)(table) + 11, SET_DCTL_MASK_SEQ1,
-			   GENMASK(23, 12));
-}
-
-#define SET_DCTL_MASK_AMSDU_MAX_LEN GENMASK(2, 0)
-static inline void SET_DCTL_AMSDU_MAX_LEN_V1(void *table, u32 val)
-{
-	le32p_replace_bits((__le32 *)(table) + 3, val, GENMASK(26, 24));
-	le32p_replace_bits((__le32 *)(table) + 11, SET_DCTL_MASK_AMSDU_MAX_LEN,
-			   GENMASK(26, 24));
-}
-
-#define SET_DCTL_MASK_STA_AMSDU_EN BIT(0)
-static inline void SET_DCTL_STA_AMSDU_EN_V1(void *table, u32 val)
-{
-	le32p_replace_bits((__le32 *)(table) + 3, val, BIT(27));
-	le32p_replace_bits((__le32 *)(table) + 11, SET_DCTL_MASK_STA_AMSDU_EN,
-			   BIT(27));
-}
-
-#define SET_DCTL_MASK_CHKSUM_OFLD_EN BIT(0)
-static inline void SET_DCTL_CHKSUM_OFLD_EN_V1(void *table, u32 val)
-{
-	le32p_replace_bits((__le32 *)(table) + 3, val, BIT(28));
-	le32p_replace_bits((__le32 *)(table) + 11, SET_DCTL_MASK_CHKSUM_OFLD_EN,
-			   BIT(28));
-}
-
-#define SET_DCTL_MASK_WITH_LLC BIT(0)
-static inline void SET_DCTL_WITH_LLC_V1(void *table, u32 val)
-{
-	le32p_replace_bits((__le32 *)(table) + 3, val, BIT(29));
-	le32p_replace_bits((__le32 *)(table) + 11, SET_DCTL_MASK_WITH_LLC,
-			   BIT(29));
-}
-
-#define SET_DCTL_MASK_SEQ2 GENMASK(11, 0)
-static inline void SET_DCTL_SEQ2_V1(void *table, u32 val)
-{
-	le32p_replace_bits((__le32 *)(table) + 4, val, GENMASK(11, 0));
-	le32p_replace_bits((__le32 *)(table) + 12, SET_DCTL_MASK_SEQ2,
-			   GENMASK(11, 0));
-}
-
-#define SET_DCTL_MASK_SEQ3 GENMASK(11, 0)
-static inline void SET_DCTL_SEQ3_V1(void *table, u32 val)
-{
-	le32p_replace_bits((__le32 *)(table) + 4, val, GENMASK(23, 12));
-	le32p_replace_bits((__le32 *)(table) + 12, SET_DCTL_MASK_SEQ3,
-			   GENMASK(23, 12));
-}
-
-#define SET_DCTL_MASK_TGT_IND GENMASK(3, 0)
-static inline void SET_DCTL_TGT_IND_V1(void *table, u32 val)
-{
-	le32p_replace_bits((__le32 *)(table) + 4, val, GENMASK(27, 24));
-	le32p_replace_bits((__le32 *)(table) + 12, SET_DCTL_MASK_TGT_IND,
-			   GENMASK(27, 24));
-}
-
-#define SET_DCTL_MASK_TGT_IND_EN BIT(0)
-static inline void SET_DCTL_TGT_IND_EN_V1(void *table, u32 val)
-{
-	le32p_replace_bits((__le32 *)(table) + 4, val, BIT(28));
-	le32p_replace_bits((__le32 *)(table) + 12, SET_DCTL_MASK_TGT_IND_EN,
-			   BIT(28));
-}
-
-#define SET_DCTL_MASK_HTC_LB GENMASK(2, 0)
-static inline void SET_DCTL_HTC_LB_V1(void *table, u32 val)
-{
-	le32p_replace_bits((__le32 *)(table) + 4, val, GENMASK(31, 29));
-	le32p_replace_bits((__le32 *)(table) + 12, SET_DCTL_MASK_HTC_LB,
-			   GENMASK(31, 29));
-}
-
-#define SET_DCTL_MASK_MHDR_LEN GENMASK(4, 0)
-static inline void SET_DCTL_MHDR_LEN_V1(void *table, u32 val)
-{
-	le32p_replace_bits((__le32 *)(table) + 5, val, GENMASK(4, 0));
-	le32p_replace_bits((__le32 *)(table) + 13, SET_DCTL_MASK_MHDR_LEN,
-			   GENMASK(4, 0));
-}
-
-#define SET_DCTL_MASK_VLAN_TAG_VALID BIT(0)
-static inline void SET_DCTL_VLAN_TAG_VALID_V1(void *table, u32 val)
-{
-	le32p_replace_bits((__le32 *)(table) + 5, val, BIT(5));
-	le32p_replace_bits((__le32 *)(table) + 13, SET_DCTL_MASK_VLAN_TAG_VALID,
-			   BIT(5));
-}
-
-#define SET_DCTL_MASK_VLAN_TAG_SEL GENMASK(1, 0)
-static inline void SET_DCTL_VLAN_TAG_SEL_V1(void *table, u32 val)
-{
-	le32p_replace_bits((__le32 *)(table) + 5, val, GENMASK(7, 6));
-	le32p_replace_bits((__le32 *)(table) + 13, SET_DCTL_MASK_VLAN_TAG_SEL,
-			   GENMASK(7, 6));
-}
-
-#define SET_DCTL_MASK_HTC_ORDER BIT(0)
-static inline void SET_DCTL_HTC_ORDER_V1(void *table, u32 val)
-{
-	le32p_replace_bits((__le32 *)(table) + 5, val, BIT(8));
-	le32p_replace_bits((__le32 *)(table) + 13, SET_DCTL_MASK_HTC_ORDER,
-			   BIT(8));
-}
-
-#define SET_DCTL_MASK_SEC_KEY_ID GENMASK(1, 0)
-static inline void SET_DCTL_SEC_KEY_ID_V1(void *table, u32 val)
-{
-	le32p_replace_bits((__le32 *)(table) + 5, val, GENMASK(10, 9));
-	le32p_replace_bits((__le32 *)(table) + 13, SET_DCTL_MASK_SEC_KEY_ID,
-			   GENMASK(10, 9));
-}
-
-#define SET_DCTL_MASK_WAPI BIT(0)
-static inline void SET_DCTL_WAPI_V1(void *table, u32 val)
-{
-	le32p_replace_bits((__le32 *)(table) + 5, val, BIT(15));
-	le32p_replace_bits((__le32 *)(table) + 13, SET_DCTL_MASK_WAPI,
-			   BIT(15));
-}
-
-#define SET_DCTL_MASK_SEC_ENT_MODE GENMASK(1, 0)
-static inline void SET_DCTL_SEC_ENT_MODE_V1(void *table, u32 val)
-{
-	le32p_replace_bits((__le32 *)(table) + 5, val, GENMASK(17, 16));
-	le32p_replace_bits((__le32 *)(table) + 13, SET_DCTL_MASK_SEC_ENT_MODE,
-			   GENMASK(17, 16));
-}
-
-#define SET_DCTL_MASK_SEC_ENTX_KEYID GENMASK(1, 0)
-static inline void SET_DCTL_SEC_ENT0_KEYID_V1(void *table, u32 val)
-{
-	le32p_replace_bits((__le32 *)(table) + 5, val, GENMASK(19, 18));
-	le32p_replace_bits((__le32 *)(table) + 13, SET_DCTL_MASK_SEC_ENTX_KEYID,
-			   GENMASK(19, 18));
-}
-
-static inline void SET_DCTL_SEC_ENT1_KEYID_V1(void *table, u32 val)
-{
-	le32p_replace_bits((__le32 *)(table) + 5, val, GENMASK(21, 20));
-	le32p_replace_bits((__le32 *)(table) + 13, SET_DCTL_MASK_SEC_ENTX_KEYID,
-			   GENMASK(21, 20));
-}
-
-static inline void SET_DCTL_SEC_ENT2_KEYID_V1(void *table, u32 val)
-{
-	le32p_replace_bits((__le32 *)(table) + 5, val, GENMASK(23, 22));
-	le32p_replace_bits((__le32 *)(table) + 13, SET_DCTL_MASK_SEC_ENTX_KEYID,
-			   GENMASK(23, 22));
-}
-
-static inline void SET_DCTL_SEC_ENT3_KEYID_V1(void *table, u32 val)
-{
-	le32p_replace_bits((__le32 *)(table) + 5, val, GENMASK(25, 24));
-	le32p_replace_bits((__le32 *)(table) + 13, SET_DCTL_MASK_SEC_ENTX_KEYID,
-			   GENMASK(25, 24));
-}
-
-static inline void SET_DCTL_SEC_ENT4_KEYID_V1(void *table, u32 val)
-{
-	le32p_replace_bits((__le32 *)(table) + 5, val, GENMASK(27, 26));
-	le32p_replace_bits((__le32 *)(table) + 13, SET_DCTL_MASK_SEC_ENTX_KEYID,
-			   GENMASK(27, 26));
-}
-
-static inline void SET_DCTL_SEC_ENT5_KEYID_V1(void *table, u32 val)
-{
-	le32p_replace_bits((__le32 *)(table) + 5, val, GENMASK(29, 28));
-	le32p_replace_bits((__le32 *)(table) + 13, SET_DCTL_MASK_SEC_ENTX_KEYID,
-			   GENMASK(29, 28));
-}
-
-static inline void SET_DCTL_SEC_ENT6_KEYID_V1(void *table, u32 val)
-{
-	le32p_replace_bits((__le32 *)(table) + 5, val, GENMASK(31, 30));
-	le32p_replace_bits((__le32 *)(table) + 13, SET_DCTL_MASK_SEC_ENTX_KEYID,
-			   GENMASK(31, 30));
-}
-
-#define SET_DCTL_MASK_SEC_ENT_VALID GENMASK(7, 0)
-static inline void SET_DCTL_SEC_ENT_VALID_V1(void *table, u32 val)
-{
-	le32p_replace_bits((__le32 *)(table) + 6, val, GENMASK(7, 0));
-	le32p_replace_bits((__le32 *)(table) + 14, SET_DCTL_MASK_SEC_ENT_VALID,
-			   GENMASK(7, 0));
-}
-
-#define SET_DCTL_MASK_SEC_ENTX GENMASK(7, 0)
-static inline void SET_DCTL_SEC_ENT0_V1(void *table, u32 val)
-{
-	le32p_replace_bits((__le32 *)(table) + 6, val, GENMASK(15, 8));
-	le32p_replace_bits((__le32 *)(table) + 14, SET_DCTL_MASK_SEC_ENTX,
-			   GENMASK(15, 8));
-}
-
-static inline void SET_DCTL_SEC_ENT1_V1(void *table, u32 val)
-{
-	le32p_replace_bits((__le32 *)(table) + 6, val, GENMASK(23, 16));
-	le32p_replace_bits((__le32 *)(table) + 14, SET_DCTL_MASK_SEC_ENTX,
-			   GENMASK(23, 16));
-}
-
-static inline void SET_DCTL_SEC_ENT2_V1(void *table, u32 val)
-{
-	le32p_replace_bits((__le32 *)(table) + 6, val, GENMASK(31, 24));
-	le32p_replace_bits((__le32 *)(table) + 14, SET_DCTL_MASK_SEC_ENTX,
-			   GENMASK(31, 24));
-}
-
-static inline void SET_DCTL_SEC_ENT3_V1(void *table, u32 val)
-{
-	le32p_replace_bits((__le32 *)(table) + 7, val, GENMASK(7, 0));
-	le32p_replace_bits((__le32 *)(table) + 15, SET_DCTL_MASK_SEC_ENTX,
-			   GENMASK(7, 0));
-}
-
-static inline void SET_DCTL_SEC_ENT4_V1(void *table, u32 val)
-{
-	le32p_replace_bits((__le32 *)(table) + 7, val, GENMASK(15, 8));
-	le32p_replace_bits((__le32 *)(table) + 15, SET_DCTL_MASK_SEC_ENTX,
-			   GENMASK(15, 8));
-}
-
-static inline void SET_DCTL_SEC_ENT5_V1(void *table, u32 val)
-{
-	le32p_replace_bits((__le32 *)(table) + 7, val, GENMASK(23, 16));
-	le32p_replace_bits((__le32 *)(table) + 15, SET_DCTL_MASK_SEC_ENTX,
-			   GENMASK(23, 16));
-}
-
-static inline void SET_DCTL_SEC_ENT6_V1(void *table, u32 val)
-{
-	le32p_replace_bits((__le32 *)(table) + 7, val, GENMASK(31, 24));
-	le32p_replace_bits((__le32 *)(table) + 15, SET_DCTL_MASK_SEC_ENTX,
-			   GENMASK(31, 24));
-}
-
 struct rtw89_h2c_bcn_upd {
 	__le32 w0;
 	__le32 w1;
-- 
2.25.1


