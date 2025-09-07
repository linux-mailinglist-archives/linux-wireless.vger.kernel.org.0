Return-Path: <linux-wireless+bounces-27058-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15CC0B479A6
	for <lists+linux-wireless@lfdr.de>; Sun,  7 Sep 2025 10:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4220167E06
	for <lists+linux-wireless@lfdr.de>; Sun,  7 Sep 2025 08:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F5D221545;
	Sun,  7 Sep 2025 08:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sn7XK745"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF08B221264
	for <linux-wireless@vger.kernel.org>; Sun,  7 Sep 2025 08:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757233868; cv=none; b=TM3xDouTXU3Haxfk35X/jkcjSeOrSyfyprOeYp9FtOHBSG+Y9nRnik4Fg8/whT4eyxQRoF8aHzHzySrwrWx2KE2Q9DWUto+xIPyfvBEd/x3CvJDD81T7rqS574E7q6hT2INQMYWZCH534dwpboIEoeGdY3Kyb3NgrMc/0BQcjy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757233868; c=relaxed/simple;
	bh=Ho9LEZHpZqP6C/oc5XnvzH8TmKDljxJRzq8aUrutt30=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EyYlIMwKu1d/E7BTcrDjdGahpsZhVtgARVc03JCxR/XtxcwS2wfR0LalrqW0nnA9pP24NSBx+2QrnyAclnOIwkGkyfAvLht5U4J1O1hJKhMB0lkeHdqsV2lPCYRaQNEqfQyHaTB4PkrmPMvQMO3mU9lfqB6SMl2qGlNzyCmAR1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sn7XK745; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757233867; x=1788769867;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ho9LEZHpZqP6C/oc5XnvzH8TmKDljxJRzq8aUrutt30=;
  b=Sn7XK745zAzkA4FvezB3wDCx9mSWWax6fS5Vu7d4Sv6DLedrAmvgY0Ea
   NQy9u1xocy0Hc8ew/rvGkoDRu7LCtOa/mDOyCTwIDqHQkmzGWC5W9IF9D
   YUdTzuHfraagXGLUIwImb4xzyloJeVKpCQFSBOuQX9hkdBw/t5Mkwzx5G
   BEkTboYal3fOgTXWavwwAxKpK9d68TuUBI6c/6sKoQsxNI1aMiRY0ePvt
   oh7Ws6GvT+eJq/GQtAzzY6AFfX++DKxlAm9iefRmqeW38SZZAqQRXwQ79
   Yb97i5PytkO6ddXbiIwgkW+f3qZdsLriWkuhskgeYiCDDIVhvMxUCDJLk
   A==;
X-CSE-ConnectionGUID: d0zzH27MSzSj6GLwug3Aug==
X-CSE-MsgGUID: fWXB36ZhR4qVE35taYR05Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11545"; a="76973620"
X-IronPort-AV: E=Sophos;i="6.18,246,1751266800"; 
   d="scan'208";a="76973620"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2025 01:31:06 -0700
X-CSE-ConnectionGUID: M7+brTPLT6u04GzorjC9gw==
X-CSE-MsgGUID: /yfXSASASBWtz80PDZ+rKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,246,1751266800"; 
   d="scan'208";a="171790072"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2025 01:31:05 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-next 11/15] wifi: iwlwifi: mld: remove support of mac cmd ver 2
Date: Sun,  7 Sep 2025 11:30:10 +0300
Message-Id: <20250907112757.5ff2f6b5f482.Ie1e93654ce9ee52e6ae3fda9bc898d611456ec41@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250907083014.1439961-1-miriam.rachel.korenblit@intel.com>
References: <20250907083014.1439961-1-miriam.rachel.korenblit@intel.com>
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


