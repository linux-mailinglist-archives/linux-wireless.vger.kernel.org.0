Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1C99573357
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 11:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235669AbiGMJqD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 05:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236206AbiGMJpX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 05:45:23 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B18F5D65
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 02:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=TqfV+mUl3yeYgPmsWRQrkxNo01IBRV6fnW6JiQ88rYQ=;
        t=1657705520; x=1658915120; b=BAYZanPV1VJQJb+XqW4x2BXAeOuDI7dwkVnwR+DS+3kCbv/
        GxUUmtMfSiXlPn6+nNKLBj/2K6SXHA+oUkw5a2mUMakA2XZvqeY53XUJ8uzyk9Uxk8iL8meLdBqA4
        /RTO2vUh+VNZpXgY/9T9gSUXmxvvdV41bBhSzYxMEBsJtDMovdFq1ZWT9HX/Jc9/Zjsv+Gk4Bop3t
        n8+TG0LGkEYEe2AqwZf7eEGDYB5UroEYGytXxwKNJMln+IOnKFQfz4C8hA3teNFNiP2UNqK+MHNPS
        eBNx6TJ03fnwM/ecSdJI3LETsBGeiZHoAWyFnZWuueLcdrrxO4s22iRJbL158bOw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBYvl-00EgvB-18;
        Wed, 13 Jul 2022 11:45:17 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 40/76] wifi: mac80211: mlme: unify assoc data event sending
Date:   Wed, 13 Jul 2022 11:44:26 +0200
Message-Id: <20220713114425.e67d694db6eb.I52052f42007a7bc31de514281f618192a3c628c2@changeid>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220713094502.163926-1-johannes@sipsolutions.net>
References: <20220713094502.163926-1-johannes@sipsolutions.net>
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

There are a few cases where we send an event to cfg80211
manually, but ieee80211_destroy_assoc_data() also handles
the case of abandoning; some cases don't need an event
and success is handled yet differently.

Unify this by providing a single status argument to the
ieee80211_destroy_assoc_data() function and then handling
all the different cases of events (or no events) there.

This will help simplify the code when MLO support is
added.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/mlme.c | 51 ++++++++++++++++++---------------------------
 1 file changed, 20 insertions(+), 31 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 8d339d3f89ab..772584732b6e 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -2998,14 +2998,21 @@ static void ieee80211_destroy_auth_data(struct ieee80211_sub_if_data *sdata,
 	sdata->u.mgd.auth_data = NULL;
 }
 
+enum assoc_status {
+	ASSOC_SUCCESS,
+	ASSOC_REJECTED,
+	ASSOC_TIMEOUT,
+	ASSOC_ABANDON,
+};
+
 static void ieee80211_destroy_assoc_data(struct ieee80211_sub_if_data *sdata,
-					 bool assoc, bool abandon)
+					 enum assoc_status status)
 {
 	struct ieee80211_mgd_assoc_data *assoc_data = sdata->u.mgd.assoc_data;
 
 	sdata_assert_lock(sdata);
 
-	if (!assoc) {
+	if (status != ASSOC_SUCCESS) {
 		/*
 		 * we are not associated yet, the only timer that could be
 		 * running is the timeout for the association response which
@@ -3026,9 +3033,10 @@ static void ieee80211_destroy_assoc_data(struct ieee80211_sub_if_data *sdata,
 		ieee80211_link_release_channel(&sdata->deflink);
 		mutex_unlock(&sdata->local->mtx);
 
-		if (abandon) {
+		if (status != ASSOC_REJECTED) {
 			struct cfg80211_assoc_failure data = {
 				.bss[0] = assoc_data->bss,
+				.timeout = status == ASSOC_TIMEOUT,
 			};
 
 			cfg80211_assoc_failure(sdata->dev, &data);
@@ -3309,7 +3317,7 @@ static void ieee80211_rx_mgmt_deauth(struct ieee80211_sub_if_data *sdata,
 			   bssid, reason_code,
 			   ieee80211_get_reason_code_string(reason_code));
 
-		ieee80211_destroy_assoc_data(sdata, false, true);
+		ieee80211_destroy_assoc_data(sdata, ASSOC_ABANDON);
 
 		cfg80211_rx_mlme_mgmt(sdata->dev, (u8 *)mgmt, len);
 		return;
@@ -3953,19 +3961,14 @@ static void ieee80211_rx_mgmt_assoc_resp(struct ieee80211_sub_if_data *sdata,
 	if (status_code != WLAN_STATUS_SUCCESS) {
 		sdata_info(sdata, "%pM denied association (code=%d)\n",
 			   mgmt->sa, status_code);
-		ieee80211_destroy_assoc_data(sdata, false, false);
+		ieee80211_destroy_assoc_data(sdata, ASSOC_REJECTED);
 		event.u.mlme.status = MLME_DENIED;
 		event.u.mlme.reason = status_code;
 		drv_event_callback(sdata->local, sdata, &event);
 	} else {
 		if (!ieee80211_assoc_success(sdata, cbss, mgmt, len, elems)) {
 			/* oops -- internal error -- send timeout for now */
-			struct cfg80211_assoc_failure data = {
-				.timeout = true,
-				.bss[0] = cbss,
-			};
-			ieee80211_destroy_assoc_data(sdata, false, false);
-			cfg80211_assoc_failure(sdata->dev, &data);
+			ieee80211_destroy_assoc_data(sdata, ASSOC_TIMEOUT);
 			goto notify_driver;
 		}
 		event.u.mlme.status = MLME_SUCCESS;
@@ -3977,7 +3980,7 @@ static void ieee80211_rx_mgmt_assoc_resp(struct ieee80211_sub_if_data *sdata,
 		 * recalc after assoc_data is NULL but before associated
 		 * is set can cause the interface to go idle
 		 */
-		ieee80211_destroy_assoc_data(sdata, true, false);
+		ieee80211_destroy_assoc_data(sdata, ASSOC_SUCCESS);
 
 		/* get uapsd queues configuration */
 		uapsd_queues = 0;
@@ -4835,19 +4838,13 @@ void ieee80211_sta_work(struct ieee80211_sub_if_data *sdata)
 		if ((ifmgd->assoc_data->need_beacon &&
 		     !sdata->deflink.u.mgd.have_beacon) ||
 		    ieee80211_do_assoc(sdata)) {
-			struct cfg80211_bss *bss = ifmgd->assoc_data->bss;
 			struct ieee80211_event event = {
 				.type = MLME_EVENT,
 				.u.mlme.data = ASSOC_EVENT,
 				.u.mlme.status = MLME_TIMEOUT,
 			};
-			struct cfg80211_assoc_failure data = {
-				.bss[0] = bss,
-				.timeout = true,
-			};
 
-			ieee80211_destroy_assoc_data(sdata, false, false);
-			cfg80211_assoc_failure(sdata->dev, &data);
+			ieee80211_destroy_assoc_data(sdata, ASSOC_TIMEOUT);
 			drv_event_callback(sdata->local, sdata, &event);
 		}
 	} else if (ifmgd->assoc_data && ifmgd->assoc_data->timeout_started)
@@ -5012,7 +5009,7 @@ void ieee80211_mgd_quiesce(struct ieee80211_sub_if_data *sdata)
 					       WLAN_REASON_DEAUTH_LEAVING,
 					       false, frame_buf);
 		if (ifmgd->assoc_data)
-			ieee80211_destroy_assoc_data(sdata, false, true);
+			ieee80211_destroy_assoc_data(sdata, ASSOC_ABANDON);
 		if (ifmgd->auth_data)
 			ieee80211_destroy_auth_data(sdata, false);
 		cfg80211_tx_mlme_mgmt(sdata->dev, frame_buf,
@@ -6407,7 +6404,7 @@ int ieee80211_mgd_deauth(struct ieee80211_sub_if_data *sdata,
 					       IEEE80211_STYPE_DEAUTH,
 					       req->reason_code, tx,
 					       frame_buf);
-		ieee80211_destroy_assoc_data(sdata, false, true);
+		ieee80211_destroy_assoc_data(sdata, ASSOC_ABANDON);
 		ieee80211_report_disconnect(sdata, frame_buf,
 					    sizeof(frame_buf), true,
 					    req->reason_code, false);
@@ -6478,16 +6475,8 @@ void ieee80211_mgd_stop(struct ieee80211_sub_if_data *sdata)
 	cancel_delayed_work_sync(&ifmgd->tdls_peer_del_work);
 
 	sdata_lock(sdata);
-	if (ifmgd->assoc_data) {
-		struct cfg80211_bss *bss = ifmgd->assoc_data->bss;
-		struct cfg80211_assoc_failure data = {
-			.bss[0] = bss,
-			.timeout = true,
-		};
-
-		ieee80211_destroy_assoc_data(sdata, false, false);
-		cfg80211_assoc_failure(sdata->dev, &data);
-	}
+	if (ifmgd->assoc_data)
+		ieee80211_destroy_assoc_data(sdata, ASSOC_TIMEOUT);
 	if (ifmgd->auth_data)
 		ieee80211_destroy_auth_data(sdata, false);
 	spin_lock_bh(&ifmgd->teardown_lock);
-- 
2.36.1

