Return-Path: <linux-wireless+bounces-9076-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 204B190B14B
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 16:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0969DB30BE0
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 13:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B606D1A2FB4;
	Mon, 17 Jun 2024 13:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f3Z30GNx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891FE1A2C11;
	Mon, 17 Jun 2024 13:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630477; cv=none; b=ROAisW46WKuyKdRGtaG+ymbiRyY4l7GhkdeP19ApTPT1jUtmSQiMYvnMhUJAO1xIqR3XameF8G+4BS91jkaIPThThwn2BsiejlSY6GYi6s889ttHEb0ToIYoXX0ZnYmgyTkZGQYuy5VKncpDg59C2Ghjq3k8NU/h8fPaztdRkmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630477; c=relaxed/simple;
	bh=oyfPLtB9HMRQ+cVwiNdkByR8dPfrTbwqv/7ROVe+dtM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qvlD7PMNSi9oQAmlWUpMstG3+ueipXoJEIIuoletuXIJifLFSZGusxZLqeRBk7FIQWXYTTtXNED3a2UAwkGNrPvSM5O11daTLF8RceNCH56sId17hZ29ffRzEmKrPJXmeCRJ+GdlG9FZS0ww4SWXx61SrfBnbFUcVNaHeqK8/Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f3Z30GNx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12467C2BD10;
	Mon, 17 Jun 2024 13:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718630477;
	bh=oyfPLtB9HMRQ+cVwiNdkByR8dPfrTbwqv/7ROVe+dtM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f3Z30GNxSyRaDKbOWfxPg2/1ctghVLdEH9zf3tX+S8/Ys4IeHlYclglGY8ZcTBQyI
	 e/EY7LaWuFWjluztKY8Xvejxc1pX4b7tObu355d+W1/JHht/ZSfhOVIXEgeq/y8B9K
	 VTiBkOWlPSKiPUyjG3F/qm2i3AhAEi6+O10hhLy0FJE6w061BDoqkgPi7d+U/Eub0z
	 x5LHiV4zO65RsYN1hwFmvTeWaA92s5vZoti7PELIzZ7+oU6Gbu0V6esBUoDf5lKnFM
	 YtMlnQcdZHY2J+y0yCAhDymbopKsCjdOYH8ru1NrV/Z1SvifXphtT6jQg0ytgDGd1g
	 XZDDSu9fC1ZtQ==
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
Subject: [PATCH AUTOSEL 6.9 17/44] wifi: cfg80211: fix 6 GHz scan request building
Date: Mon, 17 Jun 2024 09:19:30 -0400
Message-ID: <20240617132046.2587008-17-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240617132046.2587008-1-sashal@kernel.org>
References: <20240617132046.2587008-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.5
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
index 43897a5269b6a..755af47b88b91 100644
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
index 9b0dbcd6cf79a..914fad87d3c32 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -812,6 +812,7 @@ static int cfg80211_scan_6ghz(struct cfg80211_registered_device *rdev)
 	LIST_HEAD(coloc_ap_list);
 	bool need_scan_psc = true;
 	const struct ieee80211_sband_iftype_data *iftd;
+	size_t size, offs_ssids, offs_6ghz_params, offs_ies;
 
 	rdev_req->scan_6ghz = true;
 
@@ -877,10 +878,15 @@ static int cfg80211_scan_6ghz(struct cfg80211_registered_device *rdev)
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
@@ -888,8 +894,26 @@ static int cfg80211_scan_6ghz(struct cfg80211_registered_device *rdev)
 
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
@@ -978,17 +1002,8 @@ static int cfg80211_scan_6ghz(struct cfg80211_registered_device *rdev)
 
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


