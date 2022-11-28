Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 935AB63A261
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Nov 2022 08:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiK1H5y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Nov 2022 02:57:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiK1H5x (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Nov 2022 02:57:53 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3A77BCF7
        for <linux-wireless@vger.kernel.org>; Sun, 27 Nov 2022 23:57:52 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2AS7uvMdB016567, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2AS7uvMdB016567
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 28 Nov 2022 15:56:58 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Mon, 28 Nov 2022 15:57:42 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 28 Nov
 2022 15:57:41 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH] wifi: rtw88: 8821c: enable BT device recovery mechanism
Date:   Mon, 28 Nov 2022 15:56:53 +0800
Message-ID: <20221128075653.5221-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
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
X-KSE-Antiphishing-Bases: 11/28/2022 07:36:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzExLzI4IKRXpMggMDY6MDA6MDA=?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

8821ce is a combo card, and BT is a USB device that could get card lost
during stress test, and need WiFi firmware to detect and recover it, so
driver sends a H2C to enable this mechanism.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/fw.c  | 10 ++++++++++
 drivers/net/wireless/realtek/rtw88/fw.h  |  6 ++++++
 drivers/net/wireless/realtek/rtw88/mac.c | 18 +++++++++++++++++-
 3 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
index 0b5f903c0f366..59cc2a0a0bd0d 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.c
+++ b/drivers/net/wireless/realtek/rtw88/fw.c
@@ -824,6 +824,16 @@ void rtw_fw_set_nlo_info(struct rtw_dev *rtwdev, bool enable)
 	rtw_fw_send_h2c_command(rtwdev, h2c_pkt);
 }
 
+void rtw_fw_set_recover_bt_device(struct rtw_dev *rtwdev)
+{
+	u8 h2c_pkt[H2C_PKT_SIZE] = {0};
+
+	SET_H2C_CMD_ID_CLASS(h2c_pkt, H2C_CMD_RECOVER_BT_DEV);
+	SET_RECOVER_BT_DEV_EN(h2c_pkt, 1);
+
+	rtw_fw_send_h2c_command(rtwdev, h2c_pkt);
+}
+
 void rtw_fw_set_pg_info(struct rtw_dev *rtwdev)
 {
 	struct rtw_lps_conf *conf = &rtwdev->lps_conf;
diff --git a/drivers/net/wireless/realtek/rtw88/fw.h b/drivers/net/wireless/realtek/rtw88/fw.h
index a5a965803a3cc..a44a634bec619 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.h
+++ b/drivers/net/wireless/realtek/rtw88/fw.h
@@ -550,6 +550,8 @@ static inline void rtw_h2c_pkt_set_header(u8 *h2c_pkt, u8 sub_id)
 #define H2C_CMD_AOAC_GLOBAL_INFO	0x82
 #define H2C_CMD_NLO_INFO		0x8C
 
+#define H2C_CMD_RECOVER_BT_DEV		0xD1
+
 #define SET_H2C_CMD_ID_CLASS(h2c_pkt, value)				       \
 	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x00, value, GENMASK(7, 0))
 
@@ -749,6 +751,9 @@ static inline void rtw_h2c_pkt_set_header(u8 *h2c_pkt, u8 sub_id)
 #define SET_NLO_LOC_NLO_INFO(h2c_pkt, value)                                   \
 	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x00, value, GENMASK(23, 16))
 
+#define SET_RECOVER_BT_DEV_EN(h2c_pkt, value)				       \
+	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x00, value, BIT(8))
+
 #define GET_FW_DUMP_LEN(_header)					\
 	le32_get_bits(*((__le32 *)(_header) + 0x00), GENMASK(15, 0))
 #define GET_FW_DUMP_SEQ(_header)					\
@@ -838,6 +843,7 @@ void rtw_fw_set_aoac_global_info_cmd(struct rtw_dev *rtwdev,
 				     u8 group_key_enc);
 
 void rtw_fw_set_nlo_info(struct rtw_dev *rtwdev, bool enable);
+void rtw_fw_set_recover_bt_device(struct rtw_dev *rtwdev);
 void rtw_fw_update_pkt_probe_req(struct rtw_dev *rtwdev,
 				 struct cfg80211_ssid *ssid);
 void rtw_fw_channel_switch(struct rtw_dev *rtwdev, bool enable);
diff --git a/drivers/net/wireless/realtek/rtw88/mac.c b/drivers/net/wireless/realtek/rtw88/mac.c
index 52076e89d59a3..c7e64f7036ac2 100644
--- a/drivers/net/wireless/realtek/rtw88/mac.c
+++ b/drivers/net/wireless/realtek/rtw88/mac.c
@@ -906,7 +906,8 @@ static int __rtw_download_firmware_legacy(struct rtw_dev *rtwdev,
 	return ret;
 }
 
-int rtw_download_firmware(struct rtw_dev *rtwdev, struct rtw_fw_state *fw)
+static
+int _rtw_download_firmware(struct rtw_dev *rtwdev, struct rtw_fw_state *fw)
 {
 	if (rtw_chip_wcpu_11n(rtwdev))
 		return __rtw_download_firmware_legacy(rtwdev, fw);
@@ -914,6 +915,21 @@ int rtw_download_firmware(struct rtw_dev *rtwdev, struct rtw_fw_state *fw)
 	return __rtw_download_firmware(rtwdev, fw);
 }
 
+int rtw_download_firmware(struct rtw_dev *rtwdev, struct rtw_fw_state *fw)
+{
+	int ret;
+
+	ret = _rtw_download_firmware(rtwdev, fw);
+	if (ret)
+		return ret;
+
+	if (rtw_hci_type(rtwdev) == RTW_HCI_TYPE_PCIE &&
+	    rtwdev->chip->id == RTW_CHIP_TYPE_8821C)
+		rtw_fw_set_recover_bt_device(rtwdev);
+
+	return 0;
+}
+
 static u32 get_priority_queues(struct rtw_dev *rtwdev, u32 queues)
 {
 	const struct rtw_rqpn *rqpn = rtwdev->fifo.rqpn;
-- 
2.25.1

