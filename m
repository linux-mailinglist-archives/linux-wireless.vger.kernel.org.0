Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7FC3432A84
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Oct 2021 01:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233669AbhJRXws (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Oct 2021 19:52:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:35098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233465AbhJRXwn (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Oct 2021 19:52:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D55EE61263;
        Mon, 18 Oct 2021 23:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634601032;
        bh=FKcDdTU5soWw0lsJvOd/rPFAVLe46GuoH4+QCsmTUD0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LoFGHBPG8xx48ht+av+s5ERVVDE4oJqrhyDAddJgvfzpZN9Z6nSGCQdnqZHUjCsGb
         NTZGJ7DCPgcLjuT5ZCxszHdNv9ev437IfSsMMOj/b6D5544D9vShSVm3ZEeOLiMWkg
         /V5JZ8d6WxyPISJP4eGIXZ3EK77AxSFLNwwCzhFgvnOy5t6DPEQSrRl+3/pVJDJWeJ
         yNZKXbjQSndJ2I3IYtJAuEDF2IQ6jv7sR6WzsU/E9mO0Ex9dh6AZy6LOo9KhkVF3i0
         SwlmVP2aWMISDY0sahfctCgSy5p3rEItIoWrpfTVGdxfS6fgtpUNy7KR3ulElkiScl
         EBamRJ8/fdfig==
From:   Jakub Kicinski <kuba@kernel.org>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 15/15] wireless: zd1201: use eth_hw_addr_set()
Date:   Mon, 18 Oct 2021 16:50:21 -0700
Message-Id: <20211018235021.1279697-16-kuba@kernel.org>
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
 drivers/net/wireless/zydas/zd1201.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/zydas/zd1201.c b/drivers/net/wireless/zydas/zd1201.c
index 6b735fee7b18..e64e4e579518 100644
--- a/drivers/net/wireless/zydas/zd1201.c
+++ b/drivers/net/wireless/zydas/zd1201.c
@@ -507,7 +507,7 @@ static int zd1201_getconfig(struct zd1201 *zd, int rid, void *riddata,
  *		byte	data[12]
  *	total: 16
  */
-static int zd1201_setconfig(struct zd1201 *zd, int rid, void *buf, int len, int wait)
+static int zd1201_setconfig(struct zd1201 *zd, int rid, const void *buf, int len, int wait)
 {
 	int err;
 	unsigned char *request;
@@ -1729,6 +1729,7 @@ static int zd1201_probe(struct usb_interface *interface,
 	int err;
 	short porttype;
 	char buf[IW_ESSID_MAX_SIZE+2];
+	u8 addr[ETH_ALEN];
 
 	usb = interface_to_usbdev(interface);
 
@@ -1779,10 +1780,10 @@ static int zd1201_probe(struct usb_interface *interface,
 	dev->watchdog_timeo = ZD1201_TX_TIMEOUT;
 	strcpy(dev->name, "wlan%d");
 
-	err = zd1201_getconfig(zd, ZD1201_RID_CNFOWNMACADDR, 
-	    dev->dev_addr, dev->addr_len);
+	err = zd1201_getconfig(zd, ZD1201_RID_CNFOWNMACADDR, addr, ETH_ALEN);
 	if (err)
 		goto err_start;
+	eth_hw_addr_set(dev, addr);
 
 	/* Set wildcard essid to match zd->essid */
 	*(__le16 *)buf = cpu_to_le16(0);
-- 
2.31.1

