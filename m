Return-Path: <linux-wireless+bounces-33507-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KEZoBoZFvGlTwQIAu9opvQ
	(envelope-from <linux-wireless+bounces-33507-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 19:50:46 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 161DA2D1559
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 19:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0A9783024858
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 18:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7393134D4D8;
	Thu, 19 Mar 2026 18:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="esogXCSN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C71E34CFA8
	for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 18:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773946168; cv=none; b=SUj6bcEH11gvr3G/Y7EEQ78k4pFdSFie38XcXdi0bc6aXmWmUsHDCqdI0j7TikmlBDT5nx/flkkr1Dn3iDF5t24OolvWJFRik3jcs8D9767SQFnsqLMMDyZAo66BQx9DPcGJHJKWqfyu1q4VzaluwNryg8tHIa23giFi3GKAxBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773946168; c=relaxed/simple;
	bh=XlxiunsHFppOpVFzw6WZfEd+W5WWveEp6aL9yEaslTQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YQlR8XWKtHbLWb2Y4HltJeaR6vC3WN+quWXhJkVxpb5Ahjc5LdyteeIY80oZpb/TsRgsBPA/zvNpMgWY2S1Jx5llxaRRa5G6eoOuLvqeBNV4st9GighNoalq0PFr3M63zvCr4hJ9uYza3vnaRkDPDadJcyS7aQCJmUISVxm8JU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=esogXCSN; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773946167; x=1805482167;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XlxiunsHFppOpVFzw6WZfEd+W5WWveEp6aL9yEaslTQ=;
  b=esogXCSNcQ6+iSjSwqy0U4H3y0yIGV5WOPs1SRt5geWVOD78sSj9uXQ3
   Rq/F+NQUR2CGM9xBwyC6SP2GLEIn2J3ogJ68SBPxAd6/9oK/hA3QzEtjs
   jIsven46nxylc4VO9nURjiH7Ge0sCORNQsxldMDYNjYvucJVoSvf5DwDt
   jShqd9YEFxRg17vEDjIQRCNW+hoIP2MGjxEiFZEU/suWyF3yvi4/EXVNp
   iijUmlOc2kYmesNxAq/fVuOgGvlbX+zBb+DEzU3SJXTVW2fQdZg5D1KU3
   iCEncwG6h4Rh/2RPh86bWXBwiA8JCqTRaIRZW14Zmde11yJJOfiADXEV9
   w==;
X-CSE-ConnectionGUID: IOYcwBVnRBC1OJdJrfMjxQ==
X-CSE-MsgGUID: CQEHO9sjQkaVLuepvG/6lQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="85656493"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="85656493"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 11:49:27 -0700
X-CSE-ConnectionGUID: PwYCytY6SJaXgVFv6oO9ig==
X-CSE-MsgGUID: 75UiFxJNSbuHaXzyQUfrBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="227998586"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 11:49:26 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 13/15] wifi: iwlwifi: uefi: mode the comments valid kerneldoc comments
Date: Thu, 19 Mar 2026 20:48:53 +0200
Message-Id: <20260319204647.e9ad48c2cf4a.I867e3eb9581ac2a87772fd2534502c008543bafb@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260319184855.1981384-1-miriam.rachel.korenblit@intel.com>
References: <20260319184855.1981384-1-miriam.rachel.korenblit@intel.com>
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
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-33507-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.998];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 161DA2D1559
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

This will allow to get warnings if we make mistakes while documenting
the uefi structures

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/uefi.h | 27 ++++++++++++--------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.h b/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
index 0d3dac65178c..474f06db4d43 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
@@ -83,7 +83,7 @@ struct uefi_cnv_common_step_data {
 #define UEFI_GEO_NUM_BANDS_REV3		3
 #define UEFI_GEO_NUM_BANDS_REV4		4
 
-/*
+/**
  * struct uefi_cnv_var_wrds - WRDS table as defined in UEFI
  *
  * @revision: the revision of the table
@@ -117,7 +117,7 @@ struct uefi_cnv_var_wrds {
 	(offsetof(struct uefi_cnv_var_wrds, vals) +	\
 	 UEFI_SAR_PROFILE_SIZE_REV3)
 
-/*
+/**
  * struct uefi_cnv_var_ewrd - EWRD table as defined in UEFI
  * @revision: the revision of the table
  * @mode: is WRDS enbaled/disabled
@@ -142,7 +142,7 @@ struct uefi_cnv_var_ewrd {
 	(offsetof(struct uefi_cnv_var_ewrd, vals) +		\
 	 UEFI_SAR_PROFILE_SIZE_REV3 * (BIOS_SAR_MAX_PROFILE_NUM - 1))
 
-/*
+/**
  * struct uefi_cnv_var_wgds - WGDS table as defined in UEFI
  * @revision: the revision of the table
  * @num_profiles: the number of geo profiles we have in the table.
@@ -174,7 +174,7 @@ struct uefi_cnv_var_wgds {
 	(offsetof(struct uefi_cnv_var_wgds, vals) +		\
 	 UEFI_WGDS_PROFILE_SIZE_REV4 * BIOS_GEO_MAX_PROFILE_NUM)
 
-/*
+/**
  * struct uefi_cnv_var_ppag - PPAG table as defined in UEFI
  * @revision: the revision of the table
  * @ppag_modes: values from &enum iwl_ppag_flags
@@ -198,7 +198,8 @@ struct uefi_cnv_var_ppag {
 	(offsetof(struct uefi_cnv_var_ppag, vals) +	\
 	sizeof(s8) * UEFI_PPAG_NUM_CHAINS * UEFI_PPAG_SUB_BANDS_NUM_REV5)
 
-/* struct uefi_cnv_var_wtas - WTAS tabled as defined in UEFI
+/**
+ * struct uefi_cnv_var_wtas - WTAS tabled as defined in UEFI
  * @revision: the revision of the table
  * @tas_selection: different options of TAS enablement.
  * @black_list_size: the number of defined entried in the black list
@@ -211,7 +212,8 @@ struct uefi_cnv_var_wtas {
 	u16 black_list[IWL_WTAS_BLACK_LIST_MAX];
 } __packed;
 
-/* struct uefi_cnv_var_splc - SPLC tabled as defined in UEFI
+/**
+ * struct uefi_cnv_var_splc - SPLC tabled as defined in UEFI
  * @revision: the revision of the table
  * @default_pwr_limit: The default maximum power per device
  */
@@ -220,7 +222,8 @@ struct uefi_cnv_var_splc {
 	u32 default_pwr_limit;
 } __packed;
 
-/* struct uefi_cnv_var_wrdd - WRDD table as defined in UEFI
+/**
+ * struct uefi_cnv_var_wrdd - WRDD table as defined in UEFI
  * @revision: the revision of the table
  * @mcc: country identifier as defined in ISO/IEC 3166-1 Alpha 2 code
  */
@@ -229,7 +232,8 @@ struct uefi_cnv_var_wrdd {
 	u32 mcc;
 } __packed;
 
-/* struct uefi_cnv_var_eckv - ECKV table as defined in UEFI
+/**
+ * struct uefi_cnv_var_eckv - ECKV table as defined in UEFI
  * @revision: the revision of the table
  * @ext_clock_valid: indicates if external 32KHz clock is valid
  */
@@ -240,7 +244,8 @@ struct uefi_cnv_var_eckv {
 
 #define UEFI_MAX_DSM_FUNCS 32
 
-/* struct uefi_cnv_var_general_cfg - DSM-like table as defined in UEFI
+/**
+ * struct uefi_cnv_var_general_cfg - DSM-like table as defined in UEFI
  * @revision: the revision of the table
  * @functions: payload of the different DSM functions
  */
@@ -250,7 +255,9 @@ struct uefi_cnv_var_general_cfg {
 } __packed;
 
 #define IWL_UEFI_WBEM_REV0_MASK (BIT(0) | BIT(1))
-/* struct uefi_cnv_wlan_wbem_data - Bandwidth enablement per MCC as defined
+
+/**
+ * struct uefi_cnv_wlan_wbem_data - Bandwidth enablement per MCC as defined
  *	in UEFI
  * @revision: the revision of the table
  * @wbem_320mhz_per_mcc: enablement of 320MHz bandwidth per MCC
-- 
2.34.1


