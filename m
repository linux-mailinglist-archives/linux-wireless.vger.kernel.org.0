Return-Path: <linux-wireless+bounces-2526-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3609083D4F7
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jan 2024 09:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF4D61F299AD
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jan 2024 08:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A4A224F2;
	Fri, 26 Jan 2024 07:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nLeDFbIr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B341224F1
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jan 2024 07:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706252443; cv=none; b=k9bmt6SWBT5y91SbvnhqvaK6b6R1zJJiR6jUH0ztih7Yo44BCGj55+J7V4WZa4QbKMYf/y8olfdt9GbTmb47zluSWz3MXZlLg7kkmeXdqGKhObtVypI8W1aGTbHb2eryVeDhtK6O11+TqbP452S6N6chlpF3gkRVrGrFEWvmTdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706252443; c=relaxed/simple;
	bh=zE4QZ9iDsu0bHA9aUo38Li5hZxVXQlUCbpwJBZfSPMQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Sf7IKT3QwjEg1vkqhWXOWfLrHYG5214M37etkzP241FF2cdUpNSYvcQUGxaVD43XTpDlIyU2Oa0fz6tcUzMm0WhB9dLtQ3g/rFC+RGvw8UfLJ1x3Uy+Sc98LZdnaRjbYHNCzya+o7YSrYzD1tkj/5uUgCMNPJ3vhTSvAU0S9Yt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nLeDFbIr; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706252442; x=1737788442;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zE4QZ9iDsu0bHA9aUo38Li5hZxVXQlUCbpwJBZfSPMQ=;
  b=nLeDFbIrHEfueFHRN6qf0MknbX+hhq7QKcld9FnrxPl4qPv/QPjFeYSV
   ldae8pZ+mPdgR7hFaKTqk3w6JkDLI8z3tYeM0vdUnTmnvxhRjcZyS3IWK
   3FX8UBEFJRvgT8xNjK6bZVHcFoP8/a7m1lxsaRgandn6609grx8sBSXsg
   WFkHjuNQA2TY4glW8bKnnMqQ8zEH0gAnegY7Znm+g2/NEUqPvo5OC8guv
   OeHfwO3WKGGdn+iDd84Czw3jeHtnEt5+fWeplQICPpbqi4ikjd6BSpcgU
   irsVdAEBsTFF+qDBAXjfpAEoTcXs3BNKYT4FIvwFeqUXejbG3Sb8N1ows
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="9158338"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="9158338"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 23:00:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2592549"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 23:00:40 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Mukesh Sisodiya <mukesh.sisodiya@intel.com>,
	Mordechay Goodstein <mordechay.goodstein@intel.com>
Subject: [PATCH v4] wifi: iwlwifi: disable 160 MHz based on subsystem device ID
Date: Fri, 26 Jan 2024 09:00:30 +0200
Message-Id: <20240126085924.77c248ce6986.I558e8d0cf19dc862b1c4124df78a4cb690095bb2@changeid>
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
band in HE if PCI subsystem device ID  indicates no 160 MHz support.

Signed-off-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
Reviewed-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
v2: Fix Mhz/Ghz to MHz/GHz
v3: fixed the code itself too, added a space (160MHz -> 160 MHz)
v4: changed SSID to subsystem device ID
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


