Return-Path: <linux-wireless+bounces-973-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3483B81838F
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 09:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7F7928629B
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 08:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B6812E73;
	Tue, 19 Dec 2023 08:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a6O7Ekss"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DD712E44
	for <linux-wireless@vger.kernel.org>; Tue, 19 Dec 2023 08:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702975084; x=1734511084;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1rXtI6u2EtFMNF2d9Bxnv6gFUJIDf/cxc3U0rvomffc=;
  b=a6O7EkssqwTgNQ29qtMqPUEEXyR5MM3MJF/ezVZJugFbYjYr1IeRsTsI
   wuRcQl/XFoR5/ne1T11GMROYsS8OmgwJ3StRPjXCaanjKZ/dZeU1yQpc0
   Zzzte+auqMZODNh/LBilvCYoPdu76Fiug8Q69/lpbFJyt8j0BjsSTS0QK
   /OFB0jI5WS1B3ZPyROTg7ASCMngEw4+UvrYxe4IiBo+D2a3Dgqo28e2xM
   ERMVArGZQzEDzZ4rL6G7+LOMRcnUpaY5SFvOUdD53+/q6x1obkS6UR2N2
   KOo74h/iwczpEwL6h8j3yN9crNzOKbPxC8NM/KiL9lpMAreZYuiYBggEx
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="459969226"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="459969226"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 00:38:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="846266432"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="846266432"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 00:38:02 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>, Berg@web.codeaurora.org,
	Johannes <johannes.berg@intel.com>
Subject: [PATCH 09/15] wifi: cfg80211: ensure cfg80211_bss_update frees IEs on error
Date: Wed, 20 Dec 2023 04:37:57 +0200
Message-Id: <20231220043149.0570115ecda0.Ic81e9431e980419360e97502ce8c75c58793f05a@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231220023803.2901117-1-miriam.rachel.korenblit@intel.com>
References: <20231220023803.2901117-1-miriam.rachel.korenblit@intel.com>
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
Reviewed-by: Berg, Johannes <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
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


