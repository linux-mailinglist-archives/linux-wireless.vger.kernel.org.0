Return-Path: <linux-wireless+bounces-9166-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 805D190CC7F
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 14:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABE2F284D1E
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 12:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546C8177980;
	Tue, 18 Jun 2024 12:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P+uaTHnG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E96176FBD;
	Tue, 18 Jun 2024 12:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714338; cv=none; b=D0ACzvXVFVE9kFd7VjNDbFolos+w7k8szQuzoBrllIbhIhHBoTsMvcbCK1qSktAva3wAWYTMXOHyNaPtz4BOiRIVY+VVay/VMDwROv63V8oTPyEMYU7/Nas2gJk8VVNxrh3iLcieyD9k/eY+eAaLwkcx4Gj+vtOj8IxDYM5+IOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714338; c=relaxed/simple;
	bh=yCCeV+PRmlQFDEIJr/Gs/4huy2Hircq6qqPgCWYBxSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VcoDAaNBWWBMulBSHbiHHNV98u3v+cQsPZOTFgepQrKiWfJMZI2Ad1AufsvmHS6C/OAJhxcMNUlaxpkdpGbDHCQJOG6cGUc1Nt8CXQCIs2N8qpMqQg0dSW6NObktli8rNlUrCbHOUC0JenbbV9/f+UdbHLjt1w3OytU7Kv9GqPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P+uaTHnG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8198C4AF50;
	Tue, 18 Jun 2024 12:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718714338;
	bh=yCCeV+PRmlQFDEIJr/Gs/4huy2Hircq6qqPgCWYBxSs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P+uaTHnGWRJ+h8yDblV+qRHU1gQ3CvOilEblSSkfeZ0tpV6pjy0FCLCh18BI/eXsc
	 JPTMhIK+gSqwgc3bpN7dF9lc9OFt+KghqD2VDYt35XIf6m2GR/n20e+gRz6b7ZL8m9
	 W1jTOYWwKaDUb4/qRZcgkuWSh1NkabFQfhZk3h//8zvKxhSd6YE7+eTolofNisVjKA
	 nU9B7zkdwdCnQopfUcM4e94DaOAoIHBCuExAhVirqEqRHuSlLuH1IRQiXG0+ILDE5f
	 SBQWYqoNDI4Cr3+0VAJrMIXPAuPzTOUWiej6oiwHWWSY2ITFyfeySLSRlBKrtSY0MX
	 55ej6SCvSrIyA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Ilan Peer <ilan.peer@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 14/35] wifi: cfg80211: fix 6 GHz scan request building
Date: Tue, 18 Jun 2024 08:37:34 -0400
Message-ID: <20240618123831.3302346-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240618123831.3302346-1-sashal@kernel.org>
References: <20240618123831.3302346-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.34
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit f7a8b10bfd614d7a9a16fbe80d28ead4f063cb00 ]

The 6 GHz scan request struct allocated by cfg80211_scan_6ghz() is
meant to be formed this way:

 [base struct][channels][ssids][6ghz_params]

It is allocated with [channels] as the maximum number of channels
supported by the driver in the 6 GHz band, since allocation is
before knowing how many there will be.

However, the inner pointers are set incorrectly: initially, the
6 GHz scan parameters pointer is set:

 [base struct][channels]
                        ^ scan_6ghz_params

and later the SSID pointer is set to the end of the actually
_used_ channels.

 [base struct][channels]
                  ^ ssids

If many APs were to be discovered, and many channels used, and
there were many SSIDs, then the SSIDs could overlap the 6 GHz
parameters.

Additionally, the request->ssids for most of the function points
to the original request still (given the struct copy) but is used
normally, which is confusing.

Clear this up, by actually using the allocated space for 6 GHz
parameters _after_ the SSIDs, and set up the SSIDs initially so
they are used more clearly. Just like in nl80211.c, set them
only if there actually are SSIDs though.

Finally, also copy the elements (ie/ie_len) so they're part of
the same request, not pointing to the old request.

Co-developed-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Link: https://msgid.link/20240510113738.4190692ef4ee.I0cb19188be17a8abd029805e3373c0a7777c214c@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/wireless/rdev-ops.h |  6 +++++-
 net/wireless/scan.c     | 47 +++++++++++++++++++++++++++--------------
 2 files changed, 36 insertions(+), 17 deletions(-)

diff --git a/net/wireless/rdev-ops.h b/net/wireless/rdev-ops.h
index 90bb7ac4b930b..f8f114a8dc02a 100644
--- a/net/wireless/rdev-ops.h
+++ b/net/wireless/rdev-ops.h
@@ -2,7 +2,7 @@
 /*
  * Portions of this file
  * Copyright(c) 2016-2017 Intel Deutschland GmbH
- * Copyright (C) 2018, 2021-2023 Intel Corporation
+ * Copyright (C) 2018, 2021-2024 Intel Corporation
  */
 #ifndef __CFG80211_RDEV_OPS
 #define __CFG80211_RDEV_OPS
@@ -458,6 +458,10 @@ static inline int rdev_scan(struct cfg80211_registered_device *rdev,
 			    struct cfg80211_scan_request *request)
 {
 	int ret;
+
+	if (WARN_ON_ONCE(!request->n_ssids && request->ssids))
+		return -EINVAL;
+
 	trace_rdev_scan(&rdev->wiphy, request);
 	ret = rdev->ops->scan(&rdev->wiphy, request);
 	trace_rdev_return_int(&rdev->wiphy, ret);
diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index c646094a5fc47..ab559ff0909a2 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -810,6 +810,7 @@ static int cfg80211_scan_6ghz(struct cfg80211_registered_device *rdev)
 	LIST_HEAD(coloc_ap_list);
 	bool need_scan_psc = true;
 	const struct ieee80211_sband_iftype_data *iftd;
+	size_t size, offs_ssids, offs_6ghz_params, offs_ies;
 
 	rdev_req->scan_6ghz = true;
 
@@ -838,10 +839,15 @@ static int cfg80211_scan_6ghz(struct cfg80211_registered_device *rdev)
 		spin_unlock_bh(&rdev->bss_lock);
 	}
 
-	request = kzalloc(struct_size(request, channels, n_channels) +
-			  sizeof(*request->scan_6ghz_params) * count +
-			  sizeof(*request->ssids) * rdev_req->n_ssids,
-			  GFP_KERNEL);
+	size = struct_size(request, channels, n_channels);
+	offs_ssids = size;
+	size += sizeof(*request->ssids) * rdev_req->n_ssids;
+	offs_6ghz_params = size;
+	size += sizeof(*request->scan_6ghz_params) * count;
+	offs_ies = size;
+	size += rdev_req->ie_len;
+
+	request = kzalloc(size, GFP_KERNEL);
 	if (!request) {
 		cfg80211_free_coloc_ap_list(&coloc_ap_list);
 		return -ENOMEM;
@@ -849,8 +855,26 @@ static int cfg80211_scan_6ghz(struct cfg80211_registered_device *rdev)
 
 	*request = *rdev_req;
 	request->n_channels = 0;
-	request->scan_6ghz_params =
-		(void *)&request->channels[n_channels];
+	request->n_6ghz_params = 0;
+	if (rdev_req->n_ssids) {
+		/*
+		 * Add the ssids from the parent scan request to the new
+		 * scan request, so the driver would be able to use them
+		 * in its probe requests to discover hidden APs on PSC
+		 * channels.
+		 */
+		request->ssids = (void *)request + offs_ssids;
+		memcpy(request->ssids, rdev_req->ssids,
+		       sizeof(*request->ssids) * request->n_ssids);
+	}
+	request->scan_6ghz_params = (void *)request + offs_6ghz_params;
+
+	if (rdev_req->ie_len) {
+		void *ie = (void *)request + offs_ies;
+
+		memcpy(ie, rdev_req->ie, rdev_req->ie_len);
+		request->ie = ie;
+	}
 
 	/*
 	 * PSC channels should not be scanned in case of direct scan with 1 SSID
@@ -939,17 +963,8 @@ static int cfg80211_scan_6ghz(struct cfg80211_registered_device *rdev)
 
 	if (request->n_channels) {
 		struct cfg80211_scan_request *old = rdev->int_scan_req;
-		rdev->int_scan_req = request;
 
-		/*
-		 * Add the ssids from the parent scan request to the new scan
-		 * request, so the driver would be able to use them in its
-		 * probe requests to discover hidden APs on PSC channels.
-		 */
-		request->ssids = (void *)&request->channels[request->n_channels];
-		request->n_ssids = rdev_req->n_ssids;
-		memcpy(request->ssids, rdev_req->ssids, sizeof(*request->ssids) *
-		       request->n_ssids);
+		rdev->int_scan_req = request;
 
 		/*
 		 * If this scan follows a previous scan, save the scan start
-- 
2.43.0


