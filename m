Return-Path: <linux-wireless+bounces-22347-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D09FAA72B2
	for <lists+linux-wireless@lfdr.de>; Fri,  2 May 2025 14:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBB4E4A7D1D
	for <lists+linux-wireless@lfdr.de>; Fri,  2 May 2025 12:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA481255223;
	Fri,  2 May 2025 12:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BSYSSkya"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CFC254AF7
	for <linux-wireless@vger.kernel.org>; Fri,  2 May 2025 12:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746190615; cv=none; b=hZmtqrzDyz5xzzzQbSpwDrAD6gbUPj+VBGpCrqa0gPFCFsa3ca2/GA8EWssFnenBfNKLhGTOjTZGwCb3ccC7/MFyNZQ2uNub9hs0T6uCo95gC8jgSGdngD7eJlkznDNXMy4aACCrGkhEUoUmLzCj8JjrJLyNZyhZTzNBEEIWfdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746190615; c=relaxed/simple;
	bh=J9TrBDvSaXbv7SZNM8bnf1eznDRORAaCLVwdZ1xFG6E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fZU7pU7SQHHinUt9r2PEpwzyu12W0VwQOAZ8YnhtiAwEpwpMFEsDf4qNQJFno6eZnFbu0bDNhEEaTXJKflatPhu0UYu4P2YtNxbhunaEWqHieZGmmCHBC0r7c0csrI6ZD5TZQb4+jVdAfEZcxGmoq+RUDSQ5ok6OCO3hWQeQcMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BSYSSkya; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746190614; x=1777726614;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J9TrBDvSaXbv7SZNM8bnf1eznDRORAaCLVwdZ1xFG6E=;
  b=BSYSSkyaNQDKB/MYygfpmlhfsLdOY4fjBubV5HoUwKyLqy58x3t1HBfH
   vaDzGX9fmuFXOC4r2rHVGZes4MClqccWqMaTw7sFVKRR7FwoRuv3SXZI9
   9hA77xW4reaQJpa9W6ZRJzp4JAAKsxKXx1A1UDMdbwpTtUKGBcJjPcYHP
   oOWYla0er8zEwpr4kQaLSWy8Z+VFQuinkubPV2vwQIsR/YegbB1RrRQak
   LeHPMDDDQmPynKnCDAZNr8Fa0CAdNNjrqzSfrqoxwd/bKT8s7eVxfAaZD
   aXuUJAWHDA5R6UsTpcrPhia8XLZNwAWTuTY5H2XeGM1u3JeWLWH7IuLnX
   g==;
X-CSE-ConnectionGUID: R4grKruqToetwq/Tz/qjuw==
X-CSE-MsgGUID: 2HN6HyM5QrWlH16GhTeg+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11421"; a="59255541"
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="59255541"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 05:56:54 -0700
X-CSE-ConnectionGUID: b1WZ3BF+QnCnKt5Xax6nmg==
X-CSE-MsgGUID: 3jHhdyJQQfGDnFcsSPLFPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="165554711"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 05:56:52 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 05/15] wifi: iwlwifi: cfg: rename BW_NO_LIMIT to BW_NOT_LIMITED
Date: Fri,  2 May 2025 15:56:21 +0300
Message-Id: <20250502155404.9b39693b505c.Ib47aa6a072a0e61bbba28383ce54764cd859f19c@changeid>
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

It's not clear that it makes sense to have any matches
for IWL_CFG_ANY for this bit, but let's assume for now
that this makes sense. Then, it's clearer to call this
BW_NOT_LIMITED rather than BW_NO_LIMIT, since the last
change.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 68 +++++++++----------
 1 file changed, 34 insertions(+), 34 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 69191ec5d3e7..618b6b9fefa7 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -579,7 +579,7 @@ EXPORT_SYMBOL_IF_IWLWIFI_KUNIT(iwl_hw_card_ids);
 #define RF_ID(n)	.rf_id = IWL_CFG_RF_ID_##n
 #define NO_CDB		.cdb = IWL_CFG_NO_CDB
 #define CDB		.cdb = IWL_CFG_CDB
-#define BW_NO_LIMIT	.bw_limit = 0
+#define BW_NOT_LIMITED	.bw_limit = 0
 #define BW_LIMITED	.bw_limit = 1
 
 VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
@@ -881,41 +881,41 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 
 	IWL_DEV_INFO(iwl9560_2ac_cfg_soc, iwl9461_160_name, MAC_TYPE(PU),
 		     RF_TYPE(JF1), RF_ID(JF1),
-		     BW_NO_LIMIT, CORES(BT), NO_CDB),
+		     BW_NOT_LIMITED, CORES(BT), NO_CDB),
 	IWL_DEV_INFO(iwl9560_2ac_cfg_soc_80mhz, iwl9461_name, MAC_TYPE(PU),
 		     RF_TYPE(JF1), RF_ID(JF1),
 		     BW_LIMITED, CORES(BT), NO_CDB),
 	IWL_DEV_INFO(iwl9560_2ac_cfg_soc, iwl9462_160_name, MAC_TYPE(PU),
 		     RF_TYPE(JF1), RF_ID(JF1_DIV),
-		     BW_NO_LIMIT, CORES(BT), NO_CDB),
+		     BW_NOT_LIMITED, CORES(BT), NO_CDB),
 	IWL_DEV_INFO(iwl9560_2ac_cfg_soc_80mhz, iwl9462_name, MAC_TYPE(PU),
 		     RF_TYPE(JF1), RF_ID(JF1_DIV),
 		     BW_LIMITED, CORES(BT), NO_CDB),
 
 	IWL_DEV_INFO(iwl9560_2ac_cfg_soc, iwl9560_160_name, MAC_TYPE(PU),
 		     RF_TYPE(JF2), RF_ID(JF),
-		     BW_NO_LIMIT, CORES(BT), NO_CDB),
+		     BW_NOT_LIMITED, CORES(BT), NO_CDB),
 	IWL_DEV_INFO(iwl9560_2ac_cfg_soc_80mhz, iwl9560_name, MAC_TYPE(PU),
 		     RF_TYPE(JF2), RF_ID(JF),
 		     BW_LIMITED, CORES(BT), NO_CDB),
 
 	IWL_DEV_INFO(iwl9260_2ac_cfg, iwl9270_160_name, DEVICE(0x2526),
 		     MAC_TYPE(TH), RF_TYPE(JF2),
-		     BW_NO_LIMIT, CORES(BT_GNSS), NO_CDB),
+		     BW_NOT_LIMITED, CORES(BT_GNSS), NO_CDB),
 	IWL_DEV_INFO(iwl9260_2ac_cfg_80mhz, iwl9270_name, DEVICE(0x2526),
 		     MAC_TYPE(TH), RF_TYPE(JF2),
 		     BW_LIMITED, CORES(BT_GNSS), NO_CDB),
 
 	IWL_DEV_INFO(iwl9260_2ac_cfg, iwl9162_160_name, DEVICE(0x271B),
 		     MAC_TYPE(TH), RF_TYPE(JF1),
-		     BW_NO_LIMIT, CORES(BT), NO_CDB),
+		     BW_NOT_LIMITED, CORES(BT), NO_CDB),
 	IWL_DEV_INFO(iwl9260_2ac_cfg_80mhz, iwl9162_name, DEVICE(0x271B),
 		     MAC_TYPE(TH), RF_TYPE(JF1),
 		     BW_LIMITED, CORES(BT), NO_CDB),
 
 	IWL_DEV_INFO(iwl9260_2ac_cfg, iwl9260_160_name, DEVICE(0x2526),
 		     MAC_TYPE(TH), RF_TYPE(JF2),
-		     BW_NO_LIMIT, CORES(BT), NO_CDB),
+		     BW_NOT_LIMITED, CORES(BT), NO_CDB),
 	IWL_DEV_INFO(iwl9260_2ac_cfg_80mhz, iwl9260_name, DEVICE(0x2526),
 		     MAC_TYPE(TH), RF_TYPE(JF2),
 		     BW_LIMITED, CORES(BT), NO_CDB),
@@ -924,14 +924,14 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 	/* Qu B step */
 	IWL_DEV_INFO(iwl9560_qu_jf_cfg, iwl9461_160_name,
 		     MAC_TYPE(QU), MAC_STEP(B), RF_TYPE(JF1), RF_ID(JF1),
-		     BW_NO_LIMIT, CORES(BT), NO_CDB),
+		     BW_NOT_LIMITED, CORES(BT), NO_CDB),
 	IWL_DEV_INFO(iwl9560_qu_jf_cfg_80mhz, iwl9461_name,
 		     MAC_TYPE(QU), MAC_STEP(B), RF_TYPE(JF1), RF_ID(JF1),
 		     BW_LIMITED, CORES(BT), NO_CDB),
 	IWL_DEV_INFO(iwl9560_qu_jf_cfg, iwl9462_160_name,
 		     MAC_TYPE(QU), MAC_STEP(B),
 		     RF_TYPE(JF1), RF_ID(JF1_DIV),
-		     BW_NO_LIMIT, CORES(BT), NO_CDB),
+		     BW_NOT_LIMITED, CORES(BT), NO_CDB),
 	IWL_DEV_INFO(iwl9560_qu_jf_cfg_80mhz, iwl9462_name,
 		     MAC_TYPE(QU), MAC_STEP(B),
 		     RF_TYPE(JF1), RF_ID(JF1_DIV),
@@ -940,7 +940,7 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 	IWL_DEV_INFO(iwl9560_qu_jf_cfg, iwl9560_160_name,
 		     MAC_TYPE(QU), MAC_STEP(B),
 		     RF_TYPE(JF2), RF_ID(JF),
-		     BW_NO_LIMIT, CORES(BT), NO_CDB),
+		     BW_NOT_LIMITED, CORES(BT), NO_CDB),
 	IWL_DEV_INFO(iwl9560_qu_jf_cfg_80mhz, iwl9560_name,
 		     MAC_TYPE(QU), MAC_STEP(B),
 		     RF_TYPE(JF2), RF_ID(JF),
@@ -955,7 +955,7 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 	IWL_DEV_INFO(iwl9560_qu_jf_cfg, iwl9461_160_name,
 		     MAC_TYPE(QU), MAC_STEP(C),
 		     RF_TYPE(JF1), RF_ID(JF1),
-		     BW_NO_LIMIT, CORES(BT), NO_CDB),
+		     BW_NOT_LIMITED, CORES(BT), NO_CDB),
 	IWL_DEV_INFO(iwl9560_qu_jf_cfg_80mhz, iwl9461_name,
 		     MAC_TYPE(QU), MAC_STEP(C),
 		     RF_TYPE(JF1), RF_ID(JF1),
@@ -963,14 +963,14 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 	IWL_DEV_INFO(iwl9560_qu_jf_cfg, iwl9462_160_name,
 		     MAC_TYPE(QU), MAC_STEP(C),
 		     RF_TYPE(JF1), RF_ID(JF1_DIV),
-		     BW_NO_LIMIT, CORES(BT), NO_CDB),
+		     BW_NOT_LIMITED, CORES(BT), NO_CDB),
 	IWL_DEV_INFO(iwl9560_qu_jf_cfg_80mhz, iwl9462_name,
 		     MAC_TYPE(QU), MAC_STEP(C),
 		     RF_TYPE(JF1), RF_ID(JF1_DIV),
 		     BW_LIMITED, CORES(BT), NO_CDB),
 
 	IWL_DEV_INFO(iwl9560_qu_jf_cfg, iwl9560_160_name, MAC_TYPE(QU),
-		     MAC_STEP(C), RF_TYPE(JF2), RF_ID(JF), BW_NO_LIMIT, CORES(BT), NO_CDB),
+		     MAC_STEP(C), RF_TYPE(JF2), RF_ID(JF), BW_NOT_LIMITED, CORES(BT), NO_CDB),
 	IWL_DEV_INFO(iwl9560_qu_jf_cfg_80mhz, iwl9560_name, MAC_TYPE(QU),
 		     MAC_STEP(C), RF_TYPE(JF2), RF_ID(JF), BW_LIMITED, CORES(BT),
 		     NO_CDB),
@@ -982,16 +982,16 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 
 	/* QuZ */
 	IWL_DEV_INFO(iwl9560_quz_a0_jf_b0_cfg, iwl9461_160_name, MAC_TYPE(QUZ),
-		     RF_TYPE(JF1), RF_ID(JF1), BW_NO_LIMIT, CORES(BT), NO_CDB),
+		     RF_TYPE(JF1), RF_ID(JF1), BW_NOT_LIMITED, CORES(BT), NO_CDB),
 	IWL_DEV_INFO(iwl9560_quz_a0_jf_b0_cfg_80mhz, iwl9461_name, MAC_TYPE(QUZ),
 		     RF_TYPE(JF1), RF_ID(JF1), BW_LIMITED, CORES(BT), NO_CDB),
 	IWL_DEV_INFO(iwl9560_quz_a0_jf_b0_cfg, iwl9462_160_name, MAC_TYPE(QUZ),
-		     RF_TYPE(JF1), RF_ID(JF1_DIV), BW_NO_LIMIT, CORES(BT), NO_CDB),
+		     RF_TYPE(JF1), RF_ID(JF1_DIV), BW_NOT_LIMITED, CORES(BT), NO_CDB),
 	IWL_DEV_INFO(iwl9560_quz_a0_jf_b0_cfg_80mhz, iwl9462_name, MAC_TYPE(QUZ),
 		     RF_TYPE(JF1), RF_ID(JF1_DIV), BW_LIMITED, CORES(BT), NO_CDB),
 
 	IWL_DEV_INFO(iwl9560_quz_a0_jf_b0_cfg, iwl9560_160_name, MAC_TYPE(QUZ),
-		     RF_TYPE(JF2), RF_ID(JF), BW_NO_LIMIT, CORES(BT), NO_CDB),
+		     RF_TYPE(JF2), RF_ID(JF), BW_NOT_LIMITED, CORES(BT), NO_CDB),
 	IWL_DEV_INFO(iwl9560_quz_a0_jf_b0_cfg_80mhz, iwl9560_name, MAC_TYPE(QUZ),
 		     RF_TYPE(JF2), RF_ID(JF), BW_LIMITED, CORES(BT), NO_CDB),
 
@@ -1013,7 +1013,7 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 	IWL_DEV_INFO(iwl_qu_hr_80mhz, iwl_ax203_name, MAC_TYPE(QU), MAC_STEP(C),
 		     RF_TYPE(HR2), BW_LIMITED, NO_CDB),
 	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name, MAC_TYPE(QU), MAC_STEP(C),
-		     RF_TYPE(HR2), BW_NO_LIMIT, NO_CDB),
+		     RF_TYPE(HR2), BW_NOT_LIMITED, NO_CDB),
 
 	/* QuZ */
 	IWL_DEV_INFO(iwl_qu_hr1, iwl_ax101_name, MAC_TYPE(QUZ),
@@ -1021,7 +1021,7 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 	IWL_DEV_INFO(iwl_qu_hr_80mhz, iwl_ax203_name, MAC_TYPE(QUZ),
 		     MAC_STEP(B), RF_TYPE(HR2), BW_LIMITED, NO_CDB),
 	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name, MAC_TYPE(QUZ),
-		     MAC_STEP(B), RF_TYPE(HR2), BW_NO_LIMIT, NO_CDB),
+		     MAC_STEP(B), RF_TYPE(HR2), BW_NOT_LIMITED, NO_CDB),
 
 /* Ma */
 	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax201_name, MAC_TYPE(MA), RF_TYPE(HR2),
@@ -1036,7 +1036,7 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 	IWL_DEV_INFO(iwl_cfg_so_a0_hr_a0_80mhz, iwl_ax101_name, MAC_TYPE(SO),
 		     RF_TYPE(HR1), BW_LIMITED, NO_CDB),
 	IWL_DEV_INFO(iwl_cfg_so_a0_hr_a0, iwl_ax201_name, MAC_TYPE(SO),
-		     RF_TYPE(HR2), BW_NO_LIMIT, NO_CDB),
+		     RF_TYPE(HR2), BW_NOT_LIMITED, NO_CDB),
 	IWL_DEV_INFO(iwl_cfg_so_a0_hr_a0, iwl_ax201_killer_1650i_name,
 		     DEVICE(0x51f0), SUBDEV(0x1652),
 		     MAC_TYPE(SO), RF_TYPE(HR2)),
@@ -1047,25 +1047,25 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 	IWL_DEV_INFO(iwl_cfg_so_a0_hr_a0_80mhz, iwl_ax101_name, MAC_TYPE(SOF),
 		     RF_TYPE(HR1), BW_LIMITED, NO_CDB),
 	IWL_DEV_INFO(iwl_cfg_so_a0_hr_a0, iwl_ax201_name, MAC_TYPE(SOF),
-		     RF_TYPE(HR2), BW_NO_LIMIT, NO_CDB),
+		     RF_TYPE(HR2), BW_NOT_LIMITED, NO_CDB),
 
 /* So-F with Gf */
 	IWL_DEV_INFO(iwlax211_2ax_cfg_so_gf_a0, iwl_ax211_name, MAC_TYPE(SOF),
-		     RF_TYPE(GF), BW_NO_LIMIT, NO_CDB),
+		     RF_TYPE(GF), BW_NOT_LIMITED, NO_CDB),
 	IWL_DEV_INFO(iwlax411_2ax_cfg_so_gf4_a0, iwl_ax411_name, MAC_TYPE(SOF),
-		     RF_TYPE(GF), BW_NO_LIMIT, CDB),
+		     RF_TYPE(GF), BW_NOT_LIMITED, CDB),
 
 /* SoF with JF2 */
 	IWL_DEV_INFO(iwlax210_2ax_cfg_so_jf_b0, iwl9560_160_name, MAC_TYPE(SOF),
-		     RF_TYPE(JF2), RF_ID(JF), BW_NO_LIMIT, CORES(BT), NO_CDB),
+		     RF_TYPE(JF2), RF_ID(JF), BW_NOT_LIMITED, CORES(BT), NO_CDB),
 	IWL_DEV_INFO(iwlax210_2ax_cfg_so_jf_b0_80mhz, iwl9560_name, MAC_TYPE(SOF),
 		     RF_TYPE(JF2), RF_ID(JF), BW_LIMITED, CORES(BT), NO_CDB),
 
 /* SoF with JF */
 	IWL_DEV_INFO(iwlax210_2ax_cfg_so_jf_b0, iwl9461_160_name, MAC_TYPE(SOF),
-		     RF_TYPE(JF1), RF_ID(JF1), BW_NO_LIMIT, CORES(BT), NO_CDB),
+		     RF_TYPE(JF1), RF_ID(JF1), BW_NOT_LIMITED, CORES(BT), NO_CDB),
 	IWL_DEV_INFO(iwlax210_2ax_cfg_so_jf_b0, iwl9462_160_name, MAC_TYPE(SOF),
-		     RF_TYPE(JF1), RF_ID(JF1_DIV), BW_NO_LIMIT, CORES(BT), NO_CDB),
+		     RF_TYPE(JF1), RF_ID(JF1_DIV), BW_NOT_LIMITED, CORES(BT), NO_CDB),
 	IWL_DEV_INFO(iwlax210_2ax_cfg_so_jf_b0_80mhz, iwl9461_name, MAC_TYPE(SOF),
 		     RF_TYPE(JF1), RF_ID(JF1), BW_LIMITED, CORES(BT), NO_CDB),
 	IWL_DEV_INFO(iwlax210_2ax_cfg_so_jf_b0_80mhz, iwl9462_name, MAC_TYPE(SOF),
@@ -1073,21 +1073,21 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 
 /* So with GF */
 	IWL_DEV_INFO(iwlax211_2ax_cfg_so_gf_a0, iwl_ax211_name, MAC_TYPE(SO),
-		     RF_TYPE(GF), BW_NO_LIMIT, NO_CDB),
+		     RF_TYPE(GF), BW_NOT_LIMITED, NO_CDB),
 	IWL_DEV_INFO(iwlax411_2ax_cfg_so_gf4_a0, iwl_ax411_name, MAC_TYPE(SO),
-		     RF_TYPE(GF), BW_NO_LIMIT, CDB),
+		     RF_TYPE(GF), BW_NOT_LIMITED, CDB),
 
 /* So with JF2 */
 	IWL_DEV_INFO(iwlax210_2ax_cfg_so_jf_b0, iwl9560_160_name, MAC_TYPE(SO),
-		     RF_TYPE(JF2), RF_ID(JF), BW_NO_LIMIT, CORES(BT), NO_CDB),
+		     RF_TYPE(JF2), RF_ID(JF), BW_NOT_LIMITED, CORES(BT), NO_CDB),
 	IWL_DEV_INFO(iwlax210_2ax_cfg_so_jf_b0_80mhz, iwl9560_name, MAC_TYPE(SO),
 		     RF_TYPE(JF2), RF_ID(JF), BW_LIMITED, CORES(BT), NO_CDB),
 
 /* So with JF */
 	IWL_DEV_INFO(iwlax210_2ax_cfg_so_jf_b0, iwl9461_160_name, MAC_TYPE(SO),
-		     RF_TYPE(JF1), RF_ID(JF1), BW_NO_LIMIT, CORES(BT), NO_CDB),
+		     RF_TYPE(JF1), RF_ID(JF1), BW_NOT_LIMITED, CORES(BT), NO_CDB),
 	IWL_DEV_INFO(iwlax210_2ax_cfg_so_jf_b0, iwl9462_160_name, MAC_TYPE(SO),
-		     RF_TYPE(JF1), RF_ID(JF1_DIV), BW_NO_LIMIT, CORES(BT), NO_CDB),
+		     RF_TYPE(JF1), RF_ID(JF1_DIV), BW_NOT_LIMITED, CORES(BT), NO_CDB),
 	IWL_DEV_INFO(iwlax210_2ax_cfg_so_jf_b0_80mhz, iwl9461_name, MAC_TYPE(SO),
 		     RF_TYPE(JF1), RF_ID(JF1), BW_LIMITED, CORES(BT), NO_CDB),
 	IWL_DEV_INFO(iwlax210_2ax_cfg_so_jf_b0_80mhz, iwl9462_name, MAC_TYPE(SO),
@@ -1114,7 +1114,7 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 
 /* Ga (Gl) */
 	IWL_DEV_INFO(iwl_cfg_bz, iwl_gl_name, MAC_TYPE(GL), RF_TYPE(FM),
-		     BW_NO_LIMIT, NO_CDB),
+		     BW_NOT_LIMITED, NO_CDB),
 	IWL_DEV_INFO(iwl_cfg_bz_160mhz, iwl_mtp_name, MAC_TYPE(GL), RF_TYPE(FM),
 		     BW_LIMITED, NO_CDB),
 
@@ -1122,21 +1122,21 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 	IWL_DEV_INFO(iwl_cfg_sc, iwl_ax211_name, MAC_TYPE(SC), RF_TYPE(GF)),
 	IWL_DEV_INFO(iwl_cfg_sc, iwl_fm_name, MAC_TYPE(SC), RF_TYPE(FM)),
 	IWL_DEV_INFO(iwl_cfg_sc, iwl_wh_name, MAC_TYPE(SC), RF_TYPE(WH),
-		     BW_NO_LIMIT),
+		     BW_NOT_LIMITED),
 	IWL_DEV_INFO(iwl_cfg_sc_160mhz, iwl_sp_name, MAC_TYPE(SC), RF_TYPE(WH),
 		     BW_LIMITED),
 	IWL_DEV_INFO(iwl_cfg_sc, iwl_pe_name, MAC_TYPE(SC), RF_TYPE(PE)),
 	IWL_DEV_INFO(iwl_cfg_sc, iwl_ax211_name, MAC_TYPE(SC2), RF_TYPE(GF)),
 	IWL_DEV_INFO(iwl_cfg_sc, iwl_fm_name, MAC_TYPE(SC2), RF_TYPE(FM)),
 	IWL_DEV_INFO(iwl_cfg_sc, iwl_wh_name, MAC_TYPE(SC2), RF_TYPE(WH),
-		     BW_NO_LIMIT),
+		     BW_NOT_LIMITED),
 	IWL_DEV_INFO(iwl_cfg_sc_160mhz, iwl_sp_name, MAC_TYPE(SC2), RF_TYPE(WH),
 		     BW_LIMITED),
 	IWL_DEV_INFO(iwl_cfg_sc, iwl_pe_name, MAC_TYPE(SC2), RF_TYPE(PE)),
 	IWL_DEV_INFO(iwl_cfg_sc, iwl_ax211_name, MAC_TYPE(SC2F), RF_TYPE(GF)),
 	IWL_DEV_INFO(iwl_cfg_sc, iwl_fm_name, MAC_TYPE(SC2F), RF_TYPE(FM)),
 	IWL_DEV_INFO(iwl_cfg_sc, iwl_wh_name, MAC_TYPE(SC2F), RF_TYPE(WH),
-		     BW_NO_LIMIT),
+		     BW_NOT_LIMITED),
 	IWL_DEV_INFO(iwl_cfg_sc_160mhz, iwl_sp_name, MAC_TYPE(SC2F), RF_TYPE(WH),
 		     BW_LIMITED),
 	IWL_DEV_INFO(iwl_cfg_sc, iwl_pe_name, MAC_TYPE(SC2F), RF_TYPE(PE)),
-- 
2.34.1


