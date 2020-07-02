Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 550A6212976
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jul 2020 18:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbgGBQ35 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Jul 2020 12:29:57 -0400
Received: from muru.com ([72.249.23.125]:60388 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbgGBQ35 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Jul 2020 12:29:57 -0400
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 32E1480B0;
        Thu,  2 Jul 2020 16:30:49 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Eyal Reizer <eyalr@ti.com>, Guy Mishol <guym@ti.com>,
        linux-wireless@vger.kernel.org, linux-omap@vger.kernel.org
Subject: [PATCH 1/4] wlcore: Simplify runtime resume ELP path
Date:   Thu,  2 Jul 2020 09:29:48 -0700
Message-Id: <20200702162951.45392-2-tony@atomide.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200702162951.45392-1-tony@atomide.com>
References: <20200702162951.45392-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

We can simplify the runtime resume ELP path by always setting and
clearing the completion in runtime resume. This way we can test for
WL1271_FLAG_IRQ_RUNNING after the resume write to see if we need
completion at all.

And in wlcore_irq(), we need to take spinlock for running the
completion and for the pm_wakeup_event(). Spinlock is not needed
around the bitops flags check for WL1271_FLAG_SUSPENDED so the
spinlocked sections get shorter.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/net/wireless/ti/wlcore/main.c | 43 ++++++++++-----------------
 1 file changed, 15 insertions(+), 28 deletions(-)

diff --git a/drivers/net/wireless/ti/wlcore/main.c b/drivers/net/wireless/ti/wlcore/main.c
--- a/drivers/net/wireless/ti/wlcore/main.c
+++ b/drivers/net/wireless/ti/wlcore/main.c
@@ -649,24 +649,26 @@ static irqreturn_t wlcore_irq(int irq, void *cookie)
 	unsigned long flags;
 	struct wl1271 *wl = cookie;
 
-	/* complete the ELP completion */
-	spin_lock_irqsave(&wl->wl_lock, flags);
 	set_bit(WL1271_FLAG_IRQ_RUNNING, &wl->flags);
-	if (wl->elp_compl) {
-		complete(wl->elp_compl);
-		wl->elp_compl = NULL;
+
+	/* complete the ELP completion */
+	if (test_bit(WL1271_FLAG_IN_ELP, &wl->flags)) {
+		spin_lock_irqsave(&wl->wl_lock, flags);
+		if (wl->elp_compl)
+			complete(wl->elp_compl);
+		spin_unlock_irqrestore(&wl->wl_lock, flags);
 	}
 
 	if (test_bit(WL1271_FLAG_SUSPENDED, &wl->flags)) {
 		/* don't enqueue a work right now. mark it as pending */
 		set_bit(WL1271_FLAG_PENDING_WORK, &wl->flags);
 		wl1271_debug(DEBUG_IRQ, "should not enqueue work");
+		spin_lock_irqsave(&wl->wl_lock, flags);
 		disable_irq_nosync(wl->irq);
 		pm_wakeup_event(wl->dev, 0);
 		spin_unlock_irqrestore(&wl->wl_lock, flags);
 		goto out_handled;
 	}
-	spin_unlock_irqrestore(&wl->wl_lock, flags);
 
 	/* TX might be handled here, avoid redundant work */
 	set_bit(WL1271_FLAG_TX_PENDING, &wl->flags);
@@ -6732,7 +6734,6 @@ static int __maybe_unused wlcore_runtime_resume(struct device *dev)
 	unsigned long flags;
 	int ret;
 	unsigned long start_time = jiffies;
-	bool pending = false;
 	bool recovery = false;
 
 	/* Nothing to do if no ELP mode requested */
@@ -6742,49 +6743,35 @@ static int __maybe_unused wlcore_runtime_resume(struct device *dev)
 	wl1271_debug(DEBUG_PSM, "waking up chip from elp");
 
 	spin_lock_irqsave(&wl->wl_lock, flags);
-	if (test_bit(WL1271_FLAG_IRQ_RUNNING, &wl->flags))
-		pending = true;
-	else
-		wl->elp_compl = &compl;
+	wl->elp_compl = &compl;
 	spin_unlock_irqrestore(&wl->wl_lock, flags);
 
 	ret = wlcore_raw_write32(wl, HW_ACCESS_ELP_CTRL_REG, ELPCTRL_WAKE_UP);
 	if (ret < 0) {
 		recovery = true;
-		goto err;
-	}
-
-	if (!pending) {
+	} else if (!test_bit(WL1271_FLAG_IRQ_RUNNING, &wl->flags)) {
 		ret = wait_for_completion_timeout(&compl,
 			msecs_to_jiffies(WL1271_WAKEUP_TIMEOUT));
 		if (ret == 0) {
 			wl1271_warning("ELP wakeup timeout!");
-
-			/* Return no error for runtime PM for recovery */
-			ret = 0;
 			recovery = true;
-			goto err;
 		}
 	}
 
-	clear_bit(WL1271_FLAG_IN_ELP, &wl->flags);
-
-	wl1271_debug(DEBUG_PSM, "wakeup time: %u ms",
-		     jiffies_to_msecs(jiffies - start_time));
-
-	return 0;
-
-err:
 	spin_lock_irqsave(&wl->wl_lock, flags);
 	wl->elp_compl = NULL;
 	spin_unlock_irqrestore(&wl->wl_lock, flags);
+	clear_bit(WL1271_FLAG_IN_ELP, &wl->flags);
 
 	if (recovery) {
 		set_bit(WL1271_FLAG_INTENDED_FW_RECOVERY, &wl->flags);
 		wl12xx_queue_recovery_work(wl);
+	} else {
+		wl1271_debug(DEBUG_PSM, "wakeup time: %u ms",
+			     jiffies_to_msecs(jiffies - start_time));
 	}
 
-	return ret;
+	return 0;
 }
 
 static const struct dev_pm_ops wlcore_pm_ops = {
-- 
2.27.0
