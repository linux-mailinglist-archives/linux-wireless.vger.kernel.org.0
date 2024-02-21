Return-Path: <linux-wireless+bounces-3853-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B0785D761
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Feb 2024 12:49:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1555283EE3
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Feb 2024 11:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58E946521;
	Wed, 21 Feb 2024 11:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Rf9Oi6Ah"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351C53F8C2
	for <linux-wireless@vger.kernel.org>; Wed, 21 Feb 2024 11:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708516107; cv=none; b=OdB3xJTOOlTYMwkdTvn6KfqAwUKgVGdducTAhFbFLcO4ZrXwfV6+bFABsVoluIBjr5gJDbMBwC21lcebP2D9h2JEiU+BF21BVUi5MoHIvm8EB5eIXu3XDIdNd2PXZIEtNV4jKW/JLwhxGCBHi7b8J7aSXnXoJxnO5CyFNJujEes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708516107; c=relaxed/simple;
	bh=Ixp/CpHBaAjzBgDGXdHfcQB0lqNls7x8Gf5MNEJKOlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fl8c9+0pmnANxRWdVqvDpsKUwpt5HuzcD9GqacoU3GMQFPNDqrW3KpbCur8/I4tVGFzALkImor1Z0JqG+v6xj2GAT2fRokmkWW5V2i6Q7j9amV7baJnG9CKQSmMkFqn+FQfSl2OwTeAXQEzhurCVCgoESKxZSJB6zYhFm2S1qZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Rf9Oi6Ah; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=yQdIFfRLqs/A5rXpMnjQezyX8kSCI4Hge0lx/RcCHlE=; t=1708516105; x=1709725705; 
	b=Rf9Oi6AhpQOTca6Ska55XhAR8gvFDat0inpAi9niTzaW9NNC044oRVnPI1ijXy3WUklBIxOg9H8
	yzOjJ4LuvwgPk10qFXeLxcRHlArbpD95nHU8BZXmP7XJrGPlejjnBYtvtKSWHJIBVjdlgwGekaTBz
	U7Z6tcagKqdzD9PQZbb2eqzFtJM1tsPD7JaFFRp31vMlJ5VFiJDPG6Z+JyAUtN2hmFzSlQyhrmaWb
	kycGgUyQNxdw3+z6h/NHpftH6aFYY7Ma0yiPG2B+XsF0kPihPnWz5ubaXeEaydSjm3cuKQbUdkDF+
	ntxP9+TAEToxDworOZIoIXtvtFXojx2T4BcA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rcl5J-00000002EIK-1o5d;
	Wed, 21 Feb 2024 12:48:21 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] wifi: nl80211: refactor parsing CSA offsets
Date: Wed, 21 Feb 2024 12:48:18 +0100
Message-ID: <20240221124818.0bbbcb19e90b.Id4bc7e858992172a8b4327363aca07cce9adb71e@changeid>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

The CSA offset parsing happens the same way for all of
beacon template offsets, probe response template offsets
and TX offsets (for using during probe response TX from
userspace directly).

Refactor the parsing here. There's an additional check
this introduces, which is that the number of counters in
TX offsets doesn't exceed the driver capability, but as
only two counters are used at most for anything, this is
hopefully OK.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/nl80211.c | 137 +++++++++++++++++------------------------
 1 file changed, 56 insertions(+), 81 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index dd9a092b6bab..bb8834410f70 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -10048,6 +10048,42 @@ static int nl80211_notify_radar_detection(struct sk_buff *skb,
 	return 0;
 }
 
+static int nl80211_parse_counter_offsets(struct cfg80211_registered_device *rdev,
+					 const u8 *data, size_t datalen,
+					 int first_count, struct nlattr *attr,
+					 const u16 **offsets, unsigned int *n_offsets)
+{
+	int i;
+
+	*n_offsets = 0;
+
+	if (!attr)
+		return 0;
+
+	if (!nla_len(attr) || (nla_len(attr) % sizeof(u16)))
+		return -EINVAL;
+
+	*n_offsets = nla_len(attr) / sizeof(u16);
+	if (rdev->wiphy.max_num_csa_counters &&
+	    (*n_offsets > rdev->wiphy.max_num_csa_counters))
+		return -EINVAL;
+
+	*offsets = nla_data(attr);
+
+	/* sanity checks - counters should fit and be the same */
+	for (i = 0; i < *n_offsets; i++) {
+		u16 offset = (*offsets)[i];
+
+		if (offset >= datalen)
+			return -EINVAL;
+
+		if (first_count != -1 && data[offset] != first_count)
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int nl80211_channel_switch(struct sk_buff *skb, struct genl_info *info)
 {
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
@@ -10059,7 +10095,6 @@ static int nl80211_channel_switch(struct sk_buff *skb, struct genl_info *info)
 	int err;
 	bool need_new_beacon = false;
 	bool need_handle_dfs_flag = true;
-	int len, i;
 	u32 cs_count;
 
 	if (!rdev->ops->channel_switch ||
@@ -10144,72 +10179,23 @@ static int nl80211_channel_switch(struct sk_buff *skb, struct genl_info *info)
 		goto free;
 	}
 
-	len = nla_len(csa_attrs[NL80211_ATTR_CNTDWN_OFFS_BEACON]);
-	if (!len || (len % sizeof(u16))) {
-		err = -EINVAL;
+	err = nl80211_parse_counter_offsets(rdev, params.beacon_csa.tail,
+					    params.beacon_csa.tail_len,
+					    params.count,
+					    csa_attrs[NL80211_ATTR_CNTDWN_OFFS_BEACON],
+					    &params.counter_offsets_beacon,
+					    &params.n_counter_offsets_beacon);
+	if (err)
 		goto free;
-	}
 
-	params.n_counter_offsets_beacon = len / sizeof(u16);
-	if (rdev->wiphy.max_num_csa_counters &&
-	    (params.n_counter_offsets_beacon >
-	     rdev->wiphy.max_num_csa_counters)) {
-		err = -EINVAL;
+	err = nl80211_parse_counter_offsets(rdev, params.beacon_csa.probe_resp,
+					    params.beacon_csa.probe_resp_len,
+					    params.count,
+					    csa_attrs[NL80211_ATTR_CNTDWN_OFFS_PRESP],
+					    &params.counter_offsets_presp,
+					    &params.n_counter_offsets_presp);
+	if (err)
 		goto free;
-	}
-
-	params.counter_offsets_beacon =
-		nla_data(csa_attrs[NL80211_ATTR_CNTDWN_OFFS_BEACON]);
-
-	/* sanity checks - counters should fit and be the same */
-	for (i = 0; i < params.n_counter_offsets_beacon; i++) {
-		u16 offset = params.counter_offsets_beacon[i];
-
-		if (offset >= params.beacon_csa.tail_len) {
-			err = -EINVAL;
-			goto free;
-		}
-
-		if (params.beacon_csa.tail[offset] != params.count) {
-			err = -EINVAL;
-			goto free;
-		}
-	}
-
-	if (csa_attrs[NL80211_ATTR_CNTDWN_OFFS_PRESP]) {
-		len = nla_len(csa_attrs[NL80211_ATTR_CNTDWN_OFFS_PRESP]);
-		if (!len || (len % sizeof(u16))) {
-			err = -EINVAL;
-			goto free;
-		}
-
-		params.n_counter_offsets_presp = len / sizeof(u16);
-		if (rdev->wiphy.max_num_csa_counters &&
-		    (params.n_counter_offsets_presp >
-		     rdev->wiphy.max_num_csa_counters)) {
-			err = -EINVAL;
-			goto free;
-		}
-
-		params.counter_offsets_presp =
-			nla_data(csa_attrs[NL80211_ATTR_CNTDWN_OFFS_PRESP]);
-
-		/* sanity checks - counters should fit and be the same */
-		for (i = 0; i < params.n_counter_offsets_presp; i++) {
-			u16 offset = params.counter_offsets_presp[i];
-
-			if (offset >= params.beacon_csa.probe_resp_len) {
-				err = -EINVAL;
-				goto free;
-			}
-
-			if (params.beacon_csa.probe_resp[offset] !=
-			    params.count) {
-				err = -EINVAL;
-				goto free;
-			}
-		}
-	}
 
 skip_beacons:
 	err = nl80211_parse_chandef(rdev, info, &params.chandef);
@@ -12638,23 +12624,12 @@ static int nl80211_tx_mgmt(struct sk_buff *skb, struct genl_info *info)
 	params.buf = nla_data(info->attrs[NL80211_ATTR_FRAME]);
 	params.len = nla_len(info->attrs[NL80211_ATTR_FRAME]);
 
-	if (info->attrs[NL80211_ATTR_CSA_C_OFFSETS_TX]) {
-		int len = nla_len(info->attrs[NL80211_ATTR_CSA_C_OFFSETS_TX]);
-		int i;
-
-		if (len % sizeof(u16))
-			return -EINVAL;
-
-		params.n_csa_offsets = len / sizeof(u16);
-		params.csa_offsets =
-			nla_data(info->attrs[NL80211_ATTR_CSA_C_OFFSETS_TX]);
-
-		/* check that all the offsets fit the frame */
-		for (i = 0; i < params.n_csa_offsets; i++) {
-			if (params.csa_offsets[i] >= params.len)
-				return -EINVAL;
-		}
-	}
+	err = nl80211_parse_counter_offsets(rdev, NULL, params.len, -1,
+					    info->attrs[NL80211_ATTR_CSA_C_OFFSETS_TX],
+					    &params.csa_offsets,
+					    &params.n_csa_offsets);
+	if (err)
+		return err;
 
 	if (!params.dont_wait_for_ack) {
 		msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
-- 
2.43.2


