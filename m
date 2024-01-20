Return-Path: <linux-wireless+bounces-2282-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D455C8331DC
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Jan 2024 01:39:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 742791F22B39
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Jan 2024 00:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585D17F9;
	Sat, 20 Jan 2024 00:39:09 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B7C7F7
	for <linux-wireless@vger.kernel.org>; Sat, 20 Jan 2024 00:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705711149; cv=none; b=NfQnPlIjWjHIUcSllt2F2yjOtCkpYPxWwvj1XStlFzPzqa6XSLrO898UX6oyJQVEdqVrNXiFIkXy8Dl6GTR2ZEChvJKZJVXFqMqgKbNSOtyjQEDrBSfXkYq+zbF2k2adYigDN5958Ow+VknGaT3+xe/kq+s6mPy8x4ia3Sr3H4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705711149; c=relaxed/simple;
	bh=XQha4Z3t5TqXDbIC02NPcsTBBP1gOXct1EOWh7zJSMw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X50DYgjZ+PgHzOHV97qxZ2wQXwtBgflrAZrrUHgKQiuuojw4pBq9CMAiX0nsS91yWzoaT2woPxIcXrXm9hNSoFbonNjnJN8n78ghUiRHkub60/CzX3W6yKb0ghkFqr1uNY76PIkeKeQixr3jdOjm5NTvUkJweL1Q3ygxH+KH2FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 40K0d0ZH12596452, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 40K0d0ZH12596452
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 20 Jan 2024 08:39:00 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Sat, 20 Jan 2024 08:39:00 +0800
Received: from [127.0.1.1] (172.16.16.202) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Sat, 20 Jan
 2024 08:38:59 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <hsuan8331@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH v3 1/6] wifi: rtw89: add mlo_dbcc_mode for WiFi 7 chips
Date: Sat, 20 Jan 2024 08:38:26 +0800
Message-ID: <20240120003831.7014-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240120003831.7014-1-pkshih@realtek.com>
References: <20240120003831.7014-1-pkshih@realtek.com>
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

WiFi 7 chips can operate in various MLO applications, such as 1 link (2SS)
and 2 links (1SS + 1SS), and we should configure different PHY mode for
each of them.

For example,
 - MLO_2_PLUS_0_1RF is 1 link with 2SS rate, and enable one RF component.
 - MLO_1_PLUS_1_1RF is 2 links with 1SS rate for each, and enable one RF
   component that can support two paths.

By default, we set the mode to legacy MLO_DBCC_NOT_SUPPORT (don't support
MLO and DBCC yet), and later we will introduce logic to change the mode.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c |  2 ++
 drivers/net/wireless/realtek/rtw89/core.h | 27 +++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 347703b68dfd..b1fcd284a6b8 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -4191,6 +4191,8 @@ int rtw89_core_init(struct rtw89_dev *rtwdev)
 	rtw89_traffic_stats_init(rtwdev, &rtwdev->stats);
 
 	rtwdev->hal.rx_fltr = DEFAULT_AX_RX_FLTR;
+	rtwdev->dbcc_en = false;
+	rtwdev->mlo_dbcc_mode = MLO_DBCC_NOT_SUPPORT;
 
 	INIT_WORK(&btc->eapol_notify_work, rtw89_btc_ntfy_eapol_packet_work);
 	INIT_WORK(&btc->arp_notify_work, rtw89_btc_ntfy_arp_packet_work);
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 80f67f1b0679..34e52f7c3bba 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3243,6 +3243,20 @@ enum rtw89_dma_ch {
 	RTW89_DMA_CH_NUM = 13
 };
 
+#define MLO_MODE_FOR_BB0_BB1_RF(bb0, bb1, rf) ((rf) << 12 | (bb1) << 4 | (bb0))
+
+enum rtw89_mlo_dbcc_mode {
+	MLO_DBCC_NOT_SUPPORT = 1,
+	MLO_0_PLUS_2_1RF = MLO_MODE_FOR_BB0_BB1_RF(0, 2, 1),
+	MLO_0_PLUS_2_2RF = MLO_MODE_FOR_BB0_BB1_RF(0, 2, 2),
+	MLO_1_PLUS_1_1RF = MLO_MODE_FOR_BB0_BB1_RF(1, 1, 1),
+	MLO_1_PLUS_1_2RF = MLO_MODE_FOR_BB0_BB1_RF(1, 1, 2),
+	MLO_2_PLUS_0_1RF = MLO_MODE_FOR_BB0_BB1_RF(2, 0, 1),
+	MLO_2_PLUS_0_2RF = MLO_MODE_FOR_BB0_BB1_RF(2, 0, 2),
+	MLO_2_PLUS_2_2RF = MLO_MODE_FOR_BB0_BB1_RF(2, 2, 2),
+	DBCC_LEGACY = 0xffffffff,
+};
+
 enum rtw89_qta_mode {
 	RTW89_QTA_SCC,
 	RTW89_QTA_DLFW,
@@ -4839,6 +4853,7 @@ struct rtw89_dev {
 	const struct ieee80211_ops *ops;
 
 	bool dbcc_en;
+	enum rtw89_mlo_dbcc_mode mlo_dbcc_mode;
 	struct rtw89_hw_scan_info scan_info;
 	const struct rtw89_chip_info *chip;
 	const struct rtw89_pci_info *pci_info;
@@ -5835,6 +5850,18 @@ static inline void rtw89_core_tx_wait_complete(struct rtw89_dev *rtwdev,
 	rcu_read_unlock();
 }
 
+static inline bool rtw89_is_mlo_1_1(struct rtw89_dev *rtwdev)
+{
+	switch (rtwdev->mlo_dbcc_mode) {
+	case MLO_1_PLUS_1_1RF:
+	case MLO_1_PLUS_1_2RF:
+	case DBCC_LEGACY:
+		return true;
+	default:
+		return false;
+	}
+}
+
 int rtw89_core_tx_write(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
 			struct ieee80211_sta *sta, struct sk_buff *skb, int *qsel);
 int rtw89_h2c_tx(struct rtw89_dev *rtwdev,
-- 
2.25.1


