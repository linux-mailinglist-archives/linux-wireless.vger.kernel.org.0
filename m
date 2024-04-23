Return-Path: <linux-wireless+bounces-6727-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B35B8AE756
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Apr 2024 15:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 807051C23463
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Apr 2024 13:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B754B12FF71;
	Tue, 23 Apr 2024 13:05:50 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D08978C6E
	for <linux-wireless@vger.kernel.org>; Tue, 23 Apr 2024 13:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713877550; cv=none; b=Sc7p8DrPHvccPs1rFiZ27dggipNPSQIWXoTmrrA0LN5X5wx/DL6/o25bb1Iv9Ye2xd7QSDGAOVwD1Q7Jc2+N2vk+Bhm+yzEETBs8y8NH+V+HN9dncqkk++w/jKRtqdO5+q6xt3KmU1XWEcIc+wPfz7jjwNVOiJ057U9lcY60Pz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713877550; c=relaxed/simple;
	bh=6fWBEn1Z/UTYxd6TqduRUDyd1wKivNQLsJGUBqnrSoc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O9w4wZDOW6TKVwc2/p40v6CeNfQuHSi5FVYpM52ZLJSByCw3jTQzoeJlXSjhgvmeqZ2GK9q9HVflbST61t1ZpwTp9LrZUX7uk87VvJhC0qGCyOYRlm2OxPeikgKtaxWq3brwDLs8N9m/9wezDc33xY9vu+IcPNMqzM+IcwCogIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43ND5gZoA1251189, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43ND5gZoA1251189
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 23 Apr 2024 21:05:42 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 23 Apr 2024 21:05:43 +0800
Received: from [127.0.1.1] (172.16.20.182) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 23 Apr
 2024 21:05:42 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: [PATCH 4/8] wifi: rtw89: coex: Add Bluetooth version report version 7
Date: Tue, 23 Apr 2024 21:04:58 +0800
Message-ID: <20240423130502.32682-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240423130502.32682-1-pkshih@realtek.com>
References: <20240423130502.32682-1-pkshih@realtek.com>
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

The report is reported from Bluetooth, it shows the current Bluetooth
driver & firmware version code. Wi-Fi & Bluetooth need to use compatible
version. The version 7 report adjust the structure variables order.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 39 +++++++++++++++--------
 drivers/net/wireless/realtek/rtw89/core.h | 20 ++++++++++--
 2 files changed, 44 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index f4ac9354f7ab..15e04440888d 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -1132,29 +1132,36 @@ static void _update_bt_report(struct rtw89_dev *rtwdev, u8 rpt_type, u8 *pfinfo)
 	struct rtw89_btc_bt_info *bt = &btc->cx.bt;
 	struct rtw89_btc_bt_link_info *bt_linfo = &bt->link_info;
 	struct rtw89_btc_bt_a2dp_desc *a2dp = &bt_linfo->a2dp_desc;
-	struct rtw89_btc_fbtc_btver *pver = NULL;
-	struct rtw89_btc_fbtc_btscan_v1 *pscan_v1;
-	struct rtw89_btc_fbtc_btscan_v2 *pscan_v2;
-	struct rtw89_btc_fbtc_btscan_v7 *pscan_v7;
-	struct rtw89_btc_fbtc_btafh *pafh_v1 = NULL;
+	union  rtw89_btc_fbtc_btver *pver = &btc->fwinfo.rpt_fbtc_btver.finfo;
 	struct rtw89_btc_fbtc_btafh_v2 *pafh_v2 = NULL;
 	struct rtw89_btc_fbtc_btafh_v7 *pafh_v7 = NULL;
 	struct rtw89_btc_fbtc_btdevinfo *pdev = NULL;
+	struct rtw89_btc_fbtc_btafh *pafh_v1 = NULL;
+	struct rtw89_btc_fbtc_btscan_v1 *pscan_v1;
+	struct rtw89_btc_fbtc_btscan_v2 *pscan_v2;
+	struct rtw89_btc_fbtc_btscan_v7 *pscan_v7;
 	bool scan_update = true;
 	int i;
 
-	pver = (struct rtw89_btc_fbtc_btver *)pfinfo;
-	pdev = (struct rtw89_btc_fbtc_btdevinfo *)pfinfo;
-
 	rtw89_debug(rtwdev, RTW89_DBG_BTC,
 		    "[BTC], %s(): rpt_type:%d\n",
 		    __func__, rpt_type);
 
 	switch (rpt_type) {
 	case BTC_RPT_TYPE_BT_VER:
-		bt->ver_info.fw = le32_to_cpu(pver->fw_ver);
-		bt->ver_info.fw_coex = le32_get_bits(pver->coex_ver, GENMASK(7, 0));
-		bt->feature = le32_to_cpu(pver->feature);
+		if (ver->fcxbtver == 7) {
+			pver->v7 = *(struct rtw89_btc_fbtc_btver_v7 *)pfinfo;
+			bt->ver_info.fw = le32_to_cpu(pver->v7.fw_ver);
+			bt->ver_info.fw_coex = le32_get_bits(pver->v7.coex_ver,
+							     GENMASK(7, 0));
+			bt->feature = le32_to_cpu(pver->v7.feature);
+		} else {
+			pver->v1 = *(struct rtw89_btc_fbtc_btver_v1 *)pfinfo;
+			bt->ver_info.fw = le32_to_cpu(pver->v1.fw_ver);
+			bt->ver_info.fw_coex = le32_get_bits(pver->v1.coex_ver,
+							     GENMASK(7, 0));
+			bt->feature = le32_to_cpu(pver->v1.feature);
+		}
 		break;
 	case BTC_RPT_TYPE_BT_SCAN:
 		if (ver->fcxbtscan == 1) {
@@ -1218,6 +1225,7 @@ static void _update_bt_report(struct rtw89_dev *rtwdev, u8 rpt_type, u8 *pfinfo)
 		}
 		break;
 	case BTC_RPT_TYPE_BT_DEVICE:
+		pdev = (struct rtw89_btc_fbtc_btdevinfo *)pfinfo;
 		a2dp->device_name = le32_to_cpu(pdev->dev_name);
 		a2dp->vendor_id = le16_to_cpu(pdev->vendor_id);
 		a2dp->flush_time = le32_to_cpu(pdev->flush_time);
@@ -1438,8 +1446,13 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 		break;
 	case BTC_RPT_TYPE_BT_VER:
 		pcinfo = &pfwinfo->rpt_fbtc_btver.cinfo;
-		pfinfo = &pfwinfo->rpt_fbtc_btver.finfo;
-		pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_btver.finfo);
+		if (ver->fcxbtver == 1) {
+			pfinfo = &pfwinfo->rpt_fbtc_btver.finfo.v1;
+			pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_btver.finfo.v1);
+		} else if (ver->fcxbtver == 7) {
+			pfinfo = &pfwinfo->rpt_fbtc_btver.finfo.v7;
+			pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_btver.finfo.v7);
+		}
 		pcinfo->req_fver = ver->fcxbtver;
 		break;
 	case BTC_RPT_TYPE_BT_SCAN:
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 78600e7fbad4..4007377d29ba 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2705,7 +2705,7 @@ union rtw89_btc_fbtc_cynullsta_info {
 	struct rtw89_btc_fbtc_cynullsta_v7 v7;
 };
 
-struct rtw89_btc_fbtc_btver {
+struct rtw89_btc_fbtc_btver_v1 {
 	u8 fver; /* btc_ver::fcxbtver */
 	u8 rsvd;
 	__le16 rsvd2;
@@ -2714,6 +2714,22 @@ struct rtw89_btc_fbtc_btver {
 	__le32 feature;
 } __packed;
 
+struct rtw89_btc_fbtc_btver_v7 {
+	u8 fver;
+	u8 rsvd0;
+	u8 rsvd1;
+	u8 rsvd2;
+
+	__le32 coex_ver; /*bit[15:8]->shared, bit[7:0]->non-shared */
+	__le32 fw_ver;
+	__le32 feature;
+} __packed;
+
+union rtw89_btc_fbtc_btver {
+	struct rtw89_btc_fbtc_btver_v1 v1;
+	struct rtw89_btc_fbtc_btver_v7 v7;
+} __packed;
+
 struct rtw89_btc_fbtc_btafh {
 	u8 fver; /* btc_ver::fcxbtafh */
 	u8 rsvd;
@@ -2971,7 +2987,7 @@ struct rtw89_btc_rpt_fbtc_gpio_dbg {
 
 struct rtw89_btc_rpt_fbtc_btver {
 	struct rtw89_btc_rpt_cmn_info cinfo; /* common info, by driver */
-	struct rtw89_btc_fbtc_btver finfo; /* info from fw */
+	union rtw89_btc_fbtc_btver finfo; /* info from fw */
 };
 
 struct rtw89_btc_rpt_fbtc_btscan {
-- 
2.25.1


