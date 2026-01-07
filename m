Return-Path: <linux-wireless+bounces-30504-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C2AE8CFE51D
	for <lists+linux-wireless@lfdr.de>; Wed, 07 Jan 2026 15:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1A85309350D
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jan 2026 14:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE45C345724;
	Wed,  7 Jan 2026 14:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="wcSjDQvo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEFB3446D4
	for <linux-wireless@vger.kernel.org>; Wed,  7 Jan 2026 14:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767795855; cv=none; b=qtBaaFiobl83SdDi5aIVAe1rZhiLhBU1eICIo3dil9uDuLO9v4tRvXVuTWaik6/zIEp4cjb0j1CZyP7kgZQVyn4PvNYDXVBh5hrppSYAcEdr5XtFKYLfVl6/QQnxio8P1Sx6IF+HRxqyugZipS+ASB/+OoXQlYW49mYP8x1NhVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767795855; c=relaxed/simple;
	bh=eYdBxrttO5gtR9jEBa1kIS8l/X0RcNTgMiAR80c139A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tNaRWhFTwhIyx7Hq1irbmAEPSFFC/n+2kslzMbiLSMiFlR1yGbxH9ewl0rUT6W7hDNfzjSAeDk3hnC0//6mi+EFpYIgHwpULkfl+oggwDmfpmVNGpYCIPF5b0EUTbSChE3+lv9uYQBzbePXQs6UwWe0DolJjuLDitMkqdOClUmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=wcSjDQvo; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=wFZ9aocdlaC4kNskAs+4YEYDwe/2RWzZmwUKJmmkyw0=;
	t=1767795853; x=1769005453; b=wcSjDQvofx/HU2hn43HBQiJ53CkWoePxmItC35lEs2QCHKF
	nYy46+rZ7J7SjdJmlOSNBYTt+JFCsXeDJ/nfIMVO5Um5wdca/b/Vgk1n2z9WsNd3YOD63HQ9j8PMC
	W6AGB6klUYTuIydc3PR8nvDXQutB6x8mVnIslLcNYwQT6M8R9+RK2PPHoQgn2bA+rkQMBJN1XUKrP
	bF/vCKe3vxP3XYJYFfh/7jfT7b8Ghdjd7Bw7Pr9gTBZaLvZn+6qsS+4UBr4j/EA+pktYm6+qh5aO+
	oh8YelBghYcle3csm7QQ1tNZEU+z7ulkggIivDjPV1+AJAuyrrDuHIu2NxNfo7Iw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vdUSJ-00000005agF-24cT;
	Wed, 07 Jan 2026 15:24:11 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [RFC wireless-next 42/46] wifi: mac80211: track the id of the NAN cluster we joined
Date: Wed,  7 Jan 2026 15:22:41 +0100
Message-ID: <20260107152325.9ed62cc32314.I0f1060215267fd8aef31afd99f8f42e6fde7f234@changeid>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107142324.45386-48-johannes@sipsolutions.net>
References: <20260107142324.45386-48-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

Currently, we store in nan.conf the cluster id that was configured from
upper layer to be used when the device opens a cluster.
But after we joined a cluster, the configured cluster id is no longer
relevant. Particularly, in reconfig we will give the driver the
(possibly) wrong cluster id.

Add an API to be called by the driver when joined a cluster
in which the cluster id will be updated.
Use the locally stored cluster id instead of cfg80211's copy.

Ignore cluster id updates from cfg80211 if we already have one
configured.

Adjust the drivers that use the cfg80211 API
(cfg80211_nan_cluster_joined) directly, otherwise we break functionality
(i.e. accept frame check won't evaluate to true).

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 .../net/wireless/virtual/mac80211_hwsim_nan.c | 22 ++++-------
 include/net/mac80211.h                        | 16 +++++++-
 net/mac80211/cfg.c                            | 37 ++++++++++++++++---
 net/mac80211/rx.c                             |  6 +--
 net/mac80211/tx.c                             |  2 +-
 5 files changed, 58 insertions(+), 25 deletions(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim_nan.c b/drivers/net/wireless/virtual/mac80211_hwsim_nan.c
index 0fb97710b61e..46a7bcfc923a 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim_nan.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_nan.c
@@ -487,13 +487,10 @@ void mac80211_hwsim_nan_rx(struct ieee80211_hw *hw,
 
 	spin_unlock_bh(&data->nan.state_lock);
 
-	if (joined_cluster) {
-		struct wireless_dev *wdev =
-			ieee80211_vif_to_wdev(data->nan.device_vif);
-
-		cfg80211_nan_cluster_joined(wdev, data->nan.cluster_id, false,
-					    GFP_ATOMIC);
-	}
+	if (joined_cluster)
+		ieee80211_nan_cluster_joined(data->nan.device_vif,
+					     data->nan.cluster_id, false,
+					     GFP_ATOMIC);
 }
 
 static void
@@ -573,13 +570,10 @@ mac80211_hwsim_nan_exec_state_transitions(struct mac80211_hwsim_data *data)
 
 	spin_unlock(&data->nan.state_lock);
 
-	if (notify_join) {
-		struct wireless_dev *wdev =
-			ieee80211_vif_to_wdev(data->nan.device_vif);
-
-		cfg80211_nan_cluster_joined(wdev, data->nan.cluster_id, true,
-					    GFP_ATOMIC);
-	}
+	if (notify_join)
+		ieee80211_nan_cluster_joined(data->nan.device_vif,
+					     data->nan.cluster_id, true,
+					     GFP_ATOMIC);
 }
 
 static void
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 530cd13b8c88..771176eb8f4f 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -7,7 +7,7 @@
  * Copyright 2007-2010	Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright (C) 2015 - 2017 Intel Deutschland GmbH
- * Copyright (C) 2018 - 2025 Intel Corporation
+ * Copyright (C) 2018 - 2026 Intel Corporation
  */
 
 #ifndef MAC80211_H
@@ -7780,6 +7780,20 @@ void ieee80211_nan_func_match(struct ieee80211_vif *vif,
 			      struct cfg80211_nan_match_params *match,
 			      gfp_t gfp);
 
+/**
+ * ieee80211_nan_cluster_joined - notify about NAN cluster join.
+ *
+ * This function is used to notify mac80211 about NAN cluster join.
+ *
+ * @vif: &struct ieee80211_vif pointer from the add_interface callback.
+ * @cluster_id: the cluster ID that was joined
+ * @new_cluster: true if this is a new cluster
+ * @gfp: allocation flags
+ */
+void ieee80211_nan_cluster_joined(struct ieee80211_vif *vif,
+				  const u8 *cluster_id, bool new_cluster,
+				  gfp_t gfp);
+
 /**
  * ieee80211_calc_rx_airtime - calculate estimated transmission airtime for RX.
  *
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index b703a604e6bb..2583afc81194 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -372,9 +372,6 @@ static int ieee80211_nan_conf_copy(struct cfg80211_nan_conf *dst,
 		memcpy(&dst->band_cfgs, &src->band_cfgs,
 		       sizeof(dst->band_cfgs));
 
-		kfree(dst->cluster_id);
-		dst->cluster_id = NULL;
-
 		kfree(dst->extra_nan_attrs);
 		dst->extra_nan_attrs = NULL;
 		dst->extra_nan_attrs_len = 0;
@@ -383,12 +380,15 @@ static int ieee80211_nan_conf_copy(struct cfg80211_nan_conf *dst,
 		dst->vendor_elems = NULL;
 		dst->vendor_elems_len = 0;
 
-		if (src->cluster_id) {
+		if (src->cluster_id && !dst->cluster_id) {
 			dst->cluster_id = kmemdup(src->cluster_id, ETH_ALEN,
 						  GFP_KERNEL);
-			if (!dst->cluster_id)
-				goto no_mem;
+		} else if (!src->cluster_id && !dst->cluster_id) {
+			/* Set to 0 address to avoid checking for NULL whenever it is used */
+			dst->cluster_id = kzalloc(ETH_ALEN, GFP_KERNEL);
 		}
+		if (!dst->cluster_id)
+			goto no_mem;
 
 		if (src->extra_nan_attrs && src->extra_nan_attrs_len) {
 			dst->extra_nan_attrs = kmemdup(src->extra_nan_attrs,
@@ -4974,6 +4974,31 @@ void ieee80211_nan_func_match(struct ieee80211_vif *vif,
 }
 EXPORT_SYMBOL(ieee80211_nan_func_match);
 
+void ieee80211_nan_cluster_joined(struct ieee80211_vif *vif,
+				  const u8 *cluster_id, bool new_cluster,
+				  gfp_t gfp)
+{
+	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
+	u8 *new_cluster_id;
+
+	if (WARN_ON(vif->type != NL80211_IFTYPE_NAN))
+		return;
+
+	if (WARN_ON(!sdata->u.nan.started))
+		return;
+
+	new_cluster_id = kmemdup(cluster_id, ETH_ALEN, gfp);
+	if (!new_cluster_id)
+		return;
+
+	kfree(sdata->u.nan.conf.cluster_id);
+	sdata->u.nan.conf.cluster_id = new_cluster_id;
+
+	cfg80211_nan_cluster_joined(ieee80211_vif_to_wdev(vif), cluster_id,
+				    new_cluster, gfp);
+}
+EXPORT_SYMBOL(ieee80211_nan_cluster_joined);
+
 static int ieee80211_set_multicast_to_unicast(struct wiphy *wiphy,
 					      struct net_device *dev,
 					      const bool enabled)
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index a439bbb098e2..e54fc54e716a 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -6,7 +6,7 @@
  * Copyright 2007-2010	Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright(c) 2015 - 2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2025 Intel Corporation
+ * Copyright (C) 2018-2026 Intel Corporation
  */
 
 #include <linux/jiffies.h>
@@ -4625,7 +4625,7 @@ static bool ieee80211_accept_frame(struct ieee80211_rx_data *rx)
 		 * action frames or authentication frames that are addressed to
 		 * the local NAN interface.
 		 */
-		return memcmp(sdata->wdev.u.nan.cluster_id,
+		return memcmp(sdata->u.nan.conf.cluster_id,
 			      hdr->addr3, ETH_ALEN) == 0 &&
 			(ieee80211_is_public_action(hdr, skb->len) ||
 			 (ieee80211_is_auth(hdr->frame_control) &&
@@ -4642,7 +4642,7 @@ static bool ieee80211_accept_frame(struct ieee80211_rx_data *rx)
 			if (!nmi)
 				return false;
 
-			if (!ether_addr_equal(nmi->wdev.u.nan.cluster_id,
+			if (!ether_addr_equal(nmi->u.nan.conf.cluster_id,
 					      hdr->addr3))
 				return false;
 
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 8a1778e11595..a9a360fe0161 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -2852,7 +2852,7 @@ static struct sk_buff *ieee80211_build_hdr(struct ieee80211_sub_if_data *sdata,
 			ret = -ENOTCONN;
 			goto free;
 		}
-		memcpy(hdr.addr3, nmi->wdev.u.nan.cluster_id, ETH_ALEN);
+		memcpy(hdr.addr3, nmi->u.nan.conf.cluster_id, ETH_ALEN);
 		hdrlen = 24;
 		break;
 	}
-- 
2.52.0


