Return-Path: <linux-wireless+bounces-604-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA8980BAD3
	for <lists+linux-wireless@lfdr.de>; Sun, 10 Dec 2023 14:06:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F779280D31
	for <lists+linux-wireless@lfdr.de>; Sun, 10 Dec 2023 13:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F666C2C4;
	Sun, 10 Dec 2023 13:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VOqTn3Uj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3022FE
	for <linux-wireless@vger.kernel.org>; Sun, 10 Dec 2023 05:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702213582; x=1733749582;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cDB5PBzkwSn+zNT3BaZSKz2FXK4C/J3v/HhgzEGrcO4=;
  b=VOqTn3UjX7Jh4YsU7CGOwUsC9JsYjdFkaKU69TAnWdfJBFFRp2qQgxEd
   B+1GwrMHxUxk6wGt7OG2NiUtoMTCfJ89oEpdUp/iXeVvhntKaRpNHNM1A
   7Rs6St2TqFphRB7V07NoAJF9MWznmxudORp6kf6jS5wFb/ljMerfen9I1
   qM4nkTr8FXounAK5y/OEnx40vLBDc9cr1QFd8TXEBHL53XR5+hXS23uVe
   sDhW27OqrHQYTav/N10/mODNxvt0ASTMVk7L4GQxI/XvIoynqqbB+vQV3
   b42Lxz8TOc6vVGXqxaPmphWKAZrcB+410bUA8sCOKUsBYZ6PtqVd+ki8M
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10919"; a="480746087"
X-IronPort-AV: E=Sophos;i="6.04,265,1695711600"; 
   d="scan'208";a="480746087"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2023 05:06:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10919"; a="748926270"
X-IronPort-AV: E=Sophos;i="6.04,265,1695711600"; 
   d="scan'208";a="748926270"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2023 05:06:20 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>, Berg@web.codeaurora.org,
	Johannes <johannes.berg@intel.com>
Subject: [PATCH 09/14] wifi: cfg80211: generate an ML element for per-STA profiles
Date: Mon, 11 Dec 2023 09:05:27 +0200
Message-Id: <20231211085121.abde63d9cc6d.I3d346be0f84f51dccf4f4f92a3e997e6102b9456@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231211070532.2458539-1-miriam.rachel.korenblit@intel.com>
References: <20231211070532.2458539-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

The specification says that this information should not be explicitly
included in the per-STA profile. However, we need this information
readily available in the BSS for userspace and also internally when
associating. As such, append the appropriate element before
adding/updating the BSS.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Reviewed-by: Berg, Johannes <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/wireless/scan.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 2f8c9b6f7ebc..3e3ba0ddb83e 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -2621,6 +2621,7 @@ static void cfg80211_parse_ml_sta_data(struct wiphy *wiphy,
 	const struct element *elem;
 	struct cfg80211_mle *mle;
 	u16 control;
+	u8 ml_common_len;
 	u8 *new_ie;
 	struct cfg80211_bss *bss;
 	int mld_id;
@@ -2651,6 +2652,8 @@ static void cfg80211_parse_ml_sta_data(struct wiphy *wiphy,
 	    !(control & IEEE80211_MLC_BASIC_PRES_MLD_CAPA_OP))
 		return;
 
+	ml_common_len = ml_elem->variable[0];
+
 	/* length + MLD MAC address + link ID info + BSS Params Change Count */
 	pos = ml_elem->variable + 1 + 6 + 1 + 1;
 
@@ -2767,6 +2770,34 @@ static void cfg80211_parse_ml_sta_data(struct wiphy *wiphy,
 		if (!data.ielen)
 			continue;
 
+		/* The generated elements do not contain:
+		 *  - Basic ML element
+		 *  - A TBTT entry in the RNR for the transmitting AP
+		 *
+		 * This information is needed both internally and in userspace
+		 * as such, we should append it here.
+		 */
+		if (data.ielen + 3 + sizeof(*ml_elem) + ml_common_len >
+		    IEEE80211_MAX_DATA_LEN)
+			continue;
+
+		/* Copy the Basic Multi-Link element including the common
+		 * information, and then fix up the link ID.
+		 * Note that the ML element length has been verified and we
+		 * also checked that it contains the link ID.
+		 */
+		new_ie[data.ielen++] = WLAN_EID_EXTENSION;
+		new_ie[data.ielen++] = 1 + sizeof(*ml_elem) + ml_common_len;
+		new_ie[data.ielen++] = WLAN_EID_EXT_EHT_MULTI_LINK;
+		memcpy(new_ie + data.ielen, ml_elem,
+		       sizeof(*ml_elem) + ml_common_len);
+
+		new_ie[data.ielen + sizeof(*ml_elem) + 1 + ETH_ALEN] = link_id;
+
+		data.ielen += sizeof(*ml_elem) + ml_common_len;
+
+		/* TODO: Add an RNR containing only the reporting AP */
+
 		bss = cfg80211_inform_single_bss_data(wiphy, &data, gfp);
 		if (!bss)
 			break;
-- 
2.34.1


