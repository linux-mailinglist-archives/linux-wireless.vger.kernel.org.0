Return-Path: <linux-wireless+bounces-14300-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 017599A9CAD
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2024 10:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B191C283B1B
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2024 08:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A73154C12;
	Tue, 22 Oct 2024 08:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="rdx+Fc2z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D9D157487
	for <linux-wireless@vger.kernel.org>; Tue, 22 Oct 2024 08:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729585914; cv=none; b=FfRntqcVDwgM5pmRxBd+kPDIYy0ylkG1Uu2+VA9fr1vnAdKLb+KX7O2rGalmlcex2V4j5D4J/F11jgKJPHtd62bzKVfx3/8WMfnRR2vhPwex6gvtKa/0ENoPJrrp43kkajPpt8gWceAzqm3paXEl5jUinp9QLUNrWY3YArHp3Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729585914; c=relaxed/simple;
	bh=vkF8+GGp/K8uASHSlNSPBTVAqCknglYf4yopUEZ1Ahs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T8+lSEyPOVx6sA7gGFp5nGaOeAlEPAbiiPqcz21w7Hgw9dNKBE78LTfSalnTlHxgyhsHkBh8aje0fTgRYVDxOEkvsWHpAJnPUiNKEbWk4P0sJmdwzDy0pYXED4QjPeles8Nuzm9drsxHjYVNuzJFo1qvhcLgQUHl86xnEydymH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=rdx+Fc2z; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 49M8VorH63771885, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1729585910; bh=vkF8+GGp/K8uASHSlNSPBTVAqCknglYf4yopUEZ1Ahs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=rdx+Fc2zCKp+PPM0U3uU3fUctBgevPbV59NRNXtdnEFUUcLP+lpUfCveFh/UHX6l0
	 Cx2O1z6JBeFMZwb4M6+3MFaLxyWeApRlxvswDXus8IjpeHRq8RWx/h56tX/25XdmJx
	 auw003Gld8WgW/DNhMAvR3ydx9X1IuUCezRr4Fgr2dc1F8jPQr6e0gw433OoezFZZ/
	 aJ7gIUMTaPeiDymAm/0WxPtjsQuUuseUZ4TIdYKgiGJAQPVzRqESfKfLlFesDJpdBH
	 NPKNrdpUc9oD1WCZv/88zqZtOJxVoKG6mDDwXXyx0NIba0Tk0/o4OpQ17u383S1feL
	 2iUnqkP4iqVpA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 49M8VorH63771885
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 22 Oct 2024 16:31:50 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 22 Oct 2024 16:31:50 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 22 Oct
 2024 16:31:49 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <phhuang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH 5/5] wifi: rtw89: 8922a: extend RFK handling and consider MLO
Date: Tue, 22 Oct 2024 16:31:06 +0800
Message-ID: <20241022083106.149252-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241022083106.149252-1-pkshih@realtek.com>
References: <20241022083106.149252-1-pkshih@realtek.com>
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

Extend FW and driver handling on RFK to support it on both HW bands.
Then, according to MLO cases, do the corresponding RF settings.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     |  6 +-
 drivers/net/wireless/realtek/rtw89/fw.c       | 23 ++++---
 .../net/wireless/realtek/rtw89/rtw8852c_rfk.c |  6 +-
 drivers/net/wireless/realtek/rtw89/rtw8922a.c | 18 ++++--
 .../net/wireless/realtek/rtw89/rtw8922a_rfk.c | 61 +++++++++++--------
 5 files changed, 70 insertions(+), 44 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 10a5144fd425..31972c9ee5a7 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4807,13 +4807,17 @@ enum rtw89_rfk_chs_nrs {
 	RTW89_RFK_CHS_NR = __RTW89_RFK_CHS_NR_V1,
 };
 
-struct rtw89_rfk_mcc_info {
+struct rtw89_rfk_mcc_info_data {
 	u8 ch[RTW89_RFK_CHS_NR];
 	u8 band[RTW89_RFK_CHS_NR];
 	u8 bw[RTW89_RFK_CHS_NR];
 	u8 table_idx;
 };
 
+struct rtw89_rfk_mcc_info {
+	struct rtw89_rfk_mcc_info_data data[2];
+};
+
 #define RTW89_IQK_CHS_NR 2
 #define RTW89_IQK_PATH_NR 4
 
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 744a8d277cfc..d75e1d969881 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -5260,7 +5260,7 @@ int rtw89_fw_h2c_rf_reg(struct rtw89_dev *rtwdev,
 
 int rtw89_fw_h2c_rf_ntfy_mcc(struct rtw89_dev *rtwdev)
 {
-	struct rtw89_rfk_mcc_info *rfk_mcc = &rtwdev->rfk_mcc;
+	struct rtw89_rfk_mcc_info_data *rfk_mcc = rtwdev->rfk_mcc.data;
 	struct rtw89_fw_h2c_rf_get_mccch *mccch;
 	struct sk_buff *skb;
 	int ret;
@@ -5307,7 +5307,7 @@ int rtw89_fw_h2c_rf_pre_ntfy(struct rtw89_dev *rtwdev,
 	struct rtw89_rfk_mcc_info *rfk_mcc = &rtwdev->rfk_mcc;
 	struct rtw89_fw_h2c_rfk_pre_info_v0 *h2c_v0;
 	struct rtw89_fw_h2c_rfk_pre_info *h2c;
-	u8 tbl_sel = rfk_mcc->table_idx;
+	u8 tbl_sel[NUM_OF_RTW89_FW_RFK_PATH];
 	u32 len = sizeof(*h2c);
 	struct sk_buff *skb;
 	u8 ver = U8_MAX;
@@ -5331,19 +5331,24 @@ int rtw89_fw_h2c_rf_pre_ntfy(struct rtw89_dev *rtwdev,
 	h2c->common.mlo_mode = cpu_to_le32(rtwdev->mlo_dbcc_mode);
 
 	BUILD_BUG_ON(NUM_OF_RTW89_FW_RFK_TBL > RTW89_RFK_CHS_NR);
+	BUILD_BUG_ON(ARRAY_SIZE(rfk_mcc->data) < NUM_OF_RTW89_FW_RFK_PATH);
 
 	for (tbl = 0; tbl < NUM_OF_RTW89_FW_RFK_TBL; tbl++) {
 		for (path = 0; path < NUM_OF_RTW89_FW_RFK_PATH; path++) {
 			h2c->common.dbcc.ch[path][tbl] =
-				cpu_to_le32(rfk_mcc->ch[tbl]);
+				cpu_to_le32(rfk_mcc->data[path].ch[tbl]);
 			h2c->common.dbcc.band[path][tbl] =
-				cpu_to_le32(rfk_mcc->band[tbl]);
+				cpu_to_le32(rfk_mcc->data[path].band[tbl]);
 		}
 	}
 
 	for (path = 0; path < NUM_OF_RTW89_FW_RFK_PATH; path++) {
-		h2c->common.tbl.cur_ch[path] = cpu_to_le32(rfk_mcc->ch[tbl_sel]);
-		h2c->common.tbl.cur_band[path] = cpu_to_le32(rfk_mcc->band[tbl_sel]);
+		tbl_sel[path] = rfk_mcc->data[path].table_idx;
+
+		h2c->common.tbl.cur_ch[path] =
+			cpu_to_le32(rfk_mcc->data[path].ch[tbl_sel[path]]);
+		h2c->common.tbl.cur_band[path] =
+			cpu_to_le32(rfk_mcc->data[path].band[tbl_sel[path]]);
 	}
 
 	h2c->common.phy_idx = cpu_to_le32(phy_idx);
@@ -5351,9 +5356,9 @@ int rtw89_fw_h2c_rf_pre_ntfy(struct rtw89_dev *rtwdev,
 	if (ver == 0) { /* RFK_PRE_NOTIFY_V0 */
 		h2c_v0 = (struct rtw89_fw_h2c_rfk_pre_info_v0 *)skb->data;
 
-		h2c_v0->cur_band = cpu_to_le32(rfk_mcc->band[tbl_sel]);
-		h2c_v0->cur_bw = cpu_to_le32(rfk_mcc->bw[tbl_sel]);
-		h2c_v0->cur_center_ch = cpu_to_le32(rfk_mcc->ch[tbl_sel]);
+		h2c_v0->cur_band = cpu_to_le32(rfk_mcc->data[0].band[tbl_sel[0]]);
+		h2c_v0->cur_bw = cpu_to_le32(rfk_mcc->data[0].bw[tbl_sel[0]]);
+		h2c_v0->cur_center_ch = cpu_to_le32(rfk_mcc->data[0].ch[tbl_sel[0]]);
 
 		val32 = rtw89_phy_read32_mask(rtwdev, R_COEF_SEL, B_COEF_SEL_IQC_V1);
 		h2c_v0->ktbl_sel0 = cpu_to_le32(val32);
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
index 3281ee9d7523..bd17c0a1c684 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
@@ -1065,7 +1065,7 @@ static bool _iqk_nbtxk(struct rtw89_dev *rtwdev,
 
 static bool _lok_finetune_check(struct rtw89_dev *rtwdev, u8 path)
 {
-	struct rtw89_rfk_mcc_info *rfk_mcc = &rtwdev->rfk_mcc;
+	struct rtw89_rfk_mcc_info_data *rfk_mcc = rtwdev->rfk_mcc.data;
 	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
 	u8 idx = rfk_mcc->table_idx;
 	bool is_fail1,  is_fail2;
@@ -1408,7 +1408,7 @@ static void _iqk_afebb_restore(struct rtw89_dev *rtwdev,
 
 static void _iqk_preset(struct rtw89_dev *rtwdev, u8 path)
 {
-	struct rtw89_rfk_mcc_info *rfk_mcc = &rtwdev->rfk_mcc;
+	struct rtw89_rfk_mcc_info_data *rfk_mcc = rtwdev->rfk_mcc.data;
 	u8 idx = 0;
 
 	idx = rfk_mcc->table_idx;
@@ -4105,7 +4105,7 @@ void rtw8852c_set_channel_rf(struct rtw89_dev *rtwdev,
 
 void rtw8852c_mcc_get_ch_info(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 {
-	struct rtw89_rfk_mcc_info *rfk_mcc = &rtwdev->rfk_mcc;
+	struct rtw89_rfk_mcc_info_data *rfk_mcc = rtwdev->rfk_mcc.data;
 	struct rtw89_rfk_chan_desc desc[__RTW89_RFK_CHS_NR_V0] = {};
 	const struct rtw89_chan *chan;
 	enum rtw89_entity_mode mode;
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index 58c9721ac3ab..7da73a9737f2 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -2,6 +2,7 @@
 /* Copyright(c) 2023  Realtek Corporation
  */
 
+#include "chan.h"
 #include "coex.h"
 #include "debug.h"
 #include "efuse.h"
@@ -1745,7 +1746,7 @@ static void rtw8922a_digital_pwr_comp(struct rtw89_dev *rtwdev,
 
 static int rtw8922a_ctrl_mlo(struct rtw89_dev *rtwdev, enum rtw89_mlo_dbcc_mode mode)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
+	const struct rtw89_chan *chan0, *chan1;
 
 	if (mode == MLO_1_PLUS_1_1RF || mode == DBCC_LEGACY) {
 		rtw89_phy_write32_mask(rtwdev, R_DBCC, B_DBCC_EN, 0x1);
@@ -1758,13 +1759,20 @@ static int rtw8922a_ctrl_mlo(struct rtw89_dev *rtwdev, enum rtw89_mlo_dbcc_mode
 		return -EOPNOTSUPP;
 	}
 
-	if (mode == MLO_2_PLUS_0_1RF) {
-		rtw8922a_ctrl_afe_dac(rtwdev, chan->band_width, RF_PATH_A);
-		rtw8922a_ctrl_afe_dac(rtwdev, chan->band_width, RF_PATH_B);
+	if (mode == MLO_1_PLUS_1_1RF) {
+		chan0 = rtw89_mgnt_chan_get(rtwdev, 0);
+		chan1 = rtw89_mgnt_chan_get(rtwdev, 1);
+	} else if (mode == MLO_0_PLUS_2_1RF) {
+		chan1 = rtw89_mgnt_chan_get(rtwdev, 1);
+		chan0 = chan1;
 	} else {
-		rtw89_warn(rtwdev, "unsupported MLO mode %d\n", mode);
+		chan0 = rtw89_mgnt_chan_get(rtwdev, 0);
+		chan1 = chan0;
 	}
 
+	rtw8922a_ctrl_afe_dac(rtwdev, chan0->band_width, RF_PATH_A);
+	rtw8922a_ctrl_afe_dac(rtwdev, chan1->band_width, RF_PATH_B);
+
 	rtw89_phy_write32_mask(rtwdev, R_EMLSR, B_EMLSR_PARM, 0x6180);
 
 	if (mode == MLO_2_PLUS_0_1RF) {
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.c
index 28907df7407d..c4c93f836a2f 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.c
@@ -252,49 +252,58 @@ static void rtw8922a_chlk_ktbl_sel(struct rtw89_dev *rtwdev, u8 kpath, u8 idx)
 	}
 }
 
-static void rtw8922a_chlk_reload(struct rtw89_dev *rtwdev)
+static u8 rtw8922a_chlk_reload_sel_tbl(struct rtw89_dev *rtwdev,
+				       const struct rtw89_chan *chan, u8 path)
 {
 	struct rtw89_rfk_mcc_info *rfk_mcc = &rtwdev->rfk_mcc;
 	struct rtw89_rfk_chan_desc desc[__RTW89_RFK_CHS_NR_V1] = {};
-	enum rtw89_chanctx_idx chanctx_idx;
-	const struct rtw89_chan *chan;
-	enum rtw89_entity_mode mode;
-	u8 s0_tbl, s1_tbl;
 	u8 tbl_sel;
 
-	mode = rtw89_get_entity_mode(rtwdev);
-	switch (mode) {
-	case RTW89_ENTITY_MODE_MCC_PREPARE:
-		chanctx_idx = RTW89_CHANCTX_1;
-		break;
-	default:
-		chanctx_idx = RTW89_CHANCTX_0;
-		break;
-	}
-
-	chan = rtw89_chan_get(rtwdev, chanctx_idx);
-
 	for (tbl_sel = 0; tbl_sel < ARRAY_SIZE(desc); tbl_sel++) {
 		struct rtw89_rfk_chan_desc *p = &desc[tbl_sel];
 
-		p->ch = rfk_mcc->ch[tbl_sel];
+		p->ch = rfk_mcc->data[path].ch[tbl_sel];
 
 		p->has_band = true;
-		p->band = rfk_mcc->band[tbl_sel];
+		p->band = rfk_mcc->data[path].band[tbl_sel];
 
 		p->has_bw = true;
-		p->bw = rfk_mcc->bw[tbl_sel];
+		p->bw = rfk_mcc->data[path].bw[tbl_sel];
 	}
 
 	tbl_sel = rtw89_rfk_chan_lookup(rtwdev, desc, ARRAY_SIZE(desc), chan);
 
-	rfk_mcc->ch[tbl_sel] = chan->channel;
-	rfk_mcc->band[tbl_sel] = chan->band_type;
-	rfk_mcc->bw[tbl_sel] = chan->band_width;
-	rfk_mcc->table_idx = tbl_sel;
+	rfk_mcc->data[path].ch[tbl_sel] = chan->channel;
+	rfk_mcc->data[path].band[tbl_sel] = chan->band_type;
+	rfk_mcc->data[path].bw[tbl_sel] = chan->band_width;
+	rfk_mcc->data[path].table_idx = tbl_sel;
+
+	return tbl_sel;
+}
+
+static void rtw8922a_chlk_reload(struct rtw89_dev *rtwdev)
+{
+	const struct rtw89_chan *chan0, *chan1;
+	u8 s0_tbl, s1_tbl;
+
+	switch (rtwdev->mlo_dbcc_mode) {
+	default:
+	case MLO_2_PLUS_0_1RF:
+		chan0 = rtw89_mgnt_chan_get(rtwdev, 0);
+		chan1 = chan0;
+		break;
+	case MLO_0_PLUS_2_1RF:
+		chan1 = rtw89_mgnt_chan_get(rtwdev, 1);
+		chan0 = chan1;
+		break;
+	case MLO_1_PLUS_1_1RF:
+		chan0 = rtw89_mgnt_chan_get(rtwdev, 0);
+		chan1 = rtw89_mgnt_chan_get(rtwdev, 1);
+		break;
+	}
 
-	s0_tbl = tbl_sel;
-	s1_tbl = tbl_sel;
+	s0_tbl = rtw8922a_chlk_reload_sel_tbl(rtwdev, chan0, 0);
+	s1_tbl = rtw8922a_chlk_reload_sel_tbl(rtwdev, chan1, 1);
 
 	rtw8922a_chlk_ktbl_sel(rtwdev, RF_A, s0_tbl);
 	rtw8922a_chlk_ktbl_sel(rtwdev, RF_B, s1_tbl);
-- 
2.25.1


