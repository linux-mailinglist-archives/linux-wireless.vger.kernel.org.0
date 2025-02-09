Return-Path: <linux-wireless+bounces-18667-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 931F6A2DDCF
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Feb 2025 13:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38ECA160675
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Feb 2025 12:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5281CCB40;
	Sun,  9 Feb 2025 12:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RND8YtXq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E52A1D89E3
	for <linux-wireless@vger.kernel.org>; Sun,  9 Feb 2025 12:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739104521; cv=none; b=pHWsazqyi1YzL7LtzGwX3i0TBiOVkctsF10PtG6Aj2bMuIGus0CWLt8nsGXSkrMnNGnkl10HgHncObWBLx73lm/DQO6Bys9Po34tgKk+n64ib3vxTdCy4qvkiv46lmNAcAWN7HX7TaejU37dzt+U/IVRnxnqUm2v50Ie+UNm6LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739104521; c=relaxed/simple;
	bh=3cF4awjvGGR2OySM+Cv7MqorgjQUtwfWiw7FOGbO22s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AbAbGxeY/QoU6HVt1SFwEPoRWzkgj+FcaBMVfYx/Npfsd0j5MbRgdTGNuGtN71S3cIX83t0G+kY69adT5VT/v7kvSIAfV7kqhFTreFMra9NYNh8KyoEeVK0ePJ2NyxheOzdwer52LsSUHwlcxoaaGXPRDyFIeC+3qYxtCRjBcVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RND8YtXq; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739104520; x=1770640520;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3cF4awjvGGR2OySM+Cv7MqorgjQUtwfWiw7FOGbO22s=;
  b=RND8YtXqD2xmV5HWsntYoHTe3HnbwR42Jm8zZ+6L/XnHH4dDbJdsSBwK
   V/dpD3evWGhkmC0X8sRyQkBX8C7Pd6jJ5pBytko0gkn9MmEXez1zTpLtM
   DVSTQf1pKI+rsD9t6EfThsqTO3/NL3DZYrnrF+0lIHFEvP5IHntbUMzrp
   Vf7SNJ4kO4/UtqohrrWky3PQuqJsEIXpU1fbuq7aQJgFMbSqd5HdC2ArV
   HfLg/TU8HUTI1xgVSXx2/jpC5fcvVyi9K5wtWUHW96d9lrJU/40iICWfd
   qVHFj4Dwnq/gmqdYg6bVEnbnSXsia8bWnNk2BbCVIZJBBhzum9wZLiY4C
   g==;
X-CSE-ConnectionGUID: JfV3GC9cTUWUgFuR3L9+jw==
X-CSE-MsgGUID: Vflj025fTd6XGzeIweKY4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="51125984"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="51125984"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2025 04:35:19 -0800
X-CSE-ConnectionGUID: l4/JWOGqRDK1YSUOVy8NdQ==
X-CSE-MsgGUID: +GV97U9FQq+wWHU8/PhYsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="111782454"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2025 04:35:18 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 6/9] wifi: iwlwifi: mvm: use the right version of the rate API
Date: Sun,  9 Feb 2025 14:34:50 +0200
Message-Id: <20250209143303.13d70cdcbb4e.Ic92193bce4013b70a823cfef250ee79c16cf7c17@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250209123453.2010013-1-miriam.rachel.korenblit@intel.com>
References: <20250209123453.2010013-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

The firmware uses the newer version of the API in recent devices. For
older devices, we translate the rate to the new format.
Don't parse the rate with old parsing macros.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index 09fd8752046e..14ea89f931bb 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -995,7 +995,7 @@ iwl_mvm_decode_he_phy_ru_alloc(struct iwl_mvm_rx_phy_data *phy_data,
 	 */
 	u8 ru = le32_get_bits(phy_data->d1, IWL_RX_PHY_DATA1_HE_RU_ALLOC_MASK);
 	u32 rate_n_flags = phy_data->rate_n_flags;
-	u32 he_type = rate_n_flags & RATE_MCS_HE_TYPE_MSK_V1;
+	u32 he_type = rate_n_flags & RATE_MCS_HE_TYPE_MSK;
 	u8 offs = 0;
 
 	rx_status->bw = RATE_INFO_BW_HE_RU;
@@ -1050,13 +1050,13 @@ iwl_mvm_decode_he_phy_ru_alloc(struct iwl_mvm_rx_phy_data *phy_data,
 
 	if (he_mu)
 		he_mu->flags2 |=
-			le16_encode_bits(FIELD_GET(RATE_MCS_CHAN_WIDTH_MSK_V1,
+			le16_encode_bits(FIELD_GET(RATE_MCS_CHAN_WIDTH_MSK,
 						   rate_n_flags),
 					 IEEE80211_RADIOTAP_HE_MU_FLAGS2_BW_FROM_SIG_A_BW);
-	else if (he_type == RATE_MCS_HE_TYPE_TRIG_V1)
+	else if (he_type == RATE_MCS_HE_TYPE_TRIG)
 		he->data6 |=
 			cpu_to_le16(IEEE80211_RADIOTAP_HE_DATA6_TB_PPDU_BW_KNOWN) |
-			le16_encode_bits(FIELD_GET(RATE_MCS_CHAN_WIDTH_MSK_V1,
+			le16_encode_bits(FIELD_GET(RATE_MCS_CHAN_WIDTH_MSK,
 						   rate_n_flags),
 					 IEEE80211_RADIOTAP_HE_DATA6_TB_PPDU_BW);
 }
-- 
2.34.1


