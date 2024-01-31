Return-Path: <linux-wireless+bounces-2872-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B7E8438EA
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 09:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24B7A28BE2F
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 08:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0B4651B6;
	Wed, 31 Jan 2024 08:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LC05K5xI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06F2633E9
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jan 2024 08:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706689512; cv=none; b=k79hYFNoz7PWINFulbzHUNJHpYPWW0gOgRuE+kOE6cnnb6e3QcITrGjCq2vbBRrhzHisA6J5qX2iGsv3MgitbvJXLooxBaQ9IoFNNquVLR9KBBYMFoyP1b1LngJXfVmNbb0zDvYcg9jb+twZPQGiWyFEM1WY2717oVMMNhY6QwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706689512; c=relaxed/simple;
	bh=tc0di1PhuGYZXwG7kyfsf289SgmOERTOqCheYngDAf4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=euB2ylHc3VwhXi/y/3C1v7IyxtawRJc4O33X2OSN8dN2dm3Q498Ktx3Ku5j6AdioSnH606o5pvnPdKnJaqJmOlsI3C2Yvr8aJ1tUwd6qSpSuw9P9A8w4OLiR4r2wWWmJyl013xmZPDWWRwb5tbH18rnckC1EsNdFxa6w/Z0GxTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LC05K5xI; arc=none smtp.client-ip=134.134.136.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706689510; x=1738225510;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tc0di1PhuGYZXwG7kyfsf289SgmOERTOqCheYngDAf4=;
  b=LC05K5xIJLiYL/MTitR7vUSySKKJtRzc+PegtPcy27UN5NXwpAXCtfLe
   T9LT7KVLt8AC1FdpwTYB9f54527yZIEoXXbp2XjktrVo/lHaZuR7TRD1f
   5FkrZc6tK0zzJVKelASR0vpb2ZnLIxf8cA7J24Zd0AyE8cXROdaVRCJjN
   sqRrKiJffAc47nI0LatepWn1gvQFwKIbDWN4wlBhwF6Eoyrjvocef6n96
   eQJzjDM9Tp/P5pR8y9/w4vuwjCG9E4KkonepCnnMznMvio42Dj3mlg3RT
   W5GxbdNLvwjbcczOdDbTeW7yKJShWaM/2NHMXojz799P5nt4NNl1a/mN7
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="407249918"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="407249918"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 00:25:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="3968883"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 00:25:08 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 05/14] wifi: iwlwifi: cleanup sending PER_CHAIN_LIMIT_OFFSET_CMD
Date: Wed, 31 Jan 2024 10:24:38 +0200
Message-Id: <20240131091413.17a2384d4535.I306570874f1da0c6345066ebbf74a04b6c8aeb37@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240131082447.1372353-1-miriam.rachel.korenblit@intel.com>
References: <20240131082447.1372353-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

iwl_geo_tx_power_profiles_cmd::table_revision indicates whether
to use South Korea scheme or not.
We use South Korea scheme if the revision of WGDS table is 1.

We used to read the WGDS table from ACPI inside iwl_sar_geo_fill_table(),
so we had to set table_revision only after the call to it.
This added an extra if...else for each cmd version.

But it has been a while since we moved the BIOS tables reading to
INIT stage, and iwl_sar_geo_fill_table() is now only copying the
previously stored table to the cmd structure.

Set the table_revision before the call to iwl_sar_geo_fill_table()
and avoid that extra if...else.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c | 31 ++++++---------------
 1 file changed, 9 insertions(+), 22 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index f8ab31f9d109..f964452ba433 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1008,7 +1008,7 @@ static int iwl_mvm_sar_geo_init(struct iwl_mvm *mvm)
 	u16 len;
 	u32 n_bands;
 	u32 n_profiles;
-	u32 sk = 0;
+	__le32 sk = cpu_to_le32(0);
 	int ret;
 	u8 cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw, cmd_id,
 					   IWL_FW_CMD_VER_UNKNOWN);
@@ -1025,23 +1025,31 @@ static int iwl_mvm_sar_geo_init(struct iwl_mvm *mvm)
 	/* the ops field is at the same spot for all versions, so set in v1 */
 	cmd.v1.ops = cpu_to_le32(IWL_PER_CHAIN_OFFSET_SET_TABLES);
 
+	/* Only set to South Korea if the table revision is 1 */
+	if (mvm->fwrt.geo_rev == 1)
+		sk = cpu_to_le32(1);
+
 	if (cmd_ver == 5) {
 		len = sizeof(cmd.v5);
 		n_bands = ARRAY_SIZE(cmd.v5.table[0]);
 		n_profiles = BIOS_GEO_MAX_PROFILE_NUM;
+		cmd.v5.table_revision = sk;
 	} else if (cmd_ver == 4) {
 		len = sizeof(cmd.v4);
 		n_bands = ARRAY_SIZE(cmd.v4.table[0]);
 		n_profiles = BIOS_GEO_MAX_PROFILE_NUM;
+		cmd.v4.table_revision = sk;
 	} else if (cmd_ver == 3) {
 		len = sizeof(cmd.v3);
 		n_bands = ARRAY_SIZE(cmd.v3.table[0]);
 		n_profiles = BIOS_GEO_MIN_PROFILE_NUM;
+		cmd.v3.table_revision = sk;
 	} else if (fw_has_api(&mvm->fwrt.fw->ucode_capa,
 			      IWL_UCODE_TLV_API_SAR_TABLE_VER)) {
 		len = sizeof(cmd.v2);
 		n_bands = ARRAY_SIZE(cmd.v2.table[0]);
 		n_profiles = BIOS_GEO_MIN_PROFILE_NUM;
+		cmd.v2.table_revision = sk;
 	} else {
 		len = sizeof(cmd.v1);
 		n_bands = ARRAY_SIZE(cmd.v1.table[0]);
@@ -1067,27 +1075,6 @@ static int iwl_mvm_sar_geo_init(struct iwl_mvm *mvm)
 	if (ret)
 		return 0;
 
-	/* Only set to South Korea if the table revision is 1 */
-	if (mvm->fwrt.geo_rev == 1)
-		sk = 1;
-
-	/*
-	 * Set the table_revision to South Korea (1) or not (0).  The
-	 * element name is misleading, as it doesn't contain the table
-	 * revision number, but whether the South Korea variation
-	 * should be used.
-	 * This must be done after calling iwl_sar_geo_fill_table().
-	 */
-	if (cmd_ver == 5)
-		cmd.v5.table_revision = cpu_to_le32(sk);
-	else if (cmd_ver == 4)
-		cmd.v4.table_revision = cpu_to_le32(sk);
-	else if (cmd_ver == 3)
-		cmd.v3.table_revision = cpu_to_le32(sk);
-	else if (fw_has_api(&mvm->fwrt.fw->ucode_capa,
-			    IWL_UCODE_TLV_API_SAR_TABLE_VER))
-		cmd.v2.table_revision = cpu_to_le32(sk);
-
 	return iwl_mvm_send_cmd_pdu(mvm, cmd_id, 0, len, &cmd);
 }
 
-- 
2.34.1


