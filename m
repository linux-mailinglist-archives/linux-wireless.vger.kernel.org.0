Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD0CE432A76
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Oct 2021 01:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233213AbhJRXwk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Oct 2021 19:52:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:34924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229529AbhJRXwj (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Oct 2021 19:52:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5EF5C610C9;
        Mon, 18 Oct 2021 23:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634601027;
        bh=YWPJFhR/l+eQySnV51ofF78uS2SuUCZXlnOxFI2jA4o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WjLhIofykXm6rVzJl23qlB+zwsIbBLuxWJ9mhqdXxranKt0fwYJbKOTKCg2pwrD3s
         dR4uljMmxmc9Hz+yDX1vZkD5Jn8ekNIW12eXZ+zCMpsTeNWH2CLCHEYyLSelCvVOyq
         yLg3Jd0eaSSBY39rZvCp2IgEn0a7tFHLFcrcUcF+c/W0DziQmBPiIx3sdU2WxZwv6y
         urjoJb82jQ0MfICWfbwRiXrxfysd/ChihrdFDQeOC26ri+MT+CqCLyUgBAY7QHU4A/
         gjxiJ9dN4IHhZGyxungMfCeC1q7HtYzf2SOMHwvtLKcxADrVDplSLpmAMtteAlzImS
         VPmowAUWbB8zQ==
From:   Jakub Kicinski <kuba@kernel.org>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 01/15] wireless: use eth_hw_addr_set()
Date:   Mon, 18 Oct 2021 16:50:07 -0700
Message-Id: <20211018235021.1279697-2-kuba@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211018235021.1279697-1-kuba@kernel.org>
References: <20211018235021.1279697-1-kuba@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Convert all WiFi drivers from memcpy(... ETH_ADDR)
to eth_hw_addr_set():

  @@
  expression dev, np;
  @@
  - memcpy(dev->dev_addr, np, ETH_ALEN)
  + eth_hw_addr_set(dev, np)

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/wireless/ath/ath6kl/cfg80211.c              | 2 +-
 drivers/net/wireless/atmel/atmel.c                      | 2 +-
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c | 6 +++---
 drivers/net/wireless/intel/ipw2x00/ipw2100.c            | 4 ++--
 drivers/net/wireless/intel/ipw2x00/ipw2200.c            | 4 ++--
 drivers/net/wireless/intersil/hostap/hostap_main.c      | 4 ++--
 drivers/net/wireless/intersil/orinoco/main.c            | 2 +-
 drivers/net/wireless/marvell/libertas/cmd.c             | 5 ++---
 drivers/net/wireless/marvell/libertas/main.c            | 4 ++--
 drivers/net/wireless/marvell/mwifiex/uap_event.c        | 3 +--
 drivers/net/wireless/quantenna/qtnfmac/core.c           | 2 +-
 11 files changed, 18 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/ath/ath6kl/cfg80211.c b/drivers/net/wireless/ath/ath6kl/cfg80211.c
index fefdc6753acd..51cc5f898a79 100644
--- a/drivers/net/wireless/ath/ath6kl/cfg80211.c
+++ b/drivers/net/wireless/ath/ath6kl/cfg80211.c
@@ -3803,7 +3803,7 @@ struct wireless_dev *ath6kl_interface_add(struct ath6kl *ar, const char *name,
 	vif->htcap[NL80211_BAND_2GHZ].ht_enable = true;
 	vif->htcap[NL80211_BAND_5GHZ].ht_enable = true;
 
-	memcpy(ndev->dev_addr, ar->mac_addr, ETH_ALEN);
+	eth_hw_addr_set(ndev, ar->mac_addr);
 	if (fw_vif_idx != 0) {
 		ndev->dev_addr[0] = (ndev->dev_addr[0] ^ (1 << fw_vif_idx)) |
 				     0x2;
diff --git a/drivers/net/wireless/atmel/atmel.c b/drivers/net/wireless/atmel/atmel.c
index febce4e8b3dd..3d782fabbfe6 100644
--- a/drivers/net/wireless/atmel/atmel.c
+++ b/drivers/net/wireless/atmel/atmel.c
@@ -3730,7 +3730,7 @@ static int probe_atmel_card(struct net_device *dev)
 				0x00, 0x04, 0x25, 0x00, 0x00, 0x00
 			};
 			printk(KERN_ALERT "%s: *** Invalid MAC address. UPGRADE Firmware ****\n", dev->name);
-			memcpy(dev->dev_addr, default_mac, ETH_ALEN);
+			eth_hw_addr_set(dev, default_mac);
 		}
 	}
 
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
index db5f8535fdb5..fed9cd5f29a2 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
@@ -244,7 +244,7 @@ static int brcmf_netdev_set_mac_address(struct net_device *ndev, void *addr)
 	} else {
 		brcmf_dbg(TRACE, "updated to %pM\n", sa->sa_data);
 		memcpy(ifp->mac_addr, sa->sa_data, ETH_ALEN);
-		memcpy(ifp->ndev->dev_addr, ifp->mac_addr, ETH_ALEN);
+		eth_hw_addr_set(ifp->ndev, ifp->mac_addr);
 	}
 	return err;
 }
@@ -655,7 +655,7 @@ int brcmf_net_attach(struct brcmf_if *ifp, bool locked)
 	ndev->ethtool_ops = &brcmf_ethtool_ops;
 
 	/* set the mac address & netns */
-	memcpy(ndev->dev_addr, ifp->mac_addr, ETH_ALEN);
+	eth_hw_addr_set(ndev, ifp->mac_addr);
 	dev_net_set(ndev, wiphy_net(cfg_to_wiphy(drvr->config)));
 
 	INIT_WORK(&ifp->multicast_work, _brcmf_set_multicast_list);
@@ -830,7 +830,7 @@ static int brcmf_net_p2p_attach(struct brcmf_if *ifp)
 	ndev->netdev_ops = &brcmf_netdev_ops_p2p;
 
 	/* set the mac address */
-	memcpy(ndev->dev_addr, ifp->mac_addr, ETH_ALEN);
+	eth_hw_addr_set(ndev, ifp->mac_addr);
 
 	if (register_netdev(ndev) != 0) {
 		bphy_err(drvr, "couldn't register the p2p net device\n");
diff --git a/drivers/net/wireless/intel/ipw2x00/ipw2100.c b/drivers/net/wireless/intel/ipw2x00/ipw2100.c
index 47eb89b773cf..2ace2b27ecad 100644
--- a/drivers/net/wireless/intel/ipw2x00/ipw2100.c
+++ b/drivers/net/wireless/intel/ipw2x00/ipw2100.c
@@ -4685,7 +4685,7 @@ static int ipw2100_read_mac_address(struct ipw2100_priv *priv)
 		return -EIO;
 	}
 
-	memcpy(priv->net_dev->dev_addr, addr, ETH_ALEN);
+	eth_hw_addr_set(priv->net_dev, addr);
 	IPW_DEBUG_INFO("card MAC is %pM\n", priv->net_dev->dev_addr);
 
 	return 0;
@@ -4712,7 +4712,7 @@ static int ipw2100_set_mac_address(struct ipw2100_priv *priv, int batch_mode)
 
 	if (priv->config & CFG_CUSTOM_MAC) {
 		memcpy(cmd.host_command_parameters, priv->mac_addr, ETH_ALEN);
-		memcpy(priv->net_dev->dev_addr, priv->mac_addr, ETH_ALEN);
+		eth_hw_addr_set(priv->net_dev, priv->mac_addr);
 	} else
 		memcpy(cmd.host_command_parameters, priv->net_dev->dev_addr,
 		       ETH_ALEN);
diff --git a/drivers/net/wireless/intel/ipw2x00/ipw2200.c b/drivers/net/wireless/intel/ipw2x00/ipw2200.c
index 9a99f482c84a..0a38d17744a9 100644
--- a/drivers/net/wireless/intel/ipw2x00/ipw2200.c
+++ b/drivers/net/wireless/intel/ipw2x00/ipw2200.c
@@ -11185,7 +11185,7 @@ static int ipw_up(struct ipw_priv *priv)
 		ipw_init_ordinals(priv);
 		if (!(priv->config & CFG_CUSTOM_MAC))
 			eeprom_parse_mac(priv, priv->mac_addr);
-		memcpy(priv->net_dev->dev_addr, priv->mac_addr, ETH_ALEN);
+		eth_hw_addr_set(priv->net_dev, priv->mac_addr);
 
 		ipw_set_geo(priv);
 
@@ -11542,7 +11542,7 @@ static int ipw_prom_alloc(struct ipw_priv *priv)
 	priv->prom_priv->priv = priv;
 
 	strcpy(priv->prom_net_dev->name, "rtap%d");
-	memcpy(priv->prom_net_dev->dev_addr, priv->mac_addr, ETH_ALEN);
+	eth_hw_addr_set(priv->prom_net_dev, priv->mac_addr);
 
 	priv->prom_net_dev->type = ARPHRD_IEEE80211_RADIOTAP;
 	priv->prom_net_dev->netdev_ops = &ipw_prom_netdev_ops;
diff --git a/drivers/net/wireless/intersil/hostap/hostap_main.c b/drivers/net/wireless/intersil/hostap/hostap_main.c
index 54f67b682b6a..787f685e70b4 100644
--- a/drivers/net/wireless/intersil/hostap/hostap_main.c
+++ b/drivers/net/wireless/intersil/hostap/hostap_main.c
@@ -713,9 +713,9 @@ static int prism2_set_mac_address(struct net_device *dev, void *p)
 	read_lock_bh(&local->iface_lock);
 	list_for_each(ptr, &local->hostap_interfaces) {
 		iface = list_entry(ptr, struct hostap_interface, list);
-		memcpy(iface->dev->dev_addr, addr->sa_data, ETH_ALEN);
+		eth_hw_addr_set(iface->dev, addr->sa_data);
 	}
-	memcpy(local->dev->dev_addr, addr->sa_data, ETH_ALEN);
+	eth_hw_addr_set(local->dev, addr->sa_data);
 	read_unlock_bh(&local->iface_lock);
 
 	return 0;
diff --git a/drivers/net/wireless/intersil/orinoco/main.c b/drivers/net/wireless/intersil/orinoco/main.c
index 0e73a10cc06c..7df88d20ff3d 100644
--- a/drivers/net/wireless/intersil/orinoco/main.c
+++ b/drivers/net/wireless/intersil/orinoco/main.c
@@ -2265,7 +2265,7 @@ int orinoco_if_add(struct orinoco_private *priv,
 
 	netif_carrier_off(dev);
 
-	memcpy(dev->dev_addr, wiphy->perm_addr, ETH_ALEN);
+	eth_hw_addr_set(dev, wiphy->perm_addr);
 
 	dev->base_addr = base_addr;
 	dev->irq = irq;
diff --git a/drivers/net/wireless/marvell/libertas/cmd.c b/drivers/net/wireless/marvell/libertas/cmd.c
index a4d9dd73b258..104d2b6dc9af 100644
--- a/drivers/net/wireless/marvell/libertas/cmd.c
+++ b/drivers/net/wireless/marvell/libertas/cmd.c
@@ -150,10 +150,9 @@ int lbs_update_hw_spec(struct lbs_private *priv)
 		memmove(priv->current_addr, cmd.permanentaddr, ETH_ALEN);
 
 	if (!priv->copied_hwaddr) {
-		memcpy(priv->dev->dev_addr, priv->current_addr, ETH_ALEN);
+		eth_hw_addr_set(priv->dev, priv->current_addr);
 		if (priv->mesh_dev)
-			memcpy(priv->mesh_dev->dev_addr,
-				priv->current_addr, ETH_ALEN);
+			eth_hw_addr_set(priv->mesh_dev, priv->current_addr);
 		priv->copied_hwaddr = 1;
 	}
 
diff --git a/drivers/net/wireless/marvell/libertas/main.c b/drivers/net/wireless/marvell/libertas/main.c
index 64fc5e410864..5c9f295536ea 100644
--- a/drivers/net/wireless/marvell/libertas/main.c
+++ b/drivers/net/wireless/marvell/libertas/main.c
@@ -302,9 +302,9 @@ int lbs_set_mac_address(struct net_device *dev, void *addr)
 	dev = priv->dev;
 
 	memcpy(priv->current_addr, phwaddr->sa_data, ETH_ALEN);
-	memcpy(dev->dev_addr, phwaddr->sa_data, ETH_ALEN);
+	eth_hw_addr_set(dev, phwaddr->sa_data);
 	if (priv->mesh_dev)
-		memcpy(priv->mesh_dev->dev_addr, phwaddr->sa_data, ETH_ALEN);
+		eth_hw_addr_set(priv->mesh_dev, phwaddr->sa_data);
 
 	return ret;
 }
diff --git a/drivers/net/wireless/marvell/mwifiex/uap_event.c b/drivers/net/wireless/marvell/mwifiex/uap_event.c
index 9121447e2701..2e25d72dcac5 100644
--- a/drivers/net/wireless/marvell/mwifiex/uap_event.c
+++ b/drivers/net/wireless/marvell/mwifiex/uap_event.c
@@ -197,8 +197,7 @@ int mwifiex_process_uap_event(struct mwifiex_private *priv)
 		mwifiex_dbg(adapter, EVENT,
 			    "AP EVENT: event id: %#x\n", eventcause);
 		priv->port_open = false;
-		memcpy(priv->netdev->dev_addr, adapter->event_body + 2,
-		       ETH_ALEN);
+		eth_hw_addr_set(priv->netdev, adapter->event_body + 2);
 		if (priv->hist_data)
 			mwifiex_hist_data_reset(priv);
 		mwifiex_check_uap_capabilities(priv, adapter->event_skb);
diff --git a/drivers/net/wireless/quantenna/qtnfmac/core.c b/drivers/net/wireless/quantenna/qtnfmac/core.c
index 01725237836e..907a1c2c1b6d 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/core.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/core.c
@@ -179,7 +179,7 @@ static int qtnf_netdev_set_mac_address(struct net_device *ndev, void *addr)
 					     sa->sa_data);
 
 	if (ret)
-		memcpy(ndev->dev_addr, old_addr, ETH_ALEN);
+		eth_hw_addr_set(ndev, old_addr);
 
 	return ret;
 }
-- 
2.31.1

