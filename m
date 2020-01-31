Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 392E914EB82
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Jan 2020 12:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbgAaLNP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 31 Jan 2020 06:13:15 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:55804 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728342AbgAaLNO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 31 Jan 2020 06:13:14 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <luca@coelho.fi>)
        id 1ixUEa-0002GC-CG; Fri, 31 Jan 2020 13:13:12 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 31 Jan 2020 13:12:44 +0200
Message-Id: <20200131111300.891737-8-luca@coelho.fi>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200131111300.891737-1-luca@coelho.fi>
References: <20200131111300.891737-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH 07/23] mac80211: check whether HE connection is allowed by the reg domain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Haim Dreyfuss <haim.dreyfuss@intel.com>

The wireless device might be capable to connect HE
as well as the AP. However, the regulatory domain might
forbid it. Check whether the regulatory domain allows HE connection
when considering if HE IE should be added.
Also, add it when setting our peer capability.

Signed-off-by: Haim Dreyfuss <haim.dreyfuss@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 net/mac80211/mlme.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index f076e73314a6..152577cc2213 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -313,6 +313,10 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
 		ret |= ieee80211_chandef_downgrade(chandef);
 	}
 
+	if (!cfg80211_chandef_usable(sdata->wdev.wiphy, chandef,
+				     IEEE80211_CHAN_NO_HE))
+		ret |= IEEE80211_STA_DISABLE_HE;
+
 	if (chandef->width != vht_chandef.width && !tracking)
 		sdata_info(sdata,
 			   "capabilities/regulatory prevented using AP HT/VHT configuration, downgraded\n");
@@ -622,10 +626,21 @@ static void ieee80211_add_he_ie(struct ieee80211_sub_if_data *sdata,
 {
 	u8 *pos;
 	const struct ieee80211_sta_he_cap *he_cap = NULL;
+	struct ieee80211_chanctx_conf *chanctx_conf;
 	u8 he_cap_size;
+	bool reg_cap = false;
+
+	rcu_read_lock();
+	chanctx_conf = rcu_dereference(sdata->vif.chanctx_conf);
+	if (!WARN_ON_ONCE(!chanctx_conf))
+		reg_cap = cfg80211_chandef_usable(sdata->wdev.wiphy,
+						  &chanctx_conf->def,
+						  IEEE80211_CHAN_NO_HE);
+
+	rcu_read_unlock();
 
 	he_cap = ieee80211_get_he_sta_cap(sband);
-	if (!he_cap)
+	if (!he_cap || !reg_cap)
 		return;
 
 	/*
-- 
2.24.1

