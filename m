Return-Path: <linux-wireless+bounces-36343-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDpWDvODA2oJ6wEAu9opvQ
	(envelope-from <linux-wireless+bounces-36343-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 21:48:03 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B51528CE3
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 21:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6202D3044631
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 19:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D0B2E542C;
	Tue, 12 May 2026 19:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jYQBqRl+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593B63EDE47
	for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 19:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778615279; cv=none; b=kCgssZqZFV3uPivkoeXgsChjROtnGJqTpYWmXtvsr2i8bDsJAEahNm0iG/A/UdXaIb3TVOl+Uu0yavj+hiOIihMAnCnzP2iidUQbeHVVmsFYRHkGXxWm/92nzJ8dPaAmxIIWr9DKRDsYVLOlDD/wrQMSq3oXpBXi6wWebGQc5wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778615279; c=relaxed/simple;
	bh=FmAiB1jh1zpZtwFCFAPVQZMe3qgaeEw+eIVY4H19Vj0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=saOaD/GO+SqF0sUkeWZARaczAzSZDlYgs74mjd8GX/RuEPOphu6D4q/eqTfHVupBafhcI5C2s7lrpmDNLrP8o896vL4Gr5yqyB5PQJU6dGMrszD94hhjfXEka4CfJqpC2oQ4soV006glNXAftaBBH7ZD3lIDmPOqb9MDcp5UvLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jYQBqRl+; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778615278; x=1810151278;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FmAiB1jh1zpZtwFCFAPVQZMe3qgaeEw+eIVY4H19Vj0=;
  b=jYQBqRl+xqYQmfDLgb2i2XQKIeuf9W2/MFA6sJVYCiep/mbPAxU3IniC
   6bwrZV/jw6dA8pZlx9yJk6TQDj1CwkXsXXS7fUfve0ist96X4B3QzwYv5
   kPhrmk3QmnLU/kDFu/uHyKJXkDKpi5aMW1pQGHAIyl8rT2jDB9EA4FpBU
   BW5utMHSXkHNaVCacWV6GnqQq8S++vKauWo9n1YlhPt+ILWjubaUl0T84
   LbRTI6KrxbiuatkARSIUSMh85oJ9x4nuf0MCO3Ru2PBJcS+bgKbVrZC5g
   F1VT3jiJtV4HkDVC5aUhEIcoqOrDmLjjMUen1eXsIDFiUB/lkev1e4Wp/
   g==;
X-CSE-ConnectionGUID: ogLdE9rkQ1CQbazMZv9Y2Q==
X-CSE-MsgGUID: PQJgdvMaQN+RF80fGf3GdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="97106361"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="97106361"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 12:47:57 -0700
X-CSE-ConnectionGUID: aC1jLgadSL2YhfwWtuIrYg==
X-CSE-MsgGUID: x4SQEoC+S56uGFkASOOuVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="237787877"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 12:47:57 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next] wifi: mac80211_hwsim: advertise NPCA capability
Date: Tue, 12 May 2026 22:47:42 +0300
Message-Id: <20260512224724.abfd51f480b7.I2024d7fc8067a0fca26234f312937cc764b660f4@changeid>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 58B51528CE3
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-36343-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Johannes Berg <johannes.berg@intel.com>

This doesn't really do anything, but we can advertise it and then
check that the AP can be configured and client can connect, etc.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/virtual/mac80211_hwsim_main.c    | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim_main.c b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
index dc9775cd9f54..67867c0fcc24 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim_main.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
@@ -4554,6 +4554,9 @@ static const struct ieee80211_sband_iftype_data sband_capa_2ghz[] = {
 		},
 		.uhr_cap = {
 			.has_uhr = true,
+			.mac.mac_cap = {
+				[0] = IEEE80211_UHR_MAC_CAP0_NPCA_SUPP,
+			},
 			.phy.cap = IEEE80211_UHR_PHY_CAP_ELR_RX |
 				   IEEE80211_UHR_PHY_CAP_ELR_TX,
 		},
@@ -4667,6 +4670,9 @@ static const struct ieee80211_sband_iftype_data sband_capa_2ghz[] = {
 		},
 		.uhr_cap = {
 			.has_uhr = true,
+			.mac.mac_cap = {
+				[0] = IEEE80211_UHR_MAC_CAP0_NPCA_SUPP,
+			},
 			.phy.cap = IEEE80211_UHR_PHY_CAP_ELR_RX |
 				   IEEE80211_UHR_PHY_CAP_ELR_TX,
 		},
@@ -4841,6 +4847,9 @@ static const struct ieee80211_sband_iftype_data sband_capa_5ghz[] = {
 		},
 		.uhr_cap = {
 			.has_uhr = true,
+			.mac.mac_cap = {
+				[0] = IEEE80211_UHR_MAC_CAP0_NPCA_SUPP,
+			},
 			.phy.cap = IEEE80211_UHR_PHY_CAP_ELR_RX |
 				   IEEE80211_UHR_PHY_CAP_ELR_TX,
 		},
@@ -4971,6 +4980,9 @@ static const struct ieee80211_sband_iftype_data sband_capa_5ghz[] = {
 		},
 		.uhr_cap = {
 			.has_uhr = true,
+			.mac.mac_cap = {
+				[0] = IEEE80211_UHR_MAC_CAP0_NPCA_SUPP,
+			},
 			.phy.cap = IEEE80211_UHR_PHY_CAP_ELR_RX |
 				   IEEE80211_UHR_PHY_CAP_ELR_TX,
 		},
@@ -5169,6 +5181,9 @@ static const struct ieee80211_sband_iftype_data sband_capa_6ghz[] = {
 		},
 		.uhr_cap = {
 			.has_uhr = true,
+			.mac.mac_cap = {
+				[0] = IEEE80211_UHR_MAC_CAP0_NPCA_SUPP,
+			},
 			.phy.cap = IEEE80211_UHR_PHY_CAP_ELR_RX |
 				   IEEE80211_UHR_PHY_CAP_ELR_TX,
 		},
@@ -5320,6 +5335,9 @@ static const struct ieee80211_sband_iftype_data sband_capa_6ghz[] = {
 		},
 		.uhr_cap = {
 			.has_uhr = true,
+			.mac.mac_cap = {
+				[0] = IEEE80211_UHR_MAC_CAP0_NPCA_SUPP,
+			},
 			.phy.cap = IEEE80211_UHR_PHY_CAP_ELR_RX |
 				   IEEE80211_UHR_PHY_CAP_ELR_TX,
 		},
@@ -5416,6 +5434,9 @@ static const struct ieee80211_sband_iftype_data sband_capa_6ghz[] = {
 		},
 		.uhr_cap = {
 			.has_uhr = true,
+			.mac.mac_cap = {
+				[0] = IEEE80211_UHR_MAC_CAP0_NPCA_SUPP,
+			},
 			.phy.cap = IEEE80211_UHR_PHY_CAP_ELR_RX |
 				   IEEE80211_UHR_PHY_CAP_ELR_TX,
 		},
-- 
2.34.1


