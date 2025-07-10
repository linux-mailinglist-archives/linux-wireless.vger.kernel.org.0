Return-Path: <linux-wireless+bounces-25155-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEAF6AFF805
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 06:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD0251C487B7
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 04:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00FA428152B;
	Thu, 10 Jul 2025 04:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="LklDmO6v"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0A02F3E
	for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 04:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752121519; cv=none; b=IkAdPeBjr6y4amZUucGu4ey+1PChOAgj5wYgKUs4XKejaXGvsQCDZnZEPBVM/+RqrPwnauVfmlCqCvqZT0QNus565kUoa+/eGSToT9vmOU0fEo0BLEsEa1RiU2k8wMU/P67ea3r5sQpxTE/7OGWpS8KO5zAuUx1kIrV7EPi18FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752121519; c=relaxed/simple;
	bh=BDFQKK+Jot5CMnhi5U2LYqFBuma58yyCfgEc6K4JRVI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aBdI71gRwogPUbEwr18kcAcSKrK0hQGRmT1Xh0mid1EkWYVnLUaNkMEoJTu+lSBd2tO89xvgXIEMEKVqVm2fnf6s8HImDrYLJ3YN6FMlNM5oq7EdAo5CbEQHw+4VI+J6YdtmFvy4PTpolK4HQ+/xmIIZ2okYx0llqstpgIkJwT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=LklDmO6v; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 56A4PGHu82455824, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1752121516; bh=cySMqVNhoYHRI9ZeaivekHuMNj16/v6lYuKZGBOkCus=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=LklDmO6v3xCBGFCQ6czOrN8nkxYz3kIJYxXnMTZ9aitJ2LGDucOd57hfNusAZGUKl
	 N/1UWxpP3ESKZx0wI+BpztC6QHZRoNwY6/Zufg+dhV/ZlBoJOkBGNWtcemrA6t2cTy
	 EjpKDQOcKrF3Ia4jS1cVW4dNdfX7Wy4Y5o0OhdPkKDci2lxH5bkXgR44vVfYROd3Lp
	 MlGIMsLGPtTFRoECRQWS7Jq0Xdc/0ve63Db/AJrXVHxKt3S94G7Wr4TAU14uzre3uI
	 OJVG6qUm8yydaLjcC1dHBrvp18JI3531BLvYUcchpgdDslZEeb9VCyabaPWqy+kB0N
	 as98+QHAJNpTg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 56A4PGHu82455824
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 12:25:16 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 10 Jul 2025 12:25:15 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 10 Jul
 2025 12:25:14 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 06/14] wifi: rtw89: mcc: solve GO's TBTT change and TBTT too close to NoA issue
Date: Thu, 10 Jul 2025 12:24:15 +0800
Message-ID: <20250710042423.73617-7-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250710042423.73617-1-pkshih@realtek.com>
References: <20250710042423.73617-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

From: Chih-Kang Chang <gary.chang@realtek.com>

For some implementation acting as GO under MCC(GO+STA), the GO's TBTT
might change after STA roams to another AP. This could result the new GO
beacon TX at the STA timeslot of GC+STA, causing GC beacon loss.
Therefore, if the GC detects beacon loss, it will pause MCC and remain
on the GO side for 100 TU to detect the new TBTT beacon.

Additionally, some implementation acting as GO under MCC might TX beacon
too close to the NoA period. The GC calculates timeslot pattern the TOB
(time offset behind) or TOA(time offset ahead) less than the minimum
RX beacon time, which leads to beacon loss. Therefore, disable the
beacon filter in this case. Then, if the GO's TBTT changed, the pattern
TOB/TOA greater than the minimum RX beacon time, the beacon filter should
be retriggered during MCC update.

Moreover, if the beacon filter is disabled initially but the GO timeslot
change, causing QoS null data detection fail, also pause MCC to detect new
TBTT beacon.

Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/chan.c     | 143 ++++++++++++++++--
 drivers/net/wireless/realtek/rtw89/chan.h     |   6 +
 drivers/net/wireless/realtek/rtw89/core.h     |   4 +
 drivers/net/wireless/realtek/rtw89/mac.c      |  10 +-
 drivers/net/wireless/realtek/rtw89/mac80211.c |   5 +
 5 files changed, 154 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/chan.c b/drivers/net/wireless/realtek/rtw89/chan.c
index 6c80e08ae99d..ed0d89ac3495 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.c
+++ b/drivers/net/wireless/realtek/rtw89/chan.c
@@ -1000,6 +1000,11 @@ static void rtw89_mcc_assign_pattern(struct rtw89_dev *rtwdev,
 	*pattern = *new;
 	memset(&pattern->courtesy, 0, sizeof(pattern->courtesy));
 
+	if (RTW89_MCC_REQ_COURTESY(pattern, aux) && aux->is_gc)
+		aux->ignore_bcn = true;
+	else
+		aux->ignore_bcn = false;
+
 	if (RTW89_MCC_REQ_COURTESY(pattern, aux) && rtw89_mcc_can_courtesy(ref, aux)) {
 		crtz = &pattern->courtesy.ref;
 		ref->crtz = crtz;
@@ -1014,6 +1019,11 @@ static void rtw89_mcc_assign_pattern(struct rtw89_dev *rtwdev,
 		ref->crtz = NULL;
 	}
 
+	if (RTW89_MCC_REQ_COURTESY(pattern, ref) && ref->is_gc)
+		ref->ignore_bcn = true;
+	else
+		ref->ignore_bcn = false;
+
 	if (RTW89_MCC_REQ_COURTESY(pattern, ref) && rtw89_mcc_can_courtesy(aux, ref)) {
 		crtz = &pattern->courtesy.aux;
 		aux->crtz = crtz;
@@ -2255,15 +2265,6 @@ static int rtw89_mcc_start(struct rtw89_dev *rtwdev)
 	else
 		mcc->mode = RTW89_MCC_MODE_GC_STA;
 
-	if (rtw89_mcc_ignore_bcn(rtwdev, ref)) {
-		rtw89_fw_h2c_set_bcn_fltr_cfg(rtwdev, aux->rtwvif_link, false);
-	} else if (rtw89_mcc_ignore_bcn(rtwdev, aux)) {
-		rtw89_fw_h2c_set_bcn_fltr_cfg(rtwdev, ref->rtwvif_link, false);
-	} else {
-		rtw89_fw_h2c_set_bcn_fltr_cfg(rtwdev, ref->rtwvif_link, true);
-		rtw89_fw_h2c_set_bcn_fltr_cfg(rtwdev, aux->rtwvif_link, true);
-	}
-
 	rtw89_debug(rtwdev, RTW89_DBG_CHAN, "MCC sel mode: %d\n", mcc->mode);
 
 	mcc->group = RTW89_MCC_DFLT_GROUP;
@@ -2272,6 +2273,15 @@ static int rtw89_mcc_start(struct rtw89_dev *rtwdev)
 	if (ret)
 		return ret;
 
+	if (rtw89_mcc_ignore_bcn(rtwdev, ref) || aux->ignore_bcn) {
+		rtw89_fw_h2c_set_bcn_fltr_cfg(rtwdev, aux->rtwvif_link, false);
+	} else if (rtw89_mcc_ignore_bcn(rtwdev, aux) || ref->ignore_bcn) {
+		rtw89_fw_h2c_set_bcn_fltr_cfg(rtwdev, ref->rtwvif_link, false);
+	} else {
+		rtw89_fw_h2c_set_bcn_fltr_cfg(rtwdev, ref->rtwvif_link, true);
+		rtw89_fw_h2c_set_bcn_fltr_cfg(rtwdev, aux->rtwvif_link, true);
+	}
+
 	if (rtw89_concurrent_via_mrc(rtwdev))
 		ret = __mrc_fw_start(rtwdev, false);
 	else
@@ -2391,7 +2401,11 @@ static void rtw89_mcc_stop(struct rtw89_dev *rtwdev,
 static int rtw89_mcc_update(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_mcc_info *mcc = &rtwdev->mcc;
+	bool old_ref_ignore_bcn = mcc->role_ref.ignore_bcn;
+	bool old_aux_ignore_bcn = mcc->role_aux.ignore_bcn;
 	struct rtw89_mcc_config *config = &mcc->config;
+	struct rtw89_mcc_role *ref = &mcc->role_ref;
+	struct rtw89_mcc_role *aux = &mcc->role_aux;
 	struct rtw89_mcc_config old_cfg = *config;
 	bool courtesy_changed;
 	bool sync_changed;
@@ -2406,6 +2420,11 @@ static int rtw89_mcc_update(struct rtw89_dev *rtwdev)
 	if (ret)
 		return ret;
 
+	if (old_ref_ignore_bcn != ref->ignore_bcn)
+		rtw89_fw_h2c_set_bcn_fltr_cfg(rtwdev, ref->rtwvif_link, !ref->ignore_bcn);
+	else if (old_aux_ignore_bcn != aux->ignore_bcn)
+		rtw89_fw_h2c_set_bcn_fltr_cfg(rtwdev, aux->rtwvif_link, !aux->ignore_bcn);
+
 	if (memcmp(&old_cfg.pattern.courtesy, &config->pattern.courtesy,
 		   sizeof(old_cfg.pattern.courtesy)) == 0)
 		courtesy_changed = false;
@@ -2441,10 +2460,105 @@ static int rtw89_mcc_update(struct rtw89_dev *rtwdev)
 	return 0;
 }
 
+static int rtw89_mcc_search_gc_iterator(struct rtw89_dev *rtwdev,
+					struct rtw89_mcc_role *mcc_role,
+					unsigned int ordered_idx,
+					void *data)
+{
+	struct rtw89_mcc_role **role = data;
+
+	if (mcc_role->is_gc)
+		*role = mcc_role;
+
+	return 0;
+}
+
+static struct rtw89_mcc_role *rtw89_mcc_get_gc_role(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_mcc_info *mcc = &rtwdev->mcc;
+	struct rtw89_mcc_role *role = NULL;
+
+	if (mcc->mode != RTW89_MCC_MODE_GC_STA)
+		return NULL;
+
+	rtw89_iterate_mcc_roles(rtwdev, rtw89_mcc_search_gc_iterator, &role);
+
+	return role;
+}
+
+void rtw89_mcc_gc_detect_beacon_work(struct wiphy *wiphy, struct wiphy_work *work)
+{
+	struct rtw89_vif_link *rtwvif_link = container_of(work, struct rtw89_vif_link,
+							  mcc_gc_detect_beacon_work.work);
+	struct ieee80211_vif *vif = rtwvif_link_to_vif(rtwvif_link);
+	enum rtw89_entity_mode mode;
+	struct rtw89_dev *rtwdev;
+
+	lockdep_assert_wiphy(wiphy);
+
+	rtwdev = rtwvif_link->rtwvif->rtwdev;
+
+	mode = rtw89_get_entity_mode(rtwdev);
+	if (mode != RTW89_ENTITY_MODE_MCC)
+		return;
+
+	if (READ_ONCE(rtwvif_link->sync_bcn_tsf) > rtwvif_link->last_sync_bcn_tsf)
+		rtwvif_link->detect_bcn_count = 0;
+	else
+		rtwvif_link->detect_bcn_count++;
+
+	if (rtwvif_link->detect_bcn_count < RTW89_MCC_DETECT_BCN_MAX_TRIES)
+		rtw89_chanctx_proceed(rtwdev, NULL);
+	else
+		ieee80211_connection_loss(vif);
+}
+
+bool rtw89_mcc_detect_go_bcn(struct rtw89_dev *rtwdev,
+			     struct rtw89_vif_link *rtwvif_link)
+{
+	enum rtw89_entity_mode mode = rtw89_get_entity_mode(rtwdev);
+	struct rtw89_chanctx_pause_parm pause_parm = {
+		.rsn = RTW89_CHANCTX_PAUSE_REASON_GC_BCN_LOSS,
+		.trigger = rtwvif_link,
+	};
+	struct ieee80211_bss_conf *bss_conf;
+	struct rtw89_mcc_role *role;
+	u16 bcn_int;
+
+	if (mode != RTW89_ENTITY_MODE_MCC)
+		return false;
+
+	role = rtw89_mcc_get_gc_role(rtwdev);
+	if (!role)
+		return false;
+
+	if (role->rtwvif_link != rtwvif_link)
+		return false;
+
+	rtw89_debug(rtwdev, RTW89_DBG_CHAN,
+		    "MCC GC beacon loss, pause MCC to detect GO beacon\n");
+
+	rcu_read_lock();
+
+	bss_conf = rtw89_vif_rcu_dereference_link(rtwvif_link, true);
+	bcn_int = bss_conf->beacon_int;
+
+	rcu_read_unlock();
+
+	rtw89_chanctx_pause(rtwdev, &pause_parm);
+	rtwvif_link->last_sync_bcn_tsf = READ_ONCE(rtwvif_link->sync_bcn_tsf);
+	wiphy_delayed_work_queue(rtwdev->hw->wiphy,
+				 &rtwvif_link->mcc_gc_detect_beacon_work,
+				 usecs_to_jiffies(ieee80211_tu_to_usec(bcn_int)));
+
+	return true;
+}
+
 static void rtw89_mcc_detect_connection(struct rtw89_dev *rtwdev,
 					struct rtw89_mcc_role *role)
 {
 	struct ieee80211_vif *vif;
+	bool start_detect;
 	int ret;
 
 	ret = rtw89_core_send_nullfunc(rtwdev, role->rtwvif_link, true, false,
@@ -2458,7 +2572,12 @@ static void rtw89_mcc_detect_connection(struct rtw89_dev *rtwdev,
 		return;
 
 	rtw89_debug(rtwdev, RTW89_DBG_CHAN,
-		    "MCC <macid %d> can not detect AP\n", role->rtwvif_link->mac_id);
+		    "MCC <macid %d> can not detect AP/GO\n", role->rtwvif_link->mac_id);
+
+	start_detect = rtw89_mcc_detect_go_bcn(rtwdev, role->rtwvif_link);
+	if (start_detect)
+		return;
+
 	vif = rtwvif_link_to_vif(role->rtwvif_link);
 	ieee80211_connection_loss(vif);
 }
@@ -2474,9 +2593,9 @@ static void rtw89_mcc_track(struct rtw89_dev *rtwdev)
 	u16 bcn_ofst;
 	u16 diff;
 
-	if (rtw89_mcc_ignore_bcn(rtwdev, ref))
+	if (rtw89_mcc_ignore_bcn(rtwdev, ref) || aux->ignore_bcn)
 		rtw89_mcc_detect_connection(rtwdev, aux);
-	else if (rtw89_mcc_ignore_bcn(rtwdev, aux))
+	else if (rtw89_mcc_ignore_bcn(rtwdev, aux) || ref->ignore_bcn)
 		rtw89_mcc_detect_connection(rtwdev, ref);
 
 	if (mcc->mode != RTW89_MCC_MODE_GC_STA)
diff --git a/drivers/net/wireless/realtek/rtw89/chan.h b/drivers/net/wireless/realtek/rtw89/chan.h
index 9a62b7c98b83..b1175419f92b 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.h
+++ b/drivers/net/wireless/realtek/rtw89/chan.h
@@ -23,6 +23,8 @@
 #define RTW89_MCC_PROBE_TIMEOUT 100
 #define RTW89_MCC_PROBE_MAX_TRIES 3
 
+#define RTW89_MCC_DETECT_BCN_MAX_TRIES 2
+
 #define RTW89_MCC_MIN_GO_DURATION \
 	(RTW89_MCC_EARLY_TX_BCN_TIME + RTW89_MCC_MIN_RX_BCN_TIME)
 
@@ -94,6 +96,7 @@ struct rtw89_mr_chanctx_info {
 enum rtw89_chanctx_pause_reasons {
 	RTW89_CHANCTX_PAUSE_REASON_HW_SCAN,
 	RTW89_CHANCTX_PAUSE_REASON_ROC,
+	RTW89_CHANCTX_PAUSE_REASON_GC_BCN_LOSS,
 };
 
 struct rtw89_chanctx_pause_parm {
@@ -188,6 +191,9 @@ struct rtw89_mcc_links_info {
 
 void rtw89_mcc_get_links(struct rtw89_dev *rtwdev, struct rtw89_mcc_links_info *info);
 void rtw89_mcc_prepare_done_work(struct wiphy *wiphy, struct wiphy_work *work);
+void rtw89_mcc_gc_detect_beacon_work(struct wiphy *wiphy, struct wiphy_work *work);
+bool rtw89_mcc_detect_go_bcn(struct rtw89_dev *rtwdev,
+			     struct rtw89_vif_link *rtwvif_link);
 
 int rtw89_chanctx_ops_add(struct rtw89_dev *rtwdev,
 			  struct ieee80211_chanctx_conf *ctx);
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 9da0defc270f..031a69bae861 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3597,6 +3597,7 @@ struct rtw89_vif_link {
 	u8 hit_rule;
 	u8 last_noa_nr;
 	u64 sync_bcn_tsf;
+	u64 last_sync_bcn_tsf;
 	bool rand_tsf_done;
 	bool trigger;
 	bool lsig_txop;
@@ -3620,6 +3621,8 @@ struct rtw89_vif_link {
 	struct list_head general_pkt_list;
 	struct rtw89_p2p_noa_setter p2p_noa;
 	struct rtw89_ps_noa_once_handler noa_once;
+	struct wiphy_delayed_work mcc_gc_detect_beacon_work;
+	u8 detect_bcn_count;
 };
 
 enum rtw89_lv1_rcvy_step {
@@ -5777,6 +5780,7 @@ struct rtw89_mcc_role {
 	bool is_2ghz;
 	bool is_go;
 	bool is_gc;
+	bool ignore_bcn;
 };
 
 struct rtw89_mcc_bt_role {
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 37b113e3bd26..f6bbc796329c 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -5088,6 +5088,7 @@ rtw89_mac_bcn_fltr_rpt(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_l
 	const struct rtw89_c2h_mac_bcnfltr_rpt *c2h =
 		(const struct rtw89_c2h_mac_bcnfltr_rpt *)skb->data;
 	u8 type, event, mac_id;
+	bool start_detect;
 	s8 sig;
 
 	type = le32_get_bits(c2h->w2, RTW89_C2H_MAC_BCNFLTR_RPT_W2_TYPE);
@@ -5105,10 +5106,15 @@ rtw89_mac_bcn_fltr_rpt(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_l
 	switch (type) {
 	case RTW89_BCN_FLTR_BEACON_LOSS:
 		if (!rtwdev->scanning && !rtwvif->offchan &&
-		    !rtwvif_link->noa_once.in_duration)
+		    !rtwvif_link->noa_once.in_duration) {
+			start_detect = rtw89_mcc_detect_go_bcn(rtwdev, rtwvif_link);
+			if (start_detect)
+				return;
+
 			ieee80211_connection_loss(vif);
-		else
+		} else {
 			rtw89_fw_h2c_set_bcn_fltr_cfg(rtwdev, rtwvif_link, true);
+		}
 		return;
 	case RTW89_BCN_FLTR_NOTIFY:
 		nl_event = NL80211_CQM_RSSI_THRESHOLD_EVENT_HIGH;
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index c982ad633b4a..c1ca6d741b32 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -113,6 +113,8 @@ static int __rtw89_ops_add_iface_link(struct rtw89_dev *rtwdev,
 
 	wiphy_work_init(&rtwvif_link->update_beacon_work, rtw89_core_update_beacon_work);
 	wiphy_delayed_work_init(&rtwvif_link->csa_beacon_work, rtw89_core_csa_beacon_work);
+	wiphy_delayed_work_init(&rtwvif_link->mcc_gc_detect_beacon_work,
+				rtw89_mcc_gc_detect_beacon_work);
 
 	INIT_LIST_HEAD(&rtwvif_link->general_pkt_list);
 
@@ -124,6 +126,7 @@ static int __rtw89_ops_add_iface_link(struct rtw89_dev *rtwdev,
 	rtwvif_link->chanctx_idx = RTW89_CHANCTX_0;
 	rtwvif_link->reg_6ghz_power = RTW89_REG_6GHZ_POWER_DFLT;
 	rtwvif_link->rand_tsf_done = false;
+	rtwvif_link->detect_bcn_count = 0;
 
 	rcu_read_lock();
 
@@ -147,6 +150,8 @@ static void __rtw89_ops_remove_iface_link(struct rtw89_dev *rtwdev,
 
 	wiphy_work_cancel(rtwdev->hw->wiphy, &rtwvif_link->update_beacon_work);
 	wiphy_delayed_work_cancel(rtwdev->hw->wiphy, &rtwvif_link->csa_beacon_work);
+	wiphy_delayed_work_cancel(rtwdev->hw->wiphy,
+				  &rtwvif_link->mcc_gc_detect_beacon_work);
 
 	rtw89_p2p_noa_once_deinit(rtwvif_link);
 
-- 
2.25.1


