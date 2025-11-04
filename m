Return-Path: <linux-wireless+bounces-28543-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1566BC315BC
	for <lists+linux-wireless@lfdr.de>; Tue, 04 Nov 2025 15:01:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7B6A3A4DDA
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Nov 2025 13:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5957632E73B;
	Tue,  4 Nov 2025 13:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="QtLjZlT5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F4332D437;
	Tue,  4 Nov 2025 13:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762264678; cv=none; b=g3ZKDzxch1N7uCI6B27L6ESkA1rdtTYa/gszqPkslTVLEnZGEZjN5KdJLZICZR74E3Zc5D7QfISQtpkTK44tcYxowRyroBQMBHBGF9TogbinBXWaafNo2TQE/b5o2+AVGU4hTK3IB2DHr4ume/SbLEFJrzBBkYPQzKFrt3z3Hy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762264678; c=relaxed/simple;
	bh=ZaZ45zy+t7JK9cT/VbWUlKacSLv4F3wogpnyBELGC3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D7IunhT1IIvsHZaa6gEO8OHxLsn/PzJEFa/lILNO4oXged8UutxgYAye/Z29PJ9bnGivkYaOZIfe9ymGzOAHrgurTbZvRHEmsxxI4Xtu86ehtcJqcKrJwxsH2lN99CPPXoKyg/Fig+DRpLzyJyt6lJs2yd5YrfUMuXDPTiMjEv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=QtLjZlT5; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from debian.intra.ispras.ru (unknown [10.10.165.12])
	by mail.ispras.ru (Postfix) with ESMTPSA id 92F1040777B3;
	Tue,  4 Nov 2025 13:57:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 92F1040777B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1762264664;
	bh=nyJDqZegBLDHRxIbnylO9w17OTvFGjUsQI/QfH/s27A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QtLjZlT5FjMZAcAd0TmOL4inyE31JG1GLimJqTGjm3hdUlsunqaA+sj3bkXSIxYY8
	 78XgLEsxCIcMOx0cYExXBeIKB3BPKW/YmXGnp/NDdlDLPdUo0pN2HqxEkSS6KkJh/L
	 WUNi6JOBCUz9mEQjTbIl6bKQK6YsgpesYMnr3Ets=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Zong-Zhe Yang <kevin_yang@realtek.com>,
	Po-Hao Huang <phhuang@realtek.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH rtw-next v5 05/10] wifi: rtw89: implement C2H TX report handler
Date: Tue,  4 Nov 2025 16:57:12 +0300
Message-ID: <20251104135720.321110-6-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251104135720.321110-1-pchelkin@ispras.ru>
References: <20251104135720.321110-1-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rtw89 has several ways of handling TX status report events.  The first one
is based on RPP feature which is used by PCIe HCI.  The other one depends
on firmware sending a corresponding C2H message, quite similar to what
rtw88 has.

Toggle a bit in the TX descriptor to indicate to the firmware that TX
report for the frame is expected.   This will allow handling TX wait skbs
and the ones flagged with IEEE80211_TX_CTL_REQ_TX_STATUS correctly.

Do the bulk of the patch according to the vendor driver for RTL8851BU.
However, there are slight differences in C2H message format between
different types of chips.  RTL885xB ones follow format V0.  RTL8852C has
format V1, and RTL8922AU has format V2.

Found by Linux Verification Center (linuxtesting.org).

Suggested-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---

v4: - use __packed for C2H message structs (Ping-Ke)
    - shorten extremely long lines (Ping-Ke)

v3: - consider V1 and V2 C2H message formats inside rtw89_mac_c2h_tx_rpt() (Bitterblue)
    - use X'mas tree order (Ping-Ke)
    - update changelog considering further patches

v2: - fix bit masks and consider TX transmission retry limit for TX
      reporting (Bitterblue)
    - use newer style for C2H message type definitions and drop
      unimplemented funcs from 'enum rtw89_mac_c2h_misc_func' (Ping-Ke)
    - modify rtw89_core_fill_txdesc_v1() and rtw89_core_fill_txdesc_v2()
      accordingly (Ping-Ke)

 drivers/net/wireless/realtek/rtw89/core.c | 28 +++++++++++---
 drivers/net/wireless/realtek/rtw89/core.h |  4 ++
 drivers/net/wireless/realtek/rtw89/fw.h   | 41 ++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/mac.c  | 46 +++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/mac.h  |  7 ++++
 drivers/net/wireless/realtek/rtw89/txrx.h |  6 ++-
 6 files changed, 126 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 1f92be300ea7..84f94c796a48 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -1415,7 +1415,10 @@ static __le32 rtw89_build_txwd_info1(struct rtw89_tx_desc_info *desc_info)
 	u32 dword = FIELD_PREP(RTW89_TXWD_INFO1_MAX_AGGNUM, desc_info->ampdu_num) |
 		    FIELD_PREP(RTW89_TXWD_INFO1_A_CTRL_BSR, desc_info->a_ctrl_bsr) |
 		    FIELD_PREP(RTW89_TXWD_INFO1_DATA_RTY_LOWEST_RATE,
-			       desc_info->data_retry_lowest_rate);
+			       desc_info->data_retry_lowest_rate) |
+		    FIELD_PREP(RTW89_TXWD_INFO1_DATA_TXCNT_LMT_SEL,
+			       desc_info->tx_cnt_lmt_en) |
+		    FIELD_PREP(RTW89_TXWD_INFO1_DATA_TXCNT_LMT, desc_info->tx_cnt_lmt);
 
 	return cpu_to_le32(dword);
 }
@@ -1439,11 +1442,19 @@ static __le32 rtw89_build_txwd_info2_v1(struct rtw89_tx_desc_info *desc_info)
 	return cpu_to_le32(dword);
 }
 
+static __le32 rtw89_build_txwd_info3(struct rtw89_tx_desc_info *desc_info)
+{
+	u32 dword = FIELD_PREP(RTW89_TXWD_INFO3_SPE_RPT, desc_info->report);
+
+	return cpu_to_le32(dword);
+}
+
 static __le32 rtw89_build_txwd_info4(struct rtw89_tx_desc_info *desc_info)
 {
 	bool rts_en = !desc_info->is_bmc;
 	u32 dword = FIELD_PREP(RTW89_TXWD_INFO4_RTS_EN, rts_en) |
-		    FIELD_PREP(RTW89_TXWD_INFO4_HW_RTS_EN, 1);
+		    FIELD_PREP(RTW89_TXWD_INFO4_HW_RTS_EN, 1) |
+		    FIELD_PREP(RTW89_TXWD_INFO4_SW_DEFINE, desc_info->sn);
 
 	return cpu_to_le32(dword);
 }
@@ -1466,6 +1477,7 @@ void rtw89_core_fill_txdesc(struct rtw89_dev *rtwdev,
 	txwd_info->dword0 = rtw89_build_txwd_info0(desc_info);
 	txwd_info->dword1 = rtw89_build_txwd_info1(desc_info);
 	txwd_info->dword2 = rtw89_build_txwd_info2(desc_info);
+	txwd_info->dword3 = rtw89_build_txwd_info3(desc_info);
 	txwd_info->dword4 = rtw89_build_txwd_info4(desc_info);
 
 }
@@ -1495,6 +1507,7 @@ void rtw89_core_fill_txdesc_v1(struct rtw89_dev *rtwdev,
 	txwd_info->dword0 = rtw89_build_txwd_info0_v1(desc_info);
 	txwd_info->dword1 = rtw89_build_txwd_info1(desc_info);
 	txwd_info->dword2 = rtw89_build_txwd_info2_v1(desc_info);
+	txwd_info->dword3 = rtw89_build_txwd_info3(desc_info);
 	txwd_info->dword4 = rtw89_build_txwd_info4(desc_info);
 }
 EXPORT_SYMBOL(rtw89_core_fill_txdesc_v1);
@@ -1580,7 +1593,10 @@ static __le32 rtw89_build_txwd_info0_v2(struct rtw89_tx_desc_info *desc_info)
 	u32 dword = FIELD_PREP(BE_TXD_INFO0_DATA_STBC, desc_info->stbc) |
 		    FIELD_PREP(BE_TXD_INFO0_DATA_LDPC, desc_info->ldpc) |
 		    FIELD_PREP(BE_TXD_INFO0_DISDATAFB, desc_info->dis_data_fb) |
-		    FIELD_PREP(BE_TXD_INFO0_MULTIPORT_ID, desc_info->port);
+		    FIELD_PREP(BE_TXD_INFO0_MULTIPORT_ID, desc_info->port) |
+		    FIELD_PREP(BE_TXD_INFO0_DATA_TXCNT_LMT_SEL,
+			       desc_info->tx_cnt_lmt_en) |
+		    FIELD_PREP(BE_TXD_INFO0_DATA_TXCNT_LMT, desc_info->tx_cnt_lmt);
 
 	return cpu_to_le32(dword);
 }
@@ -1590,7 +1606,8 @@ static __le32 rtw89_build_txwd_info1_v2(struct rtw89_tx_desc_info *desc_info)
 	u32 dword = FIELD_PREP(BE_TXD_INFO1_MAX_AGG_NUM, desc_info->ampdu_num) |
 		    FIELD_PREP(BE_TXD_INFO1_A_CTRL_BSR, desc_info->a_ctrl_bsr) |
 		    FIELD_PREP(BE_TXD_INFO1_DATA_RTY_LOWEST_RATE,
-			       desc_info->data_retry_lowest_rate);
+			       desc_info->data_retry_lowest_rate) |
+		    FIELD_PREP(BE_TXD_INFO1_SW_DEFINE, desc_info->sn);
 
 	return cpu_to_le32(dword);
 }
@@ -1599,7 +1616,8 @@ static __le32 rtw89_build_txwd_info2_v2(struct rtw89_tx_desc_info *desc_info)
 {
 	u32 dword = FIELD_PREP(BE_TXD_INFO2_AMPDU_DENSITY, desc_info->ampdu_density) |
 		    FIELD_PREP(BE_TXD_INFO2_FORCE_KEY_EN, desc_info->sec_en) |
-		    FIELD_PREP(BE_TXD_INFO2_SEC_CAM_IDX, desc_info->sec_cam_idx);
+		    FIELD_PREP(BE_TXD_INFO2_SEC_CAM_IDX, desc_info->sec_cam_idx) |
+		    FIELD_PREP(BE_TXD_INFO2_SPE_RPT_V1, desc_info->report);
 
 	return cpu_to_le32(dword);
 }
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index d23ec4d4095a..2914cc4e97d5 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -1169,6 +1169,10 @@ struct rtw89_tx_desc_info {
 	u8 ampdu_density;
 	u8 ampdu_num;
 	bool sec_en;
+	bool report;
+	bool tx_cnt_lmt_en;
+	u8 sn: 4;
+	u8 tx_cnt_lmt: 6;
 	u8 addr_info_nr;
 	u8 sec_keyid;
 	u8 sec_type;
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index ddebf7972068..310580206368 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -3747,6 +3747,47 @@ struct rtw89_c2h_scanofld {
 #define RTW89_GET_MAC_C2H_MCC_REQ_ACK_H2C_FUNC(c2h) \
 	le32_get_bits(*((const __le32 *)(c2h) + 2), GENMASK(15, 8))
 
+struct rtw89_c2h_mac_tx_rpt {
+	struct rtw89_c2h_hdr hdr;
+	__le32 w2;
+	__le32 w3;
+	__le32 w4;
+	__le32 w5;
+	__le32 w6;
+	__le32 w7;
+} __packed;
+
+#define RTW89_C2H_MAC_TX_RPT_W2_TX_STATE GENMASK(7, 6)
+#define RTW89_C2H_MAC_TX_RPT_W2_SW_DEFINE GENMASK(11, 8)
+#define RTW89_C2H_MAC_TX_RPT_W5_DATA_TX_CNT GENMASK(13, 8)
+#define RTW89_C2H_MAC_TX_RPT_W5_DATA_TX_CNT_V1 GENMASK(15, 10)
+
+struct rtw89_c2h_mac_tx_rpt_v2 {
+	struct rtw89_c2h_hdr hdr;
+	__le32 w2;
+	__le32 w3;
+	__le32 w4;
+	__le32 w5;
+	__le32 w6;
+	__le32 w7;
+	__le32 w8;
+	__le32 w9;
+	__le32 w10;
+	__le32 w11;
+	__le32 w12;
+	__le32 w13;
+	__le32 w14;
+	__le32 w15;
+	__le32 w16;
+	__le32 w17;
+	__le32 w18;
+	__le32 w19;
+} __packed;
+
+#define RTW89_C2H_MAC_TX_RPT_W12_TX_STATE_V2 GENMASK(9, 8)
+#define RTW89_C2H_MAC_TX_RPT_W12_SW_DEFINE_V2 GENMASK(15, 12)
+#define RTW89_C2H_MAC_TX_RPT_W14_DATA_TX_CNT_V2 GENMASK(15, 10)
+
 struct rtw89_mac_mcc_tsf_rpt {
 	u32 macid_x;
 	u32 macid_y;
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index bc39b4f7bc4f..47048d125c01 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -5488,6 +5488,40 @@ rtw89_mac_c2h_mcc_status_rpt(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32
 	rtw89_complete_cond(&rtwdev->mcc.wait, cond, &data);
 }
 
+static void
+rtw89_mac_c2h_tx_rpt(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 len)
+{
+	u8 sw_define, tx_status, txcnt;
+
+	if (rtwdev->chip->chip_id == RTL8922A) {
+		const struct rtw89_c2h_mac_tx_rpt_v2 *rpt_v2;
+
+		rpt_v2 = (const struct rtw89_c2h_mac_tx_rpt_v2 *)c2h->data;
+		sw_define = le32_get_bits(rpt_v2->w12,
+					  RTW89_C2H_MAC_TX_RPT_W12_SW_DEFINE_V2);
+		tx_status = le32_get_bits(rpt_v2->w12,
+					  RTW89_C2H_MAC_TX_RPT_W12_TX_STATE_V2);
+		txcnt = le32_get_bits(rpt_v2->w14,
+				      RTW89_C2H_MAC_TX_RPT_W14_DATA_TX_CNT_V2);
+	} else {
+		const struct rtw89_c2h_mac_tx_rpt *rpt;
+
+		rpt = (const struct rtw89_c2h_mac_tx_rpt *)c2h->data;
+		sw_define = le32_get_bits(rpt->w2, RTW89_C2H_MAC_TX_RPT_W2_SW_DEFINE);
+		tx_status = le32_get_bits(rpt->w2, RTW89_C2H_MAC_TX_RPT_W2_TX_STATE);
+		if (rtwdev->chip->chip_id == RTL8852C)
+			txcnt = le32_get_bits(rpt->w5,
+					      RTW89_C2H_MAC_TX_RPT_W5_DATA_TX_CNT_V1);
+		else
+			txcnt = le32_get_bits(rpt->w5,
+					      RTW89_C2H_MAC_TX_RPT_W5_DATA_TX_CNT);
+	}
+
+	rtw89_debug(rtwdev, RTW89_DBG_TXRX,
+		    "C2H TX RPT: sn %d, tx_status %d, txcnt %d\n",
+		    sw_define, tx_status, txcnt);
+}
+
 static void
 rtw89_mac_c2h_mrc_tsf_rpt(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 len)
 {
@@ -5722,6 +5756,12 @@ void (* const rtw89_mac_c2h_mcc_handler[])(struct rtw89_dev *rtwdev,
 	[RTW89_MAC_C2H_FUNC_MCC_STATUS_RPT] = rtw89_mac_c2h_mcc_status_rpt,
 };
 
+static
+void (* const rtw89_mac_c2h_misc_handler[])(struct rtw89_dev *rtwdev,
+					    struct sk_buff *c2h, u32 len) = {
+	[RTW89_MAC_C2H_FUNC_TX_REPORT] = rtw89_mac_c2h_tx_rpt,
+};
+
 static
 void (* const rtw89_mac_c2h_mlo_handler[])(struct rtw89_dev *rtwdev,
 					   struct sk_buff *c2h, u32 len) = {
@@ -5808,6 +5848,8 @@ bool rtw89_mac_c2h_chk_atomic(struct rtw89_dev *rtwdev, struct sk_buff *c2h,
 		}
 	case RTW89_MAC_C2H_CLASS_MCC:
 		return true;
+	case RTW89_MAC_C2H_CLASS_MISC:
+		return true;
 	case RTW89_MAC_C2H_CLASS_MLO:
 		return true;
 	case RTW89_MAC_C2H_CLASS_MRC:
@@ -5843,6 +5885,10 @@ void rtw89_mac_c2h_handle(struct rtw89_dev *rtwdev, struct sk_buff *skb,
 		if (func < NUM_OF_RTW89_MAC_C2H_FUNC_MCC)
 			handler = rtw89_mac_c2h_mcc_handler[func];
 		break;
+	case RTW89_MAC_C2H_CLASS_MISC:
+		if (func < NUM_OF_RTW89_MAC_C2H_FUNC_MISC)
+			handler = rtw89_mac_c2h_misc_handler[func];
+		break;
 	case RTW89_MAC_C2H_CLASS_MLO:
 		if (func < NUM_OF_RTW89_MAC_C2H_FUNC_MLO)
 			handler = rtw89_mac_c2h_mlo_handler[func];
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 46302f4aa3d9..dfa85ade38ce 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -432,6 +432,12 @@ enum rtw89_mac_c2h_mcc_func {
 	NUM_OF_RTW89_MAC_C2H_FUNC_MCC,
 };
 
+enum rtw89_mac_c2h_misc_func {
+	RTW89_MAC_C2H_FUNC_TX_REPORT = 1,
+
+	NUM_OF_RTW89_MAC_C2H_FUNC_MISC,
+};
+
 enum rtw89_mac_c2h_mlo_func {
 	RTW89_MAC_C2H_FUNC_MLO_GET_TBL			= 0x0,
 	RTW89_MAC_C2H_FUNC_MLO_EMLSR_TRANS_DONE		= 0x1,
@@ -470,6 +476,7 @@ enum rtw89_mac_c2h_class {
 	RTW89_MAC_C2H_CLASS_WOW = 0x3,
 	RTW89_MAC_C2H_CLASS_MCC = 0x4,
 	RTW89_MAC_C2H_CLASS_FWDBG = 0x5,
+	RTW89_MAC_C2H_CLASS_MISC = 0x9,
 	RTW89_MAC_C2H_CLASS_MLO = 0xc,
 	RTW89_MAC_C2H_CLASS_MRC = 0xe,
 	RTW89_MAC_C2H_CLASS_AP = 0x18,
diff --git a/drivers/net/wireless/realtek/rtw89/txrx.h b/drivers/net/wireless/realtek/rtw89/txrx.h
index 984c9fdbb018..b37dbac7b790 100644
--- a/drivers/net/wireless/realtek/rtw89/txrx.h
+++ b/drivers/net/wireless/realtek/rtw89/txrx.h
@@ -127,6 +127,8 @@ static inline u8 rtw89_get_data_nss(struct rtw89_dev *rtwdev, u16 hw_rate)
 #define RTW89_TXWD_INFO0_MULTIPORT_ID GENMASK(6, 4)
 
 /* TX WD INFO DWORD 1 */
+#define RTW89_TXWD_INFO1_DATA_TXCNT_LMT_SEL BIT(31)
+#define RTW89_TXWD_INFO1_DATA_TXCNT_LMT GENMASK(30, 25)
 #define RTW89_TXWD_INFO1_DATA_RTY_LOWEST_RATE GENMASK(24, 16)
 #define RTW89_TXWD_INFO1_A_CTRL_BSR BIT(14)
 #define RTW89_TXWD_INFO1_MAX_AGGNUM GENMASK(7, 0)
@@ -139,10 +141,12 @@ static inline u8 rtw89_get_data_nss(struct rtw89_dev *rtwdev, u16 hw_rate)
 #define RTW89_TXWD_INFO2_SEC_CAM_IDX GENMASK(7, 0)
 
 /* TX WD INFO DWORD 3 */
+#define RTW89_TXWD_INFO3_SPE_RPT BIT(10)
 
 /* TX WD INFO DWORD 4 */
-#define RTW89_TXWD_INFO4_RTS_EN BIT(27)
 #define RTW89_TXWD_INFO4_HW_RTS_EN BIT(31)
+#define RTW89_TXWD_INFO4_RTS_EN BIT(27)
+#define RTW89_TXWD_INFO4_SW_DEFINE GENMASK(3, 0)
 
 /* TX WD INFO DWORD 5 */
 
-- 
2.51.0


