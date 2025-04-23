Return-Path: <linux-wireless+bounces-21890-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9337A97F08
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 08:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BF7B7A789A
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 06:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BC0266EF9;
	Wed, 23 Apr 2025 06:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m4oNiGw7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9B2266B70
	for <linux-wireless@vger.kernel.org>; Wed, 23 Apr 2025 06:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745389028; cv=none; b=H77qRQ8bKeuqBkbtN2M6S0AIiNWw3dBiDAQ05G7A5gIGtVZMwGpR5xkfHeIF0vYerIEJ4agYDwEg+OJmIblRuufB5Mz3pSTJbZuhbZ6iYQUksZierdhX0UvSXLyeLQueBHhzN6RFu6iAKXQpW101DlBgr15XpEZN70zYXtcn0js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745389028; c=relaxed/simple;
	bh=9iMzZFYH77hQZH4clEdGsh0IA21gqz3IWXYP8hKdjBA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Mk3qby7Ey/urmsrFONImNMNRKOPZpmTlckb8cbe30yWfle7MzbkCKymzaHUbSK/pmStX2cnROLV/f96FcUqLkzI37qCXhl72IKqxflLRxN8pRUZf6EaCDfhFdV00U5o1RJ/aLrJqWXpuWM4kPzZTBW0wdOyivlp4hUEppcV3kec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m4oNiGw7; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745389027; x=1776925027;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9iMzZFYH77hQZH4clEdGsh0IA21gqz3IWXYP8hKdjBA=;
  b=m4oNiGw7EELvB2IMfdwGd8g+uYHaNCJvdkGHZEDOCRZr3BVxU8f4jnoW
   UXot3OgqrX6pGHkqPyRfJXV3L/hN/0MuAuJgQ7KTiPFaPqlJWdU9+e75D
   vmaqv7EAu+eROku4ZESdBOStF+xkGggkFnq0DBcgFLaAwectirEO22zTW
   2wipD3molp1uXvA8ecA5d+VG9zZMT6n0tQdIRAqBXr0e/86G2eLMeS+XP
   SR1OBE1wU+X2ibtRyc8N3UGkQuu90zYjAsdzSqSibnHWxkW5ZKCPO4zFS
   P9xvXJVmr+kgujLC5ypsRvF7G0UQgHYUT8TJwRNvWZwNApqyjJNjbz6By
   Q==;
X-CSE-ConnectionGUID: 83rNbm9aQqWzIX7KlO1IdA==
X-CSE-MsgGUID: yln1KK0MQCCRW0uQQQeJuA==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="46843639"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="46843639"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 23:17:07 -0700
X-CSE-ConnectionGUID: TI/H8bM2QP2Q+GFpaxm/ww==
X-CSE-MsgGUID: tk5nFQNIRW+FTjgAXfwqEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="163269054"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 23:17:06 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Daniel Gabay <daniel.gabay@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 09/15] wifi: iwlwifi: mld: don't do iwl_trans_stop_device twice
Date: Wed, 23 Apr 2025 09:16:35 +0300
Message-Id: <20250423091408.f7d86be570d3.Ied68f0c4d126b3b0f1ffd9990bbc43d97f098e24@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250423061641.2302908-1-miriam.rachel.korenblit@intel.com>
References: <20250423061641.2302908-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

If iwl_mld_load_fw failed, we call iwl_mld_stop_fw which does, among the
others, iwl_trans_stop_device. But this is already called from
iwl_mld_load_fw's error path.

Since we do need the other stuff of iwl_mld_stop_fw to be done also in
the error path of iwl_mld_load_fw, just call it there.

This also makes the call to iwl_fw_flush_dumps in
iwl_mld_op_mope_start redundant, since it is the same as iwl_fw_dbg_stop_sync.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Daniel Gabay <daniel.gabay@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/fw.c  | 4 ++--
 drivers/net/wireless/intel/iwlwifi/mld/mld.c | 1 -
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/fw.c b/drivers/net/wireless/intel/iwlwifi/mld/fw.c
index 511df49672b5..76bf83549407 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/fw.c
@@ -327,7 +327,7 @@ int iwl_mld_load_fw(struct iwl_mld *mld)
 
 	return 0;
 err:
-	iwl_trans_stop_device(mld->trans);
+	iwl_mld_stop_fw(mld);
 	return ret;
 }
 
@@ -502,7 +502,7 @@ int iwl_mld_start_fw(struct iwl_mld *mld)
 	ret = iwl_mld_load_fw(mld);
 	if (IWL_FW_CHECK(mld, ret, "Failed to start firmware %d\n", ret)) {
 		iwl_fw_dbg_error_collect(&mld->fwrt, FW_DBG_TRIGGER_DRIVER);
-		goto error;
+		return ret;
 	}
 
 	IWL_DEBUG_INFO(mld, "uCode started.\n");
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mld.c b/drivers/net/wireless/intel/iwlwifi/mld/mld.c
index 8d788af8dcc8..2f5b6dc8bc62 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mld.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mld.c
@@ -425,7 +425,6 @@ iwl_op_mode_mld_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 	if (ret) {
 		wiphy_unlock(mld->wiphy);
 		rtnl_unlock();
-		iwl_fw_flush_dumps(&mld->fwrt);
 		goto free_hw;
 	}
 
-- 
2.34.1


