Return-Path: <linux-wireless+bounces-8207-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D13528D1E7B
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 16:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40953B22B27
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 14:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4D9171E57;
	Tue, 28 May 2024 14:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mIbzkBDz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44C516F8E9;
	Tue, 28 May 2024 14:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716906049; cv=none; b=M7ii1I8ovBqX5enb7Ok7LIhZp/Zdd76BhEgvW8YyPWNy7zLf8OWCzsi1EXlVqplIgwgJWVrUMScmSNRA7AFrNuYZnO0BIULt0rQLeGiPkld1Yvk/N3cvw+Ernf9yRKLWl6WnnnsgviU3l1WDh1kAQ8y66BqFPl7FpfvaA4RWN2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716906049; c=relaxed/simple;
	bh=hH1NSapGvIL9B5gRzd67n4mIjkMz2l2Q0Y5vX/abyNw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U8CSXkvhvDBway3QEeGVkUtD40ZsXUa0aqWgYvjCQRG6U6dBxw9qlhvD8Mk6G1aVSLODwCinIjxs8hqKxPVCtXEBqsDcfG7gySvroT4VAxRQ4fRqeBWqMrKuQcoxIRTAGG7wgxWYouQLcYfdldAXr1zSd4t3EbXqBFaIXENcC7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mIbzkBDz; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 201FA240003;
	Tue, 28 May 2024 14:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1716906044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OAOCBHHJ48ic3cXUxfC22sMmUADtsa1aIUSvwK+GTLc=;
	b=mIbzkBDzvoV1kY1cwXDPx++4Gg8etGMRgVGaWeImmuDeWiO/AvgXe9sZsMnjaZeloVgfMk
	NbVQZgtDrHFrzV+1j9T9UvgK8ecIlC3TIcK6lbrAHPsKE0XQ19L/KsMgKwiJySWnHD9v6W
	OB8pGoq37kcoAwHgrrTkzV4OPHrRJzJueb2CgXIbxWAwxgZTo3uQKi+f/IFHukxKS479d0
	WTlKSIGKIKyfrqk+cAnQhR+Cw6VerA3g8cVjeCdL+wVo88VA7rbsRT2DCNPaKFM539Vwhx
	JmKulBSdwsB5QL8qhXh6NHH7BObgBYcVsv0/SEd1+hhyrji+A64YoRSVPRkG2g==
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Date: Tue, 28 May 2024 16:20:28 +0200
Subject: [PATCH wireless 1/3] Revert "wifi: wilc1000: convert list
 management to RCU"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240528-wilc_revert_srcu_to_rcu-v1-1-bce096e0798c@bootlin.com>
References: <20240528-wilc_revert_srcu_to_rcu-v1-0-bce096e0798c@bootlin.com>
In-Reply-To: <20240528-wilc_revert_srcu_to_rcu-v1-0-bce096e0798c@bootlin.com>
To: linux-wireless@vger.kernel.org
Cc: Ajay Singh <ajay.kathat@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Kalle Valo <kvalo@kernel.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: alexis.lothore@bootlin.com

This reverts commit f236464f1db7bea80075e6e31ac70dc6eb80547f

Commit f236464f1db7 ("wifi: wilc1000: convert list management to RCU")
replaced SRCU with RCU, aiming to simplify RCU usage in the driver. No
documentation or commit history hinted about why SRCU has been preferred
in original design, so it has been assumed to be safe to do this
conversion.
Unfortunately, some static analyzers raised warnings, confirmed by runtime
checker, not long after the merge. At least three different issues arose
when switching to RCU:
- wilc_wlan_txq_filter_dup_tcp_ack is executed in a RCU read critical
  section yet calls wait_for_completion_timeout
- wilc_wfi_init_mon_interface calls kmalloc and register_netdevice while
  manipulating a vif retrieved from vif list
- set_channel sends command to chip (and so, also waits for a completion)
  while holding a vif retrieved from vif list (so, in RCU read critical
  section)

Some of those issues are not trivial to fix and would need bigger driver
rework. Fix those issues by reverting the SRCU to RCU conversion commit

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/linux-wireless/3b46ec7c-baee-49fd-b760-3bc12fb12eaf@moroto.mountain/
Fixes: f236464f1db7 ("wifi: wilc1000: convert list management to RCU")
Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
---
 drivers/net/wireless/microchip/wilc1000/cfg80211.c | 41 ++++++++++++---------
 drivers/net/wireless/microchip/wilc1000/hif.c      | 15 +++++---
 drivers/net/wireless/microchip/wilc1000/netdev.c   | 43 +++++++++++++---------
 drivers/net/wireless/microchip/wilc1000/netdev.h   |  5 ++-
 drivers/net/wireless/microchip/wilc1000/wlan.c     |  5 ++-
 5 files changed, 64 insertions(+), 45 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/cfg80211.c b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
index 7d9fb9f2d527..089102ed9ae5 100644
--- a/drivers/net/wireless/microchip/wilc1000/cfg80211.c
+++ b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
@@ -237,11 +237,12 @@ static int set_channel(struct wiphy *wiphy,
 	struct wilc_vif *vif;
 	u32 channelnum;
 	int result;
+	int srcu_idx;
 
-	rcu_read_lock();
+	srcu_idx = srcu_read_lock(&wl->srcu);
 	vif = wilc_get_wl_to_vif(wl);
 	if (IS_ERR(vif)) {
-		rcu_read_unlock();
+		srcu_read_unlock(&wl->srcu, srcu_idx);
 		return PTR_ERR(vif);
 	}
 
@@ -252,7 +253,7 @@ static int set_channel(struct wiphy *wiphy,
 	if (result)
 		netdev_err(vif->ndev, "Error in setting channel\n");
 
-	rcu_read_unlock();
+	srcu_read_unlock(&wl->srcu, srcu_idx);
 	return result;
 }
 
@@ -805,8 +806,9 @@ static int set_wiphy_params(struct wiphy *wiphy, u32 changed)
 	struct wilc *wl = wiphy_priv(wiphy);
 	struct wilc_vif *vif;
 	struct wilc_priv *priv;
+	int srcu_idx;
 
-	rcu_read_lock();
+	srcu_idx = srcu_read_lock(&wl->srcu);
 	vif = wilc_get_wl_to_vif(wl);
 	if (IS_ERR(vif))
 		goto out;
@@ -861,7 +863,7 @@ static int set_wiphy_params(struct wiphy *wiphy, u32 changed)
 		netdev_err(priv->dev, "Error in setting WIPHY PARAMS\n");
 
 out:
-	rcu_read_unlock();
+	srcu_read_unlock(&wl->srcu, srcu_idx);
 	return ret;
 }
 
@@ -1537,19 +1539,20 @@ static struct wireless_dev *add_virtual_intf(struct wiphy *wiphy,
 
 	if (type == NL80211_IFTYPE_MONITOR) {
 		struct net_device *ndev;
+		int srcu_idx;
 
-		rcu_read_lock();
+		srcu_idx = srcu_read_lock(&wl->srcu);
 		vif = wilc_get_vif_from_type(wl, WILC_AP_MODE);
 		if (!vif) {
 			vif = wilc_get_vif_from_type(wl, WILC_GO_MODE);
 			if (!vif) {
-				rcu_read_unlock();
+				srcu_read_unlock(&wl->srcu, srcu_idx);
 				goto validate_interface;
 			}
 		}
 
 		if (vif->monitor_flag) {
-			rcu_read_unlock();
+			srcu_read_unlock(&wl->srcu, srcu_idx);
 			goto validate_interface;
 		}
 
@@ -1557,12 +1560,12 @@ static struct wireless_dev *add_virtual_intf(struct wiphy *wiphy,
 		if (ndev) {
 			vif->monitor_flag = 1;
 		} else {
-			rcu_read_unlock();
+			srcu_read_unlock(&wl->srcu, srcu_idx);
 			return ERR_PTR(-EINVAL);
 		}
 
 		wdev = &vif->priv.wdev;
-		rcu_read_unlock();
+		srcu_read_unlock(&wl->srcu, srcu_idx);
 		return wdev;
 	}
 
@@ -1610,7 +1613,7 @@ static int del_virtual_intf(struct wiphy *wiphy, struct wireless_dev *wdev)
 	list_del_rcu(&vif->list);
 	wl->vif_num--;
 	mutex_unlock(&wl->vif_mutex);
-	synchronize_rcu();
+	synchronize_srcu(&wl->srcu);
 	return 0;
 }
 
@@ -1635,23 +1638,25 @@ static void wilc_set_wakeup(struct wiphy *wiphy, bool enabled)
 {
 	struct wilc *wl = wiphy_priv(wiphy);
 	struct wilc_vif *vif;
+	int srcu_idx;
 
-	rcu_read_lock();
+	srcu_idx = srcu_read_lock(&wl->srcu);
 	vif = wilc_get_wl_to_vif(wl);
 	if (IS_ERR(vif)) {
-		rcu_read_unlock();
+		srcu_read_unlock(&wl->srcu, srcu_idx);
 		return;
 	}
 
 	netdev_info(vif->ndev, "cfg set wake up = %d\n", enabled);
 	wilc_set_wowlan_trigger(vif, enabled);
-	rcu_read_unlock();
+	srcu_read_unlock(&wl->srcu, srcu_idx);
 }
 
 static int set_tx_power(struct wiphy *wiphy, struct wireless_dev *wdev,
 			enum nl80211_tx_power_setting type, int mbm)
 {
 	int ret;
+	int srcu_idx;
 	s32 tx_power = MBM_TO_DBM(mbm);
 	struct wilc *wl = wiphy_priv(wiphy);
 	struct wilc_vif *vif;
@@ -1659,10 +1664,10 @@ static int set_tx_power(struct wiphy *wiphy, struct wireless_dev *wdev,
 	if (!wl->initialized)
 		return -EIO;
 
-	rcu_read_lock();
+	srcu_idx = srcu_read_lock(&wl->srcu);
 	vif = wilc_get_wl_to_vif(wl);
 	if (IS_ERR(vif)) {
-		rcu_read_unlock();
+		srcu_read_unlock(&wl->srcu, srcu_idx);
 		return -EINVAL;
 	}
 
@@ -1674,7 +1679,7 @@ static int set_tx_power(struct wiphy *wiphy, struct wireless_dev *wdev,
 	ret = wilc_set_tx_power(vif, tx_power);
 	if (ret)
 		netdev_err(vif->ndev, "Failed to set tx power\n");
-	rcu_read_unlock();
+	srcu_read_unlock(&wl->srcu, srcu_idx);
 
 	return ret;
 }
@@ -1757,6 +1762,7 @@ static void wlan_init_locks(struct wilc *wl)
 	init_completion(&wl->cfg_event);
 	init_completion(&wl->sync_event);
 	init_completion(&wl->txq_thread_started);
+	init_srcu_struct(&wl->srcu);
 }
 
 void wlan_deinit_locks(struct wilc *wilc)
@@ -1767,6 +1773,7 @@ void wlan_deinit_locks(struct wilc *wilc)
 	mutex_destroy(&wilc->txq_add_to_head_cs);
 	mutex_destroy(&wilc->vif_mutex);
 	mutex_destroy(&wilc->deinit_lock);
+	cleanup_srcu_struct(&wilc->srcu);
 }
 
 int wilc_cfg80211_init(struct wilc **wilc, struct device *dev, int io_type,
diff --git a/drivers/net/wireless/microchip/wilc1000/hif.c b/drivers/net/wireless/microchip/wilc1000/hif.c
index 919de6ffb821..3925ca653e80 100644
--- a/drivers/net/wireless/microchip/wilc1000/hif.c
+++ b/drivers/net/wireless/microchip/wilc1000/hif.c
@@ -1570,11 +1570,12 @@ void wilc_network_info_received(struct wilc *wilc, u8 *buffer, u32 length)
 	struct host_if_drv *hif_drv;
 	struct host_if_msg *msg;
 	struct wilc_vif *vif;
+	int srcu_idx;
 	int result;
 	int id;
 
 	id = get_unaligned_le32(&buffer[length - 4]);
-	rcu_read_lock();
+	srcu_idx = srcu_read_lock(&wilc->srcu);
 	vif = wilc_get_vif_from_idx(wilc, id);
 	if (!vif)
 		goto out;
@@ -1606,7 +1607,7 @@ void wilc_network_info_received(struct wilc *wilc, u8 *buffer, u32 length)
 		kfree(msg);
 	}
 out:
-	rcu_read_unlock();
+	srcu_read_unlock(&wilc->srcu, srcu_idx);
 }
 
 void wilc_gnrl_async_info_received(struct wilc *wilc, u8 *buffer, u32 length)
@@ -1614,13 +1615,14 @@ void wilc_gnrl_async_info_received(struct wilc *wilc, u8 *buffer, u32 length)
 	struct host_if_drv *hif_drv;
 	struct host_if_msg *msg;
 	struct wilc_vif *vif;
+	int srcu_idx;
 	int result;
 	int id;
 
 	mutex_lock(&wilc->deinit_lock);
 
 	id = get_unaligned_le32(&buffer[length - 4]);
-	rcu_read_lock();
+	srcu_idx = srcu_read_lock(&wilc->srcu);
 	vif = wilc_get_vif_from_idx(wilc, id);
 	if (!vif)
 		goto out;
@@ -1647,7 +1649,7 @@ void wilc_gnrl_async_info_received(struct wilc *wilc, u8 *buffer, u32 length)
 		kfree(msg);
 	}
 out:
-	rcu_read_unlock();
+	srcu_read_unlock(&wilc->srcu, srcu_idx);
 	mutex_unlock(&wilc->deinit_lock);
 }
 
@@ -1655,11 +1657,12 @@ void wilc_scan_complete_received(struct wilc *wilc, u8 *buffer, u32 length)
 {
 	struct host_if_drv *hif_drv;
 	struct wilc_vif *vif;
+	int srcu_idx;
 	int result;
 	int id;
 
 	id = get_unaligned_le32(&buffer[length - 4]);
-	rcu_read_lock();
+	srcu_idx = srcu_read_lock(&wilc->srcu);
 	vif = wilc_get_vif_from_idx(wilc, id);
 	if (!vif)
 		goto out;
@@ -1684,7 +1687,7 @@ void wilc_scan_complete_received(struct wilc *wilc, u8 *buffer, u32 length)
 		}
 	}
 out:
-	rcu_read_unlock();
+	srcu_read_unlock(&wilc->srcu, srcu_idx);
 }
 
 int wilc_remain_on_channel(struct wilc_vif *vif, u64 cookie, u16 chan,
diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.c b/drivers/net/wireless/microchip/wilc1000/netdev.c
index 73f56f7b002b..710e29bea560 100644
--- a/drivers/net/wireless/microchip/wilc1000/netdev.c
+++ b/drivers/net/wireless/microchip/wilc1000/netdev.c
@@ -127,28 +127,30 @@ void wilc_wlan_set_bssid(struct net_device *wilc_netdev, const u8 *bssid,
 
 int wilc_wlan_get_num_conn_ifcs(struct wilc *wilc)
 {
+	int srcu_idx;
 	u8 ret_val = 0;
 	struct wilc_vif *vif;
 
-	rcu_read_lock();
+	srcu_idx = srcu_read_lock(&wilc->srcu);
 	wilc_for_each_vif(wilc, vif) {
 		if (!is_zero_ether_addr(vif->bssid))
 			ret_val++;
 	}
-	rcu_read_unlock();
+	srcu_read_unlock(&wilc->srcu, srcu_idx);
 	return ret_val;
 }
 
 static void wilc_wake_tx_queues(struct wilc *wl)
 {
+	int srcu_idx;
 	struct wilc_vif *ifc;
 
-	rcu_read_lock();
+	srcu_idx = srcu_read_lock(&wl->srcu);
 	wilc_for_each_vif(wl, ifc) {
 		if (ifc->mac_opened && netif_queue_stopped(ifc->ndev))
 			netif_wake_queue(ifc->ndev);
 	}
-	rcu_read_unlock();
+	srcu_read_unlock(&wl->srcu, srcu_idx);
 }
 
 static int wilc_txq_task(void *vp)
@@ -653,6 +655,7 @@ static int wilc_set_mac_addr(struct net_device *dev, void *p)
 	struct sockaddr *addr = (struct sockaddr *)p;
 	unsigned char mac_addr[ETH_ALEN];
 	struct wilc_vif *tmp_vif;
+	int srcu_idx;
 
 	if (!is_valid_ether_addr(addr->sa_data))
 		return -EADDRNOTAVAIL;
@@ -664,19 +667,19 @@ static int wilc_set_mac_addr(struct net_device *dev, void *p)
 
 	/* Verify MAC Address is not already in use: */
 
-	rcu_read_lock();
+	srcu_idx = srcu_read_lock(&wilc->srcu);
 	wilc_for_each_vif(wilc, tmp_vif) {
 		wilc_get_mac_address(tmp_vif, mac_addr);
 		if (ether_addr_equal(addr->sa_data, mac_addr)) {
 			if (vif != tmp_vif) {
-				rcu_read_unlock();
+				srcu_read_unlock(&wilc->srcu, srcu_idx);
 				return -EADDRNOTAVAIL;
 			}
-			rcu_read_unlock();
+			srcu_read_unlock(&wilc->srcu, srcu_idx);
 			return 0;
 		}
 	}
-	rcu_read_unlock();
+	srcu_read_unlock(&wilc->srcu, srcu_idx);
 
 	result = wilc_set_mac_address(vif, (u8 *)addr->sa_data);
 	if (result)
@@ -764,14 +767,15 @@ netdev_tx_t wilc_mac_xmit(struct sk_buff *skb, struct net_device *ndev)
 						wilc_tx_complete);
 
 	if (queue_count > FLOW_CONTROL_UPPER_THRESHOLD) {
+		int srcu_idx;
 		struct wilc_vif *vif;
 
-		rcu_read_lock();
+		srcu_idx = srcu_read_lock(&wilc->srcu);
 		wilc_for_each_vif(wilc, vif) {
 			if (vif->mac_opened)
 				netif_stop_queue(vif->ndev);
 		}
-		rcu_read_unlock();
+		srcu_read_unlock(&wilc->srcu, srcu_idx);
 	}
 
 	return NETDEV_TX_OK;
@@ -815,12 +819,13 @@ void wilc_frmw_to_host(struct wilc *wilc, u8 *buff, u32 size,
 	unsigned int frame_len = 0;
 	struct wilc_vif *vif;
 	struct sk_buff *skb;
+	int srcu_idx;
 	int stats;
 
 	if (!wilc)
 		return;
 
-	rcu_read_lock();
+	srcu_idx = srcu_read_lock(&wilc->srcu);
 	wilc_netdev = get_if_handler(wilc, buff);
 	if (!wilc_netdev)
 		goto out;
@@ -848,14 +853,15 @@ void wilc_frmw_to_host(struct wilc *wilc, u8 *buff, u32 size,
 		netdev_dbg(wilc_netdev, "netif_rx ret value is: %d\n", stats);
 	}
 out:
-	rcu_read_unlock();
+	srcu_read_unlock(&wilc->srcu, srcu_idx);
 }
 
 void wilc_wfi_mgmt_rx(struct wilc *wilc, u8 *buff, u32 size, bool is_auth)
 {
+	int srcu_idx;
 	struct wilc_vif *vif;
 
-	rcu_read_lock();
+	srcu_idx = srcu_read_lock(&wilc->srcu);
 	wilc_for_each_vif(wilc, vif) {
 		struct ieee80211_mgmt *mgmt = (struct ieee80211_mgmt *)buff;
 		u16 type = le16_to_cpup((__le16 *)buff);
@@ -876,7 +882,7 @@ void wilc_wfi_mgmt_rx(struct wilc *wilc, u8 *buff, u32 size, bool is_auth)
 		if (vif->monitor_flag)
 			wilc_wfi_monitor_rx(wilc->monitor_dev, buff, size);
 	}
-	rcu_read_unlock();
+	srcu_read_unlock(&wilc->srcu, srcu_idx);
 }
 
 static const struct net_device_ops wilc_netdev_ops = {
@@ -906,7 +912,7 @@ void wilc_netdev_cleanup(struct wilc *wilc)
 		list_del_rcu(&vif->list);
 		wilc->vif_num--;
 		mutex_unlock(&wilc->vif_mutex);
-		synchronize_rcu();
+		synchronize_srcu(&wilc->srcu);
 		if (vif->ndev)
 			unregister_netdev(vif->ndev);
 	}
@@ -925,15 +931,16 @@ static u8 wilc_get_available_idx(struct wilc *wl)
 {
 	int idx = 0;
 	struct wilc_vif *vif;
+	int srcu_idx;
 
-	rcu_read_lock();
+	srcu_idx = srcu_read_lock(&wl->srcu);
 	wilc_for_each_vif(wl, vif) {
 		if (vif->idx == 0)
 			idx = 1;
 		else
 			idx = 0;
 	}
-	rcu_read_unlock();
+	srcu_read_unlock(&wl->srcu, srcu_idx);
 	return idx;
 }
 
@@ -983,7 +990,7 @@ struct wilc_vif *wilc_netdev_ifc_init(struct wilc *wl, const char *name,
 	list_add_tail_rcu(&vif->list, &wl->vif_list);
 	wl->vif_num += 1;
 	mutex_unlock(&wl->vif_mutex);
-	synchronize_rcu();
+	synchronize_srcu(&wl->srcu);
 
 	return vif;
 
diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.h b/drivers/net/wireless/microchip/wilc1000/netdev.h
index eecee3973d6a..5937d6d45695 100644
--- a/drivers/net/wireless/microchip/wilc1000/netdev.h
+++ b/drivers/net/wireless/microchip/wilc1000/netdev.h
@@ -32,8 +32,8 @@
 
 #define wilc_for_each_vif(w, v) \
 	struct wilc *_w = w; \
-	list_for_each_entry_rcu(v, &_w->vif_list, list, \
-				 rcu_read_lock_held())
+	list_for_each_entry_srcu(v, &_w->vif_list, list, \
+				 srcu_read_lock_held(&_w->srcu))
 
 struct wilc_wfi_stats {
 	unsigned long rx_packets;
@@ -220,6 +220,7 @@ struct wilc {
 
 	/* protect vif list */
 	struct mutex vif_mutex;
+	struct srcu_struct srcu;
 	u8 open_ifcs;
 
 	/* protect head of transmit queue */
diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.c b/drivers/net/wireless/microchip/wilc1000/wlan.c
index 37c32d17856e..a9e872a7b2c3 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan.c
+++ b/drivers/net/wireless/microchip/wilc1000/wlan.c
@@ -712,6 +712,7 @@ int wilc_wlan_handle_txq(struct wilc *wilc, u32 *txq_count)
 	u32 *vmm_table = wilc->vmm_table;
 	u8 ac_pkt_num_to_chip[NQUEUES] = {0, 0, 0, 0};
 	const struct wilc_hif_func *func;
+	int srcu_idx;
 	u8 *txb = wilc->tx_buffer;
 	struct wilc_vif *vif;
 
@@ -723,10 +724,10 @@ int wilc_wlan_handle_txq(struct wilc *wilc, u32 *txq_count)
 
 	mutex_lock(&wilc->txq_add_to_head_cs);
 
-	rcu_read_lock();
+	srcu_idx = srcu_read_lock(&wilc->srcu);
 	wilc_for_each_vif(wilc, vif)
 		wilc_wlan_txq_filter_dup_tcp_ack(vif->ndev);
-	rcu_read_unlock();
+	srcu_read_unlock(&wilc->srcu, srcu_idx);
 
 	for (ac = 0; ac < NQUEUES; ac++)
 		tqe_q[ac] = wilc_wlan_txq_get_first(wilc, ac);

-- 
2.45.1


