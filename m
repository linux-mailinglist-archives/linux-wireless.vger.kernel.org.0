Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9FCB6731C1
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Jan 2023 07:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjASGZh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Jan 2023 01:25:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjASGZc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Jan 2023 01:25:32 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ADA97656FD
        for <linux-wireless@vger.kernel.org>; Wed, 18 Jan 2023 22:25:30 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 30J6PGU60005756, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 30J6PGU60005756
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 19 Jan 2023 14:25:16 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Thu, 19 Jan 2023 14:25:17 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Thu, 19 Jan
 2023 14:25:16 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 3/3] wifi: rtw89: mac: add function to get TSF
Date:   Thu, 19 Jan 2023 14:24:53 +0800
Message-ID: <20230119062453.58341-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230119062453.58341-1-pkshih@realtek.com>
References: <20230119062453.58341-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 01/19/2023 06:07:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIzLzEvMTkgpFekyCAwMzozNzowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Add mac function rtw89_mac_port_get_tsf() to get TSF by port.
It will be used when MCC (multi-channel concurrency) calculates
timing things.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c | 18 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/mac.h | 11 +++++++++++
 2 files changed, 29 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index c13edd33b1a48..9e73ef6f9bc6e 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -4061,6 +4061,24 @@ int rtw89_mac_port_update(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 	return 0;
 }
 
+int rtw89_mac_port_get_tsf(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
+			   u64 *tsf)
+{
+	const struct rtw89_port_reg *p = &rtw_port_base;
+	u32 tsf_low, tsf_high;
+	int ret;
+
+	ret = rtw89_mac_check_mac_en(rtwdev, rtwvif->mac_idx, RTW89_CMAC_SEL);
+	if (ret)
+		return ret;
+
+	tsf_low = rtw89_read32_port(rtwdev, rtwvif, p->tsftr_l);
+	tsf_high = rtw89_read32_port(rtwdev, rtwvif, p->tsftr_h);
+	*tsf = (u64)tsf_high << 32 | tsf_low;
+
+	return 0;
+}
+
 static void rtw89_mac_check_he_obss_narrow_bw_ru_iter(struct wiphy *wiphy,
 						      struct cfg80211_bss *bss,
 						      void *data)
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 4c50527aad61b..553b38a6d2c31 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -827,6 +827,15 @@ static inline u32 rtw89_mac_reg_by_port(u32 base, u8 port, u8 mac_idx)
 	return rtw89_mac_reg_by_idx(base + port * 0x40, mac_idx);
 }
 
+static inline u32
+rtw89_read32_port(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif, u32 base)
+{
+	u32 reg;
+
+	reg = rtw89_mac_reg_by_port(base, rtwvif->port, rtwvif->mac_idx);
+	return rtw89_read32(rtwdev, reg);
+}
+
 static inline u32
 rtw89_read32_port_mask(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 		       u32 base, u32 mask)
@@ -910,6 +919,8 @@ void rtw89_mac_port_tsf_sync(struct rtw89_dev *rtwdev,
 			     struct rtw89_vif *rtwvif,
 			     struct rtw89_vif *rtwvif_src,
 			     u16 offset_tu);
+int rtw89_mac_port_get_tsf(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
+			   u64 *tsf);
 void rtw89_mac_set_he_obss_narrow_bw_ru(struct rtw89_dev *rtwdev,
 					struct ieee80211_vif *vif);
 void rtw89_mac_stop_ap(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif);
-- 
2.25.1

