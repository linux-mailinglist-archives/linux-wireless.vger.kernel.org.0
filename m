Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8893A432A7A
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Oct 2021 01:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233423AbhJRXwm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Oct 2021 19:52:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:34966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233214AbhJRXwk (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Oct 2021 19:52:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7B10861212;
        Mon, 18 Oct 2021 23:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634601028;
        bh=jIuhnQdYPilsja0WYjDomP62jFeD4RXWayZ4HTtnz+o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gh719nB2PJ+N78txqniyyeUouV96PACt4TWvnN6tSrigWS0x/OMUB6Vo4vZzkiLUN
         rGxGhanh5ja+GHY/Z7Ati712lh29v9P5o2aV62qTlAoYyrtwq1x1lbGsEQzc63aVmZ
         DUbGUOe1GtxhXoNzUGN+Vcf1uZ+cfxbw4cR7H4zPfS5U8HBRVwNpY85iUg7V66174Z
         KoXhIL7PPYxNcUxYOxCHetetzxWCjarFkkdpZMFw0e4f7RXqMLpVT4/ErT7bMvVqse
         eQKqTt0OsV7hDExKODSHaL+cFsmzs9obVcx8qsLPia0AVfOHFUTZid8m3jX72Nq7Hj
         ImlqJiCaALxQw==
From:   Jakub Kicinski <kuba@kernel.org>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        merez@codeaurora.org, wil6210@qti.qualcomm.com
Subject: [PATCH 05/15] wireless: wil6210: use eth_hw_addr_set()
Date:   Mon, 18 Oct 2021 16:50:11 -0700
Message-Id: <20211018235021.1279697-6-kuba@kernel.org>
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
CC: merez@codeaurora.org
CC: kvalo@codeaurora.org
CC: linux-wireless@vger.kernel.org
CC: wil6210@qti.qualcomm.com
---
 drivers/net/wireless/ath/wil6210/cfg80211.c | 8 +++++---
 drivers/net/wireless/ath/wil6210/wil6210.h  | 2 +-
 drivers/net/wireless/ath/wil6210/wmi.c      | 2 +-
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/wil6210/cfg80211.c b/drivers/net/wireless/ath/wil6210/cfg80211.c
index bd8d0a54af77..764d1d14132b 100644
--- a/drivers/net/wireless/ath/wil6210/cfg80211.c
+++ b/drivers/net/wireless/ath/wil6210/cfg80211.c
@@ -725,9 +725,11 @@ wil_cfg80211_add_iface(struct wiphy *wiphy, const char *name,
 	if (is_valid_ether_addr(params->macaddr)) {
 		eth_hw_addr_set(ndev, params->macaddr);
 	} else {
-		eth_hw_addr_set(ndev, ndev_main->perm_addr);
-		ndev->dev_addr[0] = (ndev->dev_addr[0] ^ (1 << vif->mid)) |
-			0x2; /* locally administered */
+		u8 addr[ETH_ALEN];
+
+		ether_addr_copy(addr, ndev_main->perm_addr);
+		addr[0] = (addr[0] ^ (1 << vif->mid)) |	0x2; /* locally administered */
+		eth_hw_addr_set(ndev, addr);
 	}
 	wdev = vif_to_wdev(vif);
 	ether_addr_copy(wdev->address, ndev->dev_addr);
diff --git a/drivers/net/wireless/ath/wil6210/wil6210.h b/drivers/net/wireless/ath/wil6210/wil6210.h
index 30392eb1cbbd..11946ecd0b99 100644
--- a/drivers/net/wireless/ath/wil6210/wil6210.h
+++ b/drivers/net/wireless/ath/wil6210/wil6210.h
@@ -1341,7 +1341,7 @@ struct wil6210_priv *wil_cfg80211_init(struct device *dev);
 void wil_cfg80211_deinit(struct wil6210_priv *wil);
 void wil_p2p_wdev_free(struct wil6210_priv *wil);
 
-int wmi_set_mac_address(struct wil6210_priv *wil, void *addr);
+int wmi_set_mac_address(struct wil6210_priv *wil, const void *addr);
 int wmi_pcp_start(struct wil6210_vif *vif, int bi, u8 wmi_nettype, u8 chan,
 		  u8 edmg_chan, u8 hidden_ssid, u8 is_go);
 int wmi_pcp_stop(struct wil6210_vif *vif);
diff --git a/drivers/net/wireless/ath/wil6210/wmi.c b/drivers/net/wireless/ath/wil6210/wmi.c
index 2dc8406736f4..dd8abbb28849 100644
--- a/drivers/net/wireless/ath/wil6210/wmi.c
+++ b/drivers/net/wireless/ath/wil6210/wmi.c
@@ -2097,7 +2097,7 @@ int wmi_echo(struct wil6210_priv *wil)
 			WIL_WMI_CALL_GENERAL_TO_MS);
 }
 
-int wmi_set_mac_address(struct wil6210_priv *wil, void *addr)
+int wmi_set_mac_address(struct wil6210_priv *wil, const void *addr)
 {
 	struct wil6210_vif *vif = ndev_to_vif(wil->main_ndev);
 	struct wmi_set_mac_address_cmd cmd;
-- 
2.31.1

