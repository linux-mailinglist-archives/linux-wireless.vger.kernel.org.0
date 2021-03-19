Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38D203414FD
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Mar 2021 06:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233899AbhCSFna (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Mar 2021 01:43:30 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:39704 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233832AbhCSFnI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Mar 2021 01:43:08 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 12J5h3hE5007687, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmbs04.realtek.com.tw[172.21.6.97])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 12J5h3hE5007687
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 19 Mar 2021 13:43:03 +0800
Received: from localhost (172.21.69.146) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 19 Mar
 2021 13:43:03 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <ku920601@realtek.com>,
        <phhuang@realtek.com>, <shaofu@realtek.com>,
        <steventing@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH 2/7] rtw88: follow the AP basic rates for tx mgmt frame
Date:   Fri, 19 Mar 2021 13:42:13 +0800
Message-ID: <20210319054218.3319-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210319054218.3319-1-pkshih@realtek.com>
References: <20210319054218.3319-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.146]
X-ClientProxiedBy: RTEXMBS03.realtek.com.tw (172.21.6.96) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Shao-Fu Cheng <shaofu@realtek.com>

By default the driver uses the 1M and 6M rate for managemnt frames
in 2G and 5G bands respectively. But when the basic rates is configured
from the mac80211, we need to send the management frames according the
basic rates.

This commit makes the driver use the lowest basic rates to send
the management frames and a debufs entry to enable/disable force to use
the lowest rate 1M/6M for 2.4G/5G bands.

obtain current setting
cat /sys/kernel/debug/ieee80211/phyX/rtw88/basic_rates

force lowest rate:
echo 1 > /sys/kernel/debug/ieee80211/phyX/rtw88/basic_rates

Signed-off-by: Shao-Fu Cheng <shaofu@realtek.com>
Signed-off-by: Yu-Yen Ting <steventing@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/debug.c | 39 ++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/main.h  |  1 +
 drivers/net/wireless/realtek/rtw88/tx.c    | 27 ++++++++++++---
 3 files changed, 62 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/debug.c b/drivers/net/wireless/realtek/rtw88/debug.c
index 4539b673f6fd..067ce361e4fb 100644
--- a/drivers/net/wireless/realtek/rtw88/debug.c
+++ b/drivers/net/wireless/realtek/rtw88/debug.c
@@ -853,6 +853,39 @@ static int rtw_debugfs_get_fw_crash(struct seq_file *m, void *v)
 	return 0;
 }
 
+static ssize_t rtw_debugfs_set_basic_rates(struct file *filp,
+					   const char __user *buffer,
+					   size_t count, loff_t *loff)
+{
+	struct seq_file *seqpriv = (struct seq_file *)filp->private_data;
+	struct rtw_debugfs_priv *debugfs_priv = seqpriv->private;
+	struct rtw_dev *rtwdev = debugfs_priv->rtwdev;
+	bool input;
+	int err;
+
+	err = kstrtobool_from_user(buffer, count, &input);
+	if (err)
+		return err;
+
+	if (input)
+		set_bit(RTW_FLAG_USE_LOWEST_RATE, rtwdev->flags);
+	else
+		clear_bit(RTW_FLAG_USE_LOWEST_RATE, rtwdev->flags);
+
+	return count;
+}
+
+static int rtw_debugfs_get_basic_rates(struct seq_file *m, void *v)
+{
+	struct rtw_debugfs_priv *debugfs_priv = m->private;
+	struct rtw_dev *rtwdev = debugfs_priv->rtwdev;
+
+	seq_printf(m, "use lowest: %d\n",
+		   test_bit(RTW_FLAG_USE_LOWEST_RATE, rtwdev->flags));
+
+	return 0;
+}
+
 #define rtw_debug_impl_mac(page, addr)				\
 static struct rtw_debugfs_priv rtw_debug_priv_mac_ ##page = {	\
 	.cb_read = rtw_debug_get_mac_page,			\
@@ -961,6 +994,11 @@ static struct rtw_debugfs_priv rtw_debug_priv_fw_crash = {
 	.cb_read = rtw_debugfs_get_fw_crash,
 };
 
+static struct rtw_debugfs_priv rtw_debug_priv_basic_rates = {
+	.cb_write = rtw_debugfs_set_basic_rates,
+	.cb_read = rtw_debugfs_get_basic_rates,
+};
+
 #define rtw_debugfs_add_core(name, mode, fopname, parent)		\
 	do {								\
 		rtw_debug_priv_ ##name.rtwdev = rtwdev;			\
@@ -1035,6 +1073,7 @@ void rtw_debugfs_init(struct rtw_dev *rtwdev)
 	rtw_debugfs_add_r(rf_dump);
 	rtw_debugfs_add_r(tx_pwr_tbl);
 	rtw_debugfs_add_rw(fw_crash);
+	rtw_debugfs_add_rw(basic_rates);
 }
 
 #endif /* CONFIG_RTW88_DEBUGFS */
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index d185209ee3cc..e01eb7feed4e 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -362,6 +362,7 @@ enum rtw_flags {
 	RTW_FLAG_BUSY_TRAFFIC,
 	RTW_FLAG_WOWLAN,
 	RTW_FLAG_RESTARTING,
+	RTW_FLAG_USE_LOWEST_RATE,
 
 	NUM_OF_RTW_FLAGS,
 };
diff --git a/drivers/net/wireless/realtek/rtw88/tx.c b/drivers/net/wireless/realtek/rtw88/tx.c
index 0193708fc013..0aeed15736c8 100644
--- a/drivers/net/wireless/realtek/rtw88/tx.c
+++ b/drivers/net/wireless/realtek/rtw88/tx.c
@@ -233,17 +233,34 @@ void rtw_tx_report_handle(struct rtw_dev *rtwdev, struct sk_buff *skb, int src)
 	spin_unlock_irqrestore(&tx_report->q_lock, flags);
 }
 
+static u8 rtw_get_mgmt_rate(struct rtw_dev *rtwdev, struct sk_buff *skb,
+			    u8 lowest_rate, bool ignore_rate)
+{
+	struct ieee80211_tx_info *tx_info = IEEE80211_SKB_CB(skb);
+	struct ieee80211_vif *vif = tx_info->control.vif;
+	bool use_lowest = test_bit(RTW_FLAG_USE_LOWEST_RATE, rtwdev->flags);
+
+	if (!vif || !vif->bss_conf.basic_rates || ignore_rate || use_lowest)
+		return lowest_rate;
+
+	return __ffs(vif->bss_conf.basic_rates) + lowest_rate;
+}
+
 static void rtw_tx_pkt_info_update_rate(struct rtw_dev *rtwdev,
 					struct rtw_tx_pkt_info *pkt_info,
-					struct sk_buff *skb)
+					struct sk_buff *skb,
+					bool ignore_rate)
 {
 	if (rtwdev->hal.current_band_type == RTW_BAND_2G) {
 		pkt_info->rate_id = RTW_RATEID_B_20M;
-		pkt_info->rate = DESC_RATE1M;
+		pkt_info->rate = rtw_get_mgmt_rate(rtwdev, skb, DESC_RATE1M,
+						   ignore_rate);
 	} else {
 		pkt_info->rate_id = RTW_RATEID_G;
-		pkt_info->rate = DESC_RATE6M;
+		pkt_info->rate = rtw_get_mgmt_rate(rtwdev, skb, DESC_RATE6M,
+						   ignore_rate);
 	}
+
 	pkt_info->use_rate = true;
 	pkt_info->dis_rate_fallback = true;
 }
@@ -280,7 +297,7 @@ static void rtw_tx_mgmt_pkt_info_update(struct rtw_dev *rtwdev,
 					struct ieee80211_sta *sta,
 					struct sk_buff *skb)
 {
-	rtw_tx_pkt_info_update_rate(rtwdev, pkt_info, skb);
+	rtw_tx_pkt_info_update_rate(rtwdev, pkt_info, skb, false);
 	pkt_info->dis_qselseq = true;
 	pkt_info->en_hwseq = true;
 	pkt_info->hw_ssn_sel = 0;
@@ -404,7 +421,7 @@ void rtw_tx_rsvd_page_pkt_info_update(struct rtw_dev *rtwdev,
 	if (type != RSVD_BEACON && type != RSVD_DUMMY)
 		pkt_info->qsel = TX_DESC_QSEL_MGMT;
 
-	rtw_tx_pkt_info_update_rate(rtwdev, pkt_info, skb);
+	rtw_tx_pkt_info_update_rate(rtwdev, pkt_info, skb, true);
 
 	bmc = is_broadcast_ether_addr(hdr->addr1) ||
 	      is_multicast_ether_addr(hdr->addr1);
-- 
2.21.0

