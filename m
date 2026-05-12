Return-Path: <linux-wireless+bounces-36302-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNc6JIG7AmonwAEAu9opvQ
	(envelope-from <linux-wireless+bounces-36302-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 07:32:49 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9764251A1CA
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 07:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B9B393011576
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 05:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0AE43815DB;
	Tue, 12 May 2026 05:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QI49tNYL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49687382374
	for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 05:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778563415; cv=none; b=uK1i9SibiXWrO8gfU/xpsFBiFxewTp5SA5iOcErhpZGI/RN8IiPizPAoZYds64GuQAan+CuW35GEEBHAkbbjfdAZgaAuOMt0JjeItw/U8PDUKveCq4CKQpIn2mr4XRZtOZdLOggFmVkmAnx9vqo9zPyhUEWiBGU/7Zc8zInDmpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778563415; c=relaxed/simple;
	bh=9/60VmiVfGmaGA6lsp2b73pD3/n6MVrRjCTu+7jQKl0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BXNbg2IJnNPugWh5tpQVWwZNN/okRqxpYy5PlMBcGtd97/aJlk70QJ2ak75FioKQZZIgdAXpBbiBrRAYaQNZNmmkQhVgGRL6OMM5Ubyiqp+tVjDgbzpk/07DBE9sJP5fUAOnYpWBhlxb7fIYwlT+bB0dt7b05+u/6WrN7s5/7e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QI49tNYL; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778563414; x=1810099414;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9/60VmiVfGmaGA6lsp2b73pD3/n6MVrRjCTu+7jQKl0=;
  b=QI49tNYLZo1ZfoD1Ojm9fUQG9FJI/jnMQlZgueKirY0vpPdS4N9FcHhD
   QF5UcwxCsyMSQrXcs6Vwmnb2iYshMnmGwhGZ5dOAkmMIsGqzLAofezke0
   iXdMTqhITkCRtOmzPpNeSeiVcED/wacsMeQIP/qNisyrIxRpzoHjHUpyC
   m8n9E0sydJoSDBI/U7isurQND9Pl+ksa8N0bGn0zDnUSMoj7CjNf8jL7P
   gO3giJtC3JSeGzmQRPdM4KYBbBdwrFhlLl3wg86cq08555O70pUcd3+Ko
   1GWZROSwQDV4iAW+gxbzcEpzmWUk+u/wY9inYdQvYuqTbrmaHuFf7dXQW
   g==;
X-CSE-ConnectionGUID: 0hhOXuYASEW0O1VH+ZRnJw==
X-CSE-MsgGUID: i0X4xJioRHGA2ejHgiuWJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="78495100"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="78495100"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 22:23:34 -0700
X-CSE-ConnectionGUID: RH4uvhliTS2HCyFNF+gWkQ==
X-CSE-MsgGUID: XNjXji6aQjafh8Eh/eRodw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="233187580"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 22:23:33 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 11/15] wifi: iwlwifi: stop supporting cores 97 to 100
Date: Tue, 12 May 2026 08:23:03 +0300
Message-Id: <20260512082114.3dc9251c69ef.Icc027dc533f06ac007abfa0356774948ffdfaf3d@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260512052307.1603442-1-miriam.rachel.korenblit@intel.com>
References: <20260512052307.1603442-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9764251A1CA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-36302-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email,intel.com:dkim]
X-Rspamd-Action: no action

Remove support from cores 97 to 100, including.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c | 6 +++---
 drivers/net/wireless/intel/iwlwifi/cfg/dr.c | 6 +++---
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c | 6 +++---
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
index 8b3f15899396..c060b12cc952 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
@@ -12,8 +12,8 @@
 /* Highest firmware core release supported */
 #define IWL_BZ_UCODE_CORE_MAX	103
 
-/* Lowest firmware API version supported */
-#define IWL_BZ_UCODE_API_MIN	100
+/* Lowest firmware core release supported */
+#define IWL_BZ_UCODE_CORE_MIN	101
 
 /* Memory offsets and lengths */
 #define IWL_BZ_SMEM_OFFSET		0x400000
@@ -69,7 +69,7 @@ static const struct iwl_family_base_params iwl_bz_base = {
 	},
 	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,
 	.ucode_api_max = ENCODE_CORE_AS_API(IWL_BZ_UCODE_CORE_MAX),
-	.ucode_api_min = IWL_BZ_UCODE_API_MIN,
+	.ucode_api_min = ENCODE_CORE_AS_API(IWL_BZ_UCODE_CORE_MIN),
 };
 
 const struct iwl_mac_cfg iwl_bz_mac_cfg = {
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/dr.c b/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
index a8f2ac688d31..3ccbb21276c1 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
@@ -11,8 +11,8 @@
 /* Highest firmware core release supported */
 #define IWL_DR_UCODE_CORE_MAX	103
 
-/* Lowest firmware API version supported */
-#define IWL_DR_UCODE_API_MIN	100
+/* Lowest firmware core release supported */
+#define IWL_DR_UCODE_CORE_MIN	101
 
 /* Memory offsets and lengths */
 #define IWL_DR_SMEM_OFFSET		0x400000
@@ -70,7 +70,7 @@ static const struct iwl_family_base_params iwl_dr_base = {
 	},
 	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,
 	.ucode_api_max = ENCODE_CORE_AS_API(IWL_DR_UCODE_CORE_MAX),
-	.ucode_api_min = IWL_DR_UCODE_API_MIN,
+	.ucode_api_min = ENCODE_CORE_AS_API(IWL_DR_UCODE_CORE_MIN),
 };
 
 const struct iwl_mac_cfg iwl_dr_mac_cfg = {
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
index 4532d31d5f8b..04c726e8c283 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
@@ -12,8 +12,8 @@
 /* Highest firmware core release supported */
 #define IWL_SC_UCODE_CORE_MAX	103
 
-/* Lowest firmware API version supported */
-#define IWL_SC_UCODE_API_MIN	100
+/* Lowest firmware core release supported */
+#define IWL_SC_UCODE_CORE_MIN	101
 
 /* Memory offsets and lengths */
 #define IWL_SC_SMEM_OFFSET		0x400000
@@ -75,7 +75,7 @@ static const struct iwl_family_base_params iwl_sc_base = {
 	},
 	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,
 	.ucode_api_max = ENCODE_CORE_AS_API(IWL_SC_UCODE_CORE_MAX),
-	.ucode_api_min = IWL_SC_UCODE_API_MIN,
+	.ucode_api_min = ENCODE_CORE_AS_API(IWL_SC_UCODE_CORE_MIN),
 };
 
 const struct iwl_mac_cfg iwl_sc_mac_cfg = {
-- 
2.34.1


