Return-Path: <linux-wireless+bounces-31933-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QL8lJnpXlGkXDAIAu9opvQ
	(envelope-from <linux-wireless+bounces-31933-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Feb 2026 12:56:42 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 06CD114BA4E
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Feb 2026 12:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DB0A730072A4
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Feb 2026 11:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82CF335091;
	Tue, 17 Feb 2026 11:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EzuUcd9s"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410471C8634
	for <linux-wireless@vger.kernel.org>; Tue, 17 Feb 2026 11:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771329392; cv=none; b=ZhD+EOC4HFgQlYq7E70nmLotKOyd+y+BMR6Jg3rTF7nY2z1mrG4QwPM5i7qGdW4npqwkXRmWIka9pmSlb3WNlUKx2g2rfQA3jKxHbiyjXQpnR3QkhVbkTIh8bx+pe1Un8Ktq2mrG68oiBuD6154r8fnlcqlnQwboOlYikrAop28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771329392; c=relaxed/simple;
	bh=MSqJU/jyrrhYRMizF03ZktGj7D2AEGYJpXJYtMgrc4o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iiIaNA2LBWzG4pyspx/L3edS66ef0u0f957eJUUXdcoYWGXDNz/w90WSnB3NKMjjYV/nqkvGcdpH1+Sd6vHnltBKwPbabazoIIQP7g3zalSVhK28IjoXWlo2yHSryNQycZMVn9qwlNnnrP6DOYYyGrWM3JFjFQd6KYBQXvQ3+jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EzuUcd9s; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771329392; x=1802865392;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MSqJU/jyrrhYRMizF03ZktGj7D2AEGYJpXJYtMgrc4o=;
  b=EzuUcd9sqCdExY1y34c2h/a23bTs8ko3+B/VRtBdAhfyMtfeAIma//l0
   0edCuaTiEDRs9DS9aD7D1pwlJZ1XFKlADcEWTb/rtYdqQPkq6WK7VZTu1
   Xn+IyTYpxbegs5kBbWdMJzljEO5f7ZPlDc9CuTO6coSY9IhXlEvveUmXj
   4JXeHNLZcr7z239BiB/1OJ24k9th3qngTe9Wyv72lkRSpVEjfXoYtT2Rs
   I4bOlJTaIeoVDnt94oizQwmxMCBJq/yM3zXg/SbyU/z4MZQz4czm62B7y
   E5KCJHcvAsXzWz97BF2coLKk2I0+mQguKWhBPWnpODbSfwB7Y8rGb7VEq
   w==;
X-CSE-ConnectionGUID: Vw5hszTYSM6A5ay2qswFsg==
X-CSE-MsgGUID: TkXmX1jRRdaUZpEDc2R3iA==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="83495862"
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; 
   d="scan'208";a="83495862"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 03:56:32 -0800
X-CSE-ConnectionGUID: 6y4wnae4Tp2AWAfSgAsO0w==
X-CSE-MsgGUID: 6Xo4vSOzRaywuqJFDXe2sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; 
   d="scan'208";a="251547113"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 03:56:30 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v3 wireless-next 02/15] wifi: cfg80211: remove unneeded call to cfg80211_leave
Date: Tue, 17 Feb 2026 13:56:05 +0200
Message-Id: <20260217134342.c43709c9d3af.I3179a28f237ea3b8ec368af720fbf77455a7763f@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260217115618.2066972-1-miriam.rachel.korenblit@intel.com>
References: <20260217115618.2066972-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31933-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 06CD114BA4E
X-Rspamd-Action: no action

In cfg80211_destroy_ifaces, we first close all netdev wdevs, which will
trigger a NETDEV_GOING_DOWN event that will call cfg80211_leave,
and for non-netdev wdevs, we call cfg80211_remove_virtual_intf which
calles cfg80211_unregister_wdev, which handles the "leaving" for those
interfaces (i.e. stop_nan and stop_p2p_device)

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/wireless/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/wireless/core.c b/net/wireless/core.c
index 9af85d655027..328d3036d21f 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -349,7 +349,6 @@ void cfg80211_destroy_ifaces(struct cfg80211_registered_device *rdev)
 
 			guard(wiphy)(&rdev->wiphy);
 
-			cfg80211_leave(rdev, wdev, -1);
 			cfg80211_remove_virtual_intf(rdev, wdev);
 		}
 	}
-- 
2.34.1


