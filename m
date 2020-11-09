Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73C6F2AB42C
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Nov 2020 10:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbgKIJ6E (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Nov 2020 04:58:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729265AbgKIJ55 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Nov 2020 04:57:57 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81104C0613D3
        for <linux-wireless@vger.kernel.org>; Mon,  9 Nov 2020 01:57:56 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kc3vu-004EGg-EZ; Mon, 09 Nov 2020 10:57:54 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 6/8] rt2x00: remove WDS code
Date:   Mon,  9 Nov 2020 10:57:45 +0100
Message-Id: <20201109105103.c3248409e449.I74954b87e5bdd23c99a5314d2b265889292a6cb5@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201109095747.113720-1-johannes@sipsolutions.net>
References: <20201109095747.113720-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

The ability to reach this code was hidden behind
CONFIG_WIRELESS_WDS, which was just removed. Clean
up the driver accordingly.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/ralink/rt2x00/rt2x00config.c | 1 -
 drivers/net/wireless/ralink/rt2x00/rt2x00dev.c    | 6 +-----
 drivers/net/wireless/ralink/rt2x00/rt2x00mac.c    | 3 +--
 3 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00config.c b/drivers/net/wireless/ralink/rt2x00/rt2x00config.c
index 0ee1813e8453..6bafdd991171 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00config.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00config.c
@@ -32,7 +32,6 @@ void rt2x00lib_config_intf(struct rt2x00_dev *rt2x00dev,
 		break;
 	case NL80211_IFTYPE_AP:
 	case NL80211_IFTYPE_MESH_POINT:
-	case NL80211_IFTYPE_WDS:
 		conf.sync = TSF_SYNC_AP_NONE;
 		break;
 	case NL80211_IFTYPE_STATION:
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c b/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
index b04f76551ca4..61a4f1ad31e2 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
@@ -194,8 +194,7 @@ static void rt2x00lib_beaconupdate_iter(void *data, u8 *mac,
 
 	if (vif->type != NL80211_IFTYPE_AP &&
 	    vif->type != NL80211_IFTYPE_ADHOC &&
-	    vif->type != NL80211_IFTYPE_MESH_POINT &&
-	    vif->type != NL80211_IFTYPE_WDS)
+	    vif->type != NL80211_IFTYPE_MESH_POINT)
 		return;
 
 	/*
@@ -1436,9 +1435,6 @@ int rt2x00lib_probe_dev(struct rt2x00_dev *rt2x00dev)
 		    BIT(NL80211_IFTYPE_ADHOC) |
 #ifdef CONFIG_MAC80211_MESH
 		    BIT(NL80211_IFTYPE_MESH_POINT) |
-#endif
-#ifdef CONFIG_WIRELESS_WDS
-		    BIT(NL80211_IFTYPE_WDS) |
 #endif
 		    BIT(NL80211_IFTYPE_AP);
 
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00mac.c b/drivers/net/wireless/ralink/rt2x00/rt2x00mac.c
index 2f68a31072ae..dea5babd30fe 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00mac.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00mac.c
@@ -408,8 +408,7 @@ static void rt2x00mac_set_tim_iter(void *data, u8 *mac,
 
 	if (vif->type != NL80211_IFTYPE_AP &&
 	    vif->type != NL80211_IFTYPE_ADHOC &&
-	    vif->type != NL80211_IFTYPE_MESH_POINT &&
-	    vif->type != NL80211_IFTYPE_WDS)
+	    vif->type != NL80211_IFTYPE_MESH_POINT)
 		return;
 
 	set_bit(DELAYED_UPDATE_BEACON, &intf->delayed_flags);
-- 
2.26.2

