Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB75E4951
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2019 13:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503678AbfJYLJE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Oct 2019 07:09:04 -0400
Received: from baptiste.telenet-ops.be ([195.130.132.51]:55418 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503236AbfJYLIs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Oct 2019 07:08:48 -0400
Received: from ramsan ([84.195.182.253])
        by baptiste.telenet-ops.be with bizsmtp
        id Hn8b210045USYZQ01n8b1h; Fri, 25 Oct 2019 13:08:46 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iNxSN-0003rD-1k; Fri, 25 Oct 2019 13:08:35 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iNw6A-0006nA-Oz; Fri, 25 Oct 2019 11:41:34 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        "David S . Miller" <davem@davemloft.net>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-doc@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 7/7] mmc: dw_mmc: Remove superfluous cast in debugfs_create_u32() call
Date:   Fri, 25 Oct 2019 11:41:30 +0200
Message-Id: <20191025094130.26033-8-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191025094130.26033-1-geert+renesas@glider.be>
References: <20191025094130.26033-1-geert+renesas@glider.be>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

"dw_mci.state" is an enum, which is compatible with u32, so there is no
need to cast its address, preventing further compiler checks.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
---
v2:
  - Add Acked-by.
---
 drivers/mmc/host/dw_mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index b4c4a9cd6365f122..fc9d4d000f97e434 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -176,7 +176,7 @@ static void dw_mci_init_debugfs(struct dw_mci_slot *slot)
 
 	debugfs_create_file("regs", S_IRUSR, root, host, &dw_mci_regs_fops);
 	debugfs_create_file("req", S_IRUSR, root, slot, &dw_mci_req_fops);
-	debugfs_create_u32("state", S_IRUSR, root, (u32 *)&host->state);
+	debugfs_create_u32("state", S_IRUSR, root, &host->state);
 	debugfs_create_xul("pending_events", S_IRUSR, root,
 			   &host->pending_events);
 	debugfs_create_xul("completed_events", S_IRUSR, root,
-- 
2.17.1

