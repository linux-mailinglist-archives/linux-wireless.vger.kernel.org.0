Return-Path: <linux-wireless+bounces-36158-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WHNhHhfRAGoxNAEAu9opvQ
	(envelope-from <linux-wireless+bounces-36158-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 10 May 2026 20:40:23 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1747E505BA2
	for <lists+linux-wireless@lfdr.de>; Sun, 10 May 2026 20:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A58EC300598D
	for <lists+linux-wireless@lfdr.de>; Sun, 10 May 2026 18:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79523128DF;
	Sun, 10 May 2026 18:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NYrVI8Hp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50213112C1
	for <linux-wireless@vger.kernel.org>; Sun, 10 May 2026 18:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778438409; cv=none; b=taqKL7TaPaTmbfSVxGtYHWgk38Z28Y20T8XiDwQHleIz98TBVdij9RZdZ8sIXLTcgt8x7vumxbAmz8BJjMkCFlPOGfLzRvDmT1+35vUgbuKUnOi7A1HtgOP3pSEgJz/ayUbRic+my/PpkI67PqijrbPmHBWB03QOIgvBoq43Hvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778438409; c=relaxed/simple;
	bh=SzHQjcky3/OzCEOXo7r/x56WAEiGOSE/jGXChktiAmI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q43czLW7T1kcAC+OsnSBXovJeRV11ee7+rAbXy7Xf1057UniP2ivoSgB4d6vpq64z5mC/iTZLzJ7DTTEzXU9Uf5+pFoVvhKlEcddshu+ocV7Bbl7GyrUQqP4S9j9x7OxaUNMjiPn4lznvbvGRawX70fZB+wVb9znoFDGEqKin+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NYrVI8Hp; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778438408; x=1809974408;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SzHQjcky3/OzCEOXo7r/x56WAEiGOSE/jGXChktiAmI=;
  b=NYrVI8Hpc1hZv+gZwxZzcf1Wc2SDNsSmMIzCkM9SBZogPY/2C+Pg8MkK
   sSOtSxDEn/sN95eVdq1b6/umTJeiMm1M0qWt67kAKHjaV12vyyOpZXGqx
   2eG04Oia/RIFyBPWCHNZ6EcMxpIxuwLrMK3i3aLJ0tw1doAJlrkYXd1fi
   Zoou8AkSpJIhGSlRMKEdg+eiELD+T0keC5Ujr2h9RYngCpXEKf6wdgSdj
   oG/ydonkm9sR/wqM/Et6jtsslQtNGRE+L5mDYlmTWdXpw/G6V/XKUqFSX
   rb8MsU+RIRnK4BMefttp9qOiUGK1d5+e7cgysJxiOccqMIPICgr7CPSQ4
   g==;
X-CSE-ConnectionGUID: f2J/QiyRQgCTw0oq5NnqHQ==
X-CSE-MsgGUID: v3QU/B9NTtSPydcOyEyMYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11782"; a="83208986"
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="83208986"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 11:40:08 -0700
X-CSE-ConnectionGUID: nsw82BG+Q3+lGr4Zk/2kWA==
X-CSE-MsgGUID: lBva1Q+9TDiFpN3iE1PG3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="267626847"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 11:40:06 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH iwlwifi-next 13/15] wifi: iwlwifi: mld: Do not declare NAN support for Extended Key ID
Date: Sun, 10 May 2026 21:39:36 +0300
Message-Id: <20260510213745.55857cbf4e88.Ic3e47a926539a1d8f20103c40ebe5cfeaf671a96@changeid>
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
X-Rspamd-Queue-Id: 1747E505BA2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-36158-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Ilan Peer <ilan.peer@intel.com>

Do not declare support for Extended Key ID for NAN, as defined in section
7.4 in the WiFi Aware specification v4.0 (in order to support security
association upgrade).

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/mac80211.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index d5deb4a7fab4..cad10f011072 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -299,8 +299,6 @@ static void iwl_mld_hw_set_nan(struct iwl_mld *mld)
 
 	/* Maximal channel switch time is 4 msec */
 	hw->wiphy->nan_capa.max_channel_switch_time = 4;
-	hw->wiphy->nan_capa.dev_capabilities =
-		NAN_DEV_CAPA_EXT_KEY_ID_SUPPORTED;
 
 	hw->wiphy->nan_capa.phy.ht = mld->nvm_data->nan_phy_capa.ht;
 	hw->wiphy->nan_capa.phy.vht = mld->nvm_data->nan_phy_capa.vht;
-- 
2.34.1


