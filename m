Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C46746169C
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Nov 2021 14:35:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347321AbhK2Ni3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Nov 2021 08:38:29 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:49820 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S237460AbhK2NgW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Nov 2021 08:36:22 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mrgmE-0012xo-6g; Mon, 29 Nov 2021 15:33:02 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Mon, 29 Nov 2021 15:32:42 +0200
Message-Id: <iwlwifi.20211129152938.1c80c17ffd8a.I94ae31378b363c1182cfdca46c4b7e7165cff984@changeid>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211129133248.83829-1-luca@coelho.fi>
References: <20211129133248.83829-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 10/16] mac80211: update channel context before station state
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

Currently channel context is updated only after station got an update about
new assoc state, this results in station using the old channel context.

Fix this by moving the update channel context before updating station,
enabling the driver to immediately use the updated channel context in
the new assoc state.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 net/mac80211/sta_info.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 51b49f0d3ad4..9d496923fc19 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -667,6 +667,15 @@ static int sta_info_insert_finish(struct sta_info *sta) __acquires(RCU)
 
 	list_add_tail_rcu(&sta->list, &local->sta_list);
 
+	/* update channel context before notifying the driver about state
+	 * change, this enables driver using the updated channel context right away.
+	 */
+	if (sta->sta_state >= IEEE80211_STA_ASSOC) {
+		ieee80211_recalc_min_chandef(sta->sdata);
+		if (!sta->sta.support_p2p_ps)
+			ieee80211_recalc_p2p_go_ps_allowed(sta->sdata);
+	}
+
 	/* notify driver */
 	err = sta_info_insert_drv_state(local, sdata, sta);
 	if (err)
@@ -674,12 +683,6 @@ static int sta_info_insert_finish(struct sta_info *sta) __acquires(RCU)
 
 	set_sta_flag(sta, WLAN_STA_INSERTED);
 
-	if (sta->sta_state >= IEEE80211_STA_ASSOC) {
-		ieee80211_recalc_min_chandef(sta->sdata);
-		if (!sta->sta.support_p2p_ps)
-			ieee80211_recalc_p2p_go_ps_allowed(sta->sdata);
-	}
-
 	/* accept BA sessions now */
 	clear_sta_flag(sta, WLAN_STA_BLOCK_BA);
 
-- 
2.33.1

