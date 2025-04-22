Return-Path: <linux-wireless+bounces-21815-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D662A95AAC
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Apr 2025 03:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E4143A1163
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Apr 2025 01:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC95194C96;
	Tue, 22 Apr 2025 01:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="gDoy/NJg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0A319CCEC
	for <linux-wireless@vger.kernel.org>; Tue, 22 Apr 2025 01:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745286451; cv=none; b=i8qiqGvNVnee3IxWR2xq01N7Ln5mheWlkJD0ftLkuU1Q8Cl/Ct1Jl9H0+VfTReMpvhnXZGvJgiDgDJUPuJ1ShHJ5J97BIsD7jCFjuFNUeMbiNFTbmjhL3ovbxbRTZcnEn8W8w86Pn07aHaUiIofn/s9Gq3lLd9xKT0DcnEsw0ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745286451; c=relaxed/simple;
	bh=+OmLA/+HXfYRHm77vW5sb3UXy10aUSeh81hFa1kK9AA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pot3xU9/8kJ+Py5SDU8XrqS6mE8mikYFF3tL/HWPDtpFh8EHP8cqlYkARDAm7IROiayyJhFxxU25qp9kZHfnH1c8p3NO3aAvF2pNEr1n/t91nk43J4dx10bocbzu2vePOJPWdo8ewS4iktPHyNQa72J0ASISUlIXbET1017TXF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=gDoy/NJg; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 53M1lR0d93859584, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1745286448; bh=+OmLA/+HXfYRHm77vW5sb3UXy10aUSeh81hFa1kK9AA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=gDoy/NJgbZ0SHVcqEGXzfF1GNzjELKUH10I5+IE0TBqyWWchW9N3B/i6LgMtbc2I/
	 ehYklYic3m9pToAdqqEw9dBpNO1JJe8jgqd8ke97Uc8yNMYmbyLEtVx/gZ0fODtmvz
	 +M+pzCHKnWoREb0PQ9CQguTVH9ulIO80iNzxhbCu46Gj693OmQEvSRx42ycvpopxak
	 1eiriMGp9MB1n1lRT5J1immZs4QrxB3XqvY3STTAaA6nFsRBFojhfK+LVsNl29jJP9
	 7OA/I4hLNeTV2EwIeF36ZanGpa9u4MqSIylBTP8aVLDROr1m1gs6i6WbrIPrgxaAJ5
	 RnxZqXq2dlVDg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 53M1lR0d93859584
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 22 Apr 2025 09:47:27 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 22 Apr 2025 09:47:27 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 22 Apr
 2025 09:47:27 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <damon.chen@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 10/12] wifi: rtw89: mcc: support courtesy mechanism on both roles at the same time
Date: Tue, 22 Apr 2025 09:46:18 +0800
Message-ID: <20250422014620.18421-11-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250422014620.18421-1-pkshih@realtek.com>
References: <20250422014620.18421-1-pkshih@realtek.com>
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

From: Zong-Zhe Yang <kevin_yang@realtek.com>

MCC has a courtesy mechanism which allows one role to use another's
duration in a given cycle. Originally, this courtesy mechanism only
supports in one direction. However, in some field cases, both of MCC
roles may simultaneously have timing configurations that are not good
enough. So, support courtesy mechanism in both directions.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/chan.c | 82 ++++++++++++-----------
 drivers/net/wireless/realtek/rtw89/chan.h |  8 +++
 drivers/net/wireless/realtek/rtw89/core.h | 11 ++-
 3 files changed, 58 insertions(+), 43 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/chan.c b/drivers/net/wireless/realtek/rtw89/chan.c
index ac88f51c679b..faa9fbe9d259 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.c
+++ b/drivers/net/wireless/realtek/rtw89/chan.c
@@ -942,37 +942,44 @@ static void rtw89_mcc_assign_pattern(struct rtw89_dev *rtwdev,
 	struct rtw89_mcc_role *aux = &mcc->role_aux;
 	struct rtw89_mcc_config *config = &mcc->config;
 	struct rtw89_mcc_pattern *pattern = &config->pattern;
+	struct rtw89_mcc_courtesy_cfg *crtz;
 
 	rtw89_debug(rtwdev, RTW89_DBG_CHAN,
 		    "MCC assign pattern: ref {%d | %d}, aux {%d | %d}\n",
 		    new->tob_ref, new->toa_ref, new->tob_aux, new->toa_aux);
 
+	rtw89_debug(rtwdev, RTW89_DBG_CHAN, "MCC pattern plan: %d\n", new->plan);
+
 	*pattern = *new;
 	memset(&pattern->courtesy, 0, sizeof(pattern->courtesy));
 
-	if (pattern->tob_aux <= 0 || pattern->toa_aux <= 0) {
-		pattern->courtesy.macid_tgt = aux->rtwvif_link->mac_id;
-		pattern->courtesy.macid_src = ref->rtwvif_link->mac_id;
-		pattern->courtesy.slot_num = RTW89_MCC_DFLT_COURTESY_SLOT;
-		pattern->courtesy.enable = true;
-	} else if (pattern->tob_ref <= 0 || pattern->toa_ref <= 0) {
-		pattern->courtesy.macid_tgt = ref->rtwvif_link->mac_id;
-		pattern->courtesy.macid_src = aux->rtwvif_link->mac_id;
-		pattern->courtesy.slot_num = RTW89_MCC_DFLT_COURTESY_SLOT;
-		pattern->courtesy.enable = true;
+	if (RTW89_MCC_REQ_COURTESY(pattern, aux)) {
+		crtz = &pattern->courtesy.ref;
+		ref->crtz = crtz;
+
+		crtz->macid_tgt = aux->rtwvif_link->mac_id;
+		crtz->slot_num = RTW89_MCC_DFLT_COURTESY_SLOT;
+
+		rtw89_debug(rtwdev, RTW89_DBG_CHAN,
+			    "MCC courtesy ref: tgt %d, slot %d\n",
+			    crtz->macid_tgt, crtz->slot_num);
+	} else {
+		ref->crtz = NULL;
 	}
 
-	rtw89_debug(rtwdev, RTW89_DBG_CHAN,
-		    "MCC pattern flags: plan %d, courtesy_en %d\n",
-		    pattern->plan, pattern->courtesy.enable);
+	if (RTW89_MCC_REQ_COURTESY(pattern, ref)) {
+		crtz = &pattern->courtesy.aux;
+		aux->crtz = crtz;
 
-	if (!pattern->courtesy.enable)
-		return;
+		crtz->macid_tgt = ref->rtwvif_link->mac_id;
+		crtz->slot_num = RTW89_MCC_DFLT_COURTESY_SLOT;
 
-	rtw89_debug(rtwdev, RTW89_DBG_CHAN,
-		    "MCC pattern courtesy: tgt %d, src %d, slot %d\n",
-		    pattern->courtesy.macid_tgt, pattern->courtesy.macid_src,
-		    pattern->courtesy.slot_num);
+		rtw89_debug(rtwdev, RTW89_DBG_CHAN,
+			    "MCC courtesy aux: tgt %d, slot %d\n",
+			    crtz->macid_tgt, crtz->slot_num);
+	} else {
+		aux->crtz = NULL;
+	}
 }
 
 /* The follow-up roughly shows the relationship between the parameters
@@ -1528,10 +1535,8 @@ static int rtw89_mcc_fill_config(struct rtw89_dev *rtwdev)
 
 static int __mcc_fw_add_role(struct rtw89_dev *rtwdev, struct rtw89_mcc_role *role)
 {
+	const struct rtw89_mcc_courtesy_cfg *crtz = role->crtz;
 	struct rtw89_mcc_info *mcc = &rtwdev->mcc;
-	struct rtw89_mcc_config *config = &mcc->config;
-	struct rtw89_mcc_pattern *pattern = &config->pattern;
-	struct rtw89_mcc_courtesy *courtesy = &pattern->courtesy;
 	struct rtw89_mcc_policy *policy = &role->policy;
 	struct rtw89_fw_mcc_add_req req = {};
 	const struct rtw89_chan *chan;
@@ -1554,9 +1559,9 @@ static int __mcc_fw_add_role(struct rtw89_dev *rtwdev, struct rtw89_mcc_role *ro
 	req.duration = role->duration;
 	req.btc_in_2g = false;
 
-	if (courtesy->enable && courtesy->macid_src == req.macid) {
-		req.courtesy_target = courtesy->macid_tgt;
-		req.courtesy_num = courtesy->slot_num;
+	if (crtz) {
+		req.courtesy_target = crtz->macid_tgt;
+		req.courtesy_num = crtz->slot_num;
 		req.courtesy_en = true;
 	}
 
@@ -1736,26 +1741,23 @@ static void __mrc_fw_add_courtesy(struct rtw89_dev *rtwdev,
 	struct rtw89_mcc_info *mcc = &rtwdev->mcc;
 	struct rtw89_mcc_role *ref = &mcc->role_ref;
 	struct rtw89_mcc_role *aux = &mcc->role_aux;
-	struct rtw89_mcc_config *config = &mcc->config;
-	struct rtw89_mcc_pattern *pattern = &config->pattern;
-	struct rtw89_mcc_courtesy *courtesy = &pattern->courtesy;
 	struct rtw89_fw_mrc_add_slot_arg *slot_arg_src;
-	u8 slot_idx_tgt;
 
-	if (!courtesy->enable)
-		return;
-
-	if (courtesy->macid_src == ref->rtwvif_link->mac_id) {
+	if (ref->crtz) {
 		slot_arg_src = &arg->slots[ref->slot_idx];
-		slot_idx_tgt = aux->slot_idx;
-	} else {
-		slot_arg_src = &arg->slots[aux->slot_idx];
-		slot_idx_tgt = ref->slot_idx;
+
+		slot_arg_src->courtesy_target = aux->slot_idx;
+		slot_arg_src->courtesy_period = ref->crtz->slot_num;
+		slot_arg_src->courtesy_en = true;
 	}
 
-	slot_arg_src->courtesy_target = slot_idx_tgt;
-	slot_arg_src->courtesy_period = courtesy->slot_num;
-	slot_arg_src->courtesy_en = true;
+	if (aux->crtz) {
+		slot_arg_src = &arg->slots[aux->slot_idx];
+
+		slot_arg_src->courtesy_target = ref->slot_idx;
+		slot_arg_src->courtesy_period = aux->crtz->slot_num;
+		slot_arg_src->courtesy_en = true;
+	}
 }
 
 static int __mrc_fw_start(struct rtw89_dev *rtwdev, bool replace)
diff --git a/drivers/net/wireless/realtek/rtw89/chan.h b/drivers/net/wireless/realtek/rtw89/chan.h
index e6391f6f2aa7..1bcb87a8f9ee 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.h
+++ b/drivers/net/wireless/realtek/rtw89/chan.h
@@ -31,6 +31,14 @@
 #define RTW89_MCC_DFLT_TX_NULL_EARLY 3
 #define RTW89_MCC_DFLT_COURTESY_SLOT 3
 
+#define RTW89_MCC_REQ_COURTESY_TIME 5
+#define RTW89_MCC_REQ_COURTESY(pattern, role)			\
+({								\
+	const struct rtw89_mcc_pattern *p = pattern;		\
+	p->tob_ ## role <= RTW89_MCC_REQ_COURTESY_TIME ||	\
+	p->toa_ ## role <= RTW89_MCC_REQ_COURTESY_TIME;		\
+})
+
 #define NUM_OF_RTW89_MCC_ROLES 2
 
 enum rtw89_chanctx_pause_reasons {
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 5b77db6fd578..61c32da7354b 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -5638,6 +5638,8 @@ struct rtw89_mcc_role {
 	struct rtw89_mcc_policy policy;
 	struct rtw89_mcc_limit limit;
 
+	const struct rtw89_mcc_courtesy_cfg *crtz;
+
 	/* only valid when running with FW MRC mechanism */
 	u8 slot_idx;
 
@@ -5655,13 +5657,16 @@ struct rtw89_mcc_bt_role {
 	u16 duration; /* TU */
 };
 
-struct rtw89_mcc_courtesy {
-	bool enable;
+struct rtw89_mcc_courtesy_cfg {
 	u8 slot_num;
-	u8 macid_src;
 	u8 macid_tgt;
 };
 
+struct rtw89_mcc_courtesy {
+	struct rtw89_mcc_courtesy_cfg ref;
+	struct rtw89_mcc_courtesy_cfg aux;
+};
+
 enum rtw89_mcc_plan {
 	RTW89_MCC_PLAN_TAIL_BT,
 	RTW89_MCC_PLAN_MID_BT,
-- 
2.25.1


