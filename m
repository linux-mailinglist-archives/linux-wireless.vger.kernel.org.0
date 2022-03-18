Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1354DD31E
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Mar 2022 03:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbiCRCez (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Mar 2022 22:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231810AbiCRCeq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Mar 2022 22:34:46 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE8319B0B0
        for <linux-wireless@vger.kernel.org>; Thu, 17 Mar 2022 19:33:27 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 22I2XL390017683, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 22I2XL390017683
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 18 Mar 2022 10:33:21 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 18 Mar 2022 10:33:21 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 18 Mar
 2022 10:33:20 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <johnson.lin@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH 10/11] rtw89: support hardware generate security header
Date:   Fri, 18 Mar 2022 10:32:13 +0800
Message-ID: <20220318023214.32411-11-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220318023214.32411-1-pkshih@realtek.com>
References: <20220318023214.32411-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 03/18/2022 02:15:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzMvMTggpFekyCAxMjo0MDowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
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

The newer chip will generate security header itself, so don't set
IEEE80211_KEY_FLAG_GENERATE_IV in this kind of chip. But, it needs to fill
key_index, PN and 802.11 header length to TX descriptor, and then hardware
uses these to generate security header.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/cam.c      |  4 +-
 drivers/net/wireless/realtek/rtw89/core.c     | 50 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/core.h     |  3 ++
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  1 +
 drivers/net/wireless/realtek/rtw89/txrx.h     |  7 +++
 6 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/cam.c b/drivers/net/wireless/realtek/rtw89/cam.c
index 34df3c07c55c5..34827f174ba1e 100644
--- a/drivers/net/wireless/realtek/rtw89/cam.c
+++ b/drivers/net/wireless/realtek/rtw89/cam.c
@@ -320,6 +320,7 @@ int rtw89_cam_sec_key_add(struct rtw89_dev *rtwdev,
 			  struct ieee80211_sta *sta,
 			  struct ieee80211_key_conf *key)
 {
+	const struct rtw89_chip_info *chip = rtwdev->chip;
 	u8 hw_key_type;
 	bool ext_key = false;
 	int ret;
@@ -353,7 +354,8 @@ int rtw89_cam_sec_key_add(struct rtw89_dev *rtwdev,
 		return -EOPNOTSUPP;
 	}
 
-	key->flags |= IEEE80211_KEY_FLAG_GENERATE_IV;
+	if (!chip->hw_sec_hdr)
+		key->flags |= IEEE80211_KEY_FLAG_GENERATE_IV;
 
 	ret = rtw89_cam_sec_key_install(rtwdev, vif, sta, key, hw_key_type,
 					ext_key);
diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 3c2cbe479197d..245d8514961e8 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -435,6 +435,7 @@ static void
 rtw89_core_tx_update_sec_key(struct rtw89_dev *rtwdev,
 			     struct rtw89_core_tx_request *tx_req)
 {
+	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct ieee80211_vif *vif = tx_req->vif;
 	struct ieee80211_sta *sta = tx_req->sta;
 	struct ieee80211_tx_info *info;
@@ -446,6 +447,7 @@ rtw89_core_tx_update_sec_key(struct rtw89_dev *rtwdev,
 	struct rtw89_tx_desc_info *desc_info = &tx_req->desc_info;
 	struct sk_buff *skb = tx_req->skb;
 	u8 sec_type = RTW89_SEC_KEY_TYPE_NONE;
+	u64 pn64;
 
 	if (!vif) {
 		rtw89_warn(rtwdev, "cannot set sec key without vif\n");
@@ -491,8 +493,21 @@ rtw89_core_tx_update_sec_key(struct rtw89_dev *rtwdev,
 	}
 
 	desc_info->sec_en = true;
+	desc_info->sec_keyid = key->keyidx;
 	desc_info->sec_type = sec_type;
 	desc_info->sec_cam_idx = sec_cam->sec_cam_idx;
+
+	if (!chip->hw_sec_hdr)
+		return;
+
+	pn64 = atomic64_inc_return(&key->tx_pn);
+	desc_info->sec_seq[0] = pn64;
+	desc_info->sec_seq[1] = pn64 >> 8;
+	desc_info->sec_seq[2] = pn64 >> 16;
+	desc_info->sec_seq[3] = pn64 >> 24;
+	desc_info->sec_seq[4] = pn64 >> 32;
+	desc_info->sec_seq[5] = pn64 >> 40;
+	desc_info->wp_offset = 1; /* in unit of 8 bytes for security header */
 }
 
 static u16 rtw89_core_get_mgmt_rate(struct rtw89_dev *rtwdev,
@@ -755,6 +770,17 @@ rtw89_core_tx_btc_spec_pkt_notify(struct rtw89_dev *rtwdev,
 	return PACKET_MAX;
 }
 
+static void rtw89_core_tx_update_llc_hdr(struct rtw89_dev *rtwdev,
+					 struct rtw89_tx_desc_info *desc_info,
+					 struct sk_buff *skb)
+{
+	struct ieee80211_hdr *hdr = (void *)skb->data;
+	__le16 fc = hdr->frame_control;
+
+	desc_info->hdr_llc_len = ieee80211_hdrlen(fc);
+	desc_info->hdr_llc_len >>= 1; /* in unit of 2 bytes */
+}
+
 static void
 rtw89_core_tx_wake(struct rtw89_dev *rtwdev,
 		   struct rtw89_core_tx_request *tx_req)
@@ -806,6 +832,7 @@ rtw89_core_tx_update_desc_info(struct rtw89_dev *rtwdev,
 		rtw89_core_tx_update_data_info(rtwdev, tx_req);
 		pkt_type = rtw89_core_tx_btc_spec_pkt_notify(rtwdev, tx_req);
 		rtw89_core_tx_update_he_qos_htc(rtwdev, tx_req, pkt_type);
+		rtw89_core_tx_update_llc_hdr(rtwdev, desc_info, skb);
 		break;
 	case RTW89_CORE_TX_TYPE_FWCMD:
 		rtw89_core_tx_update_h2c_info(rtwdev, tx_req);
@@ -912,6 +939,7 @@ static __le32 rtw89_build_txwd_body0_v1(struct rtw89_tx_desc_info *desc_info)
 static __le32 rtw89_build_txwd_body1_v1(struct rtw89_tx_desc_info *desc_info)
 {
 	u32 dword = FIELD_PREP(RTW89_TXWD_BODY1_ADDR_INFO_NUM, desc_info->addr_info_nr) |
+		    FIELD_PREP(RTW89_TXWD_BODY1_SEC_KEYID, desc_info->sec_keyid) |
 		    FIELD_PREP(RTW89_TXWD_BODY1_SEC_TYPE, desc_info->sec_type);
 
 	return cpu_to_le32(dword);
@@ -936,6 +964,24 @@ static __le32 rtw89_build_txwd_body3(struct rtw89_tx_desc_info *desc_info)
 	return cpu_to_le32(dword);
 }
 
+static __le32 rtw89_build_txwd_body4(struct rtw89_tx_desc_info *desc_info)
+{
+	u32 dword = FIELD_PREP(RTW89_TXWD_BODY4_SEC_IV_L0, desc_info->sec_seq[0]) |
+		    FIELD_PREP(RTW89_TXWD_BODY4_SEC_IV_L1, desc_info->sec_seq[1]);
+
+	return cpu_to_le32(dword);
+}
+
+static __le32 rtw89_build_txwd_body5(struct rtw89_tx_desc_info *desc_info)
+{
+	u32 dword = FIELD_PREP(RTW89_TXWD_BODY5_SEC_IV_H2, desc_info->sec_seq[2]) |
+		    FIELD_PREP(RTW89_TXWD_BODY5_SEC_IV_H3, desc_info->sec_seq[3]) |
+		    FIELD_PREP(RTW89_TXWD_BODY5_SEC_IV_H4, desc_info->sec_seq[4]) |
+		    FIELD_PREP(RTW89_TXWD_BODY5_SEC_IV_H5, desc_info->sec_seq[5]);
+
+	return cpu_to_le32(dword);
+}
+
 static __le32 rtw89_build_txwd_body7_v1(struct rtw89_tx_desc_info *desc_info)
 {
 	u32 dword = FIELD_PREP(RTW89_TXWD_BODY7_USE_RATE_V1, desc_info->use_rate) |
@@ -1032,6 +1078,10 @@ void rtw89_core_fill_txdesc_v1(struct rtw89_dev *rtwdev,
 	txwd_body->dword1 = rtw89_build_txwd_body1_v1(desc_info);
 	txwd_body->dword2 = rtw89_build_txwd_body2(desc_info);
 	txwd_body->dword3 = rtw89_build_txwd_body3(desc_info);
+	if (desc_info->sec_en) {
+		txwd_body->dword4 = rtw89_build_txwd_body4(desc_info);
+		txwd_body->dword5 = rtw89_build_txwd_body5(desc_info);
+	}
 	txwd_body->dword7 = rtw89_build_txwd_body7_v1(desc_info);
 
 	if (!desc_info->en_wd_info)
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index b5587d799bd83..9f53d581a48f9 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -733,8 +733,10 @@ struct rtw89_tx_desc_info {
 	u8 ampdu_num;
 	bool sec_en;
 	u8 addr_info_nr;
+	u8 sec_keyid;
 	u8 sec_type;
 	u8 sec_cam_idx;
+	u8 sec_seq[6];
 	u16 data_rate;
 	u16 data_retry_lowest_rate;
 	bool fw_dl;
@@ -2302,6 +2304,7 @@ struct rtw89_chip_info {
 	u32 rf_base_addr[2];
 	u8 support_bands;
 	bool support_bw160;
+	bool hw_sec_hdr;
 	u8 rf_path_num;
 	u8 tx_nss;
 	u8 rx_nss;
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 142e96b0723df..a745019f8ab04 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2064,6 +2064,7 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 	.support_bands		= BIT(NL80211_BAND_2GHZ) |
 				  BIT(NL80211_BAND_5GHZ),
 	.support_bw160		= false,
+	.hw_sec_hdr		= false,
 	.rf_path_num		= 2,
 	.tx_nss			= 2,
 	.rx_nss			= 2,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 46d63c450fece..9e3a3fc514ce7 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -506,6 +506,7 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 	.rf_base_addr		= {0xe000, 0xf000},
 	.pwr_on_seq		= NULL,
 	.pwr_off_seq		= NULL,
+	.hw_sec_hdr		= true,
 	.sec_ctrl_efuse_size	= 4,
 	.physical_efuse_size	= 1216,
 	.logical_efuse_size	= 2048,
diff --git a/drivers/net/wireless/realtek/rtw89/txrx.h b/drivers/net/wireless/realtek/rtw89/txrx.h
index c943e4e95721e..1250e26ade406 100644
--- a/drivers/net/wireless/realtek/rtw89/txrx.h
+++ b/drivers/net/wireless/realtek/rtw89/txrx.h
@@ -38,6 +38,7 @@
 /* TX WD BODY DWORD 1 */
 #define RTW89_TXWD_BODY1_ADDR_INFO_NUM GENMASK(31, 26)
 #define RTW89_TXWD_BODY1_PAYLOAD_ID GENMASK(31, 16)
+#define RTW89_TXWD_BODY1_SEC_KEYID GENMASK(5, 4)
 #define RTW89_TXWD_BODY1_SEC_TYPE GENMASK(3, 0)
 
 /* TX WD BODY DWORD 2 */
@@ -52,8 +53,14 @@
 #define RTW89_TXWD_BODY3_SW_SEQ GENMASK(11, 0)
 
 /* TX WD BODY DWORD 4 */
+#define RTW89_TXWD_BODY4_SEC_IV_L1 GENMASK(31, 24)
+#define RTW89_TXWD_BODY4_SEC_IV_L0 GENMASK(23, 16)
 
 /* TX WD BODY DWORD 5 */
+#define RTW89_TXWD_BODY5_SEC_IV_H5 GENMASK(31, 24)
+#define RTW89_TXWD_BODY5_SEC_IV_H4 GENMASK(23, 16)
+#define RTW89_TXWD_BODY5_SEC_IV_H3 GENMASK(15, 8)
+#define RTW89_TXWD_BODY5_SEC_IV_H2 GENMASK(7, 0)
 
 /* TX WD BODY DWORD 6 (V1) */
 
-- 
2.25.1

