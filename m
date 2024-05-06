Return-Path: <linux-wireless+bounces-7210-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 583CC8BC80C
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 09:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97336B21565
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 07:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074EF1411CD;
	Mon,  6 May 2024 07:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y++LpdaB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796A913FD91
	for <linux-wireless@vger.kernel.org>; Mon,  6 May 2024 07:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714979105; cv=none; b=Wf8hqqxmd/WylLzo89IDwAp07r9EsacZH6Cp2h/bYkOgjqxufXSmcQAzbaohvJpRPX6I67Y7PBkJIkp5pzRDgwd760jY18g5jNPN3Pj0R8cM7dohP20zppnwMrizj/6XpG/22enrUmAQb077a+txY1lo/g6aXi2ra3YwCYt1/RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714979105; c=relaxed/simple;
	bh=AqQH/GmZLgWLn3OVToXxN/DbFag72mVpGqijOf7Fj74=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RPByD1+De+fbsEvAGZbZbwYuZKHSFxLp3Vx5l4+gVJhROzhqUVkZnYEmSJTWkjqHC9CDhFKaY/GjuIB4VcCUryQLLiFLB6cI/qSPqLFsOdCLzPUz6rhwYEnvwCvJtOtPSd3WIfWAqpcJmuHGQ+8ZkaWwvnbTZS/xiuz9DlRgvrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y++LpdaB; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714979105; x=1746515105;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AqQH/GmZLgWLn3OVToXxN/DbFag72mVpGqijOf7Fj74=;
  b=Y++LpdaBN2bOKqtOuqA/Sbd2SHsVf+imtFNbRwVuyarpS4mUFEVv1uWG
   DO+tivGgDtJSUhhR9fCt1i/7fl2KTWV3HMZtNHq1EwPLWOjJB9mHX1dKf
   qPGXdkTwQMB4xJ25J24mfVruMx3M1RRLMzw8c9u/2mSJT5E1YB06qbfKt
   oUyf3cn1bGaY+ETPFiGUQO4GtuVJGL2I2BnTxEqdYg0n78fhUGQVUHTi3
   jzeEKSK2EnatnRdMTTTpNhg0Gm74AcXIAiIeMxahKeLQQDd5wrmT1bNBP
   6d4PWJRvksXk/QrulwPfjR0ykhu3OfOruPqanYCWfpQEu0QbOX8JQ5D3B
   Q==;
X-CSE-ConnectionGUID: 6z4hE7tAT4qEEYK6atUz+A==
X-CSE-MsgGUID: +ZGgDS1STPqwl31bzfZ8XA==
X-IronPort-AV: E=McAfee;i="6600,9927,11064"; a="10638246"
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; 
   d="scan'208";a="10638246"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 00:04:50 -0700
X-CSE-ConnectionGUID: 0f6VkE8iS0ubl1y3gmygyQ==
X-CSE-MsgGUID: ZWFJwRsmTqKYtVPJcnSB5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; 
   d="scan'208";a="59264978"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 00:04:48 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	striebit <shaul.triebitz@intel.com>
Subject: [PATCH 12/15] wifi: iwlwifi: mvm: add beacon template version 14
Date: Mon,  6 May 2024 10:04:16 +0300
Message-Id: <20240506095953.76957de93810.I2c718b0d648f2559fe1337df39915c5e772856bc@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240506070419.1821330-1-miriam.rachel.korenblit@intel.com>
References: <20240506070419.1821330-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: striebit <shaul.triebitz@intel.com>

In version 14 tim_size became the offset of the
broadcast TWT IE.

Signed-off-by: striebit <shaul.triebitz@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/tx.h    | 13 +++++++++----
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |  7 +++++++
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h b/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
index d9e4c75403b8..bbd176d88820 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2012-2014, 2018-2023 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2024 Intel Corporation
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
 #ifndef __iwl_fw_api_tx_h__
@@ -793,7 +793,8 @@ enum iwl_mac_beacon_flags {
  * @reserved: reserved
  * @link_id: the firmware id of the link that will use this beacon
  * @tim_idx: the offset of the tim IE in the beacon
- * @tim_size: the length of the tim IE
+ * @tim_size: the length of the tim IE (version < 14)
+ * @btwt_offset: offset to the broadcast TWT IE if present (version >= 14)
  * @ecsa_offset: offset to the ECSA IE if present
  * @csa_offset: offset to the CSA IE if present
  * @frame: the template of the beacon frame
@@ -805,14 +806,18 @@ struct iwl_mac_beacon_cmd {
 	__le32 reserved;
 	__le32 link_id;
 	__le32 tim_idx;
-	__le32 tim_size;
+	union {
+		__le32 tim_size;
+		__le32 btwt_offset;
+	};
 	__le32 ecsa_offset;
 	__le32 csa_offset;
 	struct ieee80211_hdr frame[];
 } __packed; /* BEACON_TEMPLATE_CMD_API_S_VER_10,
 	     * BEACON_TEMPLATE_CMD_API_S_VER_11,
 	     * BEACON_TEMPLATE_CMD_API_S_VER_12,
-	     * BEACON_TEMPLATE_CMD_API_S_VER_13
+	     * BEACON_TEMPLATE_CMD_API_S_VER_13,
+	     * BEACON_TEMPLATE_CMD_API_S_VER_14
 	     */
 
 struct iwl_beacon_notif {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index 2718db5aa3f5..5a06f887769a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -1163,6 +1163,13 @@ static int iwl_mvm_mac_ctxt_send_beacon_v9(struct iwl_mvm *mvm,
 						   WLAN_EID_EXT_CHANSWITCH_ANN,
 						   beacon->len));
 
+	if (vif->type == NL80211_IFTYPE_AP &&
+	    iwl_fw_lookup_cmd_ver(mvm->fw, BEACON_TEMPLATE_CMD, 0) >= 14)
+		beacon_cmd.btwt_offset =
+			cpu_to_le32(iwl_mvm_find_ie_offset(beacon->data,
+							   WLAN_EID_S1G_TWT,
+							   beacon->len));
+
 	return iwl_mvm_mac_ctxt_send_beacon_cmd(mvm, beacon, &beacon_cmd,
 						sizeof(beacon_cmd));
 }
-- 
2.34.1


