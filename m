Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFED2573331
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 11:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236229AbiGMJpd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 05:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234656AbiGMJpN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 05:45:13 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A2BDA5A9
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 02:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=fqMlh2jGOL4mhs4t02ru9uQcEw0qFUtigf4mC9qlb2Y=;
        t=1657705512; x=1658915112; b=s/goospiXSkteVglSnjVwNwdV2jNgJEo/qXqwFbLx0PlUDT
        xWLFTDJ7UtNdRetrsVuESGNavP/oY8kJFPfJUE3MQj/86uN0cIUyqAXKdo7/NH2nZOy24gbODyhvE
        bVE7CwNOR6w+zab8ntadsJ4rd3TMjxIdfAC1Q+ULX3bNkCmWd2vylyvlCG1Mi4TEKMF1iif2cALJz
        rL4Op4od1zoyGJsSPmmBkaUGyd2w/Ni1u/BApDWC19uGKNM/SmdiOfHXC2jQvkjlNqnDboRlFQXmL
        zXj4ZxyowdeFZVbsV59NH5p1R6Og1SasFCBtmn4RDSaQXqnfosZQZG/pGsFsWXnQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBYvd-00EgvB-Nx;
        Wed, 13 Jul 2022 11:45:09 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH 17/76] wifi: cfg80211: drop BSS elements from assoc trace for now
Date:   Wed, 13 Jul 2022 11:44:03 +0200
Message-Id: <20220713114425.88ebb146cb9d.Ie54f10bb04d9ab3c5861e9702d9c5fee788dce1f@changeid>
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

For multi-link operation, this cannot work as the req->bss pointer
will be NULL, and we'll need to do more work on this to really add
tracing for the MLO case here. Drop the BSS elements for now as
they're not the most useful thing, and it's hard to size things
correctly for the MLO case (without adding a lot of code that's
also executed when tracing isn't enabled.)

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/rdev-ops.h | 11 +----------
 net/wireless/trace.h    | 13 ++-----------
 2 files changed, 3 insertions(+), 21 deletions(-)

diff --git a/net/wireless/rdev-ops.h b/net/wireless/rdev-ops.h
index 6221a996c19f..53f5a0126dfd 100644
--- a/net/wireless/rdev-ops.h
+++ b/net/wireless/rdev-ops.h
@@ -469,18 +469,9 @@ static inline int rdev_assoc(struct cfg80211_registered_device *rdev,
 			     struct net_device *dev,
 			     struct cfg80211_assoc_request *req)
 {
-	const struct cfg80211_bss_ies *bss_ies;
 	int ret;
 
-	/*
-	 * Note: we might trace not exactly the data that's processed,
-	 * due to races and the driver/mac80211 getting a newer copy.
-	 */
-	rcu_read_lock();
-	bss_ies = rcu_dereference(req->bss->ies);
-	trace_rdev_assoc(&rdev->wiphy, dev, req, bss_ies);
-	rcu_read_unlock();
-
+	trace_rdev_assoc(&rdev->wiphy, dev, req);
 	ret = rdev->ops->assoc(&rdev->wiphy, dev, req);
 	trace_rdev_return_int(&rdev->wiphy, ret);
 	return ret;
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index e78bffbc6f95..c50e8a04199e 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -1232,9 +1232,8 @@ TRACE_EVENT(rdev_auth,
 
 TRACE_EVENT(rdev_assoc,
 	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev,
-		 struct cfg80211_assoc_request *req,
-		 const struct cfg80211_bss_ies *bss_ies),
-	TP_ARGS(wiphy, netdev, req, bss_ies),
+		 struct cfg80211_assoc_request *req),
+	TP_ARGS(wiphy, netdev, req),
 	TP_STRUCT__entry(
 		WIPHY_ENTRY
 		NETDEV_ENTRY
@@ -1242,9 +1241,6 @@ TRACE_EVENT(rdev_assoc,
 		MAC_ENTRY(prev_bssid)
 		__field(bool, use_mfp)
 		__field(u32, flags)
-		__dynamic_array(u8, bss_elements, bss_ies->len)
-		__field(bool, bss_elements_bcon)
-		__field(u64, bss_elements_tsf)
 		__dynamic_array(u8, elements, req->ie_len)
 		__array(u8, ht_capa, sizeof(struct ieee80211_ht_cap))
 		__array(u8, ht_capa_mask, sizeof(struct ieee80211_ht_cap))
@@ -1264,11 +1260,6 @@ TRACE_EVENT(rdev_assoc,
 		MAC_ASSIGN(prev_bssid, req->prev_bssid);
 		__entry->use_mfp = req->use_mfp;
 		__entry->flags = req->flags;
-		if (bss_ies->len)
-			memcpy(__get_dynamic_array(bss_elements),
-			       bss_ies->data, bss_ies->len);
-		__entry->bss_elements_bcon = bss_ies->from_beacon;
-		__entry->bss_elements_tsf = bss_ies->tsf;
 		if (req->ie)
 			memcpy(__get_dynamic_array(elements),
 			       req->ie, req->ie_len);
-- 
2.36.1

