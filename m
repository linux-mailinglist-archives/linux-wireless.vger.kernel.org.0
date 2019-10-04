Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC3B1CBA9A
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2019 14:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387597AbfJDMhY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Oct 2019 08:37:24 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:46534 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387575AbfJDMhW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Oct 2019 08:37:22 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1iGMpl-0000k1-5q; Fri, 04 Oct 2019 15:37:21 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Date:   Fri,  4 Oct 2019 15:37:06 +0300
Message-Id: <20191004123706.15768-3-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191004123706.15768-1-luca@coelho.fi>
References: <20191004123706.15768-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 2/2] cfg80211: fix a bunch of RCU issues in multi-bssid code
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sara Sharon <sara.sharon@intel.com>

cfg80211_update_notlisted_nontrans() leaves the RCU critical session
too early, while still using nontrans_ssid which is RCU protected. In
addition, it performs a bunch of RCU pointer update operations such
as rcu_access_pointer and rcu_assign_pointer.

The caller, cfg80211_inform_bss_frame_data(), also accesses the RCU
pointer without holding the lock.

Just wrap all of this with bss_lock.

Signed-off-by: Sara Sharon <sara.sharon@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 net/wireless/scan.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index d313c9befa23..4c63255722e6 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -1703,8 +1703,7 @@ cfg80211_parse_mbssid_frame_data(struct wiphy *wiphy,
 static void
 cfg80211_update_notlisted_nontrans(struct wiphy *wiphy,
 				   struct cfg80211_bss *nontrans_bss,
-				   struct ieee80211_mgmt *mgmt, size_t len,
-				   gfp_t gfp)
+				   struct ieee80211_mgmt *mgmt, size_t len)
 {
 	u8 *ie, *new_ie, *pos;
 	const u8 *nontrans_ssid, *trans_ssid, *mbssid;
@@ -1715,6 +1714,8 @@ cfg80211_update_notlisted_nontrans(struct wiphy *wiphy,
 	const struct cfg80211_bss_ies *old;
 	u8 cpy_len;
 
+	lockdep_assert_held(&wiphy_to_rdev(wiphy)->bss_lock);
+
 	ie = mgmt->u.probe_resp.variable;
 
 	new_ie_len = ielen;
@@ -1726,23 +1727,22 @@ cfg80211_update_notlisted_nontrans(struct wiphy *wiphy,
 	if (!mbssid)
 		return;
 	new_ie_len -= mbssid[1];
-	rcu_read_lock();
+
 	nontrans_ssid = ieee80211_bss_get_ie(nontrans_bss, WLAN_EID_SSID);
-	if (!nontrans_ssid) {
-		rcu_read_unlock();
+	if (!nontrans_ssid)
 		return;
-	}
+
 	new_ie_len += nontrans_ssid[1];
-	rcu_read_unlock();
 
 	/* generate new ie for nontrans BSS
 	 * 1. replace SSID with nontrans BSS' SSID
 	 * 2. skip MBSSID IE
 	 */
-	new_ie = kzalloc(new_ie_len, gfp);
+	new_ie = kzalloc(new_ie_len, GFP_ATOMIC);
 	if (!new_ie)
 		return;
-	new_ies = kzalloc(sizeof(*new_ies) + new_ie_len, gfp);
+
+	new_ies = kzalloc(sizeof(*new_ies) + new_ie_len, GFP_ATOMIC);
 	if (!new_ies)
 		goto out_free;
 
@@ -1896,6 +1896,8 @@ cfg80211_inform_bss_frame_data(struct wiphy *wiphy,
 	cfg80211_parse_mbssid_frame_data(wiphy, data, mgmt, len,
 					 &non_tx_data, gfp);
 
+	spin_lock_bh(&wiphy_to_rdev(wiphy)->bss_lock);
+
 	/* check if the res has other nontransmitting bss which is not
 	 * in MBSSID IE
 	 */
@@ -1910,8 +1912,9 @@ cfg80211_inform_bss_frame_data(struct wiphy *wiphy,
 		ies2 = rcu_access_pointer(tmp_bss->ies);
 		if (ies2->tsf < ies1->tsf)
 			cfg80211_update_notlisted_nontrans(wiphy, tmp_bss,
-							   mgmt, len, gfp);
+							   mgmt, len);
 	}
+	spin_unlock_bh(&wiphy_to_rdev(wiphy)->bss_lock);
 
 	return res;
 }
-- 
2.23.0

