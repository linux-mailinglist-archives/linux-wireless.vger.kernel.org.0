Return-Path: <linux-wireless+bounces-9811-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF4791ED80
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 05:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC2581F225B8
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 03:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51CD922F17;
	Tue,  2 Jul 2024 03:39:03 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2138649633
	for <linux-wireless@vger.kernel.org>; Tue,  2 Jul 2024 03:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719891543; cv=none; b=mC7DmOcXv4Ba9BvzVGAqfB4BDp2deosYNt9awG0fmN+AVmRk29eV2OD8H5xx1z4usAofyHJK2fb5pPu76ZUgHimI80GOVgb/Vmd/9HUWR60WNXalG2rrFC587YU4v/u8RhL7wMv8F4yrIxnMBfNebZ8gBzg0NdvQv5JoaOe03t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719891543; c=relaxed/simple;
	bh=WEaxPHYeMLBUQc0bhsAYkjCldn4RHQ2PoiKdbzC4Z2I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LGDXxthv7qBstB1XAus58ac0V71oQBGNYjc6rEG8zJow9EilhlDidyWrhn+lBWL3gxgvYLAxm8RIQTOCt/jqjDke46GTM7g1OmsvvG0V0hIaqaqFIm4yMblSkoefwtNdvmG1XLRXeyNiJQTFWVVWINgCE9hu+NyuvLuhGP61RTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4623cvdcF395845, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 4623cvdcF395845
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 2 Jul 2024 11:38:57 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 2 Jul 2024 11:38:58 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 2 Jul
 2024 11:38:57 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH 2/2] wifi: rtw89: unify the selection logic of RFK table when MCC
Date: Tue, 2 Jul 2024 11:38:33 +0800
Message-ID: <20240702033833.9447-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240702033833.9447-1-pkshih@realtek.com>
References: <20240702033833.9447-1-pkshih@realtek.com>
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
1. check if the table matches target channel
2. check if the table is busy by iterating active channels
3. take the table to use if it's idle
4. next table

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/chan.c     | 22 +++++++
 drivers/net/wireless/realtek/rtw89/chan.h     |  4 ++
 drivers/net/wireless/realtek/rtw89/core.h     |  7 ++-
 drivers/net/wireless/realtek/rtw89/phy.c      | 59 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/phy.h      | 23 ++++++++
 .../net/wireless/realtek/rtw89/rtw8852c_rfk.c | 45 +++++++-------
 .../net/wireless/realtek/rtw89/rtw8922a_rfk.c | 31 +++++++++-
 7 files changed, 166 insertions(+), 25 deletions(-)

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
index e1bcac7e1324..2d39a4471169 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4685,7 +4685,12 @@ struct rtw89_dack_info {
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
index 60f20e596321..4aff2b311834 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -2,6 +2,7 @@
 /* Copyright(c) 2019-2020  Realtek Corporation
  */
 
+#include "chan.h"
 #include "coex.h"
 #include "debug.h"
 #include "fw.h"
@@ -5969,6 +5970,64 @@ void rtw89_phy_set_bss_color(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif
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
+enum rtw89_rfk_chan_status
+rtw89_rfk_chan_lookup(struct rtw89_dev *rtwdev,
+		      const struct rtw89_rfk_chan_desc *desc,
+		      const struct rtw89_chan *target_chan)
+{
+	struct rfk_chan_iter_data iter_data = {
+		.desc = *desc,
+	};
+
+	if (rfk_chan_is_equivalent(desc, target_chan))
+		return RTW89_RFK_CHAN_MATCHED;
+
+	rtw89_iterate_entity_chan(rtwdev, rfk_chan_iter_search, &iter_data);
+	if (iter_data.found)
+		return RTW89_RFK_CHAN_BUSY;
+
+	return RTW89_RFK_CHAN_IDLE;
+}
+EXPORT_SYMBOL(rtw89_rfk_chan_lookup);
+
 static void
 _rfk_write_rf(struct rtw89_dev *rtwdev, const struct rtw89_reg5_def *def)
 {
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index 6e53ac9140fb..e16689b18f87 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -715,6 +715,25 @@ enum rtw89_phy_gain_band_be rtw89_subband_to_gain_band_be(enum rtw89_subband sub
 	}
 }
 
+enum rtw89_rfk_chan_status {
+	RTW89_RFK_CHAN_IDLE,
+	RTW89_RFK_CHAN_BUSY,
+	RTW89_RFK_CHAN_MATCHED,
+};
+
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
@@ -950,5 +969,9 @@ enum rtw89_rf_path_bit rtw89_phy_get_kpath(struct rtw89_dev *rtwdev,
 					   enum rtw89_phy_idx phy_idx);
 enum rtw89_rf_path rtw89_phy_get_syn_sel(struct rtw89_dev *rtwdev,
 					 enum rtw89_phy_idx phy_idx);
+enum rtw89_rfk_chan_status
+rtw89_rfk_chan_lookup(struct rtw89_dev *rtwdev,
+		      const struct rtw89_rfk_chan_desc *desc,
+		      const struct rtw89_chan *target_chan);
 
 #endif
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
index 654e3e5507cb..88770dea705d 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
@@ -4070,12 +4070,11 @@ void rtw8852c_set_channel_rf(struct rtw89_dev *rtwdev,
 void rtw8852c_mcc_get_ch_info(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 {
 	struct rtw89_rfk_mcc_info *rfk_mcc = &rtwdev->rfk_mcc;
-	DECLARE_BITMAP(map, RTW89_IQK_CHS_NR) = {};
+	enum rtw89_rfk_chan_status status;
 	const struct rtw89_chan *chan;
 	enum rtw89_entity_mode mode;
 	u8 chan_idx;
 	u8 idx;
-	u8 i;
 
 	mode = rtw89_get_entity_mode(rtwdev);
 	switch (mode) {
@@ -4087,30 +4086,32 @@ void rtw8852c_mcc_get_ch_info(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_i
 		break;
 	}
 
-	for (i = 0; i <= chan_idx; i++) {
-		chan = rtw89_chan_get(rtwdev, i);
-
-		for (idx = 0; idx < RTW89_IQK_CHS_NR; idx++) {
-			if (rfk_mcc->ch[idx] == chan->channel &&
-			    rfk_mcc->band[idx] == chan->band_type) {
-				if (i != chan_idx) {
-					set_bit(idx, map);
-					break;
-				}
-
-				goto bottom;
-			}
+	chan = rtw89_chan_get(rtwdev, chan_idx);
+
+	for (idx = 0; idx < __RTW89_RFK_CHS_NR_V0; idx++) {
+		struct rtw89_rfk_chan_desc desc = {
+			.ch = rfk_mcc->ch[idx],
+			.has_band = true,
+			.band = rfk_mcc->band[idx],
+		};
+
+		status = rtw89_rfk_chan_lookup(rtwdev, &desc, chan);
+		switch (status) {
+		case RTW89_RFK_CHAN_MATCHED:
+			goto bottom;
+		case RTW89_RFK_CHAN_IDLE:
+			goto fill;
+		case RTW89_RFK_CHAN_BUSY:
+			break;
 		}
 	}
 
-	idx = find_first_zero_bit(map, RTW89_IQK_CHS_NR);
-	if (idx == RTW89_IQK_CHS_NR) {
-		rtw89_debug(rtwdev, RTW89_DBG_RFK,
-			    "%s: no empty rfk table; force replace the first\n",
-			    __func__);
-		idx = 0;
-	}
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "%s: no empty rfk table; force replace the first\n",
+		    __func__);
+	idx = 0;
 
+fill:
 	rfk_mcc->ch[idx] = chan->channel;
 	rfk_mcc->band[idx] = chan->band_type;
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.c
index 2a371829268c..c02d8f416e61 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.c
@@ -256,6 +256,7 @@ static void rtw8922a_chlk_reload(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_rfk_mcc_info *rfk_mcc = &rtwdev->rfk_mcc;
 	enum rtw89_sub_entity_idx sub_entity_idx;
+	enum rtw89_rfk_chan_status status;
 	const struct rtw89_chan *chan;
 	enum rtw89_entity_mode mode;
 	u8 s0_tbl, s1_tbl;
@@ -265,19 +266,45 @@ static void rtw8922a_chlk_reload(struct rtw89_dev *rtwdev)
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
 
+	for (tbl_sel = 0; tbl_sel < __RTW89_RFK_CHS_NR_V1; tbl_sel++) {
+		struct rtw89_rfk_chan_desc desc = {
+			.ch = rfk_mcc->ch[tbl_sel],
+			.has_band = true,
+			.band = rfk_mcc->band[tbl_sel],
+			.has_bw = true,
+			.bw = rfk_mcc->bw[tbl_sel],
+		};
+
+		status = rtw89_rfk_chan_lookup(rtwdev, &desc, chan);
+		switch (status) {
+		case RTW89_RFK_CHAN_MATCHED:
+			goto bottom;
+		case RTW89_RFK_CHAN_IDLE:
+			goto fill;
+		case RTW89_RFK_CHAN_BUSY:
+			break;
+		}
+	}
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "%s: no empty rfk table; force replace the first\n",
+		    __func__);
+	tbl_sel = 0;
+
+fill:
 	rfk_mcc->ch[tbl_sel] = chan->channel;
 	rfk_mcc->band[tbl_sel] = chan->band_type;
 	rfk_mcc->bw[tbl_sel] = chan->band_width;
+
+bottom:
 	rfk_mcc->table_idx = tbl_sel;
 
 	s0_tbl = tbl_sel;
-- 
2.25.1


