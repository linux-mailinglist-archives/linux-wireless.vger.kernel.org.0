Return-Path: <linux-wireless+bounces-22740-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A99C0AAF974
	for <lists+linux-wireless@lfdr.de>; Thu,  8 May 2025 14:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C94391C00243
	for <lists+linux-wireless@lfdr.de>; Thu,  8 May 2025 12:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE0A2253EA;
	Thu,  8 May 2025 12:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jo3gMjH9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35731C5F39
	for <linux-wireless@vger.kernel.org>; Thu,  8 May 2025 12:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746706406; cv=none; b=Ba1qo9H8ROQ/uC/3FYXHd1HM/8RN7crkPeQHdDpeIhC9cMQKIO2gHjrnVItXYDhOTAxYHZT1MKs346frfpIEKwci0WyhlQX2g97/njBP3DTMoYRlucez9sCJ0/a/FXqSKUsbegB32fAfnW5UxOGOcF0hXoz67Qyjnp9Zv0mKN98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746706406; c=relaxed/simple;
	bh=ATg3PwEqTJ1aUBYfKgDQX5ByVas0Ivjl/1PCqjflVHE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lCjyNDVlwc7G8Hi3sU5UN7mgGZNR9ZQegW9wm+3fohBAWW5AoHbHsJuP+2wj2tvg0uB9sG44ThaPdXJ51QShmpIwQwldgvyCLHV7+xHxMUTr9FnNSbQ1CssmX7iPzRpbojqcckffe9L4gKjDEwHKKdG51yYlYZK3K1+WsKJ/K98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jo3gMjH9; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746706404; x=1778242404;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ATg3PwEqTJ1aUBYfKgDQX5ByVas0Ivjl/1PCqjflVHE=;
  b=jo3gMjH9F7wEK6WdzV3SdWFnt2rzDXNi/jmbH7jPEBK1kHRNBdssxfHG
   iGyL6Avl9JgnYg+DzReZ9YPoRt1mZLZEgRvaEu8y+NxsAXUZAZLtMiSnA
   X4HY4cawBsD/FabvRqzWVgbl2WXNKyrspUnu7gH+2zhOLjLVVCCwdRhgA
   9vROlRNmKMsNLT9ROTYXiUgxQT9/5VKEX55f8FZ0EN7prApLkf9jslySA
   4recdd0/xSQpYBmId47VO/Gg2tlD8XO+MNuJLY68HyA4boLlAQCP+Nzwk
   jfodLy0+hE5eIc0uBZkY3wIkVOsWKnmfPepQjck4KzAaMbq8Fe/b/1Z90
   A==;
X-CSE-ConnectionGUID: PqskmYnyS2udQnv5DVq86Q==
X-CSE-MsgGUID: 0qP1arEtSFebAzRSD14FZg==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="58688031"
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; 
   d="scan'208";a="58688031"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 05:13:23 -0700
X-CSE-ConnectionGUID: +fwlWKVWQvqSuAxp+rul2w==
X-CSE-MsgGUID: 43XnmCF6RfuOXdW6/OGnPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; 
   d="scan'208";a="167347771"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 05:13:21 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 01/15] wifi: iwlwifi: build 9000 series FW filenames dynamically
Date: Thu,  8 May 2025 15:12:52 +0300
Message-Id: <20250508121306.1277801-2-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250508121306.1277801-1-miriam.rachel.korenblit@intel.com>
References: <20250508121306.1277801-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

This is more maintainable than the fw_name_pre prefix, and
requires fewer duplicate structs as well. Since only b0 FW
exists, override the MAC/RF steps for these devices.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Message-Id: <20250508151045.5f8d3334a49d.I08ab8c2c6b6863f83f1e7eb0736581f1752a5b38@changeid>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/9000.c | 17 +-----
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  6 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  |  6 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 60 +++++++++----------
 4 files changed, 38 insertions(+), 51 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/9000.c b/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
index af21cfdadc8f..70d941ac299b 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
@@ -177,24 +177,11 @@ const char iwl9560_killer_1550s_name[] =
 const char iwl9560_killer_1550s_160_name[] =
 	"Killer(R) Wireless-AC 1550s Wireless Network Adapter (9560D2W) 160MHz";
 
-const struct iwl_cfg iwl9260_2ac_cfg = {
-	.fw_name_pre = IWL9260_FW_PRE,
+const struct iwl_cfg iwl9000_2ac_cfg = {
 	IWL_DEVICE_9000,
 };
 
-const struct iwl_cfg iwl9260_2ac_cfg_80mhz = {
-	.fw_name_pre = IWL9260_FW_PRE,
-	IWL_DEVICE_9000,
-	.bw_limit = 80,
-};
-
-const struct iwl_cfg iwl9560_2ac_cfg_soc = {
-	.fw_name_pre = IWL9000_FW_PRE,
-	IWL_DEVICE_9000,
-};
-
-const struct iwl_cfg iwl9560_2ac_cfg_soc_80mhz = {
-	.fw_name_pre = IWL9000_FW_PRE,
+const struct iwl_cfg iwl9000_2ac_cfg_80mhz = {
 	IWL_DEVICE_9000,
 	.bw_limit = 80,
 };
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 30725ed5e3bc..914f549e95ba 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -665,14 +665,12 @@ extern const struct iwl_cfg iwl7265_cfg;
 extern const struct iwl_cfg iwl7265d_cfg;
 extern const struct iwl_cfg iwl8260_cfg;
 extern const struct iwl_cfg iwl8265_cfg;
-extern const struct iwl_cfg iwl9260_2ac_cfg;
-extern const struct iwl_cfg iwl9260_2ac_cfg_80mhz;
+extern const struct iwl_cfg iwl9000_2ac_cfg;
+extern const struct iwl_cfg iwl9000_2ac_cfg_80mhz;
 extern const struct iwl_cfg iwl9560_qu_jf_cfg;
 extern const struct iwl_cfg iwl9560_qu_jf_cfg_80mhz;
 extern const struct iwl_cfg iwl9560_quz_a0_jf_b0_cfg;
 extern const struct iwl_cfg iwl9560_quz_a0_jf_b0_cfg_80mhz;
-extern const struct iwl_cfg iwl9560_2ac_cfg_soc;
-extern const struct iwl_cfg iwl9560_2ac_cfg_soc_80mhz;
 extern const struct iwl_cfg iwl_qu_hr1;
 extern const struct iwl_cfg iwl_qu_hr;
 extern const struct iwl_cfg iwl_qu_hr_80mhz;
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index 6cd520d50c98..acfc3eb89afe 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -191,10 +191,12 @@ const char *iwl_drv_get_fwname_pre(struct iwl_trans *trans, char *buf)
 
 	switch (CSR_HW_REV_TYPE(trans->info.hw_rev)) {
 	case IWL_CFG_MAC_TYPE_PU:
-		mac = "pu";
+		mac = "9000-pu";
+		mac_step = 'b';
 		break;
 	case IWL_CFG_MAC_TYPE_TH:
-		mac = "th";
+		mac = "9260-th";
+		mac_step = 'b';
 		break;
 	case IWL_CFG_MAC_TYPE_QU:
 		mac = "Qu";
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 3e535fed8ff5..fe2a8f40f6d4 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -944,31 +944,31 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 	IWL_DEV_INFO(iwl8265_cfg, iwl8275_2ac_name,
 		     DEVICE(0x24FD), SUBDEV(0x0012)),
 /* 9000 */
-	IWL_DEV_INFO(iwl9260_2ac_cfg, iwl9260_killer_1550_name,
+	IWL_DEV_INFO(iwl9000_2ac_cfg, iwl9260_killer_1550_name,
 		     DEVICE(0x2526), SUBDEV(0x1550)),
-	IWL_DEV_INFO(iwl9560_2ac_cfg_soc, iwl9560_killer_1550s_name,
+	IWL_DEV_INFO(iwl9000_2ac_cfg, iwl9560_killer_1550s_name,
 		     DEVICE(0x2526), SUBDEV(0x1551)),
-	IWL_DEV_INFO(iwl9560_2ac_cfg_soc, iwl9560_killer_1550i_name,
+	IWL_DEV_INFO(iwl9000_2ac_cfg, iwl9560_killer_1550i_name,
 		     DEVICE(0x2526), SUBDEV(0x1552)),
-	IWL_DEV_INFO(iwl9560_2ac_cfg_soc, iwl9560_killer_1550s_name,
+	IWL_DEV_INFO(iwl9000_2ac_cfg, iwl9560_killer_1550s_name,
 		     DEVICE(0x30DC), SUBDEV(0x1551)),
-	IWL_DEV_INFO(iwl9560_2ac_cfg_soc, iwl9560_killer_1550i_name,
+	IWL_DEV_INFO(iwl9000_2ac_cfg, iwl9560_killer_1550i_name,
 		     DEVICE(0x30DC), SUBDEV(0x1552)),
-	IWL_DEV_INFO(iwl9560_2ac_cfg_soc, iwl9560_killer_1550s_name,
+	IWL_DEV_INFO(iwl9000_2ac_cfg, iwl9560_killer_1550s_name,
 		     DEVICE(0x31DC), SUBDEV(0x1551)),
-	IWL_DEV_INFO(iwl9560_2ac_cfg_soc, iwl9560_killer_1550i_name,
+	IWL_DEV_INFO(iwl9000_2ac_cfg, iwl9560_killer_1550i_name,
 		     DEVICE(0x31DC), SUBDEV(0x1552)),
-	IWL_DEV_INFO(iwl9560_2ac_cfg_soc, iwl9560_killer_1550s_name,
+	IWL_DEV_INFO(iwl9000_2ac_cfg, iwl9560_killer_1550s_name,
 		     DEVICE(0xA370), SUBDEV(0x1551)),
-	IWL_DEV_INFO(iwl9560_2ac_cfg_soc, iwl9560_killer_1550i_name,
+	IWL_DEV_INFO(iwl9000_2ac_cfg, iwl9560_killer_1550i_name,
 		     DEVICE(0xA370), SUBDEV(0x1552)),
-	IWL_DEV_INFO(iwl9560_2ac_cfg_soc, iwl9560_killer_1550s_160_name,
+	IWL_DEV_INFO(iwl9000_2ac_cfg, iwl9560_killer_1550s_160_name,
 		     DEVICE(0x54F0), SUBDEV(0x1551)),
-	IWL_DEV_INFO(iwl9560_2ac_cfg_soc, iwl9560_killer_1550i_name,
+	IWL_DEV_INFO(iwl9000_2ac_cfg, iwl9560_killer_1550i_name,
 		     DEVICE(0x54F0), SUBDEV(0x1552)),
-	IWL_DEV_INFO(iwl9560_2ac_cfg_soc, iwl9560_killer_1550s_160_name,
+	IWL_DEV_INFO(iwl9000_2ac_cfg, iwl9560_killer_1550s_160_name,
 		     DEVICE(0x51F0), SUBDEV(0x1552)),
-	IWL_DEV_INFO(iwl9560_2ac_cfg_soc, iwl9560_killer_1550i_160_name,
+	IWL_DEV_INFO(iwl9000_2ac_cfg, iwl9560_killer_1550i_160_name,
 		     DEVICE(0x51F0), SUBDEV(0x1551)),
 	IWL_DEV_INFO(iwlax411_2ax_cfg_so_gf4_a0, iwl_ax411_killer_1690s_name,
 		     DEVICE(0x51F0), SUBDEV(0x1691)),
@@ -989,7 +989,7 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 	IWL_DEV_INFO(iwlax411_2ax_cfg_so_gf4_a0, iwl_ax411_killer_1690i_name,
 		     DEVICE(0x7AF0), SUBDEV(0x1692)),
 
-	IWL_DEV_INFO(iwl9260_2ac_cfg, iwl9260_1_name,
+	IWL_DEV_INFO(iwl9000_2ac_cfg, iwl9260_1_name,
 		     DEVICE(0x271C), SUBDEV(0x0214)),
 	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax411_killer_1690s_name,
 		     DEVICE(0x7E40), SUBDEV(0x1691)),
@@ -1193,13 +1193,13 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 		     DEVICE(0x7AF0), SUBDEV(0x0A10)),
 
 	/* So with JF */
-	IWL_DEV_INFO(iwl9560_2ac_cfg_soc, iwl9560_killer_1550s_160_name,
+	IWL_DEV_INFO(iwl9000_2ac_cfg, iwl9560_killer_1550s_160_name,
 		     DEVICE(0x7A70), SUBDEV(0x1551)),
-	IWL_DEV_INFO(iwl9560_2ac_cfg_soc, iwl9560_killer_1550i_160_name,
+	IWL_DEV_INFO(iwl9000_2ac_cfg, iwl9560_killer_1550i_160_name,
 		     DEVICE(0x7A70), SUBDEV(0x1552)),
-	IWL_DEV_INFO(iwl9560_2ac_cfg_soc, iwl9560_killer_1550s_160_name,
+	IWL_DEV_INFO(iwl9000_2ac_cfg, iwl9560_killer_1550s_160_name,
 		     DEVICE(0x7AF0), SUBDEV(0x1551)),
-	IWL_DEV_INFO(iwl9560_2ac_cfg_soc, iwl9560_killer_1550i_160_name,
+	IWL_DEV_INFO(iwl9000_2ac_cfg, iwl9560_killer_1550i_160_name,
 		     DEVICE(0x7AF0), SUBDEV(0x1552)),
 
 	/* SO with GF2 */
@@ -1234,44 +1234,44 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax211_killer_1675i_name,
 		     DEVICE(0x7E40), SUBDEV(0x1672)),
 
-	IWL_DEV_INFO(iwl9560_2ac_cfg_soc, iwl9461_160_name, MAC_TYPE(PU),
+	IWL_DEV_INFO(iwl9000_2ac_cfg, iwl9461_160_name, MAC_TYPE(PU),
 		     RF_TYPE(JF1), RF_ID(JF1),
 		     BW_NOT_LIMITED, CORES(BT), NO_CDB),
-	IWL_DEV_INFO(iwl9560_2ac_cfg_soc_80mhz, iwl9461_name, MAC_TYPE(PU),
+	IWL_DEV_INFO(iwl9000_2ac_cfg_80mhz, iwl9461_name, MAC_TYPE(PU),
 		     RF_TYPE(JF1), RF_ID(JF1),
 		     BW_LIMITED, CORES(BT), NO_CDB),
-	IWL_DEV_INFO(iwl9560_2ac_cfg_soc, iwl9462_160_name, MAC_TYPE(PU),
+	IWL_DEV_INFO(iwl9000_2ac_cfg, iwl9462_160_name, MAC_TYPE(PU),
 		     RF_TYPE(JF1), RF_ID(JF1_DIV),
 		     BW_NOT_LIMITED, CORES(BT), NO_CDB),
-	IWL_DEV_INFO(iwl9560_2ac_cfg_soc_80mhz, iwl9462_name, MAC_TYPE(PU),
+	IWL_DEV_INFO(iwl9000_2ac_cfg_80mhz, iwl9462_name, MAC_TYPE(PU),
 		     RF_TYPE(JF1), RF_ID(JF1_DIV),
 		     BW_LIMITED, CORES(BT), NO_CDB),
 
-	IWL_DEV_INFO(iwl9560_2ac_cfg_soc, iwl9560_160_name, MAC_TYPE(PU),
+	IWL_DEV_INFO(iwl9000_2ac_cfg, iwl9560_160_name, MAC_TYPE(PU),
 		     RF_TYPE(JF2), RF_ID(JF),
 		     BW_NOT_LIMITED, CORES(BT), NO_CDB),
-	IWL_DEV_INFO(iwl9560_2ac_cfg_soc_80mhz, iwl9560_name, MAC_TYPE(PU),
+	IWL_DEV_INFO(iwl9000_2ac_cfg_80mhz, iwl9560_name, MAC_TYPE(PU),
 		     RF_TYPE(JF2), RF_ID(JF),
 		     BW_LIMITED, CORES(BT), NO_CDB),
 
-	IWL_DEV_INFO(iwl9260_2ac_cfg, iwl9270_160_name, DEVICE(0x2526),
+	IWL_DEV_INFO(iwl9000_2ac_cfg, iwl9270_160_name, DEVICE(0x2526),
 		     MAC_TYPE(TH), RF_TYPE(JF2),
 		     BW_NOT_LIMITED, CORES(BT_GNSS), NO_CDB),
-	IWL_DEV_INFO(iwl9260_2ac_cfg_80mhz, iwl9270_name, DEVICE(0x2526),
+	IWL_DEV_INFO(iwl9000_2ac_cfg_80mhz, iwl9270_name, DEVICE(0x2526),
 		     MAC_TYPE(TH), RF_TYPE(JF2),
 		     BW_LIMITED, CORES(BT_GNSS), NO_CDB),
 
-	IWL_DEV_INFO(iwl9260_2ac_cfg, iwl9162_160_name, DEVICE(0x271B),
+	IWL_DEV_INFO(iwl9000_2ac_cfg, iwl9162_160_name, DEVICE(0x271B),
 		     MAC_TYPE(TH), RF_TYPE(JF1),
 		     BW_NOT_LIMITED, CORES(BT), NO_CDB),
-	IWL_DEV_INFO(iwl9260_2ac_cfg_80mhz, iwl9162_name, DEVICE(0x271B),
+	IWL_DEV_INFO(iwl9000_2ac_cfg_80mhz, iwl9162_name, DEVICE(0x271B),
 		     MAC_TYPE(TH), RF_TYPE(JF1),
 		     BW_LIMITED, CORES(BT), NO_CDB),
 
-	IWL_DEV_INFO(iwl9260_2ac_cfg, iwl9260_160_name, DEVICE(0x2526),
+	IWL_DEV_INFO(iwl9000_2ac_cfg, iwl9260_160_name, DEVICE(0x2526),
 		     MAC_TYPE(TH), RF_TYPE(JF2),
 		     BW_NOT_LIMITED, CORES(BT), NO_CDB),
-	IWL_DEV_INFO(iwl9260_2ac_cfg_80mhz, iwl9260_name, DEVICE(0x2526),
+	IWL_DEV_INFO(iwl9000_2ac_cfg_80mhz, iwl9260_name, DEVICE(0x2526),
 		     MAC_TYPE(TH), RF_TYPE(JF2),
 		     BW_LIMITED, CORES(BT), NO_CDB),
 
-- 
2.34.1


