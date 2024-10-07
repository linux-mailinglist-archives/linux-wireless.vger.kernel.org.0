Return-Path: <linux-wireless+bounces-13642-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0086993773
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 21:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69694284CF6
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 19:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FAA71DDA3C;
	Mon,  7 Oct 2024 19:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="YyfCT6lK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2C91DE2A6
	for <linux-wireless@vger.kernel.org>; Mon,  7 Oct 2024 19:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728329732; cv=none; b=Ua1yq4auK6wFUv97wWDpu+bup8N52iENBrIouST/NOjv7sEI5m16V6SHP41524ncudDHCzoviXUdL+wPQ0H3zLdgXj2tEUN42pitSfFi1xw1iCUfotZk5aKSmJIrQ1fvHL1IvaSGSNyLSilB2njwpgIJ0Wx8+/1nWYMwyCJPPLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728329732; c=relaxed/simple;
	bh=etgsORkkKQbefDggb5bu0oyWYsdQsAj9Cb9qrYZXpcY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EZuLcCj4d9+QYUI2yGJDDqpAJWeIIT8FU0lkNcqjWiPMcDENsKLdH8Qg0Wv/vi3ayZC9NNcnlS4tq6WXwjQ0iM0WbegJ21qThPTyn3gS21x+UgxUHWc5jRPkCUCQf/LEJ6ayZmTmkJMKTpoPRhEWUTCzEp7/WpZILAY6Q2QpkME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=YyfCT6lK; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=hs1vGEsu5yi9gm8qjGbEp0yxKJGt+WBhtNxc6Lu3rxw=; t=1728329729; x=1729539329; 
	b=YyfCT6lKbDBmW5iApnKT4yaK9aQ3WznaWf5XVIDDn3Ri4EO6sJEaamK3iCw4NtLHnqxXHnvWzI6
	i1uYeqxRKDXsN9mPxKcJ50RjxAJ1HIG8hzoLKoP5SfjxpyhFV2/p4LD7NtO4vC0fdGkqy2CgV+irY
	dVzKCbtz5BEMlQK4/dHLocUujMcg/HIFu1UuSvnI+aSSGfvwS+Axv20/8YPyfxdLoPXspdOsJdQd7
	99lYDfHQVSMg6WJK+8ACZCuDFfUPFcyAE1GsG+75Kvzc4RX6Gn3Y5cgFgJjmZFQStQ7ZDpshOeepQ
	QogRc1lNbuiUPnuFfYFFF/B1ngG4jR+l0lMQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sxtVu-00000003Vid-23yQ;
	Mon, 07 Oct 2024 21:35:26 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] wifi: remove iw_public_data from struct net_device
Date: Mon,  7 Oct 2024 21:35:25 +0200
Message-ID: <20241007213525.8b2d52b60531.I6a27aaf30bded9a0977f07f47fba2bd31a3b3330@changeid>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Given the previous patches, we no longer need the
struct iw_public_data etc., it's only used by the
old Intel drivers (and ps3_gelic creates it but
then doesn't use it). Remove all of that, including
the pointer in struct net_device.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 .../networking/net_cachelines/net_device.rst   |  1 -
 .../net/ethernet/toshiba/ps3_gelic_wireless.c  |  1 -
 .../net/ethernet/toshiba/ps3_gelic_wireless.h  |  1 -
 drivers/net/wireless/intel/ipw2x00/ipw2100.c   |  2 --
 drivers/net/wireless/intel/ipw2x00/ipw2100.h   |  2 --
 drivers/net/wireless/intel/ipw2x00/ipw2200.c   |  1 -
 drivers/net/wireless/intel/ipw2x00/ipw2200.h   |  2 --
 .../net/wireless/intel/ipw2x00/libipw_spy.c    |  7 ++++---
 include/linux/netdevice.h                      |  2 --
 include/net/iw_handler.h                       | 18 ------------------
 10 files changed, 4 insertions(+), 33 deletions(-)

diff --git a/Documentation/networking/net_cachelines/net_device.rst b/Documentation/networking/net_cachelines/net_device.rst
index 22b07c814f4a..b7d1d4c7a1ab 100644
--- a/Documentation/networking/net_cachelines/net_device.rst
+++ b/Documentation/networking/net_cachelines/net_device.rst
@@ -51,7 +51,6 @@ struct_net_device_core_stats*       core_stats
 atomic_t                            carrier_up_count                                                
 atomic_t                            carrier_down_count                                              
 struct_iw_handler_def*              wireless_handlers                                               
-struct_iw_public_data*              wireless_data                                                   
 struct_ethtool_ops*                 ethtool_ops                                                     
 struct_l3mdev_ops*                  l3mdev_ops                                                      
 struct_ndisc_ops*                   ndisc_ops                                                       
diff --git a/drivers/net/ethernet/toshiba/ps3_gelic_wireless.c b/drivers/net/ethernet/toshiba/ps3_gelic_wireless.c
index 44488c153ea2..4fbe4b7cd12a 100644
--- a/drivers/net/ethernet/toshiba/ps3_gelic_wireless.c
+++ b/drivers/net/ethernet/toshiba/ps3_gelic_wireless.c
@@ -2566,7 +2566,6 @@ static void gelic_wl_setup_netdev_ops(struct net_device *netdev)
 
 	netdev->ethtool_ops = &gelic_wl_ethtool_ops;
 	netdev->netdev_ops = &gelic_wl_netdevice_ops;
-	netdev->wireless_data = &wl->wireless_data;
 	netdev->wireless_handlers = &gelic_wl_wext_handler_def;
 }
 
diff --git a/drivers/net/ethernet/toshiba/ps3_gelic_wireless.h b/drivers/net/ethernet/toshiba/ps3_gelic_wireless.h
index 1f203d1ae8db..dbabf538e10a 100644
--- a/drivers/net/ethernet/toshiba/ps3_gelic_wireless.h
+++ b/drivers/net/ethernet/toshiba/ps3_gelic_wireless.h
@@ -276,7 +276,6 @@ struct gelic_wl_info {
 	u8 active_bssid[ETH_ALEN]; /* associated bssid */
 	unsigned int essid_len;
 
-	struct iw_public_data wireless_data;
 	struct iw_statistics iwstat;
 };
 
diff --git a/drivers/net/wireless/intel/ipw2x00/ipw2100.c b/drivers/net/wireless/intel/ipw2x00/ipw2100.c
index a89e06c1b8ee..15bf35f2de2a 100644
--- a/drivers/net/wireless/intel/ipw2x00/ipw2100.c
+++ b/drivers/net/wireless/intel/ipw2x00/ipw2100.c
@@ -6022,8 +6022,6 @@ static struct net_device *ipw2100_alloc_device(struct pci_dev *pci_dev,
 	dev->netdev_ops = &ipw2100_netdev_ops;
 	dev->ethtool_ops = &ipw2100_ethtool_ops;
 	dev->wireless_handlers = &ipw2100_wx_handler_def;
-	priv->wireless_data.libipw = priv->ieee;
-	dev->wireless_data = &priv->wireless_data;
 	dev->watchdog_timeo = 3 * HZ;
 	dev->irq = 0;
 	dev->min_mtu = 68;
diff --git a/drivers/net/wireless/intel/ipw2x00/ipw2100.h b/drivers/net/wireless/intel/ipw2x00/ipw2100.h
index b34085ade3aa..6f81f509b9cb 100644
--- a/drivers/net/wireless/intel/ipw2x00/ipw2100.h
+++ b/drivers/net/wireless/intel/ipw2x00/ipw2100.h
@@ -554,8 +554,6 @@ struct ipw2100_priv {
 	struct net_device *net_dev;
 	struct iw_statistics wstats;
 
-	struct iw_public_data wireless_data;
-
 	struct tasklet_struct irq_tasklet;
 
 	struct delayed_work reset_work;
diff --git a/drivers/net/wireless/intel/ipw2x00/ipw2200.c b/drivers/net/wireless/intel/ipw2x00/ipw2200.c
index c0e9d2109e34..be1d971b3d32 100644
--- a/drivers/net/wireless/intel/ipw2x00/ipw2200.c
+++ b/drivers/net/wireless/intel/ipw2x00/ipw2200.c
@@ -11645,7 +11645,6 @@ static int ipw_pci_probe(struct pci_dev *pdev,
 
 	net_dev->netdev_ops = &ipw_netdev_ops;
 	priv->ieee->spy_enabled = true;
-	net_dev->wireless_data = &priv->wireless_data;
 	net_dev->wireless_handlers = &ipw_wx_handler_def;
 	net_dev->ethtool_ops = &ipw_ethtool_ops;
 
diff --git a/drivers/net/wireless/intel/ipw2x00/ipw2200.h b/drivers/net/wireless/intel/ipw2x00/ipw2200.h
index 46f119123b49..d3db54e6d37c 100644
--- a/drivers/net/wireless/intel/ipw2x00/ipw2200.h
+++ b/drivers/net/wireless/intel/ipw2x00/ipw2200.h
@@ -1274,8 +1274,6 @@ struct ipw_priv {
 
 	struct iw_statistics wstats;
 
-	struct iw_public_data wireless_data;
-
 	int user_requested_scan;
 	u8 direct_scan_ssid[IW_ESSID_MAX_SIZE];
 	u8 direct_scan_ssid_len;
diff --git a/drivers/net/wireless/intel/ipw2x00/libipw_spy.c b/drivers/net/wireless/intel/ipw2x00/libipw_spy.c
index 979aeb10aeeb..ba876e92f7f6 100644
--- a/drivers/net/wireless/intel/ipw2x00/libipw_spy.c
+++ b/drivers/net/wireless/intel/ipw2x00/libipw_spy.c
@@ -18,9 +18,10 @@
 
 static struct iw_spy_data *get_spydata(struct net_device *dev)
 {
-	if (dev->wireless_data && dev->wireless_data->libipw &&
-	    dev->wireless_data->libipw->spy_enabled)
-		return &dev->wireless_data->libipw->spy_data;
+	struct libipw_device *ieee = netdev_priv(dev);
+
+	if (ieee->spy_enabled)
+		return &ieee->spy_data;
 	return NULL;
 }
 
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index e87b5e488325..f0abed1e6e45 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1773,7 +1773,6 @@ enum netdev_reg_state {
  *	@wireless_handlers:	List of functions to handle Wireless Extensions,
  *				instead of ioctl,
  *				see <net/iw_handler.h> for details.
- *	@wireless_data:	Instance data managed by the core of wireless extensions
  *
  *	@netdev_ops:	Includes several pointers to callbacks,
  *			if one wants to override the ndo_*() functions
@@ -2150,7 +2149,6 @@ struct net_device {
 
 #ifdef CONFIG_WIRELESS_EXT
 	const struct iw_handler_def *wireless_handlers;
-	struct iw_public_data	*wireless_data;
 #endif
 	const struct ethtool_ops *ethtool_ops;
 #ifdef CONFIG_NET_L3_MASTER_DEV
diff --git a/include/net/iw_handler.h b/include/net/iw_handler.h
index a7b502958d27..fc44fcca1d5c 100644
--- a/include/net/iw_handler.h
+++ b/include/net/iw_handler.h
@@ -404,24 +404,6 @@ struct iw_spy_data {
 	u_char			spy_thr_under[IW_MAX_SPY];
 };
 
-/* --------------------- DEVICE WIRELESS DATA --------------------- */
-/*
- * This is all the wireless data specific to a device instance that
- * is managed by the core of Wireless Extensions or the 802.11 layer.
- * We only keep pointer to those structures, so that a driver is free
- * to share them between instances.
- * This structure should be initialised before registering the device.
- * Access to this data follow the same rules as any other struct net_device
- * data (i.e. valid as long as struct net_device exist, same locking rules).
- */
-/* Forward declaration */
-struct libipw_device;
-/* The struct */
-struct iw_public_data {
-	/* Legacy structure managed by the ipw2x00-specific IEEE 802.11 layer */
-	struct libipw_device *		libipw;
-};
-
 /**************************** PROTOTYPES ****************************/
 /*
  * Functions part of the Wireless Extensions (defined in net/wireless/wext-core.c).
-- 
2.46.2


