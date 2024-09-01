Return-Path: <linux-wireless+bounces-12291-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9209674EE
	for <lists+linux-wireless@lfdr.de>; Sun,  1 Sep 2024 06:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D240B1F21C85
	for <lists+linux-wireless@lfdr.de>; Sun,  1 Sep 2024 04:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03EDC1C36;
	Sun,  1 Sep 2024 04:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BvPisbfY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2ED171D2
	for <linux-wireless@vger.kernel.org>; Sun,  1 Sep 2024 04:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725164291; cv=none; b=csPZNWis8J4b000U6JO2cgGFpIrbpfAhS1zAQbJYw1WWTUkB+hWGVWImGlgQhot3wQqUzxIvuBcqL4U6PuOc0WZPEK/+VtBJKnikwoyp5rbYbWQvN+d72AHQMja+8oB3wRNQtfbWmJQ6F4swYnDI+qf6wRUhRT9+k7/KHtAQuVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725164291; c=relaxed/simple;
	bh=HQJOvEoG/541sD52SjN0WPmAjk8NIUqNRNwT6bd5F3I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j1pamUKIAOSfR8REghAQBAbnfG09O2A8qWG55UWh4PdRjpMtfGNq1Cgh2ZPofB6njYMPhYoIEi0rTmnQAVLngqNJJu1Ze8Rdij9ml9sOAXhqTypLmymDbadleram24JXvqOgIeHCeExa/9I/1f9Cgp+BnbZ8uPzWdsx/xISN8E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BvPisbfY; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725164290; x=1756700290;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HQJOvEoG/541sD52SjN0WPmAjk8NIUqNRNwT6bd5F3I=;
  b=BvPisbfY9xt80iLmTYmS397n5RLaD7aZrPB74MtOj9EBdkITVCfvU4+k
   UXIhTL+9X33SubqKKpxqZuC8acO0QlBlLMMfsQ0z9KmFvF/0VLIbpwbYa
   +tI20HGcHEG/MyLdcEFApKMsQmQbGssc1JlrOxNLVwr/2/ORxxhhsLcg7
   QwqXQyqJaryZw0pgDTeJzaxhuKB7YhBsMhTxezdV1/+XovZkIuJtWsxCo
   yLgDUs+3cc0TaWyfIBf8uTGilcggayotV9riHKr2/Mm2Wy8g7crHjGoGR
   Sg3oRZELu2v+skQAO4Xc2WPxPNT14GtMd1dSYKXMJ2hjdV//k8PQqzzzK
   Q==;
X-CSE-ConnectionGUID: YeXqt8x+SCuR7baXli7CPg==
X-CSE-MsgGUID: j6nmwsH9QnmT1M0YughBkg==
X-IronPort-AV: E=McAfee;i="6700,10204,11181"; a="27559513"
X-IronPort-AV: E=Sophos;i="6.10,193,1719903600"; 
   d="scan'208";a="27559513"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2024 21:18:09 -0700
X-CSE-ConnectionGUID: kQGVau9nR/mqJ6dCH1fmxQ==
X-CSE-MsgGUID: 7PdNraYoT1ate4+fSTgThw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,193,1719903600"; 
   d="scan'208";a="64276288"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2024 21:18:07 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Ilan Peer <ilan.peer@intel.com>,
	Daniel Gabay <daniel.gabay@intel.com>
Subject: [PATCH 1/8] wifi: iwlwifi: mvm: refactor scan channel description a bit
Date: Sun,  1 Sep 2024 07:17:50 +0300
Message-Id: <20240901071542.e31623ae4201.I1ea69a8ec3d39492f39d84e31fb105b159359c28@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240901041757.917200-1-miriam.rachel.korenblit@intel.com>
References: <20240901041757.917200-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

The channel number is at the same position across all versions
of the channel description struct, so move it out of the union
that versions it. Also add __packed annotations to all of the
sub-structs and the union so it's packed correctly, and fully
document the structure.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Reviewed-by: Daniel Gabay <daniel.gabay@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/scan.h  | 33 +++++++++++--------
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 12 +++----
 2 files changed, 26 insertions(+), 19 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h b/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
index 0aefdf353b21..f486d624500b 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
@@ -731,39 +731,46 @@ enum iwl_umac_scan_general_params_flags2 {
  * struct iwl_scan_channel_cfg_umac
  * @flags:		bitmap - 0-19:	directed scan to i'th ssid.
  * @channel_num:	channel number 1-13 etc.
- * @band:		band of channel: 0 for 2GHz, 1 for 5GHz
- * @iter_count:		repetition count for the channel.
- * @iter_interval:	interval between two scan iterations on one channel.
+ * @v1:			command version 1
+ * @v1.iter_count:	repetition count for the channel.
+ * @v1.iter_interval:	interval between two scan iterations on one channel.
+ * @v2:			command versions 2-4
+ * @v2.band:		band of channel: 0 for 2GHz, 1 for 5GHz
+ * @v2.iter_count:	repetition count for the channel.
+ * @v2.iter_interval:	interval between two scan iterations on one channel.
+ * @v5:			command versions 5 and up
+ * @v5.iter_count:	repetition count for the channel.
+ * @v5.iter_interval:	interval between two scan iterations on one channel.
+ * @v5.psd_20:		highest PSD value for all APs known so far
+ *			on this channel.
  */
 struct  iwl_scan_channel_cfg_umac {
 #define IWL_CHAN_CFG_FLAGS_BAND_POS 30
 	__le32 flags;
+	u8 channel_num;
 
 	/* All versions are of the same size, so use a union without adjusting
 	 * the command size later
 	 */
 	union {
 		struct {
-			u8 channel_num;
 			u8 iter_count;
 			__le16 iter_interval;
-		} v1;  /* SCAN_CHANNEL_CONFIG_API_S_VER_1 */
+		} __packed v1;  /* SCAN_CHANNEL_CONFIG_API_S_VER_1 */
 		struct {
-			u8 channel_num;
 			u8 band;
 			u8 iter_count;
 			u8 iter_interval;
-		 } v2; /* SCAN_CHANNEL_CONFIG_API_S_VER_2
-			* SCAN_CHANNEL_CONFIG_API_S_VER_3
-			* SCAN_CHANNEL_CONFIG_API_S_VER_4
-			*/
+		} __packed v2; /* SCAN_CHANNEL_CONFIG_API_S_VER_2
+				* SCAN_CHANNEL_CONFIG_API_S_VER_3
+				* SCAN_CHANNEL_CONFIG_API_S_VER_4
+				*/
 		struct {
-			u8 channel_num;
 			u8 psd_20;
 			u8 iter_count;
 			u8 iter_interval;
-		} v5;  /* SCAN_CHANNEL_CONFIG_API_S_VER_5 */
-	};
+		} __packed v5;  /* SCAN_CHANNEL_CONFIG_API_S_VER_5 */
+	} __packed;
 } __packed;
 
 /**
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index 4ae6339f87c7..296d8c562207 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -1594,7 +1594,7 @@ iwl_mvm_umac_scan_cfg_channels(struct iwl_mvm *mvm,
 
 	for (i = 0; i < n_channels; i++) {
 		channel_cfg[i].flags = cpu_to_le32(flags);
-		channel_cfg[i].v1.channel_num = channels[i]->hw_value;
+		channel_cfg[i].channel_num = channels[i]->hw_value;
 		if (iwl_mvm_is_scan_ext_chan_supported(mvm)) {
 			enum nl80211_band band = channels[i]->band;
 
@@ -1626,13 +1626,13 @@ iwl_mvm_umac_scan_cfg_channels_v4(struct iwl_mvm *mvm,
 			&cp->channel_config[i];
 
 		cfg->flags = cpu_to_le32(flags);
-		cfg->v2.channel_num = channels[i]->hw_value;
+		cfg->channel_num = channels[i]->hw_value;
 		cfg->v2.band = iwl_mvm_phy_band_from_nl80211(band);
 		cfg->v2.iter_count = 1;
 		cfg->v2.iter_interval = 0;
 
 		iwl_mvm_scan_ch_add_n_aps_override(vif_type,
-						   cfg->v2.channel_num,
+						   cfg->channel_num,
 						   cfg->v2.band, bitmap,
 						   bitmap_n_entries);
 	}
@@ -1656,7 +1656,7 @@ iwl_mvm_umac_scan_cfg_channels_v7(struct iwl_mvm *mvm,
 		u8 iwl_band = iwl_mvm_phy_band_from_nl80211(band);
 
 		cfg->flags = cpu_to_le32(flags | n_aps_flag);
-		cfg->v2.channel_num = channels[i]->hw_value;
+		cfg->channel_num = channels[i]->hw_value;
 		if (cfg80211_channel_is_psc(channels[i]))
 			cfg->flags = 0;
 		cfg->v2.iter_count = 1;
@@ -1778,7 +1778,7 @@ iwl_mvm_umac_scan_cfg_channels_v7_6g(struct iwl_mvm *mvm,
 		    !params->n_6ghz_params && params->n_ssids)
 			continue;
 
-		cfg->v1.channel_num = params->channels[i]->hw_value;
+		cfg->channel_num = params->channels[i]->hw_value;
 		if (version < 17)
 			cfg->v2.band = PHY_BAND_6;
 		else
@@ -2466,7 +2466,7 @@ iwl_mvm_scan_umac_fill_ch_p_v7(struct iwl_mvm *mvm,
 			if (!cfg80211_channel_is_psc(channel))
 				continue;
 
-			cfg->v5.channel_num = channel->hw_value;
+			cfg->channel_num = channel->hw_value;
 			cfg->v5.iter_count = 1;
 			cfg->v5.iter_interval = 0;
 
-- 
2.34.1


