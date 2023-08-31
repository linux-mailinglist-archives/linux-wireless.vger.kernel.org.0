Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6156978E5BF
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Aug 2023 07:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345491AbjHaFcz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 31 Aug 2023 01:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344994AbjHaFcx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 31 Aug 2023 01:32:53 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 98AE3185
        for <linux-wireless@vger.kernel.org>; Wed, 30 Aug 2023 22:32:44 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 37V5WBpT4020430, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 37V5WBpT4020430
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 31 Aug 2023 13:32:11 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 31 Aug 2023 13:32:36 +0800
Received: from [127.0.1.1] (172.21.69.25) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Thu, 31 Aug
 2023 13:32:36 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 3/6] wifi: rtw89: mcc: consider and determine BT duration
Date:   Thu, 31 Aug 2023 13:31:30 +0800
Message-ID: <20230831053133.24015-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230831053133.24015-1-pkshih@realtek.com>
References: <20230831053133.24015-1-pkshih@realtek.com>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Before calculating MCC pattern, we have to determine whether to handle BT
duration in it or not. The decision will depend on the channels that Wi-Fi
roles use. And, we have three cases shown below.
1. non-2GHz + non-2GHz
2. non-2GHz + 2GHz (different band)
3. 2GHz + 2GHz (dual 2GHz)

For case (1), we don't care BT duration in MCC pattern. For case (2), we
still don't care BT duration in MCC pattern. Instead, we try to satisfy it
by modifying duration of Wi-Fi role on non-2GHz channel. For case (3), we
need to modify Wi-Fi durations and also need to handle BT duration in MCC
pattern.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2: no change
---
 drivers/net/wireless/realtek/rtw89/chan.c | 169 ++++++++++++++++++++++
 1 file changed, 169 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/chan.c b/drivers/net/wireless/realtek/rtw89/chan.c
index 3778a569bb64..33d89e5070ec 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.c
+++ b/drivers/net/wireless/realtek/rtw89/chan.c
@@ -703,6 +703,171 @@ static void rtw89_mcc_set_duration_gc_sta(struct rtw89_dev *rtwdev)
 	aux->duration = dur_aux;
 }
 
+struct rtw89_mcc_mod_dur_data {
+	u16 available;
+	struct {
+		u16 dur;
+		u16 room;
+	} parm[NUM_OF_RTW89_MCC_ROLES];
+};
+
+static int rtw89_mcc_mod_dur_get_iterator(struct rtw89_dev *rtwdev,
+					  struct rtw89_mcc_role *mcc_role,
+					  unsigned int ordered_idx,
+					  void *data)
+{
+	struct rtw89_mcc_mod_dur_data *p = data;
+	u16 min;
+
+	p->parm[ordered_idx].dur = mcc_role->duration;
+
+	if (mcc_role->is_go)
+		min = RTW89_MCC_MIN_GO_DURATION;
+	else
+		min = RTW89_MCC_MIN_STA_DURATION;
+
+	p->parm[ordered_idx].room = max_t(s32, p->parm[ordered_idx].dur - min, 0);
+
+	rtw89_debug(rtwdev, RTW89_DBG_CHAN,
+		    "MCC mod dur: chk role[%u]: dur %u, min %u, room %u\n",
+		    ordered_idx, p->parm[ordered_idx].dur, min,
+		    p->parm[ordered_idx].room);
+
+	p->available += p->parm[ordered_idx].room;
+	return 0;
+}
+
+static int rtw89_mcc_mod_dur_put_iterator(struct rtw89_dev *rtwdev,
+					  struct rtw89_mcc_role *mcc_role,
+					  unsigned int ordered_idx,
+					  void *data)
+{
+	struct rtw89_mcc_mod_dur_data *p = data;
+
+	mcc_role->duration = p->parm[ordered_idx].dur;
+
+	rtw89_debug(rtwdev, RTW89_DBG_CHAN,
+		    "MCC mod dur: set role[%u]: dur %u\n",
+		    ordered_idx, p->parm[ordered_idx].dur);
+	return 0;
+}
+
+static void rtw89_mcc_mod_duration_dual_2ghz_with_bt(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_mcc_info *mcc = &rtwdev->mcc;
+	struct rtw89_mcc_config *config = &mcc->config;
+	struct rtw89_mcc_mod_dur_data data = {};
+	u16 mcc_intvl = config->mcc_interval;
+	u16 bt_dur = mcc->bt_role.duration;
+	u16 wifi_dur;
+
+	rtw89_debug(rtwdev, RTW89_DBG_CHAN,
+		    "MCC mod dur (dual 2ghz): mcc_intvl %u, raw bt_dur %u\n",
+		    mcc_intvl, bt_dur);
+
+	rtw89_iterate_mcc_roles(rtwdev, rtw89_mcc_mod_dur_get_iterator, &data);
+
+	bt_dur = clamp_t(u16, bt_dur, 1, data.available / 3);
+	wifi_dur = mcc_intvl - bt_dur;
+
+	if (data.parm[0].room <= data.parm[1].room) {
+		data.parm[0].dur -= min_t(u16, bt_dur / 2, data.parm[0].room);
+		data.parm[1].dur = wifi_dur - data.parm[0].dur;
+	} else {
+		data.parm[1].dur -= min_t(u16, bt_dur / 2, data.parm[1].room);
+		data.parm[0].dur = wifi_dur - data.parm[1].dur;
+	}
+
+	rtw89_iterate_mcc_roles(rtwdev, rtw89_mcc_mod_dur_put_iterator, &data);
+
+	rtw89_debug(rtwdev, RTW89_DBG_CHAN, "MCC mod dur: set bt: dur %u\n", bt_dur);
+	mcc->bt_role.duration = bt_dur;
+}
+
+static
+void rtw89_mcc_mod_duration_diff_band_with_bt(struct rtw89_dev *rtwdev,
+					      struct rtw89_mcc_role *role_2ghz,
+					      struct rtw89_mcc_role *role_non_2ghz)
+{
+	struct rtw89_mcc_info *mcc = &rtwdev->mcc;
+	struct rtw89_mcc_config *config = &mcc->config;
+	u16 dur_2ghz, dur_non_2ghz;
+	u16 bt_dur, mcc_intvl;
+
+	dur_2ghz = role_2ghz->duration;
+	dur_non_2ghz = role_non_2ghz->duration;
+	mcc_intvl = config->mcc_interval;
+	bt_dur = mcc->bt_role.duration;
+
+	rtw89_debug(rtwdev, RTW89_DBG_CHAN,
+		    "MCC mod dur (diff band): mcc_intvl %u, bt_dur %u\n",
+		    mcc_intvl, bt_dur);
+
+	rtw89_debug(rtwdev, RTW89_DBG_CHAN,
+		    "MCC mod dur: check dur_2ghz %u, dur_non_2ghz %u\n",
+		    dur_2ghz, dur_non_2ghz);
+
+	if (dur_non_2ghz >= bt_dur) {
+		rtw89_debug(rtwdev, RTW89_DBG_CHAN,
+			    "MCC mod dur: dur_non_2ghz is enough for bt\n");
+		return;
+	}
+
+	dur_non_2ghz = bt_dur;
+	dur_2ghz = mcc_intvl - dur_non_2ghz;
+
+	if (role_non_2ghz->limit.enable) {
+		rtw89_debug(rtwdev, RTW89_DBG_CHAN,
+			    "MCC mod dur: dur_non_2ghz is limited with max %u\n",
+			    role_non_2ghz->limit.max_dur);
+
+		dur_non_2ghz = min(dur_non_2ghz, role_non_2ghz->limit.max_dur);
+		dur_2ghz = mcc_intvl - dur_non_2ghz;
+	}
+
+	rtw89_debug(rtwdev, RTW89_DBG_CHAN,
+		    "MCC mod dur: set dur_2ghz %u, dur_non_2ghz %u\n",
+		    dur_2ghz, dur_non_2ghz);
+
+	role_2ghz->duration = dur_2ghz;
+	role_non_2ghz->duration = dur_non_2ghz;
+}
+
+static bool rtw89_mcc_duration_decision_on_bt(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_mcc_info *mcc = &rtwdev->mcc;
+	struct rtw89_mcc_role *ref = &mcc->role_ref;
+	struct rtw89_mcc_role *aux = &mcc->role_aux;
+	struct rtw89_mcc_bt_role *bt_role = &mcc->bt_role;
+
+	if (!bt_role->duration)
+		return false;
+
+	if (ref->is_2ghz && aux->is_2ghz) {
+		rtw89_debug(rtwdev, RTW89_DBG_CHAN,
+			    "MCC dual roles are on 2GHz; consider BT duration\n");
+
+		rtw89_mcc_mod_duration_dual_2ghz_with_bt(rtwdev);
+		return true;
+	}
+
+	if (!ref->is_2ghz && !aux->is_2ghz) {
+		rtw89_debug(rtwdev, RTW89_DBG_CHAN,
+			    "MCC dual roles are not on 2GHz; ignore BT duration\n");
+		return false;
+	}
+
+	rtw89_debug(rtwdev, RTW89_DBG_CHAN,
+		    "MCC one role is on 2GHz; modify another for BT duration\n");
+
+	if (ref->is_2ghz)
+		rtw89_mcc_mod_duration_diff_band_with_bt(rtwdev, ref, aux);
+	else
+		rtw89_mcc_mod_duration_diff_band_with_bt(rtwdev, aux, ref);
+
+	return false;
+}
+
 static void rtw89_mcc_sync_tbtt(struct rtw89_dev *rtwdev,
 				struct rtw89_mcc_role *tgt,
 				struct rtw89_mcc_role *src,
@@ -790,6 +955,7 @@ static int rtw89_mcc_fill_config(struct rtw89_dev *rtwdev)
 	struct rtw89_mcc_role *ref = &mcc->role_ref;
 	struct rtw89_mcc_role *aux = &mcc->role_aux;
 	struct rtw89_mcc_config *config = &mcc->config;
+	bool hdl_bt;
 
 	memset(config, 0, sizeof(*config));
 
@@ -816,6 +982,9 @@ static int rtw89_mcc_fill_config(struct rtw89_dev *rtwdev)
 		return -EFAULT;
 	}
 
+	hdl_bt = rtw89_mcc_duration_decision_on_bt(rtwdev);
+	rtw89_debug(rtwdev, RTW89_DBG_CHAN, "MCC handle bt: %d\n", hdl_bt);
+
 	rtw89_mcc_set_default_pattern(rtwdev);
 	return rtw89_mcc_fill_start_tsf(rtwdev);
 }
-- 
2.25.1

