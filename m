Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57CE2573A42
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 17:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236986AbiGMPe6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 11:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236954AbiGMPeo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 11:34:44 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB00730F46
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 08:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=mJvh0OLazZCuKrSanYZTk8Uh20wCU1+5gS0MP7RJq4Y=;
        t=1657726483; x=1658936083; b=ALlUFONThWXs5Blxu+Qd6Qq84ZTNgYjsrl0qVj7EF97/5im
        XUHYLs69u2LU7kYHJsniRIIrZZCeudpJfHCdJl4YEfdoEFTNImKQBcpnuBaRghcsEteDmi40zc05X
        8qay/Sn/VXmG1iK7TMPaZUzauGKfRbAJjD2fv5ehURyNRuQKN8S92BBkYtSh+omH3HhB1jTrwf2O8
        YkxPWQudGLqNdFw03nzpVxXHuCfaxt3gfxHMINKevGsPdIEzyOe6qL1PXZgsJ0BAbWMZLkBNhubL+
        xyxVJ3rfauJU2i97J0SYJJ4jUobChTL26sePIZph54pUxTfj9vrKQuptAyCuimEw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBeNu-00EnaA-3T;
        Wed, 13 Jul 2022 17:34:42 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 19/21] wifi: mac80211: mlme: look up beacon elems only if needed
Date:   Wed, 13 Jul 2022 17:34:31 +0200
Message-Id: <20220713173301.b27a0272f45a.If385834be226619b7581a6b343adfc97c638b1aa@changeid>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220713153433.279227-1-johannes@sipsolutions.net>
References: <20220713153433.279227-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

If NEED_DTIM_BEFORE_ASSOC isn't set, then we don't need
to enter an RCU critical section and look up the beacon
elements.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/mlme.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 09b79fb42bb8..0614712236de 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -6269,7 +6269,6 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
 	struct ieee80211_bss *bss = (void *)req->bss->priv;
 	struct ieee80211_mgd_assoc_data *assoc_data;
-	const struct cfg80211_bss_ies *beacon_ies;
 	struct ieee80211_vif_cfg *vif_cfg = &sdata->vif.cfg;
 	const struct element *ssid_elem;
 	struct ieee80211_link_data *link = &sdata->deflink;
@@ -6487,22 +6486,25 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 		link->smps_mode = link->u.mgd.req_smps;
 	}
 
-	rcu_read_lock();
-	beacon_ies = rcu_dereference(req->bss->beacon_ies);
+	if (ieee80211_hw_check(&sdata->local->hw, NEED_DTIM_BEFORE_ASSOC)) {
+		const struct cfg80211_bss_ies *beacon_ies;
 
-	if (ieee80211_hw_check(&sdata->local->hw, NEED_DTIM_BEFORE_ASSOC) &&
-	    !beacon_ies) {
-		/*
-		 * Wait up to one beacon interval ...
-		 * should this be more if we miss one?
-		 */
-		sdata_info(sdata, "waiting for beacon from %pM\n",
-			   link->u.mgd.bssid);
-		assoc_data->timeout = TU_TO_EXP_TIME(req->bss->beacon_interval);
-		assoc_data->timeout_started = true;
-		assoc_data->need_beacon = true;
+		rcu_read_lock();
+		beacon_ies = rcu_dereference(req->bss->beacon_ies);
+
+		if (beacon_ies) {
+			/*
+			 * Wait up to one beacon interval ...
+			 * should this be more if we miss one?
+			 */
+			sdata_info(sdata, "waiting for beacon from %pM\n",
+				   link->u.mgd.bssid);
+			assoc_data->timeout = TU_TO_EXP_TIME(req->bss->beacon_interval);
+			assoc_data->timeout_started = true;
+			assoc_data->need_beacon = true;
+		}
+		rcu_read_unlock();
 	}
-	rcu_read_unlock();
 
 	run_again(sdata, assoc_data->timeout);
 
-- 
2.36.1

