Return-Path: <linux-wireless+bounces-19872-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 882C5A54801
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 11:39:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC31718953BF
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 10:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BFFB2040B3;
	Thu,  6 Mar 2025 10:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Eq2YHqNI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EF5209F57
	for <linux-wireless@vger.kernel.org>; Thu,  6 Mar 2025 10:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741257499; cv=none; b=Kyw8mf1WWz8hP1doQvmGg/vyBfYoL41ar3Cn5wgFRnFcmNrqeVRvkptYwYyuquagqQhR4oEvaSs4DJRhkRECtB97S219Qdm69gb4tsLyug6Q27DZWEUFN+1pTbO5lG7Mf74LBKQMiq2Q7dnGcBNgMt5zFUz58AisQNXLGF/r8OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741257499; c=relaxed/simple;
	bh=+IyaAiQko7O6fIX11o38VosR2w0paHLTBkTyiRr5jCM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jFb917zSrXLdAKGm/BW7euCP9peHrTKggTsu/ZMNvi0QCAtSXbKl4u2GiZUN2eUzSZquvdTpRU0Af39JcInKDjGx6d6NVXyO7Q+MYzXupP5vIZjwzlrJcDB3on+7haQ/7m6R0F5/fcAnA1shQY378LN73uWGXICeT206pFgn5LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Eq2YHqNI; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741257498; x=1772793498;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+IyaAiQko7O6fIX11o38VosR2w0paHLTBkTyiRr5jCM=;
  b=Eq2YHqNISiY8En8vNQB8p+pf3iEqPH4P3je4tOtdxlXG8t4Z74cUNZML
   dgLSKePs0oxObkRFEw+wjFNsWMEKttWyKvSv6icfMlSnxYk2J6F3cMSQ4
   kNbJGEs95DF75/ov5mxTBNMUjlpZOQ4NJHxRiQdwfUdnY01DQGOK2CbED
   HkU/JO/kX6cC8nx47tvDM/9QvXJFXfaqTCxTWJaSKkMCuuoxirc9jFpnP
   J6mk1OsuiRBb0h/yvwo0LbiUybfjQkz3EWk8oVh4JduKdeDnYFi+A6nos
   KbwqO9ZqnZOkHSAIR3FKCZ3kTacMUec/GKbz1PUOR+47m0VEJjjhccffZ
   A==;
X-CSE-ConnectionGUID: C2l0IM4JQE+Hyiv+Y+Fz1A==
X-CSE-MsgGUID: Nygh2t+YT6uR1XqhEmQUFQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="45915025"
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="45915025"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 02:38:16 -0800
X-CSE-ConnectionGUID: wV0EDDhUSmyUM0DWigfooA==
X-CSE-MsgGUID: OXZjQw5ASU2qQ3v61eLNWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="123138383"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 02:38:14 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH v2 wireless 3/5] wifi: nl80211: fix assoc link handling
Date: Thu,  6 Mar 2025 12:37:57 +0200
Message-Id: <20250306123626.7b233d769c32.I62fd04a8667dd55cedb9a1c0414cc92dd098da75@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306103759.4102293-1-miriam.rachel.korenblit@intel.com>
References: <20250306103759.4102293-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

The refactoring of the assoc link handling in order to
support multi-link reconfiguration broke the setting
of the assoc link ID, and thus resulted in the wrong
BSS "use_for" value being selected. Fix that for both
association and ML reconfiguration.

Fixes: 720fa448f5a7 ("wifi: nl80211: Split the links handling of an association request")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/wireless/nl80211.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index e87267fbb442..aac0e7298dc7 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -11123,6 +11123,7 @@ static struct cfg80211_bss *nl80211_assoc_bss(struct cfg80211_registered_device
 
 static int nl80211_process_links(struct cfg80211_registered_device *rdev,
 				 struct cfg80211_assoc_link *links,
+				 int assoc_link_id,
 				 const u8 *ssid, int ssid_len,
 				 struct genl_info *info)
 {
@@ -11153,7 +11154,7 @@ static int nl80211_process_links(struct cfg80211_registered_device *rdev,
 		}
 		links[link_id].bss =
 			nl80211_assoc_bss(rdev, ssid, ssid_len, attrs,
-					  link_id, link_id);
+					  assoc_link_id, link_id);
 		if (IS_ERR(links[link_id].bss)) {
 			err = PTR_ERR(links[link_id].bss);
 			links[link_id].bss = NULL;
@@ -11350,8 +11351,8 @@ static int nl80211_associate(struct sk_buff *skb, struct genl_info *info)
 		req.ap_mld_addr = nla_data(info->attrs[NL80211_ATTR_MLD_ADDR]);
 		ap_addr = req.ap_mld_addr;
 
-		err = nl80211_process_links(rdev, req.links, ssid, ssid_len,
-					    info);
+		err = nl80211_process_links(rdev, req.links, req.link_id,
+					    ssid, ssid_len, info);
 		if (err)
 			goto free;
 
@@ -16506,7 +16507,10 @@ static int nl80211_assoc_ml_reconf(struct sk_buff *skb, struct genl_info *info)
 
 	add_links = 0;
 	if (info->attrs[NL80211_ATTR_MLO_LINKS]) {
-		err = nl80211_process_links(rdev, links, NULL, 0, info);
+		err = nl80211_process_links(rdev, links,
+					    /* mark as MLO, but not assoc */
+					    IEEE80211_MLD_MAX_NUM_LINKS,
+					    NULL, 0, info);
 		if (err)
 			return err;
 
-- 
2.34.1


