Return-Path: <linux-wireless+bounces-18506-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26652A286CF
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 10:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93EFA7A4D39
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 09:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81AE222A7E2;
	Wed,  5 Feb 2025 09:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cLw8bErm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D975422A7F0
	for <linux-wireless@vger.kernel.org>; Wed,  5 Feb 2025 09:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738748414; cv=none; b=HBEKmU1i05hjElf843VmdFk4OMDr1FndSrDSNO6s4IrLHhrk2AxtBvZfx9KIRKjoxvsB8aaWQcoPzrk02T/RtdQ9Z04hxebmuBBj0+gslxrBYCXNsD4qWjKCyPfvIp4gyry/9SXT4YZ3LBdua85LGc2nGtkBhhxzv32LbH27gZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738748414; c=relaxed/simple;
	bh=m/a9o3Yx2H7oj7bY8oDoAFyc0eEVmoH0iduV7KW+vpk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q8frEzlG8R/SIjhOGUUkIWM0OoRzlxJXe4oiPd2nPoi2angG7CpIbE1CTESdbL0XZ0JUmiyZio46+tVQU26wFpI1MjgI+08IrW/wFIe00zYsCeMZcpuRLiEgb9EHlXxHZCRwsy9lVHOAWHEruqrKmypKxa+arNrGdT1kSuI+yLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cLw8bErm; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738748413; x=1770284413;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=m/a9o3Yx2H7oj7bY8oDoAFyc0eEVmoH0iduV7KW+vpk=;
  b=cLw8bErmA29CuXjIIv/NcJePEgzBglEeJxf3Ie8KQabJnxiVwUiYRAgb
   n0//ETZtRlpQ/acYbZBZ9Eu064og3x78Kj5KE8+0TvvN6GCrZdbK6FhoQ
   uAkchWGwByQfmrQxo01DLDF0o5h+z9bYcT5SGW/YxB6zuhy5eOZwzZie4
   y2ZiRzpsK0CoQbuQCCzC70sQBN4jFn4Lo6wnITlaCD7EpJO2Gw/j7rmXH
   gCpBSTHf/0JUidpBwV5saEd8LsxU6zfnu9q/btogoH6u+G3Q8P2wXec/R
   INgc7BecemxuwR57/UJmWLulzNFpAZAJGMWQhsSM3Rr+UApmAothGOFx5
   A==;
X-CSE-ConnectionGUID: XC3Nxj6CSImnP96wcXY4ig==
X-CSE-MsgGUID: rvh8UzPFTxCoDcIcrZJpxg==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="43225251"
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="43225251"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 01:40:05 -0800
X-CSE-ConnectionGUID: Fel64f2eRYSpddq2eSo6gw==
X-CSE-MsgGUID: 68esFMAySVCQ8rDWssIOtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="115845317"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 01:40:02 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 12/17] wifi: mac80211: don't unconditionally call drv_mgd_complete_tx()
Date: Wed,  5 Feb 2025 11:39:22 +0200
Message-Id: <20250205110958.e091fc39a351.Ie6a3cdca070612a0aa4b3c6914ab9ed602d1f456@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250205093927.1775858-1-miriam.rachel.korenblit@intel.com>
References: <20250205093927.1775858-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

We might not have called drv_mgd_prepare_tx(), so only call
drv_mgd_complete_tx() under the same conditions.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/mlme.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index bb3e42afd34e..1d118c30948d 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -3976,7 +3976,8 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 	if (tx)
 		ieee80211_flush_queues(local, sdata, false);
 
-	drv_mgd_complete_tx(sdata->local, sdata, &info);
+	if (tx || frame_buf)
+		drv_mgd_complete_tx(sdata->local, sdata, &info);
 
 	/* clear AP addr only after building the needed mgmt frames */
 	eth_zero_addr(sdata->deflink.u.mgd.bssid);
-- 
2.34.1


