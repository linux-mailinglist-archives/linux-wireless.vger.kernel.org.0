Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73C7E4BB06C
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Feb 2022 04:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiBRD4W (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Feb 2022 22:56:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiBRD4V (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Feb 2022 22:56:21 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0716F2E59DC
        for <linux-wireless@vger.kernel.org>; Thu, 17 Feb 2022 19:56:04 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 21I3tllwF026460, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 21I3tllwF026460
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 18 Feb 2022 11:55:47 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 18 Feb 2022 11:55:47 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Fri, 18 Feb
 2022 11:55:47 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <Larry.Finger@lwfinger.net>
Subject: [PATCH] rtw88: change rtw_info() to proper message level
Date:   Fri, 18 Feb 2022 11:55:27 +0800
Message-ID: <20220218035527.9835-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 02/18/2022 03:45:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzIvMTggpFekyCAwMTo1MDowMA==?=
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

Larry reported funny log entries [1] when he used rtl8821ce. These
messages are not harmless, but not useful for users, so change them to
rtw_dbg() level. By the way, I review all rtw_info() and change others
to rtw_warn().

[1] https://lore.kernel.org/linux-wireless/c356d5ae-a7b3-3065-1121-64c446e70333@lwfinger.net/

Reported-by: Larry Finger <Larry.Finger@lwfinger.net>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/debug.c    | 2 +-
 drivers/net/wireless/realtek/rtw88/debug.h    | 1 +
 drivers/net/wireless/realtek/rtw88/fw.c       | 2 +-
 drivers/net/wireless/realtek/rtw88/mac80211.c | 8 ++++----
 drivers/net/wireless/realtek/rtw88/main.c     | 8 ++++----
 drivers/net/wireless/realtek/rtw88/rtw8821c.c | 2 +-
 drivers/net/wireless/realtek/rtw88/rtw8822b.c | 4 ++--
 drivers/net/wireless/realtek/rtw88/rtw8822c.c | 4 ++--
 drivers/net/wireless/realtek/rtw88/sar.c      | 8 ++++----
 9 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/debug.c b/drivers/net/wireless/realtek/rtw88/debug.c
index e429428232c15..e7e9f17df96a3 100644
--- a/drivers/net/wireless/realtek/rtw88/debug.c
+++ b/drivers/net/wireless/realtek/rtw88/debug.c
@@ -390,7 +390,7 @@ static ssize_t rtw_debugfs_set_h2c(struct file *filp,
 		     &param[0], &param[1], &param[2], &param[3],
 		     &param[4], &param[5], &param[6], &param[7]);
 	if (num != 8) {
-		rtw_info(rtwdev, "invalid H2C command format for debug\n");
+		rtw_warn(rtwdev, "invalid H2C command format for debug\n");
 		return -EINVAL;
 	}
 
diff --git a/drivers/net/wireless/realtek/rtw88/debug.h b/drivers/net/wireless/realtek/rtw88/debug.h
index 61f8369fe2d61..066792dd96afb 100644
--- a/drivers/net/wireless/realtek/rtw88/debug.h
+++ b/drivers/net/wireless/realtek/rtw88/debug.h
@@ -23,6 +23,7 @@ enum rtw_debug_mask {
 	RTW_DBG_PATH_DIV	= 0x00004000,
 	RTW_DBG_ADAPTIVITY	= 0x00008000,
 	RTW_DBG_HW_SCAN		= 0x00010000,
+	RTW_DBG_STATE		= 0x00020000,
 
 	RTW_DBG_ALL		= 0xffffffff
 };
diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
index 4c8e5ea5d069c..db90d75a86339 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.c
+++ b/drivers/net/wireless/realtek/rtw88/fw.c
@@ -2131,7 +2131,7 @@ void rtw_hw_scan_status_report(struct rtw_dev *rtwdev, struct sk_buff *skb)
 	rtw_hw_scan_complete(rtwdev, vif, aborted);
 
 	if (aborted)
-		rtw_info(rtwdev, "HW scan aborted with code: %d\n", rc);
+		rtw_dbg(rtwdev, RTW_DBG_HW_SCAN, "HW scan aborted with code: %d\n", rc);
 }
 
 void rtw_store_op_chan(struct rtw_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw88/mac80211.c b/drivers/net/wireless/realtek/rtw88/mac80211.c
index 647d2662955ba..5cdc54c9a9aae 100644
--- a/drivers/net/wireless/realtek/rtw88/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw88/mac80211.c
@@ -208,7 +208,7 @@ static int rtw_ops_add_interface(struct ieee80211_hw *hw,
 
 	mutex_unlock(&rtwdev->mutex);
 
-	rtw_info(rtwdev, "start vif %pM on port %d\n", vif->addr, rtwvif->port);
+	rtw_dbg(rtwdev, RTW_DBG_STATE, "start vif %pM on port %d\n", vif->addr, rtwvif->port);
 	return 0;
 }
 
@@ -219,7 +219,7 @@ static void rtw_ops_remove_interface(struct ieee80211_hw *hw,
 	struct rtw_vif *rtwvif = (struct rtw_vif *)vif->drv_priv;
 	u32 config = 0;
 
-	rtw_info(rtwdev, "stop vif %pM on port %d\n", vif->addr, rtwvif->port);
+	rtw_dbg(rtwdev, RTW_DBG_STATE, "stop vif %pM on port %d\n", vif->addr, rtwvif->port);
 
 	mutex_lock(&rtwdev->mutex);
 
@@ -245,8 +245,8 @@ static int rtw_ops_change_interface(struct ieee80211_hw *hw,
 {
 	struct rtw_dev *rtwdev = hw->priv;
 
-	rtw_info(rtwdev, "change vif %pM (%d)->(%d), p2p (%d)->(%d)\n",
-		 vif->addr, vif->type, type, vif->p2p, p2p);
+	rtw_dbg(rtwdev, RTW_DBG_STATE, "change vif %pM (%d)->(%d), p2p (%d)->(%d)\n",
+		vif->addr, vif->type, type, vif->p2p, p2p);
 
 	rtw_ops_remove_interface(hw, vif);
 
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 2757aa0dc586b..389eb1bd0a23c 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -314,8 +314,8 @@ int rtw_sta_add(struct rtw_dev *rtwdev, struct ieee80211_sta *sta,
 
 	rtwdev->sta_cnt++;
 	rtwdev->beacon_loss = false;
-	rtw_info(rtwdev, "sta %pM joined with macid %d\n",
-		 sta->addr, si->mac_id);
+	rtw_dbg(rtwdev, RTW_DBG_STATE, "sta %pM joined with macid %d\n",
+		sta->addr, si->mac_id);
 
 	return 0;
 }
@@ -336,8 +336,8 @@ void rtw_sta_remove(struct rtw_dev *rtwdev, struct ieee80211_sta *sta,
 	kfree(si->mask);
 
 	rtwdev->sta_cnt--;
-	rtw_info(rtwdev, "sta %pM with macid %d left\n",
-		 sta->addr, si->mac_id);
+	rtw_dbg(rtwdev, RTW_DBG_STATE, "sta %pM with macid %d left\n",
+		sta->addr, si->mac_id);
 }
 
 struct rtw_fwcd_hdr {
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.c b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
index b1f4afb508308..7b4dcc093aac1 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
@@ -499,7 +499,7 @@ static s8 get_cck_rx_pwr(struct rtw_dev *rtwdev, u8 lna_idx, u8 vga_idx)
 	}
 
 	if (lna_idx >= lna_gain_table_size) {
-		rtw_info(rtwdev, "incorrect lna index (%d)\n", lna_idx);
+		rtw_warn(rtwdev, "incorrect lna index (%d)\n", lna_idx);
 		return -120;
 	}
 
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822b.c b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
index dd4fbb82750d5..a23806b69b0fa 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
@@ -1012,12 +1012,12 @@ static int rtw8822b_set_antenna(struct rtw_dev *rtwdev,
 		antenna_tx, antenna_rx);
 
 	if (!rtw8822b_check_rf_path(antenna_tx)) {
-		rtw_info(rtwdev, "unsupported tx path 0x%x\n", antenna_tx);
+		rtw_warn(rtwdev, "unsupported tx path 0x%x\n", antenna_tx);
 		return -EINVAL;
 	}
 
 	if (!rtw8822b_check_rf_path(antenna_rx)) {
-		rtw_info(rtwdev, "unsupported rx path 0x%x\n", antenna_rx);
+		rtw_warn(rtwdev, "unsupported rx path 0x%x\n", antenna_rx);
 		return -EINVAL;
 	}
 
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index 35c46e5209de3..ddf4d1a23e605 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -2798,7 +2798,7 @@ static int rtw8822c_set_antenna(struct rtw_dev *rtwdev,
 	case BB_PATH_AB:
 		break;
 	default:
-		rtw_info(rtwdev, "unsupported tx path 0x%x\n", antenna_tx);
+		rtw_warn(rtwdev, "unsupported tx path 0x%x\n", antenna_tx);
 		return -EINVAL;
 	}
 
@@ -2808,7 +2808,7 @@ static int rtw8822c_set_antenna(struct rtw_dev *rtwdev,
 	case BB_PATH_AB:
 		break;
 	default:
-		rtw_info(rtwdev, "unsupported rx path 0x%x\n", antenna_rx);
+		rtw_warn(rtwdev, "unsupported rx path 0x%x\n", antenna_rx);
 		return -EINVAL;
 	}
 
diff --git a/drivers/net/wireless/realtek/rtw88/sar.c b/drivers/net/wireless/realtek/rtw88/sar.c
index 3383726c4d90f..c472f1502b82a 100644
--- a/drivers/net/wireless/realtek/rtw88/sar.c
+++ b/drivers/net/wireless/realtek/rtw88/sar.c
@@ -91,10 +91,10 @@ int rtw_set_sar_specs(struct rtw_dev *rtwdev,
 			return -EINVAL;
 
 		power = sar->sub_specs[i].power;
-		rtw_info(rtwdev, "On freq %u to %u, set SAR %d in 1/%lu dBm\n",
-			 rtw_common_sar_freq_ranges[idx].start_freq,
-			 rtw_common_sar_freq_ranges[idx].end_freq,
-			 power, BIT(RTW_COMMON_SAR_FCT));
+		rtw_dbg(rtwdev, RTW_DBG_REGD, "On freq %u to %u, set SAR %d in 1/%lu dBm\n",
+			rtw_common_sar_freq_ranges[idx].start_freq,
+			rtw_common_sar_freq_ranges[idx].end_freq,
+			power, BIT(RTW_COMMON_SAR_FCT));
 
 		for (j = 0; j < RTW_RF_PATH_MAX; j++) {
 			for (k = 0; k < RTW_RATE_SECTION_MAX; k++) {
-- 
2.25.1

