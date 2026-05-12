Return-Path: <linux-wireless+bounces-36334-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHFqOFCBA2pB6gEAu9opvQ
	(envelope-from <linux-wireless+bounces-36334-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 21:36:48 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6093E528B5D
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 21:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E612530E6DE9
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 19:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F11367295;
	Tue, 12 May 2026 19:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YZj9q3bB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E32A3655E7
	for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 19:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778614504; cv=none; b=I+SoAkJQRqS4u2L/swROA6O6bi8T1aK4iWS6LAnXwNgw/KF+jBrn71lRzI1I8sJ1y4ULpTgR6ySL9PTfRKiPIRe8r9/k7bMRaTakTjipC6zC7/GfbQ4U/41I0xi2GiqaOf0zcLjRC/FozEtNI3UmBZI9NTpHhoLFaMygK38+sZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778614504; c=relaxed/simple;
	bh=RxM1g2GRfonRdNv46mOSXhwSe/y6Bo9fU5Rcxlp1MR4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g2SwVsThwj7LeMz5kzn4GxVRANr3lWhW8UpvhyLhRtrv/AA3djd0z8bFnkkq4mOqyjgbkNa1smk4R+g58FLgPnhggOB2cpOPDuGtxEMAL9PPzyQiimldP/RsPmkV4bMRANaw9i1SEQNZs3Z3eLnHBAoZDM2IzzNV0CrNq8hlPoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YZj9q3bB; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778614503; x=1810150503;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RxM1g2GRfonRdNv46mOSXhwSe/y6Bo9fU5Rcxlp1MR4=;
  b=YZj9q3bB5cO64aZaAYyvtzY067HNj0QBiLI6mhswqO1lyK5u9U8jOhxz
   aob9SqCTBesg+Vt1Uy5Ge9HuL5QzvdDg65/x7oDu/xHOeM1fQ4onU0n4v
   eY36Vuxw6O6YK1tlaS2Ug6+NNyCvEZad5EBpVKdVodi+ssPDuqiXYVbZf
   uHHEIVi25fE4/dLn20GO9ib6ek/GV7GkbAbEMlxSB96EKMbww+j1iVm4j
   XrUwPSXFaFTIb2aCX0zQSL5DSGo9K1SpSAIW/QcGeZIn8RT0Ajh+2Qn7r
   VvVxwMQK3cnnORFuCc9eGp2zThjqeb7CZIB72o5xYnIJjEC2zTJe84+Fi
   g==;
X-CSE-ConnectionGUID: CyeoQrqSR9O5SUXPxsxt/Q==
X-CSE-MsgGUID: 8K8UD0l9RSWBFNvBMlgXRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="83148786"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="83148786"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 12:35:03 -0700
X-CSE-ConnectionGUID: T301rP0HQ/2js95JnpCDKA==
X-CSE-MsgGUID: d1Rwg5DdSYOq7akgGEtmGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="231471746"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 12:35:01 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Daniel Gabay <daniel.gabay@intel.com>
Subject: [PATCH iwlwifi-next 07/15] wifi: iwlwifi: mld: fix NAN DW end notification handler
Date: Tue, 12 May 2026 22:34:33 +0300
Message-Id: <20260512222731.0fd880fb80f9.Iacd459d0e2df28444bb6ccf8730e2f50440e6e32@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260512193441.2352467-1-miriam.rachel.korenblit@intel.com>
References: <20260512193441.2352467-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6093E528B5D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-36334-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim]
X-Rspamd-Action: no action

From: Daniel Gabay <daniel.gabay@intel.com>

Use IWL_DEBUG_INFO instead of IWL_INFO for logging the DW end
notification, as this is a recurring event during NAN operation
and should not spam the kernel log.

Also fix a coding style issue - missing space after 'if'.

Fixes: 9e978d8ebbe9 ("wifi: iwlwifi: mld: Add support for NAN")
Signed-off-by: Daniel Gabay <daniel.gabay@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/nan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/nan.c b/drivers/net/wireless/intel/iwlwifi/mld/nan.c
index cb7a3e01adb4..264ea7a9a896 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/nan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/nan.c
@@ -269,7 +269,7 @@ void iwl_mld_handle_nan_dw_end_notif(struct iwl_mld *mld,
 	struct wireless_dev *wdev;
 	struct ieee80211_channel *chan;
 
-	IWL_INFO(mld, "NAN: DW end: band=%u\n", notif->band);
+	IWL_DEBUG_INFO(mld, "NAN: DW end: band=%u\n", notif->band);
 
 	if (IWL_FW_CHECK(mld, !mld_vif, "NAN: DW end without mld_vif\n"))
 		return;
-- 
2.34.1


