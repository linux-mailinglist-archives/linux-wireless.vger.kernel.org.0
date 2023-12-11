Return-Path: <linux-wireless+bounces-606-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D66D80BAD5
	for <lists+linux-wireless@lfdr.de>; Sun, 10 Dec 2023 14:06:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 490801F210B0
	for <lists+linux-wireless@lfdr.de>; Sun, 10 Dec 2023 13:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA8CF9E2;
	Sun, 10 Dec 2023 13:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d30/LCQB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82BF10A
	for <linux-wireless@vger.kernel.org>; Sun, 10 Dec 2023 05:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702213595; x=1733749595;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7tYVRvl5JCRHfQPEROlW+xoT7tx9ymPAeu9Q+T6GVpE=;
  b=d30/LCQBXCnNST59LVS0zrhtYu38PmLIYyCJ2Ya8bb+kMOE9lh4mUPRc
   qWt3DFCgnFe808x/RUZpTRjMVfbZ/gwn0U6Da8WqlG7pEiMR/D8X73g6Y
   Q+VoHAAOjB5yecCd8yKCiGkwnNZXuTENj2X/NDZLSguczGQurS2KG51Jw
   MSucjbvskXOt07z0Pg2NL2M7jVJOBMb3Y/SZlRMV3TtaBYznppuI2ekBJ
   E57aCkmR53gmHrbuT3DYmNCFS508K64YyVvUiNEjp8UkfV3OD3eOlL926
   IMxflnP4okNvSrg0ejQfl1Mmvc2hmDjQbdD7HSkoNKDmr0We32ktsUuIj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10919"; a="480746163"
X-IronPort-AV: E=Sophos;i="6.04,265,1695711600"; 
   d="scan'208";a="480746163"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2023 05:06:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10919"; a="748926422"
X-IronPort-AV: E=Sophos;i="6.04,265,1695711600"; 
   d="scan'208";a="748926422"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2023 05:06:32 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>, Greenman@web.codeaurora.org,
	Gregory <gregory.greenman@intel.com>
Subject: [PATCH 11/14] wifi: mac80211: don't set ESS capab bit in assoc request
Date: Mon, 11 Dec 2023 09:05:29 +0200
Message-Id: <20231211085121.65005aba900b.I3d00c8741400572a89a7508b5ae612c968874ad7@changeid>
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

From: Johannes Berg <johannes.berg@intel.com>

The ESS capability bit is reserved in frames transmitted by
the client, so we shouldn't set it. Since we've set it for
decades, keep that old behaviour unless we're connection to
a new EHT AP.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Greenman, Gregory <gregory.greenman@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/mlme.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 2b1b64eb82f7..a693ca2cf8cd 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -1385,7 +1385,7 @@ static int ieee80211_send_assoc(struct ieee80211_sub_if_data *sdata)
 	struct ieee80211_mgmt *mgmt;
 	u8 *pos, qos_info, *ie_start;
 	size_t offset, noffset;
-	u16 capab = WLAN_CAPABILITY_ESS, link_capab;
+	u16 capab = 0, link_capab;
 	__le16 listen_int;
 	struct element *ext_capa = NULL;
 	enum nl80211_iftype iftype = ieee80211_vif_type_p2p(&sdata->vif);
@@ -1532,6 +1532,17 @@ static int ieee80211_send_assoc(struct ieee80211_sub_if_data *sdata)
 	*pos++ = assoc_data->ssid_len;
 	memcpy(pos, assoc_data->ssid, assoc_data->ssid_len);
 
+	/*
+	 * This bit is technically reserved, so it shouldn't matter for either
+	 * the AP or us, but it also means we shouldn't set it. However, we've
+	 * always set it in the past, and apparently some EHT APs check that
+	 * we don't set it. To avoid interoperability issues with old APs that
+	 * for some reason check it and want it to be set, set the bit for all
+	 * pre-EHT connections as we used to do.
+	 */
+	if (link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_EHT)
+		capab |= WLAN_CAPABILITY_ESS;
+
 	/* add the elements for the assoc (main) link */
 	link_capab = capab;
 	offset = ieee80211_assoc_link_elems(sdata, skb, &link_capab,
-- 
2.34.1


