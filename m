Return-Path: <linux-wireless+bounces-14594-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2C99B2F62
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Oct 2024 12:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 196BCB21EAE
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Oct 2024 11:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01D01D932F;
	Mon, 28 Oct 2024 11:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QcZhAfjZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611EB1D8E0F
	for <linux-wireless@vger.kernel.org>; Mon, 28 Oct 2024 11:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730116528; cv=none; b=u2/ia6VkVyBtRxOYCF7I440pGSIMN1bLthV9JdwO9inm9HNkG7suZJmsPlk458DLE4HBwdGKyvxLYv+OgcKr19Agedde/v2fLmgnP31jD0VzDsMidMZN1EG9ZViL6PCwcWt193PPf0NuMgiVPnTWd1CU7+UARq/0mWw/yzb8KbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730116528; c=relaxed/simple;
	bh=NWL/UsHCibM7WvSuOoWT4K0wx/5qCZ4aDYw4QuItpQ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fANsTmSW8EsOeeFCuiObDl/r14cR5thPSPosG/IqW4I5tgNcZkZACPrcyUM6iSxqvoqa8z7iyS5/Jn1cF0rDu5atVV5hxF/oWlFbp+iPQ2UYBav4BZRF2dXNGZn9XitxyGGohRTULil4zlvTChJ8wfje3rKrfS26Q8zpScMDJOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QcZhAfjZ; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730116527; x=1761652527;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NWL/UsHCibM7WvSuOoWT4K0wx/5qCZ4aDYw4QuItpQ0=;
  b=QcZhAfjZkO3CosZufVAjzL0flkteS15Hn0KGEZtRfVkSSCpbC5MGpisR
   YtJT3ZRCWNe1wHNCp9Gtm1R30ksacgONgUbJNq3trAn/icaEht06CX9fi
   UoZ9/cbEOFpweMMblFDOXtJy6B4yvHF2b4lQI/orBBZCN34MXAfP6N/uI
   2NIpycQNbjBE3cN5myhjTsdQv+dsXokwMhCXaLFp0H/hKPTihqq7jY9Ic
   OZgEI0ukSFeDb1Tnj21ojmGPJJ7wfdjgMq97eTSBd4PE0JzjVMIWEUwWc
   qutVYCvodolhS05aJ+AMSJSU+CMGs7l9ilqLYIP3phYyiSE6Ic4dowqEk
   A==;
X-CSE-ConnectionGUID: dqoVpLAPSb6V8MOUq65qfg==
X-CSE-MsgGUID: 2xzMQ1GUTn+Mr9Phce5OMQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11238"; a="29813898"
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="29813898"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 04:55:26 -0700
X-CSE-ConnectionGUID: L7ecwLlNR2a7O1skyfG/2Q==
X-CSE-MsgGUID: LDRXoIQIQhS8z+KoPMunDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="112432588"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 04:55:23 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 06/15] wifi: iwlwifi: mvm: use wiphy locked debugfs for low-latency
Date: Mon, 28 Oct 2024 13:54:51 +0200
Message-Id: <20241028135215.c62e23392400.Ifcb652d324bc60b7144fdf277d7989bede9e54d5@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241028115500.351123-1-miriam.rachel.korenblit@intel.com>
References: <20241028115500.351123-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

This will call into the OMI control path soon, and that will
require the wiphy mutex to be held. The files are removed by
mac80211 under wiphy mutex, so we must use the wiphy-locked
debugfs for them.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/intel/iwlwifi/mvm/debugfs-vif.c  | 64 ++++++++++++++++---
 1 file changed, 55 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
index 25f07e00db42..261aca03682c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
@@ -463,11 +463,13 @@ static ssize_t iwl_dbgfs_os_device_timediff_read(struct file *file,
 	return simple_read_from_buffer(user_buf, count, ppos, buf, pos);
 }
 
-static ssize_t iwl_dbgfs_low_latency_write(struct ieee80211_vif *vif, char *buf,
-					   size_t count, loff_t *ppos)
+static ssize_t
+iwl_dbgfs_low_latency_write_handle(struct wiphy *wiphy, struct file *file,
+				   char *buf, size_t count, void *data)
 {
-	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
-	struct iwl_mvm *mvm = mvmvif->mvm;
+	struct ieee80211_hw *hw = wiphy_to_ieee80211_hw(wiphy);
+	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
+	struct ieee80211_vif *vif = data;
 	u8 value;
 	int ret;
 
@@ -484,12 +486,28 @@ static ssize_t iwl_dbgfs_low_latency_write(struct ieee80211_vif *vif, char *buf,
 	return count;
 }
 
-static ssize_t
-iwl_dbgfs_low_latency_force_write(struct ieee80211_vif *vif, char *buf,
-				  size_t count, loff_t *ppos)
+static ssize_t iwl_dbgfs_low_latency_write(struct file *file,
+					   const char __user *user_buf,
+					   size_t count, loff_t *ppos)
 {
+	struct ieee80211_vif *vif = file->private_data;
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	struct iwl_mvm *mvm = mvmvif->mvm;
+	char buf[10] = {};
+
+	return wiphy_locked_debugfs_write(mvm->hw->wiphy, file,
+					  buf, sizeof(buf), user_buf, count,
+					  iwl_dbgfs_low_latency_write_handle,
+					  vif);
+}
+
+static ssize_t
+iwl_dbgfs_low_latency_force_write_handle(struct wiphy *wiphy, struct file *file,
+					 char *buf, size_t count, void *data)
+{
+	struct ieee80211_hw *hw = wiphy_to_ieee80211_hw(wiphy);
+	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
+	struct ieee80211_vif *vif = data;
 	u8 value;
 	int ret;
 
@@ -517,6 +535,22 @@ iwl_dbgfs_low_latency_force_write(struct ieee80211_vif *vif, char *buf,
 	return count;
 }
 
+static ssize_t
+iwl_dbgfs_low_latency_force_write(struct file *file,
+				  const char __user *user_buf,
+				  size_t count, loff_t *ppos)
+{
+	struct ieee80211_vif *vif = file->private_data;
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	struct iwl_mvm *mvm = mvmvif->mvm;
+	char buf[10] = {};
+
+	return wiphy_locked_debugfs_write(mvm->hw->wiphy, file,
+					  buf, sizeof(buf), user_buf, count,
+					  iwl_dbgfs_low_latency_force_write_handle,
+					  vif);
+}
+
 static ssize_t iwl_dbgfs_low_latency_read(struct file *file,
 					  char __user *user_buf,
 					  size_t count, loff_t *ppos)
@@ -831,8 +865,20 @@ MVM_DEBUGFS_READ_FILE_OPS(mac_params);
 MVM_DEBUGFS_READ_FILE_OPS(tx_pwr_lmt);
 MVM_DEBUGFS_READ_WRITE_FILE_OPS(pm_params, 32);
 MVM_DEBUGFS_READ_WRITE_FILE_OPS(bf_params, 256);
-MVM_DEBUGFS_READ_WRITE_FILE_OPS(low_latency, 10);
-MVM_DEBUGFS_WRITE_FILE_OPS(low_latency_force, 10);
+
+static const struct file_operations iwl_dbgfs_low_latency_ops = {
+	.write = iwl_dbgfs_low_latency_write,
+	.read = iwl_dbgfs_low_latency_read,
+	.open = simple_open,
+	.llseek = generic_file_llseek,
+};
+
+static const struct file_operations iwl_dbgfs_low_latency_force_ops = {
+	.write = iwl_dbgfs_low_latency_force_write,
+	.open = simple_open,
+	.llseek = generic_file_llseek,
+};
+
 MVM_DEBUGFS_READ_WRITE_FILE_OPS(uapsd_misbehaving, 20);
 MVM_DEBUGFS_READ_WRITE_FILE_OPS(rx_phyinfo, 10);
 MVM_DEBUGFS_READ_WRITE_FILE_OPS(quota_min, 32);
-- 
2.34.1


