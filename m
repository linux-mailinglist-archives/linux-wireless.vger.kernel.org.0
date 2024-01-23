Return-Path: <linux-wireless+bounces-2397-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 900D7839748
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jan 2024 19:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4F441C216F3
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jan 2024 18:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6E081212;
	Tue, 23 Jan 2024 18:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hPn2ZxEL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8051D81211
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jan 2024 18:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706033326; cv=none; b=XPjYHjitwfaNPqqtfN3fPFsb4S7FV+59myECXHufbAthx3KhMbTtxwRrKdVVWV2iDXZHxI/UXj4YbGRuxuTZLDIRi5fbU33Wuu7V+iZywXg7ZgG4f4MaLPB7JI7cMdwiiqW0nPHrQHAKNX8oZkG01KgtaEyXfKGhCho309N+v4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706033326; c=relaxed/simple;
	bh=Q+TQQwJriJ5dPWyOjvEbjg95NYIih3vARPOV1AdRsc0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eNPGqlK0smdh9RpPSfyrLrXMUApKc4ntlHcwetP2YOXruQu3Pfm84fne6nqstEYmsekQzKrKAwIkO2uKKNKoGTmdFMGrRCZ00kr2a2ziSD9HxKFfHglLAX/aCF/xflV31o/fQalxUJtlWdE5Ej2LORjUlJYgG4tdeQJ+rpZxO+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hPn2ZxEL; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706033325; x=1737569325;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Q+TQQwJriJ5dPWyOjvEbjg95NYIih3vARPOV1AdRsc0=;
  b=hPn2ZxELP/AzgyaF/fE2fkbE9QRsjKlUVS9R75/VK/fLDrw6UCiV3UxP
   JHCDxbUGn4D6/++LYyp5UxlQIGfXnNC04Pp2Ww2AhcoDaSSMx4LU0Xrc+
   5E3iFvUaqLhStKn8oAIgraVfZBMaFjklaBW26mb8fyE13dtBPKSpmhVY+
   yc5HuIUaDXnexlzMtcJS188TOLngQtLub+1diakxtGQ5v93/ZgPTlQOO5
   UMCkssRRsgeQG7D3RFMDcUwGa/G5cL764g65xlBgux8Np2PQ5kk6Hzs8z
   9bPl8I5LViVHGRqqcKN/LU9w7EJTLRadmTxAElqm83/KHZ6ljGsUYMS7t
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="501684"
X-IronPort-AV: E=Sophos;i="6.05,215,1701158400"; 
   d="scan'208";a="501684"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 10:08:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,215,1701158400"; 
   d="scan'208";a="1666451"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 10:08:42 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Mukesh Sisodiya <mukesh.sisodiya@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 02/15] wifi: iwlwifi: Add support for new 802.11be device
Date: Tue, 23 Jan 2024 20:08:10 +0200
Message-Id: <20240123200528.8529bd2acedf.I25dccb7bbeb21b8df2123fad51dde7fcf137a508@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240123180823.2441162-1-miriam.rachel.korenblit@intel.com>
References: <20240123180823.2441162-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Mukesh Sisodiya <mukesh.sisodiya@intel.com>

Add support for the new 802.11be device with limites capabilities:
- 320 MHz isn't supported
- MCSs 12 and 13 are not supported

Signed-off-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c      |  1 +
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.c     | 13 +++++++++++++
 drivers/net/wireless/intel/iwlwifi/iwl-config.h  |  4 ++++
 .../net/wireless/intel/iwlwifi/iwl-nvm-parse.c   | 16 ++++++++++++++--
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h   |  2 ++
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c    |  7 ++++++-
 6 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
index 82da957adcf6..21fdaf8e0e0e 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
@@ -153,6 +153,7 @@ const struct iwl_cfg_trans_params iwl_bz_trans_cfg = {
 };
 
 const char iwl_bz_name[] = "Intel(R) TBD Bz device";
+const char iwl_mtp_name[] = "Intel(R) Wi-Fi 7 BE202 160MHz";
 
 const struct iwl_cfg iwl_cfg_bz = {
 	.fw_name_mac = "bz",
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
index 650e4bde9c17..d467ec0e3552 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
@@ -12,6 +12,8 @@
 #include "fw/api/alive.h"
 #include "fw/uefi.h"
 
+#define IWL_PNVM_REDUCED_CAP_BIT BIT(25)
+
 struct iwl_pnvm_section {
 	__le32 offset;
 	const u8 data[];
@@ -173,6 +175,7 @@ static int iwl_pnvm_parse(struct iwl_trans *trans, const u8 *data,
 
 	while (len >= sizeof(*tlv)) {
 		u32 tlv_len, tlv_type;
+		u32 rf_type;
 
 		len -= sizeof(*tlv);
 		tlv = (const void *)data;
@@ -201,6 +204,16 @@ static int iwl_pnvm_parse(struct iwl_trans *trans, const u8 *data,
 			data += sizeof(*tlv) + ALIGN(tlv_len, 4);
 			len -= ALIGN(tlv_len, 4);
 
+			trans->reduced_cap_sku = false;
+			rf_type = CSR_HW_RFID_TYPE(trans->hw_rf_id);
+			if ((trans->sku_id[0] & IWL_PNVM_REDUCED_CAP_BIT) &&
+			    rf_type == IWL_CFG_RF_TYPE_FM)
+				trans->reduced_cap_sku = true;
+
+			IWL_DEBUG_FW(trans,
+				     "Reduced SKU device %d\n",
+				     trans->reduced_cap_sku);
+
 			if (trans->sku_id[0] == le32_to_cpu(sku_id->data[0]) &&
 			    trans->sku_id[1] == le32_to_cpu(sku_id->data[1]) &&
 			    trans->sku_id[2] == le32_to_cpu(sku_id->data[2])) {
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index b3c6847cccf1..97e73443316a 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -443,6 +443,9 @@ struct iwl_cfg {
 #define IWL_CFG_NO_160			0x1
 #define IWL_CFG_160			0x0
 
+#define IWL_CFG_NO_320			0x1
+#define IWL_CFG_320			0x0
+
 #define IWL_CFG_CORES_BT		0x0
 #define IWL_CFG_CORES_BT_GNSS		0x5
 
@@ -536,6 +539,7 @@ extern const char iwl_ax221_name[];
 extern const char iwl_ax231_name[];
 extern const char iwl_ax411_name[];
 extern const char iwl_bz_name[];
+extern const char iwl_mtp_name[];
 extern const char iwl_sc_name[];
 #if IS_ENABLED(CONFIG_IWLDVM)
 extern const struct iwl_cfg iwl5300_agn_cfg;
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index 402896988686..3f62f10a7c37 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -892,8 +892,9 @@ iwl_nvm_fixup_sband_iftd(struct iwl_trans *trans,
 	bool is_ap = iftype_data->types_mask & BIT(NL80211_IFTYPE_AP);
 	bool no_320;
 
-	no_320 = !trans->trans_cfg->integrated &&
-		 trans->pcie_link_speed < PCI_EXP_LNKSTA_CLS_8_0GB;
+	no_320 = (!trans->trans_cfg->integrated &&
+		 trans->pcie_link_speed < PCI_EXP_LNKSTA_CLS_8_0GB) ||
+		 trans->reduced_cap_sku;
 
 	if (!data->sku_cap_11be_enable || iwlwifi_mod_params.disable_11be)
 		iftype_data->eht_cap.has_eht = false;
@@ -1059,6 +1060,17 @@ iwl_nvm_fixup_sband_iftd(struct iwl_trans *trans,
 		iftype_data->he_cap.he_cap_elem.phy_cap_info[7] &=
 			~IEEE80211_HE_PHY_CAP7_STBC_RX_ABOVE_80MHZ;
 	}
+
+	if (trans->reduced_cap_sku) {
+		memset(&iftype_data->eht_cap.eht_mcs_nss_supp.bw._320, 0,
+		       sizeof(iftype_data->eht_cap.eht_mcs_nss_supp.bw._320));
+		iftype_data->eht_cap.eht_mcs_nss_supp.bw._80.rx_tx_mcs13_max_nss = 0;
+		iftype_data->eht_cap.eht_mcs_nss_supp.bw._160.rx_tx_mcs13_max_nss = 0;
+		iftype_data->eht_cap.eht_cap_elem.phy_cap_info[8] &=
+			~IEEE80211_EHT_PHY_CAP8_RX_4096QAM_WIDER_BW_DL_OFDMA;
+		iftype_data->eht_cap.eht_cap_elem.phy_cap_info[2] &=
+			~IEEE80211_EHT_PHY_CAP2_SOUNDING_DIM_320MHZ_MASK;
+	}
 }
 
 static void iwl_init_he_hw_capab(struct iwl_trans *trans,
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 5789a8735976..9e26c9eb6d83 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -1068,6 +1068,7 @@ struct iwl_trans_txqs {
  * @pcie_link_speed: current PCIe link speed (%PCI_EXP_LNKSTA_CLS_*),
  *	only valid for discrete (not integrated) NICs
  * @invalid_tx_cmd: invalid TX command buffer
+ * @reduced_cap_sku: reduced capability supported SKU
  */
 struct iwl_trans {
 	bool csme_own;
@@ -1090,6 +1091,7 @@ struct iwl_trans {
 	u32 hw_id;
 	char hw_id_str[52];
 	u32 sku_id[3];
+	bool reduced_cap_sku;
 
 	u8 rx_mpdu_cmd, rx_mpdu_cmd_hdr_size;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index cbae9503f4ba..42680d8469f5 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1008,8 +1008,13 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_GL, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB,
+		      IWL_CFG_320, IWL_CFG_ANY, IWL_CFG_NO_CDB,
 		      iwl_cfg_gl, iwl_bz_name),
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_GL, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_NO_320, IWL_CFG_ANY, IWL_CFG_NO_CDB,
+		      iwl_cfg_gl, iwl_mtp_name),
 
 /* SoF with JF2 */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-- 
2.34.1


