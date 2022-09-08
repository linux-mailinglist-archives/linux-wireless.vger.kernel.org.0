Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 110D55B13E6
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Sep 2022 07:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiIHFNx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Sep 2022 01:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbiIHFNs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Sep 2022 01:13:48 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A52451144C
        for <linux-wireless@vger.kernel.org>; Wed,  7 Sep 2022 22:13:46 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2885DI1X0009794, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2885DI1X0009794
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 8 Sep 2022 13:13:18 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 8 Sep 2022 13:13:37 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Thu, 8 Sep 2022
 13:13:36 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <leo.li@realtek.com>, <timlee@realtek.com>, <echuang@realtek.com>,
        <phhuang@realtek.com>, <chiuyitang@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 9/9] wifi: rtw89: split scan including lots of channels
Date:   Thu, 8 Sep 2022 13:12:57 +0800
Message-ID: <20220908051257.25353-10-pkshih@realtek.com>
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
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Po-Hao Huang <phhuang@realtek.com>

The size limit of H2C commands is 2048. With regulatory that enables
U-NII-6 ~ UNII-8 channels, channel list length combining with channel info
length will exceed that. Split the channel list to parts and do scan
multiple times to workaround that.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h | 11 +++++++++++
 drivers/net/wireless/realtek/rtw89/fw.c   | 14 ++++++++++----
 drivers/net/wireless/realtek/rtw89/fw.h   |  4 ++++
 drivers/net/wireless/realtek/rtw89/mac.c  | 14 +++++++++++++-
 4 files changed, 38 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 5e6f767b05cb7..a9ff15dfe89d7 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3314,6 +3314,7 @@ struct rtw89_hw_scan_info {
 	u8 op_chan;
 	u8 op_bw;
 	u8 op_band;
+	u32 last_chan_idx;
 };
 
 enum rtw89_phy_bb_gain_band {
@@ -3740,6 +3741,16 @@ static inline struct ieee80211_vif *rtwvif_to_vif(struct rtw89_vif *rtwvif)
 	return container_of(p, struct ieee80211_vif, drv_priv);
 }
 
+static inline struct ieee80211_vif *rtwvif_to_vif_safe(struct rtw89_vif *rtwvif)
+{
+	return rtwvif ? rtwvif_to_vif(rtwvif) : NULL;
+}
+
+static inline struct rtw89_vif *vif_to_rtwvif_safe(struct ieee80211_vif *vif)
+{
+	return vif ? (struct rtw89_vif *)vif->drv_priv : NULL;
+}
+
 static inline struct ieee80211_sta *rtwsta_to_sta(struct rtw89_sta *rtwsta)
 {
 	void *p = rtwsta;
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index d8f3ee7a74716..15dc9a8e3fdb7 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -2405,13 +2405,16 @@ static int rtw89_hw_scan_add_chan_list(struct rtw89_dev *rtwdev,
 	struct ieee80211_channel *channel;
 	struct list_head chan_list;
 	bool random_seq = req->flags & NL80211_SCAN_FLAG_RANDOM_SN;
-	int list_len = req->n_channels, off_chan_time = 0;
+	int list_len, off_chan_time = 0;
 	enum rtw89_chan_type type;
-	int ret = 0, i;
+	int ret = 0;
+	u32 idx;
 
 	INIT_LIST_HEAD(&chan_list);
-	for (i = 0; i < req->n_channels; i++) {
-		channel = req->channels[i];
+	for (idx = rtwdev->scan_info.last_chan_idx, list_len = 0;
+	     idx < req->n_channels && list_len < RTW89_SCAN_LIST_LIMIT;
+	     idx++, list_len++) {
+		channel = req->channels[idx];
 		ch_info = kzalloc(sizeof(*ch_info), GFP_KERNEL);
 		if (!ch_info) {
 			ret = -ENOMEM;
@@ -2452,6 +2455,7 @@ static int rtw89_hw_scan_add_chan_list(struct rtw89_dev *rtwdev,
 		list_add_tail(&ch_info->list, &chan_list);
 		off_chan_time += ch_info->period;
 	}
+	rtwdev->scan_info.last_chan_idx = idx;
 	ret = rtw89_fw_h2c_scan_list_offload(rtwdev, list_len, &chan_list);
 
 out:
@@ -2486,6 +2490,7 @@ void rtw89_hw_scan_start(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
 	u8 mac_addr[ETH_ALEN];
 
 	rtwdev->scan_info.scanning_vif = vif;
+	rtwdev->scan_info.last_chan_idx = 0;
 	rtwvif->scan_ies = &scan_req->ies;
 	rtwvif->scan_req = req;
 	ieee80211_stop_queues(rtwdev->hw);
@@ -2533,6 +2538,7 @@ void rtw89_hw_scan_complete(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
 	rtwvif = (struct rtw89_vif *)vif->drv_priv;
 	rtwvif->scan_req = NULL;
 	rtwvif->scan_ies = NULL;
+	rtwdev->scan_info.last_chan_idx = 0;
 	rtwdev->scan_info.scanning_vif = NULL;
 
 	if (rtwvif->net_type != RTW89_NET_TYPE_NO_LINK)
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 9d1e785d5b4e9..1fce93823eaf5 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -177,6 +177,7 @@ struct rtw89_h2creg_sch_tx_en {
 	u16 rsvd:15;
 } __packed;
 
+#define RTW89_H2C_MAX_SIZE 2048
 #define RTW89_CHANNEL_TIME 45
 #define RTW89_DFS_CHAN_TIME 105
 #define RTW89_OFF_CHAN_TIME 100
@@ -187,6 +188,9 @@ struct rtw89_h2creg_sch_tx_en {
 #define RTW89_SCANOFLD_PKT_NONE 0xFF
 #define RTW89_SCANOFLD_DEBUG_MASK 0x1F
 #define RTW89_MAC_CHINFO_SIZE 24
+#define RTW89_SCAN_LIST_GUARD 4
+#define RTW89_SCAN_LIST_LIMIT \
+		((RTW89_H2C_MAX_SIZE / RTW89_MAC_CHINFO_SIZE) - RTW89_SCAN_LIST_GUARD)
 
 struct rtw89_mac_chinfo {
 	u8 period;
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index c020a0d44cee0..347bbe294e0db 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -3715,9 +3715,12 @@ rtw89_mac_c2h_scanofld_rsp(struct rtw89_dev *rtwdev, struct sk_buff *c2h,
 			   u32 len)
 {
 	struct ieee80211_vif *vif = rtwdev->scan_info.scanning_vif;
+	struct rtw89_vif *rtwvif = vif_to_rtwvif_safe(vif);
 	struct rtw89_chan new;
 	u8 reason, status, tx_fail, band, actual_period;
+	u32 last_chan = rtwdev->scan_info.last_chan_idx;
 	u16 chan;
+	int ret;
 
 	tx_fail = RTW89_GET_MAC_C2H_SCANOFLD_TX_FAIL(c2h->data);
 	status = RTW89_GET_MAC_C2H_SCANOFLD_STATUS(c2h->data);
@@ -3739,7 +3742,16 @@ rtw89_mac_c2h_scanofld_rsp(struct rtw89_dev *rtwdev, struct sk_buff *c2h,
 			ieee80211_stop_queues(rtwdev->hw);
 		return;
 	case RTW89_SCAN_END_SCAN_NOTIFY:
-		rtw89_hw_scan_complete(rtwdev, vif, false);
+		if (rtwvif && rtwvif->scan_req &&
+		    last_chan < rtwvif->scan_req->n_channels) {
+			ret = rtw89_hw_scan_offload(rtwdev, vif, true);
+			if (ret) {
+				rtw89_hw_scan_abort(rtwdev, vif);
+				rtw89_warn(rtwdev, "HW scan failed: %d\n", ret);
+			}
+		} else {
+			rtw89_hw_scan_complete(rtwdev, vif, false);
+		}
 		break;
 	case RTW89_SCAN_ENTER_CH_NOTIFY:
 		rtw89_chan_create(&new, chan, chan, band, RTW89_CHANNEL_WIDTH_20);
-- 
2.25.1

