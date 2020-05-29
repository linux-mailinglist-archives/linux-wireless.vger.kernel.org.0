Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAE731E72CE
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2020 04:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407052AbgE2Cuf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 May 2020 22:50:35 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:35077 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405447AbgE2Cud (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 May 2020 22:50:33 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 04T2oGhvD031991, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 04T2oGhvD031991
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 29 May 2020 10:50:16 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 29 May 2020 10:50:16 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 29 May 2020 10:50:16 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <pkshih@realtek.com>,
        <kai.heng.feng@canonical.com>, <bigeasy@linutronix.de>,
        <vicamo.yang@canonical.com>
Subject: [PATCH v2 3/3] rtw88: fix EAPOL 4-way failure by finish IQK earlier
Date:   Fri, 29 May 2020 10:50:09 +0800
Message-ID: <20200529025009.2468-4-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200529025009.2468-1-yhchuang@realtek.com>
References: <20200529025009.2468-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.128]
X-ClientProxiedBy: RTEXMB03.realtek.com.tw (172.21.6.96) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ping-Ke Shih <pkshih@realtek.com>

Connecting to an AP with WPA2 security may fail. The IQK
and the EAPOL 4-way handshake may overlap because the
driver does IQK right after assoc success.

For 802.11n devices, the IQK is done in the driver and it
could require more than 100ms to complete. During IQK, any
TX/RX events are paused. So if the EAPOL 4-way handshake
started before IQK finished, then the 1/4 and 2/4 part of
the handshake could be dropped. The AP will then issue
deauth with reason IEEE8021X_FAILED (23).

To resolve this, move IQK routine into managed TX prepare
(ieee80211_ops::mgd_prepare_tx()). The callback is called
before the managed frames (auth/assoc) are sent. This will
make sure that the IQK is completed before the handshake
starts. But don't do IQK during scanning because doing it
on each channel will take too long.

For 802.11ac devices, the IQK is done in firmware and it
takes less time to complete. Therefore we don't see a
failure during the EAPOL 4-way handshake. But it is still
worth moving the IQK into ieee80211_ops::mgd_prepare_tx().

Fixes: f5df1a8b4376 ("rtw88: 8723d: Add 8723DE to Kconfig and Makefile")
Tested-by: You-Sheng Yang <vicamo.yang@canonical.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/mac80211.c |  3 +--
 drivers/net/wireless/realtek/rtw88/main.c     | 17 +++++++++++++++++
 drivers/net/wireless/realtek/rtw88/main.h     |  3 +++
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/mac80211.c b/drivers/net/wireless/realtek/rtw88/mac80211.c
index 98d2ac22f6f6..c412bc54efde 100644
--- a/drivers/net/wireless/realtek/rtw88/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw88/mac80211.c
@@ -341,13 +341,11 @@ static void rtw_ops_bss_info_changed(struct ieee80211_hw *hw,
 	rtw_leave_lps_deep(rtwdev);
 
 	if (changed & BSS_CHANGED_ASSOC) {
-		struct rtw_chip_info *chip = rtwdev->chip;
 		enum rtw_net_type net_type;
 
 		if (conf->assoc) {
 			rtw_coex_connect_notify(rtwdev, COEX_ASSOCIATE_FINISH);
 			net_type = RTW_NET_MGD_LINKED;
-			chip->ops->phy_calibration(rtwdev);
 
 			rtwvif->aid = conf->aid;
 			rtw_fw_download_rsvd_page(rtwdev);
@@ -663,6 +661,7 @@ static void rtw_ops_mgd_prepare_tx(struct ieee80211_hw *hw,
 	mutex_lock(&rtwdev->mutex);
 	rtw_leave_lps_deep(rtwdev);
 	rtw_coex_connect_notify(rtwdev, COEX_ASSOCIATE_START);
+	rtw_chip_prepare_tx(rtwdev);
 	mutex_unlock(&rtwdev->mutex);
 }
 
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index f88a7d2370aa..0eefafc51c62 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -408,6 +408,23 @@ void rtw_set_channel(struct rtw_dev *rtwdev)
 	}
 
 	rtw_phy_set_tx_power_level(rtwdev, center_chan);
+
+	/* if the channel isn't set for scanning, we will do RF calibration
+	 * in ieee80211_ops::mgd_prepare_tx(). Performing the calibration
+	 * during scanning on each channel takes too long.
+	 */
+	if (!test_bit(RTW_FLAG_SCANNING, rtwdev->flags))
+		rtwdev->need_rfk = true;
+}
+
+void rtw_chip_prepare_tx(struct rtw_dev *rtwdev)
+{
+	struct rtw_chip_info *chip = rtwdev->chip;
+
+	if (rtwdev->need_rfk) {
+		rtwdev->need_rfk = false;
+		chip->ops->phy_calibration(rtwdev);
+	}
 }
 
 static void rtw_vif_write_addr(struct rtw_dev *rtwdev, u32 start, u8 *addr)
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 2ae424869f8b..0841f5fa4bf2 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -1720,6 +1720,8 @@ struct rtw_dev {
 	struct rtw_fw_state wow_fw;
 	struct rtw_wow_param wow;
 
+	bool need_rfk;
+
 	/* hci related data, must be last */
 	u8 priv[] __aligned(sizeof(void *));
 };
@@ -1793,6 +1795,7 @@ void rtw_restore_reg(struct rtw_dev *rtwdev,
 		     struct rtw_backup_info *bckp, u32 num);
 void rtw_desc_to_mcsrate(u16 rate, u8 *mcs, u8 *nss);
 void rtw_set_channel(struct rtw_dev *rtwdev);
+void rtw_chip_prepare_tx(struct rtw_dev *rtwdev);
 void rtw_vif_port_config(struct rtw_dev *rtwdev, struct rtw_vif *rtwvif,
 			 u32 config);
 void rtw_tx_report_purge_timer(struct timer_list *t);
-- 
2.17.1

