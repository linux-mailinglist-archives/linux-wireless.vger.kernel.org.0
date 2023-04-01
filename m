Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D362E6D30C9
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Apr 2023 14:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjDAMpv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 1 Apr 2023 08:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjDAMps (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 1 Apr 2023 08:45:48 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0191E20318
        for <linux-wireless@vger.kernel.org>; Sat,  1 Apr 2023 05:45:45 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 331CjI8T1021691, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 331CjI8T1021691
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Sat, 1 Apr 2023 20:45:18 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Sat, 1 Apr 2023 20:45:36 +0800
Received: from localhost (172.16.16.15) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Sat, 1 Apr 2023
 20:45:35 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@kernel.org>
CC:     <phhuang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 6/7] wifi: rtw88: prevent scan abort with other VIFs
Date:   Sat, 1 Apr 2023 20:44:09 +0800
Message-ID: <20230401124410.33221-7-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230401124410.33221-1-pkshih@realtek.com>
References: <20230401124410.33221-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.16.15]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Po-Hao Huang <phhuang@realtek.com>

Only abort scan with current scanning VIF. If we have more than one
interface, we could call rtw_hw_scan_abort() with the wrong VIF as
input. This avoids potential null pointer being accessed when actually
the other VIF is scanning.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/fw.c       | 4 +++-
 drivers/net/wireless/realtek/rtw88/fw.h       | 2 +-
 drivers/net/wireless/realtek/rtw88/mac80211.c | 7 ++++---
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
index 049473accdb97..f2d48091b1e98 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.c
+++ b/drivers/net/wireless/realtek/rtw88/fw.c
@@ -2163,8 +2163,10 @@ int rtw_hw_scan_offload(struct rtw_dev *rtwdev, struct ieee80211_vif *vif,
 	return ret;
 }
 
-void rtw_hw_scan_abort(struct rtw_dev *rtwdev, struct ieee80211_vif *vif)
+void rtw_hw_scan_abort(struct rtw_dev *rtwdev)
 {
+	struct ieee80211_vif *vif = rtwdev->scan_info.scanning_vif;
+
 	if (!rtw_fw_feature_check(&rtwdev->fw, FW_FEATURE_SCAN_OFFLOAD))
 		return;
 
diff --git a/drivers/net/wireless/realtek/rtw88/fw.h b/drivers/net/wireless/realtek/rtw88/fw.h
index 0a386e6d6e0d1..397cbc3f6af6e 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.h
+++ b/drivers/net/wireless/realtek/rtw88/fw.h
@@ -868,5 +868,5 @@ int rtw_hw_scan_offload(struct rtw_dev *rtwdev, struct ieee80211_vif *vif,
 			bool enable);
 void rtw_hw_scan_status_report(struct rtw_dev *rtwdev, struct sk_buff *skb);
 void rtw_hw_scan_chan_switch(struct rtw_dev *rtwdev, struct sk_buff *skb);
-void rtw_hw_scan_abort(struct rtw_dev *rtwdev, struct ieee80211_vif *vif);
+void rtw_hw_scan_abort(struct rtw_dev *rtwdev);
 #endif
diff --git a/drivers/net/wireless/realtek/rtw88/mac80211.c b/drivers/net/wireless/realtek/rtw88/mac80211.c
index 1c2213957f449..41a9e4fe58b47 100644
--- a/drivers/net/wireless/realtek/rtw88/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw88/mac80211.c
@@ -393,7 +393,8 @@ static void rtw_ops_bss_info_changed(struct ieee80211_hw *hw,
 			 * when disconnected by peer
 			 */
 			if (test_bit(RTW_FLAG_SCANNING, rtwdev->flags))
-				rtw_hw_scan_abort(rtwdev, vif);
+				rtw_hw_scan_abort(rtwdev);
+
 		}
 
 		config |= PORT_SET_NET_TYPE;
@@ -873,7 +874,7 @@ static int rtw_ops_hw_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	rtw_hw_scan_start(rtwdev, vif, req);
 	ret = rtw_hw_scan_offload(rtwdev, vif, true);
 	if (ret) {
-		rtw_hw_scan_abort(rtwdev, vif);
+		rtw_hw_scan_abort(rtwdev);
 		rtw_err(rtwdev, "HW scan failed with status: %d\n", ret);
 	}
 	mutex_unlock(&rtwdev->mutex);
@@ -893,7 +894,7 @@ static void rtw_ops_cancel_hw_scan(struct ieee80211_hw *hw,
 		return;
 
 	mutex_lock(&rtwdev->mutex);
-	rtw_hw_scan_abort(rtwdev, vif);
+	rtw_hw_scan_abort(rtwdev);
 	mutex_unlock(&rtwdev->mutex);
 }
 
-- 
2.25.1

