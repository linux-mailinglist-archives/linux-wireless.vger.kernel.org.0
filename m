Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08349C47D3
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Oct 2019 08:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbfJBGfr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Oct 2019 02:35:47 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:57718 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727176AbfJBGfr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Oct 2019 02:35:47 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x926Zfaw013080, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x926Zfaw013080
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 2 Oct 2019 14:35:41 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Wed, 2 Oct 2019 14:35:41 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: [PATCH 10/14] rtw88: configure TX queue EDCA parameters
Date:   Wed, 2 Oct 2019 14:35:27 +0800
Message-ID: <20191002063531.18135-11-yhchuang@realtek.com>
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

Set CWmax/CWmin, TXOP and AIFS according to ieee80211_tx_queue_params.

Do note that hardware has only one group of EDCA[ac] registers, if more
than one vif are added, the EDCA[ac] registers will contain value of
params of the most recent set by ieee80211_ops::conf_tx().

And AIFS = AIFSN[ac] * slot_time + SIFS, so if use_short_slot is changed,
need to also change AIFS.

Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/mac80211.c | 71 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/main.h     |  8 +++
 drivers/net/wireless/realtek/rtw88/reg.h      |  4 ++
 3 files changed, 83 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/mac80211.c b/drivers/net/wireless/realtek/rtw88/mac80211.c
index cb7436949ff6..d03b0b7a0e70 100644
--- a/drivers/net/wireless/realtek/rtw88/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw88/mac80211.c
@@ -269,6 +269,54 @@ static void rtw_ops_configure_filter(struct ieee80211_hw *hw,
 	mutex_unlock(&rtwdev->mutex);
 }
 
+/* Only have one group of EDCA parameters now */
+static const u32 ac_to_edca_param[IEEE80211_NUM_ACS] = {
+	[IEEE80211_AC_VO] = REG_EDCA_VO_PARAM,
+	[IEEE80211_AC_VI] = REG_EDCA_VI_PARAM,
+	[IEEE80211_AC_BE] = REG_EDCA_BE_PARAM,
+	[IEEE80211_AC_BK] = REG_EDCA_BK_PARAM,
+};
+
+static u8 rtw_aifsn_to_aifs(struct rtw_dev *rtwdev,
+			    struct rtw_vif *rtwvif, u8 aifsn)
+{
+	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif);
+	u8 slot_time;
+	u8 sifs;
+
+	slot_time = vif->bss_conf.use_short_slot ? 9 : 20;
+	sifs = rtwdev->hal.current_band_type == RTW_BAND_5G ? 16 : 10;
+
+	return aifsn * slot_time + sifs;
+}
+
+static void __rtw_conf_tx(struct rtw_dev *rtwdev,
+			  struct rtw_vif *rtwvif, u16 ac)
+{
+	struct ieee80211_tx_queue_params *params = &rtwvif->tx_params[ac];
+	u32 edca_param = ac_to_edca_param[ac];
+	u8 ecw_max, ecw_min;
+	u8 aifs;
+
+	/* 2^ecw - 1 = cw; ecw = log2(cw + 1) */
+	ecw_max = ilog2(params->cw_max + 1);
+	ecw_min = ilog2(params->cw_min + 1);
+	aifs = rtw_aifsn_to_aifs(rtwdev, rtwvif, params->aifs);
+	rtw_write32_mask(rtwdev, edca_param, BIT_MASK_TXOP_LMT, params->txop);
+	rtw_write32_mask(rtwdev, edca_param, BIT_MASK_CWMAX, ecw_max);
+	rtw_write32_mask(rtwdev, edca_param, BIT_MASK_CWMIN, ecw_min);
+	rtw_write32_mask(rtwdev, edca_param, BIT_MASK_AIFS, aifs);
+}
+
+static void rtw_conf_tx(struct rtw_dev *rtwdev,
+			struct rtw_vif *rtwvif)
+{
+	u16 ac;
+
+	for (ac = 0; ac < IEEE80211_NUM_ACS; ac++)
+		__rtw_conf_tx(rtwdev, rtwvif, ac);
+}
+
 static void rtw_ops_bss_info_changed(struct ieee80211_hw *hw,
 				     struct ieee80211_vif *vif,
 				     struct ieee80211_bss_conf *conf,
@@ -320,11 +368,33 @@ static void rtw_ops_bss_info_changed(struct ieee80211_hw *hw,
 	if (changed & BSS_CHANGED_BEACON)
 		rtw_fw_download_rsvd_page(rtwdev, vif);
 
+	if (changed & BSS_CHANGED_ERP_SLOT)
+		rtw_conf_tx(rtwdev, rtwvif);
+
 	rtw_vif_port_config(rtwdev, rtwvif, config);
 
 	mutex_unlock(&rtwdev->mutex);
 }
 
+static int rtw_ops_conf_tx(struct ieee80211_hw *hw,
+			   struct ieee80211_vif *vif, u16 ac,
+			   const struct ieee80211_tx_queue_params *params)
+{
+	struct rtw_dev *rtwdev = hw->priv;
+	struct rtw_vif *rtwvif = (struct rtw_vif *)vif->drv_priv;
+
+	mutex_lock(&rtwdev->mutex);
+
+	rtw_leave_lps_deep(rtwdev);
+
+	rtwvif->tx_params[ac] = *params;
+	__rtw_conf_tx(rtwdev, rtwvif, ac);
+
+	mutex_unlock(&rtwdev->mutex);
+
+	return 0;
+}
+
 static u8 rtw_acquire_macid(struct rtw_dev *rtwdev)
 {
 	unsigned long mac_id;
@@ -612,6 +682,7 @@ const struct ieee80211_ops rtw_ops = {
 	.remove_interface	= rtw_ops_remove_interface,
 	.configure_filter	= rtw_ops_configure_filter,
 	.bss_info_changed	= rtw_ops_bss_info_changed,
+	.conf_tx		= rtw_ops_conf_tx,
 	.sta_add		= rtw_ops_sta_add,
 	.sta_remove		= rtw_ops_sta_remove,
 	.set_key		= rtw_ops_set_key,
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 00d2cf07a176..f3eab96dba86 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -641,6 +641,7 @@ struct rtw_vif {
 	u8 bssid[ETH_ALEN];
 	u8 port;
 	u8 bcn_ctrl;
+	struct ieee80211_tx_queue_params tx_params[IEEE80211_NUM_ACS];
 	const struct rtw_vif_port *conf;
 
 	struct rtw_traffic_stats stats;
@@ -1432,6 +1433,13 @@ static inline struct ieee80211_txq *rtwtxq_to_txq(struct rtw_txq *rtwtxq)
 	return container_of(p, struct ieee80211_txq, drv_priv);
 }
 
+static inline struct ieee80211_vif *rtwvif_to_vif(struct rtw_vif *rtwvif)
+{
+	void *p = rtwvif;
+
+	return container_of(p, struct ieee80211_vif, drv_priv);
+}
+
 void rtw_get_channel_params(struct cfg80211_chan_def *chandef,
 			    struct rtw_channel_params *ch_param);
 bool check_hw_ready(struct rtw_dev *rtwdev, u32 addr, u32 mask, u32 target);
diff --git a/drivers/net/wireless/realtek/rtw88/reg.h b/drivers/net/wireless/realtek/rtw88/reg.h
index 60014077de77..bd04c3fad1ee 100644
--- a/drivers/net/wireless/realtek/rtw88/reg.h
+++ b/drivers/net/wireless/realtek/rtw88/reg.h
@@ -239,6 +239,10 @@
 #define REG_EDCA_VI_PARAM	0x0504
 #define REG_EDCA_BE_PARAM	0x0508
 #define REG_EDCA_BK_PARAM	0x050C
+#define BIT_MASK_TXOP_LMT	GENMASK(26, 16)
+#define BIT_MASK_CWMAX		GENMASK(15, 12)
+#define BIT_MASK_CWMIN		GENMASK(11, 8)
+#define BIT_MASK_AIFS		GENMASK(7, 0)
 #define REG_PIFS		0x0512
 #define REG_SIFS		0x0514
 #define BIT_SHIFT_SIFS_OFDM_CTX	8
-- 
2.17.1

