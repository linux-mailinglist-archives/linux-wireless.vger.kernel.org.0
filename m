Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B30B1AD9A0
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2020 11:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730181AbgDQJSh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Apr 2020 05:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729987AbgDQJSh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Apr 2020 05:18:37 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D64C061A0C
        for <linux-wireless@vger.kernel.org>; Fri, 17 Apr 2020 02:18:37 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jPN8t-006tkv-1l; Fri, 17 Apr 2020 11:18:35 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] mac80211: fix drv_config_iface_filter() behaviour
Date:   Fri, 17 Apr 2020 11:18:31 +0200
Message-Id: <20200417111830.401d82c7a0bf.I5dc7d718816460c2d8d89c7af6c215f9e2b3078f@changeid>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

There are two bugs with this, first, it shouldn't be called
on an interface that's down, and secondly, it should then be
called when the interface comes up.

Note that the currently only user (iwlwifi) doesn't seem to
care about either of these scenarios.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/cfg.c   | 15 +++++++++------
 net/mac80211/iface.c |  5 +++++
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 0f72813fed53..b90f2131ec7a 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3421,12 +3421,15 @@ static void ieee80211_mgmt_frame_register(struct wiphy *wiphy,
 		if (!local->open_count)
 			break;
 
-		if (sdata->vif.probe_req_reg == 1)
-			drv_config_iface_filter(local, sdata, FIF_PROBE_REQ,
-						FIF_PROBE_REQ);
-		else if (sdata->vif.probe_req_reg == 0)
-			drv_config_iface_filter(local, sdata, 0,
-						FIF_PROBE_REQ);
+		if (ieee80211_sdata_running(sdata)) {
+			if (sdata->vif.probe_req_reg == 1)
+				drv_config_iface_filter(local, sdata,
+							FIF_PROBE_REQ,
+							FIF_PROBE_REQ);
+			else if (sdata->vif.probe_req_reg == 0)
+				drv_config_iface_filter(local, sdata, 0,
+							FIF_PROBE_REQ);
+		}
 
 		ieee80211_configure_filter(local);
 		break;
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index d069825705d6..f900c84fb40f 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -644,6 +644,11 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
 			local->fif_probe_req++;
 		}
 
+		if (sdata->vif.probe_req_reg)
+			drv_config_iface_filter(local, sdata,
+						FIF_PROBE_REQ,
+						FIF_PROBE_REQ);
+
 		if (sdata->vif.type != NL80211_IFTYPE_P2P_DEVICE &&
 		    sdata->vif.type != NL80211_IFTYPE_NAN)
 			changed |= ieee80211_reset_erp_info(sdata);
-- 
2.25.1

