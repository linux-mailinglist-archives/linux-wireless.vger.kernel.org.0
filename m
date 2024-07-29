Return-Path: <linux-wireless+bounces-10644-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F88940170
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jul 2024 00:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72689283303
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2024 22:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70D1189F50;
	Mon, 29 Jul 2024 22:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="L4Dv4/yx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C916413B780;
	Mon, 29 Jul 2024 22:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722293966; cv=none; b=EXMk1bAFd5VmVrpIvHN3yd65aK0yGF4IKTb5fI/1goNsN2aMbMvDT33+NLCuvKYfsjDbxiSI9B1edY6PakX0O2r6tn+KQvtprGJiCVNXxZJrLX2y+SQVYAb31ktzV4ZEXpsaUljXrXUM1Lun33QDnb7dLArPMLRGtbi76n9B7xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722293966; c=relaxed/simple;
	bh=6KEsNjAVfPfUggt3/ZqvqGkqS+F0e/mwKXE/gDmNeU8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JpRNrTwSJGipvtGK5sCYMvJca11bYUxGUcVxfe+d9+L53qshi9NeknIqE6DCMk0wl0YRgGH32hEi8sjlKGGEd9LeDVgm9RvHO9NRFeo9OUPSnk7mgLXzrwDqkmiXRyTVe66OnSjQKtoI3P6i65Kfr8cVIEDN1M2p1qXY2QvjD40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=L4Dv4/yx; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4WXv1f5gTSz9sc5;
	Tue, 30 Jul 2024 00:59:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1722293958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ek3INDOD2NP1O4dG1NZuIFpg48eQxX6GqA2um7yD0YQ=;
	b=L4Dv4/yxo94sGjX9g3rm4Xo4uCOSA29sac9y5keFuEWudQQ2MwmMvgNGIC+Hgt0NZr5Dp0
	ZCBY06k5kt1EtynzNXNd6VTTh6b+ZQlyQrjKQV/+hPNpRhbo4bdTPgHGTycoKue3bB+KH3
	8S2w96Z5nrunZtGN2a0FF2ofnJiTRZ0K6VC5JU9Py/p0p5WAvKmfqm78p190ZIxTx8DCWt
	il9BH5R2jyCH+D8vQmidPVM4kafzkee+94VJVECW4ZjRs8UfKTwZ+qfBBAIRiHre2u/mTF
	Ji4+LjxeOg860boD0bWWis7+rgVRmuRg6CRxcVcnl+iiQNWtoGKPtJjRt7xqVw==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: stable@vger.kernel.org
Cc: johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 6.6] wifi: mac80211: track capability/opmode NSS separately
Date: Tue, 30 Jul 2024 00:58:49 +0200
Message-ID: <20240729225849.1352302-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit a8bca3e9371dc5e276af4168be099b2a05554c2a ]

We're currently tracking rx_nss for each station, and that
is meant to be initialized to the capability NSS and later
reduced by the operating mode notification NSS.

However, we're mixing up capabilities and operating mode
NSS in the same variable. This forces us to recalculate
the NSS capability on operating mode notification RX,
which is a bit strange; due to the previous fix I had to
never keep rx_nss as zero, it also means that the capa is
never taken into account properly.

Fix all this by storing the capability value, that can be
recalculated unconditionally whenever needed, and storing
the operating mode notification NSS separately, taking it
into account when assigning the final rx_nss value.

Cc: stable@vger.kernel.org
Fixes: dd6c064cfc3f ("wifi: mac80211: set station RX-NSS on reconfig")
Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://msgid.link/20240228120157.0e1c41924d1d.I0acaa234e0267227b7e3ef81a59117c8792116bc@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
[Fixed trivial merge conflict in copyright year net/mac80211/sta_info.h]
Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 net/mac80211/cfg.c         |  2 +-
 net/mac80211/ieee80211_i.h |  2 +-
 net/mac80211/rate.c        |  2 +-
 net/mac80211/sta_info.h    |  6 ++++-
 net/mac80211/vht.c         | 46 ++++++++++++++++++--------------------
 5 files changed, 30 insertions(+), 28 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index f3fc0be9d8ea..ca5b111f20e5 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1887,7 +1887,7 @@ static int sta_link_apply_parameters(struct ieee80211_local *local,
 					      sband->band);
 	}
 
-	ieee80211_sta_set_rx_nss(link_sta);
+	ieee80211_sta_init_nss(link_sta);
 
 	return ret;
 }
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index fb55014c0e89..daea061d0fc1 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2150,7 +2150,7 @@ enum ieee80211_sta_rx_bandwidth
 ieee80211_sta_cap_rx_bw(struct link_sta_info *link_sta);
 enum ieee80211_sta_rx_bandwidth
 ieee80211_sta_cur_vht_bw(struct link_sta_info *link_sta);
-void ieee80211_sta_set_rx_nss(struct link_sta_info *link_sta);
+void ieee80211_sta_init_nss(struct link_sta_info *link_sta);
 enum ieee80211_sta_rx_bandwidth
 ieee80211_chan_width_to_rx_bw(enum nl80211_chan_width width);
 enum nl80211_chan_width
diff --git a/net/mac80211/rate.c b/net/mac80211/rate.c
index a2bc9c5d92b8..3cf252418bd3 100644
--- a/net/mac80211/rate.c
+++ b/net/mac80211/rate.c
@@ -37,7 +37,7 @@ void rate_control_rate_init(struct sta_info *sta)
 	struct ieee80211_supported_band *sband;
 	struct ieee80211_chanctx_conf *chanctx_conf;
 
-	ieee80211_sta_set_rx_nss(&sta->deflink);
+	ieee80211_sta_init_nss(&sta->deflink);
 
 	if (!ref)
 		return;
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index 195b563132d6..f4af851f45ce 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -3,7 +3,7 @@
  * Copyright 2002-2005, Devicescape Software, Inc.
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright(c) 2015-2017 Intel Deutschland GmbH
- * Copyright(c) 2020-2022 Intel Corporation
+ * Copyright(c) 2020-2024 Intel Corporation
  */
 
 #ifndef STA_INFO_H
@@ -485,6 +485,8 @@ struct ieee80211_fragment_cache {
  *	same for non-MLD STA. This is used as key for searching link STA
  * @link_id: Link ID uniquely identifying the link STA. This is 0 for non-MLD
  *	and set to the corresponding vif LinkId for MLD STA
+ * @op_mode_nss: NSS limit as set by operating mode notification, or 0
+ * @capa_nss: NSS limit as determined by local and peer capabilities
  * @link_hash_node: hash node for rhashtable
  * @sta: Points to the STA info
  * @gtk: group keys negotiated with this station, if any
@@ -521,6 +523,8 @@ struct link_sta_info {
 	u8 addr[ETH_ALEN];
 	u8 link_id;
 
+	u8 op_mode_nss, capa_nss;
+
 	struct rhlist_head link_hash_node;
 
 	struct sta_info *sta;
diff --git a/net/mac80211/vht.c b/net/mac80211/vht.c
index b3a5c3e96a72..bc13b1419981 100644
--- a/net/mac80211/vht.c
+++ b/net/mac80211/vht.c
@@ -4,7 +4,7 @@
  *
  * Portions of this file
  * Copyright(c) 2015 - 2016 Intel Deutschland GmbH
- * Copyright (C) 2018 - 2023 Intel Corporation
+ * Copyright (C) 2018 - 2024 Intel Corporation
  */
 
 #include <linux/ieee80211.h>
@@ -541,15 +541,11 @@ ieee80211_sta_cur_vht_bw(struct link_sta_info *link_sta)
 	return bw;
 }
 
-void ieee80211_sta_set_rx_nss(struct link_sta_info *link_sta)
+void ieee80211_sta_init_nss(struct link_sta_info *link_sta)
 {
 	u8 ht_rx_nss = 0, vht_rx_nss = 0, he_rx_nss = 0, eht_rx_nss = 0, rx_nss;
 	bool support_160;
 
-	/* if we received a notification already don't overwrite it */
-	if (link_sta->pub->rx_nss)
-		return;
-
 	if (link_sta->pub->eht_cap.has_eht) {
 		int i;
 		const u8 *rx_nss_mcs = (void *)&link_sta->pub->eht_cap.eht_mcs_nss_supp;
@@ -627,7 +623,15 @@ void ieee80211_sta_set_rx_nss(struct link_sta_info *link_sta)
 	rx_nss = max(vht_rx_nss, ht_rx_nss);
 	rx_nss = max(he_rx_nss, rx_nss);
 	rx_nss = max(eht_rx_nss, rx_nss);
-	link_sta->pub->rx_nss = max_t(u8, 1, rx_nss);
+	rx_nss = max_t(u8, 1, rx_nss);
+	link_sta->capa_nss = rx_nss;
+
+	/* that shouldn't be set yet, but we can handle it anyway */
+	if (link_sta->op_mode_nss)
+		link_sta->pub->rx_nss =
+			min_t(u8, rx_nss, link_sta->op_mode_nss);
+	else
+		link_sta->pub->rx_nss = rx_nss;
 }
 
 u32 __ieee80211_vht_handle_opmode(struct ieee80211_sub_if_data *sdata,
@@ -637,7 +641,7 @@ u32 __ieee80211_vht_handle_opmode(struct ieee80211_sub_if_data *sdata,
 	enum ieee80211_sta_rx_bandwidth new_bw;
 	struct sta_opmode_info sta_opmode = {};
 	u32 changed = 0;
-	u8 nss, cur_nss;
+	u8 nss;
 
 	/* ignore - no support for BF yet */
 	if (opmode & IEEE80211_OPMODE_NOTIF_RX_NSS_TYPE_BF)
@@ -647,23 +651,17 @@ u32 __ieee80211_vht_handle_opmode(struct ieee80211_sub_if_data *sdata,
 	nss >>= IEEE80211_OPMODE_NOTIF_RX_NSS_SHIFT;
 	nss += 1;
 
-	if (link_sta->pub->rx_nss != nss) {
-		cur_nss = link_sta->pub->rx_nss;
-		/* Reset rx_nss and call ieee80211_sta_set_rx_nss() which
-		 * will set the same to max nss value calculated based on capability.
-		 */
-		link_sta->pub->rx_nss = 0;
-		ieee80211_sta_set_rx_nss(link_sta);
-		/* Do not allow an nss change to rx_nss greater than max_nss
-		 * negotiated and capped to APs capability during association.
-		 */
-		if (nss <= link_sta->pub->rx_nss) {
-			link_sta->pub->rx_nss = nss;
-			sta_opmode.rx_nss = nss;
-			changed |= IEEE80211_RC_NSS_CHANGED;
-			sta_opmode.changed |= STA_OPMODE_N_SS_CHANGED;
+	if (link_sta->op_mode_nss != nss) {
+		if (nss <= link_sta->capa_nss) {
+			link_sta->op_mode_nss = nss;
+
+			if (nss != link_sta->pub->rx_nss) {
+				link_sta->pub->rx_nss = nss;
+				changed |= IEEE80211_RC_NSS_CHANGED;
+				sta_opmode.rx_nss = link_sta->pub->rx_nss;
+				sta_opmode.changed |= STA_OPMODE_N_SS_CHANGED;
+			}
 		} else {
-			link_sta->pub->rx_nss = cur_nss;
 			pr_warn_ratelimited("Ignoring NSS change in VHT Operating Mode Notification from %pM with invalid nss %d",
 					    link_sta->pub->addr, nss);
 		}
-- 
2.45.2


