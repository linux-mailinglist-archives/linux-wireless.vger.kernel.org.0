Return-Path: <linux-wireless+bounces-22354-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A78AA72BA
	for <lists+linux-wireless@lfdr.de>; Fri,  2 May 2025 14:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5813B7A978A
	for <lists+linux-wireless@lfdr.de>; Fri,  2 May 2025 12:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C69253B7C;
	Fri,  2 May 2025 12:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RIGYJP4S"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C54623C516
	for <linux-wireless@vger.kernel.org>; Fri,  2 May 2025 12:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746190627; cv=none; b=TL21AgLpstNXaamSXpYb3HWOnX6pRB3Baf27jH1njObAjlRVAP8P7RbLdgKU5RuWXHoNCNDZ0HSkt5or4g9SHLbJOD/SZvkCRsVkNIQVADbwsLng8UN1swwA0TmVeJ2UX4D0XviwuZ3oS/e4ohNHp4ssf3dvPJdtx9JCWLiglPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746190627; c=relaxed/simple;
	bh=6nyqyOE6tvVxangPrk4TDrJ0nICwrws93hRyEKLxNag=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qWzpoJmbCYG27I1wDqerQkDhuNUixM5Sgxxfb6Tvey6qnw1os3xRF/gA9zAoGnKaVqLGGK1DA6zMaBKiYtwycICnmmaDGV3EEwAHWkel8FBMf5yYWIb32lngnLzrUP14pOedEuaoAg/HG+2cHiaLuJHNEMb139ftIFV99zuvCZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RIGYJP4S; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746190625; x=1777726625;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6nyqyOE6tvVxangPrk4TDrJ0nICwrws93hRyEKLxNag=;
  b=RIGYJP4SMxUnVuALEHYjc5SIjswL3RVJQLi/GUYBGn3+uLO4xbwMowIy
   MBQfmUjYcDdHtitwvb1gN7smyGkx640/FYn+uUqNKCLyizuWuBZYHhrP3
   1Ml7VTzowkA04HjGBcQ+K3aKjMwE/rfYJdqEQUZnDmcRaxScKtUYoR7fB
   J8ZS76YmMlKNVjbf9OjRr/RYfbbe85b/KRbp7zq9/ETLvCaFY5JUP9PZc
   naHl9YLpmTrhQtbTpDljrO8PBPL1m+Vtg/dCAgjDFjJVVExi8DlrasYJX
   3NlPAcZ6xc+p+wwqgxnVpK9NOT2PVGcmYeLWOY23+TJZm0bUEc7H21bT2
   w==;
X-CSE-ConnectionGUID: Lj+0kd4pTb65B+SphAsO/g==
X-CSE-MsgGUID: zBleyPzSSKq2P+gBVFPf3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11421"; a="59255563"
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="59255563"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 05:57:05 -0700
X-CSE-ConnectionGUID: /9WQiVz3TQunqyKpbBAIZA==
X-CSE-MsgGUID: /J1afgFGTQCyfmRo2hkqig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="165554752"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 05:57:03 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 12/15] wifi: iwlwifi: cfg: remove unnecessary configs
Date: Fri,  2 May 2025 15:56:28 +0300
Message-Id: <20250502155404.689f9b335cbe.I66f1344b6ac7aa3665696637c97fa843c2307423@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250502125631.3184319-1-miriam.rachel.korenblit@intel.com>
References: <20250502125631.3184319-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Since there are two bytes hole in struct iwl_dev_info, add
a subdev_mask to match with. Also, since the PCI IDs list
needs to match first, and the dev-info list is matched from
the bottom up, remove unnecessary entries.

With this, even though there are new entries from previous
changes, the overall size is slightly reduced.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/iwl-config.h   |   1 +
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 669 +++---------------
 2 files changed, 111 insertions(+), 559 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 4b43f561bd12..fe701410a44f 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -459,6 +459,7 @@ struct iwl_cfg {
 struct iwl_dev_info {
 	u16 device;
 	u16 subdevice;
+	u16 subdevice_mask;
 	u16 rf_type;
 	u8 mac_type;
 	u8 bw_limit;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 449ed4b02a5f..6bb7de8c43fe 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -554,6 +554,7 @@ EXPORT_SYMBOL_IF_IWLWIFI_KUNIT(iwl_hw_card_ids);
 	.name = _name,				\
 	.device = IWL_CFG_ANY,			\
 	.subdevice = IWL_CFG_ANY,		\
+	.subdevice_mask = ~0,			\
 	.mac_type = IWL_CFG_ANY,		\
 	.mac_step = IWL_CFG_ANY,		\
 	.rf_type = IWL_CFG_ANY,			\
@@ -570,6 +571,9 @@ EXPORT_SYMBOL_IF_IWLWIFI_KUNIT(iwl_hw_card_ids);
 
 #define DEVICE(n)	.device = (n)
 #define SUBDEV(n)	.subdevice = (n)
+#define SUBDEV_MASKED(v, m)			\
+			.subdevice = (v),	\
+			.subdevice_mask = (m)
 #define MAC_TYPE(n)	.mac_type = IWL_CFG_MAC_TYPE_##n
 #define MAC_STEP(n)	.mac_step = SILICON_##n##_STEP
 #define RF_TYPE(n)	.rf_type = IWL_CFG_RF_TYPE_##n
@@ -584,132 +588,60 @@ EXPORT_SYMBOL_IF_IWLWIFI_KUNIT(iwl_hw_card_ids);
 VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 #if IS_ENABLED(CONFIG_IWLDVM)
 	IWL_DEV_INFO(iwl5100_n_cfg, iwl5100_agn_name,
-		     DEVICE(0x4232), SUBDEV(0x1201)), /* Mini Card */
+		     DEVICE(0x4232), SUBDEV_MASKED(0x1, 0xF)),
 	IWL_DEV_INFO(iwl5100_n_cfg, iwl5100_agn_name,
-		     DEVICE(0x4232), SUBDEV(0x1301)), /* Half Mini Card */
-	IWL_DEV_INFO(iwl5100_n_cfg, iwl5100_agn_name,
-		     DEVICE(0x4232), SUBDEV(0x1204)), /* Mini Card */
-	IWL_DEV_INFO(iwl5100_n_cfg, iwl5100_agn_name,
-		     DEVICE(0x4232), SUBDEV(0x1304)), /* Half Mini Card */
-	IWL_DEV_INFO(iwl5100_n_cfg, iwl5100_bgn_name,
-		     DEVICE(0x4232), SUBDEV(0x1205)), /* Mini Card */
+		     DEVICE(0x4232), SUBDEV_MASKED(0x4, 0xF)),
 	IWL_DEV_INFO(iwl5100_n_cfg, iwl5100_bgn_name,
-		     DEVICE(0x4232), SUBDEV(0x1305)), /* Half Mini Card */
+		     DEVICE(0x4232), SUBDEV_MASKED(0x5, 0xF)),
 	IWL_DEV_INFO(iwl5100_abg_cfg, iwl5100_abg_name,
-		     DEVICE(0x4232), SUBDEV(0x1206)), /* Mini Card */
-	IWL_DEV_INFO(iwl5100_abg_cfg, iwl5100_abg_name,
-		     DEVICE(0x4232), SUBDEV(0x1306)), /* Half Mini Card */
-	IWL_DEV_INFO(iwl5100_n_cfg, iwl5100_agn_name,
-		     DEVICE(0x4232), SUBDEV(0x1221)), /* Mini Card */
+		     DEVICE(0x4232), SUBDEV_MASKED(0x6, 0xF)),
 	IWL_DEV_INFO(iwl5100_n_cfg, iwl5100_agn_name,
-		     DEVICE(0x4232), SUBDEV(0x1321)), /* Half Mini Card */
+		     DEVICE(0x4237), SUBDEV_MASKED(0x1, 0xF)),
 	IWL_DEV_INFO(iwl5100_n_cfg, iwl5100_agn_name,
-		     DEVICE(0x4232), SUBDEV(0x1224)), /* Mini Card */
-	IWL_DEV_INFO(iwl5100_n_cfg, iwl5100_agn_name,
-		     DEVICE(0x4232), SUBDEV(0x1324)), /* Half Mini Card */
-	IWL_DEV_INFO(iwl5100_n_cfg, iwl5100_bgn_name,
-		     DEVICE(0x4232), SUBDEV(0x1225)), /* Mini Card */
+		     DEVICE(0x4237), SUBDEV_MASKED(0x4, 0xF)),
 	IWL_DEV_INFO(iwl5100_n_cfg, iwl5100_bgn_name,
-		     DEVICE(0x4232), SUBDEV(0x1325)), /* Half Mini Card */
-	IWL_DEV_INFO(iwl5100_abg_cfg, iwl5100_abg_name,
-		     DEVICE(0x4232), SUBDEV(0x1226)), /* Mini Card */
+		     DEVICE(0x4237), SUBDEV_MASKED(0x5, 0xF)),
 	IWL_DEV_INFO(iwl5100_abg_cfg, iwl5100_abg_name,
-		     DEVICE(0x4232), SUBDEV(0x1326)), /* Half Mini Card */
-	IWL_DEV_INFO(iwl5100_n_cfg, iwl5100_agn_name,
-		     DEVICE(0x4237), SUBDEV(0x1211)), /* Mini Card */
-	IWL_DEV_INFO(iwl5100_n_cfg, iwl5100_agn_name,
-		     DEVICE(0x4237), SUBDEV(0x1311)), /* Half Mini Card */
-	IWL_DEV_INFO(iwl5100_n_cfg, iwl5100_agn_name,
-		     DEVICE(0x4237), SUBDEV(0x1214)), /* Mini Card */
-	IWL_DEV_INFO(iwl5100_n_cfg, iwl5100_agn_name,
-		     DEVICE(0x4237), SUBDEV(0x1314)), /* Half Mini Card */
-	IWL_DEV_INFO(iwl5100_n_cfg, iwl5100_bgn_name,
-		     DEVICE(0x4237), SUBDEV(0x1215)), /* Mini Card */
-	IWL_DEV_INFO(iwl5100_n_cfg, iwl5100_bgn_name,
-		     DEVICE(0x4237), SUBDEV(0x1315)), /* Half Mini Card */
-	IWL_DEV_INFO(iwl5100_abg_cfg, iwl5100_abg_name,
-		     DEVICE(0x4237), SUBDEV(0x1216)), /* Mini Card */
-	IWL_DEV_INFO(iwl5100_abg_cfg, iwl5100_abg_name,
-		     DEVICE(0x4237), SUBDEV(0x1316)), /* Half Mini Card */
+		     DEVICE(0x4237), SUBDEV_MASKED(0x6, 0xF)),
 
 /* 5300 Series WiFi */
 	IWL_DEV_INFO(iwl5300_agn_cfg, iwl5300_agn_name,
-		     DEVICE(0x4235), SUBDEV(0x1021)), /* Mini Card */
-	IWL_DEV_INFO(iwl5300_agn_cfg, iwl5300_agn_name,
-		     DEVICE(0x4235), SUBDEV(0x1121)), /* Half Mini Card */
-	IWL_DEV_INFO(iwl5300_agn_cfg, iwl5300_agn_name,
-		     DEVICE(0x4235), SUBDEV(0x1024)), /* Mini Card */
-	IWL_DEV_INFO(iwl5300_agn_cfg, iwl5300_agn_name,
-		     DEVICE(0x4235), SUBDEV(0x1124)), /* Half Mini Card */
+		     DEVICE(0x4235), SUBDEV_MASKED(0x1, 0xF)),
 	IWL_DEV_INFO(iwl5300_agn_cfg, iwl5300_agn_name,
-		     DEVICE(0x4235), SUBDEV(0x1001)), /* Mini Card */
+		     DEVICE(0x4235), SUBDEV_MASKED(0x4, 0xF)),
 	IWL_DEV_INFO(iwl5300_agn_cfg, iwl5300_agn_name,
-		     DEVICE(0x4235), SUBDEV(0x1101)), /* Half Mini Card */
+		     DEVICE(0x4236), SUBDEV_MASKED(0x1, 0xF)),
 	IWL_DEV_INFO(iwl5300_agn_cfg, iwl5300_agn_name,
-		     DEVICE(0x4235), SUBDEV(0x1004)), /* Mini Card */
-	IWL_DEV_INFO(iwl5300_agn_cfg, iwl5300_agn_name,
-		     DEVICE(0x4235), SUBDEV(0x1104)), /* Half Mini Card */
-	IWL_DEV_INFO(iwl5300_agn_cfg, iwl5300_agn_name,
-		     DEVICE(0x4236), SUBDEV(0x1011)), /* Mini Card */
-	IWL_DEV_INFO(iwl5300_agn_cfg, iwl5300_agn_name,
-		     DEVICE(0x4236), SUBDEV(0x1111)), /* Half Mini Card */
-	IWL_DEV_INFO(iwl5300_agn_cfg, iwl5300_agn_name,
-		     DEVICE(0x4236), SUBDEV(0x1014)), /* Mini Card */
-	IWL_DEV_INFO(iwl5300_agn_cfg, iwl5300_agn_name,
-		     DEVICE(0x4236), SUBDEV(0x1114)), /* Half Mini Card */
+		     DEVICE(0x4236), SUBDEV_MASKED(0x4, 0xF)),
 
 /* 5350 Series WiFi/WiMax */
 	IWL_DEV_INFO(iwl5350_agn_cfg, iwl5350_agn_name,
-		     DEVICE(0x423A), SUBDEV(0x1001)), /* Mini Card */
+		     DEVICE(0x423A)),
 	IWL_DEV_INFO(iwl5350_agn_cfg, iwl5350_agn_name,
-		     DEVICE(0x423A), SUBDEV(0x1021)), /* Mini Card */
-	IWL_DEV_INFO(iwl5350_agn_cfg, iwl5350_agn_name,
-		     DEVICE(0x423B), SUBDEV(0x1011)), /* Mini Card */
+		     DEVICE(0x423B)),
 
 /* 5150 Series Wifi/WiMax */
 	IWL_DEV_INFO(iwl5150_agn_cfg, iwl5150_agn_name,
-		     DEVICE(0x423C), SUBDEV(0x1201)), /* Mini Card */
-	IWL_DEV_INFO(iwl5150_agn_cfg, iwl5150_agn_name,
-		     DEVICE(0x423C), SUBDEV(0x1301)), /* Half Mini Card */
-	IWL_DEV_INFO(iwl5150_abg_cfg, iwl5150_abg_name,
-		     DEVICE(0x423C), SUBDEV(0x1206)), /* Mini Card */
+		     DEVICE(0x423C), SUBDEV_MASKED(0x1, 0xF)),
 	IWL_DEV_INFO(iwl5150_abg_cfg, iwl5150_abg_name,
-		     DEVICE(0x423C), SUBDEV(0x1306)), /* Half Mini Card */
-	IWL_DEV_INFO(iwl5150_agn_cfg, iwl5150_agn_name,
-		     DEVICE(0x423C), SUBDEV(0x1221)), /* Mini Card */
-	IWL_DEV_INFO(iwl5150_agn_cfg, iwl5150_agn_name,
-		     DEVICE(0x423C), SUBDEV(0x1321)), /* Half Mini Card */
-	IWL_DEV_INFO(iwl5150_abg_cfg, iwl5150_abg_name,
-		     DEVICE(0x423C), SUBDEV(0x1326)), /* Half Mini Card */
+		     DEVICE(0x423C), SUBDEV_MASKED(0x6, 0xF)),
 
 	IWL_DEV_INFO(iwl5150_agn_cfg, iwl5150_agn_name,
-		     DEVICE(0x423D), SUBDEV(0x1211)), /* Mini Card */
-	IWL_DEV_INFO(iwl5150_agn_cfg, iwl5150_agn_name,
-		     DEVICE(0x423D), SUBDEV(0x1311)), /* Half Mini Card */
-	IWL_DEV_INFO(iwl5150_abg_cfg, iwl5150_abg_name,
-		     DEVICE(0x423D), SUBDEV(0x1216)), /* Mini Card */
+		     DEVICE(0x423D), SUBDEV_MASKED(0x1, 0xF)),
 	IWL_DEV_INFO(iwl5150_abg_cfg, iwl5150_abg_name,
-		     DEVICE(0x423D), SUBDEV(0x1316)), /* Half Mini Card */
+		     DEVICE(0x423D), SUBDEV_MASKED(0x6, 0xF)),
 
 /* 6x00 Series */
 	IWL_DEV_INFO(iwl6000_3agn_cfg, iwl6000_3agn_name,
-		     DEVICE(0x422B), SUBDEV(0x1101)),
-	IWL_DEV_INFO(iwl6000_3agn_cfg, iwl6000_3agn_name,
-		     DEVICE(0x422B), SUBDEV(0x1108)),
-	IWL_DEV_INFO(iwl6000_3agn_cfg, iwl6000_3agn_name,
-		     DEVICE(0x422B), SUBDEV(0x1121)),
+		     DEVICE(0x422B), SUBDEV_MASKED(0x1, 0xF)),
 	IWL_DEV_INFO(iwl6000_3agn_cfg, iwl6000_3agn_name,
-		     DEVICE(0x422B), SUBDEV(0x1128)),
+		     DEVICE(0x422B), SUBDEV_MASKED(0x8, 0xF)),
 	IWL_DEV_INFO(iwl6000i_2agn_cfg, iwl6000i_2agn_name,
-		     DEVICE(0x422C), SUBDEV(0x1301)),
+		     DEVICE(0x422C), SUBDEV_MASKED(0x1, 0xF)),
 	IWL_DEV_INFO(iwl6000i_non_n_cfg, iwl6000i_2abg_name,
-		     DEVICE(0x422C), SUBDEV(0x1306)),
+		     DEVICE(0x422C), SUBDEV_MASKED(0x6, 0xF)),
 	IWL_DEV_INFO(iwl6000i_non_n_cfg, iwl6000i_2bg_name,
-		     DEVICE(0x422C), SUBDEV(0x1307)),
-	IWL_DEV_INFO(iwl6000i_2agn_cfg, iwl6000i_2agn_name,
-		     DEVICE(0x422C), SUBDEV(0x1321)),
-	IWL_DEV_INFO(iwl6000i_non_n_cfg, iwl6000i_2abg_name,
-		     DEVICE(0x422C), SUBDEV(0x1326)),
+		     DEVICE(0x422C), SUBDEV_MASKED(0x7, 0xF)),
 	IWL_DEV_INFO(iwl6000_3agn_cfg, iwl6000_3agn_name,
 		     DEVICE(0x4238), SUBDEV(0x1111)),
 	IWL_DEV_INFO(iwl6000_3agn_cfg, iwl6000_3agn_name,
@@ -721,31 +653,23 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 
 /* 6x05 Series */
 	IWL_DEV_INFO(iwl6005_n_cfg, iwl6005_2agn_name,
-		     DEVICE(0x0082), SUBDEV(0x1301)),
+		     DEVICE(0x0082), SUBDEV_MASKED(0x1, 0xF)),
 	IWL_DEV_INFO(iwl6005_non_n_cfg, iwl6005_2abg_name,
-		     DEVICE(0x0082), SUBDEV(0x1306)),
+		     DEVICE(0x0082), SUBDEV_MASKED(0x6, 0xF)),
 	IWL_DEV_INFO(iwl6005_non_n_cfg, iwl6005_2bg_name,
-		     DEVICE(0x0082), SUBDEV(0x1307)),
+		     DEVICE(0x0082), SUBDEV_MASKED(0x7, 0xF)),
 	IWL_DEV_INFO(iwl6005_n_cfg, iwl6005_2agn_name,
-		     DEVICE(0x0082), SUBDEV(0x1308)),
-	IWL_DEV_INFO(iwl6005_n_cfg, iwl6005_2agn_name,
-		     DEVICE(0x0082), SUBDEV(0x1321)),
-	IWL_DEV_INFO(iwl6005_non_n_cfg, iwl6005_2abg_name,
-		     DEVICE(0x0082), SUBDEV(0x1326)),
-	IWL_DEV_INFO(iwl6005_n_cfg, iwl6005_2agn_name,
-		     DEVICE(0x0082), SUBDEV(0x1328)),
+		     DEVICE(0x0082), SUBDEV_MASKED(0x8, 0xF)),
+
 	IWL_DEV_INFO(iwl6005_n_cfg, iwl6005_2agn_name,
-		     DEVICE(0x0085), SUBDEV(0x1311)),
+		     DEVICE(0x0085), SUBDEV_MASKED(0x1, 0xF)),
 	IWL_DEV_INFO(iwl6005_n_cfg, iwl6005_2agn_name,
-		     DEVICE(0x0085), SUBDEV(0x1318)),
+		     DEVICE(0x0085), SUBDEV_MASKED(0x8, 0xF)),
 	IWL_DEV_INFO(iwl6005_non_n_cfg, iwl6005_2abg_name,
-		     DEVICE(0x0085), SUBDEV(0x1316)),
-	IWL_DEV_INFO(iwl6005_n_cfg, iwl6005_2agn_sff_name,
-		     DEVICE(0x0082), SUBDEV(0xC020)),
-	IWL_DEV_INFO(iwl6005_n_cfg, iwl6005_2agn_sff_name,
-		     DEVICE(0x0085), SUBDEV(0xC220)),
+		     DEVICE(0x0085), SUBDEV_MASKED(0x6, 0xF)),
+
 	IWL_DEV_INFO(iwl6005_n_cfg, iwl6005_2agn_sff_name,
-		     DEVICE(0x0085), SUBDEV(0xC228)),
+		     DEVICE(0x0082), SUBDEV_MASKED(0xC000, 0xFFFF)),
 	IWL_DEV_INFO(iwl6005_n_cfg, iwl6005_2agn_d_name,
 		     DEVICE(0x0082), SUBDEV(0x4820)),
 	IWL_DEV_INFO(iwl6005_n_cfg, iwl6005_2agn_mow1_name,
@@ -755,13 +679,9 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 
 /* 6x30 Series */
 	IWL_DEV_INFO(iwl6030_n_cfg, iwl1030_bgn_name,
-		     DEVICE(0x008A), SUBDEV(0x5305)),
+		     DEVICE(0x008A), SUBDEV_MASKED(0x5, 0xF)),
 	IWL_DEV_INFO(iwl6030_non_n_cfg, iwl1030_bg_name,
-		     DEVICE(0x008A), SUBDEV(0x5307)),
-	IWL_DEV_INFO(iwl6030_n_cfg, iwl1030_bgn_name,
-		     DEVICE(0x008A), SUBDEV(0x5325)),
-	IWL_DEV_INFO(iwl6030_non_n_cfg, iwl1030_bg_name,
-		     DEVICE(0x008A), SUBDEV(0x5327)),
+		     DEVICE(0x008A), SUBDEV_MASKED(0x7, 0xF)),
 	IWL_DEV_INFO(iwl6030_n_cfg, iwl1030_bgn_name,
 		     DEVICE(0x008B), SUBDEV(0x5315)),
 	IWL_DEV_INFO(iwl6030_non_n_cfg, iwl1030_bg_name,
@@ -773,29 +693,19 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 	IWL_DEV_INFO(iwl6030_non_n_cfg, iwl6030_2abg_name,
 		     DEVICE(0x0090), SUBDEV(0x5216)),
 	IWL_DEV_INFO(iwl6030_n_cfg, iwl6030_2agn_name,
-		     DEVICE(0x0091), SUBDEV(0x5201)),
+		     DEVICE(0x0091), SUBDEV_MASKED(0x1, 0xF)),
 	IWL_DEV_INFO(iwl6030_n_cfg, iwl6030_2bgn_name,
-		     DEVICE(0x0091), SUBDEV(0x5205)),
+		     DEVICE(0x0091), SUBDEV_MASKED(0x5, 0xF)),
 	IWL_DEV_INFO(iwl6030_non_n_cfg, iwl6030_2abg_name,
-		     DEVICE(0x0091), SUBDEV(0x5206)),
+		     DEVICE(0x0091), SUBDEV_MASKED(0x6, 0xF)),
 	IWL_DEV_INFO(iwl6030_non_n_cfg, iwl6030_2bg_name,
 		     DEVICE(0x0091), SUBDEV(0x5207)),
-	IWL_DEV_INFO(iwl6030_n_cfg, iwl6030_2agn_name,
-		     DEVICE(0x0091), SUBDEV(0x5221)),
-	IWL_DEV_INFO(iwl6030_n_cfg, iwl6030_2bgn_name,
-		     DEVICE(0x0091), SUBDEV(0x5225)),
-	IWL_DEV_INFO(iwl6030_non_n_cfg, iwl6030_2abg_name,
-		     DEVICE(0x0091), SUBDEV(0x5226)),
 
 /* 6x50 WiFi/WiMax Series */
 	IWL_DEV_INFO(iwl6050_2agn_cfg, iwl6050_2agn_name,
-		     DEVICE(0x0087), SUBDEV(0x1301)),
+		     DEVICE(0x0087), SUBDEV_MASKED(0x1, 0xF)),
 	IWL_DEV_INFO(iwl6050_2abg_cfg, iwl6050_2abg_name,
-		     DEVICE(0x0087), SUBDEV(0x1306)),
-	IWL_DEV_INFO(iwl6050_2agn_cfg, iwl6050_2agn_name,
-		     DEVICE(0x0087), SUBDEV(0x1321)),
-	IWL_DEV_INFO(iwl6050_2abg_cfg, iwl6050_2abg_name,
-		     DEVICE(0x0087), SUBDEV(0x1326)),
+		     DEVICE(0x0087), SUBDEV_MASKED(0x6, 0xF)),
 	IWL_DEV_INFO(iwl6050_2agn_cfg, iwl6050_2agn_name,
 		     DEVICE(0x0089), SUBDEV(0x1311)),
 	IWL_DEV_INFO(iwl6050_2abg_cfg, iwl6050_2abg_name,
@@ -803,13 +713,9 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 
 /* 6150 WiFi/WiMax Series */
 	IWL_DEV_INFO(iwl6150_bgn_cfg, iwl6150_bgn_name,
-		     DEVICE(0x0885), SUBDEV(0x1305)),
+		     DEVICE(0x0885), SUBDEV_MASKED(0x5, 0xF)),
 	IWL_DEV_INFO(iwl6150_bg_cfg, iwl6150_bg_name,
-		     DEVICE(0x0885), SUBDEV(0x1307)),
-	IWL_DEV_INFO(iwl6150_bgn_cfg, iwl6150_bgn_name,
-		     DEVICE(0x0885), SUBDEV(0x1325)),
-	IWL_DEV_INFO(iwl6150_bg_cfg, iwl6150_bg_name,
-		     DEVICE(0x0885), SUBDEV(0x1327)),
+		     DEVICE(0x0885), SUBDEV_MASKED(0x7, 0xF)),
 	IWL_DEV_INFO(iwl6150_bgn_cfg, iwl6150_bgn_name,
 		     DEVICE(0x0886), SUBDEV(0x1315)),
 	IWL_DEV_INFO(iwl6150_bg_cfg, iwl6150_bg_name,
@@ -817,25 +723,9 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 
 /* 1000 Series WiFi */
 	IWL_DEV_INFO(iwl1000_bgn_cfg, iwl1000_bgn_name,
-		     DEVICE(0x0083), SUBDEV(0x1205)),
-	IWL_DEV_INFO(iwl1000_bgn_cfg, iwl1000_bgn_name,
-		     DEVICE(0x0083), SUBDEV(0x1305)),
-	IWL_DEV_INFO(iwl1000_bgn_cfg, iwl1000_bgn_name,
-		     DEVICE(0x0083), SUBDEV(0x1225)),
-	IWL_DEV_INFO(iwl1000_bgn_cfg, iwl1000_bgn_name,
-		     DEVICE(0x0083), SUBDEV(0x1325)),
-	IWL_DEV_INFO(iwl1000_bgn_cfg, iwl1000_bgn_name,
-		     DEVICE(0x0084), SUBDEV(0x1215)),
-	IWL_DEV_INFO(iwl1000_bgn_cfg, iwl1000_bgn_name,
-		     DEVICE(0x0084), SUBDEV(0x1315)),
+		     DEVICE(0x0083), SUBDEV_MASKED(0x5, 0xF)),
 	IWL_DEV_INFO(iwl1000_bg_cfg, iwl1000_bg_name,
-		     DEVICE(0x0083), SUBDEV(0x1206)),
-	IWL_DEV_INFO(iwl1000_bg_cfg, iwl1000_bg_name,
-		     DEVICE(0x0083), SUBDEV(0x1306)),
-	IWL_DEV_INFO(iwl1000_bg_cfg, iwl1000_bg_name,
-		     DEVICE(0x0083), SUBDEV(0x1226)),
-	IWL_DEV_INFO(iwl1000_bg_cfg, iwl1000_bg_name,
-		     DEVICE(0x0083), SUBDEV(0x1326)),
+		     DEVICE(0x0083), SUBDEV_MASKED(0x6, 0xF)),
 	IWL_DEV_INFO(iwl1000_bg_cfg, iwl1000_bg_name,
 		     DEVICE(0x0084), SUBDEV(0x1216)),
 	IWL_DEV_INFO(iwl1000_bg_cfg, iwl1000_bg_name,
@@ -843,31 +733,23 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 
 /* 100 Series WiFi */
 	IWL_DEV_INFO(iwl100_bgn_cfg, iwl100_bgn_name,
-		     DEVICE(0x08AE), SUBDEV(0x1005)),
+		     DEVICE(0x08AE), SUBDEV_MASKED(0x5, 0xF)),
 	IWL_DEV_INFO(iwl100_bg_cfg, iwl100_bg_name,
-		     DEVICE(0x08AE), SUBDEV(0x1007)),
+		     DEVICE(0x08AE), SUBDEV_MASKED(0x7, 0xF)),
 	IWL_DEV_INFO(iwl100_bgn_cfg, iwl100_bgn_name,
 		     DEVICE(0x08AF), SUBDEV(0x1015)),
 	IWL_DEV_INFO(iwl100_bg_cfg, iwl100_bg_name,
 		     DEVICE(0x08AF), SUBDEV(0x1017)),
-	IWL_DEV_INFO(iwl100_bgn_cfg, iwl100_bgn_name,
-		     DEVICE(0x08AE), SUBDEV(0x1025)),
-	IWL_DEV_INFO(iwl100_bg_cfg, iwl100_bg_name,
-		     DEVICE(0x08AE), SUBDEV(0x1027)),
 
 /* 130 Series WiFi */
 	IWL_DEV_INFO(iwl130_bgn_cfg, iwl130_bgn_name,
-		     DEVICE(0x0896), SUBDEV(0x5005)),
+		     DEVICE(0x0896), SUBDEV_MASKED(0x5, 0xF)),
 	IWL_DEV_INFO(iwl130_bg_cfg, iwl130_bg_name,
-		     DEVICE(0x0896), SUBDEV(0x5007)),
+		     DEVICE(0x0896), SUBDEV_MASKED(0x7, 0xF)),
 	IWL_DEV_INFO(iwl130_bgn_cfg, iwl130_bgn_name,
 		     DEVICE(0x0897), SUBDEV(0x5015)),
 	IWL_DEV_INFO(iwl130_bg_cfg, iwl130_bg_name,
 		     DEVICE(0x0897), SUBDEV(0x5017)),
-	IWL_DEV_INFO(iwl130_bgn_cfg, iwl130_bgn_name,
-		     DEVICE(0x0896), SUBDEV(0x5025)),
-	IWL_DEV_INFO(iwl130_bg_cfg, iwl130_bg_name,
-		     DEVICE(0x0896), SUBDEV(0x5027)),
 
 /* 2x00 Series */
 	IWL_DEV_INFO(iwl2000_2bgn_cfg, iwl2000_2bgn_name,
@@ -881,61 +763,37 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 
 /* 2x30 Series */
 	IWL_DEV_INFO(iwl2030_2bgn_cfg, iwl2030_2bgn_name,
-		     DEVICE(0x0887), SUBDEV(0x4062)),
+		     DEVICE(0x0887)),
 	IWL_DEV_INFO(iwl2030_2bgn_cfg, iwl2030_2bgn_name,
 		     DEVICE(0x0888), SUBDEV(0x4262)),
-	IWL_DEV_INFO(iwl2030_2bgn_cfg, iwl2030_2bgn_name,
-		     DEVICE(0x0887), SUBDEV(0x4462)),
 
 /* 6x35 Series */
 	IWL_DEV_INFO(iwl6035_2agn_cfg, iwl6035_2agn_name,
-		     DEVICE(0x088E), SUBDEV(0x4060)),
-	IWL_DEV_INFO(iwl6035_2agn_cfg, iwl6035_2agn_sff_name,
-		     DEVICE(0x088E), SUBDEV(0x406A)),
-	IWL_DEV_INFO(iwl6035_2agn_cfg, iwl6035_2agn_name,
-		     DEVICE(0x088F), SUBDEV(0x4260)),
+		     DEVICE(0x088E), SUBDEV_MASKED(0x0, 0xF)),
 	IWL_DEV_INFO(iwl6035_2agn_cfg, iwl6035_2agn_sff_name,
-		     DEVICE(0x088F), SUBDEV(0x426A)),
+		     DEVICE(0x088E), SUBDEV_MASKED(0xA, 0xF)),
 	IWL_DEV_INFO(iwl6035_2agn_cfg, iwl6035_2agn_name,
-		     DEVICE(0x088E), SUBDEV(0x4460)),
+		     DEVICE(0x088F), SUBDEV_MASKED(0x0, 0xF)),
 	IWL_DEV_INFO(iwl6035_2agn_cfg, iwl6035_2agn_sff_name,
-		     DEVICE(0x088E), SUBDEV(0x446A)),
-	IWL_DEV_INFO(iwl6035_2agn_cfg, iwl6035_2agn_name,
-		     DEVICE(0x088E), SUBDEV(0x4860)),
-	IWL_DEV_INFO(iwl6035_2agn_cfg, iwl6035_2agn_name,
-		     DEVICE(0x088F), SUBDEV(0x5260)),
+		     DEVICE(0x088F), SUBDEV_MASKED(0xA, 0xF)),
 
 /* 105 Series */
 	IWL_DEV_INFO(iwl105_bgn_cfg, iwl105_bgn_name,
-		     DEVICE(0x0894), SUBDEV(0x0022)),
+		     DEVICE(0x0894)),
 	IWL_DEV_INFO(iwl105_bgn_cfg, iwl105_bgn_name,
 		     DEVICE(0x0895), SUBDEV(0x0222)),
-	IWL_DEV_INFO(iwl105_bgn_cfg, iwl105_bgn_name,
-		     DEVICE(0x0894), SUBDEV(0x0422)),
-	IWL_DEV_INFO(iwl105_bgn_cfg, iwl105_bgn_name,
-		     DEVICE(0x0894), SUBDEV(0x0822)),
 
 /* 135 Series */
 	IWL_DEV_INFO(iwl135_bgn_cfg, iwl135_bgn_name,
-		     DEVICE(0x0892), SUBDEV(0x0062)),
+		     DEVICE(0x0892)),
 	IWL_DEV_INFO(iwl135_bgn_cfg, iwl135_bgn_name,
 		     DEVICE(0x0893), SUBDEV(0x0262)),
-	IWL_DEV_INFO(iwl135_bgn_cfg, iwl135_bgn_name,
-		     DEVICE(0x0892), SUBDEV(0x0462)),
 #endif /* CONFIG_IWLDVM */
 
 #if IS_ENABLED(CONFIG_IWLMVM)
 /* 7260 Series */
 	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2ac_name,
-		     DEVICE(0x08B1), SUBDEV(0x4070)),
-	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2ac_name,
-		     DEVICE(0x08B1), SUBDEV(0x4072)),
-	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2ac_name,
-		     DEVICE(0x08B1), SUBDEV(0x4170)),
-	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2ac_name,
-		     DEVICE(0x08B1), SUBDEV(0x4C60)),
-	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2ac_name,
-		     DEVICE(0x08B1), SUBDEV(0x4C70)),
+		     DEVICE(0x08B1)), // unlisted ones fall through to here
 	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2n_name,
 		     DEVICE(0x08B1), SUBDEV(0x4060)),
 	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2n_name,
@@ -946,66 +804,26 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 		     DEVICE(0x08B1), SUBDEV(0x4062)),
 	IWL_DEV_INFO(iwl7260_cfg, iwl7260_n_name,
 		     DEVICE(0x08B1), SUBDEV(0x4162)),
-	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2ac_name,
-		     DEVICE(0x08B2), SUBDEV(0x4270)),
-	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2ac_name,
-		     DEVICE(0x08B2), SUBDEV(0x4272)),
-	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2n_name,
-		     DEVICE(0x08B2), SUBDEV(0x4260)),
-	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2n_name,
-		     DEVICE(0x08B2), SUBDEV(0x426A)),
-	IWL_DEV_INFO(iwl7260_cfg, iwl7260_n_name,
-		     DEVICE(0x08B2), SUBDEV(0x4262)),
-	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2ac_name,
-		     DEVICE(0x08B1), SUBDEV(0x4470)),
-	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2ac_name,
-		     DEVICE(0x08B1), SUBDEV(0x4472)),
 	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2n_name,
 		     DEVICE(0x08B1), SUBDEV(0x4460)),
 	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2n_name,
 		     DEVICE(0x08B1), SUBDEV(0x446A)),
 	IWL_DEV_INFO(iwl7260_cfg, iwl7260_n_name,
 		     DEVICE(0x08B1), SUBDEV(0x4462)),
-	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2ac_name,
-		     DEVICE(0x08B1), SUBDEV(0x4870)),
-	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2ac_name,
-		     DEVICE(0x08B1), SUBDEV(0x486E)),
 	IWL_DEV_INFO(iwl7260_high_temp_cfg, iwl7260_2ac_name,
 		     DEVICE(0x08B1), SUBDEV(0x4A70)),
 	IWL_DEV_INFO(iwl7260_high_temp_cfg, iwl7260_2ac_name,
 		     DEVICE(0x08B1), SUBDEV(0x4A6E)),
 	IWL_DEV_INFO(iwl7260_high_temp_cfg, iwl7260_2ac_name,
 		     DEVICE(0x08B1), SUBDEV(0x4A6C)),
-	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2ac_name,
-		     DEVICE(0x08B1), SUBDEV(0x4570)),
 	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2n_name,
 		     DEVICE(0x08B1), SUBDEV(0x4560)),
-	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2ac_name,
-		     DEVICE(0x08B2), SUBDEV(0x4370)),
-	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2n_name,
-		     DEVICE(0x08B2), SUBDEV(0x4360)),
-	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2ac_name,
-		     DEVICE(0x08B1), SUBDEV(0x5070)),
-	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2ac_name,
-		     DEVICE(0x08B1), SUBDEV(0x5072)),
-	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2ac_name,
-		     DEVICE(0x08B1), SUBDEV(0x5170)),
-	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2ac_name,
-		     DEVICE(0x08B1), SUBDEV(0x5770)),
 	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2n_name,
 		     DEVICE(0x08B1), SUBDEV(0x4020)),
 	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2n_name,
 		     DEVICE(0x08B1), SUBDEV(0x402A)),
-	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2n_name,
-		     DEVICE(0x08B2), SUBDEV(0x4220)),
 	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2n_name,
 		     DEVICE(0x08B1), SUBDEV(0x4420)),
-	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2ac_name,
-		     DEVICE(0x08B1), SUBDEV(0xC070)),
-	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2ac_name,
-		     DEVICE(0x08B1), SUBDEV(0xC072)),
-	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2ac_name,
-		     DEVICE(0x08B1), SUBDEV(0xC170)),
 	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2n_name,
 		     DEVICE(0x08B1), SUBDEV(0xC060)),
 	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2n_name,
@@ -1016,16 +834,40 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 		     DEVICE(0x08B1), SUBDEV(0xC062)),
 	IWL_DEV_INFO(iwl7260_cfg, iwl7260_n_name,
 		     DEVICE(0x08B1), SUBDEV(0xC162)),
-	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2ac_name,
-		     DEVICE(0x08B1), SUBDEV(0xC770)),
 	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2n_name,
 		     DEVICE(0x08B1), SUBDEV(0xC760)),
+	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2n_name,
+		     DEVICE(0x08B1), SUBDEV(0xC460)),
+	IWL_DEV_INFO(iwl7260_cfg, iwl7260_n_name,
+		     DEVICE(0x08B1), SUBDEV(0xC462)),
+	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2n_name,
+		     DEVICE(0x08B1), SUBDEV(0xC560)),
+	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2n_name,
+		     DEVICE(0x08B1), SUBDEV(0xC360)),
+	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2n_name,
+		     DEVICE(0x08B1), SUBDEV(0xC020)),
+	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2n_name,
+		     DEVICE(0x08B1), SUBDEV(0xC02A)),
+	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2n_name,
+		     DEVICE(0x08B1), SUBDEV(0xC420)),
 	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2ac_name,
-		     DEVICE(0x08B2), SUBDEV(0xC270)),
+		     DEVICE(0x08B2), SUBDEV(0x4270)),
 	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2ac_name,
-		     DEVICE(0x08B1), SUBDEV(0xCC70)),
+		     DEVICE(0x08B2), SUBDEV(0x4272)),
+	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2n_name,
+		     DEVICE(0x08B2), SUBDEV(0x4260)),
+	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2n_name,
+		     DEVICE(0x08B2), SUBDEV(0x426A)),
+	IWL_DEV_INFO(iwl7260_cfg, iwl7260_n_name,
+		     DEVICE(0x08B2), SUBDEV(0x4262)),
 	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2ac_name,
-		     DEVICE(0x08B1), SUBDEV(0xCC60)),
+		     DEVICE(0x08B2), SUBDEV(0x4370)),
+	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2n_name,
+		     DEVICE(0x08B2), SUBDEV(0x4360)),
+	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2n_name,
+		     DEVICE(0x08B2), SUBDEV(0x4220)),
+	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2ac_name,
+		     DEVICE(0x08B2), SUBDEV(0xC270)),
 	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2ac_name,
 		     DEVICE(0x08B2), SUBDEV(0xC272)),
 	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2n_name,
@@ -1034,352 +876,65 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 		     DEVICE(0x08B2), SUBDEV(0xC26A)),
 	IWL_DEV_INFO(iwl7260_cfg, iwl7260_n_name,
 		     DEVICE(0x08B2), SUBDEV(0xC262)),
-	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2ac_name,
-		     DEVICE(0x08B1), SUBDEV(0xC470)),
-	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2ac_name,
-		     DEVICE(0x08B1), SUBDEV(0xC472)),
-	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2n_name,
-		     DEVICE(0x08B1), SUBDEV(0xC460)),
-	IWL_DEV_INFO(iwl7260_cfg, iwl7260_n_name,
-		     DEVICE(0x08B1), SUBDEV(0xC462)),
-	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2ac_name,
-		     DEVICE(0x08B1), SUBDEV(0xC570)),
-	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2n_name,
-		     DEVICE(0x08B1), SUBDEV(0xC560)),
 	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2ac_name,
 		     DEVICE(0x08B2), SUBDEV(0xC370)),
-	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2n_name,
-		     DEVICE(0x08B1), SUBDEV(0xC360)),
-	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2n_name,
-		     DEVICE(0x08B1), SUBDEV(0xC020)),
-	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2n_name,
-		     DEVICE(0x08B1), SUBDEV(0xC02A)),
 	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2n_name,
 		     DEVICE(0x08B2), SUBDEV(0xC220)),
-	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2n_name,
-		     DEVICE(0x08B1), SUBDEV(0xC420)),
 
 /* 3160 Series */
 	IWL_DEV_INFO(iwl3160_cfg, iwl3160_2ac_name,
-		     DEVICE(0x08B3), SUBDEV(0x0070)),
-	IWL_DEV_INFO(iwl3160_cfg, iwl3160_2ac_name,
-		     DEVICE(0x08B3), SUBDEV(0x0072)),
-	IWL_DEV_INFO(iwl3160_cfg, iwl3160_2ac_name,
-		     DEVICE(0x08B3), SUBDEV(0x0170)),
-	IWL_DEV_INFO(iwl3160_cfg, iwl3160_2ac_name,
-		     DEVICE(0x08B3), SUBDEV(0x0172)),
-	IWL_DEV_INFO(iwl3160_cfg, iwl3160_2n_name,
-		     DEVICE(0x08B3), SUBDEV(0x0060)),
+		     DEVICE(0x08B3)),
+
 	IWL_DEV_INFO(iwl3160_cfg, iwl3160_n_name,
-		     DEVICE(0x08B3), SUBDEV(0x0062)),
-	IWL_DEV_INFO(iwl3160_cfg, iwl3160_2ac_name,
-		     DEVICE(0x08B4), SUBDEV(0x0270)),
-	IWL_DEV_INFO(iwl3160_cfg, iwl3160_2ac_name,
-		     DEVICE(0x08B4), SUBDEV(0x0272)),
-	IWL_DEV_INFO(iwl3160_cfg, iwl3160_2ac_name,
-		     DEVICE(0x08B3), SUBDEV(0x0470)),
-	IWL_DEV_INFO(iwl3160_cfg, iwl3160_2ac_name,
-		     DEVICE(0x08B3), SUBDEV(0x0472)),
-	IWL_DEV_INFO(iwl3160_cfg, iwl3160_2ac_name,
-		     DEVICE(0x08B4), SUBDEV(0x0370)),
-	IWL_DEV_INFO(iwl3160_cfg, iwl3160_2ac_name,
-		     DEVICE(0x08B3), SUBDEV(0x8070)),
-	IWL_DEV_INFO(iwl3160_cfg, iwl3160_2ac_name,
-		     DEVICE(0x08B3), SUBDEV(0x8072)),
-	IWL_DEV_INFO(iwl3160_cfg, iwl3160_2ac_name,
-		     DEVICE(0x08B3), SUBDEV(0x8170)),
-	IWL_DEV_INFO(iwl3160_cfg, iwl3160_2ac_name,
-		     DEVICE(0x08B3), SUBDEV(0x8172)),
+		     DEVICE(0x08B3), SUBDEV_MASKED(0x62, 0xFF)),
 	IWL_DEV_INFO(iwl3160_cfg, iwl3160_2n_name,
-		     DEVICE(0x08B3), SUBDEV(0x8060)),
-	IWL_DEV_INFO(iwl3160_cfg, iwl3160_n_name,
-		     DEVICE(0x08B3), SUBDEV(0x8062)),
-	IWL_DEV_INFO(iwl3160_cfg, iwl3160_2ac_name,
-		     DEVICE(0x08B4), SUBDEV(0x8270)),
-	IWL_DEV_INFO(iwl3160_cfg, iwl3160_2ac_name,
-		     DEVICE(0x08B4), SUBDEV(0x8370)),
-	IWL_DEV_INFO(iwl3160_cfg, iwl3160_2ac_name,
-		     DEVICE(0x08B4), SUBDEV(0x8272)),
-	IWL_DEV_INFO(iwl3160_cfg, iwl3160_2ac_name,
-		     DEVICE(0x08B3), SUBDEV(0x8470)),
-	IWL_DEV_INFO(iwl3160_cfg, iwl3160_2ac_name,
-		     DEVICE(0x08B3), SUBDEV(0x8570)),
-	IWL_DEV_INFO(iwl3160_cfg, iwl3160_2ac_name,
-		     DEVICE(0x08B3), SUBDEV(0x1070)),
+		     DEVICE(0x08B3), SUBDEV_MASKED(0x60, 0xFF)),
+
 	IWL_DEV_INFO(iwl3160_cfg, iwl3160_2ac_name,
-		     DEVICE(0x08B3), SUBDEV(0x1170)),
+		     DEVICE(0x08B4)),
 
 /* 3165 Series */
 	IWL_DEV_INFO(iwl3165_2ac_cfg, iwl3165_2ac_name,
-		     DEVICE(0x3165), SUBDEV(0x4010)),
-	IWL_DEV_INFO(iwl3165_2ac_cfg, iwl3165_2ac_name,
-		     DEVICE(0x3165), SUBDEV(0x4012)),
-	IWL_DEV_INFO(iwl3165_2ac_cfg, iwl3165_2ac_name,
-		     DEVICE(0x3166), SUBDEV(0x4212)),
-	IWL_DEV_INFO(iwl3165_2ac_cfg, iwl3165_2ac_name,
-		     DEVICE(0x3165), SUBDEV(0x4410)),
-	IWL_DEV_INFO(iwl3165_2ac_cfg, iwl3165_2ac_name,
-		     DEVICE(0x3165), SUBDEV(0x4510)),
-	IWL_DEV_INFO(iwl3165_2ac_cfg, iwl3165_2ac_name,
-		     DEVICE(0x3165), SUBDEV(0x4110)),
+		     DEVICE(0x3165)),
 	IWL_DEV_INFO(iwl3165_2ac_cfg, iwl3165_2ac_name,
-		     DEVICE(0x3166), SUBDEV(0x4310)),
-	IWL_DEV_INFO(iwl3165_2ac_cfg, iwl3165_2ac_name,
-		     DEVICE(0x3166), SUBDEV(0x4210)),
-	IWL_DEV_INFO(iwl3165_2ac_cfg, iwl3165_2ac_name,
-		     DEVICE(0x3165), SUBDEV(0x8010)),
-	IWL_DEV_INFO(iwl3165_2ac_cfg, iwl3165_2ac_name,
-		     DEVICE(0x3165), SUBDEV(0x8110)),
+		     DEVICE(0x3166)),
 
 /* 3168 Series */
 	IWL_DEV_INFO(iwl3168_2ac_cfg, iwl3168_2ac_name,
-		     DEVICE(0x24FB), SUBDEV(0x2010)),
-	IWL_DEV_INFO(iwl3168_2ac_cfg, iwl3168_2ac_name,
-		     DEVICE(0x24FB), SUBDEV(0x2110)),
-	IWL_DEV_INFO(iwl3168_2ac_cfg, iwl3168_2ac_name,
-		     DEVICE(0x24FB), SUBDEV(0x2050)),
-	IWL_DEV_INFO(iwl3168_2ac_cfg, iwl3168_2ac_name,
-		     DEVICE(0x24FB), SUBDEV(0x2150)),
-	IWL_DEV_INFO(iwl3168_2ac_cfg, iwl3168_2ac_name,
-		     DEVICE(0x24FB), SUBDEV(0x0000)),
+		     DEVICE(0x24FB)),
 
 /* 7265 Series */
 	IWL_DEV_INFO(iwl7265_cfg, iwl7265_2ac_name,
-		     DEVICE(0x095A), SUBDEV(0x5010)),
-	IWL_DEV_INFO(iwl7265_cfg, iwl7265_2ac_name,
-		     DEVICE(0x095A), SUBDEV(0x5110)),
-	IWL_DEV_INFO(iwl7265_cfg, iwl7265_2ac_name,
-		     DEVICE(0x095A), SUBDEV(0x5100)),
-	IWL_DEV_INFO(iwl7265_cfg, iwl7265_2ac_name,
-		     DEVICE(0x095B), SUBDEV(0x5310)),
-	IWL_DEV_INFO(iwl7265_cfg, iwl7265_n_name,
-		     DEVICE(0x095B), SUBDEV(0x5302)),
-	IWL_DEV_INFO(iwl7265_cfg, iwl7265_2ac_name,
-		     DEVICE(0x095B), SUBDEV(0x5210)),
-	IWL_DEV_INFO(iwl7265_cfg, iwl7265_2ac_name,
-		     DEVICE(0x095A), SUBDEV(0x5C10)),
-	IWL_DEV_INFO(iwl7265_cfg, iwl7265_2ac_name,
-		     DEVICE(0x095A), SUBDEV(0x5012)),
-	IWL_DEV_INFO(iwl7265_cfg, iwl7265_2ac_name,
-		     DEVICE(0x095A), SUBDEV(0x5412)),
-	IWL_DEV_INFO(iwl7265_cfg, iwl7265_2ac_name,
-		     DEVICE(0x095A), SUBDEV(0x5410)),
-	IWL_DEV_INFO(iwl7265_cfg, iwl7265_2ac_name,
-		     DEVICE(0x095A), SUBDEV(0x5510)),
-	IWL_DEV_INFO(iwl7265_cfg, iwl7265_2ac_name,
-		     DEVICE(0x095A), SUBDEV(0x5400)),
-	IWL_DEV_INFO(iwl7265_cfg, iwl7265_2ac_name,
-		     DEVICE(0x095A), SUBDEV(0x1010)),
+		     DEVICE(0x095A)),
 	IWL_DEV_INFO(iwl7265_cfg, iwl7265_2n_name,
 		     DEVICE(0x095A), SUBDEV(0x5000)),
 	IWL_DEV_INFO(iwl7265_cfg, iwl7265_2n_name,
 		     DEVICE(0x095A), SUBDEV(0x500A)),
-	IWL_DEV_INFO(iwl7265_cfg, iwl7265_2n_name,
-		     DEVICE(0x095B), SUBDEV(0x5200)),
 	IWL_DEV_INFO(iwl7265_cfg, iwl7265_n_name,
 		     DEVICE(0x095A), SUBDEV(0x5002)),
 	IWL_DEV_INFO(iwl7265_cfg, iwl7265_n_name,
 		     DEVICE(0x095A), SUBDEV(0x5102)),
-	IWL_DEV_INFO(iwl7265_cfg, iwl7265_n_name,
-		     DEVICE(0x095B), SUBDEV(0x5202)),
-	IWL_DEV_INFO(iwl7265_cfg, iwl7265_2ac_name,
-		     DEVICE(0x095A), SUBDEV(0x9010)),
-	IWL_DEV_INFO(iwl7265_cfg, iwl7265_2ac_name,
-		     DEVICE(0x095A), SUBDEV(0x9012)),
-	IWL_DEV_INFO(iwl7265_cfg, iwl7265_2ac_name,
-		     DEVICE(0x095A), SUBDEV(0x900A)),
-	IWL_DEV_INFO(iwl7265_cfg, iwl7265_2ac_name,
-		     DEVICE(0x095A), SUBDEV(0x9110)),
-	IWL_DEV_INFO(iwl7265_cfg, iwl7265_2ac_name,
-		     DEVICE(0x095A), SUBDEV(0x9112)),
-	IWL_DEV_INFO(iwl7265_cfg, iwl7265_2ac_name,
-		     DEVICE(0x095B), SUBDEV(0x9210)),
-	IWL_DEV_INFO(iwl7265_cfg, iwl7265_2ac_name,
-		     DEVICE(0x095B), SUBDEV(0x9200)),
-	IWL_DEV_INFO(iwl7265_cfg, iwl7265_2ac_name,
-		     DEVICE(0x095A), SUBDEV(0x9510)),
-	IWL_DEV_INFO(iwl7265_cfg, iwl7265_2ac_name,
-		     DEVICE(0x095B), SUBDEV(0x9310)),
-	IWL_DEV_INFO(iwl7265_cfg, iwl7265_2ac_name,
-		     DEVICE(0x095A), SUBDEV(0x9410)),
 	IWL_DEV_INFO(iwl7265_cfg, iwl7265_2n_name,
 		     DEVICE(0x095A), SUBDEV(0x5020)),
 	IWL_DEV_INFO(iwl7265_cfg, iwl7265_2n_name,
 		     DEVICE(0x095A), SUBDEV(0x502A)),
 	IWL_DEV_INFO(iwl7265_cfg, iwl7265_2n_name,
 		     DEVICE(0x095A), SUBDEV(0x5420)),
+
 	IWL_DEV_INFO(iwl7265_cfg, iwl7265_2ac_name,
-		     DEVICE(0x095A), SUBDEV(0x5090)),
-	IWL_DEV_INFO(iwl7265_cfg, iwl7265_2ac_name,
-		     DEVICE(0x095A), SUBDEV(0x5190)),
-	IWL_DEV_INFO(iwl7265_cfg, iwl7265_2ac_name,
-		     DEVICE(0x095A), SUBDEV(0x5590)),
-	IWL_DEV_INFO(iwl7265_cfg, iwl7265_2ac_name,
-		     DEVICE(0x095B), SUBDEV(0x5290)),
-	IWL_DEV_INFO(iwl7265_cfg, iwl7265_2ac_name,
-		     DEVICE(0x095A), SUBDEV(0x5490)),
-	IWL_DEV_INFO(iwl7265_cfg, iwl7265_2ac_name,
-		     DEVICE(0x095A), SUBDEV(0x5F10)),
-	IWL_DEV_INFO(iwl7265_cfg, iwl7265_2ac_name,
-		     DEVICE(0x095B), SUBDEV(0x5212)),
-	IWL_DEV_INFO(iwl7265_cfg, iwl7265_2ac_name,
-		     DEVICE(0x095B), SUBDEV(0x520A)),
-	IWL_DEV_INFO(iwl7265_cfg, iwl7265_2ac_name,
-		     DEVICE(0x095A), SUBDEV(0x9000)),
-	IWL_DEV_INFO(iwl7265_cfg, iwl7265_2ac_name,
-		     DEVICE(0x095A), SUBDEV(0x9400)),
-	IWL_DEV_INFO(iwl7265_cfg, iwl7265_2ac_name,
-		     DEVICE(0x095A), SUBDEV(0x9E10)),
+		     DEVICE(0x095B)),
+	IWL_DEV_INFO(iwl7265_cfg, iwl7265_n_name,
+		     DEVICE(0x095B), SUBDEV(0x5302)),
+	IWL_DEV_INFO(iwl7265_cfg, iwl7265_2n_name,
+		     DEVICE(0x095B), SUBDEV(0x5200)),
+	IWL_DEV_INFO(iwl7265_cfg, iwl7265_n_name,
+		     DEVICE(0x095B), SUBDEV(0x5202)),
 
 /* 8000 Series */
 	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2ac_name,
-		     DEVICE(0x24F3), SUBDEV(0x0010)),
-	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2ac_name,
-		     DEVICE(0x24F3), SUBDEV(0x1010)),
-	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2ac_name,
-		     DEVICE(0x24F3), SUBDEV(0x10B0)),
-	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2ac_name,
-		     DEVICE(0x24F3), SUBDEV(0x0130)),
-	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2ac_name,
-		     DEVICE(0x24F3), SUBDEV(0x1130)),
-	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2ac_name,
-		     DEVICE(0x24F3), SUBDEV(0x0132)),
-	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2ac_name,
-		     DEVICE(0x24F3), SUBDEV(0x1132)),
-	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2ac_name,
-		     DEVICE(0x24F3), SUBDEV(0x0110)),
-	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2ac_name,
-		     DEVICE(0x24F3), SUBDEV(0x01F0)),
-	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2ac_name,
-		     DEVICE(0x24F3), SUBDEV(0x0012)),
-	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2ac_name,
-		     DEVICE(0x24F3), SUBDEV(0x1012)),
-	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2ac_name,
-		     DEVICE(0x24F3), SUBDEV(0x1110)),
-	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2ac_name,
-		     DEVICE(0x24F3), SUBDEV(0x0050)),
-	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2ac_name,
-		     DEVICE(0x24F3), SUBDEV(0x0250)),
-	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2ac_name,
-		     DEVICE(0x24F3), SUBDEV(0x1050)),
-	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2ac_name,
-		     DEVICE(0x24F3), SUBDEV(0x0150)),
-	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2ac_name,
-		     DEVICE(0x24F3), SUBDEV(0x1150)),
-	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2ac_name,
-		     DEVICE(0x24F4), SUBDEV(0x0030)),
-	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2ac_name,
-		     DEVICE(0x24F4), SUBDEV(0x1030)),
-	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2ac_name,
-		     DEVICE(0x24F3), SUBDEV(0xC010)),
-	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2ac_name,
-		     DEVICE(0x24F3), SUBDEV(0xC110)),
-	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2ac_name,
-		     DEVICE(0x24F3), SUBDEV(0xD010)),
-	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2ac_name,
-		     DEVICE(0x24F3), SUBDEV(0xC050)),
-	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2ac_name,
-		     DEVICE(0x24F3), SUBDEV(0xD050)),
-	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2ac_name,
-		     DEVICE(0x24F3), SUBDEV(0xD0B0)),
-	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2ac_name,
-		     DEVICE(0x24F3), SUBDEV(0xB0B0)),
-	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2ac_name,
-		     DEVICE(0x24F3), SUBDEV(0x8010)),
-	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2ac_name,
-		     DEVICE(0x24F3), SUBDEV(0x8110)),
-	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2ac_name,
-		     DEVICE(0x24F3), SUBDEV(0x9010)),
-	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2ac_name,
-		     DEVICE(0x24F3), SUBDEV(0x9110)),
-	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2ac_name,
-		     DEVICE(0x24F4), SUBDEV(0x8030)),
-	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2ac_name,
-		     DEVICE(0x24F4), SUBDEV(0x9030)),
-	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2ac_name,
-		     DEVICE(0x24F4), SUBDEV(0xC030)),
-	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2ac_name,
-		     DEVICE(0x24F4), SUBDEV(0xD030)),
-	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2ac_name,
-		     DEVICE(0x24F3), SUBDEV(0x8130)),
-	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2ac_name,
-		     DEVICE(0x24F3), SUBDEV(0x9130)),
-	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2ac_name,
-		     DEVICE(0x24F3), SUBDEV(0x8132)),
-	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2ac_name,
-		     DEVICE(0x24F3), SUBDEV(0x9132)),
-	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2ac_name,
-		     DEVICE(0x24F3), SUBDEV(0x8050)),
-	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2ac_name,
-		     DEVICE(0x24F3), SUBDEV(0x8150)),
-	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2ac_name,
-		     DEVICE(0x24F3), SUBDEV(0x9050)),
-	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2ac_name,
-		     DEVICE(0x24F3), SUBDEV(0x9150)),
-	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2n_name,
-		     DEVICE(0x24F3), SUBDEV(0x0004)),
-	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2n_name,
-		     DEVICE(0x24F3), SUBDEV(0x0044)),
-	IWL_DEV_INFO(iwl8260_cfg, iwl4165_2ac_name,
-		     DEVICE(0x24F5), SUBDEV(0x0010)),
-	IWL_DEV_INFO(iwl8260_cfg, iwl4165_2ac_name,
-		     DEVICE(0x24F6), SUBDEV(0x0030)),
-	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2ac_name,
-		     DEVICE(0x24F3), SUBDEV(0x0810)),
-	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2ac_name,
-		     DEVICE(0x24F3), SUBDEV(0x0910)),
-	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2ac_name,
-		     DEVICE(0x24F3), SUBDEV(0x0850)),
-	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2ac_name,
-		     DEVICE(0x24F3), SUBDEV(0x0950)),
-	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2ac_name,
-		     DEVICE(0x24F3), SUBDEV(0x0930)),
-	IWL_DEV_INFO(iwl8265_cfg, iwl8265_2ac_name,
-		     DEVICE(0x24F3), SUBDEV(0x0000)),
-	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2ac_name,
-		     DEVICE(0x24F3), SUBDEV(0x4010)),
-	IWL_DEV_INFO(iwl8265_cfg, iwl8265_2ac_name,
-		     DEVICE(0x24FD), SUBDEV(0x0010)),
-	IWL_DEV_INFO(iwl8265_cfg, iwl8265_2ac_name,
-		     DEVICE(0x24FD), SUBDEV(0x0110)),
-	IWL_DEV_INFO(iwl8265_cfg, iwl8265_2ac_name,
-		     DEVICE(0x24FD), SUBDEV(0x1110)),
-	IWL_DEV_INFO(iwl8265_cfg, iwl8265_2ac_name,
-		     DEVICE(0x24FD), SUBDEV(0x1130)),
+		     DEVICE(0x24F3)),
 	IWL_DEV_INFO(iwl8265_cfg, iwl8265_2ac_name,
-		     DEVICE(0x24FD), SUBDEV(0x0130)),
-	IWL_DEV_INFO(iwl8265_cfg, iwl8265_2ac_name,
-		     DEVICE(0x24FD), SUBDEV(0x1010)),
-	IWL_DEV_INFO(iwl8265_cfg, iwl8265_2ac_name,
-		     DEVICE(0x24FD), SUBDEV(0x10D0)),
-	IWL_DEV_INFO(iwl8265_cfg, iwl8265_2ac_name,
-		     DEVICE(0x24FD), SUBDEV(0x0050)),
-	IWL_DEV_INFO(iwl8265_cfg, iwl8265_2ac_name,
-		     DEVICE(0x24FD), SUBDEV(0x0150)),
-	IWL_DEV_INFO(iwl8265_cfg, iwl8265_2ac_name,
-		     DEVICE(0x24FD), SUBDEV(0x9010)),
-	IWL_DEV_INFO(iwl8265_cfg, iwl8265_2ac_name,
-		     DEVICE(0x24FD), SUBDEV(0x8110)),
-	IWL_DEV_INFO(iwl8265_cfg, iwl8265_2ac_name,
-		     DEVICE(0x24FD), SUBDEV(0x8050)),
-	IWL_DEV_INFO(iwl8265_cfg, iwl8265_2ac_name,
-		     DEVICE(0x24FD), SUBDEV(0x8010)),
-	IWL_DEV_INFO(iwl8265_cfg, iwl8265_2ac_name,
-		     DEVICE(0x24FD), SUBDEV(0x0810)),
-	IWL_DEV_INFO(iwl8265_cfg, iwl8265_2ac_name,
-		     DEVICE(0x24FD), SUBDEV(0x9110)),
-	IWL_DEV_INFO(iwl8265_cfg, iwl8265_2ac_name,
-		     DEVICE(0x24FD), SUBDEV(0x8130)),
-	IWL_DEV_INFO(iwl8265_cfg, iwl8265_2ac_name,
-		     DEVICE(0x24FD), SUBDEV(0x0910)),
-	IWL_DEV_INFO(iwl8265_cfg, iwl8265_2ac_name,
-		     DEVICE(0x24FD), SUBDEV(0x0930)),
-	IWL_DEV_INFO(iwl8265_cfg, iwl8265_2ac_name,
-		     DEVICE(0x24FD), SUBDEV(0x0950)),
-	IWL_DEV_INFO(iwl8265_cfg, iwl8265_2ac_name,
-		     DEVICE(0x24FD), SUBDEV(0x0850)),
-	IWL_DEV_INFO(iwl8265_cfg, iwl8265_2ac_name,
-		     DEVICE(0x24FD), SUBDEV(0x1014)),
+		     DEVICE(0x24FD)),
 	IWL_DEV_INFO(iwl8265_cfg, iwl8275_2ac_name,
 		     DEVICE(0x24FD), SUBDEV(0x3E02)),
 	IWL_DEV_INFO(iwl8265_cfg, iwl8275_2ac_name,
@@ -1388,10 +943,6 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 		     DEVICE(0x24FD), SUBDEV(0x1012)),
 	IWL_DEV_INFO(iwl8265_cfg, iwl8275_2ac_name,
 		     DEVICE(0x24FD), SUBDEV(0x0012)),
-	IWL_DEV_INFO(iwl8265_cfg, iwl8265_2ac_name,
-		     DEVICE(0x24FD), SUBDEV(0x0014)),
-	IWL_DEV_INFO(iwl8265_cfg, iwl8265_2ac_name,
-		     DEVICE(0x24FD), SUBDEV(0x9074)),
 /* 9000 */
 	IWL_DEV_INFO(iwl9260_2ac_cfg, iwl9260_killer_1550_name,
 		     DEVICE(0x2526), SUBDEV(0x1550)),
@@ -2120,7 +1671,7 @@ iwl_pci_find_dev_info(u16 device, u16 subsystem_device,
 			continue;
 
 		if (dev_info->subdevice != (u16)IWL_CFG_ANY &&
-		    dev_info->subdevice != subsystem_device)
+		    dev_info->subdevice != (subsystem_device & dev_info->subdevice_mask))
 			continue;
 
 		if (dev_info->mac_type != (u8)IWL_CFG_ANY &&
-- 
2.34.1


