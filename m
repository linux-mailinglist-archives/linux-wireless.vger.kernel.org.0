Return-Path: <linux-wireless+bounces-36490-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GGCD3ETB2rgrQIAu9opvQ
	(envelope-from <linux-wireless+bounces-36490-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 14:37:05 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA45754FAD4
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 14:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6229A31A6302
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 12:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81CD048032C;
	Fri, 15 May 2026 12:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GgUWftob"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B51480326
	for <linux-wireless@vger.kernel.org>; Fri, 15 May 2026 12:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778847324; cv=none; b=UUWYGPznlVOj9TLFPC8VGmcnXLg5VJGRiagYyFNkuid7GmFqVBlsdOtZ3VECTigTmzskr4NE5FlE6Csurm9fXORbc2ZmQBRRR7r1zqFjsonQqfmwOioPltzqHN3rpOPf4QmCXra8Tfx/LVbIVvUXDecoh2j3HSd3uukQ3s5lD6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778847324; c=relaxed/simple;
	bh=RhG7jMZA9AKl4octZMhu5J3NLw766J+lawGO/Fy/We0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qJkCbPSoGBuNk90QFGg0zawDfM4VMkOSLMAzqdHOpnblvuKQfgdpDnYbvgc/wPR6WrHaMC61FKL0tnIuatrg9qz3djRUJxVkfDoLRWaAvYzn7X9AWan/u3k6W0LZ/ConiAFGeiWG3Enz+AjqMQoyu/p8YSMk9xYXa5roe5im57U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GgUWftob; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778847320; x=1810383320;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RhG7jMZA9AKl4octZMhu5J3NLw766J+lawGO/Fy/We0=;
  b=GgUWftobqRruEBMdA4G43XFEgokKZFetBfJ0gqUEYs04szsdAfhbHvBg
   t4J4ByEUcxNoyvRxfqSCn+kdpYS5D6IqjoIF3pxy9xDGM/Iu/LbIRGk9S
   nA51n+PZBSHrdrP8s6bBgQhBgR9wAVGJ2PBOTY8xeSMFbEG+hQaP2Khgs
   pL05/V0SWQdRaOwcn1Up743fBzaMwj9Tzqfxs6R2iZijsx/omjMEx+HKU
   l/nt81L4PIeDZTUv3zh6bateawtMD836B3trX+XyCkDoyU1QBjZfkaINy
   tr50gI5+NlbPF+y3aC7G40gsDTKFBDkai7TowOpmglxTDKrN0VXs/QrBM
   Q==;
X-CSE-ConnectionGUID: yI7Iu3keT8iKzNQqIL1XRQ==
X-CSE-MsgGUID: xbC8xgWUShS8vTNPmhezRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="79657846"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="79657846"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 05:15:20 -0700
X-CSE-ConnectionGUID: iGCiHN9wQwOtOSD/9tw/hg==
X-CSE-MsgGUID: XI2vLXvJQP2myadY3EnkNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="262201061"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 05:15:19 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-fixes 4/5] wifi: iwlwifi: mld: don't WARN on WoWLAN suspend w/o BSS vif
Date: Fri, 15 May 2026 15:14:59 +0300
Message-Id: <20260515151352.0c55d1135409.I54f8be0e2aa28cfb1cb1dcf3b2d2d8fe75b4397b@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260515121500.1170852-1-miriam.rachel.korenblit@intel.com>
References: <20260515121500.1170852-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AA45754FAD4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36490-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: Johannes Berg <johannes.berg@intel.com>

Clearly, from a user perspective, it must be valid to configure
WoWLAN (which can include network detection) and then suspend
while not connected to a network, or even without an interface
at all (WoWLAN config is handled on a per-wiphy basis). Since
mac80211 doesn't distinguish these cases and simply calls the
driver to suspend whenever WoWLAN is configured, the driver has
to cleanly handle the case where it's called for WoWLAN but no
(BSS) interface exists.

Remove the WARN_ON(), move the print so it doesn't get done in
this case, and keep returning 1 to disconnect everything.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/d3.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/d3.c b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
index ef98efc8fb1b..3a595a1c2e00 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
@@ -1930,12 +1930,12 @@ int iwl_mld_wowlan_suspend(struct iwl_mld *mld, struct cfg80211_wowlan *wowlan)
 	if (WARN_ON(!wowlan))
 		return 1;
 
-	IWL_DEBUG_WOWLAN(mld, "Starting the wowlan suspend flow\n");
-
 	bss_vif = iwl_mld_get_bss_vif(mld);
-	if (WARN_ON(!bss_vif))
+	if (!bss_vif)
 		return 1;
 
+	IWL_DEBUG_WOWLAN(mld, "Starting the wowlan suspend flow\n");
+
 	if (!bss_vif->cfg.assoc) {
 		int ret;
 		/* If we're not associated, this must be netdetect */
-- 
2.34.1


