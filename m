Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0367B7325C8
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jun 2023 05:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232947AbjFPDSj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Jun 2023 23:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241365AbjFPDSB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Jun 2023 23:18:01 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD5F30E6
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jun 2023 20:17:52 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 35G3HN6x8032026, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 35G3HN6x8032026
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 16 Jun 2023 11:17:23 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 16 Jun 2023 11:17:42 +0800
Received: from [127.0.1.1] (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 16 Jun
 2023 11:17:42 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@kernel.org>
CC:     <gary.chang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH] wifi: rtw88: process VO packets without workqueue to avoid PTK rekey failed
Date:   Fri, 16 Jun 2023 11:17:13 +0800
Message-ID: <20230616031713.16769-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Chih-Kang Chang <gary.chang@realtek.com>

In the wpa_supplicant rekey flow, it sends an EAPOL packet 4/4 through
nl80211_tx_control_port() and triggers wake_tx_queue() in the driver.
Then, it sends nl80211_new_key() to configure a new key in mac80211.
However, in wake_tx_queue(), a workqueue is used to process the tx packet,
which might cause the driver to process the EAPOL packet later than
nl80211_new_key(). As a result, the EAPOL 4/4 packet is dropped by mac80211
due to the rekey configuration being finished. The EAPOL packets belongs to
VO packets that need high priority. Therefore, we process VO packets
directly without workqueue to ensure that packets can process immediately.

VO is normally used by voice application that is low traffic load and low
latency, that doesn't affect user experience.
We test iperf with VO packets(iperf3 -P4 -u -b 10000M -S 0xdf)
                          before       after
TX throughput             162M         162M
ping RTT                  3.8ms        3.7ms

Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/mac80211.c |  6 +++++-
 drivers/net/wireless/realtek/rtw88/tx.c       | 10 ++++++++--
 drivers/net/wireless/realtek/rtw88/tx.h       |  1 +
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/mac80211.c b/drivers/net/wireless/realtek/rtw88/mac80211.c
index 09bcc2345bb05..4241027902832 100644
--- a/drivers/net/wireless/realtek/rtw88/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw88/mac80211.c
@@ -43,7 +43,11 @@ static void rtw_ops_wake_tx_queue(struct ieee80211_hw *hw,
 		list_add_tail(&rtwtxq->list, &rtwdev->txqs);
 	spin_unlock_bh(&rtwdev->txq_lock);
 
-	queue_work(rtwdev->tx_wq, &rtwdev->tx_work);
+	/* ensure to dequeue EAPOL (4/4) at the right time */
+	if (txq->ac == IEEE80211_AC_VO)
+		__rtw_tx_work(rtwdev);
+	else
+		queue_work(rtwdev->tx_wq, &rtwdev->tx_work);
 }
 
 static int rtw_ops_start(struct ieee80211_hw *hw)
diff --git a/drivers/net/wireless/realtek/rtw88/tx.c b/drivers/net/wireless/realtek/rtw88/tx.c
index bb5c7492c98b0..b6c97a986a1ac 100644
--- a/drivers/net/wireless/realtek/rtw88/tx.c
+++ b/drivers/net/wireless/realtek/rtw88/tx.c
@@ -635,9 +635,8 @@ static void rtw_txq_push(struct rtw_dev *rtwdev,
 	rcu_read_unlock();
 }
 
-void rtw_tx_work(struct work_struct *w)
+void __rtw_tx_work(struct rtw_dev *rtwdev)
 {
-	struct rtw_dev *rtwdev = container_of(w, struct rtw_dev, tx_work);
 	struct rtw_txq *rtwtxq, *tmp;
 
 	spin_lock_bh(&rtwdev->txq_lock);
@@ -658,6 +657,13 @@ void rtw_tx_work(struct work_struct *w)
 	spin_unlock_bh(&rtwdev->txq_lock);
 }
 
+void rtw_tx_work(struct work_struct *w)
+{
+	struct rtw_dev *rtwdev = container_of(w, struct rtw_dev, tx_work);
+
+	__rtw_tx_work(rtwdev);
+}
+
 void rtw_txq_init(struct rtw_dev *rtwdev, struct ieee80211_txq *txq)
 {
 	struct rtw_txq *rtwtxq;
diff --git a/drivers/net/wireless/realtek/rtw88/tx.h b/drivers/net/wireless/realtek/rtw88/tx.h
index 197d5868c8ad9..544133643a1bb 100644
--- a/drivers/net/wireless/realtek/rtw88/tx.h
+++ b/drivers/net/wireless/realtek/rtw88/tx.h
@@ -111,6 +111,7 @@ void rtw_tx(struct rtw_dev *rtwdev,
 void rtw_txq_init(struct rtw_dev *rtwdev, struct ieee80211_txq *txq);
 void rtw_txq_cleanup(struct rtw_dev *rtwdev, struct ieee80211_txq *txq);
 void rtw_tx_work(struct work_struct *w);
+void __rtw_tx_work(struct rtw_dev *rtwdev);
 void rtw_tx_pkt_info_update(struct rtw_dev *rtwdev,
 			    struct rtw_tx_pkt_info *pkt_info,
 			    struct ieee80211_sta *sta,
-- 
2.25.1

