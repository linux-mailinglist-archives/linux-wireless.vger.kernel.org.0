Return-Path: <linux-wireless+bounces-33642-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WAGHBhPWvmlwewMAu9opvQ
	(envelope-from <linux-wireless+bounces-33642-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 18:32:03 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AD88D2E68E5
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 18:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 72387303BB19
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 17:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E80C317171;
	Sat, 21 Mar 2026 17:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NYldh4jx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB77533B951
	for <linux-wireless@vger.kernel.org>; Sat, 21 Mar 2026 17:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774114194; cv=none; b=NLxT2sr9dH3edfiRs9dCXuQwFLEw6KHHQvPPllOZMkF27QKoMfVqqAsMRQY6MZ4Rks7JtaxPqptrfCIsotobdOIeIZXVU2BnVJXXnqFEyoD0UzUjjqJXFQHg3yzyzy1SsHOHofH5gDbKBcy4Op8Y/QkL0QeavSyGwfQwC5KWxeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774114194; c=relaxed/simple;
	bh=ba9+R/qRiB2GuXbHDegzFAoysUsOMOyde8RQAToynK4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y0M23J7/wjxQNodQj99SA92CZhMAlMq8xvAnA5tv8qaZlQiRW7bC5Fbllok2U+CGUL1QeCDSA1Q9GbHYGPtFrkupBZfOvnPQx9XeADXR1nlxNrRsdpbEMsVlSVF8+Ipc4Zsknzvoel1KA2veyY8E/MVUM6pNuZaUd32Fz0xWn/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NYldh4jx; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774114192; x=1805650192;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ba9+R/qRiB2GuXbHDegzFAoysUsOMOyde8RQAToynK4=;
  b=NYldh4jxpCQLVehQTjsKfEWsO90RE7LaAY2gcGvph5X3KhgJAMzuPY7t
   YKWFjXkCQGCqG6idBLf45oPhe+wtnnb0UoX1gI3R08w7JLQjvjUMqeYGt
   +r40o28E8BEgqZlhGE+E5KwwqTEBRYTpYPcFBzFKmsIlGiqxGHi3S7CzY
   ubJx4H6dhJIYZ2Zv6WiOuT+SElrAG+ZFDthbpg7LLktgVEUKzumc1CZEw
   KA04eOhvtnAGnqd1nVZS/tnOhOgBOaaYKYBPkJfBuFfo+snd/NZ6n3Qjn
   rZD2yrgEZxr4qzNr/mDiBAKc+9ZZ7SWygfmPFuLsIY0l8+jtoS09TenoZ
   Q==;
X-CSE-ConnectionGUID: idXnbHZ2RAaH7U9U5I0YkA==
X-CSE-MsgGUID: UEWea4CIS+Gcz6A7lDaEbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11736"; a="75244599"
X-IronPort-AV: E=Sophos;i="6.23,133,1770624000"; 
   d="scan'208";a="75244599"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2026 10:29:52 -0700
X-CSE-ConnectionGUID: 0ixCsP0JRyiOPFiobMcwbg==
X-CSE-MsgGUID: hcZR3euaRhCAYvhQXzziyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,133,1770624000"; 
   d="scan'208";a="223813618"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2026 10:29:51 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 15/15] wifi: iwlwifi: mld: set RX_FLAG_RADIOTAP_TLV_AT_END generically
Date: Sat, 21 Mar 2026 19:29:22 +0200
Message-Id: <20260321192637.31eff369ccf2.If5cee8f7c767b937891abb6cccf2692068ba7758@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260321172922.3938740-1-miriam.rachel.korenblit@intel.com>
References: <20260321172922.3938740-1-miriam.rachel.korenblit@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-33642-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: AD88D2E68E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Johannes Berg <johannes.berg@intel.com>

Instead of setting this flag in the iwl_mld_radiotap_put_tlv()
users, and not even all of them, set it inside the function.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/rx.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/rx.c b/drivers/net/wireless/intel/iwlwifi/mld/rx.c
index 6f40d6e47083..a2e586c6ea67 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/rx.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2024-2025 Intel Corporation
+ * Copyright (C) 2024-2026 Intel Corporation
  */
 
 #include <net/mac80211.h>
@@ -791,6 +791,9 @@ static void *
 iwl_mld_radiotap_put_tlv(struct sk_buff *skb, u16 type, u16 len)
 {
 	struct ieee80211_radiotap_tlv *tlv;
+	struct ieee80211_rx_status *rx_status = IEEE80211_SKB_RXCB(skb);
+
+	rx_status->flag |= RX_FLAG_RADIOTAP_TLV_AT_END;
 
 	tlv = skb_put(skb, sizeof(*tlv));
 	tlv->type = cpu_to_le16(type);
@@ -1234,8 +1237,6 @@ static void iwl_mld_rx_eht(struct iwl_mld *mld, struct sk_buff *skb,
 
 	eht = iwl_mld_radiotap_put_tlv(skb, IEEE80211_RADIOTAP_EHT, eht_len);
 
-	rx_status->flag |= RX_FLAG_RADIOTAP_TLV_AT_END;
-
 	switch (u32_get_bits(rate_n_flags, RATE_MCS_HE_GI_LTF_MSK)) {
 	case 0:
 		if (he_type == RATE_MCS_HE_TYPE_TRIG) {
@@ -1329,7 +1330,6 @@ static void iwl_mld_rx_eht(struct iwl_mld *mld, struct sk_buff *skb,
 static void iwl_mld_add_rtap_sniffer_config(struct iwl_mld *mld,
 					    struct sk_buff *skb)
 {
-	struct ieee80211_rx_status *rx_status = IEEE80211_SKB_RXCB(skb);
 	struct ieee80211_radiotap_vendor_content *radiotap;
 	const u16 vendor_data_len = sizeof(mld->monitor.cur_aid);
 
@@ -1353,8 +1353,6 @@ static void iwl_mld_add_rtap_sniffer_config(struct iwl_mld *mld,
 	/* fill the data now */
 	memcpy(radiotap->data, &mld->monitor.cur_aid,
 	       sizeof(mld->monitor.cur_aid));
-
-	rx_status->flag |= RX_FLAG_RADIOTAP_TLV_AT_END;
 }
 #endif
 
@@ -1362,7 +1360,6 @@ static void iwl_mld_add_rtap_sniffer_phy_data(struct iwl_mld *mld,
 					      struct sk_buff *skb,
 					      struct iwl_rx_phy_air_sniffer_ntfy *ntfy)
 {
-	struct ieee80211_rx_status *rx_status = IEEE80211_SKB_RXCB(skb);
 	struct ieee80211_radiotap_vendor_content *radiotap;
 	const u16 vendor_data_len = sizeof(*ntfy);
 
@@ -1382,8 +1379,6 @@ static void iwl_mld_add_rtap_sniffer_phy_data(struct iwl_mld *mld,
 
 	/* fill the data now */
 	memcpy(radiotap->data, ntfy, vendor_data_len);
-
-	rx_status->flag |= RX_FLAG_RADIOTAP_TLV_AT_END;
 }
 
 static void
-- 
2.34.1


