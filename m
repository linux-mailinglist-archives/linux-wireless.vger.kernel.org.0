Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF8714EB85
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Jan 2020 12:13:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbgAaLNQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 31 Jan 2020 06:13:16 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:55820 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728325AbgAaLNQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 31 Jan 2020 06:13:16 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <luca@coelho.fi>)
        id 1ixUEb-0002GC-LD; Fri, 31 Jan 2020 13:13:14 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 31 Jan 2020 13:12:46 +0200
Message-Id: <20200131111300.891737-10-luca@coelho.fi>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200131111300.891737-1-luca@coelho.fi>
References: <20200131111300.891737-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH 09/23] mac80211: allow changing TX-related netdev features
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Set ndev->hw_features as well as ndev->features to allow
changing the TX-related features with ethtool.

We cannot (yet) change RX-related features since that
requires telling the driver about it and we have no API
for that yet.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 net/mac80211/ieee80211_i.h | 7 +++++++
 net/mac80211/iface.c       | 4 +++-
 net/mac80211/main.c        | 6 +-----
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index e3cf24cb4615..b89543269f51 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1729,6 +1729,13 @@ int ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 			     struct cfg80211_csa_settings *params);
 
 /* interface handling */
+#define MAC80211_SUPPORTED_FEATURES_TX	(NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM | \
+					 NETIF_F_HW_CSUM | NETIF_F_SG | \
+					 NETIF_F_HIGHDMA | NETIF_F_GSO_SOFTWARE)
+#define MAC80211_SUPPORTED_FEATURES_RX	(NETIF_F_RXCSUM)
+#define MAC80211_SUPPORTED_FEATURES	(MAC80211_SUPPORTED_FEATURES_TX | \
+					 MAC80211_SUPPORTED_FEATURES_RX)
+
 int ieee80211_iface_init(void);
 void ieee80211_iface_exit(void);
 int ieee80211_if_add(struct ieee80211_local *local, const char *name,
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 9b833e170c20..99d913a6e651 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -8,7 +8,7 @@
  * Copyright 2008, Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright (c) 2016        Intel Deutschland GmbH
- * Copyright (C) 2018 Intel Corporation
+ * Copyright (C) 2018-2019 Intel Corporation
  */
 #include <linux/slab.h>
 #include <linux/kernel.h>
@@ -1938,6 +1938,8 @@ int ieee80211_if_add(struct ieee80211_local *local, const char *name,
 			sdata->u.mgd.use_4addr = params->use_4addr;
 
 		ndev->features |= local->hw.netdev_features;
+		ndev->hw_features |= ndev->features &
+					MAC80211_SUPPORTED_FEATURES_TX;
 
 		netdev_set_default_ethtool_ops(ndev, &ieee80211_ethtool_ops);
 
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 34728cf94172..287dd0588476 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -872,7 +872,6 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 	enum nl80211_band band;
 	int channels, max_bitrates;
 	bool supp_ht, supp_vht, supp_he;
-	netdev_features_t feature_whitelist;
 	struct cfg80211_chan_def dflt_chandef = {};
 
 	if (ieee80211_hw_check(hw, QUEUE_CONTROL) &&
@@ -931,10 +930,7 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 	}
 
 	/* Only HW csum features are currently compatible with mac80211 */
-	feature_whitelist = NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM |
-			    NETIF_F_HW_CSUM | NETIF_F_SG | NETIF_F_HIGHDMA |
-			    NETIF_F_GSO_SOFTWARE | NETIF_F_RXCSUM;
-	if (WARN_ON(hw->netdev_features & ~feature_whitelist))
+	if (WARN_ON(hw->netdev_features & ~MAC80211_SUPPORTED_FEATURES))
 		return -EINVAL;
 
 	if (hw->max_report_rates == 0)
-- 
2.24.1

