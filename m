Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0157D432A7B
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Oct 2021 01:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233256AbhJRXwn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Oct 2021 19:52:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:34974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233225AbhJRXwk (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Oct 2021 19:52:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CE06361206;
        Mon, 18 Oct 2021 23:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634601029;
        bh=DBQUeNzVSQKmMw1csFG8/5M8FZQUluIRCnZ5+nd6sjk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vGh89+VH/sifJi2xi7QPAhKGEBz4rhX5Qlc+jx2p5TQvyXK8oqWlt8cPyYoVQfmUT
         veWslQCqCXBb0KmTokxqxeUOFbEHdVc7WIciYjSHQIw0dZc+YyQCNfZTR0Aj3bzodI
         kk7UEPUvSYAU6l5RWseIGr0aMzY6RjmEURPK8PtUrsA9mWCFhxedQj7D+RNFknUTNl
         CLNN97lLXbTWrTJdx5nYBbHuvdPCFUBlaTbDfzlnaxJiYvL8ae2ehecqWH0PI7klDB
         COpyhfom7T1hB9qYgo2oZQEPMOqFuGpLuTS4lYg71bg7HCoyrAGUw+sez2yhSXx2ky
         bderGkGKgypFg==
From:   Jakub Kicinski <kuba@kernel.org>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        simon@thekelleys.org.uk
Subject: [PATCH 06/15] wireless: atmel: use eth_hw_addr_set()
Date:   Mon, 18 Oct 2021 16:50:12 -0700
Message-Id: <20211018235021.1279697-7-kuba@kernel.org>
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

Use a buffer on the stack. Note that atmel_get_mib() is a wrapper
around atmel_copy_to_host(). For the to device direction we just
need to make sure functions respect argument being cost.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: simon@thekelleys.org.uk
CC: kvalo@codeaurora.org
CC: linux-wireless@vger.kernel.org
---
 drivers/net/wireless/atmel/atmel.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/atmel/atmel.c b/drivers/net/wireless/atmel/atmel.c
index 8290cf881a1b..35c2e798d98b 100644
--- a/drivers/net/wireless/atmel/atmel.c
+++ b/drivers/net/wireless/atmel/atmel.c
@@ -600,7 +600,7 @@ static void atmel_set_mib8(struct atmel_private *priv, u8 type, u8 index,
 static void atmel_set_mib16(struct atmel_private *priv, u8 type, u8 index,
 			    u16 data);
 static void atmel_set_mib(struct atmel_private *priv, u8 type, u8 index,
-			  u8 *data, int data_len);
+			  const u8 *data, int data_len);
 static void atmel_get_mib(struct atmel_private *priv, u8 type, u8 index,
 			  u8 *data, int data_len);
 static void atmel_scan(struct atmel_private *priv, int specific_ssid);
@@ -3669,6 +3669,7 @@ static int probe_atmel_card(struct net_device *dev)
 {
 	int rc = 0;
 	struct atmel_private *priv = netdev_priv(dev);
+	u8 addr[ETH_ALEN] = {};
 
 	/* reset pccard */
 	if (priv->bus_type == BUS_TYPE_PCCARD)
@@ -3693,7 +3694,9 @@ static int probe_atmel_card(struct net_device *dev)
 		if (i == 0) {
 			printk(KERN_ALERT "%s: MAC failed to boot MAC address reader.\n", dev->name);
 		} else {
-			atmel_copy_to_host(dev, dev->dev_addr, atmel_read16(dev, MR2), 6);
+
+			atmel_copy_to_host(dev, addr, atmel_read16(dev, MR2), 6);
+			eth_hw_addr_set(dev, addr);
 			/* got address, now squash it again until the network
 			   interface is opened */
 			if (priv->bus_type == BUS_TYPE_PCCARD)
@@ -3705,7 +3708,8 @@ static int probe_atmel_card(struct net_device *dev)
 		/* Mac address easy in this case. */
 		priv->card_type = CARD_TYPE_PARALLEL_FLASH;
 		atmel_write16(dev,  BSR, 1);
-		atmel_copy_to_host(dev, dev->dev_addr, 0xc000, 6);
+		atmel_copy_to_host(dev, addr, 0xc000, 6);
+		eth_hw_addr_set(dev, addr);
 		atmel_write16(dev,  BSR, 0x200);
 		rc = 1;
 	} else {
@@ -3713,7 +3717,8 @@ static int probe_atmel_card(struct net_device *dev)
 		   for the Mac Address */
 		priv->card_type = CARD_TYPE_SPI_FLASH;
 		if (atmel_wakeup_firmware(priv) == 0) {
-			atmel_get_mib(priv, Mac_Address_Mib_Type, 0, dev->dev_addr, 6);
+			atmel_get_mib(priv, Mac_Address_Mib_Type, 0, addr, 6);
+			eth_hw_addr_set(dev, addr);
 
 			/* got address, now squash it again until the network
 			   interface is opened */
@@ -4103,7 +4108,7 @@ static void atmel_set_mib16(struct atmel_private *priv, u8 type, u8 index,
 }
 
 static void atmel_set_mib(struct atmel_private *priv, u8 type, u8 index,
-			  u8 *data, int data_len)
+			  const u8 *data, int data_len)
 {
 	struct get_set_mib m;
 	m.type = type;
-- 
2.31.1

