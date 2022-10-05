Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 610C45F54D7
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Oct 2022 15:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbiJENBD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Oct 2022 09:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbiJENA4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Oct 2022 09:00:56 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FCC91E3F5
        for <linux-wireless@vger.kernel.org>; Wed,  5 Oct 2022 06:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=K/ZZI411Zmx2kcU4ueXQQP9K4Y3wj535HXLw3onEKMQ=;
        t=1664974854; x=1666184454; b=Jibg3jRRbbSywec9VlmO0wL/1FWvcw441bD4KA2ewiQmovl
        xFKGIowhbnJZbND/MaZvAlVTU28c0DPN3FZIigpO6vtWZGl946R8K7EnKGUla8DWlUcfsJ5EXxKQg
        /HKyyEW3FlFd5Hc69Oz28cUBo0Ci2t3OFizXhATRMpclTWy9EJTZLiwtqFTN33edqsGxOX17n6k0W
        t98u5wySxWp2QOmzpIHZAW/hplmCGmFtMFUH32CCHc2flzRA9L8W9Vz9PXHKVy0uqOyrSZe/Sl36K
        8vh5aa4f1B7nawtxONbK2oaeorlhq2bXNOyWC/axQBUw8GVKzn2L6Mr7YIeFpFpA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1og415-00G2RL-2R;
        Wed, 05 Oct 2022 15:00:51 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 05/28] wifi: cfg80211: support reporting failed links
Date:   Wed,  5 Oct 2022 15:00:25 +0200
Message-Id: <20221005145226.2224328320e7.I53966b9c7572fe1a08a7dc02ed29be9e1b0467fc@changeid>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221005130048.217341-1-johannes@sipsolutions.net>
References: <20221005130048.217341-1-johannes@sipsolutions.net>
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

For assoc and connect result APIs, support reporting
failed links; they should still come with the BSS
pointer in the case of assoc, so they're released
correctly. In the case of connect result, this is
optional.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/cfg80211.h |  7 +++++++
 net/wireless/mlme.c    |  4 ++++
 net/wireless/nl80211.c |  5 ++++-
 net/wireless/sme.c     | 14 ++++++++++++++
 4 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index e09ff87146c1..4d35a4234417 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -6933,6 +6933,8 @@ void cfg80211_auth_timeout(struct net_device *dev, const u8 *addr);
  * @ap_mld_addr: AP MLD address (in case of MLO)
  * @links: per-link information indexed by link ID, use links[0] for
  *	non-MLO connections
+ * @links.status: Set this (along with a BSS pointer) for links that
+ *	were rejected by the AP.
  */
 struct cfg80211_rx_assoc_resp {
 	const u8 *buf;
@@ -6944,6 +6946,7 @@ struct cfg80211_rx_assoc_resp {
 	struct {
 		const u8 *addr;
 		struct cfg80211_bss *bss;
+		u16 status;
 	} links[IEEE80211_MLD_MAX_NUM_LINKS];
 };
 
@@ -7454,6 +7457,9 @@ struct cfg80211_fils_resp_params {
  *	if the bss is expired during the connection, esp. for those drivers
  *	implementing connect op. Only one parameter among @bssid and @bss needs
  *	to be specified.
+ * @links.status: per-link status code, to report a status code that's not
+ *	%WLAN_STATUS_SUCCESS for a given link, it must also be in the
+ *	@valid_links bitmap and may have a BSS pointer (which is then released)
  */
 struct cfg80211_connect_resp_params {
 	int status;
@@ -7470,6 +7476,7 @@ struct cfg80211_connect_resp_params {
 		const u8 *addr;
 		const u8 *bssid;
 		struct cfg80211_bss *bss;
+		u16 status;
 	} links[IEEE80211_MLD_MAX_NUM_LINKS];
 };
 
diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
index 581df7f4c524..58e1fb18f85a 100644
--- a/net/wireless/mlme.c
+++ b/net/wireless/mlme.c
@@ -42,6 +42,10 @@ void cfg80211_rx_assoc_resp(struct net_device *dev,
 	unsigned int link_id;
 
 	for (link_id = 0; link_id < ARRAY_SIZE(data->links); link_id++) {
+		cr.links[link_id].status = data->links[link_id].status;
+		WARN_ON_ONCE(cr.links[link_id].status != WLAN_STATUS_SUCCESS &&
+			     (!cr.ap_mld_addr || !cr.links[link_id].bss));
+
 		cr.links[link_id].bss = data->links[link_id].bss;
 		if (!cr.links[link_id].bss)
 			continue;
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 8ff8b1c040f0..ad7393cd3d18 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -17745,6 +17745,7 @@ void nl80211_send_connect_result(struct cfg80211_registered_device *rdev,
 			link_info_size += (cr->links[link].bssid ||
 					   cr->links[link].bss) ?
 					  nla_total_size(ETH_ALEN) : 0;
+			link_info_size += nla_total_size(sizeof(u16));
 		}
 	}
 
@@ -17813,7 +17814,9 @@ void nl80211_send_connect_result(struct cfg80211_registered_device *rdev,
 			     nla_put(msg, NL80211_ATTR_BSSID, ETH_ALEN, bssid)) ||
 			    (cr->links[link].addr &&
 			     nla_put(msg, NL80211_ATTR_MAC, ETH_ALEN,
-				     cr->links[link].addr)))
+				     cr->links[link].addr)) ||
+			    nla_put_u16(msg, NL80211_ATTR_STATUS_CODE,
+					cr->links[link].status))
 				goto nla_put_failure;
 
 			nla_nest_end(msg, nested_mlo_links);
diff --git a/net/wireless/sme.c b/net/wireless/sme.c
index d513536617bd..f94497e9db43 100644
--- a/net/wireless/sme.c
+++ b/net/wireless/sme.c
@@ -793,6 +793,10 @@ void __cfg80211_connect_result(struct net_device *dev,
 		}
 
 		for_each_valid_link(cr, link) {
+			/* don't do extra lookups for failures */
+			if (cr->links[link].status != WLAN_STATUS_SUCCESS)
+				continue;
+
 			if (cr->links[link].bss)
 				continue;
 
@@ -829,6 +833,16 @@ void __cfg80211_connect_result(struct net_device *dev,
 	}
 
 	memset(wdev->links, 0, sizeof(wdev->links));
+	for_each_valid_link(cr, link) {
+		if (cr->links[link].status == WLAN_STATUS_SUCCESS)
+			continue;
+		cr->valid_links &= ~BIT(link);
+		/* don't require bss pointer for failed links */
+		if (!cr->links[link].bss)
+			continue;
+		cfg80211_unhold_bss(bss_from_pub(cr->links[link].bss));
+		cfg80211_put_bss(wdev->wiphy, cr->links[link].bss);
+	}
 	wdev->valid_links = cr->valid_links;
 	for_each_valid_link(cr, link)
 		wdev->links[link].client.current_bss =
-- 
2.37.3

