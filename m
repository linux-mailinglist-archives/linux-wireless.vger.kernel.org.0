Return-Path: <linux-wireless+bounces-7445-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8938B8C2114
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 11:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E64C2815B0
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 09:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF50915FCE1;
	Fri, 10 May 2024 09:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="DH414euk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E13679945
	for <linux-wireless@vger.kernel.org>; Fri, 10 May 2024 09:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715333865; cv=none; b=hcEMwguEaqyenUeZQ2JOLl7g0GjJZqGbB391UI91zpjGq/brYlUXerd6rZdfpxxYE2qUayeg47nlQCTuY0u1pgrYBYzgWMi/fSQY16EZVmuO5cI8a/Wm80Mw18vtfWXWM5wMolcDsYQuK7EZ7YILIrS+6qylqxJlQHJXDo+wSlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715333865; c=relaxed/simple;
	bh=3SSXg1MqgYlK/dIxLGgUD9Yhl2pQzU0IFkyWySr50fQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S2oPwmMcUdaCy3Gw3viK0Bigy17jeSqW/jo46s6NMIrGATcOoREMLDfYQ4MwYhr0rXsXdxqp5rFp3FGFtuyQ+sbdNkTZ9nUoV/NyJoYCJhARyp/jxci3t7iiBuFSdns5w0ebPysokpuj94CDa7yyGMzpmk8e0YUIx1ZUeOIGyso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=DH414euk; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=v2q6LIp0a61HE0zV4/oaxjZPoVNG0yIhmihMesWGZbQ=; t=1715333864; x=1716543464; 
	b=DH414eukUaNWclH0M1BXdwPNAFDEDTZW1pfBS/exjT3k25bWDSY5SJuhnZ0I+KIBMGwk9F6eA43
	qWzsjY6/FeBzRKUD6hTXVT+n0as5ck6a5Pwk67EXb/Ij99m5MU51kmHVrrR/V2woRGHUQ/Cr5i4Aw
	Cjvpz2np0RwEsgTzbTVeMEL9T+wgKm8PFIpiouaVugBMZ2e4gZWWtlEW+8MZ+uvA3gZec90Mp2/c9
	dGPn4TwjipDRKUO/38JCaQKxqqflGU9dCvCsSehw8mf8UlxdwRgtL5WsqFjBv74ZnRYXr9slfLFRf
	IATE3i0ShplrXf78Fnb5CulMu4nqrGU99afQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1s5MhA-0000000Ekya-2RXk;
	Fri, 10 May 2024 11:37:40 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH v2] wifi: cfg80211: fix 6 GHz scan request building
Date: Fri, 10 May 2024 11:37:38 +0200
Message-ID: <20240510113738.4190692ef4ee.I0cb19188be17a8abd029805e3373c0a7777c214c@changeid>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

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
---
v2: fix author
---
 net/wireless/rdev-ops.h |  6 +++++-
 net/wireless/scan.c     | 47 +++++++++++++++++++++++++++--------------
 2 files changed, 36 insertions(+), 17 deletions(-)

diff --git a/net/wireless/rdev-ops.h b/net/wireless/rdev-ops.h
index 43897a5269b6..755af47b88b9 100644
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
index 127853877a0a..e0cbeb34074d 100644
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
@@ -978,18 +1002,9 @@ static int cfg80211_scan_6ghz(struct cfg80211_registered_device *rdev)
 
 	if (request->n_channels) {
 		struct cfg80211_scan_request *old = rdev->int_scan_req;
+
 		rdev->int_scan_req = request;
 
-		/*
-		 * Add the ssids from the parent scan request to the new scan
-		 * request, so the driver would be able to use them in its
-		 * probe requests to discover hidden APs on PSC channels.
-		 */
-		request->ssids = (void *)&request->channels[request->n_channels];
-		request->n_ssids = rdev_req->n_ssids;
-		memcpy(request->ssids, rdev_req->ssids, sizeof(*request->ssids) *
-		       request->n_ssids);
-
 		/*
 		 * If this scan follows a previous scan, save the scan start
 		 * info from the first part of the scan
-- 
2.45.0


