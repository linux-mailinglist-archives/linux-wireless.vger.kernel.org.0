Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6DF7BB8AD
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Oct 2023 15:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbjJFNOK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Oct 2023 09:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232302AbjJFNOI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Oct 2023 09:14:08 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD1893
        for <linux-wireless@vger.kernel.org>; Fri,  6 Oct 2023 06:14:06 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 396DDra861891466, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 396DDra861891466
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 6 Oct 2023 21:13:53 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 6 Oct 2023 21:13:54 +0800
Received: from [127.0.1.1] (172.16.16.139) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 6 Oct 2023
 21:13:53 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 3/6] wifi: rtw89: parse TX EHT rate selected by firmware from RA C2H report
Date:   Fri, 6 Oct 2023 21:13:24 +0800
Message-ID: <20231006131327.16806-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231006131327.16806-1-pkshih@realtek.com>
References: <20231006131327.16806-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.16.139]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

RA (rate adaptive) C2H report is to reflect current TX rate firmware is
using. Parse C2H event encoded in EHT mode, and then user space and debugfs
can use the information to know TX rate.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h |  1 +
 drivers/net/wireless/realtek/rtw89/phy.c  | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index f103ac085d2b..8c0dfd73031e 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2742,6 +2742,7 @@ enum rtw89_ra_report_mode {
 	RTW89_RA_RPT_MODE_HT,
 	RTW89_RA_RPT_MODE_VHT,
 	RTW89_RA_RPT_MODE_HE,
+	RTW89_RA_RPT_MODE_EHT,
 };
 
 enum rtw89_dig_noisy_level {
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 2a3edf775668..8a306a86f1f0 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -2399,6 +2399,18 @@ static void rtw89_phy_c2h_ra_rpt_iter(void *data, struct ieee80211_sta *sta)
 			ra_report->txrate.he_gi = NL80211_RATE_INFO_HE_GI_3_2;
 		mcs = ra_report->txrate.mcs;
 		break;
+	case RTW89_RA_RPT_MODE_EHT:
+		ra_report->txrate.flags |= RATE_INFO_FLAGS_EHT_MCS;
+		ra_report->txrate.mcs = u8_get_bits(rate, RTW89_RA_RATE_MASK_MCS_V1);
+		ra_report->txrate.nss = u8_get_bits(rate, RTW89_RA_RATE_MASK_NSS_V1) + 1;
+		if (giltf == RTW89_GILTF_2XHE08 || giltf == RTW89_GILTF_1XHE08)
+			ra_report->txrate.eht_gi = NL80211_RATE_INFO_EHT_GI_0_8;
+		else if (giltf == RTW89_GILTF_2XHE16 || giltf == RTW89_GILTF_1XHE16)
+			ra_report->txrate.eht_gi = NL80211_RATE_INFO_EHT_GI_1_6;
+		else
+			ra_report->txrate.eht_gi = NL80211_RATE_INFO_EHT_GI_3_2;
+		mcs = ra_report->txrate.mcs;
+		break;
 	}
 
 	ra_report->txrate.bw = rtw89_hw_to_rate_info_bw(bw);
-- 
2.25.1

