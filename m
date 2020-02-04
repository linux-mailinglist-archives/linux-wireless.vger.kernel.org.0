Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49D86151A4E
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2020 13:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbgBDMG0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 4 Feb 2020 07:06:26 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:58495 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727148AbgBDMGZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 4 Feb 2020 07:06:25 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID 014C6GfC018985, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTEXMB06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id 014C6GfC018985
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 4 Feb 2020 20:06:16 +0800
Received: from RTEXMB01.realtek.com.tw (172.21.6.94) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 4 Feb 2020 20:06:16 +0800
Received: from RTEXMB06.realtek.com.tw (172.21.6.99) by
 RTEXMB01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 4 Feb 2020 20:06:16 +0800
Received: from RTITCASV01.realtek.com.tw (172.21.6.18) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.1.1779.2
 via Frontend Transport; Tue, 4 Feb 2020 20:06:16 +0800
Received: from localhost.localdomain (172.21.69.117) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Tue, 4 Feb 2020 20:06:16 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: [PATCH] rtw88: disable TX-AMSDU on 2.4G band
Date:   Tue, 4 Feb 2020 20:06:14 +0800
Message-ID: <20200204120614.28861-1-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.69.117]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yan-Hsuan Chuang <yhchuang@realtek.com>

Some tests shows that using AMSDU to aggregate TCP ACKs to specific
APs will degrade the throughput on 2.4G band in 20MHz bandwidth
(< 10 Mbps, should be ~100 Mbps for 2x2). Also found that there's
barely no negative impact if we disable TX AMSDU on 2.4G to connect
to other APs. So it seems like we can just tell mac80211 to not to
aggregate MSDUs when transmitting on 2.4G band.

Note that we still can TX AMSDU on 5G band and benefit from it by
having 50 ~ 70 Mbps throughput improvement.

Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/mac80211.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/mac80211.c b/drivers/net/wireless/realtek/rtw88/mac80211.c
index 6fc33e11d08c..21b56db16916 100644
--- a/drivers/net/wireless/realtek/rtw88/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw88/mac80211.c
@@ -592,6 +592,20 @@ static int rtw_ops_ampdu_action(struct ieee80211_hw *hw,
 	return 0;
 }
 
+static bool rtw_ops_can_aggregate_in_amsdu(struct ieee80211_hw *hw,
+					   struct sk_buff *head,
+					   struct sk_buff *skb)
+{
+	struct rtw_dev *rtwdev = hw->priv;
+	struct rtw_hal *hal = &rtwdev->hal;
+
+	/* we don't want to enable TX AMSDU on 2.4G */
+	if (hal->current_band_type == RTW_BAND_2G)
+		return false;
+
+	return true;
+}
+
 static void rtw_ops_sw_scan_start(struct ieee80211_hw *hw,
 				  struct ieee80211_vif *vif,
 				  const u8 *mac_addr)
@@ -787,6 +801,7 @@ const struct ieee80211_ops rtw_ops = {
 	.sta_remove		= rtw_ops_sta_remove,
 	.set_key		= rtw_ops_set_key,
 	.ampdu_action		= rtw_ops_ampdu_action,
+	.can_aggregate_in_amsdu	= rtw_ops_can_aggregate_in_amsdu,
 	.sw_scan_start		= rtw_ops_sw_scan_start,
 	.sw_scan_complete	= rtw_ops_sw_scan_complete,
 	.mgd_prepare_tx		= rtw_ops_mgd_prepare_tx,
-- 
2.17.1

