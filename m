Return-Path: <linux-wireless+bounces-20043-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A20A57E64
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 22:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E0E0188D75F
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 21:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329C3374FF;
	Sat,  8 Mar 2025 21:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TErrsHw9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95EE19597F
	for <linux-wireless@vger.kernel.org>; Sat,  8 Mar 2025 21:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741468051; cv=none; b=I0HonqQGmUCg9I0GhhDoR9hn2rkypHUKi33Au8vPU81jBc+z70r6NyPmzZDJBdNQ8rEOcSrcKrfM4DRr1mTf/FbN2dX+SLokjR39suEw3Rf/ts1IUSnqgFMGXfRG/tbZ+2VMJbDdI79V0fSkJc1KJEmyFbGDyatbGrU9OUKXl0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741468051; c=relaxed/simple;
	bh=APQUsvv8NJyGFNs7j/q6znNhdgDoGWngVOpacJWZix4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GFodTPbQ9dfDeP1tZAbiVawDur0vs5Y2aULRol8QcPaFuSFYBEOn1MwZ4ZXjNF/3HeGmq1q+VSTjBgth8DvFj6J+dVbLtkEydp64nss3Kv6jZvSgHOIK0VToPWmCL5+q+rBrXD6ZefLwNizGZz4wgEXAwU3fDW8agL2oXJFpOL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TErrsHw9; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741468050; x=1773004050;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=APQUsvv8NJyGFNs7j/q6znNhdgDoGWngVOpacJWZix4=;
  b=TErrsHw911rXoomQPUus7kk+DPcuP6zg+/b4AgKKLnTZn85BPuT9aYbK
   4G49YxovOg9m1xyjVrm/Wlaib8IsAg0PsBxoILyuGa3uXSxrAneXP7te4
   bUEiNqD2yGVvAUEJNb0aOh1rmYXVTgwFQNLhdbDwjjKqYvRuzsEZOhtAy
   y0Ffk2TW3ueiBhmtJH45kSnccVwC1OekVktZrVtjwHd8SHg+vYCbwTVzy
   XnKIfoMfGhB8dTAqBF44H8lhA+WVFR7MXJY6xqIM9UR1+U9tDThOQLRaS
   P10V/VvDzJM2lB97kD75NDmViOB8TGsFJ/MLdJUsYby+o3mxAL7RJWbUD
   A==;
X-CSE-ConnectionGUID: VfvFjGxuRB+sy5r+CKezfA==
X-CSE-MsgGUID: ClKf+gXdS327kNHFC/XnPw==
X-IronPort-AV: E=McAfee;i="6700,10204,11367"; a="42413134"
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="42413134"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 13:04:16 -0800
X-CSE-ConnectionGUID: obuwcf+MTAGeqxhMnjhgXw==
X-CSE-MsgGUID: vHbMzwmxSIK3gPYkx78TXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="124644466"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 13:04:14 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH RESEND wireless-next 14/15] wifi: mac80211: don't include MLE in ML reconf per-STA profile
Date: Sat,  8 Mar 2025 23:03:40 +0200
Message-Id: <20250308225541.8e5be244c70f.I3472cd5c347814ee3600869a88488997bcd43224@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250308210341.2302222-1-miriam.rachel.korenblit@intel.com>
References: <20250308210341.2302222-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

In the multi-link reconfiguration frame, the per-STA profile for
added links shouldn't include the multi-link element. Set the
association ID to an invalid value, so it doesn't erroneously
match the link ID if that happens to be zero.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/ieee80211_i.h | 2 +-
 net/mac80211/mlme.c        | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index a36563a07b3b..217e949bb756 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -460,7 +460,7 @@ struct ieee80211_mgd_assoc_data {
 	bool s1g;
 	bool spp_amsdu;
 
-	unsigned int assoc_link_id;
+	s8 assoc_link_id;
 
 	__le16 ext_mld_capa_ops;
 
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 9c4d4f04b23e..94d9d9ca42fe 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -10434,6 +10434,8 @@ int ieee80211_mgd_assoc_ml_reconf(struct ieee80211_sub_if_data *sdata,
 		if (!data)
 			return -ENOMEM;
 
+		data->assoc_link_id = -1;
+
 		uapsd_supported = true;
 		ieee80211_ml_reconf_selectors(userspace_selectors);
 		for (link_id = 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS;
-- 
2.34.1


