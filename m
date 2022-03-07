Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41E264CEF1C
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Mar 2022 02:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234593AbiCGB33 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 6 Mar 2022 20:29:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233960AbiCGB32 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 6 Mar 2022 20:29:28 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD0E1DA67
        for <linux-wireless@vger.kernel.org>; Sun,  6 Mar 2022 17:28:33 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 2271SFM90023817, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 2271SFM90023817
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 7 Mar 2022 09:28:15 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 7 Mar 2022 09:28:15 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Mon, 7 Mar
 2022 09:28:14 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v2] rtw89: declare HE capabilities in 6G band
Date:   Mon, 7 Mar 2022 09:27:41 +0800
Message-ID: <20220307012741.6371-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 03/07/2022 01:07:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzMvNiCkVaTIIDEwOjAwOjAw?=
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

To work properly in 6G band, declare HE 6G capabilities. Without this fix,
it can only TX/RX with OFDM rates.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2: use correct le16_encode_bits() and enums.
---
 drivers/net/wireless/realtek/rtw89/core.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index a0086b14550a8..2a16e38e36151 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -2383,6 +2383,18 @@ static void rtw89_init_he_cap(struct rtw89_dev *rtwdev,
 			he_cap->he_mcs_nss_supp.tx_mcs_160 = cpu_to_le16(mcs_map);
 		}
 
+		if (band == NL80211_BAND_6GHZ) {
+			__le16 capa;
+
+			capa = le16_encode_bits(IEEE80211_HT_MPDU_DENSITY_NONE,
+						IEEE80211_HE_6GHZ_CAP_MIN_MPDU_START) |
+			       le16_encode_bits(IEEE80211_VHT_MAX_AMPDU_1024K,
+						IEEE80211_HE_6GHZ_CAP_MAX_AMPDU_LEN_EXP) |
+			       le16_encode_bits(IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_11454,
+						IEEE80211_HE_6GHZ_CAP_MAX_MPDU_LEN);
+			iftype_data[idx].he_6ghz_capa.capa = capa;
+		}
+
 		idx++;
 	}
 
-- 
2.25.1

