Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC0994616A8
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Nov 2021 14:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244013AbhK2NjG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Nov 2021 08:39:06 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:49796 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1377730AbhK2NgS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Nov 2021 08:36:18 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mrgmB-0012xo-6G; Mon, 29 Nov 2021 15:32:59 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Mon, 29 Nov 2021 15:32:38 +0200
Message-Id: <iwlwifi.20211129152938.cd2a615a0702.I9edb14785586344af17644b610ab5be109dcef00@changeid>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211129133248.83829-1-luca@coelho.fi>
References: <20211129133248.83829-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 06/16] mac80211: introduce channel switch disconnect function
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Nathan Errera <nathan.errera@intel.com>

Introduce a disconnect function that can be used when a
channel switch error occurs. The channel switch can request to
block the tx, and so, we need to make sure we do not send a deauth
frame in this case.

Signed-off-by: Nathan Errera <nathan.errera@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 include/net/mac80211.h | 12 ++++++++++++
 net/mac80211/cfg.c     | 14 +++++++++++++-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 775dbb982654..6770e17a1d38 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -6073,6 +6073,18 @@ void ieee80211_radar_detected(struct ieee80211_hw *hw);
  */
 void ieee80211_chswitch_done(struct ieee80211_vif *vif, bool success);
 
+/**
+ * ieee80211_channel_switch_disconnect - disconnect due to channel switch error
+ * @vif &struct ieee80211_vif pointer from the add_interface callback.
+ * @block_tx: if %true, do not send deauth frame.
+ *
+ * Instruct mac80211 to disconnect due to a channel switch error. The channel
+ * switch can request to block the tx and so, we need to make sure we do not send
+ * a deauth frame in this case.
+ */
+void ieee80211_channel_switch_disconnect(struct ieee80211_vif *vif,
+					 bool block_tx);
+
 /**
  * ieee80211_request_smps - request SM PS transition
  * @vif: &struct ieee80211_vif pointer from the add_interface callback.
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 45334d59fe06..23b35fe73a50 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -5,7 +5,7 @@
  * Copyright 2006-2010	Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2015  Intel Mobile Communications GmbH
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2020 Intel Corporation
+ * Copyright (C) 2018-2021 Intel Corporation
  */
 
 #include <linux/ieee80211.h>
@@ -3198,6 +3198,18 @@ void ieee80211_csa_finish(struct ieee80211_vif *vif)
 }
 EXPORT_SYMBOL(ieee80211_csa_finish);
 
+void ieee80211_channel_switch_disconnect(struct ieee80211_vif *vif, bool block_tx)
+{
+	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
+	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
+	struct ieee80211_local *local = sdata->local;
+
+	sdata->csa_block_tx = block_tx;
+	sdata_info(sdata, "channel switch failed, disconnecting\n");
+	ieee80211_queue_work(&local->hw, &ifmgd->csa_connection_drop_work);
+}
+EXPORT_SYMBOL(ieee80211_channel_switch_disconnect);
+
 static int ieee80211_set_after_csa_beacon(struct ieee80211_sub_if_data *sdata,
 					  u32 *changed)
 {
-- 
2.33.1

