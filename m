Return-Path: <linux-wireless+bounces-1731-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B263182B2C1
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jan 2024 17:20:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D00E281A3A
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jan 2024 16:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3E3524C1;
	Thu, 11 Jan 2024 16:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eBV/vYNn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C091524A9
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jan 2024 16:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704989917; x=1736525917;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z47WlOXTNUwEXDcjM0DqyhjTFBulX484RA3i1S1YXxc=;
  b=eBV/vYNni7FjoY83hqqt6QrHHp7DkQO2ELX/z4KcMK2HE9mEPqSovLju
   IUA3tePkoEK7iioYNSnXynm/1RwUTg1EaeDBU/WttREGdDQppmyQkz4aH
   OYEttVqq/C6fKUU6KTPnXuOCpPQUUB7x14oEjc0THi+AZbIjorRC6TEPv
   p+nm3g3B5LHLEUj9oGFEkJDaPFP/77WydCQSuH6evq8TEO0YSXoXhq37u
   J+Cr9fvNlG2bTayT2tO4EVSZP3NO+hO2/uvOqpDS+pjeM95FzF5NVyT6B
   0EEGWuh5H1+Stc3eaXg7/ITFSY/xQLBne/q19Yw5O+2OyfinSwH3us4iA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="463182600"
X-IronPort-AV: E=Sophos;i="6.04,186,1695711600"; 
   d="scan'208";a="463182600"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 08:18:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="1029606692"
X-IronPort-AV: E=Sophos;i="6.04,186,1695711600"; 
   d="scan'208";a="1029606692"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 08:18:34 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 5/8] wifi: mac80211: disallow drivers with HT wider than HE
Date: Thu, 11 Jan 2024 18:17:43 +0200
Message-Id: <20240111181514.da15fe3214d2.I4df51ad2f4c844615c168bf9bdb498925b3c77d4@changeid>
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

To simplify the code in the next patch, disallow drivers
supporting 40 MHz in HT but not HE, since we'd otherwise
have to track local maximum bandwidth per mode there.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/main.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index d48fa1147c14..e05bcc35bc1e 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -1119,8 +1119,26 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 		supp_vht = supp_vht || sband->vht_cap.vht_supported;
 
 		for_each_sband_iftype_data(sband, i, iftd) {
+			u8 he_40_mhz_cap;
+
 			supp_he = supp_he || iftd->he_cap.has_he;
 			supp_eht = supp_eht || iftd->eht_cap.has_eht;
+
+			if (sband->band == NL80211_BAND_2GHZ)
+				he_40_mhz_cap =
+					IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G;
+			else
+				he_40_mhz_cap =
+					IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G;
+
+			/* currently no support for HE client where HT has 40 MHz but not HT */
+			if (iftd->he_cap.has_he &&
+			    iftd->types_mask & (BIT(NL80211_IFTYPE_STATION) |
+						BIT(NL80211_IFTYPE_P2P_CLIENT)) &&
+			    sband->ht_cap.ht_supported &&
+			    sband->ht_cap.cap & IEEE80211_HT_CAP_SUP_WIDTH_20_40 &&
+			    !(iftd->he_cap.he_cap_elem.phy_cap_info[0] & he_40_mhz_cap))
+				return -EINVAL;
 		}
 
 		/* HT, VHT, HE require QoS, thus >= 4 queues */
-- 
2.34.1


