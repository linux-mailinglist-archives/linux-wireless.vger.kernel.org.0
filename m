Return-Path: <linux-wireless+bounces-22820-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D526AB250A
	for <lists+linux-wireless@lfdr.de>; Sat, 10 May 2025 20:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61DCA7A8F71
	for <lists+linux-wireless@lfdr.de>; Sat, 10 May 2025 18:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D79928136E;
	Sat, 10 May 2025 18:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nJ4KYicW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2759D280318
	for <linux-wireless@vger.kernel.org>; Sat, 10 May 2025 18:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746902933; cv=none; b=KtrX9S0hHFEViJPOlDS6jpQsdEJukGPy2sw0aWugri9vsq4Z18sxHz9TILqiWeY9mFqbtKMvw0EtYZH+wa0yQsGrU+HYLEsUOoh8UbLuipXRNMj4Bdv5Hz1+tzibXOoib8dYvUnNX+FqowXd3sfFc3lDlGM0JmdjoZnB0JE5OxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746902933; c=relaxed/simple;
	bh=22gKAnVVQxkHoHip+kMe12mG/T9ezwOrWU6JqVe06ZQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UVUpxtqSPusl0G0IsKUOyXgTVGDZRq2zCS8HWPfsppbElRsbe9/d8tEBaJVAxaRWllSUUBt+MQY34OLDxcftvuXb6XKYFuzb954SYbu714LKUUWUZ6BQn+yDTpqfHQq0r8fSsUfn9+3iJEKMv/CAaDra7VlnhGLMw9TsDAiiXQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nJ4KYicW; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746902932; x=1778438932;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=22gKAnVVQxkHoHip+kMe12mG/T9ezwOrWU6JqVe06ZQ=;
  b=nJ4KYicW4K6cmab9FNE7/q4iEUTJ16xyhvxZQGIDa1JZE/HUjDw99l+j
   y8kVi4NjQxkmFWw0DL6bQDGAtmvRJdFs/b6IrgHD9PxheCl/DQLMn82cM
   S1KBCC7IaP7QnnShxMQiLM9EjxlNtIYh9OZPIsVfRjamQCFiUaWGwv8IM
   N4HWXMP3e3XCwWWXblj5D9B4NkgjTeCycK6eXY11jeIhFwHG16TfRQPAs
   B2cdFQIF4GvdR+J6WHlJYYGbU6EZlRk1Xv5gZeqapSKPhAwlxOxnv+8PA
   ivG7izh8J4JBOUW7QqrzpC2QYv7c2hnb9avTr91oYtgA9em0bu/tXwArh
   w==;
X-CSE-ConnectionGUID: xTgiTybdS8qhvEqMo1Vzvw==
X-CSE-MsgGUID: RKafI8SlSF+nVaLwl0NUpA==
X-IronPort-AV: E=McAfee;i="6700,10204,11429"; a="48880884"
X-IronPort-AV: E=Sophos;i="6.15,278,1739865600"; 
   d="scan'208";a="48880884"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2025 11:48:51 -0700
X-CSE-ConnectionGUID: V7DW38UXTr6suY0W8YTFhQ==
X-CSE-MsgGUID: Ux7jkvtWSEqS0zI8n1aglA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,278,1739865600"; 
   d="scan'208";a="142033430"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2025 11:48:50 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 07/15] wifi: iwlwifi: cfg: unify and add some Killer devices
Date: Sat, 10 May 2025 21:48:19 +0300
Message-Id: <20250510214621.a16b1c2740f8.I147b97ef2c8e99451806ea0e34a9eb5bff37c326@changeid>
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

Unify a number of Killer devices now that we no longer
need to distinguish the MAC type, and add a few more
that wouldn't have gotten the right name before.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/cfg/rf-fm.c    |   9 ++
 .../net/wireless/intel/iwlwifi/iwl-config.h   |   4 +
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 122 +++++-------------
 3 files changed, 43 insertions(+), 92 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/rf-fm.c b/drivers/net/wireless/intel/iwlwifi/cfg/rf-fm.c
index dfd075bb0865..2d0cad9c5f2c 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/rf-fm.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/rf-fm.c
@@ -31,3 +31,12 @@ const struct iwl_rf_cfg iwl_rf_fm_160mhz = {
 	IWL_DEVICE_FM,
 	.bw_limit = 160,
 };
+
+const char iwl_killer_be1750s_name[] =
+	"Killer(R) Wi-Fi 7 BE1750s 320MHz Wireless Network Adapter (BE201D2W)";
+const char iwl_killer_be1750i_name[] =
+	"Killer(R) Wi-Fi 7 BE1750i 320MHz Wireless Network Adapter (BE201NGW)";
+const char iwl_killer_be1750w_name[] =
+	"Killer(TM) Wi-Fi 7 BE1750w 320MHz Wireless Network Adapter (BE200D2W)";
+const char iwl_killer_be1750x_name[] =
+	"Killer(TM) Wi-Fi 7 BE1750x 320MHz Wireless Network Adapter (BE200NGW)";
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 719986ccf316..69cbe138bad2 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -642,6 +642,10 @@ extern const char iwl_gl_name[];
 extern const char iwl_mtp_name[];
 extern const char iwl_dr_name[];
 extern const char iwl_br_name[];
+extern const char iwl_killer_be1750s_name[];
+extern const char iwl_killer_be1750i_name[];
+extern const char iwl_killer_be1750w_name[];
+extern const char iwl_killer_be1750x_name[];
 #if IS_ENABLED(CONFIG_IWLDVM)
 extern const struct iwl_rf_cfg iwl5300_agn_cfg;
 extern const struct iwl_rf_cfg iwl5350_agn_cfg;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 8d4aee2f7ce0..b41b8aa75739 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -944,45 +944,37 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 	IWL_DEV_INFO(iwl8265_cfg, iwl8275_2ac_name,
 		     DEVICE(0x24FD), SUBDEV(0x0012)),
 
+/* HR RF */
+	/* FIXME - should have some RF match */
+	IWL_DEV_INFO(iwl_rf_hr, iwl_ax200_name, DEVICE(0x2723)),
+
 /* Killer CRFs */
 	IWL_DEV_INFO(iwl_rf_jf, iwl9260_killer_1550_name, SUBDEV(0x1550)),
 	IWL_DEV_INFO(iwl_rf_jf, iwl9560_killer_1550s_name, SUBDEV(0x1551)),
 	IWL_DEV_INFO(iwl_rf_jf, iwl9560_killer_1550i_name, SUBDEV(0x1552)),
 
-	IWL_DEV_INFO(iwl_rf_gf, iwl_ax411_killer_1690s_name,
-		     DEVICE(0x51F0), SUBDEV(0x1691)),
-	IWL_DEV_INFO(iwl_rf_gf, iwl_ax411_killer_1690i_name,
-		     DEVICE(0x51F0), SUBDEV(0x1692)),
-	IWL_DEV_INFO(iwl_rf_gf, iwl_ax411_killer_1690i_name,
-		     DEVICE(0x51F1), SUBDEV(0x1692)),
-	IWL_DEV_INFO(iwl_rf_gf, iwl_ax411_killer_1690s_name,
-		     DEVICE(0x54F0), SUBDEV(0x1691)),
-	IWL_DEV_INFO(iwl_rf_gf, iwl_ax411_killer_1690i_name,
-		     DEVICE(0x54F0), SUBDEV(0x1692)),
-	IWL_DEV_INFO(iwl_rf_gf, iwl_ax411_killer_1690s_name,
-		     DEVICE(0x7A70), SUBDEV(0x1691)),
-	IWL_DEV_INFO(iwl_rf_gf, iwl_ax411_killer_1690i_name,
-		     DEVICE(0x7A70), SUBDEV(0x1692)),
-	IWL_DEV_INFO(iwl_rf_gf, iwl_ax411_killer_1690s_name,
-		     DEVICE(0x7AF0), SUBDEV(0x1691)),
-	IWL_DEV_INFO(iwl_rf_gf, iwl_ax411_killer_1690i_name,
-		     DEVICE(0x7AF0), SUBDEV(0x1692)),
+	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_killer_1650s_name, SUBDEV(0x1651)),
+	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_killer_1650i_name, SUBDEV(0x1652)),
 
-	IWL_DEV_INFO(iwl_rf_jf, iwl9260_1_name,
-		     DEVICE(0x271C), SUBDEV(0x0214)),
-	IWL_DEV_INFO(iwl_rf_gf, iwl_ax411_killer_1690s_name,
-		     DEVICE(0x7E40), SUBDEV(0x1691)),
-	IWL_DEV_INFO(iwl_rf_gf, iwl_ax411_killer_1690i_name,
-		     DEVICE(0x7E40), SUBDEV(0x1692)),
+	IWL_DEV_INFO(iwl_rf_gf, iwl_ax211_killer_1675s_name, SUBDEV(0x1671)),
+	IWL_DEV_INFO(iwl_rf_gf, iwl_ax211_killer_1675i_name, SUBDEV(0x1672)),
+	IWL_DEV_INFO(iwl_rf_gf, iwl_ax210_killer_1675w_name, SUBDEV(0x1673)),
+	IWL_DEV_INFO(iwl_rf_gf, iwl_ax210_killer_1675x_name, SUBDEV(0x1674)),
+	IWL_DEV_INFO(iwl_rf_gf, iwl_ax411_killer_1690s_name, SUBDEV(0x1691)),
+	IWL_DEV_INFO(iwl_rf_gf, iwl_ax411_killer_1690i_name, SUBDEV(0x1692)),
 
-/* AX200 */
-	IWL_DEV_INFO(iwl_rf_hr, iwl_ax200_name,
-		     DEVICE(0x2723)),
+/* Killer discrete */
 	IWL_DEV_INFO(iwl_rf_hr, iwl_ax200_killer_1650w_name,
 		     DEVICE(0x2723), SUBDEV(0x1653)),
 	IWL_DEV_INFO(iwl_rf_hr, iwl_ax200_killer_1650x_name,
 		     DEVICE(0x2723), SUBDEV(0x1654)),
 
+/* JF RF */
+	IWL_DEV_INFO(iwl_rf_jf, iwl9260_1_name,
+		     DEVICE(0x271C), SUBDEV(0x0214)),
+
+/* AX200 */
+
 	/* Qu with Hr */
 	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
 		     DEVICE(0x43F0), SUBDEV(0x0070)),
@@ -992,10 +984,6 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 		     DEVICE(0x43F0), SUBDEV(0x0078)),
 	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
 		     DEVICE(0x43F0), SUBDEV(0x007C)),
-	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_killer_1650s_name,
-		     DEVICE(0x43F0), SUBDEV(0x1651)),
-	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_killer_1650i_name,
-		     DEVICE(0x43F0), SUBDEV(0x1652)),
 	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
 		     DEVICE(0x43F0), SUBDEV(0x2074)),
 	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
@@ -1010,10 +998,6 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 		     DEVICE(0xA0F0), SUBDEV(0x007C)),
 	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
 		     DEVICE(0xA0F0), SUBDEV(0x0A10)),
-	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_killer_1650s_name,
-		     DEVICE(0xA0F0), SUBDEV(0x1651)),
-	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_killer_1650i_name,
-		     DEVICE(0xA0F0), SUBDEV(0x1652)),
 	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
 		     DEVICE(0xA0F0), SUBDEV(0x2074)),
 	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
@@ -1032,10 +1016,6 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 		     DEVICE(0x02F0), SUBDEV(0x007C)),
 	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
 		     DEVICE(0x02F0), SUBDEV(0x0310)),
-	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_killer_1650s_name,
-		     DEVICE(0x02F0), SUBDEV(0x1651)),
-	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_killer_1650i_name,
-		     DEVICE(0x02F0), SUBDEV(0x1652)),
 	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
 		     DEVICE(0x02F0), SUBDEV(0x2074)),
 	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
@@ -1050,10 +1030,6 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 		     DEVICE(0x06F0), SUBDEV(0x007C)),
 	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
 		     DEVICE(0x06F0), SUBDEV(0x0310)),
-	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_killer_1650s_name,
-		     DEVICE(0x06F0), SUBDEV(0x1651)),
-	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_killer_1650i_name,
-		     DEVICE(0x06F0), SUBDEV(0x1652)),
 	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
 		     DEVICE(0x06F0), SUBDEV(0x2074)),
 	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
@@ -1068,10 +1044,6 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 		     DEVICE(0x34F0), SUBDEV(0x007C)),
 	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
 		     DEVICE(0x34F0), SUBDEV(0x0310)),
-	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_killer_1650s_name,
-		     DEVICE(0x34F0), SUBDEV(0x1651)),
-	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_killer_1650i_name,
-		     DEVICE(0x34F0), SUBDEV(0x1652)),
 	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
 		     DEVICE(0x34F0), SUBDEV(0x2074)),
 	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
@@ -1087,10 +1059,6 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 		     DEVICE(0x3DF0), SUBDEV(0x007C)),
 	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
 		     DEVICE(0x3DF0), SUBDEV(0x0310)),
-	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_killer_1650s_name,
-		     DEVICE(0x3DF0), SUBDEV(0x1651)),
-	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_killer_1650i_name,
-		     DEVICE(0x3DF0), SUBDEV(0x1652)),
 	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
 		     DEVICE(0x3DF0), SUBDEV(0x2074)),
 	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
@@ -1106,10 +1074,6 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 		     DEVICE(0x4DF0), SUBDEV(0x007C)),
 	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
 		     DEVICE(0x4DF0), SUBDEV(0x0310)),
-	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_killer_1650s_name,
-		     DEVICE(0x4DF0), SUBDEV(0x1651)),
-	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_killer_1650i_name,
-		     DEVICE(0x4DF0), SUBDEV(0x1652)),
 	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
 		     DEVICE(0x4DF0), SUBDEV(0x2074)),
 	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
@@ -1142,10 +1106,6 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 		     DEVICE(0x2725), SUBDEV(0x6020)),
 	IWL_DEV_INFO(iwl_rf_gf, iwl_ax210_name,
 		     DEVICE(0x2725), SUBDEV(0x6024)),
-	IWL_DEV_INFO(iwl_rf_gf, iwl_ax210_killer_1675w_name,
-		     DEVICE(0x2725), SUBDEV(0x1673)),
-	IWL_DEV_INFO(iwl_rf_gf, iwl_ax210_killer_1675x_name,
-		     DEVICE(0x2725), SUBDEV(0x1674)),
 	IWL_DEV_INFO(iwl_rf_gf, iwl_ax211_name,
 		     DEVICE(0x7A70), SUBDEV(0x0090)),
 	IWL_DEV_INFO(iwl_rf_gf, iwl_ax211_name,
@@ -1171,37 +1131,7 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 	IWL_DEV_INFO(iwl_rf_gf, iwl_ax211_name,
 		     DEVICE(0x7AF0), SUBDEV(0x0A10)),
 
-	/* SO with GF2 */
-	IWL_DEV_INFO(iwl_rf_gf, iwl_ax211_killer_1675s_name,
-		     DEVICE(0x51F0), SUBDEV(0x1671)),
-	IWL_DEV_INFO(iwl_rf_gf, iwl_ax211_killer_1675i_name,
-		     DEVICE(0x51F0), SUBDEV(0x1672)),
-	IWL_DEV_INFO(iwl_rf_gf, iwl_ax211_killer_1675s_name,
-		     DEVICE(0x51F1), SUBDEV(0x1671)),
-	IWL_DEV_INFO(iwl_rf_gf, iwl_ax211_killer_1675i_name,
-		     DEVICE(0x51F1), SUBDEV(0x1672)),
-	IWL_DEV_INFO(iwl_rf_gf, iwl_ax211_killer_1675s_name,
-		     DEVICE(0x54F0), SUBDEV(0x1671)),
-	IWL_DEV_INFO(iwl_rf_gf, iwl_ax211_killer_1675i_name,
-		     DEVICE(0x54F0), SUBDEV(0x1672)),
-	IWL_DEV_INFO(iwl_rf_gf, iwl_ax211_killer_1675s_name,
-		     DEVICE(0x7A70), SUBDEV(0x1671)),
-	IWL_DEV_INFO(iwl_rf_gf, iwl_ax211_killer_1675i_name,
-		     DEVICE(0x7A70), SUBDEV(0x1672)),
-	IWL_DEV_INFO(iwl_rf_gf, iwl_ax211_killer_1675s_name,
-		     DEVICE(0x7AF0), SUBDEV(0x1671)),
-	IWL_DEV_INFO(iwl_rf_gf, iwl_ax211_killer_1675i_name,
-		     DEVICE(0x7AF0), SUBDEV(0x1672)),
-	IWL_DEV_INFO(iwl_rf_gf, iwl_ax211_killer_1675s_name,
-		     DEVICE(0x7F70), SUBDEV(0x1671)),
-	IWL_DEV_INFO(iwl_rf_gf, iwl_ax211_killer_1675i_name,
-		     DEVICE(0x7F70), SUBDEV(0x1672)),
-
 	/* MA with GF2 */
-	IWL_DEV_INFO(iwl_rf_gf, iwl_ax211_killer_1675s_name,
-		     DEVICE(0x7E40), SUBDEV(0x1671)),
-	IWL_DEV_INFO(iwl_rf_gf, iwl_ax211_killer_1675i_name,
-		     DEVICE(0x7E40), SUBDEV(0x1672)),
 
 	IWL_DEV_INFO(iwl_rf_jf, iwl9461_160_name, MAC_TYPE(PU),
 		     RF_TYPE(JF1), RF_ID(JF1),
@@ -1344,9 +1274,6 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 		     RF_TYPE(HR1), BW_LIMITED, NO_CDB),
 	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name, MAC_TYPE(SO),
 		     RF_TYPE(HR2), BW_NOT_LIMITED, NO_CDB),
-	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_killer_1650i_name,
-		     DEVICE(0x51f0), SUBDEV(0x1652),
-		     MAC_TYPE(SO), RF_TYPE(HR2)),
 
 /* So-F with Hr */
 	IWL_DEV_INFO(iwl_rf_hr_80mhz, iwl_ax203_name, MAC_TYPE(SOF),
@@ -1404,6 +1331,17 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 #if IS_ENABLED(CONFIG_IWLMLD)
 	IWL_DEV_INFO(iwl_rf_fm, iwl_ax231_name, MAC_TYPE(MA), RF_TYPE(FM),
 		     NO_CDB),
+
+/* Killer CRFs */
+	IWL_DEV_INFO(iwl_rf_fm, iwl_killer_be1750s_name, SUBDEV(0x1771)),
+	IWL_DEV_INFO(iwl_rf_fm, iwl_killer_be1750i_name, SUBDEV(0x1772)),
+
+/* Killer discrete */
+	IWL_DEV_INFO(iwl_rf_fm, iwl_killer_be1750w_name,
+		     DEVICE(0x272B), SUBDEV(0x1773)),
+	IWL_DEV_INFO(iwl_rf_fm, iwl_killer_be1750x_name,
+		     DEVICE(0x272B), SUBDEV(0x1774)),
+
 /* Bz */
 	IWL_DEV_INFO(iwl_rf_fm, iwl_ax201_name, MAC_TYPE(BZ), RF_TYPE(HR2)),
 
-- 
2.34.1


