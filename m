Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 696FA6BCF14
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Mar 2023 13:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbjCPMOB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Mar 2023 08:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjCPMNz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Mar 2023 08:13:55 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC7F5A194
        for <linux-wireless@vger.kernel.org>; Thu, 16 Mar 2023 05:13:44 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 32GCDO5o8022859, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 32GCDO5o8022859
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Thu, 16 Mar 2023 20:13:24 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 16 Mar 2023 20:13:14 +0800
Received: from localhost (172.16.16.31) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Thu, 16 Mar
 2023 20:13:14 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <phhuang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 2/5] wifi: rtw89: add function to wait for completion of tx skbs
Date:   Thu, 16 Mar 2023 20:12:03 +0800
Message-ID: <20230316121206.11479-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230316121206.11479-1-pkshih@realtek.com>
References: <20230316121206.11479-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.16.31]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Po-Hao Huang <phhuang@realtek.com>

Allocate a per-skb completion to track those skbs we are interested in
and wait for them to complete transmission with tx status. To avoid
race condition between process and softirq without addtional locking,
we use a work to free the tx_wait struct later when waiter is finished
referencing it. This must be called in process context and with a
timeout value greater than zero since it might sleep.

We use another workqueue so works can be processed concurrently and
when the PCI device is removed unexpectedly, all pending works can be
flushed. This prevents some works that were scheduled but never processed
leads to memory leak.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 58 +++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/core.h | 33 +++++++++++++
 drivers/net/wireless/realtek/rtw89/pci.c  |  6 +++
 drivers/net/wireless/realtek/rtw89/pci.h  |  4 +-
 4 files changed, 99 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 0e32bb58bade3..ea697dd9cb176 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -849,6 +849,60 @@ void rtw89_core_tx_kick_off(struct rtw89_dev *rtwdev, u8 qsel)
 	rtw89_hci_tx_kick_off(rtwdev, ch_dma);
 }
 
+static void rtw89_core_free_tx_wait_work(struct work_struct *work)
+{
+	struct rtw89_tx_wait_info *wait =
+			container_of(work, struct rtw89_tx_wait_info, work);
+	struct rtw89_dev *rtwdev = wait->rtwdev;
+	int done, ret;
+
+	/* Wait rtw89_core_tx_kick_off_and_wait() increase 'wait_done' to
+	 * ensure it doesn't use 'wait' anymore. The polling period is larger
+	 * than execution time between wait_for_completion_timeout() and
+	 * atomic_inc() in rtw89_core_tx_kick_off_and_wait().
+	 */
+	ret = read_poll_timeout(atomic_read, done, done, 1000, 100000, false,
+				&wait->wait_done);
+
+	if (ret)
+		rtw89_err(rtwdev, "tx wait timed out, stop polling\n");
+	else
+		kfree(wait);
+}
+
+int rtw89_core_tx_kick_off_and_wait(struct rtw89_dev *rtwdev, struct sk_buff *skb,
+				    int qsel, unsigned int timeout)
+{
+	struct rtw89_tx_skb_data *skb_data = RTW89_TX_SKB_CB(skb);
+	struct rtw89_tx_wait_info *wait;
+	unsigned long time_left;
+	int ret = 0;
+
+	skb_data->wait = kzalloc(sizeof(*wait), GFP_KERNEL);
+	wait = skb_data->wait;
+	if (!wait) {
+		rtw89_warn(rtwdev, "alloc tx wait info failed\n");
+		rtw89_core_tx_kick_off(rtwdev, qsel);
+		return 0;
+	}
+
+	init_completion(&wait->completion);
+	INIT_WORK(&wait->work, rtw89_core_free_tx_wait_work);
+	wait->rtwdev = rtwdev;
+
+	rtw89_core_tx_kick_off(rtwdev, qsel);
+	time_left = wait_for_completion_timeout(&wait->completion,
+						msecs_to_jiffies(timeout));
+	if (time_left == 0)
+		ret = -ETIMEDOUT;
+	else if (!wait->tx_done)
+		ret = -EAGAIN;
+
+	atomic_inc(&wait->wait_done);
+
+	return ret;
+}
+
 int rtw89_h2c_tx(struct rtw89_dev *rtwdev,
 		 struct sk_buff *skb, bool fwdl)
 {
@@ -3192,6 +3246,9 @@ int rtw89_core_init(struct rtw89_dev *rtwdev)
 	rtwdev->txq_wq = alloc_workqueue("rtw89_tx_wq", WQ_UNBOUND | WQ_HIGHPRI, 0);
 	if (!rtwdev->txq_wq)
 		return -ENOMEM;
+	rtwdev->gc_wq = alloc_workqueue("rtw89_gc_wq", WQ_UNBOUND | WQ_MEM_RECLAIM, 0);
+	if (!rtwdev->gc_wq)
+		return -ENOMEM;
 	spin_lock_init(&rtwdev->ba_lock);
 	spin_lock_init(&rtwdev->rpwm_lock);
 	mutex_init(&rtwdev->mutex);
@@ -3233,6 +3290,7 @@ void rtw89_core_deinit(struct rtw89_dev *rtwdev)
 	rtw89_fw_free_all_early_h2c(rtwdev);
 
 	destroy_workqueue(rtwdev->txq_wq);
+	destroy_workqueue(rtwdev->gc_wq);
 	mutex_destroy(&rtwdev->rf_mutex);
 	mutex_destroy(&rtwdev->mutex);
 }
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 622fd991a1f94..c1d966fc75b7a 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2599,6 +2599,19 @@ struct rtw89_phy_rate_pattern {
 	bool enable;
 };
 
+struct rtw89_tx_wait_info {
+	struct rtw89_dev *rtwdev;
+	struct completion completion;
+	struct work_struct work;
+	atomic_t wait_done;
+	bool tx_done;
+};
+
+struct rtw89_tx_skb_data {
+	struct rtw89_tx_wait_info *wait;
+	u8 hci_priv[];
+};
+
 #define RTW89_P2P_MAX_NOA_NUM 2
 
 struct rtw89_vif {
@@ -3937,6 +3950,7 @@ struct rtw89_dev {
 	/* used to protect rf read write */
 	struct mutex rf_mutex;
 	struct workqueue_struct *txq_wq;
+	struct workqueue_struct *gc_wq;
 	struct work_struct txq_work;
 	struct delayed_work txq_reinvoke_work;
 	/* used to protect ba_list and forbid_ba_list */
@@ -4148,6 +4162,14 @@ static inline void rtw89_hci_clear(struct rtw89_dev *rtwdev, struct pci_dev *pde
 		rtwdev->hci.ops->clear(rtwdev, pdev);
 }
 
+static inline
+struct rtw89_tx_skb_data *RTW89_TX_SKB_CB(struct sk_buff *skb)
+{
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
+
+	return (struct rtw89_tx_skb_data *)info->status.status_driver_data;
+}
+
 static inline u8 rtw89_read8(struct rtw89_dev *rtwdev, u32 addr)
 {
 	return rtwdev->hci.ops->read8(rtwdev, addr);
@@ -4791,11 +4813,22 @@ static inline struct sk_buff *rtw89_alloc_skb_for_rx(struct rtw89_dev *rtwdev,
 	return dev_alloc_skb(length);
 }
 
+static inline void rtw89_core_tx_wait_complete(struct rtw89_dev *rtwdev,
+					       struct rtw89_tx_wait_info *wait,
+					       bool tx_done)
+{
+	wait->tx_done = tx_done;
+	complete(&wait->completion);
+	queue_work(rtwdev->gc_wq, &wait->work);
+}
+
 int rtw89_core_tx_write(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
 			struct ieee80211_sta *sta, struct sk_buff *skb, int *qsel);
 int rtw89_h2c_tx(struct rtw89_dev *rtwdev,
 		 struct sk_buff *skb, bool fwdl);
 void rtw89_core_tx_kick_off(struct rtw89_dev *rtwdev, u8 qsel);
+int rtw89_core_tx_kick_off_and_wait(struct rtw89_dev *rtwdev, struct sk_buff *skb,
+				    int qsel, unsigned int timeout);
 void rtw89_core_fill_txdesc(struct rtw89_dev *rtwdev,
 			    struct rtw89_tx_desc_info *desc_info,
 			    void *txdesc);
diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index ec8bb5f10482e..ca6b63944ee99 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -364,6 +364,8 @@ static void rtw89_pci_tx_status(struct rtw89_dev *rtwdev,
 				struct rtw89_pci_tx_ring *tx_ring,
 				struct sk_buff *skb, u8 tx_status)
 {
+	struct rtw89_tx_skb_data *skb_data = RTW89_TX_SKB_CB(skb);
+	struct rtw89_tx_wait_info *wait = skb_data->wait;
 	struct ieee80211_tx_info *info;
 
 	info = IEEE80211_SKB_CB(skb);
@@ -394,6 +396,8 @@ static void rtw89_pci_tx_status(struct rtw89_dev *rtwdev,
 		}
 	}
 
+	if (wait)
+		rtw89_core_tx_wait_complete(rtwdev, wait, tx_status == RTW89_TX_DONE);
 	ieee80211_tx_status_ni(rtwdev->hw, skb);
 }
 
@@ -1203,6 +1207,7 @@ static int rtw89_pci_txwd_submit(struct rtw89_dev *rtwdev,
 	struct pci_dev *pdev = rtwpci->pdev;
 	struct sk_buff *skb = tx_req->skb;
 	struct rtw89_pci_tx_data *tx_data = RTW89_PCI_TX_SKB_CB(skb);
+	struct rtw89_tx_skb_data *skb_data = RTW89_TX_SKB_CB(skb);
 	bool en_wd_info = desc_info->en_wd_info;
 	u32 txwd_len;
 	u32 txwp_len;
@@ -1218,6 +1223,7 @@ static int rtw89_pci_txwd_submit(struct rtw89_dev *rtwdev,
 	}
 
 	tx_data->dma = dma;
+	skb_data->wait = NULL;
 
 	txwp_len = sizeof(*txwp_info);
 	txwd_len = chip->txwd_body_size;
diff --git a/drivers/net/wireless/realtek/rtw89/pci.h b/drivers/net/wireless/realtek/rtw89/pci.h
index 1e19740db8c54..0e4bd210b100f 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.h
+++ b/drivers/net/wireless/realtek/rtw89/pci.h
@@ -1004,9 +1004,9 @@ rtw89_pci_rxbd_increase(struct rtw89_pci_rx_ring *rx_ring, u32 cnt)
 
 static inline struct rtw89_pci_tx_data *RTW89_PCI_TX_SKB_CB(struct sk_buff *skb)
 {
-	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
+	struct rtw89_tx_skb_data *data = RTW89_TX_SKB_CB(skb);
 
-	return (struct rtw89_pci_tx_data *)info->status.status_driver_data;
+	return (struct rtw89_pci_tx_data *)data->hci_priv;
 }
 
 static inline struct rtw89_pci_tx_bd_32 *
-- 
2.25.1

