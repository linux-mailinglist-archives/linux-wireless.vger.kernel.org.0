Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF6C17A8BA9
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Sep 2023 20:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjITS0a (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Sep 2023 14:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjITS02 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Sep 2023 14:26:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E568DE
        for <linux-wireless@vger.kernel.org>; Wed, 20 Sep 2023 11:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695234380; x=1726770380;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=53pYuu+MEOeCHl72WU349izM3mAA9KUXodCVH992Q5U=;
  b=IwVeQC7iYylnuaoSEuH+1CrXHl0aciLbfZvH3Ic5936gbpWXIEHcIazI
   +3vZDefoDqo9zo+f59L1jpMURMnrrO5NaMsSVNR2JjjgfCaI3HbAGFXyh
   VyDA0kJfAE6sLHLiT+BYKZHsR1ebL3YZwIPqnH2eQ1irzLwPx/JM583a2
   96F5Gk7xskX3bwRjaslEmL0k+PItzGldndDHTBJE4ECPKlKF31I4pJt+h
   WnGMwahE8vq9w4p8SzwEjMFSaB/Vvk39xgl/0G7xQHfJqEV/V8l0JT2w5
   tN0sPCleqBX+Ir4ZPrs1jCqdYJGqfyg2pFrS6iJVZvGKy2civl8d6ONzB
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="360556317"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="360556317"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 11:26:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="723424212"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="723424212"
Received: from dmani-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.217.100])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 11:26:18 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Ayala Beker <ayala.beker@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH v2 03/18] wifi: mac80211: don't connect to an AP while it's in a CSA process
Date:   Wed, 20 Sep 2023 21:25:14 +0300
Message-Id: <20230920211508.e5001a762a4a.I9745c695f3403b259ad000ce94110588a836c04a@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230920182529.659973-1-gregory.greenman@intel.com>
References: <20230920182529.659973-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

