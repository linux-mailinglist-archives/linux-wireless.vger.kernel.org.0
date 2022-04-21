Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70F7A509F5D
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Apr 2022 14:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384023AbiDUMNQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Apr 2022 08:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383609AbiDUMMh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Apr 2022 08:12:37 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13E825C57
        for <linux-wireless@vger.kernel.org>; Thu, 21 Apr 2022 05:09:47 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 23LC9gkZ6029014, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 23LC9gkZ6029014
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 21 Apr 2022 20:09:42 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 21 Apr 2022 20:09:41 +0800
Received: from localhost (172.16.16.159) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 21 Apr
 2022 20:09:41 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 09/14] rtw89: add RF H2C to notify firmware
Date:   Thu, 21 Apr 2022 20:08:58 +0800
Message-ID: <20220421120903.73715-10-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220421120903.73715-1-pkshih@realtek.com>
References: <20220421120903.73715-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.16.159]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 04/21/2022 11:49:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzQvMjEgpFekyCAxMDowNzowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

IQK results in hardware has two copies that are used by firmware to switch
these two to support MCC.

This H2C tell firmware the corresponding channel and band of each IQK
results, and currrent one.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     |  8 ++++
 drivers/net/wireless/realtek/rtw89/fw.c       | 39 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/fw.h       | 12 ++++++
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 14 +++++++
 4 files changed, 73 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 6ca915cb7a29f..9be74d8673cfd 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2634,6 +2634,13 @@ struct rtw89_dack_info {
 
 #define RTW89_IQK_CHS_NR 2
 #define RTW89_IQK_PATH_NR 4
+
+struct rtw89_mcc_info {
+	u8 ch[RTW89_IQK_CHS_NR];
+	u8 band[RTW89_IQK_CHS_NR];
+	u8 table_idx;
+};
+
 struct rtw89_iqk_info {
 	bool lok_cor_fail[RTW89_IQK_CHS_NR][RTW89_IQK_PATH_NR];
 	bool lok_fin_fail[RTW89_IQK_CHS_NR][RTW89_IQK_PATH_NR];
@@ -3105,6 +3112,7 @@ struct rtw89_dev {
 	struct rtw89_dack_info dack;
 	struct rtw89_iqk_info iqk;
 	struct rtw89_dpk_info dpk;
+	struct rtw89_mcc_info mcc;
 	bool is_tssi_mode[RF_PATH_MAX];
 	bool is_bt_iqk_timeout;
 
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 7bef8b4288f0c..e4be785709d10 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -1785,6 +1785,45 @@ int rtw89_fw_h2c_rf_reg(struct rtw89_dev *rtwdev,
 	return -EBUSY;
 }
 
+int rtw89_fw_h2c_rf_ntfy_mcc(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_mcc_info *mcc_info = &rtwdev->mcc;
+	struct rtw89_fw_h2c_rf_get_mccch *mccch;
+	struct sk_buff *skb;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, sizeof(*mccch));
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for h2c cxdrv_ctrl\n");
+		return -ENOMEM;
+	}
+	skb_put(skb, sizeof(*mccch));
+	mccch = (struct rtw89_fw_h2c_rf_get_mccch *)skb->data;
+
+	mccch->ch_0 = cpu_to_le32(mcc_info->ch[0]);
+	mccch->ch_1 = cpu_to_le32(mcc_info->ch[1]);
+	mccch->band_0 = cpu_to_le32(mcc_info->band[0]);
+	mccch->band_1 = cpu_to_le32(mcc_info->band[1]);
+	mccch->current_channel = cpu_to_le32(rtwdev->hal.current_channel);
+	mccch->current_band_type = cpu_to_le32(rtwdev->hal.current_band_type);
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_OUTSRC, H2C_CL_OUTSRC_RF_FW_NOTIFY,
+			      H2C_FUNC_OUTSRC_RF_GET_MCCCH, 0, 0,
+			      sizeof(*mccch));
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
+EXPORT_SYMBOL(rtw89_fw_h2c_rf_ntfy_mcc);
+
 int rtw89_fw_h2c_raw_with_hdr(struct rtw89_dev *rtwdev,
 			      u8 h2c_class, u8 h2c_func, u8 *buf, u16 len,
 			      bool rack, bool dack)
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index aaabfc0dfd713..95a55c4213db3 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -2538,6 +2538,17 @@ struct rtw89_fw_h2c_rf_reg_info {
 
 #define H2C_CL_OUTSRC_RF_REG_A		0x8
 #define H2C_CL_OUTSRC_RF_REG_B		0x9
+#define H2C_CL_OUTSRC_RF_FW_NOTIFY	0xa
+#define H2C_FUNC_OUTSRC_RF_GET_MCCCH	0x2
+
+struct rtw89_fw_h2c_rf_get_mccch {
+	__le32 ch_0;
+	__le32 ch_1;
+	__le32 band_0;
+	__le32 band_1;
+	__le32 current_channel;
+	__le32 current_band_type;
+} __packed;
 
 #define RTW89_FW_RSVD_PLE_SIZE 0x800
 
@@ -2602,6 +2613,7 @@ int rtw89_fw_h2c_scan_offload(struct rtw89_dev *rtwdev,
 int rtw89_fw_h2c_rf_reg(struct rtw89_dev *rtwdev,
 			struct rtw89_fw_h2c_rf_reg_info *info,
 			u16 len, u8 page);
+int rtw89_fw_h2c_rf_ntfy_mcc(struct rtw89_dev *rtwdev);
 int rtw89_fw_h2c_raw_with_hdr(struct rtw89_dev *rtwdev,
 			      u8 h2c_class, u8 h2c_func, u8 *buf, u16 len,
 			      bool rack, bool dack);
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 1302d4324473e..3ee57df0a6396 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -1766,6 +1766,18 @@ static void rtw8852c_set_channel_help(struct rtw89_dev *rtwdev, bool enter,
 	}
 }
 
+static void rtw8852c_rfk_init(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_mcc_info *mcc_info = &rtwdev->mcc;
+
+	memset(mcc_info, 0, sizeof(*mcc_info));
+}
+
+static void rtw8852c_rfk_channel(struct rtw89_dev *rtwdev)
+{
+	rtw89_fw_h2c_rf_ntfy_mcc(rtwdev);
+}
+
 static
 void rtw8852c_set_txpwr_ul_tb_offset(struct rtw89_dev *rtwdev,
 				     s8 pw_ofst, enum rtw89_mac_idx mac_idx)
@@ -1955,6 +1967,8 @@ static const struct rtw89_chip_ops rtw8852c_chip_ops = {
 	.set_channel_help	= rtw8852c_set_channel_help,
 	.read_efuse		= rtw8852c_read_efuse,
 	.read_phycap		= rtw8852c_read_phycap,
+	.rfk_init		= rtw8852c_rfk_init,
+	.rfk_channel		= rtw8852c_rfk_channel,
 	.power_trim		= rtw8852c_power_trim,
 	.read_rf		= rtw89_phy_read_rf_v1,
 	.write_rf		= rtw89_phy_write_rf_v1,
-- 
2.25.1

