Return-Path: <linux-wireless+bounces-28808-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D08A0C480E5
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 17:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0660E420F88
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 16:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5660B284896;
	Mon, 10 Nov 2025 16:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BQUB6NRR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D4827E07E
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 16:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762790949; cv=none; b=h1UDbevlbQT8bDs7N60BUHr6bGiXSB1aT1AJzztU9iciQHUN6RWcia2fTLv1vc/mH9LFmK30mycWCnXYh3WgxjqAzRqznAuc78hgMPws4kBtDyUaPK0pKx/IWPO9Dr8LOOjB75nGa709+2sITtRj5g/WgimprqQEUrG4hNRN33o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762790949; c=relaxed/simple;
	bh=wWxnX5MR9xXeY1uHZxdd1DRMKCZFBzMJal93C5rWwso=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hiPPUQQ3Im5z5zM8pTqwd/AeOyfwtmwZXAA3SK4P27FLaKiew6Xj4LDSQkH+zPRvmw0po5CWdITQdmFxj1mdj3juAfuUnPnz1cuKgbhh05C85amMjbmc9A++heIVJggFzLrVFxczYWFNwxKHbVnFbSYPpnpU31RHjp+tT9646GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BQUB6NRR; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762790948; x=1794326948;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wWxnX5MR9xXeY1uHZxdd1DRMKCZFBzMJal93C5rWwso=;
  b=BQUB6NRRIPLVtpmbEXJgzq+jMPxd58GapHQ8h9rvjAe8uTOt9RaC/e+N
   6MrRcp9MMs1byshpuEZ9WxflzKY0LJVWMmMA4K+Y/IdGTI7ISZvEzo96D
   wJiJHqLZ9iCH9uxMcd9PNl6+NmNAOnjuf8bF2pAOBwSEh9pxJKMbyJ+yF
   T82MWj3jK029hEOyZ/bi6eECsQxHl454iOjN/rBmtKvjGBx5Wk5vvi6sn
   hqcCZTHGpNzoaBel81tJr3ChJhxuyp0jy8WjP59ZSkkVP8ajHM0ejyltA
   UfnaWad/grv4wv7mnWP6qynpHAFEwe7en5gDHDFdrb2IF+fsJMwMZc6oB
   w==;
X-CSE-ConnectionGUID: U25VeDuYS4+dh3TnIZOSVg==
X-CSE-MsgGUID: sjz/TdzySXiDzbeYsQ/8Nw==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="64725180"
X-IronPort-AV: E=Sophos;i="6.19,294,1754982000"; 
   d="scan'208";a="64725180"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 08:09:08 -0800
X-CSE-ConnectionGUID: GiCtM19IQHinarnzzeo+qg==
X-CSE-MsgGUID: uvsOCE7XS3adPgXPOgA1pA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,294,1754982000"; 
   d="scan'208";a="188877197"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 08:09:06 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH iwlwifi-next v2 6/6] wifi: iwlwifi: mld: Advertise support for multicast RX registration
Date: Mon, 10 Nov 2025 18:08:50 +0200
Message-Id: <20251110180612.640fb5a99470.If6f423bcf0a426e662041a4b310ce81485f1af03@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251110160850.366979-1-miriam.rachel.korenblit@intel.com>
References: <20251110160850.366979-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Ilan Peer <ilan.peer@intel.com>

While this is not needed for configuring Rx filters, without setting
it some multicast action frame registrations from user space would
fail, specifically, NAN multicast action frame registration (SDFs).

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/mac80211.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index 05ab6246eb17..8466345d7f21 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -377,6 +377,8 @@ static void iwl_mac_hw_set_wiphy(struct iwl_mld *mld)
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_FILS_MAX_CHANNEL_TIME);
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_OCE_PROBE_REQ_HIGH_TX_RATE);
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_MU_MIMO_AIR_SNIFFER);
+	wiphy_ext_feature_set(wiphy,
+			      NL80211_EXT_FEATURE_MULTICAST_REGISTRATIONS);
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_SPP_AMSDU_SUPPORT);
 
 	if (fw_has_capa(ucode_capa, IWL_UCODE_TLV_CAPA_PROTECTED_TWT))
-- 
2.34.1


