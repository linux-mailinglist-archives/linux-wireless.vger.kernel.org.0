Return-Path: <linux-wireless+bounces-18526-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A80AA28AFD
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 13:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB17318833B6
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 12:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B07C8634E;
	Wed,  5 Feb 2025 12:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SOX/xZx0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FB977F11
	for <linux-wireless@vger.kernel.org>; Wed,  5 Feb 2025 12:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738760180; cv=none; b=s4fZDOniceWaOjQ+Fg8Hl8iE1AjqtOaITJVVkHaAsfAUBBUGwNdEj6sSGKftKql7fsd09dwYJ+kZvEuVcQHG+68JUbyolcdV0g7q+hSBFQhW192w0r8DL1WXo+vbi6rcKUnfJfADa6XPwi4mlfmO1sPbhuwOHRcw7Hs1pwGH8pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738760180; c=relaxed/simple;
	bh=WJjz4ZYq0aq0UHRt1RyZtFA/CQ1JHr9s7LqWtHdpxhI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MSEpSW1T4MeXkIwqRZcUvs8hD8oa5FU5xcVTJk04H1Ic1QM05wh3jsid/LZjl/NgKMfQMA72SRNpQxOU5hu58Cg04t+zKbf2pDdWGEfsACK5F66toBn8lTE+bfAxUzc1XblX81DsNTFALsZvoiCkt64JW/bqSqiViNeXWvN7mwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SOX/xZx0; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738760179; x=1770296179;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WJjz4ZYq0aq0UHRt1RyZtFA/CQ1JHr9s7LqWtHdpxhI=;
  b=SOX/xZx0C0tOovmmqam+M1qh6aFK51QibwZZs/0/LUq/kBxErJeJiZ9B
   7sVCeh4EAR7cBpWGN/hbyp1CnJPyrzBQKbcAgsf2WYtBFpN6lTXhI/SVG
   wUi4yTlhTQQuri0rk3CCG0WwNhBN+q05pcG/LLzDbcUxQJvy0BQ93mfru
   mVUmPdwIlaQOXW0lNdhmj6TR6ri4aIdp62TKaII4RWe3IWsMm9Z+YyiiC
   bjRhCWviMFunU+GvLfKZ6O1Kxh/Zuof6VY9/mXqa86ShNyANCVOVdSFaa
   C+IBQKZ3DX3T9cnDGVweaaiDRkoaGHkpOFN+RLafu65CYUFB1SZOOUVYW
   A==;
X-CSE-ConnectionGUID: 5H7PlJNQRrKjU3DTfaiKCA==
X-CSE-MsgGUID: n70Yssd5RkyJAugSbaexVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="42159189"
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="42159189"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 04:56:18 -0800
X-CSE-ConnectionGUID: 9Ht8EoLgSsKK7t2vRwZ3BA==
X-CSE-MsgGUID: HYl9FZX2SAKojVeQLMh8Zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="110745467"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 04:56:17 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 08/19] wifi: iwlwifi: cfg: separate 22000/BZ family HT params
Date: Wed,  5 Feb 2025 14:55:37 +0200
Message-Id: <20250205145347.1d6186c23bee.I3c61a6c9e0db3ba6eea4dac63e1547945ad01703@changeid>
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

From: Johannes Berg <johannes.berg@intel.com>

We're adding a new IWLMLD opmode for just BZ and later
devices. If that's enabled but IWLMVM isn't, the build
fails because 22000 family configs aren't built but BZ
and later refer to it. Rather than trying to make some
new file to build it in all cases, just copy the small
struct.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c     | 9 ++++++++-
 drivers/net/wireless/intel/iwlwifi/cfg/dr.c     | 2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c     | 2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-config.h | 2 ++
 4 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
index efa3e0e35f79..c6aa3f220f8e 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
@@ -50,6 +50,13 @@ static const struct iwl_base_params iwl_bz_base_params = {
 	.pcie_l1_allowed = true,
 };
 
+const struct iwl_ht_params iwl_bz_ht_params = {
+	.stbc = true,
+	.ldpc = true,
+	.ht40_bands = BIT(NL80211_BAND_2GHZ) | BIT(NL80211_BAND_5GHZ) |
+		      BIT(NL80211_BAND_6GHZ),
+};
+
 #define IWL_DEVICE_BZ_COMMON						\
 	.ucode_api_max = IWL_BZ_UCODE_API_MAX,			\
 	.ucode_api_min = IWL_BZ_UCODE_API_MIN,			\
@@ -113,7 +120,7 @@ static const struct iwl_base_params iwl_bz_base_params = {
 
 #define IWL_DEVICE_BZ							\
 	IWL_DEVICE_BZ_COMMON,						\
-	.ht_params = &iwl_22000_ht_params
+	.ht_params = &iwl_bz_ht_params
 
 /*
  * This size was picked according to 8 MSDUs inside 512 A-MSDUs in an
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/dr.c b/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
index ab7c0f8d54f4..69176b59b4de 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
@@ -114,7 +114,7 @@ static const struct iwl_base_params iwl_dr_base_params = {
 	.uhb_supported = true,						\
 	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,		\
 	.num_rbds = IWL_NUM_RBDS_DR_EHT,				\
-	.ht_params = &iwl_22000_ht_params
+	.ht_params = &iwl_bz_ht_params
 
 /*
  * This size was picked according to 8 MSDUs inside 512 A-MSDUs in an
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
index c9eeb3f6704e..eee47af728d7 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
@@ -121,7 +121,7 @@ static const struct iwl_base_params iwl_sc_base_params = {
 	.uhb_supported = true,						\
 	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,		\
 	.num_rbds = IWL_NUM_RBDS_SC_EHT,				\
-	.ht_params = &iwl_22000_ht_params
+	.ht_params = &iwl_bz_ht_params
 
 /*
  * This size was picked according to 8 MSDUs inside 512 A-MSDUs in an
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 2b6a80142aba..758f8e70050a 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -663,6 +663,8 @@ extern const struct iwl_cfg iwl_cfg_ma;
 extern const struct iwl_cfg iwl_cfg_so_a0_hr_a0;
 extern const struct iwl_cfg iwl_cfg_quz_a0_hr_b0;
 
+extern const struct iwl_ht_params iwl_bz_ht_params;
+
 extern const struct iwl_cfg iwl_cfg_bz;
 extern const struct iwl_cfg iwl_cfg_gl;
 
-- 
2.34.1


