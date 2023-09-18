Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9677A4814
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Sep 2023 13:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241392AbjIRLMY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Sep 2023 07:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241171AbjIRLLr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Sep 2023 07:11:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 805E7C3
        for <linux-wireless@vger.kernel.org>; Mon, 18 Sep 2023 04:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695035501; x=1726571501;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=53pYuu+MEOeCHl72WU349izM3mAA9KUXodCVH992Q5U=;
  b=iCNGEbSUyUmGdaVFbp5nayQjOQrp+v++ExcbiwLnGbZA1ek34w8kANfB
   mDJOVuTbTU5xwQrZpkmxoUbqIsPCjIHh9W5ANhgX62Hna8yp7k35k2oR3
   4AJx9bUqzjyIbQjKqkZWxjkIuBkwnEslK7VgSxNlhqm7DgtswZ5kOqAE4
   9WNZK0vQdbCiV+3CojQaV3EWYVz846VionGm4HDe+EO50OLPzKryqrd0B
   ZoBxfAjrDW+MbSTycVs03nQ9eX+hIeJDh4rg9oWfeRa2m37F9jm6PZVZK
   0qTTxdRzeLoXq4/QUzEqAs4AszLjJA4fRFbT05bW0EpKDaB4WqgxTbHVy
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="378535741"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="378535741"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 04:11:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="861025257"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="861025257"
Received: from guyarad-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.215.14])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 04:11:25 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Ayala Beker <ayala.beker@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 03/18] wifi: mac80211: don't connect to an AP while it's in a CSA process
Date:   Mon, 18 Sep 2023 14:10:48 +0300
Message-Id: <20230918140607.dca69ce27501.I9745c695f3403b259ad000ce94110588a836c04a@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230918111103.435195-1-gregory.greenman@intel.com>
References: <20230918111103.435195-1-gregory.greenman@intel.com>
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

From: Ayala Beker <ayala.beker@intel.com>

Connection to an AP that is running a CSA flow may end up with a
failure as the AP might change its channel during the connection
flow while we do not track the channel change yet.
Avoid that by rejecting a connection to such an AP.

Signed-off-by: Ayala Beker <ayala.beker@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/mac80211/mlme.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index a211f594f25a..a85873f305bf 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -7015,6 +7015,7 @@ int ieee80211_mgd_auth(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
 	struct ieee80211_mgd_auth_data *auth_data;
 	struct ieee80211_link_data *link;
+	const struct element *csa_elem, *ecsa_elem;
 	u16 auth_alg;
 	int err;
 	bool cont_auth;
@@ -7057,6 +7058,22 @@ int ieee80211_mgd_auth(struct ieee80211_sub_if_data *sdata,
 	if (ifmgd->assoc_data)
 		return -EBUSY;
 
+	rcu_read_lock();
+	csa_elem = ieee80211_bss_get_elem(req->bss, WLAN_EID_CHANNEL_SWITCH);
+	ecsa_elem = ieee80211_bss_get_elem(req->bss,
+					   WLAN_EID_EXT_CHANSWITCH_ANN);
+	if ((csa_elem &&
+	     csa_elem->datalen == sizeof(struct ieee80211_channel_sw_ie) &&
+	     ((struct ieee80211_channel_sw_ie *)csa_elem->data)->count != 0) ||
+	    (ecsa_elem &&
+	     ecsa_elem->datalen == sizeof(struct ieee80211_ext_chansw_ie) &&
+	     ((struct ieee80211_ext_chansw_ie *)ecsa_elem->data)->count != 0)) {
+		rcu_read_unlock();
+		sdata_info(sdata, "AP is in CSA process, reject auth\n");
+		return -EINVAL;
+	}
+	rcu_read_unlock();
+
 	auth_data = kzalloc(sizeof(*auth_data) + req->auth_data_len +
 			    req->ie_len, GFP_KERNEL);
 	if (!auth_data)
@@ -7364,7 +7381,7 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
 	struct ieee80211_mgd_assoc_data *assoc_data;
-	const struct element *ssid_elem;
+	const struct element *ssid_elem, *csa_elem, *ecsa_elem;
 	struct ieee80211_vif_cfg *vif_cfg = &sdata->vif.cfg;
 	ieee80211_conn_flags_t conn_flags = 0;
 	struct ieee80211_link_data *link;
@@ -7394,6 +7411,21 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 		kfree(assoc_data);
 		return -EINVAL;
 	}
+
+	csa_elem = ieee80211_bss_get_elem(cbss, WLAN_EID_CHANNEL_SWITCH);
+	ecsa_elem = ieee80211_bss_get_elem(cbss, WLAN_EID_EXT_CHANSWITCH_ANN);
+	if ((csa_elem &&
+	     csa_elem->datalen == sizeof(struct ieee80211_channel_sw_ie) &&
+	     ((struct ieee80211_channel_sw_ie *)csa_elem->data)->count != 0) ||
+	    (ecsa_elem &&
+	     ecsa_elem->datalen == sizeof(struct ieee80211_ext_chansw_ie) &&
+	     ((struct ieee80211_ext_chansw_ie *)ecsa_elem->data)->count != 0)) {
+		sdata_info(sdata, "AP is in CSA process, reject assoc\n");
+		rcu_read_unlock();
+		kfree(assoc_data);
+		return -EINVAL;
+	}
+
 	memcpy(assoc_data->ssid, ssid_elem->data, ssid_elem->datalen);
 	assoc_data->ssid_len = ssid_elem->datalen;
 	memcpy(vif_cfg->ssid, assoc_data->ssid, assoc_data->ssid_len);
-- 
2.38.1

