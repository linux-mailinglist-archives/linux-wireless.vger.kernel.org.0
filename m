Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF8621328DE
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jan 2020 15:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbgAGO1v (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Jan 2020 09:27:51 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:43532 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727958AbgAGO1v (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Jan 2020 09:27:51 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID 007ERd8X016937, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id 007ERd8X016937
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 7 Jan 2020 22:27:39 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Tue, 7 Jan 2020 22:27:39 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: [PATCH] rtw88: use shorter delay time to poll PS state
Date:   Tue, 7 Jan 2020 22:27:29 +0800
Message-ID: <20200107142729.17716-1-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.128]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yan-Hsuan Chuang <yhchuang@realtek.com>

When TX packet arrives, driver should leave deep PS state to make
sure the DMA is working. After requested to leave deep PS state,
driver needs to poll the PS state to check if the mode has been
changed successfully. The driver used to check the state of the
hardware every 20 msecs, which means upon the first failure of
state check, the CPU is delayed 20 msecs for next check. This is
harmful for some time-sensitive applications such as media players.

So, use shorter delay time each check from 20 msecs to 100 usecs.
The state should be changed in several tries. But we still need
to reserve ~15 msecs in total in case of the state just took too
long to be changed successfully. If the states of driver and the
hardware is not synchronized, the power state could be locked
forever, which mean we could never enter/leave the PS state.

Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/ps.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/ps.c b/drivers/net/wireless/realtek/rtw88/ps.c
index 913e6f47130f..7a189a9926fe 100644
--- a/drivers/net/wireless/realtek/rtw88/ps.c
+++ b/drivers/net/wireless/realtek/rtw88/ps.c
@@ -91,11 +91,11 @@ void rtw_power_mode_change(struct rtw_dev *rtwdev, bool enter)
 			return;
 
 		/* check confirm power mode has left power save state */
-		for (polling_cnt = 0; polling_cnt < 3; polling_cnt++) {
+		for (polling_cnt = 0; polling_cnt < 50; polling_cnt++) {
 			polling = rtw_read8(rtwdev, rtwdev->hci.cpwm_addr);
 			if ((polling ^ confirm) & BIT_RPWM_TOGGLE)
 				return;
-			mdelay(20);
+			udelay(100);
 		}
 
 		/* in case of fw/hw missed the request, retry */
-- 
2.17.1

