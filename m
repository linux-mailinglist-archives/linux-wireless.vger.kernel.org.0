Return-Path: <linux-wireless+bounces-7545-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE58C8C367D
	for <lists+linux-wireless@lfdr.de>; Sun, 12 May 2024 14:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59374B21F97
	for <lists+linux-wireless@lfdr.de>; Sun, 12 May 2024 12:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D0D4120B;
	Sun, 12 May 2024 12:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tf+spuVb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF12240BF5
	for <linux-wireless@vger.kernel.org>; Sun, 12 May 2024 12:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715516733; cv=none; b=RDS9VWXuIJd0uPWqK1FpNHgWAJ/SxiO6enZSazNLYdHIDRXGOFsbAsywGO7UgZNPdp51+1lCeLG5rrfk3Ba2vxKXxJbJnqMahZ/HS29YbeYlmYjthwQlwMbLo1sS/QBMW6dXVOxuduHvUhjdYi89Z6TH4J/IN+mF6D2T/RligNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715516733; c=relaxed/simple;
	bh=Y3KhncoxmJfTmEP4bSlXsTRuAqNsseaI1cwMpqga0to=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g1E4VboHF3E9Uybu1CQ19cD9xo1MOTTUSQG7RLnCDir2WgwnE+WFiGghi2zxjNYlRBhNf+Zn6hS4L6+1BqAG0ekC9YjB6mNbW0Nz/cM4T101YjS1Pt8Lv68yZ/4ziVH8mhWnvRdht/fC1zPVW1ozBJMTppiWUYjO64omOTvbRdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tf+spuVb; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715516731; x=1747052731;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y3KhncoxmJfTmEP4bSlXsTRuAqNsseaI1cwMpqga0to=;
  b=Tf+spuVb80IIS5KL3NsTzdAw88FBznXqmzTsl170IXXtO+DjdbCKyGkp
   XfbvkR6WBvBHCIXgXi7a4kMdvjJ5s/dPgnzkF7RTPC4vAsXewaS6p0w3X
   FO7PN+GEpxMAygqJJc+OIe4FyKGwfLbimGDpeb3TvHAxeEdQqo8Vqj0Gx
   X1BRGnWfooVFupo+/eFSoR0Q+T2nuGnDpTCsuUHKOQ5RYRAlCxbIM6fCO
   kKfQxsYuuV5vFPuxXg2PB3+Ytl8PJjF/2WfTnkXqVHeUWC2+rgOcaCYx5
   hlTX6G8aX/e0KYKyfdRHYI5Vbs34h78gOAABbpOJOwwsBB0dJ2MtC1rv5
   w==;
X-CSE-ConnectionGUID: ZL3AFpnTTGWN/Evei4dkbQ==
X-CSE-MsgGUID: VhEpo7tuQOiEp+iZ2t6SGg==
X-IronPort-AV: E=McAfee;i="6600,9927,11071"; a="11397216"
X-IronPort-AV: E=Sophos;i="6.08,155,1712646000"; 
   d="scan'208";a="11397216"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2024 05:25:31 -0700
X-CSE-ConnectionGUID: 9CpQygJNQNyOL8MXAz2imQ==
X-CSE-MsgGUID: DXL8S4D5SeGr/D8YWQE2Ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,155,1712646000"; 
   d="scan'208";a="34761340"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2024 05:25:31 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Shaul Triebitz <shaul.triebitz@intel.com>
Subject: [PATCH 11/14] wifi: iwlwifi: mvm: always set the TWT IE offset
Date: Sun, 12 May 2024 15:25:04 +0300
Message-Id: <20240512152312.eb27175c345a.If30ef24aba10fe47fd42a7a9703eb8903035e294@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240512122507.3812527-1-miriam.rachel.korenblit@intel.com>
References: <20240512122507.3812527-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Shaul Triebitz <shaul.triebitz@intel.com>

In beacon template version 14, make sure to always set
the TWT IE offset before sending the beacon template command,
also in the debugfs inject_beacon_ie path.
If the TWT IE does not exist, the offset will be set to zero.

Fixes: bf0212fd8faa ("wifi: iwlwifi: mvm: add beacon template version 14")
Signed-off-by: Shaul Triebitz <shaul.triebitz@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c  | 9 +++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c | 2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h      | 1 +
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
index 96c9382b98fb..7e7153220fd7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
@@ -1619,6 +1619,15 @@ static int _iwl_dbgfs_inject_beacon_ie(struct iwl_mvm *mvm, char *bin, int len)
 					 &beacon_cmd.tim_size,
 					 beacon->data, beacon->len);
 
+		if (iwl_fw_lookup_cmd_ver(mvm->fw,
+					  BEACON_TEMPLATE_CMD, 0) >= 14) {
+			u32 offset = iwl_mvm_find_ie_offset(beacon->data,
+							    WLAN_EID_S1G_TWT,
+							    beacon->len);
+
+			beacon_cmd.btwt_offset = cpu_to_le32(offset);
+		}
+
 		iwl_mvm_mac_ctxt_send_beacon_cmd(mvm, beacon, &beacon_cmd,
 						 sizeof(beacon_cmd));
 	}
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index f6baf7135efd..ef7ffeaf6ff2 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -873,7 +873,7 @@ void iwl_mvm_mac_ctxt_set_tim(struct iwl_mvm *mvm,
 	}
 }
 
-static u32 iwl_mvm_find_ie_offset(u8 *beacon, u8 eid, u32 frame_size)
+u32 iwl_mvm_find_ie_offset(u8 *beacon, u8 eid, u32 frame_size)
 {
 	struct ieee80211_mgmt *mgmt = (void *)beacon;
 	const u8 *ie;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 770a7098b0f9..9e967b9cb015 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1763,6 +1763,7 @@ u8 iwl_mvm_next_antenna(struct iwl_mvm *mvm, u8 valid, u8 last_idx);
 void iwl_mvm_get_sync_time(struct iwl_mvm *mvm, int clock_type, u32 *gp2,
 			   u64 *boottime, ktime_t *realtime);
 u32 iwl_mvm_get_systime(struct iwl_mvm *mvm);
+u32 iwl_mvm_find_ie_offset(u8 *beacon, u8 eid, u32 frame_size);
 
 /* Tx / Host Commands */
 int __must_check iwl_mvm_send_cmd(struct iwl_mvm *mvm,
-- 
2.34.1


