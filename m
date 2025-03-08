Return-Path: <linux-wireless+bounces-20042-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 469B5A57E62
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 22:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79EAB16D91B
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 21:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E9D19597F;
	Sat,  8 Mar 2025 21:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ze0BJONM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07ED374FF
	for <linux-wireless@vger.kernel.org>; Sat,  8 Mar 2025 21:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741468044; cv=none; b=EKUbmFrTzFverhtyDYqeDsbh/00DKEp5dQbcFD7mL7bDvyNGQKnm6fipFvJUykS9gm/jU32yHb6Ue6ypPPKG94C7mQskOoBHpJ1kGBMPRFKMTWG5jj1l62NIO8ehQFeeGtCk39dcGbXflAqenkrm8rez+11rhAnch1epCxbcghE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741468044; c=relaxed/simple;
	bh=Mozn9GM8A5OO8wzQLG5biURyg82peQ/rG6dUuKHg38Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SXVCminjZn2nEql/IUmywCRm+pb7JpdPKaPpgPWlugVf1iCfc7V/f9pvh0I6WXApU+FXn1yM8MWiv98cACFeqAG7wgDGh9rNjj2j5LISmiT4Y8Y9/A09L1yTduFna0C+8xxkDfeLxp6shxPfd88+RdVu9u51SAGOp5m4C4LD3Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ze0BJONM; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741468043; x=1773004043;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Mozn9GM8A5OO8wzQLG5biURyg82peQ/rG6dUuKHg38Q=;
  b=Ze0BJONMgjlvUeOZxZUadjobWf37EAqtSRubScaIvDGvs62UGHyJG9El
   V7hcWxaZSQEApG71xZrcEM1MMI9SOCgDdgf6S0jG0IpVtwdYwUuoKn03v
   Vk1ajKo/9fyyuzTDtjRDcAKSx0iH9nMRNiASVX/+LKImwmUVcEfcp4Z/y
   BKR0vdIqxcHR3LxXYyNJ085PTutE75oKkGhzR0YJMRtPOEw2h1ZpSGcKv
   bnYYBGDEi5uh87xlKpPeQlhWOboN5TpG1K4m6oLgug6AD4LVnL+rQ9SwP
   8nTzF+V7obIR6fhD9VsNXpycV71xx5e5bfeMRfzu0j2PM3k1HbHJaBJuI
   Q==;
X-CSE-ConnectionGUID: wqdIglpfRja2F5bH7uYb7g==
X-CSE-MsgGUID: S4oFAFM6TM2cfq3TIYIzvg==
X-IronPort-AV: E=McAfee;i="6700,10204,11367"; a="42413123"
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="42413123"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 13:04:14 -0800
X-CSE-ConnectionGUID: MYPuUkd3TeedNlN1dGPsFw==
X-CSE-MsgGUID: SLtQxP2ARiy6XV1axwkGlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="124644427"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 13:04:13 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH RESEND wireless-next 13/15] wifi: mac80211: fix ML reconf reset in disconnect
Date: Sat,  8 Mar 2025 23:03:39 +0200
Message-Id: <20250308225541.abaea69cde42.I7e6b35731ded94fc2d68a2d4ecf81873712c268e@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250308210341.2302222-1-miriam.rachel.korenblit@intel.com>
References: <20250308210341.2302222-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

If disconnecting while ML reconfiguration is in progress,
the data isn't freed because the reset call is too late,
after the vif already switches to non-MLD. Move the call
to fix that.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/mlme.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 60a585caa96d..9c4d4f04b23e 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -4152,16 +4152,16 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 	wiphy_work_cancel(sdata->local->hw.wiphy,
 			  &ifmgd->teardown_ttlm_work);
 
-	ieee80211_vif_set_links(sdata, 0, 0);
-
-	ifmgd->mcast_seq_last = IEEE80211_SN_MODULO;
-
 	/* if disconnection happens in the middle of the ML reconfiguration
 	 * flow, cfg80211 must called to release the BSS references obtained
 	 * when the flow started.
 	 */
 	ieee80211_ml_reconf_reset(sdata);
 
+	ieee80211_vif_set_links(sdata, 0, 0);
+
+	ifmgd->mcast_seq_last = IEEE80211_SN_MODULO;
+
 	ifmgd->epcs.enabled = false;
 	ifmgd->epcs.dialog_token = 0;
 }
-- 
2.34.1


