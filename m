Return-Path: <linux-wireless+bounces-5051-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE595881910
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 22:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F712B21A27
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 21:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192C71DFC6;
	Wed, 20 Mar 2024 21:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d2a1+uvo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E6785C44
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 21:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710970028; cv=none; b=DKHORfITiYX/agwGaiUqp0zOnXAXGiGn28McmNOTLYkPqmxFI6z+edBAVtJtn+NSiXr7vts9zeGtwDcqa7TCOABKmaMTwvD3Y1gbBQiQL5/tkSExk7BtsF2iWy6JDvUb+e0Zgw98yy9l2SCKora2aH32kCLnEgmehf03LxtYd1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710970028; c=relaxed/simple;
	bh=uAzA9ss0XuzhcY8X9OAAAZQs0Ayd1auF0OXV+ZpiOPM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U3PQQnBkootc+UD9CBAGGgRlcTj/wEijpV6ZIx2KCJA5xcepv/UDcFMo9msOjcUUBBfTM0ifW4HJpywqe65sg4P5nb9Wkw8Zxa7da9VnJmIbdgA/O9Tosj0B1GjPDEgXP/w3bMvrfJiX1OOZXFYkMwl+xrffxHcm1UxXg7DiVIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d2a1+uvo; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710970026; x=1742506026;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uAzA9ss0XuzhcY8X9OAAAZQs0Ayd1auF0OXV+ZpiOPM=;
  b=d2a1+uvovGm8H0otNnzCwwaopt5vSE7f+uBjGWlkuLv4b2mKBs4/nHxP
   Mw7CKl57XHXKrVw1CsNGb3Rbyw8pZgQdMBMEe1l6fC+j8T8tH7o3UmuSG
   2c0109awCevXs5UmZBDRP2uQKEaTHQu0RI5gw3i7wz8P5eGvWGaK6fFye
   Lf/aLQqyEMRiYHO5gcGK+rHThvbR1MHsvEIfwJGjaYzthBPVJgKuCUw8k
   em/6mNipVOwJ8l+Oi+M8lkFuL+TnA192y2hHhi3sgphaj0JOf8Kftinyn
   nz7sKiAgdtbwM8NGiaLkkuPQtryiNVJXZu7RPEqXv3kVN/xAiIM/FNssM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="9698084"
X-IronPort-AV: E=Sophos;i="6.07,141,1708416000"; 
   d="scan'208";a="9698084"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 14:27:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,141,1708416000"; 
   d="scan'208";a="14184166"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 14:27:05 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Daniel Amosi <amosi.daniel@intel.com>
Subject: [PATCH 08/17] wifi: iwlwifi: Print a specific device name.
Date: Wed, 20 Mar 2024 23:26:29 +0200
Message-Id: <20240320232419.6fc9ad1396ca.I207626ce5e2ada170a7c01dccf5226110d09f135@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240320212638.1446082-1-miriam.rachel.korenblit@intel.com>
References: <20240320212638.1446082-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Daniel Amosi <amosi.daniel@intel.com>

For FM and GL, the name printed on the logs was "TBD".
Change that to print the accurate name.

Signed-off-by: Daniel Amosi <amosi.daniel@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c     | 2 ++
 drivers/net/wireless/intel/iwlwifi/iwl-config.h | 2 ++
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c   | 5 +++--
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
index 072b0a5827d1..bc98b87cf2a1 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
@@ -149,6 +149,8 @@ const struct iwl_cfg_trans_params iwl_bz_trans_cfg = {
 };
 
 const char iwl_bz_name[] = "Intel(R) TBD Bz device";
+const char iwl_fm_name[] = "Intel(R) Wi-Fi 7 BE201 320MHz";
+const char iwl_gl_name[] = "Intel(R) Wi-Fi 7 BE200 320MHz";
 const char iwl_mtp_name[] = "Intel(R) Wi-Fi 7 BE202 160MHz";
 
 const struct iwl_cfg iwl_cfg_bz = {
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 9baa6b2c37db..a931277169a7 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -541,6 +541,8 @@ extern const char iwl_ax221_name[];
 extern const char iwl_ax231_name[];
 extern const char iwl_ax411_name[];
 extern const char iwl_bz_name[];
+extern const char iwl_fm_name[];
+extern const char iwl_gl_name[];
 extern const char iwl_mtp_name[];
 extern const char iwl_sc_name[];
 extern const char iwl_sc2_name[];
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 7cba9f72dd11..a687c394cf07 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -997,18 +997,19 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 		      iwlax411_2ax_cfg_so_gf4_a0, iwl_ax411_name),
 
 /* Bz */
+/* FIXME: need to change the naming according to the actual CRF */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_BZ, IWL_CFG_ANY,
 		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
-		      iwl_cfg_bz, iwl_bz_name),
+		      iwl_cfg_bz, iwl_fm_name),
 
 /* Ga (Gl) */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_GL, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_320, IWL_CFG_ANY, IWL_CFG_NO_CDB,
-		      iwl_cfg_gl, iwl_bz_name),
+		      iwl_cfg_gl, iwl_gl_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_GL, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY, IWL_CFG_ANY,
-- 
2.34.1


