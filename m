Return-Path: <linux-wireless+bounces-4947-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D581B880BCA
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 08:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 107E81C2271C
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 07:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F972E40E;
	Wed, 20 Mar 2024 07:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O5SWzW6D"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935322CCD5
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 07:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710918867; cv=none; b=b8EQ+2zclWwL5jCYsg45cYZ3J9ZqWg11HnXyHzwaLs/f/6IZ4AwZd2O+n0QVb3qtqtvQTaeBpNLa0Tm9Xi8CLLVbtkG0eUSIAiozZ8/Q+f+jJCRVq7EOCJqO7sV3HbnzrGx2S3I1F24pjMM0dUjxMfHpxVcLkXwa1UaEQcODEZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710918867; c=relaxed/simple;
	bh=Oh/FWv3K/mVgkzq25lWsBxzlu55oL0B6MzEZgLlekqc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uP3iLGByLoCuL/DgZr3myMrUw4o950nANLYKDDMIalzzxOsP9L7Mp6aY0AdblFwyD+DG3ZfcAWtXUQs0wZkXF1NPrlXb0lXm6HBdvrefP1Ht2yC3l5RRjyyHAgNNAJCi5P/fDjt2DBjqI3/gJQFoXGnWi3LWMzbZMcxdgB3GrHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O5SWzW6D; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710918866; x=1742454866;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Oh/FWv3K/mVgkzq25lWsBxzlu55oL0B6MzEZgLlekqc=;
  b=O5SWzW6DcQU6b/IHuPy2mM7r9cqTNzhqi+dQuxoTmjFQrfgR1w3XcZRB
   byVPLtSS9fN0ODD3z3wd0mv/t3yFd1evfV7TYgs9m/fp7sS2ff83qk+m2
   VV1eX0m1EhRG7awQIR7FJn0WSSdxfZ4nZU0T9XC593O5w251hYG2weGWI
   6BDKxQwwZnWgbaK4RrAM560nJRvMb/XHNSzDvUpjfe7f3MhQeCXhK5Rxt
   k2YiJFQTGwKCslJksq/CmrQoUm+OV1aEin8K5G0SJGgDCjv1hj6BDuPFO
   9kyMwKFBREAQV34enK+sjHtGFyEBi8hxlZNc3nJUVufZfooVSnZMNbcdm
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="5763841"
X-IronPort-AV: E=Sophos;i="6.07,139,1708416000"; 
   d="scan'208";a="5763841"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 00:14:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,139,1708416000"; 
   d="scan'208";a="14477410"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 00:14:24 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Ayala Beker <ayala.beker@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 5/8] wifi: mac80211: don't select link ID if not provided in scan request
Date: Wed, 20 Mar 2024 09:14:02 +0200
Message-Id: <20240320091155.a6b643a15755.Ic28ed9a611432387b7f85e9ca9a97a4ce34a6e0f@changeid>
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

From: Ayala Beker <ayala.beker@intel.com>

If scan request doesn't include a link ID to be used for TSF
reporting, don't select it as it might become inactive before
scan is actually started by the driver.
Instead, let the driver select one of the active links.

Fixes: cbde0b49f276 ("wifi: mac80211: Extend support for scanning while MLO connected")
Signed-off-by: Ayala Beker <ayala.beker@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/scan.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/net/mac80211/scan.c b/net/mac80211/scan.c
index 0429e59ba387..977f8eb0a67b 100644
--- a/net/mac80211/scan.c
+++ b/net/mac80211/scan.c
@@ -707,19 +707,11 @@ static int __ieee80211_start_scan(struct ieee80211_sub_if_data *sdata,
 		return -EBUSY;
 
 	/* For an MLO connection, if a link ID was specified, validate that it
-	 * is indeed active. If no link ID was specified, select one of the
-	 * active links.
+	 * is indeed active.
 	 */
-	if (ieee80211_vif_is_mld(&sdata->vif)) {
-		if (req->tsf_report_link_id >= 0) {
-			if (!(sdata->vif.active_links &
-			      BIT(req->tsf_report_link_id)))
-				return -EINVAL;
-		} else {
-			req->tsf_report_link_id =
-				__ffs(sdata->vif.active_links);
-		}
-	}
+	if (ieee80211_vif_is_mld(&sdata->vif) && req->tsf_report_link_id >= 0 &&
+	    !(sdata->vif.active_links & BIT(req->tsf_report_link_id)))
+		return -EINVAL;
 
 	if (!__ieee80211_can_leave_ch(sdata))
 		return -EBUSY;
-- 
2.34.1


