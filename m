Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E542432A79
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Oct 2021 01:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233389AbhJRXwm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Oct 2021 19:52:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:34930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229524AbhJRXwk (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Oct 2021 19:52:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 33552610C9;
        Mon, 18 Oct 2021 23:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634601028;
        bh=kwH7Lzwfk17wYLmdNe76BVq2rpoTyKD/qw17t0ZoCMM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LVy+aGWYMB5bvRmkMSX+8JGuZR2BnjVJ0/MgKlc4Hwm+LIvQf4DZO+FpORR8jdaXe
         ygRqta97+ie5hmsD0lJAT3/B+ibXNW3EEAjEe+e5tNIvP1cnBZ7nfwmhpGtFQBTbUY
         g6mkM5ef8kILlD0QJ2iEJqUpZX/qG75wzSDuIXcWrD2PIgK0XM5BQvRqR2u5ecczJ5
         3MzhIGDUdDE+a/Hj70sePCCgJ2rv2IHl8g4JIX2aukBKMejpspK1xVNFUgsOHIV5k/
         xzyfvBhkRL7TjqjHwrMV0/MnWZi/h/RSkB0XcQMqMP0FX61j94mGtwqwsXqOO979Ps
         Hs+b27DOag7WA==
From:   Jakub Kicinski <kuba@kernel.org>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 04/15] wireless: ath6kl: use eth_hw_addr_set()
Date:   Mon, 18 Oct 2021 16:50:10 -0700
Message-Id: <20211018235021.1279697-5-kuba@kernel.org>
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

Do the special encoding on the stack, then copy the address.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: kvalo@codeaurora.org
CC: linux-wireless@vger.kernel.org
---
 drivers/net/wireless/ath/ath6kl/cfg80211.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath6kl/cfg80211.c b/drivers/net/wireless/ath/ath6kl/cfg80211.c
index 51cc5f898a79..bd1183830e91 100644
--- a/drivers/net/wireless/ath/ath6kl/cfg80211.c
+++ b/drivers/net/wireless/ath/ath6kl/cfg80211.c
@@ -3781,6 +3781,7 @@ struct wireless_dev *ath6kl_interface_add(struct ath6kl *ar, const char *name,
 {
 	struct net_device *ndev;
 	struct ath6kl_vif *vif;
+	u8 addr[ETH_ALEN];
 
 	ndev = alloc_netdev(sizeof(*vif), name, name_assign_type, ether_setup);
 	if (!ndev)
@@ -3803,14 +3804,14 @@ struct wireless_dev *ath6kl_interface_add(struct ath6kl *ar, const char *name,
 	vif->htcap[NL80211_BAND_2GHZ].ht_enable = true;
 	vif->htcap[NL80211_BAND_5GHZ].ht_enable = true;
 
-	eth_hw_addr_set(ndev, ar->mac_addr);
+	ether_addr_copy(addr, ar->mac_addr);
 	if (fw_vif_idx != 0) {
-		ndev->dev_addr[0] = (ndev->dev_addr[0] ^ (1 << fw_vif_idx)) |
-				     0x2;
+		addr[0] = (addr[0] ^ (1 << fw_vif_idx)) | 0x2;
 		if (test_bit(ATH6KL_FW_CAPABILITY_CUSTOM_MAC_ADDR,
 			     ar->fw_capabilities))
-			ndev->dev_addr[4] ^= 0x80;
+			addr[4] ^= 0x80;
 	}
+	eth_hw_addr_set(ndev, addr);
 
 	init_netdev(ndev);
 
-- 
2.31.1

