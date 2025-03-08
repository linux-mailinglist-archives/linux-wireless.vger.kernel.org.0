Return-Path: <linux-wireless+bounces-20038-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0373AA57E5E
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 22:07:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B129188D761
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 21:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB851EB5F9;
	Sat,  8 Mar 2025 21:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dUQ1g3Bq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2E71A5BBD
	for <linux-wireless@vger.kernel.org>; Sat,  8 Mar 2025 21:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741468022; cv=none; b=YuTHlzh24Zw5L+sz5wSIXK2AwKzzftL8L3ICLsW3fBJYEViHy3+pH0/HCfJihBwJbd6glIlQ4bT/cQuBG07FjUjdxrizGEIn0CeGSueCg/FVIQEuc+UGxLZLnCIe5e+Ob6bqmp3wJVOuliQVtXk+4uIv0vzjsIqJ7gXKudkxmTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741468022; c=relaxed/simple;
	bh=sqxI0dgpV6+w2QdV7mpm91T6PuW4AuPZjwLURYkgsFg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p7is2aTq5TuxCDA26ucI7SuAw00bAbC6chgXK91vXmuFXViqGOA58jCqXpcaXXnrrE1tL/1ZN4VoOvz8TuK/46ryCDYgcV4sK1qOUb4vyeH50qxoSNzmfyY6D8YRECRFYPYO8Xl8/S40iPpB2q2YHxToSuvGMpktIgcB8smiPvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dUQ1g3Bq; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741468021; x=1773004021;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sqxI0dgpV6+w2QdV7mpm91T6PuW4AuPZjwLURYkgsFg=;
  b=dUQ1g3Bqpd0TOODiqSzXPmhs8W3j+EMC+IeBP9pV/Q8gsgEuF1/IyBqM
   wRjB/X0DewJmztM+t4OPnT3gFog9x3gfWsHgP6EXNuhhmM+dBDcc2IVDE
   z08f8Ac3MnNA9qPf/udeNgjtWcrD7ejV21RwA55vRpr0kq+Cnjo8jjz4P
   LiWUSg3yoKDCB1M2lAdwDamCMeUBmwyyfEtbnfattK3Ok6gee5Ry7nAKM
   4vMGlHnEQkOGv+UG+EhHDnIQF/4CVZ4MPWCv9VpsF3wkCE0ODnrb0Bxym
   S3LND6lnXNuWQUtLN9JqgBlcO61gex6sHYHdyibVdUG3yMzYXfGHiq1QL
   w==;
X-CSE-ConnectionGUID: WDhPd9gRSwa4HQY3vkoZYg==
X-CSE-MsgGUID: iF24ati7Q4a7Eiby5abPsg==
X-IronPort-AV: E=McAfee;i="6700,10204,11367"; a="42413089"
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="42413089"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 13:04:08 -0800
X-CSE-ConnectionGUID: cdySxXwiTHa2FnVUpzE7kg==
X-CSE-MsgGUID: POqNln0vQrWilake+CO0Eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="124644400"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 13:04:06 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH RESEND wireless-next 09/15] wifi: mac80211: fix userspace_selectors corruption
Date: Sat,  8 Mar 2025 23:03:35 +0200
Message-Id: <20250308225541.8f1bcf96a504.Ibeb8970c82a30c97279a4cc4e68faca5df1813a5@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250308210341.2302222-1-miriam.rachel.korenblit@intel.com>
References: <20250308210341.2302222-1-miriam.rachel.korenblit@intel.com>
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


