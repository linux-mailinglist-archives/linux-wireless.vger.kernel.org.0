Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E83D8432A78
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Oct 2021 01:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233252AbhJRXwl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Oct 2021 19:52:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:34936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232256AbhJRXwj (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Oct 2021 19:52:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E4FF061206;
        Mon, 18 Oct 2021 23:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634601028;
        bh=ukd+R49DUQREErzqLqUOozd0TGISYib4Ep8MxPeGCK8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tmxfz7bndsAIXWpgf/Mr/NQD2VGTxKBNtwDolUo2Sc1xO8+iINTz7KrR7idMPmf79
         rkQ+RoyFfRrvG8jyAsa46v4rhgkkmXhZBm+zQWreUP15BNy4NWf2sKRtoXC8kjl20o
         h8f0vnA4Bm5sWKgFrIcWE1Iap4SZQGBPzfaR83a1SZLU7PtqME9TozOPgaaOm9892C
         P7RnR4+RoObPGBVdW4VE4WKL8Ywdzq0QJaLnO+k6xitW8p/ANF14TAzHKzLJhS+YXa
         4zjbcJ6K+zTJ7cutqdAwQOx47jRrmY88C0iAtGfCmjNf1fGIgVzDo5yweIJdjt9BHP
         zDdPfaFQtGxuw==
From:   Jakub Kicinski <kuba@kernel.org>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 03/15] wireless: use eth_hw_addr_set() for dev->addr_len cases
Date:   Mon, 18 Oct 2021 16:50:09 -0700
Message-Id: <20211018235021.1279697-4-kuba@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211018235021.1279697-1-kuba@kernel.org>
References: <20211018235021.1279697-1-kuba@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Convert all WiFi drivers from memcpy(... dev->addr_len)
to eth_hw_addr_set():

  @@
  expression dev, np;
  @@
  - memcpy(dev->dev_addr, np, dev->addr_len)
  + eth_hw_addr_set(dev, np)

Manually checked the netdevs are allocated with alloc_etherdev(),
so dev->addr_len must be equal to ETH_ALEN.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/wireless/atmel/atmel.c  | 2 +-
 drivers/net/wireless/zydas/zd1201.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/atmel/atmel.c b/drivers/net/wireless/atmel/atmel.c
index 3d782fabbfe6..8290cf881a1b 100644
--- a/drivers/net/wireless/atmel/atmel.c
+++ b/drivers/net/wireless/atmel/atmel.c
@@ -1296,7 +1296,7 @@ static int atmel_set_mac_address(struct net_device *dev, void *p)
 {
 	struct sockaddr *addr = p;
 
-	memcpy (dev->dev_addr, addr->sa_data, dev->addr_len);
+	eth_hw_addr_set(dev, addr->sa_data);
 	return atmel_open(dev);
 }
 
diff --git a/drivers/net/wireless/zydas/zd1201.c b/drivers/net/wireless/zydas/zd1201.c
index 097805b55c59..6b735fee7b18 100644
--- a/drivers/net/wireless/zydas/zd1201.c
+++ b/drivers/net/wireless/zydas/zd1201.c
@@ -857,7 +857,7 @@ static int zd1201_set_mac_address(struct net_device *dev, void *p)
 	    addr->sa_data, dev->addr_len, 1);
 	if (err)
 		return err;
-	memcpy(dev->dev_addr, addr->sa_data, dev->addr_len);
+	eth_hw_addr_set(dev, addr->sa_data);
 
 	return zd1201_mac_reset(zd);
 }
-- 
2.31.1

