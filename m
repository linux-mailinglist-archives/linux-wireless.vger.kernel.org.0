Return-Path: <linux-wireless+bounces-23951-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CED2FAD47F1
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 03:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 564FC3A5B19
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 01:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2128E78F4E;
	Wed, 11 Jun 2025 01:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="EV4jPvXH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DF143169
	for <linux-wireless@vger.kernel.org>; Wed, 11 Jun 2025 01:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749605766; cv=none; b=C87OP3wVwQiPhwRNZivEii9u0Ky1116d6SHlxcGYJF/pL7urAZrkc4Nq9QxyXMyX4HEYPWbJ1NC8E2Jkk3L97p70PRzM353lmo0KX1I4ZeKOUd6AUArQnizFWUkp+5vYEQOwED6PDG66nwlNHQarb6uWdchYTIPRTXsxDkGGqEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749605766; c=relaxed/simple;
	bh=b3gDd1W4oqkXi2GmlncUL7gT4ginUFw1Sw4e9XsRZG4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H/PqcLQUDoQaCtr6EiIjoWYLk5yiyhoIQ9kg1TIhfrgQZfMLOXD1/CTA1I7GliZpR7EAirkNSW/DRtIgX2zxi9voE+daeuvx38j6AWVKvADQ8XwVRDwHAQ5kxoiN+c+tiTghtSvSmidPzezMKO5tQ2tHny2YsfN/eHZE9emf1Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=EV4jPvXH; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55B1a2AZ13938200, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1749605762; bh=g4TIYQH0cJzQKSvKiONWuD113rGGL4sA+b2zIoQ+s5g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=EV4jPvXH0oAD3YOmc8u5e4K9BMeKvAU/mTMds7KWeN8Lrcg8M1ejrWQSgdNapdogr
	 YmWohmTgYEsvc3Y8pLW3r0jUSkStCVZE9HatjzsRRE2p4nUvoIoXl6DF5YbBmJhOnZ
	 Ipk/pgbLdLKTajKukhXCh2UKmTkEhtdTvB57o6YkVX+X+bjg+u04+o0fmWSR2yxIwo
	 VrGPzjrXXdKe3ze7BTYsi/msMH9WqUyNWK4RThl+JSFn1cemUjsUR9DmW+sNvzBwoA
	 0epBN7gzSlle8n+pG4bV7pH+6MMsOEz0f1n05pXreJTf5L618QnuxMtYROgMFMI50o
	 ZimN3qKNi8J6g==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55B1a2AZ13938200
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 11 Jun 2025 09:36:02 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 11 Jun 2025 09:36:02 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 11 Jun
 2025 09:36:00 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 06/10] wifi: rtw89: coex: Add H2C command to collect driver outsource information to firmware
Date: Wed, 11 Jun 2025 09:35:06 +0800
Message-ID: <20250611013510.15519-7-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250611013510.15519-1-pkshih@realtek.com>
References: <20250611013510.15519-1-pkshih@realtek.com>
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
index 54ee4136491d..ff5c804d231b 100644
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


