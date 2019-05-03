Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC9812CF3
	for <lists+linux-wireless@lfdr.de>; Fri,  3 May 2019 13:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbfECLxq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 May 2019 07:53:46 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:58249 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727639AbfECLxq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 May 2019 07:53:46 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x43BrfuZ000724, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtitcasv01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x43BrfuZ000724
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=NOT);
        Fri, 3 May 2019 19:53:41 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.408.0; Fri, 3 May 2019 19:53:41 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 3/5] rtw88: pci: check if queue mapping exceeds size of ac_to_hwq
Date:   Fri, 3 May 2019 19:53:33 +0800
Message-ID: <1556884415-23474-4-git-send-email-yhchuang@realtek.com>
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

Dump warning messages when we get a q_mapping larger than the AC
numbers. And pick BE queue as default.

Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
index 87bfcb3..353871c 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.c
+++ b/drivers/net/wireless/realtek/rtw88/pci.c
@@ -504,6 +504,8 @@ static u8 rtw_hw_queue_mapping(struct sk_buff *skb)
 		queue = RTW_TX_QUEUE_BCN;
 	else if (unlikely(ieee80211_is_mgmt(fc) || ieee80211_is_ctl(fc)))
 		queue = RTW_TX_QUEUE_MGMT;
+	else if (WARN_ON_ONCE(q_mapping >= ARRAY_SIZE(ac_to_hwq)))
+		queue = ac_to_hwq[IEEE80211_AC_BE];
 	else
 		queue = ac_to_hwq[q_mapping];
 
-- 
2.7.4

