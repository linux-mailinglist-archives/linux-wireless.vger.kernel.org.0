Return-Path: <linux-wireless+bounces-23969-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3ACAD4971
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 05:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D04B16A427
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 03:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2BF225390;
	Wed, 11 Jun 2025 03:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dqmkM/m5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F542253FB
	for <linux-wireless@vger.kernel.org>; Wed, 11 Jun 2025 03:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749612888; cv=none; b=cr5ZtuMNVow78NfVQOvjLNgNEgehsKJh5XTdKeZ+RSHpHv+wTu4PKVGNrjm5TDPvq0MYpepHStZ7CH8TAen4T/L7U/E2bCC6pGAFeBAwu6TqepTtunlh/tNeIq5XcwrNVSxcJA3te54fPEFFBmQE51GaScVjHVj9k+GPWkRnqeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749612888; c=relaxed/simple;
	bh=Y880Dmewf2eHGLtigrHUTnUd1//A+PCGJaeDSkCvrwU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Eq4WkVXgx/dg4MednC0McNOurfHHSgg9icQUXpZ0tNH71mrmUMgB4lXMPoMjb3HGY1+FRc1U+EEQAo4FKhcKhHbJm2sNGoVoxYvao7O9ZJgVJcoi9Z+xo9LZOeSiq02ahtrNmlbeRqoAhjVaoOCQo79+KJVy7Ya5TDg1wC56KrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dqmkM/m5; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749612886; x=1781148886;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y880Dmewf2eHGLtigrHUTnUd1//A+PCGJaeDSkCvrwU=;
  b=dqmkM/m5tECMc/OvOaSSd58XJglixEvnsZ+A2b07xykZlerEDiD4jbdL
   vHsZnNF0w4aHbg2L665FfgrXhLOr9XMJ9HvNeZgRZEy8/Bz0eGQrzOGhC
   QG2EoYfuY/pFW525L9zJZSr6d76SMxsRUS7jSVZnP7ksVRwMJ+APnA350
   /geHA4KRwoiJtYAWZ3RhtEPANfOx9+dKKlERGkAxSm7VazlvJpPeXZ/yB
   dqDiZLBnmGsfs+ZST90WVs5vlLJB0X4GyYZie7T6B63E/z+t2ZBXtzJjF
   AZ5mWQStrslVGVPlK/njXLMzcW2MsMDbnhjuYEkoe2LF2IndEBcThpQec
   Q==;
X-CSE-ConnectionGUID: yrxpCbluTgqIDRD81aZ6+w==
X-CSE-MsgGUID: Hkn9iHFxS62q5OBWFWtmDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="63094896"
X-IronPort-AV: E=Sophos;i="6.16,226,1744095600"; 
   d="scan'208";a="63094896"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 20:34:46 -0700
X-CSE-ConnectionGUID: uVZHvZsyTMKGVFZCEq1KTQ==
X-CSE-MsgGUID: qH/iJbdZTLeiwHUwvb4gEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,226,1744095600"; 
   d="scan'208";a="150880972"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 20:34:45 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 12/15] wifi: iwlwifi: mei: fix kernel-doc warnings
Date: Wed, 11 Jun 2025 06:34:12 +0300
Message-Id: <20250611063124.82cc1d805bda.I21e7be2df56f20e1215dc35d94f3225708c5d74f@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250611033415.1175681-1-miriam.rachel.korenblit@intel.com>
References: <20250611033415.1175681-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Fix some warnings and fill in some TBDs while at it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mei/sap.h | 30 ++++++++++----------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mei/sap.h b/drivers/net/wireless/intel/iwlwifi/mei/sap.h
index 3b56637b9697..ba1f75f739c2 100644
--- a/drivers/net/wireless/intel/iwlwifi/mei/sap.h
+++ b/drivers/net/wireless/intel/iwlwifi/mei/sap.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * Copyright (C) 2021 - 2022 Intel Corporation
+ * Copyright (C) 2021 - 2022, 2025 Intel Corporation
  */
 
 #ifndef __sap_h__
@@ -340,12 +340,12 @@ enum iwl_sap_wifi_auth_type {
 };
 
 /**
- * enum iwl_sap_wifi_cipher_alg
- * @SAP_WIFI_CIPHER_ALG_NONE: TBD
- * @SAP_WIFI_CIPHER_ALG_TKIP: TBD
- * @SAP_WIFI_CIPHER_ALG_CCMP: TBD
- * @SAP_WIFI_CIPHER_ALG_GCMP: TBD
- * @SAP_WIFI_CIPHER_ALG_GCMP_256: TBD
+ * enum iwl_sap_wifi_cipher_alg - MEI WiFi cipher algorithm IDs
+ * @SAP_WIFI_CIPHER_ALG_NONE: No encryption
+ * @SAP_WIFI_CIPHER_ALG_TKIP: TKIPO
+ * @SAP_WIFI_CIPHER_ALG_CCMP: CCMP
+ * @SAP_WIFI_CIPHER_ALG_GCMP: GCMP-128
+ * @SAP_WIFI_CIPHER_ALG_GCMP_256: GCMP-256
  */
 enum iwl_sap_wifi_cipher_alg {
 	SAP_WIFI_CIPHER_ALG_NONE	= IWL_MEI_CIPHER_NONE,
@@ -601,7 +601,7 @@ enum iwl_sap_flex_filter_flags {
 };
 
 /**
- * struct iwl_sap_flex_filter -
+ * struct iwl_sap_flex_filter - filter configuration
  * @src_port: Source port in network format.
  * @dst_port: Destination port in network format.
  * @flags: Flags and protocol, see &enum iwl_sap_flex_filter_flags.
@@ -633,7 +633,7 @@ enum iwl_sap_ipv4_filter_flags {
 };
 
 /**
- * struct iwl_sap_ipv4_filter-
+ * struct iwl_sap_ipv4_filter - IPv4 filter configuration
  * @ipv4_addr: The IP address to filer.
  * @flags: See &enum iwl_sap_ipv4_filter_flags.
  */
@@ -643,7 +643,7 @@ struct iwl_sap_ipv4_filter {
 } __packed;
 
 /**
- * enum iwl_sap_ipv6_filter_flags -
+ * enum iwl_sap_ipv6_filter_flags - IPv6 filter flags
  * @SAP_IPV6_ADDR_FILTER_COPY: Pass packets to the host.
  * @SAP_IPV6_ADDR_FILTER_ENABLED: If false, the filter should be ignored.
  */
@@ -653,7 +653,7 @@ enum iwl_sap_ipv6_filter_flags {
 };
 
 /**
- * struct iwl_sap_ipv6_filter -
+ * struct iwl_sap_ipv6_filter - IPv6 filter configuration
  * @addr_lo24: Lowest 24 bits of the IPv6 address.
  * @flags: See &enum iwl_sap_ipv6_filter_flags.
  */
@@ -663,7 +663,7 @@ struct iwl_sap_ipv6_filter {
 } __packed;
 
 /**
- * enum iwl_sap_icmpv6_filter_flags -
+ * enum iwl_sap_icmpv6_filter_flags - ICMPv6 filter flags
  * @SAP_ICMPV6_FILTER_ENABLED: If false, the filter should be ignored.
  * @SAP_ICMPV6_FILTER_COPY: Pass packets to the host.
  */
@@ -673,8 +673,8 @@ enum iwl_sap_icmpv6_filter_flags {
 };
 
 /**
- * enum iwl_sap_vlan_filter_flags -
- * @SAP_VLAN_FILTER_VLAN_ID_MSK: TBD
+ * enum iwl_sap_vlan_filter_flags - VLAN filter flags
+ * @SAP_VLAN_FILTER_VLAN_ID_MSK: VLAN ID
  * @SAP_VLAN_FILTER_ENABLED: If false, the filter should be ignored.
  */
 enum iwl_sap_vlan_filter_flags {
@@ -751,7 +751,7 @@ struct iwl_sap_pldr_data {
 } __packed;
 
 /**
- * enum iwl_sap_pldr_status -
+ * enum iwl_sap_pldr_status - product reset status
  * @SAP_PLDR_STATUS_SUCCESS: PLDR started/ended successfully
  * @SAP_PLDR_STATUS_FAILURE: PLDR failed to start/end
  */
-- 
2.34.1


