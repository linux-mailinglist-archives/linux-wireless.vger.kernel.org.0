Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67EC15B54ED
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Sep 2022 09:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiILHBL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Sep 2022 03:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiILHBG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Sep 2022 03:01:06 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 22B5A24967
        for <linux-wireless@vger.kernel.org>; Mon, 12 Sep 2022 00:01:03 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 28C70WUl8027997, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 28C70WUl8027997
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 12 Sep 2022 15:00:32 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 12 Sep 2022 15:00:52 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 12 Sep
 2022 15:00:51 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <damon.chen@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/2] wifi: rtw89: support for setting TID specific configuration
Date:   Mon, 12 Sep 2022 15:00:14 +0800
Message-ID: <20220912070014.10018-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220912070014.10018-1-pkshih@realtek.com>
References: <20220912070014.10018-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 09/12/2022 06:43:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzkvMTIgpFekyCAwMjozNzowMA==?=
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

From: Kuan-Chung Chen <damon.chen@realtek.com>

Add ops set_tid_config to support TID specific configuration.
We currently only support ampdu setting.

The command example is:
  iw wlan0 set tidconf tids 0x3 ampdu off
  iw wlan0 set tidconf peer xx:xx:xx:xx:xx:xx tids 0x2 ampdu on

Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c     | 69 +++++++++++++++----
 drivers/net/wireless/realtek/rtw89/core.h     |  3 +
 drivers/net/wireless/realtek/rtw89/mac80211.c | 29 ++++++++
 3 files changed, 88 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 71ee237a7c286..1776290a3f1a3 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -1883,21 +1883,14 @@ static void rtw89_core_stop_tx_ba_session(struct rtw89_dev *rtwdev,
 		return;
 
 	spin_lock_bh(&rtwdev->ba_lock);
-	if (!list_empty(&rtwtxq->list)) {
-		list_del_init(&rtwtxq->list);
-		goto out;
-	}
-
-	set_bit(RTW89_TXQ_F_FORBID_BA, &rtwtxq->flags);
+	if (!test_and_set_bit(RTW89_TXQ_F_FORBID_BA, &rtwtxq->flags))
+		list_add_tail(&rtwtxq->list, &rtwdev->forbid_ba_list);
+	spin_unlock_bh(&rtwdev->ba_lock);
 
-	list_add_tail(&rtwtxq->list, &rtwdev->forbid_ba_list);
 	ieee80211_stop_tx_ba_session(sta, txq->tid);
 	cancel_delayed_work(&rtwdev->forbid_ba_work);
 	ieee80211_queue_delayed_work(rtwdev->hw, &rtwdev->forbid_ba_work,
 				     RTW89_FORBID_BA_TIMER);
-
-out:
-	spin_unlock_bh(&rtwdev->ba_lock);
 }
 
 static void rtw89_core_txq_check_agg(struct rtw89_dev *rtwdev,
@@ -1909,6 +1902,9 @@ static void rtw89_core_txq_check_agg(struct rtw89_dev *rtwdev,
 	struct ieee80211_sta *sta = txq->sta;
 	struct rtw89_sta *rtwsta = sta ? (struct rtw89_sta *)sta->drv_priv : NULL;
 
+	if (test_bit(RTW89_TXQ_F_FORBID_BA, &rtwtxq->flags))
+		return;
+
 	if (unlikely(skb->protocol == cpu_to_be16(ETH_P_PAE))) {
 		rtw89_core_stop_tx_ba_session(rtwdev, rtwtxq);
 		return;
@@ -1917,9 +1913,6 @@ static void rtw89_core_txq_check_agg(struct rtw89_dev *rtwdev,
 	if (unlikely(!sta))
 		return;
 
-	if (test_bit(RTW89_TXQ_F_FORBID_BA, &rtwtxq->flags))
-		return;
-
 	if (unlikely(test_bit(RTW89_TXQ_F_BLOCK_BA, &rtwtxq->flags)))
 		return;
 
@@ -2542,6 +2535,53 @@ int rtw89_core_sta_remove(struct rtw89_dev *rtwdev,
 	return 0;
 }
 
+static void _rtw89_core_set_tid_config(struct rtw89_dev *rtwdev,
+				       struct ieee80211_sta *sta,
+				       struct cfg80211_tid_cfg *tid_conf)
+{
+	struct ieee80211_txq *txq;
+	struct rtw89_txq *rtwtxq;
+	u32 mask = tid_conf->mask;
+	u8 tids = tid_conf->tids;
+	int tids_nbit = BITS_PER_BYTE;
+	int i;
+
+	for (i = 0; i < tids_nbit; i++, tids >>= 1) {
+		if (!tids)
+			break;
+
+		if (!(tids & BIT(0)))
+			continue;
+
+		txq = sta->txq[i];
+		rtwtxq = (struct rtw89_txq *)txq->drv_priv;
+
+		if (mask & BIT(NL80211_TID_CONFIG_ATTR_AMPDU_CTRL)) {
+			if (tid_conf->ampdu == NL80211_TID_CONFIG_ENABLE) {
+				clear_bit(RTW89_TXQ_F_FORBID_BA, &rtwtxq->flags);
+			} else {
+				if (test_bit(RTW89_TXQ_F_AMPDU, &rtwtxq->flags))
+					ieee80211_stop_tx_ba_session(sta, txq->tid);
+				spin_lock_bh(&rtwdev->ba_lock);
+				list_del_init(&rtwtxq->list);
+				set_bit(RTW89_TXQ_F_FORBID_BA, &rtwtxq->flags);
+				spin_unlock_bh(&rtwdev->ba_lock);
+			}
+		}
+	}
+}
+
+void rtw89_core_set_tid_config(struct rtw89_dev *rtwdev,
+			       struct ieee80211_sta *sta,
+			       struct cfg80211_tid_config *tid_config)
+{
+	int i;
+
+	for (i = 0; i < tid_config->n_tid_conf; i++)
+		_rtw89_core_set_tid_config(rtwdev, sta,
+					   &tid_config->tid_conf[i]);
+}
+
 static void rtw89_init_ht_cap(struct rtw89_dev *rtwdev,
 			      struct ieee80211_sta_ht_cap *ht_cap)
 {
@@ -3180,6 +3220,9 @@ static int rtw89_core_register_hw(struct rtw89_dev *rtwdev)
 	hw->wiphy->max_scan_ssids = RTW89_SCANOFLD_MAX_SSID;
 	hw->wiphy->max_scan_ie_len = RTW89_SCANOFLD_MAX_IE_LEN;
 
+	hw->wiphy->tid_config_support.vif |= BIT(NL80211_TID_CONFIG_ATTR_AMPDU_CTRL);
+	hw->wiphy->tid_config_support.peer |= BIT(NL80211_TID_CONFIG_ATTR_AMPDU_CTRL);
+
 	wiphy_ext_feature_set(hw->wiphy, NL80211_EXT_FEATURE_CAN_REPLACE_PTK0);
 
 	ret = rtw89_core_set_supported_band(rtwdev);
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 5b19fee020f67..5311499599c88 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4146,6 +4146,9 @@ int rtw89_core_sta_disconnect(struct rtw89_dev *rtwdev,
 int rtw89_core_sta_remove(struct rtw89_dev *rtwdev,
 			  struct ieee80211_vif *vif,
 			  struct ieee80211_sta *sta);
+void rtw89_core_set_tid_config(struct rtw89_dev *rtwdev,
+			       struct ieee80211_sta *sta,
+			       struct cfg80211_tid_config *tid_config);
 int rtw89_core_init(struct rtw89_dev *rtwdev);
 void rtw89_core_deinit(struct rtw89_dev *rtwdev);
 int rtw89_core_register(struct rtw89_dev *rtwdev);
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index 668370cf8158a..0f09739c2157d 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -840,6 +840,34 @@ static void rtw89_ops_unassign_vif_chanctx(struct ieee80211_hw *hw,
 	mutex_unlock(&rtwdev->mutex);
 }
 
+static void rtw89_set_tid_config_iter(void *data, struct ieee80211_sta *sta)
+{
+	struct cfg80211_tid_config *tid_config = data;
+	struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
+	struct rtw89_dev *rtwdev = rtwsta->rtwvif->rtwdev;
+
+	rtw89_core_set_tid_config(rtwdev, sta, tid_config);
+}
+
+static int rtw89_ops_set_tid_config(struct ieee80211_hw *hw,
+				    struct ieee80211_vif *vif,
+				    struct ieee80211_sta *sta,
+				    struct cfg80211_tid_config *tid_config)
+{
+	struct rtw89_dev *rtwdev = hw->priv;
+
+	mutex_lock(&rtwdev->mutex);
+	if (sta)
+		rtw89_core_set_tid_config(rtwdev, sta, tid_config);
+	else
+		ieee80211_iterate_stations_atomic(rtwdev->hw,
+						  rtw89_set_tid_config_iter,
+						  tid_config);
+	mutex_unlock(&rtwdev->mutex);
+
+	return 0;
+}
+
 const struct ieee80211_ops rtw89_ops = {
 	.tx			= rtw89_ops_tx,
 	.wake_tx_queue		= rtw89_ops_wake_tx_queue,
@@ -875,5 +903,6 @@ const struct ieee80211_ops rtw89_ops = {
 	.unassign_vif_chanctx	= rtw89_ops_unassign_vif_chanctx,
 	.set_sar_specs		= rtw89_ops_set_sar_specs,
 	.sta_rc_update		= rtw89_ops_sta_rc_update,
+	.set_tid_config		= rtw89_ops_set_tid_config,
 };
 EXPORT_SYMBOL(rtw89_ops);
-- 
2.25.1

