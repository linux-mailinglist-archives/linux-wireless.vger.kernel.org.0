Return-Path: <linux-wireless+bounces-19858-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB5B2A54791
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 11:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1AB53A8F3E
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 10:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483A01D61A4;
	Thu,  6 Mar 2025 10:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X1GMaQ0g"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98787200BBD
	for <linux-wireless@vger.kernel.org>; Thu,  6 Mar 2025 10:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741256331; cv=none; b=GfhfUwt2MnywavgYrvRSj/NMWCNbMWjYRXur+7gv9WDXcAB9mvtNwwqaO+OUdfpL1NKOtl5j3G103KtAqhTfWG8wycuT9hTEP9ILfLblBY7q1J5jrA/Htm7ir49GqXRt+OvS4cqm7KgLzCxPYD6T36ehSXXbEUhZdPZgBA1qmUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741256331; c=relaxed/simple;
	bh=+IyaAiQko7O6fIX11o38VosR2w0paHLTBkTyiRr5jCM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=McWqhEnhd5w+QUThL638zflv7iOpadDaMSAVeOg8peM81uuRTy35UBM/aVm7ekrtaiy5c9adfRxLn9CDG4Ql0tOsA1SMpfxBqo23KqbKGk/oW+b/dGrXgjK0j6DB4YPBFckfP/qofs8VcgzHzq/HtSqG7KHT2etvsuvqRGukJsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X1GMaQ0g; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741256331; x=1772792331;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+IyaAiQko7O6fIX11o38VosR2w0paHLTBkTyiRr5jCM=;
  b=X1GMaQ0gvLcFzXafoamih+F34/awxefQDFH+GVhQy1FUklmw/70f+HAo
   X8izyjS7whfOt+3Xf60uJb93b2No+i1GRGVeQyIzhbqXFex6m8kDwTF8c
   llOBc4acfI5VpnPZBKVcwThsqugZwvzb7Bw61JJhSgvkGwmKtGH8hjOjK
   b0GWH/bdvPn2/8gYdR+hMnr0XY+kcq4lDfy9usLuoDCBA3okjGlY+nBv/
   tpKvCwGAGaxU8y1RdZuloB6aQK3WGOuvbmHsS4oG9CQukj9AhYVZmxym6
   zNG1y/ALE7Hm0aaRtcqas0IrJiRMDkFY4oE9HD/b5Q2+JydBVLnuCfIoW
   A==;
X-CSE-ConnectionGUID: 47leLAguQn+p/v67mkmMKg==
X-CSE-MsgGUID: qqUzbwzYTw23dGIAYHATAg==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="46181373"
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="46181373"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 02:18:50 -0800
X-CSE-ConnectionGUID: VDWmSx/YRxeL+ObAn3MAhw==
X-CSE-MsgGUID: zFt+1tUSQSGPp0GBinJfuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="118705717"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 02:18:47 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH 3/5] wifi: nl80211: fix assoc link handling
Date: Thu,  6 Mar 2025 12:18:29 +0200
Message-Id: <20250306121409.7b233d769c32.I62fd04a8667dd55cedb9a1c0414cc92dd098da75@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306101831.4042303-1-miriam.rachel.korenblit@intel.com>
References: <20250306101831.4042303-1-miriam.rachel.korenblit@intel.com>
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


