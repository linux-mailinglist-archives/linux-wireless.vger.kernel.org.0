Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BDD03AC90C
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jun 2021 12:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233802AbhFRKoW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Jun 2021 06:44:22 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:48168 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233174AbhFRKoU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Jun 2021 06:44:20 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1luBwt-001YXx-Vy; Fri, 18 Jun 2021 13:42:09 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri, 18 Jun 2021 13:41:34 +0300
Message-Id: <iwlwifi.20210618133832.d8e5cc4b527f.Icf3a67fffbdd8c408c0cadfe43f8f4cffdc90acb@changeid>
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
Subject: [PATCH 09/31] mac80211: move SMPS mode setting after ieee80211_prep_connection
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Shaul Triebitz <shaul.triebitz@intel.com>

ieee80211_mgd_assoc calls ieee80211_prep_connection which
might call ieee80211_prep_channel and set smps_mode to OFF.
That will override the previous setting of smps_mode in
ieee80211_mgd_assoc and HT SMPS will be set to "disabled"
in the association request frame.

Move the setting of smps_mode in ieee80211_mgd_assoc to
after the call to ieee80211_prep_connection.

Signed-off-by: Shaul Triebitz <shaul.triebitz@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 net/mac80211/mlme.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index fe7120f3b2ba..cc9bb4b9f8dc 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -5564,15 +5564,6 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 		       2 * FILS_NONCE_LEN);
 
 	assoc_data->bss = req->bss;
-
-	if (ifmgd->req_smps == IEEE80211_SMPS_AUTOMATIC) {
-		if (ifmgd->powersave)
-			sdata->smps_mode = IEEE80211_SMPS_DYNAMIC;
-		else
-			sdata->smps_mode = IEEE80211_SMPS_OFF;
-	} else
-		sdata->smps_mode = ifmgd->req_smps;
-
 	assoc_data->capability = req->bss->capability;
 	assoc_data->supp_rates = bss->supp_rates;
 	assoc_data->supp_rates_len = bss->supp_rates_len;
@@ -5679,6 +5670,15 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 	if (err)
 		goto err_clear;
 
+	if (ifmgd->req_smps == IEEE80211_SMPS_AUTOMATIC) {
+		if (ifmgd->powersave)
+			sdata->smps_mode = IEEE80211_SMPS_DYNAMIC;
+		else
+			sdata->smps_mode = IEEE80211_SMPS_OFF;
+	} else {
+		sdata->smps_mode = ifmgd->req_smps;
+	}
+
 	rcu_read_lock();
 	beacon_ies = rcu_dereference(req->bss->beacon_ies);
 
-- 
2.32.0

