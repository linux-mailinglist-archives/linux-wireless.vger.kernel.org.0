Return-Path: <linux-wireless+bounces-30534-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E45D03EF5
	for <lists+linux-wireless@lfdr.de>; Thu, 08 Jan 2026 16:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8726A3063F6D
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Jan 2026 15:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B9336656A;
	Thu,  8 Jan 2026 08:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iIolv1TQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CDF3590DA
	for <linux-wireless@vger.kernel.org>; Thu,  8 Jan 2026 08:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767861400; cv=none; b=Icx27DkvU1FoIoJQI91Zlt7hGlMsscMQ6z6SsAO7dYK/nBa2Gxr5tU5EDMZyCThPG4XgLQtT+LzP706ARfxVELWPav5oKkDUmLzJhlzODxXT3dCD4PTGxClaC3QOCGszBTZl+vh/KvohxLm9hmKYDCc0Yb9s1uHS7ZrvG3bCSB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767861400; c=relaxed/simple;
	bh=1+sMvRjCnSFbJPpsPt3L8q7EJI5r5rvS9jzx9kAl524=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SMHjgjCzfm/A4oZsv7T/MqylTujkpG+pgF2yBkywymS2+Cy6uHld9LIFQ4RFKI94oh5E9vkI9SUQvmfQGpsVIsHY5jJV9pgOQktGPyeGJEG6QXXcJ8y+NzxK4VkBQaTeoHC5mgel+ISG8jbfYeY0WXBTaAEFXLTDovRwHESPzPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iIolv1TQ; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767861397; x=1799397397;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1+sMvRjCnSFbJPpsPt3L8q7EJI5r5rvS9jzx9kAl524=;
  b=iIolv1TQIXlaQTdvY9TzHhjEkINSOXSvq+AKKa9Ee7Aja6o5HLQybg8c
   wRqNN8v5zoP2YHoWtdWWc9IKG/JZY2vhunvbWc7znewmRWWG/ltSC6wHA
   igl0Wrfq7ZLvRwg5bIycCgLYkHqlKB/2IoZCqWHKYzETUh0tnVjVpVHWn
   VllcFhgvFqZ732xPhsr62KmvzxUQXUXIJseqA8b0lSWtGNUJHXnc1NoMO
   hhMxCnvfv6xA+/rqQzQwfzR4QevD+wrWD+xYuK5gbtamtG8UND+J93NDt
   nn8HvDWvZV9vAS1UJRuH2cJhykblcq2e/qyV+t8i33JII9ut8qHeA/55c
   A==;
X-CSE-ConnectionGUID: 2mTc9aROS+uymbcbk348jA==
X-CSE-MsgGUID: FFeGklUPSiaS5/XbjyezIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="73084814"
X-IronPort-AV: E=Sophos;i="6.21,210,1763452800"; 
   d="scan'208";a="73084814"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2026 00:36:09 -0800
X-CSE-ConnectionGUID: NWIw9P6cSICgTdcX0yoxCQ==
X-CSE-MsgGUID: iXypw5zYSsig0RxOQpUVwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,210,1763452800"; 
   d="scan'208";a="233847518"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2026 00:36:07 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Daniel Gabay <daniel.gabay@intel.com>
Subject: [PATCH wireless-next v2 13/14] wifi: cfg80211: allow ToDS=0/FromDS=0 data frames on NAN data interfaces
Date: Thu,  8 Jan 2026 10:35:39 +0200
Message-Id: <20260108102921.de5f318a790a.Id34dd69552920b579e6881ffd38fa692a491b601@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260108083540.3129471-1-miriam.rachel.korenblit@intel.com>
References: <20260108083540.3129471-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Daniel Gabay <daniel.gabay@intel.com>

According to Wi-Fi Aware (TM) specification Table 3, data frame should
have 0 in the FromDS/ToDS fields. Don't drop received frames with 0
FromDS/ToDS if they are received on NAN_DATA interface.
While at it, fix a double indent.

Signed-off-by: Daniel Gabay <daniel.gabay@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/wireless/util.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/wireless/util.c b/net/wireless/util.c
index 076fe39b630f..5de7ea57768e 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -625,8 +625,9 @@ int ieee80211_data_to_8023_exthdr(struct sk_buff *skb, struct ethhdr *ehdr,
 	case cpu_to_le16(0):
 		if (iftype != NL80211_IFTYPE_ADHOC &&
 		    iftype != NL80211_IFTYPE_STATION &&
-		    iftype != NL80211_IFTYPE_OCB)
-				return -1;
+		    iftype != NL80211_IFTYPE_OCB &&
+		    iftype != NL80211_IFTYPE_NAN_DATA)
+			return -1;
 		break;
 	}
 
-- 
2.34.1


