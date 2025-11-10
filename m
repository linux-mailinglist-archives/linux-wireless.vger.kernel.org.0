Return-Path: <linux-wireless+bounces-28769-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C543C46BEA
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 14:02:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE033188D5E9
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 13:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC25E30F55C;
	Mon, 10 Nov 2025 13:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CLFF2SzJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBFB2FE568
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 13:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762779757; cv=none; b=pSbWtaN3pr9UDdrbZBaBCdgHr4zPq2IUzmoLnTF7GedSiqnEz0o4oupVDJzvazYSTQCEKTJaIGY7phhHDfDDX5vI/zRncQlUstVNF64cvV6GqMVgjUpTWUcJbsUfoEEBcPa3MNxT8oFiFSPEq8fycg1KL1H9v5jXPUZ2xBeyb60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762779757; c=relaxed/simple;
	bh=9OVfK41Vg9FJcKMWM+8iXz99pIf5cYHfYgXJYFSrs9s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K/4DEEsY3wpxtLO80Ph0TnoYBs0QsvMlR+M0WkJAUN3IZltZsb0vh8unc/c58pGfAr8HahUNthwpqtkALGoFxEskLRprIMD6TjIMPMlda3ltuGoUnEd2okSt52Z/t5rqQ0OgprpE8inhr+dZl1Fad/aFxLD+XmJtBFOWLGaGqAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CLFF2SzJ; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762779756; x=1794315756;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9OVfK41Vg9FJcKMWM+8iXz99pIf5cYHfYgXJYFSrs9s=;
  b=CLFF2SzJdHt0j/SKmFBz1zchBtiPpM1VttG+8R/BFmGxcEvu248Tzbs3
   SVueF6q0w5zsohM504A4rEzUEajhb23Gd+GdpMuyRdZlQlu6/lYybL7r1
   hh6Icq6AV2CAhgyTqp+H0qycUUeKp3MvVlHgtqrpzs3QwMgxGbwDwPufk
   Sgu3S4a75L2BF6OUtKVDYnTHsSEWCo9nP4M/OPrBsJe473N/cl1J//GlH
   4elUOvFaXpeA/YXCWKjy4//HEI9mNZxi5RRWeZ+ocDimfYOF8jm/h4Y5D
   lyNJvawPpBIPyiW0LpPZI4wYmQBsxTekTgWPwtaUBPRCib25/UQ6bPkLF
   Q==;
X-CSE-ConnectionGUID: K1l2Gi+IQMC510A7pF0fxg==
X-CSE-MsgGUID: 0RVKqlvUSWSaCvDO0TGeUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="82454870"
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="82454870"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 05:02:35 -0800
X-CSE-ConnectionGUID: n2jjJYFPRUmZPIrZ5NhYPQ==
X-CSE-MsgGUID: pj9r2Z58SGK9yCuIjpu33A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="192928495"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 05:02:34 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Daniel Gabay <daniel.gabay@intel.com>,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH iwlwifi-next 02/15] wifi: iwlwifi: mld: Remove wrong channel flags in scan cmd
Date: Mon, 10 Nov 2025 15:02:13 +0200
Message-Id: <20251110150012.a8a931e1abef.I8f7dc66b23198b83083685ef76dec59cfb407f57@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251110130226.223364-1-miriam.rachel.korenblit@intel.com>
References: <20251110130226.223364-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Daniel Gabay <daniel.gabay@intel.com>

Erroneously, the channel flags in the scan command for 6 GHz scan
were mistakenly set using iwl_mld_scan_get_cmd_gen_flags, which
actually calculates a different field (the general flags) in the
command.

However, these flags are not relevant for 6 GHz scan part, except for
IWL_SCAN_CHANNEL_FLAG_6G_PSC_NO_FILTER, which is already set
correctly. Since the incorrect flags are only applied in the
6 GHz scan part and are ignored by the firmware, this has no
adverse effect. Therefore, we can simply remove this helper
function call and explicitly clear the flags.

Signed-off-by: Daniel Gabay <daniel.gabay@intel.com>
Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/scan.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/scan.c b/drivers/net/wireless/intel/iwlwifi/mld/scan.c
index fd1022ddc912..16f48087a888 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/scan.c
@@ -1063,14 +1063,15 @@ static int
 iwl_mld_scan_cmd_set_6ghz_chan_params(struct iwl_mld *mld,
 				      struct iwl_mld_scan_params *params,
 				      struct ieee80211_vif *vif,
-				      struct iwl_scan_req_params_v17 *scan_p,
-				      enum iwl_mld_scan_status scan_status)
+				      struct iwl_scan_req_params_v17 *scan_p)
 {
 	struct iwl_scan_channel_params_v7 *chan_p = &scan_p->channel_params;
 	struct iwl_scan_probe_params_v4 *probe_p = &scan_p->probe_params;
 
-	chan_p->flags = iwl_mld_scan_get_cmd_gen_flags(mld, params, vif,
-						       scan_status);
+	/* Explicitly clear the flags since most of them are not
+	 * relevant for 6 GHz scan.
+	 */
+	chan_p->flags = 0;
 	chan_p->count = iwl_mld_scan_cfg_channels_6g(mld, params,
 						     params->n_channels,
 						     probe_p, chan_p,
@@ -1106,8 +1107,7 @@ iwl_mld_scan_cmd_set_chan_params(struct iwl_mld *mld,
 
 	if (params->scan_6ghz)
 		return iwl_mld_scan_cmd_set_6ghz_chan_params(mld, params,
-							     vif, scan_p,
-							     scan_status);
+							     vif, scan_p);
 
 	/* relevant only for 2.4 GHz/5 GHz scan */
 	cp->flags = iwl_mld_scan_cmd_set_chan_flags(mld, params, vif,
-- 
2.34.1


