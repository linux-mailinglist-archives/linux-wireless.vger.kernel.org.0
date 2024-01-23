Return-Path: <linux-wireless+bounces-2400-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C25083974B
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jan 2024 19:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E74271F2CA43
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jan 2024 18:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5214681ABD;
	Tue, 23 Jan 2024 18:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S7QqENLD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BC581AB8
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jan 2024 18:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706033337; cv=none; b=IDfhACOrmjfzVUwznnpIgkgFFveJiPCxyAWHe3VG1LqTk6P4s9gHyBlbPfm34aNzKkqGOpk8qfHhgUN3lP1OoOVp5TuRZL42BtVTx24JSDr/H4Gl51fFDsD9nmpVVifOd5v/hXTjXcMqTpPD29Yp0IorWhzM9K3jcwBEPX9xXFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706033337; c=relaxed/simple;
	bh=LUVTQs9/8EXCULp/TlviHLk/l9Xm5Lt8hb0Uxs63LME=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ckre7MNp+Ckb1q96gD8vbVtlCfxvC6emfq7vUkROrjaNREiV2g1GHrBl9CuYbxr3xS4i2hYLIEQzl8o/upzSXXAqmJ1hvWB71tvHjYYNIaulBcZVgZ+edLHFTi0zCxL9iCliRNwrwYYHTkIpnWRX29qbHuqn76uU0ZhKdx0Za/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S7QqENLD; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706033336; x=1737569336;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LUVTQs9/8EXCULp/TlviHLk/l9Xm5Lt8hb0Uxs63LME=;
  b=S7QqENLD+cBA2bc9k0NKYqUlUgtm8lzjP9JzE4M796lEEGLwN3Fv1EIN
   gHjRm9eUDPasu4Q5ZKOpQ0jZg7uKh1ucXEHMC4uUI2pUslFAleCAMQk9A
   Kao2M4LmwbTNRg6/aZG0KfrCaoOILWDBmOmmqyb9EypXk9GxFoWJpPnT+
   w33KJZDyUooauLNnCZqJob2e7sQ9guSMc+kS0w7KtUJ79Sm1FRZl+mf+F
   Mc+kHiCMg6egk5ltvIHNKp8iBsCcE/TTriaF5FUNjqAshanwr0wbhIShP
   imKgLPZYFPMHcFZuaDI4WnjTzWi4oA+wFnCVyyH+RGxm/GttOG6U1rdbd
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="501761"
X-IronPort-AV: E=Sophos;i="6.05,215,1701158400"; 
   d="scan'208";a="501761"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 10:08:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,215,1701158400"; 
   d="scan'208";a="1666502"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 10:08:53 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Mukesh Sisodiya <mukesh.sisodiya@intel.com>,
	Mordechay Goodstein <mordechay.goodstein@intel.com>
Subject: [PATCH 05/15] wifi: iwlwifi: disable 160Mhz based on SSID
Date: Tue, 23 Jan 2024 20:08:13 +0200
Message-Id: <20240123200528.776b395ee915.I558e8d0cf19dc862b1c4124df78a4cb690095bb2@changeid>
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

The driver should not send 160Mhz BW support for 5Ghz
band in HE if PCI Subsystem read indicates no 160Mhz support.

Signed-off-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
Reviewed-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
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
index 9e26c9eb6d83..9867e29a56ff 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -1069,6 +1069,7 @@ struct iwl_trans_txqs {
  *	only valid for discrete (not integrated) NICs
  * @invalid_tx_cmd: invalid TX command buffer
  * @reduced_cap_sku: reduced capability supported SKU
+ * @no_160: device not supporting 160Mhz
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


