Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9E41FD720
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jun 2020 23:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbgFQVZP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 17 Jun 2020 17:25:15 -0400
Received: from muru.com ([72.249.23.125]:58168 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726763AbgFQVZP (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 17 Jun 2020 17:25:15 -0400
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 17886801E;
        Wed, 17 Jun 2020 21:26:05 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Eyal Reizer <eyalr@ti.com>, Guy Mishol <guym@ti.com>,
        linux-wireless@vger.kernel.org, linux-omap@vger.kernel.org
Subject: [PATCH 1/4] wlcore: Use spin_trylock in wlcore_irq_locked() for running the queue
Date:   Wed, 17 Jun 2020 14:25:02 -0700
Message-Id: <20200617212505.62519-2-tony@atomide.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200617212505.62519-1-tony@atomide.com>
References: <20200617212505.62519-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

We need the spinlock to check if we need to run the queue. Let's use
spin_trylock instead and always run the queue unless we know there's
nothing to do.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/net/wireless/ti/wlcore/main.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/ti/wlcore/main.c b/drivers/net/wireless/ti/wlcore/main.c
--- a/drivers/net/wireless/ti/wlcore/main.c
+++ b/drivers/net/wireless/ti/wlcore/main.c
@@ -521,6 +521,7 @@ static int wlcore_irq_locked(struct wl1271 *wl)
 	int ret = 0;
 	u32 intr;
 	int loopcount = WL1271_IRQ_MAX_LOOPS;
+	bool run_tx_queue = true;
 	bool done = false;
 	unsigned int defer_count;
 	unsigned long flags;
@@ -586,19 +587,22 @@ static int wlcore_irq_locked(struct wl1271 *wl)
 				goto err_ret;
 
 			/* Check if any tx blocks were freed */
-			spin_lock_irqsave(&wl->wl_lock, flags);
-			if (!test_bit(WL1271_FLAG_FW_TX_BUSY, &wl->flags) &&
-			    wl1271_tx_total_queue_count(wl) > 0) {
-				spin_unlock_irqrestore(&wl->wl_lock, flags);
+			if (!test_bit(WL1271_FLAG_FW_TX_BUSY, &wl->flags)) {
+				if (spin_trylock_irqsave(&wl->wl_lock, flags)) {
+					if (!wl1271_tx_total_queue_count(wl))
+						run_tx_queue = false;
+					spin_unlock_irqrestore(&wl->wl_lock, flags);
+				}
+
 				/*
 				 * In order to avoid starvation of the TX path,
 				 * call the work function directly.
 				 */
-				ret = wlcore_tx_work_locked(wl);
-				if (ret < 0)
-					goto err_ret;
-			} else {
-				spin_unlock_irqrestore(&wl->wl_lock, flags);
+				if (run_tx_queue) {
+					ret = wlcore_tx_work_locked(wl);
+					if (ret < 0)
+						goto err_ret;
+				}
 			}
 
 			/* check for tx results */
-- 
2.27.0
