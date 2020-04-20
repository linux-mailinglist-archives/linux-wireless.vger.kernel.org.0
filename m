Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 209C91B08BC
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2020 14:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgDTMGQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Apr 2020 08:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725944AbgDTMGQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Apr 2020 08:06:16 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13ABDC061A0C
        for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2020 05:06:16 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jQVBl-00CgT7-4x; Mon, 20 Apr 2020 14:06:13 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     j@w1.fi, Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] nl80211: allow client-only BIGTK support
Date:   Mon, 20 Apr 2020 14:06:00 +0200
Message-Id: <20200420140559.6ba704053a5a.Ifeb869fb0b48e52fe0cb9c15572b93ac8a924f8d@changeid>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

The current NL80211_EXT_FEATURE_BEACON_PROTECTION feature flag
requires both AP and client support, add a new one called
NL80211_EXT_FEATURE_BEACON_PROTECTION_CLIENT that enables only
support in client (and P2P-client) modes.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/uapi/linux/nl80211.h |  3 +++
 net/wireless/nl80211.c       | 19 +++++++++++++++----
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 2b691161830f..9a7f845011f6 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -5674,6 +5674,8 @@ enum nl80211_feature_flags {
  *
  * @NL80211_EXT_FEATURE_BEACON_PROTECTION: The driver supports Beacon protection
  *	and can receive key configuration for BIGTK using key indexes 6 and 7.
+ * @NL80211_EXT_FEATURE_BEACON_PROTECTION_CLIENT: The driver supports Beacon
+ *	protection as a client only and cannot transmit protected beacons.
  *
  * @NL80211_EXT_FEATURE_CONTROL_PORT_NO_PREAUTH: The driver can disable the
  *	forwarding of preauth frames over the control port. They are then
@@ -5735,6 +5737,7 @@ enum nl80211_ext_feature_index {
 	NL80211_EXT_FEATURE_CONTROL_PORT_NO_PREAUTH,
 	NL80211_EXT_FEATURE_PROTECTED_TWT,
 	NL80211_EXT_FEATURE_DEL_IBSS_STA,
+	NL80211_EXT_FEATURE_BEACON_PROTECTION_CLIENT,
 
 	/* add new features before the definition below */
 	NUM_NL80211_EXT_FEATURES,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 692bcd35f809..86dab4a6bfc9 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -3904,14 +3904,25 @@ static int nl80211_get_key(struct sk_buff *skb, struct genl_info *info)
 	};
 	void *hdr;
 	struct sk_buff *msg;
+	bool bigtk_support = false;
+
+	if (wiphy_ext_feature_isset(&rdev->wiphy,
+				    NL80211_EXT_FEATURE_BEACON_PROTECTION))
+		bigtk_support = true;
+
+	if ((dev->ieee80211_ptr->iftype == NL80211_IFTYPE_STATION ||
+	     dev->ieee80211_ptr->iftype == NL80211_IFTYPE_P2P_CLIENT) &&
+	    wiphy_ext_feature_isset(&rdev->wiphy,
+				    NL80211_EXT_FEATURE_BEACON_PROTECTION_CLIENT))
+		bigtk_support = true;
 
 	if (info->attrs[NL80211_ATTR_KEY_IDX]) {
 		key_idx = nla_get_u8(info->attrs[NL80211_ATTR_KEY_IDX]);
-		if (key_idx > 5 &&
-		    !wiphy_ext_feature_isset(
-			    &rdev->wiphy,
-			    NL80211_EXT_FEATURE_BEACON_PROTECTION))
+
+		if (key_idx >= 6 && key_idx <= 7 && !bigtk_support) {
+			GENL_SET_ERR_MSG(info, "BIGTK not supported");
 			return -EINVAL;
+		}
 	}
 
 	if (info->attrs[NL80211_ATTR_MAC])
-- 
2.25.1

