Return-Path: <linux-wireless+bounces-39045-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ozBRLnYeVmq2zQAAu9opvQ
	(envelope-from <linux-wireless+bounces-39045-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 13:33:10 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2228C753EDA
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 13:33:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=OO4bsTns;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39045-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39045-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 26FC3301FB20
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 11:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C46270552;
	Tue, 14 Jul 2026 11:33:08 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CD136165F
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 11:33:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784028788; cv=none; b=i++b30cQP/OZaiekL0OWp+XxPqNjY1NOP2GoF1LxjlQIB9E9kIQDIY4XwovnRI1S5aTEa0glzXA5HQNv6o4fvcUdm7b7wRZss+vOI9RC7k7YMpdpqzynJ3NRKhclDqEjzZIIjgKTcp0EQooBcGp0UosUAR4rSd6OIPYkn0WBjW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784028788; c=relaxed/simple;
	bh=tmxEyTcXROyKdpIierbb17z4+7NdnESHQvFLHjJ3FGg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RzWzQPnFOUxKDhXek70YE2YPeV8Z5cs77JpiOvKtaa3S2j05KM46TIOGkLQfc94rRYjAy7i31sI56yCbVj5E1FOdCYzVfkvYGdcUA/lpuQHuGXtKvnV2Ls24NvufFYLHm4Wk8WguoGfXIJfAhz6TD9afk/RH14wnfrBxx9dIZ9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OO4bsTns; arc=none smtp.client-ip=192.198.163.12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784028787; x=1815564787;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tmxEyTcXROyKdpIierbb17z4+7NdnESHQvFLHjJ3FGg=;
  b=OO4bsTnsdpIeGyHqa4wM2Mzu6ZOP1rVEuuCf7OuzDQfjEn9uF7XLQC6o
   OLuSbkeIRFBjx/FxWiaXR9kMXujLXxDCvNye3SLEMPOJeNm51Vjo2X6to
   FXSHgAfdXIHSxPPgg5YS77kBpsz/6rgVr5AscghoxPzpyYl9fcr1N00TI
   oKjA/hhH+JtDIKwOeWDNplz3DIM4eMX+y0s4PZhKe4a8hUPwk4DzIDnVX
   BEgiT7RCAl4v3kRo0Sj46JIM/sITFqvFKLq5rlDE96F6fhLjOeH1xYYNY
   a0/OZ2yAvbyvHAc8rfRv8DGjDZVet4DIAFVREKWk1bGJ22wsO1Yhat6Rr
   Q==;
X-CSE-ConnectionGUID: i68j9BjgSzGrqXudO8iEpg==
X-CSE-MsgGUID: HxFLj5CvRkWeOr+Di3/fuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11846"; a="88469574"
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="88469574"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 04:33:07 -0700
X-CSE-ConnectionGUID: pUPzXka+Q1eaqHZTZ7bfwA==
X-CSE-MsgGUID: dhc10+6NRQeLWn08AVv5JA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="255882906"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 04:33:05 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 03/15] wifi: iwlwifi: claim UHR DBE capability for UHR devices
Date: Tue, 14 Jul 2026 14:32:29 +0300
Message-Id: <20260714143119.435828046f11.I538b2d90a4c282118ca2e56292cf5615d477a44c@changeid>
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
	TAGGED_FROM(0.00)[bounces-39045-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: 2228C753EDA

From: Johannes Berg <johannes.berg@intel.com>

When an Intel device supports UHR it also supports DBE
(dynamic bandwidth extension) since that's handled in
mac80211. Claim support for it for client mode.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index d47b4ae2f486..761424812609 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -699,7 +699,8 @@ static const struct ieee80211_sband_iftype_data iwl_iftype_cap[] = {
 			.mac.mac_cap = {
 				[0] = IEEE80211_UHR_MAC_CAP0_NPCA_SUPP |
 				      IEEE80211_UHR_MAC_CAP0_DPS_SUPP,
-				[1] = IEEE80211_UHR_MAC_CAP1_DUO_SUPP,
+				[1] = IEEE80211_UHR_MAC_CAP1_DUO_SUPP |
+				      IEEE80211_UHR_MAC_CAP1_DBE_SUPP,
 			},
 		},
 	},
-- 
2.34.1


