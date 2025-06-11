Return-Path: <linux-wireless+bounces-23979-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86ADDAD49CE
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 05:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A4503A614C
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 03:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E77C20C465;
	Wed, 11 Jun 2025 03:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="YxS39Lyf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A423218AC7
	for <linux-wireless@vger.kernel.org>; Wed, 11 Jun 2025 03:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749614174; cv=none; b=QPTLzgwR9kIE58bYb8qTYk5lMWWVIgI9XjrEbEramjm7r+9tPawikE8F6j0GZU69DWswUQKa7oZoLkZvXozmpTPnj3Ll9l75+mzqdwtVxxLBUzP+3mGtAO/prEpjVHcTImN/ZIAOZIPLLxvDlCuNgcfzhjr3XMA+8dK7ST5Myew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749614174; c=relaxed/simple;
	bh=F7DIn/PyWq5tJeh3/uFBiZR+ehMeQa30jQ/srEpS394=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KU8VUvcliQTfIYZTWLN+7s9YzXj+cagjHOFQ2QdxPWS0X5YZbQtokaq8Hu45nOMh1S2oopABesTW3UTSV8y2lmkZiZ6eL3a3QUasUInLbIPwlScrPopI0edt3OfmUiWPOo6mKZlmxoSjildK3FdAehM2FXG8Wpyj8t2I6/AI+sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=YxS39Lyf; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55B3uAjD54132602, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1749614170; bh=dTYtzAW2vqGo1F7afZ3uqB0vpnpHKk4Jz/nbcDuLric=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=YxS39LyfrnTMmnrXfe0puezlW8XFo3XEesd1n7bURrhNUEk+2JS2zYSuRIqEU4E0a
	 GjgKaYqUo/G1XO/9mOStGoQqsJ9BLSMMT8WXVSDYo3tZHBLqF83vw9e3g/blbK4/JF
	 3SZPP/wdSBRNSIoVQnM3P/ZSn6boXomHKmH99SOahghSFslaRBFYxuS4OutPAmNplr
	 TSHZLKtiGTbDepmkBFL9h7vf4KivF4dyyTVQYCMq3Q79Cw/EMUuVeiHUh0JjjGGAUj
	 kd5DE+DaI8kgdcyEGGLlijLgig276d1q9a1OvUGUkR1mzP5W34+5E+Q1YZuwzgNu+K
	 8qCyWPiS73aBA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55B3uAjD54132602
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 11 Jun 2025 11:56:10 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 11 Jun 2025 11:56:10 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 11 Jun
 2025 11:56:10 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next v2 06/10] wifi: rtw89: coex: Add H2C command to collect driver outsource information to firmware
Date: Wed, 11 Jun 2025 11:55:19 +0800
Message-ID: <20250611035523.36432-7-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250611035523.36432-1-pkshih@realtek.com>
References: <20250611035523.36432-1-pkshih@realtek.com>
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

From: Ching-Te Ku <ku920601@realtek.com>

In order to reduce driver I/O & some detail instant hardware control, some
of the necessary API offload to Wi-Fi firmware. Collect the reference
parameters to let firmware do decisions.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 12 ++++++-
 drivers/net/wireless/realtek/rtw89/core.h | 16 ++++++++-
 drivers/net/wireless/realtek/rtw89/fw.c   | 40 +++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/fw.h   |  6 ++++
 4 files changed, 72 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 6ec83b928bc2..d2d673fe8e18 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -154,7 +154,7 @@ static const struct rtw89_btc_ver rtw89_btc_ver_defs[] = {
 	 .fcxstep = 7,   .fcxnullsta = 7, .fcxmreg = 7,  .fcxgpiodbg = 7,
 	 .fcxbtver = 7,  .fcxbtscan = 7,  .fcxbtafh = 7, .fcxbtdevinfo = 7,
 	 .fwlrole = 8,   .frptmap = 3,    .fcxctrl = 7,  .fcxinit = 7,
-	 .fwevntrptl = 1, .fwc2hfunc = 2, .drvinfo_type = 1, .info_buf = 1800,
+	 .fwevntrptl = 1, .fwc2hfunc = 2, .drvinfo_type = 2, .info_buf = 1800,
 	 .max_role_num = 6, .fcxosi = 1,  .fcxmlo = 1,
 	},
 	{RTL8922A, RTW89_FW_VER_CODE(0, 35, 8, 0),
@@ -2776,6 +2776,16 @@ static void _fw_set_drv_info(struct rtw89_dev *rtwdev, u8 type)
 	case CXDRVINFO_FDDT:
 	case CXDRVINFO_MLO:
 	case CXDRVINFO_OSI:
+		if (!ver->fcxosi)
+			return;
+
+		if (ver->drvinfo_type == 2)
+			type = 7;
+		else
+			return;
+
+		rtw89_fw_h2c_cxdrv_osi_info(rtwdev, type);
+		break;
 	default:
 		break;
 	}
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 0c818a8025cc..a2c2a57ea300 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -1205,7 +1205,7 @@ struct rtw89_mac_ax_gnt {
 struct rtw89_mac_ax_wl_act {
 	u8 wlan_act_en;
 	u8 wlan_act;
-};
+} __packed;
 
 #define RTW89_MAC_AX_COEX_GNT_NR 2
 struct rtw89_mac_ax_coex_gnt {
@@ -2933,12 +2933,26 @@ enum btc_rf_path {
 	BTC_RF_NUM,
 };
 
+struct rtw89_btc_fbtc_outsrc_set_info {
+	u8 rf_band[BTC_RF_NUM]; /* 0:2G, 1:non-2G */
+	u8 btg_rx[BTC_RF_NUM];
+	u8 nbtg_tx[BTC_RF_NUM];
+
+	struct rtw89_mac_ax_gnt gnt_set[BTC_RF_NUM]; /* refer to btc_gnt_ctrl */
+	struct rtw89_mac_ax_wl_act wlact_set[BTC_RF_NUM]; /* BT0/BT1 */
+
+	u8 pta_req_hw_band;
+	u8 rf_gbt_source;
+} __packed;
+
 union rtw89_btc_fbtc_slot_u {
 	struct rtw89_btc_fbtc_slot v1[CXST_MAX];
 	struct rtw89_btc_fbtc_slot_v7 v7[CXST_MAX];
 };
 
 struct rtw89_btc_dm {
+	struct rtw89_btc_fbtc_outsrc_set_info ost_info_last; /* outsrc API setup info */
+	struct rtw89_btc_fbtc_outsrc_set_info ost_info; /* outsrc API setup info */
 	union rtw89_btc_fbtc_slot_u slot;
 	union rtw89_btc_fbtc_slot_u slot_now;
 	struct rtw89_btc_fbtc_tdma tdma;
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 95865eafb2cd..bc730f8644e6 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -5085,6 +5085,46 @@ int rtw89_fw_h2c_cxdrv_role_v8(struct rtw89_dev *rtwdev, u8 type)
 	return ret;
 }
 
+int rtw89_fw_h2c_cxdrv_osi_info(struct rtw89_dev *rtwdev, u8 type)
+{
+	struct rtw89_btc *btc = &rtwdev->btc;
+	struct rtw89_btc_fbtc_outsrc_set_info *osi = &btc->dm.ost_info;
+	struct rtw89_h2c_cxosi *h2c;
+	u32 len = sizeof(*h2c);
+	struct sk_buff *skb;
+	int ret;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for h2c cxdrv_osi\n");
+		return -ENOMEM;
+	}
+	skb_put(skb, len);
+	h2c = (struct rtw89_h2c_cxosi *)skb->data;
+
+	h2c->hdr.type = type;
+	h2c->hdr.ver = btc->ver->fcxosi;
+	h2c->hdr.len = len - H2C_LEN_CXDRVHDR_V7;
+	h2c->osi = *osi;
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_OUTSRC, BTFC_SET,
+			      SET_DRV_INFO, 0, 0,
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
 #define H2C_LEN_CXDRVINFO_CTRL (4 + H2C_LEN_CXDRVHDR)
 int rtw89_fw_h2c_cxdrv_ctrl(struct rtw89_dev *rtwdev, u8 type)
 {
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 14f55b10be2e..8920453a88d5 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -2247,6 +2247,11 @@ struct rtw89_h2c_cxrole_v8 {
 	struct rtw89_btc_wl_role_info_v8_u32 _u32;
 } __packed;
 
+struct rtw89_h2c_cxosi {
+	struct rtw89_h2c_cxhdr_v7 hdr;
+	struct rtw89_btc_fbtc_outsrc_set_info osi;
+} __packed;
+
 struct rtw89_h2c_cxinit {
 	struct rtw89_h2c_cxhdr hdr;
 	u8 ant_type;
@@ -4732,6 +4737,7 @@ int rtw89_fw_h2c_cxdrv_role_v1(struct rtw89_dev *rtwdev, u8 type);
 int rtw89_fw_h2c_cxdrv_role_v2(struct rtw89_dev *rtwdev, u8 type);
 int rtw89_fw_h2c_cxdrv_role_v7(struct rtw89_dev *rtwdev, u8 type);
 int rtw89_fw_h2c_cxdrv_role_v8(struct rtw89_dev *rtwdev, u8 type);
+int rtw89_fw_h2c_cxdrv_osi_info(struct rtw89_dev *rtwdev, u8 type);
 int rtw89_fw_h2c_cxdrv_ctrl(struct rtw89_dev *rtwdev, u8 type);
 int rtw89_fw_h2c_cxdrv_ctrl_v7(struct rtw89_dev *rtwdev, u8 type);
 int rtw89_fw_h2c_cxdrv_trx(struct rtw89_dev *rtwdev, u8 type);
-- 
2.25.1


