Return-Path: <linux-wireless+bounces-37203-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMdcOzcTHGraJQkAu9opvQ
	(envelope-from <linux-wireless+bounces-37203-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2026 12:53:43 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDE9615A90
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2026 12:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D1D233006031
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2026 10:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF58376A08;
	Sun, 31 May 2026 10:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E5oaZrES"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB5E376A06
	for <linux-wireless@vger.kernel.org>; Sun, 31 May 2026 10:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780224813; cv=none; b=asa+1NOakEaUprQccb8P6mjBstMURvUOtHEbHobMi0KRu/ntOqyKXTiqsi+pJDIZ3Dn4juz4QZaq04u0EoH8jIazyKMQX4v058aeV6ork1Om0xa4GfGiNUTfH0pMGBeviOSZhgkz4C5hqTDpgF+sklqOSuecdTryeW1mpwg3ts4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780224813; c=relaxed/simple;
	bh=CpEy4Nf6WZ8rJQoirAcc8t1boZIoNVhPkZyaUFxOJzE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PwfGQzkHg/Brb36lGs40q9kLTbOClUuVkJWUYQ6JC4LZSNhlVpOyhyb4A3aEFXhaMX7+rCsb9gKQ2Zhel+PWwi+lfDtdTNBziEX+a/djj0ap0CVxTKrvA5kys3sO1A9iv20FJYHU9ky1A1I1DQToJLS82f1pW6ap1hB0sBAEL84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E5oaZrES; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780224812; x=1811760812;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CpEy4Nf6WZ8rJQoirAcc8t1boZIoNVhPkZyaUFxOJzE=;
  b=E5oaZrESTfXX1b8/AXyQ1qiFYwfyPaHeO1uf2xuLMWjwM7+5Nw00lnkf
   fclikb3nW7LoeuWl4PIUU1xVWfjliZB4QL61fEmDg4FvL8Q+mjwFwGHcK
   Q8paY3ksbSFVGey/TH2x2t8VXGOE02hwGweD/tEU5e8DLFhG9e6+8EyQe
   5nlheGQLU8zYvCDvhDGfZ7RLv7azS810BIbdckQX5MAhFgfBrfAmMjsU/
   EPBUgMvVdbMwTLOufUvlUyUOZPCKeBZ/4EuQ0VunybzvwzBYccAVoE64I
   Ef8Ma+c3N17Nngee9qgvC80Jyopc33xBN5kkah12c+Qs0NHxCRPUXYPEE
   A==;
X-CSE-ConnectionGUID: 9bUzqNsAQK+vn0Hx2wmUFg==
X-CSE-MsgGUID: 2VxfUC8NTLyvfr4Zt4TMGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11802"; a="80039668"
X-IronPort-AV: E=Sophos;i="6.24,179,1774335600"; 
   d="scan'208";a="80039668"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2026 03:53:32 -0700
X-CSE-ConnectionGUID: +K2O8Si/Ts6PVd11HD7Kiw==
X-CSE-MsgGUID: zmPZJ4KeQ0S8yzCI5onAMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,179,1774335600"; 
   d="scan'208";a="240296009"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2026 03:53:31 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Shahar Tzarfati <shahar.tzarfati@intel.com>
Subject: [PATCH wireless-next 07/10] wifi: iwlwifi: mld: drop TLC config cmd v4/v5 compat code
Date: Sun, 31 May 2026 13:53:06 +0300
Message-Id: <20260531135036.c0e2dbfd0569.I44f8eb4d985bb9590b65b77e9a3dd157e4bd5e79@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260531105309.125363-1-miriam.rachel.korenblit@intel.com>
References: <20260531105309.125363-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-37203-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 3BDE9615A90
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Shahar Tzarfati <shahar.tzarfati@intel.com>

FW core102 bumped TLC_MNG_CONFIG_CMD_API_S from version 5 to
version 6. The v4 and v5 compatibility paths in
iwl_mld_send_tlc_cmd() are no longer reachable on any supported
firmware.

Signed-off-by: Shahar Tzarfati <shahar.tzarfati@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/datapath.h  |  2 +-
 .../net/wireless/intel/iwlwifi/fw/api/rs.h    | 31 --------
 drivers/net/wireless/intel/iwlwifi/mld/tlc.c  | 74 -------------------
 3 files changed, 1 insertion(+), 106 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h b/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h
index e494e5b18d22..c8eb016e1a7e 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h
@@ -57,7 +57,7 @@ enum iwl_data_path_subcmd_ids {
 
 	/**
 	 * @TLC_MNG_CONFIG_CMD: &struct iwl_tlc_config_cmd_v4 or
-	 *	&struct iwl_tlc_config_cmd_v5 or &struct iwl_tlc_config_cmd.
+	 *	&struct iwl_tlc_config_cmd.
 	 */
 	TLC_MNG_CONFIG_CMD = 0xF,
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h b/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h
index f90e743caa7e..f1254546cc9d 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h
@@ -206,37 +206,6 @@ struct iwl_tlc_config_cmd_v4 {
 	__le16 max_tx_op;
 } __packed; /* TLC_MNG_CONFIG_CMD_API_S_VER_4 */
 
-/**
- * struct iwl_tlc_config_cmd_v5 - TLC configuration
- * @sta_id: station id
- * @reserved1: reserved
- * @max_ch_width: max supported channel width from &enum iwl_tlc_mng_cfg_cw
- * @mode: &enum iwl_tlc_mng_cfg_mode
- * @chains: bitmask of &enum iwl_tlc_mng_cfg_chains
- * @sgi_ch_width_supp: bitmap of SGI support per channel width
- *		       use BIT(&enum iwl_tlc_mng_cfg_cw)
- * @flags: bitmask of &enum iwl_tlc_mng_cfg_flags
- * @non_ht_rates: bitmap of supported legacy rates
- * @ht_rates: bitmap of &enum iwl_tlc_mng_ht_rates, per <nss, channel-width>
- *	      pair (0 - 80mhz width and below, 1 - 160mhz, 2 - 320mhz).
- * @max_mpdu_len: max MPDU length, in bytes
- * @max_tx_op: max TXOP in uSecs for all AC (BK, BE, VO, VI),
- *	       set zero for no limit.
- */
-struct iwl_tlc_config_cmd_v5 {
-	u8 sta_id;
-	u8 reserved1[3];
-	u8 max_ch_width;
-	u8 mode;
-	u8 chains;
-	u8 sgi_ch_width_supp;
-	__le16 flags;
-	__le16 non_ht_rates;
-	__le32 ht_rates[IWL_TLC_NSS_MAX][IWL_TLC_MCS_PER_BW_NUM_V4];
-	__le16 max_mpdu_len;
-	__le16 max_tx_op;
-} __packed; /* TLC_MNG_CONFIG_CMD_API_S_VER_5 */
-
 /**
  * struct iwl_tlc_config_cmd - TLC configuration
  * @sta_mask: station mask (in NAN we can have multiple logical stations of
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/tlc.c b/drivers/net/wireless/intel/iwlwifi/mld/tlc.c
index a03834d3ac65..d044c9ba639f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/tlc.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/tlc.c
@@ -467,65 +467,6 @@ iwl_mld_fill_supp_rates(struct iwl_mld *mld,
 	}
 }
 
-static int iwl_mld_convert_tlc_cmd_to_v5(struct iwl_tlc_config_cmd *cmd,
-					 struct iwl_tlc_config_cmd_v5 *cmd_v5)
-{
-	if (WARN_ON_ONCE(hweight32(le32_to_cpu(cmd->sta_mask)) != 1))
-		return -EINVAL;
-
-	/* Convert sta_mask to sta_id */
-	cmd_v5->sta_id = __ffs(le32_to_cpu(cmd->sta_mask));
-
-	/* Copy all the rest */
-	cmd_v5->max_ch_width = cmd->max_ch_width;
-	cmd_v5->mode = cmd->mode;
-	cmd_v5->chains = cmd->chains;
-	cmd_v5->sgi_ch_width_supp = cmd->sgi_ch_width_supp;
-	cmd_v5->flags = cmd->flags;
-	cmd_v5->non_ht_rates = cmd->non_ht_rates;
-
-	BUILD_BUG_ON(sizeof(cmd_v5->ht_rates) != sizeof(cmd->ht_rates));
-	memcpy(cmd_v5->ht_rates, cmd->ht_rates, sizeof(cmd->ht_rates));
-
-	cmd_v5->max_mpdu_len = cmd->max_mpdu_len;
-	cmd_v5->max_tx_op = cmd->max_tx_op;
-
-	return 0;
-}
-
-static int iwl_mld_convert_tlc_cmd_to_v4(struct iwl_tlc_config_cmd *cmd,
-					 struct iwl_tlc_config_cmd_v4 *cmd_v4)
-{
-	if (WARN_ON_ONCE(hweight32(le32_to_cpu(cmd->sta_mask)) != 1))
-		return -EINVAL;
-
-	/* Convert sta_mask to sta_id */
-	cmd_v4->sta_id = __ffs(le32_to_cpu(cmd->sta_mask));
-
-	/* Copy everything until ht_rates */
-	cmd_v4->max_ch_width = cmd->max_ch_width;
-	cmd_v4->mode = cmd->mode;
-	cmd_v4->chains = cmd->chains;
-	cmd_v4->sgi_ch_width_supp = cmd->sgi_ch_width_supp;
-	cmd_v4->flags = cmd->flags;
-	cmd_v4->non_ht_rates = cmd->non_ht_rates;
-
-	/* Convert ht_rates from __le32 to __le16 */
-	BUILD_BUG_ON(ARRAY_SIZE(cmd_v4->ht_rates) != ARRAY_SIZE(cmd->ht_rates));
-	BUILD_BUG_ON(ARRAY_SIZE(cmd_v4->ht_rates[0]) != ARRAY_SIZE(cmd->ht_rates[0]));
-
-	for (int nss = 0; nss < ARRAY_SIZE(cmd->ht_rates); nss++)
-		for (int bw = 0; bw < ARRAY_SIZE(cmd->ht_rates[nss]); bw++)
-			cmd_v4->ht_rates[nss][bw] =
-				cpu_to_le16(le32_to_cpu(cmd->ht_rates[nss][bw]));
-
-	/* Copy the rest */
-	cmd_v4->max_mpdu_len = cmd->max_mpdu_len;
-	cmd_v4->max_tx_op = cmd->max_tx_op;
-
-	return 0;
-}
-
 static void iwl_mld_send_tlc_cmd(struct iwl_mld *mld,
 				 struct ieee80211_vif *vif,
 				 struct iwl_mld_sta *mld_sta,
@@ -544,8 +485,6 @@ static void iwl_mld_send_tlc_cmd(struct iwl_mld *mld,
 	};
 	u32 cmd_id = WIDE_ID(DATA_PATH_GROUP, TLC_MNG_CONFIG_CMD);
 	u8 cmd_ver = iwl_fw_lookup_cmd_ver(mld->fw, cmd_id, 0);
-	struct iwl_tlc_config_cmd_v5 cmd_v5 = {};
-	struct iwl_tlc_config_cmd_v4 cmd_v4 = {};
 	void *cmd_ptr;
 	u8 cmd_size;
 	int ret;
@@ -558,19 +497,6 @@ static void iwl_mld_send_tlc_cmd(struct iwl_mld *mld,
 	if (cmd_ver == 6) {
 		cmd_ptr = &cmd;
 		cmd_size = sizeof(cmd);
-	} else if (cmd_ver == 5) {
-		/* TODO: remove support once FW moves to version 6 */
-		ret = iwl_mld_convert_tlc_cmd_to_v5(&cmd, &cmd_v5);
-		if (ret)
-			return;
-		cmd_ptr = &cmd_v5;
-		cmd_size = sizeof(cmd_v5);
-	} else if (cmd_ver == 4) {
-		ret = iwl_mld_convert_tlc_cmd_to_v4(&cmd, &cmd_v4);
-		if (ret)
-			return;
-		cmd_ptr = &cmd_v4;
-		cmd_size = sizeof(cmd_v4);
 	} else {
 		IWL_ERR(mld, "Unsupported TLC config cmd version %d\n",
 			cmd_ver);
-- 
2.34.1


