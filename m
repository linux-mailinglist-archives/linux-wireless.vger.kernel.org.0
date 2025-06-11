Return-Path: <linux-wireless+bounces-23974-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F72AD49C9
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 05:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E203B17A108
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 03:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A68EAF9;
	Wed, 11 Jun 2025 03:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="HmrnoGrR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985A815574E
	for <linux-wireless@vger.kernel.org>; Wed, 11 Jun 2025 03:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749614159; cv=none; b=VxTTcxY2ZPNNKu8HxTWp0Pb7tssqiteoYuwIsth3BT0q/bVyxHZWkTJKaqIDwMmSy/uodGZM8BjA4/cD5GT6z9gAguIxH+X2Q6QiDayHNbRY0Ccfy4MvfaeEJoybp08BBzceamcN5Owa59U1i+ixTB8kl/Iwth9Ve44y1P45p3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749614159; c=relaxed/simple;
	bh=nA8ti+iodTj6qN6HD4oiQbMopP7dxs69NNf0Bjpb8HM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SNiZzQBxO1/g0j/R7oUOqe1XIoOWUXWmbOKQ5AjOXNZtHMJ7ixGbnIW6jyi5oZPhSFztc1vVjh5BYVcwNIaS+CremH5/M6wfP0IF3BB7bfrpK8jcesRMx+K4GYn1JrwhPkyMMGjedHpy/gLO9yzzQdO9yuA5lk+vdTe0O7ibEU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=HmrnoGrR; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55B3tsaB74132054, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1749614154; bh=SmjunfP3whMWCaRjRInZrIWA89B/Ye4Jx+T1XWw8Qlg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=HmrnoGrRPnVa9mY/Jg+rc19ax1Sc5RmhWp7V9O/5/JnmSRsiflcrmjfp+rJJA1M3N
	 MBw4Ja6VNHpdHEQritWHVNjCgT6oMwOn7NyjSVFBIKinjO4FqpM3EBIRyTOukONqWN
	 V+fAbzsacSWycrLS11MpVXCaV92IR5I0lpgQhD+7SZrd3eD4fsskYjpLiKEb/KWN+K
	 FQwgobgCmEbo4MZNBBnhgl7avvSCwEduG8Po3hKjPGly+pRwkSh5JoVnP4S4o+eYPg
	 bpzOjKSNRu220lkdw737sjM/TE9n5czIn/S9GQkZbELHQaNDuOurLsVkSBKyYaKtpR
	 D7KclIAw3qhow==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55B3tsaB74132054
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 11 Jun 2025 11:55:54 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 11 Jun 2025 11:55:54 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 11 Jun
 2025 11:55:53 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next v2 01/10] wifi: rtw89: introduce rtw89_query_mr_chanctx_info() for multi-role chanctx info
Date: Wed, 11 Jun 2025 11:55:14 +0800
Message-ID: <20250611035523.36432-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250611035523.36432-1-pkshih@realtek.com>
References: <20250611035523.36432-1-pkshih@realtek.com>
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

Add Wi-Fi 7 MLO related multi-role (MR) chanctx descriptors and query
function. They are designed for other components, e.g. coex, which are
interested in the following info.
 * whether a MLD exists and how many active link
 * the number of AP mode and station mode respectively
 * how many chanctx and the number of 2/5/6 GHz respectively

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/chan.c | 195 ++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/chan.h |  45 +++++
 2 files changed, 240 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/chan.c b/drivers/net/wireless/realtek/rtw89/chan.c
index b2bc650a911b..686f09b80b2b 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.c
+++ b/drivers/net/wireless/realtek/rtw89/chan.c
@@ -2626,6 +2626,201 @@ void rtw89_queue_chanctx_work(struct rtw89_dev *rtwdev)
 	rtw89_queue_chanctx_change(rtwdev, RTW89_CHANCTX_CHANGE_DFLT);
 }
 
+static enum rtw89_mr_wtype __rtw89_query_mr_wtype(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_entity_mgnt *mgnt = &rtwdev->hal.entity_mgnt;
+	enum rtw89_chanctx_idx chanctx_idx;
+	struct ieee80211_vif *vif;
+	struct rtw89_vif *rtwvif;
+	unsigned int num_mld = 0;
+	unsigned int num_ml = 0;
+	unsigned int cnt = 0;
+	u8 role_idx;
+	u8 idx;
+
+	for (role_idx = 0; role_idx < RTW89_MAX_INTERFACE_NUM; role_idx++) {
+		rtwvif = mgnt->active_roles[role_idx];
+		if (!rtwvif)
+			continue;
+
+		cnt++;
+
+		vif = rtwvif_to_vif(rtwvif);
+		if (!ieee80211_vif_is_mld(vif))
+			continue;
+
+		num_mld++;
+
+		for (idx = 0; idx < __RTW89_MLD_MAX_LINK_NUM; idx++) {
+			chanctx_idx = mgnt->chanctx_tbl[role_idx][idx];
+			if (chanctx_idx != RTW89_CHANCTX_IDLE)
+				num_ml++;
+		}
+	}
+
+	if (num_mld > 1)
+		goto err;
+
+	switch (cnt) {
+	case 0:
+		return RTW89_MR_WTYPE_NONE;
+	case 1:
+		if (!num_mld)
+			return RTW89_MR_WTYPE_NONMLD;
+		switch (num_ml) {
+		case 1:
+			return RTW89_MR_WTYPE_MLD1L1R;
+		case 2:
+			return RTW89_MR_WTYPE_MLD2L1R;
+		default:
+			break;
+		}
+		break;
+	case 2:
+		if (!num_mld)
+			return RTW89_MR_WTYPE_NONMLD_NONMLD;
+		switch (num_ml) {
+		case 1:
+			return RTW89_MR_WTYPE_MLD1L1R_NONMLD;
+		case 2:
+			return RTW89_MR_WTYPE_MLD2L1R_NONMLD;
+		default:
+			break;
+		}
+		break;
+	default:
+		break;
+	}
+
+err:
+	rtw89_warn(rtwdev, "%s: unhandled cnt %u mld %u ml %u\n", __func__,
+		   cnt, num_mld, num_ml);
+	return RTW89_MR_WTYPE_UNKNOWN;
+}
+
+static enum rtw89_mr_wmode __rtw89_query_mr_wmode(struct rtw89_dev *rtwdev,
+						  u8 inst_idx)
+{
+	struct rtw89_entity_mgnt *mgnt = &rtwdev->hal.entity_mgnt;
+	unsigned int num[NUM_NL80211_IFTYPES] = {};
+	enum rtw89_chanctx_idx chanctx_idx;
+	struct ieee80211_vif *vif;
+	struct rtw89_vif *rtwvif;
+	unsigned int cnt = 0;
+	u8 role_idx;
+
+	if (unlikely(inst_idx >= __RTW89_MLD_MAX_LINK_NUM))
+		return RTW89_MR_WMODE_UNKNOWN;
+
+	for (role_idx = 0; role_idx < RTW89_MAX_INTERFACE_NUM; role_idx++) {
+		chanctx_idx = mgnt->chanctx_tbl[role_idx][inst_idx];
+		if (chanctx_idx == RTW89_CHANCTX_IDLE)
+			continue;
+
+		rtwvif = mgnt->active_roles[role_idx];
+		if (unlikely(!rtwvif))
+			continue;
+
+		vif = rtwvif_to_vif(rtwvif);
+		num[vif->type]++;
+		cnt++;
+	}
+
+	switch (cnt) {
+	case 0:
+		return RTW89_MR_WMODE_NONE;
+	case 1:
+		if (num[NL80211_IFTYPE_STATION])
+			return RTW89_MR_WMODE_1CLIENT;
+		if (num[NL80211_IFTYPE_AP])
+			return RTW89_MR_WMODE_1AP;
+		break;
+	case 2:
+		if (num[NL80211_IFTYPE_STATION] == 2)
+			return RTW89_MR_WMODE_2CLIENTS;
+		if (num[NL80211_IFTYPE_AP] == 2)
+			return RTW89_MR_WMODE_2APS;
+		if (num[NL80211_IFTYPE_STATION] && num[NL80211_IFTYPE_AP])
+			return RTW89_MR_WMODE_1AP_1CLIENT;
+		break;
+	default:
+		break;
+	}
+
+	rtw89_warn(rtwdev, "%s: unhandled cnt %u\n", __func__, cnt);
+	return RTW89_MR_WMODE_UNKNOWN;
+}
+
+static enum rtw89_mr_ctxtype __rtw89_query_mr_ctxtype(struct rtw89_dev *rtwdev,
+						      u8 inst_idx)
+{
+	struct rtw89_entity_mgnt *mgnt = &rtwdev->hal.entity_mgnt;
+	DECLARE_BITMAP(map, NUM_OF_RTW89_CHANCTX) = {};
+	unsigned int num[RTW89_BAND_NUM] = {};
+	enum rtw89_chanctx_idx chanctx_idx;
+	const struct rtw89_chan *chan;
+	unsigned int cnt = 0;
+	u8 role_idx;
+
+	if (unlikely(inst_idx >= __RTW89_MLD_MAX_LINK_NUM))
+		return RTW89_MR_CTX_UNKNOWN;
+
+	for (role_idx = 0; role_idx < RTW89_MAX_INTERFACE_NUM; role_idx++) {
+		chanctx_idx = mgnt->chanctx_tbl[role_idx][inst_idx];
+		if (chanctx_idx == RTW89_CHANCTX_IDLE)
+			continue;
+
+		if (__test_and_set_bit(chanctx_idx, map))
+			continue;
+
+		chan = rtw89_chan_get(rtwdev, chanctx_idx);
+		num[chan->band_type]++;
+		cnt++;
+	}
+
+	switch (cnt) {
+	case 0:
+		return RTW89_MR_CTX_NONE;
+	case 1:
+		if (num[RTW89_BAND_2G])
+			return RTW89_MR_CTX1_2GHZ;
+		if (num[RTW89_BAND_5G])
+			return RTW89_MR_CTX1_5GHZ;
+		if (num[RTW89_BAND_6G])
+			return RTW89_MR_CTX1_6GHZ;
+		break;
+	case 2:
+		if (num[RTW89_BAND_2G] == 2)
+			return RTW89_MR_CTX2_2GHZ;
+		if (num[RTW89_BAND_5G] == 2)
+			return RTW89_MR_CTX2_5GHZ;
+		if (num[RTW89_BAND_6G] == 2)
+			return RTW89_MR_CTX2_6GHZ;
+		if (num[RTW89_BAND_2G] && num[RTW89_BAND_5G])
+			return RTW89_MR_CTX2_2GHZ_5GHZ;
+		if (num[RTW89_BAND_2G] && num[RTW89_BAND_6G])
+			return RTW89_MR_CTX2_2GHZ_6GHZ;
+		if (num[RTW89_BAND_5G] && num[RTW89_BAND_6G])
+			return RTW89_MR_CTX2_5GHZ_6GHZ;
+		break;
+	default:
+		break;
+	}
+
+	rtw89_warn(rtwdev, "%s: unhandled cnt %u\n", __func__, cnt);
+	return RTW89_MR_CTX_UNKNOWN;
+}
+
+void rtw89_query_mr_chanctx_info(struct rtw89_dev *rtwdev, u8 inst_idx,
+				 struct rtw89_mr_chanctx_info *info)
+{
+	lockdep_assert_wiphy(rtwdev->hw->wiphy);
+
+	info->wtype = __rtw89_query_mr_wtype(rtwdev);
+	info->wmode = __rtw89_query_mr_wmode(rtwdev, inst_idx);
+	info->ctxtype = __rtw89_query_mr_ctxtype(rtwdev, inst_idx);
+}
+
 void rtw89_chanctx_track(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_hal *hal = &rtwdev->hal;
diff --git a/drivers/net/wireless/realtek/rtw89/chan.h b/drivers/net/wireless/realtek/rtw89/chan.h
index 9c5e61ccab88..83f4a73e0d8c 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.h
+++ b/drivers/net/wireless/realtek/rtw89/chan.h
@@ -41,6 +41,49 @@
 
 #define NUM_OF_RTW89_MCC_ROLES 2
 
+enum rtw89_mr_wtype {
+	RTW89_MR_WTYPE_NONE,
+	RTW89_MR_WTYPE_NONMLD,
+	RTW89_MR_WTYPE_MLD1L1R,
+	RTW89_MR_WTYPE_MLD2L1R,
+	RTW89_MR_WTYPE_MLD2L2R,
+	RTW89_MR_WTYPE_NONMLD_NONMLD,
+	RTW89_MR_WTYPE_MLD1L1R_NONMLD,
+	RTW89_MR_WTYPE_MLD2L1R_NONMLD,
+	RTW89_MR_WTYPE_MLD2L2R_NONMLD,
+	RTW89_MR_WTYPE_UNKNOWN,
+};
+
+enum rtw89_mr_wmode {
+	RTW89_MR_WMODE_NONE,
+	RTW89_MR_WMODE_1CLIENT,
+	RTW89_MR_WMODE_1AP,
+	RTW89_MR_WMODE_1AP_1CLIENT,
+	RTW89_MR_WMODE_2CLIENTS,
+	RTW89_MR_WMODE_2APS,
+	RTW89_MR_WMODE_UNKNOWN,
+};
+
+enum rtw89_mr_ctxtype {
+	RTW89_MR_CTX_NONE,
+	RTW89_MR_CTX1_2GHZ,
+	RTW89_MR_CTX1_5GHZ,
+	RTW89_MR_CTX1_6GHZ,
+	RTW89_MR_CTX2_2GHZ,
+	RTW89_MR_CTX2_5GHZ,
+	RTW89_MR_CTX2_6GHZ,
+	RTW89_MR_CTX2_2GHZ_5GHZ,
+	RTW89_MR_CTX2_2GHZ_6GHZ,
+	RTW89_MR_CTX2_5GHZ_6GHZ,
+	RTW89_MR_CTX_UNKNOWN,
+};
+
+struct rtw89_mr_chanctx_info {
+	enum rtw89_mr_wtype wtype;
+	enum rtw89_mr_wmode wmode;
+	enum rtw89_mr_ctxtype ctxtype;
+};
+
 enum rtw89_chanctx_pause_reasons {
 	RTW89_CHANCTX_PAUSE_REASON_HW_SCAN,
 	RTW89_CHANCTX_PAUSE_REASON_ROC,
@@ -117,6 +160,8 @@ void rtw89_chanctx_work(struct wiphy *wiphy, struct wiphy_work *work);
 void rtw89_queue_chanctx_work(struct rtw89_dev *rtwdev);
 void rtw89_queue_chanctx_change(struct rtw89_dev *rtwdev,
 				enum rtw89_chanctx_changes change);
+void rtw89_query_mr_chanctx_info(struct rtw89_dev *rtwdev, u8 inst_idx,
+				 struct rtw89_mr_chanctx_info *info);
 void rtw89_chanctx_track(struct rtw89_dev *rtwdev);
 void rtw89_chanctx_pause(struct rtw89_dev *rtwdev,
 			 const struct rtw89_chanctx_pause_parm *parm);
-- 
2.25.1


