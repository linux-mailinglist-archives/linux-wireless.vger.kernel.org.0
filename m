Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3F007B1FC3
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Sep 2023 16:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbjI1Og1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Sep 2023 10:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbjI1OgZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Sep 2023 10:36:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6268A1AB
        for <linux-wireless@vger.kernel.org>; Thu, 28 Sep 2023 07:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695911783; x=1727447783;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=a0ZX75M2y+8hZSFFirb9c/6IgXBkoLjRWKSfX5uk1JA=;
  b=SCyfLRispxQpVRv8D/hjrSmIGKuqOJheIaObNzt97T5MHkyDyVOvMY8i
   D0++p1G1Knv7OMWKd5wNUpRxc+Xv8HAdwGwpG4g8XR6Hkp00eyxXIo6n/
   l61dgd/zZxTwEsVbJN0vGlr1tJzJkGvLB+aWj6HsZ/uFa7HM8hz6aSzkD
   wNNEhKFASpUqJWRAsJZ5fh6+P/fCOpfF2twmUK70Bj/FxCdkP17hM7fMP
   D6yZCWQO+OdhNcquNsJ7qXvbGomG+vCtNHpHnO8iq9OQRayzPfeyoRkEW
   shothRAZEwLqe+UVWjK7dGF2TfOlpP9c1k0a74ym3kWztNZDU0VLB05a6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="688485"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="688485"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 07:36:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="996590494"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="996590494"
Received: from smoriles-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.92.89])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 07:36:20 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 12/18] wifi: mac80211: Check if we had first beacon with relevant links
Date:   Thu, 28 Sep 2023 17:35:33 +0300
Message-Id: <20230928172905.3fe476aa83e5.Ic1505cf3d60f74580d31efa7e52046947c490b85@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230928143539.1037500-1-gregory.greenman@intel.com>
References: <20230928143539.1037500-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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
Fix this by checking all the active links, if non had a beacon then
protect a session.
If at least one link had a beacon there is no need for session
protection.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/mac80211/mlme.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index e92598dcf3ed..e3db27ec6793 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -2935,9 +2935,20 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
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

