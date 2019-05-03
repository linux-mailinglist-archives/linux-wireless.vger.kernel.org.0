Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 944CA12CF5
	for <lists+linux-wireless@lfdr.de>; Fri,  3 May 2019 13:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbfECLxr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 May 2019 07:53:47 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:58263 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727695AbfECLxq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 May 2019 07:53:46 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x43Brgj5000728, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtitcasv01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x43Brgj5000728
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=NOT);
        Fri, 3 May 2019 19:53:42 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.408.0; Fri, 3 May 2019 19:53:41 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 4/5] rtw88: fix unassigned rssi_level in rtw_sta_info
Date:   Fri, 3 May 2019 19:53:34 +0800
Message-ID: <1556884415-23474-5-git-send-email-yhchuang@realtek.com>
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

The new rssi_level should be stored in si, otherwise the rssi_level will
never be updated and get a wrong RA mask, which is calculated by the
rssi level

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

