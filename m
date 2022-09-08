Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 004C85B13E4
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Sep 2022 07:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbiIHFNv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Sep 2022 01:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiIHFNs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Sep 2022 01:13:48 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7DE36B7EC9
        for <linux-wireless@vger.kernel.org>; Wed,  7 Sep 2022 22:13:45 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2885DHSD0009755, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2885DHSD0009755
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 8 Sep 2022 13:13:17 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 8 Sep 2022 13:13:36 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Thu, 8 Sep 2022
 13:13:35 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <leo.li@realtek.com>, <timlee@realtek.com>, <echuang@realtek.com>,
        <phhuang@realtek.com>, <chiuyitang@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 8/9] wifi: rtw89: 8852c: support hw_scan
Date:   Thu, 8 Sep 2022 13:12:56 +0800
Message-ID: <20220908051257.25353-9-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220908051257.25353-1-pkshih@realtek.com>
References: <20220908051257.25353-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 09/08/2022 04:54:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzkvOCCkV6TIIDEyOjQ5OjAw?=
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

From: Po-Hao Huang <phhuang@realtek.com>

This enables hw_scan function for 52c. The mechanism is similar to 52a
except that it adds modifications required for 6G channels and extends the
command length to make driver compatible to both newer and existing
firmware.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h | 14 ++++++++++++++
 drivers/net/wireless/realtek/rtw89/fw.c   |  9 ++++++---
 drivers/net/wireless/realtek/rtw89/fw.h   |  4 +++-
 drivers/net/wireless/realtek/rtw89/mac.c  |  7 ++++---
 4 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 5beaf311df052..5e6f767b05cb7 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3783,6 +3783,20 @@ enum nl80211_band rtw89_hw_to_nl80211_band(enum rtw89_band hw_band)
 	}
 }
 
+static inline
+enum rtw89_band rtw89_nl80211_to_hw_band(enum nl80211_band nl_band)
+{
+	switch (nl_band) {
+	default:
+	case NL80211_BAND_2GHZ:
+		return RTW89_BAND_2G;
+	case NL80211_BAND_5GHZ:
+		return RTW89_BAND_5G;
+	case NL80211_BAND_6GHZ:
+		return RTW89_BAND_6G;
+	}
+}
+
 static inline
 enum rtw89_bandwidth nl_to_rtw89_bandwidth(enum nl80211_chan_width width)
 {
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 72f6534754fff..d8f3ee7a74716 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -227,6 +227,7 @@ static const struct __fw_feat_cfg fw_feat_tbl[] = {
 	__CFG_FW_FEAT(RTL8852A, ge, 0, 13, 36, 0, CRASH_TRIGGER),
 	__CFG_FW_FEAT(RTL8852C, le, 0, 27, 33, 0, NO_DEEP_PS),
 	__CFG_FW_FEAT(RTL8852C, ge, 0, 27, 34, 0, TX_WAKE),
+	__CFG_FW_FEAT(RTL8852C, ge, 0, 27, 36, 0, SCAN_OFFLOAD),
 };
 
 static void rtw89_fw_recognize_features(struct rtw89_dev *rtwdev)
@@ -1895,7 +1896,7 @@ int rtw89_fw_h2c_scan_list_offload(struct rtw89_dev *rtwdev, int len,
 	return -EBUSY;
 }
 
-#define H2C_LEN_SCAN_OFFLOAD 20
+#define H2C_LEN_SCAN_OFFLOAD 28
 int rtw89_fw_h2c_scan_offload(struct rtw89_dev *rtwdev,
 			      struct rtw89_scan_option *option,
 			      struct rtw89_vif *rtwvif)
@@ -1926,6 +1927,8 @@ int rtw89_fw_h2c_scan_offload(struct rtw89_dev *rtwdev,
 						       scan_info->op_pri_ch);
 		RTW89_SET_FWCMD_SCANOFLD_TARGET_CENTRAL_CH(cmd,
 							   scan_info->op_chan);
+		RTW89_SET_FWCMD_SCANOFLD_TARGET_CH_BAND(cmd,
+							scan_info->op_band);
 	}
 
 	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
@@ -2360,7 +2363,7 @@ static void rtw89_hw_scan_add_chan(struct rtw89_dev *rtwdev, int chan_type,
 
 	if (ssid_num) {
 		ch_info->num_pkt = ssid_num;
-		band = ch_info->ch_band;
+		band = rtw89_hw_to_nl80211_band(ch_info->ch_band);
 
 		list_for_each_entry(info, &scan_info->pkt_list[band], list) {
 			ch_info->probe_id = info->id;
@@ -2417,7 +2420,7 @@ static int rtw89_hw_scan_add_chan_list(struct rtw89_dev *rtwdev,
 
 		ch_info->period = req->duration_mandatory ?
 				  req->duration : RTW89_CHANNEL_TIME;
-		ch_info->ch_band = channel->band;
+		ch_info->ch_band = rtw89_nl80211_to_hw_band(channel->band);
 		ch_info->central_ch = channel->hw_value;
 		ch_info->pri_ch = channel->hw_value;
 		ch_info->rand_seq_num = random_seq;
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index edd43f00994c4..9d1e785d5b4e9 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -186,7 +186,7 @@ struct rtw89_h2creg_sch_tx_en {
 #define RTW89_SCANOFLD_MAX_IE_LEN 512
 #define RTW89_SCANOFLD_PKT_NONE 0xFF
 #define RTW89_SCANOFLD_DEBUG_MASK 0x1F
-#define RTW89_MAC_CHINFO_SIZE 20
+#define RTW89_MAC_CHINFO_SIZE 24
 
 struct rtw89_mac_chinfo {
 	u8 period;
@@ -2456,6 +2456,8 @@ static inline void RTW89_SET_FWCMD_SCANOFLD_TSF_SLOW(void *cmd, u32 val)
 	le32_get_bits(*((const __le32 *)(c2h) + 2), GENMASK(19, 16))
 #define RTW89_GET_MAC_C2H_SCANOFLD_STATUS(c2h) \
 	le32_get_bits(*((const __le32 *)(c2h) + 2), GENMASK(23, 20))
+#define RTW89_GET_MAC_C2H_ACTUAL_PERIOD(c2h) \
+	le32_get_bits(*((const __le32 *)(c2h) + 2), GENMASK(31, 24))
 #define RTW89_GET_MAC_C2H_SCANOFLD_TX_FAIL(c2h) \
 	le32_get_bits(*((const __le32 *)(c2h) + 5), GENMASK(3, 0))
 #define RTW89_GET_MAC_C2H_SCANOFLD_AIR_DENSITY(c2h) \
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 6621e98d514b2..c020a0d44cee0 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -3716,7 +3716,7 @@ rtw89_mac_c2h_scanofld_rsp(struct rtw89_dev *rtwdev, struct sk_buff *c2h,
 {
 	struct ieee80211_vif *vif = rtwdev->scan_info.scanning_vif;
 	struct rtw89_chan new;
-	u8 reason, status, tx_fail, band;
+	u8 reason, status, tx_fail, band, actual_period;
 	u16 chan;
 
 	tx_fail = RTW89_GET_MAC_C2H_SCANOFLD_TX_FAIL(c2h->data);
@@ -3724,13 +3724,14 @@ rtw89_mac_c2h_scanofld_rsp(struct rtw89_dev *rtwdev, struct sk_buff *c2h,
 	chan = RTW89_GET_MAC_C2H_SCANOFLD_PRI_CH(c2h->data);
 	reason = RTW89_GET_MAC_C2H_SCANOFLD_RSP(c2h->data);
 	band = RTW89_GET_MAC_C2H_SCANOFLD_BAND(c2h->data);
+	actual_period = RTW89_GET_MAC_C2H_ACTUAL_PERIOD(c2h->data);
 
 	if (!(rtwdev->chip->support_bands & BIT(NL80211_BAND_6GHZ)))
 		band = chan > 14 ? RTW89_BAND_5G : RTW89_BAND_2G;
 
 	rtw89_debug(rtwdev, RTW89_DBG_HW_SCAN,
-		    "band: %d, chan: %d, reason: %d, status: %d, tx_fail: %d\n",
-		    band, chan, reason, status, tx_fail);
+		    "band: %d, chan: %d, reason: %d, status: %d, tx_fail: %d, actual: %d\n",
+		    band, chan, reason, status, tx_fail, actual_period);
 
 	switch (reason) {
 	case RTW89_SCAN_LEAVE_CH_NOTIFY:
-- 
2.25.1

