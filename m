Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCD56DDB29
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Apr 2023 14:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbjDKMtF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Apr 2023 08:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbjDKMtB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Apr 2023 08:49:01 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD534495
        for <linux-wireless@vger.kernel.org>; Tue, 11 Apr 2023 05:48:58 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 33BCmO8W1030610, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 33BCmO8W1030610
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Tue, 11 Apr 2023 20:48:24 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 11 Apr 2023 20:48:46 +0800
Received: from localhost (172.16.20.144) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 11 Apr
 2023 20:48:45 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <phhuang@realtek.com>, <kevin_yang@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH v6 2/5] wifi: rtw89: add function to wait for completion of TX skbs
Date:   Tue, 11 Apr 2023 20:48:29 +0800
Message-ID: <20230411124832.14965-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230411124832.14965-1-pkshih@realtek.com>
References: <20230411124832.14965-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.20.144]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Po-Hao Huang <phhuang@realtek.com>

Allocate a per-skb completion to track those skbs we are interested in
and wait for them to complete transmission with TX status.

Normally, the completion object is freed by wait side, but it could be
timeout result that complete side should free the object instead. Add a
owner field with a spin_lock to determine which side should free the
object.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v6:
    - use kfree_rcu to free 'wait' object, so don't need spin_lock
      introduced by v5. Then, no lock in TX path.
v5:
    - use owner with spin_lock to determine which side to free completion
      object
    - remove third work that free completion object
v4: add a comment to explain polling
---
 drivers/net/wireless/realtek/rtw89/core.c | 31 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/core.h | 40 +++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/pci.c  |  5 +++
 drivers/net/wireless/realtek/rtw89/pci.h  |  4 +--
 4 files changed, 78 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 3e1d9dd6637dc..aa28204cbcd8f 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -867,6 +867,37 @@ void rtw89_core_tx_kick_off(struct rtw89_dev *rtwdev, u8 qsel)
 	rtw89_hci_tx_kick_off(rtwdev, ch_dma);
 }
 
+int rtw89_core_tx_kick_off_and_wait(struct rtw89_dev *rtwdev, struct sk_buff *skb,
+				    int qsel, unsigned int timeout)
+{
+	struct rtw89_tx_skb_data *skb_data = RTW89_TX_SKB_CB(skb);
+	struct rtw89_tx_wait_info *wait;
+	unsigned long time_left;
+	int ret = 0;
+
+	wait = kzalloc(sizeof(*wait), GFP_KERNEL);
+	if (!wait) {
+		rtw89_core_tx_kick_off(rtwdev, qsel);
+		return 0;
+	}
+
+	init_completion(&wait->completion);
+	rcu_assign_pointer(skb_data->wait, wait);
+
+	rtw89_core_tx_kick_off(rtwdev, qsel);
+	time_left = wait_for_completion_timeout(&wait->completion,
+						msecs_to_jiffies(timeout));
+	if (time_left == 0)
+		ret = -ETIMEDOUT;
+	else if (!wait->tx_done)
+		ret = -EAGAIN;
+
+	rcu_assign_pointer(skb_data->wait, NULL);
+	kfree_rcu(wait, rcu_head);
+
+	return ret;
+}
+
 int rtw89_h2c_tx(struct rtw89_dev *rtwdev,
 		 struct sk_buff *skb, bool fwdl)
 {
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index f81c098a7a89d..d94d263977243 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2623,6 +2623,17 @@ struct rtw89_phy_rate_pattern {
 	bool enable;
 };
 
+struct rtw89_tx_wait_info {
+	struct rcu_head rcu_head;
+	struct completion completion;
+	bool tx_done;
+};
+
+struct rtw89_tx_skb_data {
+	struct rtw89_tx_wait_info __rcu *wait;
+	u8 hci_priv[];
+};
+
 #define RTW89_P2P_MAX_NOA_NUM 2
 
 struct rtw89_vif {
@@ -4179,6 +4190,14 @@ static inline void rtw89_hci_clear(struct rtw89_dev *rtwdev, struct pci_dev *pde
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
@@ -4822,11 +4841,32 @@ static inline struct sk_buff *rtw89_alloc_skb_for_rx(struct rtw89_dev *rtwdev,
 	return dev_alloc_skb(length);
 }
 
+static inline void rtw89_core_tx_wait_complete(struct rtw89_dev *rtwdev,
+					       struct rtw89_tx_skb_data *skb_data,
+					       bool tx_done)
+{
+	struct rtw89_tx_wait_info *wait;
+
+	rcu_read_lock();
+
+	wait = rcu_dereference(skb_data->wait);
+	if (!wait)
+		goto out;
+
+	wait->tx_done = tx_done;
+	complete(&wait->completion);
+
+out:
+	rcu_read_unlock();
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
index 68f0fed6d31e2..fbe4d11ca920a 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -364,8 +364,11 @@ static void rtw89_pci_tx_status(struct rtw89_dev *rtwdev,
 				struct rtw89_pci_tx_ring *tx_ring,
 				struct sk_buff *skb, u8 tx_status)
 {
+	struct rtw89_tx_skb_data *skb_data = RTW89_TX_SKB_CB(skb);
 	struct ieee80211_tx_info *info;
 
+	rtw89_core_tx_wait_complete(rtwdev, skb_data, tx_status == RTW89_TX_DONE);
+
 	info = IEEE80211_SKB_CB(skb);
 	ieee80211_tx_info_clear_status(info);
 
@@ -1203,6 +1206,7 @@ static int rtw89_pci_txwd_submit(struct rtw89_dev *rtwdev,
 	struct pci_dev *pdev = rtwpci->pdev;
 	struct sk_buff *skb = tx_req->skb;
 	struct rtw89_pci_tx_data *tx_data = RTW89_PCI_TX_SKB_CB(skb);
+	struct rtw89_tx_skb_data *skb_data = RTW89_TX_SKB_CB(skb);
 	bool en_wd_info = desc_info->en_wd_info;
 	u32 txwd_len;
 	u32 txwp_len;
@@ -1218,6 +1222,7 @@ static int rtw89_pci_txwd_submit(struct rtw89_dev *rtwdev,
 	}
 
 	tx_data->dma = dma;
+	rcu_assign_pointer(skb_data->wait, NULL);
 
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

