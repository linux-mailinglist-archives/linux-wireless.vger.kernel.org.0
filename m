Return-Path: <linux-wireless+bounces-36363-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uIX2IOYPBGouDAIAu9opvQ
	(envelope-from <linux-wireless+bounces-36363-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 07:45:10 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 00CE352DB0A
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 07:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A958C308FDD4
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 05:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E54F3A6EEF;
	Wed, 13 May 2026 05:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G8VL8D99"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3993E3A48E0
	for <linux-wireless@vger.kernel.org>; Wed, 13 May 2026 05:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778651066; cv=none; b=kPkB6LEvdEzH1QTTd9wrBH5vdyjFr/VHDk07kvYtPHssaVJHGvRZvGC2qE0H3fBUWcSnwaI2KmlEuW6vvQTVOBJGJddjMSNsXrWe336brSpyBEzWg5R1ppCqTLjUVn3EmPBQiyMZko2n3byjhafGG3CJOLCskkuqWZtZjoiL3Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778651066; c=relaxed/simple;
	bh=5p2ZQtSzwIsKTL7xHHp0Fv5CyG4M2LZMKMlWnRMZaUU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DJ+6SoJSo65QhV7XKWhuyWduL5Qp7umn0MhBq55ZViEn2Sa2AiHfEOtwKERnZUR/4ohkv1/lvMV2F07tqTPnKxpBy7sYm08RZjkAdxrPEd4YnMazk7l2Znqb3V3JSD6js7ix1eThaWtgQQRXNoy+5Q3+CInK3vP3PYXi8t4hPr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G8VL8D99; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778651064; x=1810187064;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5p2ZQtSzwIsKTL7xHHp0Fv5CyG4M2LZMKMlWnRMZaUU=;
  b=G8VL8D99ZGu2ix6B3tTDQwMklS3A4BrnK6d91JIUY3xsVgYJj+0vci4f
   xQoaqXqTv5wp2EvUTrzy+Fep7tnLDPM48JKTbWrMDOfQHj7sfYUR6K8AH
   jFJ3Kvzo2+s9tmoIC8Vp+suARcNe4IEGZGVSLyI/PEQ6z3qHXNdVA1dvE
   QpirR0nAVc1n2v2TI4BYa0iHpK+FkAn3fntSTAxkoZ7cEcQuNLggLDTFi
   vLAKJYllsZ316I1HTzGJ7fnarW6Q2IUOUWDHYc29TupNsLLcD9QzUPfr+
   srNN4Ldn8IEROeCYG6ZmDO3zDatmNiaLwSI6X4GuKH/KP4FczUoOyPIiX
   g==;
X-CSE-ConnectionGUID: TWmUlSYYR8a+bOxb4AgOMQ==
X-CSE-MsgGUID: qndg3e3SQR2VzNpnvo895g==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="79552828"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="79552828"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 22:44:24 -0700
X-CSE-ConnectionGUID: +qRzEtPdRPGuv+9WflDZAw==
X-CSE-MsgGUID: Wrkz8bckRJq+AnE77cU7Vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="238077923"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 22:44:23 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 06/15] wifi: iwlwifi: mld: support NPCA capability for UHR devices
Date: Wed, 13 May 2026 08:43:53 +0300
Message-Id: <20260513084215.8c88bf84af91.If59ceaa49c2431e08941bcba3b2e75bb93aaad63@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260513054402.2897702-1-miriam.rachel.korenblit@intel.com>
References: <20260513054402.2897702-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 00CE352DB0A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36363-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	URIBL_MULTI_FAIL(0.00)[intel.com:server fail,sea.lore.kernel.org:server fail];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim]
X-Rspamd-Action: no action

From: Johannes Berg <johannes.berg@intel.com>

UHR devices have NPCA capability, so implement the necessary
configuration and set the capability bit.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/mac-cfg.h   |  4 +-
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    |  3 ++
 drivers/net/wireless/intel/iwlwifi/mld/link.c | 15 +++++++
 .../net/wireless/intel/iwlwifi/mld/mac80211.c | 39 ++++++++++++++++++-
 drivers/net/wireless/intel/iwlwifi/mld/phy.c  | 24 ++++++++++--
 5 files changed, 80 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
index dde6cfd9d286..fa2fc6a92e60 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
@@ -549,12 +549,14 @@ enum iwl_link_ctx_protection_flags {
  *      radar pulses).
  * @LINK_FLG_NDP_FEEDBACK_ENABLED: mark support for NDP feedback and change
  *	of threshold
+ * @LINK_FLG_NPCA: NPCA enabled
  */
 enum iwl_link_ctx_flags {
 	LINK_FLG_BSS_COLOR_DIS		= BIT(0),
 	LINK_FLG_MU_EDCA_CW		= BIT(1),
 	LINK_FLG_RU_2MHZ_BLOCK		= BIT(2),
 	LINK_FLG_NDP_FEEDBACK_ENABLED	= BIT(3),
+	LINK_FLG_NPCA			= BIT(4),
 }; /* LINK_CONTEXT_FLAG_E_VER_1 */
 
 /**
@@ -591,7 +593,7 @@ enum iwl_npca_flags {
  * @initial_qsrc: Indicates the value that is used to initialize the
  *	EDCAF QSRC[AC] variables
  * @min_dur_threshold: minimum PPDU time to switch to the non-primary
- *	NPCA channel (usec)
+ *	NPCA channel (spec representation)
  * @flags: NPCA flags, see &enum iwl_npca_flags
  * @reserved: reserved for alignment purposes
  */
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index 38ff6f944add..4e8222ffe732 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -695,6 +695,9 @@ static const struct ieee80211_sband_iftype_data iwl_iftype_cap[] = {
 			.has_uhr = true,
 			.phy.cap = IEEE80211_UHR_PHY_CAP_ELR_RX |
 				   IEEE80211_UHR_PHY_CAP_ELR_TX,
+			.mac.mac_cap = {
+				[0] = IEEE80211_UHR_MAC_CAP0_NPCA_SUPP,
+			},
 		},
 	},
 	{
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/link.c b/drivers/net/wireless/intel/iwlwifi/mld/link.c
index 805f2e2eac38..9ef39b03e67f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/link.c
@@ -374,6 +374,21 @@ iwl_mld_change_link_in_fw(struct iwl_mld *mld, struct ieee80211_bss_conf *link,
 	if (WARN_ON(changes & LINK_CONTEXT_MODIFY_EHT_PARAMS))
 		changes &= ~LINK_CONTEXT_MODIFY_EHT_PARAMS;
 
+	if (link->uhr_support && link->npca.enabled) {
+		flags |= LINK_FLG_NPCA;
+		if (link->npca.moplen)
+			cmd.npca_params.flags |= IWL_NPCA_FLAG_MAC_HDR_BASED;
+		cmd.npca_params.dis_subch_bmap =
+			cpu_to_le16(link->chanreq.oper.npca_punctured);
+		cmd.npca_params.initial_qsrc = link->npca.init_qsrc;
+		cmd.npca_params.min_dur_threshold = link->npca.min_dur_thresh;
+		/* spec/mac80211 have these in units of 4 usec */
+		cmd.npca_params.switch_delay =
+			4 * link->npca.switch_delay;
+		cmd.npca_params.switch_back_delay =
+			4 * link->npca.switch_back_delay;
+	}
+
 send_cmd:
 	cmd.modify_mask = cpu_to_le32(changes);
 	cmd.flags = cpu_to_le32(flags);
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index 41bc47e4e00c..1f2843af39c1 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -981,6 +981,30 @@ void iwl_mld_remove_chanctx(struct ieee80211_hw *hw,
 	mld->used_phy_ids &= ~BIT(phy->fw_id);
 }
 
+static void
+iwl_mld_update_link_npca_puncturing(struct ieee80211_hw *hw,
+				    struct ieee80211_chanctx_conf *ctx)
+{
+	struct iwl_mld *mld = IWL_MAC80211_GET_MLD(hw);
+	struct ieee80211_vif *vif;
+
+	for_each_active_interface(vif, hw) {
+		struct ieee80211_bss_conf *link;
+		int link_id;
+
+		for_each_vif_active_link(vif, link, link_id) {
+			if (rcu_access_pointer(link->chanctx_conf) != ctx)
+				continue;
+
+			if (!link->npca.enabled)
+				continue;
+
+			iwl_mld_change_link_in_fw(mld, link,
+						  LINK_CONTEXT_MODIFY_UHR_PARAMS);
+		}
+	}
+}
+
 static
 void iwl_mld_change_chanctx(struct ieee80211_hw *hw,
 			    struct ieee80211_chanctx_conf *ctx, u32 changed)
@@ -996,9 +1020,19 @@ void iwl_mld_change_chanctx(struct ieee80211_hw *hw,
 			  IEEE80211_CHANCTX_CHANGE_CHANNEL)))
 		return;
 
+	/* NPCA puncturing is in link API for FW */
+	if (changed & IEEE80211_CHANCTX_CHANGE_NPCA_PUNCT) {
+		iwl_mld_update_link_npca_puncturing(hw, ctx);
+		changed &= ~IEEE80211_CHANCTX_CHANGE_NPCA_PUNCT;
+	}
+
 	/* Check if a FW update is required */
 
-	if (changed & IEEE80211_CHANCTX_CHANGE_AP)
+	if (!changed)
+		return;
+
+	if (changed & IEEE80211_CHANCTX_CHANGE_AP ||
+	    changed & IEEE80211_CHANCTX_CHANGE_NPCA)
 		goto update;
 
 	if (chandef->chan == phy->chandef.chan &&
@@ -1255,6 +1289,9 @@ u32 iwl_mld_link_changed_mapping(struct iwl_mld *mld,
 		link_changes |= LINK_CONTEXT_MODIFY_HE_PARAMS;
 	}
 
+	if (changes & BSS_CHANGED_NPCA)
+		link_changes |= LINK_CONTEXT_MODIFY_UHR_PARAMS;
+
 	return link_changes;
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/phy.c b/drivers/net/wireless/intel/iwlwifi/mld/phy.c
index 1d93fb9e4dbf..59bf088ead84 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/phy.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/phy.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2024-2025 Intel Corporation
+ * Copyright (C) 2024-2026 Intel Corporation
  */
 #include <net/mac80211.h>
 
@@ -99,9 +99,9 @@ iwl_mld_nl80211_width_to_fw(enum nl80211_chan_width width)
 /* Maps the driver specific control channel position (relative to the center
  * freq) definitions to the fw values
  */
-u8 iwl_mld_get_fw_ctrl_pos(const struct cfg80211_chan_def *chandef)
+static u8 _iwl_mld_get_fw_ctrl_pos(u32 control, u32 cf1)
 {
-	int offs = chandef->chan->center_freq - chandef->center_freq1;
+	int offs = control - cf1;
 	int abs_offs = abs(offs);
 	u8 ret;
 
@@ -127,6 +127,12 @@ u8 iwl_mld_get_fw_ctrl_pos(const struct cfg80211_chan_def *chandef)
 	return ret;
 }
 
+u8 iwl_mld_get_fw_ctrl_pos(const struct cfg80211_chan_def *chandef)
+{
+	return _iwl_mld_get_fw_ctrl_pos(chandef->chan->center_freq,
+					chandef->center_freq1);
+}
+
 int iwl_mld_phy_fw_action(struct iwl_mld *mld,
 			  struct ieee80211_chanctx_conf *ctx, u32 action)
 {
@@ -150,6 +156,18 @@ int iwl_mld_phy_fw_action(struct iwl_mld *mld,
 		cmd.sbb_ctrl_channel_loc = iwl_mld_get_fw_ctrl_pos(&ctx->ap);
 	}
 
+	/*
+	 * Set NPCA channel if NPCA is used; if not used, just set it to an
+	 * arbitrary channel on the other side to help firmware.
+	 */
+	if (chandef->npca_chan)
+		cmd.secondary_ctrl_chnl_loc =
+			_iwl_mld_get_fw_ctrl_pos(chandef->npca_chan->center_freq,
+						 chandef->center_freq1);
+	else
+		cmd.secondary_ctrl_chnl_loc =
+			cmd.ci.ctrl_pos ^ IWL_PHY_CTRL_POS_ABOVE;
+
 	ret = iwl_mld_send_cmd_pdu(mld, PHY_CONTEXT_CMD, &cmd);
 	if (ret)
 		IWL_ERR(mld, "Failed to send PHY_CONTEXT_CMD ret = %d\n", ret);
-- 
2.34.1


