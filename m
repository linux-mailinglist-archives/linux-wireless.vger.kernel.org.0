Return-Path: <linux-wireless+bounces-11695-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB65C958673
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 14:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BE9E1F26310
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 12:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19AE190678;
	Tue, 20 Aug 2024 12:00:35 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F7018FC65
	for <linux-wireless@vger.kernel.org>; Tue, 20 Aug 2024 12:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724155235; cv=none; b=SpMKQsybATYdx3qEQa5zFVVaUmw01pnLg7hbfhr7pm2va21qeUh2WoJnYDpNfxKeio/ZAouvzGKprA0MifCH7jPB3b6986PVMzdqeY6U99nYBk1qYRd8p2mpO4oUwlW1q837KeTyEGD5mw60K2dXcfox0i+7FjMzcMmGJ0zRFEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724155235; c=relaxed/simple;
	bh=tSf1l0pn1lT8An3Ky0FAXT8O6+y3aQ/u0Dx8uHaAMQc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CgVxA/u/mgxU+1C/HTAg78L0mYjSKQlKXSWcKRsGcbpj37P9l29YX/3oSzK5EzPMR7mo/qLZ9pbuH8wFXOOhoUvw5vJNf3yruNEMuhYlv6xe+IyS560BpyG6ROKsWQ+oFAZw+xAP0FQa0tUqFls8p+hIupI5UKlcnxwMVI2OHfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sgNXH-0000wf-7P; Tue, 20 Aug 2024 14:00:27 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sgNXG-001lNg-M7; Tue, 20 Aug 2024 14:00:26 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sgNSR-00GnIQ-1I;
	Tue, 20 Aug 2024 13:55:27 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Tue, 20 Aug 2024 13:55:37 +0200
Subject: [PATCH 12/31] wifi: mwifiex: fix MAC address handling
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240820-mwifiex-cleanup-v1-12-320d8de4a4b7@pengutronix.de>
References: <20240820-mwifiex-cleanup-v1-0-320d8de4a4b7@pengutronix.de>
In-Reply-To: <20240820-mwifiex-cleanup-v1-0-320d8de4a4b7@pengutronix.de>
To: Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>, Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Sascha Hauer <s.hauer@pengutronix.de>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724154927; l=6359;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=tSf1l0pn1lT8An3Ky0FAXT8O6+y3aQ/u0Dx8uHaAMQc=;
 b=XSI6lADSa9iLXhkNw6zqXqpQ2OrGeyqN4qQFs/ihMZ6wQRg9DUeQ+PktbE7Hc+nDqLSgVyimH
 kmxnt9TEz/pAxWFmNz19EXt13OrzAePaUL9MON68+e/E/6f1Hxi2D6z
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

The mwifiex driver tries to derive the MAC addresses of the virtual
interfaces from the permanent address by adding the bss_num of the
particular interface used. It does so each time the virtual interface
is changed from AP to station or the other way round. This means that
the devices MAC address changes during a change_virtual_intf call which
is pretty unexpected by userspace.

Furthermore the driver doesn't use the permanent address to add the
bss_num to, but instead the current MAC address increases each time
we do a change_virtual_intf.

Fix this by initializing the MAC address once from the permanent MAC
address during creation of the virtual interface and never touching it
again. This also means that userspace can set a different MAC address
which then stays like this forever and is not unexpectedly changed
by the driver. The bss_type is no longer used to generate a MAC address
as that may change during lifetime of the virtual interface.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/net/wireless/marvell/mwifiex/cfg80211.c |  4 +--
 drivers/net/wireless/marvell/mwifiex/init.c     |  1 -
 drivers/net/wireless/marvell/mwifiex/main.c     | 46 ++++++++++---------------
 drivers/net/wireless/marvell/mwifiex/main.h     |  5 +--
 4 files changed, 22 insertions(+), 34 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index d5a2c8f726b9e..715d98b7ff550 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -960,8 +960,6 @@ mwifiex_init_new_priv_params(struct mwifiex_private *priv,
 	adapter->rx_locked = false;
 	spin_unlock_bh(&adapter->rx_proc_lock);
 
-	mwifiex_set_mac_address(priv, dev, false, NULL);
-
 	return 0;
 }
 
@@ -3104,7 +3102,7 @@ struct wireless_dev *mwifiex_add_virtual_intf(struct wiphy *wiphy,
 	priv->netdev = dev;
 
 	if (!adapter->mfg_mode) {
-		mwifiex_set_mac_address(priv, dev, false, NULL);
+		mwifiex_set_default_mac_address(priv, dev);
 
 		ret = mwifiex_send_cmd(priv, HostCmd_CMD_SET_BSS_MODE,
 				       HostCmd_ACT_GEN_SET, 0, NULL, true);
diff --git a/drivers/net/wireless/marvell/mwifiex/init.c b/drivers/net/wireless/marvell/mwifiex/init.c
index 8b61e45cd6678..0259c9f88486b 100644
--- a/drivers/net/wireless/marvell/mwifiex/init.c
+++ b/drivers/net/wireless/marvell/mwifiex/init.c
@@ -71,7 +71,6 @@ int mwifiex_init_priv(struct mwifiex_private *priv)
 	u32 i;
 
 	priv->media_connected = false;
-	eth_broadcast_addr(priv->curr_addr);
 	priv->port_open = false;
 	priv->usb_port = MWIFIEX_USB_EP_DATA;
 	priv->pkt_tx_ctrl = 0;
diff --git a/drivers/net/wireless/marvell/mwifiex/main.c b/drivers/net/wireless/marvell/mwifiex/main.c
index 888f2801d6f2a..f1f6deaa91122 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.c
+++ b/drivers/net/wireless/marvell/mwifiex/main.c
@@ -963,34 +963,16 @@ mwifiex_hard_start_xmit(struct sk_buff *skb, struct net_device *dev)
 }
 
 int mwifiex_set_mac_address(struct mwifiex_private *priv,
-			    struct net_device *dev, bool external,
-			    u8 *new_mac)
+			    struct net_device *dev, u8 *new_mac)
 {
 	int ret;
-	u64 mac_addr, old_mac_addr;
+	u64 old_mac_addr;
 
-	old_mac_addr = ether_addr_to_u64(priv->curr_addr);
+	netdev_info(dev, "%s: old: %pM new: %pM\n", __func__, priv->curr_addr, new_mac);
 
-	if (external) {
-		mac_addr = ether_addr_to_u64(new_mac);
-	} else {
-		/* Internal mac address change */
-		if (priv->bss_type == MWIFIEX_BSS_TYPE_ANY)
-			return -EOPNOTSUPP;
-
-		mac_addr = old_mac_addr;
-
-		if (priv->bss_type == MWIFIEX_BSS_TYPE_P2P) {
-			mac_addr |= BIT_ULL(MWIFIEX_MAC_LOCAL_ADMIN_BIT);
-			mac_addr += priv->bss_num;
-		} else if (priv->adapter->priv[0] != priv) {
-			/* Set mac address based on bss_type/bss_num */
-			mac_addr ^= BIT_ULL(priv->bss_type + 8);
-			mac_addr += priv->bss_num;
-		}
-	}
+	old_mac_addr = ether_addr_to_u64(priv->curr_addr);
 
-	u64_to_ether_addr(mac_addr, priv->curr_addr);
+	ether_addr_copy(priv->curr_addr, new_mac);
 
 	/* Send request to firmware */
 	ret = mwifiex_send_cmd(priv, HostCmd_CMD_802_11_MAC_ADDRESS,
@@ -1007,6 +989,18 @@ int mwifiex_set_mac_address(struct mwifiex_private *priv,
 	return 0;
 }
 
+int mwifiex_set_default_mac_address(struct mwifiex_private *priv,
+				    struct net_device *dev)
+{
+	u8 mac[ETH_ALEN];
+
+	ether_addr_copy(mac, priv->adapter->perm_addr);
+
+	eth_addr_add(mac, priv->bss_num);
+
+	return mwifiex_set_mac_address(priv, dev, mac);
+}
+
 /* CFG802.11 network device handler for setting MAC address.
  */
 static int
@@ -1015,7 +1009,7 @@ mwifiex_ndo_set_mac_address(struct net_device *dev, void *addr)
 	struct mwifiex_private *priv = mwifiex_netdev_get_priv(dev);
 	struct sockaddr *hw_addr = addr;
 
-	return mwifiex_set_mac_address(priv, dev, true, hw_addr->sa_data);
+	return mwifiex_set_mac_address(priv, dev, hw_addr->sa_data);
 }
 
 /*
@@ -1356,10 +1350,6 @@ void mwifiex_init_priv_params(struct mwifiex_private *priv,
 	priv->assocresp_idx = MWIFIEX_AUTO_IDX_MASK;
 	priv->gen_idx = MWIFIEX_AUTO_IDX_MASK;
 	priv->num_tx_timeout = 0;
-	if (is_valid_ether_addr(dev->dev_addr))
-		ether_addr_copy(priv->curr_addr, dev->dev_addr);
-	else
-		ether_addr_copy(priv->curr_addr, priv->adapter->perm_addr);
 
 	if (GET_BSS_ROLE(priv) == MWIFIEX_BSS_ROLE_STA ||
 	    GET_BSS_ROLE(priv) == MWIFIEX_BSS_ROLE_UAP) {
diff --git a/drivers/net/wireless/marvell/mwifiex/main.h b/drivers/net/wireless/marvell/mwifiex/main.h
index 2938e55a38d79..39f9bb49f83ff 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.h
+++ b/drivers/net/wireless/marvell/mwifiex/main.h
@@ -1658,8 +1658,9 @@ void mwifiex_process_multi_chan_event(struct mwifiex_private *priv,
 				      struct sk_buff *event_skb);
 void mwifiex_multi_chan_resync(struct mwifiex_adapter *adapter);
 int mwifiex_set_mac_address(struct mwifiex_private *priv,
-			    struct net_device *dev,
-			    bool external, u8 *new_mac);
+			    struct net_device *dev, u8 *new_mac);
+int mwifiex_set_default_mac_address(struct mwifiex_private *priv,
+				    struct net_device *dev);
 void mwifiex_devdump_tmo_func(unsigned long function_context);
 
 #ifdef CONFIG_DEBUG_FS

-- 
2.39.2


