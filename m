Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D296789D26
	for <lists+linux-wireless@lfdr.de>; Sun, 27 Aug 2023 13:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjH0LGi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 27 Aug 2023 07:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjH0LGS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 27 Aug 2023 07:06:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0FFF109
        for <linux-wireless@vger.kernel.org>; Sun, 27 Aug 2023 04:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693134376; x=1724670376;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/5mbHPLet29vZdL75trvdVix6T0yQW33GidCyXzhSig=;
  b=KvlNUVeqFinlOZk2S+kNGlTfDBCNWitWCwrIU4Ntt9kzYTl+J0i40VAR
   9lLbjD2H3rA8Q5yx4hy57prJVjAr4Grica52wECqm2QCQw3XfmS2VUZK9
   0FdhKOGxi3hR/36xyNqmm14sPV8Ux5Lbmd2S9upT8bygdqe545UYY8zZA
   ErZVWToghHMXt0bJ85qROJN3Rm4PKmkc+HWtLQQFoUuOxPgnWlXq0bIVE
   Y8v07bDa+zxvLFIdSesNsxscMjQGOZLKO5CnrbnoUe3i/SH+RcsKXWXDt
   HYQtxMrVSzDx56CCijgDfi/9Ya1R+UnoH4Ojs4DGnQSWreYdroAmBSQCo
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10814"; a="461301588"
X-IronPort-AV: E=Sophos;i="6.02,205,1688454000"; 
   d="scan'208";a="461301588"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2023 04:06:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="881633023"
Received: from ishamsi-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.251.186.7])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2023 04:06:20 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, Ilan Peer <ilan.peer@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 14/15] wifi: mac80211: Do not force off-channel for management Tx with MLO
Date:   Sun, 27 Aug 2023 14:05:31 +0300
Message-Id: <20230827135854.73c8efce252f.Ie4b0a842debb24ef25c5e6cb2ad69b9f46bc4b2a@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230827110532.348304-1-gregory.greenman@intel.com>
References: <20230827110532.348304-1-gregory.greenman@intel.com>
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

From: Ilan Peer <ilan.peer@intel.com>

When user space transmits a management frame it is expected to use
the MLD addresses if the connection is an MLD one. Thus, in case
the management Tx is using the MLD address and no channel is configured
off-channel should not be used (as one of the active links would be used).

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/mac80211/offchannel.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/offchannel.c b/net/mac80211/offchannel.c
index cdf991e74ab9..18fc984f1b82 100644
--- a/net/mac80211/offchannel.c
+++ b/net/mac80211/offchannel.c
@@ -837,8 +837,14 @@ int ieee80211_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
 		if (!sdata->u.mgd.associated ||
 		    (params->offchan && params->wait &&
 		     local->ops->remain_on_channel &&
-		     memcmp(sdata->vif.cfg.ap_addr, mgmt->bssid, ETH_ALEN)))
+		     memcmp(sdata->vif.cfg.ap_addr, mgmt->bssid, ETH_ALEN))) {
 			need_offchan = true;
+		} else if (sdata->u.mgd.associated &&
+			   ether_addr_equal(sdata->vif.cfg.ap_addr, mgmt->da)) {
+			sta = sta_info_get_bss(sdata, mgmt->da);
+			mlo_sta = sta && sta->sta.mlo;
+		}
+
 		sdata_unlock(sdata);
 		break;
 	case NL80211_IFTYPE_P2P_DEVICE:
-- 
2.38.1

