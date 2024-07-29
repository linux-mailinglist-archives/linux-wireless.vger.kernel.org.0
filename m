Return-Path: <linux-wireless+bounces-10637-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B2793FC5D
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2024 19:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0412280E2A
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2024 17:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A5716B39D;
	Mon, 29 Jul 2024 17:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q0V64W6v"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9731215ECD0
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jul 2024 17:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722273660; cv=none; b=IdCEXi9iDw/M6rQYPqHVjzvdJTgMovX+eHgJGVBour+rIwPXeoyfz6PHLzNYfue4auovFkgSY1y9hYcSh5PelGCOa8HcpcSAIo0XU4JlEWcozM90UmCKA4ny3171u/IRItXtl4p8g1k4dwVqc66gBLkOEyAt8nI3NFq1Aw3crQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722273660; c=relaxed/simple;
	bh=4UhQzKGlL0ekd0gFFlMSc+Vr66BfAa4rrLPBIqA536M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IViJujQrQgpu48GAM7lNGSGLoWuGaERB8Fa72JWRcj2bARtrL4o+7lOGe6YD68Y2UMhgh34vsx35AVm62bwK6664IrVCC34TNjmK/t6TO7bhFdKkw0YHH8eWuXLEgwRlq6RZKms8+m8xJABYCG+o0NluKl0PuICuwSubSX8yCbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q0V64W6v; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722273659; x=1753809659;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4UhQzKGlL0ekd0gFFlMSc+Vr66BfAa4rrLPBIqA536M=;
  b=Q0V64W6v2b3usjznV3YgCUkz4deIQFHTLnqx2DLo51CuMFhOr84g6u3e
   cNPnYqCOX9+4pmtD1aVR8X0XWlQvwB7vAUvcT76XtT8v8wcE8/NTu5Sbo
   dFxF/ot/fmzDRB33EeWQ/z2dUpEJmU+E+pOr/9jbVdKQdai5HAnaA/JjN
   oqaCo0qoEjONSxmuvBkI27xszKHXu4LY5BuooW47HZlap52HRCVcBYumh
   K17cRGEbmtdkhYm1uvHoXHM++AvrY4G9p1pqHfiAmlcwjqtaWxZlmXzKW
   VX/59yR0JnyG0vIMmmDvfzj4b62IKqvL1U+1xZlBz3VAUOMjycCuZyPio
   g==;
X-CSE-ConnectionGUID: pvh22pG2TgiLr2b82zkv+Q==
X-CSE-MsgGUID: iRiFAfEYTjW2L8vgCMWwDg==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="31445638"
X-IronPort-AV: E=Sophos;i="6.09,246,1716274800"; 
   d="scan'208";a="31445638"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 10:20:59 -0700
X-CSE-ConnectionGUID: 5mBXfpOeQ7mIniUGTkKhGQ==
X-CSE-MsgGUID: +nT3EISpSs+j/COmcdyqOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,246,1716274800"; 
   d="scan'208";a="54288373"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 10:20:57 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Daniel Gabay <daniel.gabay@intel.com>
Subject: [PATCH 17/17] wifi: iwlwifi: mvm: add and improve EMLSR debug info
Date: Mon, 29 Jul 2024 20:20:18 +0300
Message-Id: <20240729201718.02bd85837c87.I85480c9c4fab0f7a574dd69cbeafd82674146921@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240729172018.1993751-1-miriam.rachel.korenblit@intel.com>
References: <20240729172018.1993751-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

Add prints of the per-link MPDU counters, and change the other MPDU
counters related prints to use DL_INFO, which is already used for all
EMLSR tests anyway, instead of DL_STATS which pollutes the logs with all
the RX signal info.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Daniel Gabay <daniel.gabay@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c | 2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c           | 7 +++++--
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c          | 2 +-
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index ed30247de407..72bb6865dd63 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -223,7 +223,7 @@ static void iwl_mvm_restart_mpdu_count(struct iwl_mvm *mvm,
 		spin_unlock_bh(&mvmsta->mpdu_counters[q].lock);
 	}
 
-	IWL_DEBUG_STATS(mvm, "MPDU counters are cleared\n");
+	IWL_DEBUG_INFO(mvm, "MPDU counters are cleared\n");
 }
 
 static int iwl_mvm_esr_mode_active(struct iwl_mvm *mvm,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
index bc8078875c5a..3b5bbece63f6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
@@ -1009,8 +1009,8 @@ static void iwl_mvm_update_esr_mode_tpt(struct iwl_mvm *mvm)
 		spin_unlock_bh(&mvmsta->mpdu_counters[q].lock);
 	}
 
-	IWL_DEBUG_STATS(mvm, "total Tx MPDUs: %ld. total Rx MPDUs: %ld\n",
-			total_tx, total_rx);
+	IWL_DEBUG_INFO(mvm, "total Tx MPDUs: %ld. total Rx MPDUs: %ld\n",
+		       total_tx, total_rx);
 
 	/* If we don't have enough MPDUs - exit EMLSR */
 	if (total_tx < IWL_MVM_ENTER_ESR_TPT_THRESH &&
@@ -1020,6 +1020,9 @@ static void iwl_mvm_update_esr_mode_tpt(struct iwl_mvm *mvm)
 		return;
 	}
 
+	IWL_DEBUG_INFO(mvm, "Secondary Link %d: Tx MPDUs: %ld. Rx MPDUs: %ld\n",
+		       sec_link, sec_link_tx, sec_link_rx);
+
 	/* Calculate the percentage of the secondary link TX/RX */
 	sec_link_tx_perc = total_tx ? sec_link_tx * 100 / total_tx : 0;
 	sec_link_rx_perc = total_rx ? sec_link_rx * 100 / total_rx : 0;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index 550c97a014b9..cf4d6425f634 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -4455,7 +4455,7 @@ void iwl_mvm_count_mpdu(struct iwl_mvm_sta *mvm_sta, u8 fw_sta_id, u32 count,
 		       sizeof(queue_counter->per_link));
 		queue_counter->window_start = jiffies;
 
-		IWL_DEBUG_STATS(mvm, "MPDU counters are cleared\n");
+		IWL_DEBUG_INFO(mvm, "MPDU counters are cleared\n");
 	}
 
 	for (int i = 0; i < IWL_FW_MAX_LINK_ID; i++)
-- 
2.34.1


