Return-Path: <linux-wireless+bounces-2465-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E34683BAC2
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jan 2024 08:37:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D327C2867F7
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jan 2024 07:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F15D12B61;
	Thu, 25 Jan 2024 07:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LUr/+C1h"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEF3125D7
	for <linux-wireless@vger.kernel.org>; Thu, 25 Jan 2024 07:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706168228; cv=none; b=ddJYJLT7XIQ+2D+52KfZs+WKLOuFxMRizRfdRxOmR4QVKygAkhsmT6ouOZZdWxPTrycD0tZe7eL4VO5b02YlzEwx7RORqur1ANVtvpqC6svyRYjmmpy1faob4ogZQxwGfjPxRtPyFMaZVVf2hvFtY6a0HduimV2WcoASdNXO8Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706168228; c=relaxed/simple;
	bh=Ut/Ug30nwpAYfPNJCM66zTqJ6wn5X16ysIUQWBavLyk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=icwZ6LyjhOuPindteQDRRb5dam0woaCyFIZCMf8Appq/NaOE24Dxd76hhXZJwHz9rmeN7ZTcO+3+VPrDjOo2y3A/X57FIO7FxvBFYSzXAp1fgsM6uPUogvv5MmhkkqgSJ6wNjPwCX/caavdrqT8pasCVl+jbqCaGzKAjCO8ZFrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LUr/+C1h; arc=none smtp.client-ip=192.55.52.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706168226; x=1737704226;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ut/Ug30nwpAYfPNJCM66zTqJ6wn5X16ysIUQWBavLyk=;
  b=LUr/+C1hfjHs3BodAt/6d10XrN/QqrskOG3Nb4HSfXv4QtvdzSuniJhB
   dgdF+D8yv0O46d6eQRhLesoWXu6M858ulXEQpzIIXo+JVJMnlojk6LBAM
   QYww2ijR7EKWx+1gpfyeEH2sHertrkLhLbW/VdEHx0zRIEXfgcrOaTXfF
   5p/KvW2udr9KPkzXSqsabhuhRPH8Vd87PHNIQXbWD9Vf6uO8S+3tdn3Gw
   PXHWQ5HkvOL4oQvZGXftJZ6mIVQGmeFJYl5L9gBEqk6Z/feMN1nDt2hZk
   UThnzfoNzPo5VHpAH34VzhCBlWeaVspM0meiAyjqwD8qCf914xrRUX7wl
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="400942089"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="400942089"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 23:37:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2272457"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 23:37:04 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Mukesh Sisodiya <mukesh.sisodiya@intel.com>,
	Mordechay Goodstein <mordechay.goodstein@intel.com>
Subject: [PATCH v2] wifi: iwlwifi: disable 160MHz based on SSID
Date: Thu, 25 Jan 2024 09:36:55 +0200
Message-Id: <20240125093525.1119e6679430.I558e8d0cf19dc862b1c4124df78a4cb690095bb2@changeid>
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

The driver should not send 160MHz BW support for 5GHz
band in HE if PCI Subsystem read indicates no 160MHz support.

Signed-off-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
Reviewed-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
v2: Fix Mhz/Ghz to MHz/GHz

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


