Return-Path: <linux-wireless+bounces-3347-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7AD684E5BA
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Feb 2024 17:59:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1828E1C25810
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Feb 2024 16:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3457073164;
	Thu,  8 Feb 2024 16:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zm+dGU3b"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8AF811EC
	for <linux-wireless@vger.kernel.org>; Thu,  8 Feb 2024 16:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707411542; cv=none; b=AGrbSpTmltBk14A8qWowuF5fEmwxsxe4cSIcBUP6UlDoWUySxcYLTcE3wmPLODbdxGEpfoJ3It+MXyniEHCX7B81JO0kON9dQ/00N8lGI46Nt/PUlEUDJImSIHOsVLDvFziVyJRIfuJHIQysahMipJeXBWDcIaHe8DAffk9v4e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707411542; c=relaxed/simple;
	bh=Yk8d0R29RS8ZHNcQd0KLy6M7Q8n2KZwPpFOKkwsayLo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M9DE/9+1flD5QsrYe0jvmguZX/z9rz1VHVRKCG/32mgXqpdSwsnvsJkZ99rnCUl26Vki5FSrCQyeutbn3nFJelsEbGZbTTEtgeTOzOsYMAxzvYZXscGG75mjtXWIWkGFgXf56fkD4h4bNfcR/hiFzOpKvPtLmRWgrT4bLso2fVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zm+dGU3b; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707411540; x=1738947540;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Yk8d0R29RS8ZHNcQd0KLy6M7Q8n2KZwPpFOKkwsayLo=;
  b=Zm+dGU3bzofYMKX7M/c5lrIAyITXrbW24maSLTciIEc0q9uOVwTojrnQ
   2zwpifhkghM2Lk6dSVLbHFaS1R8KMAVRxTAvpepqwQuc4PSJXEKwu8uT9
   YnKJzLQlLf/nOt6mf7mhEWhKABmPL7anhzgcJCurXDR8EmgLH5nxKe4b0
   IP3Gz6waIpewkx4+7OqYP8SNvAjN1sHT0nD3ilCAKu8+kIWLaZnnpKd65
   9QwwZiPeIjfw3bQ+rES3TwDl6UzjxM3fGZijLr/ZKAK2yC/Ee+Z2Qo4lO
   F4xF1dZhKYN3Ms4c6mBvAjT1iRJcS+fa9D6JBCDftbwRE56w9Twl/WNdw
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1403963"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="1403963"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 08:59:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="6318814"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 08:58:58 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Mukesh Sisodiya <mukesh.sisodiya@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 01/13] wifi: iwlwifi: nvm: parse the VLP/AFC bit from regulatory
Date: Thu,  8 Feb 2024 18:58:35 +0200
Message-Id: <20240208185302.9c6a4acabdb3.I501de5c0d86b9702bf61158a2e91c954a1da9a2a@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240208165847.1190596-1-miriam.rachel.korenblit@intel.com>
References: <20240208165847.1190596-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Mukesh Sisodiya <mukesh.sisodiya@intel.com>

6 GHz STA supports different power types as LPI, SP, VLP.
and this information is provided by regulatory info.

Add support in driver to parse the power type capability in
regulatory info from FW and set it to the channel flags.

Signed-off-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    | 33 ++++++++++++++++---
 .../wireless/intel/iwlwifi/iwl-nvm-parse.h    |  2 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  3 +-
 3 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index d2f133255ee6..baa39a18087a 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -156,6 +156,8 @@ static struct ieee80211_rate iwl_cfg80211_rates[] = {
  * @NVM_CHANNEL_80MHZ: 80 MHz channel okay
  * @NVM_CHANNEL_160MHZ: 160 MHz channel okay
  * @NVM_CHANNEL_DC_HIGH: DC HIGH required/allowed (?)
+ * @NVM_CHANNEL_VLP: client support connection to UHB VLP AP
+ * @NVM_CHANNEL_AFC: client support connection to UHB AFC AP
  */
 enum iwl_nvm_channel_flags {
 	NVM_CHANNEL_VALID		= BIT(0),
@@ -170,6 +172,8 @@ enum iwl_nvm_channel_flags {
 	NVM_CHANNEL_80MHZ		= BIT(10),
 	NVM_CHANNEL_160MHZ		= BIT(11),
 	NVM_CHANNEL_DC_HIGH		= BIT(12),
+	NVM_CHANNEL_VLP			= BIT(13),
+	NVM_CHANNEL_AFC			= BIT(14),
 };
 
 /**
@@ -309,7 +313,7 @@ static inline void iwl_nvm_print_channel_flags(struct device *dev, u32 level,
 
 	/* Note: already can print up to 101 characters, 110 is the limit! */
 	IWL_DEBUG_DEV(dev, level,
-		      "Ch. %d: 0x%x:%s%s%s%s%s%s%s%s%s%s%s%s\n",
+		      "Ch. %d: 0x%x:%s%s%s%s%s%s%s%s%s%s%s%s%s%s\n",
 		      chan, flags,
 		      CHECK_AND_PRINT_I(VALID),
 		      CHECK_AND_PRINT_I(IBSS),
@@ -322,7 +326,9 @@ static inline void iwl_nvm_print_channel_flags(struct device *dev, u32 level,
 		      CHECK_AND_PRINT_I(40MHZ),
 		      CHECK_AND_PRINT_I(80MHZ),
 		      CHECK_AND_PRINT_I(160MHZ),
-		      CHECK_AND_PRINT_I(DC_HIGH));
+		      CHECK_AND_PRINT_I(DC_HIGH),
+		      CHECK_AND_PRINT_I(VLP),
+		      CHECK_AND_PRINT_I(AFC));
 #undef CHECK_AND_PRINT_I
 }
 
@@ -366,6 +372,12 @@ static u32 iwl_get_channel_flags(u8 ch_num, int ch_idx, enum nl80211_band band,
 	    (flags & IEEE80211_CHAN_NO_IR))
 		flags |= IEEE80211_CHAN_IR_CONCURRENT;
 
+	/* Set the AP type for the UHB case. */
+	if (!(nvm_flags & NVM_CHANNEL_VLP))
+		flags |= IEEE80211_CHAN_NO_6GHZ_VLP_CLIENT;
+	if (!(nvm_flags & NVM_CHANNEL_AFC))
+		flags |= IEEE80211_CHAN_NO_6GHZ_AFC_CLIENT;
+
 	return flags;
 }
 
@@ -1600,7 +1612,8 @@ IWL_EXPORT_SYMBOL(iwl_parse_nvm_data);
 static u32 iwl_nvm_get_regdom_bw_flags(const u16 *nvm_chan,
 				       int ch_idx, u16 nvm_flags,
 				       struct iwl_reg_capa reg_capa,
-				       const struct iwl_cfg *cfg)
+				       const struct iwl_cfg *cfg,
+				       bool uats_enabled)
 {
 	u32 flags = NL80211_RRF_NO_HT40;
 
@@ -1645,6 +1658,16 @@ static u32 iwl_nvm_get_regdom_bw_flags(const u16 *nvm_chan,
 			flags &= ~NL80211_RRF_NO_IR;
 		}
 	}
+
+	/* Set the AP type for the UHB case. */
+	if (uats_enabled) {
+		if (!(nvm_flags & NVM_CHANNEL_VLP))
+			flags |= NL80211_RRF_NO_6GHZ_VLP_CLIENT;
+
+		if (!(nvm_flags & NVM_CHANNEL_AFC))
+			flags |= NL80211_RRF_NO_6GHZ_AFC_CLIENT;
+	}
+
 	/*
 	 * reg_capa is per regulatory domain so apply it for every channel
 	 */
@@ -1699,7 +1722,7 @@ static struct iwl_reg_capa iwl_get_reg_capa(u32 flags, u8 resp_ver)
 struct ieee80211_regdomain *
 iwl_parse_nvm_mcc_info(struct device *dev, const struct iwl_cfg *cfg,
 		       int num_of_ch, __le32 *channels, u16 fw_mcc,
-		       u16 geo_info, u32 cap, u8 resp_ver)
+		       u16 geo_info, u32 cap, u8 resp_ver, bool uats_enabled)
 {
 	int ch_idx;
 	u16 ch_flags;
@@ -1765,7 +1788,7 @@ iwl_parse_nvm_mcc_info(struct device *dev, const struct iwl_cfg *cfg,
 
 		reg_rule_flags = iwl_nvm_get_regdom_bw_flags(nvm_chan, ch_idx,
 							     ch_flags, reg_capa,
-							     cfg);
+							     cfg, uats_enabled);
 
 		/* we can't continue the same rule */
 		if (ch_idx == 0 || prev_reg_rule_flags != reg_rule_flags ||
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h
index 651ed25b683b..fd9c3bed9407 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h
@@ -50,7 +50,7 @@ iwl_parse_nvm_data(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 struct ieee80211_regdomain *
 iwl_parse_nvm_mcc_info(struct device *dev, const struct iwl_cfg *cfg,
 		       int num_of_ch, __le32 *channels, u16 fw_mcc,
-		       u16 geo_info, u32 cap, u8 resp_ver);
+		       u16 geo_info, u32 cap, u8 resp_ver, bool uats_enabled);
 
 /**
  * struct iwl_nvm_section - describes an NVM section in memory.
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index a051e0c955d5..4a6b4f82eab4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -138,7 +138,8 @@ struct ieee80211_regdomain *iwl_mvm_get_regdomain(struct wiphy *wiphy,
 				      resp->channels,
 				      __le16_to_cpu(resp->mcc),
 				      __le16_to_cpu(resp->geo_info),
-				      le32_to_cpu(resp->cap), resp_ver);
+				      le32_to_cpu(resp->cap), resp_ver,
+				      mvm->fwrt.uats_enabled);
 	/* Store the return source id */
 	src_id = resp->source_id;
 	if (IS_ERR_OR_NULL(regd)) {
-- 
2.34.1


