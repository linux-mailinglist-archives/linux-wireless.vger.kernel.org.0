Return-Path: <linux-wireless+bounces-20033-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 149D6A57E59
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 22:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F29816D833
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 21:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD76E1A08B1;
	Sat,  8 Mar 2025 21:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mcD4WDiT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2B9374FF
	for <linux-wireless@vger.kernel.org>; Sat,  8 Mar 2025 21:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741467990; cv=none; b=Ll/tKz0rkEtaISVzyo9DHq76XupVOT+Jbr+5jYwpwlvhATGxYfy4tiJHfKait7VhIMNkFw4PMetpZ9c+2H8jYQc4papVJeYUXewj/7S6UK1TUBC64QJsGAFHMk0yiuuk5gRpw36wOY8vAJV+jw3qsuj73sRHjXP2EGPL798/VMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741467990; c=relaxed/simple;
	bh=s94LcA9sw7TLrMkJh5mCQaXdgRMBn6WyiEpLoQBX5DI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LSlkIYw+lAe379Oi/rYH1N4rtyAYzoDeR2XtzGgESVXhzL43vBfC+JyV8UWbMAMzXvVSb838DS3xNruR/6YaVde6n9psS9lWWLy7L3dG3PloDSb799KZQPVORHNetIy9SzN2oLPllKpau8ktU608mXxYfBqyGel1XulpqfWIi7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mcD4WDiT; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741467989; x=1773003989;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s94LcA9sw7TLrMkJh5mCQaXdgRMBn6WyiEpLoQBX5DI=;
  b=mcD4WDiTGfN1e2elFwFXe85d+mwm9wIq+Uwe6r91y7B3xRQYW4GbDnrn
   4JrVfYGUsU1k8cRoh3Cw6lXvdpo/nYheIUWhD1W3etYesCj3oIonOhW46
   Sb+N/r6k++1s1C+1U2t+MF7qOfKxVnnQOEIZXMdujWq5MdeCg2UGGS79F
   kmcPRyHNIIh87nV5eOKqV5EyJRRfr/xiwIUaKysjqYNONLZgVsP9oydbA
   9GTaoeAD4BlZVKmY/lA8mnZRPyxv2IKf+y/7kMBronRKCn0sQyNirCKTw
   vCxb50mawi9UPknryLlrUqdEMS0rHhCRR4e/N1HmbTLbEMt6ZrmqtxFqm
   w==;
X-CSE-ConnectionGUID: MJedEzBURdOrdwacfXk+tA==
X-CSE-MsgGUID: d6+gzIf3RmC1oO1tpXakNg==
X-IronPort-AV: E=McAfee;i="6700,10204,11367"; a="42413059"
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="42413059"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 13:04:01 -0800
X-CSE-ConnectionGUID: 4mPAFaCpRvWrouUF3vY/Gw==
X-CSE-MsgGUID: HjXvuOtGT62HqGpY85eO3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="124644369"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 13:04:00 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH RESEND wireless-next 05/15] wifi: mac80211: fix U-APSD check in ML reconfiguration
Date: Sat,  8 Mar 2025 23:03:31 +0200
Message-Id: <20250308225541.b4674be12a38.I01959e448c6a2a3e8bc5d561bbae9e8d2cca616a@changeid>
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


