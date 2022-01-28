Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 781AD49FACF
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jan 2022 14:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348947AbiA1Ner (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jan 2022 08:34:47 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:37856 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1348938AbiA1Ner (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jan 2022 08:34:47 -0500
Received: from 91-155-254-253.elisa-laajakaista.fi ([91.155.254.253] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nDROm-0002DK-Uj;
        Fri, 28 Jan 2022 15:34:46 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri, 28 Jan 2022 15:34:28 +0200
Message-Id: <iwlwifi.20220128153014.4ac2f19c121e.Ied9469d93f8199206242bfba96e4e8d1949e3a08@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220128133433.591765-1-luca@coelho.fi>
References: <20220128133433.591765-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 08/13] iwlwifi: fix various more -Wcast-qual warnings
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

When enabling W=3 that gets us -Wcast-qual, fix those warnings
in the code and propagate constness properly, or cast it away
via (uintptr_t) where really needed.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.c       |  2 +-
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c       | 12 ++++++------
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c   |  2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c       |  4 ++--
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c        |  4 ++--
 6 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
index 0177f9e2fa08..b6d3ac6ed440 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
@@ -181,7 +181,7 @@ static int iwl_pnvm_parse(struct iwl_trans *trans, const u8 *data,
 		u32 tlv_len, tlv_type;
 
 		len -= sizeof(*tlv);
-		tlv = (void *)data;
+		tlv = (const void *)data;
 
 		tlv_len = le32_to_cpu(tlv->length);
 		tlv_type = le32_to_cpu(tlv->type);
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
index bd82c24811c8..23b1d689ba7b 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
@@ -69,7 +69,7 @@ void *iwl_uefi_get_pnvm(struct iwl_trans *trans, size_t *len)
 static void *iwl_uefi_reduce_power_section(struct iwl_trans *trans,
 					   const u8 *data, size_t len)
 {
-	struct iwl_ucode_tlv *tlv;
+	const struct iwl_ucode_tlv *tlv;
 	u8 *reduce_power_data = NULL, *tmp;
 	u32 size = 0;
 
@@ -79,7 +79,7 @@ static void *iwl_uefi_reduce_power_section(struct iwl_trans *trans,
 		u32 tlv_len, tlv_type;
 
 		len -= sizeof(*tlv);
-		tlv = (void *)data;
+		tlv = (const void *)data;
 
 		tlv_len = le32_to_cpu(tlv->length);
 		tlv_type = le32_to_cpu(tlv->type);
@@ -154,7 +154,7 @@ static void *iwl_uefi_reduce_power_section(struct iwl_trans *trans,
 static void *iwl_uefi_reduce_power_parse(struct iwl_trans *trans,
 					 const u8 *data, size_t len)
 {
-	struct iwl_ucode_tlv *tlv;
+	const struct iwl_ucode_tlv *tlv;
 	void *sec_data;
 
 	IWL_DEBUG_FW(trans, "Parsing REDUCE_POWER data\n");
@@ -163,7 +163,7 @@ static void *iwl_uefi_reduce_power_parse(struct iwl_trans *trans,
 		u32 tlv_len, tlv_type;
 
 		len -= sizeof(*tlv);
-		tlv = (void *)data;
+		tlv = (const void *)data;
 
 		tlv_len = le32_to_cpu(tlv->length);
 		tlv_type = le32_to_cpu(tlv->type);
@@ -175,8 +175,8 @@ static void *iwl_uefi_reduce_power_parse(struct iwl_trans *trans,
 		}
 
 		if (tlv_type == IWL_UCODE_TLV_PNVM_SKU) {
-			struct iwl_sku_id *sku_id =
-				(void *)(data + sizeof(*tlv));
+			const struct iwl_sku_id *sku_id =
+				(const void *)(data + sizeof(*tlv));
 
 			IWL_DEBUG_FW(trans,
 				     "Got IWL_UCODE_TLV_PNVM_SKU len %d\n",
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
index fdb3f7945f84..29a04bb02a6d 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
@@ -271,7 +271,7 @@ static int iwl_dbg_tlv_alloc_trigger(struct iwl_trans *trans,
 static int iwl_dbg_tlv_config_set(struct iwl_trans *trans,
 				  const struct iwl_ucode_tlv *tlv)
 {
-	struct iwl_fw_ini_conf_set_tlv *conf_set = (void *)tlv->data;
+	const struct iwl_fw_ini_conf_set_tlv *conf_set = (const void *)tlv->data;
 	u32 tp = le32_to_cpu(conf_set->time_point);
 	u32 type = le32_to_cpu(conf_set->set_type);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index 04abfac7cd06..5a9e644a791c 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -601,7 +601,7 @@ static void iwl_parse_dbg_tlv_assert_tables(struct iwl_drv *drv,
 		     sizeof(region->special_mem))
 		return;
 
-	region = (void *)tlv->data;
+	region = (const void *)tlv->data;
 	addr = le32_to_cpu(region->special_mem.base_addr);
 	addr += le32_to_cpu(region->special_mem.offset);
 	addr &= ~FW_ADDR_CACHE_CONTROL;
@@ -1279,7 +1279,7 @@ static int iwl_parse_tlv_firmware(struct iwl_drv *drv,
 
 	if (len) {
 		IWL_ERR(drv, "invalid TLV after parsing: %zd\n", len);
-		iwl_print_hex_dump(drv, IWL_DL_FW, (u8 *)data, len);
+		iwl_print_hex_dump(drv, IWL_DL_FW, data, len);
 		return -EINVAL;
 	}
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index 7b2bbc651dac..3803847dd31d 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -732,7 +732,7 @@ static void iwl_init_he_6ghz_capa(struct iwl_trans *trans,
 	IWL_DEBUG_EEPROM(trans->dev, "he_6ghz_capa=0x%x\n", he_6ghz_capa);
 
 	/* we know it's writable - we set it before ourselves */
-	iftype_data = (void *)sband->iftype_data;
+	iftype_data = (void *)(uintptr_t)sband->iftype_data;
 	for (i = 0; i < sband->n_iftype_data; i++)
 		iftype_data[i].he_6ghz_capa.capa = cpu_to_le16(he_6ghz_capa);
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index a46365a5a9a9..b1dffcde4a9a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -31,7 +31,7 @@ void iwl_mvm_set_rekey_data(struct ieee80211_hw *hw,
 	memcpy(mvmvif->rekey_data.kck, data->kck, data->kck_len);
 	mvmvif->rekey_data.akm = data->akm & 0xFF;
 	mvmvif->rekey_data.replay_ctr =
-		cpu_to_le64(be64_to_cpup((__be64 *)data->replay_ctr));
+		cpu_to_le64(be64_to_cpup((const __be64 *)data->replay_ctr));
 	mvmvif->rekey_data.valid = true;
 
 	mutex_unlock(&mvm->mutex);
@@ -1484,7 +1484,7 @@ static void iwl_mvm_report_wakeup_reasons(struct iwl_mvm *mvm,
 		int pktsize = status->wake_packet_bufsize;
 		int pktlen = status->wake_packet_length;
 		const u8 *pktdata = status->wake_packet;
-		struct ieee80211_hdr *hdr = (void *)pktdata;
+		const struct ieee80211_hdr *hdr = (const void *)pktdata;
 		int truncated = pktlen - pktsize;
 
 		/* this would be a firmware bug */
-- 
2.34.1

