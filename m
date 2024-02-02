Return-Path: <linux-wireless+bounces-2982-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D84A9846656
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Feb 2024 04:07:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0873B1C26230
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Feb 2024 03:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0645C8E1;
	Fri,  2 Feb 2024 03:07:34 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81225BE5C
	for <linux-wireless@vger.kernel.org>; Fri,  2 Feb 2024 03:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706843254; cv=none; b=hiJYCDDuuHKtD5RY0mlP1+3PnYiXEARjV2IOJEjrXrQYz2ph94SWHhOQ0T6GhZf8i/ezrw4rADgQXHjHzY8fbHVPC+sJBRW7hLgBDxtyoA68uOfnixLNDOoNv2/LwPD/rxm8KszRuB9mYicKiJ0kKUswoDi8x6tlhG4Md8CEViQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706843254; c=relaxed/simple;
	bh=yU8uVo6YhYexjqZBwAYxEXoA8QQVHtP7rkbmcw5edz8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eCDjNqCUABt00kl4sNAEgOHIGZJLxLe4sow3WZTTPVNCh/xpSzgBa7OmLrcgAxWQqzYRABBuuhr3QKpAuNsPQVCoF43bO7pKG57N1su3ARsVzFdSycSTRi2Can54WvatLCWz/euGtPir2JpOUaFEcpfVo5LSoF3h90nApMZuVvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 41237P7F01863019, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 41237P7F01863019
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 2 Feb 2024 11:07:25 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Fri, 2 Feb 2024 11:07:26 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 2 Feb
 2024 11:07:25 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH 02/11] wifi: rtw89: rfk: send channel information to firmware for RF calibrations
Date: Fri, 2 Feb 2024 11:06:33 +0800
Message-ID: <20240202030642.108385-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240202030642.108385-1-pkshih@realtek.com>
References: <20240202030642.108385-1-pkshih@realtek.com>
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

We are going to do RF calibrations in firmware, so driver needs to provide
channel information for calibrations, which can do the same things as
they did in driver.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h | 11 ++--
 drivers/net/wireless/realtek/rtw89/fw.c   | 73 +++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/fw.h   | 42 +++++++++++++
 drivers/net/wireless/realtek/rtw89/reg.h  |  2 +
 4 files changed, 124 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index d88a6b9bc4e9..e049f7b5168b 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4282,15 +4282,18 @@ struct rtw89_dack_info {
 	bool msbk_timeout[RTW89_DACK_PATH_NR];
 };
 
-#define RTW89_IQK_CHS_NR 2
-#define RTW89_IQK_PATH_NR 4
+#define RTW89_RFK_CHS_NR 3
 
 struct rtw89_rfk_mcc_info {
-	u8 ch[RTW89_IQK_CHS_NR];
-	u8 band[RTW89_IQK_CHS_NR];
+	u8 ch[RTW89_RFK_CHS_NR];
+	u8 band[RTW89_RFK_CHS_NR];
+	u8 bw[RTW89_RFK_CHS_NR];
 	u8 table_idx;
 };
 
+#define RTW89_IQK_CHS_NR 2
+#define RTW89_IQK_PATH_NR 4
+
 struct rtw89_lck_info {
 	u8 thermal[RF_PATH_MAX];
 };
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 2f3f2b503507..5bd3d08a5d25 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -4520,6 +4520,79 @@ int rtw89_fw_h2c_rf_ntfy_mcc(struct rtw89_dev *rtwdev)
 }
 EXPORT_SYMBOL(rtw89_fw_h2c_rf_ntfy_mcc);
 
+int rtw89_fw_h2c_rf_pre_ntfy(struct rtw89_dev *rtwdev,
+			     enum rtw89_phy_idx phy_idx)
+{
+	struct rtw89_rfk_mcc_info *rfk_mcc = &rtwdev->rfk_mcc;
+	struct rtw89_fw_h2c_rfk_pre_info *h2c;
+	u8 tbl_sel = rfk_mcc->table_idx;
+	u32 len = sizeof(*h2c);
+	struct sk_buff *skb;
+	u8 tbl, path;
+	u32 val32;
+	int ret;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for h2c rfk_pre_ntfy\n");
+		return -ENOMEM;
+	}
+	skb_put(skb, len);
+	h2c = (struct rtw89_fw_h2c_rfk_pre_info *)skb->data;
+
+	h2c->mlo_mode = cpu_to_le32(rtwdev->mlo_dbcc_mode);
+
+	BUILD_BUG_ON(NUM_OF_RTW89_FW_RFK_TBL > RTW89_RFK_CHS_NR);
+
+	for (tbl = 0; tbl < NUM_OF_RTW89_FW_RFK_TBL; tbl++) {
+		for (path = 0; path < NUM_OF_RTW89_FW_RFK_PATH; path++) {
+			h2c->dbcc.ch[path][tbl] = cpu_to_le32(rfk_mcc->ch[tbl]);
+			h2c->dbcc.band[path][tbl] = cpu_to_le32(rfk_mcc->band[tbl]);
+		}
+	}
+
+	for (path = 0; path < NUM_OF_RTW89_FW_RFK_PATH; path++) {
+		h2c->tbl.cur_ch[path] = cpu_to_le32(rfk_mcc->ch[tbl_sel]);
+		h2c->tbl.cur_band[path] = cpu_to_le32(rfk_mcc->band[tbl_sel]);
+	}
+
+	h2c->phy_idx = cpu_to_le32(phy_idx);
+	h2c->cur_band = cpu_to_le32(rfk_mcc->band[tbl_sel]);
+	h2c->cur_bw = cpu_to_le32(rfk_mcc->bw[tbl_sel]);
+	h2c->cur_center_ch = cpu_to_le32(rfk_mcc->ch[tbl_sel]);
+
+	val32 = rtw89_phy_read32_mask(rtwdev, R_COEF_SEL, B_COEF_SEL_IQC_V1);
+	h2c->ktbl_sel0 = cpu_to_le32(val32);
+	val32 = rtw89_phy_read32_mask(rtwdev, R_COEF_SEL_C1, B_COEF_SEL_IQC_V1);
+	h2c->ktbl_sel1 = cpu_to_le32(val32);
+	val32 = rtw89_read_rf(rtwdev, RF_PATH_A, RR_CFGCH, RFREG_MASK);
+	h2c->rfmod0 = cpu_to_le32(val32);
+	val32 = rtw89_read_rf(rtwdev, RF_PATH_B, RR_CFGCH, RFREG_MASK);
+	h2c->rfmod1 = cpu_to_le32(val32);
+
+	if (rtw89_is_mlo_1_1(rtwdev))
+		h2c->mlo_1_1 = cpu_to_le32(1);
+
+	h2c->rfe_type = cpu_to_le32(rtwdev->efuse.rfe_type);
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_OUTSRC, H2C_CL_OUTSRC_RF_FW_RFK,
+			      H2C_FUNC_RFK_PRE_NOTIFY, 0, 0,
+			      len);
+
+	ret = rtw89_h2c_tx(rtwdev, skb, false);
+	if (ret) {
+		rtw89_err(rtwdev, "failed to send h2c\n");
+		goto fail;
+	}
+
+	return 0;
+fail:
+	dev_kfree_skb_any(skb);
+
+	return ret;
+}
+
 int rtw89_fw_h2c_raw_with_hdr(struct rtw89_dev *rtwdev,
 			      u8 h2c_class, u8 h2c_func, u8 *buf, u16 len,
 			      bool rack, bool dack)
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 9a2c50c35f2a..d9316b66ab76 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -3932,6 +3932,11 @@ enum rtw89_mcc_h2c_func {
 #define H2C_CL_OUTSRC_RF_REG_B		0x9
 #define H2C_CL_OUTSRC_RF_FW_NOTIFY	0xa
 #define H2C_FUNC_OUTSRC_RF_GET_MCCCH	0x2
+#define H2C_CL_OUTSRC_RF_FW_RFK		0xb
+
+enum rtw89_rfk_offload_h2c_func {
+	H2C_FUNC_RFK_PRE_NOTIFY = 0x8,
+};
 
 struct rtw89_fw_h2c_rf_get_mccch {
 	__le32 ch_0;
@@ -3942,6 +3947,41 @@ struct rtw89_fw_h2c_rf_get_mccch {
 	__le32 current_band_type;
 } __packed;
 
+#define NUM_OF_RTW89_FW_RFK_PATH 2
+#define NUM_OF_RTW89_FW_RFK_TBL 3
+
+struct rtw89_fw_h2c_rfk_pre_info {
+	struct {
+		__le32 ch[NUM_OF_RTW89_FW_RFK_PATH][NUM_OF_RTW89_FW_RFK_TBL];
+		__le32 band[NUM_OF_RTW89_FW_RFK_PATH][NUM_OF_RTW89_FW_RFK_TBL];
+	} __packed dbcc;
+
+	__le32 mlo_mode;
+	struct {
+		__le32 cur_ch[NUM_OF_RTW89_FW_RFK_PATH];
+		__le32 cur_band[NUM_OF_RTW89_FW_RFK_PATH];
+	} __packed tbl;
+
+	__le32 phy_idx;
+	__le32 cur_band;
+	__le32 cur_bw;
+	__le32 cur_center_ch;
+
+	__le32 ktbl_sel0;
+	__le32 ktbl_sel1;
+	__le32 rfmod0;
+	__le32 rfmod1;
+
+	__le32 mlo_1_1;
+	__le32 rfe_type;
+	__le32 drv_mode;
+
+	struct {
+		__le32 ch[NUM_OF_RTW89_FW_RFK_PATH];
+		__le32 band[NUM_OF_RTW89_FW_RFK_PATH];
+	} __packed mlo;
+} __packed;
+
 enum rtw89_rf_log_type {
 	RTW89_RF_RUN_LOG = 0,
 	RTW89_RF_RPT_LOG = 1,
@@ -4127,6 +4167,8 @@ int rtw89_fw_h2c_rf_reg(struct rtw89_dev *rtwdev,
 			struct rtw89_fw_h2c_rf_reg_info *info,
 			u16 len, u8 page);
 int rtw89_fw_h2c_rf_ntfy_mcc(struct rtw89_dev *rtwdev);
+int rtw89_fw_h2c_rf_pre_ntfy(struct rtw89_dev *rtwdev,
+			     enum rtw89_phy_idx phy_idx);
 int rtw89_fw_h2c_raw_with_hdr(struct rtw89_dev *rtwdev,
 			      u8 h2c_class, u8 h2c_func, u8 *buf, u16 len,
 			      bool rack, bool dack);
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index bd7bdd216e5f..9f209f068679 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -8730,7 +8730,9 @@
 #define B_PRT_COM_RXBB_V1 GENMASK(4, 0)
 #define B_PRT_COM_DONE BIT(0)
 #define R_COEF_SEL 0x8104
+#define R_COEF_SEL_C1 0x8204
 #define B_COEF_SEL_IQC BIT(0)
+#define B_COEF_SEL_IQC_V1 GENMASK(1, 0)
 #define B_COEF_SEL_MDPD BIT(8)
 #define R_CFIR_SYS 0x8120
 #define R_IQK_RES 0x8124
-- 
2.25.1


