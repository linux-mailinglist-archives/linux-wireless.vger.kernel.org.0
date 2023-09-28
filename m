Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 881B47B1FC5
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Sep 2023 16:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbjI1Ogb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Sep 2023 10:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbjI1Og1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Sep 2023 10:36:27 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B6191AB
        for <linux-wireless@vger.kernel.org>; Thu, 28 Sep 2023 07:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695911785; x=1727447785;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/MlXhS4Cf/tKFho6koTj23yXR4IOzcjC5xLpBJPbqCU=;
  b=FLD4aF2qRUT4rVx8QAxB34ig9Avtmwbh6/6Yztie8rGVyfME+nNPqigL
   wsciehTuARxFYT+rO3yg/D9eSmbrCTEwzdff0sjAXj9zhWq06khoyPo5v
   Pkpy3qbbZs0ThORlXznt+ttLf96V+RqfhaXf6+QYRJsyCebsbrwC8iNRV
   Wdxjl4UhYPwMZt/QV03LzsJjXJVkWRnUUf+5FmxzUR056HuLox778SuFE
   7wvD0mk+4eILuRVYpsMFferUy8IowC0R97zKuokqNOOrdwGZVO9j+ARe2
   /ni6OELbdXFl6MzepYNDeYac5nOtiRWZaoKFV4Hgml2T9r0w5UZRTcpDe
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="688494"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="688494"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 07:36:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="996590511"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="996590511"
Received: from smoriles-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.92.89])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 07:36:22 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 13/18] wifi: mac80211: add link id to mgd_prepare_tx()
Date:   Thu, 28 Sep 2023 17:35:34 +0300
Message-Id: <20230928172905.c7fc59a6780b.Ic88a5037d31e184a2dce0b031ece1a0a93a3a9da@changeid>
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

As we are moving to MLO and links terms, also the airtime protection
will be done for a link rather than for a vif. Thus, some
drivers will need to know for which link to protect airtime.
Add link id as a parameter to the mgd_prepare_tx() callback.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 include/net/mac80211.h    | 3 +++
 net/mac80211/driver-ops.h | 1 +
 net/mac80211/mlme.c       | 9 ++++++++-
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 7dae9aac089c..db3e3bd62a61 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -3641,11 +3641,14 @@ enum ieee80211_reconfig_type {
  * @success: whether the frame exchange was successful, only
  *	used with the mgd_complete_tx() method, and then only
  *	valid for auth and (re)assoc.
+ * @link_id: the link id on which the frame will be TX'ed.
+ *	Only used with the mgd_prepare_tx() method.
  */
 struct ieee80211_prep_tx_info {
 	u16 duration;
 	u16 subtype;
 	u8 success:1;
+	int link_id;
 };
 
 /**
diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
index e07e65da15ee..3c8eb6afd6fd 100644
--- a/net/mac80211/driver-ops.h
+++ b/net/mac80211/driver-ops.h
@@ -928,6 +928,7 @@ static inline void drv_mgd_prepare_tx(struct ieee80211_local *local,
 		return;
 	WARN_ON_ONCE(sdata->vif.type != NL80211_IFTYPE_STATION);
 
+	info->link_id = info->link_id < 0 ? 0 : info->link_id;
 	trace_drv_mgd_prepare_tx(local, sdata, info->duration,
 				 info->subtype, info->success);
 	if (local->ops->mgd_prepare_tx)
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index e3db27ec6793..d19940864774 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -1583,6 +1583,7 @@ static int ieee80211_send_assoc(struct ieee80211_sub_if_data *sdata)
 
 	ifmgd->assoc_req_ies_len = pos - ie_start;
 
+	info.link_id = assoc_data->assoc_link_id;
 	drv_mgd_prepare_tx(local, sdata, &info);
 
 	IEEE80211_SKB_CB(skb)->flags |= IEEE80211_TX_INTFL_DONT_ENCRYPT;
@@ -2947,8 +2948,10 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 				if (link->u.mgd.have_beacon)
 					break;
 			}
-			if (link_id == IEEE80211_MLD_MAX_NUM_LINKS)
+			if (link_id == IEEE80211_MLD_MAX_NUM_LINKS) {
+				info.link_id = ffs(sdata->vif.active_links) - 1;
 				drv_mgd_prepare_tx(sdata->local, sdata, &info);
+			}
 		}
 
 		ieee80211_send_deauth_disassoc(sdata, sdata->vif.cfg.ap_addr,
@@ -3576,6 +3579,7 @@ static void ieee80211_auth_challenge(struct ieee80211_sub_if_data *sdata,
 	u32 tx_flags = 0;
 	struct ieee80211_prep_tx_info info = {
 		.subtype = IEEE80211_STYPE_AUTH,
+		.link_id = auth_data->link_id,
 	};
 
 	pos = mgmt->u.auth.variable;
@@ -6566,6 +6570,7 @@ static int ieee80211_auth(struct ieee80211_sub_if_data *sdata)
 	if (auth_data->algorithm == WLAN_AUTH_SAE)
 		info.duration = jiffies_to_msecs(IEEE80211_AUTH_TIMEOUT_SAE);
 
+	info.link_id = auth_data->link_id;
 	drv_mgd_prepare_tx(local, sdata, &info);
 
 	sdata_info(sdata, "send auth to %pM (try %d/%d)\n",
@@ -7986,6 +7991,7 @@ int ieee80211_mgd_deauth(struct ieee80211_sub_if_data *sdata,
 			   req->bssid, req->reason_code,
 			   ieee80211_get_reason_code_string(req->reason_code));
 
+		info.link_id = ifmgd->auth_data->link_id;
 		drv_mgd_prepare_tx(sdata->local, sdata, &info);
 		ieee80211_send_deauth_disassoc(sdata, req->bssid, req->bssid,
 					       IEEE80211_STYPE_DEAUTH,
@@ -8006,6 +8012,7 @@ int ieee80211_mgd_deauth(struct ieee80211_sub_if_data *sdata,
 			   req->bssid, req->reason_code,
 			   ieee80211_get_reason_code_string(req->reason_code));
 
+		info.link_id = ifmgd->assoc_data->assoc_link_id;
 		drv_mgd_prepare_tx(sdata->local, sdata, &info);
 		ieee80211_send_deauth_disassoc(sdata, req->bssid, req->bssid,
 					       IEEE80211_STYPE_DEAUTH,
-- 
2.38.1

