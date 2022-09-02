Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9455AB435
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Sep 2022 16:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236037AbiIBOvr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Sep 2022 10:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236277AbiIBOvH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Sep 2022 10:51:07 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F9507269B
        for <linux-wireless@vger.kernel.org>; Fri,  2 Sep 2022 07:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=XUUgvV9lcE4V8T0asYtoaM4o40lQDnW9AZ3b9btMzn4=;
        t=1662127992; x=1663337592; b=sNGwT/HmzYcWbUgYAnxiecif9UUd38sBNBmX4+TLvovTYCL
        kpRcsgjpuE2/L++06PfpuaOxXdVFuERS5sG+wqI2diD/pHVoVw45nMyv0WNm7hrmbDcAEJtcXyQMu
        uI1K+OhzsQo4mo5cxWHNZ/C5F0aWjuZjqNXiZHbB5nohOT5QdmLaWkC2VAX6K6EcUahG98w5PDOkl
        cWuSpfbNPq1Xr2a+8/GZeA8okqzwOmVK6kTa2d7GGrNbmrfM4Smfue/AMUgsrA72T8wcaTH7AjeY7
        DHKNvh9oADWIoWLSp77mWSISUJ+a9W0PAWEo8SuBqipDod8qWJwN/mOzuUXy6y0A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oU7Py-006Ch3-0v;
        Fri, 02 Sep 2022 16:13:10 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 19/27] wifi: mac80211: call drv_sta_state() under sdata_lock() in reconfig
Date:   Fri,  2 Sep 2022 16:12:51 +0200
Message-Id: <20220902161143.6f0d7eaf8ef2.I1fb12610d109f47a09f859b8faf653b643e8b9b4@changeid>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220902141259.377789-1-johannes@sipsolutions.net>
References: <20220902141259.377789-1-johannes@sipsolutions.net>
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

Currently, other paths calling drv_sta_state() hold the mutex
and therefore drivers can assume that, and look at links with
that protection. Fix that for the reconfig path as well; to
do it more easily use ieee80211_reconfig_stations() for the
AP/AP_VLAN station reconfig as well.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/util.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 0eed18189491..0ea5d50091dc 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2530,7 +2530,6 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 			if (link)
 				ieee80211_assign_chanctx(local, sdata, link);
 		}
-		sdata_unlock(sdata);
 
 		switch (sdata->vif.type) {
 		case NL80211_IFTYPE_AP_VLAN:
@@ -2549,6 +2548,7 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 					    &sdata->deflink.tx_conf[i]);
 			break;
 		}
+		sdata_unlock(sdata);
 
 		/* common change flags for all interface types */
 		changed = BSS_CHANGED_ERP_CTS_PROT |
@@ -2657,23 +2657,21 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 	}
 
 	/* APs are now beaconing, add back stations */
-	mutex_lock(&local->sta_mtx);
-	list_for_each_entry(sta, &local->sta_list, list) {
-		enum ieee80211_sta_state state;
-
-		if (!sta->uploaded)
-			continue;
-
-		if (sta->sdata->vif.type != NL80211_IFTYPE_AP &&
-		    sta->sdata->vif.type != NL80211_IFTYPE_AP_VLAN)
+	list_for_each_entry(sdata, &local->interfaces, list) {
+		if (!ieee80211_sdata_running(sdata))
 			continue;
 
-		for (state = IEEE80211_STA_NOTEXIST;
-		     state < sta->sta_state; state++)
-			WARN_ON(drv_sta_state(local, sta->sdata, sta, state,
-					      state + 1));
+		sdata_lock(sdata);
+		switch (sdata->vif.type) {
+		case NL80211_IFTYPE_AP_VLAN:
+		case NL80211_IFTYPE_AP:
+			ieee80211_reconfig_stations(sdata);
+			break;
+		default:
+			break;
+		}
+		sdata_unlock(sdata);
 	}
-	mutex_unlock(&local->sta_mtx);
 
 	/* add back keys */
 	list_for_each_entry(sdata, &local->interfaces, list)
-- 
2.37.2

