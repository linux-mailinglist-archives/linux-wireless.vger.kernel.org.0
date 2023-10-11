Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 146157C528F
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Oct 2023 13:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbjJKLxg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Oct 2023 07:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbjJKLxf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Oct 2023 07:53:35 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1EB194
        for <linux-wireless@vger.kernel.org>; Wed, 11 Oct 2023 04:53:33 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 39BBrLHq93997506, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 39BBrLHq93997506
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Oct 2023 19:53:21 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 11 Oct 2023 19:53:22 +0800
Received: from [127.0.1.1] (172.16.16.120) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 11 Oct
 2023 19:53:21 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>, <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v3 4/6] wifi: rtw89: parse TX EHT rate selected by firmware from RA C2H report
Date:   Wed, 11 Oct 2023 19:52:54 +0800
Message-ID: <20231011115256.6121-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231011115256.6121-1-pkshih@realtek.com>
References: <20231011115256.6121-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.16.120]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

