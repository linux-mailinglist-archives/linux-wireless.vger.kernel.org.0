Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1450F78BCC4
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Aug 2023 04:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235355AbjH2CVA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Aug 2023 22:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235223AbjH2CUd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Aug 2023 22:20:33 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6C02919F
        for <linux-wireless@vger.kernel.org>; Mon, 28 Aug 2023 19:20:28 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 37T2Jt9yA019018, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 37T2Jt9yA019018
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 29 Aug 2023 10:19:55 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 29 Aug 2023 10:20:20 +0800
Received: from [127.0.1.1] (172.21.69.25) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 29 Aug
 2023 10:20:19 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 4/6] wifi: rtw89: mcc: decide pattern and calculate parameters
Date:   Tue, 29 Aug 2023 10:19:16 +0800
Message-ID: <20230829021918.14599-5-pkshih@realtek.com>
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

After the previous works, we can now expand and display the MCC pattern
in more detail, as shown below.

|<                              MCC interval                            >|
|<   duration ref    >| (if mid bt) |<   duration aux    >| (if tail bt) |
|<tob ref >|< toa ref>|     ...     |<tob aux >|< toa aux>|     ...      |
           V                                   V
       tbtt ref                            tbtt aux
           |<          beacon offset          >|

(where tob means `time offset behind` and toa means `time offset ahead`)

There are two key points.
1. decide position of BT slot if MCC pattern needs to handle BT duration.
2. calculate all parameters related to tob and toa in MCC pattern.

For point (1), when BT duration needs to be handled, BT position will
rely on beacon offset, either middle or tail. For point (2), to ensure
durations of the Wi-Fi roles cover their beacons, we have to calculate
tob and toa for them according to their TBTT.

And, there are two strategies to calculate parameters, strict and loose.
In strict pattern, all parameters take HW time into account as limitation.
But, the strict calculation are not always successful. In loose pattern,
it only tries to give positive parameters to reference role and doesn't
care much about auxiliary role. If unfortunately auxiliary role gets
negative parameters in loose pattern, FW will be notified and then deal
with it. So, the loose calculation won't fail. In general, we always try
strict pattern cases before using a loose pattern.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/chan.c | 233 ++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/core.h |   2 +
 2 files changed, 235 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/chan.c b/drivers/net/wireless/realtek/rtw89/chan.c
index 0d93427e0122..c609a252ef12 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.c
+++ b/drivers/net/wireless/realtek/rtw89/chan.c
@@ -622,6 +622,232 @@ static void rtw89_mcc_assign_pattern(struct rtw89_dev *rtwdev,
 		    pattern->courtesy.slot_num);
 }
 
+/* The follow-up roughly shows the relationship between the parameters
+ * for pattern calculation.
+ *
+ * |<    duration ref     >| (if mid bt) |<    duration aux     >|
+ * |< tob ref >|< toa ref >|     ...     |< tob aux >|< toa aux >|
+ *             V                                     V
+ *         tbtt ref                              tbtt aux
+ *             |<           beacon offset           >|
+ *
+ * In loose pattern calculation, we only ensure at least tob_ref and
+ * toa_ref have positive results. If tob_aux or toa_aux is negative
+ * unfortunately, FW will be notified to handle it with courtesy
+ * mechanism.
+ */
+static void __rtw89_mcc_calc_pattern_loose(struct rtw89_dev *rtwdev,
+					   struct rtw89_mcc_pattern *ptrn,
+					   bool hdl_bt)
+{
+	struct rtw89_mcc_info *mcc = &rtwdev->mcc;
+	struct rtw89_mcc_role *ref = &mcc->role_ref;
+	struct rtw89_mcc_role *aux = &mcc->role_aux;
+	struct rtw89_mcc_config *config = &mcc->config;
+	u16 bcn_ofst = config->beacon_offset;
+	u16 bt_dur_in_mid = 0;
+	u16 max_bcn_ofst;
+	s16 upper, lower;
+	u16 res;
+
+	*ptrn = (typeof(*ptrn)){
+		.plan = hdl_bt ? RTW89_MCC_PLAN_TAIL_BT : RTW89_MCC_PLAN_NO_BT,
+	};
+
+	if (!hdl_bt)
+		goto calc;
+
+	max_bcn_ofst = ref->duration + aux->duration;
+	if (ref->limit.enable)
+		max_bcn_ofst = min_t(u16, max_bcn_ofst,
+				     ref->limit.max_toa + aux->duration);
+	else if (aux->limit.enable)
+		max_bcn_ofst = min_t(u16, max_bcn_ofst,
+				     ref->duration + aux->limit.max_tob);
+
+	if (bcn_ofst > max_bcn_ofst && bcn_ofst >= mcc->bt_role.duration) {
+		bt_dur_in_mid = mcc->bt_role.duration;
+		ptrn->plan = RTW89_MCC_PLAN_MID_BT;
+	}
+
+calc:
+	rtw89_debug(rtwdev, RTW89_DBG_CHAN,
+		    "MCC calc ptrn_ls: plan %d, bcn_ofst %d\n",
+		    ptrn->plan, bcn_ofst);
+
+	res = bcn_ofst - bt_dur_in_mid;
+	upper = min_t(s16, ref->duration, res);
+	lower = 0;
+
+	if (ref->limit.enable) {
+		upper = min_t(s16, upper, ref->limit.max_toa);
+		lower = max_t(s16, lower, ref->duration - ref->limit.max_tob);
+	} else if (aux->limit.enable) {
+		upper = min_t(s16, upper,
+			      res - (aux->duration - aux->limit.max_toa));
+		lower = max_t(s16, lower, res - aux->limit.max_tob);
+	}
+
+	if (lower < upper)
+		ptrn->toa_ref = (upper + lower) / 2;
+	else
+		ptrn->toa_ref = lower;
+
+	ptrn->tob_ref = ref->duration - ptrn->toa_ref;
+	ptrn->tob_aux = res - ptrn->toa_ref;
+	ptrn->toa_aux = aux->duration - ptrn->tob_aux;
+}
+
+/* In strict pattern calculation, we consider timing that might need
+ * for HW stuffs, i.e. min_tob and min_toa.
+ */
+static int __rtw89_mcc_calc_pattern_strict(struct rtw89_dev *rtwdev,
+					   struct rtw89_mcc_pattern *ptrn)
+{
+	struct rtw89_mcc_info *mcc = &rtwdev->mcc;
+	struct rtw89_mcc_role *ref = &mcc->role_ref;
+	struct rtw89_mcc_role *aux = &mcc->role_aux;
+	struct rtw89_mcc_config *config = &mcc->config;
+	u16 min_tob = RTW89_MCC_EARLY_RX_BCN_TIME;
+	u16 min_toa = RTW89_MCC_MIN_RX_BCN_TIME;
+	u16 bcn_ofst = config->beacon_offset;
+	s16 upper_toa_ref, lower_toa_ref;
+	s16 upper_tob_aux, lower_tob_aux;
+	u16 bt_dur_in_mid;
+	s16 res;
+
+	rtw89_debug(rtwdev, RTW89_DBG_CHAN,
+		    "MCC calc ptrn_st: plan %d, bcn_ofst %d\n",
+		    ptrn->plan, bcn_ofst);
+
+	if (ptrn->plan == RTW89_MCC_PLAN_MID_BT)
+		bt_dur_in_mid = mcc->bt_role.duration;
+	else
+		bt_dur_in_mid = 0;
+
+	if (ref->duration < min_tob + min_toa) {
+		rtw89_debug(rtwdev, RTW89_DBG_CHAN,
+			    "MCC calc ptrn_st: not meet ref dur cond\n");
+		return -EINVAL;
+	}
+
+	if (aux->duration < min_tob + min_toa) {
+		rtw89_debug(rtwdev, RTW89_DBG_CHAN,
+			    "MCC calc ptrn_st: not meet aux dur cond\n");
+		return -EINVAL;
+	}
+
+	res = bcn_ofst - min_toa - min_tob - bt_dur_in_mid;
+	if (res < 0) {
+		rtw89_debug(rtwdev, RTW89_DBG_CHAN,
+			    "MCC calc ptrn_st: not meet bcn_ofst cond\n");
+		return -EINVAL;
+	}
+
+	upper_toa_ref = min_t(s16, min_toa + res, ref->duration - min_tob);
+	lower_toa_ref = min_toa;
+	upper_tob_aux = min_t(s16, min_tob + res, aux->duration - min_toa);
+	lower_tob_aux = min_tob;
+
+	if (ref->limit.enable) {
+		if (min_tob > ref->limit.max_tob || min_toa > ref->limit.max_toa) {
+			rtw89_debug(rtwdev, RTW89_DBG_CHAN,
+				    "MCC calc ptrn_st: conflict ref limit\n");
+			return -EINVAL;
+		}
+
+		upper_toa_ref = min_t(s16, upper_toa_ref, ref->limit.max_toa);
+		lower_toa_ref = max_t(s16, lower_toa_ref,
+				      ref->duration - ref->limit.max_tob);
+	} else if (aux->limit.enable) {
+		if (min_tob > aux->limit.max_tob || min_toa > aux->limit.max_toa) {
+			rtw89_debug(rtwdev, RTW89_DBG_CHAN,
+				    "MCC calc ptrn_st: conflict aux limit\n");
+			return -EINVAL;
+		}
+
+		upper_tob_aux = min_t(s16, upper_tob_aux, aux->limit.max_tob);
+		lower_tob_aux = max_t(s16, lower_tob_aux,
+				      aux->duration - aux->limit.max_toa);
+	}
+
+	upper_toa_ref = min_t(s16, upper_toa_ref,
+			      bcn_ofst - bt_dur_in_mid - lower_tob_aux);
+	lower_toa_ref = max_t(s16, lower_toa_ref,
+			      bcn_ofst - bt_dur_in_mid - upper_tob_aux);
+	if (lower_toa_ref > upper_toa_ref) {
+		rtw89_debug(rtwdev, RTW89_DBG_CHAN,
+			    "MCC calc ptrn_st: conflict boundary\n");
+		return -EINVAL;
+	}
+
+	ptrn->toa_ref = (upper_toa_ref + lower_toa_ref) / 2;
+	ptrn->tob_ref = ref->duration - ptrn->toa_ref;
+	ptrn->tob_aux = bcn_ofst - ptrn->toa_ref - bt_dur_in_mid;
+	ptrn->toa_aux = aux->duration - ptrn->tob_aux;
+	return 0;
+}
+
+static int rtw89_mcc_calc_pattern(struct rtw89_dev *rtwdev, bool hdl_bt)
+{
+	struct rtw89_mcc_info *mcc = &rtwdev->mcc;
+	struct rtw89_mcc_role *ref = &mcc->role_ref;
+	struct rtw89_mcc_role *aux = &mcc->role_aux;
+	bool sel_plan[NUM_OF_RTW89_MCC_PLAN] = {};
+	struct rtw89_mcc_pattern ptrn;
+	int ret;
+	int i;
+
+	if (ref->limit.enable && aux->limit.enable) {
+		rtw89_debug(rtwdev, RTW89_DBG_CHAN,
+			    "MCC calc ptrn: not support dual limited roles\n");
+		return -EINVAL;
+	}
+
+	if (ref->limit.enable &&
+	    ref->duration > ref->limit.max_tob + ref->limit.max_toa) {
+		rtw89_debug(rtwdev, RTW89_DBG_CHAN,
+			    "MCC calc ptrn: not fit ref limit\n");
+		return -EINVAL;
+	}
+
+	if (aux->limit.enable &&
+	    aux->duration > aux->limit.max_tob + aux->limit.max_toa) {
+		rtw89_debug(rtwdev, RTW89_DBG_CHAN,
+			    "MCC calc ptrn: not fit aux limit\n");
+		return -EINVAL;
+	}
+
+	if (hdl_bt) {
+		sel_plan[RTW89_MCC_PLAN_TAIL_BT] = true;
+		sel_plan[RTW89_MCC_PLAN_MID_BT] = true;
+	} else {
+		sel_plan[RTW89_MCC_PLAN_NO_BT] = true;
+	}
+
+	for (i = 0; i < NUM_OF_RTW89_MCC_PLAN; i++) {
+		if (!sel_plan[i])
+			continue;
+
+		ptrn = (typeof(ptrn)){
+			.plan = i,
+		};
+
+		ret = __rtw89_mcc_calc_pattern_strict(rtwdev, &ptrn);
+		if (ret)
+			rtw89_debug(rtwdev, RTW89_DBG_CHAN,
+				    "MCC calc ptrn_st with plan %d: fail\n", i);
+		else
+			goto done;
+	}
+
+	__rtw89_mcc_calc_pattern_loose(rtwdev, &ptrn, hdl_bt);
+
+done:
+	rtw89_mcc_assign_pattern(rtwdev, &ptrn);
+	return 0;
+}
+
 static void rtw89_mcc_set_default_pattern(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_mcc_info *mcc = &rtwdev->mcc;
@@ -951,6 +1177,7 @@ static int rtw89_mcc_fill_config(struct rtw89_dev *rtwdev)
 	struct rtw89_mcc_role *aux = &mcc->role_aux;
 	struct rtw89_mcc_config *config = &mcc->config;
 	bool hdl_bt;
+	int ret;
 
 	memset(config, 0, sizeof(*config));
 
@@ -980,7 +1207,13 @@ static int rtw89_mcc_fill_config(struct rtw89_dev *rtwdev)
 	hdl_bt = rtw89_mcc_duration_decision_on_bt(rtwdev);
 	rtw89_debug(rtwdev, RTW89_DBG_CHAN, "MCC handle bt: %d\n", hdl_bt);
 
+	ret = rtw89_mcc_calc_pattern(rtwdev, hdl_bt);
+	if (!ret)
+		goto bottom;
+
 	rtw89_mcc_set_default_pattern(rtwdev);
+
+bottom:
 	return rtw89_mcc_fill_start_tsf(rtwdev);
 }
 
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 4775fb490034..d782dc8397e0 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4403,6 +4403,8 @@ enum rtw89_mcc_plan {
 	RTW89_MCC_PLAN_TAIL_BT,
 	RTW89_MCC_PLAN_MID_BT,
 	RTW89_MCC_PLAN_NO_BT,
+
+	NUM_OF_RTW89_MCC_PLAN,
 };
 
 struct rtw89_mcc_pattern {
-- 
2.25.1

