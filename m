Return-Path: <linux-wireless+bounces-20071-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA35A57F39
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 23:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57B6F3A7B57
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 22:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE881AA1DA;
	Sat,  8 Mar 2025 22:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MPuSI2gy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35302135CA
	for <linux-wireless@vger.kernel.org>; Sat,  8 Mar 2025 22:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741471315; cv=none; b=nJ/qX4icQubs0xEICohberRr69GGNEWr4Sgr29eaHJNdzHAzfzhaUboXREspTqK7vkHsHqiJ76SMpCkcOD2RKM2cdjDfw8SvLlUet4KZBdYRGM5WnJecoSbbGCdud3qPRqx13dNJjXS1dRGmkStv6CwlND+vdi4yci3i2lo5hBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741471315; c=relaxed/simple;
	bh=SkkbjhtychOw9bFaQfslrV9cqDdKjbvYNFAOQTJ4jAs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QzuQ7YXPPesBAddsMy7kqsJnuYSCMzPEYXwyz3gmDrUntrbHA/8RBcy9lrvfPE4RpOZ2UXNKANNMkwTixDLzhZ7Z7Mhb9BbofCdM1FoGofTQrK2+Y8fxutc9IYj9Us0JhmEFbEGtOr57oGoL4/4tvDiDlXgGj3edpyYYQ9dY9Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MPuSI2gy; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741471314; x=1773007314;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SkkbjhtychOw9bFaQfslrV9cqDdKjbvYNFAOQTJ4jAs=;
  b=MPuSI2gyIw+uSWTJz0sBGMJqGeFEnoRMzYR2Tjo4NdYuVYnuU5zgCqs/
   rzAyKZyZ7P0hb3MYOujY1a0/0wYAm9lcwCOs+TWve4uJnbm4YtxWd5H7q
   OND6+mnaRNm2J5Vef2IjNyjoPW+HoDYbY/V3vKUB64pK9veHUBY9ORKRM
   LKmwhu6mZoVsNd/nolPZZJ2InQBHePorlH6uUm9ykBHhloG6lo2rzgcs4
   Yetau2+xB8eU5Gjxu4+qMvBefRtlmU7kHKA73a8HTHCFhlC1NoEHu4cT2
   DVkSQluHlfDMTL+a5BYCTy689wQWIMEcMu95dUxmDeOSeKSNIqBEgjWtK
   Q==;
X-CSE-ConnectionGUID: d9ixJdk1TACurxdQK8jEDQ==
X-CSE-MsgGUID: a9XcwJLGT2y8WhGZwjR58A==
X-IronPort-AV: E=McAfee;i="6700,10204,11367"; a="42540659"
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="42540659"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 14:01:53 -0800
X-CSE-ConnectionGUID: xf4SawyZTMmCOo/f5r01uA==
X-CSE-MsgGUID: kxAO7SzlRgqSGn7EZ97tJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="120352158"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 14:01:52 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH wireless-next 11/15] wifi: iwlwifi: mld: remove AP keys only for AP STA
Date: Sun,  9 Mar 2025 00:01:21 +0200
Message-Id: <20250308235203.f06a4d6eed2b.Icd20af668a22bfae5328eb0ea00ce10a72ce3539@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250308220125.2388933-1-miriam.rachel.korenblit@intel.com>
References: <20250308220125.2388933-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

On station interfaces we don't only have the AP STA, but also
TDLS stations. Don't try to remove AP keys for them.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Tested-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/sta.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/sta.c b/drivers/net/wireless/intel/iwlwifi/mld/sta.c
index f266a81dd29b..994d4561518b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/sta.c
@@ -793,7 +793,7 @@ void iwl_mld_remove_sta(struct iwl_mld *mld, struct ieee80211_sta *sta)
 		 * removed, but FW expects all the keys to be removed before
 		 * the STA is, so remove them all here.
 		 */
-		if (vif->type == NL80211_IFTYPE_STATION)
+		if (vif->type == NL80211_IFTYPE_STATION && !sta->tdls)
 			iwl_mld_remove_ap_keys(mld, vif, sta, link_id);
 
 		/* Remove the link_sta */
-- 
2.34.1


