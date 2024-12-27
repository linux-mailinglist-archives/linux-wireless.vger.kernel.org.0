Return-Path: <linux-wireless+bounces-16825-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A7B9FD1B4
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Dec 2024 09:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CF393A0610
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Dec 2024 08:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FBCA920;
	Fri, 27 Dec 2024 08:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k6hPy3k7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9470014F9EB
	for <linux-wireless@vger.kernel.org>; Fri, 27 Dec 2024 08:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735286493; cv=none; b=iZ9k9YRsvP6zlXFtX0T3/w/CRNesTZrZ55zI9/cmbUC6LXhp/n8OZ1vt6/rNSZ0IWiWTH67yMiI9SaUBN1mEIBPGh5089PY+hvFVcJi15r5scdjvVSss8YYYEWG/E75gjd/ch9Yeau+ok9DFPjKORsucsP6gFL1fhCIl+OJdess=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735286493; c=relaxed/simple;
	bh=Dml2nOSEo+WWxUod3I2RIFdbNmxclSaciKapqZlToLQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k9ZTNQEKR/+5wqYp7tOm7qYpwlYt/7baEPHSp2vDsI7XUd913y/TpUYdG9k1gUEMk4btgcQswBjXFpRRTrNTBuMAwe/krFN4WfPfaQ3v4NL3oBAp8LEelgLycqa+lfsqgGBt2Dxb7KPuZSAHqtY9u0Wf8U7XNa7lXbKMYtyn9Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k6hPy3k7; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735286491; x=1766822491;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Dml2nOSEo+WWxUod3I2RIFdbNmxclSaciKapqZlToLQ=;
  b=k6hPy3k72HyQ3teegoMOR6C/p4safogfdXWhC7bbwzwU3Lg2Q/HtCi/f
   2GmYCh1vl80myysuF9FYP17HkzLh2sbVbUN5IA1WcjORjYIA+VcMFl6aK
   vMjZs6YMqLvryQUoxfIOTu4/jfr5RyycUzGtGIGktD8YqjTww2HluXsxq
   xJ7AksXaolV9utSgh8pJhXP8nU6GoS61dr1TdISBoj8i46XadsvdhhAhm
   MmVjpZ1ChDKjNhSMUUbAhHf0flaXEMC+OKzCmPZWyfd6pzcK915H9sfVK
   j7i3LVfJHaGvguCxNGnI8XhXMq0TU7Pma+9rY+0tRRi2V6B1LPNvBmd+f
   Q==;
X-CSE-ConnectionGUID: 0p2FL+OZQweqkYpuBZ8dVQ==
X-CSE-MsgGUID: LOSZNKjnTw2lJwHlc9Njyw==
X-IronPort-AV: E=McAfee;i="6700,10204,11297"; a="46690922"
X-IronPort-AV: E=Sophos;i="6.12,268,1728975600"; 
   d="scan'208";a="46690922"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2024 00:01:31 -0800
X-CSE-ConnectionGUID: nBjmL4JmR6OCsrLj81dbMA==
X-CSE-MsgGUID: W3sC47MGRSerMxHwRL7rPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,268,1728975600"; 
   d="scan'208";a="99858233"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2024 00:01:29 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 04/17] wifi: iwlwifi: mvm: rename iwl_dev_tx_power_common::mac_context_id
Date: Fri, 27 Dec 2024 10:00:59 +0200
Message-Id: <20241227095718.f1155e713201.I753900d10e82f339cf9679ed403027d38dc1fd58@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241227080112.1098419-1-miriam.rachel.korenblit@intel.com>
References: <20241227080112.1098419-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

This is becoming the link_id. Since this makes no difference on non-MLD
devices, just rename to link_id for all the APIs that use the common
structure.

Starting from command 9, feed the link_id to the firmware instead of the
mac id.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/power.h  |  8 +++++---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c  | 18 +++++++++++++-----
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/power.h b/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
index df0680eae30c..37ec26596ee7 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
@@ -266,7 +266,7 @@ struct iwl_reduce_tx_power_cmd {
 } __packed; /* TX_REDUCED_POWER_API_S_VER_1 */
 
 enum iwl_dev_tx_power_cmd_mode {
-	IWL_TX_POWER_MODE_SET_MAC = 0,
+	IWL_TX_POWER_MODE_SET_LINK = 0,
 	IWL_TX_POWER_MODE_SET_DEVICE = 1,
 	IWL_TX_POWER_MODE_SET_CHAINS = 2,
 	IWL_TX_POWER_MODE_SET_ACK = 3,
@@ -283,12 +283,14 @@ enum iwl_dev_tx_power_cmd_mode {
 /**
  * struct iwl_dev_tx_power_common - Common part of the TX power reduction cmd
  * @set_mode: see &enum iwl_dev_tx_power_cmd_mode
- * @mac_context_id: id of the mac ctx for which we are reducing TX power.
+ * @link_id: id of the link ctx for which we are reducing TX power.
+ *	For version 9 / 10, this is the link id. For earlier versions, it is
+ *	the mac id.
  * @pwr_restriction: TX power restriction in 1/8 dBms.
  */
 struct iwl_dev_tx_power_common {
 	__le32 set_mode;
-	__le32 mac_context_id;
+	__le32 link_id;
 	__le16 pwr_restriction;
 } __packed;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index cd93fbf40eb6..ca6c40954e9d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1485,11 +1485,12 @@ int iwl_mvm_set_tx_power(struct iwl_mvm *mvm,
 			 s16 tx_power)
 {
 	u32 cmd_id = REDUCE_TX_POWER_CMD;
-	u32 mac_id = iwl_mvm_vif_from_mac80211(link_conf->vif)->id;
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(link_conf->vif);
+	u32 mac_id = mvmvif->id;
 	int len;
 	struct iwl_dev_tx_power_cmd_v3_v8 cmd = {
-		.common.set_mode = cpu_to_le32(IWL_TX_POWER_MODE_SET_MAC),
-		.common.mac_context_id = cpu_to_le32(mac_id),
+		.common.set_mode = cpu_to_le32(IWL_TX_POWER_MODE_SET_LINK),
+		.common.link_id = cpu_to_le32(mac_id),
 	};
 	struct iwl_dev_tx_power_cmd cmd_v9_v10;
 	u8 cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw, cmd_id, 3);
@@ -1500,9 +1501,16 @@ int iwl_mvm_set_tx_power(struct iwl_mvm *mvm,
 	cmd.common.pwr_restriction = cpu_to_le16(u_tx_power);
 
 	if (cmd_ver > 8) {
+		u32 link_id;
+
+		if (WARN_ON(!mvmvif->link[link_conf->link_id]))
+			return -ENODEV;
+
+		link_id = mvmvif->link[link_conf->link_id]->fw_link_id;
+
 		/* Those fields sit on the same place for v9 and v10 */
-		cmd_v9_v10.common.set_mode = cpu_to_le32(IWL_TX_POWER_MODE_SET_MAC);
-		cmd_v9_v10.common.mac_context_id = cpu_to_le32(mac_id);
+		cmd_v9_v10.common.set_mode = cpu_to_le32(IWL_TX_POWER_MODE_SET_LINK);
+		cmd_v9_v10.common.link_id = cpu_to_le32(link_id);
 		cmd_v9_v10.common.pwr_restriction = cpu_to_le16(u_tx_power);
 		cmd_data = &cmd_v9_v10;
 	}
-- 
2.34.1


