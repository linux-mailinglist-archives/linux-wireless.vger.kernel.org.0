Return-Path: <linux-wireless+bounces-4948-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF3B880BCB
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 08:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3C811F245BC
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 07:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A5E1EB23;
	Wed, 20 Mar 2024 07:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YXDaB43E"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C272F1EB22
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 07:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710918870; cv=none; b=ojoeleGCXGyvJKtG1Ce2nvlGASDH8dNFRLRZMuGIJNZIosMrgUnKlmQgK72OZO8P4ZIAXRGsJw6f3B7aNlvCWFv2ZMNKXsLigm00rVwt2tLEaZ7r6InxHl5vtaZu4rzsmOUYzXLaFF0nI25iM/zXikaeInYWfAH+vRENkLsfaVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710918870; c=relaxed/simple;
	bh=6eUlFMEubQxbS9/JI+XiecwitNl0neGcOQzXq4fA+0o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c8hJJB/aL8HeAAdEkntqOTop726cjBj/O9kTXkI/I1ohw++PzxLboHKZEpshOnPV+wbxFDhD+PPG5RIED0Q7p1mbNU+C49dvfS9meGYrU4EBR7WO8xeEa62D/Vi5dhghU+OGEK2GFnBQnOT0XG2B+zmFhc0B08o3mlJKE+nBxHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YXDaB43E; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710918869; x=1742454869;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6eUlFMEubQxbS9/JI+XiecwitNl0neGcOQzXq4fA+0o=;
  b=YXDaB43EuTe4wA+w3ubTkzDGfpcBdK/ZZevmWny3JoQsKruQZAiXC/Dl
   0Dod8m8KFP1HNbl3Oq5ApYMuJWtuiMz0UxOpUqcXnFySfhG+iTnrVaYTO
   S+lH2SxVfqrFSP0O+2dmrD5ydlG1OBDC68JyTLb2gdFh9foIWUOI8crwR
   gBU/g65v3nuXdDl5yGq/Nfz5eqbs7z3FHZVecPN7gHk87jZjbkTyvjB8N
   HiDBp3GjrqjdG1ic7PdzqJYY5aiHZt5Qw0Gu7K/9CJ6ir29G/SJiVoieq
   42rhX2HqYI3fbgkTPbsi0wdBLZX47y1MwW4y/8SuBEapa8snF9kubhsMr
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="5763845"
X-IronPort-AV: E=Sophos;i="6.07,139,1708416000"; 
   d="scan'208";a="5763845"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 00:14:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,139,1708416000"; 
   d="scan'208";a="14477413"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 00:14:26 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 6/8] wifi: mac80211: don't ask driver about no-op link changes
Date: Wed, 20 Mar 2024 09:14:03 +0200
Message-Id: <20240320091155.a8190a312a27.If4e6f5ce8228eda7afac0fc8c17dd731c5da9ed9@changeid>
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

If the links won't actually change, nothing will happen.
This was previously done in the inner function (twice in
some cases), but we shouldn't bother the driver with it.
Clean that up.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/link.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/link.c b/net/mac80211/link.c
index 503ec47bbc2a..84efb6487970 100644
--- a/net/mac80211/link.c
+++ b/net/mac80211/link.c
@@ -452,10 +452,13 @@ int ieee80211_set_active_links(struct ieee80211_vif *vif, u16 active_links)
 	if (WARN_ON(!active_links))
 		return -EINVAL;
 
+	old_active = sdata->vif.active_links;
+	if (old_active == active_links)
+		return 0;
+
 	if (!drv_can_activate_links(local, sdata, active_links))
 		return -EINVAL;
 
-	old_active = sdata->vif.active_links;
 	if (old_active & active_links) {
 		/*
 		 * if there's at least one link that stays active across
-- 
2.34.1


