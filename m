Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E423A1B5B6E
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Apr 2020 14:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728230AbgDWMaf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Apr 2020 08:30:35 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:43531 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbgDWMae (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Apr 2020 08:30:34 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 03NCUQ6V0023114, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 03NCUQ6V0023114
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 23 Apr 2020 20:30:26 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 23 Apr 2020 20:30:26 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 23 Apr 2020 20:30:25 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <pkshih@realtek.com>
Subject: [PATCH v2 5/8] rtw88: 8723d: 11N chips don't support LDPC
Date:   Thu, 23 Apr 2020 20:30:19 +0800
Message-ID: <20200423123022.10176-6-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200423123022.10176-1-yhchuang@realtek.com>
References: <20200423123022.10176-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.128]
X-ClientProxiedBy: RTEXMB02.realtek.com.tw (172.21.6.95) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ping-Ke Shih <pkshih@realtek.com>

Since 8723D devices don't support LDPC, tell mac80211 not to advertise
LDPC capability to peer.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index b0dadff0dc7b..21371576a6b2 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -933,7 +933,7 @@ static void rtw_init_ht_cap(struct rtw_dev *rtwdev,
 	ht_cap->cap = 0;
 	ht_cap->cap |= IEEE80211_HT_CAP_SGI_20 |
 			IEEE80211_HT_CAP_MAX_AMSDU |
-			IEEE80211_HT_CAP_LDPC_CODING |
+			(rtw_chip_wcpu_11ac(rtwdev) ? IEEE80211_HT_CAP_LDPC_CODING : 0) |
 			(1 << IEEE80211_HT_CAP_RX_STBC_SHIFT);
 	if (efuse->hw_cap.bw & BIT(RTW_CHANNEL_WIDTH_40))
 		ht_cap->cap |= IEEE80211_HT_CAP_SUP_WIDTH_20_40 |
-- 
2.17.1

