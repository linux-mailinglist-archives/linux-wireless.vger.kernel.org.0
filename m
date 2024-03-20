Return-Path: <linux-wireless+bounces-4943-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E60B6880BC6
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 08:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 221931C22649
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 07:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D6C24A19;
	Wed, 20 Mar 2024 07:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Os9KdABe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD8E2208F
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 07:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710918859; cv=none; b=jXHhE6YxVjRlUqh7/TdTnoGfqAcvHrNIbdoPwMqnG9IxVIKjz6O4kk0Ulzb6o4gIHBcxEEpwAHWzLqY6NV5pqQEAig0Hhfu7IUOZVz7IJvX7KWk9+dXlpICc0KkBo3ig4kcd6CixLu/wSiUI8ijCIOeuZ89kNtyAJt6PqLby3T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710918859; c=relaxed/simple;
	bh=jYA5rmFK6ns6xtK1SrCtNjRmMM6pIneu5GEu2vkYJ44=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WkMyiMcRS3Etxy7n5GGjlMoN3m5sXWailhrt9OqdJ2qVv2H91mxdBmUEjvi7Me8/3RZ2VwMo2XvbQ69RqHpthwUoCy1phLUPG/F3xDLHcVq2SAfXT3a7Qc4h2LQxEVCJ2qq68h9VMEuLfZv5b2tPDwftA8h+al9rV6yrZtbB9Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Os9KdABe; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710918857; x=1742454857;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jYA5rmFK6ns6xtK1SrCtNjRmMM6pIneu5GEu2vkYJ44=;
  b=Os9KdABe7foWj1qJnv51u7BDilcPOLkeQ8uf70ObDEFokfae6XQiJXGF
   nx2SQMwdzvoNH7x8Dzt0L4elLVGjL7iRx/VhNtezPBjlN7fICi/LAG56e
   b0PcixVRMQjEY/BzOxoO4WeFyh1BkOlwzjr2dsB4xClZPFEJ9Sqp/VC33
   9Bhmqrr4PJAbNIHXAVCqd6fPRp480EEH5ESDSocDFpyoaTbCT/MDpNoap
   u0jWZT51Gm5THKKIYC3ZztF2FUwHpq4i0SCQSHI/Xi1PqHLUWAxdWu3c0
   Tg47RNbmfMqljT9o9DaUhQ4rPTVHVlzETKV98Rt03ATzxnRFPRhx0VG5n
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="5763828"
X-IronPort-AV: E=Sophos;i="6.07,139,1708416000"; 
   d="scan'208";a="5763828"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 00:14:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,139,1708416000"; 
   d="scan'208";a="14477397"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 00:14:15 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 1/8] wifi: mac80211: do not call ieee80211_key_switch_links during reconfig
Date: Wed, 20 Mar 2024 09:13:58 +0200
Message-Id: <20240320091155.6ab8520bd4a1.Iea3e7e5d8b2bb5db1dd93f6ca589e8ea1bacaf60@changeid>
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

From: Benjamin Berg <benjamin.berg@intel.com>

The keys will be configured later by a call to ieee80211_reenable_keys.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/link.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/link.c b/net/mac80211/link.c
index 685ec66b4264..7f01462f84e9 100644
--- a/net/mac80211/link.c
+++ b/net/mac80211/link.c
@@ -375,8 +375,10 @@ static int _ieee80211_set_active_links(struct ieee80211_sub_if_data *sdata,
 		WARN_ON_ONCE(ret);
 	}
 
-	ret = ieee80211_key_switch_links(sdata, rem, add);
-	WARN_ON_ONCE(ret);
+	if (!local->in_reconfig) {
+		ret = ieee80211_key_switch_links(sdata, rem, add);
+		WARN_ON_ONCE(ret);
+	}
 
 	list_for_each_entry(sta, &local->sta_list, list) {
 		if (sdata != sta->sdata)
-- 
2.34.1


