Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 687AA600733
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Oct 2022 09:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiJQHD7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Oct 2022 03:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiJQHD5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Oct 2022 03:03:57 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF064D800
        for <linux-wireless@vger.kernel.org>; Mon, 17 Oct 2022 00:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=gwgTywA4Uh9wk2O9AButjyP/rqHME2q0HYHLs/rfNh4=; t=1665990236; x=1667199836; 
        b=oFOzi4QAZEVmnSdO+RGGgLoQm6VL8xwaDYIqx7WapFhnxbbKndnjr41PHCtw8xSjgZCaFqOYpSg
        LWKEe4JdBOS/uuTQkQ5B7NUme991fpab6PdFAdYDijMnf9w2Ap6dsU8vZ7+7WYpJZAvrecxd8ehAr
        pVxpIOORGRJWHqWQQW0zb8fvDkcg3f+m0Gbu14lO6GjylHWcUmB7LqXOdwBCxJDbNEYX1Vbkuv+Oq
        xNv25zwHAuBdNkqMXfH4Pioiz+oIx+NKJziYw+FcedQrgDiibfVbGy5U65rwjUw+C9CmWK16MoAKp
        4u4oBnCRQ+NR7hec7TwtZoNqQQNzl1hR9gxw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1okKAA-009AP5-2X;
        Mon, 17 Oct 2022 09:03:50 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] wifi: cfg80211: use bss_from_pub() instead of container_of()
Date:   Mon, 17 Oct 2022 09:03:48 +0200
Message-Id: <20221017090347.b64a0bf0de7f.I9b0201ea1f84b4da286e89504a76d6d36670faf1@changeid>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

There's no need to open-code container_of() when we have
bss_from_pub(). Use it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/scan.c | 41 +++++++++++------------------------------
 1 file changed, 11 insertions(+), 30 deletions(-)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 5382fc2003db..d5b520b624ff 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -164,9 +164,8 @@ static inline void bss_ref_put(struct cfg80211_registered_device *rdev,
 
 	if (bss->pub.hidden_beacon_bss) {
 		struct cfg80211_internal_bss *hbss;
-		hbss = container_of(bss->pub.hidden_beacon_bss,
-				    struct cfg80211_internal_bss,
-				    pub);
+
+		hbss = bss_from_pub(bss->pub.hidden_beacon_bss);
 		hbss->refcount--;
 		if (hbss->refcount == 0)
 			bss_free(hbss);
@@ -175,9 +174,7 @@ static inline void bss_ref_put(struct cfg80211_registered_device *rdev,
 	if (bss->pub.transmitted_bss) {
 		struct cfg80211_internal_bss *tbss;
 
-		tbss = container_of(bss->pub.transmitted_bss,
-				    struct cfg80211_internal_bss,
-				    pub);
+		tbss = bss_from_pub(bss->pub.transmitted_bss);
 		tbss->refcount--;
 		if (tbss->refcount == 0)
 			bss_free(tbss);
@@ -1774,13 +1771,8 @@ cfg80211_bss_update(struct cfg80211_registered_device *rdev,
 
 		/* This must be before the call to bss_ref_get */
 		if (tmp->pub.transmitted_bss) {
-			struct cfg80211_internal_bss *pbss =
-				container_of(tmp->pub.transmitted_bss,
-					     struct cfg80211_internal_bss,
-					     pub);
-
 			new->pub.transmitted_bss = tmp->pub.transmitted_bss;
-			bss_ref_get(rdev, pbss);
+			bss_ref_get(rdev, bss_from_pub(tmp->pub.transmitted_bss));
 		}
 
 		list_add_tail(&new->list, &rdev->bss_list);
@@ -2544,15 +2536,12 @@ EXPORT_SYMBOL(cfg80211_inform_bss_frame_data);
 void cfg80211_ref_bss(struct wiphy *wiphy, struct cfg80211_bss *pub)
 {
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
-	struct cfg80211_internal_bss *bss;
 
 	if (!pub)
 		return;
 
-	bss = container_of(pub, struct cfg80211_internal_bss, pub);
-
 	spin_lock_bh(&rdev->bss_lock);
-	bss_ref_get(rdev, bss);
+	bss_ref_get(rdev, bss_from_pub(pub));
 	spin_unlock_bh(&rdev->bss_lock);
 }
 EXPORT_SYMBOL(cfg80211_ref_bss);
@@ -2560,15 +2549,12 @@ EXPORT_SYMBOL(cfg80211_ref_bss);
 void cfg80211_put_bss(struct wiphy *wiphy, struct cfg80211_bss *pub)
 {
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
-	struct cfg80211_internal_bss *bss;
 
 	if (!pub)
 		return;
 
-	bss = container_of(pub, struct cfg80211_internal_bss, pub);
-
 	spin_lock_bh(&rdev->bss_lock);
-	bss_ref_put(rdev, bss);
+	bss_ref_put(rdev, bss_from_pub(pub));
 	spin_unlock_bh(&rdev->bss_lock);
 }
 EXPORT_SYMBOL(cfg80211_put_bss);
@@ -2582,7 +2568,7 @@ void cfg80211_unlink_bss(struct wiphy *wiphy, struct cfg80211_bss *pub)
 	if (WARN_ON(!pub))
 		return;
 
-	bss = container_of(pub, struct cfg80211_internal_bss, pub);
+	bss = bss_from_pub(pub);
 
 	spin_lock_bh(&rdev->bss_lock);
 	if (list_empty(&bss->list))
@@ -2591,8 +2577,7 @@ void cfg80211_unlink_bss(struct wiphy *wiphy, struct cfg80211_bss *pub)
 	list_for_each_entry_safe(nontrans_bss, tmp,
 				 &pub->nontrans_list,
 				 nontrans_list) {
-		tmp1 = container_of(nontrans_bss,
-				    struct cfg80211_internal_bss, pub);
+		tmp1 = bss_from_pub(nontrans_bss);
 		if (__cfg80211_unlink_bss(rdev, tmp1))
 			rdev->bss_generation++;
 	}
@@ -2649,9 +2634,7 @@ void cfg80211_update_assoc_bss_entry(struct wireless_dev *wdev,
 
 	/* use transmitting bss */
 	if (cbss->pub.transmitted_bss)
-		cbss = container_of(cbss->pub.transmitted_bss,
-				    struct cfg80211_internal_bss,
-				    pub);
+		cbss = bss_from_pub(cbss->pub.transmitted_bss);
 
 	cbss->pub.channel = chan;
 
@@ -2680,8 +2663,7 @@ void cfg80211_update_assoc_bss_entry(struct wireless_dev *wdev,
 		list_for_each_entry_safe(nontrans_bss, tmp,
 					 &new->pub.nontrans_list,
 					 nontrans_list) {
-			bss = container_of(nontrans_bss,
-					   struct cfg80211_internal_bss, pub);
+			bss = bss_from_pub(nontrans_bss);
 			if (__cfg80211_unlink_bss(rdev, bss))
 				rdev->bss_generation++;
 		}
@@ -2698,8 +2680,7 @@ void cfg80211_update_assoc_bss_entry(struct wireless_dev *wdev,
 	list_for_each_entry_safe(nontrans_bss, tmp,
 				 &cbss->pub.nontrans_list,
 				 nontrans_list) {
-		bss = container_of(nontrans_bss,
-				   struct cfg80211_internal_bss, pub);
+		bss = bss_from_pub(nontrans_bss);
 		bss->pub.channel = chan;
 		rb_erase(&bss->rbn, &rdev->bss_tree);
 		rb_insert_bss(rdev, bss);
-- 
2.37.3

