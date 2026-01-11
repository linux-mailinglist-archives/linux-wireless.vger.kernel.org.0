Return-Path: <linux-wireless+bounces-30664-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B62D0F886
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Jan 2026 18:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1781F302A3B7
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Jan 2026 17:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC83521ABBB;
	Sun, 11 Jan 2026 17:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZJvrx4nh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA319349B17
	for <linux-wireless@vger.kernel.org>; Sun, 11 Jan 2026 17:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768153202; cv=none; b=HvvV9z/IPxeABoU0ep+CdHhq33b+b+WRIK92EPsoNK7KaERzCPOMSc1dFRTnL62Fy391awN4Ei9q1OQTXy7Ue3z2daGg27gRHPp4o+CL/XGzpDpMvpGN0lpDXEK78sCu4xTEsFB7uHMvX90wPmju/BYYFWNPe/fD2sd/CCG7Btc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768153202; c=relaxed/simple;
	bh=gvIleLZurRQH/skuHEGHRJSmizXbTYBt2/Y+rs5YR44=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wr6OAJ6uNfhdxJUtID1918cOXkeCaJ08iITo6n8UlIyBoWA5hbUSSm+3nICaps5YBaqnkRtma2s1Ht/zFobAQG7wV5uJ7QgLueEPpLRbomQqjK8un3fH5e2VG7YdyyMaoaESu4ndGFcwkCY2ITxxmgkF5eHJyGMws7DNt4QlRmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZJvrx4nh; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768153197; x=1799689197;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gvIleLZurRQH/skuHEGHRJSmizXbTYBt2/Y+rs5YR44=;
  b=ZJvrx4nhRFOGEDwFa7CY+LDEImKpewbrvC2ytpd+sNJuUsmOQxcVkg1x
   p3dsqNx/YM4v5Mv6va8j4PUp0SamPZ3lLxyqacnakp13M5sqkYHndp+Qh
   IWAf/RDE1H9LHtlm0tkHgxUxLczXqtcyNArQJJyzJAmx0/QeImgCTTtMd
   T1bv5jgOgc0sr/Sa7+B77pkKGT0G6wDe4BjLRGeQULDAFTMbO2oj3+B/N
   xXRxXKRi4SpXQ1wQgttcy6soKqEv1Zc2TdhA2ua1x2BV7Lhl/fcW8L0QY
   bMNt4v7Fv2r8iuvEqfDygEgHhkTmOLzbHztkmeNzzgZ7rYt/Fb69/Ci9P
   w==;
X-CSE-ConnectionGUID: jXFRQlNNQquMozO5BDOXgw==
X-CSE-MsgGUID: te7uv386RhC8OIUuEKmxdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11668"; a="69521101"
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="69521101"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2026 09:39:54 -0800
X-CSE-ConnectionGUID: 99WEbCvzT/2YJYw+CXnm0Q==
X-CSE-MsgGUID: FoDUychYS0qdQwsgDoksQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="208393823"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2026 09:39:53 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-next 15/15] wifi: iwlwifi: rename struct iwl_mcc_allowed_ap_type_cmd::offset_map
Date: Sun, 11 Jan 2026 19:39:26 +0200
Message-Id: <20260111193638.6ed558b09581.I6560b8cfb36b68cea1afe8f89f87dded99d2caf7@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260111173926.2216629-1-miriam.rachel.korenblit@intel.com>
References: <20260111173926.2216629-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

This was poorly named, probably a copy paste mistake.
The real meaning of this field is a map of the MCCs to describe the AP
type allowed for each country.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h | 4 ++--
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c        | 5 +++--
 drivers/net/wireless/intel/iwlwifi/fw/uefi.h        | 2 +-
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
index f6b59e009036..bd6bf931866f 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
@@ -702,11 +702,11 @@ struct iwl_pnvm_init_complete_ntfy {
 
 /**
  * struct iwl_mcc_allowed_ap_type_cmd - struct for MCC_ALLOWED_AP_TYPE_CMD
- * @offset_map: mapping a mcc to UHB AP type support (UATS) allowed
+ * @mcc_to_ap_type_map: mapping an MCC to 6 GHz AP type support (UATS)
  * @reserved: reserved
  */
 struct iwl_mcc_allowed_ap_type_cmd {
-	u8 offset_map[UATS_TABLE_ROW_SIZE][UATS_TABLE_COL_SIZE];
+	u8 mcc_to_ap_type_map[UATS_TABLE_ROW_SIZE][UATS_TABLE_COL_SIZE];
 	__le16 reserved;
 } __packed; /* MCC_ALLOWED_AP_TYPE_CMD_API_S_VER_1 */
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
index b7532494d4e0..a7ba86e06c09 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
@@ -402,8 +402,9 @@ static int iwl_uefi_uats_parse(struct uefi_cnv_wlan_uats_data *uats_data,
 	if (uats_data->revision != 1)
 		return -EINVAL;
 
-	memcpy(fwrt->uats_table.offset_map, uats_data->offset_map,
-	       sizeof(fwrt->uats_table.offset_map));
+	memcpy(fwrt->uats_table.mcc_to_ap_type_map,
+	       uats_data->mcc_to_ap_type_map,
+	       sizeof(fwrt->uats_table.mcc_to_ap_type_map));
 
 	fwrt->uats_valid = true;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.h b/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
index 5a4c557e47c7..349ac1505ad7 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
@@ -60,7 +60,7 @@ struct uefi_cnv_wlan_sgom_data {
 
 struct uefi_cnv_wlan_uats_data {
 	u8 revision;
-	u8 offset_map[IWL_UATS_MAP_SIZE - 1];
+	u8 mcc_to_ap_type_map[IWL_UATS_MAP_SIZE - 1];
 } __packed;
 
 struct uefi_cnv_common_step_data {
-- 
2.34.1


