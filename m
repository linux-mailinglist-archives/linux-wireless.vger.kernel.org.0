Return-Path: <linux-wireless+bounces-1408-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFAF82222C
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jan 2024 20:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C89B1F23494
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jan 2024 19:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140EC168B9;
	Tue,  2 Jan 2024 19:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eCGpMKwg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE98168A6
	for <linux-wireless@vger.kernel.org>; Tue,  2 Jan 2024 19:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704224203; x=1735760203;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DjRv+kRkNNGe4Zh42doR5UW0R5K1g+hVdpA21okZXJU=;
  b=eCGpMKwgXgyK3RWXcMYUGbzrtHIzOxv3ovdekUH3mgW2v++Xdm3VHH77
   1R0/Kx0U3gkeHln+Xf0nVVo7lX6zVAsNFAXsMWT8HvhgJDIaNQ8t61sVJ
   YzQ2IiKEYiGNXK+687IGhRP2HkI6WSHMrK0X6eK7cbMr1+W5XaHURAIDm
   8aX1PbiWMUXPlblSxkH+r4oGe9tOOCPfrAptKSRlnOc+X8S5MMnXz0w55
   iWdASH7otrYKHrWeOEFkVhVdMW5Iw9hjIwda2JZEcPHHN9mLhl7BgJuuK
   Z4oayFtzTdlNYpvxY846IwGIIV//4Vtfyppj8aQSusRfM3QMQRNSuZ4mr
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="463314346"
X-IronPort-AV: E=Sophos;i="6.04,325,1695711600"; 
   d="scan'208";a="463314346"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 11:36:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="898624607"
X-IronPort-AV: E=Sophos;i="6.04,325,1695711600"; 
   d="scan'208";a="898624607"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 11:36:40 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH 13/15] wifi: mac80211: remove redundant ML element check
Date: Tue,  2 Jan 2024 21:35:42 +0200
Message-Id: <20240102213313.bb9b636e66f6.I7fc0897022142d46f39ac0b912a4f7b0f1b6ea26@changeid>
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

From: Johannes Berg <johannes.berg@intel.com>

If "ml_basic" is assigned, we already know that the type
of ML element is basic, so we don't need to check again,
that check can never happen. Simplify the code.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/mlme.c | 29 ++++++++++-------------------
 1 file changed, 10 insertions(+), 19 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 5ded60320132..fba596d81280 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -5413,33 +5413,24 @@ static void ieee80211_rx_mgmt_assoc_resp(struct ieee80211_sub_if_data *sdata,
 		}
 
 		if (ieee80211_vif_is_mld(&sdata->vif)) {
+			struct ieee80211_mle_basic_common_info *common;
+
 			if (!elems->ml_basic) {
 				sdata_info(sdata,
-					   "MLO association with %pM but no multi-link element in response!\n",
+					   "MLO association with %pM but no (basic) multi-link element in response!\n",
 					   assoc_data->ap_addr);
 				goto abandon_assoc;
 			}
 
-			if (le16_get_bits(elems->ml_basic->control,
-					  IEEE80211_ML_CONTROL_TYPE) !=
-					IEEE80211_ML_CONTROL_TYPE_BASIC) {
+			common = (void *)elems->ml_basic->variable;
+
+			if (memcmp(assoc_data->ap_addr,
+				   common->mld_mac_addr, ETH_ALEN)) {
 				sdata_info(sdata,
-					   "bad multi-link element (control=0x%x)\n",
-					   le16_to_cpu(elems->ml_basic->control));
+					   "AP MLD MAC address mismatch: got %pM expected %pM\n",
+					   common->mld_mac_addr,
+					   assoc_data->ap_addr);
 				goto abandon_assoc;
-			} else {
-				struct ieee80211_mle_basic_common_info *common;
-
-				common = (void *)elems->ml_basic->variable;
-
-				if (memcmp(assoc_data->ap_addr,
-					   common->mld_mac_addr, ETH_ALEN)) {
-					sdata_info(sdata,
-						   "AP MLD MAC address mismatch: got %pM expected %pM\n",
-						   common->mld_mac_addr,
-						   assoc_data->ap_addr);
-					goto abandon_assoc;
-				}
 			}
 		}
 
-- 
2.34.1


