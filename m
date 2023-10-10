Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 614EA7BF0B0
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Oct 2023 04:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441860AbjJJCKv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Oct 2023 22:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441824AbjJJCKt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Oct 2023 22:10:49 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320278F
        for <linux-wireless@vger.kernel.org>; Mon,  9 Oct 2023 19:10:47 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 39A2AaME22015418, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 39A2AaME22015418
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Oct 2023 10:10:36 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 10 Oct 2023 10:10:37 +0800
Received: from [127.0.1.1] (172.16.16.25) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 10 Oct
 2023 10:10:36 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>, <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 5/6] wifi: radiotap: add bandwidth definition of EHT U-SIG
Date:   Tue, 10 Oct 2023 10:10:05 +0800
Message-ID: <20231010021006.6061-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231010021006.6061-1-pkshih@realtek.com>
References: <20231010021006.6061-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.16.25]
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Define EHT U-SIG bandwidth used by radiotap according to Table 36-28
"U-SIG field of an EHT MU PPDU" in 802.11be (D3.0).

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
  - correct commit message about the source of bandwidth definition
    of EHT U-SIG suggested by Johannes
---
 include/net/ieee80211_radiotap.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/net/ieee80211_radiotap.h b/include/net/ieee80211_radiotap.h
index 2338f8d2a8b3..925bac726a92 100644
--- a/include/net/ieee80211_radiotap.h
+++ b/include/net/ieee80211_radiotap.h
@@ -539,6 +539,12 @@ enum ieee80211_radiotap_eht_usig_common {
 	IEEE80211_RADIOTAP_EHT_USIG_COMMON_VALIDATE_BITS_OK	= 0x00000080,
 	IEEE80211_RADIOTAP_EHT_USIG_COMMON_PHY_VER		= 0x00007000,
 	IEEE80211_RADIOTAP_EHT_USIG_COMMON_BW			= 0x00038000,
+		IEEE80211_RADIOTAP_EHT_USIG_COMMON_BW_20MHZ		= 0,
+		IEEE80211_RADIOTAP_EHT_USIG_COMMON_BW_40MHZ		= 1,
+		IEEE80211_RADIOTAP_EHT_USIG_COMMON_BW_80MHZ		= 2,
+		IEEE80211_RADIOTAP_EHT_USIG_COMMON_BW_160MHZ		= 3,
+		IEEE80211_RADIOTAP_EHT_USIG_COMMON_BW_320MHZ_1		= 4,
+		IEEE80211_RADIOTAP_EHT_USIG_COMMON_BW_320MHZ_2		= 5,
 	IEEE80211_RADIOTAP_EHT_USIG_COMMON_UL_DL		= 0x00040000,
 	IEEE80211_RADIOTAP_EHT_USIG_COMMON_BSS_COLOR		= 0x01f80000,
 	IEEE80211_RADIOTAP_EHT_USIG_COMMON_TXOP			= 0xfe000000,
-- 
2.25.1

