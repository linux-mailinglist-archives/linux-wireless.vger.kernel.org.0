Return-Path: <linux-wireless+bounces-11971-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B1B95EF54
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 13:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E583F1C22953
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 11:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CCDA13B2A4;
	Mon, 26 Aug 2024 11:01:42 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6FC16F908
	for <linux-wireless@vger.kernel.org>; Mon, 26 Aug 2024 11:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724670102; cv=none; b=P0MqWRaNomUwyFzfBxcnE7TZqKvg3Sb+M5iLvda/QPcqJgmR5w2OOSCZ/9NgNHNCnWuCy+qPj/PhHPq+JlEahxnqaPb3Wef144K8HaSpKF+hBSQPpCqZ44dgqVC7sQzq7XLe7fR9AEzq6vsXjcm/BXQqG97EmGQbxNt5vcgqFkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724670102; c=relaxed/simple;
	bh=NkkGQ5SFMbTIT7y5aD7lg6eNcuu36qG/js++gvunC1k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CM/Tk75wF7+GCSKfiIeEOpRiXnkwuL1O7toYAWNRp9urA8LBbyXb/6fLnDS4Mdn6HQ157Q8I5Zoc8MRNmRYO2ExyPhz/dvNEAjifGQhnihQnKyCObMWl+gGIIBVg31M1RSmGCi8Yy1jllbr6eQOWO7cstQNzIqWt8hVLrj4p0QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1siXTY-00047V-Ll; Mon, 26 Aug 2024 13:01:32 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1siXTX-003Ae4-Vi; Mon, 26 Aug 2024 13:01:32 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1siXTX-004aRi-2r;
	Mon, 26 Aug 2024 13:01:31 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Mon, 26 Aug 2024 13:01:23 +0200
Subject: [PATCH 02/12] wifi: mwifiex: fix MAC address handling
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240826-mwifiex-cleanup-1-v1-2-56e6f8e056ec@pengutronix.de>
References: <20240826-mwifiex-cleanup-1-v1-0-56e6f8e056ec@pengutronix.de>
In-Reply-To: <20240826-mwifiex-cleanup-1-v1-0-56e6f8e056ec@pengutronix.de>
To: Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>, Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sascha Hauer <s.hauer@pengutronix.de>, stable@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724670091; l=6657;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=NkkGQ5SFMbTIT7y5aD7lg6eNcuu36qG/js++gvunC1k=;
 b=FAPwdqEECNf8or9NUzlpb7A9gF10skWLPAcqjWGNcN3U7LhkhvUYS/aHZ0WiT0rhMtaoU5JHO
 kPq0kOsNOQOCbiZjvsGVKwVvdbDmNVSJo96oy/ydefPGiqfbwN9AFm3
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
address during creation of the virtual interface and never touch it
again. This also means that userspace can set a different MAC address
which then stays like this forever and is not unexpectedly changed
by the driver.

It is not clear how many (if any) MAC addresses after the permanent MAC
address are reserved for a device, so set the locally admistered
bit for all MAC addresses modified from the permanent address.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Cc: stable@vger.kernel.org
---
 drivers/net/wireless/marvell/mwifiex/cfg80211.c |  4 +-
 drivers/net/wireless/marvell/mwifiex/init.c     |  1 -
 drivers/net/wireless/marvell/mwifiex/main.c     | 54 ++++++++++++-------------
 drivers/net/wireless/marvell/mwifiex/main.h     |  5 ++-
 4 files changed, 30 insertions(+), 34 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index 5697a02e6b8d3..d3e1424bea390 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -962,8 +962,6 @@ mwifiex_init_new_priv_params(struct mwifiex_private *priv,
 	adapter->rx_locked = false;
 	spin_unlock_bh(&adapter->rx_proc_lock);
 
-	mwifiex_set_mac_address(priv, dev, false, NULL);
-
 	return 0;
 }
 
@@ -3115,7 +3113,7 @@ struct wireless_dev *mwifiex_add_virtual_intf(struct wiphy *wiphy,
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
index 96d1f6039fbca..46acddd03ffd1 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.c
+++ b/drivers/net/wireless/marvell/mwifiex/main.c
@@ -971,34 +971,16 @@ mwifiex_hard_start_xmit(struct sk_buff *skb, struct net_device *dev)
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
@@ -1015,6 +997,26 @@ int mwifiex_set_mac_address(struct mwifiex_private *priv,
 	return 0;
 }
 
+int mwifiex_set_default_mac_address(struct mwifiex_private *priv,
+				    struct net_device *dev)
+{
+	int priv_num;
+	u8 mac[ETH_ALEN];
+
+	ether_addr_copy(mac, priv->adapter->perm_addr);
+
+	for (priv_num = 0; priv_num < priv->adapter->priv_num; priv_num++)
+		if (priv == priv->adapter->priv[priv_num])
+			break;
+
+	if (priv_num) {
+		eth_addr_add(mac, priv_num);
+		mac[0] |= 0x2;
+	}
+
+	return mwifiex_set_mac_address(priv, dev, mac);
+}
+
 /* CFG802.11 network device handler for setting MAC address.
  */
 static int
@@ -1023,7 +1025,7 @@ mwifiex_ndo_set_mac_address(struct net_device *dev, void *addr)
 	struct mwifiex_private *priv = mwifiex_netdev_get_priv(dev);
 	struct sockaddr *hw_addr = addr;
 
-	return mwifiex_set_mac_address(priv, dev, true, hw_addr->sa_data);
+	return mwifiex_set_mac_address(priv, dev, hw_addr->sa_data);
 }
 
 /*
@@ -1364,10 +1366,6 @@ void mwifiex_init_priv_params(struct mwifiex_private *priv,
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
index 529863edd7a25..dc07eb11f7752 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.h
+++ b/drivers/net/wireless/marvell/mwifiex/main.h
@@ -1694,8 +1694,9 @@ void mwifiex_process_multi_chan_event(struct mwifiex_private *priv,
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


