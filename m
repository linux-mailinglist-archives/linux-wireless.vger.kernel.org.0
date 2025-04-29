Return-Path: <linux-wireless+bounces-22208-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FD3AA1B9C
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 21:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C29DD1A818D6
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 19:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A408B25FA07;
	Tue, 29 Apr 2025 19:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OStUbpCV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B781326156A
	for <linux-wireless@vger.kernel.org>; Tue, 29 Apr 2025 19:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745956449; cv=none; b=Tgk0vbjIUH8Gmrc+2vbO0+SZE9CQ1HePDegoRPEjYfAlq/57JvGNEu6XJ6H1/UBWoB+0OZIlciDKrPx/wzuHlGYYhT4d/NKnU5laZ0RyJPQRJhasqQjQedFgDgm521e3rb46ihHKhK9tUxdr9wX18jJGWbDMgntUWCqdqco8PPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745956449; c=relaxed/simple;
	bh=lej7MedZCzB3nkPf7kBOaG89H+aaUVlJo4+dt28uWys=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e5CrmaVwrhMIiM1pGCbtPremUXWfibVVT+4a/vU6j0ZuVjEqcICAJS/fcrg58ht24YaS2b4jkjVyMTF/Vd93MsMhkA8r5N5TepBhCbVDgLFJAQc80wenTsSFTPg3jVlsPF8/IcZWazqfKohadj/4qaIQJdPevq10X6RLEBklCtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OStUbpCV; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745956446; x=1777492446;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lej7MedZCzB3nkPf7kBOaG89H+aaUVlJo4+dt28uWys=;
  b=OStUbpCV43UE/QU0sMlt+nhC8InbgijqzuR6JFGSAuyT9rVQubK/U3bA
   Izj8nSI58ZbcXlB5UFcLIk2Y2vKbhfZ2YtMSVWOMg1acu2OTuF4NDteLE
   BjcRur+KUmYKsMHZE93KT8pXdLWIM6CNTK/XqD5/cozsMmteRe1Do9Ftr
   CNhNZKez4Vlpva2qpuqm+S4NKKx+Jr+ebfp0141qgs239FM7SLu2D0rkH
   Qg+XQ+pOAMDuhat/jL1RcXOihqawwfzeKmwi6v4aJz71ggjr9712algtm
   wCTm6ooq2EJTNyrjPaFeZd1qZbYQ0bXuleymMZ9eUHfxUPU+B5HlQ1ozV
   g==;
X-CSE-ConnectionGUID: 8oThEV3ySkq+aYdP4bwClQ==
X-CSE-MsgGUID: ok25z2gyTmGIfXE3QvYnVQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="46713489"
X-IronPort-AV: E=Sophos;i="6.15,250,1739865600"; 
   d="scan'208";a="46713489"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 12:54:05 -0700
X-CSE-ConnectionGUID: egry5bcITViAIJqrgoyQOw==
X-CSE-MsgGUID: t2FzlaLERFG2/hDdcyQl7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,250,1739865600"; 
   d="scan'208";a="171154986"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 12:54:05 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-next 03/14] wifi: iwlwifi: mld: send the WPFC table to the FW
Date: Tue, 29 Apr 2025 22:53:33 +0300
Message-Id: <20250429224932.e349a33cd871.Ied196cf0fbe18b82b87ce713c4e3347f9aca1c25@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250429195344.254957-1-miriam.rachel.korenblit@intel.com>
References: <20250429195344.254957-1-miriam.rachel.korenblit@intel.com>
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


