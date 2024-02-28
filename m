Return-Path: <linux-wireless+bounces-4150-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 234BE86AA6B
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 09:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 862CF282EC1
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 08:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7897F31A82;
	Wed, 28 Feb 2024 08:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="tDIrKspl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1C72D60C
	for <linux-wireless@vger.kernel.org>; Wed, 28 Feb 2024 08:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709110153; cv=none; b=a2Gxxhm0A+IcbKWAEcrh+Wj93bY81V1PDScqLc1vpyuUb/N9kIYbIQUMR8Hoyqr3xQnBFjqlit3Ilhw6BjCiVy3Z24nWC03LFw6+WQW6N/hR1DtJ1wvjGJGdDfEHxxgJ+kCni8cKROUtT9JYQntb66asprhPerDqkFFGxhiv6oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709110153; c=relaxed/simple;
	bh=GH234ThYK/CbslSPidh7qj8r735EKZZt1K4fDgj9EC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p3otugpKkmGPR+efmPFnWJdaa0GoCDea9RA5awp9hzuHor82VARXauJZKdv3XZdyo8ZFuSgSVlej1GJ1Ff1QNS1SSgkqqX1r+5E0AR17Zm3dvUOsaD6zqVgwD3GyL1BRCsHLgcoHF/IRhgKhXKt9f7zCT2Fbg241tkinVp6Lt24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=tDIrKspl; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=nV1zAS4CHCd9wjj2/NVlwm3qWhQlkoLk80Lq09ojcrw=;
	t=1709110150; x=1710319750; b=tDIrKsplyfYiRDBI/LYWdG/RsF7TkHCaoXUOw+MEmliNykk
	/7/kDAYRs578lEMTQAWyF1BN/uwlTnB485UfXBqqfxeXsqMChOfAPKqa/0yTypjbE2ddsl+Dz9Y5w
	ySY32jumjepZAEvnkudZyC0YQABFn95Xti2gH2auq6gKXcmmxALyI8urkX1AcNgLk59cHPk3yCxjJ
	h7L0ry0gE0MeuIXbFP0bbhwyhd8/DapAgq+wqroFo9gjHGVmxRa5ooJPAGdhe+jtaKVmpYzYVGRw7
	rj3RtCHmq6VegrghPsHWTNGh+FabF5C4mrTWCPGOmjoqFtf4a7x/CNxOIwwHdCPw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rfFcg-0000000C0BC-2qTz;
	Wed, 28 Feb 2024 09:49:06 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Ilan Peer <ilan.peer@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH 3/8] wifi: mac80211: add ieee80211_vif_link_active() helper
Date: Wed, 28 Feb 2024 09:48:11 +0100
Message-ID: <20240228094901.688760aff5f7.I06892a503f5ecb9563fbd678d35d08daf7a044b0@changeid>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240228084901.18661-10-johannes@sipsolutions.net>
References: <20240228084901.18661-10-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

We sometimes need to check if a link is active, and this
is complicated by the fact that active_links has no bits
set when the vif isn't (acting as) an MLD. Add a small
new helper ieee80211_vif_link_active() to make that a bit
easier, and use it in a few places.

Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/mac80211.h    | 15 +++++++++++++++
 net/mac80211/cfg.c        |  3 +--
 net/mac80211/chan.c       |  3 +--
 net/mac80211/driver-ops.c | 14 +++++---------
 net/mac80211/util.c       |  3 +--
 5 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 34d66d0a24b1..6c6d8210d637 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -2011,6 +2011,21 @@ static inline bool ieee80211_vif_is_mld(const struct ieee80211_vif *vif)
 	return vif->valid_links != 0;
 }
 
+/**
+ * ieee80211_vif_link_active - check if a given link is active
+ * @vif: the vif
+ * @link_id: the link ID to check
+ * Return: %true if the vif is an MLD and the link is active, or if
+ *	the vif is not an MLD and the link ID is 0; %false otherwise.
+ */
+static inline bool ieee80211_vif_link_active(const struct ieee80211_vif *vif,
+					     unsigned int link_id)
+{
+	if (!ieee80211_vif_is_mld(vif))
+		return link_id == 0;
+	return vif->active_links & BIT(link_id);
+}
+
 #define for_each_vif_active_link(vif, link, link_id)				\
 	for (link_id = 0; link_id < ARRAY_SIZE((vif)->link_conf); link_id++)	\
 		if ((!(vif)->active_links ||					\
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index e57ba4f7a589..821a83e487df 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3155,8 +3155,7 @@ int __ieee80211_request_smps_mgd(struct ieee80211_sub_if_data *sdata,
 	if (WARN_ON_ONCE(sdata->vif.type != NL80211_IFTYPE_STATION))
 		return -EINVAL;
 
-	if (ieee80211_vif_is_mld(&sdata->vif) &&
-	    !(sdata->vif.active_links & BIT(link->link_id)))
+	if (!ieee80211_vif_link_active(&sdata->vif, link->link_id))
 		return 0;
 
 	old_req = link->u.mgd.req_smps;
diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index 38acdc458c7c..80e4b9784131 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -1701,8 +1701,7 @@ int ieee80211_link_use_channel(struct ieee80211_link_data *link,
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
-	if (sdata->vif.active_links &&
-	    !(sdata->vif.active_links & BIT(link->link_id))) {
+	if (!ieee80211_vif_link_active(&sdata->vif, link->link_id)) {
 		ieee80211_link_update_chanreq(link, chanreq);
 		return 0;
 	}
diff --git a/net/mac80211/driver-ops.c b/net/mac80211/driver-ops.c
index 3b7f70073fc3..dce37ba8ebe3 100644
--- a/net/mac80211/driver-ops.c
+++ b/net/mac80211/driver-ops.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright 2015 Intel Deutschland GmbH
- * Copyright (C) 2022-2023 Intel Corporation
+ * Copyright (C) 2022-2024 Intel Corporation
  */
 #include <net/mac80211.h>
 #include "ieee80211_i.h"
@@ -214,8 +214,7 @@ int drv_conf_tx(struct ieee80211_local *local,
 	if (!check_sdata_in_driver(sdata))
 		return -EIO;
 
-	if (sdata->vif.active_links &&
-	    !(sdata->vif.active_links & BIT(link->link_id)))
+	if (!ieee80211_vif_link_active(&sdata->vif, link->link_id))
 		return 0;
 
 	if (params->cw_min == 0 || params->cw_min > params->cw_max) {
@@ -315,8 +314,7 @@ int drv_assign_vif_chanctx(struct ieee80211_local *local,
 	if (!check_sdata_in_driver(sdata))
 		return -EIO;
 
-	if (sdata->vif.active_links &&
-	    !(sdata->vif.active_links & BIT(link_conf->link_id)))
+	if (!ieee80211_vif_link_active(&sdata->vif, link_conf->link_id))
 		return 0;
 
 	trace_drv_assign_vif_chanctx(local, sdata, link_conf, ctx);
@@ -343,8 +341,7 @@ void drv_unassign_vif_chanctx(struct ieee80211_local *local,
 	if (!check_sdata_in_driver(sdata))
 		return;
 
-	if (sdata->vif.active_links &&
-	    !(sdata->vif.active_links & BIT(link_conf->link_id)))
+	if (!ieee80211_vif_link_active(&sdata->vif, link_conf->link_id))
 		return;
 
 	trace_drv_unassign_vif_chanctx(local, sdata, link_conf, ctx);
@@ -461,8 +458,7 @@ void drv_link_info_changed(struct ieee80211_local *local,
 	if (!check_sdata_in_driver(sdata))
 		return;
 
-	if (sdata->vif.active_links &&
-	    !(sdata->vif.active_links & BIT(link_id)))
+	if (!ieee80211_vif_link_active(&sdata->vif, link_id))
 		return;
 
 	trace_drv_link_info_changed(local, sdata, info, changed);
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 627bd5a8bda5..d7c4d162321f 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -1935,8 +1935,7 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 		for (link_id = 0;
 		     link_id < ARRAY_SIZE(sdata->vif.link_conf);
 		     link_id++) {
-			if (ieee80211_vif_is_mld(&sdata->vif) &&
-			    !(sdata->vif.active_links & BIT(link_id)))
+			if (!ieee80211_vif_link_active(&sdata->vif, link_id))
 				continue;
 
 			link = sdata_dereference(sdata->link[link_id], sdata);
-- 
2.43.2


