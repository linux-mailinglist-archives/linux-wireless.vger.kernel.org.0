Return-Path: <linux-wireless+bounces-22246-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE2BAA4B03
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 14:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6E759A051B
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 12:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B6D25A2A6;
	Wed, 30 Apr 2025 12:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YSIQ4T4h"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89F025A2C9
	for <linux-wireless@vger.kernel.org>; Wed, 30 Apr 2025 12:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746015888; cv=none; b=UOePD2BC5KHZTX7DyKDd4IXEfFWgnwR2OBGynR+TS05+omkNoYNlj90243C6zP7M4vEmhPMzQ9vbZsk2K9+DJUg8RuY8A2SFOnnGmkNX5mYJ65KreQDsMezXjl6aC+qgh6fpre518+wjnrgMixiYsElQnXl+Dr4xqYb84N0o6Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746015888; c=relaxed/simple;
	bh=lej7MedZCzB3nkPf7kBOaG89H+aaUVlJo4+dt28uWys=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UJw6A6w3FklpX+mS1Nit1QpDfeXKjc/bypJCQ+lXZ0urCFuR5cgLu6LSxTmoAcuf14nY585VLYrhs1Nw1yU9L6va3hbBXTNCX16kk0KYWB6sHlR24X9PG/fMbSXXy1DxyaOv6sEk5ERal0OuqiejFQqSUbroe2hMqB7B3HPybfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YSIQ4T4h; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746015886; x=1777551886;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lej7MedZCzB3nkPf7kBOaG89H+aaUVlJo4+dt28uWys=;
  b=YSIQ4T4hnlkcSDA7hpxyncGKkNhrBhUVQz2Jmaftq+W8fusq7QbCVsgi
   cEU3pvCTMKMw1vUxZdFgRxZonSTvjxZ0/+dp2Om/vHM7+INzUb2d+5Emv
   elzGsDebymoIWOM6nuKPPaGqu8sYM7FDmCoITSdHaVWXzWIUus2pV5/oK
   +43jOtAqelsJyUT2usj6Y6YUzWMt3u/WKcMVqYZvavmYRJapCxxZ+CHfF
   o7H6rzBv+GLKauuMSGFT5e8hvr3YcMdPAsZRADygxI0yUv2T/JC1+eYRO
   QmMX3r0HoKBO7jGE7KYTIT8QHeAve7V+pV/l3t5u61Olb27KBDKfx+4d1
   A==;
X-CSE-ConnectionGUID: vmULFT4lTgGE4rHxOBZiRQ==
X-CSE-MsgGUID: 0qcDiAxcQyuh7cJoaCO6PA==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="47578261"
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="47578261"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 05:24:46 -0700
X-CSE-ConnectionGUID: hiMdB8xISX+DQhj+AYRVDA==
X-CSE-MsgGUID: yV5tLRYKTy+8/MNxDx7Ncw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="135087848"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 05:24:46 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH v2 iwlwifi-next 03/14] wifi: iwlwifi: mld: send the WPFC table to the FW
Date: Wed, 30 Apr 2025 15:23:09 +0300
Message-Id: <20250430151952.e349a33cd871.Ied196cf0fbe18b82b87ce713c4e3347f9aca1c25@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250430122320.1061510-1-miriam.rachel.korenblit@intel.com>
References: <20250430122320.1061510-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

Read the table on op mode start, and send it to the FW when it is
loaded.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/fw.c   | 12 +++++++-
 drivers/net/wireless/intel/iwlwifi/mld/phy.c  | 29 +++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mld/phy.h  |  2 ++
 .../wireless/intel/iwlwifi/mld/regulatory.c   |  2 ++
 4 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/fw.c b/drivers/net/wireless/intel/iwlwifi/mld/fw.c
index 6e9af37fb86d..238e8ad8ba82 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/fw.c
@@ -8,6 +8,7 @@
 #include "fw/api/alive.h"
 #include "fw/api/scan.h"
 #include "fw/api/rx.h"
+#include "phy.h"
 #include "fw/dbg.h"
 #include "fw/pnvm.h"
 #include "hcmd.h"
@@ -254,7 +255,9 @@ static int iwl_mld_load_fw_wait_alive(struct iwl_mld *mld)
 static int iwl_mld_run_fw_init_sequence(struct iwl_mld *mld)
 {
 	struct iwl_notification_wait init_wait;
-	struct iwl_init_extended_cfg_cmd init_cfg = {};
+	struct iwl_init_extended_cfg_cmd init_cfg = {
+		.init_flags = cpu_to_le32(BIT(IWL_INIT_PHY)),
+	};
 	static const u16 init_complete[] = {
 		INIT_COMPLETE_NOTIF,
 	};
@@ -291,6 +294,13 @@ static int iwl_mld_run_fw_init_sequence(struct iwl_mld *mld)
 		return ret;
 	}
 
+	ret = iwl_mld_send_phy_cfg_cmd(mld);
+	if (ret) {
+		IWL_ERR(mld, "Failed to send PHY config command: %d\n", ret);
+		iwl_remove_notification(&mld->notif_wait, &init_wait);
+		return ret;
+	}
+
 	ret = iwl_wait_notification(&mld->notif_wait, &init_wait,
 				    MLD_INIT_COMPLETE_TIMEOUT);
 	if (ret) {
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/phy.c b/drivers/net/wireless/intel/iwlwifi/mld/phy.c
index 2fbc8090088b..2345fe5c3291 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/phy.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/phy.c
@@ -153,3 +153,32 @@ int iwl_mld_phy_fw_action(struct iwl_mld *mld,
 
 	return ret;
 }
+
+static u32 iwl_mld_get_phy_config(struct iwl_mld *mld)
+{
+	u32 phy_config = ~(FW_PHY_CFG_TX_CHAIN |
+			   FW_PHY_CFG_RX_CHAIN);
+	u32 valid_rx_ant = iwl_mld_get_valid_rx_ant(mld);
+	u32 valid_tx_ant = iwl_mld_get_valid_tx_ant(mld);
+
+	phy_config |= valid_tx_ant << FW_PHY_CFG_TX_CHAIN_POS |
+		      valid_rx_ant << FW_PHY_CFG_RX_CHAIN_POS;
+
+	return mld->fw->phy_config & phy_config;
+}
+
+int iwl_mld_send_phy_cfg_cmd(struct iwl_mld *mld)
+{
+	const struct iwl_tlv_calib_ctrl *default_calib =
+		&mld->fw->default_calib[IWL_UCODE_REGULAR];
+	struct iwl_phy_cfg_cmd_v3 cmd = {
+		.phy_cfg = cpu_to_le32(iwl_mld_get_phy_config(mld)),
+		.calib_control.event_trigger = default_calib->event_trigger,
+		.calib_control.flow_trigger = default_calib->flow_trigger,
+		.phy_specific_cfg = mld->fwrt.phy_filters,
+	};
+
+	IWL_INFO(mld, "Sending Phy CFG command: 0x%x\n", cmd.phy_cfg);
+
+	return iwl_mld_send_cmd_pdu(mld, PHY_CONFIGURATION_CMD, &cmd);
+}
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/phy.h b/drivers/net/wireless/intel/iwlwifi/mld/phy.h
index 2212a89321b7..563e309deb0a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/phy.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/phy.h
@@ -52,4 +52,6 @@ iwl_mld_get_chandef_from_chanctx(struct iwl_mld *mld,
 				 struct ieee80211_chanctx_conf *ctx);
 u8 iwl_mld_get_fw_ctrl_pos(const struct cfg80211_chan_def *chandef);
 
+int iwl_mld_send_phy_cfg_cmd(struct iwl_mld *mld);
+
 #endif /* __iwl_mld_phy_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/regulatory.c b/drivers/net/wireless/intel/iwlwifi/mld/regulatory.c
index a75af8c1e8ab..fa9f8ac14631 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/regulatory.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/regulatory.c
@@ -66,6 +66,8 @@ void iwl_mld_get_bios_tables(struct iwl_mld *mld)
 	ret = iwl_uefi_get_uats_table(mld->trans, &mld->fwrt);
 	if (ret)
 		IWL_DEBUG_RADIO(mld, "failed to read UATS table (%d)\n", ret);
+
+	iwl_bios_get_phy_filters(&mld->fwrt);
 }
 
 static int iwl_mld_geo_sar_init(struct iwl_mld *mld)
-- 
2.34.1


