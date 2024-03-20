Return-Path: <linux-wireless+bounces-4945-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17132880BC8
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 08:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46FAB1C226B3
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 07:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B122C697;
	Wed, 20 Mar 2024 07:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NeBzXDVH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED17C2BAF2
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 07:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710918863; cv=none; b=MT7vUNUv3269hkHFfYAfJl/TF95ns+LD4hGH19EqTcZnHtTnkRF6OOfY+q8ecdXJ0k2Lv6CVkD7C/ltZshz5ri5QqFCz1i3VAm+9YvE0x++sMafbwdkLT8YrbXKL3L6fuHeZwrT7S8xc5DfkNe7RQ4KrS7H1nE4UmwI0pyw6PQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710918863; c=relaxed/simple;
	bh=XfD/MD9aJLdMuYQ9JNy1aV5uqn0V5yb4tqrj6uooTpg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Torb0mFvqcOQu3uvfWJQFqewjA16u51srQGS+GsLV938JZREzlEbkeUi56IciGTl5itdb/zoSsDS/bJVXAQbHE1FskLpPYXbXadVPhN+cKKQEugRZnuN2VNAvE6kQQEGCpGA99stwqAgP9F7zdIWbm8O0P8tAUqQmSxUz6cK5Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NeBzXDVH; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710918861; x=1742454861;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XfD/MD9aJLdMuYQ9JNy1aV5uqn0V5yb4tqrj6uooTpg=;
  b=NeBzXDVHe1seBTLhAoU3c1Eo3ZtQ+78+nKutKPNRDqfDcxu83iw/UHc9
   lPGqdZ6XeTaukz30LGCMwMcUAiBbltf4eZ2Wp2UFslnT4k5wPGUVn++Fv
   vWa1+LhX94vS3LRzdvye0EDZtKjclUsr1gow2ThIxL4OT6Koexg+t76ei
   mQrUH6S/mWo8HrfXYyTOjwYf0K8gnhEICyqhxs3LGyKSaJvvCm//B4E7L
   WXvkac8uCLyvc4LiyC5zCvd2Y3xTwShtf5VRALc/mZ5lE/fL6kTBPSikA
   pE9yLtVfQXRrnRWq4lQsg5VOB/r6cDsJL4rckZM6+snjIVWTsdSnxPph3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="5763832"
X-IronPort-AV: E=Sophos;i="6.07,139,1708416000"; 
   d="scan'208";a="5763832"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 00:14:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,139,1708416000"; 
   d="scan'208";a="14477403"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 00:14:19 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Ayala Beker <ayala.beker@intel.com>
Subject: [PATCH 3/8] wifi: mac80211: clarify IEEE80211_STATUS_SUBDATA_MASK
Date: Wed, 20 Mar 2024 09:14:00 +0200
Message-Id: <20240320091155.28ac7b665039.I1abbb13e90f016cab552492e05f5cb5b52de6463@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240320071405.815427-1-miriam.rachel.korenblit@intel.com>
References: <20240320071405.815427-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

We have 13 bits for the status_data, so restricting
type to 4 and subdata to 8 bits is confusing, even if
we don't need more bits now. Change subdata mask to
be 9 bits instead, just to make things match up.

If we actually need more types or more subdata bits
we can later also reshuffle the bits between these,
but we should probably keep them at 13 bits together.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Ayala Beker <ayala.beker@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/ht.c          | 2 +-
 net/mac80211/ieee80211_i.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/ht.c b/net/mac80211/ht.c
index c3330aea4da3..d7e8cf8e48b7 100644
--- a/net/mac80211/ht.c
+++ b/net/mac80211/ht.c
@@ -580,7 +580,7 @@ int ieee80211_send_smps_action(struct ieee80211_sub_if_data *sdata,
 	/* we'll do more on status of this frame */
 	info = IEEE80211_SKB_CB(skb);
 	info->flags |= IEEE80211_TX_CTL_REQ_TX_STATUS;
-	/* we have 12 bits, and need 6: link_id 4, smps 2 */
+	/* we have 13 bits, and need 6: link_id 4, smps 2 */
 	info->status_data = IEEE80211_STATUS_TYPE_SMPS |
 			    u16_encode_bits(status_link_id << 2 | smps,
 					    IEEE80211_STATUS_SUBDATA_MASK);
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index c2212363dad3..fe81ab641620 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -90,7 +90,7 @@ enum ieee80211_status_data {
 	IEEE80211_STATUS_TYPE_INVALID	= 0,
 	IEEE80211_STATUS_TYPE_SMPS	= 1,
 	IEEE80211_STATUS_TYPE_NEG_TTLM	= 2,
-	IEEE80211_STATUS_SUBDATA_MASK	= 0xff0,
+	IEEE80211_STATUS_SUBDATA_MASK	= 0x1ff0,
 };
 
 static inline bool
-- 
2.34.1


