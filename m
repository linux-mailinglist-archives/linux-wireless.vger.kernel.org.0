Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB57B7B7B6A
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Oct 2023 11:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241885AbjJDJMs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Oct 2023 05:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232913AbjJDJMr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Oct 2023 05:12:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B39A6
        for <linux-wireless@vger.kernel.org>; Wed,  4 Oct 2023 02:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696410764; x=1727946764;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=f8CC7SDz967K5KY+0M3Gkk5o9lmtnPDemAdlwYxrQmo=;
  b=Q3f3twb88htKVO+wbREBScqrWYb7Nk/Nuk+Jf+PIZ+S33r6c/jbPr51G
   Ml6QdyIruFX0jbpMCiz9My8MgmHEiQuElUwGQUHwZhhtdLHKaSSkG1d+4
   bK0+/xUYPl8RFWVy/4DponGnDUCxKEzPIVfk8XZzWVjgvLOlLXNrD3gdV
   sRr4DPoRkgrvbgV2yn682Yubpef3otye75Y1pp0aNPRyZF1eiHzqix4IQ
   IY0+fkOoQqapM9RtzmHGF9GjosLgFwdsaK78gJ2nCIFOrqr9aXgpuXT9h
   53GCCqMZfvsdrnW4i2Q/BAy25NCBy9mT13Hv3ECIwcWhTjN//TfJupvo7
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="380387041"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="380387041"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 02:12:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="727930994"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="727930994"
Received: from oferweis-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.222.21])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 02:12:41 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH v2 12/18] wifi: mac80211: Check if we had first beacon with relevant links
Date:   Wed,  4 Oct 2023 12:12:02 +0300
Message-Id: <20231004120820.d290f0ab77b0.Ic1505cf3d60f74580d31efa7e52046947c490b85@changeid>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

If there is a disassoc before the fisrt beacon we need to protect a
session for the deauth frame. Currently we are checking if we had a
beacon in the default link, which is wrong in a MLO connection and
link id != 0.
Fix this by checking all the active links, if none had a beacon then
protect a session.
If at least one link had a beacon there is no need for session
protection.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
v2: fixed a typo in commit message
---
 net/mac80211/mlme.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index ad4d8b191b39..8c8f2b633f85 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -2936,9 +2936,20 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 		 * deauthentication frame by calling mgd_prepare_tx, if the
 		 * driver requested so.
 		 */
-		if (ieee80211_hw_check(&local->hw, DEAUTH_NEED_MGD_TX_PREP) &&
-		    !sdata->deflink.u.mgd.have_beacon) {
-			drv_mgd_prepare_tx(sdata->local, sdata, &info);
+		if (ieee80211_hw_check(&local->hw, DEAUTH_NEED_MGD_TX_PREP)) {
+			for (link_id = 0; link_id < ARRAY_SIZE(sdata->link);
+			     link_id++) {
+				struct ieee80211_link_data *link;
+
+				link = sdata_dereference(sdata->link[link_id],
+							 sdata);
+				if (!link)
+					continue;
+				if (link->u.mgd.have_beacon)
+					break;
+			}
+			if (link_id == IEEE80211_MLD_MAX_NUM_LINKS)
+				drv_mgd_prepare_tx(sdata->local, sdata, &info);
 		}
 
 		ieee80211_send_deauth_disassoc(sdata, sdata->vif.cfg.ap_addr,
-- 
2.38.1

