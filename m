Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B327432A83
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Oct 2021 01:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233395AbhJRXwr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Oct 2021 19:52:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:35060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233452AbhJRXwn (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Oct 2021 19:52:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 92BDB610C9;
        Mon, 18 Oct 2021 23:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634601031;
        bh=YMFq0DgrKnedKvOU0oWg0iFrHFF1hqJrmAgBziUbGRk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fN9AYYrWZlfW0FGC1/1EGl9aC7ik918Ib0EcSZw5d+pHLJ8MJWTMlYpkugnc7ay1c
         XeoGdh2OE55OBncQVw+xS/DHGCWkPlWfu6u9ywkKEPWbxq8S0A53hwn7TMkZrZTM5+
         zyQHpRLNd2pl9rEh9JIQ/3VPdsjzVXi9FJrFjyvqgIzYycGJNiqrmAc04XrqZralpj
         x8E7mtk908/8QLnjboNtT1UIsZQQy2E+VbEpGq3zHdY0YDePrqsUbRUQ0D79/IfYDx
         R9KDOYIJb1xEF7S/o3nt/HfBDTLzVu3sIO9+r8EPSobXo/HhZVgDwWg34uD2cZo5/8
         SNL8djgE8HCUQ==
From:   Jakub Kicinski <kuba@kernel.org>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 14/15] wireless: wl3501_cs: use eth_hw_addr_set()
Date:   Mon, 18 Oct 2021 16:50:20 -0700
Message-Id: <20211018235021.1279697-15-kuba@kernel.org>
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
 drivers/net/wireless/wl3501_cs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/wl3501_cs.c b/drivers/net/wireless/wl3501_cs.c
index 672f5d5f3f2c..dad38fc04243 100644
--- a/drivers/net/wireless/wl3501_cs.c
+++ b/drivers/net/wireless/wl3501_cs.c
@@ -1945,8 +1945,7 @@ static int wl3501_config(struct pcmcia_device *link)
 		goto failed;
 	}
 
-	for (i = 0; i < 6; i++)
-		dev->dev_addr[i] = ((char *)&this->mac_addr)[i];
+	eth_hw_addr_set(dev, this->mac_addr);
 
 	/* print probe information */
 	printk(KERN_INFO "%s: wl3501 @ 0x%3.3x, IRQ %d, "
-- 
2.31.1

