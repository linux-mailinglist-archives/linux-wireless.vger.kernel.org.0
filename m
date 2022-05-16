Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 297B05282B9
	for <lists+linux-wireless@lfdr.de>; Mon, 16 May 2022 12:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238325AbiEPK5w (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 May 2022 06:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242370AbiEPK5s (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 May 2022 06:57:48 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1627E28E1B
        for <linux-wireless@vger.kernel.org>; Mon, 16 May 2022 03:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=2QsqNvHxG9X3UsNDcUybgPCqpIreWmgaU6Fp2tMAY/M=; t=1652698658; x=1653908258; 
        b=R0q0bb4FnqIGEv8CxkusULFNF//g0HTru9GvuEhONdEnBocfLM4MKpdMiDzTQnnirfyhDxt1QGk
        G3qdaVdHWV4vQbPKUC2zsAOPkgAtpsQL2gj3nbdlvIZO0Y4B9UqvWwswIxGD7v0/4suLz2ilL0hat
        QSDR5oHrB2vC3ivWt8j68CPD+lKfAkGOzeGmGymTwDDvedjJzGKsjLq7Jd6obGOzIuGH0AWU8qnnl
        brd2YM6jS8okO8+lJEVmJvNwTm5FYc7Id2d9H5mS6+oVgBo4rtooNdPSdyssIYQpKTqagdpXXnMmg
        ayeURxTD1vq9sG7mV5aVddDMr/Mn785GRYsQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nqYPu-00DLLC-Uk;
        Mon, 16 May 2022 12:57:35 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] mac80211: refactor freeing the next_beacon
Date:   Mon, 16 May 2022 12:57:32 +0200
Message-Id: <20220516125731.c463ee66ce05.I10a3a666030edf78e6dde4347040b03409e1aa92@changeid>
X-Mailer: git-send-email 2.36.1
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

We have this code seven times, refactor it into a
separate function.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/cfg.c | 45 ++++++++++++++++++---------------------------
 1 file changed, 18 insertions(+), 27 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index bbec7d778084..f7896f257e1b 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1348,6 +1348,16 @@ static int ieee80211_change_beacon(struct wiphy *wiphy, struct net_device *dev,
 	return 0;
 }
 
+static void ieee80211_free_next_beacon(struct ieee80211_sub_if_data *sdata)
+{
+	if (!sdata->u.ap.next_beacon)
+		return;
+
+	kfree(sdata->u.ap.next_beacon->mbssid_ies);
+	kfree(sdata->u.ap.next_beacon);
+	sdata->u.ap.next_beacon = NULL;
+}
+
 static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev)
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
@@ -1382,11 +1392,7 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev)
 
 	mutex_unlock(&local->mtx);
 
-	if (sdata->u.ap.next_beacon) {
-		kfree(sdata->u.ap.next_beacon->mbssid_ies);
-		kfree(sdata->u.ap.next_beacon);
-		sdata->u.ap.next_beacon = NULL;
-	}
+	ieee80211_free_next_beacon(sdata);
 
 	/* turn off carrier for this interface and dependent VLANs */
 	list_for_each_entry(vlan, &sdata->u.ap.vlans, u.vlan.list)
@@ -3321,9 +3327,7 @@ static int ieee80211_set_after_csa_beacon(struct ieee80211_sub_if_data *sdata,
 
 		err = ieee80211_assign_beacon(sdata, sdata->u.ap.next_beacon,
 					      NULL, NULL);
-		kfree(sdata->u.ap.next_beacon->mbssid_ies);
-		kfree(sdata->u.ap.next_beacon);
-		sdata->u.ap.next_beacon = NULL;
+		ieee80211_free_next_beacon(sdata);
 
 		if (err < 0)
 			return err;
@@ -3479,9 +3483,7 @@ static int ieee80211_set_csa_beacon(struct ieee80211_sub_if_data *sdata,
 		     IEEE80211_MAX_CNTDWN_COUNTERS_NUM) ||
 		    (params->n_counter_offsets_presp >
 		     IEEE80211_MAX_CNTDWN_COUNTERS_NUM)) {
-			kfree(sdata->u.ap.next_beacon->mbssid_ies);
-			kfree(sdata->u.ap.next_beacon);
-			sdata->u.ap.next_beacon = NULL;
+			ieee80211_free_next_beacon(sdata);
 			return -EINVAL;
 		}
 
@@ -3493,9 +3495,7 @@ static int ieee80211_set_csa_beacon(struct ieee80211_sub_if_data *sdata,
 
 		err = ieee80211_assign_beacon(sdata, &params->beacon_csa, &csa, NULL);
 		if (err < 0) {
-			kfree(sdata->u.ap.next_beacon->mbssid_ies);
-			kfree(sdata->u.ap.next_beacon);
-			sdata->u.ap.next_beacon = NULL;
+			ieee80211_free_next_beacon(sdata);
 			return err;
 		}
 		*changed |= err;
@@ -3585,11 +3585,8 @@ static int ieee80211_set_csa_beacon(struct ieee80211_sub_if_data *sdata,
 static void ieee80211_color_change_abort(struct ieee80211_sub_if_data  *sdata)
 {
 	sdata->vif.color_change_active = false;
-	if (sdata->u.ap.next_beacon) {
-		kfree(sdata->u.ap.next_beacon->mbssid_ies);
-		kfree(sdata->u.ap.next_beacon);
-		sdata->u.ap.next_beacon = NULL;
-	}
+
+	ieee80211_free_next_beacon(sdata);
 
 	cfg80211_color_change_aborted_notify(sdata->dev);
 }
@@ -4330,9 +4327,7 @@ ieee80211_set_after_color_change_beacon(struct ieee80211_sub_if_data *sdata,
 
 		ret = ieee80211_assign_beacon(sdata, sdata->u.ap.next_beacon,
 					      NULL, NULL);
-		kfree(sdata->u.ap.next_beacon->mbssid_ies);
-		kfree(sdata->u.ap.next_beacon);
-		sdata->u.ap.next_beacon = NULL;
+		ieee80211_free_next_beacon(sdata);
 
 		if (ret < 0)
 			return ret;
@@ -4375,11 +4370,7 @@ ieee80211_set_color_change_beacon(struct ieee80211_sub_if_data *sdata,
 		err = ieee80211_assign_beacon(sdata, &params->beacon_color_change,
 					      NULL, &color_change);
 		if (err < 0) {
-			if (sdata->u.ap.next_beacon) {
-				kfree(sdata->u.ap.next_beacon->mbssid_ies);
-				kfree(sdata->u.ap.next_beacon);
-				sdata->u.ap.next_beacon = NULL;
-			}
+			ieee80211_free_next_beacon(sdata);
 			return err;
 		}
 		*changed |= err;
-- 
2.36.1

