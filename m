Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD4E31277FE
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Dec 2019 10:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbfLTJWc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Dec 2019 04:22:32 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:47440 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727391AbfLTJWc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Dec 2019 04:22:32 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID xBK9MPS5025721, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id xBK9MPS5025721
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 20 Dec 2019 17:22:26 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Fri, 20 Dec 2019 17:22:25 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: [PATCH 06/11] rtw88: remove unused spinlock
Date:   Fri, 20 Dec 2019 17:21:51 +0800
Message-ID: <20191220092156.13443-7-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191220092156.13443-1-yhchuang@realtek.com>
References: <20191220092156.13443-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.126]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Tzu-En Huang <tehuang@realtek.com>

dm_lock is never used. Thus, remove this redundant spinlock.

Signed-off-by: Tzu-En Huang <tehuang@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/main.c | 1 -
 drivers/net/wireless/realtek/rtw88/main.h | 3 ---
 2 files changed, 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index cc61c390226c..d6c9cc1806f7 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -1339,7 +1339,6 @@ int rtw_core_init(struct rtw_dev *rtwdev)
 	skb_queue_head_init(&rtwdev->coex.queue);
 	skb_queue_head_init(&rtwdev->tx_report.queue);
 
-	spin_lock_init(&rtwdev->dm_lock);
 	spin_lock_init(&rtwdev->rf_lock);
 	spin_lock_init(&rtwdev->h2c.lock);
 	spin_lock_init(&rtwdev->txq_lock);
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 144fbab38fd5..b2cc7479d49b 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -1544,9 +1544,6 @@ struct rtw_dev {
 	/* ensures exclusive access from mac80211 callbacks */
 	struct mutex mutex;
 
-	/* lock for dm to use */
-	spinlock_t dm_lock;
-
 	/* read/write rf register */
 	spinlock_t rf_lock;
 
-- 
2.17.1

