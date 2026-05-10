Return-Path: <linux-wireless+bounces-36176-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4HJIAH7vAGqGOgEAu9opvQ
	(envelope-from <linux-wireless+bounces-36176-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 10 May 2026 22:50:06 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 737645065B1
	for <lists+linux-wireless@lfdr.de>; Sun, 10 May 2026 22:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6F8A43013026
	for <lists+linux-wireless@lfdr.de>; Sun, 10 May 2026 20:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1654433F58C;
	Sun, 10 May 2026 20:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W3Z3jtDp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37D633507C
	for <linux-wireless@vger.kernel.org>; Sun, 10 May 2026 20:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778446153; cv=none; b=SyYfBCaHxohjNTKdwuRkcpcuSC0o1kAliQx36xXiOE9D9OU+83tkKcz+1fFqqXtKI97IdJDVnzaQwBBmyRmPbe6vryW9lppPGFnqCLtKFxsPgMhhB9+lKsjcp67b48xsZ9lvrlyYTTHuUUJvbUeVcJ0Xz56G2TwECk1Na/FOzbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778446153; c=relaxed/simple;
	bh=7FUFODScREFExGIdy40kjUxN2o5F7kFC6qP3mGIkKYU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rieeD+sa4QB+vZrpiCA1bkhiNvnxyLWs/kjmZ0N4mEGX207eLMP5HFWaoxldeQTwqHMtLMks3ccEaEtBCFsJg71V2FAnru0oFgNV5lpJAuvd924akcgPIX5VDWnb12dDobYVMFkQhl/S2UKUbcrAhO6oz/f5qoP0rrVyUr72r2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W3Z3jtDp; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778446152; x=1809982152;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7FUFODScREFExGIdy40kjUxN2o5F7kFC6qP3mGIkKYU=;
  b=W3Z3jtDpTYUSZf9A/6JBaH7J5iVWgU+DHAG47zCd7w8U+hqrTsBskr51
   ZsdF6a+kqh9uGPofnnkvEcExKls9GOXYbaY/wvkb67KKNpQaU3o4muvWw
   V5qPQel5+PGrFo8HmEwrRqntXWZPGdtRGc53Vbq8MBzkZ7Ljbjz4x/oFH
   LpZOy9kPrOPfRNYj+Bmd1pqdxNb3zaVju8SeQRseCdwtw2Ysoc2aXjxdO
   +c1HFQpy/LHGx2D/YoGiTpKaGEC8Zd3+u5of86IO36rJQKnRTc4jnEQd4
   +d2EWXHEntFWdUyPgOEkPT/+3NzqXgA1gdfTL3/Na1/kXKTDx9tXt+XE2
   g==;
X-CSE-ConnectionGUID: YlkG1byBQci+0uoOtYFCYA==
X-CSE-MsgGUID: 1SoznF9kQUWyeFciVyMYWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11782"; a="81904762"
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="81904762"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 13:49:12 -0700
X-CSE-ConnectionGUID: FuAdzwFbQgKrnW0e2EbYcA==
X-CSE-MsgGUID: pp4Qfkw5SBq5E0banLX9dQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="239095083"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 13:49:11 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Israel Kozitz <israel.kozitz@intel.com>,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH v2 iwlwifi-next 14/15] wifi: iwlwifi: mld: fix NAN max channel switch time unit
Date: Sun, 10 May 2026 23:48:39 +0300
Message-Id: <20260510234534.cb3c05e5d334.I89d9f336aaf388c6e48769de5fe1e5db19295057@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260510204840.133723-1-miriam.rachel.korenblit@intel.com>
References: <20260510204840.133723-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 737645065B1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-36176-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
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

From: Israel Kozitz <israel.kozitz@intel.com>

The max_channel_switch_time in wiphy_nan_capa is in microseconds, but
the value was set to 4, which is only 4 microseconds instead of the
intended 4 milliseconds.

Fix by using 4 * USEC_PER_MSEC.

Signed-off-by: Israel Kozitz <israel.kozitz@intel.com>
Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/mac80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index cad10f011072..49c75d4ee9a6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -298,7 +298,7 @@ static void iwl_mld_hw_set_nan(struct iwl_mld *mld)
 		 NAN_DEV_CAPA_NUM_RX_ANT_MASK);
 
 	/* Maximal channel switch time is 4 msec */
-	hw->wiphy->nan_capa.max_channel_switch_time = 4;
+	hw->wiphy->nan_capa.max_channel_switch_time = 4 * USEC_PER_MSEC;
 
 	hw->wiphy->nan_capa.phy.ht = mld->nvm_data->nan_phy_capa.ht;
 	hw->wiphy->nan_capa.phy.vht = mld->nvm_data->nan_phy_capa.vht;
-- 
2.34.1


