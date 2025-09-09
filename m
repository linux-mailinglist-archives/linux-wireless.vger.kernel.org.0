Return-Path: <linux-wireless+bounces-27130-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88EC9B49FFB
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 05:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF11F4E49A2
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 03:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7187AD515;
	Tue,  9 Sep 2025 03:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a4Yig8hW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEB6264A90
	for <linux-wireless@vger.kernel.org>; Tue,  9 Sep 2025 03:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757388132; cv=none; b=jarOGCCIzDCxMHr05IgvJxvlMcMz4YZNEdoPdpGu5e2wOgePl0awbMQ4INcymA+O5egGwLEEYNHhTQ8DGNptIaggM7u0CelvjgjZ1T+QKV3P1HY0qiVEz7sQzOK0ryXnPctSOTK5HwBEr8SIU08kujBbytPHSc6udedl+vvrjwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757388132; c=relaxed/simple;
	bh=Ho9LEZHpZqP6C/oc5XnvzH8TmKDljxJRzq8aUrutt30=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QyWXszMV+8Ya6cXyMvAC++TmX+/HkUdEjj84ZH66mO3eNs5x38cm5FaoouatIJG1gBNeS1JoDFVUUdEoi7FdLbMCEvg0H3L+4kXq2sYzVhoeErYNd/5/N+g0B+Y1/kOdP/g80haVT83B5sCmrc0v5KmLIjIgXb1deesD2ZzHO9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a4Yig8hW; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757388131; x=1788924131;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ho9LEZHpZqP6C/oc5XnvzH8TmKDljxJRzq8aUrutt30=;
  b=a4Yig8hW5oWjAHeAjinil/tkq1uj92QUwM5CuaVH/bUa6MXPZbnUuyYx
   XxCtlAjCO8taYPgM7P/N86a+M13KZ4SggrgCgTcnpXUIWhSD5ADtCIops
   aVfZQgcJXku12XfzeXRlmtHWtAat+1KB5BDK0n/gHNNctPZ6wyM3z7QVt
   M58RsPFcs14QujiYUEc51bePetxnjYp3rtdKPR86brNYRZfYmOLoNwp40
   TVfkiwD3QTQeNyup0AoFDmQeNvpKG02XaFoJu4iGyyeLqPrGoPWmlWe0s
   DqpgBjB8zcEjGbU6IwAmfj3SW2hJ8iuU0Pzva7r/Yo4OPIqE8PwuKMH6C
   A==;
X-CSE-ConnectionGUID: DkIWZfk7Q+GdtMuO89ZKUg==
X-CSE-MsgGUID: OtEMPsNATZa686DEOkZwCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11547"; a="70281069"
X-IronPort-AV: E=Sophos;i="6.18,250,1751266800"; 
   d="scan'208";a="70281069"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 20:22:10 -0700
X-CSE-ConnectionGUID: 5D8CQt1hTauECOhsvhZfig==
X-CSE-MsgGUID: 41Tof16HR+a8gp8uA9uNuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,250,1751266800"; 
   d="scan'208";a="203950394"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 20:22:09 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH v2 iwlwifi-next 11/15] wifi: iwlwifi: mld: remove support of mac cmd ver 2
Date: Tue,  9 Sep 2025 06:21:24 +0300
Message-Id: <20250909061931.a56bf370d31a.Ie1e93654ce9ee52e6ae3fda9bc898d611456ec41@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250909032128.3318193-1-miriam.rachel.korenblit@intel.com>
References: <20250909032128.3318193-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

The last FW API that supported ver 2 is API 99 (core 96)
Since we no longer support it in any device that loads iwlmld, we can
remove support of it.

Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/mld/iface.c    | 30 +++++--------------
 1 file changed, 8 insertions(+), 22 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/iface.c b/drivers/net/wireless/intel/iwlwifi/mld/iface.c
index c4738400ee11..ed379825a923 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/iface.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/iface.c
@@ -115,20 +115,12 @@ static bool iwl_mld_is_nic_ack_enabled(struct iwl_mld *mld,
 
 static void iwl_mld_set_he_support(struct iwl_mld *mld,
 				   struct ieee80211_vif *vif,
-				   struct iwl_mac_config_cmd *cmd,
-				   int cmd_ver)
+				   struct iwl_mac_config_cmd *cmd)
 {
-	if (vif->type == NL80211_IFTYPE_AP) {
-		if (cmd_ver == 2)
-			cmd->wifi_gen_v2.he_ap_support = cpu_to_le16(1);
-		else
-			cmd->wifi_gen.he_ap_support = 1;
-	} else {
-		if (cmd_ver == 2)
-			cmd->wifi_gen_v2.he_support = cpu_to_le16(1);
-		else
-			cmd->wifi_gen.he_support = 1;
-	}
+	if (vif->type == NL80211_IFTYPE_AP)
+		cmd->wifi_gen.he_ap_support = 1;
+	else
+		cmd->wifi_gen.he_support = 1;
 }
 
 /* fill the common part for all interface types */
@@ -140,9 +132,6 @@ static void iwl_mld_mac_cmd_fill_common(struct iwl_mld *mld,
 	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
 	struct ieee80211_bss_conf *link_conf;
 	unsigned int link_id;
-	int cmd_ver = iwl_fw_lookup_cmd_ver(mld->fw,
-					    WIDE_ID(MAC_CONF_GROUP,
-						    MAC_CONFIG_CMD), 0);
 
 	lockdep_assert_wiphy(mld->wiphy);
 
@@ -169,11 +158,8 @@ static void iwl_mld_mac_cmd_fill_common(struct iwl_mld *mld,
 	 * and enable both when we have MLO.
 	 */
 	if (ieee80211_vif_is_mld(vif)) {
-		iwl_mld_set_he_support(mld, vif, cmd, cmd_ver);
-		if (cmd_ver == 2)
-			cmd->wifi_gen_v2.eht_support = cpu_to_le32(1);
-		else
-			cmd->wifi_gen.eht_support = 1;
+		iwl_mld_set_he_support(mld, vif, cmd);
+		cmd->wifi_gen.eht_support = 1;
 		return;
 	}
 
@@ -181,7 +167,7 @@ static void iwl_mld_mac_cmd_fill_common(struct iwl_mld *mld,
 		if (!link_conf->he_support)
 			continue;
 
-		iwl_mld_set_he_support(mld, vif, cmd, cmd_ver);
+		iwl_mld_set_he_support(mld, vif, cmd);
 
 		/* EHT, if supported, was already set above */
 		break;
-- 
2.34.1


