Return-Path: <linux-wireless+bounces-22778-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 275B5AB1106
	for <lists+linux-wireless@lfdr.de>; Fri,  9 May 2025 12:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52C484C3AA9
	for <lists+linux-wireless@lfdr.de>; Fri,  9 May 2025 10:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8827028FFDB;
	Fri,  9 May 2025 10:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XWSgCt9a"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CB428FFD4
	for <linux-wireless@vger.kernel.org>; Fri,  9 May 2025 10:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746787523; cv=none; b=SymZBh3whFjTM/1M0QBr8tPCTwJClBm0EBncAPcUlky99H4hFDAFjCr9rEdBwaOdKPrXdt4cdAYBkabsRBAQErzKuwnQvEYgLAF377CYuBDR+psxA8nD4NAZTiSmwEcfOzydB1CPEAdJQh3vVpvQCM9g+KTof8DqMwVOLIbP88g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746787523; c=relaxed/simple;
	bh=8SGowftuOPTNDKE0VG4Xo1rWJcpMArwL4XRimXuc+WQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dkHZU4Vgh/jyeEMYQ/JmWmRS/CfKKs+t64SnUO5zVA/GjEFxDVZWceUaNbe6REoihnMTb0aB/GusuNiDIxyljW3cajlvzYxRIl8UsGI0VXY5io0X5awgv7FTv/n6ZQ6PHJ34vl1UkBnsuFZqtUbbiqmoDA8gNhONvArxysLigpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XWSgCt9a; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746787522; x=1778323522;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8SGowftuOPTNDKE0VG4Xo1rWJcpMArwL4XRimXuc+WQ=;
  b=XWSgCt9a84iyog/WPuhWZjEDChUdNYINiyZ+IQNi7YX2v24ha6We8qvV
   hpDmidJNd+ZSjBt2+Wob+8U8hnSR/W6wEIyDS8sH2sNtELqX2SNe9qelC
   hmISyjHNkRKYdq8E3HaDigTn1OK8c0WGT4PfzMZVZ5HuI3TxHDvZH01BW
   AoRLzaNP4HqXFBgwwzR/nykWUAlDYsmZzA8kkKpfCOJ0rNHcgxJS3Proe
   4nwfT7rIoWcwvG2T6WbygkWCWYc98obBstX5gglGbLgpB6DIesGrGejdi
   OVJ5Gggxg0/e/nPcduCdDO3o8PiKgo3M3CMc/VFFLxq+YLanQoR5Qg1b8
   A==;
X-CSE-ConnectionGUID: s/bq5uw0Qh+g1VjHS7761g==
X-CSE-MsgGUID: xSpFnzdpQHWeZCpoktMykw==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="59239901"
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
   d="scan'208";a="59239901"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 03:45:21 -0700
X-CSE-ConnectionGUID: k+a1A4RpSPicsSY6XquU6g==
X-CSE-MsgGUID: lqpAmQTSQm6Zkm9W3I+iHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
   d="scan'208";a="136537044"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 03:45:21 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Subject: [PATCH iwlwifi-next 10/15] wifi: iwlwifi: mld: Fix ROC activity cleanup in iwl_mld_vif
Date: Fri,  9 May 2025 13:44:49 +0300
Message-Id: <20250509104454.2582160-11-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250509104454.2582160-1-miriam.rachel.korenblit@intel.com>
References: <20250509104454.2582160-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>

The roc_activity member in the iwl_mld_vif structure was previously
set to zero during cleanup as was present in struct_group, which
incorrectly indicated ROC_ACTIVITY_HOTSPOT.
To fix this issue, remove roc_activity member from struct_group.
Notify mac80211 of ROC expiration during vif cleanup to maintain
synchronization between the driver and mac80211.
While on it, update it's type to enum iwl_roc_activity.

Signed-off-by: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Message-Id: <20250509134302.ea3e1fb12595.If2a191ab496046b7e72e6df78ada398b564afeda@changeid>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/iface.c | 3 +++
 drivers/net/wireless/intel/iwlwifi/mld/iface.h | 7 ++++---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/iface.c b/drivers/net/wireless/intel/iwlwifi/mld/iface.c
index c083ba416d40..fdb7a3b3107d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/iface.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/iface.c
@@ -25,6 +25,9 @@ void iwl_mld_cleanup_vif(void *data, u8 *mac, struct ieee80211_vif *vif)
 	/* EMLSR is turned back on during recovery */
 	vif->driver_flags &= ~IEEE80211_VIF_EML_ACTIVE;
 
+	if (mld_vif->roc_activity != ROC_NUM_ACTIVITIES)
+		ieee80211_remain_on_channel_expired(mld->hw);
+
 	mld_vif->roc_activity = ROC_NUM_ACTIVITIES;
 
 	for_each_mld_vif_valid_link(mld_vif, link) {
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/iface.h b/drivers/net/wireless/intel/iwlwifi/mld/iface.h
index 1ae522431f3f..3437f0c422cf 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/iface.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/iface.h
@@ -10,6 +10,7 @@
 #include "link.h"
 #include "session-protect.h"
 #include "d3.h"
+#include "fw/api/time-event.h"
 
 enum iwl_mld_cca_40mhz_wa_status {
 	CCA_40_MHZ_WA_NONE,
@@ -125,8 +126,6 @@ struct iwl_mld_emlsr {
  *	Only valid for STA. (FIXME: needs to be per link)
  * @num_associated_stas: number of associated STAs. Relevant only for AP mode.
  * @ap_ibss_active: whether the AP/IBSS was started
- * @roc_activity: the id of the roc_activity running. Relevant for p2p device
- *	only. Set to %ROC_NUM_ACTIVITIES when not in use.
  * @cca_40mhz_workaround: When we are connected in 2.4 GHz and 40 MHz, and the
  *	environment is too loaded, we work around this by reconnecting to the
  *	same AP with 20 MHz. This manages the status of the workaround.
@@ -142,6 +141,8 @@ struct iwl_mld_emlsr {
  * @use_ps_poll: use ps_poll frames
  * @disable_bf: disable beacon filter
  * @dbgfs_slink: debugfs symlink for this interface
+ * @roc_activity: the id of the roc_activity running. Relevant for p2p device
+ *	only. Set to %ROC_NUM_ACTIVITIES when not in use.
  */
 struct iwl_mld_vif {
 	/* Add here fields that need clean up on restart */
@@ -153,7 +154,6 @@ struct iwl_mld_vif {
 		struct ieee80211_key_conf __rcu *bigtks[2];
 		u8 num_associated_stas;
 		bool ap_ibss_active;
-		u32 roc_activity;
 		enum iwl_mld_cca_40mhz_wa_status cca_40mhz_workaround;
 #ifdef CONFIG_IWLWIFI_DEBUGFS
 		bool beacon_inject_active;
@@ -176,6 +176,7 @@ struct iwl_mld_vif {
 	bool disable_bf;
 	struct dentry *dbgfs_slink;
 #endif
+	enum iwl_roc_activity roc_activity;
 };
 
 static inline struct iwl_mld_vif *
-- 
2.34.1


