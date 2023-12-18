Return-Path: <linux-wireless+bounces-889-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03ECC816662
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Dec 2023 07:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F9F9B2134B
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Dec 2023 06:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30EA2D533;
	Mon, 18 Dec 2023 06:15:22 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF16D26B
	for <linux-wireless@vger.kernel.org>; Mon, 18 Dec 2023 06:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3BI6FFCH03224884, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3BI6FFCH03224884
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Dec 2023 14:15:15 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 18 Dec 2023 14:15:15 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 18 Dec
 2023 14:15:15 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 08/11] wifi: rtw89: coex: Add Bluetooth RSSI level information
Date: Mon, 18 Dec 2023 14:13:38 +0800
Message-ID: <20231218061341.51255-9-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231218061341.51255-1-pkshih@realtek.com>
References: <20231218061341.51255-1-pkshih@realtek.com>
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
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

From: Ching-Te Ku <ku920601@realtek.com>

In order to control RF LNA setting, need Bluetooth RSSI level information.
RSSI level separate Bluetooth RSSI to several level, so the mechanism can
assign a corresponding setting.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 37 +++++++++++++++++++++--
 drivers/net/wireless/realtek/rtw89/core.h |  1 +
 2 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 43a95f9b0868..d1368b2bc688 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -5761,6 +5761,37 @@ void rtw89_btc_ntfy_icmp_packet_work(struct work_struct *work)
 	mutex_unlock(&rtwdev->mutex);
 }
 
+static u8 _update_bt_rssi_level(struct rtw89_dev *rtwdev, u8 rssi)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	struct rtw89_btc *btc = &rtwdev->btc;
+	struct rtw89_btc_bt_info *bt = &btc->cx.bt;
+	u8 *rssi_st, rssi_th, rssi_level = 0;
+	u8 i;
+
+	/* for rssi locate in which {40, 36, 31, 28}
+	 * if rssi >= 40% (-60dBm) --> rssi_level = 4
+	 * if 36% <= rssi < 40%    --> rssi_level = 3
+	 * if 31% <= rssi < 36%    --> rssi_level = 2
+	 * if 28% <= rssi < 31%    --> rssi_level = 1
+	 * if rssi < 28%           --> rssi_level = 0
+	 */
+
+	/* check if rssi across bt_rssi_thres boundary */
+	for (i = 0; i < BTC_BT_RSSI_THMAX; i++) {
+		rssi_th = chip->bt_rssi_thres[i];
+		rssi_st = &bt->link_info.rssi_state[i];
+
+		*rssi_st = _update_rssi_state(rtwdev, *rssi_st, rssi, rssi_th);
+
+		if (BTC_RSSI_HIGH(*rssi_st)) {
+			rssi_level = BTC_BT_RSSI_THMAX - i;
+			break;
+		}
+	}
+	return rssi_level;
+}
+
 #define BT_PROFILE_PROTOCOL_MASK GENMASK(7, 4)
 
 static void _update_bt_info(struct rtw89_dev *rtwdev, u8 *buf, u32 len)
@@ -5836,7 +5867,8 @@ static void _update_bt_info(struct rtw89_dev *rtwdev, u8 *buf, u32 len)
 	btinfo.val = bt->raw_info[BTC_BTINFO_H0];
 	/* raw val is dBm unit, translate from -100~ 0dBm to 0~100%*/
 	b->rssi = chip->ops->btc_get_bt_rssi(rtwdev, btinfo.hb0.rssi);
-	btc->dm.trx_info.bt_rssi = b->rssi;
+	bt->rssi_level = _update_bt_rssi_level(rtwdev, b->rssi);
+	btc->dm.trx_info.bt_rssi = bt->rssi_level;
 
 	/* parse raw info high-Byte1 */
 	btinfo.val = bt->raw_info[BTC_BTINFO_H1];
@@ -6686,8 +6718,9 @@ static void _show_bt_info(struct rtw89_dev *rtwdev, struct seq_file *m)
 		   bt_linfo->pan_desc.active ? "Y" : "N");
 
 	seq_printf(m,
-		   " %-15s : rssi:%ddBm, tx_rate:%dM, %s%s%s",
+		   " %-15s : rssi:%ddBm(lvl:%d), tx_rate:%dM, %s%s%s",
 		   "[link]", bt_linfo->rssi - 100,
+		   bt->rssi_level,
 		   bt_linfo->tx_3m ? 3 : 2,
 		   bt_linfo->status.map.inq_pag ? " inq-page!!" : "",
 		   bt_linfo->status.map.acl_busy ? " acl_busy!!" : "",
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 0e7b8360ace7..7c92330ba06a 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -1814,6 +1814,7 @@ struct rtw89_btc_bt_info {
 	union rtw89_btc_bt_rfk_info_map rfk_info;
 
 	u8 raw_info[BTC_BTINFO_MAX]; /* raw bt info from mailbox */
+	u8 rssi_level;
 
 	u32 scbd;
 	u32 feature;
-- 
2.25.1


