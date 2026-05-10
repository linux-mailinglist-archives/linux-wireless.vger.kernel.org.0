Return-Path: <linux-wireless+bounces-36156-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ADyWDzbRAGoMNAEAu9opvQ
	(envelope-from <linux-wireless+bounces-36156-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 10 May 2026 20:40:54 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7AF505BD6
	for <lists+linux-wireless@lfdr.de>; Sun, 10 May 2026 20:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0ACAB301B4F2
	for <lists+linux-wireless@lfdr.de>; Sun, 10 May 2026 18:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910F931326B;
	Sun, 10 May 2026 18:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XO9IFQ/p"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537C53112C1
	for <linux-wireless@vger.kernel.org>; Sun, 10 May 2026 18:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778438406; cv=none; b=ey2s326ZmEisYp6CVc/R6fDaOyQIMjvDj7OYc380CH+HdTqsGj98Ugyp7CleR4tCmM5qKqB/m+YrAJYv7yjTGobOE9h/2LZ0hQG1USNRpGcHq3KoJ9sQepg4OhVhADObwnS6EJyWtbHbppRNMiVrjF9yTFDiVTBWr8rb/J982n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778438406; c=relaxed/simple;
	bh=TZsyUkkdADgmeM85Ou4w5h0FerOFmCgh/Gszzq1dsSg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o+r35C+IoFeGdBILWMKgEYcrYPsCKjjc4+Sqhaj+rCLQvmwZQRQ0esriAGIamXujm661FMC9f98dPMcSiMRn06scOIp7P45NDvw2MqvJM9PLvueNeE0wdzjqFkqkfERdy6AotxNEMiGCA09+ztt86Krf457BEGea+YPnGymPeyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XO9IFQ/p; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778438405; x=1809974405;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TZsyUkkdADgmeM85Ou4w5h0FerOFmCgh/Gszzq1dsSg=;
  b=XO9IFQ/p612Wq66jqfYb+T2AfOrVb29GpLekbidHFalovJvkR4teUrOE
   y2Isue3NMVJRno1sxLFO8VCx1pF/zYY4ce3gtpL39UonRBhcCaj7hTw4c
   jvjs4t8380Tuxyu3kTQi272sEj+dcsN/39wniB+ZcF5Prz+M7aryc1pIn
   vbBmp1uedjFySi3z1bctSpV6EArhYvww30I2Ut+QS28XAJtUZaTmhWGkg
   DTzxRt9scre5ecs+eQXOPH4PzjIVC++9coHHNq8mFXCqmnKE2AYpV/rm0
   R2rxg+gpLt/j8zlDVSv4GqNAI+x8VZ+WPges7WRGIFp0vvKdZqXMIDF6+
   w==;
X-CSE-ConnectionGUID: VAHbgpSMR3q0CFb08UmrGQ==
X-CSE-MsgGUID: H7TuRIt3TAy24/gdTslZeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11782"; a="83208984"
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="83208984"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 11:40:05 -0700
X-CSE-ConnectionGUID: rtd3L11GSkueFc/vEf4Vqw==
X-CSE-MsgGUID: d/X00/j5SmimLaPlnv39Aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="267626828"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 11:40:04 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH iwlwifi-next 11/15] wifi: iwlwifi: mld: Fix number of antennas in NAN capabilities
Date: Sun, 10 May 2026 21:39:34 +0300
Message-Id: <20260510213745.c5608e6a5324.Ib8b9769e7a598b01f6285bd0782aa3bf13f144a2@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260510183938.4182886-1-miriam.rachel.korenblit@intel.com>
References: <20260510183938.4182886-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BE7AF505BD6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-36156-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,intel.com:dkim]
X-Rspamd-Action: no action

From: Ilan Peer <ilan.peer@intel.com>

Instead of hardcoding the number of supported antennas for Tx/Rx, set
them according to hardware capabilities.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/mac80211.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index e76421a8a8e6..4ad1d55fd646 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -290,8 +290,12 @@ static void iwl_mld_hw_set_nan(struct iwl_mld *mld)
 				      NAN_OP_MODE_PHY_MODE_HE |
 				      NAN_OP_MODE_160MHZ;
 
-	/* Support 2 antennas for Tx and Rx */
-	hw->wiphy->nan_capa.n_antennas = 0x22;
+	hw->wiphy->nan_capa.n_antennas =
+		(hweight32(hw->wiphy->available_antennas_tx) &
+		 NAN_DEV_CAPA_NUM_TX_ANT_MASK) |
+		((hweight32(hw->wiphy->available_antennas_rx) <<
+		  NAN_DEV_CAPA_NUM_RX_ANT_POS) &
+		 NAN_DEV_CAPA_NUM_RX_ANT_MASK);
 
 	/* Maximal channel switch time is 4 msec */
 	hw->wiphy->nan_capa.max_channel_switch_time = 4;
-- 
2.34.1


