Return-Path: <linux-wireless+bounces-33578-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLHoKzsDvWkO5gIAu9opvQ
	(envelope-from <linux-wireless+bounces-33578-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 09:20:11 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DBD2D71DA
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 09:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E9BC0300A3AA
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 08:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2C137187F;
	Fri, 20 Mar 2026 08:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mshr3BZz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A56C233134
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 08:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773994603; cv=none; b=kQBM0aMdOy+jfnS0ksToHb2fqpB8AhGX3/xt0wFEBJpD8C1ai7N7A3kpK4azogDpoBJxUrn0nkJgU/HVAUY32vHdVR8M8pZWtoGbyEp8/lVE16rhhbxUax+b4mRh9R4vRgv1wSJXFi1Q5pEUe/ca3ax3zpUSSdhogbq+hJDWjSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773994603; c=relaxed/simple;
	bh=4MckkVS+X0d9pdmRLw8pct3/N+KEhwY05jo4gNVxs00=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jp0e+YIKB/RoAOD5ej5rQPNVz5zBd9j8h+kOhIykRN/HwogmWPdsw+H6BvopAq+KYbCEPD+W5nvy3fRTAvAlMlH0NGEsXi1KcF4zJmb77Nr062KiUG4l1Ympdc/pvIoQRNcRg7b6JUXtkvf0WaQHuTWvcdNpG6z+majxTQsqphg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mshr3BZz; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773994602; x=1805530602;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4MckkVS+X0d9pdmRLw8pct3/N+KEhwY05jo4gNVxs00=;
  b=Mshr3BZzXMuzmYaTFcXAFFEcQfTXuAfQWJigrDyeyRudyDD6v277v6Fw
   q3jvyfh86qLMqCXWapYNqxacItf40MOs7soCCT6uIig18bw+nm8XxW0FA
   ZqSEiUeyqfdizDirtojTaeXgkwkpcfNNYxbilCaanhwmT0ywmvH++lCF0
   83P4q0JoXOWU2nwZa3xAx6YhCc8v4ty5pAkEictEOa9hTMjc1s44DjItq
   3PSgBuCLAjuTnzlo25Jvky4kf2f1e5cd4bYO3AGt1GsoQzzFqxw0JJMEA
   X7rXgBUCZKgZ1cmowNMszu/cFQPraMn33r6WOStuSzJgCxC/YBlPyntbw
   Q==;
X-CSE-ConnectionGUID: Kdkf2XXvTieTEVOTEYPIHw==
X-CSE-MsgGUID: qe4m4sq+QG2KMGWmuE//lA==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="74967238"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="74967238"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 01:16:41 -0700
X-CSE-ConnectionGUID: X3iZdiWAT+KXLKhweGBtzw==
X-CSE-MsgGUID: 3uBjXx6rSXa42hQ5LB1aFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="223245723"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 01:16:40 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH wireless-next] wifi: mac80211_hwsim: advertise basic UHR support
Date: Fri, 20 Mar 2026 10:16:28 +0200
Message-Id: <20260320101624.77af6463920e.I257e525a461c350bed87cfaefc52de25e37afcfb@changeid>
X-Mailer: git-send-email 2.34.1
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-33578-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.995];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 15DBD2D71DA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Johannes Berg <johannes.berg@intel.com>

Just add support for ELR, and nothing else since the spec
isn't really all that well-specified yet.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index 82adcc848189..fdadc6fa89bd 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -4641,6 +4641,11 @@ static const struct ieee80211_sband_iftype_data sband_capa_2ghz[] = {
 			},
 			/* PPE threshold information is not supported */
 		},
+		.uhr_cap = {
+			.has_uhr = true,
+			.phy.cap = IEEE80211_UHR_PHY_CAP_ELR_RX |
+				   IEEE80211_UHR_PHY_CAP_ELR_TX,
+		},
 	},
 	{
 		.types_mask = BIT(NL80211_IFTYPE_AP) |
@@ -4749,6 +4754,11 @@ static const struct ieee80211_sband_iftype_data sband_capa_2ghz[] = {
 			},
 			/* PPE threshold information is not supported */
 		},
+		.uhr_cap = {
+			.has_uhr = true,
+			.phy.cap = IEEE80211_UHR_PHY_CAP_ELR_RX |
+				   IEEE80211_UHR_PHY_CAP_ELR_TX,
+		},
 	},
 #ifdef CONFIG_MAC80211_MESH
 	{
@@ -4918,6 +4928,11 @@ static const struct ieee80211_sband_iftype_data sband_capa_5ghz[] = {
 			},
 			/* PPE threshold information is not supported */
 		},
+		.uhr_cap = {
+			.has_uhr = true,
+			.phy.cap = IEEE80211_UHR_PHY_CAP_ELR_RX |
+				   IEEE80211_UHR_PHY_CAP_ELR_TX,
+		},
 	},
 	{
 		.types_mask = BIT(NL80211_IFTYPE_AP) |
@@ -5043,6 +5058,11 @@ static const struct ieee80211_sband_iftype_data sband_capa_5ghz[] = {
 			},
 			/* PPE threshold information is not supported */
 		},
+		.uhr_cap = {
+			.has_uhr = true,
+			.phy.cap = IEEE80211_UHR_PHY_CAP_ELR_RX |
+				   IEEE80211_UHR_PHY_CAP_ELR_TX,
+		},
 	},
 #ifdef CONFIG_MAC80211_MESH
 	{
@@ -5236,6 +5256,11 @@ static const struct ieee80211_sband_iftype_data sband_capa_6ghz[] = {
 			},
 			/* PPE threshold information is not supported */
 		},
+		.uhr_cap = {
+			.has_uhr = true,
+			.phy.cap = IEEE80211_UHR_PHY_CAP_ELR_RX |
+				   IEEE80211_UHR_PHY_CAP_ELR_TX,
+		},
 	},
 	{
 		.types_mask = BIT(NL80211_IFTYPE_AP) |
@@ -5382,6 +5407,11 @@ static const struct ieee80211_sband_iftype_data sband_capa_6ghz[] = {
 			},
 			/* PPE threshold information is not supported */
 		},
+		.uhr_cap = {
+			.has_uhr = true,
+			.phy.cap = IEEE80211_UHR_PHY_CAP_ELR_RX |
+				   IEEE80211_UHR_PHY_CAP_ELR_TX,
+		},
 	},
 #ifdef CONFIG_MAC80211_MESH
 	{
@@ -5473,6 +5503,11 @@ static const struct ieee80211_sband_iftype_data sband_capa_6ghz[] = {
 			},
 			/* PPE threshold information is not supported */
 		},
+		.uhr_cap = {
+			.has_uhr = true,
+			.phy.cap = IEEE80211_UHR_PHY_CAP_ELR_RX |
+				   IEEE80211_UHR_PHY_CAP_ELR_TX,
+		},
 	},
 #endif
 };
-- 
2.34.1


