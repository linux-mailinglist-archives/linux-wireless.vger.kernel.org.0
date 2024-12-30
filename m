Return-Path: <linux-wireless+bounces-16890-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF54F9FE280
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Dec 2024 05:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 483013A163F
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Dec 2024 04:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B59166F3D;
	Mon, 30 Dec 2024 04:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HO08YP/y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C3E165F16
	for <linux-wireless@vger.kernel.org>; Mon, 30 Dec 2024 04:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735534581; cv=none; b=XTIMb+AAdWrRI4EJ/IRlkGyoUrR9gRxmPHe699hm3vWmzVeiT2j1LMLBbTqC2UEbt/FlZ6fkPjnPUfRazLmLLwXnkSD1Wg7EV8vXpLJ3a8mlTdrRrW8O/l240gVELRNqTEb9r0CyIHrq93ODSQG61ykcEC34BKHxsWzCAKTEX7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735534581; c=relaxed/simple;
	bh=gLMkWnfLOjs3JbTCokgbd82BVvXFfst4cBGqlq/Z/sw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mF4ys64YLb53S9krDQGgjGx7/ECx257b/m+a0rH6Rh/wj9G2+Ig1T1nrkNIAv1MepL892ettAhgPOK/lkKzgcky4Dx/l25GrAo3x3NgSlR67gLyDyqAH0/eSjR4TFemPtXcfMkli24P40GPpkgXZ1y+etsJOfdQpGZbPE9eEWx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HO08YP/y; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735534580; x=1767070580;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gLMkWnfLOjs3JbTCokgbd82BVvXFfst4cBGqlq/Z/sw=;
  b=HO08YP/ystfDAyui9BOyLou6jW9iDNZ0soCM1lU/TTbtzf61TOLf+rGc
   ceqIEUjFCkEiHTW2t/dJA6hkpAyRsJIxf0Spz/E7q0zoqFW46HTle5fTV
   40lmIR+obIjqWrSWstCbe9t2Y+giM9BuOgjLNTK7AAuJFTA1ouXBeMYQs
   2/msQERvv3x9KaWEWR7Pmq3FwMnIeKOtkwGXfA4azMPMLwqmVqKZBFvGa
   NJOmzWiWLmW/lOezaysak9eJU8S4l0i8nDaum3CH/72DCxM+TqyKQ4dXk
   5LQLNpzj8s6lOaL667dA7nWv9subfZke97vxTOhJYmzdL5D84OmG1sGGy
   w==;
X-CSE-ConnectionGUID: ikL8xuqoTUGTI/SGjzEC5g==
X-CSE-MsgGUID: pw4fQiKrTxqxUxTgheZZxw==
X-IronPort-AV: E=McAfee;i="6700,10204,11299"; a="46405014"
X-IronPort-AV: E=Sophos;i="6.12,275,1728975600"; 
   d="scan'208";a="46405014"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2024 20:56:19 -0800
X-CSE-ConnectionGUID: LMdXbkpXQ6KgLI4YhVC1Ww==
X-CSE-MsgGUID: FT0HMGV8S8iEkw+GazICyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="104758899"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2024 20:56:17 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 07/15] wifi: cfg80211: check extended MLD capa/ops in assoc
Date: Mon, 30 Dec 2024 06:55:46 +0200
Message-Id: <20241230065327.e29f42c7ae21.Ib2cdce608321ad154e4b13103cc315c3e3cb6b2b@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241230045554.3746143-1-miriam.rachel.korenblit@intel.com>
References: <20241230045554.3746143-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Check that additionally extended MLD capa/ops for the MLD is
consistent, i.e. the same value is reported by all affiliated
APs/links.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/linux/ieee80211.h | 44 +++++++++++++++++++++++++++++++++++++++
 net/wireless/mlme.c       |  7 +++++++
 2 files changed, 51 insertions(+)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 05dedc45505c..9c0e2617fe8f 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -4961,6 +4961,7 @@ struct ieee80211_multi_link_elem {
 #define IEEE80211_MLC_BASIC_PRES_EML_CAPA		0x0080
 #define IEEE80211_MLC_BASIC_PRES_MLD_CAPA_OP		0x0100
 #define IEEE80211_MLC_BASIC_PRES_MLD_ID			0x0200
+#define IEEE80211_MLC_BASIC_PRES_EXT_MLD_CAPA_OP	0x0400
 
 #define IEEE80211_MED_SYNC_DELAY_DURATION		0x00ff
 #define IEEE80211_MED_SYNC_DELAY_SYNC_OFDM_ED_THRESH	0x0f00
@@ -5226,6 +5227,47 @@ static inline u16 ieee80211_mle_get_mld_capa_op(const u8 *data)
 	return get_unaligned_le16(common);
 }
 
+/**
+ * ieee80211_mle_get_ext_mld_capa_op - returns the extended MLD capabilities
+ *	and operations.
+ * @data: pointer to the multi-link element
+ * Return: the extended MLD capabilities and operations field value from
+ *	the multi-link element, or 0 if not present
+ *
+ * The element is assumed to be of the correct type (BASIC) and big enough,
+ * this must be checked using ieee80211_mle_type_ok().
+ */
+static inline u16 ieee80211_mle_get_ext_mld_capa_op(const u8 *data)
+{
+	const struct ieee80211_multi_link_elem *mle = (const void *)data;
+	u16 control = le16_to_cpu(mle->control);
+	const u8 *common = mle->variable;
+
+	/*
+	 * common points now at the beginning of
+	 * ieee80211_mle_basic_common_info
+	 */
+	common += sizeof(struct ieee80211_mle_basic_common_info);
+
+	if (!(control & IEEE80211_MLC_BASIC_PRES_EXT_MLD_CAPA_OP))
+		return 0;
+
+	if (control & IEEE80211_MLC_BASIC_PRES_LINK_ID)
+		common += 1;
+	if (control & IEEE80211_MLC_BASIC_PRES_BSS_PARAM_CH_CNT)
+		common += 1;
+	if (control & IEEE80211_MLC_BASIC_PRES_MED_SYNC_DELAY)
+		common += 2;
+	if (control & IEEE80211_MLC_BASIC_PRES_EML_CAPA)
+		common += 2;
+	if (control & IEEE80211_MLC_BASIC_PRES_MLD_CAPA_OP)
+		common += 2;
+	if (control & IEEE80211_MLC_BASIC_PRES_MLD_ID)
+		common += 1;
+
+	return get_unaligned_le16(common);
+}
+
 /**
  * ieee80211_mle_get_mld_id - returns the MLD ID
  * @data: pointer to the multi-link element
@@ -5298,6 +5340,8 @@ static inline bool ieee80211_mle_size_ok(const u8 *data, size_t len)
 			common += 2;
 		if (control & IEEE80211_MLC_BASIC_PRES_MLD_ID)
 			common += 1;
+		if (control & IEEE80211_MLC_BASIC_PRES_EXT_MLD_CAPA_OP)
+			common += 2;
 		break;
 	case IEEE80211_ML_CONTROL_TYPE_PREQ:
 		common += sizeof(struct ieee80211_mle_preq_common_info);
diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
index 9d577523462d..5c09bf4cdc2e 100644
--- a/net/wireless/mlme.c
+++ b/net/wireless/mlme.c
@@ -352,6 +352,13 @@ cfg80211_mlme_check_mlo_compat(const struct ieee80211_multi_link_elem *mle_a,
 		return -EINVAL;
 	}
 
+	if (ieee80211_mle_get_ext_mld_capa_op((const u8 *)mle_a) !=
+	    ieee80211_mle_get_ext_mld_capa_op((const u8 *)mle_b)) {
+		NL_SET_ERR_MSG(extack,
+			       "extended link MLD capabilities/ops mismatch");
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
-- 
2.34.1


