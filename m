Return-Path: <linux-wireless+bounces-23883-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A631AD25B4
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 20:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E92A516DE78
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 18:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF8821D3D1;
	Mon,  9 Jun 2025 18:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hSA1LaNf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B19621CFF4
	for <linux-wireless@vger.kernel.org>; Mon,  9 Jun 2025 18:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749494157; cv=none; b=JU+7eArvSibMVfMkF5TvxfC/sBLEJinJleD5Q1kTUIsr07x9VdKMy5HA1wx2jKQLWee0ONQ0MleKyKxr4Ap6wkp5iQJUqpLRN9GqWaFmlSN1YVp19JCTS5WpazzNjGqhT4/n4cK73b1f3IyTfilJFPQb3wEP6+Y7Trh3zKSyyJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749494157; c=relaxed/simple;
	bh=UoBf2MhvVLhqdR9ixWddMcMAN8EQnpSBRgdmBVzbsmY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tH7eEthGkNz4pypRE+Oiuw5SRPgXhWJgF0dUC91MxPEN5nFVcHLRzmsRYapqFu63NTsLWmHhqr2VLkgqGvxWRv+uCkTY3WDiQQHglQPS8CdFrHSYT6TIVfJKZ2wLwbw+aKX7erDuJypxNWBBtM7V+ygxpfGhaBSokRvJLRTXKQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hSA1LaNf; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749494155; x=1781030155;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UoBf2MhvVLhqdR9ixWddMcMAN8EQnpSBRgdmBVzbsmY=;
  b=hSA1LaNfKVoYT0x92IxILSyPk6k7ovF5zsQo5/x00zgxP1osq919vLHS
   c9uevzXkJ/9bwmG8zsU9mA7kXuiYQYYRMeN/r113N+iWXrH9xyrOD3R7+
   klozgFAyV3wZpMqMDOV3Yz8k1uhmWfdquKaIPsBOTQarzZOJDXvQx1Js1
   dJnrnzg7LTYIcWLfLqEC/IXSAOY4th7tmw6uo/JCjpX35w8eISIptYBML
   G0PMgxOF4k/gK5vhGMMcnxb33m8of9dB0opeegNn5Xl7fg5rF7ueX/1TP
   nbJNeZaNf6NDPpyzILi9fftpjgHJKBEP2YiI1n5MO9EyQHAVNKrMBcP9J
   Q==;
X-CSE-ConnectionGUID: XYReZ64VQMaoDFR/98+mfg==
X-CSE-MsgGUID: 3/M0N5t4Tu6sYeHRqve6YA==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="55249767"
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="55249767"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 11:35:54 -0700
X-CSE-ConnectionGUID: SrbZEkDQSTCWPzZ6zHGudw==
X-CSE-MsgGUID: 8Vz5pnLTT3eNr+ObeNcSaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="151732498"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 11:35:54 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 08/15] wifi: nl80211: make nl80211_check_scan_flags() type safe
Date: Mon,  9 Jun 2025 21:35:20 +0300
Message-Id: <20250609213231.bdb3c96570b0.Ia153e6ce06dc9a636ff5bcc1d52468a1afd06e13@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250609183527.3974138-1-miriam.rachel.korenblit@intel.com>
References: <20250609183527.3974138-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

The cast from void * here coupled with the boolean argument
on what to cast to is confusing and really not needed, just
split the code and make a type-safe interface. It seems to
even reduce the code size slightly, at least on x86-64.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/wireless/nl80211.c | 55 +++++++++++++++++++++---------------------
 1 file changed, 28 insertions(+), 27 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 42774c02a18f..4d6332c71dfd 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -9296,34 +9296,12 @@ static bool nl80211_check_scan_feat(struct wiphy *wiphy, u32 flags, u32 flag,
 
 static int
 nl80211_check_scan_flags(struct wiphy *wiphy, struct wireless_dev *wdev,
-			 void *request, struct nlattr **attrs,
-			 bool is_sched_scan)
+			 struct nlattr **attrs, u8 *mac_addr, u8 *mac_addr_mask,
+			 u32 *flags, enum nl80211_feature_flags randomness_flag)
 {
-	u8 *mac_addr, *mac_addr_mask;
-	u32 *flags;
-	enum nl80211_feature_flags randomness_flag;
-
 	if (!attrs[NL80211_ATTR_SCAN_FLAGS])
 		return 0;
 
-	if (is_sched_scan) {
-		struct cfg80211_sched_scan_request *req = request;
-
-		randomness_flag = wdev ?
-				  NL80211_FEATURE_SCHED_SCAN_RANDOM_MAC_ADDR :
-				  NL80211_FEATURE_ND_RANDOM_MAC_ADDR;
-		flags = &req->flags;
-		mac_addr = req->mac_addr;
-		mac_addr_mask = req->mac_addr_mask;
-	} else {
-		struct cfg80211_scan_request_int *req = request;
-
-		randomness_flag = NL80211_FEATURE_SCAN_RANDOM_MAC_ADDR;
-		flags = &req->req.flags;
-		mac_addr = req->req.mac_addr;
-		mac_addr_mask = req->req.mac_addr_mask;
-	}
-
 	*flags = nla_get_u32(attrs[NL80211_ATTR_SCAN_FLAGS]);
 
 	if (((*flags & NL80211_SCAN_FLAG_LOW_PRIORITY) &&
@@ -9372,6 +9350,30 @@ nl80211_check_scan_flags(struct wiphy *wiphy, struct wireless_dev *wdev,
 	return 0;
 }
 
+static int
+nl80211_check_scan_flags_sched(struct wiphy *wiphy, struct wireless_dev *wdev,
+			       struct nlattr **attrs,
+			       struct cfg80211_sched_scan_request *req)
+{
+	return nl80211_check_scan_flags(wiphy, wdev, attrs,
+					req->mac_addr, req->mac_addr_mask,
+					&req->flags,
+					wdev ? NL80211_FEATURE_SCHED_SCAN_RANDOM_MAC_ADDR :
+					       NL80211_FEATURE_ND_RANDOM_MAC_ADDR);
+}
+
+static int
+nl80211_check_scan_flags_reg(struct wiphy *wiphy, struct wireless_dev *wdev,
+			     struct nlattr **attrs,
+			     struct cfg80211_scan_request_int *req)
+{
+	return nl80211_check_scan_flags(wiphy, wdev, attrs,
+					req->req.mac_addr,
+					req->req.mac_addr_mask,
+					&req->req.flags,
+					NL80211_FEATURE_SCAN_RANDOM_MAC_ADDR);
+}
+
 static int nl80211_trigger_scan(struct sk_buff *skb, struct genl_info *info)
 {
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
@@ -9568,8 +9570,7 @@ static int nl80211_trigger_scan(struct sk_buff *skb, struct genl_info *info)
 			nla_get_flag(info->attrs[NL80211_ATTR_MEASUREMENT_DURATION_MANDATORY]);
 	}
 
-	err = nl80211_check_scan_flags(wiphy, wdev, request, info->attrs,
-				       false);
+	err = nl80211_check_scan_flags_reg(wiphy, wdev, info->attrs, request);
 	if (err)
 		goto out_free;
 
@@ -10022,7 +10023,7 @@ nl80211_parse_sched_scan(struct wiphy *wiphy, struct wireless_dev *wdev,
 		       request->ie_len);
 	}
 
-	err = nl80211_check_scan_flags(wiphy, wdev, request, attrs, true);
+	err = nl80211_check_scan_flags_sched(wiphy, wdev, attrs, request);
 	if (err)
 		goto out_free;
 
-- 
2.34.1


