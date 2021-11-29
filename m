Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C43A746169F
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Nov 2021 14:35:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343654AbhK2Nib (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Nov 2021 08:38:31 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:49832 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S242592AbhK2NgZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Nov 2021 08:36:25 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mrgmF-0012xo-Q6; Mon, 29 Nov 2021 15:33:04 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Mon, 29 Nov 2021 15:32:44 +0200
Message-Id: <iwlwifi.20211129152938.550b95b5fca7.Ia31395e880172aefcc0a8c70ed060f84b94bdb83@changeid>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211129133248.83829-1-luca@coelho.fi>
References: <20211129133248.83829-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 12/16] mac80211: Remove a couple of obsolete TODO
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ilan Peer <ilan.peer@intel.com>

The HE capability IE is an extension IE so remove
an irrelevant comments.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 net/mac80211/main.c | 13 +++++--------
 net/mac80211/mlme.c |  4 ----
 2 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 45fb517591ee..5311c3cd3050 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -1131,17 +1131,14 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 		local->scan_ies_len +=
 			2 + sizeof(struct ieee80211_vht_cap);
 
-	/* HE cap element is variable in size - set len to allow max size */
 	/*
-	 * TODO: 1 is added at the end of the calculation to accommodate for
-	 *	the temporary placing of the HE capabilities IE under EXT.
-	 *	Remove it once it is placed in the final place.
-	 */
-	if (supp_he)
+	 * HE cap element is variable in size - set len to allow max size */
+	if (supp_he) {
 		local->scan_ies_len +=
-			2 + sizeof(struct ieee80211_he_cap_elem) +
+			3 + sizeof(struct ieee80211_he_cap_elem) +
 			sizeof(struct ieee80211_he_mcs_nss_supp) +
-			IEEE80211_HE_PPE_THRES_MAX_LEN + 1;
+			IEEE80211_HE_PPE_THRES_MAX_LEN;
+	}
 
 	if (!local->ops->hw_scan) {
 		/* For hw_scan, driver needs to set these up. */
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 30d344a88d96..e6af62587e81 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -655,10 +655,6 @@ static void ieee80211_add_he_ie(struct ieee80211_sub_if_data *sdata,
 	if (!he_cap || !reg_cap)
 		return;
 
-	/*
-	 * TODO: the 1 added is because this temporarily is under the EXTENSION
-	 * IE. Get rid of it when it moves.
-	 */
 	he_cap_size =
 		2 + 1 + sizeof(he_cap->he_cap_elem) +
 		ieee80211_he_mcs_nss_size(&he_cap->he_cap_elem) +
-- 
2.33.1

