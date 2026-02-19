Return-Path: <linux-wireless+bounces-32012-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6NccLT/clmlJpgIAu9opvQ
	(envelope-from <linux-wireless+bounces-32012-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Feb 2026 10:47:43 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A1215D80B
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Feb 2026 10:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4A9F3300ECB8
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Feb 2026 09:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178ED2ECE91;
	Thu, 19 Feb 2026 09:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ei42IQ9P"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB26A30F921
	for <linux-wireless@vger.kernel.org>; Thu, 19 Feb 2026 09:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771494460; cv=none; b=hLGbUYwXaaUzSUDjkfVSaAI2nlSKswYj+LyheNYjhTARsB1oHYIBUDfXKGhAqoItTIbprlX5C3Feu8zPVuo9QMcvYX0ByHRgdSt9QcA/GmruI2VX932+3NQZdRGWGUM2Ao2UTGVKYWtFN/RbdepdpWrp6ZEdGEC7vBiH/nfPN7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771494460; c=relaxed/simple;
	bh=MSqJU/jyrrhYRMizF03ZktGj7D2AEGYJpXJYtMgrc4o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=psGk0dXTfq0aLEmQ7/v6dwwkvHtJoUfsOLgm0gV5es3kh8ZQCfbNcFe4f/HlI0NeLzxXJ7h11I1efj+0hTIxuTNL8p3zRcwghAg944rHbrZNfOjqb5AZg4m+qUyezyZ3FlcdiUOW6l+C8UU8IrGJhp60qRpEp0lPe9lrIpVDpGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ei42IQ9P; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771494459; x=1803030459;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MSqJU/jyrrhYRMizF03ZktGj7D2AEGYJpXJYtMgrc4o=;
  b=Ei42IQ9PRZySiRB8cczjGee5iXsBAw/AWvGl/dvjqnnqbQMv6l1LBWoh
   MfVO0cCbzQ+a97jFVfYHkpf4algl8nGA4IfiuVBuJweVcN7QsE1tt1/F+
   z8Pd4O2j3NCRAi4MY0JcgfHP1L/jibsSPtGQKKLROYdO2lPMFl9qEvAnU
   /7/53C9dSEbId1Bm7VfhQCEAJ+3P66dBRT4Kl3SRAhRLr8/2uwI0X1WbZ
   ApvTbGgt92qa4rGBYM6N5niTwsMlJiOAaLZ4Pvq2HhTLB4bVWjw1plt+T
   IwKcwPn43mfsABTiw3vZ/ZSKYTagKOzMXcJmZ2vbfMEUA8esg6ooydP9x
   w==;
X-CSE-ConnectionGUID: taBWgvoUSESNbhyKVaaeHA==
X-CSE-MsgGUID: nmb5uJECSpqyZ3GNz2Y8Yg==
X-IronPort-AV: E=McAfee;i="6800,10657,11705"; a="83680075"
X-IronPort-AV: E=Sophos;i="6.21,299,1763452800"; 
   d="scan'208";a="83680075"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 01:47:39 -0800
X-CSE-ConnectionGUID: vPUiARB6SmeVe64bet6T8w==
X-CSE-MsgGUID: lGO2igg+Q32sQKHXbpTKTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,299,1763452800"; 
   d="scan'208";a="218988997"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 01:47:38 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v4 wireless-next 02/15] wifi: cfg80211: remove unneeded call to cfg80211_leave
Date: Thu, 19 Feb 2026 11:47:12 +0200
Message-Id: <20260219114327.c43709c9d3af.I3179a28f237ea3b8ec368af720fbf77455a7763f@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260219094725.3846371-1-miriam.rachel.korenblit@intel.com>
References: <20260219094725.3846371-1-miriam.rachel.korenblit@intel.com>
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
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-32012-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 33A1215D80B
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


