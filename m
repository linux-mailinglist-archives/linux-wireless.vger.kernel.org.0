Return-Path: <linux-wireless+bounces-21654-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD39A91ECC
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 15:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77BAB7AE454
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 13:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F4924EF73;
	Thu, 17 Apr 2025 13:53:47 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C0E24EF65
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 13:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744898027; cv=none; b=kIFFmWNadjdklA1Hv7GXb7uIQFmYkntGD/ajc5GYEPhqvT2W2q11zQQqvwNAY7kbZZY+8qYQsJxMIeca0RhNM3nnIHavwt4h1u1NIzzdtYVo3Ds09Qii81bzSqV/grflk2xez32WMlZNIag1gM3QHdALz6tbSITCmArynGcJjBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744898027; c=relaxed/simple;
	bh=3+eUbsLPpjSU0tCw99VJHJrXkdBt2ZW/dgX5V02MF7g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=XLqyrbqs8yIFAxuuxCeZNEKyed9ORtGGhT4DDKZXD6PjhgQLJ5D5SaRwstRr5gf6pg3RwjqMx7YBgL3wOwG8mr/idZPymg9jOD9uZKmEoQPaLJ5QRxi3GZaBMULTG+oArpWhVklxQ6dsdRKLnlLYVqQVJXC9eF2vSP8kt6hbSrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: ox6e45XQSEezBZv5GAAzOw==
X-CSE-MsgGUID: S08UMYjHT3yGHZ0HyyfHyA==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 17 Apr 2025 22:53:45 +0900
Received: from localhost.localdomain (unknown [10.14.100.3])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 8B96F4006DE8;
	Thu, 17 Apr 2025 22:53:42 +0900 (JST)
From: Alexander Savchenko <oleksandr.savchenko.dn@bp.renesas.com>
To: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Sergiy Petrov <sergiy.petrov.ue@bp.renesas.com>,
	Viktor Barna <viktor.barna.rj@bp.renesas.com>,
	Gal Gur <gal.gur.jx@renesas.com>,
	Alexander Savchenko <oleksandr.savchenko.dn@bp.renesas.com>
Subject: [PATCH 14/38] ra6w: add dev.c
Date: Thu, 17 Apr 2025 16:52:12 +0300
Message-Id: <20250417135236.52410-15-oleksandr.savchenko.dn@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250417135236.52410-1-oleksandr.savchenko.dn@bp.renesas.com>
References: <20250417135236.52410-1-oleksandr.savchenko.dn@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

Part of the split. Please, take a look at the cover letter for more details

Reviewed-by: Viktor Barna <viktor.barna.rj@bp.renesas.com>
Reviewed-by: Gal Gur <gal.gur.jx@renesas.com>
Signed-off-by: Alexander Savchenko <oleksandr.savchenko.dn@bp.renesas.com>
---
 drivers/net/wireless/renesas/ra6w/dev.c | 233 ++++++++++++++++++++++++
 1 file changed, 233 insertions(+)
 create mode 100644 drivers/net/wireless/renesas/ra6w/dev.c

diff --git a/drivers/net/wireless/renesas/ra6w/dev.c b/drivers/net/wireless/renesas/ra6w/dev.c
new file mode 100644
index 000000000000..16716fb4fdd7
--- /dev/null
+++ b/drivers/net/wireless/renesas/ra6w/dev.c
@@ -0,0 +1,233 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * This file contains netdevice communication.
+ *
+ * Copyright (C) [2022-2025] Renesas Electronics Corporation and/or its affiliates.
+ */
+
+#include <linux/version.h>
+#include <linux/module.h>
+#include <linux/netdevice.h>
+#include <net/cfg80211.h>
+
+#include "core.h"
+#include "cfg80211.h"
+#include "dev.h"
+#include "params.h"
+#include "dbg.h"
+
+static int ra6w_dev_ndo_open(struct net_device *ndev)
+{
+	struct ra6w_cfg80211_vif *vif = netdev_priv(ndev);
+	struct ra6w_cfg80211_priv *priv = vif->priv;
+
+	vif->up = true;
+	priv->vif_started++;
+
+	if (ra6w_recovery_reprobe_get()) {
+		ra6w_recovery_reprobe_set(false);
+		return 0;
+	}
+
+	netif_carrier_off(ndev);
+
+	return 0;
+}
+
+static int ra6w_dev_ndo_close(struct net_device *ndev)
+{
+	struct ra6w_cfg80211_vif *vif = netdev_priv(ndev);
+	struct ra6w_cfg80211_priv *priv = NULL;
+
+	if (!vif)
+		return 0;
+
+	priv = vif->priv;
+	if (!priv)
+		return 0;
+
+	if (priv->scan_request) {
+		ra6w_ctrl_scan_cancel(&priv->core->ctrl, vif);
+		ra6w_cfg80211_scan_done(priv);
+	}
+
+	vif->up = false;
+	if (netif_carrier_ok(ndev)) {
+		if (vif->type == NL80211_IFTYPE_STATION ||
+		    vif->type == NL80211_IFTYPE_P2P_CLIENT)
+			cfg80211_disconnected(ndev, WLAN_REASON_DEAUTH_LEAVING,
+					      NULL, 0, true, GFP_ATOMIC);
+
+		netif_carrier_off(ndev);
+	}
+
+	if (vif->type == NL80211_IFTYPE_MONITOR)
+		priv->mon_vif_idx = RA6W_CFG80211_VIF_IDX_INVALID;
+
+	priv->vif_started--;
+
+	return 0;
+}
+
+static struct ra6w_cfg80211_sta *ra6w_dev_get_sta(struct ra6w_cfg80211_vif *vif,
+						  struct sk_buff *skb)
+{
+	struct ra6w_cfg80211_sta *sta = NULL;
+
+	if (!vif)
+		return NULL;
+
+	switch (vif->type) {
+	case NL80211_IFTYPE_STATION:
+	case NL80211_IFTYPE_P2P_CLIENT:
+		sta = vif->sta.ap;
+		if (sta && sta->valid)
+			return sta;
+
+		break;
+	case NL80211_IFTYPE_AP:
+	case NL80211_IFTYPE_P2P_GO: {
+		const struct ethhdr *eth = (struct ethhdr *)skb->data;
+
+		if (is_multicast_ether_addr(eth->h_dest)) {
+			sta = ra6w_cfg80211_sta_get(vif->priv, vif->ap.bcmc_index);
+			if (sta && sta->valid)
+				return sta;
+
+			break;
+		}
+
+		list_for_each_entry(sta, &vif->ap.sta_list, list) {
+			if (sta->valid && ether_addr_equal(sta->mac_addr, eth->h_dest))
+				return sta;
+		}
+	}
+		break;
+	default:
+		break;
+	}
+
+	return NULL;
+}
+
+static netdev_tx_t ra6w_dev_tx(struct ra6w_cfg80211_vif *vif, struct sk_buff *skb)
+{
+	struct ra6w_cfg80211_priv *priv = vif->priv;
+	struct ra6w_tx *tx = &priv->core->tx;
+	struct ra6w_tx_buf *tx_buf = NULL;
+	const struct ra6w_cfg80211_sta *sta = NULL;
+	u8 hdr_size = RA6W_GET_DATA_SIZE(RA6W_TX_EXT_LEN, 0);
+	u8 tx_buf_ac = RA6W_TX_DATA_AC;
+	u8 sta_idx = RA6W_CFG80211_STA_IDX_INVALID;
+	u8 prio = skb->priority;
+
+	if (skb->len - hdr_size > RA6W_CMD_DATA_SIZE)
+		return -EINVAL;
+
+	sta = ra6w_dev_get_sta(vif, skb);
+	if (sta)
+		sta_idx = sta->sta_idx;
+
+	if (sta_idx == RA6W_CFG80211_STA_IDX_INVALID)
+		return -ENXIO;
+
+	if (skb_headroom(skb) < hdr_size) {
+		int ret;
+
+		ret = pskb_expand_head(skb, hdr_size, 0, GFP_ATOMIC);
+		if (ret < 0) {
+			ra6w_err("[%s] SKB resize failed: hdr_size %u (reserved %u) ret %d\n",
+				 __func__, hdr_size, skb_headroom(skb), ret);
+
+			return -EFAULT;
+		}
+	}
+
+	if (skb->priority == 0 || skb->priority > IEEE80211_QOS_CTL_TAG1D_MASK)
+		prio = cfg80211_classify8021d(skb, NULL);
+
+	tx_buf = (struct ra6w_tx_buf *)skb_push(skb, hdr_size);
+	tx_buf->cmd = RA6W_CMD_DATA_TX;
+	tx_buf->ext_len = RA6W_TX_EXT_LEN;
+	tx_buf->ext_hdr.buf_idx = tx_buf_ac;
+	tx_buf->ext_hdr.tid = prio;
+	tx_buf->ext_hdr.vif_idx = vif->vif_idx;
+	tx_buf->ext_hdr.sta_idx = sta_idx;
+	tx_buf->ext_hdr.flags = 0;
+	tx_buf->ext_hdr.sn = 0;
+	tx_buf->data_len = cpu_to_le16(skb->len - hdr_size);
+
+	return ra6w_tx_event_post(tx, tx_buf_ac, skb);
+}
+
+static netdev_tx_t ra6w_dev_ndo_start_xmit(struct sk_buff *skb, struct net_device *ndev)
+{
+	int ret;
+	struct ra6w_cfg80211_vif *vif = netdev_priv(ndev);
+
+	ret = ra6w_dev_tx(vif, skb);
+	if (ret) {
+		dev_kfree_skb(skb);
+		ndev->stats.tx_errors++;
+		ndev->stats.tx_dropped++;
+
+		return NETDEV_TX_OK;
+	}
+
+	ndev->stats.tx_packets++;
+	ndev->stats.tx_bytes += skb->len;
+
+	return NETDEV_TX_OK;
+}
+
+static const struct net_device_ops ra6w_dev_ops = {
+	.ndo_open = ra6w_dev_ndo_open,
+	.ndo_stop = ra6w_dev_ndo_close,
+	.ndo_start_xmit = ra6w_dev_ndo_start_xmit,
+	.ndo_set_mac_address = eth_mac_addr,
+};
+
+static const struct net_device_ops ra6w_dev_monitor_ops = {
+	.ndo_open = ra6w_dev_ndo_open,
+	.ndo_stop = ra6w_dev_ndo_close,
+	.ndo_set_mac_address = eth_mac_addr,
+};
+
+static u32 ra6w_dev_ethtool_get_link(struct net_device *ndev)
+{
+	return netif_carrier_ok(ndev);
+}
+
+static const struct ethtool_ops ra6w_ethtool_ops = {
+	.get_link = ra6w_dev_ethtool_get_link,
+	.get_drvinfo = cfg80211_get_drvinfo,
+};
+
+void ra6w_dev_init(struct net_device *ndev)
+{
+	if (!ndev)
+		return;
+
+	ether_setup(ndev);
+
+	ndev->priv_flags &= ~IFF_TX_SKB_SHARING;
+
+	ra6w_dev_set_ops(ndev);
+	ndev->ethtool_ops = &ra6w_ethtool_ops;
+
+	ndev->needs_free_netdev = true;
+	ndev->watchdog_timeo = RA6W_CMD_TX_LIFETIME_MS;
+	ndev->needed_headroom += RA6W_GET_DATA_SIZE(RA6W_TX_EXT_LEN, 0);
+	ndev->hw_features = 0;
+}
+
+void ra6w_dev_set_ops(struct net_device *ndev)
+{
+	ndev->netdev_ops = &ra6w_dev_ops;
+	ndev->tx_queue_len = RA6W_TX_BUF_Q_MAX;
+}
+
+void ra6w_dev_set_monitor_ops(struct net_device *ndev)
+{
+	ndev->netdev_ops = &ra6w_dev_monitor_ops;
+}
-- 
2.17.1


