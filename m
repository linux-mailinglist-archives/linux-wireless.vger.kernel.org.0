Return-Path: <linux-wireless+bounces-18532-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1BB3A28B02
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 13:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3037E1617F6
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 12:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D3217C79;
	Wed,  5 Feb 2025 12:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eEe0pst0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819BF136358
	for <linux-wireless@vger.kernel.org>; Wed,  5 Feb 2025 12:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738760191; cv=none; b=J4LxEGPgChHYZYM9foelRocU1pionorpdrqEWszuGktl7KtH3KEUxJoLGMUM4gLimz2VK5QVsJ7EvX507iBd8DXAh+fFTNzZH4N9my4FR2IPaRXgNHSFO4psE0G6C85WxH1SupM2Vt6pBFMCo+0pqTUCqqS+ZVPHcOIiW8bYqqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738760191; c=relaxed/simple;
	bh=E4lddmeW3tSNfD90BFI5aTi/JMVQphPdijBufpcjSJs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DwsCe/fRfqxU2iQw5AMhMaIz6vSVWd5PNmw1NKEhOkN5znVcHNTTIbC/AeZkBo4F3gxccahbF2toJWfqrb2HzBWkU0W+WkFjwz/cFwRhelHibJ5IDjJyw3BXq70ollDO5dG6UZxS3vcwci1FDV33hgG74U3hDmYDEBEhBZyj71Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eEe0pst0; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738760190; x=1770296190;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=E4lddmeW3tSNfD90BFI5aTi/JMVQphPdijBufpcjSJs=;
  b=eEe0pst08I/SWb2HkGjCaCeotgrdhWmVkBeN9lEYHoUshxLu7Qq//mZt
   mgGJfXgjqY2WI/XN25VdvaEonvgn+YukHwRpeIlz1bbBpf7vmJ0KBpVTj
   g60X04OMcM25L6N9kMVBjqjqRJzIMTaujLfbdGLHxyZnuGzJuC+uGtKCp
   xjk31Whycpboe2tO/6gtCtmw8A/zvyBXjKkTzHDsJGcM6ocJSwSDSjCc1
   UwYP2nxfsRG1581JupIP00dblxeRflXJ05bXJ9ltTY7SgG0+5APrV4Lc1
   z4gWUzTM3NmLscc8TyS7PpMJiYdMsncCLQX9oJ170qSRdwetA1+iR2ZvE
   w==;
X-CSE-ConnectionGUID: bUos+tMUQ4etQM5rw+Usjg==
X-CSE-MsgGUID: qQ6NtBpVQ5WG0NLDfQPXdQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="42159214"
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="42159214"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 04:56:29 -0800
X-CSE-ConnectionGUID: m3bYd+5gTg2YDo0PRrPAOw==
X-CSE-MsgGUID: OHHKS3lIQH2dgcjzli4s2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="110745491"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 04:56:28 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 14/19] wifi: iwlwifi: properly set the names for SC devices
Date: Wed,  5 Feb 2025 14:55:43 +0200
Message-Id: <20250205145347.5bf5d931204e.I5eb435db1b8df46687c43ebae6488c0c4430d530@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250205125548.1963070-1-miriam.rachel.korenblit@intel.com>
References: <20250205125548.1963070-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

Sc devices can come with several CRFs. Use the CRF to determine the name
of the device.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c   |  6 ---
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  3 --
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 43 ++++++++++++++++---
 3 files changed, 37 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
index eee47af728d7..eb56af9a8411 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
@@ -142,22 +142,16 @@ const struct iwl_cfg_trans_params iwl_sc_trans_cfg = {
 	.ltr_delay = IWL_CFG_TRANS_LTR_DELAY_2500US,
 };
 
-const char iwl_sc_name[] = "Intel(R) TBD Sc device";
-
 const struct iwl_cfg iwl_cfg_sc = {
 	.fw_name_mac = "sc",
 	IWL_DEVICE_SC,
 };
 
-const char iwl_sc2_name[] = "Intel(R) TBD Sc2 device";
-
 const struct iwl_cfg iwl_cfg_sc2 = {
 	.fw_name_mac = "sc2",
 	IWL_DEVICE_SC,
 };
 
-const char iwl_sc2f_name[] = "Intel(R) TBD Sc2f device";
-
 const struct iwl_cfg iwl_cfg_sc2f = {
 	.fw_name_mac = "sc2f",
 	IWL_DEVICE_SC,
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 8fe5129224b0..c51350dd784e 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -555,9 +555,6 @@ extern const char iwl_fm_name[];
 extern const char iwl_wh_name[];
 extern const char iwl_gl_name[];
 extern const char iwl_mtp_name[];
-extern const char iwl_sc_name[];
-extern const char iwl_sc2_name[];
-extern const char iwl_sc2f_name[];
 extern const char iwl_dr_name[];
 extern const char iwl_br_name[];
 #if IS_ENABLED(CONFIG_IWLDVM)
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 346a5c178dc2..cd347cd8176a 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1173,19 +1173,50 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 /* Sc */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SC, IWL_CFG_ANY,
-		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_GF, IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_BW_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
+		      iwl_cfg_sc, iwl_ax211_name),
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_SC, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_BW_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
+		      iwl_cfg_sc, iwl_fm_name),
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_SC, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_WH, IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_BW_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
-		      iwl_cfg_sc, iwl_sc_name),
+		      iwl_cfg_sc, iwl_wh_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SC2, IWL_CFG_ANY,
-		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_GF, IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_BW_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
+		      iwl_cfg_sc2, iwl_ax211_name),
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_SC2, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_BW_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
-		      iwl_cfg_sc2, iwl_sc2_name),
+		      iwl_cfg_sc2, iwl_fm_name),
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_SC2, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_WH, IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_BW_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
+		      iwl_cfg_sc2, iwl_wh_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SC2F, IWL_CFG_ANY,
-		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_GF, IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_BW_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
-		      iwl_cfg_sc2f, iwl_sc2f_name),
+		      iwl_cfg_sc2f, iwl_ax211_name),
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_SC2F, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_BW_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
+		      iwl_cfg_sc2f, iwl_fm_name),
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_SC2F, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_WH, IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_BW_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
+		      iwl_cfg_sc2f, iwl_wh_name),
+
 /* Dr */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_DR, IWL_CFG_ANY,
-- 
2.34.1


