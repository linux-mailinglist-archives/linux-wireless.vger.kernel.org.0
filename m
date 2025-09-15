Return-Path: <linux-wireless+bounces-27314-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E593EB57308
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Sep 2025 10:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6A071889508
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Sep 2025 08:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6862C2EF65B;
	Mon, 15 Sep 2025 08:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DC7vusbF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7C52EAD05
	for <linux-wireless@vger.kernel.org>; Mon, 15 Sep 2025 08:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757925305; cv=none; b=BQkoCV8KMxzuL2gcJdhv91KjR9PLp5BVxUlz1lLkQ0KrgzOkQSuKkGxbsbwQd5HOlVlo9aPJn0RO3RUUaW46yNRxazfuwnW9S6ullrTkQI1+A7TRMocwj/LWgfDjwHz53RMEZaj/8+E0sbXSaaVwwqaL7WSGqPoxx1TAGo4DmFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757925305; c=relaxed/simple;
	bh=02c5WfOuwVWCr0BsuwIFZLEGy77jH47qvEUis7tHi2c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ICxP/7IEFtpIfM1/9MmSHnGb9/f1ltyhw04QYg89oYfAUq+2mw1dBeLM6As7O+2hYPbn8amw0DeGxmLTvBBL81nFijbxfUZdXgtnSZLN7xvh+/JmDAkbqsElbUUGXviZFobrhv9Nk16ZKbKVsKKih89Trs0cMbxI/a9+DMpEml0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DC7vusbF; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757925304; x=1789461304;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=02c5WfOuwVWCr0BsuwIFZLEGy77jH47qvEUis7tHi2c=;
  b=DC7vusbFDwIwj+vYdU5rEdNS0XtSCf78pxTPFeTuYjCws0wH7hhoL5Y1
   belQ0Q1sbK/LMqJz+ejWFo8bPBCxGeH+z/1nhE7uUn3vg33DKUKJ9uUUx
   bSTefoQUd1TmvVTTi/o+EmuXUtxsV1vZ+fZgWHbXfv6ABBh6kQxQx3lLN
   A2R1Lc1l1r6PKIabjWwuK6ltTTRYeC62w1cB8HnTs0PFtSBNwkHeVQJVT
   VrekZgun14PmmX8bML+4+ruWqfRFs1ltwCDnaRW+bdnXWvYaP1kSuY8Ki
   tIx0QghceGcdF5Kpu8coHGkjiYDJipPp8Npo40ehZbZyTzQyt6Y/GyZvw
   w==;
X-CSE-ConnectionGUID: 3qJC5nO5QGagJDK0ZCsWKg==
X-CSE-MsgGUID: yoUtUGFLRm+aXUE5y2XZ/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11553"; a="59213070"
X-IronPort-AV: E=Sophos;i="6.18,265,1751266800"; 
   d="scan'208";a="59213070"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 01:35:04 -0700
X-CSE-ConnectionGUID: CPYwN3Q3Qt2B9mPJ9gX6pg==
X-CSE-MsgGUID: 8WTALFj9SOeQabbm8DWAUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,265,1751266800"; 
   d="scan'208";a="178569858"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 01:35:03 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-next 02/11] wifi: iwlwifi: mld: remove support from of alive notif version 6
Date: Mon, 15 Sep 2025 11:34:23 +0300
Message-Id: <20250915113137.4923c981b0bf.Iff598c6d109fdbf0d5a5bab59d53485478ecc125@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250915083432.1048608-1-miriam.rachel.korenblit@intel.com>
References: <20250915083432.1048608-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

The last FW API that supports version 6 is 97. Since this API is no
longer supported on any device that loads iwlmld, we can remove support
of it.

Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/fw.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/fw.c b/drivers/net/wireless/intel/iwlwifi/mld/fw.c
index bdb69c098fd1..b3abfa1ec810 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/fw.c
@@ -124,7 +124,6 @@ static bool iwl_alive_fn(struct iwl_notif_wait_data *notif_wait,
 	u16 status;
 
 	switch (version) {
-	case 6:
 	case 7:
 		expected_sz = sizeof(struct iwl_alive_ntf_v7);
 		break;
@@ -188,9 +187,8 @@ static bool iwl_alive_fn(struct iwl_notif_wait_data *notif_wait,
 		     le32_to_cpu(umac->umac_major),
 		     le32_to_cpu(umac->umac_minor));
 
-	if (version >= 7)
-		IWL_DEBUG_FW(mld, "FW alive flags 0x%x\n",
-			     le16_to_cpu(palive->flags));
+	IWL_DEBUG_FW(mld, "FW alive flags 0x%x\n",
+		     le16_to_cpu(palive->flags));
 
 	if (version >= 8)
 		IWL_DEBUG_FW(mld, "platform_id 0x%llx\n",
-- 
2.34.1


