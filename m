Return-Path: <linux-wireless+bounces-22274-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7FBAA4C73
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 15:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF3E2463CA6
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 13:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0D82620C9;
	Wed, 30 Apr 2025 12:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GpUFbyIy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462C02609FA
	for <linux-wireless@vger.kernel.org>; Wed, 30 Apr 2025 12:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746017884; cv=none; b=etIWM5w4uatZcpExxGEpcV0kTUNZsvsd0nyhg0C0MX0w5ZvQmP/7JOk3niOWbwyvbMbMRsL3725pT8uzaN5tOw+RwgAVXQ4vfp/8iK+1Ml45PWMfndWmF2k5Lx7vpRm4VjKrGk4C9aALczvxlo81rHPziUffeoNjblBAi9y7G3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746017884; c=relaxed/simple;
	bh=2ZR7OHsR3e2/Gd5NSP+GF206XDxDybmBquWPj4OeXmI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mm/7AxmtF63M1+KudTgAfhqQ+OsJ4GGhRSNhY3xF9vpdFwFevvLvaamCroJQVd8ftknjspu+JMvkMOKodWsHCX38XZnHF1d17tyb1vsH4bnad0DNrfWhXCn+k+XUa29Sb8XSz4S7784avornrJipeYtQSyzzeNIP6F3g51+4wvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GpUFbyIy; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746017882; x=1777553882;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2ZR7OHsR3e2/Gd5NSP+GF206XDxDybmBquWPj4OeXmI=;
  b=GpUFbyIyNlxh9z6C4vOZAAaErBcOf/BvuaOZPegZcxMz3dkFDbph0Yjl
   vKdNHMTuCLF8MBYxjKOxltpMYN50a8TbY89v+UrYb1mRFOIqc6KwIAoTO
   nycFC+wGAfHp2qto2LwYrfZoF3aTaFDWjh1/MgtIsV2fbLdiwNYO3WhJ/
   mXPWGUu82Jz3RMvMFU7rBV+jEby9aAsXXF3Yf2l/KnqRKWFqlZsofCvqn
   3HUx9rBfZlaLwi5WTv3etZHoNJQoRXz1cMcRujBNtiULVejCBHhreEa/f
   PFZ3IRQy0iKUDA8iQ6K4wKicq6I9b4LeM00C7ubWIQXD4XXbx7u1c1lhC
   A==;
X-CSE-ConnectionGUID: IOpz+D6FR3KW79dSpcmjRA==
X-CSE-MsgGUID: ma3vIdGITKeyIgTqjdtuCA==
X-IronPort-AV: E=McAfee;i="6700,10204,11419"; a="58332353"
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="58332353"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 05:58:02 -0700
X-CSE-ConnectionGUID: SayzSr5UTWS4R0GlquH0mQ==
X-CSE-MsgGUID: /MkOZYnETgyOzaWLCAIaLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="134632132"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 05:58:00 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-next 13/15] wifi: iwlwifi: dvm: fix various W=1 warnings
Date: Wed, 30 Apr 2025 15:57:27 +0300
Message-Id: <20250430155443.3ef1e4f1cccb.Ic41d3f3721e8bd9df9cd50242232110c4a93e873@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250430125729.1122751-1-miriam.rachel.korenblit@intel.com>
References: <20250430125729.1122751-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Fix warnings occurring with W=1, mostly const and one about
pointer arithmetic.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/dvm/eeprom.c   | 35 +++++++++----------
 .../net/wireless/intel/iwlwifi/dvm/mac80211.c |  4 +--
 drivers/net/wireless/intel/iwlwifi/dvm/main.c |  8 ++---
 drivers/net/wireless/intel/iwlwifi/dvm/rx.c   |  8 ++---
 drivers/net/wireless/intel/iwlwifi/dvm/rxon.c |  8 ++---
 5 files changed, 30 insertions(+), 33 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/eeprom.c b/drivers/net/wireless/intel/iwlwifi/dvm/eeprom.c
index cdc05f7e75a6..35805cc02bf8 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/eeprom.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/eeprom.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2005-2014, 2018-2019, 2021, 2024 Intel Corporation
+ * Copyright (C) 2005-2014, 2018-2019, 2021, 2024-2025 Intel Corporation
  */
 #include <linux/types.h>
 #include <linux/slab.h>
@@ -151,7 +151,7 @@ static u16 iwl_eeprom_query16(const u8 *eeprom, size_t eeprom_size, int offset)
 {
 	if (WARN_ON(offset + sizeof(u16) > eeprom_size))
 		return 0;
-	return le16_to_cpup((__le16 *)(eeprom + offset));
+	return le16_to_cpup((const __le16 *)(eeprom + offset));
 }
 
 static u32 eeprom_indirect_address(const u8 *eeprom, size_t eeprom_size,
@@ -204,8 +204,8 @@ static u32 eeprom_indirect_address(const u8 *eeprom, size_t eeprom_size,
 	return (address & ADDRESS_MSK) + (offset << 1);
 }
 
-static const u8 *iwl_eeprom_query_addr(const u8 *eeprom, size_t eeprom_size,
-				       u32 offset)
+static const void *iwl_eeprom_query_addr(const u8 *eeprom, size_t eeprom_size,
+					 u32 offset)
 {
 	u32 address = eeprom_indirect_address(eeprom, eeprom_size, offset);
 
@@ -218,10 +218,9 @@ static const u8 *iwl_eeprom_query_addr(const u8 *eeprom, size_t eeprom_size,
 static int iwl_eeprom_read_calib(const u8 *eeprom, size_t eeprom_size,
 				 struct iwl_nvm_data *data)
 {
-	struct iwl_eeprom_calib_hdr *hdr;
+	const struct iwl_eeprom_calib_hdr *hdr;
 
-	hdr = (void *)iwl_eeprom_query_addr(eeprom, eeprom_size,
-					    EEPROM_CALIB_ALL);
+	hdr = iwl_eeprom_query_addr(eeprom, eeprom_size, EEPROM_CALIB_ALL);
 	if (!hdr)
 		return -ENODATA;
 	data->calib_version = hdr->version;
@@ -295,7 +294,7 @@ struct iwl_eeprom_enhanced_txpwr {
 } __packed;
 
 static s8 iwl_get_max_txpwr_half_dbm(const struct iwl_nvm_data *data,
-				     struct iwl_eeprom_enhanced_txpwr *txp)
+				     const struct iwl_eeprom_enhanced_txpwr *txp)
 {
 	s8 result = 0; /* (.5 dBm) */
 
@@ -329,7 +328,7 @@ static s8 iwl_get_max_txpwr_half_dbm(const struct iwl_nvm_data *data,
 
 static void
 iwl_eeprom_enh_txp_read_element(struct iwl_nvm_data *data,
-				struct iwl_eeprom_enhanced_txpwr *txp,
+				const struct iwl_eeprom_enhanced_txpwr *txp,
 				int n_channels, s8 max_txpower_avg)
 {
 	int ch_idx;
@@ -360,20 +359,18 @@ static void iwl_eeprom_enhanced_txpower(struct device *dev,
 					const u8 *eeprom, size_t eeprom_size,
 					int n_channels)
 {
-	struct iwl_eeprom_enhanced_txpwr *txp_array, *txp;
+	const struct iwl_eeprom_enhanced_txpwr *txp_array, *txp;
 	int idx, entries;
-	__le16 *txp_len;
+	const __le16 *txp_len;
 	s8 max_txp_avg_halfdbm;
 
 	BUILD_BUG_ON(sizeof(struct iwl_eeprom_enhanced_txpwr) != 8);
 
 	/* the length is in 16-bit words, but we want entries */
-	txp_len = (__le16 *)iwl_eeprom_query_addr(eeprom, eeprom_size,
-						  EEPROM_TXP_SZ_OFFS);
+	txp_len = iwl_eeprom_query_addr(eeprom, eeprom_size, EEPROM_TXP_SZ_OFFS);
 	entries = le16_to_cpup(txp_len) * 2 / EEPROM_TXP_ENTRY_LEN;
 
-	txp_array = (void *)iwl_eeprom_query_addr(eeprom, eeprom_size,
-						  EEPROM_TXP_OFFS);
+	txp_array = iwl_eeprom_query_addr(eeprom, eeprom_size, EEPROM_TXP_OFFS);
 
 	for (idx = 0; idx < entries; idx++) {
 		txp = &txp_array[idx];
@@ -426,7 +423,7 @@ static void iwl_init_band_reference(const struct iwl_cfg *cfg,
 
 	offset |= INDIRECT_ADDRESS | INDIRECT_REGULATORY;
 
-	*ch_info = (void *)iwl_eeprom_query_addr(eeprom, eeprom_size, offset);
+	*ch_info = iwl_eeprom_query_addr(eeprom, eeprom_size, offset);
 
 	switch (eeprom_band) {
 	case 1:		/* 2.4GHz band */
@@ -1098,14 +1095,14 @@ iwl_parse_eeprom_data(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 				    EEPROM_RAW_TEMPERATURE);
 	if (!tmp)
 		goto err_free;
-	data->raw_temperature = *(__le16 *)tmp;
+	data->raw_temperature = *(const __le16 *)tmp;
 
 	tmp = iwl_eeprom_query_addr(eeprom, eeprom_size,
 				    EEPROM_KELVIN_TEMPERATURE);
 	if (!tmp)
 		goto err_free;
-	data->kelvin_temperature = *(__le16 *)tmp;
-	data->kelvin_voltage = *((__le16 *)tmp + 1);
+	data->kelvin_temperature = *(const __le16 *)tmp;
+	data->kelvin_voltage = *((const __le16 *)tmp + 1);
 
 	radio_cfg =
 		iwl_eeprom_query16(eeprom, eeprom_size, EEPROM_RADIO_CONFIG);
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c
index 56d19a034c24..bd8f67b5bab5 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c
@@ -2,7 +2,7 @@
 /******************************************************************************
  *
  * Copyright(c) 2003 - 2014 Intel Corporation. All rights reserved.
- * Copyright(C) 2018 - 2019, 2022 - 2024 Intel Corporation
+ * Copyright(C) 2018 - 2019, 2022 - 2025 Intel Corporation
  *
  * Portions of this file are derived from the ipw3945 project, as well
  * as portions of the ieee80211 subsystem header files.
@@ -549,7 +549,7 @@ static int iwlagn_mac_resume(struct ieee80211_hw *hw)
 
 	iwlagn_prepare_restart(priv);
 
-	memset((void *)&ctx->active, 0, sizeof(ctx->active));
+	memset((void *)(uintptr_t)&ctx->active, 0, sizeof(ctx->active));
 	iwl_connection_init_rx_config(priv, ctx);
 	iwlagn_set_rxon_chain(priv, ctx);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/main.c b/drivers/net/wireless/intel/iwlwifi/dvm/main.c
index a27a72cc017a..e4e2fc158e52 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/main.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/main.c
@@ -2,7 +2,7 @@
 /******************************************************************************
  *
  * Copyright(c) 2003 - 2014, 2018 - 2022 Intel Corporation. All rights reserved.
- * Copyright(c) 2024 Intel Corporation. All rights reserved.
+ * Copyright(c) 2024-2025 Intel Corporation. All rights reserved.
  * Copyright(c) 2015 Intel Deutschland GmbH
  *
  * Portions of this file are derived from the ipw3945 project, as well
@@ -824,11 +824,11 @@ int iwl_alive_start(struct iwl_priv *priv)
 	iwlagn_send_tx_ant_config(priv, priv->nvm_data->valid_tx_ant);
 
 	if (iwl_is_associated_ctx(ctx) && !priv->wowlan) {
-		struct iwl_rxon_cmd *active_rxon =
-				(struct iwl_rxon_cmd *)&ctx->active;
+		struct iwl_rxon_cmd *active = (void *)(uintptr_t)&ctx->active;
+
 		/* apply any changes in staging */
 		ctx->staging.filter_flags |= RXON_FILTER_ASSOC_MSK;
-		active_rxon->filter_flags &= ~RXON_FILTER_ASSOC_MSK;
+		active->filter_flags &= ~RXON_FILTER_ASSOC_MSK;
 	} else {
 		struct iwl_rxon_context *tmp;
 		/* Initialize our rx_config data */
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/rx.c b/drivers/net/wireless/intel/iwlwifi/dvm/rx.c
index 7f67e602940c..5f8b60824043 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/rx.c
@@ -3,7 +3,7 @@
  *
  * Copyright(c) 2003 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2015 Intel Deutschland GmbH
- * Copyright(c) 2018, 2020-2021 Intel Corporation
+ * Copyright(c) 2018, 2020-2021, 2025 Intel Corporation
  *
  * Portions of this file are derived from the ipw3945 project, as well
  * as portionhelp of the ieee80211 subsystem header files.
@@ -50,7 +50,7 @@ static void iwlagn_rx_csa(struct iwl_priv *priv, struct iwl_rx_cmd_buffer *rxb)
 	 * See iwlagn_mac_channel_switch.
 	 */
 	struct iwl_rxon_context *ctx = &priv->contexts[IWL_RXON_CTX_BSS];
-	struct iwl_rxon_cmd *rxon = (void *)&ctx->active;
+	struct iwl_rxon_cmd *rxon = (void *)(uintptr_t)&ctx->active;
 
 	if (!test_bit(STATUS_CHANNEL_SWITCH_PENDING, &priv->status))
 		return;
@@ -643,8 +643,8 @@ static void iwlagn_pass_packet_to_mac80211(struct iwl_priv *priv,
 	fraglen = len - hdrlen;
 
 	if (fraglen) {
-		int offset = (void *)hdr + hdrlen -
-			     rxb_addr(rxb) + rxb_offset(rxb);
+		int offset = (u8 *)hdr + hdrlen -
+			     (u8 *)rxb_addr(rxb) + rxb_offset(rxb);
 
 		skb_add_rx_frag(skb, 0, rxb_steal_page(rxb), offset,
 				fraglen, rxb->truesize);
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/rxon.c b/drivers/net/wireless/intel/iwlwifi/dvm/rxon.c
index f80cce37e2c0..2d3c1627f283 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/rxon.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/rxon.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
- * Copyright(c) 2003 - 2014 Intel Corporation. All rights reserved.
+ * Copyright(c) 2003 - 2014, 2025 Intel Corporation. All rights reserved.
  * Copyright(c) 2015 Intel Deutschland GmbH
  *****************************************************************************/
 
@@ -341,7 +341,7 @@ static int iwlagn_rxon_disconn(struct iwl_priv *priv,
 			       struct iwl_rxon_context *ctx)
 {
 	int ret;
-	struct iwl_rxon_cmd *active = (void *)&ctx->active;
+	struct iwl_rxon_cmd *active = (void *)(uintptr_t)&ctx->active;
 
 	if (ctx->ctxid == IWL_RXON_CTX_BSS) {
 		ret = iwlagn_disable_bss(priv, ctx, &ctx->staging);
@@ -441,7 +441,7 @@ static int iwlagn_rxon_connect(struct iwl_priv *priv,
 			       struct iwl_rxon_context *ctx)
 {
 	int ret;
-	struct iwl_rxon_cmd *active = (void *)&ctx->active;
+	struct iwl_rxon_cmd *active = (void *)(uintptr_t)&ctx->active;
 
 	/* RXON timing must be before associated RXON */
 	if (ctx->ctxid == IWL_RXON_CTX_BSS) {
@@ -1023,7 +1023,7 @@ static void iwl_calc_basic_rates(struct iwl_priv *priv,
 int iwlagn_commit_rxon(struct iwl_priv *priv, struct iwl_rxon_context *ctx)
 {
 	/* cast away the const for active_rxon in this function */
-	struct iwl_rxon_cmd *active = (void *)&ctx->active;
+	struct iwl_rxon_cmd *active = (void *)(uintptr_t)&ctx->active;
 	bool new_assoc = !!(ctx->staging.filter_flags & RXON_FILTER_ASSOC_MSK);
 	int ret;
 
-- 
2.34.1


