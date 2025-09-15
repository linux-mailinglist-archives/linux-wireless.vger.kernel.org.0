Return-Path: <linux-wireless+bounces-27316-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A12B57309
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Sep 2025 10:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F35867A80E3
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Sep 2025 08:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D6B2EF67F;
	Mon, 15 Sep 2025 08:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l/lLc/G1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8693C2EFD91
	for <linux-wireless@vger.kernel.org>; Mon, 15 Sep 2025 08:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757925308; cv=none; b=KmUtkjCG1RnOHxryniE/F4Y8tJODRM5MSvfZbfJZIxspTp4wbidcW+szgWXpWRZivoDz0Sa4YeQ3muJC9rHIN47jr19hw7IjjCMq4mu4WaTCUsquKzketaMHQX16fuiHF2r8IsIE8LmeQjHOyriFdlu/y9Xgqq3m042HnurVY70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757925308; c=relaxed/simple;
	bh=dDcvBHFwxfMUPGobp4yg9pyNjTyxMwR0oCUVKvgJ60E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F24hhNF6HcJix0kOPJAX6jt8UZ1MHyJb7ULuWCWEMirXHjsKp+wYk9DyCJhR2K5boEwKSBJ6+xMaoxxsDLVr/EVGnERXFeODf+MZ/AL1vrWlxqgU4SFuPNUrXgBd0Eo9R0BRbw8mgzxnZcMWj9w6Hjs9T+WzWF1xcOrb4EXqeIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l/lLc/G1; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757925307; x=1789461307;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dDcvBHFwxfMUPGobp4yg9pyNjTyxMwR0oCUVKvgJ60E=;
  b=l/lLc/G1438sXPmkeanZJotLZqV/O2ySxWWjh93oejaE0txIuKLStqz8
   ElXniZB779zHcAiPKhxUv9co5Ku1ljHGwrjVfs3+pvQ2zQICx6mwsWytD
   k58HyPquonWuK0PR7irmPxULdhjNhldU8DP1LULPuUY0iLQOEjtYMN/o2
   WrU8D49gkysqbe7f/wH/HT+EbRInt83OAFcsAKOb8vRAH8xlh14AO9SjY
   zSSREcgxJDEjMl6nYPopKSmLw0JPrTGB0zd846K76swX0Q1oPkiDTEVy5
   Taz0Uznvsykk1LubiYQ+qaB2EDfCIAgsWYBeYRNlybTvNODXtGVeD07ty
   A==;
X-CSE-ConnectionGUID: ZfwNXxHZQKiJXhMPJJ4/8Q==
X-CSE-MsgGUID: 23BPiXsHQ8+/Uk7K5xtMYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11553"; a="59213074"
X-IronPort-AV: E=Sophos;i="6.18,265,1751266800"; 
   d="scan'208";a="59213074"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 01:35:06 -0700
X-CSE-ConnectionGUID: XzELajBUQgmM/ZvV67i3Pg==
X-CSE-MsgGUID: 5lJYueSlRd+mimUO7daw8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,265,1751266800"; 
   d="scan'208";a="178569872"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 01:35:05 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 04/11] wifi: iwlwifi: mvm: move rate conversions to utils.c
Date: Mon, 15 Sep 2025 11:34:25 +0300
Message-Id: <20250915113137.547129c7732e.I12c40876537722680d069b4bb5fc058206ba63d4@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250915083432.1048608-1-miriam.rachel.korenblit@intel.com>
References: <20250915083432.1048608-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

These aren't really related to rate scaling, they're just
firmware API functions. Try to keep rs.c more for scaling
and move these out.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   5 +
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c   | 164 ------------------
 drivers/net/wireless/intel/iwlwifi/mvm/rs.h   |   3 -
 .../net/wireless/intel/iwlwifi/mvm/utils.c    | 164 ++++++++++++++++++
 4 files changed, 169 insertions(+), 167 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index b515028adc8f..301d590fe0bd 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -2894,4 +2894,9 @@ iwl_mvm_send_ap_tx_power_constraint_cmd(struct iwl_mvm *mvm,
 
 void iwl_mvm_smps_workaround(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 			     bool update);
+
+/* rate_n_flags conversion */
+u32 iwl_mvm_v3_rate_from_fw(__le32 rate, u8 rate_ver);
+__le32 iwl_mvm_v3_rate_to_fw(u32 rate, u8 rate_ver);
+
 #endif /* __IWL_MVM_H__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
index 5802ed80a9ca..d1619a229d8f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
@@ -4178,167 +4178,3 @@ int iwl_mvm_tx_protection(struct iwl_mvm *mvm, struct iwl_mvm_sta *mvmsta,
 	else
 		return rs_drv_tx_protection(mvm, mvmsta, enable);
 }
-
-static u32 iwl_legacy_rate_to_fw_idx(u32 rate_n_flags)
-{
-	int rate = rate_n_flags & RATE_LEGACY_RATE_MSK_V1;
-	int idx;
-	bool ofdm = !(rate_n_flags & RATE_MCS_CCK_MSK_V1);
-	int offset = ofdm ? IWL_FIRST_OFDM_RATE : 0;
-	int last = ofdm ? IWL_RATE_COUNT_LEGACY : IWL_FIRST_OFDM_RATE;
-
-	for (idx = offset; idx < last; idx++)
-		if (iwl_fw_rate_idx_to_plcp(idx) == rate)
-			return idx - offset;
-	return IWL_RATE_INVALID;
-}
-
-u32 iwl_mvm_v3_rate_from_fw(__le32 rate, u8 rate_ver)
-{
-	u32 rate_v3 = 0, rate_v1;
-	u32 dup = 0;
-
-	if (rate_ver > 1)
-		return iwl_v3_rate_from_v2_v3(rate, rate_ver >= 3);
-
-	rate_v1 = le32_to_cpu(rate);
-	if (rate_v1 == 0)
-		return rate_v1;
-	/* convert rate */
-	if (rate_v1 & RATE_MCS_HT_MSK_V1) {
-		u32 nss;
-
-		rate_v3 |= RATE_MCS_MOD_TYPE_HT;
-		rate_v3 |=
-			rate_v1 & RATE_HT_MCS_RATE_CODE_MSK_V1;
-		nss = u32_get_bits(rate_v1, RATE_HT_MCS_MIMO2_MSK);
-		rate_v3 |= u32_encode_bits(nss, RATE_MCS_NSS_MSK);
-	} else if (rate_v1 & RATE_MCS_VHT_MSK_V1 ||
-		   rate_v1 & RATE_MCS_HE_MSK_V1) {
-		u32 nss = u32_get_bits(rate_v1, RATE_VHT_MCS_NSS_MSK);
-
-		rate_v3 |= rate_v1 & RATE_VHT_MCS_RATE_CODE_MSK;
-
-		rate_v3 |= u32_encode_bits(nss, RATE_MCS_NSS_MSK);
-
-		if (rate_v1 & RATE_MCS_HE_MSK_V1) {
-			u32 he_type_bits = rate_v1 & RATE_MCS_HE_TYPE_MSK_V1;
-			u32 he_type = he_type_bits >> RATE_MCS_HE_TYPE_POS_V1;
-			u32 he_106t = (rate_v1 & RATE_MCS_HE_106T_MSK_V1) >>
-				RATE_MCS_HE_106T_POS_V1;
-			u32 he_gi_ltf = (rate_v1 & RATE_MCS_HE_GI_LTF_MSK_V1) >>
-				RATE_MCS_HE_GI_LTF_POS;
-
-			if ((he_type_bits == RATE_MCS_HE_TYPE_SU ||
-			     he_type_bits == RATE_MCS_HE_TYPE_EXT_SU) &&
-			    he_gi_ltf == RATE_MCS_HE_SU_4_LTF)
-				/* the new rate have an additional bit to
-				 * represent the value 4 rather then using SGI
-				 * bit for this purpose - as it was done in the
-				 * old rate
-				 */
-				he_gi_ltf += (rate_v1 & RATE_MCS_SGI_MSK_V1) >>
-					RATE_MCS_SGI_POS_V1;
-
-			rate_v3 |= he_gi_ltf << RATE_MCS_HE_GI_LTF_POS;
-			rate_v3 |= he_type << RATE_MCS_HE_TYPE_POS;
-			rate_v3 |= he_106t << RATE_MCS_HE_106T_POS;
-			rate_v3 |= rate_v1 & RATE_HE_DUAL_CARRIER_MODE_MSK;
-			rate_v3 |= RATE_MCS_MOD_TYPE_HE;
-		} else {
-			rate_v3 |= RATE_MCS_MOD_TYPE_VHT;
-		}
-	/* if legacy format */
-	} else {
-		u32 legacy_rate = iwl_legacy_rate_to_fw_idx(rate_v1);
-
-		if (WARN_ON_ONCE(legacy_rate == IWL_RATE_INVALID))
-			legacy_rate = (rate_v1 & RATE_MCS_CCK_MSK_V1) ?
-				IWL_FIRST_CCK_RATE : IWL_FIRST_OFDM_RATE;
-
-		rate_v3 |= legacy_rate;
-		if (!(rate_v1 & RATE_MCS_CCK_MSK_V1))
-			rate_v3 |= RATE_MCS_MOD_TYPE_LEGACY_OFDM;
-	}
-
-	/* convert flags */
-	if (rate_v1 & RATE_MCS_LDPC_MSK_V1)
-		rate_v3 |= RATE_MCS_LDPC_MSK;
-	rate_v3 |= (rate_v1 & RATE_MCS_CHAN_WIDTH_MSK_V1) |
-		(rate_v1 & RATE_MCS_ANT_AB_MSK) |
-		(rate_v1 & RATE_MCS_STBC_MSK) |
-		(rate_v1 & RATE_MCS_BF_MSK);
-
-	dup = (rate_v1 & RATE_MCS_DUP_MSK_V1) >> RATE_MCS_DUP_POS_V1;
-	if (dup) {
-		rate_v3 |= RATE_MCS_DUP_MSK;
-		rate_v3 |= dup << RATE_MCS_CHAN_WIDTH_POS;
-	}
-
-	if ((!(rate_v1 & RATE_MCS_HE_MSK_V1)) &&
-	    (rate_v1 & RATE_MCS_SGI_MSK_V1))
-		rate_v3 |= RATE_MCS_SGI_MSK;
-
-	return rate_v3;
-}
-
-__le32 iwl_mvm_v3_rate_to_fw(u32 rate, u8 rate_ver)
-{
-	u32 result = 0;
-	int rate_idx;
-
-	if (rate_ver > 1)
-		return iwl_v3_rate_to_v2_v3(rate, rate_ver > 2);
-
-	switch (rate & RATE_MCS_MOD_TYPE_MSK) {
-	case RATE_MCS_MOD_TYPE_CCK:
-		result = RATE_MCS_CCK_MSK_V1;
-		fallthrough;
-	case RATE_MCS_MOD_TYPE_LEGACY_OFDM:
-		rate_idx = u32_get_bits(rate, RATE_LEGACY_RATE_MSK);
-		if (!(result & RATE_MCS_CCK_MSK_V1))
-			rate_idx += IWL_FIRST_OFDM_RATE;
-		result |= u32_encode_bits(iwl_fw_rate_idx_to_plcp(rate_idx),
-					  RATE_LEGACY_RATE_MSK_V1);
-		break;
-	case RATE_MCS_MOD_TYPE_HT:
-		result = RATE_MCS_HT_MSK_V1;
-		result |= u32_encode_bits(u32_get_bits(rate,
-						       RATE_HT_MCS_CODE_MSK),
-					  RATE_HT_MCS_RATE_CODE_MSK_V1);
-		result |= u32_encode_bits(u32_get_bits(rate,
-						       RATE_MCS_NSS_MSK),
-					  RATE_HT_MCS_MIMO2_MSK);
-		break;
-	case RATE_MCS_MOD_TYPE_VHT:
-		result = RATE_MCS_VHT_MSK_V1;
-		result |= u32_encode_bits(u32_get_bits(rate,
-						       RATE_VHT_MCS_NSS_MSK),
-					  RATE_MCS_CODE_MSK);
-		result |= u32_encode_bits(u32_get_bits(rate, RATE_MCS_NSS_MSK),
-					  RATE_VHT_MCS_NSS_MSK);
-		break;
-	case RATE_MCS_MOD_TYPE_HE: /* not generated */
-	default:
-		WARN_ONCE(1, "bad modulation type %d\n",
-			  u32_get_bits(rate, RATE_MCS_MOD_TYPE_MSK));
-		return 0;
-	}
-
-	if (rate & RATE_MCS_LDPC_MSK)
-		result |= RATE_MCS_LDPC_MSK_V1;
-	WARN_ON_ONCE(u32_get_bits(rate, RATE_MCS_CHAN_WIDTH_MSK) >
-			RATE_MCS_CHAN_WIDTH_160_VAL);
-	result |= (rate & RATE_MCS_CHAN_WIDTH_MSK_V1) |
-		  (rate & RATE_MCS_ANT_AB_MSK) |
-		  (rate & RATE_MCS_STBC_MSK) |
-		  (rate & RATE_MCS_BF_MSK);
-
-	/* not handling DUP since we don't use it */
-	WARN_ON_ONCE(rate & RATE_MCS_DUP_MSK);
-
-	if (rate & RATE_MCS_SGI_MSK)
-		result |= RATE_MCS_SGI_MSK_V1;
-
-	return cpu_to_le32(result);
-}
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs.h b/drivers/net/wireless/intel/iwlwifi/mvm/rs.h
index dfb062b7c5c2..34c957bef6f8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs.h
@@ -425,9 +425,6 @@ void iwl_mvm_rate_control_unregister(void);
 
 struct iwl_mvm_sta;
 
-u32 iwl_mvm_v3_rate_from_fw(__le32 rate, u8 rate_ver);
-__le32 iwl_mvm_v3_rate_to_fw(u32 rate, u8 rate_ver);
-
 int iwl_mvm_tx_protection(struct iwl_mvm *mvm, struct iwl_mvm_sta *mvmsta,
 			  bool enable);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
index 22602c32faa5..aa7af04d914e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
@@ -1237,3 +1237,167 @@ bool iwl_mvm_vif_is_active(struct iwl_mvm_vif *mvmvif)
 
 	return false;
 }
+
+static u32 iwl_legacy_rate_to_fw_idx(u32 rate_n_flags)
+{
+	int rate = rate_n_flags & RATE_LEGACY_RATE_MSK_V1;
+	int idx;
+	bool ofdm = !(rate_n_flags & RATE_MCS_CCK_MSK_V1);
+	int offset = ofdm ? IWL_FIRST_OFDM_RATE : 0;
+	int last = ofdm ? IWL_RATE_COUNT_LEGACY : IWL_FIRST_OFDM_RATE;
+
+	for (idx = offset; idx < last; idx++)
+		if (iwl_fw_rate_idx_to_plcp(idx) == rate)
+			return idx - offset;
+	return IWL_RATE_INVALID;
+}
+
+u32 iwl_mvm_v3_rate_from_fw(__le32 rate, u8 rate_ver)
+{
+	u32 rate_v3 = 0, rate_v1;
+	u32 dup = 0;
+
+	if (rate_ver > 1)
+		return iwl_v3_rate_from_v2_v3(rate, rate_ver >= 3);
+
+	rate_v1 = le32_to_cpu(rate);
+	if (rate_v1 == 0)
+		return rate_v1;
+	/* convert rate */
+	if (rate_v1 & RATE_MCS_HT_MSK_V1) {
+		u32 nss;
+
+		rate_v3 |= RATE_MCS_MOD_TYPE_HT;
+		rate_v3 |=
+			rate_v1 & RATE_HT_MCS_RATE_CODE_MSK_V1;
+		nss = u32_get_bits(rate_v1, RATE_HT_MCS_MIMO2_MSK);
+		rate_v3 |= u32_encode_bits(nss, RATE_MCS_NSS_MSK);
+	} else if (rate_v1 & RATE_MCS_VHT_MSK_V1 ||
+		   rate_v1 & RATE_MCS_HE_MSK_V1) {
+		u32 nss = u32_get_bits(rate_v1, RATE_VHT_MCS_NSS_MSK);
+
+		rate_v3 |= rate_v1 & RATE_VHT_MCS_RATE_CODE_MSK;
+
+		rate_v3 |= u32_encode_bits(nss, RATE_MCS_NSS_MSK);
+
+		if (rate_v1 & RATE_MCS_HE_MSK_V1) {
+			u32 he_type_bits = rate_v1 & RATE_MCS_HE_TYPE_MSK_V1;
+			u32 he_type = he_type_bits >> RATE_MCS_HE_TYPE_POS_V1;
+			u32 he_106t = (rate_v1 & RATE_MCS_HE_106T_MSK_V1) >>
+				RATE_MCS_HE_106T_POS_V1;
+			u32 he_gi_ltf = (rate_v1 & RATE_MCS_HE_GI_LTF_MSK_V1) >>
+				RATE_MCS_HE_GI_LTF_POS;
+
+			if ((he_type_bits == RATE_MCS_HE_TYPE_SU ||
+			     he_type_bits == RATE_MCS_HE_TYPE_EXT_SU) &&
+			    he_gi_ltf == RATE_MCS_HE_SU_4_LTF)
+				/* the new rate have an additional bit to
+				 * represent the value 4 rather then using SGI
+				 * bit for this purpose - as it was done in the
+				 * old rate
+				 */
+				he_gi_ltf += (rate_v1 & RATE_MCS_SGI_MSK_V1) >>
+					RATE_MCS_SGI_POS_V1;
+
+			rate_v3 |= he_gi_ltf << RATE_MCS_HE_GI_LTF_POS;
+			rate_v3 |= he_type << RATE_MCS_HE_TYPE_POS;
+			rate_v3 |= he_106t << RATE_MCS_HE_106T_POS;
+			rate_v3 |= rate_v1 & RATE_HE_DUAL_CARRIER_MODE_MSK;
+			rate_v3 |= RATE_MCS_MOD_TYPE_HE;
+		} else {
+			rate_v3 |= RATE_MCS_MOD_TYPE_VHT;
+		}
+	/* if legacy format */
+	} else {
+		u32 legacy_rate = iwl_legacy_rate_to_fw_idx(rate_v1);
+
+		if (WARN_ON_ONCE(legacy_rate == IWL_RATE_INVALID))
+			legacy_rate = (rate_v1 & RATE_MCS_CCK_MSK_V1) ?
+				IWL_FIRST_CCK_RATE : IWL_FIRST_OFDM_RATE;
+
+		rate_v3 |= legacy_rate;
+		if (!(rate_v1 & RATE_MCS_CCK_MSK_V1))
+			rate_v3 |= RATE_MCS_MOD_TYPE_LEGACY_OFDM;
+	}
+
+	/* convert flags */
+	if (rate_v1 & RATE_MCS_LDPC_MSK_V1)
+		rate_v3 |= RATE_MCS_LDPC_MSK;
+	rate_v3 |= (rate_v1 & RATE_MCS_CHAN_WIDTH_MSK_V1) |
+		(rate_v1 & RATE_MCS_ANT_AB_MSK) |
+		(rate_v1 & RATE_MCS_STBC_MSK) |
+		(rate_v1 & RATE_MCS_BF_MSK);
+
+	dup = (rate_v1 & RATE_MCS_DUP_MSK_V1) >> RATE_MCS_DUP_POS_V1;
+	if (dup) {
+		rate_v3 |= RATE_MCS_DUP_MSK;
+		rate_v3 |= dup << RATE_MCS_CHAN_WIDTH_POS;
+	}
+
+	if ((!(rate_v1 & RATE_MCS_HE_MSK_V1)) &&
+	    (rate_v1 & RATE_MCS_SGI_MSK_V1))
+		rate_v3 |= RATE_MCS_SGI_MSK;
+
+	return rate_v3;
+}
+
+__le32 iwl_mvm_v3_rate_to_fw(u32 rate, u8 rate_ver)
+{
+	u32 result = 0;
+	int rate_idx;
+
+	if (rate_ver > 1)
+		return iwl_v3_rate_to_v2_v3(rate, rate_ver > 2);
+
+	switch (rate & RATE_MCS_MOD_TYPE_MSK) {
+	case RATE_MCS_MOD_TYPE_CCK:
+		result = RATE_MCS_CCK_MSK_V1;
+		fallthrough;
+	case RATE_MCS_MOD_TYPE_LEGACY_OFDM:
+		rate_idx = u32_get_bits(rate, RATE_LEGACY_RATE_MSK);
+		if (!(result & RATE_MCS_CCK_MSK_V1))
+			rate_idx += IWL_FIRST_OFDM_RATE;
+		result |= u32_encode_bits(iwl_fw_rate_idx_to_plcp(rate_idx),
+					  RATE_LEGACY_RATE_MSK_V1);
+		break;
+	case RATE_MCS_MOD_TYPE_HT:
+		result = RATE_MCS_HT_MSK_V1;
+		result |= u32_encode_bits(u32_get_bits(rate,
+						       RATE_HT_MCS_CODE_MSK),
+					  RATE_HT_MCS_RATE_CODE_MSK_V1);
+		result |= u32_encode_bits(u32_get_bits(rate,
+						       RATE_MCS_NSS_MSK),
+					  RATE_HT_MCS_MIMO2_MSK);
+		break;
+	case RATE_MCS_MOD_TYPE_VHT:
+		result = RATE_MCS_VHT_MSK_V1;
+		result |= u32_encode_bits(u32_get_bits(rate,
+						       RATE_VHT_MCS_NSS_MSK),
+					  RATE_MCS_CODE_MSK);
+		result |= u32_encode_bits(u32_get_bits(rate, RATE_MCS_NSS_MSK),
+					  RATE_VHT_MCS_NSS_MSK);
+		break;
+	case RATE_MCS_MOD_TYPE_HE: /* not generated */
+	default:
+		WARN_ONCE(1, "bad modulation type %d\n",
+			  u32_get_bits(rate, RATE_MCS_MOD_TYPE_MSK));
+		return 0;
+	}
+
+	if (rate & RATE_MCS_LDPC_MSK)
+		result |= RATE_MCS_LDPC_MSK_V1;
+	WARN_ON_ONCE(u32_get_bits(rate, RATE_MCS_CHAN_WIDTH_MSK) >
+			RATE_MCS_CHAN_WIDTH_160_VAL);
+	result |= (rate & RATE_MCS_CHAN_WIDTH_MSK_V1) |
+		  (rate & RATE_MCS_ANT_AB_MSK) |
+		  (rate & RATE_MCS_STBC_MSK) |
+		  (rate & RATE_MCS_BF_MSK);
+
+	/* not handling DUP since we don't use it */
+	WARN_ON_ONCE(rate & RATE_MCS_DUP_MSK);
+
+	if (rate & RATE_MCS_SGI_MSK)
+		result |= RATE_MCS_SGI_MSK_V1;
+
+	return cpu_to_le32(result);
+}
-- 
2.34.1


