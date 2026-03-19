Return-Path: <linux-wireless+bounces-33504-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICV5KEtFvGkJwQIAu9opvQ
	(envelope-from <linux-wireless+bounces-33504-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 19:49:47 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 636652D14EB
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 19:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2227D30451CE
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 18:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED53318EC4;
	Thu, 19 Mar 2026 18:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gRbLmitk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B212346798
	for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 18:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773946163; cv=none; b=iU1Yvs8L7DMlDPjlw6ykDcCe0CKOa0en+o1CrAniMqKrBFJIF+mzB1S4q7bOhHTNYz2R8jTqP9TdaUrKAci4qv8504ok/u32aB3tz3lBuk/V8KSvU2JLZJtrN4Mabg7g/pX3DWKmBqzLyo6UUHIenrujDrviR/jbywxFZeD4Lh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773946163; c=relaxed/simple;
	bh=OxvpRxQxKeYGEtkz/TaR1mchKeuuPJPbv+wC/tXSsQo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zn4B/qznEB6ZTBU3wmtV3MoeCUsUBlD30kryxYVzmqQSTHARANEIEZpCAHnqv0ckD136QQAaY5Bb+D3hFj5YHHI6AfRH+rYLXWncbtN8rIOoKU2ogpUUiIgVfFfY4IbHqW9hlLNd932auQtOM2qE2ep1D6zyX265IravBw9b9Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gRbLmitk; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773946163; x=1805482163;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OxvpRxQxKeYGEtkz/TaR1mchKeuuPJPbv+wC/tXSsQo=;
  b=gRbLmitkwG12wNfxBwxU3tTpBp0DThbB2xCDKlGTtccBIc2/jM/A020N
   JtY939gAVWbDwN8LUH3xJXpmOx21Qu6ebBNIHNkZ/0/LxU28z4NKQfqye
   zRwQ+CnFf+R14rb4vkf+MPjTJ42sofPsEDRJLGD05WK+LGxwr1sKMaR2R
   dB/kb7zXsV2MAompG0akXtJ39M/6YTX/ZRszjU7Tctc9VMbc1YLWLJ/PO
   VnzPLkoLhEl1vDcexHLLPrsnsUI68Bq9FTBqLPGQCZSrR7MLacst5TTKd
   6i2/ZIFX1uYRa8XvTrAz4F93JrVdBAVNyW1fx5DBsruKR1gMfmTCDoAGw
   Q==;
X-CSE-ConnectionGUID: nHV1O71aRRGUYy2b/Dyp8w==
X-CSE-MsgGUID: Cef5UUL3SrKaAhC/trG60Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="85656488"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="85656488"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 11:49:22 -0700
X-CSE-ConnectionGUID: RJ2FmEmNTGysAMlEeXP4tA==
X-CSE-MsgGUID: flNpQtrbSsafUo7fjMGN1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="227998548"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 11:49:21 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 10/15] wifi: iwlwifi: acpi: validate the WGDS table
Date: Thu, 19 Mar 2026 20:48:50 +0200
Message-Id: <20260319204647.a398511514ed.Ie4e62e2008f7e117ae7e305967ffadf1a30fc2b1@changeid>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-33504-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.998];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: 636652D14EB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

Prefer to use ARRAY_SIZE when we check array-length.
Make sure num_profile isn't bigger than the number of profiles we can
actually store in the firmware runtime object.
Same of the number of bands.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c | 38 ++++++++++++++------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index 721bd014bbaa..1c416d3f75ea 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -865,6 +865,18 @@ int iwl_acpi_get_wgds_table(struct iwl_fw_runtime *fwrt)
 			num_bands = rev_data[idx].bands;
 			num_profiles = rev_data[idx].profiles;
 
+			if (WARN_ON(num_profiles >
+				    ARRAY_SIZE(fwrt->geo_profiles))) {
+				ret = -EINVAL;
+				goto out_free;
+			}
+
+			if (WARN_ON(num_bands >
+				    ARRAY_SIZE(fwrt->geo_profiles[0].bands))) {
+				ret = -EINVAL;
+				goto out_free;
+			}
+
 			if (rev_data[idx].min_profiles) {
 				/* read header that says # of profiles */
 				union acpi_object *entry;
@@ -904,18 +916,20 @@ int iwl_acpi_get_wgds_table(struct iwl_fw_runtime *fwrt)
 
 read_table:
 	fwrt->geo_rev = tbl_rev;
+
 	for (i = 0; i < num_profiles; i++) {
-		for (j = 0; j < BIOS_GEO_MAX_NUM_BANDS; j++) {
+		struct iwl_geo_profile *prof = &fwrt->geo_profiles[i];
+
+		for (j = 0; j < ARRAY_SIZE(prof->bands); j++) {
 			union acpi_object *entry;
 
 			/*
-			 * num_bands is either 2 or 3, if it's only 2 then
-			 * fill the third band (6 GHz) with the values from
-			 * 5 GHz (second band)
+			 * num_bands is either 2 or 3 or 4, if it's lower
+			 * than 4, fill the third band (6 GHz) with the values
+			 * from 5 GHz (second band)
 			 */
 			if (j >= num_bands) {
-				fwrt->geo_profiles[i].bands[j].max =
-					fwrt->geo_profiles[i].bands[1].max;
+				prof->bands[j].max = prof->bands[1].max;
 			} else {
 				entry = &wifi_pkg->package.elements[entry_idx];
 				entry_idx++;
@@ -925,15 +939,17 @@ int iwl_acpi_get_wgds_table(struct iwl_fw_runtime *fwrt)
 					goto out_free;
 				}
 
-				fwrt->geo_profiles[i].bands[j].max =
+				prof->bands[j].max =
 					entry->integer.value;
 			}
 
-			for (k = 0; k < BIOS_GEO_NUM_CHAINS; k++) {
+			for (k = 0;
+			     k < ARRAY_SIZE(prof->bands[0].chains);
+			     k++) {
 				/* same here as above */
 				if (j >= num_bands) {
-					fwrt->geo_profiles[i].bands[j].chains[k] =
-						fwrt->geo_profiles[i].bands[1].chains[k];
+					prof->bands[j].chains[k] =
+						prof->bands[1].chains[k];
 				} else {
 					entry = &wifi_pkg->package.elements[entry_idx];
 					entry_idx++;
@@ -943,7 +959,7 @@ int iwl_acpi_get_wgds_table(struct iwl_fw_runtime *fwrt)
 						goto out_free;
 					}
 
-					fwrt->geo_profiles[i].bands[j].chains[k] =
+					prof->bands[j].chains[k] =
 						entry->integer.value;
 				}
 			}
-- 
2.34.1


