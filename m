Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD66712CF6
	for <lists+linux-wireless@lfdr.de>; Fri,  3 May 2019 13:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbfECLxu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 May 2019 07:53:50 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:58247 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727631AbfECLxp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 May 2019 07:53:45 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x43Bre3g000720, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtitcasv01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x43Bre3g000720
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=NOT);
        Fri, 3 May 2019 19:53:40 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.408.0; Fri, 3 May 2019 19:53:40 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 2/5] rtw88: pci: use ieee80211_ac_numbers instead of 0-3
Date:   Fri, 3 May 2019 19:53:32 +0800
Message-ID: <1556884415-23474-3-git-send-email-yhchuang@realtek.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556884415-23474-1-git-send-email-yhchuang@realtek.com>
References: <1556884415-23474-1-git-send-email-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.126]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yan-Hsuan Chuang <yhchuang@realtek.com>

AC numbers are defined as enum in mac80211, use them instead of bare
0-3 indexing.

Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/pci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
index cfe05ba..87bfcb3 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.c
+++ b/drivers/net/wireless/realtek/rtw88/pci.c
@@ -487,10 +487,10 @@ static void rtw_pci_stop(struct rtw_dev *rtwdev)
 }
 
 static u8 ac_to_hwq[] = {
-	[0] = RTW_TX_QUEUE_VO,
-	[1] = RTW_TX_QUEUE_VI,
-	[2] = RTW_TX_QUEUE_BE,
-	[3] = RTW_TX_QUEUE_BK,
+	[IEEE80211_AC_VO] = RTW_TX_QUEUE_VO,
+	[IEEE80211_AC_VI] = RTW_TX_QUEUE_VI,
+	[IEEE80211_AC_BE] = RTW_TX_QUEUE_BE,
+	[IEEE80211_AC_BK] = RTW_TX_QUEUE_BK,
 };
 
 static u8 rtw_hw_queue_mapping(struct sk_buff *skb)
-- 
2.7.4

