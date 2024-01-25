Return-Path: <linux-wireless+bounces-2491-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC88F83C4B7
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jan 2024 15:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 171F3B242D8
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jan 2024 14:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4636BB2B;
	Thu, 25 Jan 2024 14:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Si7ZUbp8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1878E6BB39
	for <linux-wireless@vger.kernel.org>; Thu, 25 Jan 2024 14:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706193089; cv=none; b=DSdqfLUIQ+4rACM/kOY4ZWWVtwiFfMRb38gEQFLQlX+yp6hSvfDU31koNcp8tmeyWbKLDSAytt71X0ZHTXgyVUJBM39ev4AIWx19fjXogNmoDv1Xvo8FZ9Jy/mZB6P6TJFVgrZcmh0y6dqODnnxVTW/GMyVuflZkohv6mzdjpww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706193089; c=relaxed/simple;
	bh=DsW1WAgg6T72z/h+04X+OEVo1Chq1pFPfNqgQb9G96I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KI6J9xzFJZC0pWlv5EhojjFgn+iKYNho/sJeWgY+w7xaSHQ0B63YVD+oE2l3O731X1UgvT0Ofca6WBjTNQj51fsPewFdxH9ahbniuGmOZeRozva1AFbLLEXTCoq9e8wFKHlfrjamQsWWwCWILPpieNq1//pIsNXTiQb9d7IFd9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Si7ZUbp8; arc=none smtp.client-ip=134.134.136.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706193087; x=1737729087;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DsW1WAgg6T72z/h+04X+OEVo1Chq1pFPfNqgQb9G96I=;
  b=Si7ZUbp8w64xgyXEVa7+I11JhDRU5pH3nN99t09zN90OKNJhU2hVaZAp
   el/iapNb252ZtIJGGZ2BejmKKHjIlPp6fcB9/hgMjDlKEv3xaZ4odWWvC
   a3K+EYMDt2oBsXWbr9CrpIwogvHQJBVqBDezLOUVDVxxSbyjKGLt2W4l9
   x+EzVbTwMv+tQ950uBPdxFirBcRswezBkH3hRiXht3kBx3ncQORbaLRcR
   RelUR6pqWJrgLtPXEgDHUYOu2gC+XJvQF4uiEEn+QzdgG2JTnsRXyRSXe
   OJwVoDv/eTtNirOShrx6FLbSfxbf1m5U2DrY9KxetaTpS7WmH5UfNzdvz
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="392596716"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="392596716"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 06:31:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="930028986"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="930028986"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 06:31:23 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Mukesh Sisodiya <mukesh.sisodiya@intel.com>,
	Mordechay Goodstein <mordechay.goodstein@intel.com>
Subject: [PATCH v3] wifi: iwlwifi: disable 160 MHz based on SSID
Date: Thu, 25 Jan 2024 16:31:15 +0200
Message-Id: <20240125163103.578d2d3a617f.I558e8d0cf19dc862b1c4124df78a4cb690095bb2@changeid>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Mukesh Sisodiya <mukesh.sisodiya@intel.com>

The driver should not send 160 MHz BW support for 5 GHz
band in HE if PCI Subsystem read indicates no 160 MHz support.

Signed-off-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
Reviewed-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
v2: Fix Mhz/Ghz to MHz/GHz
v3: fixed the code itself too, added a space (160MHz -> 160 MHz)
---
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c | 4 ++++
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h     | 3 ++-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c      | 1 +
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index 3f62f10a7c37..67c7cda073e8 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -1061,6 +1061,10 @@ iwl_nvm_fixup_sband_iftd(struct iwl_trans *trans,
 			~IEEE80211_HE_PHY_CAP7_STBC_RX_ABOVE_80MHZ;
 	}
 
+	if (trans->no_160)
+		iftype_data->he_cap.he_cap_elem.phy_cap_info[0] &=
+			~IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G;
+
 	if (trans->reduced_cap_sku) {
 		memset(&iftype_data->eht_cap.eht_mcs_nss_supp.bw._320, 0,
 		       sizeof(iftype_data->eht_cap.eht_mcs_nss_supp.bw._320));
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 9e26c9eb6d83..e3b76c682d76 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -1069,6 +1069,7 @@ struct iwl_trans_txqs {
  *	only valid for discrete (not integrated) NICs
  * @invalid_tx_cmd: invalid TX command buffer
  * @reduced_cap_sku: reduced capability supported SKU
+ * @no_160: device not supporting 160 MHz
  */
 struct iwl_trans {
 	bool csme_own;
@@ -1092,7 +1093,7 @@ struct iwl_trans {
 	char hw_id_str[52];
 	u32 sku_id[3];
 	bool reduced_cap_sku;
-
+	u8 no_160;
 	u8 rx_mpdu_cmd, rx_mpdu_cmd_hdr_size;
 
 	bool pm_support;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 42680d8469f5..c80b02503b41 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1394,6 +1394,7 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (dev_info) {
 		iwl_trans->cfg = dev_info->cfg;
 		iwl_trans->name = dev_info->name;
+		iwl_trans->no_160 = dev_info->no_160 == IWL_CFG_NO_160;
 	}
 
 #if IS_ENABLED(CONFIG_IWLMVM)
-- 
2.34.1


