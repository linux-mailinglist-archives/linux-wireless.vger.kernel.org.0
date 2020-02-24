Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B67CD16A1CA
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Feb 2020 10:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbgBXJTY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Feb 2020 04:19:24 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:57562 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbgBXJTY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Feb 2020 04:19:24 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1j69ta-006AMd-50; Mon, 24 Feb 2020 10:19:22 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Markus Theil <markus.theil@tu-ilmenau.de>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 1/2] Revert "mac80211: support NL80211_EXT_FEATURE_CONTROL_PORT_OVER_NL80211_MAC_ADDRS"
Date:   Mon, 24 Feb 2020 10:19:11 +0100
Message-Id: <20200224101910.b87da63a3cd6.Ic94bc51a370c4aa7d19fbca9b96d90ab703257dc@changeid>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

This reverts commit 9b125c27998719288e4dcf2faf54511039526692.

As Jouni points out, there's really no need for this, since the
RSN pre-authentication frames are normal data frames, not port
control frames (locally).

Fixes: 9b125c279987 ("mac80211: support NL80211_EXT_FEATURE_CONTROL_PORT_OVER_NL80211_MAC_ADDRS")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/main.c | 2 --
 net/mac80211/tx.c   | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index cae3a34d3503..944e86da5c65 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -589,8 +589,6 @@ struct ieee80211_hw *ieee80211_alloc_hw_nm(size_t priv_data_len,
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_FILS_STA);
 	wiphy_ext_feature_set(wiphy,
 			      NL80211_EXT_FEATURE_CONTROL_PORT_OVER_NL80211);
-	wiphy_ext_feature_set(wiphy,
-			      NL80211_EXT_FEATURE_CONTROL_PORT_OVER_NL80211_MAC_ADDRS);
 
 	if (!ops->hw_scan) {
 		wiphy->features |= NL80211_FEATURE_LOW_PRIORITY_SCAN |
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 8dd93072f6e6..2645a39cce88 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -5315,7 +5315,7 @@ int ieee80211_tx_control_port(struct wiphy *wiphy, struct net_device *dev,
 
 	ehdr = skb_push(skb, sizeof(struct ethhdr));
 	memcpy(ehdr->h_dest, dest, ETH_ALEN);
-	memcpy(ehdr->h_source, src, ETH_ALEN);
+	memcpy(ehdr->h_source, sdata->vif.addr, ETH_ALEN);
 	ehdr->h_proto = proto;
 
 	skb->dev = dev;
-- 
2.24.1

