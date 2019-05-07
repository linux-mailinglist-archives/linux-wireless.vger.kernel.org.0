Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDC0715799
	for <lists+linux-wireless@lfdr.de>; Tue,  7 May 2019 04:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbfEGC22 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 May 2019 22:28:28 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:50865 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfEGC22 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 May 2019 22:28:28 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x472SMXi004592, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtitcasv01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x472SMXi004592
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=NOT);
        Tue, 7 May 2019 10:28:22 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.408.0; Tue, 7 May 2019 10:28:21 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 5.2 v3] rtw88: fix unassigned rssi_level in rtw_sta_info
Date:   Tue, 7 May 2019 10:28:18 +0800
Message-ID: <1557196098-1479-1-git-send-email-yhchuang@realtek.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.126]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yan-Hsuan Chuang <yhchuang@realtek.com>

The new rssi_level should be stored in si, otherwise the rssi_level will
never be updated and get a wrong RA mask, which is calculated by the
rssi level

If a wrong RA mask is chosen, the firmware will pick some *bad rates*.
The most hurtful scene will be in *noisy environment*, such as office or
public area with many APs and users.
The latency would be high and the overall throughput would be only half
or less.

Tested in 2.4G in office area, with this patch the throughput increased
from such as "1x Mbps -> 4x Mbps".

Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/phy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/phy.c b/drivers/net/wireless/realtek/rtw88/phy.c
index 4381b36..7f437e2 100644
--- a/drivers/net/wireless/realtek/rtw88/phy.c
+++ b/drivers/net/wireless/realtek/rtw88/phy.c
@@ -144,10 +144,10 @@ static void rtw_phy_stat_rssi_iter(void *data, struct ieee80211_sta *sta)
 	struct rtw_phy_stat_iter_data *iter_data = data;
 	struct rtw_dev *rtwdev = iter_data->rtwdev;
 	struct rtw_sta_info *si = (struct rtw_sta_info *)sta->drv_priv;
-	u8 rssi, rssi_level;
+	u8 rssi;
 
 	rssi = ewma_rssi_read(&si->avg_rssi);
-	rssi_level = rtw_phy_get_rssi_level(si->rssi_level, rssi);
+	si->rssi_level = rtw_phy_get_rssi_level(si->rssi_level, rssi);
 
 	rtw_fw_send_rssi_info(rtwdev, si);
 
-- 
2.7.4

