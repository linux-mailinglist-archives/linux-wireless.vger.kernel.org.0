Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 987714B1F2A
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Feb 2022 08:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244661AbiBKHQN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Feb 2022 02:16:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbiBKHQM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Feb 2022 02:16:12 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9CA10A4
        for <linux-wireless@vger.kernel.org>; Thu, 10 Feb 2022 23:16:10 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 21B7G3zuC011138, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 21B7G3zuC011138
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 11 Feb 2022 15:16:03 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 11 Feb 2022 15:16:03 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Fri, 11 Feb
 2022 15:16:02 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <timlee@realtek.com>,
        <ku920601@realtek.com>
Subject: [PATCH 1/6] rtw88: 8822ce: add support for txrx 1ss mode
Date:   Fri, 11 Feb 2022 15:15:28 +0800
Message-ID: <20220211071533.34716-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220211071533.34716-1-pkshih@realtek.com>
References: <20220211071533.34716-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 02/11/2022 07:03:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzIvMTEgpFekyCAwNjowMDowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Chin-Yen Lee <timlee@realtek.com>

In some case, wifi chip need to be configed to be txrx 1ss mode.
For this mode, wifi components, such as MAC/BB/RF, need to be
specially set, and driver need to send SMPS action frame to inform AP.

Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/debug.c    |  4 ++-
 drivers/net/wireless/realtek/rtw88/main.c     | 33 ++++++++++++++++++-
 drivers/net/wireless/realtek/rtw88/main.h     |  5 ++-
 drivers/net/wireless/realtek/rtw88/rtw8822c.c |  1 +
 drivers/net/wireless/realtek/rtw88/tx.c       |  2 +-
 5 files changed, 41 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/debug.c b/drivers/net/wireless/realtek/rtw88/debug.c
index e429428232c15..03a08137066fe 100644
--- a/drivers/net/wireless/realtek/rtw88/debug.c
+++ b/drivers/net/wireless/realtek/rtw88/debug.c
@@ -715,8 +715,10 @@ static int rtw_debugfs_get_phy_info(struct seq_file *m, void *v)
 	seq_printf(m, "Current CH(fc) = %u\n", rtwdev->hal.current_channel);
 	seq_printf(m, "Current BW = %u\n", rtwdev->hal.current_band_width);
 	seq_printf(m, "Current IGI = 0x%x\n", dm_info->igi_history[0]);
-	seq_printf(m, "TP {Tx, Rx} = {%u, %u}Mbps\n\n",
+	seq_printf(m, "TP {Tx, Rx} = {%u, %u}Mbps\n",
 		   stats->tx_throughput, stats->rx_throughput);
+	seq_printf(m, "1SS for TX and RX = %c\n\n", rtwdev->hal.txrx_1ss ?
+		   'Y' : 'N');
 
 	seq_puts(m, "==========[Tx Phy Info]========\n");
 	seq_puts(m, "[Tx Rate] = ");
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 2757aa0dc586b..41b6db4226380 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -1135,7 +1135,7 @@ void rtw_update_sta_info(struct rtw_dev *rtwdev, struct rtw_sta_info *si)
 			ldpc_en = HT_LDPC_EN;
 	}
 
-	if (efuse->hw_cap.nss == 1)
+	if (efuse->hw_cap.nss == 1 || rtwdev->hal.txrx_1ss)
 		ra_mask &= RA_MASK_VHT_RATES_1SS | RA_MASK_HT_RATES_1SS;
 
 	if (hal->current_band_type == RTW_BAND_5G) {
@@ -1570,6 +1570,37 @@ static void rtw_unset_supported_band(struct ieee80211_hw *hw,
 	kfree(hw->wiphy->bands[NL80211_BAND_5GHZ]);
 }
 
+static void rtw_vif_smps_iter(void *data, u8 *mac,
+			      struct ieee80211_vif *vif)
+{
+	struct rtw_dev *rtwdev = (struct rtw_dev *)data;
+
+	if (vif->type != NL80211_IFTYPE_STATION || !vif->bss_conf.assoc)
+		return;
+
+	if (rtwdev->hal.txrx_1ss)
+		ieee80211_request_smps(vif, IEEE80211_SMPS_STATIC);
+	else
+		ieee80211_request_smps(vif, IEEE80211_SMPS_OFF);
+}
+
+void rtw_set_txrx_1ss(struct rtw_dev *rtwdev, bool txrx_1ss)
+{
+	struct rtw_chip_info *chip = rtwdev->chip;
+	struct rtw_hal *hal = &rtwdev->hal;
+
+	if (!chip->ops->config_txrx_mode || rtwdev->hal.txrx_1ss == txrx_1ss)
+		return;
+
+	rtwdev->hal.txrx_1ss = txrx_1ss;
+	if (txrx_1ss)
+		chip->ops->config_txrx_mode(rtwdev, BB_PATH_A, BB_PATH_A, false);
+	else
+		chip->ops->config_txrx_mode(rtwdev, hal->antenna_tx,
+					    hal->antenna_rx, false);
+	rtw_iterate_vifs_atomic(rtwdev, rtw_vif_smps_iter, rtwdev);
+}
+
 static void __update_firmware_feature(struct rtw_dev *rtwdev,
 				      struct rtw_fw_state *fw)
 {
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 36e1e408933db..970d29d19003d 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -874,6 +874,8 @@ struct rtw_chip_ops {
 			       enum rtw_bb_path tx_path_1ss,
 			       enum rtw_bb_path tx_path_cck,
 			       bool is_tx2_path);
+	void (*config_txrx_mode)(struct rtw_dev *rtwdev, u8 tx_path,
+				 u8 rx_path, bool is_tx2_path);
 
 	/* for coex */
 	void (*coex_set_init)(struct rtw_dev *rtwdev);
@@ -1867,6 +1869,7 @@ struct rtw_hal {
 	u32 antenna_tx;
 	u32 antenna_rx;
 	u8 bfee_sts_cap;
+	bool txrx_1ss;
 
 	/* protect tx power section */
 	struct mutex tx_power_mutex;
@@ -2123,5 +2126,5 @@ void rtw_core_fw_scan_notify(struct rtw_dev *rtwdev, bool start);
 int rtw_dump_fw(struct rtw_dev *rtwdev, const u32 ocp_src, u32 size,
 		u32 fwcd_item);
 int rtw_dump_reg(struct rtw_dev *rtwdev, const u32 addr, const u32 size);
-
+void rtw_set_txrx_1ss(struct rtw_dev *rtwdev, bool config_1ss);
 #endif
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index 35c46e5209de3..01bb356b4b65f 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -4962,6 +4962,7 @@ static struct rtw_chip_ops rtw8822c_ops = {
 	.cfo_init		= rtw8822c_cfo_init,
 	.cfo_track		= rtw8822c_cfo_track,
 	.config_tx_path		= rtw8822c_config_tx_path,
+	.config_txrx_mode	= rtw8822c_config_trx_mode,
 
 	.coex_set_init		= rtw8822c_coex_cfg_init,
 	.coex_set_ant_switch	= NULL,
diff --git a/drivers/net/wireless/realtek/rtw88/tx.c b/drivers/net/wireless/realtek/rtw88/tx.c
index efcc1b0371a8d..94d1089f40220 100644
--- a/drivers/net/wireless/realtek/rtw88/tx.c
+++ b/drivers/net/wireless/realtek/rtw88/tx.c
@@ -353,7 +353,7 @@ static void rtw_tx_data_pkt_info_update(struct rtw_dev *rtwdev,
 
 	bw = si->bw_mode;
 	rate_id = si->rate_id;
-	stbc = si->stbc_en;
+	stbc = rtwdev->hal.txrx_1ss ? false : si->stbc_en;
 	ldpc = si->ldpc_en;
 
 out:
-- 
2.25.1

