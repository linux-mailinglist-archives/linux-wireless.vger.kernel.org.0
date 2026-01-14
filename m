Return-Path: <linux-wireless+bounces-30800-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA1FD1BF7F
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jan 2026 02:41:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E8DA73014EB4
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jan 2026 01:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97422874E1;
	Wed, 14 Jan 2026 01:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="qQDiXiUY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D86A2E22BE
	for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 01:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768354866; cv=none; b=UXlDGZEGQNpWWrzdUCPenDE8Qw2G2mJBp5Y9JQ97t2D1RCP+iscngCWm9fhEhAKCnCkp/TtMeaKJVas+TOHMsHfGQEmjjbhvA5PxCE7qfllLeShX5qA1YIkElol34vQYIkd5CRo0USPbUTxbP0vkms22ThX/0FTWWwlxBAmeqqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768354866; c=relaxed/simple;
	bh=nv6LJCgqk7gnNxH6Pd9c5rp124T4w1+ZxcXEjWy+5hM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lvt/hUw2wALcbbqnIif/H+kCHqvQuC8nl+ZNc074nW2JLQAJ5HXe90SDPOA/8DOmLEILzpYn2jwgjTs7mn8QBLsRxqALRFZThFpasixcqYy5dgndyDnNSAptN9S3WqP3258C7pbKlfJVrhU4YAjgRy/XrtOiPZswcCfletibNAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=qQDiXiUY; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60E1f1KU14168630, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1768354861; bh=ykGcOXYtqLL7VeVs/8234hzSql4wwqN+i9abVlJAjIc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=qQDiXiUY4uL/4Hi3ncFiVY5/nCzr3Ac506faHP8yvuh3Tx4thPvjW8PT2U+Y1d5a1
	 MbqEbwXJPYJaa+WyWscrMhycAiSQxEVki6xRSnJKpOEiDtxLHkUbZGf5II109ZIenD
	 +vcmWn/0EP6Qg7bNzvh63BGj4+tY8lwxglZ8EH6R3Pnkam4frSzwzwdrlUvJ0PK4b+
	 T3/gOwRwmJGAjyiBaUCrR/pQ7ucy4aoJLaUiXPfAF4lkvbS8cD2PMHidMknkdu97MV
	 gKkb2LYmE/iHWsFNguU4zm8V9NTSHmUWAqEiYDNRFTf21DfhmpxLOHW0MPDmFY4oD4
	 d5bhKAMzljBgw==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60E1f1KU14168630
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 09:41:01 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 14 Jan 2026 09:41:02 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Wed, 14 Jan 2026 09:41:02 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <echuang@realtek.com>, <phhuang@realtek.com>
Subject: [PATCH rtw-next 08/12] wifi: rtw89: phy: update BB wrapper RFSI
Date: Wed, 14 Jan 2026 09:39:46 +0800
Message-ID: <20260114013950.19704-9-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260114013950.19704-1-pkshih@realtek.com>
References: <20260114013950.19704-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

RTL8922D adds newly BB wrapper RFSI, including compensation values
and threshold, bandedge settings, and CIM3K coefficient.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.h    |   8 +
 drivers/net/wireless/realtek/rtw89/phy.h    |   6 +
 drivers/net/wireless/realtek/rtw89/phy_be.c | 328 ++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/reg.h    | 207 ++++++++++++
 4 files changed, 549 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 784a1cf4c6f4..0c8614fc3000 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -1139,6 +1139,14 @@ rtw89_write16_idx(struct rtw89_dev *rtwdev, u32 addr, u16 data, u8 band)
 	rtw89_write16(rtwdev, addr, data);
 }
 
+static inline void
+rtw89_write32_idx(struct rtw89_dev *rtwdev, u32 addr, u32 mask, u32 data, u8 band)
+{
+	addr = rtw89_mac_reg_by_idx(rtwdev, addr, band);
+
+	rtw89_write32_mask(rtwdev, addr, mask, data);
+}
+
 static inline
 u32 rtw89_mac_reg_by_port(struct rtw89_dev *rtwdev, u32 base, u8 port, u8 mac_idx)
 {
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index 0834569278cd..4e985a604338 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -893,6 +893,12 @@ static inline void rtw89_phy_bb_wrap_init(struct rtw89_dev *rtwdev)
 		phy->bb_wrap_init(rtwdev);
 }
 
+void rtw89_phy_bb_wrap_set_rfsi_ct_opt(struct rtw89_dev *rtwdev,
+				       enum rtw89_phy_idx phy_idx);
+void rtw89_phy_bb_wrap_set_rfsi_bandedge_ch(struct rtw89_dev *rtwdev,
+					    const struct rtw89_chan *chan,
+					    enum rtw89_phy_idx phy_idx);
+
 static inline void rtw89_phy_ch_info_init(struct rtw89_dev *rtwdev)
 {
 	const struct rtw89_phy_gen_def *phy = rtwdev->chip->phy_def;
diff --git a/drivers/net/wireless/realtek/rtw89/phy_be.c b/drivers/net/wireless/realtek/rtw89/phy_be.c
index 766ea4404ffc..f64dc47a5850 100644
--- a/drivers/net/wireless/realtek/rtw89/phy_be.c
+++ b/drivers/net/wireless/realtek/rtw89/phy_be.c
@@ -2,6 +2,7 @@
 /* Copyright(c) 2023  Realtek Corporation
  */
 
+#include "chan.h"
 #include "debug.h"
 #include "mac.h"
 #include "phy.h"
@@ -519,6 +520,332 @@ static void rtw89_phy_bb_wrap_ftm_init(struct rtw89_dev *rtwdev,
 	rtw89_write32_mask(rtwdev, addr, 0x7, 0);
 }
 
+static u32 rtw89_phy_bb_wrap_be_bandedge_decision(struct rtw89_dev *rtwdev,
+						  const struct rtw89_chan *chan)
+{
+	u8 pri_ch = chan->primary_channel;
+	u32 val = 0;
+
+	switch (chan->band_type) {
+	default:
+	case RTW89_BAND_2G:
+		if (pri_ch == 1 || pri_ch == 13)
+			val = BIT(1) | BIT(0);
+		else if (pri_ch == 3 || pri_ch == 11)
+			val = BIT(1);
+		break;
+	case RTW89_BAND_5G:
+		if (pri_ch == 36 || pri_ch == 64 || pri_ch == 100)
+			val = BIT(3) | BIT(2) | BIT(1) | BIT(0);
+		else if (pri_ch == 40 || pri_ch == 60 || pri_ch == 104)
+			val = BIT(3) | BIT(2) | BIT(1);
+		else if ((pri_ch > 40 && pri_ch < 60) || pri_ch == 108 || pri_ch == 112)
+			val = BIT(3) | BIT(2);
+		else if (pri_ch > 112 && pri_ch < 132)
+			val = BIT(3);
+		break;
+	case RTW89_BAND_6G:
+		if (pri_ch == 233)
+			val = BIT(0);
+		break;
+	}
+
+	return val;
+}
+
+void rtw89_phy_bb_wrap_set_rfsi_ct_opt(struct rtw89_dev *rtwdev,
+				       enum rtw89_phy_idx phy_idx)
+{
+	u32 reg;
+
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_RFSI_CT_OPT_0_BE4, phy_idx);
+	rtw89_write32(rtwdev, reg, 0x00010001);
+
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_RFSI_CT_OPT_8_BE4, phy_idx);
+	rtw89_write32(rtwdev, reg, 0x00010001);
+}
+EXPORT_SYMBOL(rtw89_phy_bb_wrap_set_rfsi_ct_opt);
+
+void rtw89_phy_bb_wrap_set_rfsi_bandedge_ch(struct rtw89_dev *rtwdev,
+					    const struct rtw89_chan *chan,
+					    enum rtw89_phy_idx phy_idx)
+{
+	u32 reg;
+	u32 val;
+
+	val = rtw89_phy_bb_wrap_be_bandedge_decision(rtwdev, chan);
+
+	rtw89_phy_write32_idx(rtwdev, R_TX_CFR_MANUAL_EN_BE4, B_TX_CFR_MANUAL_EN_BE4_M,
+			      chan->primary_channel == 13, phy_idx);
+
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_BANDEDGE_DBWX_BE4, phy_idx);
+	rtw89_write32_mask(rtwdev, reg, B_BANDEDGE_DBW20_BE4, val & BIT(0));
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_BANDEDGE_DBWX_BE4, phy_idx);
+	rtw89_write32_mask(rtwdev, reg, B_BANDEDGE_DBW40_BE4, (val & BIT(1)) >> 1);
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_BANDEDGE_DBWX_BE4, phy_idx);
+	rtw89_write32_mask(rtwdev, reg, B_BANDEDGE_DBW80_BE4, (val & BIT(2)) >> 2);
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_BANDEDGE_DBWY_BE4, phy_idx);
+	rtw89_write32_mask(rtwdev, reg, B_BANDEDGE_DBW160_BE4, (val & BIT(3)) >> 3);
+}
+EXPORT_SYMBOL(rtw89_phy_bb_wrap_set_rfsi_bandedge_ch);
+
+static void rtw89_phy_bb_wrap_tx_rfsi_qam_comp_th_init(struct rtw89_dev *rtwdev,
+						       enum rtw89_mac_idx mac_idx)
+{
+	/* TH0 */
+	rtw89_write32_idx(rtwdev, R_QAM_TH0_BE4, B_QAM_TH0_0_BE4, 0x1, mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_TH0_BE4, B_QAM_TH0_3_BE4, 0x1, mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_TH1_BE4, B_QAM_TH1_1_BE4, 0x1, mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_TH1_BE4, B_QAM_TH1_4_BE4, 0x1, mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_TH1_BE4, B_QAM_TH1_7_BE4, 0x1, mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_TH2_BE4, B_QAM_TH2_0_BE4, 0x1, mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_TH2_BE4, B_QAM_TH2_3_BE4, 0x1, mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_TH2_BE4, B_QAM_TH2_6_BE4, 0x1, mac_idx);
+	/* TH1 */
+	rtw89_write32_idx(rtwdev, R_QAM_TH0_BE4, B_QAM_TH0_1_BE4, 0x2, mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_TH0_BE4, B_QAM_TH0_4_BE4, 0x2, mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_TH1_BE4, B_QAM_TH1_2_BE4, 0x2, mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_TH1_BE4, B_QAM_TH1_5_BE4, 0x2, mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_TH1_BE4, B_QAM_TH1_8_BE4, 0x2, mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_TH2_BE4, B_QAM_TH2_1_BE4, 0x2, mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_TH2_BE4, B_QAM_TH2_4_BE4, 0x2, mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_TH2_BE4, B_QAM_TH2_7_BE4, 0x2, mac_idx);
+	/* TH2 */
+	rtw89_write32_idx(rtwdev, R_QAM_TH0_BE4, B_QAM_TH0_2_BE4, 0x4, mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_TH1_BE4, B_QAM_TH1_0_BE4, 0x4, mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_TH1_BE4, B_QAM_TH1_3_BE4, 0x4, mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_TH1_BE4, B_QAM_TH1_6_BE4, 0x4, mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_TH1_BE4, B_QAM_TH1_9_BE4, 0x4, mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_TH2_BE4, B_QAM_TH2_2_BE4, 0x4, mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_TH2_BE4, B_QAM_TH2_5_BE4, 0x4, mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_TH2_BE4, B_QAM_TH2_8_BE4, 0x4, mac_idx);
+	/* DPD 160M */
+	rtw89_write32_idx(rtwdev, R_DPD_DBW160_TH0_BE4, B_DPD_DBW160_TH0_0_BE4, 0x1, mac_idx);
+	rtw89_write32_idx(rtwdev, R_DPD_DBW160_TH0_BE4, B_DPD_DBW160_TH0_1_BE4, 0x1, mac_idx);
+	rtw89_write32_idx(rtwdev, R_DPD_DBW160_TH0_BE4, B_DPD_DBW160_TH0_2_BE4, 0x1, mac_idx);
+	rtw89_write32_idx(rtwdev, R_DPD_DBW160_TH0_BE4, B_DPD_DBW160_TH0_3_BE4, 0x1, mac_idx);
+	rtw89_write32_idx(rtwdev, R_DPD_DBW160_TH0_BE4, B_DPD_DBW160_TH0_4_BE4, 0x1, mac_idx);
+	rtw89_write32_idx(rtwdev, R_DPD_DBW160_TH1_BE4, B_DPD_DBW160_TH1_5_BE4, 0x1, mac_idx);
+	rtw89_write32_idx(rtwdev, R_DPD_DBW160_TH1_BE4, B_DPD_DBW160_TH1_6_BE4, 0x1, mac_idx);
+	rtw89_write32_idx(rtwdev, R_DPD_DBW160_TH1_BE4, B_DPD_DBW160_TH1_7_BE4, 0x1, mac_idx);
+	/* DPD 20M */
+	rtw89_write32_idx(rtwdev, R_DPD_CBW_TH0_BE4, B_DPD_CBW20_TH0_0_BE4, 0x2, mac_idx);
+	rtw89_write32_idx(rtwdev, R_DPD_CBW_TH0_BE4, B_DPD_CBW20_TH0_1_BE4, 0x2, mac_idx);
+	rtw89_write32_idx(rtwdev, R_DPD_CBW_TH0_BE4, B_DPD_CBW20_TH0_2_BE4, 0x2, mac_idx);
+	rtw89_write32_idx(rtwdev, R_DPD_CBW_TH0_BE4, B_DPD_CBW20_TH0_3_BE4, 0x2, mac_idx);
+	rtw89_write32_idx(rtwdev, R_DPD_CBW_TH0_BE4, B_DPD_CBW20_TH0_4_BE4, 0x2, mac_idx);
+	rtw89_write32_idx(rtwdev, R_DPD_CBW_TH0_BE4, B_DPD_CBW20_TH0_5_BE4, 0x2, mac_idx);
+	rtw89_write32_idx(rtwdev, R_DPD_CBW_TH0_BE4, B_DPD_CBW20_TH0_6_BE4, 0x2, mac_idx);
+	rtw89_write32_idx(rtwdev, R_DPD_CBW_TH1_BE4, B_DPD_CBW20_TH1_7_BE4, 0x2, mac_idx);
+	/* DPD 40M */
+	rtw89_write32_idx(rtwdev, R_DPD_CBW_TH1_BE4, B_DPD_CBW40_TH1_0_BE4, 0x2, mac_idx);
+	rtw89_write32_idx(rtwdev, R_DPD_CBW_TH1_BE4, B_DPD_CBW40_TH1_1_BE4, 0x2, mac_idx);
+	rtw89_write32_idx(rtwdev, R_DPD_CBW_TH1_BE4, B_DPD_CBW40_TH1_2_BE4, 0x2, mac_idx);
+	rtw89_write32_idx(rtwdev, R_DPD_CBW_TH1_BE4, B_DPD_CBW40_TH1_3_BE4, 0x2, mac_idx);
+	rtw89_write32_idx(rtwdev, R_DPD_CBW_TH1_BE4, B_DPD_CBW40_TH1_4_BE4, 0x2, mac_idx);
+	rtw89_write32_idx(rtwdev, R_DPD_CBW_TH1_BE4, B_DPD_CBW20_TH0_3_BE4, 0x2, mac_idx);
+	rtw89_write32_idx(rtwdev, R_DPD_CBW_TH1_BE4, B_DPD_CBW20_TH0_4_BE4, 0x2, mac_idx);
+	rtw89_write32_idx(rtwdev, R_DPD_CBW_TH1_BE4, B_DPD_CBW20_TH0_5_BE4, 0x2, mac_idx);
+	/* DPD 80M */
+	rtw89_write32_idx(rtwdev, R_DPD_CBW_TH1_BE4, B_DPD_CBW80_TH1_0_BE4, 0x2, mac_idx);
+	rtw89_write32_idx(rtwdev, R_DPD_CBW_TH2_BE4, B_DPD_CBW80_TH2_1_BE4, 0x2, mac_idx);
+	rtw89_write32_idx(rtwdev, R_DPD_CBW_TH2_BE4, B_DPD_CBW80_TH2_2_BE4, 0x2, mac_idx);
+	rtw89_write32_idx(rtwdev, R_DPD_CBW_TH2_BE4, B_DPD_CBW80_TH2_3_BE4, 0x2, mac_idx);
+	rtw89_write32_idx(rtwdev, R_DPD_CBW_TH2_BE4, B_DPD_CBW80_TH2_4_BE4, 0x2, mac_idx);
+	rtw89_write32_idx(rtwdev, R_DPD_CBW_TH2_BE4, B_DPD_CBW80_TH2_5_BE4, 0x2, mac_idx);
+	rtw89_write32_idx(rtwdev, R_DPD_CBW_TH2_BE4, B_DPD_CBW80_TH2_6_BE4, 0x2, mac_idx);
+	rtw89_write32_idx(rtwdev, R_DPD_CBW_TH2_BE4, B_DPD_CBW80_TH2_7_BE4, 0x2, mac_idx);
+	/* CIM3K */
+	rtw89_write32_idx(rtwdev, R_COMP_CIM3K_BE4, B_COMP_CIM3K_TH2_BE4, 0x2, mac_idx);
+}
+
+static void rtw89_phy_bb_wrap_tx_rfsi_scenario_def(struct rtw89_dev *rtwdev,
+						   enum rtw89_mac_idx mac_idx)
+{
+	rtw89_write32_idx(rtwdev, R_RFSI_CT_DEF_BE4, B_RFSI_CT_ER_BE4, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_RFSI_CT_DEF_BE4, B_RFSI_CT_SUBF_BE4, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_RFSI_CT_DEF_BE4, B_RFSI_CT_FTM_BE4, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_RFSI_CT_DEF_BE4, B_RFSI_CT_SENS_BE4, 0x0, mac_idx);
+
+	rtw89_write32_idx(rtwdev, R_FBTB_CT_DEF_BE4, B_FBTB_CT_DEF_BE, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_FBTB_CT_DEF_BE4, B_FBTB_CT_PB_BE4, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_FBTB_CT_DEF_BE4, B_FBTB_CT_DL_WO_BE4, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_FBTB_CT_DEF_BE4, B_FBTB_CT_DL_BF_BE4, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_FBTB_CT_DEF_BE4, B_FBTB_CT_MUMIMO_BE4, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_FBTB_CT_DEF_BE4, B_FBTB_CT_FTM_BE4, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_FBTB_CT_DEF_BE4, B_FBTB_CT_SENS_BE4, 0x0, mac_idx);
+}
+
+static void rtw89_phy_bb_wrap_tx_rfsi_qam_comp_val(struct rtw89_dev *rtwdev,
+						   enum rtw89_mac_idx mac_idx)
+{
+	rtw89_write32_idx(rtwdev, R_QAM_COMP_TH0_BE4, MASKLWORD, 0x4010, mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_COMP_TH0_BE4, MASKHWORD, 0x4410, mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_COMP_TH1_BE4, MASKLWORD, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_COMP_TH1_BE4, MASKHWORD, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_COMP_TH2_BE4, MASKLWORD, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_COMP_TH2_BE4, MASKHWORD, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_COMP_TH3_BE4, MASKLWORD, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_COMP_TH3_BE4, MASKHWORD, 0x0, mac_idx);
+
+	rtw89_write32_idx(rtwdev, R_QAM_COMP_TH4_BE4, B_QAM_COMP_TH4_L, 0x8, mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_COMP_TH4_BE4, B_QAM_COMP_TH4_M, 0x8, mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_COMP_TH4_BE4, B_QAM_COMP_TH4_H, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_COMP_TH5_BE4, B_QAM_COMP_TH5_L, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_COMP_TH5_BE4, B_QAM_COMP_TH5_M, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_COMP_TH5_BE4, B_QAM_COMP_TH5_H, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_COMP_TH6_BE4, B_QAM_COMP_TH6_L, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_COMP_TH6_BE4, B_QAM_COMP_TH6_M, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_COMP_TH4_BE4, B_QAM_COMP_TH4_2L, 0x8, mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_COMP_TH4_BE4, B_QAM_COMP_TH4_2M, 0x8, mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_COMP_TH4_BE4, B_QAM_COMP_TH4_2H, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_COMP_TH5_BE4, B_QAM_COMP_TH5_2L, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_COMP_TH5_BE4, B_QAM_COMP_TH5_2M, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_COMP_TH5_BE4, B_QAM_COMP_TH5_2H, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_COMP_TH6_BE4, B_QAM_COMP_TH6_2L, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_QAM_COMP_TH6_BE4, B_QAM_COMP_TH6_2M, 0x0, mac_idx);
+
+	rtw89_write32_idx(rtwdev, R_OW_VAL_0_BE4, MASKLWORD, 0x4010, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OW_VAL_0_BE4, MASKHWORD, 0x4010, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OW_VAL_1_BE4, MASKLWORD, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OW_VAL_1_BE4, MASKHWORD, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OW_VAL_2_BE4, MASKLWORD, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OW_VAL_2_BE4, MASKHWORD, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OW_VAL_3_BE4, MASKLWORD, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OW_VAL_3_BE4, MASKHWORD, 0x0, mac_idx);
+}
+
+static void rtw89_phy_bb_set_oob_dpd_qam_comp_val(struct rtw89_dev *rtwdev,
+						  enum rtw89_mac_idx mac_idx)
+{
+	rtw89_write32_idx(rtwdev, R_OOB_CBW20_BE4, B_OOB_CBW20_CCK0_BE4, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW20_BE4, B_OOB_CBW20_CCK1_BE4, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW20_BE4, B_OOB_CBW20_CCK2_BE4, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW20_BE4, B_OOB_CBW20_CCK3_BE4, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW20_BE4, B_OOB_CBW20_CCK4_BE4, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW20_BE4, B_OOB_CBW20_CCK5_BE4, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW20_BE4, B_OOB_CBW20_CCK6_BE4, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW20_BE4, B_OOB_CBW20_CCK7_BE4, 0x0, mac_idx);
+
+	rtw89_write32_idx(rtwdev, R_OOB_CBW40_BE4, B_OOB_CBW40_CCK0_BE4, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW40_BE4, B_OOB_CBW40_CCK1_BE4, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW40_BE4, B_OOB_CBW40_CCK2_BE4, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW40_BE4, B_OOB_CBW40_CCK3_BE4, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW40_BE4, B_OOB_CBW40_CCK4_BE4, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW40_BE4, B_OOB_CBW40_CCK5_BE4, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW40_BE4, B_OOB_CBW40_CCK6_BE4, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW40_BE4, B_OOB_CBW40_CCK7_BE4, 0x0, mac_idx);
+
+	rtw89_write32_idx(rtwdev, R_OOB_CBW20_BE4, B_OOB_CBW20_TH0_BE4, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW20_BE4, B_OOB_CBW20_TH1_BE4, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW20_BE4, B_OOB_CBW20_TH2_BE4, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW20_BE4, B_OOB_CBW20_TH3_BE4, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW20_BE4, B_OOB_CBW20_TH4_BE4, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW20_BE4, B_OOB_CBW20_TH5_BE4, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW20_BE4, B_OOB_CBW20_TH6_BE4, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW20_BE4, B_OOB_CBW20_TH7_BE4, 0x0, mac_idx);
+
+	rtw89_write32_idx(rtwdev, R_OOB_CBW40_BE4, B_OOB_CBW40_TH0_BE4, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW40_BE4, B_OOB_CBW40_TH1_BE4, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW40_BE4, B_OOB_CBW40_TH2_BE4, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW40_BE4, B_OOB_CBW40_TH3_BE4, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW40_BE4, B_OOB_CBW40_TH4_BE4, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW40_BE4, B_OOB_CBW40_TH5_BE4, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW40_BE4, B_OOB_CBW40_TH6_BE4, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW40_BE4, B_OOB_CBW40_TH7_BE4, 0x0, mac_idx);
+
+	rtw89_write32_idx(rtwdev, R_OOB_CBW80_BE4, B_OOB_CBW80_TH0_BE4, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW80_BE4, B_OOB_CBW80_TH1_BE4, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW80_BE4, B_OOB_CBW80_TH2_BE4, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW80_BE4, B_OOB_CBW80_TH3_BE4, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW80_BE4, B_OOB_CBW80_TH4_BE4, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW80_BE4, B_OOB_CBW80_TH5_BE4, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW80_BE4, B_OOB_CBW80_TH6_BE4, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW80_BE4, B_OOB_CBW80_TH7_BE4, 0x0, mac_idx);
+
+	rtw89_write32_idx(rtwdev, R_OOB_CBW40_BE4, B_OOB_CBW20_OW0_BE4, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW40_BE4, B_OOB_CBW20_OW1_BE4, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW40_BE4, B_OOB_CBW20_OW2_BE4, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW40_BE4, B_OOB_CBW20_OW3_BE4, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW40_BE4, B_OOB_CBW20_OW4_BE4, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW40_BE4, B_OOB_CBW20_OW5_BE4, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW40_BE4, B_OOB_CBW20_OW6_BE4, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW40_BE4, B_OOB_CBW20_OW7_BE4, 0x0, mac_idx);
+
+	rtw89_write32_idx(rtwdev, R_OOB_CBW40_BE4, B_OOB_CBW40_OW0_BE4, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW40_BE4, B_OOB_CBW40_OW1_BE4, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW40_BE4, B_OOB_CBW40_OW2_BE4, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW40_BE4, B_OOB_CBW40_OW3_BE4, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW40_BE4, B_OOB_CBW40_OW4_BE4, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW40_BE4, B_OOB_CBW40_OW5_BE4, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW40_BE4, B_OOB_CBW40_OW6_BE4, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW40_BE4, B_OOB_CBW40_OW7_BE4, 0x0, mac_idx);
+
+	rtw89_write32_idx(rtwdev, R_OOB_CBW80_BE4, B_OOB_CBW80_OW0_BE4, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW80_BE4, B_OOB_CBW80_OW1_BE4, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW80_BE4, B_OOB_CBW80_OW2_BE4, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW80_BE4, B_OOB_CBW80_OW3_BE4, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW80_BE4, B_OOB_CBW80_OW4_BE4, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW80_BE4, B_OOB_CBW80_OW5_BE4, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW80_BE4, B_OOB_CBW80_OW6_BE4, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_OOB_CBW80_BE4, B_OOB_CBW80_OW7_BE4, 0x0, mac_idx);
+}
+
+static void rtw89_phy_bb_set_mdpd_qam_comp_val(struct rtw89_dev *rtwdev,
+					       enum rtw89_mac_idx mac_idx)
+{
+	rtw89_write32_idx(rtwdev, R_DPD_CBW160_BE4, B_DPD_CBW160_TH0_BE4, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_DPD_CBW160_BE4, B_DPD_CBW160_TH1_BE4, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_DPD_CBW160_BE4, B_DPD_CBW160_TH2_BE4, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_DPD_CBW160_BE4, B_DPD_CBW160_TH3_BE4, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_DPD_CBW160_BE4, B_DPD_CBW160_TH4_BE4, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_DPD_CBW160_BE4, B_DPD_CBW160_TH5_BE4, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_DPD_CBW160_BE4, B_DPD_CBW160_TH6_BE4, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_DPD_CBW160_BE4, B_DPD_CBW160_TH7_BE4, 0x0, mac_idx);
+
+	rtw89_write32_idx(rtwdev, R_DPD_CBW160_BE4, B_DPD_CBW160_OW0_BE4, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_DPD_CBW160_BE4, B_DPD_CBW160_OW1_BE4, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_DPD_CBW160_BE4, B_DPD_CBW160_OW2_BE4, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_DPD_CBW160_BE4, B_DPD_CBW160_OW3_BE4, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_DPD_CBW160_BE4, B_DPD_CBW160_OW4_BE4, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_DPD_CBW160_BE4, B_DPD_CBW160_OW5_BE4, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_DPD_CBW160_BE4, B_DPD_CBW160_OW6_BE4, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_DPD_CBW160_BE4, B_DPD_CBW160_OW7_BE4, 0x0, mac_idx);
+}
+
+static void rtw89_phy_bb_set_cim3k_val(struct rtw89_dev *rtwdev,
+				       enum rtw89_mac_idx mac_idx)
+{
+	rtw89_write32_idx(rtwdev, R_COMP_CIM3K_BE4, B_COMP_CIM3K_TH_BE4, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_COMP_CIM3K_BE4, B_COMP_CIM3K_OW_BE4, 0x0, mac_idx);
+	rtw89_write32_idx(rtwdev, R_COMP_CIM3K_BE4, B_COMP_CIM3K_NONBE_BE4, 0x1, mac_idx);
+	rtw89_write32_idx(rtwdev, R_COMP_CIM3K_BE4, B_COMP_CIM3K_BANDEDGE_BE4, 0x1, mac_idx);
+}
+
+static void rtw89_phy_bb_wrap_tx_rfsi_ctrl_init(struct rtw89_dev *rtwdev,
+						enum rtw89_mac_idx mac_idx)
+{
+	enum rtw89_phy_idx phy_idx = mac_idx != RTW89_MAC_0 ? RTW89_PHY_1 : RTW89_PHY_0;
+	enum rtw89_core_chip_id chip_id = rtwdev->chip->chip_id;
+	const struct rtw89_chan *chan;
+
+	if (chip_id != RTL8922D)
+		return;
+
+	rtw89_phy_bb_wrap_tx_rfsi_qam_comp_th_init(rtwdev, mac_idx);
+	rtw89_phy_bb_wrap_tx_rfsi_scenario_def(rtwdev, mac_idx);
+	rtw89_phy_bb_wrap_tx_rfsi_qam_comp_val(rtwdev, mac_idx);
+	rtw89_phy_bb_set_oob_dpd_qam_comp_val(rtwdev, mac_idx);
+	rtw89_phy_bb_set_mdpd_qam_comp_val(rtwdev, mac_idx);
+	rtw89_phy_bb_set_cim3k_val(rtwdev, mac_idx);
+
+	rtw89_phy_bb_wrap_set_rfsi_ct_opt(rtwdev, phy_idx);
+
+	chan = rtw89_mgnt_chan_get(rtwdev, phy_idx);
+	if (chan)
+		rtw89_phy_bb_wrap_set_rfsi_bandedge_ch(rtwdev, chan, phy_idx);
+}
+
 static void rtw89_phy_bb_wrap_ul_pwr(struct rtw89_dev *rtwdev)
 {
 	enum rtw89_core_chip_id chip_id = rtwdev->chip->chip_id;
@@ -545,6 +872,7 @@ static void __rtw89_phy_bb_wrap_init_be(struct rtw89_dev *rtwdev,
 	rtw89_phy_bb_wrap_force_cr_init(rtwdev, mac_idx);
 	rtw89_phy_bb_wrap_ftm_init(rtwdev, mac_idx);
 	rtw89_phy_bb_wrap_tpu_set_all(rtwdev, mac_idx);
+	rtw89_phy_bb_wrap_tx_rfsi_ctrl_init(rtwdev, mac_idx);
 	rtw89_phy_bb_wrap_ul_pwr(rtwdev);
 }
 
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index d4f90b22e010..b7536dda0101 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -9917,6 +9917,210 @@
 #define R_TSSI_K_P1 0xE7A0
 #define B_TSSI_K_OFDM_P1 GENMASK(29, 20)
 
+#define R_COMP_CIM3K_BE4 0x11998
+#define B_COMP_CIM3K_OW_BE4 BIT(1)
+#define B_COMP_CIM3K_TH_BE4 BIT(2)
+#define B_COMP_CIM3K_TH2_BE4 GENMASK(5, 3)
+#define B_COMP_CIM3K_TXPWR_EN_BE4 BIT(6)
+#define B_COMP_CIM3K_NONBE_BE4 BIT(7)
+#define B_COMP_CIM3K_BANDEDGE_BE4 BIT(8)
+#define R_DPD_CBW160_BE4 0x119B4
+#define B_DPD_CBW160_TH0_BE4 BIT(0)
+#define B_DPD_CBW160_TH1_BE4 BIT(1)
+#define B_DPD_CBW160_TH2_BE4 BIT(2)
+#define B_DPD_CBW160_TH3_BE4 BIT(3)
+#define B_DPD_CBW160_TH4_BE4 BIT(4)
+#define B_DPD_CBW160_TH5_BE4 BIT(5)
+#define B_DPD_CBW160_TH6_BE4 BIT(6)
+#define B_DPD_CBW160_TH7_BE4 BIT(7)
+#define B_DPD_CBW160_OW0_BE4 BIT(8)
+#define B_DPD_CBW160_OW1_BE4 BIT(9)
+#define B_DPD_CBW160_OW2_BE4 BIT(10)
+#define B_DPD_CBW160_OW3_BE4 BIT(11)
+#define B_DPD_CBW160_OW4_BE4 BIT(12)
+#define B_DPD_CBW160_OW5_BE4 BIT(13)
+#define B_DPD_CBW160_OW6_BE4 BIT(14)
+#define B_DPD_CBW160_OW7_BE4 BIT(15)
+#define R_OOB_CBW20_BE4 0x119B4
+#define B_OOB_CBW20_CCK0_BE4 BIT(16)
+#define B_OOB_CBW20_CCK1_BE4 BIT(17)
+#define B_OOB_CBW20_CCK2_BE4 BIT(18)
+#define B_OOB_CBW20_CCK3_BE4 BIT(19)
+#define B_OOB_CBW20_CCK4_BE4 BIT(20)
+#define B_OOB_CBW20_CCK5_BE4 BIT(21)
+#define B_OOB_CBW20_CCK6_BE4 BIT(22)
+#define B_OOB_CBW20_CCK7_BE4 BIT(23)
+#define B_OOB_CBW20_TH0_BE4 BIT(24)
+#define B_OOB_CBW20_TH1_BE4 BIT(25)
+#define B_OOB_CBW20_TH2_BE4 BIT(26)
+#define B_OOB_CBW20_TH3_BE4 BIT(27)
+#define B_OOB_CBW20_TH4_BE4 BIT(28)
+#define B_OOB_CBW20_TH5_BE4 BIT(29)
+#define B_OOB_CBW20_TH6_BE4 BIT(30)
+#define B_OOB_CBW20_TH7_BE4 BIT(31)
+#define R_OOB_CBW40_BE4 0x119B8
+#define B_OOB_CBW20_OW0_BE4 BIT(0)
+#define B_OOB_CBW20_OW1_BE4 BIT(1)
+#define B_OOB_CBW20_OW2_BE4 BIT(2)
+#define B_OOB_CBW20_OW3_BE4 BIT(3)
+#define B_OOB_CBW20_OW4_BE4 BIT(4)
+#define B_OOB_CBW20_OW5_BE4 BIT(5)
+#define B_OOB_CBW20_OW6_BE4 BIT(6)
+#define B_OOB_CBW20_OW7_BE4 BIT(7)
+#define B_OOB_CBW40_CCK0_BE4 BIT(8)
+#define B_OOB_CBW40_CCK1_BE4 BIT(9)
+#define B_OOB_CBW40_CCK2_BE4 BIT(10)
+#define B_OOB_CBW40_CCK3_BE4 BIT(11)
+#define B_OOB_CBW40_CCK4_BE4 BIT(12)
+#define B_OOB_CBW40_CCK5_BE4 BIT(13)
+#define B_OOB_CBW40_CCK6_BE4 BIT(14)
+#define B_OOB_CBW40_CCK7_BE4 BIT(15)
+#define B_OOB_CBW40_TH0_BE4 BIT(16)
+#define B_OOB_CBW40_TH1_BE4 BIT(17)
+#define B_OOB_CBW40_TH2_BE4 BIT(18)
+#define B_OOB_CBW40_TH3_BE4 BIT(19)
+#define B_OOB_CBW40_TH4_BE4 BIT(20)
+#define B_OOB_CBW40_TH5_BE4 BIT(21)
+#define B_OOB_CBW40_TH6_BE4 BIT(22)
+#define B_OOB_CBW40_TH7_BE4 BIT(23)
+#define B_OOB_CBW40_OW0_BE4 BIT(24)
+#define B_OOB_CBW40_OW1_BE4 BIT(25)
+#define B_OOB_CBW40_OW2_BE4 BIT(26)
+#define B_OOB_CBW40_OW3_BE4 BIT(27)
+#define B_OOB_CBW40_OW4_BE4 BIT(28)
+#define B_OOB_CBW40_OW5_BE4 BIT(29)
+#define B_OOB_CBW40_OW6_BE4 BIT(30)
+#define B_OOB_CBW40_OW7_BE4 BIT(31)
+#define R_OOB_CBW80_BE4 0x119BC
+#define B_OOB_CBW80_TH0_BE4 BIT(0)
+#define B_OOB_CBW80_TH1_BE4 BIT(1)
+#define B_OOB_CBW80_TH2_BE4 BIT(2)
+#define B_OOB_CBW80_TH3_BE4 BIT(3)
+#define B_OOB_CBW80_TH4_BE4 BIT(4)
+#define B_OOB_CBW80_TH5_BE4 BIT(5)
+#define B_OOB_CBW80_TH6_BE4 BIT(6)
+#define B_OOB_CBW80_TH7_BE4 BIT(7)
+#define B_OOB_CBW80_OW0_BE4 BIT(8)
+#define B_OOB_CBW80_OW1_BE4 BIT(9)
+#define B_OOB_CBW80_OW2_BE4 BIT(10)
+#define B_OOB_CBW80_OW3_BE4 BIT(11)
+#define B_OOB_CBW80_OW4_BE4 BIT(12)
+#define B_OOB_CBW80_OW5_BE4 BIT(13)
+#define B_OOB_CBW80_OW6_BE4 BIT(14)
+#define B_OOB_CBW80_OW7_BE4 BIT(15)
+#define R_DPD_DBW160_TH0_BE4 0x119BC
+#define B_DPD_DBW160_TH0_0_BE4 GENMASK(18, 16)
+#define B_DPD_DBW160_TH0_1_BE4 GENMASK(21, 19)
+#define B_DPD_DBW160_TH0_2_BE4 GENMASK(24, 22)
+#define B_DPD_DBW160_TH0_3_BE4 GENMASK(27, 25)
+#define B_DPD_DBW160_TH0_4_BE4 GENMASK(30, 28)
+#define R_DPD_DBW160_TH1_BE4 0x119C0
+#define B_DPD_DBW160_TH1_5_BE4 GENMASK(2, 0)
+#define B_DPD_DBW160_TH1_6_BE4 GENMASK(5, 3)
+#define B_DPD_DBW160_TH1_7_BE4 GENMASK(8, 6)
+#define R_DPD_CBW_TH0_BE4 0x119C0
+#define B_DPD_CBW20_TH0_0_BE4 GENMASK(11, 9)
+#define B_DPD_CBW20_TH0_1_BE4 GENMASK(14, 12)
+#define B_DPD_CBW20_TH0_2_BE4 GENMASK(17, 15)
+#define B_DPD_CBW20_TH0_3_BE4 GENMASK(20, 18)
+#define B_DPD_CBW20_TH0_4_BE4 GENMASK(23, 21)
+#define B_DPD_CBW20_TH0_5_BE4 GENMASK(26, 24)
+#define B_DPD_CBW20_TH0_6_BE4 GENMASK(29, 27)
+#define R_DPD_CBW_TH1_BE4 0x119C4
+#define B_DPD_CBW20_TH1_7_BE4 GENMASK(2, 0)
+#define B_DPD_CBW40_TH1_0_BE4 GENMASK(5, 3)
+#define B_DPD_CBW40_TH1_1_BE4 GENMASK(8, 6)
+#define B_DPD_CBW40_TH1_2_BE4 GENMASK(11, 9)
+#define B_DPD_CBW40_TH1_3_BE4 GENMASK(14, 12)
+#define B_DPD_CBW40_TH1_4_BE4 GENMASK(17, 15)
+#define B_DPD_CBW40_TH1_5_BE4 GENMASK(20, 18)
+#define B_DPD_CBW40_TH1_6_BE4 GENMASK(23, 21)
+#define B_DPD_CBW40_TH1_7_BE4 GENMASK(26, 24)
+#define B_DPD_CBW80_TH1_0_BE4 GENMASK(29, 27)
+#define R_DPD_CBW_TH2_BE4 0x119C8
+#define B_DPD_CBW80_TH2_1_BE4 GENMASK(2, 0)
+#define B_DPD_CBW80_TH2_2_BE4 GENMASK(5, 3)
+#define B_DPD_CBW80_TH2_3_BE4 GENMASK(8, 6)
+#define B_DPD_CBW80_TH2_4_BE4 GENMASK(11, 9)
+#define B_DPD_CBW80_TH2_5_BE4 GENMASK(14, 12)
+#define B_DPD_CBW80_TH2_6_BE4 GENMASK(17, 15)
+#define B_DPD_CBW80_TH2_7_BE4 GENMASK(20, 18)
+#define R_QAM_TH0_BE4 0x119E4
+#define B_QAM_TH0_0_BE4 GENMASK(18, 16)
+#define B_QAM_TH0_1_BE4 GENMASK(21, 19)
+#define B_QAM_TH0_2_BE4 GENMASK(24, 22)
+#define B_QAM_TH0_3_BE4 GENMASK(27, 25)
+#define B_QAM_TH0_4_BE4 GENMASK(30, 28)
+#define R_QAM_TH1_BE4 0x119E8
+#define B_QAM_TH1_0_BE4 GENMASK(2, 0)
+#define B_QAM_TH1_1_BE4 GENMASK(5, 3)
+#define B_QAM_TH1_2_BE4 GENMASK(8, 6)
+#define B_QAM_TH1_3_BE4 GENMASK(11, 9)
+#define B_QAM_TH1_4_BE4 GENMASK(14, 12)
+#define B_QAM_TH1_5_BE4 GENMASK(17, 15)
+#define B_QAM_TH1_6_BE4 GENMASK(20, 18)
+#define B_QAM_TH1_7_BE4 GENMASK(23, 21)
+#define B_QAM_TH1_8_BE4 GENMASK(26, 24)
+#define B_QAM_TH1_9_BE4 GENMASK(29, 27)
+#define R_QAM_TH2_BE4 0x119EC
+#define B_QAM_TH2_0_BE4 GENMASK(2, 0)
+#define B_QAM_TH2_1_BE4 GENMASK(5, 3)
+#define B_QAM_TH2_2_BE4 GENMASK(8, 6)
+#define B_QAM_TH2_3_BE4 GENMASK(11, 9)
+#define B_QAM_TH2_4_BE4 GENMASK(14, 12)
+#define B_QAM_TH2_5_BE4 GENMASK(17, 15)
+#define B_QAM_TH2_6_BE4 GENMASK(20, 18)
+#define B_QAM_TH2_7_BE4 GENMASK(23, 21)
+#define B_QAM_TH2_8_BE4 GENMASK(26, 24)
+#define R_RFSI_CT_DEF_BE4 0x119F0
+#define B_RFSI_CT_ER_BE4 GENMASK(18, 15)
+#define B_RFSI_CT_SUBF_BE4 GENMASK(22, 19)
+#define B_RFSI_CT_FTM_BE4 GENMASK(26, 23)
+#define B_RFSI_CT_SENS_BE4 GENMASK(30, 27)
+#define R_FBTB_CT_DEF_BE4 0x119F4
+#define B_FBTB_CT_DEF_BE GENMASK(3, 0)
+#define B_FBTB_CT_PB_BE4 GENMASK(7, 4)
+#define B_FBTB_CT_DL_WO_BE4 GENMASK(11, 8)
+#define B_FBTB_CT_DL_BF_BE4 GENMASK(15, 12)
+#define B_FBTB_CT_MUMIMO_BE4 GENMASK(19, 16)
+#define B_FBTB_CT_FTM_BE4 GENMASK(23, 20)
+#define B_FBTB_CT_SENS_BE4 GENMASK(27, 24)
+#define R_RFSI_CT_OPT_0_BE4 0x11A94
+#define R_RFSI_CT_OPT_8_BE4 0x11A98
+#define R_QAM_COMP_TH0_BE4 0x11A9C
+#define R_QAM_COMP_TH1_BE4 0x11AA0
+#define R_QAM_COMP_TH2_BE4 0x11AA4
+#define R_QAM_COMP_TH3_BE4 0x11AA8
+#define R_QAM_COMP_TH4_BE4 0x11ABC
+#define B_QAM_COMP_TH4_L GENMASK(4, 0)
+#define B_QAM_COMP_TH4_M GENMASK(14, 10)
+#define B_QAM_COMP_TH4_H GENMASK(24, 20)
+#define B_QAM_COMP_TH4_2L GENMASK(9, 5)
+#define B_QAM_COMP_TH4_2M GENMASK(19, 15)
+#define B_QAM_COMP_TH4_2H GENMASK(29, 25)
+#define R_QAM_COMP_TH5_BE4 0x11AC0
+#define B_QAM_COMP_TH5_L GENMASK(4, 0)
+#define B_QAM_COMP_TH5_M GENMASK(14, 10)
+#define B_QAM_COMP_TH5_H GENMASK(24, 20)
+#define B_QAM_COMP_TH5_2L GENMASK(9, 5)
+#define B_QAM_COMP_TH5_2M GENMASK(19, 15)
+#define B_QAM_COMP_TH5_2H GENMASK(29, 25)
+#define R_QAM_COMP_TH6_BE4 0x11AC4
+#define B_QAM_COMP_TH6_L GENMASK(4, 0)
+#define B_QAM_COMP_TH6_M GENMASK(14, 10)
+#define B_QAM_COMP_TH6_2L GENMASK(9, 5)
+#define B_QAM_COMP_TH6_2M GENMASK(19, 15)
+#define R_OW_VAL_0_BE4 0x11AAC
+#define R_OW_VAL_1_BE4 0x11AB0
+#define R_OW_VAL_2_BE4 0x11AB4
+#define R_OW_VAL_3_BE4 0x11AB8
+#define R_BANDEDGE_DBWX_BE4 0x11ACC
+#define B_BANDEDGE_DBW20_BE4 BIT(29)
+#define B_BANDEDGE_DBW40_BE4 BIT(30)
+#define B_BANDEDGE_DBW80_BE4 BIT(31)
+#define R_BANDEDGE_DBWY_BE4 0x11AD0
+#define B_BANDEDGE_DBW160_BE4 BIT(0)
+
 #define R_CHINFO_SEG_BE4 0x200B4
 #define B_CHINFO_SEG_LEN_BE4 GENMASK(12, 10)
 #define R_STS_HDR2_PARSING_BE4 0x2070C
@@ -9949,6 +10153,9 @@
 #define B_IFS_T3_HIS_BE4 GENMASK(15, 0)
 #define B_IFS_T4_HIS_BE4 GENMASK(31, 16)
 
+#define R_TX_CFR_MANUAL_EN_BE4 0x2483C
+#define B_TX_CFR_MANUAL_EN_BE4_M BIT(30)
+
 #define R_CHINFO_OPT_BE4 0x267C8
 #define B_CHINFO_OPT_BE4 GENMASK(14, 13)
 #define R_CHINFO_NX_BE4 0x267D0
-- 
2.25.1


