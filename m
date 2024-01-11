Return-Path: <linux-wireless+bounces-1729-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E12A682B2C0
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jan 2024 17:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DC7CB2613B
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jan 2024 16:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB80951C2A;
	Thu, 11 Jan 2024 16:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fODtv+l6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBD24F8AA
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jan 2024 16:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704989905; x=1736525905;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qzoqWacS6h32MWMkW/bWLrT9QBKnxrDGwy2FHaM+bgU=;
  b=fODtv+l6sog6BC3nD6SaAp8uhlBOy1FGDHvXkGRsey0ZpS4W7y5suO3U
   qwUvXnOvwl6hlugtBDDWkonnUCeSqmV33LUSAoL40O7KNweBz4X7Glqa8
   /Mw7CWNBd9xCa2PiQnubVjiJ7K8W39qk4S1l2qqWVOh/hfVMLB4bEMmZE
   +3KiNrYhN1C+prsIs1isN/5yWWTQr28aNvmgb/lmu9LGQxz6hI0pxrl3Y
   ouzdJuN6uueVKcMyStmZ+tjV8A4+V9WRB9crCyqovd5Ez8x1hhzO8gJmR
   ghR5UcBGZtn5rkVoYAv0R94nj25gx/Tvv9f/UkKpo3g7To00x0/Yb/3c9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="463182501"
X-IronPort-AV: E=Sophos;i="6.04,186,1695711600"; 
   d="scan'208";a="463182501"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 08:18:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="1029606525"
X-IronPort-AV: E=Sophos;i="6.04,186,1695711600"; 
   d="scan'208";a="1029606525"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 08:18:16 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 3/8] wifi: mac80211: remove extra element parsing
Date: Thu, 11 Jan 2024 18:17:41 +0200
Message-Id: <20240111181514.c4a55da9f778.I112b1ef00904c4183ac7644800f8daa8a4449875@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240111161746.3978601-1-miriam.rachel.korenblit@intel.com>
References: <20240111161746.3978601-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

We already parse all the BSS elements into elems, there's
really no need to separately find EHT/ML again. Remove the
extra code.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/mlme.c | 24 ++----------------------
 1 file changed, 2 insertions(+), 22 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 6fa69ad3ad4f..45be270eaab7 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -4962,32 +4962,12 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 			(IEEE80211_CONN_DISABLE_HE |
 			 IEEE80211_CONN_DISABLE_EHT)) &&
 	    he_oper) {
-		const struct cfg80211_bss_ies *cbss_ies;
-		const struct element *eht_ml_elem;
-		const u8 *eht_oper_ie;
-
-		cbss_ies = rcu_dereference(cbss->ies);
-		eht_oper_ie = cfg80211_find_ext_ie(WLAN_EID_EXT_EHT_OPERATION,
-						   cbss_ies->data, cbss_ies->len);
-		if (eht_oper_ie && eht_oper_ie[1] >=
-		    1 + sizeof(struct ieee80211_eht_operation))
-			eht_oper = (void *)(eht_oper_ie + 3);
-		else
-			eht_oper = NULL;
+		eht_oper = elems->eht_operation;
 
 		if (!ieee80211_verify_sta_eht_mcs_support(sdata, sband, eht_oper))
 			*conn_flags |= IEEE80211_CONN_DISABLE_EHT;
 
-		eht_ml_elem = cfg80211_find_ext_elem(WLAN_EID_EXT_EHT_MULTI_LINK,
-						     cbss_ies->data, cbss_ies->len);
-
-		/* data + 1 / datalen - 1 since it's an extended element */
-		if (!(*conn_flags & IEEE80211_CONN_DISABLE_EHT) &&
-		    eht_ml_elem &&
-		    ieee80211_mle_type_ok(eht_ml_elem->data + 1,
-					  IEEE80211_ML_CONTROL_TYPE_BASIC,
-					  eht_ml_elem->datalen - 1))
-			supports_mlo = true;
+		supports_mlo = elems->ml_basic;
 	}
 
 	/* Allow VHT if at least one channel on the sband supports 80 MHz */
-- 
2.34.1


