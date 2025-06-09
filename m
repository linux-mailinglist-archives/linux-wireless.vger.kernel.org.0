Return-Path: <linux-wireless+bounces-23884-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82142AD25B5
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 20:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 745787A286E
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 18:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F97F21CFF4;
	Mon,  9 Jun 2025 18:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h/Ar+vNW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48E721CFF7
	for <linux-wireless@vger.kernel.org>; Mon,  9 Jun 2025 18:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749494158; cv=none; b=TqPfgRtg89iMe/Rw9MKH+gM2Siqa8N3DlFU1fm/e85VtH+NUVrJTNTs2AcmOJZPXSuhyVWoi12WPKrIPozTrpNbyrwlZq9vpXBKuM6mGcPPI15d5Lt+k4hq/VuIIlj+Pr/pBRIP7o8JXWH7KGHOSu9oF0d4uHkjr6klklFYm1zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749494158; c=relaxed/simple;
	bh=KjUE8i7SWzTg6BWfkCtbMUSSWLvUngL521og9PSoNX0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QleHJfCxyBgZBRBCOjckwJbLgvhJbMlvpzKC09U+X1gKbbqCPV7ScltiRlr1LPhok4accZoqyMh9eOsIxLx2ZMDTtjIyfGRp9uvaItUJkJpGIDTQ64lBDbSPQtzHT97V5WK/q59gYPoQKQmY5S2OYNUAYEw2TUj1udv2WBMGgRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h/Ar+vNW; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749494156; x=1781030156;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KjUE8i7SWzTg6BWfkCtbMUSSWLvUngL521og9PSoNX0=;
  b=h/Ar+vNWnioIov/QPbBfuIZDzmM/T2S08wHzCMQtLJDsQAt4r8GU201c
   zU9I8elyfcBb6+oTSV6TQG2RWGNRtALrtmuCX+BmP5IlXV9azLLMiLUDD
   Mab+HGvPEWkafS4mzXDkgpobWBTiyKDLRjwxGJNglxKBiLsClZgLjs8t+
   ypMu/wwDqphi6qtFiH589UmJFCAj3Q5s4wQe4Ja6kO6sKb9iUCoCVR41h
   WiW+uqykY6Osqof+GigLNwK9Pvs+7aNoqDYr6SJqpWio+QryXl7+PP5Cp
   +P/+KeCNAlr1xsUdn3keiEWp46xzXQSpA0nRuCQh+6zNosKDWf1jmsuZ3
   A==;
X-CSE-ConnectionGUID: 1n6+HmcLRVCrfGNQYGX8UQ==
X-CSE-MsgGUID: ASDEjtvBTdS/m7dlidEZ2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="55249769"
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="55249769"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 11:35:56 -0700
X-CSE-ConnectionGUID: RGmwlplER0Kn8QYg4fOJPg==
X-CSE-MsgGUID: ZhfwXQAHRnOYJUoR59TRSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="151732509"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 11:35:55 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 09/15] wifi: cfg80211: only verify part of Extended MLD Capabilities
Date: Mon,  9 Jun 2025 21:35:21 +0300
Message-Id: <20250609213231.a2fad48dd3e6.Iae1740cd2ac833bc4a64fd2af718e1485158fd42@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250609183527.3974138-1-miriam.rachel.korenblit@intel.com>
References: <20250609183527.3974138-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

We verify that the Extended MLD Capabilities are matching between links.
However, some bits are reserved and in particular the Recommended Max
Links subfield may not necessarily match. So only verify the known
subfields that can reliably be expected to be the same. More information
can be found in Table 9-417o, in IEEE P802.11be/D7.0.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/linux/ieee80211.h |  9 ++++++++-
 net/wireless/mlme.c       | 21 +++++++++++++++++++--
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 420c7f9aa6ee..599137c2c091 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -9,7 +9,7 @@
  * Copyright (c) 2006, Michael Wu <flamingice@sourmilk.net>
  * Copyright (c) 2013 - 2014 Intel Mobile Communications GmbH
  * Copyright (c) 2016 - 2017 Intel Deutschland GmbH
- * Copyright (c) 2018 - 2024 Intel Corporation
+ * Copyright (c) 2018 - 2025 Intel Corporation
  */
 
 #ifndef LINUX_IEEE80211_H
@@ -5264,6 +5264,13 @@ static inline u16 ieee80211_mle_get_mld_capa_op(const u8 *data)
 	return get_unaligned_le16(common);
 }
 
+/* Defined in Figure 9-1074t in P802.11be_D7.0 */
+#define IEEE80211_EHT_ML_EXT_MLD_CAPA_OP_PARAM_UPDATE           0x0001
+#define IEEE80211_EHT_ML_EXT_MLD_CAPA_OP_RECO_MAX_LINKS_MASK    0x001e
+#define IEEE80211_EHT_ML_EXT_MLD_CAPA_NSTR_UPDATE               0x0020
+#define IEEE80211_EHT_ML_EXT_MLD_CAPA_EMLSR_ENA_ON_ONE_LINK     0x0040
+#define IEEE80211_EHT_ML_EXT_MLD_CAPA_BTM_MLD_RECO_MULTI_AP     0x0080
+
 /**
  * ieee80211_mle_get_ext_mld_capa_op - returns the extended MLD capabilities
  *	and operations.
diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
index 05d44a443518..ad83ccaf6c4f 100644
--- a/net/wireless/mlme.c
+++ b/net/wireless/mlme.c
@@ -352,8 +352,25 @@ cfg80211_mlme_check_mlo_compat(const struct ieee80211_multi_link_elem *mle_a,
 		return -EINVAL;
 	}
 
-	if (ieee80211_mle_get_ext_mld_capa_op((const u8 *)mle_a) !=
-	    ieee80211_mle_get_ext_mld_capa_op((const u8 *)mle_b)) {
+	/*
+	 * Only verify the values in Extended MLD Capabilities that are
+	 * not reserved when transmitted by an AP (and expected to remain the
+	 * same over time).
+	 * The Recommended Max Simultaneous Links subfield in particular is
+	 * reserved when included in a unicast Probe Response frame and may
+	 * also change when the AP adds/removes links. The BTM MLD
+	 * Recommendation For Multiple APs Support subfield is reserved when
+	 * transmitted by an AP. All other bits are currently reserved.
+	 * See IEEE P802.11be/D7.0, Table 9-417o.
+	 */
+	if ((ieee80211_mle_get_ext_mld_capa_op((const u8 *)mle_a) &
+	     (IEEE80211_EHT_ML_EXT_MLD_CAPA_OP_PARAM_UPDATE |
+	      IEEE80211_EHT_ML_EXT_MLD_CAPA_NSTR_UPDATE |
+	      IEEE80211_EHT_ML_EXT_MLD_CAPA_EMLSR_ENA_ON_ONE_LINK)) !=
+	    (ieee80211_mle_get_ext_mld_capa_op((const u8 *)mle_b) &
+	     (IEEE80211_EHT_ML_EXT_MLD_CAPA_OP_PARAM_UPDATE |
+	      IEEE80211_EHT_ML_EXT_MLD_CAPA_NSTR_UPDATE |
+	      IEEE80211_EHT_ML_EXT_MLD_CAPA_EMLSR_ENA_ON_ONE_LINK))) {
 		NL_SET_ERR_MSG(extack,
 			       "extended link MLD capabilities/ops mismatch");
 		return -EINVAL;
-- 
2.34.1


