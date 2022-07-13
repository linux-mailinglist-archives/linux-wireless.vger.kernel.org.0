Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6E3573353
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 11:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235181AbiGMJqE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 05:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236212AbiGMJpX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 05:45:23 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF50C04F4
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 02:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=TG9oBaJziNF8wnrAAMKjLv2aa3BbfHZygjIgor+8uOU=;
        t=1657705520; x=1658915120; b=Zz8LWEG+S8BKRMBHMLtrjOFQIQgo/5q8TABsU3R2FzpyjA4
        SvBzA1/e/6DBxkQpUjKAgqzULbZ2iSNCY/86ofXLodMCUFLPjGq/CMq+ubG5FYTe0xz2O2HrTXZjR
        uesVoFY6zU4K6NJ50WZfSjx0wNV6G8+9K9ffwzgLrZ69sTUdkM+JDo+agt+Q2bxKedQ1VqM6QWOdw
        rz76yThlMoHBiDRvp+fynZAwGowtFvMiqGxwkjMc5Ii0uHxqvrnXsvOstMrDkQrrfLLG3zIJIBQoN
        Jth/oeKFfnlGcpC3amyw8zrUZ17ktTi0uW0SSroivWgpoBm+t4VPFHMoI+0UPZ7A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBYvk-00EgvB-D4;
        Wed, 13 Jul 2022 11:45:16 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 38/76] wifi: cfg80211: remove BSS pointer from cfg80211_disassoc_request
Date:   Wed, 13 Jul 2022 11:44:24 +0200
Message-Id: <20220713114425.d91527f387df.Ie3f9ceefd2ecf78d55bb09b2e434da9b2a992dcc@changeid>
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

The race described by the comment in mac80211 hasn't existed
since the locking rework to use the same lock and for MLO we
need to pass the AP MLD address, so just pass the BSSID or
AP MLD address instead of the BSS struct pointer, and adjust
all the code accordingly.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/cfg80211.h |  6 +++---
 net/mac80211/mlme.c    | 14 +++++---------
 net/wireless/core.h    |  2 +-
 net/wireless/mlme.c    |  8 +++-----
 net/wireless/trace.h   |  5 +----
 5 files changed, 13 insertions(+), 22 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index e50b93160319..cc20f0036e75 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -2886,7 +2886,7 @@ struct cfg80211_assoc_request {
  * This structure provides information needed to complete IEEE 802.11
  * deauthentication.
  *
- * @bssid: the BSSID of the BSS to deauthenticate from
+ * @bssid: the BSSID or AP MLD address to deauthenticate from
  * @ie: Extra IEs to add to Deauthentication frame or %NULL
  * @ie_len: Length of ie buffer in octets
  * @reason_code: The reason code for the deauthentication
@@ -2907,7 +2907,7 @@ struct cfg80211_deauth_request {
  * This structure provides information needed to complete IEEE 802.11
  * disassociation.
  *
- * @bss: the BSS to disassociate from
+ * @ap_addr: the BSSID or AP MLD address to disassociate from
  * @ie: Extra IEs to add to Disassociation frame or %NULL
  * @ie_len: Length of ie buffer in octets
  * @reason_code: The reason code for the disassociation
@@ -2915,7 +2915,7 @@ struct cfg80211_deauth_request {
  *	Disassociation frame is to be transmitted.
  */
 struct cfg80211_disassoc_request {
-	struct cfg80211_bss *bss;
+	const u8 *ap_addr;
 	const u8 *ie;
 	size_t ie_len;
 	u16 reason_code;
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 7870e3e23e26..0c432e3abd90 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -6425,18 +6425,14 @@ int ieee80211_mgd_disassoc(struct ieee80211_sub_if_data *sdata,
 {
 	u8 frame_buf[IEEE80211_DEAUTH_FRAME_LEN];
 
-	/*
-	 * cfg80211 should catch this ... but it's racy since
-	 * we can receive a disassoc frame, process it, hand it
-	 * to cfg80211 while that's in a locked section already
-	 * trying to tell us that the user wants to disconnect.
-	 */
-	if (sdata->deflink.u.mgd.bss != req->bss)
-		return -ENOLINK;
+	if (!sdata->u.mgd.associated ||
+	    memcmp(sdata->vif.cfg.ap_addr, req->ap_addr, ETH_ALEN))
+		return -ENOTCONN;
 
 	sdata_info(sdata,
 		   "disassociating from %pM by local choice (Reason: %u=%s)\n",
-		   req->bss->bssid, req->reason_code, ieee80211_get_reason_code_string(req->reason_code));
+		   req->ap_addr, req->reason_code,
+		   ieee80211_get_reason_code_string(req->reason_code));
 
 	ieee80211_set_disassoc(sdata, IEEE80211_STYPE_DISASSOC,
 			       req->reason_code, !req->local_state_change,
diff --git a/net/wireless/core.h b/net/wireless/core.h
index fd723fa5e2d7..e72ca6eefafb 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -372,7 +372,7 @@ int cfg80211_mlme_deauth(struct cfg80211_registered_device *rdev,
 			 const u8 *ie, int ie_len, u16 reason,
 			 bool local_state_change);
 int cfg80211_mlme_disassoc(struct cfg80211_registered_device *rdev,
-			   struct net_device *dev, const u8 *bssid,
+			   struct net_device *dev, const u8 *ap_addr,
 			   const u8 *ie, int ie_len, u16 reason,
 			   bool local_state_change);
 void cfg80211_mlme_down(struct cfg80211_registered_device *rdev,
diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
index 935537c64ed8..4a35b3559daa 100644
--- a/net/wireless/mlme.c
+++ b/net/wireless/mlme.c
@@ -370,7 +370,7 @@ int cfg80211_mlme_deauth(struct cfg80211_registered_device *rdev,
 }
 
 int cfg80211_mlme_disassoc(struct cfg80211_registered_device *rdev,
-			   struct net_device *dev, const u8 *bssid,
+			   struct net_device *dev, const u8 *ap_addr,
 			   const u8 *ie, int ie_len, u16 reason,
 			   bool local_state_change)
 {
@@ -380,6 +380,7 @@ int cfg80211_mlme_disassoc(struct cfg80211_registered_device *rdev,
 		.local_state_change = local_state_change,
 		.ie = ie,
 		.ie_len = ie_len,
+		.ap_addr = ap_addr,
 	};
 	int err;
 
@@ -388,10 +389,7 @@ int cfg80211_mlme_disassoc(struct cfg80211_registered_device *rdev,
 	if (!wdev->connected)
 		return -ENOTCONN;
 
-	if (ether_addr_equal(wdev->links[0].client.current_bss->pub.bssid,
-			     bssid))
-		req.bss = &wdev->links[0].client.current_bss->pub;
-	else
+	if (memcmp(wdev->u.client.connected_addr, ap_addr, ETH_ALEN))
 		return -ENOTCONN;
 
 	err = rdev_disassoc(rdev, dev, &req);
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index c50e8a04199e..4316d3dc31ea 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -1318,10 +1318,7 @@ TRACE_EVENT(rdev_disassoc,
 	TP_fast_assign(
 		WIPHY_ASSIGN;
 		NETDEV_ASSIGN;
-		if (req->bss)
-			MAC_ASSIGN(bssid, req->bss->bssid);
-		else
-			eth_zero_addr(__entry->bssid);
+		MAC_ASSIGN(bssid, req->ap_addr);
 		__entry->reason_code = req->reason_code;
 		__entry->local_state_change = req->local_state_change;
 	),
-- 
2.36.1

