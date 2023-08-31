Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09BCD78E5C4
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Aug 2023 07:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345659AbjHaFdB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 31 Aug 2023 01:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245132AbjHaFcy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 31 Aug 2023 01:32:54 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1A0151BF
        for <linux-wireless@vger.kernel.org>; Wed, 30 Aug 2023 22:32:46 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 37V5WFfO4020465, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 37V5WFfO4020465
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 31 Aug 2023 13:32:15 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 31 Aug 2023 13:32:41 +0800
Received: from [127.0.1.1] (172.21.69.25) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Thu, 31 Aug
 2023 13:32:41 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 6/6] wifi: rtw89: mcc: trigger FW to start/stop MCC
Date:   Thu, 31 Aug 2023 13:31:33 +0800
Message-ID: <20230831053133.24015-7-pkshih@realtek.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Zong-Zhe Yang <kevin_yang@realtek.com>

According to Wi-Fi/BT roles' settings, we fill corresponding H2Cs (host
to chip packets). Then, following MCC (multi-channel concurrency) pattern,
we send these H2Cs as planned. Eventually, the trigger H2Cs will be sent
to tell FW to really start/stop MCC.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2: no change
---
 drivers/net/wireless/realtek/rtw89/chan.c | 173 ++++++++++++++++++++++
 1 file changed, 173 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/chan.c b/drivers/net/wireless/realtek/rtw89/chan.c
index a4cacda2b1c0..5f30c6d304b8 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.c
+++ b/drivers/net/wireless/realtek/rtw89/chan.c
@@ -1222,6 +1222,159 @@ static int rtw89_mcc_fill_config(struct rtw89_dev *rtwdev)
 	return rtw89_mcc_fill_start_tsf(rtwdev);
 }
 
+static int __mcc_fw_add_role(struct rtw89_dev *rtwdev, struct rtw89_mcc_role *role)
+{
+	struct rtw89_mcc_info *mcc = &rtwdev->mcc;
+	struct rtw89_mcc_config *config = &mcc->config;
+	struct rtw89_mcc_pattern *pattern = &config->pattern;
+	struct rtw89_mcc_courtesy *courtesy = &pattern->courtesy;
+	struct rtw89_mcc_policy *policy = &role->policy;
+	struct rtw89_fw_mcc_add_req req = {};
+	const struct rtw89_chan *chan;
+	int ret;
+
+	chan = rtw89_chan_get(rtwdev, role->rtwvif->sub_entity_idx);
+	req.central_ch_seg0 = chan->channel;
+	req.primary_ch = chan->primary_channel;
+	req.bandwidth = chan->band_width;
+	req.ch_band_type = chan->band_type;
+
+	req.macid = role->rtwvif->mac_id;
+	req.group = mcc->group;
+	req.c2h_rpt = policy->c2h_rpt;
+	req.tx_null_early = policy->tx_null_early;
+	req.dis_tx_null = policy->dis_tx_null;
+	req.in_curr_ch = policy->in_curr_ch;
+	req.sw_retry_count = policy->sw_retry_count;
+	req.dis_sw_retry = policy->dis_sw_retry;
+	req.duration = role->duration;
+	req.btc_in_2g = false;
+
+	if (courtesy->enable && courtesy->macid_src == req.macid) {
+		req.courtesy_target = courtesy->macid_tgt;
+		req.courtesy_num = courtesy->slot_num;
+		req.courtesy_en = true;
+	}
+
+	ret = rtw89_fw_h2c_add_mcc(rtwdev, &req);
+	if (ret) {
+		rtw89_debug(rtwdev, RTW89_DBG_CHAN,
+			    "MCC h2c failed to add wifi role: %d\n", ret);
+		return ret;
+	}
+
+	ret = rtw89_fw_h2c_mcc_macid_bitmap(rtwdev, mcc->group,
+					    role->rtwvif->mac_id,
+					    role->macid_bitmap);
+	if (ret) {
+		rtw89_debug(rtwdev, RTW89_DBG_CHAN,
+			    "MCC h2c failed to set macid bitmap: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int __mcc_fw_add_bt_role(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_mcc_info *mcc = &rtwdev->mcc;
+	struct rtw89_mcc_bt_role *bt_role = &mcc->bt_role;
+	struct rtw89_fw_mcc_add_req req = {};
+	int ret;
+
+	req.group = mcc->group;
+	req.duration = bt_role->duration;
+	req.btc_in_2g = true;
+
+	ret = rtw89_fw_h2c_add_mcc(rtwdev, &req);
+	if (ret) {
+		rtw89_debug(rtwdev, RTW89_DBG_CHAN,
+			    "MCC h2c failed to add bt role: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int __mcc_fw_start(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_mcc_info *mcc = &rtwdev->mcc;
+	struct rtw89_mcc_role *ref = &mcc->role_ref;
+	struct rtw89_mcc_role *aux = &mcc->role_aux;
+	struct rtw89_mcc_config *config = &mcc->config;
+	struct rtw89_mcc_pattern *pattern = &config->pattern;
+	struct rtw89_mcc_sync *sync = &config->sync;
+	struct rtw89_fw_mcc_start_req req = {};
+	int ret;
+
+	req.group = mcc->group;
+
+	switch (pattern->plan) {
+	case RTW89_MCC_PLAN_TAIL_BT:
+		ret = __mcc_fw_add_role(rtwdev, ref);
+		if (ret)
+			return ret;
+		ret = __mcc_fw_add_role(rtwdev, aux);
+		if (ret)
+			return ret;
+		ret = __mcc_fw_add_bt_role(rtwdev);
+		if (ret)
+			return ret;
+
+		req.btc_in_group = true;
+		break;
+	case RTW89_MCC_PLAN_MID_BT:
+		ret = __mcc_fw_add_role(rtwdev, ref);
+		if (ret)
+			return ret;
+		ret = __mcc_fw_add_bt_role(rtwdev);
+		if (ret)
+			return ret;
+		ret = __mcc_fw_add_role(rtwdev, aux);
+		if (ret)
+			return ret;
+
+		req.btc_in_group = true;
+		break;
+	case RTW89_MCC_PLAN_NO_BT:
+		ret = __mcc_fw_add_role(rtwdev, ref);
+		if (ret)
+			return ret;
+		ret = __mcc_fw_add_role(rtwdev, aux);
+		if (ret)
+			return ret;
+
+		req.btc_in_group = false;
+		break;
+	default:
+		rtw89_warn(rtwdev, "MCC unknown plan: %d\n", pattern->plan);
+		return -EFAULT;
+	}
+
+	if (sync->enable) {
+		ret = rtw89_fw_h2c_mcc_sync(rtwdev, req.group, sync->macid_src,
+					    sync->macid_tgt, sync->offset);
+		if (ret) {
+			rtw89_debug(rtwdev, RTW89_DBG_CHAN,
+				    "MCC h2c failed to trigger sync: %d\n", ret);
+			return ret;
+		}
+	}
+
+	req.macid = ref->rtwvif->mac_id;
+	req.tsf_high = config->start_tsf >> 32;
+	req.tsf_low = config->start_tsf;
+
+	ret = rtw89_fw_h2c_start_mcc(rtwdev, &req);
+	if (ret) {
+		rtw89_debug(rtwdev, RTW89_DBG_CHAN,
+			    "MCC h2c failed to trigger start: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
 static int rtw89_mcc_start(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_mcc_info *mcc = &rtwdev->mcc;
@@ -1253,13 +1406,33 @@ static int rtw89_mcc_start(struct rtw89_dev *rtwdev)
 	if (ret)
 		return ret;
 
+	ret = __mcc_fw_start(rtwdev);
+	if (ret)
+		return ret;
+
 	rtw89_chanctx_notify(rtwdev, RTW89_CHANCTX_STATE_MCC_START);
 	return 0;
 }
 
 static void rtw89_mcc_stop(struct rtw89_dev *rtwdev)
 {
+	struct rtw89_mcc_info *mcc = &rtwdev->mcc;
+	struct rtw89_mcc_role *ref = &mcc->role_ref;
+	int ret;
+
 	rtw89_debug(rtwdev, RTW89_DBG_CHAN, "MCC stop\n");
+
+	ret = rtw89_fw_h2c_stop_mcc(rtwdev, mcc->group,
+				    ref->rtwvif->mac_id, true);
+	if (ret)
+		rtw89_debug(rtwdev, RTW89_DBG_CHAN,
+			    "MCC h2c failed to trigger stop: %d\n", ret);
+
+	ret = rtw89_fw_h2c_del_mcc_group(rtwdev, mcc->group, true);
+	if (ret)
+		rtw89_debug(rtwdev, RTW89_DBG_CHAN,
+			    "MCC h2c failed to delete group: %d\n", ret);
+
 	rtw89_chanctx_notify(rtwdev, RTW89_CHANCTX_STATE_MCC_STOP);
 }
 
-- 
2.25.1

