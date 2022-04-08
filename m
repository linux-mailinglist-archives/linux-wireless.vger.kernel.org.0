Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38B244F8B9C
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Apr 2022 02:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232828AbiDHAQo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 Apr 2022 20:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232788AbiDHAQd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 Apr 2022 20:16:33 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C04EB19FF51
        for <linux-wireless@vger.kernel.org>; Thu,  7 Apr 2022 17:14:30 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 2380EOl24019423, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 2380EOl24019423
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 8 Apr 2022 08:14:24 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 8 Apr 2022 08:14:24 +0800
Received: from localhost (172.16.21.190) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 8 Apr
 2022 08:14:23 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <leo.li@realtek.com>,
        <johnson.lin@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH v2 11/13] rtw89: add new H2C to configure security CAM via DCTL for V1 chip
Date:   Fri, 8 Apr 2022 08:13:51 +0800
Message-ID: <20220408001353.17188-12-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220408001353.17188-1-pkshih@realtek.com>
References: <20220408001353.17188-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.21.190]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 04/07/2022 23:57:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzQvNyCkVaTIIDEwOjAwOjAw?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DCTL is short for D-MAC control that V1 chip uses this H2C to configure
security CAM. Implement the callers in next patch.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/cam.c |  28 +++
 drivers/net/wireless/realtek/rtw89/cam.h |   4 +
 drivers/net/wireless/realtek/rtw89/fw.c  |  35 +++
 drivers/net/wireless/realtek/rtw89/fw.h  | 306 +++++++++++++++++++++++
 4 files changed, 373 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/cam.c b/drivers/net/wireless/realtek/rtw89/cam.c
index 34827f174ba1e..08b9779163bb5 100644
--- a/drivers/net/wireless/realtek/rtw89/cam.c
+++ b/drivers/net/wireless/realtek/rtw89/cam.c
@@ -710,3 +710,31 @@ void rtw89_cam_fill_addr_cam_info(struct rtw89_dev *rtwdev,
 	FWCMD_SET_ADDR_SEC_ENT5(cmd, addr_cam->sec_ent[5]);
 	FWCMD_SET_ADDR_SEC_ENT6(cmd, addr_cam->sec_ent[6]);
 }
+
+void rtw89_cam_fill_dctl_sec_cam_info_v1(struct rtw89_dev *rtwdev,
+					 struct rtw89_vif *rtwvif,
+					 struct rtw89_sta *rtwsta,
+					 u8 *cmd)
+{
+	struct rtw89_addr_cam_entry *addr_cam = rtw89_get_addr_cam_of(rtwvif, rtwsta);
+
+	SET_DCTL_MACID_V1(cmd, rtwsta ? rtwsta->mac_id : rtwvif->mac_id);
+	SET_DCTL_OPERATION_V1(cmd, 1);
+
+	SET_DCTL_SEC_ENT0_KEYID_V1(cmd, addr_cam->sec_ent_keyid[0]);
+	SET_DCTL_SEC_ENT1_KEYID_V1(cmd, addr_cam->sec_ent_keyid[1]);
+	SET_DCTL_SEC_ENT2_KEYID_V1(cmd, addr_cam->sec_ent_keyid[2]);
+	SET_DCTL_SEC_ENT3_KEYID_V1(cmd, addr_cam->sec_ent_keyid[3]);
+	SET_DCTL_SEC_ENT4_KEYID_V1(cmd, addr_cam->sec_ent_keyid[4]);
+	SET_DCTL_SEC_ENT5_KEYID_V1(cmd, addr_cam->sec_ent_keyid[5]);
+	SET_DCTL_SEC_ENT6_KEYID_V1(cmd, addr_cam->sec_ent_keyid[6]);
+
+	SET_DCTL_SEC_ENT_VALID_V1(cmd, addr_cam->sec_cam_map[0] & 0xff);
+	SET_DCTL_SEC_ENT0_V1(cmd, addr_cam->sec_ent[0]);
+	SET_DCTL_SEC_ENT1_V1(cmd, addr_cam->sec_ent[1]);
+	SET_DCTL_SEC_ENT2_V1(cmd, addr_cam->sec_ent[2]);
+	SET_DCTL_SEC_ENT3_V1(cmd, addr_cam->sec_ent[3]);
+	SET_DCTL_SEC_ENT4_V1(cmd, addr_cam->sec_ent[4]);
+	SET_DCTL_SEC_ENT5_V1(cmd, addr_cam->sec_ent[5]);
+	SET_DCTL_SEC_ENT6_V1(cmd, addr_cam->sec_ent[6]);
+}
diff --git a/drivers/net/wireless/realtek/rtw89/cam.h b/drivers/net/wireless/realtek/rtw89/cam.h
index 3a6a786530d17..a3931d3e40d26 100644
--- a/drivers/net/wireless/realtek/rtw89/cam.h
+++ b/drivers/net/wireless/realtek/rtw89/cam.h
@@ -355,6 +355,10 @@ void rtw89_cam_fill_addr_cam_info(struct rtw89_dev *rtwdev,
 				  struct rtw89_vif *vif,
 				  struct rtw89_sta *rtwsta,
 				  const u8 *scan_mac_addr, u8 *cmd);
+void rtw89_cam_fill_dctl_sec_cam_info_v1(struct rtw89_dev *rtwdev,
+					 struct rtw89_vif *rtwvif,
+					 struct rtw89_sta *rtwsta,
+					 u8 *cmd);
 int rtw89_cam_fill_bssid_cam_info(struct rtw89_dev *rtwdev,
 				  struct rtw89_vif *vif, u8 *cmd);
 int rtw89_cam_sec_key_add(struct rtw89_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index beedc650e33aa..5d411f8ee2eda 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -599,6 +599,41 @@ int rtw89_fw_h2c_cam(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 	return -EBUSY;
 }
 
+#define H2C_DCTL_SEC_CAM_LEN 68
+int rtw89_fw_h2c_dctl_sec_cam_v1(struct rtw89_dev *rtwdev,
+				 struct rtw89_vif *rtwvif,
+				 struct rtw89_sta *rtwsta)
+{
+	struct sk_buff *skb;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, H2C_DCTL_SEC_CAM_LEN);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for dctl sec cam\n");
+		return -ENOMEM;
+	}
+	skb_put(skb, H2C_DCTL_SEC_CAM_LEN);
+
+	rtw89_cam_fill_dctl_sec_cam_info_v1(rtwdev, rtwvif, rtwsta, skb->data);
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_MAC,
+			      H2C_CL_MAC_FR_EXCHG,
+			      H2C_FUNC_MAC_DCTLINFO_UD_V1, 0, 0,
+			      H2C_DCTL_SEC_CAM_LEN);
+
+	if (rtw89_h2c_tx(rtwdev, skb, false)) {
+		rtw89_err(rtwdev, "failed to send h2c\n");
+		goto fail;
+	}
+
+	return 0;
+fail:
+	dev_kfree_skb_any(skb);
+
+	return -EBUSY;
+}
+EXPORT_SYMBOL(rtw89_fw_h2c_dctl_sec_cam_v1);
+
 #define H2C_BA_CAM_LEN 8
 int rtw89_fw_h2c_ba_cam(struct rtw89_dev *rtwdev, struct rtw89_sta *rtwsta,
 			bool valid, struct ieee80211_ampdu_params *params)
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 9cba8990b8365..aaabfc0dfd713 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -1151,6 +1151,308 @@ static inline void SET_CMC_TBL_CSI_BW(void *table, u32 val)
 			   GENMASK(31, 30));
 }
 
+static inline void SET_DCTL_MACID_V1(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 0, val, GENMASK(6, 0));
+}
+
+static inline void SET_DCTL_OPERATION_V1(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 0, val, BIT(7));
+}
+
+#define SET_DCTL_MASK_QOS_FIELD_V1 GENMASK(7, 0)
+static inline void SET_DCTL_QOS_FIELD_V1(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 1, val, GENMASK(7, 0));
+	le32p_replace_bits((__le32 *)(table) + 9, SET_DCTL_MASK_QOS_FIELD_V1,
+			   GENMASK(7, 0));
+}
+
+#define SET_DCTL_MASK_SET_DCTL_HW_EXSEQ_MACID GENMASK(6, 0)
+static inline void SET_DCTL_HW_EXSEQ_MACID_V1(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 1, val, GENMASK(14, 8));
+	le32p_replace_bits((__le32 *)(table) + 9, SET_DCTL_MASK_SET_DCTL_HW_EXSEQ_MACID,
+			   GENMASK(14, 8));
+}
+
+#define SET_DCTL_MASK_QOS_DATA BIT(0)
+static inline void SET_DCTL_QOS_DATA_V1(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 1, val, BIT(15));
+	le32p_replace_bits((__le32 *)(table) + 9, SET_DCTL_MASK_QOS_DATA,
+			   BIT(15));
+}
+
+#define SET_DCTL_MASK_AES_IV_L GENMASK(15, 0)
+static inline void SET_DCTL_AES_IV_L_V1(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 1, val, GENMASK(31, 16));
+	le32p_replace_bits((__le32 *)(table) + 9, SET_DCTL_MASK_AES_IV_L,
+			   GENMASK(31, 16));
+}
+
+#define SET_DCTL_MASK_AES_IV_H GENMASK(31, 0)
+static inline void SET_DCTL_AES_IV_H_V1(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 2, val, GENMASK(31, 0));
+	le32p_replace_bits((__le32 *)(table) + 10, SET_DCTL_MASK_AES_IV_H,
+			   GENMASK(31, 0));
+}
+
+#define SET_DCTL_MASK_SEQ0 GENMASK(11, 0)
+static inline void SET_DCTL_SEQ0_V1(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 3, val, GENMASK(11, 0));
+	le32p_replace_bits((__le32 *)(table) + 11, SET_DCTL_MASK_SEQ0,
+			   GENMASK(11, 0));
+}
+
+#define SET_DCTL_MASK_SEQ1 GENMASK(11, 0)
+static inline void SET_DCTL_SEQ1_V1(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 3, val, GENMASK(23, 12));
+	le32p_replace_bits((__le32 *)(table) + 11, SET_DCTL_MASK_SEQ1,
+			   GENMASK(23, 12));
+}
+
+#define SET_DCTL_MASK_AMSDU_MAX_LEN GENMASK(2, 0)
+static inline void SET_DCTL_AMSDU_MAX_LEN_V1(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 3, val, GENMASK(26, 24));
+	le32p_replace_bits((__le32 *)(table) + 11, SET_DCTL_MASK_AMSDU_MAX_LEN,
+			   GENMASK(26, 24));
+}
+
+#define SET_DCTL_MASK_STA_AMSDU_EN BIT(0)
+static inline void SET_DCTL_STA_AMSDU_EN_V1(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 3, val, BIT(27));
+	le32p_replace_bits((__le32 *)(table) + 11, SET_DCTL_MASK_STA_AMSDU_EN,
+			   BIT(27));
+}
+
+#define SET_DCTL_MASK_CHKSUM_OFLD_EN BIT(0)
+static inline void SET_DCTL_CHKSUM_OFLD_EN_V1(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 3, val, BIT(28));
+	le32p_replace_bits((__le32 *)(table) + 11, SET_DCTL_MASK_CHKSUM_OFLD_EN,
+			   BIT(28));
+}
+
+#define SET_DCTL_MASK_WITH_LLC BIT(0)
+static inline void SET_DCTL_WITH_LLC_V1(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 3, val, BIT(29));
+	le32p_replace_bits((__le32 *)(table) + 11, SET_DCTL_MASK_WITH_LLC,
+			   BIT(29));
+}
+
+#define SET_DCTL_MASK_SEQ2 GENMASK(11, 0)
+static inline void SET_DCTL_SEQ2_V1(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 4, val, GENMASK(11, 0));
+	le32p_replace_bits((__le32 *)(table) + 12, SET_DCTL_MASK_SEQ2,
+			   GENMASK(11, 0));
+}
+
+#define SET_DCTL_MASK_SEQ3 GENMASK(11, 0)
+static inline void SET_DCTL_SEQ3_V1(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 4, val, GENMASK(23, 12));
+	le32p_replace_bits((__le32 *)(table) + 12, SET_DCTL_MASK_SEQ3,
+			   GENMASK(23, 12));
+}
+
+#define SET_DCTL_MASK_TGT_IND GENMASK(3, 0)
+static inline void SET_DCTL_TGT_IND_V1(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 4, val, GENMASK(27, 24));
+	le32p_replace_bits((__le32 *)(table) + 12, SET_DCTL_MASK_TGT_IND,
+			   GENMASK(27, 24));
+}
+
+#define SET_DCTL_MASK_TGT_IND_EN BIT(0)
+static inline void SET_DCTL_TGT_IND_EN_V1(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 4, val, BIT(28));
+	le32p_replace_bits((__le32 *)(table) + 12, SET_DCTL_MASK_TGT_IND_EN,
+			   BIT(28));
+}
+
+#define SET_DCTL_MASK_HTC_LB GENMASK(2, 0)
+static inline void SET_DCTL_HTC_LB_V1(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 4, val, GENMASK(31, 29));
+	le32p_replace_bits((__le32 *)(table) + 12, SET_DCTL_MASK_HTC_LB,
+			   GENMASK(31, 29));
+}
+
+#define SET_DCTL_MASK_MHDR_LEN GENMASK(4, 0)
+static inline void SET_DCTL_MHDR_LEN_V1(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 5, val, GENMASK(4, 0));
+	le32p_replace_bits((__le32 *)(table) + 13, SET_DCTL_MASK_MHDR_LEN,
+			   GENMASK(4, 0));
+}
+
+#define SET_DCTL_MASK_VLAN_TAG_VALID BIT(0)
+static inline void SET_DCTL_VLAN_TAG_VALID_V1(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 5, val, BIT(5));
+	le32p_replace_bits((__le32 *)(table) + 13, SET_DCTL_MASK_VLAN_TAG_VALID,
+			   BIT(5));
+}
+
+#define SET_DCTL_MASK_VLAN_TAG_SEL GENMASK(1, 0)
+static inline void SET_DCTL_VLAN_TAG_SEL_V1(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 5, val, GENMASK(7, 6));
+	le32p_replace_bits((__le32 *)(table) + 13, SET_DCTL_MASK_VLAN_TAG_SEL,
+			   GENMASK(7, 6));
+}
+
+#define SET_DCTL_MASK_HTC_ORDER BIT(0)
+static inline void SET_DCTL_HTC_ORDER_V1(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 5, val, BIT(8));
+	le32p_replace_bits((__le32 *)(table) + 13, SET_DCTL_MASK_HTC_ORDER,
+			   BIT(8));
+}
+
+#define SET_DCTL_MASK_SEC_KEY_ID GENMASK(1, 0)
+static inline void SET_DCTL_SEC_KEY_ID_V1(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 5, val, GENMASK(10, 9));
+	le32p_replace_bits((__le32 *)(table) + 13, SET_DCTL_MASK_SEC_KEY_ID,
+			   GENMASK(10, 9));
+}
+
+#define SET_DCTL_MASK_WAPI BIT(0)
+static inline void SET_DCTL_WAPI_V1(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 5, val, BIT(15));
+	le32p_replace_bits((__le32 *)(table) + 13, SET_DCTL_MASK_WAPI,
+			   BIT(15));
+}
+
+#define SET_DCTL_MASK_SEC_ENT_MODE GENMASK(1, 0)
+static inline void SET_DCTL_SEC_ENT_MODE_V1(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 5, val, GENMASK(17, 16));
+	le32p_replace_bits((__le32 *)(table) + 13, SET_DCTL_MASK_SEC_ENT_MODE,
+			   GENMASK(17, 16));
+}
+
+#define SET_DCTL_MASK_SEC_ENTX_KEYID GENMASK(1, 0)
+static inline void SET_DCTL_SEC_ENT0_KEYID_V1(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 5, val, GENMASK(19, 18));
+	le32p_replace_bits((__le32 *)(table) + 13, SET_DCTL_MASK_SEC_ENTX_KEYID,
+			   GENMASK(19, 18));
+}
+
+static inline void SET_DCTL_SEC_ENT1_KEYID_V1(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 5, val, GENMASK(21, 20));
+	le32p_replace_bits((__le32 *)(table) + 13, SET_DCTL_MASK_SEC_ENTX_KEYID,
+			   GENMASK(21, 20));
+}
+
+static inline void SET_DCTL_SEC_ENT2_KEYID_V1(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 5, val, GENMASK(23, 22));
+	le32p_replace_bits((__le32 *)(table) + 13, SET_DCTL_MASK_SEC_ENTX_KEYID,
+			   GENMASK(23, 22));
+}
+
+static inline void SET_DCTL_SEC_ENT3_KEYID_V1(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 5, val, GENMASK(25, 24));
+	le32p_replace_bits((__le32 *)(table) + 13, SET_DCTL_MASK_SEC_ENTX_KEYID,
+			   GENMASK(25, 24));
+}
+
+static inline void SET_DCTL_SEC_ENT4_KEYID_V1(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 5, val, GENMASK(27, 26));
+	le32p_replace_bits((__le32 *)(table) + 13, SET_DCTL_MASK_SEC_ENTX_KEYID,
+			   GENMASK(27, 26));
+}
+
+static inline void SET_DCTL_SEC_ENT5_KEYID_V1(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 5, val, GENMASK(29, 28));
+	le32p_replace_bits((__le32 *)(table) + 13, SET_DCTL_MASK_SEC_ENTX_KEYID,
+			   GENMASK(29, 28));
+}
+
+static inline void SET_DCTL_SEC_ENT6_KEYID_V1(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 5, val, GENMASK(31, 30));
+	le32p_replace_bits((__le32 *)(table) + 13, SET_DCTL_MASK_SEC_ENTX_KEYID,
+			   GENMASK(31, 30));
+}
+
+#define SET_DCTL_MASK_SEC_ENT_VALID GENMASK(7, 0)
+static inline void SET_DCTL_SEC_ENT_VALID_V1(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 6, val, GENMASK(7, 0));
+	le32p_replace_bits((__le32 *)(table) + 14, SET_DCTL_MASK_SEC_ENT_VALID,
+			   GENMASK(7, 0));
+}
+
+#define SET_DCTL_MASK_SEC_ENTX GENMASK(7, 0)
+static inline void SET_DCTL_SEC_ENT0_V1(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 6, val, GENMASK(15, 8));
+	le32p_replace_bits((__le32 *)(table) + 14, SET_DCTL_MASK_SEC_ENTX,
+			   GENMASK(15, 8));
+}
+
+static inline void SET_DCTL_SEC_ENT1_V1(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 6, val, GENMASK(23, 16));
+	le32p_replace_bits((__le32 *)(table) + 14, SET_DCTL_MASK_SEC_ENTX,
+			   GENMASK(23, 16));
+}
+
+static inline void SET_DCTL_SEC_ENT2_V1(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 6, val, GENMASK(31, 24));
+	le32p_replace_bits((__le32 *)(table) + 14, SET_DCTL_MASK_SEC_ENTX,
+			   GENMASK(31, 24));
+}
+
+static inline void SET_DCTL_SEC_ENT3_V1(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 7, val, GENMASK(7, 0));
+	le32p_replace_bits((__le32 *)(table) + 15, SET_DCTL_MASK_SEC_ENTX,
+			   GENMASK(7, 0));
+}
+
+static inline void SET_DCTL_SEC_ENT4_V1(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 7, val, GENMASK(15, 8));
+	le32p_replace_bits((__le32 *)(table) + 15, SET_DCTL_MASK_SEC_ENTX,
+			   GENMASK(15, 8));
+}
+
+static inline void SET_DCTL_SEC_ENT5_V1(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 7, val, GENMASK(23, 16));
+	le32p_replace_bits((__le32 *)(table) + 15, SET_DCTL_MASK_SEC_ENTX,
+			   GENMASK(23, 16));
+}
+
+static inline void SET_DCTL_SEC_ENT6_V1(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 7, val, GENMASK(31, 24));
+	le32p_replace_bits((__le32 *)(table) + 15, SET_DCTL_MASK_SEC_ENTX,
+			   GENMASK(31, 24));
+}
+
 static inline void SET_BCN_UPD_PORT(void *h2c, u32 val)
 {
 	le32p_replace_bits((__le32 *)h2c, val, GENMASK(7, 0));
@@ -2200,6 +2502,7 @@ struct rtw89_fw_h2c_rf_reg_info {
 #define H2C_CL_MAC_FR_EXCHG		0x5
 #define H2C_FUNC_MAC_CCTLINFO_UD	0x2
 #define H2C_FUNC_MAC_BCN_UPD		0x5
+#define H2C_FUNC_MAC_DCTLINFO_UD_V1	0x9
 #define H2C_FUNC_MAC_CCTLINFO_UD_V1	0xa
 
 /* CLASS 6 - Address CAM */
@@ -2267,6 +2570,9 @@ int rtw89_fw_h2c_update_beacon(struct rtw89_dev *rtwdev,
 			       struct rtw89_vif *rtwvif);
 int rtw89_fw_h2c_cam(struct rtw89_dev *rtwdev, struct rtw89_vif *vif,
 		     struct rtw89_sta *rtwsta, const u8 *scan_mac_addr);
+int rtw89_fw_h2c_dctl_sec_cam_v1(struct rtw89_dev *rtwdev,
+				 struct rtw89_vif *rtwvif,
+				 struct rtw89_sta *rtwsta);
 void rtw89_fw_c2h_irqsafe(struct rtw89_dev *rtwdev, struct sk_buff *c2h);
 void rtw89_fw_c2h_work(struct work_struct *work);
 int rtw89_fw_h2c_role_maintain(struct rtw89_dev *rtwdev,
-- 
2.25.1

