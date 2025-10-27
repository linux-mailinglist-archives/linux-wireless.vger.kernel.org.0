Return-Path: <linux-wireless+bounces-28314-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B87C0DA2F
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Oct 2025 13:43:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC3FE420305
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Oct 2025 12:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C534330F925;
	Mon, 27 Oct 2025 12:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jDRXslht"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F823019D0
	for <linux-wireless@vger.kernel.org>; Mon, 27 Oct 2025 12:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761568449; cv=none; b=GlIoOly/BpMiaqlkvZPhjBGku7MLWHd1yB9DJVPy3iUOaV7HolWRJJy/CIN2Jb08ahDH3gwkWcCTM8m2s/KhsGWkhkzaWfNo1iwRuVeM559DGsrnUuQrwpWZo+NswQ7ZGqXzEsCU/AuOnrM25q1OTWtnWLJy5bh3jiGpKB2vdww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761568449; c=relaxed/simple;
	bh=0pASwt84W6N/PwN+XxgZ/WNfENLhdL5NYWDzu2qdrAM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a0CP4IdluXs066YCfu+qhYlVCqJxKhhYMMCCaJJNa64177wSVDn5DJ9piKZfnAS7tzrW4WjZ7PjFnMDD8j1ttcV+ngrlVmQ/BXOboIM4PRm7rOmHPvTgk8XhhWxTgNsCRiZUF5EoYN8aq2Ce0Dpa+alaQKVj1zC6ztUD0ZDqjes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jDRXslht; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761568448; x=1793104448;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0pASwt84W6N/PwN+XxgZ/WNfENLhdL5NYWDzu2qdrAM=;
  b=jDRXslhtWdHV1SG7li1Wi87dZJw185onMygjsStamsHkSUwekjxV/egA
   6L7+w5cIor7URdcsna6uzYvWWCWCssUIxZI7DUVeK7n16Ht5N37M1XkET
   OY/KLsUEfRIfT8J/BzqHhAHrJJqbvbEGkAyNldPkODclrHI++ssVN4gG8
   pnmEm8+j/Otwom8+G1La1jJejiXUKA23A6TGpnrlvvuqa41Fk0w5T8FgX
   c9X7Y5DRiW8cIbi0tv2L0FwccXCH3ka9EPkIAUQUdaI/2OXfLktWQCZXe
   Sf54PQAXOWXKnLGSzT4kajJsPbgddLdCL7Lpkoq2k1GNsRFt/95UseLdD
   g==;
X-CSE-ConnectionGUID: KSq2tLEsS726BStDIw0k6A==
X-CSE-MsgGUID: 5kA+d129TeC8HAhIqkDbjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="66258578"
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="66258578"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 05:34:08 -0700
X-CSE-ConnectionGUID: sLw7RhBTQumQ6IHcbpuADw==
X-CSE-MsgGUID: ILpbDWXIQXu/5tUTpczLCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="190162823"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 05:34:07 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next v3 3/4] wifi: mac80211: use wiphy_hrtimer_work for ml_reconf_work
Date: Mon, 27 Oct 2025 14:33:56 +0200
Message-Id: <20251027143011.4f7a33b57dfb.I063c5c15bf7672f94cea75f83e486a3ca52d098f@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251027123357.2221947-1-miriam.rachel.korenblit@intel.com>
References: <20251027123357.2221947-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

The work item may be scheduled relatively far in the future. As the
event happens at a specific point in time, the normal timer accuracy is
not sufficient in that case.

Switch to use wiphy_hrtimer_work so that the accuracy is sufficient.

Fixes: 8eb8dd2ffbbb ("wifi: mac80211: Support link removal using Reconfiguration ML element")
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/ieee80211_i.h |  2 +-
 net/mac80211/mlme.c        | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index eb22279c6e01..eb38049b2252 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -612,7 +612,7 @@ struct ieee80211_if_managed {
 	u8 *assoc_req_ies;
 	size_t assoc_req_ies_len;
 
-	struct wiphy_delayed_work ml_reconf_work;
+	struct wiphy_hrtimer_work ml_reconf_work;
 	u16 removed_links;
 
 	/* TID-to-link mapping support */
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 1775835d255d..dad3985b5704 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -4259,7 +4259,7 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 				  &ifmgd->neg_ttlm_timeout_work);
 
 	sdata->u.mgd.removed_links = 0;
-	wiphy_delayed_work_cancel(sdata->local->hw.wiphy,
+	wiphy_hrtimer_work_cancel(sdata->local->hw.wiphy,
 				  &sdata->u.mgd.ml_reconf_work);
 
 	wiphy_work_cancel(sdata->local->hw.wiphy,
@@ -6886,7 +6886,7 @@ static void ieee80211_ml_reconfiguration(struct ieee80211_sub_if_data *sdata,
 		/* In case the removal was cancelled, abort it */
 		if (sdata->u.mgd.removed_links) {
 			sdata->u.mgd.removed_links = 0;
-			wiphy_delayed_work_cancel(sdata->local->hw.wiphy,
+			wiphy_hrtimer_work_cancel(sdata->local->hw.wiphy,
 						  &sdata->u.mgd.ml_reconf_work);
 		}
 		return;
@@ -6916,9 +6916,9 @@ static void ieee80211_ml_reconfiguration(struct ieee80211_sub_if_data *sdata,
 	}
 
 	sdata->u.mgd.removed_links = removed_links;
-	wiphy_delayed_work_queue(sdata->local->hw.wiphy,
+	wiphy_hrtimer_work_queue(sdata->local->hw.wiphy,
 				 &sdata->u.mgd.ml_reconf_work,
-				 TU_TO_JIFFIES(delay));
+				 us_to_ktime(ieee80211_tu_to_usec(delay)));
 }
 
 static int ieee80211_ttlm_set_links(struct ieee80211_sub_if_data *sdata,
@@ -8803,7 +8803,7 @@ void ieee80211_sta_setup_sdata(struct ieee80211_sub_if_data *sdata)
 			ieee80211_csa_connection_drop_work);
 	wiphy_delayed_work_init(&ifmgd->tdls_peer_del_work,
 				ieee80211_tdls_peer_del_work);
-	wiphy_delayed_work_init(&ifmgd->ml_reconf_work,
+	wiphy_hrtimer_work_init(&ifmgd->ml_reconf_work,
 				ieee80211_ml_reconf_work);
 	wiphy_delayed_work_init(&ifmgd->reconf.wk,
 				ieee80211_ml_sta_reconf_timeout);
-- 
2.34.1


