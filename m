Return-Path: <linux-wireless+bounces-19885-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B6FA54838
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 11:44:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7427B3AD023
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 10:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160AF20AF66;
	Thu,  6 Mar 2025 10:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y/Kgr9I2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770A12040BF
	for <linux-wireless@vger.kernel.org>; Thu,  6 Mar 2025 10:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741257834; cv=none; b=Gq4Y7/3MkA151D/HbtHxaoPKjJaDXBwRi2GVw9zCYxwUkAqwF4cX8R8KA/ycfeMwIYfQLwfSZHqOyY3mJD/c4fw1Mkh7/lODTyEsljDnn83wqYn9FXhJ4+LVJpysTHF17M/TOoE00y7LJHZN7lXdycRgXx+S0KD8XlknT1YEYwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741257834; c=relaxed/simple;
	bh=sqxI0dgpV6+w2QdV7mpm91T6PuW4AuPZjwLURYkgsFg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oaOaHurEmTWVDQ0j1D/wAenB255cfGHjMnfnrqhra6Wk10kWolC4CU9GIMW3Zij3FvzQ4RaCD5vZtwG6uJQM1Qxfx+9ZgYqYh20eTPGI4AAECZNdjO2NNAxgqprruOyl4xmwes4/w19OcL0miHRCf1rx+1+7uCsZhawXh/lKinE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y/Kgr9I2; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741257833; x=1772793833;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sqxI0dgpV6+w2QdV7mpm91T6PuW4AuPZjwLURYkgsFg=;
  b=Y/Kgr9I2WiwIvZvNIt98sOaMxLUPhRUsZBz9PKZx5DyrWQrJJjuaVccy
   VMbqfv+ok3P52FGhmzIYaHnO7BIOsJkMp6JC9Wy4hR3kOQ+IsaeqoRjCm
   3nNHQpi4LSNHRr9kfTqG6jLXAaAA6vKAPpFvG2DAN58JJ7C8dbpKLPq/i
   eakqmex2zXOlJ194l5+gs5NE2+J7YJyqT7ONiqQ2q20gtp7XZu62HQtXW
   WYERvlYnzfXnb/YpKqPoThtRWnm6o25LNVSN/z1ZBtD2EX+O7QsOg6Mtu
   3efSL9W1qCdnvygpbjqUyMaYHJyBlwyzVuoUtt2q02eCe+O6fALYfl26P
   Q==;
X-CSE-ConnectionGUID: ur21nWv7SnWrFJgzCy5Jcw==
X-CSE-MsgGUID: 0YKjaoMGQVuuL3Acb0eCZw==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="29844494"
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="29844494"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 02:43:53 -0800
X-CSE-ConnectionGUID: cx3k//ySQgipcmay2qZgWw==
X-CSE-MsgGUID: seHUjJ87SUyGgV1nC5PCsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="118797758"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 02:43:51 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH wireless-next 09/15] wifi: mac80211: fix userspace_selectors corruption
Date: Thu,  6 Mar 2025 12:43:20 +0200
Message-Id: <20250306124057.499f9762afc1.Ibeb8970c82a30c97279a4cc4e68faca5df1813a5@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306104326.4105722-1-miriam.rachel.korenblit@intel.com>
References: <20250306104326.4105722-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Spotted during code review, the selectors need to be large
enough for a 128-bit bitmap, not a single unsigned long,
otherwise we have stack corruption.

We should also allow passing selectors from userspace, but
that should be a separate change.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/mlme.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 426c0246fe1f..85ae66197674 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -9914,8 +9914,6 @@ EXPORT_SYMBOL(ieee80211_disable_rssi_reports);
 
 static void ieee80211_ml_reconf_selectors(unsigned long *userspace_selectors)
 {
-	*userspace_selectors = 0;
-
 	/* these selectors are mandatory for ML reconfiguration */
 	set_bit(BSS_MEMBERSHIP_SELECTOR_SAE_H2E, userspace_selectors);
 	set_bit(BSS_MEMBERSHIP_SELECTOR_HE_PHY, userspace_selectors);
@@ -9935,7 +9933,7 @@ void ieee80211_process_ml_reconf_resp(struct ieee80211_sub_if_data *sdata,
 		                sdata->u.mgd.reconf.removed_links;
 	u16 link_mask, valid_links;
 	unsigned int link_id;
-	unsigned long userspace_selectors;
+	unsigned long userspace_selectors[BITS_TO_LONGS(128)] = {};
 	size_t orig_len = len;
 	u8 i, group_key_data_len;
 	u8 *pos;
@@ -10043,7 +10041,7 @@ void ieee80211_process_ml_reconf_resp(struct ieee80211_sub_if_data *sdata,
 	}
 
 	ieee80211_vif_set_links(sdata, valid_links, sdata->vif.dormant_links);
-	ieee80211_ml_reconf_selectors(&userspace_selectors);
+	ieee80211_ml_reconf_selectors(userspace_selectors);
 	link_mask = 0;
 	for (link_id = 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS; link_id++) {
 		struct cfg80211_bss *cbss = add_links_data->link[link_id].bss;
@@ -10089,7 +10087,7 @@ void ieee80211_process_ml_reconf_resp(struct ieee80211_sub_if_data *sdata,
 		link->u.mgd.conn = add_links_data->link[link_id].conn;
 		if (ieee80211_prep_channel(sdata, link, link_id, cbss,
 					   true, &link->u.mgd.conn,
-					   &userspace_selectors)) {
+					   userspace_selectors)) {
 			link_info(link, "mlo: reconf: prep_channel failed\n");
 			goto disconnect;
 		}
@@ -10427,14 +10425,14 @@ int ieee80211_mgd_assoc_ml_reconf(struct ieee80211_sub_if_data *sdata,
 	 */
 	if (added_links) {
 		bool uapsd_supported;
-		unsigned long userspace_selectors;
+		unsigned long userspace_selectors[BITS_TO_LONGS(128)] = {};
 
 		data = kzalloc(sizeof(*data), GFP_KERNEL);
 		if (!data)
 			return -ENOMEM;
 
 		uapsd_supported = true;
-		ieee80211_ml_reconf_selectors(&userspace_selectors);
+		ieee80211_ml_reconf_selectors(userspace_selectors);
 		for (link_id = 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS;
 		     link_id++) {
 			struct ieee80211_supported_band *sband;
@@ -10510,7 +10508,7 @@ int ieee80211_mgd_assoc_ml_reconf(struct ieee80211_sub_if_data *sdata,
 						     data->link[link_id].bss,
 						     true,
 						     &data->link[link_id].conn,
-						     &userspace_selectors);
+						     userspace_selectors);
 			if (err)
 				goto err_free;
 		}
-- 
2.34.1


