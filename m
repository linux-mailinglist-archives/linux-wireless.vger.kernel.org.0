Return-Path: <linux-wireless+bounces-22389-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC0AAA85F2
	for <lists+linux-wireless@lfdr.de>; Sun,  4 May 2025 12:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 339B9178A6F
	for <lists+linux-wireless@lfdr.de>; Sun,  4 May 2025 10:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D9A17736;
	Sun,  4 May 2025 10:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Aw8zHmwa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C58A1A76DA
	for <linux-wireless@vger.kernel.org>; Sun,  4 May 2025 10:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746354417; cv=none; b=G6370Lm8YMtAbRqRwOKSkTlPZR+/7GdGALSTEwag40jXwzTvFvKSqd7iB4vU1nZs9zNcUFub7tg6j88BY27arccaquIMKeiqtZfEr120iAYd4RAUQ8YZlXU05lT8hlq/2EuLWw8DXyosyvV1IBOpQqjAqNsnJbt9O4BNIdSfx+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746354417; c=relaxed/simple;
	bh=a4dKb2icW6RWjkNoLISwPDPquAEm9DfxanvMT39JQfw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E3jm2DGX2DXlWrat0y+Im4kl4stH3+vjUvBI7jT3N6ekzVIeOtg+Tu7ecxIVIjhKE29vsAw4ZsxGpMzctuw5Qj+EleahpFC1oF+bLB9BeAPXor4suShoFtEqajO9FhdINWK/hLFc7mtGJe6S0qinzU6OJQm+SE7YrVR7pBmPSv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Aw8zHmwa; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746354415; x=1777890415;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=a4dKb2icW6RWjkNoLISwPDPquAEm9DfxanvMT39JQfw=;
  b=Aw8zHmwaYWOZJi8gBPo+JAI09AcXh3I0322FVPNS4qWLj8UZKN7SnC/6
   quUl6ukgbuYmbl2mCw5SkYJKTNQlmlVGERT+st66pEhBkOZ7QXQwXjcUn
   08GIQIFMNBRes4+UIQigADv3brIJxwfPUK4XXWunud8C2FpPuaItlP8Wh
   2Cw6twCuhoLayduSb6oEwiGcHDJqYU//qH2LWSUpQ3jWibWaAM0/l1qvm
   c4AkJ4f+HU9PGztF3EHclM8+ZXDhmLyNGvh+xJAU+Bk39BGV2dr/NcfWS
   tgpdblHWchV1i1HVifQ9jLe3hqRK9Lb2g3ZhxIjl6BuxM91yalubmQERc
   A==;
X-CSE-ConnectionGUID: ji7dRxoNSUqqHYEiZQqCZg==
X-CSE-MsgGUID: /L/DNAbxQkaT9X9GoDdGZw==
X-IronPort-AV: E=McAfee;i="6700,10204,11422"; a="65511481"
X-IronPort-AV: E=Sophos;i="6.15,261,1739865600"; 
   d="scan'208";a="65511481"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2025 03:26:54 -0700
X-CSE-ConnectionGUID: A7GbHXAHTh62xL3scFm1nQ==
X-CSE-MsgGUID: umcWc4yLScKjOaCGNZoOhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,261,1739865600"; 
   d="scan'208";a="139778868"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2025 03:26:53 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-next 04/15] wifi: iwlwifi: remove sku_id from trans
Date: Sun,  4 May 2025 13:26:19 +0300
Message-Id: <20250504132447.fe8be4454007.I24824f35620b21fe49e9243818c7188e431af48e@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250504102630.757937-1-miriam.rachel.korenblit@intel.com>
References: <20250504102630.757937-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

This is ephemeral data that's passed from the alive
response to the PNVM loading, so it doesn't need to
be stored. Pass it around instead.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.c  | 49 +++++++++++--------
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.h  |  5 +-
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c  | 17 ++++---
 drivers/net/wireless/intel/iwlwifi/fw/uefi.h  |  6 ++-
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  2 -
 drivers/net/wireless/intel/iwlwifi/mld/fw.c   | 33 ++++++++-----
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 16 +++---
 7 files changed, 74 insertions(+), 54 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
index 7766b2a45cdf..4f3c2f7f4f5b 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
@@ -167,7 +167,8 @@ static int iwl_pnvm_handle_section(struct iwl_trans *trans, const u8 *data,
 
 static int iwl_pnvm_parse(struct iwl_trans *trans, const u8 *data,
 			  size_t len,
-			  struct iwl_pnvm_image *pnvm_data)
+			  struct iwl_pnvm_image *pnvm_data,
+			  __le32 sku_id[3])
 {
 	const struct iwl_ucode_tlv *tlv;
 
@@ -190,23 +191,23 @@ static int iwl_pnvm_parse(struct iwl_trans *trans, const u8 *data,
 		}
 
 		if (tlv_type == IWL_UCODE_TLV_PNVM_SKU) {
-			const struct iwl_sku_id *sku_id =
+			const struct iwl_sku_id *tlv_sku_id =
 				(const void *)(data + sizeof(*tlv));
 
 			IWL_DEBUG_FW(trans,
 				     "Got IWL_UCODE_TLV_PNVM_SKU len %d\n",
 				     tlv_len);
 			IWL_DEBUG_FW(trans, "sku_id 0x%0x 0x%0x 0x%0x\n",
-				     le32_to_cpu(sku_id->data[0]),
-				     le32_to_cpu(sku_id->data[1]),
-				     le32_to_cpu(sku_id->data[2]));
+				     le32_to_cpu(tlv_sku_id->data[0]),
+				     le32_to_cpu(tlv_sku_id->data[1]),
+				     le32_to_cpu(tlv_sku_id->data[2]));
 
 			data += sizeof(*tlv) + ALIGN(tlv_len, 4);
 			len -= ALIGN(tlv_len, 4);
 
 			trans->reduced_cap_sku = false;
 			rf_type = CSR_HW_RFID_TYPE(trans->info.hw_rf_id);
-			if ((trans->sku_id[0] & IWL_PNVM_REDUCED_CAP_BIT) &&
+			if ((sku_id[0] & cpu_to_le32(IWL_PNVM_REDUCED_CAP_BIT)) &&
 			    rf_type == IWL_CFG_RF_TYPE_FM)
 				trans->reduced_cap_sku = true;
 
@@ -214,9 +215,9 @@ static int iwl_pnvm_parse(struct iwl_trans *trans, const u8 *data,
 				     "Reduced SKU device %d\n",
 				     trans->reduced_cap_sku);
 
-			if (trans->sku_id[0] == le32_to_cpu(sku_id->data[0]) &&
-			    trans->sku_id[1] == le32_to_cpu(sku_id->data[1]) &&
-			    trans->sku_id[2] == le32_to_cpu(sku_id->data[2])) {
+			if (sku_id[0] == tlv_sku_id->data[0] &&
+			    sku_id[1] == tlv_sku_id->data[1] &&
+			    sku_id[2] == tlv_sku_id->data[2]) {
 				int ret;
 
 				ret = iwl_pnvm_handle_section(trans, data, len,
@@ -263,13 +264,14 @@ static int iwl_pnvm_get_from_fs(struct iwl_trans *trans, u8 **data, size_t *len)
 	return 0;
 }
 
-static u8 *iwl_get_pnvm_image(struct iwl_trans *trans_p, size_t *len)
+static u8 *iwl_get_pnvm_image(struct iwl_trans *trans_p, size_t *len,
+			      __le32 sku_id[3])
 {
 	struct pnvm_sku_package *package;
 	u8 *image = NULL;
 
 	/* Get PNVM from BIOS for non-Intel SKU */
-	if (trans_p->sku_id[2]) {
+	if (sku_id[2]) {
 		package = iwl_uefi_get_pnvm(trans_p, len);
 		if (!IS_ERR_OR_NULL(package)) {
 			if (*len >= sizeof(*package)) {
@@ -294,8 +296,10 @@ static u8 *iwl_get_pnvm_image(struct iwl_trans *trans_p, size_t *len)
 	return image;
 }
 
-static void iwl_pnvm_load_pnvm_to_trans(struct iwl_trans *trans,
-					const struct iwl_ucode_capabilities *capa)
+static void
+iwl_pnvm_load_pnvm_to_trans(struct iwl_trans *trans,
+			    const struct iwl_ucode_capabilities *capa,
+			    __le32 sku_id[3])
 {
 	struct iwl_pnvm_image *pnvm_data = NULL;
 	u8 *data = NULL;
@@ -309,7 +313,7 @@ static void iwl_pnvm_load_pnvm_to_trans(struct iwl_trans *trans,
 	if (trans->pnvm_loaded)
 		goto set;
 
-	data = iwl_get_pnvm_image(trans, &length);
+	data = iwl_get_pnvm_image(trans, &length, sku_id);
 	if (!data) {
 		trans->fail_to_parse_pnvm_image = true;
 		return;
@@ -319,7 +323,7 @@ static void iwl_pnvm_load_pnvm_to_trans(struct iwl_trans *trans,
 	if (!pnvm_data)
 		goto free;
 
-	ret = iwl_pnvm_parse(trans, data, length, pnvm_data);
+	ret = iwl_pnvm_parse(trans, data, length, pnvm_data, sku_id);
 	if (ret) {
 		trans->fail_to_parse_pnvm_image = true;
 		goto free;
@@ -339,7 +343,8 @@ static void iwl_pnvm_load_pnvm_to_trans(struct iwl_trans *trans,
 
 static void
 iwl_pnvm_load_reduce_power_to_trans(struct iwl_trans *trans,
-				    const struct iwl_ucode_capabilities *capa)
+				    const struct iwl_ucode_capabilities *capa,
+				    __le32 sku_id[3])
 {
 	struct iwl_pnvm_image *pnvm_data = NULL;
 	u8 *data = NULL;
@@ -362,7 +367,8 @@ iwl_pnvm_load_reduce_power_to_trans(struct iwl_trans *trans,
 	if (!pnvm_data)
 		goto free;
 
-	ret = iwl_uefi_reduce_power_parse(trans, data, length, pnvm_data);
+	ret = iwl_uefi_reduce_power_parse(trans, data, length, pnvm_data,
+					  sku_id);
 	if (ret) {
 		trans->failed_to_load_reduce_power_image = true;
 		goto free;
@@ -386,18 +392,19 @@ iwl_pnvm_load_reduce_power_to_trans(struct iwl_trans *trans,
 
 int iwl_pnvm_load(struct iwl_trans *trans,
 		  struct iwl_notif_wait_data *notif_wait,
-		  const struct iwl_ucode_capabilities *capa)
+		  const struct iwl_ucode_capabilities *capa,
+		  __le32 sku_id[3])
 {
 	struct iwl_notification_wait pnvm_wait;
 	static const u16 ntf_cmds[] = { WIDE_ID(REGULATORY_AND_NVM_GROUP,
 						PNVM_INIT_COMPLETE_NTFY) };
 
 	/* if the SKU_ID is empty, there's nothing to do */
-	if (!trans->sku_id[0] && !trans->sku_id[1] && !trans->sku_id[2])
+	if (!sku_id[0] && !sku_id[1] && !sku_id[2])
 		return 0;
 
-	iwl_pnvm_load_pnvm_to_trans(trans, capa);
-	iwl_pnvm_load_reduce_power_to_trans(trans, capa);
+	iwl_pnvm_load_pnvm_to_trans(trans, capa, sku_id);
+	iwl_pnvm_load_reduce_power_to_trans(trans, capa, sku_id);
 
 	iwl_init_notification_wait(notif_wait, &pnvm_wait,
 				   ntf_cmds, ARRAY_SIZE(ntf_cmds),
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.h b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.h
index 1bac3466154c..9540926e8a0f 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright(c) 2020-2023 Intel Corporation
+ * Copyright(c) 2020-2023, 2025 Intel Corporation
  */
 #ifndef __IWL_PNVM_H__
 #define __IWL_PNVM_H__
@@ -14,7 +14,8 @@
 
 int iwl_pnvm_load(struct iwl_trans *trans,
 		  struct iwl_notif_wait_data *notif_wait,
-		  const struct iwl_ucode_capabilities *capa);
+		  const struct iwl_ucode_capabilities *capa,
+		  __le32 sku_id[3]);
 
 static inline
 void iwl_pnvm_get_fs_name(struct iwl_trans *trans,
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
index 5aedb78cb6d0..d49bf3c34f95 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
@@ -219,7 +219,8 @@ static int iwl_uefi_reduce_power_section(struct iwl_trans *trans,
 
 int iwl_uefi_reduce_power_parse(struct iwl_trans *trans,
 				const u8 *data, size_t len,
-				struct iwl_pnvm_image *pnvm_data)
+				struct iwl_pnvm_image *pnvm_data,
+				__le32 sku_id[3])
 {
 	const struct iwl_ucode_tlv *tlv;
 
@@ -241,23 +242,23 @@ int iwl_uefi_reduce_power_parse(struct iwl_trans *trans,
 		}
 
 		if (tlv_type == IWL_UCODE_TLV_PNVM_SKU) {
-			const struct iwl_sku_id *sku_id =
+			const struct iwl_sku_id *tlv_sku_id =
 				(const void *)(data + sizeof(*tlv));
 
 			IWL_DEBUG_FW(trans,
 				     "Got IWL_UCODE_TLV_PNVM_SKU len %d\n",
 				     tlv_len);
 			IWL_DEBUG_FW(trans, "sku_id 0x%0x 0x%0x 0x%0x\n",
-				     le32_to_cpu(sku_id->data[0]),
-				     le32_to_cpu(sku_id->data[1]),
-				     le32_to_cpu(sku_id->data[2]));
+				     le32_to_cpu(tlv_sku_id->data[0]),
+				     le32_to_cpu(tlv_sku_id->data[1]),
+				     le32_to_cpu(tlv_sku_id->data[2]));
 
 			data += sizeof(*tlv) + ALIGN(tlv_len, 4);
 			len -= ALIGN(tlv_len, 4);
 
-			if (trans->sku_id[0] == le32_to_cpu(sku_id->data[0]) &&
-			    trans->sku_id[1] == le32_to_cpu(sku_id->data[1]) &&
-			    trans->sku_id[2] == le32_to_cpu(sku_id->data[2])) {
+			if (sku_id[0] == tlv_sku_id->data[0] &&
+			    sku_id[1] == tlv_sku_id->data[1] &&
+			    sku_id[2] == tlv_sku_id->data[2]) {
 				int ret = iwl_uefi_reduce_power_section(trans,
 								    data, len,
 								    pnvm_data);
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.h b/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
index ace36cb081e6..81df7020b2c7 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
@@ -253,7 +253,8 @@ void *iwl_uefi_get_pnvm(struct iwl_trans *trans, size_t *len);
 u8 *iwl_uefi_get_reduced_power(struct iwl_trans *trans, size_t *len);
 int iwl_uefi_reduce_power_parse(struct iwl_trans *trans,
 				const u8 *data, size_t len,
-				struct iwl_pnvm_image *pnvm_data);
+				struct iwl_pnvm_image *pnvm_data,
+				__le32 sku_id[3]);
 void iwl_uefi_get_step_table(struct iwl_trans *trans);
 int iwl_uefi_handle_tlv_mem_desc(struct iwl_trans *trans, const u8 *data,
 				 u32 tlv_len, struct iwl_pnvm_image *pnvm_data);
@@ -285,7 +286,8 @@ static inline void *iwl_uefi_get_pnvm(struct iwl_trans *trans, size_t *len)
 static inline int
 iwl_uefi_reduce_power_parse(struct iwl_trans *trans,
 			    const u8 *data, size_t len,
-			    struct iwl_pnvm_image *pnvm_data)
+			    struct iwl_pnvm_image *pnvm_data,
+			    __le32 sku_id[3])
 {
 	return -EOPNOTSUPP;
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 929c29ca3939..c83c27270719 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -863,7 +863,6 @@ struct iwl_trans_info {
  * @status: a bit-mask of transport status flags
  * @dev: pointer to struct device * that represents the device
  * @info: device information for use by other layers
- * @sku_id: the SKU identifier (for PNVM matching)
  * @pnvm_loaded: indicates PNVM was loaded
  * @pm_support: set to true in start_hw if link pm is supported
  * @ltr_enabled: set to true if the LTR is enabled
@@ -902,7 +901,6 @@ struct iwl_trans {
 	struct device *dev;
 
 	const struct iwl_trans_info info;
-	u32 sku_id[3];
 	bool reduced_cap_sku;
 	bool step_urm;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/fw.c b/drivers/net/wireless/intel/iwlwifi/mld/fw.c
index 8831b95b91ef..87c25277a174 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/fw.c
@@ -99,6 +99,11 @@ static void iwl_mld_alive_imr_data(struct iwl_trans *trans,
 	}
 }
 
+struct iwl_mld_alive_data {
+	__le32 sku_id[3];
+	bool valid;
+};
+
 static bool iwl_alive_fn(struct iwl_notif_wait_data *notif_wait,
 			 struct iwl_rx_packet *pkt, void *data)
 {
@@ -109,8 +114,8 @@ static bool iwl_alive_fn(struct iwl_notif_wait_data *notif_wait,
 	struct iwl_trans *trans = mld->trans;
 	u32 version = iwl_fw_lookup_notif_ver(mld->fw, LEGACY_GROUP,
 					      UCODE_ALIVE_NTFY, 0);
+	struct iwl_mld_alive_data *alive_data = data;
 	struct iwl_alive_ntf *palive;
-	bool *alive_valid = data;
 	struct iwl_umac_alive *umac;
 	struct iwl_lmac_alive *lmac1;
 	struct iwl_lmac_alive *lmac2 = NULL;
@@ -142,12 +147,15 @@ static bool iwl_alive_fn(struct iwl_notif_wait_data *notif_wait,
 	lmac2 = &palive->lmac_data[1];
 	status = le16_to_cpu(palive->status);
 
-	trans->sku_id[0] = le32_to_cpu(palive->sku_id.data[0]);
-	trans->sku_id[1] = le32_to_cpu(palive->sku_id.data[1]);
-	trans->sku_id[2] = le32_to_cpu(palive->sku_id.data[2]);
+	BUILD_BUG_ON(sizeof(alive_data->sku_id) !=
+		     sizeof(palive->sku_id.data));
+	memcpy(alive_data->sku_id, palive->sku_id.data,
+	       sizeof(palive->sku_id.data));
 
 	IWL_DEBUG_FW(mld, "Got sku_id: 0x0%x 0x0%x 0x0%x\n",
-		     trans->sku_id[0], trans->sku_id[1], trans->sku_id[2]);
+		     le32_to_cpu(alive_data->sku_id[0]),
+		     le32_to_cpu(alive_data->sku_id[1]),
+		     le32_to_cpu(alive_data->sku_id[2]));
 
 	lmac_error_event_table =
 		le32_to_cpu(lmac1->dbg_ptrs.error_event_table_ptr);
@@ -166,7 +174,7 @@ static bool iwl_alive_fn(struct iwl_notif_wait_data *notif_wait,
 		IWL_ERR(mld, "Not valid error log pointer 0x%08X\n",
 			umac_error_table);
 
-	*alive_valid = status == IWL_ALIVE_STATUS_OK;
+	alive_data->valid = status == IWL_ALIVE_STATUS_OK;
 
 	IWL_DEBUG_FW(mld,
 		     "Alive ucode status 0x%04x revision 0x%01X 0x%01X\n",
@@ -225,18 +233,18 @@ static void iwl_mld_print_alive_notif_timeout(struct iwl_mld *mld)
 			pc_data->pc_address);
 }
 
-static int iwl_mld_load_fw_wait_alive(struct iwl_mld *mld)
+static int iwl_mld_load_fw_wait_alive(struct iwl_mld *mld,
+				      struct iwl_mld_alive_data *alive_data)
 {
 	static const u16 alive_cmd[] = { UCODE_ALIVE_NTFY };
 	struct iwl_notification_wait alive_wait;
-	bool alive_valid = false;
 	int ret;
 
 	lockdep_assert_wiphy(mld->wiphy);
 
 	iwl_init_notification_wait(&mld->notif_wait, &alive_wait,
 				   alive_cmd, ARRAY_SIZE(alive_cmd),
-				   iwl_alive_fn, &alive_valid);
+				   iwl_alive_fn, alive_data);
 
 	iwl_dbg_tlv_time_point(&mld->fwrt, IWL_FW_INI_TIME_POINT_EARLY, NULL);
 
@@ -257,7 +265,7 @@ static int iwl_mld_load_fw_wait_alive(struct iwl_mld *mld)
 		return ret;
 	}
 
-	if (!alive_valid) {
+	if (!alive_data->valid) {
 		IWL_ERR(mld, "Loaded firmware is not valid!\n");
 		return -EIO;
 	}
@@ -273,6 +281,7 @@ static int iwl_mld_run_fw_init_sequence(struct iwl_mld *mld)
 	struct iwl_init_extended_cfg_cmd init_cfg = {
 		.init_flags = cpu_to_le32(BIT(IWL_INIT_PHY)),
 	};
+	struct iwl_mld_alive_data alive_data = {};
 	static const u16 init_complete[] = {
 		INIT_COMPLETE_NOTIF,
 	};
@@ -280,12 +289,12 @@ static int iwl_mld_run_fw_init_sequence(struct iwl_mld *mld)
 
 	lockdep_assert_wiphy(mld->wiphy);
 
-	ret = iwl_mld_load_fw_wait_alive(mld);
+	ret = iwl_mld_load_fw_wait_alive(mld, &alive_data);
 	if (ret)
 		return ret;
 
 	ret = iwl_pnvm_load(mld->trans, &mld->notif_wait,
-			    &mld->fw->ucode_capa);
+			    &mld->fw->ucode_capa, alive_data.sku_id);
 	if (ret) {
 		IWL_ERR(mld, "Timeout waiting for PNVM load %d\n", ret);
 		return ret;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index bb480b2c3626..5d2cafc44a7a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -29,6 +29,7 @@
 #define MVM_UCODE_CALIB_TIMEOUT	(2 * HZ)
 
 struct iwl_mvm_alive_data {
+	__le32 sku_id[3];
 	bool valid;
 };
 
@@ -181,14 +182,15 @@ static bool iwl_alive_fn(struct iwl_notif_wait_data *notif_wait,
 		lmac2 = &palive->lmac_data[1];
 		status = le16_to_cpu(palive->status);
 
-		mvm->trans->sku_id[0] = le32_to_cpu(palive->sku_id.data[0]);
-		mvm->trans->sku_id[1] = le32_to_cpu(palive->sku_id.data[1]);
-		mvm->trans->sku_id[2] = le32_to_cpu(palive->sku_id.data[2]);
+		BUILD_BUG_ON(sizeof(palive->sku_id.data) !=
+			     sizeof(alive_data->sku_id));
+		memcpy(alive_data->sku_id, palive->sku_id.data,
+		       sizeof(palive->sku_id.data));
 
 		IWL_DEBUG_FW(mvm, "Got sku_id: 0x0%x 0x0%x 0x0%x\n",
-			     mvm->trans->sku_id[0],
-			     mvm->trans->sku_id[1],
-			     mvm->trans->sku_id[2]);
+			     le32_to_cpu(alive_data->sku_id[0]),
+			     le32_to_cpu(alive_data->sku_id[1]),
+			     le32_to_cpu(alive_data->sku_id[2]));
 	} else if (iwl_rx_packet_payload_len(pkt) == sizeof(struct iwl_alive_ntf_v4)) {
 		struct iwl_alive_ntf_v4 *palive;
 
@@ -430,7 +432,7 @@ static int iwl_mvm_load_ucode_wait_alive(struct iwl_mvm *mvm,
 	iwl_trans_fw_alive(mvm->trans);
 
 	ret = iwl_pnvm_load(mvm->trans, &mvm->notif_wait,
-			    &mvm->fw->ucode_capa);
+			    &mvm->fw->ucode_capa, alive_data.sku_id);
 	if (ret) {
 		IWL_ERR(mvm, "Timeout waiting for PNVM load!\n");
 		iwl_fw_set_current_image(&mvm->fwrt, old_type);
-- 
2.34.1


