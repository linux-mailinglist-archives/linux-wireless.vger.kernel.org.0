Return-Path: <linux-wireless+bounces-1396-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8142482221A
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jan 2024 20:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A464B20B7B
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jan 2024 19:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67CE615E96;
	Tue,  2 Jan 2024 19:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="irKBm+OO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9797D15E90
	for <linux-wireless@vger.kernel.org>; Tue,  2 Jan 2024 19:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704224166; x=1735760166;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2s/5RHsYJLrq+OcbozNeF+uUvUUTVH2X7UnH8e8yal0=;
  b=irKBm+OOPXAUSHHczFvdRsdal+1UHz2Fqc/k0e3gkHga3ZHuy+XVbTdf
   Q3ufS6heZqT9cSasP3JRuJopumhfg5nqa4MPFO591xC8BgQUTo6Ny5Zlu
   EfhhSvWzJGNTaDky75domqEB4m9aTOGW5YJBo6XnqTDGo6CkVa+/w/y7y
   xa/QZ1NQzCrKhWgNSM9rHc72fjmZQ1l3T29M19sJ7D/1UmOitWbYCQCrZ
   X9DGGOv0lQh5pjn0cN3Q0+NV3v33RarYlGFILuGUZ23lvfIHLDhN12xaw
   noAAT6MHIBu7R7TRE9Ir0/sC5CaP2fdDasQhgPkGkA3CxtVlhX8u3gssl
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="463314280"
X-IronPort-AV: E=Sophos;i="6.04,325,1695711600"; 
   d="scan'208";a="463314280"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 11:36:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="898624426"
X-IronPort-AV: E=Sophos;i="6.04,325,1695711600"; 
   d="scan'208";a="898624426"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 11:36:04 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 01/15] wifi: cfg80211: correct comment about MLD ID
Date: Tue,  2 Jan 2024 21:35:30 +0200
Message-Id: <20240102213313.0917ab4b5d7f.I76aff0e261a5de44ffb467e591a46597a30d7c0a@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240102193544.157749-1-miriam.rachel.korenblit@intel.com>
References: <20240102193544.157749-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

The comment was referencing the wrong section of the documentation and
was also subtly wrong as it assumed the rules that apply when sending
probe requests directly to a nontransmitted AP. However, in that case
the response comes from the transmitting AP and the AP MLD ID will be
included.

Fixes: 2481b5da9c6b ("wifi: cfg80211: handle BSS data contained in ML probe responses")
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/wireless/scan.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index cf2131671eb6..019208f6be77 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -2673,8 +2673,11 @@ static void cfg80211_parse_ml_sta_data(struct wiphy *wiphy,
 	/* MLD capabilities and operations */
 	pos += 2;
 
-	/* Not included when the (nontransmitted) AP is responding itself,
-	 * but defined to zero then (Draft P802.11be_D3.0, 9.4.2.170.2)
+	/*
+	 * The MLD ID of the reporting AP is always zero. It is set if the AP
+	 * is part of an MBSSID set and will be non-zero for ML Elements
+	 * relating to a nontransmitted BSS (matching the Multi-BSSID Index,
+	 * Draft P802.11be_D3.2, 35.3.4.2)
 	 */
 	if (u16_get_bits(control, IEEE80211_MLC_BASIC_PRES_MLD_ID)) {
 		mld_id = *pos;
-- 
2.34.1


