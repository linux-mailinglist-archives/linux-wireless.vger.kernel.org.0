Return-Path: <linux-wireless+bounces-17628-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB4BA14A24
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jan 2025 08:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08403188A467
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jan 2025 07:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FA01F7917;
	Fri, 17 Jan 2025 07:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="eTnZuX1C"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9223F1F8668
	for <linux-wireless@vger.kernel.org>; Fri, 17 Jan 2025 07:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737098962; cv=none; b=LMuMT7J4oMmFfVXGKYSO7lohDsjCHTwmCIP/L7CKSi4/JbcYglrNYJ0Otmr7ccxwVS1k5uEaL6tWERIKEwmQZqsFXOxYJ4wQE1jIgcNh6vSdXxIWhkH2ZnGBUusObE/Fwl+osPX37nuv+AqI34eY+LWDovheptDEb0mBuqpP9p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737098962; c=relaxed/simple;
	bh=NNoDpuRmphL5cGeVttrGvh9PjPOuiIDPr4X0TQ62SfI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DE2zokzpO4clfjylctX+uigloMk+yFIvL5bHZpBgC24/EjB9A5TlLFUHBAkq1UlwxLE7C4y/5pkrVPxAAJwWz6t7qPma33UJtDhoPo01wlk+UterxhBcdcdnly/2vNq5cBcgRROi9bGNWCoHltYlr7fKRbRnq1/e9SnFJbhDGrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=eTnZuX1C; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 50H7TGDY02337827, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1737098956; bh=NNoDpuRmphL5cGeVttrGvh9PjPOuiIDPr4X0TQ62SfI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=eTnZuX1CaRQCX1xjwJJVBHYUToRhl0kME/XEh/oOmBae9xg4p+CbQ3ETpm9WpRUU9
	 J7RmuR/A/w+MUhDTfNmGTCts8nw+SoTYvpbZbWhPP/dSeCL0oUWOLltbnU1rYPfpCU
	 ItW2YPABDEHL+a8WliTrAUZBKBm6peaiqZfsV9SSnnpG3NNk70k41IeUFkxkzuMNZP
	 sa3hflLV3kNX/i2jiCXMIPfFHgrWsOPnMW3DZdZcOkrqKOGyUk/2EJQ6yeOAsO6AYC
	 9U14vyRGa0Co+Ob0F0MGcwrAzUr273xYuSRsOSP7PQbtw5Xd/GPdgIBn96y4G+UwK1
	 FzxOXCwNO7Utw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 50H7TGDY02337827
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 17 Jan 2025 15:29:16 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 17 Jan 2025 15:29:16 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 17 Jan
 2025 15:29:16 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH 5/8] wifi: rtw89: phy: support ch_info per PHY
Date: Fri, 17 Jan 2025 15:28:25 +0800
Message-ID: <20250117072828.16728-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250117072828.16728-1-pkshih@realtek.com>
References: <20250117072828.16728-1-pkshih@realtek.com>
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

The ch_info is to record current channel info such as minimum RSSI of
connected stations, and to assist in dynamic mechanisms of DIG and EDCCA.

Move the struct to PHY context, so the dynamic mechanisms can use the info
of the same PHY.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h |  1 +
 drivers/net/wireless/realtek/rtw89/phy.c  | 18 ++++++++++++------
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 86f1370ff136..0523f97fb0e1 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -5695,6 +5695,7 @@ struct rtw89_dev {
 		enum rtw89_phy_idx phy_idx;
 		struct rtw89_env_monitor_info env_monitor;
 		struct rtw89_dig_info dig;
+		struct rtw89_phy_ch_info ch_info;
 	} bbs[RTW89_PHY_NUM];
 
 	struct delayed_work track_work;
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index bae8d8643490..e07f874590d2 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -5115,7 +5115,6 @@ static void rtw89_phy_stat_thermal_update(struct rtw89_dev *rtwdev)
 
 struct rtw89_phy_iter_rssi_data {
 	struct rtw89_dev *rtwdev;
-	struct rtw89_phy_ch_info *ch_info;
 	bool rssi_changed;
 };
 
@@ -5123,10 +5122,15 @@ static
 void __rtw89_phy_stat_rssi_update_iter(struct rtw89_sta_link *rtwsta_link,
 				       struct rtw89_phy_iter_rssi_data *rssi_data)
 {
-	struct rtw89_phy_ch_info *ch_info = rssi_data->ch_info;
+	struct rtw89_vif_link *rtwvif_link = rtwsta_link->rtwvif_link;
+	struct rtw89_dev *rtwdev = rssi_data->rtwdev;
+	struct rtw89_phy_ch_info *ch_info;
+	struct rtw89_bb_ctx *bb;
 	unsigned long rssi_curr;
 
 	rssi_curr = ewma_rssi_read(&rtwsta_link->avg_rssi);
+	bb = rtw89_get_bb_ctx(rtwdev, rtwvif_link->phy_idx);
+	ch_info = &bb->ch_info;
 
 	if (rssi_curr < ch_info->rssi_min) {
 		ch_info->rssi_min = rssi_curr;
@@ -5157,11 +5161,13 @@ static void rtw89_phy_stat_rssi_update_iter(void *data,
 
 static void rtw89_phy_stat_rssi_update(struct rtw89_dev *rtwdev)
 {
-	struct rtw89_phy_iter_rssi_data rssi_data = {0};
+	struct rtw89_phy_iter_rssi_data rssi_data = {};
+	struct rtw89_bb_ctx *bb;
 
 	rssi_data.rtwdev = rtwdev;
-	rssi_data.ch_info = &rtwdev->ch_info;
-	rssi_data.ch_info->rssi_min = U8_MAX;
+	rtw89_for_each_active_bb(rtwdev, bb)
+		bb->ch_info.rssi_min = U8_MAX;
+
 	ieee80211_iterate_stations_atomic(rtwdev->hw,
 					  rtw89_phy_stat_rssi_update_iter,
 					  &rssi_data);
@@ -5919,7 +5925,7 @@ static const u16 fa_th_nolink[FA_TH_NUM] = {196, 352, 440, 528};
 static void rtw89_phy_dig_update_rssi_info(struct rtw89_dev *rtwdev,
 					   struct rtw89_bb_ctx *bb)
 {
-	struct rtw89_phy_ch_info *ch_info = &rtwdev->ch_info;
+	struct rtw89_phy_ch_info *ch_info = &bb->ch_info;
 	struct rtw89_dig_info *dig = &bb->dig;
 	bool is_linked = rtwdev->total_sta_assoc > 0;
 
-- 
2.25.1


