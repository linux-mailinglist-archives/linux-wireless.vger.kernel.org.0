Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A84227215BE
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Jun 2023 11:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbjFDJMU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 4 Jun 2023 05:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbjFDJMT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 4 Jun 2023 05:12:19 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23C1E3
        for <linux-wireless@vger.kernel.org>; Sun,  4 Jun 2023 02:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685869929; x=1717405929;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lpqJmrzIVlFvFjKMIRKmBBmUMkdDwXLsnt+ZcTM4y1g=;
  b=CfEqZfGM601MVRmp83JbDZmmy6Trq+PzfRMBLYw5wcwLFx2YamJD6dl8
   N4Qt0IstNyQhjMmfntqAyyGhO1ABJ/jK9KxbPsuKjDWctRi1v3jZvSyR6
   Id0SnXw86cjp2hOWFYveiLhhQV2x6s8o6YbPcm00W5hXZXXpKUUDVxzcI
   YVrXFOx29q7WGZP9mSn1aatBlEJbwzuEyMZEkYD1JIHmNbPwy2DQ6nnwK
   wjuBPQ13mTqcrdwAVR3TXjmH8d0ngAUD2CKjhr6MXjwTi2cr8oXoD8oYU
   j0LbbF2Jso28zG5IfY1EcAX/IraSA1cpdd8VKF8KQa2AVARXRo6CK2pAi
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10730"; a="336526535"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="336526535"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2023 02:12:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10730"; a="820804738"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="820804738"
Received: from yfruchte-mobl3.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.219.60])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2023 02:12:08 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 11/16] wifi: mac80211: use correct iftype HE cap
Date:   Sun,  4 Jun 2023 12:11:23 +0300
Message-Id: <20230604120651.0e908e5c5fdd.Iac142549a6144ac949ebd116b921a59ae5282735@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230604091128.609335-1-gregory.greenman@intel.com>
References: <20230604091128.609335-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

We already check that the right iftype capa exists,
but then don't use it. Assign it to a variable so we
can actually use it, and then do that.

Fixes: bac2fd3d7534 ("mac80211: remove use of ieee80211_get_he_sta_cap()")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/mac80211/he.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/net/mac80211/he.c b/net/mac80211/he.c
index 729f261520c7..0322abae0825 100644
--- a/net/mac80211/he.c
+++ b/net/mac80211/he.c
@@ -3,7 +3,7 @@
  * HE handling
  *
  * Copyright(c) 2017 Intel Deutschland GmbH
- * Copyright(c) 2019 - 2022 Intel Corporation
+ * Copyright(c) 2019 - 2023 Intel Corporation
  */
 
 #include "ieee80211_i.h"
@@ -114,6 +114,7 @@ ieee80211_he_cap_ie_to_sta_he_cap(struct ieee80211_sub_if_data *sdata,
 				  struct link_sta_info *link_sta)
 {
 	struct ieee80211_sta_he_cap *he_cap = &link_sta->pub->he_cap;
+	const struct ieee80211_sta_he_cap *own_he_cap_ptr;
 	struct ieee80211_sta_he_cap own_he_cap;
 	struct ieee80211_he_cap_elem *he_cap_ie_elem = (void *)he_cap_ie;
 	u8 he_ppe_size;
@@ -123,12 +124,16 @@ ieee80211_he_cap_ie_to_sta_he_cap(struct ieee80211_sub_if_data *sdata,
 
 	memset(he_cap, 0, sizeof(*he_cap));
 
-	if (!he_cap_ie ||
-	    !ieee80211_get_he_iftype_cap(sband,
-					 ieee80211_vif_type_p2p(&sdata->vif)))
+	if (!he_cap_ie)
 		return;
 
-	own_he_cap = sband->iftype_data->he_cap;
+	own_he_cap_ptr =
+		ieee80211_get_he_iftype_cap(sband,
+					    ieee80211_vif_type_p2p(&sdata->vif));
+	if (!own_he_cap_ptr)
+		return;
+
+	own_he_cap = *own_he_cap_ptr;
 
 	/* Make sure size is OK */
 	mcs_nss_size = ieee80211_he_mcs_nss_size(he_cap_ie_elem);
-- 
2.38.1

