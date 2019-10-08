Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4337CF4E4
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2019 10:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730600AbfJHIVN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Oct 2019 04:21:13 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:47343 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730554AbfJHIVN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Oct 2019 04:21:13 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x988L7Os028137, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x988L7Os028137
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 8 Oct 2019 16:21:07 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Tue, 8 Oct 2019 16:21:07 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: [PATCH 04/10] rtw88: add set_bitrate_mask support
Date:   Tue, 8 Oct 2019 16:20:55 +0800
Message-ID: <20191008082101.2494-5-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191008082101.2494-1-yhchuang@realtek.com>
References: <20191008082101.2494-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.126]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Tzu-En Huang <tehuang@realtek.com>

Support setting bit rate from upper layer.
After configuring the original rate control result in the driver, the
result is then masked by the bit rate mask received from the ops
set_bitrate_mask. Lastly, the masked result will be sent to firmware.

Signed-off-by: Tzu-En Huang <tehuang@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/mac80211.c | 53 ++++++++++++++
 drivers/net/wireless/realtek/rtw88/main.c     | 73 +++++++++++++++----
 drivers/net/wireless/realtek/rtw88/main.h     |  3 +
 3 files changed, 113 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/mac80211.c b/drivers/net/wireless/realtek/rtw88/mac80211.c
index 5dc50ff956bf..3e4f2f27ced2 100644
--- a/drivers/net/wireless/realtek/rtw88/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw88/mac80211.c
@@ -475,6 +475,8 @@ static int rtw_ops_sta_remove(struct ieee80211_hw *hw,
 	for (i = 0; i < ARRAY_SIZE(sta->txq); i++)
 		rtw_txq_cleanup(rtwdev, sta->txq[i]);
 
+	kfree(si->mask);
+
 	rtwdev->sta_cnt--;
 
 	rtw_info(rtwdev, "sta %pM with macid %d left\n",
@@ -683,6 +685,56 @@ static void rtw_ops_flush(struct ieee80211_hw *hw,
 	mutex_unlock(&rtwdev->mutex);
 }
 
+struct rtw_iter_bitrate_mask_data {
+	struct rtw_dev *rtwdev;
+	struct ieee80211_vif *vif;
+	const struct cfg80211_bitrate_mask *mask;
+};
+
+static void rtw_ra_mask_info_update_iter(void *data, struct ieee80211_sta *sta)
+{
+	struct rtw_iter_bitrate_mask_data *br_data = data;
+	struct rtw_sta_info *si = (struct rtw_sta_info *)sta->drv_priv;
+
+	if (si->vif != br_data->vif)
+		return;
+
+	/* free previous mask setting */
+	kfree(si->mask);
+	si->mask = kmemdup(br_data->mask, sizeof(struct cfg80211_bitrate_mask),
+			   GFP_ATOMIC);
+	if (!si->mask) {
+		si->use_cfg_mask = false;
+		return;
+	}
+
+	si->use_cfg_mask = true;
+	rtw_update_sta_info(br_data->rtwdev, si);
+}
+
+static void rtw_ra_mask_info_update(struct rtw_dev *rtwdev,
+				    struct ieee80211_vif *vif,
+				    const struct cfg80211_bitrate_mask *mask)
+{
+	struct rtw_iter_bitrate_mask_data br_data;
+
+	br_data.rtwdev = rtwdev;
+	br_data.vif = vif;
+	br_data.mask = mask;
+	rtw_iterate_stas_atomic(rtwdev, rtw_ra_mask_info_update_iter, &br_data);
+}
+
+static int rtw_ops_set_bitrate_mask(struct ieee80211_hw *hw,
+				    struct ieee80211_vif *vif,
+				    const struct cfg80211_bitrate_mask *mask)
+{
+	struct rtw_dev *rtwdev = hw->priv;
+
+	rtw_ra_mask_info_update(rtwdev, vif, mask);
+
+	return 0;
+}
+
 const struct ieee80211_ops rtw_ops = {
 	.tx			= rtw_ops_tx,
 	.wake_tx_queue		= rtw_ops_wake_tx_queue,
@@ -704,5 +756,6 @@ const struct ieee80211_ops rtw_ops = {
 	.set_rts_threshold	= rtw_ops_set_rts_threshold,
 	.sta_statistics		= rtw_ops_sta_statistics,
 	.flush			= rtw_ops_flush,
+	.set_bitrate_mask	= rtw_ops_set_bitrate_mask,
 };
 EXPORT_SYMBOL(rtw_ops);
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 683c23823513..570b2e358be4 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -612,12 +612,66 @@ static u8 get_rate_id(u8 wireless_set, enum rtw_bandwidth bw_mode, u8 tx_num)
 #define RA_MASK_OFDM_IN_HT_2G	0x00010
 #define RA_MASK_OFDM_IN_HT_5G	0x00030
 
+static u64 rtw_update_rate_mask(struct rtw_dev *rtwdev,
+				struct rtw_sta_info *si,
+				u64 ra_mask, bool is_vht_enable,
+				u8 wireless_set)
+{
+	struct rtw_hal *hal = &rtwdev->hal;
+	const struct cfg80211_bitrate_mask *mask = si->mask;
+	u64 cfg_mask = GENMASK(63, 0);
+	u8 rssi_level, band;
+
+	if (wireless_set != WIRELESS_CCK) {
+		rssi_level = si->rssi_level;
+		if (rssi_level == 0)
+			ra_mask &= 0xffffffffffffffffULL;
+		else if (rssi_level == 1)
+			ra_mask &= 0xfffffffffffffff0ULL;
+		else if (rssi_level == 2)
+			ra_mask &= 0xffffffffffffefe0ULL;
+		else if (rssi_level == 3)
+			ra_mask &= 0xffffffffffffcfc0ULL;
+		else if (rssi_level == 4)
+			ra_mask &= 0xffffffffffff8f80ULL;
+		else if (rssi_level >= 5)
+			ra_mask &= 0xffffffffffff0f00ULL;
+	}
+
+	if (!si->use_cfg_mask)
+		return ra_mask;
+
+	band = hal->current_band_type;
+	if (band == RTW_BAND_2G) {
+		band = NL80211_BAND_2GHZ;
+		cfg_mask = mask->control[band].legacy;
+	} else if (band == RTW_BAND_5G) {
+		band = NL80211_BAND_5GHZ;
+		cfg_mask = mask->control[band].legacy << 4;
+	}
+
+	if (!is_vht_enable) {
+		if (ra_mask & RA_MASK_HT_RATES_1SS)
+			cfg_mask |= mask->control[band].ht_mcs[0] << 12;
+		if (ra_mask & RA_MASK_HT_RATES_2SS)
+			cfg_mask |= mask->control[band].ht_mcs[1] << 20;
+	} else {
+		if (ra_mask & RA_MASK_VHT_RATES_1SS)
+			cfg_mask |= mask->control[band].vht_mcs[0] << 12;
+		if (ra_mask & RA_MASK_VHT_RATES_2SS)
+			cfg_mask |= mask->control[band].vht_mcs[1] << 22;
+	}
+
+	ra_mask &= cfg_mask;
+
+	return ra_mask;
+}
+
 void rtw_update_sta_info(struct rtw_dev *rtwdev, struct rtw_sta_info *si)
 {
 	struct ieee80211_sta *sta = si->sta;
 	struct rtw_efuse *efuse = &rtwdev->efuse;
 	struct rtw_hal *hal = &rtwdev->hal;
-	u8 rssi_level;
 	u8 wireless_set;
 	u8 bw_mode;
 	u8 rate_id;
@@ -710,21 +764,8 @@ void rtw_update_sta_info(struct rtw_dev *rtwdev, struct rtw_sta_info *si)
 
 	rate_id = get_rate_id(wireless_set, bw_mode, tx_num);
 
-	if (wireless_set != WIRELESS_CCK) {
-		rssi_level = si->rssi_level;
-		if (rssi_level == 0)
-			ra_mask &= 0xffffffffffffffffULL;
-		else if (rssi_level == 1)
-			ra_mask &= 0xfffffffffffffff0ULL;
-		else if (rssi_level == 2)
-			ra_mask &= 0xffffffffffffefe0ULL;
-		else if (rssi_level == 3)
-			ra_mask &= 0xffffffffffffcfc0ULL;
-		else if (rssi_level == 4)
-			ra_mask &= 0xffffffffffff8f80ULL;
-		else if (rssi_level >= 5)
-			ra_mask &= 0xffffffffffff0f00ULL;
-	}
+	ra_mask = rtw_update_rate_mask(rtwdev, si, ra_mask, is_vht_enable,
+				       wireless_set);
 
 	si->bw_mode = bw_mode;
 	si->stbc_en = stbc_en;
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 2834c1eaeb91..cb6336b28f12 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -632,6 +632,9 @@ struct rtw_sta_info {
 	DECLARE_BITMAP(tid_ba, IEEE80211_NUM_TIDS);
 
 	struct rtw_ra_report ra_report;
+
+	bool use_cfg_mask;
+	struct cfg80211_bitrate_mask *mask;
 };
 
 enum rtw_bfee_role {
-- 
2.17.1

