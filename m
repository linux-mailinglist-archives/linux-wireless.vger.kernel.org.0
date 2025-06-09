Return-Path: <linux-wireless+bounces-23886-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 848C6AD25B7
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 20:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 694A23B1B02
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 18:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7FD21D594;
	Mon,  9 Jun 2025 18:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VHqS8owP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F136821FF26
	for <linux-wireless@vger.kernel.org>; Mon,  9 Jun 2025 18:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749494160; cv=none; b=TiyrgTLF7OIREIShqDDMS3Bue341a5U1X/V4ZGRPlYZfrnQNjKx8XMxmY6bY9JP0uGnkQGnFDeZbwNBF9YEe09TEqFLW6vdkRVudpHWfTno0ZASdY1iEIhlHCRafDIbvoWi7/Rj1GBb2mPkUBYrFxgn46hvYaZ+7dUQhm3PBx5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749494160; c=relaxed/simple;
	bh=p/7x9QwNcLwNm6DQGNCRCPtP/877o6LDlZW/oqsZl4E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KHuaj2e7FQbwnfgi2pR/FIys557ftz+Ki95TaMHhNQ9EwTpJgqNdBI3nUqiSkE7umeU/ynD99ZjpUnPEEJucTPb88O4J4Lb7KwMH7D5BmbVUkaVp7qNLdeRPYbZlHBN5U+NWQgtNrRlksal8nlx7O8/dobs4R3V7+vqh5MREgAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VHqS8owP; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749494159; x=1781030159;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p/7x9QwNcLwNm6DQGNCRCPtP/877o6LDlZW/oqsZl4E=;
  b=VHqS8owPkt4VSjH+Y6QogDcKREnuGXj74m49tJHElsuy9vrljjRfTUgA
   AaM0CshJyfIoKDlpnK7E1m1amFXM0QP4LXhZsJmjilp6Eww9+aTjOIE6A
   aaiaGFN87DOKKXd1+e+smNP+aeutwaz/lOF6eW/5Og4Mz0Clkw2b+yjjl
   PN57HE847VtgChLWRX3Y1ufOc2K67CVBJMT/KyawIVkyCw2RIROKfhEur
   0SmC7+IDSO9U4ioCKbUEe9jikNTMr6Eo8pI7h7QjLb17zx9Idy8ARGuCL
   VYx4dwuGp77tKQp0SGa93kc+t7q4KSIj1c4EkMGrArjkGSOjZ7VuEXnsA
   Q==;
X-CSE-ConnectionGUID: N1IxbzyETVS05+JG4ktE/Q==
X-CSE-MsgGUID: ghx6HLcpSbWJ2AVsiT9yvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="55249773"
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="55249773"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 11:35:58 -0700
X-CSE-ConnectionGUID: LT1WtxZST2SGm+Yldzc37g==
X-CSE-MsgGUID: DCPygbbBSPCApYqHmlbFzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="151732530"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 11:35:57 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 11/15] wifi: cfg80211: add a flag for the first part of a scan
Date: Mon,  9 Jun 2025 21:35:23 +0300
Message-Id: <20250609213231.07e5a8a452ec.Ibf18f513e507422078fb31b28947e582a20df87a@changeid>
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

From: Benjamin Berg <benjamin.berg@intel.com>

When there are no non-6 GHz channels, then the 6 GHz scan is the first
part of a split scan. Add a boolean denoting whether the scan is the
first part of a scan as it might be useful to drivers for internal
bookkeeping. This flag is also set if the scan is not split.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/net/cfg80211.h |  6 +++++-
 net/wireless/scan.c    | 15 ++++++++++-----
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 07368dd9a212..f61f0a4e40f3 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -2651,7 +2651,10 @@ struct cfg80211_scan_6ghz_params {
  *	are 0 in the mask should be randomised, bits that are 1 should
  *	be taken from the @mac_addr
  * @scan_6ghz: relevant for split scan request only,
- *	true if this is the second scan request
+ *	true if this is a 6 GHz scan request
+ * @first_part: %true if this is the first part of a split scan request or a
+ *	scan that was not split. May be %true for a @scan_6ghz scan if no other
+ *	channels were requested
  * @n_6ghz_params: number of 6 GHz params
  * @scan_6ghz_params: 6 GHz params
  * @bssid: BSSID to scan for (most commonly, the wildcard BSSID)
@@ -2679,6 +2682,7 @@ struct cfg80211_scan_request {
 	unsigned long scan_start;
 	bool no_cck;
 	bool scan_6ghz;
+	bool first_part;
 	u32 n_6ghz_params;
 	struct cfg80211_scan_6ghz_params *scan_6ghz_params;
 	s8 tsf_report_link_id;
diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index d12ece068c10..6143be6bbd5e 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -838,7 +838,8 @@ static bool cfg80211_find_ssid_match(struct cfg80211_colocated_ap *ap,
 	return false;
 }
 
-static int cfg80211_scan_6ghz(struct cfg80211_registered_device *rdev)
+static int cfg80211_scan_6ghz(struct cfg80211_registered_device *rdev,
+			      bool first_part)
 {
 	u8 i;
 	struct cfg80211_colocated_ap *ap;
@@ -850,6 +851,7 @@ static int cfg80211_scan_6ghz(struct cfg80211_registered_device *rdev)
 	size_t size, offs_ssids, offs_6ghz_params, offs_ies;
 
 	rdev_req->req.scan_6ghz = true;
+	rdev_req->req.first_part = first_part;
 
 	if (!rdev->wiphy.bands[NL80211_BAND_6GHZ])
 		return -EOPNOTSUPP;
@@ -1046,7 +1048,7 @@ static int cfg80211_scan_6ghz(struct cfg80211_registered_device *rdev)
 		 * If this scan follows a previous scan, save the scan start
 		 * info from the first part of the scan
 		 */
-		if (old)
+		if (!first_part && !WARN_ON(!old))
 			rdev->int_scan_req->info = old->info;
 
 		err = rdev_scan(rdev, request);
@@ -1070,8 +1072,10 @@ int cfg80211_scan(struct cfg80211_registered_device *rdev)
 	struct cfg80211_scan_request_int *rdev_req = rdev->scan_req;
 	u32 n_channels = 0, idx, i;
 
-	if (!(rdev->wiphy.flags & WIPHY_FLAG_SPLIT_SCAN_6GHZ))
+	if (!(rdev->wiphy.flags & WIPHY_FLAG_SPLIT_SCAN_6GHZ)) {
+		rdev_req->req.first_part = true;
 		return rdev_scan(rdev, rdev_req);
+	}
 
 	for (i = 0; i < rdev_req->req.n_channels; i++) {
 		if (rdev_req->req.channels[i]->band != NL80211_BAND_6GHZ)
@@ -1079,7 +1083,7 @@ int cfg80211_scan(struct cfg80211_registered_device *rdev)
 	}
 
 	if (!n_channels)
-		return cfg80211_scan_6ghz(rdev);
+		return cfg80211_scan_6ghz(rdev, true);
 
 	request = kzalloc(struct_size(request, req.channels, n_channels),
 			  GFP_KERNEL);
@@ -1096,6 +1100,7 @@ int cfg80211_scan(struct cfg80211_registered_device *rdev)
 	}
 
 	rdev_req->req.scan_6ghz = false;
+	rdev_req->req.first_part = true;
 	rdev->int_scan_req = request;
 	return rdev_scan(rdev, request);
 }
@@ -1128,7 +1133,7 @@ void ___cfg80211_scan_done(struct cfg80211_registered_device *rdev,
 	if (wdev_running(wdev) &&
 	    (rdev->wiphy.flags & WIPHY_FLAG_SPLIT_SCAN_6GHZ) &&
 	    !rdev_req->req.scan_6ghz && !request->info.aborted &&
-	    !cfg80211_scan_6ghz(rdev))
+	    !cfg80211_scan_6ghz(rdev, false))
 		return;
 
 	/*
-- 
2.34.1


