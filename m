Return-Path: <linux-wireless+bounces-20274-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 280FCA5E746
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 23:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 976503B416E
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 22:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688821F03E6;
	Wed, 12 Mar 2025 22:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LiIjxNtR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE2C1EF0AD
	for <linux-wireless@vger.kernel.org>; Wed, 12 Mar 2025 22:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741818186; cv=none; b=cuHxpiT87vPtpX0AnNKqP/yPKE6gAvqFDlH3iG4KpZwJdQJ92FilQ2KfxUYa1DCvDKZCswdbvsMJSWpcI1hLOeM8elGFY72V25Lj2E+0fXvdPy0+WBPYiP3zYE8W0IVxkL6D9hpKwCZctje3Ni2TFNMwwYH+2VWTFQOu0arZ+V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741818186; c=relaxed/simple;
	bh=GjS7lGGESt/rvA4lexSx3lHXmgQxxPUxFvVmQtzoatI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DgcPdVZXUKt/Vo7x9z7Wfes0fpGvYXsdP4/fO8VCZ/Lydiq+4v7fFiKXczfpGRJJ3Df8OJohIsvSscbXoOcQw6p6P3QZU4nnXiJcgpu1XofAZZFjU4x8sZxV4b+WzTkvBRawYmloH6RrXv8hg35mWAMSLcQ4LjR6umfrMJnPQjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LiIjxNtR; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741818185; x=1773354185;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GjS7lGGESt/rvA4lexSx3lHXmgQxxPUxFvVmQtzoatI=;
  b=LiIjxNtRCj/S9S0X53+eYnj1PzpDEKLsp126GpEujWK0qgcy2t6ClkaX
   FMKHPD174RusPXP6rn9Fl57VjUTMzb1x8mPZ9SQYfazgqLpBRL5zK+/nB
   DtL4P5tmqZExhCv9Hwc+Ojrd/YPiJb231QW1dADq35K5oKweXxxsBjGKB
   PZ1m2PU+Q4mMZ8WueGskFNGSAJgHSMZEIrFon07Yx2eJwV83Bm+/o2ysA
   Da08NrOAc/C60DqZxvjqNudx9g55JHpBfO26ur821/pJsLQ41OEhlilZc
   Cok9yBZ/azRfM15sHfOJ0U1YaATPbGWKAIeKyG1k1hYY8uvFR1XrwtvwY
   A==;
X-CSE-ConnectionGUID: ZBslj8FSQdWWnsEsH2XIfg==
X-CSE-MsgGUID: C1oAmiywS9uW+ECIUx4yNA==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="42826754"
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="42826754"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 15:23:05 -0700
X-CSE-ConnectionGUID: 3Q1b7AfdRL2KTmMSdhdTeQ==
X-CSE-MsgGUID: yW9dRUVCTheAuGPTTZ3pQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="121267390"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 15:23:03 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH wireless-next 09/15] wifi: iwlwifi: mld: KUnit: create chanctx with a custom width
Date: Thu, 13 Mar 2025 00:22:32 +0200
Message-Id: <20250313002008.85a1285d34cd.Ia71cdcd4241fe73501bc93e3cb2c6bb3f631b9ec@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250312222238.2585340-1-miriam.rachel.korenblit@intel.com>
References: <20250312222238.2585340-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

Currently iwlmld_kunit_add_chanctx receives a band, picks a predefined
static chandef, and creates the chanctx from it.
Change it to receive a bandwidth as well. Otherwise, the bandwidth in
the chanctx/phy will be different than what test specified in the
iwl_mld_kunit_link.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
---
 .../net/wireless/intel/iwlwifi/mld/tests/utils.c   |  5 +++--
 .../net/wireless/intel/iwlwifi/mld/tests/utils.h   | 14 ++++++++------
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/tests/utils.c b/drivers/net/wireless/intel/iwlwifi/mld/tests/utils.c
index fa2710661bd5..9712ee696509 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/tests/utils.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/tests/utils.c
@@ -346,7 +346,8 @@ iwlmld_kunit_setup_assoc(bool mlo, struct iwl_mld_kunit_link *assoc_link)
 	else
 		link = &vif->bss_conf;
 
-	chan_ctx = iwlmld_kunit_add_chanctx(assoc_link->band);
+	chan_ctx = iwlmld_kunit_add_chanctx(assoc_link->band,
+					    assoc_link->bandwidth);
 
 	wiphy_lock(mld->wiphy);
 	iwlmld_kunit_assign_chanctx_to_link(vif, link, chan_ctx);
@@ -427,7 +428,7 @@ struct ieee80211_vif *iwlmld_kunit_assoc_emlsr(struct iwl_mld_kunit_link *link1,
 	link = wiphy_dereference(mld->wiphy, vif->link_conf[link2->id]);
 	KUNIT_EXPECT_NOT_NULL(test, link);
 
-	chan_ctx = iwlmld_kunit_add_chanctx(link2->band);
+	chan_ctx = iwlmld_kunit_add_chanctx(link2->band, link2->bandwidth);
 	iwlmld_kunit_assign_chanctx_to_link(vif, link, chan_ctx);
 
 	wiphy_unlock(mld->wiphy);
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/tests/utils.h b/drivers/net/wireless/intel/iwlwifi/mld/tests/utils.h
index bb757a7dd8e7..d3723653cf1b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/tests/utils.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/tests/utils.h
@@ -65,24 +65,26 @@ struct ieee80211_chanctx_conf *
 iwlmld_kunit_add_chanctx_from_def(struct cfg80211_chan_def *def);
 
 static inline struct ieee80211_chanctx_conf *
-iwlmld_kunit_add_chanctx(enum nl80211_band band)
+iwlmld_kunit_add_chanctx(enum nl80211_band band, enum nl80211_chan_width width)
 {
-	struct cfg80211_chan_def *chandef;
+	struct cfg80211_chan_def chandef;
 
 	switch (band) {
 	case NL80211_BAND_2GHZ:
-		chandef = &chandef_2ghz;
+		chandef = chandef_2ghz;
 		break;
 	case NL80211_BAND_5GHZ:
-		chandef = &chandef_5ghz;
+		chandef = chandef_5ghz;
 		break;
 	default:
 	case NL80211_BAND_6GHZ:
-		chandef = &chandef_6ghz;
+		chandef = chandef_6ghz;
 		break;
 	}
 
-	return iwlmld_kunit_add_chanctx_from_def(chandef);
+	chandef.width = width;
+
+	return iwlmld_kunit_add_chanctx_from_def(&chandef);
 }
 
 void iwlmld_kunit_assign_chanctx_to_link(struct ieee80211_vif *vif,
-- 
2.34.1


