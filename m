Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18CBA2DCB5
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2019 14:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfE2MZt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 May 2019 08:25:49 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:54282 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726937AbfE2MZs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 May 2019 08:25:48 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1hVxeM-0007wy-La; Wed, 29 May 2019 15:25:46 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Naftali Goldstein <naftali.goldstein@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>
Subject: [PATCH 03/10] mac80211: do not start any work during reconfigure flow
Date:   Wed, 29 May 2019 15:25:30 +0300
Message-Id: <20190529122537.8564-4-luca@coelho.fi>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190529122537.8564-1-luca@coelho.fi>
References: <20190529122537.8564-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Naftali Goldstein <naftali.goldstein@intel.com>

It is not a good idea to try to perform any work (e.g. send an auth
frame) during reconfigure flow.

Prevent this from happening, and at the end of the reconfigure flow
requeue all the works.

Signed-off-by: Naftali Goldstein <naftali.goldstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 net/mac80211/ieee80211_i.h | 7 +++++++
 net/mac80211/util.c        | 4 ++++
 2 files changed, 11 insertions(+)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 073a8235ae1b..b10fe579f993 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2037,6 +2037,13 @@ void __ieee80211_flush_queues(struct ieee80211_local *local,
 
 static inline bool ieee80211_can_run_worker(struct ieee80211_local *local)
 {
+	/*
+	 * It's unsafe to try to do any work during reconfigure flow.
+	 * When the flow ends the work will be requeued.
+	 */
+	if (local->in_reconfig)
+		return false;
+
 	/*
 	 * If quiescing is set, we are racing with __ieee80211_suspend.
 	 * __ieee80211_suspend flushes the workers after setting quiescing,
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index cba4633cd6cf..81615d86fd70 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2480,6 +2480,10 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 		mutex_lock(&local->mtx);
 		ieee80211_start_next_roc(local);
 		mutex_unlock(&local->mtx);
+
+		/* Requeue all works */
+		list_for_each_entry(sdata, &local->interfaces, list)
+			ieee80211_queue_work(&local->hw, &sdata->work);
 	}
 
 	ieee80211_wake_queues_by_reason(hw, IEEE80211_MAX_QUEUE_MAP,
-- 
2.20.1

