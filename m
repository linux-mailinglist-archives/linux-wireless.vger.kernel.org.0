Return-Path: <linux-wireless+bounces-27538-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF592B8C900
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Sep 2025 15:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D5E3581A59
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Sep 2025 13:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF822F5472;
	Sat, 20 Sep 2025 13:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="af4GPsV1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B1421B9FD;
	Sat, 20 Sep 2025 13:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758374847; cv=none; b=LI/uD7s84w2h1UM40zqXBrhtcGVxttaeKyeLiap+9mLOQij/jLieEDe/KzLHauq2Ekxgj7CZ0OE2BDz2kQHgON1ju3DpYSnUKo1fUsGTIhipzvcsEExvKrQaeFudjYvH+YOemXVdn1GH561uN65jJXqz67hQM0qlNrfLQ7O8QBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758374847; c=relaxed/simple;
	bh=l15qfHvbWBbEbSPebXNZBwWTH7/nQF3MOqffe6BmUVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iYZ8hryxS83+1tzAEKJPPL9O846+ApFTlmJ9GKmWoN7/XR9PP/79Na0+k9+j+WrGsHj7M1saFMcMEd3WltuLjCG4Bn+V4x5QAiy+zD5vE1xrRRN+kd8EzTOwjYe7ucpTFW+G5iVbaiaqpqd8amx+QK08WieXZy9uR9vhlaAEunY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=af4GPsV1; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from debian.intra.ispras.ru (unknown [10.10.165.11])
	by mail.ispras.ru (Postfix) with ESMTPSA id 67C3140762E3;
	Sat, 20 Sep 2025 13:27:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 67C3140762E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1758374842;
	bh=u9ayjBmbstI/fj4lHOYTyzGJ+UXftVdmTPLI+eJ150U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=af4GPsV1YQYf8D7NBb4+EsOwhiBhNutrj9rhtrk1Ns7OXOQN4qMKvdmQdq/G46ZLy
	 4IzaIrtw8+SMjDKwuqb4nskYRXZX8Fg5hHLKXAp3HuD4pDD7YoybvVeX2/SnyHCK9B
	 8u8/fQNfqajKml65j8bQ40LBGzHYLohcIQlu85oo=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Zong-Zhe Yang <kevin_yang@realtek.com>,
	Po-Hao Huang <phhuang@realtek.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH rtw-next 3/6] wifi: rtw89: implement C2H TX report handler
Date: Sat, 20 Sep 2025 16:26:08 +0300
Message-ID: <20250920132614.277719-4-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250920132614.277719-1-pchelkin@ispras.ru>
References: <20250920132614.277719-1-pchelkin@ispras.ru>
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

Toggle a bit in the TX descriptor and place skb in a queue to wait for a
message from the firmware.  Do this according to the vendor driver for
RTL8851BU.

It seems the only way to implement TX status reporting for rtw89 USB.
This will allow handling TX wait skbs and the ones flagged with
IEEE80211_TX_CTL_REQ_TX_STATUS correctly.

Found by Linux Verification Center (linuxtesting.org).

Suggested-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
 drivers/net/wireless/realtek/rtw89/core.c | 12 +++++++++++-
 drivers/net/wireless/realtek/rtw89/core.h |  2 ++
 drivers/net/wireless/realtek/rtw89/fw.h   |  5 +++++
 drivers/net/wireless/realtek/rtw89/mac.c  | 23 +++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/mac.h  |  9 +++++++++
 drivers/net/wireless/realtek/rtw89/txrx.h |  2 ++
 6 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 917b2adede61..d2a559ddfa2e 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -1420,11 +1420,20 @@ static __le32 rtw89_build_txwd_info2_v1(struct rtw89_tx_desc_info *desc_info)
 	return cpu_to_le32(dword);
 }
 
+static __le32 rtw89_build_txwd_info3(struct rtw89_tx_desc_info *desc_info)
+{
+	bool rpt_en = desc_info->report;
+	u32 dword = FIELD_PREP(RTW89_TXWD_INFO3_SPE_RPT, rpt_en);
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
@@ -1447,6 +1456,7 @@ void rtw89_core_fill_txdesc(struct rtw89_dev *rtwdev,
 	txwd_info->dword0 = rtw89_build_txwd_info0(desc_info);
 	txwd_info->dword1 = rtw89_build_txwd_info1(desc_info);
 	txwd_info->dword2 = rtw89_build_txwd_info2(desc_info);
+	txwd_info->dword3 = rtw89_build_txwd_info3(desc_info);
 	txwd_info->dword4 = rtw89_build_txwd_info4(desc_info);
 
 }
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 928c8c84c964..2362724323a9 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -1167,6 +1167,8 @@ struct rtw89_tx_desc_info {
 	u8 ampdu_density;
 	u8 ampdu_num;
 	bool sec_en;
+	bool report;
+	u8 sn;
 	u8 addr_info_nr;
 	u8 sec_keyid;
 	u8 sec_type;
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index ddebf7972068..f196088a8316 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -3747,6 +3747,11 @@ struct rtw89_c2h_scanofld {
 #define RTW89_GET_MAC_C2H_MCC_REQ_ACK_H2C_FUNC(c2h) \
 	le32_get_bits(*((const __le32 *)(c2h) + 2), GENMASK(15, 8))
 
+#define RTW89_GET_MAC_C2H_TX_RPT_TX_STATE(c2h) \
+	le32_get_bits(*((const __le32 *)(c2h) + 2), GENMASK(7, 6))
+#define RTW89_GET_MAC_C2H_TX_RPT_SW_DEFINE(c2h) \
+	le32_get_bits(*((const __le32 *)(c2h) + 2), GENMASK(12, 8))
+
 struct rtw89_mac_mcc_tsf_rpt {
 	u32 macid_x;
 	u32 macid_y;
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index fd11b8fb3c89..01afdcd5f36c 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -5457,6 +5457,17 @@ rtw89_mac_c2h_mcc_status_rpt(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32
 	rtw89_complete_cond(&rtwdev->mcc.wait, cond, &data);
 }
 
+static void
+rtw89_mac_c2h_tx_rpt(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 len)
+{
+	u8 sw_define = RTW89_GET_MAC_C2H_TX_RPT_SW_DEFINE(c2h->data);
+	u8 tx_status = RTW89_GET_MAC_C2H_TX_RPT_TX_STATE(c2h->data);
+
+	rtw89_debug(rtwdev, RTW89_DBG_TXRX,
+		    "C2H TX RPT: sn %d, tx_status %d\n",
+		    sw_define, tx_status);
+}
+
 static void
 rtw89_mac_c2h_mrc_tsf_rpt(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 len)
 {
@@ -5691,6 +5702,12 @@ void (* const rtw89_mac_c2h_mcc_handler[])(struct rtw89_dev *rtwdev,
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
@@ -5777,6 +5794,8 @@ bool rtw89_mac_c2h_chk_atomic(struct rtw89_dev *rtwdev, struct sk_buff *c2h,
 		}
 	case RTW89_MAC_C2H_CLASS_MCC:
 		return true;
+	case RTW89_MAC_C2H_CLASS_MISC:
+		return true;
 	case RTW89_MAC_C2H_CLASS_MLO:
 		return true;
 	case RTW89_MAC_C2H_CLASS_MRC:
@@ -5812,6 +5831,10 @@ void rtw89_mac_c2h_handle(struct rtw89_dev *rtwdev, struct sk_buff *skb,
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
index 25fe5e5c8a97..632b85aed032 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -432,6 +432,14 @@ enum rtw89_mac_c2h_mcc_func {
 	NUM_OF_RTW89_MAC_C2H_FUNC_MCC,
 };
 
+enum rtw89_mac_c2h_misc_func {
+	RTW89_MAC_C2H_FUNC_WPS_RPT,
+	RTW89_MAC_C2H_FUNC_TX_REPORT,
+	RTW89_MAC_C2H_FUNC_BF_SENS_FEEDBACK = 0x4,
+
+	NUM_OF_RTW89_MAC_C2H_FUNC_MISC,
+};
+
 enum rtw89_mac_c2h_mlo_func {
 	RTW89_MAC_C2H_FUNC_MLO_GET_TBL			= 0x0,
 	RTW89_MAC_C2H_FUNC_MLO_EMLSR_TRANS_DONE		= 0x1,
@@ -470,6 +478,7 @@ enum rtw89_mac_c2h_class {
 	RTW89_MAC_C2H_CLASS_WOW = 0x3,
 	RTW89_MAC_C2H_CLASS_MCC = 0x4,
 	RTW89_MAC_C2H_CLASS_FWDBG = 0x5,
+	RTW89_MAC_C2H_CLASS_MISC = 0x9,
 	RTW89_MAC_C2H_CLASS_MLO = 0xc,
 	RTW89_MAC_C2H_CLASS_MRC = 0xe,
 	RTW89_MAC_C2H_CLASS_AP = 0x18,
diff --git a/drivers/net/wireless/realtek/rtw89/txrx.h b/drivers/net/wireless/realtek/rtw89/txrx.h
index 984c9fdbb018..d7259e6d798e 100644
--- a/drivers/net/wireless/realtek/rtw89/txrx.h
+++ b/drivers/net/wireless/realtek/rtw89/txrx.h
@@ -139,8 +139,10 @@ static inline u8 rtw89_get_data_nss(struct rtw89_dev *rtwdev, u16 hw_rate)
 #define RTW89_TXWD_INFO2_SEC_CAM_IDX GENMASK(7, 0)
 
 /* TX WD INFO DWORD 3 */
+#define RTW89_TXWD_INFO3_SPE_RPT BIT(10)
 
 /* TX WD INFO DWORD 4 */
+#define RTW89_TXWD_INFO4_SW_DEFINE GENMASK(3, 0)
 #define RTW89_TXWD_INFO4_RTS_EN BIT(27)
 #define RTW89_TXWD_INFO4_HW_RTS_EN BIT(31)
 
-- 
2.51.0


