Return-Path: <linux-wireless+bounces-30658-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D24D0F871
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Jan 2026 18:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D217C305A2F4
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Jan 2026 17:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9BA921ABBB;
	Sun, 11 Jan 2026 17:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TKiFza++"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B0A34D3AD
	for <linux-wireless@vger.kernel.org>; Sun, 11 Jan 2026 17:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768153190; cv=none; b=bTfwbUvLrCxhIZE2yCuQhQ0Ew0FoIaLtcF4ZEenP5y2eMM2ftbICcm0V+1KXjIkR3YkvvVx8ytNB3HbROuygYMAHlqg1MV//PJ5sajMZgBXTn68VNywYrn4Q+NYcaFwMxp35FWRi+Z/cDV/OUY0zVpqLWoDdp9bE+Xok3eH3fhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768153190; c=relaxed/simple;
	bh=GzUqG2antwo7yg1mnJyZ2HZllUAJG/2ltB9XipypnPw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jFV5e6usmR2PRfwI/pscI6EUUBBX97tbz4P49rTr8DuPTV/FizJsSe8Z601Gk7zTEq+p5WTKXXS3kidjKvzjqcY+bGus6IBP1Lw0saxYdbL/8sKeHQxueJCRZ7nvKCeABg8M66Ud2JkXG9ShOVNkIGHJyJwg0BMn2kT5AB5WsPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TKiFza++; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768153189; x=1799689189;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GzUqG2antwo7yg1mnJyZ2HZllUAJG/2ltB9XipypnPw=;
  b=TKiFza++jrsY5aBpbbi/AgC8uyvgoxMgwsHqdjetmnke1TJHGzKvkMKB
   mLK94+YVUOGHg0KgvwiIT1IfR38XBsMclmuT6GW6ZUBqKokpPWANsNb1H
   ChO7sbl1Kp+5Byv8ALXTFWbG3FG5QTTnd0avbOGiaSVca8q5o+VGtFpop
   sPB8r5LdNyQ/P2N15HIa6NK93uQB1kDK8tT1Ap0LZ6r0uFMdnrpYkV2dn
   YqO8aILlWTVTJCybE0ZheMi6Nsx4jhAcjcAJOw1gotf99s6dT/Ffr6RJl
   0/JUV7Q77fs2I8xoLBBW57ZeWoeQcLnFyelzjR4S0qp6DvQv8JRnA02U0
   A==;
X-CSE-ConnectionGUID: TicArAfXSJ24BfA6Un32kQ==
X-CSE-MsgGUID: WT3J3SBcTAi2RxJJ8X6M1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11668"; a="69521094"
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="69521094"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2026 09:39:49 -0800
X-CSE-ConnectionGUID: 2qnBCxWyTJiVV0T3UDeY/A==
X-CSE-MsgGUID: GKSg7x0tQxWdklr2V33Abg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="208393809"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2026 09:39:48 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-next 11/15] wifi: iwlwifi: split bios_value_u32 to separate the header
Date: Sun, 11 Jan 2026 19:39:22 +0200
Message-Id: <20260111193638.2f191a5f33fe.I7797134967b980bbda9ba29daa360e50a2196d7d@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260111173926.2216629-1-miriam.rachel.korenblit@intel.com>
References: <20260111173926.2216629-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

This header will be reused in other firmware API structures

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/nvm-reg.h  | 16 ++++++++++++----
 .../net/wireless/intel/iwlwifi/fw/regulatory.c   |  6 ++++--
 drivers/net/wireless/intel/iwlwifi/mld/debugfs.c |  6 +++---
 .../net/wireless/intel/iwlwifi/mld/regulatory.c  |  8 ++++----
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c      |  5 +++--
 5 files changed, 26 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
index 4644fc1aa1ec..48f407baed39 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
@@ -503,18 +503,26 @@ enum bios_source {
 };
 
 /**
- * struct bios_value_u32 - BIOS configuration.
+ * struct iwl_bios_config_hdr - BIOS configuration header
  * @table_source: see &enum bios_source
  * @table_revision: table revision.
  * @reserved: reserved
- * @value: value in bios.
  */
-struct bios_value_u32 {
+struct iwl_bios_config_hdr {
 	u8 table_source;
 	u8 table_revision;
 	u8 reserved[2];
+} __packed; /* BIOS_CONFIG_HDR_API_S_VER_1 */
+
+/**
+ * struct bios_value_u32 - BIOS configuration.
+ * @hdr: bios config header
+ * @value: value in bios.
+ */
+struct bios_value_u32 {
+	struct iwl_bios_config_hdr hdr;
 	__le32 value;
-} __packed; /* BIOS_TABLE_SOURCE_U32_S_VER_1 */
+} __packed; /* BIOS_CONFIG_DATA_U32_API_S_VER_1 */
 
 /**
  * struct iwl_tas_config_cmd - configures the TAS.
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
index 00f1c20a5a37..958e71a3c958 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
@@ -376,8 +376,10 @@ int iwl_fill_ppag_table(struct iwl_fw_runtime *fwrt,
 		num_sub_bands = IWL_NUM_SUB_BANDS_V2;
 		gain = cmd->v7.gain[0];
 		*cmd_size = sizeof(cmd->v7);
-		cmd->v7.ppag_config_info.table_source = fwrt->ppag_bios_source;
-		cmd->v7.ppag_config_info.table_revision = fwrt->ppag_bios_rev;
+		cmd->v7.ppag_config_info.hdr.table_source =
+			fwrt->ppag_bios_source;
+		cmd->v7.ppag_config_info.hdr.table_revision =
+			fwrt->ppag_bios_rev;
 		cmd->v7.ppag_config_info.value = cpu_to_le32(fwrt->ppag_flags);
 	} else {
 		IWL_DEBUG_RADIO(fwrt, "Unsupported PPAG command version\n");
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mld/debugfs.c
index b9c9cd3f44e4..5c2a2033b3fd 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/debugfs.c
@@ -244,7 +244,7 @@ static size_t iwl_mld_dump_tas_resp(struct iwl_dhc_tas_status_resp *resp,
 	}
 
 	pos += scnprintf(buf + pos, count - pos, "TAS Report\n");
-	switch (resp->tas_config_info.table_source) {
+	switch (resp->tas_config_info.hdr.table_source) {
 	case BIOS_SOURCE_NONE:
 		pos += scnprintf(buf + pos, count - pos,
 				 "BIOS SOURCE NONE ");
@@ -260,13 +260,13 @@ static size_t iwl_mld_dump_tas_resp(struct iwl_dhc_tas_status_resp *resp,
 	default:
 		pos += scnprintf(buf + pos, count - pos,
 				 "BIOS SOURCE UNKNOWN (%d) ",
-				 resp->tas_config_info.table_source);
+				 resp->tas_config_info.hdr.table_source);
 		break;
 	}
 
 	pos += scnprintf(buf + pos, count - pos,
 			 "revision is: %d data is: 0x%08x\n",
-			 resp->tas_config_info.table_revision,
+			 resp->tas_config_info.hdr.table_revision,
 			 resp->tas_config_info.value);
 	pos += scnprintf(buf + pos, count - pos, "Current MCC: 0x%x\n",
 			 le16_to_cpu(resp->curr_mcc));
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/regulatory.c b/drivers/net/wireless/intel/iwlwifi/mld/regulatory.c
index 92e6c0535501..7d11036f9e04 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/regulatory.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/regulatory.c
@@ -165,8 +165,8 @@ static int iwl_mld_ppag_send_cmd(struct iwl_mld *mld)
 {
 	struct iwl_fw_runtime *fwrt = &mld->fwrt;
 	union iwl_ppag_table_cmd cmd = {
-		.v7.ppag_config_info.table_source = fwrt->ppag_bios_source,
-		.v7.ppag_config_info.table_revision = fwrt->ppag_bios_rev,
+		.v7.ppag_config_info.hdr.table_source = fwrt->ppag_bios_source,
+		.v7.ppag_config_info.hdr.table_revision = fwrt->ppag_bios_rev,
 		.v7.ppag_config_info.value = cpu_to_le32(fwrt->ppag_flags),
 	};
 	int ret;
@@ -389,8 +389,8 @@ void iwl_mld_init_tas(struct iwl_mld *mld)
 	for (u8 i = 0; i < data.block_list_size; i++)
 		cmd.block_list_array[i] =
 			cpu_to_le16(data.block_list_array[i]);
-	cmd.tas_config_info.table_source = data.table_source;
-	cmd.tas_config_info.table_revision = data.table_revision;
+	cmd.tas_config_info.hdr.table_source = data.table_source;
+	cmd.tas_config_info.hdr.table_revision = data.table_revision;
 	cmd.tas_config_info.value = cpu_to_le32(data.tas_selection);
 
 	ret = iwl_mld_send_cmd_pdu(mld, cmd_id, &cmd);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 018f3396e955..a34ca8073ca8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1135,8 +1135,9 @@ static void iwl_mvm_tas_init(struct iwl_mvm *mvm)
 		for (u16 i = 0; i < data.block_list_size; i++)
 			cmd_v5.block_list_array[i] =
 				cpu_to_le16(data.block_list_array[i]);
-		cmd_v5.tas_config_info.table_source = data.table_source;
-		cmd_v5.tas_config_info.table_revision = data.table_revision;
+		cmd_v5.tas_config_info.hdr.table_source = data.table_source;
+		cmd_v5.tas_config_info.hdr.table_revision =
+			data.table_revision;
 		cmd_v5.tas_config_info.value = cpu_to_le32(data.tas_selection);
 	} else if (fw_ver == 4) {
 		cmd_size = sizeof(cmd_v2_v4.common) + sizeof(cmd_v2_v4.v4);
-- 
2.34.1


