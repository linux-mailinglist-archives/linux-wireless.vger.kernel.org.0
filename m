Return-Path: <linux-wireless+bounces-3240-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8FA684BA8C
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 17:03:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A313DB244FC
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 16:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FEF0134CC2;
	Tue,  6 Feb 2024 16:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="biS8pUCr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36B1134CE2
	for <linux-wireless@vger.kernel.org>; Tue,  6 Feb 2024 16:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707235365; cv=none; b=iOmxoi9NMmjxV1Y3uXw/KzZfoxGt1dlDdjuRk0o6SBMz6Jv3ti1ZkaWMiCYziUt08zVVsWpEMfWb1qyI3qSVQrj1Tneb3Kl9vbCgBNhdmNEL6G6Bgo/fG6QzROgs8z69CzSsiZJzfnPdWaAn7wK9a87p4qJs3crzycqU0eEw/C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707235365; c=relaxed/simple;
	bh=fkU0LPKftaA7BihYZTIDQ6Vcd3L6sWgNc+unk7ZCQ0I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qmrge4dsZLcN/FXgade16TWewZio8rzEHXYb2sW3NdorhiMPxjZpTpn17VU+RDuLdBIWR5dIO/hRRyPGQ/BHyO0e0xlE62ylELqpeuC8f40hEngx7yU0zUWG+mJjcZcmgNW3mLokqYv53gc2RxEld/svtBoeQFdWM+cYGP25adc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=biS8pUCr; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707235364; x=1738771364;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fkU0LPKftaA7BihYZTIDQ6Vcd3L6sWgNc+unk7ZCQ0I=;
  b=biS8pUCr6yXRT72fEyguH1BWh5OzBfZF7aHUpsy55hTnxwxuDfRvpOqI
   y1UF11vQs2oCqQ5AdyloFdQkVeDqs1JMeWnTVOQwRwZmBOuSRc/nh3fyS
   bEHcap2wcqusy8VBKmm9PgfpuJ35Mtd3bMgEpKvbEjLsiGGUigMO9Jqcf
   7NYl0gmEY5wFwKR9OK3T/UHM9uYAnBZtU+/tpbg/URr+2GvtsJ8aoB1/O
   cT9BNcYCUp3g+n9ucnlD/n+LRitRiSZrReNcPlel4dY4Rfz1to/JpMbPZ
   lROvaInjSCZIuzSR9zgBCou2eBtSAUVWtul/L2O5cWJn6qulG3ZwN1WTa
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="23252445"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="23252445"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 08:02:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="1349850"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 08:02:42 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Shaul Triebitz <shaul.triebitz@intel.com>
Subject: [PATCH 09/11] wifi: iwlwifi: iwlmvm: handle unprotected deauth/disassoc in d3
Date: Tue,  6 Feb 2024 18:02:12 +0200
Message-Id: <20240206175739.fde438a22e3f.I3c8497520aaa95a22febff727b0ad08146965d47@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240206160214.3260547-1-miriam.rachel.korenblit@intel.com>
References: <20240206160214.3260547-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Shaul Triebitz <shaul.triebitz@intel.com>

In MFP, do not disconnect if an unprotected deauth
or disassoc was received during D3.
For that, need to configure wowlan with MFP (IS_11W_ASSOC).

Now, in case of an unprotected deauth/disassoc, the wakeup
reason returned by the firmware will be:
IWL_WAKEUP_BY_11W_UNPROTECTED_DEAUTH_OR_DISASSOC
(and not IWL_WOWLAN_WAKEUP_BY_DISCONNECTION_ON_DEAUTH
which will cause a disconnection).
Also, report this reason to cfg80211.

In another patch, the driver will send an SA query.

Signed-off-by: Shaul Triebitz <shaul.triebitz@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index e1c77276557d..26c01d740d0d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -925,6 +925,9 @@ iwl_mvm_get_wowlan_config(struct iwl_mvm *mvm,
 	wowlan_config_cmd->flags = ENABLE_L3_FILTERING |
 		ENABLE_NBNS_FILTERING | ENABLE_DHCP_FILTERING;
 
+	if (ap_sta->mfp)
+		wowlan_config_cmd->flags |= IS_11W_ASSOC;
+
 	if (iwl_fw_lookup_cmd_ver(mvm->fw, WOWLAN_CONFIGURATION, 0) < 6) {
 		/* Query the last used seqno and set it */
 		int ret = iwl_mvm_get_last_nonqos_seq(mvm, vif);
@@ -1511,6 +1514,9 @@ static void iwl_mvm_report_wakeup_reasons(struct iwl_mvm *mvm,
 	if (reasons & IWL_WOWLAN_WAKEUP_BY_REM_WAKE_WAKEUP_PACKET)
 		wakeup.tcp_match = true;
 
+	if (reasons & IWL_WAKEUP_BY_11W_UNPROTECTED_DEAUTH_OR_DISASSOC)
+		wakeup.unprot_deauth_disassoc = true;
+
 	if (status->wake_packet) {
 		int pktsize = status->wake_packet_bufsize;
 		int pktlen = status->wake_packet_length;
-- 
2.34.1


