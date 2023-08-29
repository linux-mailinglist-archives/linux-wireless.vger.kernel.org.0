Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6529A78BCC2
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Aug 2023 04:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235272AbjH2CU6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Aug 2023 22:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235103AbjH2CUb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Aug 2023 22:20:31 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1690712F
        for <linux-wireless@vger.kernel.org>; Mon, 28 Aug 2023 19:20:24 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 37T2JpXdA018932, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 37T2JpXdA018932
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 29 Aug 2023 10:19:51 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 29 Aug 2023 10:20:16 +0800
Received: from [127.0.1.1] (172.21.69.25) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 29 Aug
 2023 10:20:15 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/6] wifi: rtw89: mcc: initialize start flow
Date:   Tue, 29 Aug 2023 10:19:13 +0800
Message-ID: <20230829021918.14599-2-pkshih@realtek.com>
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

We prepare to support TDMA-based MCC (multi-channel concurrency)
which allows two kinds of modes below.
* P2P GO + normal STA
* P2P GC + normal STA

Each mode has two vif and two chanctx. Then, each vif binds one
separate chanctx and becomes one MCC role. We name the two MCC
roles as follows.
* MCC role - reference (ref)
	We calculate the baseline of our TDMA things accodring
	to its info, e.g. TBTT. In normal case, it will be put
	at the first slot of TDMA.
* MCC role - auxiliary (aux)

MCC state machine will be running in FW eventually, but before that,
we have to fill and calculate things that are needed by FW. We fill
the information of MCC role according to its vif and its chanctx.
Then, we calculate the start time for MCC.

Note that the parameters used in the calculation now is assigned by
default rules. The precise parameters for better MCC behavior will be
derived in the following.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/chan.c | 410 ++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/chan.h |   9 +
 drivers/net/wireless/realtek/rtw89/core.c |   4 +
 drivers/net/wireless/realtek/rtw89/core.h |  76 ++++
 4 files changed, 499 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/chan.c b/drivers/net/wireless/realtek/rtw89/chan.c
index e1bc3606f9ae..617d7473ba7c 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.c
+++ b/drivers/net/wireless/realtek/rtw89/chan.c
@@ -3,8 +3,10 @@
  */
 
 #include "chan.h"
+#include "coex.h"
 #include "debug.h"
 #include "fw.h"
+#include "mac.h"
 #include "ps.h"
 #include "util.h"
 
@@ -263,14 +265,422 @@ static void rtw89_chanctx_notify(struct rtw89_dev *rtwdev,
 	}
 }
 
+/* This function centrally manages how MCC roles are sorted and iterated.
+ * And, it guarantees that ordered_idx is less than NUM_OF_RTW89_MCC_ROLES.
+ * So, if data needs to pass an array for ordered_idx, the array can declare
+ * with NUM_OF_RTW89_MCC_ROLES. Besides, the entire iteration will stop
+ * immediately as long as iterator returns a non-zero value.
+ */
+static
+int rtw89_iterate_mcc_roles(struct rtw89_dev *rtwdev,
+			    int (*iterator)(struct rtw89_dev *rtwdev,
+					    struct rtw89_mcc_role *mcc_role,
+					    unsigned int ordered_idx,
+					    void *data),
+			    void *data)
+{
+	struct rtw89_mcc_info *mcc = &rtwdev->mcc;
+	struct rtw89_mcc_role * const roles[] = {
+		&mcc->role_ref,
+		&mcc->role_aux,
+	};
+	unsigned int idx;
+	int ret;
+
+	BUILD_BUG_ON(ARRAY_SIZE(roles) != NUM_OF_RTW89_MCC_ROLES);
+
+	for (idx = 0; idx < NUM_OF_RTW89_MCC_ROLES; idx++) {
+		ret = iterator(rtwdev, roles[idx], idx, data);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+/* For now, IEEE80211_HW_TIMING_BEACON_ONLY can make things simple to ensure
+ * correctness of MCC calculation logic below. We have noticed that once driver
+ * declares WIPHY_FLAG_SUPPORTS_MLO, the use of IEEE80211_HW_TIMING_BEACON_ONLY
+ * will be restricted. We will make an alternative in driver when it is ready
+ * for MLO.
+ */
+static u32 rtw89_mcc_get_tbtt_ofst(struct rtw89_dev *rtwdev,
+				   struct rtw89_mcc_role *role, u64 tsf)
+{
+	struct rtw89_vif *rtwvif = role->rtwvif;
+	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif);
+	u32 bcn_intvl_us = ieee80211_tu_to_usec(role->beacon_interval);
+	u64 sync_tsf = vif->bss_conf.sync_tsf;
+
+	if (tsf < sync_tsf) {
+		rtw89_debug(rtwdev, RTW89_DBG_CHAN,
+			    "MCC get tbtt ofst: tsf might not update yet\n");
+		sync_tsf = 0;
+	}
+
+	return (tsf - sync_tsf) % bcn_intvl_us;
+}
+
+static
+void rtw89_mcc_role_fw_macid_bitmap_set_bit(struct rtw89_mcc_role *mcc_role,
+					    unsigned int bit)
+{
+	unsigned int idx = bit / 8;
+	unsigned int pos = bit % 8;
+
+	if (idx >= ARRAY_SIZE(mcc_role->macid_bitmap))
+		return;
+
+	mcc_role->macid_bitmap[idx] |= BIT(pos);
+}
+
+static void rtw89_mcc_role_macid_sta_iter(void *data, struct ieee80211_sta *sta)
+{
+	struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
+	struct rtw89_vif *rtwvif = rtwsta->rtwvif;
+	struct rtw89_mcc_role *mcc_role = data;
+	struct rtw89_vif *target = mcc_role->rtwvif;
+
+	if (rtwvif != target)
+		return;
+
+	rtw89_mcc_role_fw_macid_bitmap_set_bit(mcc_role, rtwsta->mac_id);
+}
+
+static void rtw89_mcc_fill_role_macid_bitmap(struct rtw89_dev *rtwdev,
+					     struct rtw89_mcc_role *mcc_role)
+{
+	struct rtw89_vif *rtwvif = mcc_role->rtwvif;
+
+	rtw89_mcc_role_fw_macid_bitmap_set_bit(mcc_role, rtwvif->mac_id);
+	ieee80211_iterate_stations_atomic(rtwdev->hw,
+					  rtw89_mcc_role_macid_sta_iter,
+					  mcc_role);
+}
+
+static void rtw89_mcc_fill_role_policy(struct rtw89_dev *rtwdev,
+				       struct rtw89_mcc_role *mcc_role)
+{
+	struct rtw89_mcc_policy *policy = &mcc_role->policy;
+
+	policy->c2h_rpt = RTW89_FW_MCC_C2H_RPT_ALL;
+	policy->tx_null_early = RTW89_MCC_DFLT_TX_NULL_EARLY;
+	policy->in_curr_ch = false;
+	policy->dis_sw_retry = true;
+	policy->sw_retry_count = false;
+
+	if (mcc_role->is_go)
+		policy->dis_tx_null = true;
+	else
+		policy->dis_tx_null = false;
+}
+
+static void rtw89_mcc_fill_role_limit(struct rtw89_dev *rtwdev,
+				      struct rtw89_mcc_role *mcc_role)
+{
+	struct ieee80211_vif *vif = rtwvif_to_vif(mcc_role->rtwvif);
+	struct ieee80211_p2p_noa_desc *noa_desc;
+	u32 bcn_intvl_us = ieee80211_tu_to_usec(mcc_role->beacon_interval);
+	u32 max_toa_us, max_tob_us, max_dur_us;
+	u32 start_time, interval, duration;
+	u64 tsf, tsf_lmt;
+	int ret;
+	int i;
+
+	if (!mcc_role->is_go && !mcc_role->is_gc)
+		return;
+
+	/* find the first periodic NoA */
+	for (i = 0; i < RTW89_P2P_MAX_NOA_NUM; i++) {
+		noa_desc = &vif->bss_conf.p2p_noa_attr.desc[i];
+		if (noa_desc->count == 255)
+			goto fill;
+	}
+
+	return;
+
+fill:
+	start_time = le32_to_cpu(noa_desc->start_time);
+	interval = le32_to_cpu(noa_desc->interval);
+	duration = le32_to_cpu(noa_desc->duration);
+
+	if (interval != bcn_intvl_us) {
+		rtw89_debug(rtwdev, RTW89_DBG_CHAN,
+			    "MCC role limit: mismatch interval: %d vs. %d\n",
+			    interval, bcn_intvl_us);
+		return;
+	}
+
+	ret = rtw89_mac_port_get_tsf(rtwdev, mcc_role->rtwvif, &tsf);
+	if (ret) {
+		rtw89_warn(rtwdev, "MCC failed to get port tsf: %d\n", ret);
+		return;
+	}
+
+	tsf_lmt = (tsf & GENMASK_ULL(63, 32)) | start_time;
+	max_toa_us = rtw89_mcc_get_tbtt_ofst(rtwdev, mcc_role, tsf_lmt);
+	max_dur_us = interval - duration;
+	max_tob_us = max_dur_us - max_toa_us;
+
+	if (!max_toa_us || !max_tob_us) {
+		rtw89_debug(rtwdev, RTW89_DBG_CHAN,
+			    "MCC role limit: hit boundary\n");
+		return;
+	}
+
+	if (max_dur_us < max_toa_us) {
+		rtw89_debug(rtwdev, RTW89_DBG_CHAN,
+			    "MCC role limit: insufficient duration\n");
+		return;
+	}
+
+	mcc_role->limit.max_toa = max_toa_us / 1024;
+	mcc_role->limit.max_tob = max_tob_us / 1024;
+	mcc_role->limit.max_dur = max_dur_us / 1024;
+	mcc_role->limit.enable = true;
+
+	rtw89_debug(rtwdev, RTW89_DBG_CHAN,
+		    "MCC role limit: max_toa %d, max_tob %d, max_dur %d\n",
+		    mcc_role->limit.max_toa, mcc_role->limit.max_tob,
+		    mcc_role->limit.max_dur);
+}
+
+static int rtw89_mcc_fill_role(struct rtw89_dev *rtwdev,
+			       struct rtw89_vif *rtwvif,
+			       struct rtw89_mcc_role *role)
+{
+	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif);
+	const struct rtw89_chan *chan;
+
+	memset(role, 0, sizeof(*role));
+	role->rtwvif = rtwvif;
+	role->beacon_interval = vif->bss_conf.beacon_int;
+
+	if (!role->beacon_interval) {
+		rtw89_warn(rtwdev,
+			   "cannot handle MCC role without beacon interval\n");
+		return -EINVAL;
+	}
+
+	role->duration = role->beacon_interval / 2;
+
+	chan = rtw89_chan_get(rtwdev, rtwvif->sub_entity_idx);
+	role->is_2ghz = chan->band_type == RTW89_BAND_2G;
+	role->is_go = rtwvif->wifi_role == RTW89_WIFI_ROLE_P2P_GO;
+	role->is_gc = rtwvif->wifi_role == RTW89_WIFI_ROLE_P2P_CLIENT;
+
+	rtw89_mcc_fill_role_macid_bitmap(rtwdev, role);
+	rtw89_mcc_fill_role_policy(rtwdev, role);
+	rtw89_mcc_fill_role_limit(rtwdev, role);
+
+	rtw89_debug(rtwdev, RTW89_DBG_CHAN,
+		    "MCC role: bcn_intvl %d, is_2ghz %d, is_go %d, is_gc %d\n",
+		    role->beacon_interval, role->is_2ghz, role->is_go, role->is_gc);
+	return 0;
+}
+
+static void rtw89_mcc_fill_bt_role(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_mcc_info *mcc = &rtwdev->mcc;
+	struct rtw89_mcc_bt_role *bt_role = &mcc->bt_role;
+
+	memset(bt_role, 0, sizeof(*bt_role));
+	bt_role->duration = rtw89_coex_query_bt_req_len(rtwdev, RTW89_PHY_0);
+
+	rtw89_debug(rtwdev, RTW89_DBG_CHAN, "MCC bt role: dur %d\n",
+		    bt_role->duration);
+}
+
+struct rtw89_mcc_fill_role_selector {
+	struct rtw89_vif *bind_vif[NUM_OF_RTW89_SUB_ENTITY];
+};
+
+static_assert((u8)NUM_OF_RTW89_SUB_ENTITY >= NUM_OF_RTW89_MCC_ROLES);
+
+static int rtw89_mcc_fill_role_iterator(struct rtw89_dev *rtwdev,
+					struct rtw89_mcc_role *mcc_role,
+					unsigned int ordered_idx,
+					void *data)
+{
+	struct rtw89_mcc_fill_role_selector *sel = data;
+	struct rtw89_vif *role_vif = sel->bind_vif[ordered_idx];
+	int ret;
+
+	if (!role_vif) {
+		rtw89_warn(rtwdev, "cannot handle MCC without role[%d]\n",
+			   ordered_idx);
+		return -EINVAL;
+	}
+
+	rtw89_debug(rtwdev, RTW89_DBG_CHAN,
+		    "MCC fill role[%d] with vif <macid %d>\n",
+		    ordered_idx, role_vif->mac_id);
+
+	ret = rtw89_mcc_fill_role(rtwdev, role_vif, mcc_role);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int rtw89_mcc_fill_all_roles(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_mcc_fill_role_selector sel = {};
+	struct rtw89_vif *rtwvif;
+	int ret;
+
+	rtw89_for_each_rtwvif(rtwdev, rtwvif) {
+		if (sel.bind_vif[rtwvif->sub_entity_idx]) {
+			rtw89_warn(rtwdev,
+				   "MCC skip extra vif <macid %d> on chanctx[%d]\n",
+				   rtwvif->mac_id, rtwvif->sub_entity_idx);
+			continue;
+		}
+
+		sel.bind_vif[rtwvif->sub_entity_idx] = rtwvif;
+	}
+
+	ret = rtw89_iterate_mcc_roles(rtwdev, rtw89_mcc_fill_role_iterator, &sel);
+	if (ret)
+		return ret;
+
+	rtw89_mcc_fill_bt_role(rtwdev);
+	return 0;
+}
+
+static void rtw89_mcc_assign_pattern(struct rtw89_dev *rtwdev,
+				     const struct rtw89_mcc_pattern *new)
+{
+	struct rtw89_mcc_info *mcc = &rtwdev->mcc;
+	struct rtw89_mcc_role *ref = &mcc->role_ref;
+	struct rtw89_mcc_role *aux = &mcc->role_aux;
+	struct rtw89_mcc_config *config = &mcc->config;
+	struct rtw89_mcc_pattern *pattern = &config->pattern;
+
+	rtw89_debug(rtwdev, RTW89_DBG_CHAN,
+		    "MCC assign pattern: ref {%d | %d}, aux {%d | %d}\n",
+		    new->tob_ref, new->toa_ref, new->tob_aux, new->toa_aux);
+
+	*pattern = *new;
+	memset(&pattern->courtesy, 0, sizeof(pattern->courtesy));
+
+	if (pattern->tob_aux <= 0 || pattern->toa_aux <= 0) {
+		pattern->courtesy.macid_tgt = aux->rtwvif->mac_id;
+		pattern->courtesy.macid_src = ref->rtwvif->mac_id;
+		pattern->courtesy.slot_num = RTW89_MCC_DFLT_COURTESY_SLOT;
+		pattern->courtesy.enable = true;
+	} else if (pattern->tob_ref <= 0 || pattern->toa_ref <= 0) {
+		pattern->courtesy.macid_tgt = ref->rtwvif->mac_id;
+		pattern->courtesy.macid_src = aux->rtwvif->mac_id;
+		pattern->courtesy.slot_num = RTW89_MCC_DFLT_COURTESY_SLOT;
+		pattern->courtesy.enable = true;
+	}
+
+	rtw89_debug(rtwdev, RTW89_DBG_CHAN,
+		    "MCC pattern flags: plan %d, courtesy_en %d\n",
+		    pattern->plan, pattern->courtesy.enable);
+
+	if (!pattern->courtesy.enable)
+		return;
+
+	rtw89_debug(rtwdev, RTW89_DBG_CHAN,
+		    "MCC pattern courtesy: tgt %d, src %d, slot %d\n",
+		    pattern->courtesy.macid_tgt, pattern->courtesy.macid_src,
+		    pattern->courtesy.slot_num);
+}
+
+static void rtw89_mcc_set_default_pattern(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_mcc_info *mcc = &rtwdev->mcc;
+	struct rtw89_mcc_role *ref = &mcc->role_ref;
+	struct rtw89_mcc_role *aux = &mcc->role_aux;
+	struct rtw89_mcc_pattern tmp = {};
+
+	rtw89_debug(rtwdev, RTW89_DBG_CHAN,
+		    "MCC use default pattern unexpectedly\n");
+
+	tmp.plan = RTW89_MCC_PLAN_NO_BT;
+	tmp.tob_ref = ref->duration / 2;
+	tmp.toa_ref = ref->duration - tmp.tob_ref;
+	tmp.tob_aux = aux->duration / 2;
+	tmp.toa_aux = aux->duration - tmp.tob_aux;
+
+	rtw89_mcc_assign_pattern(rtwdev, &tmp);
+}
+
+static int rtw89_mcc_fill_start_tsf(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_mcc_info *mcc = &rtwdev->mcc;
+	struct rtw89_mcc_role *ref = &mcc->role_ref;
+	struct rtw89_mcc_config *config = &mcc->config;
+	u32 bcn_intvl_ref_us = ieee80211_tu_to_usec(ref->beacon_interval);
+	u32 tob_ref_us = ieee80211_tu_to_usec(config->pattern.tob_ref);
+	struct rtw89_vif *rtwvif = ref->rtwvif;
+	u64 tsf, start_tsf;
+	u32 cur_tbtt_ofst;
+	u64 min_time;
+	int ret;
+
+	ret = rtw89_mac_port_get_tsf(rtwdev, rtwvif, &tsf);
+	if (ret) {
+		rtw89_warn(rtwdev, "MCC failed to get port tsf: %d\n", ret);
+		return ret;
+	}
+
+	min_time = tsf;
+	if (ref->is_go)
+		min_time += ieee80211_tu_to_usec(RTW89_MCC_SHORT_TRIGGER_TIME);
+	else
+		min_time += ieee80211_tu_to_usec(RTW89_MCC_LONG_TRIGGER_TIME);
+
+	cur_tbtt_ofst = rtw89_mcc_get_tbtt_ofst(rtwdev, ref, tsf);
+	start_tsf = tsf - cur_tbtt_ofst + bcn_intvl_ref_us - tob_ref_us;
+	while (start_tsf < min_time)
+		start_tsf += bcn_intvl_ref_us;
+
+	config->start_tsf = start_tsf;
+	return 0;
+}
+
+static int rtw89_mcc_fill_config(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_mcc_info *mcc = &rtwdev->mcc;
+	struct rtw89_mcc_config *config = &mcc->config;
+
+	memset(config, 0, sizeof(*config));
+	rtw89_mcc_set_default_pattern(rtwdev);
+	return rtw89_mcc_fill_start_tsf(rtwdev);
+}
+
 static int rtw89_mcc_start(struct rtw89_dev *rtwdev)
 {
+	struct rtw89_mcc_info *mcc = &rtwdev->mcc;
+	struct rtw89_mcc_role *ref = &mcc->role_ref;
+	struct rtw89_mcc_role *aux = &mcc->role_aux;
+	int ret;
+
 	if (rtwdev->scanning)
 		rtw89_hw_scan_abort(rtwdev, rtwdev->scan_info.scanning_vif);
 
 	rtw89_leave_lps(rtwdev);
 
 	rtw89_debug(rtwdev, RTW89_DBG_CHAN, "MCC start\n");
+
+	ret = rtw89_mcc_fill_all_roles(rtwdev);
+	if (ret)
+		return ret;
+
+	if (ref->is_go || aux->is_go)
+		mcc->mode = RTW89_MCC_MODE_GO_STA;
+	else
+		mcc->mode = RTW89_MCC_MODE_GC_STA;
+
+	rtw89_debug(rtwdev, RTW89_DBG_CHAN, "MCC sel mode: %d\n", mcc->mode);
+
+	ret = rtw89_mcc_fill_config(rtwdev);
+	if (ret)
+		return ret;
+
 	rtw89_chanctx_notify(rtwdev, RTW89_CHANCTX_STATE_MCC_START);
 	return 0;
 }
diff --git a/drivers/net/wireless/realtek/rtw89/chan.h b/drivers/net/wireless/realtek/rtw89/chan.h
index 448e6c5df9f1..eac5e0460e10 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.h
+++ b/drivers/net/wireless/realtek/rtw89/chan.h
@@ -10,6 +10,15 @@
 /* The dwell time in TU before doing rtw89_chanctx_work(). */
 #define RTW89_CHANCTX_TIME_MCC_PREPARE 100
 
+/* various MCC setting time in TU */
+#define RTW89_MCC_LONG_TRIGGER_TIME 300
+#define RTW89_MCC_SHORT_TRIGGER_TIME 100
+
+#define RTW89_MCC_DFLT_TX_NULL_EARLY 3
+#define RTW89_MCC_DFLT_COURTESY_SLOT 3
+
+#define NUM_OF_RTW89_MCC_ROLES 2
+
 static inline bool rtw89_get_entity_state(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_hal *hal = &rtwdev->hal;
diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 133bf289bacb..183e1f34fcce 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -3892,6 +3892,10 @@ static int rtw89_core_register_hw(struct rtw89_dev *rtwdev)
 	ieee80211_hw_set(hw, SINGLE_SCAN_ON_ALL_BANDS);
 	ieee80211_hw_set(hw, SUPPORTS_MULTI_BSSID);
 	ieee80211_hw_set(hw, WANT_MONITOR_VIF);
+
+	/* ref: description of rtw89_mcc_get_tbtt_ofst() in chan.c */
+	ieee80211_hw_set(hw, TIMING_BEACON_ONLY);
+
 	if (RTW89_CHK_FW_FEATURE(BEACON_FILTER, &rtwdev->fw))
 		ieee80211_hw_set(hw, CONNECTION_MONITOR);
 
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 04ce221730f9..c14fd08cac98 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4357,8 +4357,84 @@ struct rtw89_wow_param {
 	u8 pattern_cnt;
 };
 
+struct rtw89_mcc_limit {
+	bool enable;
+	u16 max_tob; /* TU; max time offset behind */
+	u16 max_toa; /* TU; max time offset ahead */
+	u16 max_dur; /* TU */
+};
+
+struct rtw89_mcc_policy {
+	u8 c2h_rpt;
+	u8 tx_null_early;
+	u8 dis_tx_null;
+	u8 in_curr_ch;
+	u8 dis_sw_retry;
+	u8 sw_retry_count;
+};
+
+struct rtw89_mcc_role {
+	struct rtw89_vif *rtwvif;
+	struct rtw89_mcc_policy policy;
+	struct rtw89_mcc_limit limit;
+
+	/* byte-array in LE order for FW */
+	u8 macid_bitmap[BITS_TO_BYTES(RTW89_MAX_MAC_ID_NUM)];
+
+	u16 duration; /* TU */
+	u16 beacon_interval; /* TU */
+	bool is_2ghz;
+	bool is_go;
+	bool is_gc;
+};
+
+struct rtw89_mcc_bt_role {
+	u16 duration; /* TU */
+};
+
+struct rtw89_mcc_courtesy {
+	bool enable;
+	u8 slot_num;
+	u8 macid_src;
+	u8 macid_tgt;
+};
+
+enum rtw89_mcc_plan {
+	RTW89_MCC_PLAN_TAIL_BT,
+	RTW89_MCC_PLAN_MID_BT,
+	RTW89_MCC_PLAN_NO_BT,
+};
+
+struct rtw89_mcc_pattern {
+	s16 tob_ref; /* TU; time offset behind of reference role */
+	s16 toa_ref; /* TU; time offset ahead of reference role */
+	s16 tob_aux; /* TU; time offset behind of auxiliary role */
+	s16 toa_aux; /* TU; time offset ahead of auxiliary role */
+
+	enum rtw89_mcc_plan plan;
+	struct rtw89_mcc_courtesy courtesy;
+};
+
+struct rtw89_mcc_config {
+	struct rtw89_mcc_pattern pattern;
+	u64 start_tsf;
+	u16 mcc_interval; /* TU */
+	u16 beacon_offset; /* TU */
+};
+
+enum rtw89_mcc_mode {
+	RTW89_MCC_MODE_GO_STA,
+	RTW89_MCC_MODE_GC_STA,
+};
+
 struct rtw89_mcc_info {
 	struct rtw89_wait_info wait;
+
+	enum rtw89_mcc_mode mode;
+	struct rtw89_mcc_role role_ref; /* reference role */
+	struct rtw89_mcc_role role_aux; /* auxiliary role */
+	struct rtw89_mcc_bt_role bt_role;
+	struct rtw89_mcc_config config;
 };
 
 struct rtw89_dev {
-- 
2.25.1

