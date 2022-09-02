Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E78A05AB430
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Sep 2022 16:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236939AbiIBOvs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Sep 2022 10:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236602AbiIBOvI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Sep 2022 10:51:08 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3FFCC6CFD
        for <linux-wireless@vger.kernel.org>; Fri,  2 Sep 2022 07:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=AIU9Cq4XFIi0mNMtUqFV+kVrHz3R9jjwNT8zL48ZNN8=;
        t=1662127992; x=1663337592; b=KqrwBpGe7KAaADEy6KIZ5nM9OLNRj8RDAtEKBKlPmBkUf7k
        +Udd1sjp/mXdM1/l/VQLg+7GpP966Gug8qfDhIK7ljPFlqxndv3PkSARQCQPQcz9rUEpWKQQjrk8V
        3RX+RWho2vsow5AuA+QlgV9L9RVXk02IgVepcMw2hj4djBj7ABucEzBZXmfiD0eUSXmzoKO24D62n
        oUFkbhmACjus72kqubG/in7hxO2971LcrNVRx7Iu3mGeNy5hs9RtDm4zRMG0aJ4ZNrZE5sDhbs+Yg
        OA8+eCv0YCVum8zlrXywqFZ3kbBmT9xMWpmI9hTWcXhoE9OilrV4kfoH+QAbVTiA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oU7Py-006Ch3-2o;
        Fri, 02 Sep 2022 16:13:10 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 21/27] wifi: mac80211: set up beacon timing config on links
Date:   Fri,  2 Sep 2022 16:12:53 +0200
Message-Id: <20220902161143.b3ab2553538c.I47c496386723d852da80f17e8b504a97176aa696@changeid>
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

On secondary MLO links, I forgot to set the beacon interval
and DTIM period, fix that.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/mlme.c | 83 +++++++++++++++++++++++++--------------------
 1 file changed, 47 insertions(+), 36 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index bf883f2e6de3..8a2237106002 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -4819,6 +4819,40 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 	return ret;
 }
 
+static bool ieee80211_get_dtim(const struct cfg80211_bss_ies *ies,
+			       u8 *dtim_count, u8 *dtim_period)
+{
+	const u8 *tim_ie = cfg80211_find_ie(WLAN_EID_TIM, ies->data, ies->len);
+	const u8 *idx_ie = cfg80211_find_ie(WLAN_EID_MULTI_BSSID_IDX, ies->data,
+					 ies->len);
+	const struct ieee80211_tim_ie *tim = NULL;
+	const struct ieee80211_bssid_index *idx;
+	bool valid = tim_ie && tim_ie[1] >= 2;
+
+	if (valid)
+		tim = (void *)(tim_ie + 2);
+
+	if (dtim_count)
+		*dtim_count = valid ? tim->dtim_count : 0;
+
+	if (dtim_period)
+		*dtim_period = valid ? tim->dtim_period : 0;
+
+	/* Check if value is overridden by non-transmitted profile */
+	if (!idx_ie || idx_ie[1] < 3)
+		return valid;
+
+	idx = (void *)(idx_ie + 2);
+
+	if (dtim_count)
+		*dtim_count = idx->dtim_count;
+
+	if (dtim_period)
+		*dtim_period = idx->dtim_period;
+
+	return true;
+}
+
 static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 				    struct ieee80211_mgmt *mgmt,
 				    struct ieee802_11_elems *elems,
@@ -4882,8 +4916,19 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 			goto out_err;
 
 		if (link_id != assoc_data->assoc_link_id) {
-			err = ieee80211_prep_channel(sdata, link,
-						     assoc_data->link[link_id].bss,
+			struct cfg80211_bss *cbss = assoc_data->link[link_id].bss;
+			const struct cfg80211_bss_ies *ies;
+
+			rcu_read_lock();
+			ies = rcu_dereference(cbss->ies);
+			ieee80211_get_dtim(ies,
+					   &link->conf->sync_dtim_count,
+					   &link->u.mgd.dtim_period);
+			link->conf->dtim_period = link->u.mgd.dtim_period ?: 1;
+			link->conf->beacon_int = cbss->beacon_interval;
+			rcu_read_unlock();
+
+			err = ieee80211_prep_channel(sdata, link, cbss,
 						     &link->u.mgd.conn_flags);
 			if (err) {
 				link_info(link, "prep_channel failed\n");
@@ -6356,40 +6401,6 @@ void ieee80211_mlme_notify_scan_completed(struct ieee80211_local *local)
 	rcu_read_unlock();
 }
 
-static bool ieee80211_get_dtim(const struct cfg80211_bss_ies *ies,
-			       u8 *dtim_count, u8 *dtim_period)
-{
-	const u8 *tim_ie = cfg80211_find_ie(WLAN_EID_TIM, ies->data, ies->len);
-	const u8 *idx_ie = cfg80211_find_ie(WLAN_EID_MULTI_BSSID_IDX, ies->data,
-					 ies->len);
-	const struct ieee80211_tim_ie *tim = NULL;
-	const struct ieee80211_bssid_index *idx;
-	bool valid = tim_ie && tim_ie[1] >= 2;
-
-	if (valid)
-		tim = (void *)(tim_ie + 2);
-
-	if (dtim_count)
-		*dtim_count = valid ? tim->dtim_count : 0;
-
-	if (dtim_period)
-		*dtim_period = valid ? tim->dtim_period : 0;
-
-	/* Check if value is overridden by non-transmitted profile */
-	if (!idx_ie || idx_ie[1] < 3)
-		return valid;
-
-	idx = (void *)(idx_ie + 2);
-
-	if (dtim_count)
-		*dtim_count = idx->dtim_count;
-
-	if (dtim_period)
-		*dtim_period = idx->dtim_period;
-
-	return true;
-}
-
 static int ieee80211_prep_connection(struct ieee80211_sub_if_data *sdata,
 				     struct cfg80211_bss *cbss, s8 link_id,
 				     const u8 *ap_mld_addr, bool assoc,
-- 
2.37.2

