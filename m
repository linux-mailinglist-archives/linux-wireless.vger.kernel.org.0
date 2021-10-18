Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5119D432A80
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Oct 2021 01:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233559AbhJRXwq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Oct 2021 19:52:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:35060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233395AbhJRXwm (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Oct 2021 19:52:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A78756128A;
        Mon, 18 Oct 2021 23:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634601030;
        bh=5wULzODvrAyrwTGlx9z5JklV+k/oNgcKP11IvnpY3Dw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Aefl9/yNWHgSxtrBTemrGBEmfzbI3NkkTIAm9ZYQ7C1HSBLeMuQvoYMcyBlnn8aIY
         0VcjbSe32K+m0YlfxBggEYdDHKaOKnu5uKORXtwsFDV9sav6dCuCJeR/CQSHDmpWFA
         WLELYRgeA78CwOiOgBiNfW/gGtVgSDPnF06yqB7ugyEzeBJQ4/kFnxhTSI+KXI4JeU
         EVyGYikajoUs/WhfQ8nSe+17FBxy1Aa5m2hHsk4T2rWzWW7R3CgB3HGLaDHFFgQdCb
         Oamoit96/infQOslSd6e4JJ99LP5qO/k9zUcuECP3NhQ6XFwtC1mLDtjWH3u167Wza
         +oCfR01532JJA==
From:   Jakub Kicinski <kuba@kernel.org>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        johannes@sipsolutions.net
Subject: [PATCH 11/15] wireless: mac80211_hwsim: use eth_hw_addr_set()
Date:   Mon, 18 Oct 2021 16:50:17 -0700
Message-Id: <20211018235021.1279697-12-kuba@kernel.org>
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
CC: johannes@sipsolutions.net
CC: kvalo@codeaurora.org
CC: linux-wireless@vger.kernel.org
---
 drivers/net/wireless/mac80211_hwsim.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index 0adae76eb8df..8d0ae99eca94 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -3527,13 +3527,16 @@ static const struct net_device_ops hwsim_netdev_ops = {
 
 static void hwsim_mon_setup(struct net_device *dev)
 {
+	u8 addr[ETH_ALEN];
+
 	dev->netdev_ops = &hwsim_netdev_ops;
 	dev->needs_free_netdev = true;
 	ether_setup(dev);
 	dev->priv_flags |= IFF_NO_QUEUE;
 	dev->type = ARPHRD_IEEE80211_RADIOTAP;
-	eth_zero_addr(dev->dev_addr);
-	dev->dev_addr[0] = 0x12;
+	eth_zero_addr(addr);
+	addr[0] = 0x12;
+	eth_hw_addr_set(dev, addr);
 }
 
 static struct mac80211_hwsim_data *get_hwsim_data_ref_from_addr(const u8 *addr)
-- 
2.31.1

