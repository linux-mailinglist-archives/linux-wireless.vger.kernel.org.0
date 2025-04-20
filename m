Return-Path: <linux-wireless+bounces-21757-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 230C6A946DF
	for <lists+linux-wireless@lfdr.de>; Sun, 20 Apr 2025 09:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 308593B77C0
	for <lists+linux-wireless@lfdr.de>; Sun, 20 Apr 2025 07:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3EF1B532F;
	Sun, 20 Apr 2025 07:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NXuEu94h"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFDC1C6FFB
	for <linux-wireless@vger.kernel.org>; Sun, 20 Apr 2025 07:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745132424; cv=none; b=tYbTQVG2qG/JxUo6FwU7ZeUhCqkUHUTxz0N6HM9rtBoMnYHj8wmxBgL0TIkq5puTFGNNjJfGGapVquIHC9fAO4/30iPNNKMW0dKWGclpK1dXXrlcvxAhkO11ffFoRA15AMxxI0AiQu0BL+9XLZaCguOqV/WstuGrY3g1CoflyxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745132424; c=relaxed/simple;
	bh=WChuQTVvX1kw2Limsvm+3dVOZQVaF5GqDlLn8j6xm2M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rXeF3U9C+884hGPcOdRERmsGtGW48gzTNBJfKRFR3JMEzdFw+8DEShXnTIRrrWixLi6dQ+/Atz+7YCrfaFAfxY2OXG0G8Yl4V+4iNt51M0dLuYhSrVIgJNJrHDKsMHqJ8F8VFaE7JqACYf1nfhXFJiX+KWkQiQ1uoIiGRGUA5Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NXuEu94h; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745132423; x=1776668423;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WChuQTVvX1kw2Limsvm+3dVOZQVaF5GqDlLn8j6xm2M=;
  b=NXuEu94hYKVTOXROiNtc+4Xj5IDewD0Isz7jp3uwTssf4X+4fk8UwVvd
   XiE1SSfQ2f1IJJaWb6ktv/2k1yjw3rUfTnFTCJifMOMzNggmXyp0febfi
   +2Oj4VF2gQCaQ3/GtSF2rRg/G5ufI4Fxc1uuVB/QS2+SAwmTaZ/PdCRL5
   P163tFSYchcvRuUA2m/IECj5HMHuWXO6U6wHaJTgXVjN/9gwKo+lQfliy
   K7qzmU6MMhwk92fE+fyRIHLMn30Log2EMsO7ZFmXbv2ethMvrVav688ID
   9/x0hZ2yq/rvRwUzJKQOdsKePAMOEzz1JcGVwO9VPDLnZbkjWcTnlDjDU
   g==;
X-CSE-ConnectionGUID: 5OmhCggkTLGHSWTRBhvvGg==
X-CSE-MsgGUID: Jm+FFVTnQfWgdsh54+Q+gg==
X-IronPort-AV: E=McAfee;i="6700,10204,11408"; a="46827921"
X-IronPort-AV: E=Sophos;i="6.15,225,1739865600"; 
   d="scan'208";a="46827921"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2025 00:00:22 -0700
X-CSE-ConnectionGUID: 6WDMKubMRjK5nKD1WimB2w==
X-CSE-MsgGUID: kjeyIgG8SzCSZKYIPHPY1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,225,1739865600"; 
   d="scan'208";a="154615750"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2025 00:00:20 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH wireless 5/7] wifi: iwlwifi: mld: fix BAID validity check
Date: Sun, 20 Apr 2025 09:59:59 +0300
Message-Id: <20250420095642.9c0b84c44c3b.Ied236258854b149960eb357ec61bf3a572503fbc@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250420070001.3406977-1-miriam.rachel.korenblit@intel.com>
References: <20250420070001.3406977-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Perhaps IWL_FW_CHECK() is a bit misnamed, but it just returns
the value of the inner condition. Therefore, the current code
skips the actual function when it has the BAID data and makes
it crash later when it doesn't. Fix the logic.

Fixes: d1e879ec600f ("wifi: iwlwifi: add iwlmld sub-driver")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/agg.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/agg.c b/drivers/net/wireless/intel/iwlwifi/mld/agg.c
index db9e0f04f4b7..687a9450ac98 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/agg.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/agg.c
@@ -124,9 +124,9 @@ void iwl_mld_handle_bar_frame_release_notif(struct iwl_mld *mld,
 
 	rcu_read_lock();
 	baid_data = rcu_dereference(mld->fw_id_to_ba[baid]);
-	if (!IWL_FW_CHECK(mld, !baid_data,
-			  "Got valid BAID %d but not allocated, invalid BAR release!\n",
-			  baid))
+	if (IWL_FW_CHECK(mld, !baid_data,
+			 "Got valid BAID %d but not allocated, invalid BAR release!\n",
+			 baid))
 		goto out_unlock;
 
 	if (IWL_FW_CHECK(mld, tid != baid_data->tid ||
-- 
2.34.1


