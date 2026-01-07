Return-Path: <linux-wireless+bounces-30454-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5761CFDF3C
	for <lists+linux-wireless@lfdr.de>; Wed, 07 Jan 2026 14:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 221D53004EEE
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jan 2026 13:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0073832A3D8;
	Wed,  7 Jan 2026 13:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y8QK5Lz8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795DE329375
	for <linux-wireless@vger.kernel.org>; Wed,  7 Jan 2026 13:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767792029; cv=none; b=YCw1+4xwSKdiAVAT/zUDYNiW1Xt2yLMNg9xZyjnaFtPjKSTr2J41YpbuuifbzQKF9eW7AioWiBx8+numm1f1B9zfxxZVvVK+uIWD4gETSAy3qtNDX7zQxtg/6dQ0IbeIkqXfnTFx7SqeiXhVKkefQwqAv1EPE/I29GG9aNdXRA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767792029; c=relaxed/simple;
	bh=1+sMvRjCnSFbJPpsPt3L8q7EJI5r5rvS9jzx9kAl524=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kA1nJD/fp+/kOYvI+MOSupnJcyQGlyxvLXJa9YOmMXwfvdGk8ka8+/RBzyupM9eksP6TA2IqXPSiGiGzGH0oum9xuKTuKYbjG0uXClMiz2EwhlUMT/NxkAVtEVKonBNp+bad0Y8sERF50d4HyoVjoUON6fETO04gt1N4Tc7BlXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y8QK5Lz8; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767792029; x=1799328029;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1+sMvRjCnSFbJPpsPt3L8q7EJI5r5rvS9jzx9kAl524=;
  b=Y8QK5Lz8ysHqPuE7zy3RCQyZ7xOtSP2VHF0efInnTI0GA5BTsjdsqlds
   O5P+Z62ubKcQ6FdgL5/naQahHItyE+vWiT/vejcPyl0GCAzevuKERHFGK
   ShifzC2HXLq2LHAYZacMqmF9/lLrkb4sXxQRmWhImyIBdBO4KKFS0c3G5
   uqoyefzWnXZh3ANBNXt0Cz42+y7oMXZB/aWDUyvfwTLJ8VTqJ5Kh3L7Jg
   05gyG9sVZmbobs3VuX2gyX23BFscnL4HY9SCDIHRr7vSLzEchGIbb6/z5
   CN1TE5StaVckeftrUtKn4nMncII68rVSWbBXiQAwO2ziiPZ2l+wBaiHUj
   g==;
X-CSE-ConnectionGUID: ZB5z0q+UTAajcfluDtN/6Q==
X-CSE-MsgGUID: 8vqjVLcPS9KeOI5rj8zdvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="86576870"
X-IronPort-AV: E=Sophos;i="6.21,208,1763452800"; 
   d="scan'208";a="86576870"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 05:20:28 -0800
X-CSE-ConnectionGUID: NE45j3GqRKue1k/RqkyNcw==
X-CSE-MsgGUID: mNOvb4OdSbeJSnF7Zu9XSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,208,1763452800"; 
   d="scan'208";a="203185791"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 05:20:27 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Daniel Gabay <daniel.gabay@intel.com>
Subject: [PATCH wireless-next 12/15] wifi: cfg80211: allow ToDS=0/FromDS=0 data frames on NAN data interfaces
Date: Wed,  7 Jan 2026 15:20:00 +0200
Message-Id: <20260107150057.9a58d784fa41.Id34dd69552920b579e6881ffd38fa692a491b601@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260107132003.2291979-1-miriam.rachel.korenblit@intel.com>
References: <20260107132003.2291979-1-miriam.rachel.korenblit@intel.com>
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


