Return-Path: <linux-wireless+bounces-39063-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DIuhAQVDVmqn2QAAu9opvQ
	(envelope-from <linux-wireless+bounces-39063-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 16:09:09 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7CB7558B2
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 16:09:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=P70vUJLT;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39063-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39063-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 25AB430EF3B6
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 14:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1765847B439;
	Tue, 14 Jul 2026 14:02:47 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C5247CC82
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 14:02:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784037767; cv=none; b=FrEu1em2NaWWWOh9YkxBKfsz84PYQFTGJYTbC4AngvVoSPIAigVCQ9YM6WtIGCvlUJfgOVO1LaHJgZuf7RZxesgWJwUvrkg4lsH/NVouaKJmOzCZaKopoMTyoNe0F9WdqM8vYBf/zL4Axy5KPGqrqTkJHehJ60077loZ9bu+ijY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784037767; c=relaxed/simple;
	bh=tmxEyTcXROyKdpIierbb17z4+7NdnESHQvFLHjJ3FGg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XZXuK6MBIYdrDln+vku3pNL+z4/jaMt5asyvjpsY1cak8MonhX3cY1dBqhXYos59dAaceehhF1BLKXXgsGpmml3wZHDiwsdAbQJmU5GyUCjJb6RyC35d1ehlq+g+5wl4vsO6Ec8q5GxYaDgRYWVoQD79uv/WOv9e/jJdA3191Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P70vUJLT; arc=none smtp.client-ip=198.175.65.16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784037765; x=1815573765;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tmxEyTcXROyKdpIierbb17z4+7NdnESHQvFLHjJ3FGg=;
  b=P70vUJLTYqZDZkRf3reG2Nyl/50tvunh7WWgQLNh1hLyVtMtBAKikS4/
   GSLyT8OzlF46mGcg/M6Wl8SjryyPP3TSfPNswTCInItPXIKHIslrFdGp9
   OUcrQS6mPxEZxcNdV2KPncp9Lb0P/pasjrBEx8mzFv3iVglf+AXqMPLeM
   L/NjDj9/lpwDnRnX9X3PbV8ozBkPOYZAcpVWfbmXbX1PvbPXbILUFHIGB
   Fl3F6WuUjmaE+UXPj45c2BJfKH5zZALbHDYKzr/L/kjIL80XfHALzKO5T
   x3Bz45ZUoZjQl8+FECoewEoIOYhZJHi56x5DqIBiMIld5k5P+vlGTluGc
   A==;
X-CSE-ConnectionGUID: VrKirX17SaK1Zni0niHanw==
X-CSE-MsgGUID: QusRE4wBRrOQbRXbenB5ew==
X-IronPort-AV: E=McAfee;i="6800,10657,11846"; a="84855072"
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="84855072"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 07:02:45 -0700
X-CSE-ConnectionGUID: BL31WU9STBeJ1jOFg476kA==
X-CSE-MsgGUID: Eae96TUrTYubhGrHnkff7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="254737845"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 07:02:44 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 iwlwifi-next 03/15] wifi: iwlwifi: claim UHR DBE capability for UHR devices
Date: Tue, 14 Jul 2026 17:02:06 +0300
Message-Id: <20260714165826.435828046f11.I538b2d90a4c282118ca2e56292cf5615d477a44c@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260714140218.2887000-1-miriam.rachel.korenblit@intel.com>
References: <20260714140218.2887000-1-miriam.rachel.korenblit@intel.com>
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
	TAGGED_FROM(0.00)[bounces-39063-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,changeid:mid,intel.com:from_mime,intel.com:email,intel.com:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5A7CB7558B2

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


