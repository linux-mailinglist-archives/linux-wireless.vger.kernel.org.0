Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F0A733ABF
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jun 2023 22:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbjFPUVk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Jun 2023 16:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjFPUVj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Jun 2023 16:21:39 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E983A8B
        for <linux-wireless@vger.kernel.org>; Fri, 16 Jun 2023 13:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=JI+735el2DVcVic9jVqG9f9lVpJNE6Zx9OWJlst5Nqs=;
        t=1686946896; x=1688156496; b=PQbzREC0KXZh5f0UssucoATqMpSkC2WHc6OWFxV9O9ZRTUB
        HBiJOAQu+Qp0C+UA4at5uTqtONzpskjtmmCxmCK7fcwhVKtGWBOIbZ1qRTLUA8s+l4IdC6XnzQo1h
        mHnP40WiyuCuDvNN7lrsHZpcJSfW2B6WKcdF9SqR3xDZQNvXliHIrGydxcEUz8FF9z9xGDm33/LGh
        XZn3xfy+pAUCckzfvttLI9i3j8IQ+GjvBd46Y8jpoBekva/xHyK+1MZ+FNfgC52wd7X8acmQPV+Dy
        czXgrd33064QqYUDkLsaMRMAPp0ZML/wsOt1M+VXKtgWOL9TPvwGECI1gb9zwgnw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qAFwo-008bm6-3D;
        Fri, 16 Jun 2023 22:21:31 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 2/2] wifi: cfg80211: fix regulatory disconnect with OCB/NAN
Date:   Fri, 16 Jun 2023 22:21:27 +0200
Message-Id: <20230616222122.e8cc85591283.I8e78a3789a29e6149447b3139df724a6f1b46fc3@changeid>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230616222122.eb073d650c75.I72739923ef80919889ea9b50de9e4ba4baa836ae@changeid>
References: <20230616222122.eb073d650c75.I72739923ef80919889ea9b50de9e4ba4baa836ae@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Since regulatory disconnect was added, OCB and NAN interface
types were added, which made it completely unusable for any
driver that allowed OCB/NAN. Add OCB/NAN (though NAN doesn't
do anything, we don't have any info) and also remove all the
logic that opts out, so it won't be broken again if/when new
interface types are added.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/regulatory.h | 13 +------------
 net/wireless/core.c      | 16 ----------------
 net/wireless/reg.c       | 14 ++++++++++----
 3 files changed, 11 insertions(+), 32 deletions(-)

diff --git a/include/net/regulatory.h b/include/net/regulatory.h
index 896191f420d5..b2cb4a9eb04d 100644
--- a/include/net/regulatory.h
+++ b/include/net/regulatory.h
@@ -140,17 +140,6 @@ struct regulatory_request {
  *      otherwise initiating radiation is not allowed. This will enable the
  *      relaxations enabled under the CFG80211_REG_RELAX_NO_IR configuration
  *      option
- * @REGULATORY_IGNORE_STALE_KICKOFF: the regulatory core will _not_ make sure
- *	all interfaces on this wiphy reside on allowed channels. If this flag
- *	is not set, upon a regdomain change, the interfaces are given a grace
- *	period (currently 60 seconds) to disconnect or move to an allowed
- *	channel. Interfaces on forbidden channels are forcibly disconnected.
- *	Currently these types of interfaces are supported for enforcement:
- *	NL80211_IFTYPE_ADHOC, NL80211_IFTYPE_STATION, NL80211_IFTYPE_AP,
- *	NL80211_IFTYPE_AP_VLAN, NL80211_IFTYPE_MONITOR,
- *	NL80211_IFTYPE_P2P_CLIENT, NL80211_IFTYPE_P2P_GO,
- *	NL80211_IFTYPE_P2P_DEVICE. The flag will be set by default if a device
- *	includes any modes unsupported for enforcement checking.
  * @REGULATORY_WIPHY_SELF_MANAGED: for devices that employ wiphy-specific
  *	regdom management. These devices will ignore all regdom changes not
  *	originating from their own wiphy.
@@ -177,7 +166,7 @@ enum ieee80211_regulatory_flags {
 	REGULATORY_COUNTRY_IE_FOLLOW_POWER	= BIT(3),
 	REGULATORY_COUNTRY_IE_IGNORE		= BIT(4),
 	REGULATORY_ENABLE_RELAX_NO_IR           = BIT(5),
-	REGULATORY_IGNORE_STALE_KICKOFF         = BIT(6),
+	/* reuse bit 6 next time */
 	REGULATORY_WIPHY_SELF_MANAGED		= BIT(7),
 };
 
diff --git a/net/wireless/core.c b/net/wireless/core.c
index b3ec9eaec36b..609b79fe4a74 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -721,22 +721,6 @@ int wiphy_register(struct wiphy *wiphy)
 			return -EINVAL;
 	}
 
-	/*
-	 * if a wiphy has unsupported modes for regulatory channel enforcement,
-	 * opt-out of enforcement checking
-	 */
-	if (wiphy->interface_modes & ~(BIT(NL80211_IFTYPE_STATION) |
-				       BIT(NL80211_IFTYPE_P2P_CLIENT) |
-				       BIT(NL80211_IFTYPE_AP) |
-				       BIT(NL80211_IFTYPE_MESH_POINT) |
-				       BIT(NL80211_IFTYPE_P2P_GO) |
-				       BIT(NL80211_IFTYPE_ADHOC) |
-				       BIT(NL80211_IFTYPE_P2P_DEVICE) |
-				       BIT(NL80211_IFTYPE_NAN) |
-				       BIT(NL80211_IFTYPE_AP_VLAN) |
-				       BIT(NL80211_IFTYPE_MONITOR)))
-		wiphy->regulatory_flags |= REGULATORY_IGNORE_STALE_KICKOFF;
-
 	if (WARN_ON((wiphy->regulatory_flags & REGULATORY_WIPHY_SELF_MANAGED) &&
 		    (wiphy->regulatory_flags &
 					(REGULATORY_CUSTOM_REG |
diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index f5ea1f373ab7..f9e03850d71b 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -2391,9 +2391,17 @@ static bool reg_wdev_chan_valid(struct wiphy *wiphy, struct wireless_dev *wdev)
 		case NL80211_IFTYPE_P2P_DEVICE:
 			/* no enforcement required */
 			break;
+		case NL80211_IFTYPE_OCB:
+			if (!wdev->u.ocb.chandef.chan)
+				continue;
+			chandef = wdev->u.ocb.chandef;
+			break;
+		case NL80211_IFTYPE_NAN:
+			/* we have no info, but NAN is also pretty universal */
+			continue;
 		default:
 			/* others not implemented for now */
-			WARN_ON(1);
+			WARN_ON_ONCE(1);
 			break;
 		}
 
@@ -2452,9 +2460,7 @@ static void reg_check_chans_work(struct work_struct *work)
 	rtnl_lock();
 
 	list_for_each_entry(rdev, &cfg80211_rdev_list, list)
-		if (!(rdev->wiphy.regulatory_flags &
-		      REGULATORY_IGNORE_STALE_KICKOFF))
-			reg_leave_invalid_chans(&rdev->wiphy);
+		reg_leave_invalid_chans(&rdev->wiphy);
 
 	rtnl_unlock();
 }
-- 
2.40.1

