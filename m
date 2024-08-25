Return-Path: <linux-wireless+bounces-11908-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBADC95E444
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Aug 2024 18:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93A672817A5
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Aug 2024 16:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231DE16C6A6;
	Sun, 25 Aug 2024 16:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="evXab46a"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D16A15B108
	for <linux-wireless@vger.kernel.org>; Sun, 25 Aug 2024 16:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724602650; cv=none; b=ktLhtDY/TxsCq1Q+B40nv72JpfiY4UlhONfEDWjgWv2DYYAfZDKcGOMEvzHaj/CyBS+n+ff5C/DbY5H8WBG8Yk4mj9oUa5S4DlcJbH1T/T2JoLWYMsuHGS7t8KkmZPhop0PUd5uzJR7fHuDe6UGCSJGsVj0jAHpF0M+UsxqVN5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724602650; c=relaxed/simple;
	bh=6Kts3oIxkH6mXSXB5TdQhv4gczf++rmG/lW82lT0mrs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L6ownP5lc3iDqjhyfg8WNF9VnkO9i1AVTrzUVLBFcJQfdv0k3KRX2VAnWzTMMxA363CXfTl3LX5CKtmfcc+xeb/EAU4BEHynQX8hzJmQFh96LtVg7P4w+B9C/8y6xApQrRSnFYrmvFgahAkjCu4sBAoIVQ7ZuaxRpiQ41DRBKxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=evXab46a; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724602648; x=1756138648;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6Kts3oIxkH6mXSXB5TdQhv4gczf++rmG/lW82lT0mrs=;
  b=evXab46apUByNgVDlDvRL8P9dbBNAlWwYQdGPkZ6+XlkqwIPfE/Zshug
   JwUWrF/764MkITnXYdNn3zEJDomqixJK1iH023y+ksBKPz2D7ZD+emUc1
   3AS3YE84wmPeuXt1HJOeQJiVptlAEcYhp3dzNkR5cu7iaBjOQlUGOBGnb
   SlEV2RomowQ6aQk2pOWEUDWuD5EAJJqpgDESCICYtvkrYP5xqaU4i3eIl
   FUZ8dtxsHwBNqp5i41UZZ/PL7yd1FErOn0Vzpmm9wM+4QgB3iA8Vj92fx
   HPW/DOJ3Ni9Fq1MDgku88O2AWZ66LPmTB/410tG49Ovwsy1fkhnChZjfE
   A==;
X-CSE-ConnectionGUID: aV+FAgUfSKq1DJtAgABrQg==
X-CSE-MsgGUID: bbgtuPX6SV2sKlucRtv3nQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11175"; a="22544121"
X-IronPort-AV: E=Sophos;i="6.10,175,1719903600"; 
   d="scan'208";a="22544121"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2024 09:17:27 -0700
X-CSE-ConnectionGUID: JlXoksXzShmFgfFZXzVhRQ==
X-CSE-MsgGUID: kRCUmTxuRSC/pSvEkXAong==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,175,1719903600"; 
   d="scan'208";a="62999732"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2024 09:17:26 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 03/13] wifi: iwlwifi: mvm: replace CONFIG_PM by CONFIG_PM_SLEEP
Date: Sun, 25 Aug 2024 19:17:03 +0300
Message-Id: <20240825191257.44e47ba584de.I64f985d0405345252b76b7157291b79677abd64d@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240825161713.3547021-1-miriam.rachel.korenblit@intel.com>
References: <20240825161713.3547021-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

Replace the ifdef CONFIG_PM by CONFIG_PM_SLEEP. CONFIG_PM was useful
when we had CONFIG_PM_RUNTIME but that was removed long ago.
Use PM_SLEEP consistently across the driver.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/Makefile   | 2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 4 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h      | 6 +++---
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c      | 7 +++++--
 4 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/Makefile b/drivers/net/wireless/intel/iwlwifi/mvm/Makefile
index 8873904f51ec..59751f123571 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/Makefile
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/Makefile
@@ -13,7 +13,7 @@ iwlmvm-y += ptp.o
 iwlmvm-y += time-sync.o
 iwlmvm-$(CONFIG_IWLWIFI_DEBUGFS) += debugfs.o debugfs-vif.o
 iwlmvm-$(CONFIG_IWLWIFI_LEDS) += led.o
-iwlmvm-$(CONFIG_PM) += d3.o
+iwlmvm-$(CONFIG_PM_SLEEP) += d3.o
 iwlmvm-$(CONFIG_IWLMEI) += vendor-cmd.o
 
 subdir-ccflags-y += -I $(src)/../
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 835a05b91833..7236ff7277ce 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1241,7 +1241,7 @@ int __iwl_mvm_mac_start(struct iwl_mvm *mvm)
 		mvm->nvm_data = NULL;
 	}
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 	/* fast_resume will be cleared by iwl_mvm_fast_resume */
 	fast_resume = mvm->fast_resume;
 
@@ -1263,7 +1263,7 @@ int __iwl_mvm_mac_start(struct iwl_mvm *mvm)
 			set_bit(IWL_MVM_STATUS_FIRMWARE_RUNNING, &mvm->status);
 		}
 	}
-#endif /* CONFIG_PM */
+#endif /* CONFIG_PM_SLEEP */
 
 	if (test_bit(IWL_MVM_STATUS_HW_RESTART_REQUESTED, &mvm->status)) {
 		/*
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 22f48b66d79c..78af0a167730 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -508,7 +508,7 @@ struct iwl_mvm_vif {
 	bool bf_enabled;
 	bool ba_enabled;
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 	/* WoWLAN GTK rekey data */
 	struct {
 		u8 kck[NL80211_KCK_EXT_LEN];
@@ -1176,7 +1176,7 @@ struct iwl_mvm {
 
 	struct ieee80211_vif *p2p_device_vif;
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 	struct wiphy_wowlan_support wowlan;
 	int gtk_ivlen, gtk_icvlen, ptk_ivlen, ptk_icvlen;
 
@@ -2291,7 +2291,7 @@ void iwl_mvm_ipv6_addr_change(struct ieee80211_hw *hw,
 void iwl_mvm_set_default_unicast_key(struct ieee80211_hw *hw,
 				     struct ieee80211_vif *vif, int idx);
 extern const struct file_operations iwl_dbgfs_d3_test_ops;
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 void iwl_mvm_set_last_nonqos_seq(struct iwl_mvm *mvm,
 				 struct ieee80211_vif *vif);
 void iwl_mvm_fast_suspend(struct iwl_mvm *mvm);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 75fc60a4808c..1cc5667340e8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -2090,6 +2090,7 @@ static void iwl_op_mode_mvm_time_point(struct iwl_op_mode *op_mode,
 	iwl_dbg_tlv_time_point(&mvm->fwrt, tp_id, tp_data);
 }
 
+#ifdef CONFIG_PM_SLEEP
 static void iwl_op_mode_mvm_device_powered_off(struct iwl_op_mode *op_mode)
 {
 	struct iwl_mvm *mvm = IWL_OP_MODE_GET_MVM(op_mode);
@@ -2098,11 +2099,13 @@ static void iwl_op_mode_mvm_device_powered_off(struct iwl_op_mode *op_mode)
 	clear_bit(IWL_MVM_STATUS_IN_D3, &mvm->status);
 	mvm->trans->system_pm_mode = IWL_PLAT_PM_MODE_DISABLED;
 	iwl_mvm_stop_device(mvm);
-#ifdef CONFIG_PM
 	mvm->fast_resume = false;
-#endif
 	mutex_unlock(&mvm->mutex);
 }
+#else
+static void iwl_op_mode_mvm_device_powered_off(struct iwl_op_mode *op_mode)
+{}
+#endif
 
 #define IWL_MVM_COMMON_OPS					\
 	/* these could be differentiated */			\
-- 
2.34.1


