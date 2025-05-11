Return-Path: <linux-wireless+bounces-22840-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD754AB29C3
	for <lists+linux-wireless@lfdr.de>; Sun, 11 May 2025 18:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB60B7A2502
	for <lists+linux-wireless@lfdr.de>; Sun, 11 May 2025 16:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BFE517DFE7;
	Sun, 11 May 2025 16:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XStkhQQ+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3070256C7C
	for <linux-wireless@vger.kernel.org>; Sun, 11 May 2025 16:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746982419; cv=none; b=Tijq3B3YypkkOilLOstuXxJ0pOfBbsJffHiJzt6BecnKXL1luBGXpnEPDcrDx2mnxMtcbYtNNlzxa9Ol2ou3Ca2fhCJ15GvMSHfOo8o90Fg+E+R9p/XuBHxpHSXe8KJlEKwuJYh0tNE6LheGNzxzHpkOVcdrImU94FNIESzSjro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746982419; c=relaxed/simple;
	bh=FAxGsssblCidQB776jcWYG8HwE+0rDz6qutlAdfmfG4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sPiDDzrUTaikopQBogpEtTJaqwqHohK4J9I8qWoea4O/67vX9WhvQiK9EjAWEQV+k/HdL5e91RYEj2PSszPZKcZuJm+XdddokoSSm6Lwtsnn1/n+wyFXCixoBDiE8IGkCA0mf3hyauFuMgVIglZ0EF7v+xr1SHLQOAKL2Q06dj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XStkhQQ+; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746982418; x=1778518418;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FAxGsssblCidQB776jcWYG8HwE+0rDz6qutlAdfmfG4=;
  b=XStkhQQ+0gCuz/iFuwMxEoCdkjxO0KrJi20dIcmzd2ud7atgDGJqtCNp
   y16dX3WbQEP2bujz4BKb6Gz66ovgMQoArGRwnRbS1Es0FdhbAYTyaEtnw
   RJKPaxS+OCaG9pXuDD+2wJiG9t6Zp2+x5HwIv8ig/AmXe8jkVY9OA0BLX
   Gt/sYOkgIpJNxnF2yei2MmFo58GkLj/rJDhUmvqxxc6QI6TkAZjOkGpRv
   OPbbsfeJtbk5FIRNxj+XxCedzJkK5k6oLRvPRtOkFZsnW+gUNeWiX9APJ
   A9JfQTJ8xqhTk0hkrRIcRt3hLrIrtUEqaUoxkspbK02+Ue29zBHXCQxXN
   Q==;
X-CSE-ConnectionGUID: pg0MccD0QdScLzaXEBkvwA==
X-CSE-MsgGUID: zje5tzEwS7iY6uWsoYLDHA==
X-IronPort-AV: E=McAfee;i="6700,10204,11430"; a="52582680"
X-IronPort-AV: E=Sophos;i="6.15,280,1739865600"; 
   d="scan'208";a="52582680"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2025 09:53:37 -0700
X-CSE-ConnectionGUID: xPsXK0vURReFOJIVmcEaEA==
X-CSE-MsgGUID: +Kbg5cbOS36bIrE61KTAQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,280,1739865600"; 
   d="scan'208";a="137655010"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2025 09:53:36 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH iwlwifi-next 01/15] wifi: iwlwifi: cfg: mark Ty devices as discrete
Date: Sun, 11 May 2025 19:53:07 +0300
Message-Id: <20250511195137.f3a75ae80f28.I79964f4426389f04798b70841a9e847be48bf9c3@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250511165321.590808-1-miriam.rachel.korenblit@intel.com>
References: <20250511165321.590808-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Looks like these were never marked discrete, since they always
used the iwl_so_mac_cfg (earlier iwl_so_trans_cfg). Mark them
as discrete since they are.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
PerCI-Ready: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Tested-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/ax210.c  | 10 ++++++++++
 drivers/net/wireless/intel/iwlwifi/iwl-config.h |  1 +
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c   |  4 ++--
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c b/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
index 18d0de13f564..3bf9fdbe01c6 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
@@ -88,6 +88,16 @@ static const struct iwl_family_base_params iwl_ax210_base = {
 	.ucode_api_max = IWL_AX210_UCODE_API_MAX,
 };
 
+const struct iwl_mac_cfg iwl_ty_mac_cfg = {
+	.mq_rx_supported = true,
+	.gen2 = true,
+	.device_family = IWL_DEVICE_FAMILY_AX210,
+	.base = &iwl_ax210_base,
+	.umac_prph_offset = 0x300000,
+	/* TODO: the following values need to be checked */
+	.xtal_latency = 500,
+};
+
 const struct iwl_mac_cfg iwl_so_mac_cfg = {
 	.mq_rx_supported = true,
 	.gen2 = true,
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 0b18f44af774..363ef060d68e 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -527,6 +527,7 @@ extern const struct iwl_mac_cfg iwl_qu_mac_cfg;
 extern const struct iwl_mac_cfg iwl_qu_medium_latency_mac_cfg;
 extern const struct iwl_mac_cfg iwl_qu_long_latency_mac_cfg;
 extern const struct iwl_mac_cfg iwl_ax200_mac_cfg;
+extern const struct iwl_mac_cfg iwl_ty_mac_cfg;
 extern const struct iwl_mac_cfg iwl_so_mac_cfg;
 extern const struct iwl_mac_cfg iwl_so_long_latency_mac_cfg;
 extern const struct iwl_mac_cfg iwl_so_long_latency_imr_mac_cfg;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 1d149843f335..d270dfaa6c83 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -488,8 +488,8 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct pci_device_id iwl_hw_card_ids[] = {
 
 	{IWL_PCI_DEVICE(0x2723, PCI_ANY_ID, iwl_ax200_mac_cfg)},
 
-/* So devices */
-	{IWL_PCI_DEVICE(0x2725, PCI_ANY_ID, iwl_so_mac_cfg)},
+/* Ty/So devices */
+	{IWL_PCI_DEVICE(0x2725, PCI_ANY_ID, iwl_ty_mac_cfg)},
 	{IWL_PCI_DEVICE(0x7A70, PCI_ANY_ID, iwl_so_long_latency_imr_mac_cfg)},
 	{IWL_PCI_DEVICE(0x7AF0, PCI_ANY_ID, iwl_so_mac_cfg)},
 	{IWL_PCI_DEVICE(0x51F0, PCI_ANY_ID, iwl_so_long_latency_mac_cfg)},
-- 
2.34.1


