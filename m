Return-Path: <linux-wireless+bounces-2225-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51427832580
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jan 2024 09:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 824F31C21E24
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jan 2024 08:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E77D28DA1;
	Fri, 19 Jan 2024 08:15:43 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9F0286B4
	for <linux-wireless@vger.kernel.org>; Fri, 19 Jan 2024 08:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705652143; cv=none; b=QrEFrkpdBAAI2ofqxY2gWs8lh+iBcVDfdyFc1T688fP+A/x2Y2kZRsXoRSnV8psGK+7dNWEMqrWCuwPxzME1aaY3jaa6HNRjwSG211o3BidwOHGN5jA0HkFHV2uIDmCG6oY2K2a5P6OvJFn4NoelpaXuMtPhex03wxERcHGki2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705652143; c=relaxed/simple;
	bh=YyoInkFlGpTTTJvItkVjucJpGbBNstuboB5EPIy5RJc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qbEEBBFzWin4wuolNylod5ToLBveXgG2c0Fl2Bc0bXE0c+dNbPRuYjqGI1GxfPLzkjdi+C56QNBHJKrAdd1u+H4xfSs+dXwLo0+kYeoLinBTSuXknLXbb1Ox4yYV4DT75z62ydrjjo8yL8gVudQ/PJSUhSG/CCuWpgER9KYnYrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 40J8FYWe82212428, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 40J8FYWe82212428
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jan 2024 16:15:34 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Fri, 19 Jan 2024 16:15:34 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 19 Jan
 2024 16:15:33 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <gary.chang@realtek.com>, <phhuang@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/8] wifi: rtw89: refine hardware scan C2H events
Date: Fri, 19 Jan 2024 16:14:55 +0800
Message-ID: <20240119081501.25223-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240119081501.25223-1-pkshih@realtek.com>
References: <20240119081501.25223-1-pkshih@realtek.com>
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

From: Po-Hao Huang <phhuang@realtek.com>

Define struct for scan offload C2H events and update each elements'
bitfield. This patch does not change original behavior, just style
conversion and naming changes.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.h  | 36 +++++++++++++++---------
 drivers/net/wireless/realtek/rtw89/mac.c | 16 ++++++-----
 2 files changed, 31 insertions(+), 21 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index c5f1fdff9fe0..f64fba138834 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -169,6 +169,10 @@ enum rtw89_scanofld_notify_reason {
 	RTW89_SCAN_ENTER_CH_NOTIFY,
 	RTW89_SCAN_LEAVE_CH_NOTIFY,
 	RTW89_SCAN_END_SCAN_NOTIFY,
+	RTW89_SCAN_REPORT_NOTIFY,
+	RTW89_SCAN_CHKPT_NOTIFY,
+	RTW89_SCAN_ENTER_OP_NOTIFY,
+	RTW89_SCAN_LEAVE_OP_NOTIFY,
 };
 
 enum rtw89_chan_type {
@@ -3278,20 +3282,24 @@ struct rtw89_c2h_ra_rpt {
 #define RTW89_GET_MAC_C2H_PKTOFLD_LEN(c2h) \
 	le32_get_bits(*((const __le32 *)(c2h) + 2), GENMASK(31, 16))
 
-#define RTW89_GET_MAC_C2H_SCANOFLD_PRI_CH(c2h) \
-	le32_get_bits(*((const __le32 *)(c2h) + 2), GENMASK(7, 0))
-#define RTW89_GET_MAC_C2H_SCANOFLD_RSP(c2h) \
-	le32_get_bits(*((const __le32 *)(c2h) + 2), GENMASK(19, 16))
-#define RTW89_GET_MAC_C2H_SCANOFLD_STATUS(c2h) \
-	le32_get_bits(*((const __le32 *)(c2h) + 2), GENMASK(23, 20))
-#define RTW89_GET_MAC_C2H_ACTUAL_PERIOD(c2h) \
-	le32_get_bits(*((const __le32 *)(c2h) + 2), GENMASK(31, 24))
-#define RTW89_GET_MAC_C2H_SCANOFLD_TX_FAIL(c2h) \
-	le32_get_bits(*((const __le32 *)(c2h) + 5), GENMASK(3, 0))
-#define RTW89_GET_MAC_C2H_SCANOFLD_AIR_DENSITY(c2h) \
-	le32_get_bits(*((const __le32 *)(c2h) + 5), GENMASK(7, 4))
-#define RTW89_GET_MAC_C2H_SCANOFLD_BAND(c2h) \
-	le32_get_bits(*((const __le32 *)(c2h) + 5), GENMASK(25, 24))
+struct rtw89_c2h_scanofld {
+	__le32 w0;
+	__le32 w1;
+	__le32 w2;
+	__le32 w3;
+	__le32 w4;
+	__le32 w5;
+	__le32 w6;
+	__le32 w7;
+} __packed;
+
+#define RTW89_C2H_SCANOFLD_W2_PRI_CH GENMASK(7, 0)
+#define RTW89_C2H_SCANOFLD_W2_RSN GENMASK(19, 16)
+#define RTW89_C2H_SCANOFLD_W2_STATUS GENMASK(23, 20)
+#define RTW89_C2H_SCANOFLD_W2_PERIOD GENMASK(31, 24)
+#define RTW89_C2H_SCANOFLD_W5_TX_FAIL GENMASK(3, 0)
+#define RTW89_C2H_SCANOFLD_W5_AIR_DENSITY GENMASK(7, 4)
+#define RTW89_C2H_SCANOFLD_W5_BAND GENMASK(25, 24)
 
 #define RTW89_GET_MAC_C2H_MCC_RCV_ACK_GROUP(c2h) \
 	le32_get_bits(*((const __le32 *)(c2h) + 2), GENMASK(1, 0))
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 16f21406fbd2..d472906bd073 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -4671,9 +4671,11 @@ static bool rtw89_is_op_chan(struct rtw89_dev *rtwdev, u8 band, u8 channel)
 }
 
 static void
-rtw89_mac_c2h_scanofld_rsp(struct rtw89_dev *rtwdev, struct sk_buff *c2h,
+rtw89_mac_c2h_scanofld_rsp(struct rtw89_dev *rtwdev, struct sk_buff *skb,
 			   u32 len)
 {
+	const struct rtw89_c2h_scanofld *c2h =
+		(const struct rtw89_c2h_scanofld *)skb->data;
 	struct ieee80211_vif *vif = rtwdev->scan_info.scanning_vif;
 	struct rtw89_vif *rtwvif = vif_to_rtwvif_safe(vif);
 	struct rtw89_chan new;
@@ -4685,12 +4687,12 @@ rtw89_mac_c2h_scanofld_rsp(struct rtw89_dev *rtwdev, struct sk_buff *c2h,
 	if (!rtwvif)
 		return;
 
-	tx_fail = RTW89_GET_MAC_C2H_SCANOFLD_TX_FAIL(c2h->data);
-	status = RTW89_GET_MAC_C2H_SCANOFLD_STATUS(c2h->data);
-	chan = RTW89_GET_MAC_C2H_SCANOFLD_PRI_CH(c2h->data);
-	reason = RTW89_GET_MAC_C2H_SCANOFLD_RSP(c2h->data);
-	band = RTW89_GET_MAC_C2H_SCANOFLD_BAND(c2h->data);
-	actual_period = RTW89_GET_MAC_C2H_ACTUAL_PERIOD(c2h->data);
+	tx_fail = le32_get_bits(c2h->w5, RTW89_C2H_SCANOFLD_W5_TX_FAIL);
+	status = le32_get_bits(c2h->w2, RTW89_C2H_SCANOFLD_W2_STATUS);
+	chan = le32_get_bits(c2h->w2, RTW89_C2H_SCANOFLD_W2_PRI_CH);
+	reason = le32_get_bits(c2h->w2, RTW89_C2H_SCANOFLD_W2_RSN);
+	band = le32_get_bits(c2h->w5, RTW89_C2H_SCANOFLD_W5_BAND);
+	actual_period = le32_get_bits(c2h->w2, RTW89_C2H_SCANOFLD_W2_PERIOD);
 
 	if (!(rtwdev->chip->support_bands & BIT(NL80211_BAND_6GHZ)))
 		band = chan > 14 ? RTW89_BAND_5G : RTW89_BAND_2G;
-- 
2.25.1


