Return-Path: <linux-wireless+bounces-36256-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILyaBg4ZAmognwEAu9opvQ
	(envelope-from <linux-wireless+bounces-36256-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 19:59:42 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB40513F83
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 19:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4118131F020D
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 17:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C954508FF;
	Mon, 11 May 2026 17:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TavP+nsQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B476A466B52
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 17:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778521032; cv=none; b=Q9jJhkX6VdGArmcCRtMUsowvs8BOZH/z9W+Im2EEqewpeydsmeX8QF8aU112UmgNInQkmHkvNwFKGLPgHXJVLGNlyxIgmlQSc3w4sPyU00m6Di/wnguS/rZmR+80M4H46/RlHLx+rseMhwgSl1ARSiporg7sHT40sTSKtQN6UMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778521032; c=relaxed/simple;
	bh=QRrLvkLN+f0C4ox8cdFUS+7maYN7JT6zlWF+pDXSIJs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I2V6T5rqAQjKABQPq2p1JuBd7PD1XvPcQpHpxedXU3zNnNmrCu65nzZWYN1BRkcPVgvFRen5/zlmg0kdla32fBLFmiMgGbuZI2uZxEd1Dx5VCdZCqneJycwePZLCzaAqSrpekOR2sgr4+RSZ+ZsBTPFTEStJIvobVkbV7Tqd14U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TavP+nsQ; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778521032; x=1810057032;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QRrLvkLN+f0C4ox8cdFUS+7maYN7JT6zlWF+pDXSIJs=;
  b=TavP+nsQBuktqYDN29EPYEUKGk83IbCt3crAzjiTlYgc08znJJPHvRCD
   Jsa4DSzia83vzieMKFvOBz/RLM+62kJ+IqIHWPzOW42f3ztBM/z++SV/i
   MYqrbvCIzlYwtSB6Bgo9T3ZPO+7ufF4v82egUZTknByu9IpgfOAyEQYB0
   CgqXERplwywzgKERR3Oy909EtfJb5EPxS7z4/vLMQGKgm37BDRQMr94OV
   jF6AS5VBSBMJIrugmEJnJC2MD05W+hxqaZfZdmq8dwEvYfzK/dsuj71XC
   ycP7GGwM/ZG1gk0z5Yq8zU22E3QMQ/xUosj6QMaoUikepMbxSI06L85i4
   g==;
X-CSE-ConnectionGUID: ZXwBo4PXRw+C7dmpxD4HLg==
X-CSE-MsgGUID: rv2UpCucSUCdqklRYsJP3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="79314882"
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="79314882"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 10:37:11 -0700
X-CSE-ConnectionGUID: yhUhMA8rSkOKNPXMB+TfIw==
X-CSE-MsgGUID: sjup5qc1Qn+UVtuMxdY0cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="261005344"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 10:37:03 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Avinash Bhatt <avinash.bhatt@intel.com>
Subject: [PATCH iwlwifi-next 15/15] wifi: iwlwifi: fix buffer overflow when firmware reports no channels
Date: Mon, 11 May 2026 20:36:31 +0300
Message-Id: <20260511203428.e03cd831bc96.I8260d881eebe3e83d3208959b525c51af26414e6@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260511173631.1067831-1-miriam.rachel.korenblit@intel.com>
References: <20260511173631.1067831-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: ACB40513F83
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-36256-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Avinash Bhatt <avinash.bhatt@intel.com>

On parsing NVM in setting country code, if firmware reports 0 channels,
buffer is allocated for 0 rules but a dummy rule is added for cfg80211
compatibility, causing kmemdup() to read 128 bytes from a 32-byte buffer.

Allocate regd buffer for one rule addition when reported
channels are 0.

Signed-off-by: Avinash Bhatt <avinash.bhatt@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    | 21 ++++++++++---------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index 0736c8c00d4e..455d6e8c7028 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -1724,8 +1724,16 @@ iwl_parse_nvm_mcc_info(struct iwl_trans *trans,
 	IWL_DEBUG_DEV(dev, IWL_DL_LAR, "building regdom for %d channels\n",
 		      num_of_ch);
 
-	/* build a regdomain rule for every valid channel */
-	regd = kzalloc_flex(*regd, reg_rules, num_of_ch);
+	/* build a regdomain rule for every valid channel.
+	 * Certain firmware versions might report no valid channels
+	 * if booted in RF-kill, i.e. not all calibrations etc. are
+	 * running. We'll get out of this situation later when the
+	 * rfkill is removed and we update the regdomain again, but
+	 * since cfg80211 doesn't accept an empty regdomain, we need
+	 * to allocate space for at least one rule to add a dummy
+	 * (unusable) rule in this case so we can init.
+	 */
+	regd = kzalloc_flex(*regd, reg_rules, num_of_ch ?: 1);
 	if (!regd)
 		return ERR_PTR(-ENOMEM);
 
@@ -1799,14 +1807,7 @@ iwl_parse_nvm_mcc_info(struct iwl_trans *trans,
 		reg_query_regdb_wmm(regd->alpha2, center_freq, rule);
 	}
 
-	/*
-	 * Certain firmware versions might report no valid channels
-	 * if booted in RF-kill, i.e. not all calibrations etc. are
-	 * running. We'll get out of this situation later when the
-	 * rfkill is removed and we update the regdomain again, but
-	 * since cfg80211 doesn't accept an empty regdomain, add a
-	 * dummy (unusable) rule here in this case so we can init.
-	 */
+	/* If no valid rules were found, add a dummy rule */
 	if (!valid_rules) {
 		valid_rules = 1;
 		rule = &regd->reg_rules[valid_rules - 1];
-- 
2.34.1


