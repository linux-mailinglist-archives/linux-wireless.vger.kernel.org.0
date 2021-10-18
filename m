Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99E69432A81
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Oct 2021 01:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233671AbhJRXwq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Oct 2021 19:52:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:35066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233425AbhJRXwm (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Oct 2021 19:52:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F1ACA61206;
        Mon, 18 Oct 2021 23:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634601031;
        bh=PW3M1jNhvW2Fe4gchYFcyIN+J1hiNouMdSO0FaS5GcU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XYqT2a99iLcUePO7yDAUA1dgDucpN3kn6OPfOsj5FCR4XlvwjjEPM+SrBdyge15MQ
         xvmBRMatQk/d/qx9k6p87keXGs3BTxNDIioOLO9BJshUWL+kXRsOyad7PDI3Jiz2P9
         2AcmuVmtcxtgHZ7GVp5kg5NJ7QFclvKvof05l6Lq+3U251yC8ulOsCRIAH1FGeBY4X
         MlVMPrjqaogZM2IATSKsf3ZkZZbERqEN/a4DNBtPoSU+c17iHUlS5s7tLG2A1tu6Li
         AjRib7GCObboJUNafisk0QPNEnwAhfvI1YTIRqzfmAcZrdeFqt+0O/itJnfYCtFQRX
         MrAKArozAjNjA==
From:   Jakub Kicinski <kuba@kernel.org>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        ajay.kathat@microchip.com, claudiu.beznea@microchip.com
Subject: [PATCH 12/15] wireless: wilc1000: use eth_hw_addr_set()
Date:   Mon, 18 Oct 2021 16:50:18 -0700
Message-Id: <20211018235021.1279697-13-kuba@kernel.org>
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
CC: ajay.kathat@microchip.com
CC: claudiu.beznea@microchip.com
CC: kvalo@codeaurora.org
CC: linux-wireless@vger.kernel.org
---
 drivers/net/wireless/microchip/wilc1000/netdev.c | 13 +++++++++----
 drivers/net/wireless/microchip/wilc1000/netdev.h |  3 ++-
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.c b/drivers/net/wireless/microchip/wilc1000/netdev.c
index d3b33c6ab93a..690572e01a2a 100644
--- a/drivers/net/wireless/microchip/wilc1000/netdev.c
+++ b/drivers/net/wireless/microchip/wilc1000/netdev.c
@@ -111,7 +111,8 @@ static struct net_device *get_if_handler(struct wilc *wilc, u8 *mac_header)
 	return ndev;
 }
 
-void wilc_wlan_set_bssid(struct net_device *wilc_netdev, u8 *bssid, u8 mode)
+void wilc_wlan_set_bssid(struct net_device *wilc_netdev, const u8 *bssid,
+			 u8 mode)
 {
 	struct wilc_vif *vif = netdev_priv(wilc_netdev);
 
@@ -594,10 +595,14 @@ static int wilc_mac_open(struct net_device *ndev)
 	wilc_set_operation_mode(vif, wilc_get_vif_idx(vif), vif->iftype,
 				vif->idx);
 
-	if (is_valid_ether_addr(ndev->dev_addr))
+	if (is_valid_ether_addr(ndev->dev_addr)) {
 		wilc_set_mac_address(vif, ndev->dev_addr);
-	else
-		wilc_get_mac_address(vif, ndev->dev_addr);
+	} else {
+		u8 addr[ETH_ALEN];
+
+		wilc_get_mac_address(vif, addr);
+		eth_hw_addr_set(ndev, addr);
+	}
 	netdev_dbg(ndev, "Mac address: %pM\n", ndev->dev_addr);
 
 	if (!is_valid_ether_addr(ndev->dev_addr)) {
diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.h b/drivers/net/wireless/microchip/wilc1000/netdev.h
index 79f73a72da57..b9a88b3e322f 100644
--- a/drivers/net/wireless/microchip/wilc1000/netdev.h
+++ b/drivers/net/wireless/microchip/wilc1000/netdev.h
@@ -287,7 +287,8 @@ void wilc_frmw_to_host(struct wilc *wilc, u8 *buff, u32 size, u32 pkt_offset);
 void wilc_mac_indicate(struct wilc *wilc);
 void wilc_netdev_cleanup(struct wilc *wilc);
 void wilc_wfi_mgmt_rx(struct wilc *wilc, u8 *buff, u32 size);
-void wilc_wlan_set_bssid(struct net_device *wilc_netdev, u8 *bssid, u8 mode);
+void wilc_wlan_set_bssid(struct net_device *wilc_netdev, const u8 *bssid,
+			 u8 mode);
 struct wilc_vif *wilc_netdev_ifc_init(struct wilc *wl, const char *name,
 				      int vif_type, enum nl80211_iftype type,
 				      bool rtnl_locked);
-- 
2.31.1

