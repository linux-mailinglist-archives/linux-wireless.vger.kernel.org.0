Return-Path: <linux-wireless+bounces-28776-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF60C46BFC
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 14:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 846CA18817C2
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 13:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5916930E0DC;
	Mon, 10 Nov 2025 13:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YSSI9hRn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32DE1A704B
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 13:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762779767; cv=none; b=sEoFT4JDn02F723fiqRyH0kUlnj9Pk4AgLEelPFZkc1TpSjEs5tYCnMjGioToOeLS5XniWSju76X2Ao+6zYKIf5xNu56WZa8bolZP9+sna+RLixaL4b4y7l3TblV+6bYPigzgGt+gBGvXE6wEnM3rYxLqd9SpZBVm6ZmevXjHxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762779767; c=relaxed/simple;
	bh=Xv6j9dr6LK0VBNraetgCxeWIsc0nni4K7TbS5i+4ft0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BWBVPIjtEwf0WS1+CKcVjK/NGK9Sl13p1xJULoSQjH5QzBGbDXaZRYynw2bfCpVzDgDNPBmlJAuWGLy0XI1iitlCXDib6KJzyRTywDzfaD4YR2E9xbMIHWepzqk0Zs/mpb/+3Qu6QhPQpXAMyDAXeO4PdHRho6uVnMa3aiJYees=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YSSI9hRn; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762779766; x=1794315766;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Xv6j9dr6LK0VBNraetgCxeWIsc0nni4K7TbS5i+4ft0=;
  b=YSSI9hRnqmLC1jmeIwDKoKgr4ICzC35DDwwC/Rx+n3mYGCKv4wbWWDdz
   EfSr0db3XEeunwfc9AzH34SgLhe2tYfn6SiR7fxeFnYGeEtrLo5q2oMIZ
   vhxzeLcLXuewYtf7vqPTsdD0DCqKh9sQ4ZdkI0+riyJm6zsy6JB5h2Xfm
   TVdH3Nao1xrAXJsTG2OaRVxhCLE1dl2HrL/qxgJPPbzSwJKPquwKjgX7Z
   jo+Nwl8bjFm1inTW8ZDLZzyflDY9VZ5ZZRa4yw3RW+rhQcfsYGTb1YT7l
   4HM7ofnT8lKocFDBLyktPjqdo4+INqyw4w5vqYUmBLqfQjJTp+LpZrE+g
   w==;
X-CSE-ConnectionGUID: Tb3V2WNsSXqeBIw5/zcphg==
X-CSE-MsgGUID: pkTCFM+OSmqImc6h+MxU+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="82454888"
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="82454888"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 05:02:45 -0800
X-CSE-ConnectionGUID: J8xDb4XrRtyHAvuKcEo+1w==
X-CSE-MsgGUID: D6q8+yvuRoumWkM5CSu0sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="192928544"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 05:02:44 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Subject: [PATCH iwlwifi-next 09/15] wifi: iwlwifi: mld: refactor AP power type setting
Date: Mon, 10 Nov 2025 15:02:20 +0200
Message-Id: <20251110150012.f3b15566dac8.I31b900ab161fb627158dc1b3e2fc4ab35d84fddf@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251110130226.223364-1-miriam.rachel.korenblit@intel.com>
References: <20251110130226.223364-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>

Fix unsafe power type mapping for iwl_txpower_constraints_cmd
that breaks if enum values change. Replace "power_type - 1" with
explicit case handling for each power type.
While on it, Add debug logging to show configured power type.

Signed-off-by: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/mld/power.c    | 37 ++++++++++++++++---
 1 file changed, 31 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/power.c b/drivers/net/wireless/intel/iwlwifi/mld/power.c
index f664b277adf7..c3318e84f4a2 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/power.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/power.c
@@ -328,6 +328,33 @@ iwl_mld_tpe_sta_cmd_data(struct iwl_txpower_constraints_cmd *cmd,
 				       link->tpe.max_reg_client[0].power[i]);
 }
 
+static int
+iwl_mld_set_ap_power_type(struct iwl_txpower_constraints_cmd *cmd,
+			  struct ieee80211_vif *vif,
+			  struct ieee80211_bss_conf *link)
+{
+	if (vif->type == NL80211_IFTYPE_AP) {
+		cmd->ap_type = cpu_to_le16(IWL_6GHZ_AP_TYPE_VLP);
+		return 0;
+	}
+
+	switch (link->power_type) {
+	case IEEE80211_REG_LPI_AP:
+		cmd->ap_type = cpu_to_le16(IWL_6GHZ_AP_TYPE_LPI);
+		break;
+	case IEEE80211_REG_SP_AP:
+		cmd->ap_type = cpu_to_le16(IWL_6GHZ_AP_TYPE_SP);
+		break;
+	case IEEE80211_REG_VLP_AP:
+		cmd->ap_type = cpu_to_le16(IWL_6GHZ_AP_TYPE_VLP);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 void
 iwl_mld_send_ap_tx_power_constraint_cmd(struct iwl_mld *mld,
 					struct ieee80211_vif *vif,
@@ -349,15 +376,13 @@ iwl_mld_send_ap_tx_power_constraint_cmd(struct iwl_mld *mld,
 	memset(cmd.psd_pwr, DEFAULT_TPE_TX_POWER, sizeof(cmd.psd_pwr));
 	memset(cmd.eirp_pwr, DEFAULT_TPE_TX_POWER, sizeof(cmd.eirp_pwr));
 
-	if (vif->type == NL80211_IFTYPE_AP) {
-		cmd.ap_type = cpu_to_le16(IWL_6GHZ_AP_TYPE_VLP);
-	} else if (link->power_type == IEEE80211_REG_UNSET_AP) {
+	if (iwl_mld_set_ap_power_type(&cmd, vif, link))
 		return;
-	} else {
-		cmd.ap_type = cpu_to_le16(link->power_type - 1);
+
+	if (vif->type != NL80211_IFTYPE_AP)
 		iwl_mld_tpe_sta_cmd_data(&cmd, link);
-	}
 
+	IWL_DEBUG_POWER(mld, "AP power type: %d\n", le16_to_cpu(cmd.ap_type));
 	ret = iwl_mld_send_cmd_pdu(mld,
 				   WIDE_ID(PHY_OPS_GROUP,
 					   AP_TX_POWER_CONSTRAINTS_CMD),
-- 
2.34.1


