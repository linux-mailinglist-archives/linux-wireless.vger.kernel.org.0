Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB413AC936
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jun 2021 12:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233732AbhFRKz2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Jun 2021 06:55:28 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:48240 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233860AbhFRKzT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Jun 2021 06:55:19 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1luBx4-001YXx-1Q; Fri, 18 Jun 2021 13:42:19 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri, 18 Jun 2021 13:41:46 +0300
Message-Id: <iwlwifi.20210618133832.c96eadcffe80.I86799c2c866b5610b4cf91115c21d8ceb525c5aa@changeid>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618104156.747775-1-luca@coelho.fi>
References: <20210618104156.747775-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 21/31] cfg80211: set custom regdomain after wiphy registration
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

We used to set regulatory info before the registration of
the device and then the regulatory info didn't get set, because
the device isn't registered so there isn't a device to set the
regulatory info for. So set the regulatory info after the device
registration.
Call reg_process_self_managed_hints() once again after the device
registration because it does nothing before it.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 net/wireless/core.c | 8 ++++----
 net/wireless/reg.c  | 1 +
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/wireless/core.c b/net/wireless/core.c
index 6fbf7537faf5..6bc074f18a24 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -5,7 +5,7 @@
  * Copyright 2006-2010		Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright 2015-2017	Intel Deutschland GmbH
- * Copyright (C) 2018-2020 Intel Corporation
+ * Copyright (C) 2018-2021 Intel Corporation
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
@@ -936,9 +936,6 @@ int wiphy_register(struct wiphy *wiphy)
 		return res;
 	}
 
-	/* set up regulatory info */
-	wiphy_regulatory_register(wiphy);
-
 	list_add_rcu(&rdev->list, &cfg80211_rdev_list);
 	cfg80211_rdev_list_generation++;
 
@@ -949,6 +946,9 @@ int wiphy_register(struct wiphy *wiphy)
 	cfg80211_debugfs_rdev_add(rdev);
 	nl80211_notify_wiphy(rdev, NL80211_CMD_NEW_WIPHY);
 
+	/* set up regulatory info */
+	wiphy_regulatory_register(wiphy);
+
 	if (wiphy->regulatory_flags & REGULATORY_CUSTOM_REG) {
 		struct regulatory_request request;
 
diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index 0406ce7334fa..0df048bd4b84 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -4049,6 +4049,7 @@ void wiphy_regulatory_register(struct wiphy *wiphy)
 
 	wiphy_update_regulatory(wiphy, lr->initiator);
 	wiphy_all_share_dfs_chan_state(wiphy);
+	reg_process_self_managed_hints();
 }
 
 void wiphy_regulatory_deregister(struct wiphy *wiphy)
-- 
2.32.0

