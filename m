Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2506AD1486
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2019 18:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731542AbfJIQuJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Oct 2019 12:50:09 -0400
Received: from muru.com ([72.249.23.125]:36234 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730490AbfJIQuJ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Oct 2019 12:50:09 -0400
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 7F5448140;
        Wed,  9 Oct 2019 16:50:42 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Eyal Reizer <eyalr@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>,
        Guy Mishol <guym@ti.com>, linux-wireless@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCHv3] wlcore: clean-up clearing of WL1271_FLAG_IRQ_RUNNING
Date:   Wed,  9 Oct 2019 09:50:06 -0700
Message-Id: <20191009165006.41567-1-tony@atomide.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

We set WL1271_FLAG_IRQ_RUNNING in the beginning of wlcore_irq(), but clear
it before interrupt handling is done in wlcore_irq_locked().

Let's move the clearing to the end of wlcore_irq() where it gets set,
and remove the old comments about hardirq. That's no longer the case as
we're using request_threaded_irq().

Note that the WL1271_FLAG_IRQ_RUNNING should never race between the
interrupt handler and wlcore_runtime_resume() as because of autosuspend
timeout we cannot enter idle between wlcore_irq_locked() and the end of
wlcore_irq().

Cc: Anders Roxell <anders.roxell@linaro.org>
Cc: Eyal Reizer <eyalr@ti.com>
Cc: Guy Mishol <guym@ti.com>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>

Changes since v2:

- Downgraded to clean-up from a fix as the race should never happen

Changes since v1:

- Add locking around clear_bit like we do elsewhere in the driver

---
 drivers/net/wireless/ti/wlcore/main.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ti/wlcore/main.c b/drivers/net/wireless/ti/wlcore/main.c
--- a/drivers/net/wireless/ti/wlcore/main.c
+++ b/drivers/net/wireless/ti/wlcore/main.c
@@ -544,11 +544,6 @@ static int wlcore_irq_locked(struct wl1271 *wl)
 	}
 
 	while (!done && loopcount--) {
-		/*
-		 * In order to avoid a race with the hardirq, clear the flag
-		 * before acknowledging the chip.
-		 */
-		clear_bit(WL1271_FLAG_IRQ_RUNNING, &wl->flags);
 		smp_mb__after_atomic();
 
 		ret = wlcore_fw_status(wl, wl->fw_status);
@@ -668,7 +663,7 @@ static irqreturn_t wlcore_irq(int irq, void *cookie)
 		disable_irq_nosync(wl->irq);
 		pm_wakeup_event(wl->dev, 0);
 		spin_unlock_irqrestore(&wl->wl_lock, flags);
-		return IRQ_HANDLED;
+		goto out_handled;
 	}
 	spin_unlock_irqrestore(&wl->wl_lock, flags);
 
@@ -692,6 +687,11 @@ static irqreturn_t wlcore_irq(int irq, void *cookie)
 
 	mutex_unlock(&wl->mutex);
 
+out_handled:
+	spin_lock_irqsave(&wl->wl_lock, flags);
+	clear_bit(WL1271_FLAG_IRQ_RUNNING, &wl->flags);
+	spin_unlock_irqrestore(&wl->wl_lock, flags);
+
 	return IRQ_HANDLED;
 }
 
-- 
2.23.0
