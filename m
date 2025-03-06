Return-Path: <linux-wireless+bounces-19890-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C66BA5483D
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 11:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A59F8171A5F
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 10:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29020204C28;
	Thu,  6 Mar 2025 10:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C8RfySyn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB3120B1F3
	for <linux-wireless@vger.kernel.org>; Thu,  6 Mar 2025 10:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741257842; cv=none; b=IVUfn+GSO1CmiEmuz6Bxd2oH/6OMPdp7TDJsvaDau9W+wDYP71MBaIdeH2k72UrEZP5hnwV75XBvV3DmOlJLBV/rJQz1uLtemNeMEurqcsr1ZlZCbdfO+iISXVgFaPqJkuopG9+/9fcMDr9ZfRx+m1mVQZL4RF7WiycqOHrdoqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741257842; c=relaxed/simple;
	bh=APQUsvv8NJyGFNs7j/q6znNhdgDoGWngVOpacJWZix4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Cn1OyruPn/5K0wznaVoPuOTrcJzQOiLQupAKUY6DfXVFBIu9QiLbar8eQZRZo7P433ZquGZOhfLEHb4LziEZ4qz8hB7XzHCll3N7ugO0ixblPTvaBRcZyQK+JpthS+dCKtib1AzOkHLydyDDLEs3ru6ifSdY8AkJoIQzT1VXO1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C8RfySyn; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741257841; x=1772793841;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=APQUsvv8NJyGFNs7j/q6znNhdgDoGWngVOpacJWZix4=;
  b=C8RfySynyxzTwqddbxV//9waj6fgxjnPJgQYFkl0SwGSvfZWBQfQY/aR
   41GATqqS/LF2IjsVJ4jnWuEKMpItZ8c/E43lSYflMD81AVNwWm0rJx3bq
   W7NJGTASJOreQ2Y0Kom8S2APQ6Fzla7Ydc1t6aiLOD+Joh305GiFHsw6Y
   YII/kfv/c829g7aUaIk/4i78G9rZ7OrH3yO47URM0m+y4XndMRhMrWNb+
   tQyHSRDbUwzYkaD6jNidNXXAIi8u0aTFECpJNiFYt/aXXBMBSeyPR0wSo
   ToSl5BQAlGqo0HqUplYVLLPJwJbrncBVcuMD5NlhI7+7JoW7DUtM/goGM
   A==;
X-CSE-ConnectionGUID: P5UX7jRhRl+rJx4RhBnxEQ==
X-CSE-MsgGUID: 5E9loJXGRNWUEqmIUhutjA==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="29844521"
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="29844521"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 02:44:01 -0800
X-CSE-ConnectionGUID: nJ+K3MopSd6WEylU9nURkw==
X-CSE-MsgGUID: KA+U8Nl8T5K4JeusgTeZfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="118797786"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 02:43:59 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH wireless-next 14/15] wifi: mac80211: don't include MLE in ML reconf per-STA profile
Date: Thu,  6 Mar 2025 12:43:25 +0200
Message-Id: <20250306124057.7191c2a0dc6d.I3472cd5c347814ee3600869a88488997bcd43224@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306104326.4105722-1-miriam.rachel.korenblit@intel.com>
References: <20250306104326.4105722-1-miriam.rachel.korenblit@intel.com>
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


