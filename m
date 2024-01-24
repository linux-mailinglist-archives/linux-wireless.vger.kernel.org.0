Return-Path: <linux-wireless+bounces-2429-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF6383A028
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jan 2024 04:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8026B2948A4
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jan 2024 03:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6095E1381;
	Wed, 24 Jan 2024 03:37:19 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611CBBE59
	for <linux-wireless@vger.kernel.org>; Wed, 24 Jan 2024 03:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706067439; cv=none; b=tDpLKI2tUbHX5qxspZWyv86cvmHAJJQaloprOUe83WF5IWntmL1hH8YOZe9mCmcw94n7DRSbau4U639ADSwD77q75RxtGUaTxkUhehbVg1zcLhAHanMXvpytFW3LPyp5P7HvHxamxm04LxLqX579mcvFWBx1utUXrBJIw9vB/Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706067439; c=relaxed/simple;
	bh=YQka8Bg613sdA84XOfabBhSu+sGgqcct31yaoGr6T4Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uRHpmsQlSeh779wvFcv1AGKh1809B0NDEuuIIv6UxM+tYWok/jb+OJ5tjgi8KRifYl8CPFYPKKkjJsPQOmc0NT5JuhxLBCvQMILj1InZE6NzPOPEWNWLMafzUUWCCTBh5R+ouDm7FYj96jBkFOEsXwWEsxjjtm4beMONztWykec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 40O3bACL1723709, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 40O3bACL1723709
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 11:37:10 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Wed, 24 Jan 2024 11:37:10 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXDAG02.realtek.com.tw
 (172.21.6.101) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 24 Jan
 2024 11:37:10 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/6] wifi: rtw89: 8922a: implement {stop,resume}_sch_tx and cfg_ppdu
Date: Wed, 24 Jan 2024 11:36:33 +0800
Message-ID: <20240124033637.12330-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240124033637.12330-1-pkshih@realtek.com>
References: <20240124033637.12330-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXDAG02.realtek.com.tw (172.21.6.101)
X-KSE-ServerInfo: RTEXDAG02.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

To set TX/RX path or set channel, we need these helpers to stop TX and
restore settings. The sch_tx stands for scheduler TX channel, and the
cfg_ppdu is to stop reporting PPDU status, so we should stop them during
setting.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c      |  5 +-
 drivers/net/wireless/realtek/rtw89/mac.h      | 14 ++-
 drivers/net/wireless/realtek/rtw89/mac_be.c   | 96 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/reg.h      | 44 +++++++++
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |  2 +
 5 files changed, 158 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index eb94e832e154..d1d16564a686 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -5205,7 +5205,8 @@ bool rtw89_mac_get_txpwr_cr_ax(struct rtw89_dev *rtwdev,
 	return false;
 }
 
-int rtw89_mac_cfg_ppdu_status(struct rtw89_dev *rtwdev, u8 mac_idx, bool enable)
+static
+int rtw89_mac_cfg_ppdu_status_ax(struct rtw89_dev *rtwdev, u8 mac_idx, bool enable)
 {
 	u32 reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_PPDU_STAT, mac_idx);
 	int ret;
@@ -5228,7 +5229,6 @@ int rtw89_mac_cfg_ppdu_status(struct rtw89_dev *rtwdev, u8 mac_idx, bool enable)
 
 	return 0;
 }
-EXPORT_SYMBOL(rtw89_mac_cfg_ppdu_status);
 
 void rtw89_mac_update_rts_threshold(struct rtw89_dev *rtwdev, u8 mac_idx)
 {
@@ -6179,6 +6179,7 @@ const struct rtw89_mac_gen_def rtw89_mac_gen_ax = {
 	.bf_assoc = rtw89_mac_bf_assoc_ax,
 
 	.typ_fltr_opt = rtw89_mac_typ_fltr_opt_ax,
+	.cfg_ppdu_status = rtw89_mac_cfg_ppdu_status_ax,
 
 	.dle_mix_cfg = dle_mix_cfg_ax,
 	.chk_dle_rdy = chk_dle_rdy_ax,
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 181d03d1f78a..66bac01eb067 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -913,6 +913,7 @@ struct rtw89_mac_gen_def {
 			    enum rtw89_machdr_frame_type type,
 			    enum rtw89_mac_fwd_target fwd_target,
 			    u8 mac_idx);
+	int (*cfg_ppdu_status)(struct rtw89_dev *rtwdev, u8 mac_idx, bool enable);
 
 	int (*dle_mix_cfg)(struct rtw89_dev *rtwdev, const struct rtw89_dle_mem *cfg);
 	int (*chk_dle_rdy)(struct rtw89_dev *rtwdev, bool wde_or_ple);
@@ -1138,9 +1139,20 @@ int rtw89_mac_stop_sch_tx(struct rtw89_dev *rtwdev, u8 mac_idx,
 			  u32 *tx_en, enum rtw89_sch_tx_sel sel);
 int rtw89_mac_stop_sch_tx_v1(struct rtw89_dev *rtwdev, u8 mac_idx,
 			     u32 *tx_en, enum rtw89_sch_tx_sel sel);
+int rtw89_mac_stop_sch_tx_v2(struct rtw89_dev *rtwdev, u8 mac_idx,
+			     u32 *tx_en, enum rtw89_sch_tx_sel sel);
 int rtw89_mac_resume_sch_tx(struct rtw89_dev *rtwdev, u8 mac_idx, u32 tx_en);
 int rtw89_mac_resume_sch_tx_v1(struct rtw89_dev *rtwdev, u8 mac_idx, u32 tx_en);
-int rtw89_mac_cfg_ppdu_status(struct rtw89_dev *rtwdev, u8 mac_ids, bool enable);
+int rtw89_mac_resume_sch_tx_v2(struct rtw89_dev *rtwdev, u8 mac_idx, u32 tx_en);
+
+static inline
+int rtw89_mac_cfg_ppdu_status(struct rtw89_dev *rtwdev, u8 mac_idx, bool enable)
+{
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
+
+	return mac->cfg_ppdu_status(rtwdev, mac_idx, enable);
+}
+
 void rtw89_mac_update_rts_threshold(struct rtw89_dev *rtwdev, u8 mac_idx);
 void rtw89_mac_flush_txq(struct rtw89_dev *rtwdev, u32 queues, bool drop);
 int rtw89_mac_coex_init(struct rtw89_dev *rtwdev, const struct rtw89_mac_ax_coex *coex);
diff --git a/drivers/net/wireless/realtek/rtw89/mac_be.c b/drivers/net/wireless/realtek/rtw89/mac_be.c
index 4befbe06cd15..f03d05a2f857 100644
--- a/drivers/net/wireless/realtek/rtw89/mac_be.c
+++ b/drivers/net/wireless/realtek/rtw89/mac_be.c
@@ -1718,6 +1718,101 @@ static int trx_init_be(struct rtw89_dev *rtwdev)
 	return 0;
 }
 
+static int rtw89_set_hw_sch_tx_en_v2(struct rtw89_dev *rtwdev, u8 mac_idx,
+				     u32 tx_en, u32 tx_en_mask)
+{
+	u32 reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_CTN_DRV_TXEN, mac_idx);
+	u32 val;
+	int ret;
+
+	ret = rtw89_mac_check_mac_en(rtwdev, mac_idx, RTW89_CMAC_SEL);
+	if (ret)
+		return ret;
+
+	val = rtw89_read32(rtwdev, reg);
+	val = (val & ~tx_en_mask) | (tx_en & tx_en_mask);
+	rtw89_write32(rtwdev, reg, val);
+
+	return 0;
+}
+
+int rtw89_mac_stop_sch_tx_v2(struct rtw89_dev *rtwdev, u8 mac_idx,
+			     u32 *tx_en, enum rtw89_sch_tx_sel sel)
+{
+	int ret;
+
+	*tx_en = rtw89_read32(rtwdev,
+			      rtw89_mac_reg_by_idx(rtwdev, R_BE_CTN_DRV_TXEN, mac_idx));
+
+	switch (sel) {
+	case RTW89_SCH_TX_SEL_ALL:
+		ret = rtw89_set_hw_sch_tx_en_v2(rtwdev, mac_idx, 0,
+						B_BE_CTN_TXEN_ALL_MASK);
+		if (ret)
+			return ret;
+		break;
+	case RTW89_SCH_TX_SEL_HIQ:
+		ret = rtw89_set_hw_sch_tx_en_v2(rtwdev, mac_idx,
+						0, B_BE_CTN_TXEN_HGQ);
+		if (ret)
+			return ret;
+		break;
+	case RTW89_SCH_TX_SEL_MG0:
+		ret = rtw89_set_hw_sch_tx_en_v2(rtwdev, mac_idx,
+						0, B_BE_CTN_TXEN_MGQ);
+		if (ret)
+			return ret;
+		break;
+	case RTW89_SCH_TX_SEL_MACID:
+		ret = rtw89_set_hw_sch_tx_en_v2(rtwdev, mac_idx, 0,
+						B_BE_CTN_TXEN_ALL_MASK);
+		if (ret)
+			return ret;
+		break;
+	default:
+		return 0;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(rtw89_mac_stop_sch_tx_v2);
+
+int rtw89_mac_resume_sch_tx_v2(struct rtw89_dev *rtwdev, u8 mac_idx, u32 tx_en)
+{
+	int ret;
+
+	ret = rtw89_set_hw_sch_tx_en_v2(rtwdev, mac_idx, tx_en,
+					B_BE_CTN_TXEN_ALL_MASK);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+EXPORT_SYMBOL(rtw89_mac_resume_sch_tx_v2);
+
+static
+int rtw89_mac_cfg_ppdu_status_be(struct rtw89_dev *rtwdev, u8 mac_idx, bool enable)
+{
+	u32 reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_PPDU_STAT, mac_idx);
+	int ret;
+
+	ret = rtw89_mac_check_mac_en(rtwdev, mac_idx, RTW89_CMAC_SEL);
+	if (ret)
+		return ret;
+
+	if (!enable) {
+		rtw89_write32_clr(rtwdev, reg, B_BE_PPDU_STAT_RPT_EN);
+		return 0;
+	}
+
+	rtw89_write32_mask(rtwdev, R_BE_HW_PPDU_STATUS, B_BE_FWD_PPDU_STAT_MASK, 3);
+	rtw89_write32(rtwdev, reg, B_BE_PPDU_STAT_RPT_EN | B_BE_PPDU_MAC_INFO |
+				   B_BE_APP_RX_CNT_RPT | B_BE_APP_PLCP_HDR_RPT |
+				   B_BE_PPDU_STAT_RPT_CRC32 | B_BE_PPDU_STAT_RPT_DMA);
+
+	return 0;
+}
+
 static bool rtw89_mac_get_txpwr_cr_be(struct rtw89_dev *rtwdev,
 				      enum rtw89_phy_idx phy_idx,
 				      u32 reg_base, u32 *cr)
@@ -2239,6 +2334,7 @@ const struct rtw89_mac_gen_def rtw89_mac_gen_be = {
 	.bf_assoc = rtw89_mac_bf_assoc_be,
 
 	.typ_fltr_opt = rtw89_mac_typ_fltr_opt_be,
+	.cfg_ppdu_status = rtw89_mac_cfg_ppdu_status_be,
 
 	.dle_mix_cfg = dle_mix_cfg_be,
 	.chk_dle_rdy = chk_dle_rdy_be,
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index acc96d30d085..bafad1d3e9a1 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -5502,6 +5502,14 @@
 #define B_BE_DROP_NONDMA_PPDU BIT(2)
 #define B_BE_APPEND_FCS BIT(0)
 
+#define R_BE_HW_PPDU_STATUS 0x9C30
+#define B_BE_FWD_RPKTTYPE_MASK GENMASK(31, 26)
+#define B_BE_FWD_PPDU_PRTID_MASK GENMASK(25, 23)
+#define B_BE_FWD_PPDU_FW_RLS BIT(22)
+#define B_BE_FWD_PPDU_QUEID_MASK GENMASK(21, 16)
+#define B_BE_FWD_OTHER_RPKT_MASK GENMASK(15, 8)
+#define B_BE_FWD_PPDU_STAT_MASK GENMASK(7, 0)
+
 #define R_BE_CUT_AMSDU_CTRL 0x9C94
 #define B_BE_EN_CUT_AMSDU BIT(31)
 #define B_BE_CUT_AMSDU_CHKLEN_EN BIT(30)
@@ -6140,6 +6148,28 @@
 #define B_BE_SET_MUEDCATIMER_TF_0 BIT(4)
 #define B_BE_MUEDCA_EN_0 BIT(0)
 
+#define R_BE_CTN_DRV_TXEN 0x10398
+#define R_BE_CTN_DRV_TXEN_C1 0x14398
+#define B_BE_CTN_TXEN_TWT_3 BIT(17)
+#define B_BE_CTN_TXEN_TWT_2 BIT(16)
+#define B_BE_CTN_TXEN_TWT_1 BIT(15)
+#define B_BE_CTN_TXEN_TWT_0 BIT(14)
+#define B_BE_CTN_TXEN_ULQ BIT(13)
+#define B_BE_CTN_TXEN_BCNQ BIT(12)
+#define B_BE_CTN_TXEN_HGQ BIT(11)
+#define B_BE_CTN_TXEN_CPUMGQ BIT(10)
+#define B_BE_CTN_TXEN_MGQ1 BIT(9)
+#define B_BE_CTN_TXEN_MGQ BIT(8)
+#define B_BE_CTN_TXEN_VO_1 BIT(7)
+#define B_BE_CTN_TXEN_VI_1 BIT(6)
+#define B_BE_CTN_TXEN_BK_1 BIT(5)
+#define B_BE_CTN_TXEN_BE_1 BIT(4)
+#define B_BE_CTN_TXEN_VO_0 BIT(3)
+#define B_BE_CTN_TXEN_VI_0 BIT(2)
+#define B_BE_CTN_TXEN_BK_0 BIT(1)
+#define B_BE_CTN_TXEN_BE_0 BIT(0)
+#define B_BE_CTN_TXEN_ALL_MASK GENMASK(17, 0)
+
 #define R_BE_TB_CHK_CCA_NAV 0x103AC
 #define R_BE_TB_CHK_CCA_NAV_C1 0x143AC
 #define B_BE_TB_CHK_TX_NAV BIT(15)
@@ -7141,6 +7171,20 @@
 #define S_BE_BACAM_RST_ENT 1
 #define S_BE_BACAM_RST_ALL 2
 
+#define R_BE_PPDU_STAT 0x11440
+#define R_BE_PPDU_STAT_C1 0x15440
+#define B_BE_STAT_IORST BIT(13)
+#define B_BE_STAT_GCKDIS BIT(12)
+#define B_BE_PPDU_STAT_WR_BW_MASK GENMASK(11, 10)
+#define B_BE_PPDU_STAT_RPT_TRIG BIT(8)
+#define B_BE_PPDU_STAT_RPT_DMA BIT(6)
+#define B_BE_PPDU_STAT_RPT_CRC32 BIT(5)
+#define B_BE_PPDU_STAT_RPT_ADDR BIT(4)
+#define B_BE_APP_PLCP_HDR_RPT BIT(3)
+#define B_BE_APP_RX_CNT_RPT BIT(2)
+#define B_BE_PPDU_MAC_INFO BIT(1)
+#define B_BE_PPDU_STAT_RPT_EN BIT(0)
+
 #define R_BE_RX_SR_CTRL 0x1144A
 #define R_BE_RX_SR_CTRL_C1 0x1544A
 #define B_BE_SR_OP_MODE_MASK GENMASK(5, 4)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index 9c7465d0715b..beac7bf0faff 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -1332,6 +1332,8 @@ static const struct rtw89_chip_ops rtw8922a_chip_ops = {
 	.query_rxdesc		= rtw89_core_query_rxdesc_v2,
 	.fill_txdesc		= rtw89_core_fill_txdesc_v2,
 	.fill_txdesc_fwcmd	= rtw89_core_fill_txdesc_fwcmd_v2,
+	.stop_sch_tx		= rtw89_mac_stop_sch_tx_v2,
+	.resume_sch_tx		= rtw89_mac_resume_sch_tx_v2,
 	.h2c_dctl_sec_cam	= rtw89_fw_h2c_dctl_sec_cam_v2,
 	.h2c_default_cmac_tbl	= rtw89_fw_h2c_default_cmac_tbl_g7,
 	.h2c_assoc_cmac_tbl	= rtw89_fw_h2c_assoc_cmac_tbl_g7,
-- 
2.25.1


