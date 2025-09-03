Return-Path: <linux-wireless+bounces-26969-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC91B418C2
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Sep 2025 10:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94DBF18823E9
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Sep 2025 08:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D8C2EC08C;
	Wed,  3 Sep 2025 08:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SxoQtcfj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3032EBDEA
	for <linux-wireless@vger.kernel.org>; Wed,  3 Sep 2025 08:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756888776; cv=none; b=lEbx+CtMEcWFbGH/noYpRI5ENRTEm9z33Cto0xV2IxR5S2uSGRjLthHfo+kYulZ2CWJ3ftnPZ0+WaF9Q+EENy0aFmYF9xMrjTuhLI978dNo7PKN4B/2nJ/7AV20OeWfdtsb133+1C255COryF6w8Fescy0kmWhylqBxZhBuwDaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756888776; c=relaxed/simple;
	bh=SrK9pR7zBI7coZkkG2DM9bYWahMos0eQehcLufqYp8g=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RzWrDz06fRfqbHNSblGdephXi/pcWXniHNGiBTuU+JBXGCkX7GikNZyk65sHQO+g6UPLdGMDUNy8dcH2iwOcr0/5bozPkSMg12MrXq4iBWxZjA2CncN2QzGCyLSX1yBTQY+0ObV9kslt9mrYF+Bckgbghi1JCdWt7dxcnXigsgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SxoQtcfj; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756888775; x=1788424775;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=SrK9pR7zBI7coZkkG2DM9bYWahMos0eQehcLufqYp8g=;
  b=SxoQtcfjERDfpuSSRcXgpmo4AI+DEm40EVUpJHccpFwyAM82qA5bzjuh
   2Gj+qKTatPz1ncl2GB0k94WKFQ3Y/5Pzh2/co68IIKnI04Q6843KxPtLB
   rMPS8bI+9nXObQJx+eK4c+bcmloFR5FFhViC0ojchpcradNzqYY17oXBs
   xazvmEEJWh3V/s0O6aAMKeBqH7td72MLclYKSIZASLQ4TSu+cCLdjnwZR
   ZFqcs/4jZXG3C8j5LVQWMG8ms3X8KDlVFBJEjkxEvkarCgZ3I0vkArXmR
   mzCtY/lK7mlA1FKo0dgIXrZ6NpT2ArBfHJmD49WLDEiptpLiPjvGALlZ8
   w==;
X-CSE-ConnectionGUID: LWnOsR/hS9K/FtFdYDts4g==
X-CSE-MsgGUID: ZHbiLG1QRDaO2k+vxBOFJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63028829"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="63028829"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 01:39:34 -0700
X-CSE-ConnectionGUID: isEKReWNRwazdSmuItsHig==
X-CSE-MsgGUID: eF+0h+9cTLuKq9qjoIEIkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="175896596"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 01:39:34 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH wireless-next 2/2] wifi: mac80211: reduce the scope of rts_threshold
Date: Wed,  3 Sep 2025 11:39:04 +0300
Message-Id: <20250903083904.1972284-3-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250903083904.1972284-1-miriam.rachel.korenblit@intel.com>
References: <20250903083904.1972284-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

This is only needed within the 'if' scope, not in the function scope.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/util.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 32f1bc5908c5..b56941a70754 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -1756,7 +1756,6 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 	bool sched_scan_stopped = false;
 	bool suspended = local->suspended;
 	bool in_reconfig = false;
-	u32 rts_threshold;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
@@ -1832,7 +1831,9 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 	/* setup RTS threshold */
 	if (hw->wiphy->n_radio > 0) {
 		for (i = 0; i < hw->wiphy->n_radio; i++) {
-			rts_threshold = hw->wiphy->radio_cfg[i].rts_threshold;
+			u32 rts_threshold =
+				hw->wiphy->radio_cfg[i].rts_threshold;
+
 			drv_set_rts_threshold(local, i, rts_threshold);
 		}
 	} else {
-- 
2.34.1


