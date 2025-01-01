Return-Path: <linux-wireless+bounces-16957-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6DB9FF2D8
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jan 2025 06:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D086161BAB
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jan 2025 05:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E119827735;
	Wed,  1 Jan 2025 05:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kAvGAC8K"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E69DF60
	for <linux-wireless@vger.kernel.org>; Wed,  1 Jan 2025 05:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735707964; cv=none; b=j26SUvrMOYmUFpQ+zAI9iaHRo2qosk4FAw+uMYT8lmifSKXOQOQVvG1xWQwLf3c6DfHN67c+hEhzFMJ1s399jT5jRksfIfXOGQEJFbq+UBNxRiyDtHyd6ABsSvdwL9B+DuqqvqmRnsnXBEGH44FFj27mYnKRvS73Nf1yo8fFH/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735707964; c=relaxed/simple;
	bh=gLMkWnfLOjs3JbTCokgbd82BVvXFfst4cBGqlq/Z/sw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aFv19Z/ACXg/3Hrov0qcnxRs0jK8GeJ9D6KT2sB4P8bLy3JOwQsirq1FTW6LM2SQuB/GWujOYRIWPPLB88GSuJQxtxhhX+tiqlTUSI8jL7BtNNt6GRMAPpEC0TAQQZ5g0LxIfoXcCnXkvXE2v8RuTRgLoQwA1JgIMOCur49i/yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kAvGAC8K; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735707963; x=1767243963;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gLMkWnfLOjs3JbTCokgbd82BVvXFfst4cBGqlq/Z/sw=;
  b=kAvGAC8Ke/V/G24nI180+XdQ2Ik4VLqwGe0zKCoBihVUGCU25GXMLisW
   EvQZ2sioYy8aN5wgtfey6qb/SrTJ7R+YJ8pasiSgkvM1ZT5Uv/2FVKGkd
   64yqU2N2T51p9rdmbFekP+jzoQVIVJA/3rFaxzu+P/dwngp4RpyTdGOGk
   /2uE5NEaq1AyBx6ZYzAui1NB6CADhI3+nAZqRtnJNjeJdmz9ejAMOUiC7
   AKLq9+8knNtEacA8GD39jfNZSllgaiGSmBen3Bblkgb7a72cxydP9GIXy
   hgPVMp9+jTdmnintx0mfOJK47ogmevlRc3fOfk4qpIFCstrxmW5FQHJuq
   A==;
X-CSE-ConnectionGUID: e1w7SIsITFWl2ioY4bQydQ==
X-CSE-MsgGUID: 9ey9wzcZTPyktoiXqf695A==
X-IronPort-AV: E=McAfee;i="6700,10204,11302"; a="36194413"
X-IronPort-AV: E=Sophos;i="6.12,281,1728975600"; 
   d="scan'208";a="36194413"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2024 21:06:03 -0800
X-CSE-ConnectionGUID: EV/ZdJfoSzCdYGDdrXvj4A==
X-CSE-MsgGUID: okQ7MENdQKK2zYfp435aWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,281,1728975600"; 
   d="scan'208";a="101618899"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2024 21:06:02 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 07/19] wifi: cfg80211: check extended MLD capa/ops in assoc
Date: Wed,  1 Jan 2025 07:05:27 +0200
Message-Id: <20250101070249.e29f42c7ae21.Ib2cdce608321ad154e4b13103cc315c3e3cb6b2b@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250101050539.1718643-1-miriam.rachel.korenblit@intel.com>
References: <20250101050539.1718643-1-miriam.rachel.korenblit@intel.com>
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


