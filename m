Return-Path: <linux-wireless+bounces-10325-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F311093467F
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jul 2024 04:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 251101C216A9
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jul 2024 02:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1D624B4A;
	Thu, 18 Jul 2024 02:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="YE5oCvb4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675AF175A5
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jul 2024 02:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721271149; cv=none; b=FMPVFcfPZ1v4keVJiLKCZAX2LDyxSKbZC1JAT0g8LlZFMnvYHfsEBCgvMW+BoFyzQNG8yRYrtJYsC0uzbqctB/enpuYm1DbR1T/rs78YgxTESFJBaPpJLWbKhBoM7RqZ0/s4c4O+PKS7tW/3mkr2S5cEjlTMVlQNEoBCFkHKlb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721271149; c=relaxed/simple;
	bh=E/fIppzoy8kW36Y9D5QLmgssG0ZhQRBp99tdTn7tkA4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cNYnUKnWJQZXblaNUOp0fV5RbN4R6M5PC2AilYFmuIj989I9D4VBJgOMml3A9J4jt9+6SXy2YCAS3uZ8c/6mTSr31//sXfXcMEgWpSlSFhdkEbSrnqaRDD7xXv5CJeNXADvRenxnmss+BEKEPmWE+QsrTM/VXNUUhFdAoEcs+Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=YE5oCvb4; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 46I2qOKD12860440, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1721271144; bh=E/fIppzoy8kW36Y9D5QLmgssG0ZhQRBp99tdTn7tkA4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=YE5oCvb4uAU85w08I0uOuWqtHauWmMuxROxT/GHSnskf3OWkeDD/JXhyXdsKOeHda
	 xa/E/Xb50DnhO7mJWGuzFwOL5U0/cj6e7l4AR780jpF+sAUx1ri6LtLIEn8RdDYtBT
	 dzO6gfqYl0o3I/kttVdkgFJju3IiLwUPMJD7mj6beo6zvm4wtOR5IsRsXEG7dOtL6G
	 KTXAfkjloHfyQdl+QOC0zeMKxABpsU55gKH4+HWn/NoOldU55t5v4M50kRQ3Cxjje+
	 tDfJOgP9/V0AJGDyAp4NrvROnFZEvZMMTo9kP7Jb59GwLV9gRFBk2NlHff8cuMff5e
	 uLqjN9tG9CQlg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 46I2qOKD12860440
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jul 2024 10:52:24 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 18 Jul 2024 10:52:24 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 18 Jul
 2024 10:52:23 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/6] wifi: rtw89: 8852bt: add chip_info of RTL8852BT
Date: Thu, 18 Jul 2024 10:51:34 +0800
Message-ID: <20240718025138.18777-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240718025138.18777-1-pkshih@realtek.com>
References: <20240718025138.18777-1-pkshih@realtek.com>
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

Add chip_info of RTL8852BT accordingly, including firmware elements
support, MAC memory quota (WDE, PLE and etc), SER IMR used by firmware,
BTC registers, register based H2C/C2H, WoWLAN stub.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.h       |  17 +-
 drivers/net/wireless/realtek/rtw89/mac.c      |   7 +
 drivers/net/wireless/realtek/rtw89/mac.h      |   6 +
 drivers/net/wireless/realtek/rtw89/reg.h      |  58 ++-
 .../net/wireless/realtek/rtw89/rtw8852bt.c    | 369 ++++++++++++++++++
 .../net/wireless/realtek/rtw89/rtw8852bt.h    |   2 +
 6 files changed, 455 insertions(+), 4 deletions(-)
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852bt.c

diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index c3b4324c621c..935f89c09054 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -3741,17 +3741,28 @@ enum rtw89_fw_element_id {
 	RTW89_FW_ELEMENT_ID_NUM,
 };
 
-#define BITS_OF_RTW89_TXPWR_FW_ELEMENTS \
+#define BITS_OF_RTW89_TXPWR_FW_ELEMENTS_NO_6GHZ \
 	(BIT(RTW89_FW_ELEMENT_ID_TXPWR_BYRATE) | \
 	 BIT(RTW89_FW_ELEMENT_ID_TXPWR_LMT_2GHZ) | \
 	 BIT(RTW89_FW_ELEMENT_ID_TXPWR_LMT_5GHZ) | \
-	 BIT(RTW89_FW_ELEMENT_ID_TXPWR_LMT_6GHZ) | \
 	 BIT(RTW89_FW_ELEMENT_ID_TXPWR_LMT_RU_2GHZ) | \
 	 BIT(RTW89_FW_ELEMENT_ID_TXPWR_LMT_RU_5GHZ) | \
-	 BIT(RTW89_FW_ELEMENT_ID_TXPWR_LMT_RU_6GHZ) | \
 	 BIT(RTW89_FW_ELEMENT_ID_TX_SHAPE_LMT) | \
 	 BIT(RTW89_FW_ELEMENT_ID_TX_SHAPE_LMT_RU))
 
+#define BITS_OF_RTW89_TXPWR_FW_ELEMENTS \
+	(BITS_OF_RTW89_TXPWR_FW_ELEMENTS_NO_6GHZ | \
+	 BIT(RTW89_FW_ELEMENT_ID_TXPWR_LMT_6GHZ) | \
+	 BIT(RTW89_FW_ELEMENT_ID_TXPWR_LMT_RU_6GHZ))
+
+#define RTW89_AX_GEN_DEF_NEEDED_FW_ELEMENTS_NO_6GHZ \
+	(BIT(RTW89_FW_ELEMENT_ID_BB_REG) | \
+	 BIT(RTW89_FW_ELEMENT_ID_RADIO_A) | \
+	 BIT(RTW89_FW_ELEMENT_ID_RADIO_B) | \
+	 BIT(RTW89_FW_ELEMENT_ID_RF_NCTL) | \
+	 BIT(RTW89_FW_ELEMENT_ID_TXPWR_TRK) | \
+	 BITS_OF_RTW89_TXPWR_FW_ELEMENTS_NO_6GHZ)
+
 #define RTW89_BE_GEN_DEF_NEEDED_FW_ELEMENTS (BIT(RTW89_FW_ELEMENT_ID_BBMCU0) | \
 					     BIT(RTW89_FW_ELEMENT_ID_BB_REG) | \
 					     BIT(RTW89_FW_ELEMENT_ID_RADIO_A) | \
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index e2399796aeb1..b479434e6301 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -1625,6 +1625,7 @@ const struct rtw89_mac_size_set rtw89_mac_size = {
 	.wde_size18 = {RTW89_WDE_PG_64, 0, 2048,},
 	/* 8852C PCIE SCC */
 	.wde_size19 = {RTW89_WDE_PG_64, 3328, 0,},
+	.wde_size23 = {RTW89_WDE_PG_64, 1022, 2,},
 	/* PCIE */
 	.ple_size0 = {RTW89_PLE_PG_128, 1520, 16,},
 	.ple_size0_v1 = {RTW89_PLE_PG_128, 2688, 240, 212992,},
@@ -1635,6 +1636,7 @@ const struct rtw89_mac_size_set rtw89_mac_size = {
 	.ple_size6 = {RTW89_PLE_PG_128, 496, 16,},
 	/* DLFW */
 	.ple_size8 = {RTW89_PLE_PG_128, 64, 960,},
+	.ple_size9 = {RTW89_PLE_PG_128, 2288, 16,},
 	/* 8852C DLFW */
 	.ple_size18 = {RTW89_PLE_PG_128, 2544, 16,},
 	/* 8852C PCIE SCC */
@@ -1652,6 +1654,7 @@ const struct rtw89_mac_size_set rtw89_mac_size = {
 	.wde_qt17 = {0, 0, 0,  0,},
 	/* 8852C PCIE SCC */
 	.wde_qt18 = {3228, 60, 0, 40,},
+	.wde_qt23 = {958, 48, 0, 16,},
 	.ple_qt0 = {320, 320, 32, 16, 13, 13, 292, 292, 64, 18, 1, 4, 0,},
 	.ple_qt1 = {320, 320, 32, 16, 1316, 1316, 1595, 1595, 1367, 1321, 1, 1307, 0,},
 	/* PCIE SCC */
@@ -1671,12 +1674,16 @@ const struct rtw89_mac_size_set rtw89_mac_size = {
 	.ple_qt46 = {525, 0, 16, 20, 13, 13, 178, 0, 32, 62, 8, 16,},
 	/* 8852C PCIE SCC */
 	.ple_qt47 = {525, 0, 32, 20, 1034, 13, 1199, 0, 1053, 62, 160, 1037,},
+	.ple_qt57 = {147, 0, 16, 20, 13, 13, 178, 0, 32, 14, 8, 0,},
 	/* PCIE 64 */
 	.ple_qt58 = {147, 0, 16, 20, 157, 13, 229, 0, 172, 14, 24, 0,},
+	.ple_qt59 = {147, 0, 32, 20, 1860, 13, 2025, 0, 1879, 14, 24, 0,},
 	/* 8852A PCIE WOW */
 	.ple_qt_52a_wow = {264, 0, 32, 20, 64, 13, 1005, 0, 64, 128, 120,},
 	/* 8852B PCIE WOW */
 	.ple_qt_52b_wow = {147, 0, 16, 20, 157, 13, 133, 0, 172, 14, 24, 0,},
+	/* 8852BT PCIE WOW */
+	.ple_qt_52bt_wow = {147, 0, 32, 20, 1860, 13, 1929, 0, 1879, 14, 24, 0,},
 	/* 8851B PCIE WOW */
 	.ple_qt_51b_wow = {147, 0, 16, 20, 157, 13, 133, 0, 172, 14, 24, 0,},
 	.ple_rsvd_qt0 = {2, 107, 107, 6, 6, 6, 6, 0, 0, 0,},
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index d5895516b3ed..02052fbbec1a 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -885,12 +885,14 @@ struct rtw89_mac_size_set {
 	const struct rtw89_dle_size wde_size9;
 	const struct rtw89_dle_size wde_size18;
 	const struct rtw89_dle_size wde_size19;
+	const struct rtw89_dle_size wde_size23;
 	const struct rtw89_dle_size ple_size0;
 	const struct rtw89_dle_size ple_size0_v1;
 	const struct rtw89_dle_size ple_size3_v1;
 	const struct rtw89_dle_size ple_size4;
 	const struct rtw89_dle_size ple_size6;
 	const struct rtw89_dle_size ple_size8;
+	const struct rtw89_dle_size ple_size9;
 	const struct rtw89_dle_size ple_size18;
 	const struct rtw89_dle_size ple_size19;
 	const struct rtw89_wde_quota wde_qt0;
@@ -900,6 +902,7 @@ struct rtw89_mac_size_set {
 	const struct rtw89_wde_quota wde_qt7;
 	const struct rtw89_wde_quota wde_qt17;
 	const struct rtw89_wde_quota wde_qt18;
+	const struct rtw89_wde_quota wde_qt23;
 	const struct rtw89_ple_quota ple_qt0;
 	const struct rtw89_ple_quota ple_qt1;
 	const struct rtw89_ple_quota ple_qt4;
@@ -911,9 +914,12 @@ struct rtw89_mac_size_set {
 	const struct rtw89_ple_quota ple_qt45;
 	const struct rtw89_ple_quota ple_qt46;
 	const struct rtw89_ple_quota ple_qt47;
+	const struct rtw89_ple_quota ple_qt57;
 	const struct rtw89_ple_quota ple_qt58;
+	const struct rtw89_ple_quota ple_qt59;
 	const struct rtw89_ple_quota ple_qt_52a_wow;
 	const struct rtw89_ple_quota ple_qt_52b_wow;
+	const struct rtw89_ple_quota ple_qt_52bt_wow;
 	const struct rtw89_ple_quota ple_qt_51b_wow;
 	const struct rtw89_rsvd_quota ple_rsvd_qt0;
 	const struct rtw89_rsvd_quota ple_rsvd_qt1;
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 7df36f3bff0b..15b17e2cf99b 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -706,6 +706,14 @@
 				B_AX_HDT_CHANNEL_DMA_ERR_INT_EN | \
 				B_AX_HDT_TOTAL_LEN_ERR_INT_EN | \
 				B_AX_HDT_DMA_PROCESS_ERR_INT_EN)
+#define B_AX_HOST_DISP_IMR_SET_V01 (B_AX_HDT_CHANNEL_DIFF_ERR_INT_EN | \
+				    B_AX_HDT_PAYLOAD_OVERFLOW_INT_EN | \
+				    B_AX_HDT_PAYLOAD_UNDERFLOW_INT_EN | \
+				    B_AX_HDT_CHANNEL_DMA_ERR_INT_EN | \
+				    B_AX_HDT_TOTAL_LEN_ERR_INT_EN | \
+				    B_AX_HDT_DMA_PROCESS_ERR_INT_EN | \
+				    B_AX_HDT_RX_WRITE_OVERFLOW_INT_EN | \
+				    B_AX_HDT_RX_WRITE_UNDERFLOW_INT_EN)
 
 #define B_AX_HR_WRFF_UNDERFLOW_ERR_INT_EN BIT(31)
 #define B_AX_HR_WRFF_OVERFLOW_ERR_INT_EN BIT(30)
@@ -1096,6 +1104,7 @@
 #define B_AX_WDE_BUFMGN_FRZTMR_MODE BIT(0)
 
 #define R_AX_WDE_ERR_IMR 0x8C38
+#define B_AX_WDE_DATCHN_UAPG_ERR_INT_EN BIT(30)
 #define B_AX_WDE_DATCHN_RRDY_ERR_INT_EN BIT(27)
 #define B_AX_WDE_DATCHN_FRZTO_ERR_INT_EN BIT(26)
 #define B_AX_WDE_DATCHN_NULLPG_ERR_INT_EN BIT(25)
@@ -1135,6 +1144,29 @@
 			  B_AX_WDE_DATCHN_ARBT_ERR_INT_EN | \
 			  B_AX_WDE_DATCHN_NULLPG_ERR_INT_EN | \
 			  B_AX_WDE_DATCHN_FRZTO_ERR_INT_EN)
+#define B_AX_WDE_IMR_CLR_V01 (B_AX_WDE_BUFREQ_QTAID_ERR_INT_EN | \
+			      B_AX_WDE_BUFREQ_UNAVAL_ERR_INT_EN | \
+			      B_AX_WDE_BUFRTN_INVLD_PKTID_ERR_INT_EN | \
+			      B_AX_WDE_BUFRTN_SIZE_ERR_INT_EN | \
+			      B_AX_WDE_BUFREQ_SRCHTAILPG_ERR_INT_EN | \
+			      B_AX_WDE_GETNPG_STRPG_ERR_INT_EN | \
+			      B_AX_WDE_GETNPG_PGOFST_ERR_INT_EN | \
+			      B_AX_WDE_BUFMGN_FRZTO_ERR_INT_EN | \
+			      B_AX_WDE_QUE_CMDTYPE_ERR_INT_EN | \
+			      B_AX_WDE_QUE_DSTQUEID_ERR_INT_EN | \
+			      B_AX_WDE_QUE_SRCQUEID_ERR_INT_EN | \
+			      B_AX_WDE_ENQ_PKTCNT_OVRF_ERR_INT_EN | \
+			      B_AX_WDE_ENQ_PKTCNT_NVAL_ERR_INT_EN | \
+			      B_AX_WDE_PREPKTLLT_AD_ERR_INT_EN | \
+			      B_AX_WDE_NXTPKTLL_AD_ERR_INT_EN | \
+			      B_AX_WDE_QUEMGN_FRZTO_ERR_INT_EN | \
+			      B_AX_WDE_DATCHN_ARBT_ERR_INT_EN | \
+			      B_AX_WDE_DATCHN_NULLPG_ERR_INT_EN | \
+			      B_AX_WDE_DATCHN_FRZTO_ERR_INT_EN | \
+			      B_AX_WDE_DATCHN_RRDY_ERR_INT_EN | \
+			      B_AX_WDE_DATCHN_ADRERR_ERR_INT_EN | \
+			      B_AX_WDE_DATCHN_CAMREQ_ERR_INT_EN | \
+			      B_AX_WDE_DATCHN_UAPG_ERR_INT_EN)
 #define B_AX_WDE_IMR_SET (B_AX_WDE_BUFREQ_QTAID_ERR_INT_EN | \
 			  B_AX_WDE_BUFREQ_UNAVAL_ERR_INT_EN | \
 			  B_AX_WDE_BUFRTN_INVLD_PKTID_ERR_INT_EN | \
@@ -1154,6 +1186,28 @@
 			  B_AX_WDE_DATCHN_ARBT_ERR_INT_EN | \
 			  B_AX_WDE_DATCHN_NULLPG_ERR_INT_EN | \
 			  B_AX_WDE_DATCHN_FRZTO_ERR_INT_EN)
+#define B_AX_WDE_IMR_SET_V01 (B_AX_WDE_BUFREQ_QTAID_ERR_INT_EN | \
+			      B_AX_WDE_BUFREQ_UNAVAL_ERR_INT_EN | \
+			      B_AX_WDE_BUFRTN_INVLD_PKTID_ERR_INT_EN | \
+			      B_AX_WDE_BUFRTN_SIZE_ERR_INT_EN | \
+			      B_AX_WDE_BUFREQ_SRCHTAILPG_ERR_INT_EN | \
+			      B_AX_WDE_GETNPG_STRPG_ERR_INT_EN | \
+			      B_AX_WDE_GETNPG_PGOFST_ERR_INT_EN | \
+			      B_AX_WDE_BUFMGN_FRZTO_ERR_INT_EN | \
+			      B_AX_WDE_QUE_CMDTYPE_ERR_INT_EN | \
+			      B_AX_WDE_QUE_DSTQUEID_ERR_INT_EN | \
+			      B_AX_WDE_QUE_SRCQUEID_ERR_INT_EN | \
+			      B_AX_WDE_ENQ_PKTCNT_OVRF_ERR_INT_EN | \
+			      B_AX_WDE_ENQ_PKTCNT_NVAL_ERR_INT_EN | \
+			      B_AX_WDE_PREPKTLLT_AD_ERR_INT_EN | \
+			      B_AX_WDE_NXTPKTLL_AD_ERR_INT_EN | \
+			      B_AX_WDE_QUEMGN_FRZTO_ERR_INT_EN | \
+			      B_AX_WDE_DATCHN_ARBT_ERR_INT_EN | \
+			      B_AX_WDE_DATCHN_NULLPG_ERR_INT_EN | \
+			      B_AX_WDE_DATCHN_FRZTO_ERR_INT_EN | \
+			      B_AX_WDE_DATCHN_RRDY_ERR_INT_EN | \
+			      B_AX_WDE_DATCHN_ADRERR_ERR_INT_EN | \
+			      B_AX_WDE_DATCHN_CAMREQ_ERR_INT_EN)
 
 #define B_AX_WDE_DATCHN_CAMREQ_ERR_INT_EN BIT(29)
 #define B_AX_WDE_DATCHN_ADRERR_ERR_INT_EN BIT(28)
@@ -3098,7 +3152,9 @@
 				 B_AX_OFDM_CCA_TIMEOUT_INT_EN | \
 				 B_AX_DATA_ON_TIMEOUT_INT_EN | \
 				 B_AX_STS_ON_TIMEOUT_INT_EN | \
-				 B_AX_CSI_ON_TIMEOUT_INT_EN)
+				 B_AX_CSI_ON_TIMEOUT_INT_EN | \
+				 B_AX_PHYINTF_TIMEOUT_THR_MSAK)
+#define B_AX_PHYINFO_IMR_SET (B_AX_PHY_TXON_TIMEOUT_INT_EN | 0x7)
 
 #define R_AX_PHYINFO_ERR_ISR 0xCCFC
 #define R_AX_PHYINFO_ERR_ISR_C1 0xECFC
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
new file mode 100644
index 000000000000..0ecd9d41c2ad
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
@@ -0,0 +1,369 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/* Copyright(c) 2024 Realtek Corporation
+ */
+
+#include "coex.h"
+#include "fw.h"
+#include "mac.h"
+#include "phy.h"
+#include "reg.h"
+#include "rtw8852bt.h"
+
+#define RTW8852BT_FW_FORMAT_MAX 0
+#define RTW8852BT_FW_BASENAME "rtw89/rtw8852bt_fw"
+#define RTW8852BT_MODULE_FIRMWARE \
+	RTW8852BT_FW_BASENAME ".bin"
+
+static const struct rtw89_hfc_ch_cfg rtw8852bt_hfc_chcfg_pcie[] = {
+	{16, 742, grp_0}, /* ACH 0 */
+	{16, 742, grp_0}, /* ACH 1 */
+	{16, 742, grp_0}, /* ACH 2 */
+	{16, 742, grp_0}, /* ACH 3 */
+	{0, 0, grp_0}, /* ACH 4 */
+	{0, 0, grp_0}, /* ACH 5 */
+	{0, 0, grp_0}, /* ACH 6 */
+	{0, 0, grp_0}, /* ACH 7 */
+	{15, 743, grp_0}, /* B0MGQ */
+	{15, 743, grp_0}, /* B0HIQ */
+	{0, 0, grp_0}, /* B1MGQ */
+	{0, 0, grp_0}, /* B1HIQ */
+	{40, 0, 0} /* FWCMDQ */
+};
+
+static const struct rtw89_hfc_pub_cfg rtw8852bt_hfc_pubcfg_pcie = {
+	958, /* Group 0 */
+	0, /* Group 1 */
+	958, /* Public Max */
+	0 /* WP threshold */
+};
+
+static const struct rtw89_hfc_param_ini rtw8852bt_hfc_param_ini_pcie[] = {
+	[RTW89_QTA_SCC] = {rtw8852bt_hfc_chcfg_pcie, &rtw8852bt_hfc_pubcfg_pcie,
+			   &rtw89_mac_size.hfc_preccfg_pcie, RTW89_HCIFC_POH},
+	[RTW89_QTA_DLFW] = {NULL, NULL, &rtw89_mac_size.hfc_preccfg_pcie,
+			    RTW89_HCIFC_POH},
+	[RTW89_QTA_INVALID] = {NULL},
+};
+
+static const struct rtw89_dle_mem rtw8852bt_dle_mem_pcie[] = {
+	[RTW89_QTA_SCC] = {RTW89_QTA_SCC, &rtw89_mac_size.wde_size23,
+			   &rtw89_mac_size.ple_size9, &rtw89_mac_size.wde_qt23,
+			   &rtw89_mac_size.wde_qt23, &rtw89_mac_size.ple_qt57,
+			   &rtw89_mac_size.ple_qt59},
+	[RTW89_QTA_WOW] = {RTW89_QTA_WOW, &rtw89_mac_size.wde_size23,
+			   &rtw89_mac_size.ple_size9, &rtw89_mac_size.wde_qt23,
+			   &rtw89_mac_size.wde_qt23, &rtw89_mac_size.ple_qt57,
+			   &rtw89_mac_size.ple_qt_52bt_wow},
+	[RTW89_QTA_DLFW] = {RTW89_QTA_DLFW, &rtw89_mac_size.wde_size4,
+			    &rtw89_mac_size.ple_size4, &rtw89_mac_size.wde_qt4,
+			    &rtw89_mac_size.wde_qt4, &rtw89_mac_size.ple_qt13,
+			    &rtw89_mac_size.ple_qt13},
+	[RTW89_QTA_INVALID] = {RTW89_QTA_INVALID, NULL, NULL, NULL, NULL, NULL,
+			       NULL},
+};
+
+static const u32 rtw8852bt_h2c_regs[RTW89_H2CREG_MAX] = {
+	R_AX_H2CREG_DATA0, R_AX_H2CREG_DATA1,  R_AX_H2CREG_DATA2,
+	R_AX_H2CREG_DATA3
+};
+
+static const u32 rtw8852bt_c2h_regs[RTW89_C2HREG_MAX] = {
+	R_AX_C2HREG_DATA0, R_AX_C2HREG_DATA1, R_AX_C2HREG_DATA2,
+	R_AX_C2HREG_DATA3
+};
+
+static const u32 rtw8852bt_wow_wakeup_regs[RTW89_WOW_REASON_NUM] = {
+	R_AX_C2HREG_DATA3 + 3, R_AX_C2HREG_DATA3 + 3,
+};
+
+static const struct rtw89_page_regs rtw8852bt_page_regs = {
+	.hci_fc_ctrl	= R_AX_HCI_FC_CTRL,
+	.ch_page_ctrl	= R_AX_CH_PAGE_CTRL,
+	.ach_page_ctrl	= R_AX_ACH0_PAGE_CTRL,
+	.ach_page_info	= R_AX_ACH0_PAGE_INFO,
+	.pub_page_info3	= R_AX_PUB_PAGE_INFO3,
+	.pub_page_ctrl1	= R_AX_PUB_PAGE_CTRL1,
+	.pub_page_ctrl2	= R_AX_PUB_PAGE_CTRL2,
+	.pub_page_info1	= R_AX_PUB_PAGE_INFO1,
+	.pub_page_info2 = R_AX_PUB_PAGE_INFO2,
+	.wp_page_ctrl1	= R_AX_WP_PAGE_CTRL1,
+	.wp_page_ctrl2	= R_AX_WP_PAGE_CTRL2,
+	.wp_page_info1	= R_AX_WP_PAGE_INFO1,
+};
+
+static const struct rtw89_reg_def rtw8852bt_dcfo_comp = {
+	R_DCFO_COMP_S0, B_DCFO_COMP_S0_MSK
+};
+
+static const struct rtw89_imr_info rtw8852bt_imr_info = {
+	.wdrls_imr_set		= B_AX_WDRLS_IMR_SET,
+	.wsec_imr_reg		= R_AX_SEC_DEBUG,
+	.wsec_imr_set		= B_AX_IMR_ERROR,
+	.mpdu_tx_imr_set	= 0,
+	.mpdu_rx_imr_set	= 0,
+	.sta_sch_imr_set	= B_AX_STA_SCHEDULER_IMR_SET,
+	.txpktctl_imr_b0_reg	= R_AX_TXPKTCTL_ERR_IMR_ISR,
+	.txpktctl_imr_b0_clr	= B_AX_TXPKTCTL_IMR_B0_CLR,
+	.txpktctl_imr_b0_set	= B_AX_TXPKTCTL_IMR_B0_SET,
+	.txpktctl_imr_b1_reg	= R_AX_TXPKTCTL_ERR_IMR_ISR_B1,
+	.txpktctl_imr_b1_clr	= B_AX_TXPKTCTL_IMR_B1_CLR,
+	.txpktctl_imr_b1_set	= B_AX_TXPKTCTL_IMR_B1_SET,
+	.wde_imr_clr		= B_AX_WDE_IMR_CLR_V01,
+	.wde_imr_set		= B_AX_WDE_IMR_SET_V01,
+	.ple_imr_clr		= B_AX_PLE_IMR_CLR,
+	.ple_imr_set		= B_AX_PLE_IMR_SET,
+	.host_disp_imr_clr	= B_AX_HOST_DISP_IMR_CLR,
+	.host_disp_imr_set	= B_AX_HOST_DISP_IMR_SET_V01,
+	.cpu_disp_imr_clr	= B_AX_CPU_DISP_IMR_CLR,
+	.cpu_disp_imr_set	= B_AX_CPU_DISP_IMR_SET,
+	.other_disp_imr_clr	= B_AX_OTHER_DISP_IMR_CLR,
+	.other_disp_imr_set	= 0,
+	.bbrpt_com_err_imr_reg	= R_AX_BBRPT_COM_ERR_IMR_ISR,
+	.bbrpt_chinfo_err_imr_reg = R_AX_BBRPT_CHINFO_ERR_IMR_ISR,
+	.bbrpt_err_imr_set	= 0,
+	.bbrpt_dfs_err_imr_reg	= R_AX_BBRPT_DFS_ERR_IMR_ISR,
+	.ptcl_imr_clr		= B_AX_PTCL_IMR_CLR_ALL,
+	.ptcl_imr_set		= B_AX_PTCL_IMR_SET,
+	.cdma_imr_0_reg		= R_AX_DLE_CTRL,
+	.cdma_imr_0_clr		= B_AX_DLE_IMR_CLR,
+	.cdma_imr_0_set		= B_AX_DLE_IMR_SET,
+	.cdma_imr_1_reg		= 0,
+	.cdma_imr_1_clr		= 0,
+	.cdma_imr_1_set		= 0,
+	.phy_intf_imr_reg	= R_AX_PHYINFO_ERR_IMR,
+	.phy_intf_imr_clr	= B_AX_PHYINFO_IMR_EN_ALL,
+	.phy_intf_imr_set	= B_AX_PHYINFO_IMR_SET,
+	.rmac_imr_reg		= R_AX_RMAC_ERR_ISR,
+	.rmac_imr_clr		= B_AX_RMAC_IMR_CLR,
+	.rmac_imr_set		= B_AX_RMAC_IMR_SET,
+	.tmac_imr_reg		= R_AX_TMAC_ERR_IMR_ISR,
+	.tmac_imr_clr		= B_AX_TMAC_IMR_CLR,
+	.tmac_imr_set		= B_AX_TMAC_IMR_SET,
+};
+
+static const struct rtw89_rrsr_cfgs rtw8852bt_rrsr_cfgs = {
+	.ref_rate = {R_AX_TRXPTCL_RRSR_CTL_0, B_AX_WMAC_RESP_REF_RATE_SEL, 0},
+	.rsc = {R_AX_TRXPTCL_RRSR_CTL_0, B_AX_WMAC_RESP_RSC_MASK, 2},
+};
+
+static const struct rtw89_dig_regs rtw8852bt_dig_regs = {
+	.seg0_pd_reg = R_SEG0R_PD_V1,
+	.pd_lower_bound_mask = B_SEG0R_PD_LOWER_BOUND_MSK,
+	.pd_spatial_reuse_en = B_SEG0R_PD_SPATIAL_REUSE_EN_MSK_V1,
+	.bmode_pd_reg = R_BMODE_PDTH_EN_V1,
+	.bmode_cca_rssi_limit_en = B_BMODE_PDTH_LIMIT_EN_MSK_V1,
+	.bmode_pd_lower_bound_reg = R_BMODE_PDTH_V1,
+	.bmode_rssi_nocca_low_th_mask = B_BMODE_PDTH_LOWER_BOUND_MSK_V1,
+	.p0_lna_init = {R_PATH0_LNA_INIT_V1, B_PATH0_LNA_INIT_IDX_MSK},
+	.p1_lna_init = {R_PATH1_LNA_INIT_V1, B_PATH1_LNA_INIT_IDX_MSK},
+	.p0_tia_init = {R_PATH0_TIA_INIT_V1, B_PATH0_TIA_INIT_IDX_MSK_V1},
+	.p1_tia_init = {R_PATH1_TIA_INIT_V1, B_PATH1_TIA_INIT_IDX_MSK_V1},
+	.p0_rxb_init = {R_PATH0_RXB_INIT_V1, B_PATH0_RXB_INIT_IDX_MSK_V1},
+	.p1_rxb_init = {R_PATH1_RXB_INIT_V1, B_PATH1_RXB_INIT_IDX_MSK_V1},
+	.p0_p20_pagcugc_en = {R_PATH0_P20_FOLLOW_BY_PAGCUGC_V2,
+			      B_PATH0_P20_FOLLOW_BY_PAGCUGC_EN_MSK},
+	.p0_s20_pagcugc_en = {R_PATH0_S20_FOLLOW_BY_PAGCUGC_V2,
+			      B_PATH0_S20_FOLLOW_BY_PAGCUGC_EN_MSK},
+	.p1_p20_pagcugc_en = {R_PATH1_P20_FOLLOW_BY_PAGCUGC_V2,
+			      B_PATH1_P20_FOLLOW_BY_PAGCUGC_EN_MSK},
+	.p1_s20_pagcugc_en = {R_PATH1_S20_FOLLOW_BY_PAGCUGC_V2,
+			      B_PATH1_S20_FOLLOW_BY_PAGCUGC_EN_MSK},
+};
+
+static const struct rtw89_edcca_regs rtw8852bt_edcca_regs = {
+	.edcca_level			= R_SEG0R_EDCCA_LVL_V1,
+	.edcca_mask			= B_EDCCA_LVL_MSK0,
+	.edcca_p_mask			= B_EDCCA_LVL_MSK1,
+	.ppdu_level			= R_SEG0R_EDCCA_LVL_V1,
+	.ppdu_mask			= B_EDCCA_LVL_MSK3,
+	.rpt_a				= R_EDCCA_RPT_A,
+	.rpt_b				= R_EDCCA_RPT_B,
+	.rpt_sel			= R_EDCCA_RPT_SEL,
+	.rpt_sel_mask			= B_EDCCA_RPT_SEL_MSK,
+	.tx_collision_t2r_st		= R_TX_COLLISION_T2R_ST,
+	.tx_collision_t2r_st_mask	= B_TX_COLLISION_T2R_ST_M,
+};
+
+static const struct rtw89_btc_rf_trx_para rtw89_btc_8852bt_rf_ul[] = {
+	{255, 0, 0, 7}, /* 0 -> original */
+	{255, 2, 0, 7}, /* 1 -> for BT-connected ACI issue && BTG co-rx */
+	{255, 0, 0, 7}, /* 2 ->reserved for shared-antenna */
+	{255, 0, 0, 7}, /* 3- >reserved for shared-antenna */
+	{255, 0, 0, 7}, /* 4 ->reserved for shared-antenna */
+	{255, 1, 0, 7}, /* the below id is for non-shared-antenna free-run */
+	{6, 1, 0, 7},
+	{13, 1, 0, 7},
+	{13, 1, 0, 7}
+};
+
+static const struct rtw89_btc_rf_trx_para rtw89_btc_8852bt_rf_dl[] = {
+	{255, 0, 0, 7}, /* 0 -> original */
+	{255, 2, 0, 7}, /* 1 -> reserved for shared-antenna */
+	{255, 0, 0, 7}, /* 2 ->reserved for shared-antenna */
+	{255, 0, 0, 7}, /* 3- >reserved for shared-antenna */
+	{255, 0, 0, 7}, /* 4 ->reserved for shared-antenna */
+	{255, 1, 0, 7}, /* the below id is for non-shared-antenna free-run */
+	{255, 1, 0, 7},
+	{255, 1, 0, 7},
+	{255, 1, 0, 7}
+};
+
+static const struct rtw89_btc_fbtc_mreg rtw89_btc_8852bt_mon_reg[] = {
+	RTW89_DEF_FBTC_MREG(REG_MAC, 4, 0xda24),
+	RTW89_DEF_FBTC_MREG(REG_MAC, 4, 0xda28),
+	RTW89_DEF_FBTC_MREG(REG_MAC, 4, 0xda2c),
+	RTW89_DEF_FBTC_MREG(REG_MAC, 4, 0xda30),
+	RTW89_DEF_FBTC_MREG(REG_MAC, 4, 0xda4c),
+	RTW89_DEF_FBTC_MREG(REG_MAC, 4, 0xda10),
+	RTW89_DEF_FBTC_MREG(REG_MAC, 4, 0xda20),
+	RTW89_DEF_FBTC_MREG(REG_MAC, 4, 0xda34),
+	RTW89_DEF_FBTC_MREG(REG_MAC, 4, 0xcef4),
+	RTW89_DEF_FBTC_MREG(REG_MAC, 4, 0x8424),
+	RTW89_DEF_FBTC_MREG(REG_MAC, 4, 0xd200),
+	RTW89_DEF_FBTC_MREG(REG_MAC, 4, 0xd220),
+	RTW89_DEF_FBTC_MREG(REG_BB, 4, 0x980),
+	RTW89_DEF_FBTC_MREG(REG_BB, 4, 0x4aa4),
+	RTW89_DEF_FBTC_MREG(REG_BB, 4, 0x4778),
+	RTW89_DEF_FBTC_MREG(REG_BB, 4, 0x476c),
+};
+
+static const u8 rtw89_btc_8852bt_wl_rssi_thres[BTC_WL_RSSI_THMAX] = {70, 60, 50, 40};
+static const u8 rtw89_btc_8852bt_bt_rssi_thres[BTC_BT_RSSI_THMAX] = {50, 40, 30, 20};
+
+static const struct rtw89_chip_ops rtw8852bt_chip_ops = {
+};
+
+#ifdef CONFIG_PM
+static const struct wiphy_wowlan_support rtw_wowlan_stub_8852bt = {
+	.flags = WIPHY_WOWLAN_MAGIC_PKT | WIPHY_WOWLAN_DISCONNECT,
+	.n_patterns = RTW89_MAX_PATTERN_NUM,
+	.pattern_max_len = RTW89_MAX_PATTERN_SIZE,
+	.pattern_min_len = 1,
+};
+#endif
+
+const struct rtw89_chip_info rtw8852bt_chip_info = {
+	.chip_id		= RTL8852BT,
+	.chip_gen		= RTW89_CHIP_AX,
+	.ops			= &rtw8852bt_chip_ops,
+	.mac_def		= &rtw89_mac_gen_ax,
+	.phy_def		= &rtw89_phy_gen_ax,
+	.fw_basename		= RTW8852BT_FW_BASENAME,
+	.fw_format_max		= RTW8852BT_FW_FORMAT_MAX,
+	.try_ce_fw		= true,
+	.bbmcu_nr		= 0,
+	.needed_fw_elms		= RTW89_AX_GEN_DEF_NEEDED_FW_ELEMENTS_NO_6GHZ,
+	.fifo_size		= 458752,
+	.small_fifo_size	= true,
+	.dle_scc_rsvd_size	= 98304,
+	.max_amsdu_limit	= 5000,
+	.dis_2g_40m_ul_ofdma	= true,
+	.rsvd_ple_ofst		= 0x6f800,
+	.hfc_param_ini		= rtw8852bt_hfc_param_ini_pcie,
+	.dle_mem		= rtw8852bt_dle_mem_pcie,
+	.wde_qempty_acq_grpnum	= 4,
+	.wde_qempty_mgq_grpsel	= 4,
+	.rf_base_addr		= {0xe000, 0xf000},
+	.pwr_on_seq		= NULL,
+	.pwr_off_seq		= NULL,
+	.bb_table		= NULL,
+	.bb_gain_table		= NULL,
+	.rf_table		= {},
+	.nctl_table		= NULL,
+	.nctl_post_table	= NULL,
+	.dflt_parms		= NULL,
+	.rfe_parms_conf		= NULL,
+	.txpwr_factor_rf	= 2,
+	.txpwr_factor_mac	= 1,
+	.dig_table		= NULL,
+	.dig_regs		= &rtw8852bt_dig_regs,
+	.tssi_dbw_table		= NULL,
+	.support_macid_num	= RTW89_MAX_MAC_ID_NUM,
+	.support_chanctx_num	= 1,
+	.support_rnr		= false,
+	.support_bands		= BIT(NL80211_BAND_2GHZ) |
+				  BIT(NL80211_BAND_5GHZ),
+	.support_bandwidths	= BIT(NL80211_CHAN_WIDTH_20) |
+				  BIT(NL80211_CHAN_WIDTH_40) |
+				  BIT(NL80211_CHAN_WIDTH_80),
+	.support_unii4		= true,
+	.ul_tb_waveform_ctrl	= true,
+	.ul_tb_pwr_diff		= false,
+	.hw_sec_hdr		= false,
+	.rf_path_num		= 2,
+	.tx_nss			= 2,
+	.rx_nss			= 2,
+	.acam_num		= 128,
+	.bcam_num		= 10,
+	.scam_num		= 128,
+	.bacam_num		= 2,
+	.bacam_dynamic_num	= 4,
+	.bacam_ver		= RTW89_BACAM_V0,
+	.ppdu_max_usr		= 4,
+	.sec_ctrl_efuse_size	= 4,
+	.physical_efuse_size	= 1216,
+	.logical_efuse_size	= 2048,
+	.limit_efuse_size	= 1280,
+	.dav_phy_efuse_size	= 96,
+	.dav_log_efuse_size	= 16,
+	.efuse_blocks		= NULL,
+	.phycap_addr		= 0x580,
+	.phycap_size		= 128,
+	.para_ver		= 0,
+	.wlcx_desired		= 0x070e0000,
+	.btcx_desired		= 0x7,
+	.scbd			= 0x1,
+	.mailbox		= 0x1,
+
+	.afh_guard_ch		= 6,
+	.wl_rssi_thres		= rtw89_btc_8852bt_wl_rssi_thres,
+	.bt_rssi_thres		= rtw89_btc_8852bt_bt_rssi_thres,
+	.rssi_tol		= 2,
+	.mon_reg_num		= ARRAY_SIZE(rtw89_btc_8852bt_mon_reg),
+	.mon_reg		= rtw89_btc_8852bt_mon_reg,
+	.rf_para_ulink_num	= ARRAY_SIZE(rtw89_btc_8852bt_rf_ul),
+	.rf_para_ulink		= rtw89_btc_8852bt_rf_ul,
+	.rf_para_dlink_num	= ARRAY_SIZE(rtw89_btc_8852bt_rf_dl),
+	.rf_para_dlink		= rtw89_btc_8852bt_rf_dl,
+	.ps_mode_supported	= BIT(RTW89_PS_MODE_RFOFF) |
+				  BIT(RTW89_PS_MODE_CLK_GATED) |
+				  BIT(RTW89_PS_MODE_PWR_GATED),
+	.low_power_hci_modes	= 0,
+	.h2c_cctl_func_id	= H2C_FUNC_MAC_CCTLINFO_UD,
+	.hci_func_en_addr	= R_AX_HCI_FUNC_EN,
+	.h2c_desc_size		= sizeof(struct rtw89_txwd_body),
+	.txwd_body_size		= sizeof(struct rtw89_txwd_body),
+	.txwd_info_size		= sizeof(struct rtw89_txwd_info),
+	.h2c_ctrl_reg		= R_AX_H2CREG_CTRL,
+	.h2c_counter_reg	= {R_AX_UDM1 + 1, B_AX_UDM1_HALMAC_H2C_DEQ_CNT_MASK >> 8},
+	.h2c_regs		= rtw8852bt_h2c_regs,
+	.c2h_ctrl_reg		= R_AX_C2HREG_CTRL,
+	.c2h_counter_reg	= {R_AX_UDM1 + 1, B_AX_UDM1_HALMAC_C2H_ENQ_CNT_MASK >> 8},
+	.c2h_regs		= rtw8852bt_c2h_regs,
+	.page_regs		= &rtw8852bt_page_regs,
+	.wow_reason_reg		= rtw8852bt_wow_wakeup_regs,
+	.cfo_src_fd		= true,
+	.cfo_hw_comp		= true,
+	.dcfo_comp		= &rtw8852bt_dcfo_comp,
+	.dcfo_comp_sft		= 10,
+	.imr_info		= &rtw8852bt_imr_info,
+	.imr_dmac_table		= NULL,
+	.imr_cmac_table		= NULL,
+	.rrsr_cfgs		= &rtw8852bt_rrsr_cfgs,
+	.bss_clr_vld		= {R_BSS_CLR_MAP_V1, B_BSS_CLR_MAP_VLD0},
+	.bss_clr_map_reg	= R_BSS_CLR_MAP_V1,
+	.dma_ch_mask		= BIT(RTW89_DMA_ACH4) | BIT(RTW89_DMA_ACH5) |
+				  BIT(RTW89_DMA_ACH6) | BIT(RTW89_DMA_ACH7) |
+				  BIT(RTW89_DMA_B1MG) | BIT(RTW89_DMA_B1HI),
+	.edcca_regs		= &rtw8852bt_edcca_regs,
+#ifdef CONFIG_PM
+	.wowlan_stub		= &rtw_wowlan_stub_8852bt,
+#endif
+	.xtal_info		= NULL,
+};
+EXPORT_SYMBOL(rtw8852bt_chip_info);
+
+MODULE_FIRMWARE(RTW8852BT_MODULE_FIRMWARE);
+MODULE_AUTHOR("Realtek Corporation");
+MODULE_DESCRIPTION("Realtek 802.11ax wireless 8852BT driver");
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt.h b/drivers/net/wireless/realtek/rtw89/rtw8852bt.h
index 6177f36ad667..b76b36aaf025 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bt.h
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt.h
@@ -10,4 +10,6 @@
 #define RF_PATH_NUM_8852BT 2
 #define BB_PATH_NUM_8852BT 2
 
+extern const struct rtw89_chip_info rtw8852bt_chip_info;
+
 #endif
-- 
2.25.1


