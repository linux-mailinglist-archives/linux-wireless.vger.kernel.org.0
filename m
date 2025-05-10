Return-Path: <linux-wireless+bounces-22826-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0579EAB2510
	for <lists+linux-wireless@lfdr.de>; Sat, 10 May 2025 20:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48BDC189D6BB
	for <lists+linux-wireless@lfdr.de>; Sat, 10 May 2025 18:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AAA5283CAC;
	Sat, 10 May 2025 18:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nvWWuFXh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB6F22D4EB
	for <linux-wireless@vger.kernel.org>; Sat, 10 May 2025 18:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746902940; cv=none; b=WiQejWspZgrBs5xTY5qBInQcCUUhlKeFE5lXE1qg4NdEqLJdpz9kG2rbNJMc+dQqDQDCjUxnszOEN7ZwnqBAutqDUi4uSZfGUpCYdbUVo75gR0Bnz8Px+n00qvNlUOBYX765LkQLA2f9ijejvrdRT3Wo9TXPPXPwGdW8MxbODiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746902940; c=relaxed/simple;
	bh=c96Oxb04/2jTxyLGjkFwvT3/4hOaXFCgtcfDcBFdbc8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t07TFZMMM66LZIAkdyfhq5Vjcylr0cygquFawpn2YsC7V1imlpCMuoPVLd0zLXPoDIIQJ55qBXbG/HdPOVN760z+h5nBIjOCZbI2ZnPjsB7h3t76ilmtZExhxhBHdP/EJIdgqHIdY2KPfGNwspnZyfjthQFAzs1FzSl4Tj74yvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nvWWuFXh; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746902939; x=1778438939;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c96Oxb04/2jTxyLGjkFwvT3/4hOaXFCgtcfDcBFdbc8=;
  b=nvWWuFXhnvQaczrKbBHBMv/EQIvVyHFh6NwTKIHtt7qU2e2NH/mbQ4Eg
   m62XIwHzoBs3yt0RSU9WzJxUq7NDh4cRH9rCMHKGYr3ndN6l7x/v1g8W8
   TpFUVSvc+Zm4IuFoS9J/WbLw0Bw+dg96VKbD8weFwOUm+8kfa/zvwFOtf
   meKdTQuikB9I6qWR1NN2PfY9Gw2EEs9I0qNswU1M2ihGk7MrvJ/Qu9v0c
   O3VqsOqUdPVHGKU9Mir+lIg2aP/jEI0cT0E/hUgX/dhKt+7su3cKQZHBO
   WExdUKj3qlNRLPaYv1pb9493U1S6u16c/mHiBvfj1aa/MYqO+9bIUAhh8
   Q==;
X-CSE-ConnectionGUID: fxIVt6/US6CdzANcI5izZg==
X-CSE-MsgGUID: jwuDFsFYRUOU32H9JeOduA==
X-IronPort-AV: E=McAfee;i="6700,10204,11429"; a="48880893"
X-IronPort-AV: E=Sophos;i="6.15,278,1739865600"; 
   d="scan'208";a="48880893"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2025 11:48:59 -0700
X-CSE-ConnectionGUID: AT6Kl1qDTN6PUZwhrQPnzw==
X-CSE-MsgGUID: WmhIpIWXQK+tzRjeWHGSxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,278,1739865600"; 
   d="scan'208";a="142033453"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2025 11:48:58 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 13/15] wifi: iwlwifi: cfg: fix PE RF names
Date: Sat, 10 May 2025 21:48:25 +0300
Message-Id: <20250510214621.d03eaad5be56.I276a09f0cad364e51ed4730ca81fbe504e61f2c7@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250510184827.3800322-1-miriam.rachel.korenblit@intel.com>
References: <20250510184827.3800322-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

There are a couple of variants of this, match them correctly
to their names and clean up a bit.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/Makefile     |  2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/rf-pe.c  | 16 ++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c     |  2 --
 drivers/net/wireless/intel/iwlwifi/iwl-config.h |  6 +++++-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c   | 17 +++++++----------
 5 files changed, 29 insertions(+), 14 deletions(-)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/cfg/rf-pe.c

diff --git a/drivers/net/wireless/intel/iwlwifi/Makefile b/drivers/net/wireless/intel/iwlwifi/Makefile
index 89e7df5bf6ef..031babc65a0d 100644
--- a/drivers/net/wireless/intel/iwlwifi/Makefile
+++ b/drivers/net/wireless/intel/iwlwifi/Makefile
@@ -23,7 +23,7 @@ iwlwifi-$(CONFIG_IWLMVM) += cfg/ax210.o
 iwlwifi-$(CONFIG_IWLMLD) += cfg/bz.o cfg/sc.o cfg/dr.o
 # RF configurations
 iwlwifi-$(CONFIG_IWLMVM) += cfg/rf-jf.o cfg/rf-hr.o cfg/rf-gf.o
-iwlwifi-$(CONFIG_IWLMLD) += cfg/rf-fm.o cfg/rf-wh.o
+iwlwifi-$(CONFIG_IWLMLD) += cfg/rf-fm.o cfg/rf-wh.o cfg/rf-pe.o
 
 iwlwifi-objs		+= iwl-dbg-tlv.o
 iwlwifi-objs		+= iwl-trans.o
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/rf-pe.c b/drivers/net/wireless/intel/iwlwifi/cfg/rf-pe.c
new file mode 100644
index 000000000000..483f21659eff
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/rf-pe.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright (C) 2025 Intel Corporation
+ */
+#include "iwl-config.h"
+
+/* currently iwl_rf_wh/iwl_rf_wh_160mhz are just defines for the FM ones */
+
+const char iwl_killer_bn1850w2_name[] =
+	"Killer(R) Wi-Fi 8 BN1850w2 320MHz Wireless Network Adapter (BN201.D2W)";
+const char iwl_killer_bn1850i_name[] =
+	"Killer(R) Wi-Fi 8 BN1850i 320MHz Wireless Network Adapter (BN201.NGW)";
+
+const char iwl_bn201_name[] = "Intel(R) Wi-Fi 8 BN201";
+const char iwl_be221_name[] = "Intel(R) Wi-Fi 7 BE221";
+const char iwl_be223_name[] = "Intel(R) Wi-Fi 7 BE223";
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
index 3078e7d0c1fe..b2e4d4035296 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
@@ -105,8 +105,6 @@ const struct iwl_mac_cfg iwl_sc_mac_cfg = {
 	.ltr_delay = IWL_CFG_TRANS_LTR_DELAY_2500US,
 };
 
-const char iwl_pe_name[] = "Intel(R) Wi-Fi 8 BN201";
-
 IWL_FW_AND_PNVM(IWL_SC_A_FM_B_FW_PRE, IWL_SC_UCODE_API_MAX);
 IWL_FW_AND_PNVM(IWL_SC_A_FM_C_FW_PRE, IWL_SC_UCODE_API_MAX);
 MODULE_FIRMWARE(IWL_SC_A_HR_A_FW_MODULE_FIRMWARE(IWL_SC_UCODE_API_MAX));
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 7bf18658763e..5b3229304616 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -647,7 +647,11 @@ extern const char iwl_be213_name[];
 extern const char iwl_killer_be1775s_name[];
 extern const char iwl_killer_be1775i_name[];
 extern const char iwl_be211_name[];
-extern const char iwl_pe_name[];
+extern const char iwl_killer_bn1850w2_name[];
+extern const char iwl_killer_bn1850i_name[];
+extern const char iwl_bn201_name[];
+extern const char iwl_be221_name[];
+extern const char iwl_be223_name[];
 extern const char iwl_dr_name[];
 extern const char iwl_br_name[];
 #if IS_ENABLED(CONFIG_IWLDVM)
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index f52c3c19beb7..e2f9b1dea58f 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1023,20 +1023,17 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 	IWL_DEV_INFO(iwl_rf_wh, iwl_be211_name, RF_TYPE(WH)),
 	IWL_DEV_INFO(iwl_rf_wh_160mhz, iwl_be213_name, RF_TYPE(WH), BW_LIMITED),
 
+/* PE RF */
+	IWL_DEV_INFO(iwl_rf_pe, iwl_bn201_name, RF_TYPE(PE)),
+	IWL_DEV_INFO(iwl_rf_pe, iwl_be223_name, RF_TYPE(PE), SUBDEV(0x0524)),
+	IWL_DEV_INFO(iwl_rf_pe, iwl_be221_name, RF_TYPE(PE), SUBDEV(0x0324)),
+
 /* Killer */
 	IWL_DEV_INFO(iwl_rf_wh, iwl_killer_be1775s_name, SUBDEV(0x1776)),
 	IWL_DEV_INFO(iwl_rf_wh, iwl_killer_be1775i_name, SUBDEV(0x1775)),
 
-/* Sc */
-	IWL_DEV_INFO(iwl_rf_pe, iwl_pe_name, MAC_TYPE(SC), RF_TYPE(PE)),
-	IWL_DEV_INFO(iwl_rf_pe, iwl_pe_name, MAC_TYPE(SC2), RF_TYPE(PE)),
-	IWL_DEV_INFO(iwl_rf_pe, iwl_pe_name, MAC_TYPE(SC2F), RF_TYPE(PE)),
-
-/* Dr */
-	IWL_DEV_INFO(iwl_rf_pe, iwl_dr_name, MAC_TYPE(DR), RF_TYPE(PE)),
-
-/* Br */
-	IWL_DEV_INFO(iwl_rf_pe, iwl_br_name, MAC_TYPE(BR), RF_TYPE(PE)),
+	IWL_DEV_INFO(iwl_rf_pe, iwl_killer_bn1850w2_name, SUBDEV(0x1851)),
+	IWL_DEV_INFO(iwl_rf_pe, iwl_killer_bn1850i_name, SUBDEV(0x1852)),
 #endif /* CONFIG_IWLMLD */
 };
 EXPORT_SYMBOL_IF_IWLWIFI_KUNIT(iwl_dev_info_table);
-- 
2.34.1


