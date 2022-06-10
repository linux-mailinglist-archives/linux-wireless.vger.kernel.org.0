Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9E42545D58
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jun 2022 09:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343868AbiFJH13 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Jun 2022 03:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346770AbiFJH1B (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Jun 2022 03:27:01 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D77144FE1
        for <linux-wireless@vger.kernel.org>; Fri, 10 Jun 2022 00:26:58 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 25A7QroN6010175, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 25A7QroN6010175
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 10 Jun 2022 15:26:53 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 10 Jun 2022 15:26:53 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 10 Jun
 2022 15:26:53 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <damon.chen@realtek.com>,
        <phhuang@realtek.com>
Subject: [PATCH 08/11] rtw89: drop invalid TX rate report of legacy rate
Date:   Fri, 10 Jun 2022 15:26:07 +0800
Message-ID: <20220610072610.27095-9-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220610072610.27095-1-pkshih@realtek.com>
References: <20220610072610.27095-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 06/10/2022 07:06:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzYvMTAgpFekyCAwNjowMDowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Somehow, firmware could report invalid TX rate, and we consider the
invalid rate as 0 that will make a wrong decision. So, drop invalid
reports, and also suppress the warning message.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c |  9 +++++----
 drivers/net/wireless/realtek/rtw89/core.h |  2 +-
 drivers/net/wireless/realtek/rtw89/phy.c  | 14 +++++++++++---
 3 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index c494ad9013078..b296c39329292 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -155,18 +155,19 @@ static struct ieee80211_rate rtw89_bitrates[] = {
 	{ .bitrate = 540, .hw_value = 0x0b, },
 };
 
-u16 rtw89_ra_report_to_bitrate(struct rtw89_dev *rtwdev, u8 rpt_rate)
+bool rtw89_ra_report_to_bitrate(struct rtw89_dev *rtwdev, u8 rpt_rate, u16 *bitrate)
 {
 	struct ieee80211_rate rate;
 
 	if (unlikely(rpt_rate >= ARRAY_SIZE(rtw89_bitrates))) {
-		rtw89_info(rtwdev, "invalid rpt rate %d\n", rpt_rate);
-		return 0;
+		rtw89_debug(rtwdev, RTW89_DBG_UNEXP, "invalid rpt rate %d\n", rpt_rate);
+		return false;
 	}
 
 	rate = rtw89_bitrates[rpt_rate];
+	*bitrate = rate.bitrate;
 
-	return rate.bitrate;
+	return true;
 }
 
 static struct ieee80211_supported_band rtw89_sband_2ghz = {
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index e05f17c6545e9..ff3aeffbd20ad 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3893,7 +3893,7 @@ int rtw89_core_acquire_sta_ba_entry(struct rtw89_sta *rtwsta, u8 tid, u8 *cam_id
 int rtw89_core_release_sta_ba_entry(struct rtw89_sta *rtwsta, u8 tid, u8 *cam_idx);
 void rtw89_vif_type_mapping(struct ieee80211_vif *vif, bool assoc);
 int rtw89_chip_info_setup(struct rtw89_dev *rtwdev);
-u16 rtw89_ra_report_to_bitrate(struct rtw89_dev *rtwdev, u8 rpt_rate);
+bool rtw89_ra_report_to_bitrate(struct rtw89_dev *rtwdev, u8 rpt_rate, u16 *bitrate);
 int rtw89_regd_init(struct rtw89_dev *rtwdev,
 		    void (*reg_notifier)(struct wiphy *wiphy, struct regulatory_request *request));
 void rtw89_regd_notifier(struct wiphy *wiphy, struct regulatory_request *request);
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 762cdba9d3cfd..2d9d2d4c8fecf 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -1918,21 +1918,29 @@ static void rtw89_phy_c2h_ra_rpt_iter(void *data, struct ieee80211_sta *sta)
 	struct rtw89_ra_report *ra_report = &rtwsta->ra_report;
 	struct sk_buff *c2h = ra_data->c2h;
 	u8 mode, rate, bw, giltf, mac_id;
+	u16 legacy_bitrate;
+	bool valid;
 
 	mac_id = RTW89_GET_PHY_C2H_RA_RPT_MACID(c2h->data);
 	if (mac_id != rtwsta->mac_id)
 		return;
 
-	memset(ra_report, 0, sizeof(*ra_report));
-
 	rate = RTW89_GET_PHY_C2H_RA_RPT_MCSNSS(c2h->data);
 	bw = RTW89_GET_PHY_C2H_RA_RPT_BW(c2h->data);
 	giltf = RTW89_GET_PHY_C2H_RA_RPT_GILTF(c2h->data);
 	mode = RTW89_GET_PHY_C2H_RA_RPT_MD_SEL(c2h->data);
 
+	if (mode == RTW89_RA_RPT_MODE_LEGACY) {
+		valid = rtw89_ra_report_to_bitrate(rtwdev, rate, &legacy_bitrate);
+		if (!valid)
+			return;
+	}
+
+	memset(ra_report, 0, sizeof(*ra_report));
+
 	switch (mode) {
 	case RTW89_RA_RPT_MODE_LEGACY:
-		ra_report->txrate.legacy = rtw89_ra_report_to_bitrate(rtwdev, rate);
+		ra_report->txrate.legacy = legacy_bitrate;
 		break;
 	case RTW89_RA_RPT_MODE_HT:
 		ra_report->txrate.flags |= RATE_INFO_FLAGS_MCS;
-- 
2.25.1

