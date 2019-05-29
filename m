Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEEF62D716
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2019 09:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbfE2Hy5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 May 2019 03:54:57 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:37201 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbfE2Hy5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 May 2019 03:54:57 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x4T7sr4V005554, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtitcasv01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x4T7sr4V005554
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=NOT);
        Wed, 29 May 2019 15:54:53 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.408.0; Wed, 29 May 2019 15:54:53 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 04/11] rtw88: remove unused variable
Date:   Wed, 29 May 2019 15:54:40 +0800
Message-ID: <1559116487-5244-5-git-send-email-yhchuang@realtek.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559116487-5244-1-git-send-email-yhchuang@realtek.com>
References: <1559116487-5244-1-git-send-email-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.126]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yan-Hsuan Chuang <yhchuang@realtek.com>

The orig variable is taken but not used, remove it

Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/phy.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/phy.c b/drivers/net/wireless/realtek/rtw88/phy.c
index 9733dba..a7c7fd1 100644
--- a/drivers/net/wireless/realtek/rtw88/phy.c
+++ b/drivers/net/wireless/realtek/rtw88/phy.c
@@ -1665,12 +1665,11 @@ void rtw_phy_tx_power_by_rate_config(struct rtw_hal *hal)
 static void
 __rtw_phy_tx_power_limit_config(struct rtw_hal *hal, u8 regd, u8 bw, u8 rs)
 {
-	s8 base, orig;
+	s8 base;
 	u8 ch;
 
 	for (ch = 0; ch < RTW_MAX_CHANNEL_NUM_2G; ch++) {
 		base = hal->tx_pwr_by_rate_base_2g[0][rs];
-		orig = hal->tx_pwr_limit_2g[regd][bw][rs][ch];
 		hal->tx_pwr_limit_2g[regd][bw][rs][ch] -= base;
 	}
 
-- 
2.7.4

