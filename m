Return-Path: <linux-wireless+bounces-1010-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2DC818E69
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 18:42:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD1E31F28024
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 17:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D191374F8;
	Tue, 19 Dec 2023 17:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jrI+Dvm5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6B5374CF
	for <linux-wireless@vger.kernel.org>; Tue, 19 Dec 2023 17:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703007697; x=1734543697;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y4+ZwngCe8/Yl/qb+AcJihA0DSGKs71xiBwkRhfil2E=;
  b=jrI+Dvm5gftviPIXS/OyxWyqQWsr/KBKOJyIqfeSlC4Eg5A3XpNHrkCz
   LqzRqmcG4qlMQXvaaUHN/5Lz2WNxDTQcuB7nXqqunkk+jS6GipujBkCG3
   K9pTtE/h89L8Gkv5zbc34rGIvjwETDz9hTijr63Fi4q2p0yLb6PLBeenW
   mRjPxQJnF9Sp2B9xmy8Y5LvbvzkSG+VN8c8RLauR3fQ0Wx7TPl1UzaUO/
   mgjDGWzCMdSgZIQtn+rzkXCItYk9yN9oP9zPRb+tTCxU7yyQ7UYNwsdV4
   OtrYdn1X9KSbWNw2jBZ/5sZ9Rtv9F6kmNPFm2V1as80Ndt0/7Ba8CMyJz
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="2790511"
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="2790511"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 09:41:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="894370254"
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="894370254"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 09:41:34 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 09/13] wifi: cfg80211: ensure cfg80211_bss_update frees IEs on error
Date: Wed, 20 Dec 2023 13:41:42 +0200
Message-Id: <20231220133549.8e72ea105e17.Ic81e9431e980419360e97502ce8c75c58793f05a@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231220133549.bdfb8a9c7c54.I973563562969a27fea8ec5685b96a3a47afe142f@changeid>
References: <20231220133549.bdfb8a9c7c54.I973563562969a27fea8ec5685b96a3a47afe142f@changeid>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

cfg80211_bss_update is expected to consume the IEs that are passed into
it in the temporary internal BSS. This did not happen in some error
cases (which are also WARN_ON paths), so change the code to use a common
label and use that everywhere.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
v2: Fix wrong email addresses
---
 net/wireless/scan.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 68ba446067ac..f7fd7ea0e935 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -1818,15 +1818,15 @@ __cfg80211_bss_update(struct cfg80211_registered_device *rdev,
 		      bool signal_valid, unsigned long ts)
 {
 	struct cfg80211_internal_bss *found = NULL;
+	struct cfg80211_bss_ies *ies;
 
 	if (WARN_ON(!tmp->pub.channel))
-		return NULL;
+		goto free_ies;
 
 	tmp->ts = ts;
 
-	if (WARN_ON(!rcu_access_pointer(tmp->pub.ies))) {
-		return NULL;
-	}
+	if (WARN_ON(!rcu_access_pointer(tmp->pub.ies)))
+		goto free_ies;
 
 	found = rb_find_bss(rdev, tmp, BSS_CMP_REGULAR);
 
@@ -1836,7 +1836,6 @@ __cfg80211_bss_update(struct cfg80211_registered_device *rdev,
 	} else {
 		struct cfg80211_internal_bss *new;
 		struct cfg80211_internal_bss *hidden;
-		struct cfg80211_bss_ies *ies;
 
 		/*
 		 * create a copy -- the "res" variable that is passed in
@@ -1845,15 +1844,8 @@ __cfg80211_bss_update(struct cfg80211_registered_device *rdev,
 		 */
 		new = kzalloc(sizeof(*new) + rdev->wiphy.bss_priv_size,
 			      GFP_ATOMIC);
-		if (!new) {
-			ies = (void *)rcu_dereference(tmp->pub.beacon_ies);
-			if (ies)
-				kfree_rcu(ies, rcu_head);
-			ies = (void *)rcu_dereference(tmp->pub.proberesp_ies);
-			if (ies)
-				kfree_rcu(ies, rcu_head);
-			return NULL;
-		}
+		if (!new)
+			goto free_ies;
 		memcpy(new, tmp, sizeof(*new));
 		new->refcount = 1;
 		INIT_LIST_HEAD(&new->hidden_list);
@@ -1913,6 +1905,16 @@ __cfg80211_bss_update(struct cfg80211_registered_device *rdev,
 	bss_ref_get(rdev, found);
 
 	return found;
+
+free_ies:
+	ies = (void *)rcu_dereference(tmp->pub.beacon_ies);
+	if (ies)
+		kfree_rcu(ies, rcu_head);
+	ies = (void *)rcu_dereference(tmp->pub.proberesp_ies);
+	if (ies)
+		kfree_rcu(ies, rcu_head);
+
+	return NULL;
 }
 
 struct cfg80211_internal_bss *
-- 
2.34.1


