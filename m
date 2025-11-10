Return-Path: <linux-wireless+bounces-28774-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC0AC46BF3
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 14:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 561274E7CD3
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 13:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C628C1E2307;
	Mon, 10 Nov 2025 13:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JSpuoawu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A413101DB
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 13:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762779765; cv=none; b=o0F0sPj+LuM4RKb02SRHmM/0g63GXjKzq16aFDEudo+P6ACa444D7ZBGr8H246wgXhReLsPo6p7aSDiz8/oeHhkcOvEcpCtcrCyrjkEPAFN7sakpaSmhUJwOQYXDZwB/IV74aWexi1DHuh9V84SdiuEPugH5VToURYkwtSvAIIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762779765; c=relaxed/simple;
	bh=nsbE0dL53r8dXlIxS66PxP50xfLcYh2krzOvSuwM4l0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j1WJuJHkjDBwdGcMkBzcQZLi1jtzvgmqPcn7h3ptI7GuCU4pQHZPUxn+AKWKjxHpek5jAs5fqzqmFgWABCuLYuGL5xOAffwxG8mFcrfUxkHiRtbfUWlQm7tFlhOszHxIj594sqCPIKlAG5lkrxA3g2yQFWIBsLd6TqX2jI/qecQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JSpuoawu; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762779764; x=1794315764;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nsbE0dL53r8dXlIxS66PxP50xfLcYh2krzOvSuwM4l0=;
  b=JSpuoawu7tfhs4ONdipK9pOio7oKLSfMC41TA785vNXOu7tC4R74JEWa
   aX4NP3jv74Z4VG0X/E7FQ6f+8/6LUEIgkxW7gPPcx6DeAla/cwdz1fWoP
   JC/f9VkHJrAgZ38RAVck0AIR970WXssQ1loPgAgw0k8Cb3dj5hwcVaeaK
   GGAAocaFcIFVYmlK23RUMuCRRolQEXiET77SKemE9GrlHazH1wBLs+fE8
   HgcN8a2x0OWvDoonAOP9CA/BxyQVIJfaYxoftuPQhZtv/w9pB4WQYZin2
   OjA/leJfFXRxdELKSo86WrhewNr63HAZvNjfaFP4Wltzcnc+Ia0bDPQdX
   w==;
X-CSE-ConnectionGUID: lZsELEQXQOmWMGRFvQm3gQ==
X-CSE-MsgGUID: hBYc2DADS5SNM50XI+yomw==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="82454885"
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="82454885"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 05:02:42 -0800
X-CSE-ConnectionGUID: kR1E3GEdQuWtr0z99Ywcuw==
X-CSE-MsgGUID: LrSkH164QxSFfSf+pGWFEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="192928528"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 05:02:41 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-next 07/15] wifi: iwlwifi: mld: support TLC command version 6
Date: Mon, 10 Nov 2025 15:02:18 +0200
Message-Id: <20251110150012.64220c6b292b.I2f5d195ce2bf9d35398f0f6f2d5faf9e90ae45a4@changeid>
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

In version 6, a phy id is added to the tlc command and the sta_id
becomes a sta_mask.

This change is required for NAN:
- in NAN we can have 2 logical stations of the same physical
  station and with the same channel/band (2 NDIs with the same peer) -
  hence the sta_mask.
- In NAN we can have more than one TLC configuration for a single
  station (for example if it operates on more than one channel) - so the
  FW needs to be able to find the right TLC context, based on the phy id.

Populate the new version (for now with a single station id only. The
other ones will be added later when NAN is implemented).

In case the FW has a lower version than that - convert it to the FW
version.
Note that there is some code duplicantion in the conversions to v5
and to v4, but this is intentional since v5 will be removed as soon as
v6 is supported.

Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/rs.h    | 36 +++++++-
 drivers/net/wireless/intel/iwlwifi/mld/tlc.c  | 85 ++++++++++++++++---
 2 files changed, 106 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h b/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h
index 9c464e7aba10..8a998747dd95 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h
@@ -205,7 +205,7 @@ struct iwl_tlc_config_cmd_v4 {
 } __packed; /* TLC_MNG_CONFIG_CMD_API_S_VER_4 */
 
 /**
- * struct iwl_tlc_config_cmd - TLC configuration
+ * struct iwl_tlc_config_cmd_v5 - TLC configuration
  * @sta_id: station id
  * @reserved1: reserved
  * @max_ch_width: max supported channel width from &enum iwl_tlc_mng_cfg_cw
@@ -221,7 +221,7 @@ struct iwl_tlc_config_cmd_v4 {
  * @max_tx_op: max TXOP in uSecs for all AC (BK, BE, VO, VI),
  *	       set zero for no limit.
  */
-struct iwl_tlc_config_cmd {
+struct iwl_tlc_config_cmd_v5 {
 	u8 sta_id;
 	u8 reserved1[3];
 	u8 max_ch_width;
@@ -235,6 +235,38 @@ struct iwl_tlc_config_cmd {
 	__le16 max_tx_op;
 } __packed; /* TLC_MNG_CONFIG_CMD_API_S_VER_5 */
 
+/**
+ * struct iwl_tlc_config_cmd - TLC configuration
+ * @sta_mask: station mask (in NAN we can have multiple logical stations of
+ *	the same peer (with the same TLC configuration)).
+ * @phy_id: the phy id to used for this TLC configuration
+ * @max_ch_width: max supported channel width from &enum iwl_tlc_mng_cfg_cw
+ * @mode: &enum iwl_tlc_mng_cfg_mode
+ * @chains: bitmask of &enum iwl_tlc_mng_cfg_chains
+ * @sgi_ch_width_supp: bitmap of SGI support per channel width
+ *		       use BIT(&enum iwl_tlc_mng_cfg_cw)
+ * @flags: bitmask of &enum iwl_tlc_mng_cfg_flags
+ * @non_ht_rates: bitmap of supported legacy rates
+ * @ht_rates: bitmap of &enum iwl_tlc_mng_ht_rates, per <nss, channel-width>
+ *	      pair (0 - 80mhz width and below, 1 - 160mhz, 2 - 320mhz).
+ * @max_mpdu_len: max MPDU length, in bytes
+ * @max_tx_op: max TXOP in uSecs for all AC (BK, BE, VO, VI),
+ *	       set zero for no limit.
+ */
+struct iwl_tlc_config_cmd {
+	__le32 sta_mask;
+	__le32 phy_id;
+	u8 max_ch_width;
+	u8 mode;
+	u8 chains;
+	u8 sgi_ch_width_supp;
+	__le16 flags;
+	__le16 non_ht_rates;
+	__le32 ht_rates[IWL_TLC_NSS_MAX][IWL_TLC_MCS_PER_BW_NUM_V4];
+	__le16 max_mpdu_len;
+	__le16 max_tx_op;
+} __packed; /* TLC_MNG_CONFIG_CMD_API_S_VER_6 */
+
 /**
  * enum iwl_tlc_update_flags - updated fields
  * @IWL_TLC_NOTIF_FLAG_RATE: last initial rate update
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/tlc.c b/drivers/net/wireless/intel/iwlwifi/mld/tlc.c
index 0e172281b0c8..62a54c37a98c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/tlc.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/tlc.c
@@ -8,6 +8,7 @@
 #include "tlc.h"
 #include "hcmd.h"
 #include "sta.h"
+#include "phy.h"
 
 #include "fw/api/rs.h"
 #include "fw/api/context.h"
@@ -447,11 +448,48 @@ iwl_mld_fill_supp_rates(struct iwl_mld *mld, struct ieee80211_vif *vif,
 	}
 }
 
-static void iwl_mld_convert_tlc_cmd_to_v4(struct iwl_tlc_config_cmd *cmd,
-					  struct iwl_tlc_config_cmd_v4 *cmd_v4)
+static int iwl_mld_convert_tlc_cmd_to_v5(struct iwl_tlc_config_cmd *cmd,
+					 struct iwl_tlc_config_cmd_v5 *cmd_v5)
 {
+	if (WARN_ON_ONCE(hweight32(le32_to_cpu(cmd->sta_mask)) != 1))
+		return -EINVAL;
+
+	/* Convert sta_mask to sta_id */
+	cmd_v5->sta_id = __ffs(le32_to_cpu(cmd->sta_mask));
+
+	/* Copy all the rest */
+	cmd_v5->max_ch_width = cmd->max_ch_width;
+	cmd_v5->mode = cmd->mode;
+	cmd_v5->chains = cmd->chains;
+	cmd_v5->sgi_ch_width_supp = cmd->sgi_ch_width_supp;
+	cmd_v5->flags = cmd->flags;
+	cmd_v5->non_ht_rates = cmd->non_ht_rates;
+
+	BUILD_BUG_ON(sizeof(cmd_v5->ht_rates) != sizeof(cmd->ht_rates));
+	memcpy(cmd_v5->ht_rates, cmd->ht_rates, sizeof(cmd->ht_rates));
+
+	cmd_v5->max_mpdu_len = cmd->max_mpdu_len;
+	cmd_v5->max_tx_op = cmd->max_tx_op;
+
+	return 0;
+}
+
+static int iwl_mld_convert_tlc_cmd_to_v4(struct iwl_tlc_config_cmd *cmd,
+					 struct iwl_tlc_config_cmd_v4 *cmd_v4)
+{
+	if (WARN_ON_ONCE(hweight32(le32_to_cpu(cmd->sta_mask)) != 1))
+		return -EINVAL;
+
+	/* Convert sta_mask to sta_id */
+	cmd_v4->sta_id = __ffs(le32_to_cpu(cmd->sta_mask));
+
 	/* Copy everything until ht_rates */
-	memcpy(cmd_v4, cmd, offsetof(struct iwl_tlc_config_cmd, ht_rates));
+	cmd_v4->max_ch_width = cmd->max_ch_width;
+	cmd_v4->mode = cmd->mode;
+	cmd_v4->chains = cmd->chains;
+	cmd_v4->sgi_ch_width_supp = cmd->sgi_ch_width_supp;
+	cmd_v4->flags = cmd->flags;
+	cmd_v4->non_ht_rates = cmd->non_ht_rates;
 
 	/* Convert ht_rates from __le32 to __le16 */
 	BUILD_BUG_ON(ARRAY_SIZE(cmd_v4->ht_rates) != ARRAY_SIZE(cmd->ht_rates));
@@ -465,14 +503,17 @@ static void iwl_mld_convert_tlc_cmd_to_v4(struct iwl_tlc_config_cmd *cmd,
 	/* Copy the rest */
 	cmd_v4->max_mpdu_len = cmd->max_mpdu_len;
 	cmd_v4->max_tx_op = cmd->max_tx_op;
+
+	return 0;
 }
 
 static void iwl_mld_send_tlc_cmd(struct iwl_mld *mld,
 				 struct ieee80211_vif *vif,
 				 struct ieee80211_link_sta *link_sta,
-				 enum nl80211_band band)
+				 struct ieee80211_bss_conf *link)
 {
 	struct iwl_mld_sta *mld_sta = iwl_mld_sta_from_mac80211(link_sta->sta);
+	enum nl80211_band band = link->chanreq.oper.chan->band;
 	struct ieee80211_supported_band *sband = mld->hw->wiphy->bands[band];
 	const struct ieee80211_sta_he_cap *own_he_cap =
 		ieee80211_get_he_iftype_cap_vif(sband, vif);
@@ -492,25 +533,44 @@ static void iwl_mld_send_tlc_cmd(struct iwl_mld *mld,
 	int fw_sta_id = iwl_mld_fw_sta_id_from_link_sta(mld, link_sta);
 	u32 cmd_id = WIDE_ID(DATA_PATH_GROUP, TLC_MNG_CONFIG_CMD);
 	u8 cmd_ver = iwl_fw_lookup_cmd_ver(mld->fw, cmd_id, 0);
-	struct iwl_tlc_config_cmd_v4 cmd_v4;
+	struct ieee80211_chanctx_conf *chan_ctx;
+	struct iwl_tlc_config_cmd_v5 cmd_v5 = {};
+	struct iwl_tlc_config_cmd_v4 cmd_v4 = {};
 	void *cmd_ptr;
 	u8 cmd_size;
+	u32 phy_id;
 	int ret;
 
 	if (fw_sta_id < 0)
 		return;
 
-	cmd.sta_id = fw_sta_id;
+	cmd.sta_mask = cpu_to_le32(BIT(fw_sta_id));
+
+	chan_ctx = rcu_dereference_wiphy(mld->wiphy, link->chanctx_conf);
+	if (WARN_ON(!chan_ctx))
+		return;
+
+	phy_id = iwl_mld_phy_from_mac80211(chan_ctx)->fw_id;
+	cmd.phy_id = cpu_to_le32(phy_id);
 
 	iwl_mld_fill_supp_rates(mld, vif, link_sta, sband,
 				own_he_cap, own_eht_cap,
 				&cmd);
 
-	if (cmd_ver == 5) {
+	if (cmd_ver == 6) {
 		cmd_ptr = &cmd;
 		cmd_size = sizeof(cmd);
+	} else if (cmd_ver == 5) {
+		/* TODO: remove support once FW moves to version 6 */
+		ret = iwl_mld_convert_tlc_cmd_to_v5(&cmd, &cmd_v5);
+		if (ret)
+			return;
+		cmd_ptr = &cmd_v5;
+		cmd_size = sizeof(cmd_v5);
 	} else if (cmd_ver == 4) {
-		iwl_mld_convert_tlc_cmd_to_v4(&cmd, &cmd_v4);
+		ret = iwl_mld_convert_tlc_cmd_to_v4(&cmd, &cmd_v4);
+		if (ret)
+			return;
 		cmd_ptr = &cmd_v4;
 		cmd_size = sizeof(cmd_v4);
 	} else {
@@ -520,8 +580,9 @@ static void iwl_mld_send_tlc_cmd(struct iwl_mld *mld,
 	}
 
 	IWL_DEBUG_RATE(mld,
-		       "TLC CONFIG CMD, sta_id=%d, max_ch_width=%d, mode=%d\n",
-		       cmd.sta_id, cmd.max_ch_width, cmd.mode);
+		       "TLC CONFIG CMD, sta_mask=0x%x, max_ch_width=%d, mode=%d, phy_id=%d\n",
+		       le32_to_cpu(cmd.sta_mask), cmd.max_ch_width, cmd.mode,
+		       le32_to_cpu(cmd.phy_id));
 
 	/* Send async since this can be called within a RCU-read section */
 	ret = iwl_mld_send_cmd_with_flags_pdu(mld, cmd_id, CMD_ASYNC, cmd_ptr,
@@ -561,7 +622,6 @@ void iwl_mld_config_tlc_link(struct iwl_mld *mld,
 			     struct ieee80211_link_sta *link_sta)
 {
 	struct iwl_mld_sta *mld_sta = iwl_mld_sta_from_mac80211(link_sta->sta);
-	enum nl80211_band band;
 
 	if (WARN_ON_ONCE(!link_conf->chanreq.oper.chan))
 		return;
@@ -575,8 +635,7 @@ void iwl_mld_config_tlc_link(struct iwl_mld *mld,
 		ieee80211_sta_recalc_aggregates(link_sta->sta);
 	}
 
-	band = link_conf->chanreq.oper.chan->band;
-	iwl_mld_send_tlc_cmd(mld, vif, link_sta, band);
+	iwl_mld_send_tlc_cmd(mld, vif, link_sta, link_conf);
 }
 
 void iwl_mld_config_tlc(struct iwl_mld *mld, struct ieee80211_vif *vif,
-- 
2.34.1


