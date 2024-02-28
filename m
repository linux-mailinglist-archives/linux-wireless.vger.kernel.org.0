Return-Path: <linux-wireless+bounces-4143-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4200B86AA62
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 09:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 653141C210FE
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 08:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431222377A;
	Wed, 28 Feb 2024 08:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="a4xcLJdf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A167E2D605
	for <linux-wireless@vger.kernel.org>; Wed, 28 Feb 2024 08:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709110080; cv=none; b=OSmdGHcRG2qsH9jcYZ5fdvaO2yTYeIXXjSdqQepCb9oVbLMQHByHPpY/xmPkBqOvE09ezg2uGctq7x5X1rEM+lDRv8gOSgf0n38s7/gFTVEKbnbr5S4OdBvKLExgNXMCQTVd6Al0s8gMslm0FHRWVKKlURqwG8nHZ7MpB7xenV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709110080; c=relaxed/simple;
	bh=TStAacKcNujBTe/VAEEHtY2ZSJbuI0yd6MzSD84imGE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AxqePyH/1HzsWSRNn4R54nIac465D+KcY9GGvoU7C1eVndaHfxB+K+biZLE5rFNvZFbERNgBTvhEW+sHIti0ZMNqnc5qsR/uuWShN4DuOhssiSm9+AbjZAbAIpRwwQRv+U40ttP8BZsJoTh2y+nSZXtYLSuXELzkmwZSTOGhHDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=a4xcLJdf; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=p/sEAzCJvetYOeJJLZeGOQXLOFEuVNeRAlfGFdV0Yak=; t=1709110078; x=1710319678; 
	b=a4xcLJdfa98rSCrb0rSs6jnmNu7w8sLmMJuZ3Q21AQOdv5UPGswq4ogHgT/D9IeXa6D0mhT5Ca7
	LD06LSL4N23S+opjFYXK6KcFy3VovMGn7MWFUDFOmIF3XL/J9w/AImOaBV7RQE66aA0HGVIOpzrJu
	Rgo7RME6O28caxGuQwz3uHsJ6Se3skrIDbjdTlvNMvUXAY05OztExTjd0auvn3kJLLqB3MeajmKvg
	ldmGeRRE9wNtNn6UMvg+LKVbz94gLWxPNaKZ119F6Qb1vvC7sAn3jkaFoRMWrIRhPC17oOXa77K9b
	iK4G+GSlfx35DthipUHAqCg4fjG4pWEA6EVQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rfFbX-0000000C06w-2QDK;
	Wed, 28 Feb 2024 09:47:56 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Ilan Peer <ilan.peer@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH] wifi: mac80211: Adjust CQM handling for MLO
Date: Wed, 28 Feb 2024 09:47:54 +0100
Message-ID: <20240228094753.bf6a3fefe553.Id738810b73e1087e01d5885508b70a3631707627@changeid>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ilan Peer <ilan.peer@intel.com>

The CQM handling did not consider the MLO case and thus notified
a not-existing link with the CQM change. To fix this, propagate
the CQM notification to all the active links (handling both the
non-MLO and MLO cases).

TODO: this currently propagates the same configuration to all
links regardless of the band. This might not be the correct
approach as different links might need to be configured with
different values.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/cfg.c | 79 +++++++++++++++++++++++++++++-----------------
 1 file changed, 50 insertions(+), 29 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 0744113f3535..e57ba4f7a589 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3256,33 +3256,57 @@ static int ieee80211_set_power_mgmt(struct wiphy *wiphy, struct net_device *dev,
 	return 0;
 }
 
+static void ieee80211_set_cqm_rssi_link(struct ieee80211_sub_if_data *sdata,
+					struct ieee80211_link_data *link,
+					s32 rssi_thold, u32 rssi_hyst,
+					s32 rssi_low, s32 rssi_high)
+{
+	struct ieee80211_bss_conf *conf;
+
+	if (!link || !link->conf)
+		return;
+
+	conf = link->conf;
+
+	if (rssi_thold && rssi_hyst &&
+	    rssi_thold == conf->cqm_rssi_thold &&
+	    rssi_hyst == conf->cqm_rssi_hyst)
+		return;
+
+	conf->cqm_rssi_thold = rssi_thold;
+	conf->cqm_rssi_hyst = rssi_hyst;
+	conf->cqm_rssi_low = rssi_low;
+	conf->cqm_rssi_high = rssi_high;
+	link->u.mgd.last_cqm_event_signal = 0;
+
+	if (!ieee80211_vif_link_active(&sdata->vif, link->link_id))
+		return;
+
+	if (sdata->u.mgd.associated &&
+	    (sdata->vif.driver_flags & IEEE80211_VIF_SUPPORTS_CQM_RSSI))
+		ieee80211_link_info_change_notify(sdata, link, BSS_CHANGED_CQM);
+}
+
 static int ieee80211_set_cqm_rssi_config(struct wiphy *wiphy,
 					 struct net_device *dev,
 					 s32 rssi_thold, u32 rssi_hyst)
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
 	struct ieee80211_vif *vif = &sdata->vif;
-	struct ieee80211_bss_conf *bss_conf = &vif->bss_conf;
+	int link_id;
 
-	if (rssi_thold == bss_conf->cqm_rssi_thold &&
-	    rssi_hyst == bss_conf->cqm_rssi_hyst)
-		return 0;
-
-	if (sdata->vif.driver_flags & IEEE80211_VIF_BEACON_FILTER &&
-	    !(sdata->vif.driver_flags & IEEE80211_VIF_SUPPORTS_CQM_RSSI))
+	if (vif->driver_flags & IEEE80211_VIF_BEACON_FILTER &&
+	    !(vif->driver_flags & IEEE80211_VIF_SUPPORTS_CQM_RSSI))
 		return -EOPNOTSUPP;
 
-	bss_conf->cqm_rssi_thold = rssi_thold;
-	bss_conf->cqm_rssi_hyst = rssi_hyst;
-	bss_conf->cqm_rssi_low = 0;
-	bss_conf->cqm_rssi_high = 0;
-	sdata->deflink.u.mgd.last_cqm_event_signal = 0;
+	/* For MLD, handle CQM change on all the active links */
+	for (link_id = 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS; link_id++) {
+		struct ieee80211_link_data *link =
+			sdata_dereference(sdata->link[link_id], sdata);
 
-	/* tell the driver upon association, unless already associated */
-	if (sdata->u.mgd.associated &&
-	    sdata->vif.driver_flags & IEEE80211_VIF_SUPPORTS_CQM_RSSI)
-		ieee80211_link_info_change_notify(sdata, &sdata->deflink,
-						  BSS_CHANGED_CQM);
+		ieee80211_set_cqm_rssi_link(sdata, link, rssi_thold, rssi_hyst,
+					    0, 0);
+	}
 
 	return 0;
 }
@@ -3293,22 +3317,19 @@ static int ieee80211_set_cqm_rssi_range_config(struct wiphy *wiphy,
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
 	struct ieee80211_vif *vif = &sdata->vif;
-	struct ieee80211_bss_conf *bss_conf = &vif->bss_conf;
+	int link_id;
 
-	if (sdata->vif.driver_flags & IEEE80211_VIF_BEACON_FILTER)
+	if (vif->driver_flags & IEEE80211_VIF_BEACON_FILTER)
 		return -EOPNOTSUPP;
 
-	bss_conf->cqm_rssi_low = rssi_low;
-	bss_conf->cqm_rssi_high = rssi_high;
-	bss_conf->cqm_rssi_thold = 0;
-	bss_conf->cqm_rssi_hyst = 0;
-	sdata->deflink.u.mgd.last_cqm_event_signal = 0;
+	/* For MLD, handle CQM change on all the active links */
+	for (link_id = 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS; link_id++) {
+		struct ieee80211_link_data *link =
+			sdata_dereference(sdata->link[link_id], sdata);
 
-	/* tell the driver upon association, unless already associated */
-	if (sdata->u.mgd.associated &&
-	    sdata->vif.driver_flags & IEEE80211_VIF_SUPPORTS_CQM_RSSI)
-		ieee80211_link_info_change_notify(sdata, &sdata->deflink,
-						  BSS_CHANGED_CQM);
+		ieee80211_set_cqm_rssi_link(sdata, link, 0, 0,
+					    rssi_low, rssi_high);
+	}
 
 	return 0;
 }
-- 
2.43.2


