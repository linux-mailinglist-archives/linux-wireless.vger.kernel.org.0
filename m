Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 191EA4C7F7C
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Mar 2022 01:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbiCAApD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Feb 2022 19:45:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiCAApB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Feb 2022 19:45:01 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14A62DEE
        for <linux-wireless@vger.kernel.org>; Mon, 28 Feb 2022 16:44:20 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 2210i0z35026804, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 2210i0z35026804
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 1 Mar 2022 08:44:00 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 1 Mar 2022 08:43:59 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Tue, 1 Mar
 2022 08:43:59 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <johannes.berg@intel.com>
Subject: [PATCH v3] rtw89: fix HE PHY bandwidth capability
Date:   Tue, 1 Mar 2022 08:43:31 +0800
Message-ID: <20220301004331.6621-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
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
X-KSE-Antiphishing-Bases: 03/01/2022 00:31:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzIvMjggpFWkyCAxMToyMTowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
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

From: Johannes Berg <johannes.berg@intel.com>

Bit 2 and 3 are reserved on 5/6 GHz and bit 1 is reserved on 2.4 GHz,
so the driver should only set the non-reserved bits according
to band.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v3: not only bit 2, but also bit 3 is also reserved on 5/6 GHz.
v2: do rebase onto the latest tree
---
 drivers/net/wireless/realtek/rtw89/core.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index a0086b14550a8..f9822a07e9c5a 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -2333,10 +2333,15 @@ static void rtw89_init_he_cap(struct rtw89_dev *rtwdev,
 				  IEEE80211_HE_MAC_CAP4_AMSDU_IN_AMPDU;
 		if (i == NL80211_IFTYPE_STATION)
 			mac_cap_info[5] = IEEE80211_HE_MAC_CAP5_HT_VHT_TRIG_FRAME_RX;
-		phy_cap_info[0] = IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G |
-				  IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G;
-		if (chip->support_bw160)
-			phy_cap_info[0] |= IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G;
+		if (band == NL80211_BAND_2GHZ) {
+			phy_cap_info[0] =
+				IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G;
+		} else {
+			phy_cap_info[0] =
+				IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G;
+			if (chip->support_bw160)
+				phy_cap_info[0] |= IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G;
+		}
 		phy_cap_info[1] = IEEE80211_HE_PHY_CAP1_DEVICE_CLASS_A |
 				  IEEE80211_HE_PHY_CAP1_LDPC_CODING_IN_PAYLOAD |
 				  IEEE80211_HE_PHY_CAP1_HE_LTF_AND_GI_FOR_HE_PPDUS_0_8US;
-- 
2.25.1

