Return-Path: <linux-wireless+bounces-16851-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDE39FDC33
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Dec 2024 21:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 101217A124A
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Dec 2024 20:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755B31990D8;
	Sat, 28 Dec 2024 20:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OEGeFBCo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1CC19883C
	for <linux-wireless@vger.kernel.org>; Sat, 28 Dec 2024 20:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735418092; cv=none; b=YTy/eA87QAfXow2TFA8fgpAIZ/bH2h3sohPQ5UL3fAXs6Vl/748hRDfahVhuSqGfxXMLjkPvs+f1KNCKf77uVBoT+wMBHqHcGrX6HTcK8CDKpk87Cbatq3F0oZAF7cOSpaMvPveT+1gKDlhQfFGbqt/3V6HhKnegxuG3taa8ClE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735418092; c=relaxed/simple;
	bh=hIhRVWiZezutTbRJCsvM8qyf+jtr2beZQd870I2Mu0k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=saOkId48rFnABKN1SZeSd5S9Og8TTgbnxVTE55kvc3u/VYHerCexQNhxC9Lo43z3m4Q4u1P9z4z1ZJpgJoYx1GdDjgYopm2l62sdRGLlDRrVHDZBi6t3DIUJB7+TKS+IpTqkepQxieCSeF6RfU0FIWO7Dbrk2KeyPkbaUenUot4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OEGeFBCo; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735418090; x=1766954090;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hIhRVWiZezutTbRJCsvM8qyf+jtr2beZQd870I2Mu0k=;
  b=OEGeFBCoQ/tYA3Cn51gfo9JzXhxYWRp5AYFz1quKeFSlTbB7oHX1b9XO
   9JO1OG+S9UdMtfuZwyt6QIhlMHuVKztQ9qORGtNac6BsmxK+NFx6chlxV
   3uNISqmn344xOJBr1W/QBsiH4lyD3cyQgSzl+GAisS9MsxsJud4qhoYrU
   rIJvu7kv0LhYXDX+4/VHKtBHorUZ09jitZ6BSMoxFCDFixCZOogzf2vI2
   fBHFVkWYWDOz6vL+Sgb1EPSSHR3kcrHxaLRYTcWDadoVQ3p/lFGIU09gW
   8VP6Tmx5+6aZrRIqyEW76DtG9xiT8gPw/ihmD/ederV6rTxLIEq8CmXHF
   Q==;
X-CSE-ConnectionGUID: SbXaBz2RQjiZY5bNJGjMfA==
X-CSE-MsgGUID: L9wiCY2lT0q7G6co+ZIZ4g==
X-IronPort-AV: E=McAfee;i="6700,10204,11299"; a="35479770"
X-IronPort-AV: E=Sophos;i="6.12,273,1728975600"; 
   d="scan'208";a="35479770"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2024 12:34:48 -0800
X-CSE-ConnectionGUID: GlDdmdxLSb2XfD0nE1Egew==
X-CSE-MsgGUID: V6v8kNEwRSK2RNeb+1a4mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="104488411"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2024 12:34:47 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 09/15] wifi: iwlwifi: s/iwl_dts_measurement_notif_v2/iwl_dts_measurement_notif/g
Date: Sat, 28 Dec 2024 22:34:13 +0200
Message-Id: <20241228223206.c2f489844d87.I9de3e424be48d66994cde3684ce7e9e99456067d@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241228203419.2443350-1-miriam.rachel.korenblit@intel.com>
References: <20241228203419.2443350-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

No need to carry the version number in the structure name if this is the
latest version available.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/commands.h | 2 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/phy.h      | 6 +++---
 drivers/net/wireless/intel/iwlwifi/mvm/tt.c          | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h b/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
index 34a1f97653c0..4b450c722a9c 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
@@ -502,7 +502,7 @@ enum iwl_legacy_cmds {
 	/**
 	 * @DTS_MEASUREMENT_NOTIFICATION:
 	 * &struct iwl_dts_measurement_notif_v1 or
-	 * &struct iwl_dts_measurement_notif_v2
+	 * &struct iwl_dts_measurement_notif
 	 */
 	DTS_MEASUREMENT_NOTIFICATION = 0xdd,
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/phy.h b/drivers/net/wireless/intel/iwlwifi/fw/api/phy.h
index 1dce28f3afa0..eb8961b51cb0 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/phy.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/phy.h
@@ -55,7 +55,7 @@ enum iwl_phy_ops_subcmd_ids {
 	/**
 	 * @DTS_MEASUREMENT_NOTIF_WIDE:
 	 * &struct iwl_dts_measurement_notif_v1 or
-	 * &struct iwl_dts_measurement_notif_v2
+	 * &struct iwl_dts_measurement_notif
 	 */
 	DTS_MEASUREMENT_NOTIF_WIDE = 0xFF,
 };
@@ -152,13 +152,13 @@ struct iwl_dts_measurement_notif_v1 {
 } __packed; /* TEMPERATURE_MEASUREMENT_TRIGGER_NTFY_S_VER_1*/
 
 /**
- * struct iwl_dts_measurement_notif_v2 - measurements notification
+ * struct iwl_dts_measurement_notif - measurements notification
  *
  * @temp: the measured temperature
  * @voltage: the measured voltage
  * @threshold_idx: the trip index that was crossed
  */
-struct iwl_dts_measurement_notif_v2 {
+struct iwl_dts_measurement_notif {
 	__le32 temp;
 	__le32 voltage;
 	__le32 threshold_idx;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
index 256f8f558b15..c851290e75a2 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
@@ -105,7 +105,7 @@ static bool iwl_mvm_temp_notif_wait(struct iwl_notif_wait_data *notif_wait,
 void iwl_mvm_temp_notif(struct iwl_mvm *mvm, struct iwl_rx_cmd_buffer *rxb)
 {
 	struct iwl_rx_packet *pkt = rxb_addr(rxb);
-	struct iwl_dts_measurement_notif_v2 *notif_v2;
+	struct iwl_dts_measurement_notif *notif_v2;
 	int len = iwl_rx_packet_payload_len(pkt);
 	int temp;
 	u32 ths_crossed;
-- 
2.34.1


