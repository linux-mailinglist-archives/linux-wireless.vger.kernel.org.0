Return-Path: <linux-wireless+bounces-27322-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A62A0B57310
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Sep 2025 10:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6FAC7A9859
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Sep 2025 08:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438A22EF662;
	Mon, 15 Sep 2025 08:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CEt2rZl5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48B92F0692
	for <linux-wireless@vger.kernel.org>; Mon, 15 Sep 2025 08:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757925318; cv=none; b=XOO+Aei7vIxCWKYiChZjaeiecwZIKNtYAUsE/i98N4wGwVR8yoNqAK+MtKuJsXqg42PqN4s5sQnY4JGY7dgH+z0n4+ig4I621/gYgShBYEN/rUi9GI00jsVN/EPN/vwAdOZVfSu0sNSfbZo8iGIHVzwDyr4kO3PoOszH2d92YKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757925318; c=relaxed/simple;
	bh=AzQldFAki2Ux5dOHbcoGdMfwzsRw1ZENQOj35rTHN6A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u+ExcWiDyaEHkEwyxJDGm2UZLeO31FpKuMSHHmQZqX1RyfdFfShN+lbg0+o4+b2Gpq82++rKji/JhEE2dECx5Fq9gnNU3qf+1DNNjFe6h6e4jvxuo3Xwuduv20JNQGemDXSO7a9Ik/D0GjxI54Zby170xuDTfjwEmFIJ1hy3xZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CEt2rZl5; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757925317; x=1789461317;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AzQldFAki2Ux5dOHbcoGdMfwzsRw1ZENQOj35rTHN6A=;
  b=CEt2rZl5yC8si5D3SfqqNtyHNBEQO11vx/jy1o2jdUzzG7CytbEYbFOf
   Kw87LM/xSZJxQZ5b/9wBcZIyOpn2xthf16h5d0nVyknPg5wi+VKP2PuKE
   pT6VN6j7rX6h10Ye2S/fhWGDQ2vG6kYCukNpCUoGWI/KhaG9RUUhH0z34
   xUlBXVnF7if+OB/JNZWQZxC591hhSI4oXbTagjMylHbSyq90NRhrrWY/F
   oyqLorsfALE8GSC8HP6/w9AxcYLFXicKOfJ8nmHF/n5P4ITtVdL2l3Rvw
   /HvXlZ/Ixy1nYeDaH8U6naK4x/7mQpDHaU0VYkHoQLRwQdO17XeM2kwe2
   w==;
X-CSE-ConnectionGUID: Y1s1+8gTQfuj5EFbvX/DTw==
X-CSE-MsgGUID: FL8uMqkBST6RB4mABPsxcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11553"; a="59213086"
X-IronPort-AV: E=Sophos;i="6.18,265,1751266800"; 
   d="scan'208";a="59213086"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 01:35:14 -0700
X-CSE-ConnectionGUID: BImM0faTTYSRfZH0k+nrUQ==
X-CSE-MsgGUID: aBCEgNLBQ36H38VOIAbmCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,265,1751266800"; 
   d="scan'208";a="178569909"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 01:35:13 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-next 10/11] wifi: iwlwifi: mld: support get/set_antenna
Date: Mon, 15 Sep 2025 11:34:31 +0300
Message-Id: <20250915113137.5a45baf9513c.I5912e6b6d9a9ae6530d0ac45e9517d07f98b8d05@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250915083432.1048608-1-miriam.rachel.korenblit@intel.com>
References: <20250915083432.1048608-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

This allows to set the antennas from user space.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/mld/mac80211.c | 34 +++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mld/mld.h  | 11 ++++++
 2 files changed, 45 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index 5725104a53bf..98d47fed8421 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -23,6 +23,7 @@
 #include "roc.h"
 #include "mlo.h"
 #include "stats.h"
+#include "iwl-nvm-parse.h"
 #include "ftm-initiator.h"
 #include "low_latency.h"
 #include "fw/api/scan.h"
@@ -2591,11 +2592,44 @@ iwl_mld_can_neg_ttlm(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	return NEG_TTLM_RES_ACCEPT;
 }
 
+static int iwl_mld_get_antenna(struct ieee80211_hw *hw, int radio_idx,
+			       u32 *tx_ant, u32 *rx_ant)
+{
+	struct iwl_mld *mld = IWL_MAC80211_GET_MLD(hw);
+
+	*tx_ant = iwl_mld_get_valid_tx_ant(mld);
+	*rx_ant = iwl_mld_get_valid_rx_ant(mld);
+
+	return 0;
+}
+
+static int iwl_mld_set_antenna(struct ieee80211_hw *hw, int radio_idx,
+			       u32 tx_ant, u32 rx_ant)
+{
+	struct iwl_mld *mld = IWL_MAC80211_GET_MLD(hw);
+
+	if (WARN_ON(!mld->nvm_data))
+		return -EBUSY;
+
+	/* mac80211 ensures the device is not started,
+	 * so the firmware cannot be running
+	 */
+
+	mld->set_tx_ant = tx_ant;
+	mld->set_rx_ant = rx_ant;
+
+	iwl_reinit_cab(mld->trans, mld->nvm_data, tx_ant, rx_ant, mld->fw);
+
+	return 0;
+}
+
 const struct ieee80211_ops iwl_mld_hw_ops = {
 	.tx = iwl_mld_mac80211_tx,
 	.start = iwl_mld_mac80211_start,
 	.stop = iwl_mld_mac80211_stop,
 	.config = iwl_mld_mac80211_config,
+	.get_antenna = iwl_mld_get_antenna,
+	.set_antenna = iwl_mld_set_antenna,
 	.add_interface = iwl_mld_mac80211_add_interface,
 	.remove_interface = iwl_mld_mac80211_remove_interface,
 	.conf_tx = iwl_mld_mac80211_conf_tx,
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mld.h b/drivers/net/wireless/intel/iwlwifi/mld/mld.h
index 94dc9da6360d..b1d44fdaa61b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mld.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mld.h
@@ -180,6 +180,8 @@
  * @mcast_filter_cmd: pointer to the multicast filter command.
  * @mgmt_tx_ant: stores the last TX antenna index; used for setting
  *	TX rate_n_flags for non-STA mgmt frames (toggles on every TX failure).
+ * @set_tx_ant: stores the last TX antenna bitmask set by user space (if any)
+ * @set_rx_ant: stores the last RX antenna bitmask set by user space (if any)
  * @fw_rates_ver_3: FW rates are in version 3
  * @low_latency: low-latency manager.
  * @tzone: thermal zone device's data
@@ -279,6 +281,9 @@ struct iwl_mld {
 
 	u8 mgmt_tx_ant;
 
+	u8 set_tx_ant;
+	u8 set_rx_ant;
+
 	bool fw_rates_ver_3;
 
 	struct iwl_mld_low_latency low_latency;
@@ -374,6 +379,9 @@ static inline u8 iwl_mld_get_valid_tx_ant(const struct iwl_mld *mld)
 	if (mld->nvm_data && mld->nvm_data->valid_tx_ant)
 		tx_ant &= mld->nvm_data->valid_tx_ant;
 
+	if (mld->set_tx_ant)
+		tx_ant &= mld->set_tx_ant;
+
 	return tx_ant;
 }
 
@@ -384,6 +392,9 @@ static inline u8 iwl_mld_get_valid_rx_ant(const struct iwl_mld *mld)
 	if (mld->nvm_data && mld->nvm_data->valid_rx_ant)
 		rx_ant &= mld->nvm_data->valid_rx_ant;
 
+	if (mld->set_rx_ant)
+		rx_ant &= mld->set_rx_ant;
+
 	return rx_ant;
 }
 
-- 
2.34.1


