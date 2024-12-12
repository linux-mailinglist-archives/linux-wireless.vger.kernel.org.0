Return-Path: <linux-wireless+bounces-16307-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 495E89EE507
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2024 12:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4027A16645E
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2024 11:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3BB210F62;
	Thu, 12 Dec 2024 11:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fjuGHrd1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6F82116E9
	for <linux-wireless@vger.kernel.org>; Thu, 12 Dec 2024 11:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734003003; cv=none; b=nhX+4jFiQ7vg1Gx5X8uyjEeDshO5S10bD/CmSWyrNiy0NGcujmN3Qh0/+ER58x/eB67F695kOiW/X43U60Shms2EP2mhSu/Klyu+gF9WS6bU/5AVREpRMHJq7yUvibG7MMQJDps3SelFQHOHQpmuwBGGvqK0Kj1hlgHwI/28neQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734003003; c=relaxed/simple;
	bh=tz4GTdW+rII6H9Dw/IBzqnHGxMtbEMLfALHbDjOBLp4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NqrQhaVuCALJ0xCteGIwHdfnPFyankJw+7s9eGluTtrBBfgRP8gEzYCNcKSpdaXS1j1QvLOfwJkDtPa1CjVxaEqGBJHyEsD29YVQHC8iEYEG0wKS3jgCWxvVkmSjfwAOS6wm4y3WpOrQD9rvgAqcrczwpHdAjC7pMci6zMnt7ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fjuGHrd1; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734003002; x=1765539002;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tz4GTdW+rII6H9Dw/IBzqnHGxMtbEMLfALHbDjOBLp4=;
  b=fjuGHrd19eL5I7kT6MLfx+bXchzo1FwPehL70UHH4XOReoM9cChXrRAK
   hD0EO0GJry7bA08fwFKirt4mkoy5CkdLdxiIYyEQVSHwWwhdykxQAYkWk
   25biu0ZhTWpxbBkDVmvEAQ2etLRfnA8i5h5lxpm83k/RoDhGHidTQTWug
   nSlsoN7epnRiRZi2q2G0rFw0f4tNjURj1ckNeUreuEg5SKDABDvFDrnKv
   s0hT0jxyR6zMeGwcniLsnEAbfbtCIkz14ML+5yoSxFbGqjVnWs6A7Wujk
   V/60i8WwSe7OGT0XJUQ6Wdf8QOPZBaXHrLaKNoxtD/FRFPIX6fKMYALAm
   g==;
X-CSE-ConnectionGUID: HSsFFFU3T6GGWGWZTGHsdA==
X-CSE-MsgGUID: yY7xa9WuSNuhm6lzEL7WPA==
X-IronPort-AV: E=McAfee;i="6700,10204,11284"; a="33726405"
X-IronPort-AV: E=Sophos;i="6.12,228,1728975600"; 
   d="scan'208";a="33726405"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 03:29:59 -0800
X-CSE-ConnectionGUID: Znzic5DHR9aWpIXy6mxIOg==
X-CSE-MsgGUID: IIgNXywGQnee/0hAnrK8qA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,228,1728975600"; 
   d="scan'208";a="95955259"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 03:29:57 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH] wifi: iwlwifi: fix CRF name for Bz
Date: Thu, 12 Dec 2024 13:29:42 +0200
Message-Id: <20241212132940.b9eebda1ca60.I36791a134ed5e538e059418eb6520761da97b44c@changeid>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

We had BE201 hard coded.
Look at the RF_ID and decide based on its value.

Fixes: 6795a37161fb ("wifi: iwlwifi: Print a specific device name.")
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c   |  1 +
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  1 +
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 37 ++++++++++++++++++-
 3 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
index cd1fe8490ae5..1c43f283ac4a 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
@@ -161,6 +161,7 @@ const struct iwl_cfg_trans_params iwl_gl_trans_cfg = {
 
 const char iwl_bz_name[] = "Intel(R) TBD Bz device";
 const char iwl_fm_name[] = "Intel(R) Wi-Fi 7 BE201 320MHz";
+const char iwl_wh_name[] = "Intel(R) Wi-Fi 7 BE211 320MHz";
 const char iwl_gl_name[] = "Intel(R) Wi-Fi 7 BE200 320MHz";
 const char iwl_mtp_name[] = "Intel(R) Wi-Fi 7 BE202 160MHz";
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 34c91deca57b..17721bb47e25 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -545,6 +545,7 @@ extern const char iwl_ax231_name[];
 extern const char iwl_ax411_name[];
 extern const char iwl_bz_name[];
 extern const char iwl_fm_name[];
+extern const char iwl_wh_name[];
 extern const char iwl_gl_name[];
 extern const char iwl_mtp_name[];
 extern const char iwl_sc_name[];
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 805fb249a0c6..8fb2aa282242 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1106,19 +1106,54 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 		      iwlax210_2ax_cfg_so_jf_b0, iwl9462_name),
 
 /* Bz */
-/* FIXME: need to change the naming according to the actual CRF */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_BZ, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_HR2, IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
+		      iwl_cfg_bz, iwl_ax201_name),
+
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_BZ, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_GF, IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
+		      iwl_cfg_bz, iwl_ax211_name),
+
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_BZ, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
 		      iwl_cfg_bz, iwl_fm_name),
 
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_BZ, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_WH, IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
+		      iwl_cfg_bz, iwl_wh_name),
+
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_BZ_W, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_HR2, IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
+		      iwl_cfg_bz, iwl_ax201_name),
+
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_BZ_W, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_GF, IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
+		      iwl_cfg_bz, iwl_ax211_name),
+
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_BZ_W, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
 		      iwl_cfg_bz, iwl_fm_name),
 
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_BZ_W, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_WH, IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
+		      iwl_cfg_bz, iwl_wh_name),
+
 /* Ga (Gl) */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_GL, IWL_CFG_ANY,
-- 
2.34.1


