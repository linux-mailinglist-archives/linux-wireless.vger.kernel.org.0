Return-Path: <linux-wireless+bounces-31901-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QAmFIkWSk2lu6gEAu9opvQ
	(envelope-from <linux-wireless+bounces-31901-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Feb 2026 22:55:17 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE750147D0D
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Feb 2026 22:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 825B73004D36
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Feb 2026 21:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CF32C158D;
	Mon, 16 Feb 2026 21:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YF6GOx6/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB8A29617D
	for <linux-wireless@vger.kernel.org>; Mon, 16 Feb 2026 21:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771278907; cv=none; b=CF81J2dTrfSl7zUhlHMCbdxvwgSNhhUsO6TbmDAl5tKDhO5UUjzVsh4kcboBOACQZgQ3OT6lbfXB8jl27jbn1k0swBPuG0KF5WxbXS97xfz4wWIFqfBYW4PUndHu+HNpaY8CvPwEXFOrgUUCZjnd8kPJNl1F2VVi7LbqF6W09XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771278907; c=relaxed/simple;
	bh=MSqJU/jyrrhYRMizF03ZktGj7D2AEGYJpXJYtMgrc4o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Bme1lX+J+xZl6zuqLSrXKlt1P3ZVOBQcEGat29/8+jMIsM30HlOr6oX7gRKvf0esWlCFzs5AqV2LJml0M6Ggz040wh48Tb6XL1R+Ve4TkUsiVQTqrNIksYP0Ayvp5mwm4rpBzhZPyC5TtTM4vlgHCzwFInLVKB0tIEVKCJQpcM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YF6GOx6/; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771278907; x=1802814907;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MSqJU/jyrrhYRMizF03ZktGj7D2AEGYJpXJYtMgrc4o=;
  b=YF6GOx6/yeOkRJwbZQCFgdRLR1IexbpkCMsMCtA/6nNKnCU7a5aGi6/1
   hUQTYvMaPjxGKIDC4CviO+8vR0j/OJlSIzaLLniHMmo/K6V6chNmmwdaJ
   k411Xom323KSJWQEvsq12j9TBCTi+9kEvkeNbLytoS7wGGdur4mluAJGN
   ioSvZ/yusXtw4KuF/0B+anDTTCstw+chWSCk7V4RxGUvxllNwAw7L4JxJ
   Eid3eLCSYxxrYs/A/4s9Tw6RDrVpTcKNDaHDiaO2eMyyRLJ6qEkaMH/e8
   9DLa0ISGqbJPXe1U+P3Ne3DEchrtX4YPiVr8ZwLrateSP524DVCPUehGV
   A==;
X-CSE-ConnectionGUID: t6b8laTbS1O7cJhXDzJdFA==
X-CSE-MsgGUID: kSHI9QGfRCeLghpMWEz74A==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="75980283"
X-IronPort-AV: E=Sophos;i="6.21,295,1763452800"; 
   d="scan'208";a="75980283"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2026 13:55:06 -0800
X-CSE-ConnectionGUID: aqdrr6+ISW2ZSpDRpxKcoA==
X-CSE-MsgGUID: bEkI4UNzRquTrHJbNVBI4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,295,1763452800"; 
   d="scan'208";a="213547299"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2026 13:55:05 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 02/15] wifi: cfg80211: remove unneeded call to cfg80211_leave
Date: Mon, 16 Feb 2026 23:54:39 +0200
Message-Id: <20260216234830.c43709c9d3af.I3179a28f237ea3b8ec368af720fbf77455a7763f@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260216215452.1538316-1-miriam.rachel.korenblit@intel.com>
References: <20260216215452.1538316-1-miriam.rachel.korenblit@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31901-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AE750147D0D
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


