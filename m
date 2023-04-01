Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29C556D30CD
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Apr 2023 14:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjDAMpx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 1 Apr 2023 08:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjDAMps (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 1 Apr 2023 08:45:48 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076E520C22
        for <linux-wireless@vger.kernel.org>; Sat,  1 Apr 2023 05:45:46 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 331CjHtaD021677, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 331CjHtaD021677
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Sat, 1 Apr 2023 20:45:17 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Sat, 1 Apr 2023 20:45:35 +0800
Received: from localhost (172.16.16.15) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Sat, 1 Apr 2023
 20:45:34 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@kernel.org>
CC:     <phhuang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 5/7] wifi: rtw88: refine reserved page flow for AP mode
Date:   Sat, 1 Apr 2023 20:44:08 +0800
Message-ID: <20230401124410.33221-6-pkshih@realtek.com>
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
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Po-Hao Huang <phhuang@realtek.com>

Only gather reserved pages from AP interface after it has started. Or
else ieee80211_beacon_get_*() returns NULL and causes other VIFs'
reserved pages fail to download. Update location of current reserved page
after beacon renews so offsets changed by beacon can be recognized.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/fw.c       | 5 +++++
 drivers/net/wireless/realtek/rtw88/mac80211.c | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
index 82295ac6402ee..049473accdb97 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.c
+++ b/drivers/net/wireless/realtek/rtw88/fw.c
@@ -1393,6 +1393,10 @@ static void rtw_build_rsvd_page_iter(void *data, u8 *mac,
 	struct rtw_vif *rtwvif = (struct rtw_vif *)vif->drv_priv;
 	struct rtw_rsvd_page *rsvd_pkt;
 
+	/* AP not yet started, don't gather its rsvd pages */
+	if (vif->type == NL80211_IFTYPE_AP && !rtwdev->ap_active)
+		return;
+
 	list_for_each_entry(rsvd_pkt, &rtwvif->rsvd_page_list, vif_list) {
 		if (rsvd_pkt->type == RSVD_BEACON)
 			list_add(&rsvd_pkt->build_list,
@@ -1614,6 +1618,7 @@ void rtw_fw_update_beacon_work(struct work_struct *work)
 
 	mutex_lock(&rtwdev->mutex);
 	rtw_fw_download_rsvd_page(rtwdev);
+	rtw_send_rsvd_page_h2c(rtwdev);
 	mutex_unlock(&rtwdev->mutex);
 }
 
diff --git a/drivers/net/wireless/realtek/rtw88/mac80211.c b/drivers/net/wireless/realtek/rtw88/mac80211.c
index 37a3146a2910c..1c2213957f449 100644
--- a/drivers/net/wireless/realtek/rtw88/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw88/mac80211.c
@@ -417,6 +417,7 @@ static void rtw_ops_bss_info_changed(struct ieee80211_hw *hw,
 	if (changed & BSS_CHANGED_BEACON) {
 		rtw_set_dtim_period(rtwdev, conf->dtim_period);
 		rtw_fw_download_rsvd_page(rtwdev);
+		rtw_send_rsvd_page_h2c(rtwdev);
 	}
 
 	if (changed & BSS_CHANGED_BEACON_ENABLED) {
-- 
2.25.1

