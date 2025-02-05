Return-Path: <linux-wireless+bounces-18519-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB046A28AF7
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 13:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D54EF3A622F
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 12:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548B6376;
	Wed,  5 Feb 2025 12:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HX4q+eap"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD42DF5C
	for <linux-wireless@vger.kernel.org>; Wed,  5 Feb 2025 12:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738760169; cv=none; b=FrywII2davsHRrma9IStAYm4yf/pqkmawoB9Ngxd9zgm/rqikFsDTmYxdz57wTx4+uZ3q7N3tPQMQ6QfgNfx0+zgEdGjBT55peAK07dZGnpas7b/MryDED7wtImzhsIshXa/tAUYksbq6saB2Gm+JYSZSTbeJ5rertXDisbsmf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738760169; c=relaxed/simple;
	bh=hIhRVWiZezutTbRJCsvM8qyf+jtr2beZQd870I2Mu0k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZoXpomp/WyPx+NC4bKb2v0lxOH/zC23EIxEYdvzaxpHT0LpBpChwcDab1rKI8JwKKck1tiYhdhTo/IQWL+f8dvkfNGwMleZJGUZqJinwTz+8U0U3U7zzKzgR5JULU33pOC6wTROKuT8pgwj05ZfhD06Gj0PU7UdlJInKE7beMQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HX4q+eap; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738760168; x=1770296168;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hIhRVWiZezutTbRJCsvM8qyf+jtr2beZQd870I2Mu0k=;
  b=HX4q+eapposgV8s+cIUragKPkb58uT9MZnzK61yJBhLDaN8wu0QxOHfo
   FMMJIqKnsFowlvJVtTYX1AFLCgCS63Wmal+M5yOrKurRWoRO6YXRSZWUf
   m7Bkzf87IRpVW5IogjKTlivPgTedoZG4v+HZtLtxheYHxBL476wRPLmwx
   KpBe1QlHI4LteVdmzKDGdkkY63PFcJjoDmBBxJwbOXVfEhbEHNTz5C0hR
   uTSD7zf6tMQHPVeR0qxCbtbQgAnEmGSzXKfP86bOfqswNNAx2RDWbsO5r
   KehfEs3xJvZni43bxZm0YzrAlFC6M6SGS4Zl0PNjiG9XxTuUqc7FLG9Vp
   Q==;
X-CSE-ConnectionGUID: TBo6n/VOQW+FUFehIpG4pw==
X-CSE-MsgGUID: uWqHtppDS5inCAa61xRPTg==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="42159160"
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="42159160"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 04:56:07 -0800
X-CSE-ConnectionGUID: ifdV7GItQvmhzZJCUNKMog==
X-CSE-MsgGUID: II6XBGLpQLioiQ5fGNNGSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="110745416"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 04:56:06 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 02/19] wifi: iwlwifi: remove the version number from iwl_dts_measurement_notif_v2
Date: Wed,  5 Feb 2025 14:55:31 +0200
Message-Id: <20250205145347.412ce75a5e3b.I9de3e424be48d66994cde3684ce7e9e99456067d@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250205125548.1963070-1-miriam.rachel.korenblit@intel.com>
References: <20250205125548.1963070-1-miriam.rachel.korenblit@intel.com>
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


