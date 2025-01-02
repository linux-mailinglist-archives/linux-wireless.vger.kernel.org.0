Return-Path: <linux-wireless+bounces-16988-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB8249FFA63
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2025 15:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2F413A1096
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2025 14:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1029B1B4F21;
	Thu,  2 Jan 2025 14:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mI8rpLfq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505101B3948
	for <linux-wireless@vger.kernel.org>; Thu,  2 Jan 2025 14:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735827641; cv=none; b=fDeCPU4likfj3bmjfBq4ffMtIPtmIZydfSurlQEq7JguZlCuFLtx2vsCKBYP6tSUnrYWFd7RHwzuXwNPkr1R0KqG0ZXsjorU63eGh8wFyS4d32C47MytEIcv/nJ533nG4YB2RVZOEzyf6Rmu1ZQP5nzzajNLeX4EwK8Euz5uBm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735827641; c=relaxed/simple;
	bh=H3iGrCkmStFfjtjiMU1XNNXU/ht//ydnzW3d9b0r79g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IzMkyQYzfChlk9XdU52wu/NjgiPipIrJHEotV+ynJxNLyzPRpz2Bxm8mz14WSnsJu+5GqrhYEQXq+F+7O0/aB9hH9tYI8QKQ+E1YqmkBUhFlpCbVKfT3pv0nPxXaVILWKWM/1p/zKEiQDoIKSe0OUrC2nEVyJ/t8h9ukycvy1gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mI8rpLfq; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735827639; x=1767363639;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=H3iGrCkmStFfjtjiMU1XNNXU/ht//ydnzW3d9b0r79g=;
  b=mI8rpLfqsQIQXcyXOcb9Z7eZqUjX69ilg0LbZVtjKB6APIoOpxhEweYs
   lTY8U8V5hfuIesDLMY3aZ8Od/+XPEKASL2MRCerg71VI6lTuaRFqj0+Qy
   YXa5pE/hUwytV1K/n8KJJaWkvf5MV2BaPG93+Ec86HYKXo2D49eRIn7lU
   zBPOMnNpHnqBoSFiJOEJ+XA8HFEPJeZfqRWRwnMeUQlb5ie4d1BjfUYtQ
   hN8F68PQUWMsIlKLLOannCwxv18UKaMrTbZwN1DOzhLil+2U37goPYygE
   sXko3hz+Dj7NvgN1voe3yuyZzwqc8ebKZWSmHg0aBH99LNalBzcxjCXLe
   w==;
X-CSE-ConnectionGUID: kVY+Vt2aTPa3YiVQr/u73A==
X-CSE-MsgGUID: HJ/EvlZAQLetolZPvDV7AQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11302"; a="46735118"
X-IronPort-AV: E=Sophos;i="6.12,285,1728975600"; 
   d="scan'208";a="46735118"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2025 06:20:39 -0800
X-CSE-ConnectionGUID: R07FTATqSue0TnbMFdHVKQ==
X-CSE-MsgGUID: NXb4l7c/ReaC8GR4c2Z2XA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,285,1728975600"; 
   d="scan'208";a="132357416"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2025 06:20:37 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 10/17] wifi: nl80211: simplify nested if checks
Date: Thu,  2 Jan 2025 16:20:02 +0200
Message-Id: <20250102161730.c8bf7338aa64.Ie49dcc1ba44b507d91d5a9d8bd538d7ac2e46c54@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250102142009.3057049-1-miriam.rachel.korenblit@intel.com>
References: <20250102142009.3057049-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

In the absence of (an) else clause(s), "if (a) if (b)" is
equivalent to "if (a && b)", so simplify the code a bit.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/wireless/nl80211.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index d073f14eb6ae..b3b3c30a787e 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -18536,10 +18536,9 @@ void nl80211_send_port_authorized(struct cfg80211_registered_device *rdev,
 	    nla_put(msg, NL80211_ATTR_MAC, ETH_ALEN, peer_addr))
 		goto nla_put_failure;
 
-	if ((td_bitmap_len > 0) && td_bitmap)
-		if (nla_put(msg, NL80211_ATTR_TD_BITMAP,
-			    td_bitmap_len, td_bitmap))
-			goto nla_put_failure;
+	if (td_bitmap_len > 0 && td_bitmap &&
+	    nla_put(msg, NL80211_ATTR_TD_BITMAP, td_bitmap_len, td_bitmap))
+		goto nla_put_failure;
 
 	genlmsg_end(msg, hdr);
 
-- 
2.34.1


