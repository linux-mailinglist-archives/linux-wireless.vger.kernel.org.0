Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CEC4437193
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Oct 2021 08:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbhJVGPV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Oct 2021 02:15:21 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:51595 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbhJVGPV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Oct 2021 02:15:21 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 19M6CopyE008625, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36503.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 19M6CopyE008625
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 22 Oct 2021 14:12:50 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36503.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 22 Oct 2021 14:12:50 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 22 Oct
 2021 14:12:49 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <colin.king@canonical.com>
Subject: [PATCH] rtw89: Fix variable dereferenced before check 'sta'
Date:   Fri, 22 Oct 2021 14:12:42 +0800
Message-ID: <20211022061242.8383-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 10/22/2021 06:01:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzEwLzIyIKRXpMggMDM6MzQ6MDA=?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36503.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 10/22/2021 05:58:47
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 166878 [Oct 22 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 463 463 5854868460de3f0d8e8c0a4df98aeb05fb764a09
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: realtek.com:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 10/22/2021 06:01:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The pointer rtwsta is dereferencing pointer sta before sta is being null
checked. Fix this by assigning sta->drv_priv to rtwsta only if sta is not
NULL, otherwise just NULL.

Fixes: e3ec7017f6a2 ("rtw89: add Realtek 802.11ax driver")
Reported-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 06fb6e5b1b37..d02ec5a735cb 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -1412,7 +1412,7 @@ static void rtw89_core_ba_work(struct work_struct *work)
 	list_for_each_entry_safe(rtwtxq, tmp, &rtwdev->ba_list, list) {
 		struct ieee80211_txq *txq = rtw89_txq_to_txq(rtwtxq);
 		struct ieee80211_sta *sta = txq->sta;
-		struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
+		struct rtw89_sta *rtwsta = sta ? (struct rtw89_sta *)sta->drv_priv : NULL;
 		u8 tid = txq->tid;
 
 		if (!sta) {
@@ -1462,7 +1462,7 @@ static void rtw89_core_txq_check_agg(struct rtw89_dev *rtwdev,
 	struct ieee80211_hw *hw = rtwdev->hw;
 	struct ieee80211_txq *txq = rtw89_txq_to_txq(rtwtxq);
 	struct ieee80211_sta *sta = txq->sta;
-	struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
+	struct rtw89_sta *rtwsta = sta ? (struct rtw89_sta *)sta->drv_priv : NULL;
 
 	if (unlikely(skb_get_queue_mapping(skb) == IEEE80211_AC_VO))
 		return;
@@ -1534,7 +1534,7 @@ static bool rtw89_core_txq_agg_wait(struct rtw89_dev *rtwdev,
 {
 	struct rtw89_txq *rtwtxq = (struct rtw89_txq *)txq->drv_priv;
 	struct ieee80211_sta *sta = txq->sta;
-	struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
+	struct rtw89_sta *rtwsta = sta ? (struct rtw89_sta *)sta->drv_priv : NULL;
 
 	if (!sta || rtwsta->max_agg_wait <= 0)
 		return false;
-- 
2.25.1

