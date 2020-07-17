Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C23582234E6
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jul 2020 08:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbgGQGuG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Jul 2020 02:50:06 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:55017 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbgGQGuF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Jul 2020 02:50:05 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 06H6o0Mu9028960, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 06H6o0Mu9028960
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 17 Jul 2020 14:50:00 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 17 Jul 2020 14:49:59 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 17 Jul 2020 14:49:59 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/7] rtw88: fix short GI capability based on current bandwidth
Date:   Fri, 17 Jul 2020 14:49:32 +0800
Message-ID: <20200717064937.27966-3-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200717064937.27966-1-yhchuang@realtek.com>
References: <20200717064937.27966-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.128]
X-ClientProxiedBy: RTEXMB02.realtek.com.tw (172.21.6.95) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Tsang-Shian Lin <thlin@realtek.com>

Fix the transmission is not sent with short GI under
some conditions even if the receiver supports short GI.
If VHT capability IE exists in the beacon, the original
code uses the short GI for 80M field as driver's short GI
setting for transmission, even the current bandwidth is
not 80MHz.

Short GI supported fields for 20M/40M are informed in HT
capability information element, and short GI supported
field for 80M is informed in VHT capability information
element.

These three fields may be set to different values.
Driver needs to record each short GI support field for
each bandwidth, and send correct info depends on current
bandwidth to the WiFi firmware.

Fixes: e3037485c68e ("rtw88: new Realtek 802.11ac driver")
Signed-off-by: Tsang-Shian Lin <thlin@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/main.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 7304e8bc5e31..54044abf30d7 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -722,8 +722,6 @@ void rtw_update_sta_info(struct rtw_dev *rtwdev, struct rtw_sta_info *si)
 			stbc_en = VHT_STBC_EN;
 		if (sta->vht_cap.cap & IEEE80211_VHT_CAP_RXLDPC)
 			ldpc_en = VHT_LDPC_EN;
-		if (sta->vht_cap.cap & IEEE80211_VHT_CAP_SHORT_GI_80)
-			is_support_sgi = true;
 	} else if (sta->ht_cap.ht_supported) {
 		ra_mask |= (sta->ht_cap.mcs.rx_mask[1] << 20) |
 			   (sta->ht_cap.mcs.rx_mask[0] << 12);
@@ -731,9 +729,6 @@ void rtw_update_sta_info(struct rtw_dev *rtwdev, struct rtw_sta_info *si)
 			stbc_en = HT_STBC_EN;
 		if (sta->ht_cap.cap & IEEE80211_HT_CAP_LDPC_CODING)
 			ldpc_en = HT_LDPC_EN;
-		if (sta->ht_cap.cap & IEEE80211_HT_CAP_SGI_20 ||
-		    sta->ht_cap.cap & IEEE80211_HT_CAP_SGI_40)
-			is_support_sgi = true;
 	}
 
 	if (efuse->hw_cap.nss == 1)
@@ -775,12 +770,18 @@ void rtw_update_sta_info(struct rtw_dev *rtwdev, struct rtw_sta_info *si)
 	switch (sta->bandwidth) {
 	case IEEE80211_STA_RX_BW_80:
 		bw_mode = RTW_CHANNEL_WIDTH_80;
+		is_support_sgi = sta->vht_cap.vht_supported &&
+				 (sta->vht_cap.cap & IEEE80211_VHT_CAP_SHORT_GI_80);
 		break;
 	case IEEE80211_STA_RX_BW_40:
 		bw_mode = RTW_CHANNEL_WIDTH_40;
+		is_support_sgi = sta->ht_cap.ht_supported &&
+				 (sta->ht_cap.cap & IEEE80211_HT_CAP_SGI_40);
 		break;
 	default:
 		bw_mode = RTW_CHANNEL_WIDTH_20;
+		is_support_sgi = sta->ht_cap.ht_supported &&
+				 (sta->ht_cap.cap & IEEE80211_HT_CAP_SGI_20);
 		break;
 	}
 
-- 
2.17.1

