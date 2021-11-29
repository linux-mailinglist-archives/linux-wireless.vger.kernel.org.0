Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82E8C46169A
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Nov 2021 14:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345460AbhK2Ni1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Nov 2021 08:38:27 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:49808 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233319AbhK2NgU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Nov 2021 08:36:20 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mrgmC-0012xo-O0; Mon, 29 Nov 2021 15:33:01 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Mon, 29 Nov 2021 15:32:40 +0200
Message-Id: <iwlwifi.20211129152938.cab99f22fe19.Iefe494687f15fd85f77c1b989d1149c8efdfdc36@changeid>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211129133248.83829-1-luca@coelho.fi>
References: <20211129133248.83829-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 08/16] mac80211: do drv_reconfig_complete() before restarting all
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

When we reconfigure, the driver might do some things to complete
the reconfiguration. It's strange and could be broken in some
cases because we restart other works (e.g. remain-on-channel and
TX) before this happens, yet only start queues later.

Change this to do the reconfig complete when reconfiguration is
actually complete, not when we've already started doing other
things again.

For iwlwifi, this should fix a race where the reconfig can race
with TX, for ath10k and ath11k that also use this it won't make
a difference because they just start queues there, and mac80211
also stopped the queues and will restart them later as before.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 net/mac80211/util.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 43df2f0c5db9..4b102d5863cf 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2646,6 +2646,13 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 		mutex_unlock(&local->sta_mtx);
 	}
 
+	/*
+	 * If this is for hw restart things are still running.
+	 * We may want to change that later, however.
+	 */
+	if (local->open_count && (!suspended || reconfig_due_to_wowlan))
+		drv_reconfig_complete(local, IEEE80211_RECONFIG_TYPE_RESTART);
+
 	if (local->in_reconfig) {
 		local->in_reconfig = false;
 		barrier();
@@ -2664,13 +2671,6 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 					IEEE80211_QUEUE_STOP_REASON_SUSPEND,
 					false);
 
-	/*
-	 * If this is for hw restart things are still running.
-	 * We may want to change that later, however.
-	 */
-	if (local->open_count && (!suspended || reconfig_due_to_wowlan))
-		drv_reconfig_complete(local, IEEE80211_RECONFIG_TYPE_RESTART);
-
 	if (!suspended)
 		return 0;
 
-- 
2.33.1

