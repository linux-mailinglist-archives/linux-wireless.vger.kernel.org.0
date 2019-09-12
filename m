Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FEA5B08F1
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Sep 2019 08:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfILGjm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Sep 2019 02:39:42 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:41621 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbfILGjl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Sep 2019 02:39:41 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x8C6dNkE009949, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x8C6dNkE009949
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 12 Sep 2019 14:39:23 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Thu, 12 Sep 2019 14:39:23 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: [PATCH 2/2] rtw88: report RX power for each antenna
Date:   Thu, 12 Sep 2019 14:39:15 +0800
Message-ID: <1568270355-29727-3-git-send-email-yhchuang@realtek.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1568270355-29727-1-git-send-email-yhchuang@realtek.com>
References: <1568270355-29727-1-git-send-email-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.126]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yan-Hsuan Chuang <yhchuang@realtek.com>

Report chains and chain_signal in ieee80211_rx_status.
It is useful for program such as tcpdump to see if the
antennas are well connected/placed.

8822C is able to receive CCK rates with 2 antennas, while
8822B can only use 1 antenna path to receive CCK rates.

Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/rtw8822b.c | 1 +
 drivers/net/wireless/realtek/rtw88/rtw8822c.c | 6 +++---
 drivers/net/wireless/realtek/rtw88/rx.c       | 5 +++++
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822b.c b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
index 568033a..0861195 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
@@ -766,6 +766,7 @@ static void query_phy_status_page0(struct rtw_dev *rtwdev, u8 *phy_status,
 	s8 min_rx_power = -120;
 	u8 pwdb = GET_PHY_STAT_P0_PWDB(phy_status);
 
+	/* 8822B uses only 1 antenna to RX CCK rates */
 	pkt_stat->rx_power[RF_PATH_A] = pwdb - 110;
 	pkt_stat->rssi = rtw_phy_rf_power_2_rssi(pkt_stat->rx_power, 1);
 	pkt_stat->bw = RTW_CHANNEL_WIDTH_20;
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index 24b27bc..75c77ac 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -1627,9 +1627,9 @@ static void query_phy_status_page0(struct rtw_dev *rtwdev, u8 *phy_status,
 	rx_power[RF_PATH_A] -= 110;
 	rx_power[RF_PATH_B] -= 110;
 
-	pkt_stat->rx_power[RF_PATH_A] = max3(rx_power[RF_PATH_A],
-					     rx_power[RF_PATH_B],
-					     min_rx_power);
+	pkt_stat->rx_power[RF_PATH_A] = rx_power[RF_PATH_A];
+	pkt_stat->rx_power[RF_PATH_B] = rx_power[RF_PATH_B];
+
 	pkt_stat->rssi = rtw_phy_rf_power_2_rssi(pkt_stat->rx_power, 1);
 	pkt_stat->bw = RTW_CHANNEL_WIDTH_20;
 	pkt_stat->signal_power = max(pkt_stat->rx_power[RF_PATH_A],
diff --git a/drivers/net/wireless/realtek/rtw88/rx.c b/drivers/net/wireless/realtek/rtw88/rx.c
index 4d837f0..48b9ed4 100644
--- a/drivers/net/wireless/realtek/rtw88/rx.c
+++ b/drivers/net/wireless/realtek/rtw88/rx.c
@@ -90,6 +90,7 @@ void rtw_rx_fill_rx_status(struct rtw_dev *rtwdev,
 			   u8 *phy_status)
 {
 	struct ieee80211_hw *hw = rtwdev->hw;
+	u8 path;
 
 	memset(rx_status, 0, sizeof(*rx_status));
 	rx_status->freq = hw->conf.chandef.chan->center_freq;
@@ -146,6 +147,10 @@ void rtw_rx_fill_rx_status(struct rtw_dev *rtwdev,
 		rx_status->bw = RATE_INFO_BW_20;
 
 	rx_status->signal = pkt_stat->signal_power;
+	for (path = 0; path < rtwdev->hal.rf_path_num; path++) {
+		rx_status->chains |= BIT(path);
+		rx_status->chain_signal[path] = pkt_stat->rx_power[path];
+	}
 
 	rtw_rx_addr_match(rtwdev, pkt_stat, hdr);
 }
-- 
2.7.4

