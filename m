Return-Path: <linux-wireless+bounces-18815-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FC6A31E21
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 06:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD256162665
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 05:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828A41E1A05;
	Wed, 12 Feb 2025 05:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ast7oRss"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C591FAC3E
	for <linux-wireless@vger.kernel.org>; Wed, 12 Feb 2025 05:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739339044; cv=none; b=kmq8nRLmSYxaQGueIId2nxEeka695/SGx7TGeer0nfOu2RNMA3UAB1V9+AyZi9Ug/hfJZSTyxNYUUfct6PRhCPSNr0qqVUhAEl2Mdol09bmIUjh0mLMf5ulthf2Xap2ri7Lp9lYnG5Nh93uU/OBQ53ai2lxs97Hdr0uoV8K1iYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739339044; c=relaxed/simple;
	bh=5Ayg8iaUpgV9w+NnCX7Hd70+hJpk+X20hlasHZwgNfE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WZIPOim6HK4DhLj03m0Gsuv1okVXAUB4Mkw+b7ALEght0UKiUcXmwdPjMkbjLw9iB/DuAlHH3lDDfjgpaiHDeRbPMJEzrqx9Vd6qdfZs8M6sSeZoGhoUfnRMmkt0HgQ59qoxk42EAcwwAuK0Cqy2YUvo4xqVokk/UcN/YEg1YrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ast7oRss; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739339043; x=1770875043;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5Ayg8iaUpgV9w+NnCX7Hd70+hJpk+X20hlasHZwgNfE=;
  b=ast7oRss/8ncP2laDFSzal0l2Di++7aY4MdtwClTtTAgJTg8lmNC9/dM
   4xBirJYTez+dbc2rSIcVfOVKfcGoer63pvd+jMhjTVF9kpBUCu3i4OlL8
   j/PytzM5pbNd4eB1UPLOMiW+Mkju2nL5Bzf40ve0QVt/Yda3WV4H2908v
   b76AcergE7gNOtZW6vFLWF+S8HBPNA07uzNjv0Vz6arto33/w+d6rSrFW
   GKdPP5nI1nbsa/lKLi1UAB1KoPQEEVuokhwekrRedAeyoCrZG2VuA6/ZW
   7CN3ck7mXqwjolOVSE9pa1YzvWld9DYr22ggkvMfrgZf2djl+mk/b1EdZ
   w==;
X-CSE-ConnectionGUID: QW0BMiF1RiGw9luWz0lMjg==
X-CSE-MsgGUID: qoEb0hz9Qh+1tnYbByeUag==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="39172226"
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="39172226"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 21:44:02 -0800
X-CSE-ConnectionGUID: D1mP8+MLQDyVaQAnGuXQhg==
X-CSE-MsgGUID: rmNs6BBTSGicWIMqxNMe7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117893909"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 21:44:01 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 10/12] wifi: iwlwifi: add OMI bandwidth reduction APIs
Date: Wed, 12 Feb 2025 07:43:31 +0200
Message-Id: <20250212073923.4d34e8f5a3df.Idd6185cdb8d8a133f92032db9278c1510961cbdc@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250212054333.376219-1-miriam.rachel.korenblit@intel.com>
References: <20250212054333.376219-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

This adds the API definitions needed for OMI bandwidth reduction.
Will be used in a later patches.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/datapath.h  | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h b/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h
index 34a562d6c208..c139b965980d 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h
@@ -90,6 +90,12 @@ enum iwl_data_path_subcmd_ids {
 	 */
 	SEC_KEY_CMD = 0x18,
 
+	/**
+	 * @OMI_SEND_STATUS_NOTIF: notification after OMI was sent
+	 *	uses &struct iwl_omi_send_status_notif
+	 */
+	OMI_SEND_STATUS_NOTIF = 0xF2,
+
 	/**
 	 * @ESR_MODE_NOTIF: notification to recommend/force a wanted esr mode,
 	 *	uses &struct iwl_esr_mode_notif
@@ -688,4 +694,13 @@ struct iwl_sec_key_cmd {
 	} __packed u; /* SEC_KEY_OPERATION_API_U_VER_1 */
 } __packed; /* SEC_KEY_CMD_API_S_VER_1 */
 
+/**
+ * struct iwl_omi_send_status_notif - OMI status notification
+ * @success: indicates that the OMI was sent successfully
+ *	(currently always set)
+ */
+struct iwl_omi_send_status_notif {
+	__le32 success;
+} __packed; /* OMI_SEND_STATUS_NTFY_API_S_VER_1 */
+
 #endif /* __iwl_fw_api_datapath_h__ */
-- 
2.34.1


