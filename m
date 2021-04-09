Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B493F359971
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Apr 2021 11:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232395AbhDIJkq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Apr 2021 05:40:46 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:44224 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231638AbhDIJkp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Apr 2021 05:40:45 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1lUncr-000ELR-V7; Fri, 09 Apr 2021 12:40:31 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Date:   Fri,  9 Apr 2021 12:40:14 +0300
Message-Id: <iwlwifi.20210409123755.a126c8833398.I677bdac314dd50d90474a90593902c17f9410cc4@changeid>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210409094028.356611-1-luca@coelho.fi>
References: <20210409094028.356611-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 01/15] mac80211: drop the connection if firmware crashed while in CSA
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Naftali Goldstein <naftali.goldstein@intel.com>

Don't bother keeping the link in that case. It is way
too complicated to keep the connection.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Naftali Goldstein <naftali.goldstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 net/mac80211/ieee80211_i.h | 2 ++
 net/mac80211/main.c        | 9 ++++++++-
 net/mac80211/mlme.c        | 4 ++--
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index ecda126a7026..8fcbaa1eedf3 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1660,6 +1660,8 @@ void ieee80211_mgd_conn_tx_status(struct ieee80211_sub_if_data *sdata,
 void ieee80211_mgd_quiesce(struct ieee80211_sub_if_data *sdata);
 void ieee80211_sta_restart(struct ieee80211_sub_if_data *sdata);
 void ieee80211_sta_handle_tspec_ac_params(struct ieee80211_sub_if_data *sdata);
+void ieee80211_sta_connection_lost(struct ieee80211_sub_if_data *sdata,
+				   u8 *bssid, u8 reason, bool tx);
 
 /* IBSS code */
 void ieee80211_ibss_notify_scan_completed(struct ieee80211_local *local);
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 4f3f8bb58e76..f27aed37ed2b 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -5,7 +5,7 @@
  * Copyright 2006-2007	Jiri Benc <jbenc@suse.cz>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright (C) 2017     Intel Deutschland GmbH
- * Copyright (C) 2018 - 2019 Intel Corporation
+ * Copyright (C) 2018-2021 Intel Corporation
  */
 
 #include <net/mac80211.h>
@@ -282,6 +282,13 @@ static void ieee80211_restart_work(struct work_struct *work)
 			 * Then we can have a race...
 			 */
 			cancel_work_sync(&sdata->u.mgd.csa_connection_drop_work);
+			if (sdata->vif.csa_active) {
+				sdata_lock(sdata);
+				ieee80211_sta_connection_lost(sdata,
+							      sdata->u.mgd.associated->bssid,
+							      WLAN_REASON_UNSPECIFIED, false);
+				sdata_unlock(sdata);
+			}
 		}
 		flush_delayed_work(&sdata->dec_tailroom_needed_wk);
 	}
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 2e33a1263518..c569a10a1bbb 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -4382,8 +4382,8 @@ static void ieee80211_sta_timer(struct timer_list *t)
 	ieee80211_queue_work(&sdata->local->hw, &sdata->work);
 }
 
-static void ieee80211_sta_connection_lost(struct ieee80211_sub_if_data *sdata,
-					  u8 *bssid, u8 reason, bool tx)
+void ieee80211_sta_connection_lost(struct ieee80211_sub_if_data *sdata,
+				   u8 *bssid, u8 reason, bool tx)
 {
 	u8 frame_buf[IEEE80211_DEAUTH_FRAME_LEN];
 
-- 
2.31.0

