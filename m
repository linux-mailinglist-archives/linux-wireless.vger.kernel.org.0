Return-Path: <linux-wireless+bounces-37034-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CyrG8pOF2r7AAgAu9opvQ
	(envelope-from <linux-wireless+bounces-37034-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 22:06:34 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D93D5E9E7C
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 22:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5D2043070570
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 20:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C723B6BE8;
	Wed, 27 May 2026 20:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DSDQJOEA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F763B47D2
	for <linux-wireless@vger.kernel.org>; Wed, 27 May 2026 20:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779912342; cv=none; b=AjsGp5iRV1sChAHRBLObgcrpoNYaxFkTlJjokgri8gS52d17RGvXygMyOA8b5DmKXmYJMeSyn6t7gWvzqGLlKBTvPzsVQDw3njYHeuocpSpRDFgY26PzLTOt1gLegB7tWAyztMVFJkb+seqgZcvmSiFclcyhFFslXQeHtvvueNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779912342; c=relaxed/simple;
	bh=PViT4ceGwb2y57UfZEyrHPidOf/w8Q661YSMoy9jjV4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sS4wjTw5RkDNqayH/mlahcVwqVS6F8A7EFN/VoQ3h+rsBG0aBG/TR70pJGmlOvp0W7LZcQEzpCPnLgFkVOdD/xpPt5CYHzjjsG5dGTl9d6AsvTznqt/a3VYGFJLyWw7jbGqNmnpCS0Gkvek9Mf03Tux3JLE/AtyMwkWy2c6iL8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DSDQJOEA; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779912341; x=1811448341;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PViT4ceGwb2y57UfZEyrHPidOf/w8Q661YSMoy9jjV4=;
  b=DSDQJOEANRXbXQo3b6y1IJSUMwutQpNg8qluvcXLWiyQf6eumpTmChnT
   AfCnIFSUDoFXJ6+L3g1zXheF+2sPbU6u/Bld8OunM8t/1XWNfBNwK+dPo
   Xow7vczKqRo+e+EvwtMvPC4AdJl1spLaATEcL99WW8mKjjFmJBkHsye7p
   9wucCnAoZwvnCVmjb9B78FtWVWDcQihpHJcqdC9uOh8eOWbWRBkFwRdKH
   D/+0SWbfv7feaqEPGSGBxyCBNyCv9PoebyOyuML9Gi8et7EVDYheTrngt
   SJRVYDKZY7qSJhLExBwYhYVWvuTDqwuLCyvZnxrehDRgvAOh/R7kan/RT
   w==;
X-CSE-ConnectionGUID: uwMHN9LRS2OfivsOlfrUqg==
X-CSE-MsgGUID: kEKs8pB2TeW9o8Bzn0h8LQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="80940873"
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; 
   d="scan'208";a="80940873"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 13:05:40 -0700
X-CSE-ConnectionGUID: qD66dy7YQ06EY7J8CRXWvA==
X-CSE-MsgGUID: h9Rc+ggIRcOVbMTwXD2T1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; 
   d="scan'208";a="247286971"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 13:05:38 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Israel Kozitz <israel.kozitz@intel.com>
Subject: [PATCH iwlwifi-next 09/15] wifi: iwlwifi: mld: support FW TLV for NAN max channel switch time
Date: Wed, 27 May 2026 23:05:06 +0300
Message-Id: <20260527230313.e8ae1a3adacd.I15b933407ca3974a65047b63b4f9b00bed3520fb@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260527200512.506707-1-miriam.rachel.korenblit@intel.com>
References: <20260527200512.506707-1-miriam.rachel.korenblit@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-37034-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1D93D5E9E7C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Israel Kozitz <israel.kozitz@intel.com>

Add a new FW TLV (IWL_UCODE_TLV_FW_NAN_MAX_CHAN_SWITCH_TIME) that
allows the firmware to specify the NAN maximum channel switch time
in microseconds.

When the TLV is present, use its value for the NAN device capability.
Otherwise, fall back to the default of 4 milliseconds.

Signed-off-by: Israel Kozitz <israel.kozitz@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/file.h      | 1 +
 drivers/net/wireless/intel/iwlwifi/fw/img.h       | 1 +
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c      | 6 ++++++
 drivers/net/wireless/intel/iwlwifi/mld/mac80211.c | 9 +++++++--
 4 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/file.h b/drivers/net/wireless/intel/iwlwifi/fw/file.h
index 197c88c25f72..a26ed82a8106 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/file.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/file.h
@@ -112,6 +112,7 @@ enum iwl_ucode_tlv_type {
 	IWL_UCODE_TLV_FW_NUM_LINKS		= IWL_UCODE_TLV_CONST_BASE + 1,
 	IWL_UCODE_TLV_FW_NUM_BEACONS		= IWL_UCODE_TLV_CONST_BASE + 2,
 	IWL_UCODE_TLV_FW_NUM_MCAST_KEY_ENTRIES	= IWL_UCODE_TLV_CONST_BASE + 3,
+	IWL_UCODE_TLV_FW_NAN_MAX_CHAN_SWITCH_TIME = IWL_UCODE_TLV_CONST_BASE + 4,
 
 	IWL_UCODE_TLV_TYPE_DEBUG_INFO		= IWL_UCODE_TLV_DEBUG_BASE + 0,
 	IWL_UCODE_TLV_TYPE_BUFFER_ALLOCATION	= IWL_UCODE_TLV_DEBUG_BASE + 1,
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/img.h b/drivers/net/wireless/intel/iwlwifi/fw/img.h
index 75b1344f6cbe..95b45a253641 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/img.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/img.h
@@ -54,6 +54,7 @@ struct iwl_ucode_capabilities {
 	u32 num_links;
 	u32 num_beacons;
 	u32 num_mcast_key_entries;
+	u16 nan_max_chan_switch_time;
 	DECLARE_BITMAP(_api, NUM_IWL_UCODE_TLV_API);
 	DECLARE_BITMAP(_capa, NUM_IWL_UCODE_TLV_CAPA);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index 488524529538..842586d4fc5c 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -1337,6 +1337,12 @@ static int iwl_parse_tlv_firmware(struct iwl_drv *drv,
 			capa->num_mcast_key_entries =
 				le32_to_cpup((const __le32 *)tlv_data);
 			break;
+		case IWL_UCODE_TLV_FW_NAN_MAX_CHAN_SWITCH_TIME:
+			if (tlv_len != sizeof(u32))
+				goto invalid_tlv_len;
+			capa->nan_max_chan_switch_time =
+				le32_to_cpup((const __le32 *)tlv_data);
+			break;
 		case IWL_UCODE_TLV_UMAC_DEBUG_ADDRS: {
 			const struct iwl_umac_debug_addrs *dbg_ptrs =
 				(const void *)tlv_data;
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index 92858b8f7395..56e0c19e0f81 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -291,8 +291,13 @@ static void iwl_mld_hw_set_nan(struct iwl_mld *mld)
 		  NAN_DEV_CAPA_NUM_RX_ANT_POS) &
 		 NAN_DEV_CAPA_NUM_RX_ANT_MASK);
 
-	/* Maximal channel switch time is 4 msec */
-	hw->wiphy->nan_capa.max_channel_switch_time = 4 * USEC_PER_MSEC;
+	/* Maximal channel switch time - use FW TLV value if available */
+	if (mld->fw->ucode_capa.nan_max_chan_switch_time)
+		hw->wiphy->nan_capa.max_channel_switch_time =
+			mld->fw->ucode_capa.nan_max_chan_switch_time;
+	else
+		hw->wiphy->nan_capa.max_channel_switch_time =
+			4 * USEC_PER_MSEC;
 
 	hw->wiphy->nan_capa.phy.ht = mld->nvm_data->nan_phy_capa.ht;
 	hw->wiphy->nan_capa.phy.vht = mld->nvm_data->nan_phy_capa.vht;
-- 
2.34.1


