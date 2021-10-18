Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD76432A77
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Oct 2021 01:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233239AbhJRXwl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Oct 2021 19:52:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:34930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229710AbhJRXwj (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Oct 2021 19:52:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A2B4161177;
        Mon, 18 Oct 2021 23:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634601027;
        bh=ozgquof7mrl3x3m/m1WfeR4uowUm86vibx6xBhByfp4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E+uD3DrdwGP00PFL7lwbzfp7QGCPiqRIQ6U2XPz6oJVcfiCH9evRalvuUlGHbQbRs
         1DDAP8XxcoyRmx6t4GaO/urZ0/ouE8guN4g4Lo8pIyf4jLOG3yIOPQoaI0EhVBFVv1
         7WnV638yVIsW2Pc432zpdel5m71018zYEWus0fgrLz+xQ6VkIfc9ZzG2tWRN+cmB8E
         MHxQdMOFwffHE4hlXAZuqWaPjSLPjvy0+9vdbzK3Og6eNMje1W2tZ0M+u/OBtX33Am
         rj4W9C8xXvHyaZ2Z3922f0Vp8f7EedPgAY4SbVU9qb00iKJncgTcOawcoTpDrwmIwi
         NMIxHB0FKNW5A==
From:   Jakub Kicinski <kuba@kernel.org>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 02/15] wireless: use eth_hw_addr_set() instead of ether_addr_copy()
Date:   Mon, 18 Oct 2021 16:50:08 -0700
Message-Id: <20211018235021.1279697-3-kuba@kernel.org>
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

Convert wireless from ether_addr_copy() to eth_hw_addr_set():

  @@
  expression dev, np;
  @@
  - ether_addr_copy(dev->dev_addr, np)
  + eth_hw_addr_set(dev, np)

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/wireless/ath/wil6210/cfg80211.c   | 4 ++--
 drivers/net/wireless/ath/wil6210/main.c       | 6 +++---
 drivers/net/wireless/marvell/mwifiex/main.c   | 2 +-
 drivers/net/wireless/quantenna/qtnfmac/core.c | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/wil6210/cfg80211.c b/drivers/net/wireless/ath/wil6210/cfg80211.c
index 1ff2679963f0..bd8d0a54af77 100644
--- a/drivers/net/wireless/ath/wil6210/cfg80211.c
+++ b/drivers/net/wireless/ath/wil6210/cfg80211.c
@@ -723,9 +723,9 @@ wil_cfg80211_add_iface(struct wiphy *wiphy, const char *name,
 	ndev = vif_to_ndev(vif);
 	ether_addr_copy(ndev->perm_addr, ndev_main->perm_addr);
 	if (is_valid_ether_addr(params->macaddr)) {
-		ether_addr_copy(ndev->dev_addr, params->macaddr);
+		eth_hw_addr_set(ndev, params->macaddr);
 	} else {
-		ether_addr_copy(ndev->dev_addr, ndev_main->perm_addr);
+		eth_hw_addr_set(ndev, ndev_main->perm_addr);
 		ndev->dev_addr[0] = (ndev->dev_addr[0] ^ (1 << vif->mid)) |
 			0x2; /* locally administered */
 	}
diff --git a/drivers/net/wireless/ath/wil6210/main.c b/drivers/net/wireless/ath/wil6210/main.c
index 3ba5b2550a8c..7da87c9f363f 100644
--- a/drivers/net/wireless/ath/wil6210/main.c
+++ b/drivers/net/wireless/ath/wil6210/main.c
@@ -1358,7 +1358,7 @@ static int wil_get_bl_info(struct wil6210_priv *wil)
 	ether_addr_copy(ndev->perm_addr, mac);
 	ether_addr_copy(wiphy->perm_addr, mac);
 	if (!is_valid_ether_addr(ndev->dev_addr))
-		ether_addr_copy(ndev->dev_addr, mac);
+		eth_hw_addr_set(ndev, mac);
 
 	if (rf_status) {/* bad RF cable? */
 		wil_err(wil, "RF communication error 0x%04x",
@@ -1431,7 +1431,7 @@ static int wil_get_otp_info(struct wil6210_priv *wil)
 	ether_addr_copy(ndev->perm_addr, mac);
 	ether_addr_copy(wiphy->perm_addr, mac);
 	if (!is_valid_ether_addr(ndev->dev_addr))
-		ether_addr_copy(ndev->dev_addr, mac);
+		eth_hw_addr_set(ndev, mac);
 
 	return 0;
 }
@@ -1609,7 +1609,7 @@ int wil_reset(struct wil6210_priv *wil, bool load_fw)
 		struct net_device *ndev = wil->main_ndev;
 
 		ether_addr_copy(ndev->perm_addr, mac);
-		ether_addr_copy(ndev->dev_addr, ndev->perm_addr);
+		eth_hw_addr_set(ndev, ndev->perm_addr);
 		return 0;
 	}
 
diff --git a/drivers/net/wireless/marvell/mwifiex/main.c b/drivers/net/wireless/marvell/mwifiex/main.c
index 7943fd3b3058..a0f9a6113f78 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.c
+++ b/drivers/net/wireless/marvell/mwifiex/main.c
@@ -985,7 +985,7 @@ int mwifiex_set_mac_address(struct mwifiex_private *priv,
 		return ret;
 	}
 
-	ether_addr_copy(dev->dev_addr, priv->curr_addr);
+	eth_hw_addr_set(dev, priv->curr_addr);
 	return 0;
 }
 
diff --git a/drivers/net/wireless/quantenna/qtnfmac/core.c b/drivers/net/wireless/quantenna/qtnfmac/core.c
index 907a1c2c1b6d..2a63ffdc4b2c 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/core.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/core.c
@@ -478,7 +478,7 @@ int qtnf_core_net_attach(struct qtnf_wmac *mac, struct qtnf_vif *vif,
 	dev->needs_free_netdev = true;
 	dev_net_set(dev, wiphy_net(wiphy));
 	dev->ieee80211_ptr = &vif->wdev;
-	ether_addr_copy(dev->dev_addr, vif->mac_addr);
+	eth_hw_addr_set(dev, vif->mac_addr);
 	dev->flags |= IFF_BROADCAST | IFF_MULTICAST;
 	dev->watchdog_timeo = QTNF_DEF_WDOG_TIMEOUT;
 	dev->tx_queue_len = 100;
-- 
2.31.1

