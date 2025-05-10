Return-Path: <linux-wireless+bounces-22819-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29668AB2509
	for <lists+linux-wireless@lfdr.de>; Sat, 10 May 2025 20:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C023AA015E8
	for <lists+linux-wireless@lfdr.de>; Sat, 10 May 2025 18:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808DF283FCA;
	Sat, 10 May 2025 18:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H/5mRVJ0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FE0283FD8
	for <linux-wireless@vger.kernel.org>; Sat, 10 May 2025 18:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746902931; cv=none; b=OPOS2f+lajD7HhaUWVw0yYxJl2wG39lbEvsYRJWOkYr2TyIInl+g4xmiX/8pcEr0LnRBPSd1zZPh6ytwTQ7PHvVKL3ZCaA29HMig1+7YjHQ6HwO0gKaRQX+Y+BD3YO8BJ+T8aeybOK/7h/V89dlALcUDS1H85umenDugW42bU/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746902931; c=relaxed/simple;
	bh=p38WilwcnjagFngYwkw0rPvsBPU4RNmSBV9NFW0B1pU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Pir0xTIhpVc8d3R3iOSQ0oF4y184xkri2rT3tKkZ4TB4LTAKSFz9voCNiA/h/Kq7cr/zdqsZIvXYDAfXU3jfbr1lfB+OaKJVUpnE/gQRGGvrSenxEk0gxzoFphUh8f0+cls1FSaCQmskFwe/BrCBZvxPjGC3cOFTTVh8aU7KAms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H/5mRVJ0; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746902930; x=1778438930;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p38WilwcnjagFngYwkw0rPvsBPU4RNmSBV9NFW0B1pU=;
  b=H/5mRVJ0WOm2xD6kRAXGFhM8oLsB/eBKtwIzOFlmwJN4EVTQEzaq0Lla
   ALDprLlyAXVntBpMNM76kip142XgfYlXPkY/NRBeflXPjgLtaHCvugeuU
   mGGKXe+923kWNIcUflAJ3n67pfJnP3VVlK7vGhZmXzAFW5ZbGuWbHWUTy
   bTNt4fEtQq5t2B1+eYsniluHZtS96RGfIJ6Y2J8o3mQsI2rC4SBOi40ET
   kqCSvtfaONunb4jPFf7TFAwWlhxDTCz42wJzfsKg6IA7Sq9uQ7+T1IXcN
   o8FIw16VKBzQZckiDMbRR24mNC1NoX4YXvjb7+KHZSUk/TvIsaxZP3y+Q
   w==;
X-CSE-ConnectionGUID: ry4Hu+ExQWym+Pa7Tg/VfA==
X-CSE-MsgGUID: QFVwHxd/TNGQhkpG2WCtdw==
X-IronPort-AV: E=McAfee;i="6700,10204,11429"; a="48880883"
X-IronPort-AV: E=Sophos;i="6.15,278,1739865600"; 
   d="scan'208";a="48880883"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2025 11:48:50 -0700
X-CSE-ConnectionGUID: CrCsM/DwT22jvamAwihCng==
X-CSE-MsgGUID: p94kQ7eOS5+AVoFLS81+Yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,278,1739865600"; 
   d="scan'208";a="142033427"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2025 11:48:49 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 06/15] wifi: iwlwifi: cfg: fix and unify Killer/JF configs
Date: Sat, 10 May 2025 21:48:18 +0300
Message-Id: <20250510214621.a93788f159ec.I114f09a0f61849ac3b75d12d7def35be842e5b7c@changeid>
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

All of these should be 160 MHz, and they can be recognised
by just the subdevice ID. Unify all the Killer/JF entries.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/9000.c |  6 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 58 ++-----------------
 2 files changed, 7 insertions(+), 57 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/9000.c b/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
index 7bfe497bebb7..816cf72e32e7 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
@@ -115,14 +115,10 @@ const char iwl9462_160_name[] = "Intel(R) Wireless-AC 9462 160MHz";
 const char iwl9560_160_name[] = "Intel(R) Wireless-AC 9560 160MHz";
 
 const char iwl9260_killer_1550_name[] =
-	"Killer (R) Wireless-AC 1550 Wireless Network Adapter (9260NGW) 160MHz";
+	"Killer(R) Wireless-AC 1550 Wireless Network Adapter (9260NGW) 160MHz";
 const char iwl9560_killer_1550i_name[] =
-	"Killer (R) Wireless-AC 1550i Wireless Network Adapter (9560NGW)";
-const char iwl9560_killer_1550i_160_name[] =
 	"Killer(R) Wireless-AC 1550i Wireless Network Adapter (9560NGW) 160MHz";
 const char iwl9560_killer_1550s_name[] =
-	"Killer (R) Wireless-AC 1550s Wireless Network Adapter (9560NGW)";
-const char iwl9560_killer_1550s_160_name[] =
 	"Killer(R) Wireless-AC 1550s Wireless Network Adapter (9560D2W) 160MHz";
 
 MODULE_FIRMWARE(IWL9000_MODULE_FIRMWARE(IWL9000_UCODE_API_MAX));
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 51c9a871d1da..8d4aee2f7ce0 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -943,33 +943,12 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 		     DEVICE(0x24FD), SUBDEV(0x1012)),
 	IWL_DEV_INFO(iwl8265_cfg, iwl8275_2ac_name,
 		     DEVICE(0x24FD), SUBDEV(0x0012)),
-/* 9000 */
-	IWL_DEV_INFO(iwl_rf_jf, iwl9260_killer_1550_name,
-		     DEVICE(0x2526), SUBDEV(0x1550)),
-	IWL_DEV_INFO(iwl_rf_jf, iwl9560_killer_1550s_name,
-		     DEVICE(0x2526), SUBDEV(0x1551)),
-	IWL_DEV_INFO(iwl_rf_jf, iwl9560_killer_1550i_name,
-		     DEVICE(0x2526), SUBDEV(0x1552)),
-	IWL_DEV_INFO(iwl_rf_jf, iwl9560_killer_1550s_name,
-		     DEVICE(0x30DC), SUBDEV(0x1551)),
-	IWL_DEV_INFO(iwl_rf_jf, iwl9560_killer_1550i_name,
-		     DEVICE(0x30DC), SUBDEV(0x1552)),
-	IWL_DEV_INFO(iwl_rf_jf, iwl9560_killer_1550s_name,
-		     DEVICE(0x31DC), SUBDEV(0x1551)),
-	IWL_DEV_INFO(iwl_rf_jf, iwl9560_killer_1550i_name,
-		     DEVICE(0x31DC), SUBDEV(0x1552)),
-	IWL_DEV_INFO(iwl_rf_jf, iwl9560_killer_1550s_name,
-		     DEVICE(0xA370), SUBDEV(0x1551)),
-	IWL_DEV_INFO(iwl_rf_jf, iwl9560_killer_1550i_name,
-		     DEVICE(0xA370), SUBDEV(0x1552)),
-	IWL_DEV_INFO(iwl_rf_jf, iwl9560_killer_1550s_160_name,
-		     DEVICE(0x54F0), SUBDEV(0x1551)),
-	IWL_DEV_INFO(iwl_rf_jf, iwl9560_killer_1550i_name,
-		     DEVICE(0x54F0), SUBDEV(0x1552)),
-	IWL_DEV_INFO(iwl_rf_jf, iwl9560_killer_1550s_160_name,
-		     DEVICE(0x51F0), SUBDEV(0x1552)),
-	IWL_DEV_INFO(iwl_rf_jf, iwl9560_killer_1550i_160_name,
-		     DEVICE(0x51F0), SUBDEV(0x1551)),
+
+/* Killer CRFs */
+	IWL_DEV_INFO(iwl_rf_jf, iwl9260_killer_1550_name, SUBDEV(0x1550)),
+	IWL_DEV_INFO(iwl_rf_jf, iwl9560_killer_1550s_name, SUBDEV(0x1551)),
+	IWL_DEV_INFO(iwl_rf_jf, iwl9560_killer_1550i_name, SUBDEV(0x1552)),
+
 	IWL_DEV_INFO(iwl_rf_gf, iwl_ax411_killer_1690s_name,
 		     DEVICE(0x51F0), SUBDEV(0x1691)),
 	IWL_DEV_INFO(iwl_rf_gf, iwl_ax411_killer_1690i_name,
@@ -1192,16 +1171,6 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 	IWL_DEV_INFO(iwl_rf_gf, iwl_ax211_name,
 		     DEVICE(0x7AF0), SUBDEV(0x0A10)),
 
-	/* So with JF */
-	IWL_DEV_INFO(iwl_rf_jf, iwl9560_killer_1550s_160_name,
-		     DEVICE(0x7A70), SUBDEV(0x1551)),
-	IWL_DEV_INFO(iwl_rf_jf, iwl9560_killer_1550i_160_name,
-		     DEVICE(0x7A70), SUBDEV(0x1552)),
-	IWL_DEV_INFO(iwl_rf_jf, iwl9560_killer_1550s_160_name,
-		     DEVICE(0x7AF0), SUBDEV(0x1551)),
-	IWL_DEV_INFO(iwl_rf_jf, iwl9560_killer_1550i_160_name,
-		     DEVICE(0x7AF0), SUBDEV(0x1552)),
-
 	/* SO with GF2 */
 	IWL_DEV_INFO(iwl_rf_gf, iwl_ax211_killer_1675s_name,
 		     DEVICE(0x51F0), SUBDEV(0x1671)),
@@ -1301,11 +1270,6 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 		     RF_TYPE(JF2), RF_ID(JF),
 		     BW_LIMITED, CORES(BT), NO_CDB),
 
-	IWL_DEV_INFO(iwl_rf_jf_80mhz, iwl9560_killer_1550s_name,
-		     SUBDEV(0x1551), MAC_TYPE(QU), MAC_STEP(B), RF_TYPE(JF2)),
-	IWL_DEV_INFO(iwl_rf_jf_80mhz, iwl9560_killer_1550i_name,
-		     SUBDEV(0x1552), MAC_TYPE(QU), MAC_STEP(B), RF_TYPE(JF2)),
-
 	/* Qu C step */
 	IWL_DEV_INFO(iwl_rf_jf, iwl9461_160_name,
 		     MAC_TYPE(QU), MAC_STEP(C),
@@ -1330,11 +1294,6 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 		     MAC_STEP(C), RF_TYPE(JF2), RF_ID(JF), BW_LIMITED, CORES(BT),
 		     NO_CDB),
 
-	IWL_DEV_INFO(iwl_rf_jf, iwl9560_killer_1550s_name,
-		     SUBDEV(0x1551), MAC_TYPE(QU), MAC_STEP(C), RF_TYPE(JF2)),
-	IWL_DEV_INFO(iwl_rf_jf_80mhz, iwl9560_killer_1550i_name,
-		     SUBDEV(0x1552), MAC_TYPE(QU), MAC_STEP(C), RF_TYPE(JF2)),
-
 	/* QuZ */
 	IWL_DEV_INFO(iwl_rf_jf, iwl9461_160_name, MAC_TYPE(QUZ),
 		     RF_TYPE(JF1), RF_ID(JF1), BW_NOT_LIMITED, CORES(BT), NO_CDB),
@@ -1350,11 +1309,6 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 	IWL_DEV_INFO(iwl_rf_jf_80mhz, iwl9560_name, MAC_TYPE(QUZ),
 		     RF_TYPE(JF2), RF_ID(JF), BW_LIMITED, CORES(BT), NO_CDB),
 
-	IWL_DEV_INFO(iwl_rf_jf, iwl9560_killer_1550s_name,
-		     SUBDEV(0x1551), MAC_TYPE(QUZ), RF_TYPE(JF2)),
-	IWL_DEV_INFO(iwl_rf_jf_80mhz, iwl9560_killer_1550i_name,
-		     SUBDEV(0x1552), MAC_TYPE(QUZ), RF_TYPE(JF2)),
-
 /* Qu with Hr */
 	/* Qu B step */
 	IWL_DEV_INFO(iwl_rf_hr1, iwl_ax101_name, MAC_TYPE(QU),
-- 
2.34.1


