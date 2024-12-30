Return-Path: <linux-wireless+bounces-16892-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C78C9FE282
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Dec 2024 05:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A3AE1881C39
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Dec 2024 04:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63357176AA1;
	Mon, 30 Dec 2024 04:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QgHtSsdN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF713188713
	for <linux-wireless@vger.kernel.org>; Mon, 30 Dec 2024 04:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735534583; cv=none; b=bMJZvQofz4BsI5ie98o0mPBszoNvVXi3VA0bwEopZRCAiChsr4VuIwE3du0QWCALRlqmmFaeYqyhJ4slEuXAXncuflpZSsDbZDt1yV191+ndO+/pzL+9McjVT+5sAqD1RokGTaPdcFFbAtlpH/p/OUNjkRqPZMhM4DYZDFUP34A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735534583; c=relaxed/simple;
	bh=/24k+PXjiES+vGDf7B9sAYUYuO+KxcWBKq2Gm7lJZA0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O9guv6jr5EoNxRYNlDAGZuBDcLJmZsPbMDrGBUSWC1vK7ISkw3gO8M64cpdVMYjjNoRtYWkHdUjn6OHkNMMtVT/phXJc8epvmW6rjritdjY0bq264NwPEyFdvUbfBDQOcCVo6elqIPyXeyXXETANHte5G7jpC9+eZT+xC0z8UHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QgHtSsdN; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735534582; x=1767070582;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/24k+PXjiES+vGDf7B9sAYUYuO+KxcWBKq2Gm7lJZA0=;
  b=QgHtSsdNR2cR1OTayaxzArtnRZSMRRyNA6BERlYbFwIPm3mmxxWKuVSQ
   HmKddx/IS6JNyYJ6EfT6/dGkHk/oby1mg6XHmFaZX8C71Req5bbKYMI+4
   GLhvzaUobgR+kTzJ2xGLN2ptn3PBYj612UDzvZi8XQbMFh7cLyZFEkyY1
   jhl91fISvANgQPChr3CxeNWmk9mPMARr+Qp/ZN9QZBsFLTrnBeQGs9adM
   g7IFX2FL1+7Nbj2M4BmfTI17T3lKGSyQ9dZ7gl5ZgD7jg2Whpg676Ey7H
   5bnp4vuVxXTCe6ggAmJYf6BayPnF08Wg8jNI7omlUeb07eXxNjDwcQ1OB
   A==;
X-CSE-ConnectionGUID: 49N5wkI/Tqm2JhQGXd0P7g==
X-CSE-MsgGUID: A/L0LjA4Sm2dsCxulP44Pw==
X-IronPort-AV: E=McAfee;i="6700,10204,11299"; a="46405023"
X-IronPort-AV: E=Sophos;i="6.12,275,1728975600"; 
   d="scan'208";a="46405023"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2024 20:56:22 -0800
X-CSE-ConnectionGUID: WRzqpoLGSF6Xa0dWDG/YOQ==
X-CSE-MsgGUID: N+HBmuGQTLiOWxyCPqZXkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="104758907"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2024 20:56:20 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 09/15] wifi: mac80211: Remove unused basic_rates variable
Date: Mon, 30 Dec 2024 06:55:48 +0200
Message-Id: <20241230065327.23a86a9bad0c.If79bc2c1c98d01cfb4c7e93c18b198fe6c6ea44c@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241230045554.3746143-1-miriam.rachel.korenblit@intel.com>
References: <20241230045554.3746143-1-miriam.rachel.korenblit@intel.com>
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


