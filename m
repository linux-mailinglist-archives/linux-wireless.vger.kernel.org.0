Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08655432A7F
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Oct 2021 01:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233660AbhJRXwp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Oct 2021 19:52:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:35046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233343AbhJRXwm (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Oct 2021 19:52:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 526B561212;
        Mon, 18 Oct 2021 23:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634601030;
        bh=N+zy+U2tgRh/l27HwBJ04BEcTXccUWflGL4ZqT3xikA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g+uJmcIeHW4XUXuDoS0WoUMbD04z/51oZbeVVf6ut0ZI6SiQmMW1370W632MB2HiW
         3bi5WTSva9D+S8+ez1p4bWvJA89AqxwZ0Y4dJiDLsvYYa73VniTNYGdM/eVmDkTFXI
         gaxTf+1hg2ZlIOMnUF1QV8zls6TGPhY5ElNkW3ERXG2MVdJ/XOHv7E5COpSTS/3KTo
         zAxyueCO8wosK0gSwHb/CL3acmxilIw6BRtJXBkoaMRlYYjrLmuEF8oJj9CEv8jHA6
         BtPP4ytw9A9+f/ldJ8vj06BbliJW/KMSKJlVD0VJDHEXY/bcv7JgQZ4k0DBN9mKcDn
         EkipNAw6+kXZA==
From:   Jakub Kicinski <kuba@kernel.org>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        j@w1.fi, arnd@arndb.de
Subject: [PATCH 10/15] wireless: intersil: use eth_hw_addr_set()
Date:   Mon, 18 Oct 2021 16:50:16 -0700
Message-Id: <20211018235021.1279697-11-kuba@kernel.org>
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
CC: j@w1.fi
CC: kvalo@codeaurora.org
CC: arnd@arndb.de
CC: linux-wireless@vger.kernel.org
---
 drivers/net/wireless/intersil/hostap/hostap_hw.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intersil/hostap/hostap_hw.c b/drivers/net/wireless/intersil/hostap/hostap_hw.c
index 9a19046217df..e459e7192ae9 100644
--- a/drivers/net/wireless/intersil/hostap/hostap_hw.c
+++ b/drivers/net/wireless/intersil/hostap/hostap_hw.c
@@ -1403,14 +1403,17 @@ static int prism2_hw_init2(struct net_device *dev, int initial)
 	hfa384x_events_only_cmd(dev);
 
 	if (initial) {
+		u8 addr[ETH_ALEN] = {};
 		struct list_head *ptr;
+
 		prism2_check_sta_fw_version(local);
 
 		if (hfa384x_get_rid(dev, HFA384X_RID_CNFOWNMACADDR,
-				    dev->dev_addr, 6, 1) < 0) {
+				    addr, ETH_ALEN, 1) < 0) {
 			printk("%s: could not get own MAC address\n",
 			       dev->name);
 		}
+		eth_hw_addr_set(dev, addr);
 		list_for_each(ptr, &local->hostap_interfaces) {
 			iface = list_entry(ptr, struct hostap_interface, list);
 			eth_hw_addr_inherit(iface->dev, dev);
-- 
2.31.1

