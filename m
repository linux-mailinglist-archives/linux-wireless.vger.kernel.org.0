Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B28FC47CC
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Oct 2019 08:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbfJBGfm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Oct 2019 02:35:42 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:57687 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbfJBGfl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Oct 2019 02:35:41 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x926ZZQn013046, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x926ZZQn013046
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 2 Oct 2019 14:35:35 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Wed, 2 Oct 2019 14:35:35 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: [PATCH 02/14] rtw88: allows to set RTS in TX descriptor
Date:   Wed, 2 Oct 2019 14:35:19 +0800
Message-ID: <20191002063531.18135-3-yhchuang@realtek.com>
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

Allows driver to send RTS by filling tx descriptor.

The user may want to set the rts threshold. But since we have not
been taking over rate control from mac80211 to driver by setting flag
IEEE80211_HW_HAS_RATE_CONTROL, there is nothing we can do about it.
So here just store the value, and mac80211 will tell us to use rts
protection by ieee80211_tx_info::control::use_rts.

Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/mac80211.c | 12 ++++++++++++
 drivers/net/wireless/realtek/rtw88/main.h     |  2 ++
 drivers/net/wireless/realtek/rtw88/tx.c       |  4 ++++
 drivers/net/wireless/realtek/rtw88/tx.h       |  2 ++
 4 files changed, 20 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/mac80211.c b/drivers/net/wireless/realtek/rtw88/mac80211.c
index 97777c7fdce8..1646f38fd940 100644
--- a/drivers/net/wireless/realtek/rtw88/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw88/mac80211.c
@@ -541,6 +541,17 @@ static void rtw_ops_mgd_prepare_tx(struct ieee80211_hw *hw,
 	mutex_unlock(&rtwdev->mutex);
 }
 
+static int rtw_ops_set_rts_threshold(struct ieee80211_hw *hw, u32 value)
+{
+	struct rtw_dev *rtwdev = hw->priv;
+
+	mutex_lock(&rtwdev->mutex);
+	rtwdev->rts_threshold = value;
+	mutex_unlock(&rtwdev->mutex);
+
+	return 0;
+}
+
 const struct ieee80211_ops rtw_ops = {
 	.tx			= rtw_ops_tx,
 	.start			= rtw_ops_start,
@@ -557,5 +568,6 @@ const struct ieee80211_ops rtw_ops = {
 	.sw_scan_start		= rtw_ops_sw_scan_start,
 	.sw_scan_complete	= rtw_ops_sw_scan_complete,
 	.mgd_prepare_tx		= rtw_ops_mgd_prepare_tx,
+	.set_rts_threshold	= rtw_ops_set_rts_threshold,
 };
 EXPORT_SYMBOL(rtw_ops);
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 161297ad7d99..810bf151ad36 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -484,6 +484,7 @@ struct rtw_tx_pkt_info {
 	bool fs;
 	bool short_gi;
 	bool report;
+	bool rts;
 };
 
 struct rtw_rx_pkt_stat {
@@ -1377,6 +1378,7 @@ struct rtw_dev {
 	struct dentry *debugfs;
 
 	u8 sta_cnt;
+	u32 rts_threshold;
 
 	DECLARE_BITMAP(mac_id_map, RTW_MAX_MAC_ID_NUM);
 	DECLARE_BITMAP(flags, NUM_OF_RTW_FLAGS);
diff --git a/drivers/net/wireless/realtek/rtw88/tx.c b/drivers/net/wireless/realtek/rtw88/tx.c
index 91bfd8c28ff7..25fa932d0208 100644
--- a/drivers/net/wireless/realtek/rtw88/tx.c
+++ b/drivers/net/wireless/realtek/rtw88/tx.c
@@ -56,6 +56,7 @@ void rtw_tx_fill_tx_desc(struct rtw_tx_pkt_info *pkt_info, struct sk_buff *skb)
 	SET_TX_DESC_DATA_SHORT(txdesc, pkt_info->short_gi);
 	SET_TX_DESC_SPE_RPT(txdesc, pkt_info->report);
 	SET_TX_DESC_SW_DEFINE(txdesc, pkt_info->sn);
+	SET_TX_DESC_USE_RTS(txdesc, pkt_info->rts);
 }
 EXPORT_SYMBOL(rtw_tx_fill_tx_desc);
 
@@ -258,6 +259,9 @@ static void rtw_tx_data_pkt_info_update(struct rtw_dev *rtwdev,
 		ampdu_density = get_tx_ampdu_density(sta);
 	}
 
+	if (info->control.use_rts)
+		pkt_info->rts = true;
+
 	if (sta->vht_cap.vht_supported)
 		rate = get_highest_vht_tx_rate(rtwdev, sta);
 	else if (sta->ht_cap.ht_supported)
diff --git a/drivers/net/wireless/realtek/rtw88/tx.h b/drivers/net/wireless/realtek/rtw88/tx.h
index 8338dbf55576..ab5b71f8ac22 100644
--- a/drivers/net/wireless/realtek/rtw88/tx.h
+++ b/drivers/net/wireless/realtek/rtw88/tx.h
@@ -35,6 +35,8 @@
 	le32p_replace_bits((__le32 *)(txdesc) + 0x09, value, GENMASK(23, 12))
 #define SET_TX_DESC_MAX_AGG_NUM(txdesc, value)                                 \
 	le32p_replace_bits((__le32 *)(txdesc) + 0x03, value, GENMASK(21, 17))
+#define SET_TX_DESC_USE_RTS(tx_desc, value)                                    \
+	le32p_replace_bits((__le32 *)(txdesc) + 0x03, value, BIT(12))
 #define SET_TX_DESC_AMPDU_DENSITY(txdesc, value)                               \
 	le32p_replace_bits((__le32 *)(txdesc) + 0x02, value, GENMASK(22, 20))
 #define SET_TX_DESC_DATA_STBC(txdesc, value)                                   \
-- 
2.17.1

