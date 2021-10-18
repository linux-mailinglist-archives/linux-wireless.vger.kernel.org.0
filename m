Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CFA6432A7D
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Oct 2021 01:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233236AbhJRXwo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Oct 2021 19:52:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:35014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229710AbhJRXwl (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Oct 2021 19:52:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AB63161207;
        Mon, 18 Oct 2021 23:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634601029;
        bh=TGdJ3lbDpePudMe8CH/lgolQLsf4z+Ob8jFN/7vgx2c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gWUrAE8TVZUCrMMuPPmWh2fqLN6ccUHXww49zFi5ZZ1Vx2YmYCeISjysrVcG1K7K3
         d+uBRNFYOTbuVRQTSqhDImXs+Jn6+D0yEYRbNUAzF730E2RBp1UhbIANK4XoW66lVu
         MYm7AuGV93iOUynAnLLK+bxeADsSYq4SDuvC2cxUctlfXVRoX/a+1TkPi+X0gKVbhC
         jmBts5BYXHlLoLXXsTFMKw/mjXGlv9e64PzpChRIIDGfWTfTbT6wc8oT9TKd6ZIEOj
         J1X9z3d/oSN8CN0KVbZQzhT3y3vay9CPt9D342xKjRJNmSs2+oLJ9QF2WXi2Hmb9wN
         bdPA4g5htbQDw==
From:   Jakub Kicinski <kuba@kernel.org>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        bigeasy@linutronix.de, arnd@arndb.de
Subject: [PATCH 08/15] wireless: cisco: use eth_hw_addr_set()
Date:   Mon, 18 Oct 2021 16:50:14 -0700
Message-Id: <20211018235021.1279697-9-kuba@kernel.org>
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

Use dev_addr_set() to match the existing logic.
setup_card() is always passed netdev->dev_addr, so pass the netdev
pointer instead and assign the address using a helper there.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: kvalo@codeaurora.org
CC: bigeasy@linutronix.de
CC: arnd@arndb.de
CC: linux-wireless@vger.kernel.org
---
 drivers/net/wireless/cisco/airo.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/cisco/airo.c b/drivers/net/wireless/cisco/airo.c
index 65dd8cff1b01..45594f003ef7 100644
--- a/drivers/net/wireless/cisco/airo.c
+++ b/drivers/net/wireless/cisco/airo.c
@@ -1109,7 +1109,7 @@ struct airo_info;
 static int get_dec_u16(char *buffer, int *start, int limit);
 static void OUT4500(struct airo_info *, u16 reg, u16 value);
 static unsigned short IN4500(struct airo_info *, u16 reg);
-static u16 setup_card(struct airo_info*, u8 *mac, int lock);
+static u16 setup_card(struct airo_info*, struct net_device *dev, int lock);
 static int enable_MAC(struct airo_info *ai, int lock);
 static void disable_MAC(struct airo_info *ai, int lock);
 static void enable_interrupts(struct airo_info*);
@@ -2337,9 +2337,9 @@ static int airo_set_mac_address(struct net_device *dev, void *p)
 	disable_MAC(ai, 1);
 	writeConfigRid (ai, 1);
 	enable_MAC(ai, 1);
-	memcpy (ai->dev->dev_addr, addr->sa_data, dev->addr_len);
+	dev_addr_set(ai->dev, addr->sa_data);
 	if (ai->wifidev)
-		memcpy (ai->wifidev->dev_addr, addr->sa_data, dev->addr_len);
+		dev_addr_set(ai->wifidev, addr->sa_data);
 	return 0;
 }
 
@@ -2854,7 +2854,7 @@ static struct net_device *_init_airo_card(unsigned short irq, int port,
 	}
 
 	if (probe) {
-		if (setup_card(ai, dev->dev_addr, 1) != SUCCESS) {
+		if (setup_card(ai, dev, 1) != SUCCESS) {
 			airo_print_err(dev->name, "MAC could not be enabled");
 			rc = -EIO;
 			goto err_out_map;
@@ -2972,7 +2972,7 @@ int reset_airo_card(struct net_device *dev)
 	if (reset_card (dev, 1))
 		return -1;
 
-	if (setup_card(ai, dev->dev_addr, 1) != SUCCESS) {
+	if (setup_card(ai, dev, 1) != SUCCESS) {
 		airo_print_err(dev->name, "MAC could not be enabled");
 		return -1;
 	}
@@ -3817,7 +3817,8 @@ static inline void set_auth_type(struct airo_info *local, int auth_type)
 		local->last_auth = auth_type;
 }
 
-static int noinline_for_stack airo_readconfig(struct airo_info *ai, u8 *mac, int lock)
+static int noinline_for_stack airo_readconfig(struct airo_info *ai,
+					      struct net_device *dev, int lock)
 {
 	int i, status;
 	/* large variables, so don't inline this function,
@@ -3861,9 +3862,7 @@ static int noinline_for_stack airo_readconfig(struct airo_info *ai, u8 *mac, int
 	}
 
 	/* Save off the MAC */
-	for (i = 0; i < ETH_ALEN; i++) {
-		mac[i] = ai->config.macAddr[i];
-	}
+	eth_hw_addr_set(dev, ai->config.macAddr);
 
 	/* Check to see if there are any insmod configured
 	   rates to add */
@@ -3879,7 +3878,7 @@ static int noinline_for_stack airo_readconfig(struct airo_info *ai, u8 *mac, int
 }
 
 
-static u16 setup_card(struct airo_info *ai, u8 *mac, int lock)
+static u16 setup_card(struct airo_info *ai, struct net_device *dev, int lock)
 {
 	Cmd cmd;
 	Resp rsp;
@@ -3925,7 +3924,7 @@ static u16 setup_card(struct airo_info *ai, u8 *mac, int lock)
 	if (lock)
 		up(&ai->sem);
 	if (ai->config.len == 0) {
-		status = airo_readconfig(ai, mac, lock);
+		status = airo_readconfig(ai, dev, lock);
 		if (status != SUCCESS)
 			return ERROR;
 	}
@@ -5654,7 +5653,7 @@ static int __maybe_unused airo_pci_resume(struct device *dev_d)
 	if (prev_state != PCI_D1) {
 		reset_card(dev, 0);
 		mpi_init_descriptors(ai);
-		setup_card(ai, dev->dev_addr, 0);
+		setup_card(ai, dev, 0);
 		clear_bit(FLAG_RADIO_OFF, &ai->flags);
 		clear_bit(FLAG_PENDING_XMIT, &ai->flags);
 	} else {
@@ -7534,7 +7533,7 @@ static int airo_config_commit(struct net_device *dev,
 
 		readSsidRid(local, &SSID_rid);
 		if (test_bit(FLAG_MPI,&local->flags))
-			setup_card(local, dev->dev_addr, 1);
+			setup_card(local, dev, 1);
 		else
 			reset_airo_card(dev);
 		disable_MAC(local, 1);
@@ -8208,7 +8207,7 @@ static int flashrestart(struct airo_info *ai, struct net_device *dev)
 		if (status != SUCCESS)
 			return status;
 	}
-	status = setup_card(ai, dev->dev_addr, 1);
+	status = setup_card(ai, dev, 1);
 
 	if (!test_bit(FLAG_MPI,&ai->flags))
 		for (i = 0; i < MAX_FIDS; i++) {
-- 
2.31.1

