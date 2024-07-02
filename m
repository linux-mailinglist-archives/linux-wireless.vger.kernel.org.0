Return-Path: <linux-wireless+bounces-9851-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 653F0923E19
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 14:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8992F1C21AA2
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 12:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE78158DC8;
	Tue,  2 Jul 2024 12:45:26 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E8616D327
	for <linux-wireless@vger.kernel.org>; Tue,  2 Jul 2024 12:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719924326; cv=none; b=lKlCJ3suUoWJwrJSaj1D/jeiCgYDoHYzA2fckoQps5DIEbgiIcLcjFSMLK4UwNp5hDNFCGzVX5ue9sfQI6gFMEpbrwvH1fYKacqFE8j8xdUyyP4HZ+jXDSl9gjyDQgRHSGGVPfDmoRIU4J3LgoxKZqls7W8XitBO/NLnuXiQu6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719924326; c=relaxed/simple;
	bh=boNy//8RwBveWxljrP1UcGwLmwmXqirY2ByjbfDv13Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZtcJV8Q1E16ojZZkuPXRVwUkyfEVynV1OhmhA/SK4jVZJLjump8T3aktpVkTzPQueuoRzyXp1dAHjxRYh8PbSXcL9vWorkS2YptN5CBSIRQXIUy6YmPs+rNzDjebh1ncM9xpjW4InLMbHbMJAfu3ZeNdfq9GI12OyXqu4DFE4LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 462CjLtxD923963, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 462CjLtxD923963
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 2 Jul 2024 20:45:21 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 2 Jul 2024 20:45:21 +0800
Received: from [127.0.1.1] (172.16.17.57) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 2 Jul
 2024 20:45:19 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH v2 2/2] wifi: rtw89: unify the selection logic of RFK table when MCC
Date: Tue, 2 Jul 2024 20:44:52 +0800
Message-ID: <20240702124452.18747-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240702124452.18747-1-pkshih@realtek.com>
References: <20240702124452.18747-1-pkshih@realtek.com>
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

Driver will notify FW the target index of RFK table to use at some
moments. When MCC (multi-channel concurrent), the correctness of the
notification is especially important.

We now unify the selection logic of RFK table as below among chips.
1. check each table if it matches target channel
2. check all tables if any is idle by iterating active channels
3. replace the first table if all are busy unexpectedly

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2: correct precedence of selection logic of RFK MCC table slots
    - frist, search for exactly matched slot
    - if not, search for an idle slot
    - if not, force to use first slot
---
 drivers/net/wireless/realtek/rtw89/chan.c     | 22 ++++++
 drivers/net/wireless/realtek/rtw89/chan.h     |  4 ++
 drivers/net/wireless/realtek/rtw89/core.h     |  7 +-
 drivers/net/wireless/realtek/rtw89/phy.c      | 69 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/phy.h      | 16 +++++
 .../net/wireless/realtek/rtw89/rtw8852c_rfk.c | 32 +++------
 .../net/wireless/realtek/rtw89/rtw8922a_rfk.c | 17 ++++-
 7 files changed, 141 insertions(+), 26 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/chan.c b/drivers/net/wireless/realtek/rtw89/chan.c
index 3b1997223cc5..7f90d93dcdc0 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.c
+++ b/drivers/net/wireless/realtek/rtw89/chan.c
@@ -141,6 +141,28 @@ bool rtw89_assign_entity_chan(struct rtw89_dev *rtwdev,
 	return band_changed;
 }
 
+int rtw89_iterate_entity_chan(struct rtw89_dev *rtwdev,
+			      int (*iterator)(const struct rtw89_chan *chan,
+					      void *data),
+			      void *data)
+{
+	struct rtw89_hal *hal = &rtwdev->hal;
+	const struct rtw89_chan *chan;
+	int ret;
+	u8 idx;
+
+	lockdep_assert_held(&rtwdev->mutex);
+
+	for_each_set_bit(idx,  hal->entity_map, NUM_OF_RTW89_SUB_ENTITY) {
+		chan = rtw89_chan_get(rtwdev, idx);
+		ret = iterator(chan, data);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static void __rtw89_config_entity_chandef(struct rtw89_dev *rtwdev,
 					  enum rtw89_sub_entity_idx idx,
 					  const struct cfg80211_chan_def *chandef,
diff --git a/drivers/net/wireless/realtek/rtw89/chan.h b/drivers/net/wireless/realtek/rtw89/chan.h
index ffa412f281f3..5278ff8c513b 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.h
+++ b/drivers/net/wireless/realtek/rtw89/chan.h
@@ -78,6 +78,10 @@ void rtw89_chan_create(struct rtw89_chan *chan, u8 center_chan, u8 primary_chan,
 bool rtw89_assign_entity_chan(struct rtw89_dev *rtwdev,
 			      enum rtw89_sub_entity_idx idx,
 			      const struct rtw89_chan *new);
+int rtw89_iterate_entity_chan(struct rtw89_dev *rtwdev,
+			      int (*iterator)(const struct rtw89_chan *chan,
+					      void *data),
+			      void *data);
 void rtw89_config_entity_chandef(struct rtw89_dev *rtwdev,
 				 enum rtw89_sub_entity_idx idx,
 				 const struct cfg80211_chan_def *chandef);
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 001da3ad149e..11fa003a9788 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4695,7 +4695,12 @@ struct rtw89_dack_info {
 	bool msbk_timeout[RTW89_DACK_PATH_NR];
 };
 
-#define RTW89_RFK_CHS_NR 3
+enum rtw89_rfk_chs_nrs {
+	__RTW89_RFK_CHS_NR_V0 = 2,
+	__RTW89_RFK_CHS_NR_V1 = 3,
+
+	RTW89_RFK_CHS_NR = __RTW89_RFK_CHS_NR_V1,
+};
 
 struct rtw89_rfk_mcc_info {
 	u8 ch[RTW89_RFK_CHS_NR];
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index e025f0ed9f59..ad11d1414874 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -2,6 +2,7 @@
 /* Copyright(c) 2019-2020  Realtek Corporation
  */
 
+#include "chan.h"
 #include "coex.h"
 #include "debug.h"
 #include "fw.h"
@@ -6003,6 +6004,74 @@ void rtw89_phy_set_bss_color(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif
 			      vif->cfg.aid, phy_idx);
 }
 
+static bool rfk_chan_validate_desc(const struct rtw89_rfk_chan_desc *desc)
+{
+	return desc->ch != 0;
+}
+
+static bool rfk_chan_is_equivalent(const struct rtw89_rfk_chan_desc *desc,
+				   const struct rtw89_chan *chan)
+{
+	if (!rfk_chan_validate_desc(desc))
+		return false;
+
+	if (desc->ch != chan->channel)
+		return false;
+
+	if (desc->has_band && desc->band != chan->band_type)
+		return false;
+
+	if (desc->has_bw && desc->bw != chan->band_width)
+		return false;
+
+	return true;
+}
+
+struct rfk_chan_iter_data {
+	const struct rtw89_rfk_chan_desc desc;
+	unsigned int found;
+};
+
+static int rfk_chan_iter_search(const struct rtw89_chan *chan, void *data)
+{
+	struct rfk_chan_iter_data *iter_data = data;
+
+	if (rfk_chan_is_equivalent(&iter_data->desc, chan))
+		iter_data->found++;
+
+	return 0;
+}
+
+u8 rtw89_rfk_chan_lookup(struct rtw89_dev *rtwdev,
+			 const struct rtw89_rfk_chan_desc *desc, u8 desc_nr,
+			 const struct rtw89_chan *target_chan)
+{
+	int sel = -1;
+	u8 i;
+
+	for (i = 0; i < desc_nr; i++) {
+		struct rfk_chan_iter_data iter_data = {
+			.desc = desc[i],
+		};
+
+		if (rfk_chan_is_equivalent(&desc[i], target_chan))
+			return i;
+
+		rtw89_iterate_entity_chan(rtwdev, rfk_chan_iter_search, &iter_data);
+		if (!iter_data.found && sel == -1)
+			sel = i;
+	}
+
+	if (sel == -1) {
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "no idle rfk entry; force replace the first\n");
+		sel = 0;
+	}
+
+	return sel;
+}
+EXPORT_SYMBOL(rtw89_rfk_chan_lookup);
+
 static void
 _rfk_write_rf(struct rtw89_dev *rtwdev, const struct rtw89_reg5_def *def)
 {
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index 6e53ac9140fb..d8df553b9cb0 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -715,6 +715,19 @@ enum rtw89_phy_gain_band_be rtw89_subband_to_gain_band_be(enum rtw89_subband sub
 	}
 }
 
+struct rtw89_rfk_chan_desc {
+	/* desc is valid iff ch is non-zero */
+	u8 ch;
+
+	/* To avoid us from extending old chip code every time, each new
+	 * field must be defined along with a bool flag in positivte way.
+	 */
+	bool has_band;
+	u8 band;
+	bool has_bw;
+	u8 bw;
+};
+
 enum rtw89_rfk_flag {
 	RTW89_RFK_F_WRF = 0,
 	RTW89_RFK_F_WM = 1,
@@ -950,5 +963,8 @@ enum rtw89_rf_path_bit rtw89_phy_get_kpath(struct rtw89_dev *rtwdev,
 					   enum rtw89_phy_idx phy_idx);
 enum rtw89_rf_path rtw89_phy_get_syn_sel(struct rtw89_dev *rtwdev,
 					 enum rtw89_phy_idx phy_idx);
+u8 rtw89_rfk_chan_lookup(struct rtw89_dev *rtwdev,
+			 const struct rtw89_rfk_chan_desc *desc, u8 desc_nr,
+			 const struct rtw89_chan *target_chan);
 
 #endif
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
index 654e3e5507cb..743f7014bf3e 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
@@ -4070,12 +4070,11 @@ void rtw8852c_set_channel_rf(struct rtw89_dev *rtwdev,
 void rtw8852c_mcc_get_ch_info(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 {
 	struct rtw89_rfk_mcc_info *rfk_mcc = &rtwdev->rfk_mcc;
-	DECLARE_BITMAP(map, RTW89_IQK_CHS_NR) = {};
+	struct rtw89_rfk_chan_desc desc[__RTW89_RFK_CHS_NR_V0] = {};
 	const struct rtw89_chan *chan;
 	enum rtw89_entity_mode mode;
 	u8 chan_idx;
 	u8 idx;
-	u8 i;
 
 	mode = rtw89_get_entity_mode(rtwdev);
 	switch (mode) {
@@ -4087,34 +4086,21 @@ void rtw8852c_mcc_get_ch_info(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_i
 		break;
 	}
 
-	for (i = 0; i <= chan_idx; i++) {
-		chan = rtw89_chan_get(rtwdev, i);
+	chan = rtw89_chan_get(rtwdev, chan_idx);
 
-		for (idx = 0; idx < RTW89_IQK_CHS_NR; idx++) {
-			if (rfk_mcc->ch[idx] == chan->channel &&
-			    rfk_mcc->band[idx] == chan->band_type) {
-				if (i != chan_idx) {
-					set_bit(idx, map);
-					break;
-				}
+	for (idx = 0; idx < ARRAY_SIZE(desc); idx++) {
+		struct rtw89_rfk_chan_desc *p = &desc[idx];
 
-				goto bottom;
-			}
-		}
-	}
+		p->ch = rfk_mcc->ch[idx];
 
-	idx = find_first_zero_bit(map, RTW89_IQK_CHS_NR);
-	if (idx == RTW89_IQK_CHS_NR) {
-		rtw89_debug(rtwdev, RTW89_DBG_RFK,
-			    "%s: no empty rfk table; force replace the first\n",
-			    __func__);
-		idx = 0;
+		p->has_band = true;
+		p->band = rfk_mcc->band[idx];
 	}
 
+	idx = rtw89_rfk_chan_lookup(rtwdev, desc, ARRAY_SIZE(desc), chan);
+
 	rfk_mcc->ch[idx] = chan->channel;
 	rfk_mcc->band[idx] = chan->band_type;
-
-bottom:
 	rfk_mcc->table_idx = idx;
 }
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.c
index 2a371829268c..0ebcb06ae848 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.c
@@ -255,6 +255,7 @@ static void rtw8922a_chlk_ktbl_sel(struct rtw89_dev *rtwdev, u8 kpath, u8 idx)
 static void rtw8922a_chlk_reload(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_rfk_mcc_info *rfk_mcc = &rtwdev->rfk_mcc;
+	struct rtw89_rfk_chan_desc desc[__RTW89_RFK_CHS_NR_V1] = {};
 	enum rtw89_sub_entity_idx sub_entity_idx;
 	const struct rtw89_chan *chan;
 	enum rtw89_entity_mode mode;
@@ -265,16 +266,28 @@ static void rtw8922a_chlk_reload(struct rtw89_dev *rtwdev)
 	switch (mode) {
 	case RTW89_ENTITY_MODE_MCC_PREPARE:
 		sub_entity_idx = RTW89_SUB_ENTITY_1;
-		tbl_sel = 1;
 		break;
 	default:
 		sub_entity_idx = RTW89_SUB_ENTITY_0;
-		tbl_sel = 0;
 		break;
 	}
 
 	chan = rtw89_chan_get(rtwdev, sub_entity_idx);
 
+	for (tbl_sel = 0; tbl_sel < ARRAY_SIZE(desc); tbl_sel++) {
+		struct rtw89_rfk_chan_desc *p = &desc[tbl_sel];
+
+		p->ch = rfk_mcc->ch[tbl_sel];
+
+		p->has_band = true;
+		p->band = rfk_mcc->band[tbl_sel];
+
+		p->has_bw = true;
+		p->bw = rfk_mcc->bw[tbl_sel];
+	}
+
+	tbl_sel = rtw89_rfk_chan_lookup(rtwdev, desc, ARRAY_SIZE(desc), chan);
+
 	rfk_mcc->ch[tbl_sel] = chan->channel;
 	rfk_mcc->band[tbl_sel] = chan->band_type;
 	rfk_mcc->bw[tbl_sel] = chan->band_width;
-- 
2.25.1


