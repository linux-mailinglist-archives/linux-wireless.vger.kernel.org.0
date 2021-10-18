Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2B74432A82
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Oct 2021 01:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233772AbhJRXwr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Oct 2021 19:52:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:35072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233309AbhJRXwn (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Oct 2021 19:52:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 50C7061250;
        Mon, 18 Oct 2021 23:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634601031;
        bh=dE88fn6owS/u78BUKFz1R0smoxBiZvJ8wnfDQQe5xoc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pL1mN36XvnbzWof7/iie+mTIz8Vho80rcn/+xKY65bdOHdiH+NErxQYc4CU19hFNA
         DFwSO+sZjmn/8MCFtv/xpHxjPMQ3L4nfxKRzS1oNnRbiyIJRJ0qOqbOeqvgK1hfQFR
         W6vJ+883SqCQxxzL6R/6vMdrlHrOiBGCBNujC7gQeF2P6pFpYS5v7aQjMo7oXMBE3q
         Xvs+xR+02eE8HohbIgvStu38WnGH/IxRUkTXLP5J3rKPjM6m4W7y6ssiNVgWYWW202
         x658RLY0qKcku1hacraLlDp6gEFHdS867VFmcvEqW65ZxnFWUKmEpn1o7eOz9Pp70p
         /AnECQiQujzKw==
From:   Jakub Kicinski <kuba@kernel.org>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 13/15] wireless: ray_cs: use eth_hw_addr_set()
Date:   Mon, 18 Oct 2021 16:50:19 -0700
Message-Id: <20211018235021.1279697-14-kuba@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211018235021.1279697-1-kuba@kernel.org>
References: <20211018235021.1279697-1-kuba@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Commit 406f42fa0d3c ("net-next: When a bond have a massive amount
of VLANs...") introduced a rbtree for faster Ethernet address look
up. To maintain netdev->dev_addr in this tree we need to make all
the writes to it got through appropriate helpers.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: kvalo@codeaurora.org
CC: linux-wireless@vger.kernel.org
---
 drivers/net/wireless/ray_cs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ray_cs.c b/drivers/net/wireless/ray_cs.c
index 0f5009c47cd0..e3a3dc3e45b4 100644
--- a/drivers/net/wireless/ray_cs.c
+++ b/drivers/net/wireless/ray_cs.c
@@ -791,7 +791,7 @@ static int ray_dev_init(struct net_device *dev)
 #endif /* RAY_IMMEDIATE_INIT */
 
 	/* copy mac and broadcast addresses to linux device */
-	memcpy(dev->dev_addr, &local->sparm.b4.a_mac_addr, ADDRLEN);
+	eth_hw_addr_set(dev, local->sparm.b4.a_mac_addr);
 	eth_broadcast_addr(dev->broadcast);
 
 	dev_dbg(&link->dev, "ray_dev_init ending\n");
-- 
2.31.1

