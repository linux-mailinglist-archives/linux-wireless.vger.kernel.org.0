Return-Path: <linux-wireless+bounces-19880-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 509E0A54830
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 11:44:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DD583ACEA5
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 10:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC85204698;
	Thu,  6 Mar 2025 10:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kQ3E56fw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3562C2040BF
	for <linux-wireless@vger.kernel.org>; Thu,  6 Mar 2025 10:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741257827; cv=none; b=d6RjNdlQnayuDyHWwdYFhvfYylQWpoREXneOXg6bShna3xRtsZ0qOjbwqDXxdrSgsHnczURDF1+AhAbr/eipXSURJPbD+W5uNVP1yWowpI6hotQVz2aK1TWkOxqpFagYFt8SJPgLDfUNn3I5FkgLjofNnOIe8yC51lOw29DyR0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741257827; c=relaxed/simple;
	bh=s94LcA9sw7TLrMkJh5mCQaXdgRMBn6WyiEpLoQBX5DI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H/gz69opDIKTiDgdeVOdI+fWo0sNtpkZVNfkPF5+bGlXtoPMPlXLTIpIsahylzFMDq4KBZsH5OwqrUByONLACHpplJGTdftnJHRr6d2YxzmIr/X1KjlVoU7LY+3p0DaqfZsw8iD5QtLHQQua3GRZSD2VCF2KlejdiGTerXkKCJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kQ3E56fw; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741257827; x=1772793827;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s94LcA9sw7TLrMkJh5mCQaXdgRMBn6WyiEpLoQBX5DI=;
  b=kQ3E56fwZ/Ukko9MBbaYxpBDore/2ogdI8UYLHK5Ti7T6vAm6pPahhB0
   xz3SD5dGnpj8qdChl4r6vGH0C2zIuZ37zjsopXZKqvfPO1K/BN3j/oDYT
   Plm4hcVWBWPgjGAP/0IqsGOTJMpmN6WXCVnPHhdfDHMkIdnKg0RSMcjFm
   9742ie321VYWAb/M0ukstSKSneMguv98U2k57rWzxZegvPQ1AhEXq/BP+
   mEuxYyhSA2/Byf+6pPiwAcBBfjn78Z2l3CY5Ou4GqWAR71LkuaJM2jd+n
   9WqCIqYxhuinG9Brx2x86BM8PM3LoncaaK8n5j2E9dbJqEjh4aWhDY1M/
   g==;
X-CSE-ConnectionGUID: OVFHMRqYS9+703S1hC+ULQ==
X-CSE-MsgGUID: UK1aN24uQgmDEeyRR2pfYg==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="29844482"
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="29844482"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 02:43:46 -0800
X-CSE-ConnectionGUID: RtwS4elhShW3CojF+kh20Q==
X-CSE-MsgGUID: dp6j/1/mTUqZeaBWMSpajg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="118797731"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 02:43:45 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH wireless-next 05/15] wifi: mac80211: fix U-APSD check in ML reconfiguration
Date: Thu,  6 Mar 2025 12:43:16 +0200
Message-Id: <20250306124057.db8705144418.I01959e448c6a2a3e8bc5d561bbae9e8d2cca616a@changeid>
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

If U-APSD isn't enabled by us, then IEEE80211_STA_UAPSD_ENABLED
won't be set, but the AP can still support it in that case. Only
require U-APSD from the AP if we enabled it, don't require it to
be disabled on the AP if we didn't.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/mlme.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 87ebeec2877d..426c0246fe1f 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -10492,12 +10492,11 @@ int ieee80211_mgd_assoc_ml_reconf(struct ieee80211_sub_if_data *sdata,
 			}
 		}
 
-		/* Require U-APSD support to be similar to the current valid
-		 * links
-		 */
-		if (uapsd_supported !=
-		    !!(sdata->u.mgd.flags & IEEE80211_STA_UAPSD_ENABLED)) {
+		/* Require U-APSD support if we enabled it */
+		if (sdata->u.mgd.flags & IEEE80211_STA_UAPSD_ENABLED &&
+		    !uapsd_supported) {
 			err = -EINVAL;
+			sdata_info(sdata, "U-APSD on but not available on (all) new links\n");
 			goto err_free;
 		}
 
-- 
2.34.1


