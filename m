Return-Path: <linux-wireless+bounces-6725-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4310D8AE752
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Apr 2024 15:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74A4A1C2345B
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Apr 2024 13:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7D312FF71;
	Tue, 23 Apr 2024 13:05:38 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F3C78C6E
	for <linux-wireless@vger.kernel.org>; Tue, 23 Apr 2024 13:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713877538; cv=none; b=I47rSpAVsgqGWChDyCn8rHQO3Vsz36SQY7IVbJSSWy/wCskc2qKxq1lJucHEtHWiPYqOUl+IhjI22tzmA9yzDb/EBeay4uf8odQHPM4Jx0U6tj8B9919zR74nGrivvMrW9Lpxj5Ehb4FfYuDKvPBm3ALgpR1+zMpEOBpzBMIIp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713877538; c=relaxed/simple;
	bh=t809SEv2KPZ29AzfYRAULOT9GkYMPi0Um2x4SsEn4tM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pK7hIAtsSJrCNC8IdBu+X2NkoRODektGm04MdTgqWYt8Tszg8vyOx5ddK8NkmBuTLEDYBv+/5J6rclkSyGg/sKtf+AhmpBuKZHFKOQv32eFMfphsHxj1zyLzznJpKpeldKD+gVtqihtYrApGul93BEXP7+DQSZzmKi4pbuW3rDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43ND5XgH41251177, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43ND5XgH41251177
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 23 Apr 2024 21:05:33 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 23 Apr 2024 21:05:34 +0800
Received: from [127.0.1.1] (172.16.20.182) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 23 Apr
 2024 21:05:33 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: [PATCH 2/8] wifi: rtw89: coex: Add Bluetooth scan parameter report version 7
Date: Tue, 23 Apr 2024 21:04:56 +0800
Message-ID: <20240423130502.32682-3-pkshih@realtek.com>
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

This report is reported from Bluetooth, it described Bluetooth scan
parameters. Version 7 adjust the structure variables order.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 15 +++++++++++++++
 drivers/net/wireless/realtek/rtw89/core.h |  9 +++++++++
 2 files changed, 24 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index e61af63090f7..b0921a264f3d 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -1135,6 +1135,7 @@ static void _update_bt_report(struct rtw89_dev *rtwdev, u8 rpt_type, u8 *pfinfo)
 	struct rtw89_btc_fbtc_btver *pver = NULL;
 	struct rtw89_btc_fbtc_btscan_v1 *pscan_v1;
 	struct rtw89_btc_fbtc_btscan_v2 *pscan_v2;
+	struct rtw89_btc_fbtc_btscan_v7 *pscan_v7;
 	struct rtw89_btc_fbtc_btafh *pafh_v1 = NULL;
 	struct rtw89_btc_fbtc_btafh_v2 *pafh_v2 = NULL;
 	struct rtw89_btc_fbtc_btdevinfo *pdev = NULL;
@@ -1172,6 +1173,15 @@ static void _update_bt_report(struct rtw89_dev *rtwdev, u8 rpt_type, u8 *pfinfo)
 				    pscan_v2->para[i].intvl == 0)
 					scan_update = false;
 			}
+		} else if (ver->fcxbtscan == 7) {
+			pscan_v7 = (struct rtw89_btc_fbtc_btscan_v7 *)pfinfo;
+			for (i = 0; i < CXSCAN_MAX; i++) {
+				bt->scan_info_v2[i] = pscan_v7->para[i];
+				if ((pscan_v7->type & BIT(i)) &&
+				    pscan_v7->para[i].win == 0 &&
+				    pscan_v7->para[i].intvl == 0)
+					scan_update = false;
+			}
 		}
 		if (scan_update)
 			bt->scan_info_update = 1;
@@ -1428,6 +1438,11 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 		} else if (ver->fcxbtscan == 2) {
 			pfinfo = &pfwinfo->rpt_fbtc_btscan.finfo.v2;
 			pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_btscan.finfo.v2);
+		} else if (ver->fcxbtscan == 7) {
+			pfinfo = &pfwinfo->rpt_fbtc_btscan.finfo.v7;
+			pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_btscan.finfo.v7);
+		} else {
+			goto err;
 		}
 		pcinfo->req_fver = ver->fcxbtscan;
 		break;
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index d8f7eea7ae6e..0b1d63b2fa1f 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -1954,9 +1954,18 @@ struct rtw89_btc_fbtc_btscan_v2 {
 	struct rtw89_btc_bt_scan_info_v2 para[CXSCAN_MAX];
 } __packed;
 
+struct rtw89_btc_fbtc_btscan_v7 {
+	u8 fver; /* btc_ver::fcxbtscan */
+	u8 type;
+	u8 rsvd0;
+	u8 rsvd1;
+	struct rtw89_btc_bt_scan_info_v2 para[CXSCAN_MAX];
+} __packed;
+
 union rtw89_btc_fbtc_btscan {
 	struct rtw89_btc_fbtc_btscan_v1 v1;
 	struct rtw89_btc_fbtc_btscan_v2 v2;
+	struct rtw89_btc_fbtc_btscan_v7 v7;
 };
 
 struct rtw89_btc_bt_info {
-- 
2.25.1


