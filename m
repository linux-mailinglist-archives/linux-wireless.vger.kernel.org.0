Return-Path: <linux-wireless+bounces-12294-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E0B9674F1
	for <lists+linux-wireless@lfdr.de>; Sun,  1 Sep 2024 06:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C05CB21682
	for <lists+linux-wireless@lfdr.de>; Sun,  1 Sep 2024 04:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22016381BD;
	Sun,  1 Sep 2024 04:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XJwsLwZX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DD83A8CE
	for <linux-wireless@vger.kernel.org>; Sun,  1 Sep 2024 04:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725164295; cv=none; b=kWBLoJbzbr37jaNuex60N3cuNnStNNm8oCp0kFPEbm7T6N+IsrfMHkIoOO/P6FbruHlufX/9BETC2wuhxvEW96c3efobsMx80nGel7Tdjl41Z1hcJ1GWTfMEP+lusyxrObhqci3q596N57KEQALV+lBYBx+fM546xGP/IXiLyz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725164295; c=relaxed/simple;
	bh=OBIzoy9/JGYmTY0LrJ/27qzcoaeeCjNezUYCzQz7dao=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YW7GX6BaGlRO4dWNpiwHx4D62n0w08aR35Cv0YYMDNThMM1TFmRRL6lHZ2co1aXa9lGRgWFh2aBO1rngPcnKMfH4ACBYkixClUpfvd6o3EQ7vVnBt18L8LDCVzl1XYcTpnCN022xHP9aY4s8D+hLApazkLh79IkvF8kKQP2qQPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XJwsLwZX; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725164293; x=1756700293;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OBIzoy9/JGYmTY0LrJ/27qzcoaeeCjNezUYCzQz7dao=;
  b=XJwsLwZXOMkm/FlaNPAOozasGoeAgjzkSqUn915mbPjMVI16u2bP0gF3
   T7Dhl4Zk0wHEO61t1dBHT9ZlM5o8+M8NXDT7oV2nfGG0hfpGmKKKCZCGk
   K4obStm3UsIoEnyw5H/jhAqAMymn2NSbFNVawYGMaLcZzFbuhYBJD5mLA
   HvD363KGyZh2uwTgfu4Qlub1jtsuSSza9q0jRNOezJ6nhJi4FALqDS9Sn
   Viv+defsPXyjmyAYSbIcj7s5a9F/3pnMMQfjHDASwLcrdXGJ7q4xjRLOV
   pqUq/Rpm7Xd2EhLqihFouHwE2lWQn9SXBc6QbwnHGydL2Vb66PkYbtJXL
   A==;
X-CSE-ConnectionGUID: Ug71ZWBgQCSVIfx2Qr5mUA==
X-CSE-MsgGUID: VRAi+WA1THOLr0UkzOC0UQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11181"; a="27559522"
X-IronPort-AV: E=Sophos;i="6.10,193,1719903600"; 
   d="scan'208";a="27559522"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2024 21:18:13 -0700
X-CSE-ConnectionGUID: 0lq5ymkrRFWlEMAUT4RmKw==
X-CSE-MsgGUID: hfYdVnHMSp2mCkIf2eRyTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,193,1719903600"; 
   d="scan'208";a="64276311"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2024 21:18:12 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 4/8] wifi: iwlwifi: STA command structure shouldn't be mvm specific
Date: Sun,  1 Sep 2024 07:17:53 +0300
Message-Id: <20240901071542.39c9ceea41d3.I2a06bfca589c467fa84ad82ff86e73ec82e72a5e@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240901041757.917200-1-miriam.rachel.korenblit@intel.com>
References: <20240901041757.917200-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

This strcuture is not specific to mvm, so rename it.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h | 6 +++---
 drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c    | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
index 73586e547e57..6dd9401596e9 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
@@ -42,7 +42,7 @@ enum iwl_mac_conf_subcmd_ids {
 	 */
 	LINK_CONFIG_CMD = 0x9,
 	/**
-	 * @STA_CONFIG_CMD: &struct iwl_mvm_sta_cfg_cmd
+	 * @STA_CONFIG_CMD: &struct iwl_sta_cfg_cmd
 	 */
 	STA_CONFIG_CMD = 0xA,
 	/**
@@ -563,7 +563,7 @@ enum iwl_fw_sta_type {
 }; /* STATION_TYPE_E_VER_1 */
 
 /**
- * struct iwl_mvm_sta_cfg_cmd - cmd structure to add a peer sta to the uCode's
+ * struct iwl_sta_cfg_cmd - cmd structure to add a peer sta to the uCode's
  *	station table
  * ( STA_CONFIG_CMD = 0xA )
  *
@@ -595,7 +595,7 @@ enum iwl_fw_sta_type {
  *	capa
  * @htc_flags: which features are supported in HTC
  */
-struct iwl_mvm_sta_cfg_cmd {
+struct iwl_sta_cfg_cmd {
 	__le32 sta_id;
 	__le32 link_id;
 	u8 peer_mld_address[ETH_ALEN];
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
index 071de9372843..759b77d555b7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
@@ -46,7 +46,7 @@ u32 iwl_mvm_sta_fw_id_mask(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 }
 
 static int iwl_mvm_mld_send_sta_cmd(struct iwl_mvm *mvm,
-				    struct iwl_mvm_sta_cfg_cmd *cmd)
+				    struct iwl_sta_cfg_cmd *cmd)
 {
 	int ret = iwl_mvm_send_cmd_pdu(mvm,
 				       WIDE_ID(MAC_CONF_GROUP, STA_CONFIG_CMD),
@@ -63,7 +63,7 @@ static int iwl_mvm_mld_add_int_sta_to_fw(struct iwl_mvm *mvm,
 					 struct iwl_mvm_int_sta *sta,
 					 const u8 *addr, int link_id)
 {
-	struct iwl_mvm_sta_cfg_cmd cmd;
+	struct iwl_sta_cfg_cmd cmd;
 
 	lockdep_assert_held(&mvm->mutex);
 
@@ -438,7 +438,7 @@ static int iwl_mvm_mld_cfg_sta(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 	struct iwl_mvm_vif *mvm_vif = iwl_mvm_vif_from_mac80211(vif);
 	struct iwl_mvm_vif_link_info *link_info =
 					mvm_vif->link[link_conf->link_id];
-	struct iwl_mvm_sta_cfg_cmd cmd = {
+	struct iwl_sta_cfg_cmd cmd = {
 		.sta_id = cpu_to_le32(mvm_link_sta->sta_id),
 		.station_type = cpu_to_le32(mvm_sta->sta_type),
 	};
-- 
2.34.1


