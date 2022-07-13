Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86154573350
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 11:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235205AbiGMJqF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 05:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235411AbiGMJpX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 05:45:23 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80CBF682E
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 02:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=RIT7ut7pNLfxhLAA9dqUZpEel7gC/Q+hWACultW4p1w=;
        t=1657705520; x=1658915120; b=c5i7HLKb3lVg7eq6KLTCqp1T6qlD3U7gVNAMxyUyOYZ2D4R
        Ye8r7X/pDJNktw9TqGUGicNGd45jL4bbIBd1D+JA9NO6B4ya7Fz8Fr2TCnGQqHnW2b+WHMZmc0eVy
        iLU5kzKjzpm86i5IM/wrfyAmQsfR/RehD9/DfKz+aKrDLfZlqQReaGD1D6Hp1bKgWycNucXFlo5QU
        3tVPHBMyFJdi9IB8pEHZUByB/BMQAqb9BH/z440PIP5yqw2kTQ+kivcfGPUpnq7axYzOQbLvkuenC
        PXCBtjGB9CAI198+e+fodOs/AkrOcobHHR4RtS5ORqiRgLnRrlZIzQRG27cCuQBw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBYvl-00EgvB-OU;
        Wed, 13 Jul 2022 11:45:17 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 43/76] wifi: cfg80211: extend cfg80211_rx_assoc_resp() for MLO
Date:   Wed, 13 Jul 2022 11:44:29 +0200
Message-Id: <20220713114425.3be1ea9a6923.I65fe8c243555026276258acae283f6b466646890@changeid>
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

Extend the cfg80211_rx_assoc_resp() to cover multiple
BSSes, the AP MLD address and local link addresses
for MLO.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/cfg80211.h |  9 +++++-
 net/mac80211/mlme.c    |  2 +-
 net/wireless/mlme.c    | 64 +++++++++++++++++++++++++++---------------
 net/wireless/trace.h   | 16 +++++------
 4 files changed, 59 insertions(+), 32 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 1a0bdff1569c..09f2e2f031b6 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -6886,14 +6886,21 @@ void cfg80211_auth_timeout(struct net_device *dev, const u8 *addr);
  *	as the AC bitmap in the QoS info field
  * @req_ies: information elements from the (Re)Association Request frame
  * @req_ies_len: length of req_ies data
+ * @ap_mld_addr: AP MLD address (in case of MLO)
+ * @links: per-link information indexed by link ID, use links[0] for
+ *	non-MLO connections
  */
 struct cfg80211_rx_assoc_resp {
-	struct cfg80211_bss *bss;
 	const u8 *buf;
 	size_t len;
 	const u8 *req_ies;
 	size_t req_ies_len;
 	int uapsd_queues;
+	const u8 *ap_mld_addr;
+	struct {
+		const u8 *addr;
+		struct cfg80211_bss *bss;
+	} links[IEEE80211_MLD_MAX_NUM_LINKS];
 };
 
 /**
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index a47836730493..1819a8161e12 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -3994,7 +3994,7 @@ static void ieee80211_rx_mgmt_assoc_resp(struct ieee80211_sub_if_data *sdata,
 		info.success = 1;
 	}
 
-	resp.bss = cbss;
+	resp.links[0].bss = cbss;
 	resp.buf = (u8 *)mgmt;
 	resp.len = len;
 	resp.req_ies = ifmgd->assoc_req_ies;
diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
index a6ad696f131b..80f11a29cb86 100644
--- a/net/wireless/mlme.c
+++ b/net/wireless/mlme.c
@@ -28,28 +28,41 @@ void cfg80211_rx_assoc_resp(struct net_device *dev,
 	struct wiphy *wiphy = wdev->wiphy;
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
 	struct ieee80211_mgmt *mgmt = (struct ieee80211_mgmt *)data->buf;
-	struct cfg80211_connect_resp_params cr;
-	const u8 *resp_ie = mgmt->u.assoc_resp.variable;
-	size_t resp_ie_len = data->len - offsetof(struct ieee80211_mgmt,
-						  u.assoc_resp.variable);
-
-	if (data->bss->channel->band == NL80211_BAND_S1GHZ) {
-		resp_ie = (u8 *)&mgmt->u.s1g_assoc_resp.variable;
-		resp_ie_len = data->len - offsetof(struct ieee80211_mgmt,
-						   u.s1g_assoc_resp.variable);
-	}
+	struct cfg80211_connect_resp_params cr = {
+		.timeout_reason = NL80211_TIMEOUT_UNSPECIFIED,
+		.req_ie = data->req_ies,
+		.req_ie_len = data->req_ies_len,
+		.resp_ie = mgmt->u.assoc_resp.variable,
+		.resp_ie_len = data->len -
+			       offsetof(struct ieee80211_mgmt,
+					u.assoc_resp.variable),
+		.status = le16_to_cpu(mgmt->u.assoc_resp.status_code),
+		.ap_mld_addr = data->ap_mld_addr,
+	};
+	unsigned int link_id;
+
+	for (link_id = 0; link_id < ARRAY_SIZE(data->links); link_id++) {
+		cr.links[link_id].bss = data->links[link_id].bss;
+		if (!cr.links[link_id].bss)
+			continue;
+		cr.links[link_id].bssid = data->links[link_id].bss->bssid;
+		cr.links[link_id].addr = data->links[link_id].addr;
+		/* need to have local link addresses for MLO connections */
+		WARN_ON(cr.ap_mld_addr && !cr.links[link_id].addr);
+
+		if (cr.links[link_id].bss->channel->band == NL80211_BAND_S1GHZ) {
+			WARN_ON(link_id);
+			cr.resp_ie = (u8 *)&mgmt->u.s1g_assoc_resp.variable;
+			cr.resp_ie_len = data->len -
+					 offsetof(struct ieee80211_mgmt,
+						  u.s1g_assoc_resp.variable);
+		}
 
-	memset(&cr, 0, sizeof(cr));
-	cr.status = (int)le16_to_cpu(mgmt->u.assoc_resp.status_code);
-	cr.links[0].bssid = mgmt->bssid;
-	cr.links[0].bss = data->bss;
-	cr.req_ie = data->req_ies;
-	cr.req_ie_len = data->req_ies_len;
-	cr.resp_ie = resp_ie;
-	cr.resp_ie_len = resp_ie_len;
-	cr.timeout_reason = NL80211_TIMEOUT_UNSPECIFIED;
+		if (cr.ap_mld_addr)
+			cr.valid_links |= BIT(link_id);
+	}
 
-	trace_cfg80211_send_rx_assoc(dev, data->bss);
+	trace_cfg80211_send_rx_assoc(dev, data);
 
 	/*
 	 * This is a bit of a hack, we don't notify userspace of
@@ -58,8 +71,15 @@ void cfg80211_rx_assoc_resp(struct net_device *dev,
 	 * frame instead of reassoc.
 	 */
 	if (cfg80211_sme_rx_assoc_resp(wdev, cr.status)) {
-		cfg80211_unhold_bss(bss_from_pub(data->bss));
-		cfg80211_put_bss(wiphy, data->bss);
+		for (link_id = 0; link_id < ARRAY_SIZE(data->links); link_id++) {
+			struct cfg80211_bss *bss = data->links[link_id].bss;
+
+			if (!bss)
+				continue;
+
+			cfg80211_unhold_bss(bss_from_pub(bss));
+			cfg80211_put_bss(wiphy, bss);
+		}
 		return;
 	}
 
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 94d107cab72c..dac66ad5937d 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -2887,20 +2887,20 @@ DEFINE_EVENT(netdev_evt_only, cfg80211_send_rx_auth,
 );
 
 TRACE_EVENT(cfg80211_send_rx_assoc,
-	TP_PROTO(struct net_device *netdev, struct cfg80211_bss *bss),
-	TP_ARGS(netdev, bss),
+	TP_PROTO(struct net_device *netdev,
+		 struct cfg80211_rx_assoc_resp *data),
+	TP_ARGS(netdev, data),
 	TP_STRUCT__entry(
 		NETDEV_ENTRY
-		MAC_ENTRY(bssid)
-		CHAN_ENTRY
+		MAC_ENTRY(ap_addr)
 	),
 	TP_fast_assign(
 		NETDEV_ASSIGN;
-		MAC_ASSIGN(bssid, bss->bssid);
-		CHAN_ASSIGN(bss->channel);
+		MAC_ASSIGN(ap_addr,
+			   data->ap_mld_addr ?: data->links[0].bss->bssid);
 	),
-	TP_printk(NETDEV_PR_FMT ", " MAC_PR_FMT ", " CHAN_PR_FMT,
-		  NETDEV_PR_ARG, MAC_PR_ARG(bssid), CHAN_PR_ARG)
+	TP_printk(NETDEV_PR_FMT ", " MAC_PR_FMT,
+		  NETDEV_PR_ARG, MAC_PR_ARG(ap_addr))
 );
 
 DECLARE_EVENT_CLASS(netdev_frame_event,
-- 
2.36.1

