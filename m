Return-Path: <linux-wireless+bounces-39027-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tRHvJVcZVmq8zAAAu9opvQ
	(envelope-from <linux-wireless+bounces-39027-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 13:11:19 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E578753C97
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 13:11:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=oFE18fth;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39027-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39027-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 840FF3007296
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 11:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E20355F46;
	Tue, 14 Jul 2026 11:11:12 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95F23769EF
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 11:11:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784027472; cv=none; b=tLHrt9Yh3YCfAaTEpspBGZ7dUKIMIENNAzKGMkxQRdaccCePJhuYS6gxVFAjsNrWnEMUCW1cFeXW6BiTRNwvXTvZOZ3DUiSidqS4GNkbc/Ghpkg2ZeL+oB987NVRIAMSUapl9pbKZEv+DEk4ktmMrhrOKg/H98gd+JRLG11TNO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784027472; c=relaxed/simple;
	bh=AIa4Bt1kp+fI4W6DW+a/uBlJ4oY4SIEdIneWll9LRNg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qcDDa+JZR2GNSQc+s1R2HtlPaWRU304BCt+2aLiWKX9yoxsACd66JEq+u7L/IpiYJbWjr5fSPzj+1iaGywfrb5WCp+hLEyYSslVPFRMLWpTQITYBWQEZLc8YTG2ACVLpzYuiN3YzHBkqOrHls3Sp1+mLhiZnSMR8Xxc1k82hrDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oFE18fth; arc=none smtp.client-ip=192.198.163.13
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784027470; x=1815563470;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AIa4Bt1kp+fI4W6DW+a/uBlJ4oY4SIEdIneWll9LRNg=;
  b=oFE18fthxshU6bLKemYN7evMlydu1sJjjp9L/6cC0bR6ijCaja7a6KAb
   sgdI9ropgNWS9st9aZNkQ060ku45PfsBfNqMKNkr1mlq5OG9Ff3sYz1qE
   j3478MD6k0Rk1YOHu3lWUtZIBluSsq05hBMVxws4Oxy/M3wistvxcyqw+
   AYOmLMCFbvdG0Vn5aYxz4HoAl4RNNL9ncIxIqSANQGSf/Qqy+NoEz0cD4
   qVUp9jYNrrIGAcqarzVgMuVX8fVN7RGT5VCCcZdCLZ51dawTeTet17csG
   Wn++ikWOwVgdnjtf2UhMJoFjhY+1LCH04HTOW482lkYtrw8RWY8REEKgR
   A==;
X-CSE-ConnectionGUID: ES2YVK3jTA6vxC4aCgn/ww==
X-CSE-MsgGUID: Cmxy3uHxRn6ld1/RGYxmtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11846"; a="87189707"
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="87189707"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 04:11:10 -0700
X-CSE-ConnectionGUID: 7iJ40I0dRZGr/2XFIZo7bQ==
X-CSE-MsgGUID: loupp8swT66X0BsR0J9k6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="257795749"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 04:11:08 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH wireless] wifi: mac80211: copy aggregation information
Date: Tue, 14 Jul 2026 14:10:46 +0300
Message-Id: <20260714141038.15620aa5324b.I049254b854ac91c32e0768eb7c819f32eda34218@changeid>
X-Mailer: git-send-email 2.34.1
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-39027-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:benjamin.berg@intel.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,intel.com:from_mime,intel.com:email,intel.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,changeid:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4E578753C97

From: Benjamin Berg <benjamin.berg@intel.com>

This information can be considered part of the capabilities and should
also be copied to the NAN data station.

Fixes: 27e9b326b674 ("wifi: mac80211: support NAN stations")
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/cfg.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index b00191e02a63..43f142624d33 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -2611,6 +2611,9 @@ static int sta_apply_parameters(struct ieee80211_local *local,
 		memcpy(&sta->deflink.pub->supp_rates,
 		       &nmi_sta->deflink.pub->supp_rates,
 		       sizeof(sta->deflink.pub->supp_rates));
+
+		sta->deflink.pub->agg = nmi_sta->deflink.pub->agg;
+		__ieee80211_sta_recalc_aggregates(sta, 0);
 	}
 
 	/* set the STA state after all sta info from usermode has been set */
-- 
2.34.1


