Return-Path: <linux-wireless+bounces-19015-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1E9A3750E
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Feb 2025 16:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43FE93A8AEA
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Feb 2025 15:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961DC156236;
	Sun, 16 Feb 2025 15:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b="Ktldllse"
X-Original-To: linux-wireless@vger.kernel.org
Received: from ns2.wdyn.eu (ns2.wdyn.eu [5.252.227.236])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB2D1F95A
	for <linux-wireless@vger.kernel.org>; Sun, 16 Feb 2025 15:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.252.227.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739719949; cv=none; b=AVyoecDeVFs7MTUBZHjjkIcZ3oygyp3tbFSCSBD+5+k2lDhHrCerG1vzwN0alQhegTRx4OF15M4r7EzWx0ZJBcp7lrE8FkgYeB8PP+lwfXqg+I6JeVoORbpm3/43MFqm3IgSowbgo5Hc0k1/HDJ0BanASDQVtf+rGnADbfKKwbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739719949; c=relaxed/simple;
	bh=8Drd6O/upxVbT4QAey6W5dYjVmuG+cJLFaZtYNFg6WM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NwHo1TznLjv9nFV+ssXhZp+oZwDCBIteofqJeagLCmE4VMfonefEaZ8Wco5X3oGTBC5UczoD/VaB70COrVkVVAhxp65hNo/How87m4Q0OSVclIxwM90J+iGxROaAVIko3wYC3wZzHqrbbgLTn+MTUtFCfUXaJoLTC5TixB37Lhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de; spf=pass smtp.mailfrom=wetzel-home.de; dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b=Ktldllse; arc=none smtp.client-ip=5.252.227.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wetzel-home.de
From: Alexander Wetzel <Alexander@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
	s=wetzel-home; t=1739719937;
	bh=8Drd6O/upxVbT4QAey6W5dYjVmuG+cJLFaZtYNFg6WM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KtldllseDv8mQB11i5aJPnFnT36bJPp+bt9lrOUax40kEz+QMYoCSKCNyf5/mukHp
	 0jiNVMnS1CsMu5tgCPrjH+hRmOcGZddi5fvrGg8drHy2qgK49DGySewzLWavFcv/84
	 VEVEaYb0KmutOAek5g7iN3Tdze6HVD+TsLn43IUc=
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Alexander Wetzel <Alexander@wetzel-home.de>
Subject: [PATCH 01/10] wifi: mac80211: move rate control setup
Date: Sun, 16 Feb 2025 16:31:51 +0100
Message-ID: <20250216153200.1318604-2-Alexander@wetzel-home.de>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250216153200.1318604-1-Alexander@wetzel-home.de>
References: <20250216153200.1318604-1-Alexander@wetzel-home.de>
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


