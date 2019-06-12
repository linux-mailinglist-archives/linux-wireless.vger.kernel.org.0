Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE4E41C7B
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2019 08:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731244AbfFLGpg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Jun 2019 02:45:36 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:51299 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727443AbfFLGpd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Jun 2019 02:45:33 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x5C6jTj2004356, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtitcasv01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x5C6jTj2004356
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 12 Jun 2019 14:45:29 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.439.0; Wed, 12 Jun 2019 14:45:29 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 04/11] rtw88: 8822c: add rf write protection when switching channel
Date:   Wed, 12 Jun 2019 14:45:10 +0800
Message-ID: <1560321917-17751-5-git-send-email-yhchuang@realtek.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1560321917-17751-1-git-send-email-yhchuang@realtek.com>
References: <1560321917-17751-1-git-send-email-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.126]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Chien-Hsun Liao <ben.liao@realtek.com>

Collision of writing rf registers could occur if the driver writes
rf registers by direct write while the hardware is writing other rf
registers by pi write simultaneously.

Hardware pi write can be triggered by rf calibrations sometimes, so
the driver can not always write rf registers by direct write
protection. Direct write protection can make sure that there is no
hardware pi write during the direct write.

According to some experiments, if we add direct write protection
when switching channel, the performance of rf calibration will not
be affected.

Signed-off-by: Chien-Hsun Liao <ben.liao@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/phy.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/phy.c b/drivers/net/wireless/realtek/rtw88/phy.c
index 4381b36..580f310 100644
--- a/drivers/net/wireless/realtek/rtw88/phy.c
+++ b/drivers/net/wireless/realtek/rtw88/phy.c
@@ -596,14 +596,19 @@ bool rtw_phy_write_rf_reg(struct rtw_dev *rtwdev, enum rtw_rf_path rf_path,
 	direct_addr = base_addr[rf_path] + (addr << 2);
 	mask &= RFREG_MASK;
 
-	rtw_write32_mask(rtwdev, REG_RSV_CTRL, BITS_RFC_DIRECT, DISABLE_PI);
-	rtw_write32_mask(rtwdev, REG_WLRF1, BITS_RFC_DIRECT, DISABLE_PI);
+	if (addr == RF_CFGCH) {
+		rtw_write32_mask(rtwdev, REG_RSV_CTRL, BITS_RFC_DIRECT, DISABLE_PI);
+		rtw_write32_mask(rtwdev, REG_WLRF1, BITS_RFC_DIRECT, DISABLE_PI);
+	}
+
 	rtw_write32_mask(rtwdev, direct_addr, mask, data);
 
 	udelay(1);
 
-	rtw_write32_mask(rtwdev, REG_RSV_CTRL, BITS_RFC_DIRECT, ENABLE_PI);
-	rtw_write32_mask(rtwdev, REG_WLRF1, BITS_RFC_DIRECT, ENABLE_PI);
+	if (addr == RF_CFGCH) {
+		rtw_write32_mask(rtwdev, REG_RSV_CTRL, BITS_RFC_DIRECT, ENABLE_PI);
+		rtw_write32_mask(rtwdev, REG_WLRF1, BITS_RFC_DIRECT, ENABLE_PI);
+	}
 
 	return true;
 }
-- 
2.7.4

