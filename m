Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C04D24E864
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Aug 2020 17:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727893AbgHVPjK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 22 Aug 2020 11:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbgHVPjJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 22 Aug 2020 11:39:09 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86549C061573
        for <linux-wireless@vger.kernel.org>; Sat, 22 Aug 2020 08:39:09 -0700 (PDT)
Received: from [95.81.14.74] (helo=localhost.localdomain)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1k9Vbn-0008VD-6R; Sat, 22 Aug 2020 17:39:07 +0200
From:   John Crispin <john@phrozen.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        John Crispin <john@phrozen.org>
Subject: [PATCH] mac80211: notify non-transmitting BSS of color changes
Date:   Sat, 22 Aug 2020 17:39:02 +0200
Message-Id: <20200822153902.4091442-1-john@phrozen.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When a transmitting multiple bssid BSS changes its bss color, we need to
also notify the non transmitting BSSs of the new bss color.

This patch depends on the multiple bssid and bss coloring series.

Signed-off-by: John Crispin <john@phrozen.org>
---
 net/mac80211/cfg.c | 42 ++++++++++++++++++++++++++++++------------
 1 file changed, 30 insertions(+), 12 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 60bcf936d9c6..82b0ea4fcf0a 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -4182,6 +4182,32 @@ static int ieee80211_set_color_change_beacon(struct ieee80211_sub_if_data *sdata
 	return 0;
 }
 
+static void ieee80211_color_change_bss_config_notify(struct ieee80211_sub_if_data *sdata,
+						     u8 color, int enable, u32 changed)
+{
+	sdata->vif.bss_conf.he_bss_color.color = color;
+	sdata->vif.bss_conf.he_bss_color.enabled = enable;
+	changed |= BSS_CHANGED_HE_BSS_COLOR;
+
+	ieee80211_bss_info_change_notify(sdata, changed);
+
+	if (ieee80211_hw_check(&sdata->local->hw, SUPPORTS_MULTI_BSSID_AP) &&
+	    !sdata->vif.multiple_bssid.non_transmitted) {
+		struct ieee80211_vif *child;
+
+		list_for_each_entry(child, &sdata->vif.multiple_bssid.list,
+				    multiple_bssid.list) {
+			struct ieee80211_sub_if_data *child_sdata = vif_to_sdata(child);
+
+			sdata_lock(child_sdata);
+			child->bss_conf.he_bss_color.color = color;
+			child->bss_conf.he_bss_color.enabled = enable;
+			ieee80211_bss_info_change_notify(child_sdata, BSS_CHANGED_HE_BSS_COLOR);
+			sdata_unlock(child_sdata);
+		}
+	}
+}
+
 static int ieee80211_color_change_finalize(struct ieee80211_sub_if_data *sdata)
 {
 	struct ieee80211_local *local = sdata->local;
@@ -4199,12 +4225,7 @@ static int ieee80211_color_change_finalize(struct ieee80211_sub_if_data *sdata)
 		return err;
 	}
 
-	sdata->vif.bss_conf.he_bss_color.color = sdata->vif.color_change_color;
-	sdata->vif.bss_conf.he_bss_color.enabled = 1;
-	changed |= BSS_CHANGED_HE_BSS_COLOR;
-
-	ieee80211_bss_info_change_notify(sdata, changed);
-
+	ieee80211_color_change_bss_config_notify(sdata, sdata->vif.color_change_color, 1, 0);
 	cfg80211_color_change_notify(sdata->dev);
 
 	return 0;
@@ -4283,14 +4304,11 @@ __ieee80211_color_change(struct wiphy *wiphy, struct net_device *dev,
 
 	cfg80211_color_change_started_notify(sdata->dev, params->count);
 
-	if (changed) {
-		sdata->vif.bss_conf.he_bss_color.enabled = 0;
-		changed |= BSS_CHANGED_HE_BSS_COLOR;
-		ieee80211_bss_info_change_notify(sdata, changed);
-	} else {
+	if (changed)
+		ieee80211_color_change_bss_config_notify(sdata, 0, 0, changed);
+	else
 		/* if the beacon didn't change, we can finalize immediately */
 		ieee80211_color_change_finalize(sdata);
-	}
 
 	return 0;
 }
-- 
2.25.1

