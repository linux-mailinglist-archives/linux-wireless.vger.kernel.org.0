Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70844212974
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jul 2020 18:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbgGBQaA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Jul 2020 12:30:00 -0400
Received: from muru.com ([72.249.23.125]:60406 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726750AbgGBQ37 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Jul 2020 12:29:59 -0400
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id B77CC80B0;
        Thu,  2 Jul 2020 16:30:51 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Eyal Reizer <eyalr@ti.com>, Guy Mishol <guym@ti.com>,
        linux-wireless@vger.kernel.org, linux-omap@vger.kernel.org
Subject: [PATCH 4/4] wlcore: Remove pointless spinlock
Date:   Thu,  2 Jul 2020 09:29:51 -0700
Message-Id: <20200702162951.45392-5-tony@atomide.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200702162951.45392-1-tony@atomide.com>
References: <20200702162951.45392-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

No need to take a spinlock here for bitops.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/net/wireless/ti/wlcore/main.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wireless/ti/wlcore/main.c b/drivers/net/wireless/ti/wlcore/main.c
--- a/drivers/net/wireless/ti/wlcore/main.c
+++ b/drivers/net/wireless/ti/wlcore/main.c
@@ -700,9 +700,7 @@ static irqreturn_t wlcore_irq(int irq, void *cookie)
 	mutex_unlock(&wl->mutex);
 
 out_handled:
-	spin_lock_irqsave(&wl->wl_lock, flags);
 	clear_bit(WL1271_FLAG_IRQ_RUNNING, &wl->flags);
-	spin_unlock_irqrestore(&wl->wl_lock, flags);
 
 	return IRQ_HANDLED;
 }
-- 
2.27.0
