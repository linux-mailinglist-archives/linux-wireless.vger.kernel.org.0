Return-Path: <linux-wireless+bounces-10720-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 758D9942761
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 09:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC388B22EDC
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 07:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CF31A4B52;
	Wed, 31 Jul 2024 07:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="OY0nP9zd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C275216CD03
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jul 2024 07:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722409546; cv=none; b=t2X4G0u17kMPPqaazGXtxQL/Zmggnmd9EZ0XcPJaB6vUNYoJIuwqOjxS8tBmh1JYdRyOLtk2h7LUVxwq+wmFBZn6zweAhYIKESYEEyYL37GmND6S+Bm8sTHX2x2fAJ0m2SluoTmA3H8QSN9arPbYXwEuSmpRJ4q9PL4sc28Ib/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722409546; c=relaxed/simple;
	bh=jouyvA38EVKemk2xWt2vUGJB/0C7O0ut4ibOIvrHdrU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dKwIZd1YpazQ8LCAYk0yQ9Ojuuvo/uRrpwH/sI16/7Tnbwaey0uDkiSAnDmzNPEgvz434zkC51DjgJlSr/tLIYe+eaNHFhsb1/+wlyyAQJnqQ14Pcg5iExjuGYbP0krjf28UT0z0AskePTfPBzSnHHzYEY3D+ZHV2R9ypjYiV7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=OY0nP9zd; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 46V75fN822075378, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1722409541; bh=jouyvA38EVKemk2xWt2vUGJB/0C7O0ut4ibOIvrHdrU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=OY0nP9zdfUVr8V4FkCdwh5Tf45J3eQ/5zxp/pgXTyr9lSS4uQc6fgYbHV7uT+qHMZ
	 4+OyU2L4x4w4RsUK7cnxgmxQxaF3dva2uZPXPZbOlY7iSrWh/a6FdIODgubzTIxhzt
	 1TgndgU7SoBgXWjQ0TNRl9LRpr+Dln1nYr70rivOZ8lusUNL+WdEOxiIuZqjnDgCKq
	 8Gj/6+PFsuYL4nGDqDvQ4zNH2XUSkldfxOs4rYw7zpeskfrtFJf32J5R+BE0UkSxax
	 f7IMvxR0U8TNbg9HRixtYvMKQ57U7NFoKNPeVTPGSWFd96CQqVJyKqsU+oYnKnrz4a
	 QhS3aDaII6NQg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 46V75fN822075378
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jul 2024 15:05:41 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 31 Jul 2024 15:05:41 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 31 Jul
 2024 15:05:41 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <dian_syuan0116@realtek.com>,
        <damon.chen@realtek.com>, <phhuang@realtek.com>
Subject: [PATCH 4/5] wifi: rtw89: add support for HW encryption in unicast management frames
Date: Wed, 31 Jul 2024 15:05:05 +0800
Message-ID: <20240731070506.46100-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240731070506.46100-1-pkshih@realtek.com>
References: <20240731070506.46100-1-pkshih@realtek.com>
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

From: Kuan-Chung Chen <damon.chen@realtek.com>

Add hardware encryption support for unicast management frames for
8922AE and 8852CE. Other chips will continue to use software
encryption for unicast management frames.

Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/cam.c      | 12 +++++---
 drivers/net/wireless/realtek/rtw89/core.c     | 29 ++++++++++++-------
 drivers/net/wireless/realtek/rtw89/core.h     |  1 +
 drivers/net/wireless/realtek/rtw89/mac.c      |  7 +++++
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |  1 +
 .../net/wireless/realtek/rtw89/rtw8852bt.c    |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |  1 +
 10 files changed, 40 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/cam.c b/drivers/net/wireless/realtek/rtw89/cam.c
index 4557c6e035a9..4476fc7e53db 100644
--- a/drivers/net/wireless/realtek/rtw89/cam.c
+++ b/drivers/net/wireless/realtek/rtw89/cam.c
@@ -384,20 +384,24 @@ int rtw89_cam_sec_key_add(struct rtw89_dev *rtwdev,
 		break;
 	case WLAN_CIPHER_SUITE_CCMP:
 		hw_key_type = RTW89_SEC_KEY_TYPE_CCMP128;
-		key->flags |= IEEE80211_KEY_FLAG_SW_MGMT_TX;
+		if (!chip->hw_mgmt_tx_encrypt)
+			key->flags |= IEEE80211_KEY_FLAG_SW_MGMT_TX;
 		break;
 	case WLAN_CIPHER_SUITE_CCMP_256:
 		hw_key_type = RTW89_SEC_KEY_TYPE_CCMP256;
-		key->flags |= IEEE80211_KEY_FLAG_SW_MGMT_TX;
+		if (!chip->hw_mgmt_tx_encrypt)
+			key->flags |= IEEE80211_KEY_FLAG_SW_MGMT_TX;
 		ext_key = true;
 		break;
 	case WLAN_CIPHER_SUITE_GCMP:
 		hw_key_type = RTW89_SEC_KEY_TYPE_GCMP128;
-		key->flags |= IEEE80211_KEY_FLAG_SW_MGMT_TX;
+		if (!chip->hw_mgmt_tx_encrypt)
+			key->flags |= IEEE80211_KEY_FLAG_SW_MGMT_TX;
 		break;
 	case WLAN_CIPHER_SUITE_GCMP_256:
 		hw_key_type = RTW89_SEC_KEY_TYPE_GCMP256;
-		key->flags |= IEEE80211_KEY_FLAG_SW_MGMT_TX;
+		if (!chip->hw_mgmt_tx_encrypt)
+			key->flags |= IEEE80211_KEY_FLAG_SW_MGMT_TX;
 		ext_key = true;
 		break;
 	case WLAN_CIPHER_SUITE_AES_CMAC:
diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 871ad32c3056..652aa50ffc01 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -602,15 +602,28 @@ static u8 rtw89_core_tx_get_mac_id(struct rtw89_dev *rtwdev,
 	return rtwsta->mac_id;
 }
 
+static void rtw89_core_tx_update_llc_hdr(struct rtw89_dev *rtwdev,
+					 struct rtw89_tx_desc_info *desc_info,
+					 struct sk_buff *skb)
+{
+	struct ieee80211_hdr *hdr = (void *)skb->data;
+	__le16 fc = hdr->frame_control;
+
+	desc_info->hdr_llc_len = ieee80211_hdrlen(fc);
+	desc_info->hdr_llc_len >>= 1; /* in unit of 2 bytes */
+}
+
 static void
 rtw89_core_tx_update_mgmt_info(struct rtw89_dev *rtwdev,
 			       struct rtw89_core_tx_request *tx_req)
 {
+	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct ieee80211_vif *vif = tx_req->vif;
 	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
 	struct rtw89_tx_desc_info *desc_info = &tx_req->desc_info;
 	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev,
 						       rtwvif->chanctx_idx);
+	struct sk_buff *skb = tx_req->skb;
 	u8 qsel, ch_dma;
 
 	qsel = desc_info->hiq ? RTW89_TX_QSEL_B0_HI : RTW89_TX_QSEL_B0_MGMT;
@@ -629,6 +642,11 @@ rtw89_core_tx_update_mgmt_info(struct rtw89_dev *rtwdev,
 	desc_info->dis_data_fb = true;
 	desc_info->data_rate = rtw89_core_get_mgmt_rate(rtwdev, tx_req, chan);
 
+	if (chip->hw_mgmt_tx_encrypt && IEEE80211_SKB_CB(skb)->control.hw_key) {
+		rtw89_core_tx_update_sec_key(rtwdev, tx_req);
+		rtw89_core_tx_update_llc_hdr(rtwdev, desc_info, skb);
+	}
+
 	rtw89_debug(rtwdev, RTW89_DBG_TXRX,
 		    "tx mgmt frame with rate 0x%x on channel %d (band %d, bw %d)\n",
 		    desc_info->data_rate, chan->channel, chan->band_type,
@@ -862,17 +880,6 @@ rtw89_core_tx_btc_spec_pkt_notify(struct rtw89_dev *rtwdev,
 	return PACKET_MAX;
 }
 
-static void rtw89_core_tx_update_llc_hdr(struct rtw89_dev *rtwdev,
-					 struct rtw89_tx_desc_info *desc_info,
-					 struct sk_buff *skb)
-{
-	struct ieee80211_hdr *hdr = (void *)skb->data;
-	__le16 fc = hdr->frame_control;
-
-	desc_info->hdr_llc_len = ieee80211_hdrlen(fc);
-	desc_info->hdr_llc_len >>= 1; /* in unit of 2 bytes */
-}
-
 static void
 rtw89_core_tx_wake(struct rtw89_dev *rtwdev,
 		   struct rtw89_core_tx_request *tx_req)
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index ba2ac5cefc50..5a9e028117a2 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4175,6 +4175,7 @@ struct rtw89_chip_info {
 	bool ul_tb_waveform_ctrl;
 	bool ul_tb_pwr_diff;
 	bool hw_sec_hdr;
+	bool hw_mgmt_tx_encrypt;
 	u8 rf_path_num;
 	u8 tx_nss;
 	u8 rx_nss;
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 7f2ca16bedcc..58676ec0dde8 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -2032,11 +2032,16 @@ int rtw89_mac_resize_ple_rx_quota(struct rtw89_dev *rtwdev, bool wow)
 
 void rtw89_mac_hw_mgnt_sec(struct rtw89_dev *rtwdev, bool enable)
 {
+	const struct rtw89_chip_info *chip = rtwdev->chip;
 	u32 msk32 = B_AX_UC_MGNT_DEC | B_AX_BMC_MGNT_DEC;
 
 	if (rtwdev->chip->chip_gen != RTW89_CHIP_AX)
 		return;
 
+	/* 8852C enable B_AX_UC_MGNT_DEC by default */
+	if (chip->chip_id == RTL8852C)
+		msk32 = B_AX_BMC_MGNT_DEC;
+
 	if (enable)
 		rtw89_write32_set(rtwdev, R_AX_SEC_ENG_CTRL, msk32);
 	else
@@ -2261,6 +2266,8 @@ static int sec_eng_init_ax(struct rtw89_dev *rtwdev)
 	/* init TX encryption */
 	val |= (B_AX_SEC_TX_ENC | B_AX_SEC_RX_DEC);
 	val |= (B_AX_MC_DEC | B_AX_BC_DEC);
+	if (chip->chip_id == RTL8852C)
+		val |= B_AX_UC_MGNT_DEC;
 	if (chip->chip_id == RTL8852A || chip->chip_id == RTL8852B ||
 	    chip->chip_id == RTL8851B)
 		val &= ~B_AX_TX_PARTIAL_MODE;
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index c181d88a299e..d66c190044d6 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -2464,6 +2464,7 @@ const struct rtw89_chip_info rtw8851b_chip_info = {
 	.ul_tb_waveform_ctrl	= true,
 	.ul_tb_pwr_diff		= false,
 	.hw_sec_hdr		= false,
+	.hw_mgmt_tx_encrypt	= false,
 	.rf_path_num		= 1,
 	.tx_nss			= 1,
 	.rx_nss			= 1,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 9856e90b837e..48fe1446bd47 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2179,6 +2179,7 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 	.ul_tb_waveform_ctrl	= false,
 	.ul_tb_pwr_diff		= false,
 	.hw_sec_hdr		= false,
+	.hw_mgmt_tx_encrypt	= false,
 	.rf_path_num		= 2,
 	.tx_nss			= 2,
 	.rx_nss			= 2,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index 019223312c6c..03a8ccd45108 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -819,6 +819,7 @@ const struct rtw89_chip_info rtw8852b_chip_info = {
 	.ul_tb_waveform_ctrl	= true,
 	.ul_tb_pwr_diff		= false,
 	.hw_sec_hdr		= false,
+	.hw_mgmt_tx_encrypt	= false,
 	.rf_path_num		= 2,
 	.tx_nss			= 2,
 	.rx_nss			= 2,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
index e54bafb0fd45..2f16e5a7c0f2 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
@@ -752,6 +752,7 @@ const struct rtw89_chip_info rtw8852bt_chip_info = {
 	.ul_tb_waveform_ctrl	= true,
 	.ul_tb_pwr_diff		= false,
 	.hw_sec_hdr		= false,
+	.hw_mgmt_tx_encrypt     = false,
 	.rf_path_num		= 2,
 	.tx_nss			= 2,
 	.rx_nss			= 2,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 8f35f887242e..66d3fa32407d 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -2960,6 +2960,7 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 	.ul_tb_waveform_ctrl	= false,
 	.ul_tb_pwr_diff		= true,
 	.hw_sec_hdr		= true,
+	.hw_mgmt_tx_encrypt	= true,
 	.rf_path_num		= 2,
 	.tx_nss			= 2,
 	.rx_nss			= 2,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index 747912736a2f..93baa7506cf0 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -2563,6 +2563,7 @@ const struct rtw89_chip_info rtw8922a_chip_info = {
 	.ul_tb_waveform_ctrl	= false,
 	.ul_tb_pwr_diff		= false,
 	.hw_sec_hdr		= true,
+	.hw_mgmt_tx_encrypt	= true,
 	.rf_path_num		= 2,
 	.tx_nss			= 2,
 	.rx_nss			= 2,
-- 
2.25.1


