Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7047C5291
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Oct 2023 13:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234760AbjJKLxo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Oct 2023 07:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232111AbjJKLxn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Oct 2023 07:53:43 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F49A4
        for <linux-wireless@vger.kernel.org>; Wed, 11 Oct 2023 04:53:40 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 39BBrNUB13997542, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 39BBrNUB13997542
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Oct 2023 19:53:23 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Wed, 11 Oct 2023 19:53:23 +0800
Received: from [127.0.1.1] (172.16.16.120) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 11 Oct
 2023 19:53:23 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>, <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v3 5/6] wifi: rtw89: show EHT rate in debugfs
Date:   Wed, 11 Oct 2023 19:52:55 +0800
Message-ID: <20231011115256.6121-6-pkshih@realtek.com>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
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

Since we have TX rate from RA report of C2H event and RX rate from RX
descriptor, show them in debugfs like

  TX rate [1]: EHT 2SS MCS-7 GI:3.2 BW:80	(hw_rate=0x427)
  RX rate [1]: EHT 2SS MCS-7 GI:3.2 BW:80	(hw_rate=0x427)

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/debug.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index 6990d3679bc0..a3f795d240ea 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -3467,6 +3467,11 @@ static void rtw89_sta_info_get_iter(void *data, struct ieee80211_sta *sta)
 		[NL80211_RATE_INFO_HE_GI_1_6] = "1.6",
 		[NL80211_RATE_INFO_HE_GI_3_2] = "3.2",
 	};
+	static const char * const eht_gi_str[] = {
+		[NL80211_RATE_INFO_EHT_GI_0_8] = "0.8",
+		[NL80211_RATE_INFO_EHT_GI_1_6] = "1.6",
+		[NL80211_RATE_INFO_EHT_GI_3_2] = "3.2",
+	};
 	struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
 	struct rate_info *rate = &rtwsta->ra_report.txrate;
 	struct ieee80211_rx_status *status = &rtwsta->rx_status;
@@ -3492,6 +3497,10 @@ static void rtw89_sta_info_get_iter(void *data, struct ieee80211_sta *sta)
 		seq_printf(m, "HE %dSS MCS-%d GI:%s", rate->nss, rate->mcs,
 			   rate->he_gi <= NL80211_RATE_INFO_HE_GI_3_2 ?
 			   he_gi_str[rate->he_gi] : "N/A");
+	else if (rate->flags & RATE_INFO_FLAGS_EHT_MCS)
+		seq_printf(m, "EHT %dSS MCS-%d GI:%s", rate->nss, rate->mcs,
+			   rate->eht_gi < ARRAY_SIZE(eht_gi_str) ?
+			   eht_gi_str[rate->eht_gi] : "N/A");
 	else
 		seq_printf(m, "Legacy %d", rate->legacy);
 	seq_printf(m, "%s", rtwsta->ra_report.might_fallback_legacy ? " FB_G" : "");
@@ -3520,6 +3529,11 @@ static void rtw89_sta_info_get_iter(void *data, struct ieee80211_sta *sta)
 			   status->he_gi <= NL80211_RATE_INFO_HE_GI_3_2 ?
 			   he_gi_str[rate->he_gi] : "N/A");
 		break;
+	case RX_ENC_EHT:
+		seq_printf(m, "EHT %dSS MCS-%d GI:%s", status->nss, status->rate_idx,
+			   status->eht.gi < ARRAY_SIZE(eht_gi_str) ?
+			   eht_gi_str[status->eht.gi] : "N/A");
+		break;
 	}
 	seq_printf(m, " BW:%u", rtw89_rate_info_bw_to_mhz(status->bw));
 	seq_printf(m, "\t(hw_rate=0x%x)\n", rtwsta->rx_hw_rate);
-- 
2.25.1

