Return-Path: <linux-wireless+bounces-19053-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8D4A37CE3
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Feb 2025 09:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9AC516CF53
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Feb 2025 08:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694B5194C77;
	Mon, 17 Feb 2025 08:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b="jUj5sdHS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from ns2.wdyn.eu (ns2.wdyn.eu [5.252.227.236])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42BA19259D
	for <linux-wireless@vger.kernel.org>; Mon, 17 Feb 2025 08:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.252.227.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739780258; cv=none; b=p5hTtZ1a9+4VhzALCu2Fpa26rVgvZdYxh/NhREuqcukuC8QhZmpb9ia7gHRJRXzi5znNtnUGPti+N8tlwIeGGPT3D2dNW+aL0THOIjFQR6qgd6WVyEMIwYnJMWGRU0QP/B/jqcV0qkoHEx4bJ/85MwTp2sGWb+BcgiX6t8cikkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739780258; c=relaxed/simple;
	bh=8Drd6O/upxVbT4QAey6W5dYjVmuG+cJLFaZtYNFg6WM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FKYj4C6oJso1nqnYc/jAc834ea/O8uXfLXCDOW7ZyzljWWgbZ3VCT9/mPu3XoQE9BMlb3QqzddXMkakxmTHR5iWP5TDUBEqFqIG+9b1vTPWpw0a/CWBGBGiwNeXHXa0oocjvMIJmQ8mOqJTxW18Dt+mX3zbg9IRbuFvcthwxqeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de; spf=pass smtp.mailfrom=wetzel-home.de; dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b=jUj5sdHS; arc=none smtp.client-ip=5.252.227.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wetzel-home.de
From: Alexander Wetzel <Alexander@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
	s=wetzel-home; t=1739780252;
	bh=8Drd6O/upxVbT4QAey6W5dYjVmuG+cJLFaZtYNFg6WM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jUj5sdHSLwyUcRs6/M2ooGyXzW8PTJI1SoNPjOPhzyPuVxBRNwFPMzBrTdgPUCakX
	 DqJxnUjxAbldhveAMBDf0OLfZOuUL3Ge59XLTIP9oAhMZWiMVSS8a4iMjmMQzRatYQ
	 vg1RpImL3vHlZThW51XMUj590kTyDhOr1gU2yTbs=
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Alexander Wetzel <Alexander@wetzel-home.de>
Subject: [PATCH v2 01/10] wifi: mac80211: move rate control setup
Date: Mon, 17 Feb 2025 09:17:12 +0100
Message-ID: <20250217081721.45110-2-Alexander@wetzel-home.de>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250217081721.45110-1-Alexander@wetzel-home.de>
References: <20250217081721.45110-1-Alexander@wetzel-home.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move setting up the rate control into ieee80211_sdata_init() to ensure
rates are also set up for the virtual monitor interface.

Signed-off-by: Alexander Wetzel <Alexander@wetzel-home.de>
---
 net/mac80211/iface.c | 51 ++++++++++++++++++++++----------------------
 1 file changed, 26 insertions(+), 25 deletions(-)

diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 77d0078616fb..e01beda8c414 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -1118,6 +1118,31 @@ static void ieee80211_sdata_init(struct ieee80211_local *local,
 	 * MLD connection, we get a separate allocation for it.
 	 */
 	ieee80211_link_init(sdata, -1, &sdata->deflink, &sdata->vif.bss_conf);
+
+	for (int i = 0; i < NUM_NL80211_BANDS; i++) {
+		struct ieee80211_supported_band *sband;
+
+		sband = local->hw.wiphy->bands[i];
+		sdata->rc_rateidx_mask[i] =
+			sband ? (1 << sband->n_bitrates) - 1 : 0;
+		if (sband) {
+			__le16 cap;
+			u16 *vht_rate_mask;
+
+			memcpy(sdata->rc_rateidx_mcs_mask[i],
+			       sband->ht_cap.mcs.rx_mask,
+			       sizeof(sdata->rc_rateidx_mcs_mask[i]));
+
+			cap = sband->vht_cap.vht_mcs.rx_mcs_map;
+			vht_rate_mask = sdata->rc_rateidx_vht_mcs_mask[i];
+			ieee80211_get_vht_mask_from_cap(cap, vht_rate_mask);
+		} else {
+			memset(sdata->rc_rateidx_mcs_mask[i], 0,
+			       sizeof(sdata->rc_rateidx_mcs_mask[i]));
+			memset(sdata->rc_rateidx_vht_mcs_mask[i], 0,
+			       sizeof(sdata->rc_rateidx_vht_mcs_mask[i]));
+		}
+	}
 }
 
 int ieee80211_add_virtual_monitor(struct ieee80211_local *local)
@@ -2076,7 +2101,7 @@ int ieee80211_if_add(struct ieee80211_local *local, const char *name,
 	struct net_device *ndev = NULL;
 	struct ieee80211_sub_if_data *sdata = NULL;
 	struct txq_info *txqi;
-	int ret, i;
+	int ret;
 
 	ASSERT_RTNL();
 	lockdep_assert_wiphy(local->hw.wiphy);
@@ -2165,30 +2190,6 @@ int ieee80211_if_add(struct ieee80211_local *local, const char *name,
 	wiphy_delayed_work_init(&sdata->dec_tailroom_needed_wk,
 				ieee80211_delayed_tailroom_dec);
 
-	for (i = 0; i < NUM_NL80211_BANDS; i++) {
-		struct ieee80211_supported_band *sband;
-		sband = local->hw.wiphy->bands[i];
-		sdata->rc_rateidx_mask[i] =
-			sband ? (1 << sband->n_bitrates) - 1 : 0;
-		if (sband) {
-			__le16 cap;
-			u16 *vht_rate_mask;
-
-			memcpy(sdata->rc_rateidx_mcs_mask[i],
-			       sband->ht_cap.mcs.rx_mask,
-			       sizeof(sdata->rc_rateidx_mcs_mask[i]));
-
-			cap = sband->vht_cap.vht_mcs.rx_mcs_map;
-			vht_rate_mask = sdata->rc_rateidx_vht_mcs_mask[i];
-			ieee80211_get_vht_mask_from_cap(cap, vht_rate_mask);
-		} else {
-			memset(sdata->rc_rateidx_mcs_mask[i], 0,
-			       sizeof(sdata->rc_rateidx_mcs_mask[i]));
-			memset(sdata->rc_rateidx_vht_mcs_mask[i], 0,
-			       sizeof(sdata->rc_rateidx_vht_mcs_mask[i]));
-		}
-	}
-
 	ieee80211_set_default_queues(sdata);
 
 	/* setup type-dependent data */
-- 
2.48.1


