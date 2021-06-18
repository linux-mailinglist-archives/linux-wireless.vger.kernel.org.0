Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04A263AC947
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jun 2021 12:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233346AbhFRLAW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Jun 2021 07:00:22 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:48252 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229550AbhFRLAV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Jun 2021 07:00:21 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1luBx5-001YXx-MA; Fri, 18 Jun 2021 13:42:21 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri, 18 Jun 2021 13:41:48 +0300
Message-Id: <iwlwifi.20210618133832.86c58fca486d.Iabd8f036d2ef1d770fd20ed3ccd149f32154f430@changeid>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618104156.747775-1-luca@coelho.fi>
References: <20210618104156.747775-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 23/31] cfg80211: trace more information in assoc trace event
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Add more information to the assoc trace event so we can see
more precisely what's going on and what options were used.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 net/wireless/rdev-ops.h | 12 +++++++++++-
 net/wireless/trace.h    | 36 ++++++++++++++++++++++++++++++++++--
 2 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/net/wireless/rdev-ops.h b/net/wireless/rdev-ops.h
index 8b1358d04ca2..b1d37f582dc6 100644
--- a/net/wireless/rdev-ops.h
+++ b/net/wireless/rdev-ops.h
@@ -464,8 +464,18 @@ static inline int rdev_assoc(struct cfg80211_registered_device *rdev,
 			     struct net_device *dev,
 			     struct cfg80211_assoc_request *req)
 {
+	const struct cfg80211_bss_ies *bss_ies;
 	int ret;
-	trace_rdev_assoc(&rdev->wiphy, dev, req);
+
+	/*
+	 * Note: we might trace not exactly the data that's processed,
+	 * due to races and the driver/mac80211 getting a newer copy.
+	 */
+	rcu_read_lock();
+	bss_ies = rcu_dereference(req->bss->ies);
+	trace_rdev_assoc(&rdev->wiphy, dev, req, bss_ies);
+	rcu_read_unlock();
+
 	ret = rdev->ops->assoc(&rdev->wiphy, dev, req);
 	trace_rdev_return_int(&rdev->wiphy, ret);
 	return ret;
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 76b777d5903f..440bce5f0274 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -1195,8 +1195,9 @@ TRACE_EVENT(rdev_auth,
 
 TRACE_EVENT(rdev_assoc,
 	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev,
-		 struct cfg80211_assoc_request *req),
-	TP_ARGS(wiphy, netdev, req),
+		 struct cfg80211_assoc_request *req,
+		 const struct cfg80211_bss_ies *bss_ies),
+	TP_ARGS(wiphy, netdev, req, bss_ies),
 	TP_STRUCT__entry(
 		WIPHY_ENTRY
 		NETDEV_ENTRY
@@ -1204,6 +1205,17 @@ TRACE_EVENT(rdev_assoc,
 		MAC_ENTRY(prev_bssid)
 		__field(bool, use_mfp)
 		__field(u32, flags)
+		__dynamic_array(u8, bss_elements, bss_ies->len)
+		__field(bool, bss_elements_bcon)
+		__field(u64, bss_elements_tsf)
+		__dynamic_array(u8, elements, req->ie_len)
+		__array(u8, ht_capa, sizeof(struct ieee80211_ht_cap))
+		__array(u8, ht_capa_mask, sizeof(struct ieee80211_ht_cap))
+		__array(u8, vht_capa, sizeof(struct ieee80211_vht_cap))
+		__array(u8, vht_capa_mask, sizeof(struct ieee80211_vht_cap))
+		__dynamic_array(u8, fils_kek, req->fils_kek_len)
+		__dynamic_array(u8, fils_nonces,
+				req->fils_nonces ? 2 * FILS_NONCE_LEN : 0)
 	),
 	TP_fast_assign(
 		WIPHY_ASSIGN;
@@ -1215,6 +1227,26 @@ TRACE_EVENT(rdev_assoc,
 		MAC_ASSIGN(prev_bssid, req->prev_bssid);
 		__entry->use_mfp = req->use_mfp;
 		__entry->flags = req->flags;
+		if (bss_ies->len)
+			memcpy(__get_dynamic_array(bss_elements),
+			       bss_ies->data, bss_ies->len);
+		__entry->bss_elements_bcon = bss_ies->from_beacon;
+		__entry->bss_elements_tsf = bss_ies->tsf;
+		if (req->ie)
+			memcpy(__get_dynamic_array(elements),
+			       req->ie, req->ie_len);
+		memcpy(__entry->ht_capa, &req->ht_capa, sizeof(req->ht_capa));
+		memcpy(__entry->ht_capa_mask, &req->ht_capa_mask,
+		       sizeof(req->ht_capa_mask));
+		memcpy(__entry->vht_capa, &req->vht_capa, sizeof(req->vht_capa));
+		memcpy(__entry->vht_capa_mask, &req->vht_capa_mask,
+		       sizeof(req->vht_capa_mask));
+		if (req->fils_kek)
+			memcpy(__get_dynamic_array(fils_kek),
+			       req->fils_kek, req->fils_kek_len);
+		if (req->fils_nonces)
+			memcpy(__get_dynamic_array(fils_nonces),
+			       req->fils_nonces, 2 * FILS_NONCE_LEN);
 	),
 	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", bssid: " MAC_PR_FMT
 		  ", previous bssid: " MAC_PR_FMT ", use mfp: %s, flags: %u",
-- 
2.32.0

