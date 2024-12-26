Return-Path: <linux-wireless+bounces-16812-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C749FCBA6
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Dec 2024 16:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 556731883266
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Dec 2024 15:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842D81369BB;
	Thu, 26 Dec 2024 15:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GHPumL6k"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012781F94A
	for <linux-wireless@vger.kernel.org>; Thu, 26 Dec 2024 15:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735227925; cv=none; b=KXTMqVoUJENHU5V/p3QCjN4JFKrdh1hCFervy5BvtRaU9F+WwB/NE+LvqbBb9eCagDUiDyJ1KcrBIvGIou+V270Yp7iiDbMeHOxDWycpdfOUoSDrhxhfwbnimFi4zYWv03UOTrq3tHu+CvvcTE9PBcRTPPscjvVuiH71seajXus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735227925; c=relaxed/simple;
	bh=vV3sYvgq/smtvJWO4Y11v5xEHgydAnQnpoFSZoMWrFg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=imZ8Cfu/+SMnoCkqwUQZriIfKzM1/EBVicc6qai3GqzhdAX/rRuhtV2OPe42GmKxBTw6W0UTsVBF/Xhgvgu9zyjIRQtqcHC//JsICLa9Uq8R/0fUETJV4mhEop7jv3oBEGlrbRnwoouOSQFLYVx+sQ3z9ql1+inHghtdiZRm+Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GHPumL6k; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735227922; x=1766763922;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vV3sYvgq/smtvJWO4Y11v5xEHgydAnQnpoFSZoMWrFg=;
  b=GHPumL6kFxsp7/hgt0BS68P+gwqxmRkmx2dF+K+yCIUtTU/yogSUWvXj
   ZoKtAf3aICW+IG0d60hIvaMKIuj+8+McJZo1yWPaMf1jRKT50PLb1trvc
   zW1rcOQ9aPtk7P4Llddi3nOEMy8E2OaXnENomYvvdi4KZnING2/TrTF6a
   m5FH+Nul3ygKpzhvaGbSARKVCTj72z9B2NWwFlEnMWWF2vhQxuJayNdXY
   jBLOm6dHvM9f4I5ZLHZAOBzb8UOoVE1H8RA9/T9NdoLijsgH+NHY/tk0v
   JXVOA4NcFPFogQAYUdAmQjs6BFExtkU6bisKWfO9r/dcRK6vDEdA+h6ag
   Q==;
X-CSE-ConnectionGUID: xDDwHCsCQhevgsNE8uFSDA==
X-CSE-MsgGUID: ltEj7pD4Rrq+F7R51Yqx/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11296"; a="35878145"
X-IronPort-AV: E=Sophos;i="6.12,266,1728975600"; 
   d="scan'208";a="35878145"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2024 07:45:22 -0800
X-CSE-ConnectionGUID: earvXQMnQk+olNucZsN/eg==
X-CSE-MsgGUID: VjNRlYpAR++p71DkIfx/QA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,266,1728975600"; 
   d="scan'208";a="99777992"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2024 07:45:21 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 07/15] wifi: iwlwifi: support BIOS override for UNII4 in CA/US also in LARI versions < 12
Date: Thu, 26 Dec 2024 17:44:48 +0200
Message-Id: <20241226174257.672651ad849c.I67a00d9544c48ad964f8e998ebe8c168071c3d01@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241226154456.473690-1-miriam.rachel.korenblit@intel.com>
References: <20241226154456.473690-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

Commit ef7ddf4e2f94 ("iwlwifi: Add support for LARI_CONFIG_CHANGE_CMD v12")
added a few bits to iwl_lari_config_change_cmd::chan_state_active_bitmap
if the FW has LARI version >= 12.
But we also need to send those bits for version 8-11 if the FW is capable
of this feature (indicated with capability bits)
Add the FW capability bit, and set the additional bits in the cmd when
the version is 8 and the FW capability bit is set.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/file.h       | 5 +++--
 drivers/net/wireless/intel/iwlwifi/fw/regulatory.c | 8 +++++++-
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/file.h b/drivers/net/wireless/intel/iwlwifi/fw/file.h
index ae05227b6153..784667830816 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/file.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/file.h
@@ -384,7 +384,8 @@ typedef unsigned int __bitwise iwl_ucode_tlv_capa_t;
  *	to report the CSI information with (certain) RX frames
  * @IWL_UCODE_TLV_CAPA_FTM_CALIBRATED: has FTM calibrated and thus supports both
  *	initiator and responder
- * @IWL_UCODE_TLV_CAPA_MLME_OFFLOAD: supports MLME offload
+ * @IWL_UCODE_TLV_CAPA_BIOS_OVERRIDE_UNII4_US_CA: supports (de)activating UNII-4
+ *	for US/CA/WW from BIOS
  * @IWL_UCODE_TLV_CAPA_PROTECTED_TWT: Supports protection of TWT action frames
  * @IWL_UCODE_TLV_CAPA_FW_RESET_HANDSHAKE: Supports the firmware handshake in
  *	reset flow
@@ -474,7 +475,7 @@ enum iwl_ucode_tlv_capa {
 	IWL_UCODE_TLV_CAPA_DBG_BUF_ALLOC_CMD_SUPP	= (__force iwl_ucode_tlv_capa_t)93,
 
 	/* set 3 */
-	IWL_UCODE_TLV_CAPA_MLME_OFFLOAD			= (__force iwl_ucode_tlv_capa_t)96,
+	IWL_UCODE_TLV_CAPA_BIOS_OVERRIDE_UNII4_US_CA	= (__force iwl_ucode_tlv_capa_t)96,
 
 	/*
 	 * @IWL_UCODE_TLV_CAPA_PSC_CHAN_SUPPORT: supports PSC channels
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
index 4d9a1f83ef8c..5e655adce926 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
@@ -564,7 +564,13 @@ int iwl_fill_lari_config(struct iwl_fw_runtime *fwrt,
 	if (!ret) {
 		if (cmd_ver < 8)
 			value &= ~ACTIVATE_5G2_IN_WW_MASK;
-		if (cmd_ver < 12)
+
+		/* Since version 12, bits 5 and 6 are supported
+		 * regardless of this capability.
+		 */
+		if (cmd_ver < 12 &&
+		    !fw_has_capa(&fwrt->fw->ucode_capa,
+				 IWL_UCODE_TLV_CAPA_BIOS_OVERRIDE_UNII4_US_CA))
 			value &= CHAN_STATE_ACTIVE_BITMAP_CMD_V11;
 
 		cmd->chan_state_active_bitmap = cpu_to_le32(value);
-- 
2.34.1


