Return-Path: <linux-wireless+bounces-22273-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77CD4AA4C71
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 15:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A30D1C22252
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 13:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589A4261388;
	Wed, 30 Apr 2025 12:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mE/wSgyi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A142A2609DE
	for <linux-wireless@vger.kernel.org>; Wed, 30 Apr 2025 12:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746017882; cv=none; b=ljkvApxy6sVu+RbeLRjQgPuKA2w9Pt1OMZw+6CKJ5J4O4IONz7d5TOvvKyLtpA5EIORS772horzW/Kl7oj7j2ToUq4nXj6fMrR2i0l9Ueqz8yc6y7KV863Jynw9NwLcHRkzmb16QsTPihhKK7XlFUfwY3WPV1BkRVwBocQp+zoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746017882; c=relaxed/simple;
	bh=MVxNJDFo6dElaGJy7BvZfd8Z3cl5DRFOWTVq89KxR44=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F4fenKjqORUXfskDLOUz6dWn4xnCeUTM2k12xKu3d5wiScyEDDDlpCOtMG0WCHRLgONqi4ONm5jpWWmw8ru958/adrVE8H2YFhDU46bheXia8okHK1fONPtyZXTgHhbnQQXWL/f9ZMgAIQoLB84B7Oj8l/1cm4TwQkJjX2gVrIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mE/wSgyi; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746017881; x=1777553881;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MVxNJDFo6dElaGJy7BvZfd8Z3cl5DRFOWTVq89KxR44=;
  b=mE/wSgyifCZPVr3VpQsMh0oNYJB98F71g13aMg0KP4WzJSosxBHaoNi9
   TfmFKoRcVm3LV0LnUiCVQIUm1Zwa1n82lhsQCcdRqLcJzJAkWoiGb1kHC
   un0my7AlGSQ8aThcXO21jv+aP9kA/bMItc0OcEhig2dLWDqMppgevEht5
   VcD9na8tOyEOJY0glk0nbduXaEs62bfcmHvM3obDu/Q429Q7pqwL9KVIV
   Lfi0SKjFGgxc1nA1G+vMlx5GhoQ/W1D+87ldnCxhVpCr3mqoxDo6xEWwF
   TXk/TjJqkMRO5Z3m30gBw08MQeN+H5+n9glTTHokTyV2N723krZbcLRRu
   Q==;
X-CSE-ConnectionGUID: KWh4cRJpS5uiFTSyzkl0+A==
X-CSE-MsgGUID: NGNVOJ8IQmGPFAD7d4ltDw==
X-IronPort-AV: E=McAfee;i="6700,10204,11419"; a="58332351"
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="58332351"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 05:58:00 -0700
X-CSE-ConnectionGUID: 89Vxkvj+Q6uy9MFNhInXng==
X-CSE-MsgGUID: cQ8eEHuLQbCaSqHm3JzLNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="134632126"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 05:57:59 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-next 12/15] wifi: iwlwifi: mld: fix BAID validity check
Date: Wed, 30 Apr 2025 15:57:26 +0300
Message-Id: <20250430155443.984f5057db58.Ied236258854b149960eb357ec61bf3a572503fbc@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250430125729.1122751-1-miriam.rachel.korenblit@intel.com>
References: <20250430125729.1122751-1-miriam.rachel.korenblit@intel.com>
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


