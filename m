Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0BC6E22E6
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Apr 2023 14:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjDNMMN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Apr 2023 08:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbjDNMML (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Apr 2023 08:12:11 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A1CE69
        for <linux-wireless@vger.kernel.org>; Fri, 14 Apr 2023 05:12:09 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 33ECBcqT6007106, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 33ECBcqT6007106
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 14 Apr 2023 20:11:38 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 14 Apr 2023 20:12:01 +0800
Received: from localhost (172.16.20.53) by RTEXDAG02.realtek.com.tw
 (172.21.6.101) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 14 Apr
 2023 20:12:00 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@kernel.org>
CC:     <phhuang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 4/8] wifi: rtw88: disallow PS during AP mode
Date:   Fri, 14 Apr 2023 20:11:31 +0800
Message-ID: <20230414121135.17828-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230414121135.17828-1-pkshih@realtek.com>
References: <20230414121135.17828-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.20.53]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXDAG02.realtek.com.tw (172.21.6.101)
X-KSE-ServerInfo: RTEXDAG02.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
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

Firmware can't support PS mode during AP mode, so disallow this case.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2: don't reject doing scan, and change the subject as well.
---
 drivers/net/wireless/realtek/rtw88/mac80211.c | 13 +++++++++++++
 drivers/net/wireless/realtek/rtw88/main.c     |  2 +-
 drivers/net/wireless/realtek/rtw88/main.h     |  1 +
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/mac80211.c b/drivers/net/wireless/realtek/rtw88/mac80211.c
index 19c4d7c29759e..1ced57b090832 100644
--- a/drivers/net/wireless/realtek/rtw88/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw88/mac80211.c
@@ -449,12 +449,24 @@ static int rtw_ops_start_ap(struct ieee80211_hw *hw,
 	const struct rtw_chip_info *chip = rtwdev->chip;
 
 	mutex_lock(&rtwdev->mutex);
+	rtwdev->ap_active = true;
 	chip->ops->phy_calibration(rtwdev);
 	mutex_unlock(&rtwdev->mutex);
 
 	return 0;
 }
 
+static void rtw_ops_stop_ap(struct ieee80211_hw *hw,
+			    struct ieee80211_vif *vif,
+			    struct ieee80211_bss_conf *link_conf)
+{
+	struct rtw_dev *rtwdev = hw->priv;
+
+	mutex_lock(&rtwdev->mutex);
+	rtwdev->ap_active = false;
+	mutex_unlock(&rtwdev->mutex);
+}
+
 static int rtw_ops_conf_tx(struct ieee80211_hw *hw,
 			   struct ieee80211_vif *vif,
 			   unsigned int link_id, u16 ac,
@@ -916,6 +928,7 @@ const struct ieee80211_ops rtw_ops = {
 	.configure_filter	= rtw_ops_configure_filter,
 	.bss_info_changed	= rtw_ops_bss_info_changed,
 	.start_ap		= rtw_ops_start_ap,
+	.stop_ap		= rtw_ops_stop_ap,
 	.conf_tx		= rtw_ops_conf_tx,
 	.sta_add		= rtw_ops_sta_add,
 	.sta_remove		= rtw_ops_sta_remove,
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index abebccd0581a2..4537513d06689 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -257,7 +257,7 @@ static void rtw_watch_dog_work(struct work_struct *work)
 	 * threshold.
 	 */
 	if (rtwdev->ps_enabled && data.rtwvif && !ps_active &&
-	    !rtwdev->beacon_loss)
+	    !rtwdev->beacon_loss && !rtwdev->ap_active)
 		rtw_enter_lps(rtwdev, data.rtwvif->port);
 
 	rtwdev->watch_dog_cnt++;
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 532c56219a5f5..b04ed190ea5d4 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -2058,6 +2058,7 @@ struct rtw_dev {
 
 	bool need_rfk;
 	struct completion fw_scan_density;
+	bool ap_active;
 
 	/* hci related data, must be last */
 	u8 priv[] __aligned(sizeof(void *));
-- 
2.25.1

