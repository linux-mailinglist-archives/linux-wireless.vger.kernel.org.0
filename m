Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4D5E3AC90A
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jun 2021 12:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233762AbhFRKoU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Jun 2021 06:44:20 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:48156 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233742AbhFRKoT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Jun 2021 06:44:19 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1luBws-001YXx-Ct; Fri, 18 Jun 2021 13:42:08 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri, 18 Jun 2021 13:41:32 +0300
Message-Id: <iwlwifi.20210618133832.0465f8bcbe32.Iba39fc559ecfa887be00a5f3beabd881e5c86e54@changeid>
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
Subject: [PATCH 07/31] mac80211: allow SMPS requests only in client mode
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

The code currently allows this for AP mode, but then ignores
it. Clarify that since the spec doesn't allow it in AP mode.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 net/mac80211/ht.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/net/mac80211/ht.c b/net/mac80211/ht.c
index 3d62a80b5790..2eb7641f5556 100644
--- a/net/mac80211/ht.c
+++ b/net/mac80211/ht.c
@@ -9,7 +9,7 @@
  * Copyright 2007, Michael Wu <flamingice@sourmilk.net>
  * Copyright 2007-2010, Intel Corporation
  * Copyright 2017	Intel Deutschland GmbH
- * Copyright(c) 2020 Intel Corporation
+ * Copyright(c) 2020-2021 Intel Corporation
  */
 
 #include <linux/ieee80211.h>
@@ -555,17 +555,15 @@ void ieee80211_request_smps(struct ieee80211_vif *vif,
 {
 	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
 
-	if (WARN_ON_ONCE(vif->type != NL80211_IFTYPE_STATION &&
-			 vif->type != NL80211_IFTYPE_AP))
+	if (WARN_ON_ONCE(vif->type != NL80211_IFTYPE_STATION))
 		return;
 
-	if (vif->type == NL80211_IFTYPE_STATION) {
-		if (sdata->u.mgd.driver_smps_mode == smps_mode)
-			return;
-		sdata->u.mgd.driver_smps_mode = smps_mode;
-		ieee80211_queue_work(&sdata->local->hw,
-				     &sdata->u.mgd.request_smps_work);
-	}
+	if (sdata->u.mgd.driver_smps_mode == smps_mode)
+		return;
+
+	sdata->u.mgd.driver_smps_mode = smps_mode;
+	ieee80211_queue_work(&sdata->local->hw,
+			     &sdata->u.mgd.request_smps_work);
 }
 /* this might change ... don't want non-open drivers using it */
 EXPORT_SYMBOL_GPL(ieee80211_request_smps);
-- 
2.32.0

