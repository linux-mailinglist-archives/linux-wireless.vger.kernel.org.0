Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEB46C47DB
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Oct 2019 08:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbfJBGfy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Oct 2019 02:35:54 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:57706 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfJBGfo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Oct 2019 02:35:44 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x926Zclk013064, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x926Zclk013064
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 2 Oct 2019 14:35:38 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Wed, 2 Oct 2019 14:35:38 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: [PATCH 06/14] rtw88: add TX-AMSDU support
Date:   Wed, 2 Oct 2019 14:35:23 +0800
Message-ID: <20191002063531.18135-7-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191002063531.18135-1-yhchuang@realtek.com>
References: <20191002063531.18135-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.126]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yan-Hsuan Chuang <yhchuang@realtek.com>

Based on the mac80211's TXQ implementation, TX-AMSDU can
be used to get higher MAC efficiency. To make mac80211
aggregate MSDUs, low level driver just need to leave skbs
in the TXQ, and mac80211 will try to aggregate them if
possible. As driver will schedule a tasklet when the TX
queue is woke, until the tasklet being served, there will
have some skbs in the queue if traffic is heavy.

Driver can control the max AMSDU size depending on the
current bit rate used by hardware/firmware. The higher
rates are used, the larger AMSDU size can be.

It is tested that can achieve higher T-Put at higher rates.
If the environment is relatively clean, and the bit_rate
is high enough, we can get about 80Mbps improvement.

For lower bit rates, not much gain can we get, so leave
the max_amsdu length low to prevent aggregation.

Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/fw.c   | 24 +++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/main.c |  1 +
 2 files changed, 25 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
index 4b41bf531998..51649df7cc98 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.c
+++ b/drivers/net/wireless/realtek/rtw88/fw.c
@@ -29,6 +29,28 @@ static void rtw_fw_c2h_cmd_handle_ext(struct rtw_dev *rtwdev,
 	}
 }
 
+static u16 get_max_amsdu_len(u32 bit_rate)
+{
+	/* lower than ofdm, do not aggregate */
+	if (bit_rate < 550)
+		return 1;
+
+	/* lower than 20M 2ss mcs8, make it small */
+	if (bit_rate < 1800)
+		return 1200;
+
+	/* lower than 40M 2ss mcs9, make it medium */
+	if (bit_rate < 4000)
+		return 2600;
+
+	/* not yet 80M 2ss mcs8/9, make it twice regular packet size */
+	if (bit_rate < 7000)
+		return 3500;
+
+	/* unlimited */
+	return 0;
+}
+
 struct rtw_fw_iter_ra_data {
 	struct rtw_dev *rtwdev;
 	u8 *payload;
@@ -83,6 +105,8 @@ static void rtw_fw_ra_report_iter(void *data, struct ieee80211_sta *sta)
 
 	si->ra_report.desc_rate = rate;
 	si->ra_report.bit_rate = bit_rate;
+
+	sta->max_rc_amsdu_len = get_max_amsdu_len(bit_rate);
 }
 
 static void rtw_fw_ra_report_handle(struct rtw_dev *rtwdev, u8 *payload,
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 690a5c4d64e7..f7044e8bcb5b 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -1310,6 +1310,7 @@ int rtw_register_hw(struct rtw_dev *rtwdev, struct ieee80211_hw *hw)
 	ieee80211_hw_set(hw, SUPPORT_FAST_XMIT);
 	ieee80211_hw_set(hw, SUPPORTS_AMSDU_IN_AMPDU);
 	ieee80211_hw_set(hw, HAS_RATE_CONTROL);
+	ieee80211_hw_set(hw, TX_AMSDU);
 
 	hw->wiphy->interface_modes = BIT(NL80211_IFTYPE_STATION) |
 				     BIT(NL80211_IFTYPE_AP) |
-- 
2.17.1

