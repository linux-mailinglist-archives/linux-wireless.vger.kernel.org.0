Return-Path: <linux-wireless+bounces-19191-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE69A3D735
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 11:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 814337A401E
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 10:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A410E1F3D20;
	Thu, 20 Feb 2025 10:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b="axZChxku"
X-Original-To: linux-wireless@vger.kernel.org
Received: from ns2.wdyn.eu (ns2.wdyn.eu [5.252.227.236])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059B71F3B92
	for <linux-wireless@vger.kernel.org>; Thu, 20 Feb 2025 10:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.252.227.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740048285; cv=none; b=QuWsJfdO1yW3+dWlaQuNDivanfWPCh+cg1ULmmr1bcDj/9/MASW/RlPs1eKo3VPY/4QXX+CG6XHkvYHSxVG6JHdG7eef4B4ddCd062UTrIUdwBNHHKhLPNjUoYQpmkhvN0I3SIUeP8Jg+Qgq4Fz/nOqa08s4FAnCTVHu68eA61o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740048285; c=relaxed/simple;
	bh=tGx2EV38wBwrG3IpJ3NAsu9iteg8bo6B8Wt13suMfOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B+dwS7xWnrVCOPvIOwv5Y9W1zbTz+TvBkLQYNO4cFh/47MULsMoOJSGiop3i7BLKW/waoBo15sAhcy+w5r7t4aFAgns/ms7lzHM1Nge6p+0ceDSE8zyqjMeQVlgQQMLs6lXtr+pQveKXI6oxDj7HwSsKja903r0fdZ8nxH+y0Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de; spf=pass smtp.mailfrom=wetzel-home.de; dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b=axZChxku; arc=none smtp.client-ip=5.252.227.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wetzel-home.de
From: Alexander Wetzel <Alexander@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
	s=wetzel-home; t=1740048280;
	bh=tGx2EV38wBwrG3IpJ3NAsu9iteg8bo6B8Wt13suMfOc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=axZChxkuuGJCgRPNHL4flExP6CXY2UydNLTnfVE8yZxWPCMTwReLg/6bcAnsj2ziq
	 tOy8TfRWoJSap7Ix6uSLUGoQuyC6NxKLjPkfzIadN4Acgh1Ff1xtw+p/LY7U43lwXf
	 /KsvHem7z6di+qD2Trdt71s6N1vu9zqfRwO9NqbY=
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Alexander Wetzel <Alexander@wetzel-home.de>
Subject: [PATCH v3 01/10] wifi: mac80211: move rate control setup
Date: Thu, 20 Feb 2025 11:44:17 +0100
Message-ID: <20250220104426.82011-2-Alexander@wetzel-home.de>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250220104426.82011-1-Alexander@wetzel-home.de>
References: <20250220104426.82011-1-Alexander@wetzel-home.de>
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
index b0423046028c..7525fe9e62de 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -1120,6 +1120,31 @@ static void ieee80211_sdata_init(struct ieee80211_local *local,
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
@@ -2080,7 +2105,7 @@ int ieee80211_if_add(struct ieee80211_local *local, const char *name,
 	struct net_device *ndev = NULL;
 	struct ieee80211_sub_if_data *sdata = NULL;
 	struct txq_info *txqi;
-	int ret, i;
+	int ret;
 
 	ASSERT_RTNL();
 	lockdep_assert_wiphy(local->hw.wiphy);
@@ -2169,30 +2194,6 @@ int ieee80211_if_add(struct ieee80211_local *local, const char *name,
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


