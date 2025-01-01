Return-Path: <linux-wireless+bounces-16959-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3971B9FF2DA
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jan 2025 06:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 084237A17B3
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jan 2025 05:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11CA16426;
	Wed,  1 Jan 2025 05:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fOxsjC1G"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2C7DF60
	for <linux-wireless@vger.kernel.org>; Wed,  1 Jan 2025 05:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735707967; cv=none; b=nRxomrhjamy0lkPeGXEpt7lW8YDYUJXpSQU+mmCUiAX6n1S5Oy+DCLKXIrGxBvVVD5bdKqD4dcLiR7k27qA+Cv3uV5gvgrBPO0RtebENFz+g0jDt2qokRNVuYS+Xg7zNcR+4WrjFWgOMD8cmfTs8qjbM6th2wAwP5P1snWt4p2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735707967; c=relaxed/simple;
	bh=/24k+PXjiES+vGDf7B9sAYUYuO+KxcWBKq2Gm7lJZA0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P/DRD0VHsCrTtYyfSkjPnH4iaJOOP2Cu53C1pJKMLoPeH+ZoNigVCntBZzP5nO/0p/bEsGz+BvXFWuq3SF1COzwa5pUDl0vWfKI6+w2b9b58lwg+JQyL6Bv0U8iEJE7TGya1OO+idNMJvw/R8y7CkkdxTufdWpVdNvsAbzR06vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fOxsjC1G; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735707966; x=1767243966;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/24k+PXjiES+vGDf7B9sAYUYuO+KxcWBKq2Gm7lJZA0=;
  b=fOxsjC1GMH/UOkxcuyzZzuVNm0Y/P5Vb4R2sP7ZBcL8x+/LJZloxX2kX
   1vWiHJVavvEE2NPx+rtdX5S9ywjnA5FuJ4tR1Qe3iKM7+Aw1HH9bxtcZL
   Sm8A6pndtzk6PGreZ/jHBdI3Op37szKAYfuMMemwJP77cu/UIpV4fLM7G
   hNrE7JfSY0wBvA5vcbI/pI31qi3acK7wC+XFmZCZD2p/BU2ByrKMpqUNk
   TL2ApnhFifQ9R3fU2E1XE7ymbLdhQ4J12CnICZra6j6newyfbJYbRlR5Q
   a7DaRvJxwyM5r4t1Bb3corLURQLgGZg6L4OGGZRL98WpBk+cHJFMuK9cw
   g==;
X-CSE-ConnectionGUID: shAsgbjgRju6fbUiK9EDWg==
X-CSE-MsgGUID: rPCqUkiiTsmOckgGgBARaA==
X-IronPort-AV: E=McAfee;i="6700,10204,11302"; a="36194422"
X-IronPort-AV: E=Sophos;i="6.12,281,1728975600"; 
   d="scan'208";a="36194422"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2024 21:06:06 -0800
X-CSE-ConnectionGUID: l9GIt6ZSQYGaOh2RSraXgQ==
X-CSE-MsgGUID: MtZkbv0iSj6MhAfqO68J8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,281,1728975600"; 
   d="scan'208";a="101618908"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2024 21:06:05 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 09/19] wifi: mac80211: Remove unused basic_rates variable
Date: Wed,  1 Jan 2025 07:05:29 +0200
Message-Id: <20250101070249.23a86a9bad0c.If79bc2c1c98d01cfb4c7e93c18b198fe6c6ea44c@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250101050539.1718643-1-miriam.rachel.korenblit@intel.com>
References: <20250101050539.1718643-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

The basic_rates variable was passed to mesh_sta_info_init as an out
parameter even though the result is not used. Passing NULL instead is
safe here, so do that.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/mesh_plink.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/mesh_plink.c b/net/mac80211/mesh_plink.c
index 6ea35c88dc48..5a0156e11c91 100644
--- a/net/mac80211/mesh_plink.c
+++ b/net/mac80211/mesh_plink.c
@@ -432,15 +432,14 @@ static void mesh_sta_info_init(struct ieee80211_sub_if_data *sdata,
 {
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_supported_band *sband;
-	u32 rates, basic_rates = 0, changed = 0;
+	u32 rates, changed = 0;
 	enum ieee80211_sta_rx_bandwidth bw = sta->sta.deflink.bandwidth;
 
 	sband = ieee80211_get_sband(sdata);
 	if (!sband)
 		return;
 
-	rates = ieee80211_sta_get_rates(sdata, elems, sband->band,
-					&basic_rates);
+	rates = ieee80211_sta_get_rates(sdata, elems, sband->band, NULL);
 
 	spin_lock_bh(&sta->mesh->plink_lock);
 	sta->deflink.rx_stats.last_rx = jiffies;
-- 
2.34.1


