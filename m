Return-Path: <linux-wireless+bounces-28067-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BBF3BEE0FB
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Oct 2025 10:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1F1F3A710F
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Oct 2025 08:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D1B29D270;
	Sun, 19 Oct 2025 08:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HZQG3D4n"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7540E11713
	for <linux-wireless@vger.kernel.org>; Sun, 19 Oct 2025 08:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760863549; cv=none; b=LFLa1TkkIIVJyAEehGFThpqG9/1CKtkcnCTxsawyMUUb5yopOqWPYkL/sGDAMxEApoD6Bk2+fGRHJYV1SLxW2UTixSnBge93TRtY8gdgBF7oK4XrVeN/oVw2MiZLCZ+7ZVK2YkgkJdduRtR3gwSKXIOeOEGMS1eirxbKDkOx+vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760863549; c=relaxed/simple;
	bh=cGYVa1HVAYvF9g1SwPBcVz8jkp3B6jaW+Ygpvwbc4Nk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AYt+i957zhQa+HJVsWlGMS5lw07Sx6Et2PRPIbWLEN3Jo61C6j9Ol66fiurqVP++ZL5wS7aOGHmfwT3KjhJPKIW1hDzwY1IKwDvn4jlLWgKP9hDxypSfq8en8CBf8qaB64oEu/bbnDYM0kaCyS3vQ/r/SsvYtCv41B68nDFatQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HZQG3D4n; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760863547; x=1792399547;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cGYVa1HVAYvF9g1SwPBcVz8jkp3B6jaW+Ygpvwbc4Nk=;
  b=HZQG3D4ncHi6X1j6j7kNJoMTNjU3ueYZQEcqiqlqPIFepEgoF47ODIFR
   lm8jnIasm9ReBIIjoV3XXDRqOrtCynmwRZ44FjeJbHuEFnv9v1cvcGSIx
   jxRBbsH7TXVEns7MoAcjUZlv0seEie7uk+ppVXaRvS19vuhqN0V/MmgdE
   Kde1S6X1TB0OwpL+2XzgDGS+bsPG8z0HCFjJSDc+JOQnLOms5F1cecJtM
   tMeuqF/AXe/YsuMfLJwqdqEr2nwMyKejLRsDbVvD7x9Ufsd5h6jw520db
   TjW5U5v58FoYYhzwnBc41bjWrZWIWW20IwRtikIPkoLqBrMMv7D70GiDU
   Q==;
X-CSE-ConnectionGUID: 2XtDFFeZRP+Hd/8TIpXBTQ==
X-CSE-MsgGUID: r+UfYiUkSnmuaTplVVrSYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74363193"
X-IronPort-AV: E=Sophos;i="6.19,240,1754982000"; 
   d="scan'208";a="74363193"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2025 01:45:47 -0700
X-CSE-ConnectionGUID: e0ybvNvWQQ+xVJgvP4HzNA==
X-CSE-MsgGUID: P8i6GEHtSWiGShCxcO/c5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,240,1754982000"; 
   d="scan'208";a="182279902"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2025 01:45:46 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-next 12/15] wifi: iwlwifi: disable EHT if the device doesn't allow it
Date: Sun, 19 Oct 2025 11:45:13 +0300
Message-Id: <20251019114304.71121f4e5557.I49e2329d4121f9e52d0889156d0c3e8778e27d88@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251019084516.2568208-1-miriam.rachel.korenblit@intel.com>
References: <20251019084516.2568208-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

We have a few devices that don't allow EHT. Make sure we reflect this
towards mac80211 so that we won't try to enable it.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/cfg/rf-fm.c    |  1 +
 .../net/wireless/intel/iwlwifi/cfg/rf-wh.c    | 23 +++++++++++++++++++
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  5 +++-
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    |  2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c |  6 +++--
 5 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/rf-fm.c b/drivers/net/wireless/intel/iwlwifi/cfg/rf-fm.c
index 456a666c8dfd..fd82050e33a3 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/rf-fm.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/rf-fm.c
@@ -19,6 +19,7 @@
 	.non_shared_ant = ANT_B,					\
 	.vht_mu_mimo_supported = true,					\
 	.uhb_supported = true,						\
+	.eht_supported = true,						\
 	.num_rbds = IWL_NUM_RBDS_EHT,					\
 	.nvm_ver = IWL_FM_NVM_VERSION,					\
 	.nvm_type = IWL_NVM_EXT
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/rf-wh.c b/drivers/net/wireless/intel/iwlwifi/cfg/rf-wh.c
index b8c6b06e7099..b5803ea1eb78 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/rf-wh.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/rf-wh.c
@@ -4,8 +4,31 @@
  */
 #include "iwl-config.h"
 
+/* NVM versions */
+#define IWL_WH_NVM_VERSION		0x0a1d
+
+#define IWL_DEVICE_WH							\
+	.ht_params = {							\
+		.stbc = true,						\
+		.ldpc = true,						\
+		.ht40_bands = BIT(NL80211_BAND_2GHZ) |			\
+			      BIT(NL80211_BAND_5GHZ),			\
+	},								\
+	.led_mode = IWL_LED_RF_STATE,					\
+	.non_shared_ant = ANT_B,					\
+	.vht_mu_mimo_supported = true,					\
+	.uhb_supported = true,						\
+	.num_rbds = IWL_NUM_RBDS_EHT,					\
+	.nvm_ver = IWL_WH_NVM_VERSION,					\
+	.nvm_type = IWL_NVM_EXT
+
 /* currently iwl_rf_wh/iwl_rf_wh_160mhz are just defines for the FM ones */
 
+const struct iwl_rf_cfg iwl_rf_wh_non_eht = {
+	IWL_DEVICE_WH,
+	.eht_supported = false,
+};
+
 const char iwl_killer_be1775s_name[] =
 	"Killer(R) Wi-Fi 7 BE1775s 320MHz Wireless Network Adapter (BE211D2W)";
 const char iwl_killer_be1775i_name[] =
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index e44936204068..0a5a683325ef 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -416,6 +416,7 @@ struct iwl_mac_cfg {
  * @vht_mu_mimo_supported: VHT MU-MIMO support
  * @nvm_type: see &enum iwl_nvm_type
  * @uhb_supported: ultra high band channels supported
+ * @eht_supported: EHT supported
  * @num_rbds: number of receive buffer descriptors to use
  *	(only used for multi-queue capable devices)
  *
@@ -448,7 +449,8 @@ struct iwl_rf_cfg {
 	    host_interrupt_operation_mode:1,
 	    lp_xtal_workaround:1,
 	    vht_mu_mimo_supported:1,
-	    uhb_supported:1;
+	    uhb_supported:1,
+	    eht_supported:1;
 	u8 valid_tx_ant;
 	u8 valid_rx_ant;
 	u8 non_shared_ant;
@@ -742,6 +744,7 @@ extern const struct iwl_rf_cfg iwl_rf_fm;
 extern const struct iwl_rf_cfg iwl_rf_fm_160mhz;
 #define iwl_rf_wh iwl_rf_fm
 #define iwl_rf_wh_160mhz iwl_rf_fm_160mhz
+extern const struct iwl_rf_cfg iwl_rf_wh_non_eht;
 #define iwl_rf_pe iwl_rf_fm
 #endif /* CONFIG_IWLMLD */
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index 23465e4c4b39..e021fc57d85d 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -2080,7 +2080,7 @@ struct iwl_nvm_data *iwl_get_nvm(struct iwl_trans *trans,
 		!!(mac_flags & NVM_MAC_SKU_FLAGS_BAND_5_2_ENABLED);
 	nvm->sku_cap_mimo_disabled =
 		!!(mac_flags & NVM_MAC_SKU_FLAGS_MIMO_DISABLED);
-	if (CSR_HW_RFID_TYPE(trans->info.hw_rf_id) >= IWL_CFG_RF_TYPE_FM)
+	if (trans->cfg->eht_supported)
 		nvm->sku_cap_11be_enable = true;
 
 	/* Initialize PHY sku data */
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index af5faf49f4ce..ab132eb84096 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1053,8 +1053,10 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 
 /* WH RF */
 	IWL_DEV_INFO(iwl_rf_wh, iwl_be211_name, RF_TYPE(WH)),
-	IWL_DEV_INFO(iwl_rf_wh, iwl_ax221_name, RF_TYPE(WH), SUBDEV(0x0514)),
-	IWL_DEV_INFO(iwl_rf_wh, iwl_ax221_name, RF_TYPE(WH), SUBDEV(0x4514)),
+	IWL_DEV_INFO(iwl_rf_wh_non_eht, iwl_ax221_name, RF_TYPE(WH),
+		     SUBDEV(0x0514)),
+	IWL_DEV_INFO(iwl_rf_wh_non_eht, iwl_ax221_name, RF_TYPE(WH),
+		     SUBDEV(0x4514)),
 	IWL_DEV_INFO(iwl_rf_wh_160mhz, iwl_be213_name, RF_TYPE(WH), BW_LIMITED),
 
 /* PE RF */
-- 
2.34.1


