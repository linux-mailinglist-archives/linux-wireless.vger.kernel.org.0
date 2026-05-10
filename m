Return-Path: <linux-wireless+bounces-36160-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFzYEUjRAGoMNAEAu9opvQ
	(envelope-from <linux-wireless+bounces-36160-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 10 May 2026 20:41:12 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B60B3505BE4
	for <lists+linux-wireless@lfdr.de>; Sun, 10 May 2026 20:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5EF6B301EB40
	for <lists+linux-wireless@lfdr.de>; Sun, 10 May 2026 18:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5CA3161BA;
	Sun, 10 May 2026 18:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OYfE5FUB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA7631619C
	for <linux-wireless@vger.kernel.org>; Sun, 10 May 2026 18:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778438412; cv=none; b=eT9YHK89a8ySuGYw5R3gBn2yMux71qODYeOtd4DXM4p5s+OpBkgehrrxAcex2u/9fAnDAjXNWnBc2KoKTlIvqnvgill1RDA/bqLqoXWo5IKgCoreMyf6j6GkGjCQXSVOkbUXTco2JmDedxcxfZ5UGaqeLE4I2utip7zLIgufyPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778438412; c=relaxed/simple;
	bh=VY9L3z3KgSwyXwiSLNvgGy+QV1I/w8saoHan9RnnGq0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hr33wDCLkVxJaxtnbOtjhJ7QmuSSjYx5KE/qnZ9lvvki7RT2gIqvLJQi59jWRszyMQr17ijNVac4CfkA+gg69BoN2BhGXoeVMKSNoyc88xq4QZSRjLh4qi5HZ9BLwiCsyrhqSKgOPzVX8flkhJB5uB7DSqp901XyGsAgSJAnaGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OYfE5FUB; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778438410; x=1809974410;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VY9L3z3KgSwyXwiSLNvgGy+QV1I/w8saoHan9RnnGq0=;
  b=OYfE5FUBFlnSlmBczkbyNDqhL81WGQQfoqjZIBNERFmlhiU7QW3V9FN1
   fL96RrRNcur3csJwVn28Pcuya7LhCk3esrL92H4f289CSCmdU86edSFg5
   VPFl4tVgDRUCrIQAXvUEmlHwqyluLTyS67s9u7IyS8WY9V50ztzKZwg2G
   IjkTYxPCXOQ70329Q5Nl0NOuxoBa6RwylP3LXkqvtWztFg41w/QyYKEtr
   EhEVQZkP8/CT5ApaGueb+YN2XheCL1cDWRdMpnFLJE34WK97ysT3X+cy0
   3U8cd2vIYxY/1cKT9V/OoqCK9Eye23ZQhy/ZFdjlCaFk0U/A0M3ILxThg
   g==;
X-CSE-ConnectionGUID: aiH+tEdAQOqN/fU1tO6DuA==
X-CSE-MsgGUID: BsWtKWMESBCibovhAuGMxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11782"; a="83208989"
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="83208989"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 11:40:10 -0700
X-CSE-ConnectionGUID: QJtO2YHLSj+c7MVBw+M+fw==
X-CSE-MsgGUID: PBBKnII0SzSChb/HNH4itg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="267626859"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 11:40:09 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 15/15] wifi: iwlwifi: mld: don't allow softAP with NAN
Date: Sun, 10 May 2026 21:39:38 +0300
Message-Id: <20260510213745.4b8241f41fdf.I3cd256f3075d6e93b1fd9afc905af0a6a633ed4b@changeid>
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
X-Rspamd-Queue-Id: B60B3505BE4
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
	TAGGED_FROM(0.00)[bounces-36160-lists,linux-wireless=lfdr.de];
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

SoftAP in concurrency with NAN is not supported. Update the interface
combinations accordingly.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/mld/mac80211.c   | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index 49c75d4ee9a6..1106ad651cfe 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -69,11 +69,6 @@ static const struct ieee80211_iface_limit iwl_mld_limits_nan[] = {
 		.max = 1,
 		.types = BIT(NL80211_IFTYPE_NAN),
 	},
-	/* Removed when two channels are permitted */
-	{
-		.max = 1,
-		.types = BIT(NL80211_IFTYPE_AP),
-	},
 };
 
 static const struct ieee80211_iface_combination
@@ -90,19 +85,13 @@ iwl_mld_iface_combinations[] = {
 		.limits = iwl_mld_limits_ap,
 		.n_limits = ARRAY_SIZE(iwl_mld_limits_ap),
 	},
-	/* NAN combinations follow, these exclude P2P */
+	/* NAN combination follow, this excludes P2P and AP */
 	{
 		.num_different_channels = 2,
 		.max_interfaces = 3,
 		.limits = iwl_mld_limits_nan,
-		.n_limits = ARRAY_SIZE(iwl_mld_limits_nan) - 1,
-	},
-	{
-		.num_different_channels = 1,
-		.max_interfaces = 4,
-		.limits = iwl_mld_limits_nan,
 		.n_limits = ARRAY_SIZE(iwl_mld_limits_nan),
-	}
+	},
 };
 
 static const u8 ext_capa_base[IWL_MLD_STA_EXT_CAPA_SIZE] = {
@@ -376,7 +365,7 @@ static void iwl_mac_hw_set_wiphy(struct iwl_mld *mld)
 	} else {
 		/* Do not include NAN combinations */
 		wiphy->n_iface_combinations =
-			ARRAY_SIZE(iwl_mld_iface_combinations) - 2;
+			ARRAY_SIZE(iwl_mld_iface_combinations) - 1;
 	}
 
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_VHT_IBSS);
-- 
2.34.1


