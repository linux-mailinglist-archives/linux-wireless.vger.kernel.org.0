Return-Path: <linux-wireless+bounces-25283-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14673B02090
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 17:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0BF07BCE23
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 15:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5482ED845;
	Fri, 11 Jul 2025 15:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jW84IgS0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4722ED873
	for <linux-wireless@vger.kernel.org>; Fri, 11 Jul 2025 15:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752248102; cv=none; b=WNGvmccRr3NkSo1wBSS3iSc16pqCrkr96/k4JWmj27WAcr7KxhdRTqKlMLRj36yIacLxwzybNeXIbnTXJ73/6aPWSrACPFhYHpzRhdl+oTSIfJfzU5rWw+iG6tzynS5TibyBK8qq39c2X+9GrBZ/7rvhJSMTak0KVpiyYtaDSBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752248102; c=relaxed/simple;
	bh=DwiL0OsaIujngDh9SLfdq9vDiOgEGwIG3ikTjbldeww=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=APUcuWv9SVCrKACebw5I27qTIgxoX9YmKs2J4rWyClhLyFjH/rZa8Cj9TGEBpFH4GTiWUBC/JhAakI3vDGG3rol8qta/aBycKZmWVCOQQeLedet19jUmu4Rt8F1GK0qPK1OpcttdROmwuktoSl7ect1suDDXiIJCZseGuMilnLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jW84IgS0; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752248101; x=1783784101;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DwiL0OsaIujngDh9SLfdq9vDiOgEGwIG3ikTjbldeww=;
  b=jW84IgS0g4D19ZHKRGsrxcJU6dXHioeYW+JIWwZ1/zyOVuNZJHXSh2x6
   NggQNrF2k45kijuHrcbxXEWrxY7Eh3Wyl8mKNES0ueJWlpbyOSpMzTDLu
   rBMGVuSIlMHyrJKEjOIrVDqYNZyZMLiT12Zd6Yydo6TdnDargJ0sy19hz
   JQUcnwIPYaRNFlB6j5WXsy8vyQTyyPC9/Naor9rtm/uxxPETC8JjeSkgf
   N4YF8cJNWlaHy1V+EIMrCz0gdYKjDJnsvJfe7GKz87tFcT0fIp6W+ZzKS
   cE85/r584zggO9gCPTy/NW8DvsHOjokjprNKD1a60SZkI19M+rdi8tTlo
   w==;
X-CSE-ConnectionGUID: abWv/zBtQdCPfzYdQG0I/Q==
X-CSE-MsgGUID: TH8ugG4CQkm68HRja7ojRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54264162"
X-IronPort-AV: E=Sophos;i="6.16,304,1744095600"; 
   d="scan'208";a="54264162"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 08:35:00 -0700
X-CSE-ConnectionGUID: fD5uLWcRQRWw24TtFAik/g==
X-CSE-MsgGUID: /rXHxHzTRsuMPRaMz+alwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,304,1744095600"; 
   d="scan'208";a="156485126"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 08:34:59 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 08/15] wifi: iwlwifi: mld: remove support for iwl_geo_tx_power_profiles_cmd version 4
Date: Fri, 11 Jul 2025 18:34:22 +0300
Message-Id: <20250711183056.faeb1e6bac2a.I1a29b16f59b67c103d1f91dedee27e04cd7fdfdd@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250711153429.3417098-1-miriam.rachel.korenblit@intel.com>
References: <20250711153429.3417098-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

iwlmld was planned to be used for HR/GF, which has version 4,
but it was decided at the end to use iwlmvm for HR/GF, so iwlmld only
needs to support version 5.
Remove version 4 support.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/intel/iwlwifi/mld/regulatory.c   | 43 +++++--------------
 1 file changed, 10 insertions(+), 33 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/regulatory.c b/drivers/net/wireless/intel/iwlwifi/mld/regulatory.c
index b82ddd629e24..75d2f5cb23a7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/regulatory.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/regulatory.c
@@ -71,40 +71,17 @@ void iwl_mld_get_bios_tables(struct iwl_mld *mld)
 static int iwl_mld_geo_sar_init(struct iwl_mld *mld)
 {
 	u32 cmd_id = WIDE_ID(PHY_OPS_GROUP, PER_CHAIN_LIMIT_OFFSET_CMD);
-	union iwl_geo_tx_power_profiles_cmd cmd;
-	u16 len;
-	u32 n_bands;
-	__le32 sk = cpu_to_le32(0);
-	int ret;
-	u8 cmd_ver = iwl_fw_lookup_cmd_ver(mld->fw, cmd_id,
-					   IWL_FW_CMD_VER_UNKNOWN);
-
-	BUILD_BUG_ON(offsetof(struct iwl_geo_tx_power_profiles_cmd_v4, ops) !=
-		     offsetof(struct iwl_geo_tx_power_profiles_cmd_v5, ops));
-
-	cmd.v4.ops = cpu_to_le32(IWL_PER_CHAIN_OFFSET_SET_TABLES);
-
 	/* Only set to South Korea if the table revision is 1 */
-	if (mld->fwrt.geo_rev == 1)
-		sk = cpu_to_le32(1);
-
-	if (cmd_ver == 5) {
-		len = sizeof(cmd.v5);
-		n_bands = ARRAY_SIZE(cmd.v5.table[0]);
-		cmd.v5.table_revision = sk;
-	} else if (cmd_ver == 4) {
-		len = sizeof(cmd.v4);
-		n_bands = ARRAY_SIZE(cmd.v4.table[0]);
-		cmd.v4.table_revision = sk;
-	} else {
-		return -EOPNOTSUPP;
-	}
+	__le32 sk = cpu_to_le32(mld->fwrt.geo_rev == 1 ? 1 : 0);
+	union iwl_geo_tx_power_profiles_cmd cmd = {
+		.v5.ops = cpu_to_le32(IWL_PER_CHAIN_OFFSET_SET_TABLES),
+		.v5.table_revision = sk,
+	};
+	int ret;
 
-	BUILD_BUG_ON(offsetof(struct iwl_geo_tx_power_profiles_cmd_v4, table) !=
-		     offsetof(struct iwl_geo_tx_power_profiles_cmd_v5, table));
-	/* the table is at the same position for all versions, so set use v4 */
-	ret = iwl_sar_geo_fill_table(&mld->fwrt, &cmd.v4.table[0][0],
-				     n_bands, BIOS_GEO_MAX_PROFILE_NUM);
+	ret = iwl_sar_geo_fill_table(&mld->fwrt, &cmd.v5.table[0][0],
+				     ARRAY_SIZE(cmd.v5.table[0]),
+				     BIOS_GEO_MAX_PROFILE_NUM);
 
 	/* It is a valid scenario to not support SAR, or miss wgds table,
 	 * but in that case there is no need to send the command.
@@ -112,7 +89,7 @@ static int iwl_mld_geo_sar_init(struct iwl_mld *mld)
 	if (ret)
 		return 0;
 
-	return iwl_mld_send_cmd_pdu(mld, cmd_id, &cmd, len);
+	return iwl_mld_send_cmd_pdu(mld, cmd_id, &cmd, sizeof(cmd.v5));
 }
 
 int iwl_mld_config_sar_profile(struct iwl_mld *mld, int prof_a, int prof_b)
-- 
2.34.1


