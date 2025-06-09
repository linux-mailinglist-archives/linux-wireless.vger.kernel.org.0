Return-Path: <linux-wireless+bounces-23876-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3C6AD25AD
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 20:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F1F47A27DE
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 18:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC0221CC46;
	Mon,  9 Jun 2025 18:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nXHaduwR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BC719258E
	for <linux-wireless@vger.kernel.org>; Mon,  9 Jun 2025 18:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749494147; cv=none; b=Ky5B8QLww2FSWz+yv8mDCAe3AvYhuThiCIvgKdZRt5atAYekHefpNLwfrMjeYJRZPDtpKDbyOiYwIsMVBrO3CRgkHxnkI1dIm5IAIMweZM5Cu+/nUEEpy6YgenyJNKhlfaq6Mj1aTxaXBXgCFVvZxMG2x+6E/lsNLi8AGJqO75I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749494147; c=relaxed/simple;
	bh=zLvOPs0ghY4l5hGd2RKwtIGWTKHF3VuM9PzReYCmWxY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ATNBuwsLI0PpidIe1hwe3cPugQtk3TqhbDflcmDaqRZcVNMQ8EohO6CUMSWH6MWN8tb2SwItW76BRtkur44znGmhLorfFqb+WZGWIqyQPnY0EQlYnTN8JxjhiZ9EQUeWMZMvS/b4MLsDzbgsuaQCogISZ18WmQVz4GghRsf1I7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nXHaduwR; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749494145; x=1781030145;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zLvOPs0ghY4l5hGd2RKwtIGWTKHF3VuM9PzReYCmWxY=;
  b=nXHaduwRw4vQXjD583L8Ysdcl8glBFxUXGg1wLC+W44IgPyHGQN/HPLv
   1d0c95PKFUMzolfNmb8FwLiLMnXkFRf8LfX4vYpXUKzzVNKCCfNsb9A+e
   9zvu8lSrw2U5VyqdjqB+dk78mBOyV4/rYgZIs3zHAV6RN4S+kUjgG1yeQ
   Fizz65y/t9XMUDymrA9ymZB39AWQqHPAtSTwUWeRSIN/kegv9JATSHj2Q
   F7o9KplAiBEA/LhQST8T3bPPKuH7kuTVybL3MgJMQsPRQMlDaVh7TmgZV
   JVjlTeCOvrsJb8fbsuH7zGep9IWzzTQEuXhd0iUrLAWGV0OjBfZn/eBSC
   Q==;
X-CSE-ConnectionGUID: WbtSgwcPT3y0fC1nDEAN4w==
X-CSE-MsgGUID: 1GGt6OcoRXed6W9IQpApAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="55249747"
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="55249747"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 11:35:45 -0700
X-CSE-ConnectionGUID: 5HKr0V2/Re+Wfdc9x/+Xiw==
X-CSE-MsgGUID: 9qbeOhljT16gWObSnRDTKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="151732446"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 11:35:44 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 01/15] wifi: mac80211: avoid weird state in error path
Date: Mon,  9 Jun 2025 21:35:13 +0300
Message-Id: <20250609213231.ba2011fb435f.Id87ff6dab5e1cf757b54094ac2d714c656165059@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250609183527.3974138-1-miriam.rachel.korenblit@intel.com>
References: <20250609183527.3974138-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

If we get to the error path of ieee80211_prep_connection, for example
because of a FW issue, then ieee80211_vif_set_links is called
with 0.
But the call to drv_change_vif_links from ieee80211_vif_update_links
will probably fail as well, for the same reason.
In this case, the valid_links and active_links bitmaps will be reverted
to the value of the failing connection.
Then, in the next connection, due to the logic of
ieee80211_set_vif_links_bitmaps, valid_links will be set to the ID of
the new connection assoc link, but the active_links will remain with the
ID of the old connection's assoc link.
If those IDs are different, we get into a weird state of valid_links and
active_links being different. One of the consequences of this state is
to call drv_change_vif_links with new_links as 0, since the & operation
between the bitmaps will be 0.

Since a removal of a link should always succeed, ignore the return value
of drv_change_vif_links if it was called to only remove links, which is
the case for the ieee80211_prep_connection's error path.
That way, the bitmaps will not be reverted to have the value from the
failing connection and will have 0, so the next connection will have a
good state.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/mac80211.h | 2 ++
 net/mac80211/link.c    | 9 ++++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 82617579d910..27a665b49712 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -4466,6 +4466,8 @@ struct ieee80211_prep_tx_info {
  *	new links bitmaps may be 0 if going from/to a non-MLO situation.
  *	The @old array contains pointers to the old bss_conf structures
  *	that were already removed, in case they're needed.
+ *	Note that removal of link should always succeed, so the return value
+ *	will be ignored in a removal only case.
  *	This callback can sleep.
  * @change_sta_links: Change the valid links of a station, similar to
  *	@change_vif_links. This callback can sleep.
diff --git a/net/mac80211/link.c b/net/mac80211/link.c
index d40c2bd3b50b..cef37a0add2b 100644
--- a/net/mac80211/link.c
+++ b/net/mac80211/link.c
@@ -2,7 +2,7 @@
 /*
  * MLO link handling
  *
- * Copyright (C) 2022-2024 Intel Corporation
+ * Copyright (C) 2022-2025 Intel Corporation
  */
 #include <linux/slab.h>
 #include <linux/kernel.h>
@@ -368,6 +368,13 @@ static int ieee80211_vif_update_links(struct ieee80211_sub_if_data *sdata,
 			ieee80211_update_apvlan_links(sdata);
 	}
 
+	/*
+	 * Ignore errors if we are only removing links as removal should
+	 * always succeed
+	 */
+	if (!new_links)
+		ret = 0;
+
 	if (ret) {
 		/* restore config */
 		memcpy(sdata->link, old_data, sizeof(old_data));
-- 
2.34.1


