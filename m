Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BEEDEBD06
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Nov 2019 06:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbfKAFTw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Nov 2019 01:19:52 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:35495 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727332AbfKAFTw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Nov 2019 01:19:52 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID xA15Ji48015123, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id xA15Ji48015123
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 1 Nov 2019 13:19:44 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Fri, 1 Nov 2019 13:19:44 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: [PATCH v2] rtw88: raise LPS threshold to 50, for less power consumption
Date:   Fri, 1 Nov 2019 13:19:42 +0800
Message-ID: <20191101051942.18730-1-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.126]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yan-Hsuan Chuang <yhchuang@realtek.com>

The LPS threshold was set to 2, means driver will leave LPS
mode if there is more than 2 frames TX/RX for every 2 seconds.
This makes driver enter/leave LPS frequently even if we just
"ping -i1" to the others.

Apparently we do not want to leave LPS mode if there is only
some background traffics or web surfing. By experiment, set
this to 50 is a more reasonable value to lower the over all
power consumption.

Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---

v1 -> v2
  * this was originally ("https://patchwork.kernel.org/patch/11211881/")
  * but seems module parameter is not a good idea here, just change
    the default value to 50 for a general solution

 drivers/net/wireless/realtek/rtw88/ps.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/ps.h b/drivers/net/wireless/realtek/rtw88/ps.h
index 25925eedbad4..19afceca7d0e 100644
--- a/drivers/net/wireless/realtek/rtw88/ps.h
+++ b/drivers/net/wireless/realtek/rtw88/ps.h
@@ -5,7 +5,7 @@
 #ifndef __RTW_PS_H_
 #define __RTW_PS_H_
 
-#define RTW_LPS_THRESHOLD	2
+#define RTW_LPS_THRESHOLD	50
 
 #define POWER_MODE_ACK		BIT(6)
 #define POWER_MODE_PG		BIT(4)
-- 
2.17.1

