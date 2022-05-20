Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E06F952E607
	for <lists+linux-wireless@lfdr.de>; Fri, 20 May 2022 09:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345351AbiETHSd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 May 2022 03:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239625AbiETHSc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 May 2022 03:18:32 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF102E0AF
        for <linux-wireless@vger.kernel.org>; Fri, 20 May 2022 00:17:57 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 24K7HpkaE023703, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 24K7HpkaE023703
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 20 May 2022 15:17:51 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 20 May 2022 15:17:51 +0800
Received: from localhost (172.16.17.21) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 20 May
 2022 15:17:50 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <phhuang@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH 1/6] rtw89: fix channel inconsistency during hw_scan
Date:   Fri, 20 May 2022 15:17:26 +0800
Message-ID: <20220520071731.38563-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220520071731.38563-1-pkshih@realtek.com>
References: <20220520071731.38563-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.17.21]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 05/20/2022 06:55:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzUvMjAgpFekyCAwNjowMDowMA==?=
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

From: Po Hao Huang <phhuang@realtek.com>

Previously channel maintained by driver could be different from the
ones hardware actually is. Restore these variables back to prevent
unexpected behavior.

Signed-off-by: Po Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c     |  2 +-
 drivers/net/wireless/realtek/rtw89/fw.c       | 20 ++++++++++++++-----
 drivers/net/wireless/realtek/rtw89/fw.h       |  5 +----
 drivers/net/wireless/realtek/rtw89/mac.c      | 15 ++++++++------
 drivers/net/wireless/realtek/rtw89/mac80211.c |  2 +-
 5 files changed, 27 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index a6a90572e74bf..e24e133a94df6 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -1608,7 +1608,7 @@ static void rtw89_core_update_rx_status(struct rtw89_dev *rtwdev,
 
 	if (rtwdev->scanning &&
 	    RTW89_CHK_FW_FEATURE(SCAN_OFFLOAD, &rtwdev->fw)) {
-		u8 chan = hal->current_channel;
+		u8 chan = hal->current_primary_channel;
 		u8 band = hal->current_band_type;
 		enum nl80211_band nl_band;
 
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 4718aced1428a..7fb4509a6c72a 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -2339,6 +2339,9 @@ void rtw89_hw_scan_complete(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
 	rtwvif->scan_req = NULL;
 	rtwvif->scan_ies = NULL;
 	rtwdev->scan_info.scanning_vif = NULL;
+
+	if (rtwvif->net_type != RTW89_NET_TYPE_NO_LINK)
+		rtw89_store_op_chan(rtwdev, false);
 }
 
 void rtw89_hw_scan_abort(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif)
@@ -2370,15 +2373,22 @@ int rtw89_hw_scan_offload(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
 	return ret;
 }
 
-void rtw89_store_op_chan(struct rtw89_dev *rtwdev)
+void rtw89_store_op_chan(struct rtw89_dev *rtwdev, bool backup)
 {
 	struct rtw89_hw_scan_info *scan_info = &rtwdev->scan_info;
 	struct rtw89_hal *hal = &rtwdev->hal;
 
-	scan_info->op_pri_ch = hal->current_primary_channel;
-	scan_info->op_chan = hal->current_channel;
-	scan_info->op_bw = hal->current_band_width;
-	scan_info->op_band = hal->current_band_type;
+	if (backup) {
+		scan_info->op_pri_ch = hal->current_primary_channel;
+		scan_info->op_chan = hal->current_channel;
+		scan_info->op_bw = hal->current_band_width;
+		scan_info->op_band = hal->current_band_type;
+	} else {
+		hal->current_primary_channel = scan_info->op_pri_ch;
+		hal->current_channel = scan_info->op_chan;
+		hal->current_band_width = scan_info->op_bw;
+		hal->current_band_type = scan_info->op_band;
+	}
 }
 
 #define H2C_FW_CPU_EXCEPTION_LEN 4
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 95a55c4213db3..e75ad22aa85df 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -2633,17 +2633,14 @@ int rtw89_fw_msg_reg(struct rtw89_dev *rtwdev,
 		     struct rtw89_mac_c2h_info *c2h_info);
 int rtw89_fw_h2c_fw_log(struct rtw89_dev *rtwdev, bool enable);
 void rtw89_fw_st_dbg_dump(struct rtw89_dev *rtwdev);
-void rtw89_store_op_chan(struct rtw89_dev *rtwdev);
+void rtw89_store_op_chan(struct rtw89_dev *rtwdev, bool backup);
 void rtw89_hw_scan_start(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
 			 struct ieee80211_scan_request *req);
 void rtw89_hw_scan_complete(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
 			    bool aborted);
 int rtw89_hw_scan_offload(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
 			  bool enable);
-void rtw89_hw_scan_status_report(struct rtw89_dev *rtwdev, struct sk_buff *skb);
-void rtw89_hw_scan_chan_switch(struct rtw89_dev *rtwdev, struct sk_buff *skb);
 void rtw89_hw_scan_abort(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif);
-void rtw89_store_op_chan(struct rtw89_dev *rtwdev);
 int rtw89_fw_h2c_trigger_cpu_exception(struct rtw89_dev *rtwdev);
 
 #endif
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 3cf892912c1d9..93124b815825f 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -3681,17 +3681,20 @@ rtw89_mac_c2h_scanofld_rsp(struct rtw89_dev *rtwdev, struct sk_buff *c2h,
 		rtw89_hw_scan_complete(rtwdev, vif, false);
 		break;
 	case RTW89_SCAN_ENTER_CH_NOTIFY:
-		if (rtw89_is_op_chan(rtwdev, band, chan))
+		hal->prev_band_type = hal->current_band_type;
+		hal->current_band_type = band;
+		hal->prev_primary_channel = hal->current_primary_channel;
+		hal->current_primary_channel = chan;
+		hal->current_channel = chan;
+		hal->current_band_width = RTW89_CHANNEL_WIDTH_20;
+		if (rtw89_is_op_chan(rtwdev, band, chan)) {
+			rtw89_store_op_chan(rtwdev, false);
 			ieee80211_wake_queues(rtwdev->hw);
+		}
 		break;
 	default:
 		return;
 	}
-
-	hal->prev_band_type = hal->current_band_type;
-	hal->prev_primary_channel = hal->current_channel;
-	hal->current_channel = chan;
-	hal->current_band_type = band;
 }
 
 static void
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index f24e4a208376b..6d0c62c545a78 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -350,7 +350,7 @@ static void rtw89_ops_bss_info_changed(struct ieee80211_hw *hw,
 			rtw89_phy_set_bss_color(rtwdev, vif);
 			rtw89_chip_cfg_txpwr_ul_tb_offset(rtwdev, vif);
 			rtw89_mac_port_update(rtwdev, rtwvif);
-			rtw89_store_op_chan(rtwdev);
+			rtw89_store_op_chan(rtwdev, true);
 		} else {
 			/* Abort ongoing scan if cancel_scan isn't issued
 			 * when disconnected by peer
-- 
2.25.1

