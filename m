Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5FAF34FC5B
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Mar 2021 11:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234644AbhCaJPK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 31 Mar 2021 05:15:10 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:43760 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S234699AbhCaJPA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 31 Mar 2021 05:15:00 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1lRWwD-00087q-I4; Wed, 31 Mar 2021 12:14:59 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 31 Mar 2021 12:14:46 +0300
Message-Id: <iwlwifi.20210331121101.7c7bd00e0aeb.Ib226ad57e416b43a710c36a78a617d4243458b99@changeid>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210331091452.543321-1-luca@coelho.fi>
References: <20210331091452.543321-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.5-pre1
Subject: [PATCH 06/12] iwlwifi: mvm: Add support for 6GHz passive scan
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ilan Peer <ilan.peer@intel.com>

When doing scan while 6GHz channels are not enabled, the 6GHz band
is not scanned. Thus, if there are no APs on the 2GHz and 5GHz bands
(that will allow discovery of geographic location etc. that would
allow enabling the 6GHz channels) but there are non collocated APs
on 6GHz PSC channels these would never be discovered.

To overcome this, FW added support for performing passive UHB scan
in case no APs were discovered during scan on the 2GHz and 5GHz
channels.

Add support for enabling such scan when the following conditions are
met:

- 6GHz channels are supported but not enabled by regulatory.
- Station interface is not associated or less than a defined time
  interval passed from the last resume or HW reset flows.
- At least 4 channels are included in the scan request
- The scan request includes the widlcard SSID.
- At least 50 minutes passed from the last 6GHz passive scan.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/scan.h  |   8 ++
 drivers/net/wireless/intel/iwlwifi/fw/file.h  |   3 +
 .../wireless/intel/iwlwifi/mvm/constants.h    |   2 +
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   |   2 +
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |   2 +
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   3 +
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 128 ++++++++++++++++++
 7 files changed, 148 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h b/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
index 6b8ca35cec1a..b2605aefc290 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
@@ -634,6 +634,12 @@ enum iwl_umac_scan_general_flags2 {
  * @IWL_UMAC_SCAN_GEN_FLAGS_V2_TRIGGER_UHB_SCAN: at the end of 2.4GHz and
  *		5.2Ghz bands scan, trigger scan on 6GHz band to discover
  *		the reported collocated APs
+ * @IWL_UMAC_SCAN_GEN_FLAGS_V2_6GHZ_PASSIVE_SCAN: at the end of 2.4GHz and 5GHz
+ *      bands scan, if not APs were discovered, allow scan to conitnue and scan
+ *      6GHz PSC channels in order to discover country information.
+ * @IWL_UMAC_SCAN_GEN_FLAGS_V2_6GHZ_PASSIVE_SCAN_FILTER_IN: in case
+ *      &IWL_UMAC_SCAN_GEN_FLAGS_V2_6GHZ_PASSIVE_SCAN is enabled and scan is
+ *      activated over 6GHz PSC channels, filter in beacons and probe responses.
  */
 enum iwl_umac_scan_general_flags_v2 {
 	IWL_UMAC_SCAN_GEN_FLAGS_V2_PERIODIC             = BIT(0),
@@ -649,6 +655,8 @@ enum iwl_umac_scan_general_flags_v2 {
 	IWL_UMAC_SCAN_GEN_FLAGS_V2_MULTI_SSID           = BIT(10),
 	IWL_UMAC_SCAN_GEN_FLAGS_V2_FORCE_PASSIVE        = BIT(11),
 	IWL_UMAC_SCAN_GEN_FLAGS_V2_TRIGGER_UHB_SCAN     = BIT(12),
+	IWL_UMAC_SCAN_GEN_FLAGS_V2_6GHZ_PASSIVE_SCAN    = BIT(13),
+	IWL_UMAC_SCAN_GEN_FLAGS_V2_6GHZ_PASSIVE_SCAN_FILTER_IN = BIT(14),
 };
 
 /**
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/file.h b/drivers/net/wireless/intel/iwlwifi/fw/file.h
index 35dffcaf5aba..f9c5cf538ad1 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/file.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/file.h
@@ -362,6 +362,8 @@ typedef unsigned int __bitwise iwl_ucode_tlv_capa_t;
  * @IWL_UCODE_TLV_CAPA_PROTECTED_TWT: Supports protection of TWT action frames
  * @IWL_UCODE_TLV_CAPA_FW_RESET_HANDSHAKE: Supports the firmware handshake in
  *	reset flow
+ * @IWL_UCODE_TLV_CAPA_PASSIVE_6GHZ_SCAN: Support for passive scan on 6GHz PSC
+ *      channels even when these are not enabled.
  *
  * @NUM_IWL_UCODE_TLV_CAPA: number of bits used
  */
@@ -408,6 +410,7 @@ enum iwl_ucode_tlv_capa {
 	IWL_UCODE_TLV_CAPA_SESSION_PROT_CMD		= (__force iwl_ucode_tlv_capa_t)54,
 	IWL_UCODE_TLV_CAPA_PROTECTED_TWT		= (__force iwl_ucode_tlv_capa_t)56,
 	IWL_UCODE_TLV_CAPA_FW_RESET_HANDSHAKE		= (__force iwl_ucode_tlv_capa_t)57,
+	IWL_UCODE_TLV_CAPA_PASSIVE_6GHZ_SCAN		= (__force iwl_ucode_tlv_capa_t)58,
 
 	/* set 2 */
 	IWL_UCODE_TLV_CAPA_EXTENDED_DTS_MEASURE		= (__force iwl_ucode_tlv_capa_t)64,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/constants.h b/drivers/net/wireless/intel/iwlwifi/mvm/constants.h
index 45634302801f..1343f25f1090 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/constants.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/constants.h
@@ -117,5 +117,7 @@
 #define IWL_MVM_FTM_INITIATOR_SMOOTH_OVERSHOOT  20016
 #define IWL_MVM_FTM_INITIATOR_SMOOTH_AGE_SEC    2
 #define IWL_MVM_DISABLE_AP_FILS			false
+#define IWL_MVM_6GHZ_PASSIVE_SCAN_TIMEOUT       3000 /* in seconds */
+#define IWL_MVM_6GHZ_PASSIVE_SCAN_ASSOC_TIMEOUT 60   /* in seconds */
 
 #endif /* __MVM_CONSTANTS_H */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index a7dc85c704a9..2e28cf299ef4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -2028,6 +2028,8 @@ static int __iwl_mvm_resume(struct iwl_mvm *mvm, bool test)
 
 	mutex_lock(&mvm->mutex);
 
+	mvm->last_reset_or_resume_time_jiffies = jiffies;
+
 	/* get the BSS vif pointer again */
 	vif = iwl_mvm_get_bss_vif(mvm);
 	if (IS_ERR_OR_NULL(vif))
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index fd35dd31613e..607d5d564928 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1099,6 +1099,8 @@ int __iwl_mvm_mac_start(struct iwl_mvm *mvm)
 	iwl_dbg_tlv_time_point(&mvm->fwrt, IWL_FW_INI_TIME_POINT_PERIODIC,
 			       NULL);
 
+	mvm->last_reset_or_resume_time_jiffies = jiffies;
+
 	if (ret && test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status)) {
 		/* Something went wrong - we need to finish some cleanup
 		 * that normally iwl_mvm_mac_restart_complete() below
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index e607ad713f88..e2a37ac7c4b1 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1096,6 +1096,9 @@ struct iwl_mvm {
 	/* sniffer data to include in radiotap */
 	__le16 cur_aid;
 	u8 cur_bssid[ETH_ALEN];
+
+	unsigned long last_6ghz_passive_scan_jiffies;
+	unsigned long last_reset_or_resume_time_jiffies;
 };
 
 /* Extract MVM priv from op_mode and _hw */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index caf87f320094..5a0696c44f6d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -43,6 +43,9 @@
 /* adaptive dwell number of APs override for social channels */
 #define IWL_SCAN_ADWELL_N_APS_SOCIAL_CHS 2
 
+/* minimal number of 2GHz and 5GHz channels in the regular scan request */
+#define IWL_MVM_6GHZ_PASSIVE_SCAN_MIN_CHANS 4
+
 struct iwl_mvm_scan_timing_params {
 	u32 suspend_time;
 	u32 max_out_time;
@@ -94,6 +97,7 @@ struct iwl_mvm_scan_params {
 	struct cfg80211_scan_6ghz_params *scan_6ghz_params;
 	u32 n_6ghz_params;
 	bool scan_6ghz;
+	bool enable_6ghz_passive;
 };
 
 static inline void *iwl_mvm_get_scan_req_umac_data(struct iwl_mvm *mvm)
@@ -1873,6 +1877,98 @@ static u8 iwl_mvm_scan_umac_chan_flags_v2(struct iwl_mvm *mvm,
 	return flags;
 }
 
+static void iwl_mvm_scan_6ghz_passive_scan(struct iwl_mvm *mvm,
+					   struct iwl_mvm_scan_params *params,
+					   struct ieee80211_vif *vif)
+{
+	struct ieee80211_supported_band *sband =
+		&mvm->nvm_data->bands[NL80211_BAND_6GHZ];
+	u32 n_disabled, i;
+
+	params->enable_6ghz_passive = false;
+
+	if (params->scan_6ghz)
+		return;
+
+	if (!fw_has_capa(&mvm->fw->ucode_capa,
+			 IWL_UCODE_TLV_CAPA_PASSIVE_6GHZ_SCAN)) {
+		IWL_DEBUG_SCAN(mvm,
+			       "6GHz passive scan: Not supported by FW\n");
+		return;
+	}
+
+	/* 6GHz passive scan allowed only on station interface  */
+	if (vif->type != NL80211_IFTYPE_STATION) {
+		IWL_DEBUG_SCAN(mvm,
+			       "6GHz passive scan: not station interface\n");
+		return;
+	}
+
+	/*
+	 * 6GHz passive scan is allowed while associated in a defined time
+	 * interval following HW reset or resume flow
+	 */
+	if (vif->bss_conf.assoc &&
+	    (time_before(mvm->last_reset_or_resume_time_jiffies +
+			 (IWL_MVM_6GHZ_PASSIVE_SCAN_ASSOC_TIMEOUT * HZ),
+			 jiffies))) {
+		IWL_DEBUG_SCAN(mvm, "6GHz passive scan: associated\n");
+		return;
+	}
+
+	/* No need for 6GHz passive scan if not enough time elapsed */
+	if (time_after(mvm->last_6ghz_passive_scan_jiffies +
+		       (IWL_MVM_6GHZ_PASSIVE_SCAN_TIMEOUT * HZ), jiffies)) {
+		IWL_DEBUG_SCAN(mvm,
+			       "6GHz passive scan: timeout did not expire\n");
+		return;
+	}
+
+	/* not enough channels in the regular scan request */
+	if (params->n_channels < IWL_MVM_6GHZ_PASSIVE_SCAN_MIN_CHANS) {
+		IWL_DEBUG_SCAN(mvm,
+			       "6GHz passive scan: not enough channels\n");
+		return;
+	}
+
+	for (i = 0; i < params->n_ssids; i++) {
+		if (!params->ssids[i].ssid_len)
+			break;
+	}
+
+	/* not a wildcard scan, so cannot enable passive 6GHz scan */
+	if (i == params->n_ssids) {
+		IWL_DEBUG_SCAN(mvm,
+			       "6GHz passive scan: no wildcard SSID\n");
+		return;
+	}
+
+	if (!sband || !sband->n_channels) {
+		IWL_DEBUG_SCAN(mvm,
+			       "6GHz passive scan: no 6GHz channels\n");
+		return;
+	}
+
+	for (i = 0, n_disabled = 0; i < sband->n_channels; i++) {
+		if (sband->channels[i].flags & (IEEE80211_CHAN_DISABLED))
+			n_disabled++;
+	}
+
+	/*
+	 * Not all the 6GHz channels are disabled, so no need for 6GHz passive
+	 * scan
+	 */
+	if (n_disabled != sband->n_channels) {
+		IWL_DEBUG_SCAN(mvm,
+			       "6GHz passive scan: 6GHz channels enabled\n");
+		return;
+	}
+
+	/* all conditions to enable 6ghz passive scan are satisfied */
+	IWL_DEBUG_SCAN(mvm, "6GHz passive scan: can be enabled\n");
+	params->enable_6ghz_passive = true;
+}
+
 static u16 iwl_mvm_scan_umac_flags_v2(struct iwl_mvm *mvm,
 				      struct iwl_mvm_scan_params *params,
 				      struct ieee80211_vif *vif,
@@ -1911,6 +2007,9 @@ static u16 iwl_mvm_scan_umac_flags_v2(struct iwl_mvm *mvm,
 	    params->flags & NL80211_SCAN_FLAG_COLOCATED_6GHZ)
 		flags |= IWL_UMAC_SCAN_GEN_FLAGS_V2_TRIGGER_UHB_SCAN;
 
+	if (params->enable_6ghz_passive)
+		flags |= IWL_UMAC_SCAN_GEN_FLAGS_V2_6GHZ_PASSIVE_SCAN;
+
 	return flags;
 }
 
@@ -2183,6 +2282,30 @@ iwl_mvm_scan_umac_fill_ch_p_v6(struct iwl_mvm *mvm,
 					  params->n_channels,
 					  channel_cfg_flags,
 					  vif->type);
+
+	if (params->enable_6ghz_passive) {
+		struct ieee80211_supported_band *sband =
+			&mvm->nvm_data->bands[NL80211_BAND_6GHZ];
+		u32 i;
+
+		for (i = 0; i < sband->n_channels; i++) {
+			struct ieee80211_channel *channel =
+				&sband->channels[i];
+
+			struct iwl_scan_channel_cfg_umac *cfg =
+				&cp->channel_config[cp->count];
+
+			if (!cfg80211_channel_is_psc(channel))
+				continue;
+
+			cfg->flags = 0;
+			cfg->v2.channel_num = channel->hw_value;
+			cfg->v2.band = PHY_BAND_6;
+			cfg->v2.iter_count = 1;
+			cfg->v2.iter_interval = 0;
+			cp->count++;
+		}
+	}
 }
 
 static int iwl_mvm_scan_umac_v12(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
@@ -2500,6 +2623,8 @@ int iwl_mvm_reg_scan_start(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 
 	iwl_mvm_build_scan_probe(mvm, vif, ies, &params);
 
+	iwl_mvm_scan_6ghz_passive_scan(mvm, &params, vif);
+
 	uid = iwl_mvm_build_scan_cmd(mvm, vif, &hcmd, &params,
 				     IWL_MVM_SCAN_REGULAR);
 
@@ -2524,6 +2649,9 @@ int iwl_mvm_reg_scan_start(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	mvm->scan_status |= IWL_MVM_SCAN_REGULAR;
 	mvm->scan_vif = iwl_mvm_vif_from_mac80211(vif);
 
+	if (params.enable_6ghz_passive)
+		mvm->last_6ghz_passive_scan_jiffies = jiffies;
+
 	schedule_delayed_work(&mvm->scan_timeout_dwork,
 			      msecs_to_jiffies(SCAN_TIMEOUT));
 
-- 
2.31.0

