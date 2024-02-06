Return-Path: <linux-wireless+bounces-3191-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF1984ACAD
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 04:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB5E1B22F46
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 03:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9BE1AB7FC;
	Tue,  6 Feb 2024 03:07:29 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4A04BAAA
	for <linux-wireless@vger.kernel.org>; Tue,  6 Feb 2024 03:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707188849; cv=none; b=f7AlYgjSGplmhf18VVtQqckb79nvWSwO7Pr532R7FFntFeWU5o2YiLD8hqOpq3wYvQxN5PssVvW+7G/cTSqpyPpXHXa70CY5ECeQUEnpf9zei2ALTgQi6Sj50RsJXrPsus9D3JybO/4PXUfwAXu1D6//tDb1QLTWaiSfDD5eDt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707188849; c=relaxed/simple;
	bh=/KHT0vSbQ6eWgbft4Eh6udSeZI10al30HD4o4tBq0U8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VLE5z36TiLRRPMiZgy/Wfn2JtKaLM67Bwlpq7q08GomQvScUo4E91xTyN3ei/gb/gPtS7dPvZstMQl2EdRpVoOdvnkfPUvNs1xVzYIH8O3nMg8nNXBqffSkfLhfEKEJdm+Ip8YdzjT8xmTyu40GB9s0IpDU8ssXTNl8Kc6r4VWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 41637MMD03532498, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 41637MMD03532498
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 Feb 2024 11:07:22 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Tue, 6 Feb 2024 11:07:22 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 6 Feb
 2024 11:07:21 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 4/6] wifi: rtw89: chan: tweak weight recalc ahead before MLO
Date: Tue, 6 Feb 2024 11:06:22 +0800
Message-ID: <20240206030624.23382-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240206030624.23382-1-pkshih@realtek.com>
References: <20240206030624.23382-1-pkshih@realtek.com>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Originally, we consider weight only based on how many chanctxs that
mac80211 sets. However, we need to consider both active chanctxs and
active interfaces to distinguish MCC (multiple channel concurrent)
from impending MLO.

Although the logic of handling is extended, for now, behavior might
not be different under current condition.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/chan.c | 51 ++++++++++++++++++++---
 drivers/net/wireless/realtek/rtw89/chan.h |  5 +++
 drivers/net/wireless/realtek/rtw89/core.h |  6 ++-
 3 files changed, 56 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/chan.c b/drivers/net/wireless/realtek/rtw89/chan.c
index 6a666a92b59b..57fabc05dab9 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.c
+++ b/drivers/net/wireless/realtek/rtw89/chan.c
@@ -212,24 +212,51 @@ void rtw89_entity_init(struct rtw89_dev *rtwdev)
 	rtw89_config_default_chandef(rtwdev);
 }
 
+static void rtw89_entity_calculate_weight(struct rtw89_dev *rtwdev,
+					  struct rtw89_entity_weight *w)
+{
+	struct rtw89_hal *hal = &rtwdev->hal;
+	const struct rtw89_chanctx_cfg *cfg;
+	struct rtw89_vif *rtwvif;
+	int idx;
+
+	for_each_set_bit(idx, hal->entity_map, NUM_OF_RTW89_SUB_ENTITY) {
+		cfg = hal->sub[idx].cfg;
+		if (!cfg) {
+			/* doesn't run with chanctx ops; one channel at most */
+			w->active_chanctxs = 1;
+			break;
+		}
+
+		if (cfg->ref_count > 0)
+			w->active_chanctxs++;
+	}
+
+	rtw89_for_each_rtwvif(rtwdev, rtwvif) {
+		if (rtwvif->chanctx_assigned)
+			w->active_roles++;
+	}
+}
+
 enum rtw89_entity_mode rtw89_entity_recalc(struct rtw89_dev *rtwdev)
 {
 	DECLARE_BITMAP(recalc_map, NUM_OF_RTW89_SUB_ENTITY) = {};
 	struct rtw89_hal *hal = &rtwdev->hal;
 	const struct cfg80211_chan_def *chandef;
+	struct rtw89_entity_weight w = {};
 	enum rtw89_entity_mode mode;
 	struct rtw89_chan chan;
-	u8 weight;
 	u8 idx;
 
 	lockdep_assert_held(&rtwdev->mutex);
 
 	bitmap_copy(recalc_map, hal->entity_map, NUM_OF_RTW89_SUB_ENTITY);
 
-	weight = bitmap_weight(hal->entity_map, NUM_OF_RTW89_SUB_ENTITY);
-	switch (weight) {
+	rtw89_entity_calculate_weight(rtwdev, &w);
+	switch (w.active_chanctxs) {
 	default:
-		rtw89_warn(rtwdev, "unknown ent chan weight: %d\n", weight);
+		rtw89_warn(rtwdev, "unknown ent chanctxs weight: %d\n",
+			   w.active_chanctxs);
 		bitmap_zero(recalc_map, NUM_OF_RTW89_SUB_ENTITY);
 		fallthrough;
 	case 0:
@@ -239,7 +266,14 @@ enum rtw89_entity_mode rtw89_entity_recalc(struct rtw89_dev *rtwdev)
 	case 1:
 		mode = RTW89_ENTITY_MODE_SCC;
 		break;
-	case 2:
+	case 2 ... NUM_OF_RTW89_SUB_ENTITY:
+		if (w.active_roles != NUM_OF_RTW89_MCC_ROLES) {
+			rtw89_debug(rtwdev, RTW89_DBG_CHAN,
+				    "unhandled ent: %d chanctxs %d roles\n",
+				    w.active_chanctxs, w.active_roles);
+			return RTW89_ENTITY_MODE_UNHANDLED;
+		}
+
 		mode = rtw89_get_entity_mode(rtwdev);
 		if (mode == RTW89_ENTITY_MODE_MCC)
 			break;
@@ -582,6 +616,9 @@ static int rtw89_mcc_fill_all_roles(struct rtw89_dev *rtwdev)
 	int ret;
 
 	rtw89_for_each_rtwvif(rtwdev, rtwvif) {
+		if (!rtwvif->chanctx_assigned)
+			continue;
+
 		if (sel.bind_vif[rtwvif->sub_entity_idx]) {
 			rtw89_warn(rtwdev,
 				   "MCC skip extra vif <macid %d> on chanctx[%d]\n",
@@ -2007,6 +2044,7 @@ int rtw89_chanctx_ops_assign_vif(struct rtw89_dev *rtwdev,
 
 	rtwvif->sub_entity_idx = cfg->idx;
 	rtwvif->chanctx_assigned = true;
+	cfg->ref_count++;
 	return 0;
 }
 
@@ -2014,6 +2052,9 @@ void rtw89_chanctx_ops_unassign_vif(struct rtw89_dev *rtwdev,
 				    struct rtw89_vif *rtwvif,
 				    struct ieee80211_chanctx_conf *ctx)
 {
+	struct rtw89_chanctx_cfg *cfg = (struct rtw89_chanctx_cfg *)ctx->drv_priv;
+
 	rtwvif->sub_entity_idx = RTW89_SUB_ENTITY_0;
 	rtwvif->chanctx_assigned = false;
+	cfg->ref_count--;
 }
diff --git a/drivers/net/wireless/realtek/rtw89/chan.h b/drivers/net/wireless/realtek/rtw89/chan.h
index 9b98d8f4ee9d..ffa412f281f3 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.h
+++ b/drivers/net/wireless/realtek/rtw89/chan.h
@@ -38,6 +38,11 @@ enum rtw89_chanctx_pause_reasons {
 	RTW89_CHANCTX_PAUSE_REASON_ROC,
 };
 
+struct rtw89_entity_weight {
+	unsigned int active_chanctxs;
+	unsigned int active_roles;
+};
+
 static inline bool rtw89_get_entity_state(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_hal *hal = &rtwdev->hal;
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 927356861cb8..ba2b298c4a9b 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4119,6 +4119,7 @@ struct rtw89_tas_info {
 
 struct rtw89_chanctx_cfg {
 	enum rtw89_sub_entity_idx idx;
+	int ref_count;
 };
 
 enum rtw89_chanctx_changes {
@@ -4138,13 +4139,16 @@ enum rtw89_entity_mode {
 	RTW89_ENTITY_MODE_MCC,
 
 	NUM_OF_RTW89_ENTITY_MODE,
-	RTW89_ENTITY_MODE_INVALID = NUM_OF_RTW89_ENTITY_MODE,
+	RTW89_ENTITY_MODE_INVALID = -EINVAL,
+	RTW89_ENTITY_MODE_UNHANDLED = -ESRCH,
 };
 
 struct rtw89_sub_entity {
 	struct cfg80211_chan_def chandef;
 	struct rtw89_chan chan;
 	struct rtw89_chan_rcd rcd;
+
+	/* only assigned when running with chanctx_ops */
 	struct rtw89_chanctx_cfg *cfg;
 };
 
-- 
2.25.1


