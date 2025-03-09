Return-Path: <linux-wireless+bounces-20080-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1703CA580A8
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Mar 2025 06:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9622118901A2
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Mar 2025 05:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F013242AA5;
	Sun,  9 Mar 2025 05:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MWcnN5fH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AD554F8C
	for <linux-wireless@vger.kernel.org>; Sun,  9 Mar 2025 05:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741498633; cv=none; b=ISUdn2ObYzo8981DhjxfboYGNFkl9QaUZVYyhDgGDJteZJYfDk4oHKi/KYTWA4BR9YeLZ9xdF86mUV1lEnuq6ftTPxFvyfv/CtoqY+kin3aMbRQqCV03krG3zoEv4ugk1Pm9UmcE0vGQbhUNgJrzbubKLf6izk2hBwSE6LdRUNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741498633; c=relaxed/simple;
	bh=ppb6Tdxwu9zik7hUyKIif6LlLEkF6pu6cGPBD1TsbjY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oyhhStQnsAQrnVXYoCDq66FqVzZnVQdS1mLlTqcpnFv4iO4Lb3UEStI7Kpuzu0AmgJVcJdYpQZWhlVsYnuWRApWmYCFscaEpqush38SJhGsVgovg95Fj6krH0gFaP7d5n/SfwI9KmzYECrRZjQTGrIuHtMm9W4FiaFVNFfsVK/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MWcnN5fH; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741498632; x=1773034632;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ppb6Tdxwu9zik7hUyKIif6LlLEkF6pu6cGPBD1TsbjY=;
  b=MWcnN5fH4kQ/N38yFpkqIGmeNCiuv03HtHKIA8aSDT8grjqunJ2/Ucw1
   ejl9lQDwHbJvn75u5uNapmwQntfxUEufmSS+nsJG7uzHaYM85XVL7iplY
   UzyqPXgXYXuYYfS5CLLhti/VOev8hTAlQvoFAF+7bhDc6DmQTogdIoFI1
   8sY8YEK3NuPKVHJaxLL5cB9HgcqVpIvM2gWjD91uOWTfouSt44e07Or6f
   MAiuEsGDw5z1zlu3RdQouOaEmquwEqSQjUI/prLj8oIqjW1MM3SgVzh8n
   AsOdwajpiR0Et5eXCqtVNu1iQtz862LlnHI/EiWYmcyk19fIZmVfYll9m
   w==;
X-CSE-ConnectionGUID: k5hxyNETS4yuiX98fYRL3A==
X-CSE-MsgGUID: L6oBeMvBQNGG5cq7h/ybmw==
X-IronPort-AV: E=McAfee;i="6700,10204,11367"; a="41671689"
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="41671689"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 21:37:12 -0800
X-CSE-ConnectionGUID: 4JSPXTIcQvu4pU+qFfKfqA==
X-CSE-MsgGUID: SAWtu8vFRAKclxX5+vBBQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="150470613"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 21:37:10 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH v2 wireless-next 04/15] wifi: iwlwifi: mld: refactor iwl_mld_valid_emlsr_pair
Date: Sun,  9 Mar 2025 07:36:42 +0200
Message-Id: <20250309073442.0a3b2f88fbbf.I0152bc39e828488451e85135feb044ce1f7a85d3@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250309053653.2697525-1-miriam.rachel.korenblit@intel.com>
References: <20250309053653.2697525-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

- Change reasons enum to a bitmask and rename it
- Don't use 'else if' so all reasons will be set in the reasons bitmask

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/mlo.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mlo.c b/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
index b68092be9aed..bbaf9ad0e9eb 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
@@ -748,23 +748,23 @@ iwl_mld_valid_emlsr_pair(struct ieee80211_vif *vif,
 {
 	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
 	struct iwl_mld *mld = mld_vif->mld;
-	enum iwl_mld_emlsr_exit ret = 0;
+	u32 reason_mask = 0;
 
 	/* Per-link considerations */
 	if (iwl_mld_emlsr_disallowed_with_link(mld, vif, a, true) ||
 	    iwl_mld_emlsr_disallowed_with_link(mld, vif, b, false))
 		return false;
 
-	if (a->chandef->chan->band == b->chandef->chan->band) {
-		ret |= IWL_MLD_EMLSR_EXIT_EQUAL_BAND;
-	} else if (a->chandef->width != b->chandef->width) {
+	if (a->chandef->chan->band == b->chandef->chan->band)
+		reason_mask |= IWL_MLD_EMLSR_EXIT_EQUAL_BAND;
+	if (a->chandef->width != b->chandef->width) {
 		/* TODO: task=EMLSR task=statistics
 		 * replace BANDWIDTH exit reason with channel load criteria
 		 */
-		ret |= IWL_MLD_EMLSR_EXIT_BANDWIDTH;
+		reason_mask |= IWL_MLD_EMLSR_EXIT_BANDWIDTH;
 	}
 
-	if (ret) {
+	if (reason_mask) {
 		IWL_DEBUG_INFO(mld,
 			       "Links %d and %d are not a valid pair for EMLSR\n",
 			       a->link_id, b->link_id);
@@ -772,7 +772,7 @@ iwl_mld_valid_emlsr_pair(struct ieee80211_vif *vif,
 			       "Links bandwidth are: %d and %d\n",
 			       nl80211_chan_width_to_mhz(a->chandef->width),
 			       nl80211_chan_width_to_mhz(b->chandef->width));
-		iwl_mld_print_emlsr_exit(mld, ret);
+		iwl_mld_print_emlsr_exit(mld, reason_mask);
 		return false;
 	}
 
-- 
2.34.1


