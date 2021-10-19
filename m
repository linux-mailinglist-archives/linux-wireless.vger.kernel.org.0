Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C183433C22
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Oct 2021 18:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233069AbhJSQae (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Oct 2021 12:30:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:52200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230303AbhJSQad (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Oct 2021 12:30:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D289360E76;
        Tue, 19 Oct 2021 16:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634660900;
        bh=SLj3u9qQw6idOnVDL7zGHCaBfWPhvEXHe/kZALrxMkg=;
        h=From:To:Cc:Subject:Date:From;
        b=mkxXNqITf57GSfcxNogILvRLjki4cK3thM0CMjUm89/mbqwYFSMMGP9hUrOX89lb6
         VUoEaahTk0cTWcqBMFbe3A1ioAsw6oa8koPR+ZIz8mFVJaQNa+tASxNgnEtr81UiMV
         Fx5/Xqn0nS6laEYDBa7NWkbIbZS54hpsfXmUD65uqoRHEBYuJGi/XqNMsW5LnAKY1p
         RVYz/2Jm/Q72WDuya3fJdw9/spCPpAf6o3Viaxhd8vYWpE//FN0+6OMIGMfWdEfYyT
         ppTPTP/FagpnL0YG2BWszk1k0/pyr7jiSZaXDPKxajNEJTTxpUmcWrN6wU+oGbhC3P
         I2FWg4Rv2djDQ==
From:   Jakub Kicinski <kuba@kernel.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 1/2] mac80211: use eth_hw_addr_set()
Date:   Tue, 19 Oct 2021 09:28:15 -0700
Message-Id: <20211019162816.1384077-1-kuba@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Commit 406f42fa0d3c ("net-next: When a bond have a massive amount
of VLANs...") introduced a rbtree for faster Ethernet address look
up. To maintain netdev->dev_addr in this tree we need to make all
the writes to it got through appropriate helpers.

Convert mac80211 from memcpy(... ETH_ADDR) to eth_hw_addr_set():

  @@
  expression dev, np;
  @@
  - memcpy(dev->dev_addr, np, ETH_ALEN)
  + eth_hw_addr_set(dev, np)

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/mac80211/iface.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 62c95597704b..878b919f22bb 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -1108,9 +1108,7 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
 	 * this interface, if it has the special null one.
 	 */
 	if (dev && is_zero_ether_addr(dev->dev_addr)) {
-		memcpy(dev->dev_addr,
-		       local->hw.wiphy->perm_addr,
-		       ETH_ALEN);
+		eth_hw_addr_set(dev, local->hw.wiphy->perm_addr);
 		memcpy(dev->perm_addr, dev->dev_addr, ETH_ALEN);
 
 		if (!is_valid_ether_addr(dev->dev_addr)) {
@@ -1964,9 +1962,9 @@ int ieee80211_if_add(struct ieee80211_local *local, const char *name,
 
 		ieee80211_assign_perm_addr(local, ndev->perm_addr, type);
 		if (is_valid_ether_addr(params->macaddr))
-			memcpy(ndev->dev_addr, params->macaddr, ETH_ALEN);
+			eth_hw_addr_set(ndev, params->macaddr);
 		else
-			memcpy(ndev->dev_addr, ndev->perm_addr, ETH_ALEN);
+			eth_hw_addr_set(ndev, ndev->perm_addr);
 		SET_NETDEV_DEV(ndev, wiphy_dev(local->hw.wiphy));
 
 		/* don't use IEEE80211_DEV_TO_SUB_IF -- it checks too much */
-- 
2.31.1

