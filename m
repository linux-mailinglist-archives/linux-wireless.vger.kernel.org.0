Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3A4527B22
	for <lists+linux-wireless@lfdr.de>; Mon, 16 May 2022 02:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236491AbiEPAwj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 15 May 2022 20:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232404AbiEPAwg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 15 May 2022 20:52:36 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFD52558A
        for <linux-wireless@vger.kernel.org>; Sun, 15 May 2022 17:52:34 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 24G0qSJr9000815, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 24G0qSJr9000815
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 16 May 2022 08:52:28 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 16 May 2022 08:52:28 +0800
Received: from localhost (172.16.17.21) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Mon, 16 May
 2022 08:52:27 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <kevin_yang@realtek.com>
Subject: [PATCH v2 1/6] rtw89: add ieee80211::sta_rc_update ops
Date:   Mon, 16 May 2022 08:52:10 +0800
Message-ID: <20220516005215.5878-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220516005215.5878-1-pkshih@realtek.com>
References: <20220516005215.5878-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 05/16/2022 00:38:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzUvMTUgpFWkyCAxMDowMDowMA==?=
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

When peer's NSS, rate or bandwidth is changed, we update RA(rate adaptive)
mask to ensure transmitting packets properly.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac80211.c | 12 +++++++++++-
 drivers/net/wireless/realtek/rtw89/phy.c      | 12 +++++++++---
 drivers/net/wireless/realtek/rtw89/phy.h      |  3 ++-
 3 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index 8da3e117ad382..f24e4a208376b 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -630,7 +630,7 @@ static void rtw89_ra_mask_info_update_iter(void *data, struct ieee80211_sta *sta
 
 	rtwsta->use_cfg_mask = true;
 	rtwsta->mask = *br_data->mask;
-	rtw89_phy_ra_updata_sta(br_data->rtwdev, sta);
+	rtw89_phy_ra_updata_sta(br_data->rtwdev, sta, IEEE80211_RC_SUPP_RATES_CHANGED);
 }
 
 static void rtw89_ra_mask_info_update(struct rtw89_dev *rtwdev,
@@ -759,6 +759,15 @@ static void rtw89_ops_cancel_hw_scan(struct ieee80211_hw *hw,
 	mutex_unlock(&rtwdev->mutex);
 }
 
+static void rtw89_ops_sta_rc_update(struct ieee80211_hw *hw,
+				    struct ieee80211_vif *vif,
+				    struct ieee80211_sta *sta, u32 changed)
+{
+	struct rtw89_dev *rtwdev = hw->priv;
+
+	rtw89_phy_ra_updata_sta(rtwdev, sta, changed);
+}
+
 const struct ieee80211_ops rtw89_ops = {
 	.tx			= rtw89_ops_tx,
 	.wake_tx_queue		= rtw89_ops_wake_tx_queue,
@@ -788,5 +797,6 @@ const struct ieee80211_ops rtw89_ops = {
 	.hw_scan		= rtw89_ops_hw_scan,
 	.cancel_hw_scan		= rtw89_ops_cancel_hw_scan,
 	.set_sar_specs		= rtw89_ops_set_sar_specs,
+	.sta_rc_update		= rtw89_ops_sta_rc_update,
 };
 EXPORT_SYMBOL(rtw89_ops);
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 33494e8451cf3..c9a4ae989ac7d 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -357,13 +357,19 @@ static void rtw89_phy_ra_sta_update(struct rtw89_dev *rtwdev,
 	ra->csi_mode = csi_mode;
 }
 
-void rtw89_phy_ra_updata_sta(struct rtw89_dev *rtwdev, struct ieee80211_sta *sta)
+void rtw89_phy_ra_updata_sta(struct rtw89_dev *rtwdev, struct ieee80211_sta *sta,
+			     u32 changed)
 {
 	struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
 	struct rtw89_ra_info *ra = &rtwsta->ra;
 
 	rtw89_phy_ra_sta_update(rtwdev, sta, false);
-	ra->upd_mask = 1;
+
+	if (changed & IEEE80211_RC_SUPP_RATES_CHANGED)
+		ra->upd_mask = 1;
+	if (changed & (IEEE80211_RC_BW_CHANGED | IEEE80211_RC_NSS_CHANGED))
+		ra->upd_bw_nss_mask = 1;
+
 	rtw89_debug(rtwdev, RTW89_DBG_RA,
 		    "ra updat: macid = %d, bw = %d, nss = %d, gi = %d %d",
 		    ra->macid,
@@ -487,7 +493,7 @@ static void rtw89_phy_ra_updata_sta_iter(void *data, struct ieee80211_sta *sta)
 {
 	struct rtw89_dev *rtwdev = (struct rtw89_dev *)data;
 
-	rtw89_phy_ra_updata_sta(rtwdev, sta);
+	rtw89_phy_ra_updata_sta(rtwdev, sta, IEEE80211_RC_SUPP_RATES_CHANGED);
 }
 
 void rtw89_phy_ra_update(struct rtw89_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index 3ca5efa4c097b..291660154d58d 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -471,7 +471,8 @@ s8 rtw89_phy_read_txpwr_limit(struct rtw89_dev *rtwdev,
 			      u8 bw, u8 ntx, u8 rs, u8 bf, u8 ch);
 void rtw89_phy_ra_assoc(struct rtw89_dev *rtwdev, struct ieee80211_sta *sta);
 void rtw89_phy_ra_update(struct rtw89_dev *rtwdev);
-void rtw89_phy_ra_updata_sta(struct rtw89_dev *rtwdev, struct ieee80211_sta *sta);
+void rtw89_phy_ra_updata_sta(struct rtw89_dev *rtwdev, struct ieee80211_sta *sta,
+			     u32 changed);
 void rtw89_phy_rate_pattern_vif(struct rtw89_dev *rtwdev,
 				struct ieee80211_vif *vif,
 				const struct cfg80211_bitrate_mask *mask);
-- 
2.25.1

