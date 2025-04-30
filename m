Return-Path: <linux-wireless+bounces-22264-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 311DFAA4C2A
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 15:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C68B9E05C7
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 12:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E742609C4;
	Wed, 30 Apr 2025 12:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fjUR7FHB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B14E25E46B
	for <linux-wireless@vger.kernel.org>; Wed, 30 Apr 2025 12:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746017869; cv=none; b=GHQd0gkuFweRad5lB3ZgkDNM+M3a+pBFjy3q4+S76l1QuI9BYavXkThVa7/sCh06AcYO+WbUuPSZ/PHXtBwuu+vFCEGmWOycfzSB1Jh4X7uUns4UHlvDnyGM+KUXDp/HMonTQHW9yGtbS14AoP615Z3GYLQ4IQ2bbl0fASKrAwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746017869; c=relaxed/simple;
	bh=sSOAsrbduH6I0LICXGsZNJYAxfFPri8P50f5IKuMpuc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r7GmC+uLNQ51m+qroT5u+oRRv+K25NzEZEx7c9OBio7sI59Yn1z6DMJ93zIFlOVYCCthiJBpy/th+aUHtFKj48bep4tNgHlR9zCcIsgskt0l1bOmR+QwpffYMzK7LIquDbcXIfd8u3qw6xL93uz9Jbt66yFFVO0brxuk9XVD9Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fjUR7FHB; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746017867; x=1777553867;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sSOAsrbduH6I0LICXGsZNJYAxfFPri8P50f5IKuMpuc=;
  b=fjUR7FHBo2iKScpXYvR0x9+fbUOK1IP/hIQjOya5Plq1tqYvxtc3JRlx
   19d9Bvi9sHCTnfLDXX1XEYwcorr4ubRYh61AYisXTUi5QVqXpboRXfHxn
   cFgdDuRHHp4myoyitJIDQjmhXsmA9pE2zkIUpXmsRHn6zR3GjlBRl7f9B
   zisneUMNX/OjPeyp0NHXBIfpnhmHr+DIS8UGrGwa8bO7GZHkZbbQ0jWXU
   1blll+dkyW5NAUALvZ2/ABIWOGJVK7pu3ICJsGCUemXtOYax1w6Ep2ZEA
   ms0k3u3cM0aqMolGtTTVciXiDQN4QUZEVERK9PdKUoVoJ+dAbh5sbuDTF
   w==;
X-CSE-ConnectionGUID: 92VzHvvFTAK+3mtU4s6oTw==
X-CSE-MsgGUID: WitMfPePQ+m93sy8oKbvOQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11419"; a="58332331"
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="58332331"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 05:57:47 -0700
X-CSE-ConnectionGUID: /6rAEL/sTdeBxvmui9IxFw==
X-CSE-MsgGUID: Qr9KaInXTTqhjc55/o5uSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="134632090"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 05:57:46 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-next 03/15] wifi: iwlwifi: mld: support iwl_mac_power_cmd version 2
Date: Wed, 30 Apr 2025 15:57:17 +0300
Message-Id: <20250430155443.77fdb18d1ee0.I93688612ac4f6ec99da9bc54bee16554ef40a40b@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250430125729.1122751-1-miriam.rachel.korenblit@intel.com>
References: <20250430125729.1122751-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

This version fixes the issue that was worked around by
iwl_mld_smps_wa. So for FWs with the new version don't do the
workaround, and set new bit added in this version when appropriate.
While at it, rename iwl_mld_smps_wa to iwl_mld_smps_workaround.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/mac80211.c | 13 +++++++++----
 drivers/net/wireless/intel/iwlwifi/mld/power.c    |  3 +++
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index 6710dcacecd3..ef976e4d700f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -1248,9 +1248,14 @@ iwl_mld_mac80211_link_info_changed(struct ieee80211_hw *hw,
 }
 
 static void
-iwl_mld_smps_wa(struct iwl_mld *mld, struct ieee80211_vif *vif, bool enable)
+iwl_mld_smps_workaround(struct iwl_mld *mld, struct ieee80211_vif *vif, bool enable)
 {
 	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
+	bool workaround_required =
+		iwl_fw_lookup_cmd_ver(mld->fw, MAC_PM_POWER_TABLE, 0) < 2;
+
+	if (!workaround_required)
+		return;
 
 	/* Send the device-level power commands since the
 	 * firmware checks the POWER_TABLE_CMD's POWER_SAVE_EN bit to
@@ -1297,7 +1302,7 @@ void iwl_mld_mac80211_vif_cfg_changed(struct ieee80211_hw *hw,
 	}
 
 	if (changes & BSS_CHANGED_PS) {
-		iwl_mld_smps_wa(mld, vif, vif->cfg.ps);
+		iwl_mld_smps_workaround(mld, vif, vif->cfg.ps);
 		iwl_mld_update_mac_power(mld, vif, false);
 	}
 
@@ -1710,7 +1715,7 @@ static int iwl_mld_move_sta_state_up(struct iwl_mld *mld,
 						    FW_CTXT_ACTION_MODIFY);
 			if (ret)
 				return ret;
-			iwl_mld_smps_wa(mld, vif, vif->cfg.ps);
+			iwl_mld_smps_workaround(mld, vif, vif->cfg.ps);
 		}
 
 		/* MFP is set by default before the station is authorized.
@@ -1753,7 +1758,7 @@ static int iwl_mld_move_sta_state_down(struct iwl_mld *mld,
 						  &mld_vif->emlsr.check_tpt_wk);
 
 			iwl_mld_reset_cca_40mhz_workaround(mld, vif);
-			iwl_mld_smps_wa(mld, vif, true);
+			iwl_mld_smps_workaround(mld, vif, true);
 		}
 
 		/* once we move into assoc state, need to update the FW to
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/power.c b/drivers/net/wireless/intel/iwlwifi/mld/power.c
index 2f16c174b57e..8cc276041360 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/power.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/power.c
@@ -253,6 +253,9 @@ static void iwl_mld_power_build_cmd(struct iwl_mld *mld,
 
 	cmd->flags |= cpu_to_le16(POWER_FLAGS_POWER_MANAGEMENT_ENA_MSK);
 
+	if (iwl_fw_lookup_cmd_ver(mld->fw, MAC_PM_POWER_TABLE, 0) >= 2)
+		cmd->flags |= cpu_to_le16(POWER_FLAGS_ENABLE_SMPS_MSK);
+
 	/* firmware supports LPRX for beacons at rate 1 Mbps or 6 Mbps only */
 	if (link_conf->beacon_rate &&
 	    (link_conf->beacon_rate->bitrate == 10 ||
-- 
2.34.1


