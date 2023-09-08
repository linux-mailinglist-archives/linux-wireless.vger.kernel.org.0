Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF1E7980E0
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Sep 2023 05:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240909AbjIHDNR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 Sep 2023 23:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233705AbjIHDNO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 Sep 2023 23:13:14 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C261BE2
        for <linux-wireless@vger.kernel.org>; Thu,  7 Sep 2023 20:13:09 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3883D24e81359579, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 3883D24e81359579
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Sep 2023 11:13:02 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 8 Sep 2023 11:12:56 +0800
Received: from [127.0.1.1] (172.21.69.25) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 8 Sep 2023
 11:12:55 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 6/8] wifi: rtw89: mcc: deal with P2P PS change
Date:   Fri, 8 Sep 2023 11:11:43 +0800
Message-ID: <20230908031145.20931-7-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230908031145.20931-1-pkshih@realtek.com>
References: <20230908031145.20931-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.25]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Zong-Zhe Yang <kevin_yang@realtek.com>

MCC fills duration limit of a role according to NoA description.
If P2P PS changes during MCC, we don't process P2P PS via normal
flow. Instead, we re-fill duration limit of the role for new NoA
description, and then we do MCC update.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/chan.c     | 25 ++++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/core.c     | 10 ++++++++
 drivers/net/wireless/realtek/rtw89/core.h     |  2 ++
 drivers/net/wireless/realtek/rtw89/mac80211.c |  2 +-
 4 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/chan.c b/drivers/net/wireless/realtek/rtw89/chan.c
index 417fb5e98813..6f584a56e92f 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.c
+++ b/drivers/net/wireless/realtek/rtw89/chan.c
@@ -1596,6 +1596,26 @@ static void rtw89_mcc_update_macid_bitmap(struct rtw89_dev *rtwdev)
 	rtw89_iterate_mcc_roles(rtwdev, rtw89_mcc_upd_map_iterator, NULL);
 }
 
+static int rtw89_mcc_upd_lmt_iterator(struct rtw89_dev *rtwdev,
+				      struct rtw89_mcc_role *mcc_role,
+				      unsigned int ordered_idx,
+				      void *data)
+{
+	memset(&mcc_role->limit, 0, sizeof(mcc_role->limit));
+	rtw89_mcc_fill_role_limit(rtwdev, mcc_role);
+	return 0;
+}
+
+static void rtw89_mcc_update_limit(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_mcc_info *mcc = &rtwdev->mcc;
+
+	if (mcc->mode != RTW89_MCC_MODE_GC_STA)
+		return;
+
+	rtw89_iterate_mcc_roles(rtwdev, rtw89_mcc_upd_lmt_iterator, NULL);
+}
+
 void rtw89_chanctx_work(struct work_struct *work)
 {
 	struct rtw89_dev *rtwdev = container_of(work, struct rtw89_dev,
@@ -1625,10 +1645,13 @@ void rtw89_chanctx_work(struct work_struct *work)
 			rtw89_warn(rtwdev, "failed to start MCC: %d\n", ret);
 		break;
 	case RTW89_ENTITY_MODE_MCC:
-		if (changed & BIT(RTW89_CHANCTX_BCN_OFFSET_CHANGE))
+		if (changed & BIT(RTW89_CHANCTX_BCN_OFFSET_CHANGE) ||
+		    changed & BIT(RTW89_CHANCTX_P2P_PS_CHANGE))
 			update_mcc_pattern = true;
 		if (changed & BIT(RTW89_CHANCTX_REMOTE_STA_CHANGE))
 			rtw89_mcc_update_macid_bitmap(rtwdev);
+		if (changed & BIT(RTW89_CHANCTX_P2P_PS_CHANGE))
+			rtw89_mcc_update_limit(rtwdev);
 		if (update_mcc_pattern) {
 			ret = rtw89_mcc_update(rtwdev);
 			if (ret)
diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 06dd9d105e38..53425d09fe5c 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -2673,6 +2673,16 @@ static void rtw89_core_rfk_track(struct rtw89_dev *rtwdev)
 	rtw89_chip_rfk_track(rtwdev);
 }
 
+void rtw89_core_update_p2p_ps(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif)
+{
+	enum rtw89_entity_mode mode = rtw89_get_entity_mode(rtwdev);
+
+	if (mode == RTW89_ENTITY_MODE_MCC)
+		rtw89_queue_chanctx_change(rtwdev, RTW89_CHANCTX_P2P_PS_CHANGE);
+	else
+		rtw89_process_p2p_ps(rtwdev, vif);
+}
+
 void rtw89_traffic_stats_init(struct rtw89_dev *rtwdev,
 			      struct rtw89_traffic_stats *stats)
 {
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 82291d9599a5..4cf11bbc00cb 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3790,6 +3790,7 @@ struct rtw89_chanctx_cfg {
 enum rtw89_chanctx_changes {
 	RTW89_CHANCTX_REMOTE_STA_CHANGE,
 	RTW89_CHANCTX_BCN_OFFSET_CHANGE,
+	RTW89_CHANCTX_P2P_PS_CHANGE,
 
 	NUM_OF_RTW89_CHANCTX_CHANGES,
 	RTW89_CHANCTX_CHANGE_DFLT = NUM_OF_RTW89_CHANCTX_CHANGES,
@@ -5526,6 +5527,7 @@ void rtw89_core_scan_complete(struct rtw89_dev *rtwdev,
 			      struct ieee80211_vif *vif, bool hw_scan);
 void rtw89_reg_6ghz_power_recalc(struct rtw89_dev *rtwdev,
 				 struct rtw89_vif *rtwvif, bool active);
+void rtw89_core_update_p2p_ps(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif);
 void rtw89_core_ntfy_btc_event(struct rtw89_dev *rtwdev, enum rtw89_btc_hmsg event);
 
 #endif
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index 5e48618706d9..b18ebd844141 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -445,7 +445,7 @@ static void rtw89_ops_bss_info_changed(struct ieee80211_hw *hw,
 		rtw89_mac_bf_set_gid_table(rtwdev, vif, conf);
 
 	if (changed & BSS_CHANGED_P2P_PS)
-		rtw89_process_p2p_ps(rtwdev, vif);
+		rtw89_core_update_p2p_ps(rtwdev, vif);
 
 	if (changed & BSS_CHANGED_CQM)
 		rtw89_fw_h2c_set_bcn_fltr_cfg(rtwdev, vif, true);
-- 
2.25.1

