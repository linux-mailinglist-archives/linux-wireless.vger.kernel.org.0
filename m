Return-Path: <linux-wireless+bounces-30269-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0BCCEDF23
	for <lists+linux-wireless@lfdr.de>; Fri, 02 Jan 2026 08:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6C327300CCEC
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Jan 2026 07:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C46310651;
	Fri,  2 Jan 2026 07:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="QSFyBmbf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6C7310636
	for <linux-wireless@vger.kernel.org>; Fri,  2 Jan 2026 07:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767337755; cv=none; b=iacvKsNvcqZTuc3h53n69xkJ4msaYZKBeApdX0bCNBpP+Ru0Pw9p9OrXn7kqBxPnrxhf9Y9OEbOyrkRjSl3z2v5Ipeqcxrg3Y33xnPUxcrEa93b504PyB+qjnTh0G7LeHPnReU620gzhiDIPPkK3enqyFKK7nmlS7hNo5286+I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767337755; c=relaxed/simple;
	bh=KZT6Vzh8xlZ023KVimhFnwHKMmkKwSeP5rwdC98Z5ok=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OB04UeLl2dM9Du4K7C/Bq1k7q6iAmN2qoKRCUqqxNR7mJbih7v6sdQ/AMU7XrFNPVNPDHegJi2TgzLzoL71yhKXoEq3bObK/AqWobYb2o0nlznWS2h4gmwhxn+xGg5SO3mgcb0l1tT6xeHpzAzOFc0pyO/QTGM4cAH4mrmgL77w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=QSFyBmbf; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6027943A0486908, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1767337744; bh=+N0cDwlBTDrc/KVh7wpSHRow05F3VTBn0tIgDrrpcxg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=QSFyBmbf1j8/VXoRuaWw6/brtBHpDeOVPzOaQFhRHGu8vlVYc5KFhIBCRh3U4/Wzp
	 gp/pXETDfseS1uxO7U5EmAQR1hSxxKqrYWt/1U6Z/ejL/+ctauqV3v1ZjlvcC959zd
	 0yqJLD/mXU367sCAh/VvIf7eIBBe0wAE+1dvGaRgQGOLNFRmUk3u5Njfq/STd+bzRi
	 TdNJzx7sZNZ9RptLKUeEUVAYEE7BPW+1ZmCTM3SfA+YZqSZ/UzPqZ9KtqLhGdz/Vx9
	 X8Gt2QXiFlHe97f+orEQbDrWo5ork7JIE0PMVay/6iAdtJYj96wW6ed5JUG4eptQXs
	 Rg3jkFY6CzDrg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 6027943A0486908
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 2 Jan 2026 15:09:04 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 2 Jan 2026 15:09:05 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 2 Jan 2026 15:09:05 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Fri, 2 Jan 2026 15:09:05 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH rtw-next 01/10] wifi: rtw89: update TXWD v3 for RTL8922D
Date: Fri, 2 Jan 2026 15:08:31 +0800
Message-ID: <20260102070840.62047-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260102070840.62047-1-pkshih@realtek.com>
References: <20260102070840.62047-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add TXWD v3 to assist in transmitting for RTL8922D according to hardware
design.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 59 +++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/core.h |  3 ++
 drivers/net/wireless/realtek/rtw89/txrx.h | 16 ++++++
 3 files changed, 78 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index e713422ebd7c..36565ba2cc91 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -1633,6 +1633,17 @@ static __le32 rtw89_build_txwd_body2_v2(struct rtw89_tx_desc_info *desc_info)
 	return cpu_to_le32(dword);
 }
 
+static __le32 rtw89_build_txwd_body2_v3(struct rtw89_tx_desc_info *desc_info)
+{
+	u32 dword = FIELD_PREP(BE_TXD_BODY2_TID_IND_V1, desc_info->tid_indicate) |
+		    FIELD_PREP(BE_TXD_BODY2_QSEL_V1, desc_info->qsel) |
+		    FIELD_PREP(BE_TXD_BODY2_TXPKTSIZE, desc_info->pkt_size) |
+		    FIELD_PREP(BE_TXD_BODY2_AGG_EN, desc_info->agg_en) |
+		    FIELD_PREP(BE_TXD_BODY2_MACID_V1, desc_info->mac_id);
+
+	return cpu_to_le32(dword);
+}
+
 static __le32 rtw89_build_txwd_body3_v2(struct rtw89_tx_desc_info *desc_info)
 {
 	u32 dword = FIELD_PREP(BE_TXD_BODY3_WIFI_SEQ, desc_info->seq) |
@@ -1642,6 +1653,16 @@ static __le32 rtw89_build_txwd_body3_v2(struct rtw89_tx_desc_info *desc_info)
 	return cpu_to_le32(dword);
 }
 
+static __le32 rtw89_build_txwd_body3_v3(struct rtw89_tx_desc_info *desc_info)
+{
+	u32 dword = FIELD_PREP(BE_TXD_BODY3_WIFI_SEQ, desc_info->seq) |
+		    FIELD_PREP(BE_TXD_BODY3_MLO_FLAG, desc_info->mlo) |
+		    FIELD_PREP(BE_TXD_BODY3_IS_MLD_SW_EN, desc_info->sw_mld) |
+		    FIELD_PREP(BE_TXD_BODY3_BK_V1, desc_info->bk);
+
+	return cpu_to_le32(dword);
+}
+
 static __le32 rtw89_build_txwd_body4_v2(struct rtw89_tx_desc_info *desc_info)
 {
 	u32 dword = FIELD_PREP(BE_TXD_BODY4_SEC_IV_L0, desc_info->sec_seq[0]) |
@@ -1713,6 +1734,15 @@ static __le32 rtw89_build_txwd_info2_v2(struct rtw89_tx_desc_info *desc_info)
 	return cpu_to_le32(dword);
 }
 
+static __le32 rtw89_build_txwd_info2_v3(struct rtw89_tx_desc_info *desc_info)
+{
+	u32 dword = FIELD_PREP(BE_TXD_INFO2_AMPDU_DENSITY, desc_info->ampdu_density) |
+		    FIELD_PREP(BE_TXD_INFO2_FORCE_KEY_EN_V1, desc_info->sec_en) |
+		    FIELD_PREP(BE_TXD_INFO2_SEC_CAM_IDX_V1, desc_info->sec_cam_idx);
+
+	return cpu_to_le32(dword);
+}
+
 static __le32 rtw89_build_txwd_info4_v2(struct rtw89_tx_desc_info *desc_info)
 {
 	bool rts_en = !desc_info->is_bmc;
@@ -1751,6 +1781,35 @@ void rtw89_core_fill_txdesc_v2(struct rtw89_dev *rtwdev,
 }
 EXPORT_SYMBOL(rtw89_core_fill_txdesc_v2);
 
+void rtw89_core_fill_txdesc_v3(struct rtw89_dev *rtwdev,
+			       struct rtw89_tx_desc_info *desc_info,
+			       void *txdesc)
+{
+	struct rtw89_txwd_body_v2 *txwd_body = txdesc;
+	struct rtw89_txwd_info_v2 *txwd_info;
+
+	txwd_body->dword0 = rtw89_build_txwd_body0_v2(desc_info);
+	txwd_body->dword1 = rtw89_build_txwd_body1_v2(desc_info);
+	txwd_body->dword2 = rtw89_build_txwd_body2_v3(desc_info);
+	txwd_body->dword3 = rtw89_build_txwd_body3_v3(desc_info);
+	if (desc_info->sec_en) {
+		txwd_body->dword4 = rtw89_build_txwd_body4_v2(desc_info);
+		txwd_body->dword5 = rtw89_build_txwd_body5_v2(desc_info);
+	}
+	txwd_body->dword6 = rtw89_build_txwd_body6_v2(desc_info);
+	txwd_body->dword7 = rtw89_build_txwd_body7_v2(desc_info);
+
+	if (!desc_info->en_wd_info)
+		return;
+
+	txwd_info = (struct rtw89_txwd_info_v2 *)(txwd_body + 1);
+	txwd_info->dword0 = rtw89_build_txwd_info0_v2(desc_info);
+	txwd_info->dword1 = rtw89_build_txwd_info1_v2(desc_info);
+	txwd_info->dword2 = rtw89_build_txwd_info2_v3(desc_info);
+	txwd_info->dword4 = rtw89_build_txwd_info4_v2(desc_info);
+}
+EXPORT_SYMBOL(rtw89_core_fill_txdesc_v3);
+
 static __le32 rtw89_build_txwd_fwcmd0_v1(struct rtw89_tx_desc_info *desc_info)
 {
 	u32 dword = FIELD_PREP(AX_RXD_RPKT_LEN_MASK, desc_info->pkt_size) |
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 93b633d39e47..d9931bc95fcc 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -7580,6 +7580,9 @@ void rtw89_core_fill_txdesc_v1(struct rtw89_dev *rtwdev,
 void rtw89_core_fill_txdesc_v2(struct rtw89_dev *rtwdev,
 			       struct rtw89_tx_desc_info *desc_info,
 			       void *txdesc);
+void rtw89_core_fill_txdesc_v3(struct rtw89_dev *rtwdev,
+			       struct rtw89_tx_desc_info *desc_info,
+			       void *txdesc);
 void rtw89_core_fill_txdesc_fwcmd_v1(struct rtw89_dev *rtwdev,
 				     struct rtw89_tx_desc_info *desc_info,
 				     void *txdesc);
diff --git a/drivers/net/wireless/realtek/rtw89/txrx.h b/drivers/net/wireless/realtek/rtw89/txrx.h
index fa324b4a1dde..c92e25f8a2b5 100644
--- a/drivers/net/wireless/realtek/rtw89/txrx.h
+++ b/drivers/net/wireless/realtek/rtw89/txrx.h
@@ -188,12 +188,16 @@ static inline u8 rtw89_get_data_nss(struct rtw89_dev *rtwdev, u16 hw_rate)
 #define BE_TXD_BODY2_QSEL GENMASK(22, 17)
 #define BE_TXD_BODY2_TID_IND BIT(23)
 #define BE_TXD_BODY2_MACID GENMASK(31, 24)
+#define BE_TXD_BODY2_QSEL_V1 GENMASK(20, 15)
+#define BE_TXD_BODY2_TID_IND_V1 BIT(21)
+#define BE_TXD_BODY2_MACID_V1 GENMASK(31, 22)
 
 /* TX WD BODY DWORD 3 */
 #define BE_TXD_BODY3_WIFI_SEQ GENMASK(11, 0)
 #define BE_TXD_BODY3_MLO_FLAG BIT(12)
 #define BE_TXD_BODY3_IS_MLD_SW_EN BIT(13)
 #define BE_TXD_BODY3_TRY_RATE BIT(14)
+#define BE_TXD_BODY3_BK_V1 BIT(14)
 #define BE_TXD_BODY3_RELINK_FLAG_V1 BIT(15)
 #define BE_TXD_BODY3_BAND0_SU_TC_V1 GENMASK(21, 16)
 #define BE_TXD_BODY3_TOTAL_TC GENMASK(27, 22)
@@ -201,6 +205,7 @@ static inline u8 rtw89_get_data_nss(struct rtw89_dev *rtwdev, u16 hw_rate)
 #define BE_TXD_BODY3_MU_PRI_RTY BIT(29)
 #define BE_TXD_BODY3_MU_2ND_RTY BIT(30)
 #define BE_TXD_BODY3_BAND1_SU_RTY_V1 BIT(31)
+#define BE_TXD_BODY3_DRIVER_QUEUE_TIME GENMASK(31, 16)
 
 /* TX WD BODY DWORD 4 */
 #define BE_TXD_BODY4_TXDESC_CHECKSUM GENMASK(15, 0)
@@ -224,6 +229,10 @@ static inline u8 rtw89_get_data_nss(struct rtw89_dev *rtwdev, u16 hw_rate)
 #define BE_TXD_BODY6_EOSP_BIT BIT(15)
 #define BE_TXD_BODY6_S_IDX GENMASK(23, 16)
 #define BE_TXD_BODY6_RU_POS GENMASK(31, 24)
+#define BE_TXD_BODY6_MU_TC_V1 GENMASK(3, 0)
+#define BE_TXD_BODY6_RU_TC_V1 GENMASK(8, 5)
+#define BE_TXD_BODY6_RELINK_EN BIT(9)
+#define BE_TXD_BODY6_RELINK_LAST BIT(10)
 
 /* TX WD BODY DWORD 7 */
 #define BE_TXD_BODY7_RTS_TC GENMASK(5, 0)
@@ -262,6 +271,8 @@ static inline u8 rtw89_get_data_nss(struct rtw89_dev *rtwdev, u16 hw_rate)
 /* TX WD INFO DWORD 2 */
 #define BE_TXD_INFO2_SEC_CAM_IDX GENMASK(7, 0)
 #define BE_TXD_INFO2_FORCE_KEY_EN BIT(8)
+#define BE_TXD_INFO2_SEC_CAM_IDX_V1 GENMASK(9, 0)
+#define BE_TXD_INFO2_FORCE_KEY_EN_V1 BIT(10)
 #define BE_TXD_INFO2_LIFETIME_SEL GENMASK(15, 13)
 #define BE_TXD_INFO2_FORCE_TXOP BIT(17)
 #define BE_TXD_INFO2_AMPDU_DENSITY GENMASK(20, 18)
@@ -277,6 +288,7 @@ static inline u8 rtw89_get_data_nss(struct rtw89_dev *rtwdev, u16 hw_rate)
 #define BE_TXD_INFO3_RTT_EN BIT(9)
 #define BE_TXD_INFO3_HT_DATA_SND_V1 BIT(10)
 #define BE_TXD_INFO3_BT_NULL BIT(11)
+#define BE_TXD_INFO3_DISABLE_TXBF BIT(11)
 #define BE_TXD_INFO3_TRI_FRAME BIT(12)
 #define BE_TXD_INFO3_NULL_0 BIT(13)
 #define BE_TXD_INFO3_NULL_1 BIT(14)
@@ -292,6 +304,8 @@ static inline u8 rtw89_get_data_nss(struct rtw89_dev *rtwdev, u16 hw_rate)
 #define BE_TXD_INFO4_PUNC_MODE GENMASK(17, 16)
 #define BE_TXD_INFO4_SW_TX_OK_0 BIT(18)
 #define BE_TXD_INFO4_SW_TX_OK_1 BIT(19)
+#define BE_TXD_INFO4_SW_EHT_NLTF_SWITCH BIT(20)
+#define BE_TXD_INFO4_SW_EHT_NLTF GENMASK(22, 21)
 #define BE_TXD_INFO4_SW_TX_PWR_DBM GENMASK(26, 23)
 #define BE_TXD_INFO4_RTS_EN BIT(27)
 #define BE_TXD_INFO4_CTS2SELF BIT(28)
@@ -308,6 +322,7 @@ static inline u8 rtw89_get_data_nss(struct rtw89_dev *rtwdev, u16 hw_rate)
 #define BE_TXD_INFO6_UL_GI_LTF GENMASK(14, 12)
 #define BE_TXD_INFO6_UL_DOPPLER BIT(15)
 #define BE_TXD_INFO6_UL_STBC BIT(16)
+#define BE_TXD_INFO6_UL_MU_MIMO_EN BIT(17)
 #define BE_TXD_INFO6_UL_LENGTH_REF GENMASK(21, 18)
 #define BE_TXD_INFO6_UL_RF_GAIN_IDX GENMASK(31, 22)
 
@@ -322,6 +337,7 @@ static inline u8 rtw89_get_data_nss(struct rtw89_dev *rtwdev, u16 hw_rate)
 #define BE_TXD_INFO7_UL_HELTF_SYMBOL_NUM GENMASK(19, 17)
 #define BE_TXD_INFO7_ULBW GENMASK(21, 20)
 #define BE_TXD_INFO7_ULBW_EXT GENMASK(23, 22)
+#define BE_TXD_INFO7_UL_TRI_PAD_TSF BIT(24)
 #define BE_TXD_INFO7_USE_WD_UL GENMASK(25, 24)
 #define BE_TXD_INFO7_EXTEND_MODE_SEL GENMASK(31, 28)
 
-- 
2.25.1


