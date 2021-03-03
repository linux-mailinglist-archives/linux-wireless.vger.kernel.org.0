Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79E9632C146
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Mar 2021 01:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245712AbhCCVR5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 Mar 2021 16:17:57 -0500
Received: from o1.ptr2625.egauge.net ([167.89.112.53]:16628 "EHLO
        o1.ptr2625.egauge.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377280AbhCCTux (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 Mar 2021 14:50:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=egauge.net;
        h=from:subject:mime-version:to:cc:content-transfer-encoding:
        content-type;
        s=sgd; bh=FigIU+xBn26s32OslZYnIbTwNFgb07dPKzm2P59oAsE=;
        b=AVh/krKlYhybTYbCGLYhmBAsXR4hYkq7vov3zwIgf+9e7sJqBcVFXl+Yd1vvhHFFGefE
        CfHCgRVhpvk3UZoGlb50nfNEVuGeODh7yi306OaG8KNZu7v85WSNTlPKcqI7E0Dp32NUWO
        xrG2zhOxokx+0wJyYbnZKcDIM3vm/JWwI=
Received: by filterdrecv-p3iad2-fdf5ff85d-l7rdf with SMTP id filterdrecv-p3iad2-fdf5ff85d-l7rdf-19-603FE86F-A
        2021-03-03 19:50:07.158649079 +0000 UTC m=+1890158.047260485
Received: from pearl.egauge.net (unknown)
        by geopod-ismtpd-1-0 (SG)
        with ESMTP
        id xU5Q7yBrRzqdtxTgrcR71w
        Wed, 03 Mar 2021 19:50:06.922 +0000 (UTC)
Received: by pearl.egauge.net (Postfix, from userid 1000)
        id 2A679700433; Wed,  3 Mar 2021 12:50:06 -0700 (MST)
From:   David Mosberger-Tang <davidm@egauge.net>
Subject: [PATCH] wilc1000: Bring MAC address setting in line with typical
 Linux behavior
Date:   Wed, 03 Mar 2021 19:50:07 +0000 (UTC)
Message-Id: <20210303194846.1823596-1-davidm@egauge.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-SG-EID: =?us-ascii?Q?+kMxBqj35EdRUKoy8diX1j4AXmPtd302oan+iXZuF8m2Nw4HRW2irNspffT=2Fkh?=
 =?us-ascii?Q?ET6RJF6+Prbl0h=2FEtF1rRLvE6rnK5LA4ARw7Vds?=
 =?us-ascii?Q?1XubTCfb8f+MTo8ZwBcIWSxpwRxP1PfrgUcOmG6?=
 =?us-ascii?Q?iqHNbOwO6qB+tqRts1K0Vv=2F1qAzk0Zc4rt9Q544?=
 =?us-ascii?Q?8skePb9icZvYv3H8qc6mP2G08d5MAPyqqufwBfN?=
 =?us-ascii?Q?gXF3CnCvs3h=2FynZxyhLO84NJESXhA59BVf0la5n?=
 =?us-ascii?Q?Bl8bhlgAcbgeYSXCbkUFA=3D=3D?=
To:     linux-wireless@vger.kernel.org
Cc:     Ajay Singh <ajay.kathat@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        davidm@egauge.net
X-Entity-ID: Xg4JGAcGrJFIz2kDG9eoaQ==
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Linux network drivers normally disallow changing the MAC address when
the interface is up.  This driver has been different in that it allows
to change the MAC address *only* when it's up.  This patch brings
wilc1000 behavior more in line with other network drivers.  We could
have replaced wilc_set_mac_addr() with eth_mac_addr() but that would
break existing documentation on how to change the MAC address.
Likewise, return -EADDRNOTAVAIL (not -EINVAL) when the specified MAC
address is invalid or unavailable.

Signed-off-by: David Mosberger-Tang <davidm@egauge.net>
---
 .../net/wireless/microchip/wilc1000/netdev.c  | 25 ++++++++++++-------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.c b/drivers/net/wireless/microchip/wilc1000/netdev.c
index 1b205e7d97a8..37f40039e4ca 100644
--- a/drivers/net/wireless/microchip/wilc1000/netdev.c
+++ b/drivers/net/wireless/microchip/wilc1000/netdev.c
@@ -575,7 +575,6 @@ static int wilc_mac_open(struct net_device *ndev)
 {
 	struct wilc_vif *vif = netdev_priv(ndev);
 	struct wilc *wl = vif->wilc;
-	unsigned char mac_add[ETH_ALEN] = {0};
 	int ret = 0;
 	struct mgmt_frame_regs mgmt_regs = {};
 
@@ -598,9 +597,12 @@ static int wilc_mac_open(struct net_device *ndev)
 
 	wilc_set_operation_mode(vif, wilc_get_vif_idx(vif), vif->iftype,
 				vif->idx);
-	wilc_get_mac_address(vif, mac_add);
-	netdev_dbg(ndev, "Mac address: %pM\n", mac_add);
-	ether_addr_copy(ndev->dev_addr, mac_add);
+
+	if (is_valid_ether_addr(ndev->dev_addr))
+		wilc_set_mac_address(vif, ndev->dev_addr);
+	else
+		wilc_get_mac_address(vif, ndev->dev_addr);
+	netdev_dbg(ndev, "Mac address: %pM\n", ndev->dev_addr);
 
 	if (!is_valid_ether_addr(ndev->dev_addr)) {
 		netdev_err(ndev, "Wrong MAC address\n");
@@ -639,7 +641,14 @@ static int wilc_set_mac_addr(struct net_device *dev, void *p)
 	int srcu_idx;
 
 	if (!is_valid_ether_addr(addr->sa_data))
-		return -EINVAL;
+		return -EADDRNOTAVAIL;
+
+	if (!vif->mac_opened) {
+		eth_commit_mac_addr_change(dev, p);
+		return 0;
+	}
+
+	/* Verify MAC Address is not already in use: */
 
 	srcu_idx = srcu_read_lock(&wilc->srcu);
 	list_for_each_entry_rcu(tmp_vif, &wilc->vif_list, list) {
@@ -647,7 +656,7 @@ static int wilc_set_mac_addr(struct net_device *dev, void *p)
 		if (ether_addr_equal(addr->sa_data, mac_addr)) {
 			if (vif != tmp_vif) {
 				srcu_read_unlock(&wilc->srcu, srcu_idx);
-				return -EINVAL;
+				return -EADDRNOTAVAIL;
 			}
 			srcu_read_unlock(&wilc->srcu, srcu_idx);
 			return 0;
@@ -659,9 +668,7 @@ static int wilc_set_mac_addr(struct net_device *dev, void *p)
 	if (result)
 		return result;
 
-	ether_addr_copy(vif->bssid, addr->sa_data);
-	ether_addr_copy(vif->ndev->dev_addr, addr->sa_data);
-
+	eth_commit_mac_addr_change(dev, p);
 	return result;
 }
 
-- 
2.25.1

