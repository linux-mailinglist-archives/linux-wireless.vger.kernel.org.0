Return-Path: <linux-wireless+bounces-26539-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 991DCB3016D
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Aug 2025 19:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C5C21CC82CE
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Aug 2025 17:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DBD7343D7B;
	Thu, 21 Aug 2025 17:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mFcCmBnN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF3A343D8C
	for <linux-wireless@vger.kernel.org>; Thu, 21 Aug 2025 17:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755798488; cv=none; b=D9oHzZQkShV/y4/rf81KrPleoBZuLO2YXC1HGmZteKcRK4Ndnsr0TVRv/jvAsE2g+F3crG2CnrBv8gHZzDhsRMyRiEk4LUt8ELmFqkxbxo5XMph7tlXhoVZ+shomqvyRMNrw8hKiGBje7+tDFaqUCK3KPs6C2TZoNsaNmTMQuJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755798488; c=relaxed/simple;
	bh=UGviCGI/KIA+e1AdCW/yUWxGW/aWc07W1pIlc3QAvds=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eIWkvr/mtCwxHfzDTyrfxR4UyCFo1hKyYtWtfSiD3QNDq+K8SEj74escMYZlSACKx0EWdGiPngeOGSqLErRWantpOyLet5IPcyX4M2oNLQHhuWaKjuaPb/lmdLGrLC74+UUyD7TDWBp7G5NeIk5E4dkb4mH2NNU2yoNaeD/dxrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mFcCmBnN; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755798487; x=1787334487;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UGviCGI/KIA+e1AdCW/yUWxGW/aWc07W1pIlc3QAvds=;
  b=mFcCmBnNnZeZlGoAS7l3P0S2m5zf1OPt6OFbRPSvnVLWTHr7UDD9qoXK
   jBkLg64wK3oNU5xkaN9X02LVW5f+eNcaBvg2MsZ4b/HoO1Fe+y2ikk0w4
   S/0YbLbJm/J7D8MdpDvXiB3LoH5t3/gI6qh3k5O3Ui037617gqGnGu8Bw
   XHa4Yi3ibHQ4Dz79c0CqXzT1SoglUr2RIc8vWYaiWZxvInqqtOaOnqcgh
   s5y61nb2U5svrr7yETbPU9W7onyJ4Ook0RXbhyS6eJ/KX4hFsczQpWLvG
   WMzm+luHZmiAx0NQo42vNTAbgVJkweuM4bCEpZwgM+TmVgxds11ujXF9P
   g==;
X-CSE-ConnectionGUID: Op3v+e/QQdiNJlvOV1hF3A==
X-CSE-MsgGUID: jYDo7YOPRYSreuAdm8js2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="68806086"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="68806086"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 10:48:07 -0700
X-CSE-ConnectionGUID: REvlSa3oSd6jhceatoZyhg==
X-CSE-MsgGUID: HSdKnQIhS8C/71SXGQEtpA==
X-ExtLoop1: 1
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 10:48:06 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Subject: [PATCH v2 iwlwifi-next 12/15] wifi: iwlwifi: mld: don't consider old versions of PPAG
Date: Thu, 21 Aug 2025 20:47:23 +0300
Message-Id: <20250821204455.35698eb46b67.Ie77dc9c3ee8275d1c2e4eafa27f1c7899c2660ce@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250821174726.2425334-1-miriam.rachel.korenblit@intel.com>
References: <20250821174726.2425334-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

There is a utility function, iwl_fill_ppag_table, to fill the PPAG table
according the version of the FW API and on of the BIOS table.
But this function handles really old APIs that iwlmld will not support.
Also, iwlmvm will no longer have new APIs of PPAG (because it is loaded
on frozen devices only). So in the next versions we might introdue
regressions to iwlmvm.
Simply fill the PPAG table separately in iwlmld code, without using this
utility.

Reviewed-by: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/intel/iwlwifi/fw/regulatory.c    |  1 +
 .../wireless/intel/iwlwifi/mld/regulatory.c   | 28 ++++++++++++++-----
 2 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
index 00921f86286a..6e98ac341997 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
@@ -305,6 +305,7 @@ static bool iwl_ppag_value_valid(struct iwl_fw_runtime *fwrt, int chain,
 	return true;
 }
 
+/* Utility function for iwlmvm and iwlxvt */
 int iwl_fill_ppag_table(struct iwl_fw_runtime *fwrt,
 			union iwl_ppag_table_cmd *cmd, int *cmd_size)
 {
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/regulatory.c b/drivers/net/wireless/intel/iwlwifi/mld/regulatory.c
index 75d2f5cb23a7..40571125b3ab 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/regulatory.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/regulatory.c
@@ -163,18 +163,32 @@ int iwl_mld_init_sgom(struct iwl_mld *mld)
 
 static int iwl_mld_ppag_send_cmd(struct iwl_mld *mld)
 {
-	union iwl_ppag_table_cmd cmd = {};
-	int ret, len;
+	struct iwl_fw_runtime *fwrt = &mld->fwrt;
+	union iwl_ppag_table_cmd cmd = {
+		.v7.ppag_config_info.table_source = fwrt->ppag_bios_source,
+		.v7.ppag_config_info.table_revision = fwrt->ppag_bios_rev,
+		.v7.ppag_config_info.value = cpu_to_le32(fwrt->ppag_flags),
+	};
+	int ret;
 
-	ret = iwl_fill_ppag_table(&mld->fwrt, &cmd, &len);
-	/* Not supporting PPAG table is a valid scenario */
-	if (ret < 0)
-		return 0;
+	IWL_DEBUG_RADIO(fwrt,
+			"PPAG MODE bits going to be sent: %d\n",
+			fwrt->ppag_flags);
+
+	for (int chain = 0; chain < IWL_NUM_CHAIN_LIMITS; chain++) {
+		for (int subband = 0; subband < IWL_NUM_SUB_BANDS_V2; subband++) {
+			cmd.v7.gain[chain][subband] =
+				fwrt->ppag_chains[chain].subbands[subband];
+			IWL_DEBUG_RADIO(fwrt,
+					"PPAG table: chain[%d] band[%d]: gain = %d\n",
+					chain, subband, cmd.v7.gain[chain][subband]);
+		}
+	}
 
 	IWL_DEBUG_RADIO(mld, "Sending PER_PLATFORM_ANT_GAIN_CMD\n");
 	ret = iwl_mld_send_cmd_pdu(mld, WIDE_ID(PHY_OPS_GROUP,
 						PER_PLATFORM_ANT_GAIN_CMD),
-				   &cmd, len);
+				   &cmd, sizeof(cmd.v7));
 	if (ret < 0)
 		IWL_ERR(mld, "failed to send PER_PLATFORM_ANT_GAIN_CMD (%d)\n",
 			ret);
-- 
2.34.1


