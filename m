Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD972C79C5
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Nov 2020 16:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbgK2Pdg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 29 Nov 2020 10:33:36 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:33606 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727716AbgK2Pdg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 29 Nov 2020 10:33:36 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kjOfJ-0035ld-MC; Sun, 29 Nov 2020 17:31:06 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Date:   Sun, 29 Nov 2020 17:30:54 +0200
Message-Id: <iwlwifi.20201129172929.0e2327107c06.I461adb07704e056b054a4a7c29b80c95a9f56637@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201129153055.1971298-1-luca@coelho.fi>
References: <20201129153055.1971298-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 12/13] mac80211: disallow band-switch during CSA
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

If the AP advertises a band switch during CSA, we will not have
the right information to continue working with it, since it will
likely (have to) change its capabilities and we don't track any
capability changes at all. Additionally, we store e.g. supported
rates per band, and that information would become invalid.

Since this is a fringe scenario, just disconnect explicitly.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 net/mac80211/mlme.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 6de63ba6b1c8..67829667d394 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -1417,6 +1417,17 @@ ieee80211_sta_process_chanswitch(struct ieee80211_sub_if_data *sdata,
 		return;
 	}
 
+	if (sdata->vif.bss_conf.chandef.chan->band !=
+	    csa_ie.chandef.chan->band) {
+		sdata_info(sdata,
+			   "AP %pM switches to different band (%d MHz, width:%d, CF1/2: %d/%d MHz), disconnecting\n",
+			   ifmgd->associated->bssid,
+			   csa_ie.chandef.chan->center_freq,
+			   csa_ie.chandef.width, csa_ie.chandef.center_freq1,
+			   csa_ie.chandef.center_freq2);
+		goto lock_and_drop_connection;
+	}
+
 	if (!cfg80211_chandef_usable(local->hw.wiphy, &csa_ie.chandef,
 				     IEEE80211_CHAN_DISABLED)) {
 		sdata_info(sdata,
@@ -1429,9 +1440,7 @@ ieee80211_sta_process_chanswitch(struct ieee80211_sub_if_data *sdata,
 			   csa_ie.chandef.width, csa_ie.chandef.center_freq1,
 			   csa_ie.chandef.freq1_offset,
 			   csa_ie.chandef.center_freq2);
-		ieee80211_queue_work(&local->hw,
-				     &ifmgd->csa_connection_drop_work);
-		return;
+		goto lock_and_drop_connection;
 	}
 
 	if (cfg80211_chandef_identical(&csa_ie.chandef,
@@ -1516,6 +1525,9 @@ ieee80211_sta_process_chanswitch(struct ieee80211_sub_if_data *sdata,
 			  TU_TO_EXP_TIME((csa_ie.count - 1) *
 					 cbss->beacon_interval));
 	return;
+ lock_and_drop_connection:
+	mutex_lock(&local->mtx);
+	mutex_lock(&local->chanctx_mtx);
  drop_connection:
 	/*
 	 * This is just so that the disconnect flow will know that
-- 
2.29.2

