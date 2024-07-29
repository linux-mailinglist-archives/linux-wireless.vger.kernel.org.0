Return-Path: <linux-wireless+bounces-10635-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 773E693FC5B
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2024 19:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC53D1F21DF2
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2024 17:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03228187562;
	Mon, 29 Jul 2024 17:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LChSqwGJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A7E187344
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jul 2024 17:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722273656; cv=none; b=nPRVbJPQZLhWf7MOTUYl5i84W9lqfsFrgD2jo2RsyN5LmHogUuCKLj/RGyU/p4/APW2MAlt5vkcPUdX3H6LgW6i5DgXCr5HMMnaz/WbjUSFkvtO87BvFqcLHtC7xSHUyP+9GgzXQ/SNy90vzg2W9q7RAA6U//vdkqiQHV+euaJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722273656; c=relaxed/simple;
	bh=xLS9R8w52sKtInvjm7Epu5MWSM+6den9RvygSLvDOLM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TBAYHfmHdBSieJfXuoFXxS5cY1P9od77o6gChPpwg+GmCzksyhUNEhENQqDMgOsg9YprpNZ8Mtax8UB6M9yls1qql4VZW9yHqKZuxMqosojbd526Mms6htp4/NNSYZ8xCfkqpyQEqpxDyyKjs464gs9j72FVnzwcNm5KIXNeokQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LChSqwGJ; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722273656; x=1753809656;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xLS9R8w52sKtInvjm7Epu5MWSM+6den9RvygSLvDOLM=;
  b=LChSqwGJBo/LnyAOtDtODln31uONKGmrKKm20yUg+RqdbR+AhdOGhR8Y
   kkoCML9b/GZTQHmx3e4H3vTIkL7yvALgl22ug+rZthxnaFXJaddtYcd7T
   XB8oRUA7wPSPfR8d1vaYCyfY9u6YSKqyWPmKq7XmBqGvKtBgYUk2W5M0A
   bDBPGRk8Bd4h2KjuRmtaour5bl3HffYxYyNPX63ttAfwz3gP32qLJZBdT
   dNPgSxEr/SbV6IvNmwxe4Qj0YwNpMP2wybYXk6qrvMMrK1+3HTklXPt2k
   QzF6EOecSIy5wjKL22NIdqHLIBjleGfcV9JXZIElGoa2QuX01i1JCBl8L
   Q==;
X-CSE-ConnectionGUID: WR3niSWKRNuzycchrXampA==
X-CSE-MsgGUID: m/gVWRbwQQKasHOyjGYNtg==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="31445633"
X-IronPort-AV: E=Sophos;i="6.09,246,1716274800"; 
   d="scan'208";a="31445633"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 10:20:55 -0700
X-CSE-ConnectionGUID: BxRNijnqRUed8qGCJDU9vg==
X-CSE-MsgGUID: aveS77HyT4GnNnV/JbFahw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,246,1716274800"; 
   d="scan'208";a="54288359"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 10:20:54 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 15/17] wifi: iwlwifi: mvm: add firmware debug points for EMLSR entry / exit
Date: Mon, 29 Jul 2024 20:20:16 +0300
Message-Id: <20240729201718.3a91e89e32f8.Ieb28d7756c47dee52c912a71abe82fa0b08b19da@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240729172018.1993751-1-miriam.rachel.korenblit@intel.com>
References: <20240729172018.1993751-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

This will help to dump the firmware logs at the right spot if needed.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h   | 4 ++++
 drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h b/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
index 855cd13a181e..550de6db1834 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
@@ -476,6 +476,8 @@ enum iwl_fw_ini_region_device_memory_subtype {
  * @IWL_FW_INI_TIME_POINT_PRESET_OVERRIDE_START: start handling override preset
  *	request
  * @IWL_FW_INI_TIME_SCAN_FAILURE: failed scan channel list
+ * @IWL_FW_INI_TIME_ESR_LINK_UP: EMLSR is active (several links are activated)
+ * @IWL_FW_INI_TIME_ESR_LINK_DOWN: EMLSR is inactive (only one active link left)
  * @IWL_FW_INI_TIME_POINT_NUM: number of time points
  */
 enum iwl_fw_ini_time_point {
@@ -509,6 +511,8 @@ enum iwl_fw_ini_time_point {
 	IWL_FW_INI_TIME_POINT_PRESET_OVERRIDE_EXT_REQ,
 	IWL_FW_INI_TIME_POINT_PRESET_OVERRIDE_START,
 	IWL_FW_INI_TIME_SCAN_FAILURE,
+	IWL_FW_INI_TIME_ESR_LINK_UP,
+	IWL_FW_INI_TIME_ESR_LINK_DOWN,
 	IWL_FW_INI_TIME_POINT_NUM,
 }; /* FW_TLV_DEBUG_TIME_POINT_API_E */
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index 3c99396ad369..ed30247de407 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -269,6 +269,9 @@ static int iwl_mvm_esr_mode_active(struct iwl_mvm *mvm,
 	 */
 	iwl_mvm_restart_mpdu_count(mvm, mvmvif);
 
+	iwl_dbg_tlv_time_point(&mvm->fwrt, IWL_FW_INI_TIME_ESR_LINK_UP,
+			       NULL);
+
 	return ret;
 }
 
@@ -456,6 +459,9 @@ static int iwl_mvm_esr_mode_inactive(struct iwl_mvm *mvm,
 	/* Start a new counting window */
 	iwl_mvm_restart_mpdu_count(mvm, mvmvif);
 
+	iwl_dbg_tlv_time_point(&mvm->fwrt, IWL_FW_INI_TIME_ESR_LINK_DOWN,
+			       NULL);
+
 	return ret;
 }
 
-- 
2.34.1


