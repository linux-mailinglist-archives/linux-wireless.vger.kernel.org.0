Return-Path: <linux-wireless+bounces-39046-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id W4dCHnkeVmq4zQAAu9opvQ
	(envelope-from <linux-wireless+bounces-39046-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 13:33:13 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26410753EDD
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 13:33:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=TJYjAVSr;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39046-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39046-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 55281302011A
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 11:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2070C351C25;
	Tue, 14 Jul 2026 11:33:10 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C61181334
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 11:33:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784028790; cv=none; b=pjMKClJ2LED5795Q+dbCTgvfQA/i2Cy4IJ+fKVfEKGwrEaIeqLqWxR4U1YA2FESDcHhPlJqc8RVxLpRAFMcezT/+Li5+9jVoMhdsiYjgnIqKFDV8xIlXlXjaOfjyVcS/oS4NDSPqBVUdsLEDgVs5+eNFVoBFx+h1elx2XA5Y9Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784028790; c=relaxed/simple;
	bh=my+qKsnNy4Haj0ddMtWhReKNx7JpYeiaftIBmkM2kHs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rDAwQ+VsiJCl2WNavqQYIvmEmQf4v4hyl5ew10S+2NvcDvKx7BwVdwkaGu2thDfzlJjREjuIwDJ+q/Bno8mCSig4m9VYWdpwLouj/hAj6m7/8j/ArhhmSYsxVXz50waNbIznURROjYOMYceK+4dhyYbPdj6z23bAMW66Efz9Mjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TJYjAVSr; arc=none smtp.client-ip=192.198.163.12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784028789; x=1815564789;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=my+qKsnNy4Haj0ddMtWhReKNx7JpYeiaftIBmkM2kHs=;
  b=TJYjAVSrXtCPQ1vhY8vcX8ZENpvRM9+RjXZB1mh7TaMGwLMWMOTeiBfM
   mKemFEIRbbgbwnw5s0umU7jnK+yZs3ORzvpWvyDg+0jH6otdjGPukLKuI
   yubSSlfhCgjaGyTY323g7QkWPfyeAVoyVk+u5EyrGo7Isb8cGuptix+Q1
   HgZOq1LyampNkS80NKh/qKJMMM1akoTI0KUpPupDK86P9XIHOaT49IJoD
   d0vu9cMGX2Bkr8VJwBxhItzMZUBy+xyhA5XQKDtY9zryuc5o4FZSK/02T
   arMGbfOUQ9XSVqE1yXnM4DQrE2iQaDHrFWRRQWZzw+lp7p6NLN5lKioxQ
   g==;
X-CSE-ConnectionGUID: nFsmDsg5TfKdc+lAPPdPZA==
X-CSE-MsgGUID: 8hLb3RSKTG+KSJzQk9/wEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11846"; a="88469576"
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="88469576"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 04:33:09 -0700
X-CSE-ConnectionGUID: 9V13RUhZRXW/E/gVY1wiSA==
X-CSE-MsgGUID: DMC7RT4BSWmXU2lR1lWA1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="255882910"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 04:33:07 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 04/15] wifi: iwlwifi: support TTL platform device ID
Date: Tue, 14 Jul 2026 14:32:30 +0300
Message-Id: <20260714143119.46183446954f.Icc260831e530c1c92c9be615a7077768b1b9ae30@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260714143119.a549b9499e3e.Id1a95bbbf92b5862862becaf57419bb9fe1385e5@changeid>
References: <20260714143119.a549b9499e3e.Id1a95bbbf92b5862862becaf57419bb9fe1385e5@changeid>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-39046-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:johannes.berg@intel.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:from_mime,intel.com:email,intel.com:dkim,changeid:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 26410753EDD

Add support for a new device ID that we will have on TTL (sc2).

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 7a7b10152e5a..a3e6c9e09a3b 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -548,6 +548,7 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct pci_device_id iwl_hw_card_ids[] = {
 	{IWL_PCI_DEVICE(0xD340, PCI_ANY_ID, iwl_sc_mac_cfg)},
 	{IWL_PCI_DEVICE(0x6E70, PCI_ANY_ID, iwl_sc_mac_cfg)},
 	{IWL_PCI_DEVICE(0xD240, PCI_ANY_ID, iwl_sc_mac_cfg)},
+	{IWL_PCI_DEVICE(0x9327, PCI_ANY_ID, iwl_sc_mac_cfg)},
 #endif /* CONFIG_IWLMVM || CONFIG_IWLMLD */
 
 	{0}
-- 
2.34.1


