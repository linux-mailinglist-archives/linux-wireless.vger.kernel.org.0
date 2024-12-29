Return-Path: <linux-wireless+bounces-16862-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 790069FDF3F
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Dec 2024 15:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D20183A1791
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Dec 2024 14:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19D128691;
	Sun, 29 Dec 2024 14:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nV6tbjig"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2231C1607B7
	for <linux-wireless@vger.kernel.org>; Sun, 29 Dec 2024 14:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735483510; cv=none; b=R7uoaoBCLMytTLAqXzMzDVXeY+T2h4pzWuv0ruYrzybVoU8d+XLqTLjy/S4EeFPXPKyJR9xld3HPHAQLKw0c/DZD7DP93fDfZMLF6ph43zH0YaU4LU+SBBA9+OQ3fYWutCCV9HqeHoa1ZiT75QuC732J/VJVrHLA4f99GxUzJCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735483510; c=relaxed/simple;
	bh=X7d1g/MzFestKB8fyf2XWUC+/CtY4lYz38c5wuqbFOU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zar5unpdDUaI/UUmdhoWrJOvgDKifzLa1AYT2wg05MyFz/3wfZhBDXIGjZjAxl+Iz0hdQ9DGUU33ZvKHbHi6WxjjjvDQiCK+ty8sfEAeCMAHPQss5o1RiEVSq6djJXIJqmVAMVYjlHYvgl8le24KLovq6gljsP7mOzTtzZvc5gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nV6tbjig; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735483509; x=1767019509;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X7d1g/MzFestKB8fyf2XWUC+/CtY4lYz38c5wuqbFOU=;
  b=nV6tbjigo8GOCwrCzUVKGkfCUNWBz+lq+kA0vDjYyFR3cz8AXqfj2U1Y
   /f26KyJcubm9f1SB00Ej7g97sRUMuGAIqyaACSpYrzoxR07NZv0UFIIlI
   Zr+K7vbekJr/qiuW3lOmzCnjcQvmtcW/igqXJQCWjf6OLcREYu6ye1EP0
   kXfoFPcMIOmk9ADw7zF+vmZCKAZ1PXmfGIeKvbRVA0rt9AgPYjBSiDTXL
   yLkEpQGfoZlvr0x//yrrgb/gGQhg29dXJna5jIoz4/aRE2UOPAcyIiQlN
   pjWvoo2eJLX3e35aNSLJQFR6hn7nbtXuAeNws4L4R0fM3AhA56u6Bcjf9
   g==;
X-CSE-ConnectionGUID: q2koCFwkSZOf8BwwIv7paw==
X-CSE-MsgGUID: plMwyQw/RzajzCGMDgR5/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11299"; a="39572425"
X-IronPort-AV: E=Sophos;i="6.12,274,1728975600"; 
   d="scan'208";a="39572425"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2024 06:45:08 -0800
X-CSE-ConnectionGUID: tpuTzr60RtaUCctCxxqEfQ==
X-CSE-MsgGUID: zYhmUGugQ4GTFkiVxiVITA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="105656779"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2024 06:45:06 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 01/17] wifi: iwlwifi: mvm: avoid NULL pointer dereference
Date: Sun, 29 Dec 2024 16:44:36 +0200
Message-Id: <20241229164246.31d41f7d3eab.I7fb7036a0b187c1636b01970207259cb2327952c@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241229144452.3151163-1-miriam.rachel.korenblit@intel.com>
References: <20241229144452.3151163-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

When iterating over the links of a vif, we need to make sure that the
pointer is valid (in other words - that the link exists) before
dereferncing it.
Use for_each_vif_active_link that also does the check.

Fixes: 2b7ee1a10a72 ("wifi: iwlwiif: mvm: handle the new BT notif")
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/coex.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/coex.c b/drivers/net/wireless/intel/iwlwifi/mvm/coex.c
index 36726ea4b822..21641d41a958 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/coex.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/coex.c
@@ -530,18 +530,15 @@ static void iwl_mvm_bt_coex_notif_iterator(void *_data, u8 *mac,
 					   struct ieee80211_vif *vif)
 {
 	struct iwl_mvm *mvm = _data;
+	struct ieee80211_bss_conf *link_conf;
+	unsigned int link_id;
 
 	lockdep_assert_held(&mvm->mutex);
 
 	if (vif->type != NL80211_IFTYPE_STATION)
 		return;
 
-	for (int link_id = 0;
-	     link_id < IEEE80211_MLD_MAX_NUM_LINKS;
-	     link_id++) {
-		struct ieee80211_bss_conf *link_conf =
-			rcu_dereference_check(vif->link_conf[link_id],
-					      lockdep_is_held(&mvm->mutex));
+	for_each_vif_active_link(vif, link_conf, link_id) {
 		struct ieee80211_chanctx_conf *chanctx_conf =
 			rcu_dereference_check(link_conf->chanctx_conf,
 					      lockdep_is_held(&mvm->mutex));
-- 
2.34.1


