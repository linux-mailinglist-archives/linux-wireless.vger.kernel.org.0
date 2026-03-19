Return-Path: <linux-wireless+bounces-33465-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gCRRD+7Bu2n1ngIAu9opvQ
	(envelope-from <linux-wireless+bounces-33465-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 10:29:18 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9312C8AB9
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 10:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6BD1D304C601
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 09:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B585E3B47D5;
	Thu, 19 Mar 2026 09:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kzKuC3OT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6675E3B2FFC
	for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 09:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773911386; cv=none; b=Y04zQpvtFA39YjtfjskMMEnhX/a4mp7GTNb5LsMF6irnWwrP+3n1qH8cLNAdp8y9W7lTEazI5D2vOOnGJIOYHEAxj1Z1UdeoGnWgtZghUAgQRwLiKC8rOoOxVUj15HnHeqIs8t2mgNMtUTLkb/UzEby7MaxGlOf3Ll05YAaZvqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773911386; c=relaxed/simple;
	bh=aNb8XFOjPZNLJv/njv+EGC094aXkCDPFJRips7NQgwE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cyv5HqC9DOikV4ZNgOb8XfsZL77/+cd8f53G4yd5LvMgoXOG9qbdCbrcMWCIG7B6NDQmjtYziidAYXrmGP1G117UVNr9fzpfqyLZ4t99uLlCmSrLDz6YIkSGxqT3xEbUONNGtRZShCfFHraYmghDABnKd7nOg7znhxzcOM28kxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kzKuC3OT; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773911384; x=1805447384;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aNb8XFOjPZNLJv/njv+EGC094aXkCDPFJRips7NQgwE=;
  b=kzKuC3OTCjw1X1bl6WG/F5qHx6kxL3tBr7D8wXYf3EX59FXVSKk2xQIy
   zOAD9kLXzsDoDTh2qchfKsGlYYP2FlK8Zn1hU0RDZg1Dvu49FDNyhGydB
   SSdk26QKw4ltrdJwdBRCcIm3XTZBOtg1h/60pWa+Ld3ooCzhPoNwEtfee
   5UmyUJJzXuY2n2As+eIS/2UXc+dJYidSMkGxbV7BPEOcvZMbYDxBD5sHW
   i/mRFnj8iRBjGlSdRtzkOj8LgEl83peZ/k0BLJPN5+jiOfHfcouzoiMJT
   flPgj/lLYpIiX3XURAJ0wZ2I4J2P5NH+4/GXxaTwhGQabxPGpmqLxFolQ
   w==;
X-CSE-ConnectionGUID: Avx5yBIcSnmbjvpzjuzjfw==
X-CSE-MsgGUID: P3XKJyQ0SRS4ArUuIsEfGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="73992701"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="73992701"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 02:09:43 -0700
X-CSE-ConnectionGUID: EHRdR0/8ReWbOFh3vFzzUQ==
X-CSE-MsgGUID: bFWi+JWASrG0F/zeuHRGSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="218387124"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 02:09:42 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH v2 iwlwifi-next 03/15] wifi: iwlwifi: uefi: decouple UEFI and firmware APIs
Date: Thu, 19 Mar 2026 11:09:15 +0200
Message-Id: <20260319110722.db39a64073db.I21486dedb7357570151437cb0211b697e0efb61d@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260319090927.1090112-1-miriam.rachel.korenblit@intel.com>
References: <20260319090927.1090112-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
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
	TAGGED_FROM(0.00)[bounces-33465-lists,linux-wireless=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: CA9312C8AB9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

The APIs in uefi.h are not firmware API files nor are they pure software
objects. They really reflect a specific layout we expect to see in the
UEFI tables.
Since the UEFI objects are encoded into the BIOS, we can't use the same
values for the declaration of the UEFI objects and for the pure software
object like iwl_sar_profile in the firmware runtime object.

Decouple the two types.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/uefi.h | 23 ++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.h b/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
index 99170a72c3f1..c6940a3c03ea 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
@@ -76,13 +76,24 @@ struct uefi_cnv_common_step_data {
 	u8 radio2;
 } __packed;
 
+#define UEFI_SAR_MAX_SUB_BANDS_NUM	11
+#define UEFI_SAR_MAX_CHAINS_PER_PROFILE	4
+
+/*
+ * struct uefi_sar_profile_chain - per-chain values of a SAR profile
+ * @subbands: the SAR value for each subband
+ */
+struct uefi_sar_profile_chain {
+	u8 subbands[UEFI_SAR_MAX_SUB_BANDS_NUM];
+};
+
 /*
  * struct uefi_sar_profile - a SAR profile as defined in UEFI
  *
  * @chains: a per-chain table of SAR values
  */
 struct uefi_sar_profile {
-	struct iwl_sar_profile_chain chains[BIOS_SAR_MAX_CHAINS_PER_PROFILE];
+	struct uefi_sar_profile_chain chains[UEFI_SAR_MAX_CHAINS_PER_PROFILE];
 } __packed;
 
 /*
@@ -125,6 +136,14 @@ struct uefi_cnv_var_wgds {
 	struct iwl_geo_profile geo_profiles[BIOS_GEO_MAX_PROFILE_NUM];
 } __packed;
 
+/*
+ * struct uefi_ppag_chain - PPAG table for a specific chain
+ * @subbands: the PPAG values for band
+ */
+struct uefi_ppag_chain {
+	s8 subbands[UEFI_SAR_MAX_SUB_BANDS_NUM];
+};
+
 /*
  * struct uefi_cnv_var_ppag - PPAG table as defined in UEFI
  * @revision: the revision of the table
@@ -134,7 +153,7 @@ struct uefi_cnv_var_wgds {
 struct uefi_cnv_var_ppag {
 	u8 revision;
 	u32 ppag_modes;
-	struct iwl_ppag_chain ppag_chains[IWL_NUM_CHAIN_LIMITS];
+	struct uefi_ppag_chain ppag_chains[IWL_NUM_CHAIN_LIMITS];
 } __packed;
 
 /* struct uefi_cnv_var_wtas - WTAS tabled as defined in UEFI
-- 
2.34.1


