Return-Path: <linux-wireless+bounces-20078-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D8EA580A5
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Mar 2025 06:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D468F16BF9A
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Mar 2025 05:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E6C14B07A;
	Sun,  9 Mar 2025 05:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XPgowFt9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2300354F8C
	for <linux-wireless@vger.kernel.org>; Sun,  9 Mar 2025 05:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741498630; cv=none; b=nWemOm2wZkHtON/RWx95LuW9UD0eKESDunQk6fmNkDWieb43mVfyysJliEocCJO2HBQe8wLYLRiYt1EQoUh5INqnZXvVoifOuxDOUyL2dQn5Nd4PhJCM1+0jtp/d3Gzw8uuxZLKc9404r1GMMijXBZgpYZZZ/RXN2DZ+3JGAYxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741498630; c=relaxed/simple;
	bh=qiu6D3O5Fs5+np7jyjiuQi7ZEmGDSSmwq9OLd1BtLUI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jUn0LV/+1ce169R5Hf2Z5K+65U6rB9JS1as+1ajXbCC8TlKBrPZfzEb2nFseif4HPd97pI7PwCMAaQeXk3FOPOfweSUdMxeaPGXfkU9toIy9sribuGPLN0ZNxkOziGup4HPCp1BNvRPYSgHMz0L+zG4s+J4rQpqp+vW638MQCx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XPgowFt9; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741498629; x=1773034629;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qiu6D3O5Fs5+np7jyjiuQi7ZEmGDSSmwq9OLd1BtLUI=;
  b=XPgowFt9SU9qBztNHlUZh0s5KJU6uIfGTKYYwi3c5iRYJA4xrTNIr1Cq
   Txr5HCtgRd9mLhizrE1pc5WWktiwKQ0aUiW1jy9eZ6BC1SjZPBtCGDBU7
   tzWF7hGKfA2hFYnJo43QLViRDbqbNvtUR3+g7+Sd2Nah2uuLa/bIJQ5rL
   R8SqfU7YLQzq4SDg9S2R0g+O1OWBI9EAxKNKQOIpEL7NnTTo2z/Wd7z8N
   SpsHGE+i4JR0RHrSVtDT+t/doxZ0zLomZ0/M8isbNoqRJGuKCMqH5vZH1
   MrMJZqFqxcWpCvytR/Rxhuq/+e0KX9AnWrGHd9GkYUJZLqNRNvAtmO0gL
   Q==;
X-CSE-ConnectionGUID: TqURk9kvSeG46Kd0HkIgeQ==
X-CSE-MsgGUID: GJQVbZ2jRW+aSxc8ht6BlQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11367"; a="41671684"
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="41671684"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 21:37:09 -0800
X-CSE-ConnectionGUID: eBCY9O6SS1isUpwm6tzIcg==
X-CSE-MsgGUID: oZujZwd0SG20FTMYLCny+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="150470594"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 21:37:08 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH v2 wireless-next 02/15] wifi: iwlwifi: mld: fix SMPS W/A
Date: Sun,  9 Mar 2025 07:36:40 +0200
Message-Id: <20250309073442.1cdeb78b19ba.I58fe02c062524029071b04b093a1b09c5e46f4ef@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250309053653.2697525-1-miriam.rachel.korenblit@intel.com>
References: <20250309053653.2697525-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

If the user disables power save of a vif that didn't have it enabled
(for example before association), mac80211 will not notify the driver
with BSS_CHANGED_PS. This will cause the driver to not update the
device-level power save to disabled.
Fix this by checking the vif's power save status upon authorization, and
stop considering the vif's power save status on disassociation.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/mld/iface.h    |  2 ++
 .../net/wireless/intel/iwlwifi/mld/mac80211.c | 25 +++++++++++++++----
 .../net/wireless/intel/iwlwifi/mld/power.c    |  3 ++-
 3 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/iface.h b/drivers/net/wireless/intel/iwlwifi/mld/iface.h
index 2c928113f680..57910660ed18 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/iface.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/iface.h
@@ -134,6 +134,7 @@ struct iwl_mld_emlsr {
  * @beacon_inject_active: indicates an active debugfs beacon ie injection
  * @low_latency_causes: bit flags, indicating the causes for low-latency,
  *	see @iwl_mld_low_latency_cause.
+ * @ps_disabled: indicates that PS is disabled for this interface
  * @mld: pointer to the mld structure.
  * @deflink: default link data, for use in non-MLO,
  * @link: reference to link data for each valid link, for use in MLO.
@@ -159,6 +160,7 @@ struct iwl_mld_vif {
 		bool beacon_inject_active;
 #endif
 		u8 low_latency_causes;
+		bool ps_disabled;
 	);
 	/* And here fields that survive a fw restart */
 	struct iwl_mld *mld;
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index d73bd0179f7d..ba149581e25d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -1262,6 +1262,23 @@ iwl_mld_mac80211_link_info_changed(struct ieee80211_hw *hw,
 		iwl_mld_set_tx_power(mld, link_conf, link_conf->txpower);
 }
 
+static void
+iwl_mld_smps_wa(struct iwl_mld *mld, struct ieee80211_vif *vif, bool enable)
+{
+	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
+
+	/* Send the device-level power commands since the
+	 * firmware checks the POWER_TABLE_CMD's POWER_SAVE_EN bit to
+	 * determine SMPS mode.
+	 */
+	if (mld_vif->ps_disabled == !enable)
+		return;
+
+	mld_vif->ps_disabled = !enable;
+
+	iwl_mld_update_device_power(mld, false);
+}
+
 static
 void iwl_mld_mac80211_vif_cfg_changed(struct ieee80211_hw *hw,
 				      struct ieee80211_vif *vif,
@@ -1295,11 +1312,7 @@ void iwl_mld_mac80211_vif_cfg_changed(struct ieee80211_hw *hw,
 	}
 
 	if (changes & BSS_CHANGED_PS) {
-		/* Send both device-level and MAC-level power commands since the
-		 * firmware checks the POWER_TABLE_CMD's POWER_SAVE_EN bit to
-		 * determine SMPS mode.
-		 */
-		iwl_mld_update_device_power(mld, false);
+		iwl_mld_smps_wa(mld, vif, vif->cfg.ps);
 		iwl_mld_update_mac_power(mld, vif, false);
 	}
 
@@ -1716,6 +1729,7 @@ static int iwl_mld_move_sta_state_up(struct iwl_mld *mld,
 						    FW_CTXT_ACTION_MODIFY);
 			if (ret)
 				return ret;
+			iwl_mld_smps_wa(mld, vif, vif->cfg.ps);
 		}
 
 		/* MFP is set by default before the station is authorized.
@@ -1758,6 +1772,7 @@ static int iwl_mld_move_sta_state_down(struct iwl_mld *mld,
 						  &mld_vif->emlsr.check_tpt_wk);
 
 			iwl_mld_reset_cca_40mhz_workaround(mld, vif);
+			iwl_mld_smps_wa(mld, vif, true);
 		}
 
 		/* once we move into assoc state, need to update the FW to
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/power.c b/drivers/net/wireless/intel/iwlwifi/mld/power.c
index ed7c0319f239..2f16c174b57e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/power.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/power.c
@@ -15,11 +15,12 @@ static void iwl_mld_vif_ps_iterator(void *data, u8 *mac,
 				    struct ieee80211_vif *vif)
 {
 	bool *ps_enable = (bool *)data;
+	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
 
 	if (vif->type != NL80211_IFTYPE_STATION)
 		return;
 
-	*ps_enable &= vif->cfg.ps;
+	*ps_enable &= !mld_vif->ps_disabled;
 }
 
 int iwl_mld_update_device_power(struct iwl_mld *mld, bool d3)
-- 
2.34.1


