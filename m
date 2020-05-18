Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 494041D72A1
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2020 10:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbgERIPA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 May 2020 04:15:00 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:36409 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727125AbgERIPA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 May 2020 04:15:00 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 04I8EoIN2005070, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 04I8EoIN2005070
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 18 May 2020 16:14:50 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 18 May 2020 16:14:50 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 18 May 2020 16:14:49 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <pkshih@realtek.com>,
        <kai.heng.feng@canonical.com>
Subject: [PATCH 3/3] rtw88: fix EAPOL 4-way failure by finish IQK earlier
Date:   Mon, 18 May 2020 16:14:44 +0800
Message-ID: <20200518081444.7664-4-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200518081444.7664-1-yhchuang@realtek.com>
References: <20200518081444.7664-1-yhchuang@realtek.com>
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

If we connect to an AP with WPA2 security, the IQK and the
EAPOL 4-way handshake may be failed due to overlap, because
driver does IQK right after assoc success.

For 802.11n devices, they used to do IQK in driver that could
requires more than 100ms to finished. During IQK, any TX/RX
events are paused. So, if the EAPOL 4-way started before IQK
is finished, the 1/4 and 2/4 could be dropped, then the AP
will issue deauth with reason IEEE8021X_FAILED (23).

To resolve this, move IQK routine into managed TX prepare,
which is ieee80211_ops::mgd_prepare_tx() called before the
managed frames (auth/assoc) are sent. This can make sure IQK
is done before connection. While scanning, not to do IQK for
each channel because it would take too long.

For 802.11ac devices, they used to do IQK in firmware, and it
takes less time to finish it, so we do not see EAPOL 4-way
failure on them. But, it is still worth to move the IQK to
mgd_prepare_tx().

Fixes: f5df1a8b4376 ("rtw88: 8723d: Add 8723DE to Kconfig and Makefile")
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/mac80211.c |  3 +--
 drivers/net/wireless/realtek/rtw88/main.c     | 16 ++++++++++++++++
 drivers/net/wireless/realtek/rtw88/main.h     |  3 +++
 3 files changed, 20 insertions(+), 2 deletions(-)

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
index f88a7d2370aa..d561968b67da 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -408,6 +408,22 @@ void rtw_set_channel(struct rtw_dev *rtwdev)
 	}
 
 	rtw_phy_set_tx_power_level(rtwdev, center_chan);
+
+	/* If set channel isn't for scanning, we'll do RF calibration once in
+	 * this channel while mgd_prepare_tx.
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
index e62a4bceac94..98cdec152053 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -1723,6 +1723,8 @@ struct rtw_dev {
 	struct rtw_fw_state wow_fw;
 	struct rtw_wow_param wow;
 
+	bool need_rfk;
+
 	/* hci related data, must be last */
 	u8 priv[] __aligned(sizeof(void *));
 };
@@ -1796,6 +1798,7 @@ void rtw_restore_reg(struct rtw_dev *rtwdev,
 		     struct rtw_backup_info *bckp, u32 num);
 void rtw_desc_to_mcsrate(u16 rate, u8 *mcs, u8 *nss);
 void rtw_set_channel(struct rtw_dev *rtwdev);
+void rtw_chip_prepare_tx(struct rtw_dev *rtwdev);
 void rtw_vif_port_config(struct rtw_dev *rtwdev, struct rtw_vif *rtwvif,
 			 u32 config);
 void rtw_tx_report_purge_timer(struct timer_list *t);
-- 
2.17.1

