Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 720687A902E
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Sep 2023 02:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjIUAga (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Sep 2023 20:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjIUAg2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Sep 2023 20:36:28 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9684D7
        for <linux-wireless@vger.kernel.org>; Wed, 20 Sep 2023 17:36:19 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 38L0a9a451966988, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 38L0a9a451966988
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Sep 2023 08:36:09 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 21 Sep 2023 08:36:09 +0800
Received: from [127.0.1.1] (172.16.16.112) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Thu, 21 Sep
 2023 08:36:09 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/4] wifi: rtw89: mcc: fix NoA start time when GO is auxiliary
Date:   Thu, 21 Sep 2023 08:35:56 +0800
Message-ID: <20230921003559.11588-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230921003559.11588-1-pkshih@realtek.com>
References: <20230921003559.11588-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.16.112]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
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

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Under TDMA-based MCC (multi-channel concurrency), there are two roles,
reference and auxiliary. We arrange MCC timeline based on time domain
of reference role. Then, we calculate NoA start time according to MCC
timeline.

Besides, when MCC runs GO+STA mode, we plan an offset between GO time
domain and STA time domain to make their TBTTs have a time gap.

However, if GO is auxiliary role instead of reference role, NoA start
time is described by STA time domain instead of GO time domain. To fix
this, we apply the offset mentioned above to NoA start time to convert
time domain from STA to GO.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/chan.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/chan.c b/drivers/net/wireless/realtek/rtw89/chan.c
index fb68d7f8ec3a..5564067c45cc 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.c
+++ b/drivers/net/wireless/realtek/rtw89/chan.c
@@ -1430,6 +1430,7 @@ static void rtw89_mcc_handle_beacon_noa(struct rtw89_dev *rtwdev, bool enable)
 	struct rtw89_mcc_role *aux = &mcc->role_aux;
 	struct rtw89_mcc_config *config = &mcc->config;
 	struct rtw89_mcc_pattern *pattern = &config->pattern;
+	struct rtw89_mcc_sync *sync = &config->sync;
 	struct ieee80211_p2p_noa_desc noa_desc = {};
 	u64 start_time = config->start_tsf;
 	u32 interval = config->mcc_interval;
@@ -1449,6 +1450,9 @@ static void rtw89_mcc_handle_beacon_noa(struct rtw89_dev *rtwdev, bool enable)
 			      ieee80211_tu_to_usec(config->beacon_offset) +
 			      ieee80211_tu_to_usec(pattern->toa_aux);
 		duration = config->mcc_interval - aux->duration;
+
+		/* convert time domain from sta(ref) to GO(aux) */
+		start_time += ieee80211_tu_to_usec(sync->offset);
 	} else {
 		rtw89_debug(rtwdev, RTW89_DBG_CHAN,
 			    "MCC find no GO: skip updating beacon NoA\n");
-- 
2.25.1

