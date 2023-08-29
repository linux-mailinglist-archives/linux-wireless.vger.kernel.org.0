Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B256678BCC3
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Aug 2023 04:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235286AbjH2CU7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Aug 2023 22:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235163AbjH2CUb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Aug 2023 22:20:31 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4A57E199
        for <linux-wireless@vger.kernel.org>; Mon, 28 Aug 2023 19:20:26 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 37T2JqtO6018978, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 37T2JqtO6018978
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 29 Aug 2023 10:19:52 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 29 Aug 2023 10:20:17 +0800
Received: from [127.0.1.1] (172.21.69.25) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 29 Aug
 2023 10:20:16 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/6] wifi: rtw89: mcc: fill fundamental configurations
Date:   Tue, 29 Aug 2023 10:19:14 +0800
Message-ID: <20230829021918.14599-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230829021918.14599-1-pkshih@realtek.com>
References: <20230829021918.14599-1-pkshih@realtek.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Zong-Zhe Yang <kevin_yang@realtek.com>

We determine the fundamental settings shown below.

 |<                MCC interval                 >|
 |<    duration ref     >|<    duration aux     >|
 |           |                       |           |
             |<    beacon offset    >|
	     |                       |
             V                       V
         (tbtt ref)              (tbtt aux)

(where `ref` (reference) and `aux` (auxiliary) mean the two MCC roles)

Based on MCC mode (GO+STA or GC+STA), we fill configurations of
MCC interval and beacon offset. And, we make sure each MCC role
have a basically required duration in the MCC interval.

The beacon offset mentioned above is a parameter for further MCC
pattern calculation. If MCC is in GC+STA mode, we will calculate
the real beacon offset through TSFs shown in beacons of both MCC
roles. Otherwise, we will use a default beacon offset, and make
GO sync STA's TSF timer with this offset.

MCC pattern calculation will break down each MCC role's duration
in more detail. We will implement it in the following.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/chan.c | 165 ++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/chan.h |  11 ++
 drivers/net/wireless/realtek/rtw89/core.h |   9 ++
 3 files changed, 185 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/chan.c b/drivers/net/wireless/realtek/rtw89/chan.c
index 617d7473ba7c..c2fb91678bd6 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.c
+++ b/drivers/net/wireless/realtek/rtw89/chan.c
@@ -321,6 +321,39 @@ static u32 rtw89_mcc_get_tbtt_ofst(struct rtw89_dev *rtwdev,
 	return (tsf - sync_tsf) % bcn_intvl_us;
 }
 
+static u16 rtw89_mcc_get_bcn_ofst(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_mcc_info *mcc = &rtwdev->mcc;
+	struct rtw89_mcc_role *ref = &mcc->role_ref;
+	struct rtw89_mcc_role *aux = &mcc->role_aux;
+	struct rtw89_mac_mcc_tsf_rpt rpt = {};
+	struct rtw89_fw_mcc_tsf_req req = {};
+	u32 bcn_intvl_ref_us = ieee80211_tu_to_usec(ref->beacon_interval);
+	u32 tbtt_ofst_ref, tbtt_ofst_aux;
+	u64 tsf_ref, tsf_aux;
+	int ret;
+
+	req.group = mcc->group;
+	req.macid_x = ref->rtwvif->mac_id;
+	req.macid_y = aux->rtwvif->mac_id;
+	ret = rtw89_fw_h2c_mcc_req_tsf(rtwdev, &req, &rpt);
+	if (ret) {
+		rtw89_debug(rtwdev, RTW89_DBG_CHAN,
+			    "MCC h2c failed to request tsf: %d\n", ret);
+		return RTW89_MCC_DFLT_BCN_OFST_TIME;
+	}
+
+	tsf_ref = (u64)rpt.tsf_x_high << 32 | rpt.tsf_x_low;
+	tsf_aux = (u64)rpt.tsf_y_high << 32 | rpt.tsf_y_low;
+	tbtt_ofst_ref = rtw89_mcc_get_tbtt_ofst(rtwdev, ref, tsf_ref);
+	tbtt_ofst_aux = rtw89_mcc_get_tbtt_ofst(rtwdev, aux, tsf_aux);
+
+	while (tbtt_ofst_ref < tbtt_ofst_aux)
+		tbtt_ofst_ref += bcn_intvl_ref_us;
+
+	return (tbtt_ofst_ref - tbtt_ofst_aux) / 1024;
+}
+
 static
 void rtw89_mcc_role_fw_macid_bitmap_set_bit(struct rtw89_mcc_role *mcc_role,
 					    unsigned int bit)
@@ -608,6 +641,110 @@ static void rtw89_mcc_set_default_pattern(struct rtw89_dev *rtwdev)
 	rtw89_mcc_assign_pattern(rtwdev, &tmp);
 }
 
+static void rtw89_mcc_set_duration_go_sta(struct rtw89_dev *rtwdev,
+					  struct rtw89_mcc_role *role_go,
+					  struct rtw89_mcc_role *role_sta)
+{
+	struct rtw89_mcc_info *mcc = &rtwdev->mcc;
+	struct rtw89_mcc_config *config = &mcc->config;
+	u16 mcc_intvl = config->mcc_interval;
+	u16 dur_go, dur_sta;
+
+	dur_go = clamp_t(u16, role_go->duration, RTW89_MCC_MIN_GO_DURATION,
+			 mcc_intvl - RTW89_MCC_MIN_STA_DURATION);
+	if (role_go->limit.enable)
+		dur_go = min(dur_go, role_go->limit.max_dur);
+	dur_sta = mcc_intvl - dur_go;
+
+	rtw89_debug(rtwdev, RTW89_DBG_CHAN,
+		    "MCC set dur: (go, sta) {%d, %d} -> {%d, %d}\n",
+		    role_go->duration, role_sta->duration, dur_go, dur_sta);
+
+	role_go->duration = dur_go;
+	role_sta->duration = dur_sta;
+}
+
+static void rtw89_mcc_set_duration_gc_sta(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_mcc_info *mcc = &rtwdev->mcc;
+	struct rtw89_mcc_role *ref = &mcc->role_ref;
+	struct rtw89_mcc_role *aux = &mcc->role_aux;
+	struct rtw89_mcc_config *config = &mcc->config;
+	u16 mcc_intvl = config->mcc_interval;
+	u16 dur_ref, dur_aux;
+
+	if (ref->duration < RTW89_MCC_MIN_STA_DURATION) {
+		dur_ref = RTW89_MCC_MIN_STA_DURATION;
+		dur_aux = mcc_intvl - dur_ref;
+	} else if (aux->duration < RTW89_MCC_MIN_STA_DURATION) {
+		dur_aux = RTW89_MCC_MIN_STA_DURATION;
+		dur_ref = mcc_intvl - dur_aux;
+	} else {
+		dur_ref = ref->duration;
+		dur_aux = mcc_intvl - dur_ref;
+	}
+
+	if (ref->limit.enable) {
+		dur_ref = min(dur_ref, ref->limit.max_dur);
+		dur_aux = mcc_intvl - dur_ref;
+	} else if (aux->limit.enable) {
+		dur_aux = min(dur_aux, aux->limit.max_dur);
+		dur_ref = mcc_intvl - dur_aux;
+	}
+
+	rtw89_debug(rtwdev, RTW89_DBG_CHAN,
+		    "MCC set dur: (ref, aux) {%d ~ %d} -> {%d ~ %d}\n",
+		    ref->duration, aux->duration, dur_ref, dur_aux);
+
+	ref->duration = dur_ref;
+	aux->duration = dur_aux;
+}
+
+static void rtw89_mcc_sync_tbtt(struct rtw89_dev *rtwdev,
+				struct rtw89_mcc_role *tgt,
+				struct rtw89_mcc_role *src,
+				bool ref_is_src)
+{
+	struct rtw89_mcc_info *mcc = &rtwdev->mcc;
+	struct rtw89_mcc_config *config = &mcc->config;
+	u16 beacon_offset_us = ieee80211_tu_to_usec(config->beacon_offset);
+	u32 bcn_intvl_src_us = ieee80211_tu_to_usec(src->beacon_interval);
+	u32 cur_tbtt_ofst_src;
+	u32 tsf_ofst_tgt;
+	u64 tbtt_tgt;
+	u64 tsf_src;
+	int ret;
+
+	ret = rtw89_mac_port_get_tsf(rtwdev, src->rtwvif, &tsf_src);
+	if (ret) {
+		rtw89_warn(rtwdev, "MCC failed to get port tsf: %d\n", ret);
+		return;
+	}
+
+	cur_tbtt_ofst_src = rtw89_mcc_get_tbtt_ofst(rtwdev, src, tsf_src);
+
+	if (ref_is_src)
+		tbtt_tgt = tsf_src - cur_tbtt_ofst_src + beacon_offset_us;
+	else
+		tbtt_tgt = tsf_src - cur_tbtt_ofst_src +
+			   (bcn_intvl_src_us - beacon_offset_us);
+
+	tsf_ofst_tgt = bcn_intvl_src_us - tbtt_tgt % bcn_intvl_src_us;
+
+	config->sync.macid_tgt = tgt->rtwvif->mac_id;
+	config->sync.macid_src = src->rtwvif->mac_id;
+	config->sync.offset = tsf_ofst_tgt / 1024;
+	config->sync.enable = true;
+
+	rtw89_debug(rtwdev, RTW89_DBG_CHAN,
+		    "MCC sync tbtt: tgt %d, src %d, offset %d\n",
+		    config->sync.macid_tgt, config->sync.macid_src,
+		    config->sync.offset);
+
+	rtw89_mac_port_tsf_sync(rtwdev, tgt->rtwvif, src->rtwvif,
+				config->sync.offset);
+}
+
 static int rtw89_mcc_fill_start_tsf(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_mcc_info *mcc = &rtwdev->mcc;
@@ -645,9 +782,35 @@ static int rtw89_mcc_fill_start_tsf(struct rtw89_dev *rtwdev)
 static int rtw89_mcc_fill_config(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_mcc_info *mcc = &rtwdev->mcc;
+	struct rtw89_mcc_role *ref = &mcc->role_ref;
+	struct rtw89_mcc_role *aux = &mcc->role_aux;
 	struct rtw89_mcc_config *config = &mcc->config;
 
 	memset(config, 0, sizeof(*config));
+
+	switch (mcc->mode) {
+	case RTW89_MCC_MODE_GO_STA:
+		config->beacon_offset = RTW89_MCC_DFLT_BCN_OFST_TIME;
+		if (ref->is_go) {
+			rtw89_mcc_sync_tbtt(rtwdev, ref, aux, false);
+			config->mcc_interval = ref->beacon_interval;
+			rtw89_mcc_set_duration_go_sta(rtwdev, ref, aux);
+		} else {
+			rtw89_mcc_sync_tbtt(rtwdev, aux, ref, true);
+			config->mcc_interval = aux->beacon_interval;
+			rtw89_mcc_set_duration_go_sta(rtwdev, aux, ref);
+		}
+		break;
+	case RTW89_MCC_MODE_GC_STA:
+		config->beacon_offset = rtw89_mcc_get_bcn_ofst(rtwdev);
+		config->mcc_interval = ref->beacon_interval;
+		rtw89_mcc_set_duration_gc_sta(rtwdev);
+		break;
+	default:
+		rtw89_warn(rtwdev, "MCC unknown mode: %d\n", mcc->mode);
+		return -EFAULT;
+	}
+
 	rtw89_mcc_set_default_pattern(rtwdev);
 	return rtw89_mcc_fill_start_tsf(rtwdev);
 }
@@ -677,6 +840,8 @@ static int rtw89_mcc_start(struct rtw89_dev *rtwdev)
 
 	rtw89_debug(rtwdev, RTW89_DBG_CHAN, "MCC sel mode: %d\n", mcc->mode);
 
+	mcc->group = RTW89_MCC_DFLT_GROUP;
+
 	ret = rtw89_mcc_fill_config(rtwdev);
 	if (ret)
 		return ret;
diff --git a/drivers/net/wireless/realtek/rtw89/chan.h b/drivers/net/wireless/realtek/rtw89/chan.h
index eac5e0460e10..9bdf3d1637bb 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.h
+++ b/drivers/net/wireless/realtek/rtw89/chan.h
@@ -13,7 +13,18 @@
 /* various MCC setting time in TU */
 #define RTW89_MCC_LONG_TRIGGER_TIME 300
 #define RTW89_MCC_SHORT_TRIGGER_TIME 100
+#define RTW89_MCC_EARLY_TX_BCN_TIME 10
+#define RTW89_MCC_EARLY_RX_BCN_TIME 5
+#define RTW89_MCC_MIN_RX_BCN_TIME 10
+#define RTW89_MCC_DFLT_BCN_OFST_TIME 40
 
+#define RTW89_MCC_MIN_GO_DURATION \
+	(RTW89_MCC_EARLY_TX_BCN_TIME + RTW89_MCC_MIN_RX_BCN_TIME)
+
+#define RTW89_MCC_MIN_STA_DURATION \
+	(RTW89_MCC_EARLY_RX_BCN_TIME + RTW89_MCC_MIN_RX_BCN_TIME)
+
+#define RTW89_MCC_DFLT_GROUP 0
 #define RTW89_MCC_DFLT_TX_NULL_EARLY 3
 #define RTW89_MCC_DFLT_COURTESY_SLOT 3
 
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index c14fd08cac98..4775fb490034 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4415,8 +4415,16 @@ struct rtw89_mcc_pattern {
 	struct rtw89_mcc_courtesy courtesy;
 };
 
+struct rtw89_mcc_sync {
+	bool enable;
+	u16 offset; /* TU */
+	u8 macid_src;
+	u8 macid_tgt;
+};
+
 struct rtw89_mcc_config {
 	struct rtw89_mcc_pattern pattern;
+	struct rtw89_mcc_sync sync;
 	u64 start_tsf;
 	u16 mcc_interval; /* TU */
 	u16 beacon_offset; /* TU */
@@ -4430,6 +4438,7 @@ enum rtw89_mcc_mode {
 struct rtw89_mcc_info {
 	struct rtw89_wait_info wait;
 
+	u8 group;
 	enum rtw89_mcc_mode mode;
 	struct rtw89_mcc_role role_ref; /* reference role */
 	struct rtw89_mcc_role role_aux; /* auxiliary role */
-- 
2.25.1

