Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA7837980E1
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Sep 2023 05:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239760AbjIHDNQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 Sep 2023 23:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239085AbjIHDNN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 Sep 2023 23:13:13 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39E81BD8
        for <linux-wireless@vger.kernel.org>; Thu,  7 Sep 2023 20:13:08 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3883D14e81359579, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 3883D14e81359579
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Sep 2023 11:13:01 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 8 Sep 2023 11:12:53 +0800
Received: from [127.0.1.1] (172.21.69.25) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 8 Sep 2023
 11:12:52 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 4/8] wifi: rtw89: mcc: update role bitmap when changed
Date:   Fri, 8 Sep 2023 11:11:41 +0800
Message-ID: <20230908031145.20931-5-pkshih@realtek.com>
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

Each MCC (multi-channel concurrency) role maintains a bitmap of mac IDs.
The bitmap is supposed to contain the two points below.
* mac ID of itself
* mac ID(s) of STA(s) connecting to it
Under STA+GC mode, the bitmaps of both roles should not change. However,
under STA+GO mode, the bitmap of GO may change due to P2P clients which
connect/disconnect to/from it.

FW controls (TDMA-based) MCC things via mac IDs in bitmap of each role.
For example, mac IDs are required by FW when it wants to pause role1's
TX in role0 slot.

So, to sync between driver and FW, we update the new mac ID bitmap of GO
to FW once it's changed.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/chan.c | 74 ++++++++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/chan.h |  3 +
 drivers/net/wireless/realtek/rtw89/core.c |  4 ++
 drivers/net/wireless/realtek/rtw89/core.h |  8 +++
 4 files changed, 88 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/chan.c b/drivers/net/wireless/realtek/rtw89/chan.c
index 5f30c6d304b8..5ac6d60dfd73 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.c
+++ b/drivers/net/wireless/realtek/rtw89/chan.c
@@ -191,6 +191,7 @@ void rtw89_entity_init(struct rtw89_dev *rtwdev)
 	struct rtw89_hal *hal = &rtwdev->hal;
 
 	bitmap_zero(hal->entity_map, NUM_OF_RTW89_SUB_ENTITY);
+	bitmap_zero(hal->changes, NUM_OF_RTW89_CHANCTX_CHANGES);
 	atomic_set(&hal->roc_entity_idx, RTW89_SUB_ENTITY_IDLE);
 	rtw89_config_default_chandef(rtwdev);
 }
@@ -1436,15 +1437,66 @@ static void rtw89_mcc_stop(struct rtw89_dev *rtwdev)
 	rtw89_chanctx_notify(rtwdev, RTW89_CHANCTX_STATE_MCC_STOP);
 }
 
+static int rtw89_mcc_upd_map_iterator(struct rtw89_dev *rtwdev,
+				      struct rtw89_mcc_role *mcc_role,
+				      unsigned int ordered_idx,
+				      void *data)
+{
+	struct rtw89_mcc_info *mcc = &rtwdev->mcc;
+	struct rtw89_mcc_role upd = {
+		.rtwvif = mcc_role->rtwvif,
+	};
+	int ret;
+
+	if (!mcc_role->is_go)
+		return 0;
+
+	rtw89_mcc_fill_role_macid_bitmap(rtwdev, &upd);
+	if (memcmp(mcc_role->macid_bitmap, upd.macid_bitmap,
+		   sizeof(mcc_role->macid_bitmap)) == 0)
+		return 0;
+
+	ret = rtw89_fw_h2c_mcc_macid_bitmap(rtwdev, mcc->group,
+					    upd.rtwvif->mac_id,
+					    upd.macid_bitmap);
+	if (ret) {
+		rtw89_debug(rtwdev, RTW89_DBG_CHAN,
+			    "MCC h2c failed to update macid bitmap: %d\n", ret);
+		return ret;
+	}
+
+	memcpy(mcc_role->macid_bitmap, upd.macid_bitmap,
+	       sizeof(mcc_role->macid_bitmap));
+	return 0;
+}
+
+static void rtw89_mcc_update_macid_bitmap(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_mcc_info *mcc = &rtwdev->mcc;
+
+	if (mcc->mode != RTW89_MCC_MODE_GO_STA)
+		return;
+
+	rtw89_iterate_mcc_roles(rtwdev, rtw89_mcc_upd_map_iterator, NULL);
+}
+
 void rtw89_chanctx_work(struct work_struct *work)
 {
 	struct rtw89_dev *rtwdev = container_of(work, struct rtw89_dev,
 						chanctx_work.work);
+	struct rtw89_hal *hal = &rtwdev->hal;
 	enum rtw89_entity_mode mode;
+	u32 changed = 0;
 	int ret;
+	int i;
 
 	mutex_lock(&rtwdev->mutex);
 
+	for (i = 0; i < NUM_OF_RTW89_CHANCTX_CHANGES; i++) {
+		if (test_and_clear_bit(i, hal->changes))
+			changed |= BIT(i);
+	}
+
 	mode = rtw89_get_entity_mode(rtwdev);
 	switch (mode) {
 	case RTW89_ENTITY_MODE_MCC_PREPARE:
@@ -1455,6 +1507,10 @@ void rtw89_chanctx_work(struct work_struct *work)
 		if (ret)
 			rtw89_warn(rtwdev, "failed to start MCC: %d\n", ret);
 		break;
+	case RTW89_ENTITY_MODE_MCC:
+		if (changed & BIT(RTW89_CHANCTX_REMOTE_STA_CHANGE))
+			rtw89_mcc_update_macid_bitmap(rtwdev);
+		break;
 	default:
 		break;
 	}
@@ -1462,8 +1518,10 @@ void rtw89_chanctx_work(struct work_struct *work)
 	mutex_unlock(&rtwdev->mutex);
 }
 
-void rtw89_queue_chanctx_work(struct rtw89_dev *rtwdev)
+void rtw89_queue_chanctx_change(struct rtw89_dev *rtwdev,
+				enum rtw89_chanctx_changes change)
 {
+	struct rtw89_hal *hal = &rtwdev->hal;
 	enum rtw89_entity_mode mode;
 	u32 delay;
 
@@ -1474,6 +1532,15 @@ void rtw89_queue_chanctx_work(struct rtw89_dev *rtwdev)
 	case RTW89_ENTITY_MODE_MCC_PREPARE:
 		delay = ieee80211_tu_to_usec(RTW89_CHANCTX_TIME_MCC_PREPARE);
 		break;
+	case RTW89_ENTITY_MODE_MCC:
+		delay = ieee80211_tu_to_usec(RTW89_CHANCTX_TIME_MCC);
+		break;
+	}
+
+	if (change != RTW89_CHANCTX_CHANGE_DFLT) {
+		rtw89_debug(rtwdev, RTW89_DBG_CHAN, "set chanctx change %d\n",
+			    change);
+		set_bit(change, hal->changes);
 	}
 
 	rtw89_debug(rtwdev, RTW89_DBG_CHAN,
@@ -1483,6 +1550,11 @@ void rtw89_queue_chanctx_work(struct rtw89_dev *rtwdev)
 				     usecs_to_jiffies(delay));
 }
 
+void rtw89_queue_chanctx_work(struct rtw89_dev *rtwdev)
+{
+	rtw89_queue_chanctx_change(rtwdev, RTW89_CHANCTX_CHANGE_DFLT);
+}
+
 int rtw89_chanctx_ops_add(struct rtw89_dev *rtwdev,
 			  struct ieee80211_chanctx_conf *ctx)
 {
diff --git a/drivers/net/wireless/realtek/rtw89/chan.h b/drivers/net/wireless/realtek/rtw89/chan.h
index 9bdf3d1637bb..2fca703c99f0 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.h
+++ b/drivers/net/wireless/realtek/rtw89/chan.h
@@ -9,6 +9,7 @@
 
 /* The dwell time in TU before doing rtw89_chanctx_work(). */
 #define RTW89_CHANCTX_TIME_MCC_PREPARE 100
+#define RTW89_CHANCTX_TIME_MCC 100
 
 /* various MCC setting time in TU */
 #define RTW89_MCC_LONG_TRIGGER_TIME 300
@@ -75,6 +76,8 @@ void rtw89_entity_init(struct rtw89_dev *rtwdev);
 enum rtw89_entity_mode rtw89_entity_recalc(struct rtw89_dev *rtwdev);
 void rtw89_chanctx_work(struct work_struct *work);
 void rtw89_queue_chanctx_work(struct rtw89_dev *rtwdev);
+void rtw89_queue_chanctx_change(struct rtw89_dev *rtwdev,
+				enum rtw89_chanctx_changes change);
 int rtw89_chanctx_ops_add(struct rtw89_dev *rtwdev,
 			  struct ieee80211_chanctx_conf *ctx);
 void rtw89_chanctx_ops_remove(struct rtw89_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 3b80b110c4f3..a91011e7b05e 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -2934,6 +2934,8 @@ int rtw89_core_sta_add(struct rtw89_dev *rtwdev,
 			rtw89_warn(rtwdev, "failed to send h2c role info\n");
 			return ret;
 		}
+
+		rtw89_queue_chanctx_change(rtwdev, RTW89_CHANCTX_REMOTE_STA_CHANGE);
 	}
 
 	return 0;
@@ -3099,6 +3101,8 @@ int rtw89_core_sta_remove(struct rtw89_dev *rtwdev,
 			rtw89_warn(rtwdev, "failed to send h2c role info\n");
 			return ret;
 		}
+
+		rtw89_queue_chanctx_change(rtwdev, RTW89_CHANCTX_REMOTE_STA_CHANGE);
 	}
 
 	return 0;
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 43a81acdaacf..eb185b3ffa3c 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3787,6 +3787,13 @@ struct rtw89_chanctx_cfg {
 	enum rtw89_sub_entity_idx idx;
 };
 
+enum rtw89_chanctx_changes {
+	RTW89_CHANCTX_REMOTE_STA_CHANGE,
+
+	NUM_OF_RTW89_CHANCTX_CHANGES,
+	RTW89_CHANCTX_CHANGE_DFLT = NUM_OF_RTW89_CHANCTX_CHANGES,
+};
+
 enum rtw89_entity_mode {
 	RTW89_ENTITY_MODE_SCC,
 	RTW89_ENTITY_MODE_MCC_PREPARE,
@@ -3818,6 +3825,7 @@ struct rtw89_hal {
 	bool support_igi;
 	atomic_t roc_entity_idx;
 
+	DECLARE_BITMAP(changes, NUM_OF_RTW89_CHANCTX_CHANGES);
 	DECLARE_BITMAP(entity_map, NUM_OF_RTW89_SUB_ENTITY);
 	struct rtw89_sub_entity sub[NUM_OF_RTW89_SUB_ENTITY];
 	struct cfg80211_chan_def roc_chandef;
-- 
2.25.1

