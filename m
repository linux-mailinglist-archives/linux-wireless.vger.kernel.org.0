Return-Path: <linux-wireless+bounces-21869-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73641A97E52
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 07:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D499D7ACE8D
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 05:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0588F266B61;
	Wed, 23 Apr 2025 05:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jVL3L10G"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90ED266B4C
	for <linux-wireless@vger.kernel.org>; Wed, 23 Apr 2025 05:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745387464; cv=none; b=bkHOgwOI1R7dimaSa8lUR8zJjGv1d+uItciP/VcuKslHg8Z/LayoU9dxqt9lw560IaUl4RORS6keJKbl+Ku5OTxiZJYGwZP1ZAWoYUB3FhH1jJgNM74yxSpeRZCYKk9J3qt1DArXcx/wy2CB43jO+7acFhs040BaLx/kUf+OcNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745387464; c=relaxed/simple;
	bh=9iMzZFYH77hQZH4clEdGsh0IA21gqz3IWXYP8hKdjBA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gV98x20h7WXvv406gSFRqprMefB55UqKqjNB0cY+90JhcmLu3an4zv2iiUWYyzm4PmgnkfjeeuoVXt5G5EStcjw+8/pWL5DvE3LNDlog0IHpjUhK51rXIg7qh/M2zrI91Iwvslr6qXj6fKK5+NrRL81JeREhepENNkPQ40APkFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jVL3L10G; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745387463; x=1776923463;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9iMzZFYH77hQZH4clEdGsh0IA21gqz3IWXYP8hKdjBA=;
  b=jVL3L10GXnFzOH2yBgrT0crlM5/QgfmZXxG00i9W+co7vxaJqZVN0QHT
   hsyjQHCWOnuuO8DJPwuKbrkAiv9mMQsiL07+3AkM52rs6d/7c8LQvn5Sc
   WlhbfWRLA66vzRCDgwhYw3Y/RYbGfr2dob6r4KqIIqJJOHh3917HRZtJ3
   FMsDVaVwalbECgK/U3ITqZcoMDmFElxwvIOygHaXi9WJAcyAg//OWPxGt
   XTHUC6RvvEUR1da3CyO935O5a21UeRLYe2k8+KAuSCG9C+mA3fF1VUu7L
   sDafnnqHgNjSrrATB9qC8D1pqKij1aN+tscgxDIJnV54+AQUdJTENktxJ
   g==;
X-CSE-ConnectionGUID: e85+xnkeQMylRm59KWyV4A==
X-CSE-MsgGUID: vMG/FKjzSY6xS8QAbyK+Eg==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="46844633"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="46844633"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 22:51:03 -0700
X-CSE-ConnectionGUID: R8l8PE54RTaxtzOOmrattA==
X-CSE-MsgGUID: lFIpD+NBRu68YvYw+EVALg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="133164339"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 22:51:01 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Daniel Gabay <daniel.gabay@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless 09/17] wifi: iwlwifi: mld: don't do iwl_trans_stop_device twice
Date: Wed, 23 Apr 2025 08:50:28 +0300
Message-Id: <20250423084826.f7d86be570d3.Ied68f0c4d126b3b0f1ffd9990bbc43d97f098e24@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250423055036.2262960-1-miriam.rachel.korenblit@intel.com>
References: <20250423055036.2262960-1-miriam.rachel.korenblit@intel.com>
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


