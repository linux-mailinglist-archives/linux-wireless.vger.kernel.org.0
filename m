Return-Path: <linux-wireless+bounces-27294-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36CFDB570C1
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Sep 2025 08:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 813DD189A7C8
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Sep 2025 06:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11452C028F;
	Mon, 15 Sep 2025 06:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="GOCu8fiT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07982550AF
	for <linux-wireless@vger.kernel.org>; Mon, 15 Sep 2025 06:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757919350; cv=none; b=orX/DoXFO/MdP0TZespQbLVs0bQnl9iXoiBR9AfozNhX7ZRWoMj/5ag2dVA+a28W7SJ2Dw8QEom9unF5hCr8IIPPQ9ymMP+CrAAeyfJZEGk4e8y3c5Fc7DqGxN+ox+KqRGnMyrrSVsKw0LqOKcfeWahBtsqoZGJPIKhDA+C4Et4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757919350; c=relaxed/simple;
	bh=jk482uxZZZqZVcW46qL+dywLm0szJ6d1su5PJMUGzNk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Db9/1AqCs6Aqb/wKyMdcYd/BIK+CYxtAoXR86csHn0bzszSdcP/BaBDRkhKRtl99WqLexBO8R6R88WmvRG1hu0B65OGfaSUgBV76XZ9AvCbF6vepqbXe71gaj+iXlKyNqwznLFhpwQJevNOU1F+E+d0+4hf3TRzgva5cteQ8pG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=GOCu8fiT; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 58F6tjbR7594920, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1757919345; bh=FCcycoaGP9WFKD54yYd1q12caD/WQJ1bjTh5HlCeyAk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=GOCu8fiTTA9TZdekw48Q2pHvCkzbQl0FhybW8JUiSbj4Xvg34sIngUPKOAZTilrdw
	 8XO0f+Hsg15PAbHsQ+pUJ6HHXf+rS68hM83Isk0SWt778rPNGt5SxowYLf2huaqJXm
	 VRgQ/6NnQD2ggqrWLp4d3ZvpFS4DAxhZ7oEpjHpgoJF4QhCdk0nPLhPgVL+q89mQFq
	 PKLJ90zF3Fshb+W453lIqxU/fM0ByIXqsHPjf5z9WKLextu7YfDi70vV8uP5f77c5u
	 axGpQeHZVcI2wMffc8dygj5yhb8spmeZdRKeKxI0ePgqnnR7oZATejlvdL+pj4+CtC
	 AUKq83ZCzq5EA==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 58F6tjbR7594920
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 15 Sep 2025 14:55:45 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Mon, 15 Sep 2025 14:55:45 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27; Mon, 15 Sep
 2025 14:55:45 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <damon.chen@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 11/11] wifi: rtw89: wow: enable TKIP related feature
Date: Mon, 15 Sep 2025 14:54:34 +0800
Message-ID: <20250915065434.39324-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250915065213.38659-1-pkshih@realtek.com>
References: <20250915065213.38659-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTKEXHMBS06.realtek.com.tw (10.21.1.56)

From: Chih-Kang Chang <gary.chang@realtek.com>

For chips that supports TKIP HW encryption and decryption, enable TKIP
cipher for WoWLAN feature. Additionally, the TX MIC KEY and RX MIC KEY is
opposite in FW. Therefore, reverse the MIC KEY direction in H2C format,
and also reverse it from AOAC report before reporting to mac80211.

Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h |  2 +-
 drivers/net/wireless/realtek/rtw89/fw.c   |  5 +-
 drivers/net/wireless/realtek/rtw89/wow.c  | 79 ++++++++++++++++++-----
 drivers/net/wireless/realtek/rtw89/wow.h  |  6 ++
 4 files changed, 74 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 8408d5d8d42d..3d4ad2ffb75c 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -5771,8 +5771,8 @@ struct rtw89_wow_gtk_info {
 	u8 kck[32];
 	u8 kek[32];
 	u8 tk1[16];
-	u8 txmickey[8];
 	u8 rxmickey[8];
+	u8 txmickey[8];
 	__le32 igtk_keyid;
 	__le64 ipn;
 	u8 igtk[2][32];
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 2273dae8434a..ab904a7def1b 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -8726,9 +8726,10 @@ int rtw89_fw_h2c_wow_gtk_ofld(struct rtw89_dev *rtwdev,
 			goto fail;
 	}
 
-	/* not support TKIP yet */
 	h2c->w0 = le32_encode_bits(enable, RTW89_H2C_WOW_GTK_OFLD_W0_EN) |
-		  le32_encode_bits(0, RTW89_H2C_WOW_GTK_OFLD_W0_TKIP_EN) |
+		  le32_encode_bits(!!memchr_inv(gtk_info->txmickey, 0,
+						sizeof(gtk_info->txmickey)),
+				   RTW89_H2C_WOW_GTK_OFLD_W0_TKIP_EN) |
 		  le32_encode_bits(gtk_info->igtk_keyid ? 1 : 0,
 				   RTW89_H2C_WOW_GTK_OFLD_W0_IEEE80211W_EN) |
 		  le32_encode_bits(macid, RTW89_H2C_WOW_GTK_OFLD_W0_MAC_ID) |
diff --git a/drivers/net/wireless/realtek/rtw89/wow.c b/drivers/net/wireless/realtek/rtw89/wow.c
index 5bb7c1a42f1d..5faa51ad896a 100644
--- a/drivers/net/wireless/realtek/rtw89/wow.c
+++ b/drivers/net/wireless/realtek/rtw89/wow.c
@@ -99,13 +99,26 @@ static int rtw89_rx_pn_to_iv(struct rtw89_dev *rtwdev,
 
 	ieee80211_get_key_rx_seq(key, 0, &seq);
 
-	/* seq.ccmp.pn[] is BE order array */
-	pn = u64_encode_bits(seq.ccmp.pn[0], RTW89_KEY_PN_5) |
-	     u64_encode_bits(seq.ccmp.pn[1], RTW89_KEY_PN_4) |
-	     u64_encode_bits(seq.ccmp.pn[2], RTW89_KEY_PN_3) |
-	     u64_encode_bits(seq.ccmp.pn[3], RTW89_KEY_PN_2) |
-	     u64_encode_bits(seq.ccmp.pn[4], RTW89_KEY_PN_1) |
-	     u64_encode_bits(seq.ccmp.pn[5], RTW89_KEY_PN_0);
+	switch (key->cipher) {
+	case WLAN_CIPHER_SUITE_TKIP:
+		pn = u64_encode_bits(seq.tkip.iv32, RTW89_KEY_TKIP_PN_IV32) |
+		     u64_encode_bits(seq.tkip.iv16, RTW89_KEY_TKIP_PN_IV16);
+		break;
+	case WLAN_CIPHER_SUITE_CCMP:
+	case WLAN_CIPHER_SUITE_GCMP:
+	case WLAN_CIPHER_SUITE_CCMP_256:
+	case WLAN_CIPHER_SUITE_GCMP_256:
+		/* seq.ccmp.pn[] is BE order array */
+		pn = u64_encode_bits(seq.ccmp.pn[0], RTW89_KEY_PN_5) |
+		     u64_encode_bits(seq.ccmp.pn[1], RTW89_KEY_PN_4) |
+		     u64_encode_bits(seq.ccmp.pn[2], RTW89_KEY_PN_3) |
+		     u64_encode_bits(seq.ccmp.pn[3], RTW89_KEY_PN_2) |
+		     u64_encode_bits(seq.ccmp.pn[4], RTW89_KEY_PN_1) |
+		     u64_encode_bits(seq.ccmp.pn[5], RTW89_KEY_PN_0);
+		break;
+	default:
+		return -EINVAL;
+	}
 
 	err = _pn_to_iv(rtwdev, key, iv, pn, key->keyidx);
 	if (err)
@@ -177,13 +190,26 @@ static int rtw89_rx_iv_to_pn(struct rtw89_dev *rtwdev,
 	if (err)
 		return err;
 
-	/* seq.ccmp.pn[] is BE order array */
-	seq.ccmp.pn[0] = u64_get_bits(pn, RTW89_KEY_PN_5);
-	seq.ccmp.pn[1] = u64_get_bits(pn, RTW89_KEY_PN_4);
-	seq.ccmp.pn[2] = u64_get_bits(pn, RTW89_KEY_PN_3);
-	seq.ccmp.pn[3] = u64_get_bits(pn, RTW89_KEY_PN_2);
-	seq.ccmp.pn[4] = u64_get_bits(pn, RTW89_KEY_PN_1);
-	seq.ccmp.pn[5] = u64_get_bits(pn, RTW89_KEY_PN_0);
+	switch (key->cipher) {
+	case WLAN_CIPHER_SUITE_TKIP:
+		seq.tkip.iv32 = u64_get_bits(pn, RTW89_KEY_TKIP_PN_IV32);
+		seq.tkip.iv16 = u64_get_bits(pn, RTW89_KEY_TKIP_PN_IV16);
+		break;
+	case WLAN_CIPHER_SUITE_CCMP:
+	case WLAN_CIPHER_SUITE_GCMP:
+	case WLAN_CIPHER_SUITE_CCMP_256:
+	case WLAN_CIPHER_SUITE_GCMP_256:
+		/* seq.ccmp.pn[] is BE order array */
+		seq.ccmp.pn[0] = u64_get_bits(pn, RTW89_KEY_PN_5);
+		seq.ccmp.pn[1] = u64_get_bits(pn, RTW89_KEY_PN_4);
+		seq.ccmp.pn[2] = u64_get_bits(pn, RTW89_KEY_PN_3);
+		seq.ccmp.pn[3] = u64_get_bits(pn, RTW89_KEY_PN_2);
+		seq.ccmp.pn[4] = u64_get_bits(pn, RTW89_KEY_PN_1);
+		seq.ccmp.pn[5] = u64_get_bits(pn, RTW89_KEY_PN_0);
+		break;
+	default:
+		return -EINVAL;
+	}
 
 	ieee80211_set_key_rx_seq(key, 0, &seq);
 	rtw89_debug(rtwdev, RTW89_DBG_WOW, "%s key %d iv-%*ph to pn-%*ph\n",
@@ -285,6 +311,11 @@ static void rtw89_wow_get_key_info_iter(struct ieee80211_hw *hw,
 
 	switch (key->cipher) {
 	case WLAN_CIPHER_SUITE_TKIP:
+		if (sta)
+			memcpy(gtk_info->txmickey,
+			       key->key + NL80211_TKIP_DATA_OFFSET_TX_MIC_KEY,
+			       sizeof(gtk_info->txmickey));
+		fallthrough;
 	case WLAN_CIPHER_SUITE_CCMP:
 	case WLAN_CIPHER_SUITE_GCMP:
 	case WLAN_CIPHER_SUITE_CCMP_256:
@@ -348,10 +379,27 @@ static void rtw89_wow_set_key_info_iter(struct ieee80211_hw *hw,
 	struct rtw89_wow_aoac_report *aoac_rpt = &rtw_wow->aoac_rpt;
 	struct rtw89_set_key_info_iter_data *iter_data = data;
 	bool update_tx_key_info = iter_data->rx_ready;
+	u8 tmp[RTW89_MIC_KEY_LEN];
 	int ret;
 
 	switch (key->cipher) {
 	case WLAN_CIPHER_SUITE_TKIP:
+		/*
+		 * TX MIC KEY and RX MIC KEY is oppsite in FW,
+		 * need to swap it before sending to mac80211.
+		 */
+		if (!sta && update_tx_key_info && aoac_rpt->rekey_ok &&
+		    !iter_data->tkip_gtk_swapped) {
+			memcpy(tmp, &aoac_rpt->gtk[NL80211_TKIP_DATA_OFFSET_TX_MIC_KEY],
+			       RTW89_MIC_KEY_LEN);
+			memcpy(&aoac_rpt->gtk[NL80211_TKIP_DATA_OFFSET_TX_MIC_KEY],
+			       &aoac_rpt->gtk[NL80211_TKIP_DATA_OFFSET_RX_MIC_KEY],
+			       RTW89_MIC_KEY_LEN);
+			memcpy(&aoac_rpt->gtk[NL80211_TKIP_DATA_OFFSET_RX_MIC_KEY],
+			       tmp, RTW89_MIC_KEY_LEN);
+			iter_data->tkip_gtk_swapped = true;
+		}
+		fallthrough;
 	case WLAN_CIPHER_SUITE_CCMP:
 	case WLAN_CIPHER_SUITE_GCMP:
 	case WLAN_CIPHER_SUITE_CCMP_256:
@@ -642,7 +690,8 @@ static void rtw89_wow_update_key_info(struct rtw89_dev *rtwdev, bool rx_ready)
 	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
 	struct rtw89_wow_aoac_report *aoac_rpt = &rtw_wow->aoac_rpt;
 	struct rtw89_set_key_info_iter_data data = {.error = false,
-						    .rx_ready = rx_ready};
+						    .rx_ready = rx_ready,
+						    .tkip_gtk_swapped = false};
 	struct ieee80211_bss_conf *bss_conf;
 	struct ieee80211_key_conf *key;
 
diff --git a/drivers/net/wireless/realtek/rtw89/wow.h b/drivers/net/wireless/realtek/rtw89/wow.h
index 6606528d31c7..d2ba6cebc2a6 100644
--- a/drivers/net/wireless/realtek/rtw89/wow.h
+++ b/drivers/net/wireless/realtek/rtw89/wow.h
@@ -5,6 +5,9 @@
 #ifndef __RTW89_WOW_H__
 #define __RTW89_WOW_H__
 
+#define RTW89_KEY_TKIP_PN_IV16 GENMASK_ULL(15, 0)
+#define RTW89_KEY_TKIP_PN_IV32 GENMASK_ULL(47, 16)
+
 #define RTW89_KEY_PN_0 GENMASK_ULL(7, 0)
 #define RTW89_KEY_PN_1 GENMASK_ULL(15, 8)
 #define RTW89_KEY_PN_2 GENMASK_ULL(23, 16)
@@ -25,6 +28,8 @@
 #define RTW89_WOW_SYMBOL_CHK_PTK BIT(0)
 #define RTW89_WOW_SYMBOL_CHK_GTK BIT(1)
 
+#define RTW89_MIC_KEY_LEN 8
+
 enum rtw89_wake_reason {
 	RTW89_WOW_RSN_RX_PTK_REKEY = 0x1,
 	RTW89_WOW_RSN_RX_GTK_REKEY = 0x2,
@@ -73,6 +78,7 @@ struct rtw89_set_key_info_iter_data {
 	u32 igtk_cipher;
 	bool rx_ready;
 	bool error;
+	bool tkip_gtk_swapped;
 };
 
 static inline int rtw89_wow_get_sec_hdr_len(struct rtw89_dev *rtwdev)
-- 
2.25.1


