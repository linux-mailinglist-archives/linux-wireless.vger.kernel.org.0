Return-Path: <linux-wireless+bounces-20172-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A999A5BEE9
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 12:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3420A1887EE1
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 11:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C382505AF;
	Tue, 11 Mar 2025 11:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="w6MsRvmh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D40254866
	for <linux-wireless@vger.kernel.org>; Tue, 11 Mar 2025 11:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741692352; cv=none; b=JOenOd1p9E2Wf+Gizrgbl3BefBzstahQ9eFcf4/FirQM9xngeHg32mZeVlx/kgbpmKMjFJ1/SAq0z6SBLDVpe4y+Kejq9v2JJU7fMcqpDZ1c0WkteXFaFESK0wLcma05jNQxVqqNfwBHn+fF9Bc+eduAHFMJpebk3HjpkxXnXdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741692352; c=relaxed/simple;
	bh=RcpSIGeCFjU2WQ3OaAGIrqrD4Gebkr6we94BDK88jak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lx+B3ZvL+ypRORnMnhhqlUznqz5r1EIUpPzjLC+fM3dfLF5a1bqj04sYh+jM3Qvyq9vzYPLlF7xAxSJ0G1ysDDm7/DhQqFG2WwF5SaAQcUjJrdfN4L1nUuvk4orTe0iO11eh463mLZAAPF2UFIARz3UlLRSvQdWCKTxoPvWN9iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=w6MsRvmh; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=IJMYeVJVn6kaiIhFUayKGm4J3PT8SSJ7YIb5R21OePY=;
	t=1741692350; x=1742901950; b=w6MsRvmhmwVWRVvUWvi4Lueg7WUeGwZjDVYei0DGXI4dxjA
	1RxeiCVPZaGZbBFzTxT2hgRHEWLVU3URYoKDKyAOUDFUzAuwYmvm9zP5v3IZgp00knUxR2TLdj/0e
	GfNEw9FhtHudFyMI1Qkvf+aLgB+YX3qa7BfCW+wHM9vUd8g1OPb2a/x7y2W91G3ga5VLwfIgsUh6Q
	MRj8hm2QberEdXgDOfj6FRLoLw7M1UWYV0fMBw5rd4Viky+NWov9qoJjyCqyQqcA3b2YazvkurBVR
	tK8MXWSQ6tysYnoElnp8rqVgfOcu+Yj7gMSJR/BUHl7H3yN5q2Nc3fSRo/kI46VA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1trxk3-00000007pEA-0Zsf;
	Tue, 11 Mar 2025 12:25:47 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH wireless-next 2/2] wifi: mac80211: use cfg80211_chandef_get_width()
Date: Tue, 11 Mar 2025 12:25:35 +0100
Message-ID: <20250311122534.0a1d24a1a763.I51a52a67587a7eee65c80b9c5cf132820ebb9dd9@changeid>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311122534.c5c3b4af9a74.Ib25cf60f634dc359961182113214e5cdc3504e9c@changeid>
References: <20250311122534.c5c3b4af9a74.Ib25cf60f634dc359961182113214e5cdc3504e9c@changeid>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

We can now use this helper here and simplify some code.

Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/mlme.c | 2 +-
 net/mac80211/wbrf.c | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index bfd3653a5b84..59acacfaaa73 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -788,7 +788,7 @@ static int ieee80211_chandef_num_subchans(const struct cfg80211_chan_def *c)
 	if (c->width == NL80211_CHAN_WIDTH_80P80)
 		return 4 + 4;
 
-	return nl80211_chan_width_to_mhz(c->width) / 20;
+	return cfg80211_chandef_get_width(c) / 20;
 }
 
 static int ieee80211_chandef_num_widths(const struct cfg80211_chan_def *c)
diff --git a/net/mac80211/wbrf.c b/net/mac80211/wbrf.c
index 3a8612309137..478b34b81919 100644
--- a/net/mac80211/wbrf.c
+++ b/net/mac80211/wbrf.c
@@ -2,6 +2,7 @@
 /*
  * Wifi Band Exclusion Interface for WLAN
  * Copyright (C) 2023 Advanced Micro Devices
+ * Copyright (C) 2025 Intel Corporation
  *
  */
 
@@ -45,7 +46,7 @@ static void get_ranges_from_chandef(struct cfg80211_chan_def *chandef,
 	u64 start_freq2, end_freq2;
 	int bandwidth;
 
-	bandwidth = nl80211_chan_width_to_mhz(chandef->width);
+	bandwidth = cfg80211_chandef_get_width(chandef);
 
 	get_chan_freq_boundary(chandef->center_freq1, bandwidth, &start_freq1, &end_freq1);
 
-- 
2.48.1


