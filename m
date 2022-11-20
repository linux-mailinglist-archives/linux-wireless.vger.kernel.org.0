Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4B8A631553
	for <lists+linux-wireless@lfdr.de>; Sun, 20 Nov 2022 18:01:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbiKTRBe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 20 Nov 2022 12:01:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiKTRBd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 20 Nov 2022 12:01:33 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B054B2B25D
        for <linux-wireless@vger.kernel.org>; Sun, 20 Nov 2022 09:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668963692; x=1700499692;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OCFupwgPglOWgLbP2MgmeN6f4VL7Cdo9zEErrV57Sx4=;
  b=aOiQeOyRGLEM3tBOlIJ4C7BBDpBIe0MkSQoVsTtX86V393sn0P4jQ0+x
   BqnKiamb0fDTFgapsjleczvCtvyh7Om9oLpfBYLr8Okc/jliW59UcuoXQ
   z5E7BKgvikKPmDse+wN4YZQeKbW5rTLKCXi3XplImalSB2SEzDkXw0zdE
   EAlMFRJglYJw4qWFXX16WvbQcCQBnMDJUmrlvX1Eau5nCxkiODY1QlsND
   sbwZC5HD0cKvYAxLY6b8xs3obQcfJzlbRnFuRnOjHgd01v6TpSThrisgC
   +tMMuZ488tqJhCSBc7Rph8mflgzr+3Q/Q948b68ImGIt4tyQStapsUoO7
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10537"; a="315234862"
X-IronPort-AV: E=Sophos;i="5.96,179,1665471600"; 
   d="scan'208";a="315234862"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2022 09:01:32 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10537"; a="765719454"
X-IronPort-AV: E=Sophos;i="5.96,179,1665471600"; 
   d="scan'208";a="765719454"
Received: from dwiener-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.87.2])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2022 09:01:30 -0800
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Mordechay Goodstein <mordechay.goodstein@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 3/9] wifi: iwlwifi: rs: add support for parsing max MCS per NSS/BW in 11be
Date:   Sun, 20 Nov 2022 19:00:33 +0200
Message-Id: <20221120185147.3554a5dcbdb1.I7b5e8071df91146c4bee3e9bcb7ad62595b275e1@changeid>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221120170039.1788067-1-gregory.greenman@intel.com>
References: <20221120170039.1788067-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

Rate scale needs to be configured to what MCS it can use per BW and NSS,
this is done by parsing our capabilities of TX and peer's capabilities of
RX and setting the minimum for rate scale usage.

Also do some cleanup removing redundant enum defines not used by
FW/Driver.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/rs.h    |  10 +-
 drivers/net/wireless/intel/iwlwifi/fw/rs.c    |   2 +
 .../net/wireless/intel/iwlwifi/mvm/rs-fw.c    | 125 +++++++++++++++++-
 3 files changed, 129 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h b/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h
index 687f804c46b7..ddacd5b45aea 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h
@@ -36,14 +36,14 @@ enum iwl_tlc_mng_cfg_flags {
  * @IWL_TLC_MNG_CH_WIDTH_40MHZ: 40MHZ channel
  * @IWL_TLC_MNG_CH_WIDTH_80MHZ: 80MHZ channel
  * @IWL_TLC_MNG_CH_WIDTH_160MHZ: 160MHZ channel
- * @IWL_TLC_MNG_CH_WIDTH_LAST: maximum value
+ * @IWL_TLC_MNG_CH_WIDTH_320MHZ: 320MHZ channel
  */
 enum iwl_tlc_mng_cfg_cw {
 	IWL_TLC_MNG_CH_WIDTH_20MHZ,
 	IWL_TLC_MNG_CH_WIDTH_40MHZ,
 	IWL_TLC_MNG_CH_WIDTH_80MHZ,
 	IWL_TLC_MNG_CH_WIDTH_160MHZ,
-	IWL_TLC_MNG_CH_WIDTH_LAST = IWL_TLC_MNG_CH_WIDTH_160MHZ,
+	IWL_TLC_MNG_CH_WIDTH_320MHZ,
 };
 
 /**
@@ -64,8 +64,7 @@ enum iwl_tlc_mng_cfg_chains {
  * @IWL_TLC_MNG_MODE_HT: enable HT
  * @IWL_TLC_MNG_MODE_VHT: enable VHT
  * @IWL_TLC_MNG_MODE_HE: enable HE
- * @IWL_TLC_MNG_MODE_INVALID: invalid value
- * @IWL_TLC_MNG_MODE_NUM: a count of possible modes
+ * @IWL_TLC_MNG_MODE_EHT: enable EHT
  */
 enum iwl_tlc_mng_cfg_mode {
 	IWL_TLC_MNG_MODE_CCK = 0,
@@ -74,8 +73,7 @@ enum iwl_tlc_mng_cfg_mode {
 	IWL_TLC_MNG_MODE_HT,
 	IWL_TLC_MNG_MODE_VHT,
 	IWL_TLC_MNG_MODE_HE,
-	IWL_TLC_MNG_MODE_INVALID,
-	IWL_TLC_MNG_MODE_NUM = IWL_TLC_MNG_MODE_INVALID,
+	IWL_TLC_MNG_MODE_EHT,
 };
 
 /**
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/rs.c b/drivers/net/wireless/intel/iwlwifi/fw/rs.c
index a835214611ce..e128d2e07f38 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/rs.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/rs.c
@@ -218,6 +218,8 @@ int rs_pretty_print_rate(char *buf, int bufsz, const u32 rate)
 		type = "HT";
 	else if (format == RATE_MCS_HE_MSK)
 		type = "HE";
+	else if (format == RATE_MCS_EHT_MSK)
+		type = "EHT";
 	else
 		type = "Unknown"; /* shouldn't happen */
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
index 2e9081cb6627..f30eeab5505b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
@@ -9,9 +9,11 @@
 #include "iwl-op-mode.h"
 #include "mvm.h"
 
-static u8 rs_fw_bw_from_sta_bw(struct ieee80211_sta *sta)
+static u8 rs_fw_bw_from_sta_bw(const struct ieee80211_sta *sta)
 {
 	switch (sta->deflink.bandwidth) {
+	case IEEE80211_STA_RX_BW_320:
+		return IWL_TLC_MNG_CH_WIDTH_320MHZ;
 	case IEEE80211_STA_RX_BW_160:
 		return IWL_TLC_MNG_CH_WIDTH_160MHZ;
 	case IEEE80211_STA_RX_BW_80:
@@ -238,6 +240,122 @@ rs_fw_he_set_enabled_rates(const struct ieee80211_sta *sta,
 	}
 }
 
+static u8 rs_fw_eht_max_nss(u8 rx_nss, u8 tx_nss)
+{
+	u8 tx = u8_get_bits(tx_nss, IEEE80211_EHT_MCS_NSS_TX);
+	u8 rx = u8_get_bits(rx_nss, IEEE80211_EHT_MCS_NSS_RX);
+	/* the max nss that can be used,
+	 * is the min with our tx capa and the peer rx capa.
+	 */
+	return min(tx, rx);
+}
+
+#define MAX_NSS_MCS(mcs_num, rx, tx) \
+	rs_fw_eht_max_nss((rx)->rx_tx_mcs ##mcs_num## _max_nss, \
+			  (tx)->rx_tx_mcs ##mcs_num## _max_nss)
+
+static void rs_fw_set_eht_mcs_nss(__le16 ht_rates[][3],
+				  enum IWL_TLC_MCS_PER_BW bw,
+				  u8 max_nss, u16 mcs_msk)
+{
+	if (max_nss >= 2)
+		ht_rates[IWL_TLC_NSS_2][bw] |= cpu_to_le16(mcs_msk);
+
+	if (max_nss >= 1)
+		ht_rates[IWL_TLC_NSS_1][bw] |= cpu_to_le16(mcs_msk);
+}
+
+static const
+struct ieee80211_eht_mcs_nss_supp_bw *
+rs_fw_rs_mcs2eht_mcs(enum IWL_TLC_MCS_PER_BW bw,
+		     const struct ieee80211_eht_mcs_nss_supp *eht_mcs)
+{
+	switch (bw) {
+	case IWL_TLC_MCS_PER_BW_80:
+		return &eht_mcs->bw._80;
+	case IWL_TLC_MCS_PER_BW_160:
+		return &eht_mcs->bw._160;
+	case IWL_TLC_MCS_PER_BW_320:
+		return &eht_mcs->bw._320;
+	default:
+		return NULL;
+	}
+}
+
+static void rs_fw_eht_set_enabled_rates(const struct ieee80211_sta *sta,
+					struct ieee80211_supported_band *sband,
+					struct iwl_tlc_config_cmd_v4 *cmd)
+{
+	/* peer RX mcs capa */
+	const struct ieee80211_eht_mcs_nss_supp *eht_rx_mcs =
+		&sta->deflink.eht_cap.eht_mcs_nss_supp;
+	/* our TX mcs capa */
+	const struct ieee80211_eht_mcs_nss_supp *eht_tx_mcs =
+		&sband->iftype_data->eht_cap.eht_mcs_nss_supp;
+
+	enum IWL_TLC_MCS_PER_BW bw;
+	struct ieee80211_eht_mcs_nss_supp_20mhz_only mcs_rx_20;
+	struct ieee80211_eht_mcs_nss_supp_20mhz_only mcs_tx_20;
+
+	/* peer is 20Mhz only */
+	if (!(sta->deflink.he_cap.he_cap_elem.phy_cap_info[0] &
+	      IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_MASK_ALL)) {
+		mcs_rx_20 = eht_rx_mcs->only_20mhz;
+	} else {
+		mcs_rx_20.rx_tx_mcs7_max_nss = eht_rx_mcs->bw._80.rx_tx_mcs9_max_nss;
+		mcs_rx_20.rx_tx_mcs9_max_nss = eht_rx_mcs->bw._80.rx_tx_mcs9_max_nss;
+		mcs_rx_20.rx_tx_mcs11_max_nss = eht_rx_mcs->bw._80.rx_tx_mcs11_max_nss;
+		mcs_rx_20.rx_tx_mcs13_max_nss = eht_rx_mcs->bw._80.rx_tx_mcs13_max_nss;
+	}
+
+	/* nic is 20Mhz only */
+	if (!(sband->iftype_data->he_cap.he_cap_elem.phy_cap_info[0] &
+	      IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_MASK_ALL)) {
+		mcs_tx_20 = eht_tx_mcs->only_20mhz;
+	} else {
+		mcs_tx_20.rx_tx_mcs7_max_nss = eht_tx_mcs->bw._80.rx_tx_mcs9_max_nss;
+		mcs_tx_20.rx_tx_mcs9_max_nss = eht_tx_mcs->bw._80.rx_tx_mcs9_max_nss;
+		mcs_tx_20.rx_tx_mcs11_max_nss = eht_tx_mcs->bw._80.rx_tx_mcs11_max_nss;
+		mcs_tx_20.rx_tx_mcs13_max_nss = eht_tx_mcs->bw._80.rx_tx_mcs13_max_nss;
+	}
+
+	/* rates for 20/40/80 bw */
+	bw = IWL_TLC_MCS_PER_BW_80;
+	rs_fw_set_eht_mcs_nss(cmd->ht_rates, bw,
+			      MAX_NSS_MCS(7, &mcs_rx_20, &mcs_tx_20), GENMASK(7, 0));
+	rs_fw_set_eht_mcs_nss(cmd->ht_rates, bw,
+			      MAX_NSS_MCS(9, &mcs_rx_20, &mcs_tx_20), GENMASK(9, 8));
+	rs_fw_set_eht_mcs_nss(cmd->ht_rates, bw,
+			      MAX_NSS_MCS(11, &mcs_rx_20, &mcs_tx_20), GENMASK(11, 10));
+	rs_fw_set_eht_mcs_nss(cmd->ht_rates, bw,
+			      MAX_NSS_MCS(13, &mcs_rx_20, &mcs_tx_20), GENMASK(13, 12));
+
+	/* rate for 160/320 bw */
+	for (bw = IWL_TLC_MCS_PER_BW_160; bw <= IWL_TLC_MCS_PER_BW_320; bw++) {
+		const struct ieee80211_eht_mcs_nss_supp_bw *mcs_rx =
+			rs_fw_rs_mcs2eht_mcs(bw, eht_rx_mcs);
+		const struct ieee80211_eht_mcs_nss_supp_bw *mcs_tx =
+			rs_fw_rs_mcs2eht_mcs(bw, eht_tx_mcs);
+
+		/* got unsuppored index for bw */
+		if (!mcs_rx || !mcs_tx)
+			continue;
+
+		rs_fw_set_eht_mcs_nss(cmd->ht_rates, bw,
+				      MAX_NSS_MCS(9, mcs_rx, mcs_tx), GENMASK(9, 0));
+		rs_fw_set_eht_mcs_nss(cmd->ht_rates, bw,
+				      MAX_NSS_MCS(11, mcs_rx, mcs_tx), GENMASK(11, 10));
+		rs_fw_set_eht_mcs_nss(cmd->ht_rates, bw,
+				      MAX_NSS_MCS(13, mcs_rx, mcs_tx), GENMASK(13, 12));
+	}
+
+	/* the station support only a single receive chain */
+	if (sta->deflink.smps_mode == IEEE80211_SMPS_STATIC ||
+	    sta->deflink.rx_nss < 2)
+		memset(cmd->ht_rates[IWL_TLC_NSS_2], 0,
+		       sizeof(cmd->ht_rates[IWL_TLC_NSS_2]));
+}
+
 static void rs_fw_set_supp_rates(struct ieee80211_sta *sta,
 				 struct ieee80211_supported_band *sband,
 				 struct iwl_tlc_config_cmd_v4 *cmd)
@@ -258,7 +376,10 @@ static void rs_fw_set_supp_rates(struct ieee80211_sta *sta,
 	cmd->mode = IWL_TLC_MNG_MODE_NON_HT;
 
 	/* HT/VHT rates */
-	if (he_cap->has_he) {
+	if (sta->deflink.eht_cap.has_eht) {
+		cmd->mode = IWL_TLC_MNG_MODE_EHT;
+		rs_fw_eht_set_enabled_rates(sta, sband, cmd);
+	} else if (he_cap->has_he) {
 		cmd->mode = IWL_TLC_MNG_MODE_HE;
 		rs_fw_he_set_enabled_rates(sta, sband, cmd);
 	} else if (vht_cap->vht_supported) {
-- 
2.35.3

