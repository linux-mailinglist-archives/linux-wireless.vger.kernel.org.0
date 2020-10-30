Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 372D42A002E
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Oct 2020 09:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726003AbgJ3Ik2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 30 Oct 2020 04:40:28 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:48081 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbgJ3Ik0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 30 Oct 2020 04:40:26 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 09U8eIeX5008838, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb04.realtek.com.tw[172.21.6.97])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 09U8eIeX5008838
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 30 Oct 2020 16:40:18 +0800
Received: from localhost.localdomain (172.21.69.222) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2044.4; Fri, 30 Oct 2020 16:40:18 +0800
From:   <tehuang@realtek.com>
To:     <kvalo@codeaurora.org>, <tony0620emma@gmail.com>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: [PATCH 2/4] rtw88: store firmware feature in firmware header
Date:   Fri, 30 Oct 2020 16:40:11 +0800
Message-ID: <20201030084013.8457-3-tehuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201030084013.8457-1-tehuang@realtek.com>
References: <20201030084013.8457-1-tehuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.69.222]
X-ClientProxiedBy: RTEXMB03.realtek.com.tw (172.21.6.96) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Chin-Yen Lee <timlee@realtek.com>

Some functions need the support of firmware with special version.
In order to get the feature of current firmware, we store the information
in firmware header and parse after firmware is loaded. The current feature
list in firmware header includes checking leave lps via C2H and
supported lps deep mode.

Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
Signed-off-by: Tzu-En Huang <tehuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/fw.h   | 10 +++++++++-
 drivers/net/wireless/realtek/rtw88/main.c | 13 +++++++++++++
 drivers/net/wireless/realtek/rtw88/main.h |  1 +
 3 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/fw.h b/drivers/net/wireless/realtek/rtw88/fw.h
index 08644540d259..5b74830c4d2c 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.h
+++ b/drivers/net/wireless/realtek/rtw88/fw.h
@@ -72,6 +72,14 @@ enum rtw_fw_rf_type {
 	FW_RF_MAX_TYPE = 0xF,
 };
 
+enum rtw_fw_feature {
+	FW_FEATURE_SIG = BIT(0),
+	FW_FEATURE_LPS_C2H = BIT(1),
+	FW_FEATURE_LCLK = BIT(2),
+	FW_FEATURE_PG = BIT(3),
+	FW_FEATURE_MAX = BIT(31),
+};
+
 struct rtw_coex_info_req {
 	u8 seq;
 	u8 op_code;
@@ -177,7 +185,7 @@ struct rtw_fw_hdr {
 	u8 subversion;
 	u8 subindex;
 	__le32 rsvd;		/* 0x08 */
-	__le32 rsvd2;		/* 0x0C */
+	__le32 feature;		/* 0x0C */
 	u8 month;		/* 0x10 */
 	u8 day;
 	u8 hour;
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 565efd880624..259ad849af93 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -1259,6 +1259,17 @@ static void rtw_unset_supported_band(struct ieee80211_hw *hw,
 	kfree(hw->wiphy->bands[NL80211_BAND_5GHZ]);
 }
 
+static void __update_firmware_feature(struct rtw_dev *rtwdev,
+				      struct rtw_fw_state *fw)
+{
+	u32 feature;
+	const struct rtw_fw_hdr *fw_hdr =
+				(const struct rtw_fw_hdr *)fw->firmware->data;
+
+	feature = le32_to_cpu(fw_hdr->feature);
+	fw->feature = feature & FW_FEATURE_SIG ? feature : 0;
+}
+
 static void __update_firmware_info(struct rtw_dev *rtwdev,
 				   struct rtw_fw_state *fw)
 {
@@ -1269,6 +1280,8 @@ static void __update_firmware_info(struct rtw_dev *rtwdev,
 	fw->version = le16_to_cpu(fw_hdr->version);
 	fw->sub_version = fw_hdr->subversion;
 	fw->sub_index = fw_hdr->subindex;
+
+	__update_firmware_feature(rtwdev, fw);
 }
 
 static void __update_firmware_info_legacy(struct rtw_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index ffb02e614217..b00235573a13 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -1633,6 +1633,7 @@ struct rtw_fw_state {
 	u8 sub_index;
 	u16 h2c_version;
 	u8 prev_dump_seq;
+	u32 feature;
 };
 
 struct rtw_hal {
-- 
2.17.1

