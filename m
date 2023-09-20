Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3D37A8BB9
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Sep 2023 20:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjITS1S (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Sep 2023 14:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbjITS1Q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Sep 2023 14:27:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7157CF0
        for <linux-wireless@vger.kernel.org>; Wed, 20 Sep 2023 11:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695234425; x=1726770425;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TZ+FBGJaqRanprzIDQChvOfo7GQuqtWHc70H4UXsRQU=;
  b=WwiIRF5kZ/dlw1Ykf+0/AkVNOzuyYgpL4C8biBTCet4+RcIuXxBL9AT+
   AJhoxsaeM332sBKQ7byWhA7nc1cUF5sWPwIF5u+2utIVq84Uisw7hFuyM
   2xyd2AGBcprHG/3SWcotO2akQ16j6nabhHyRj4vfDncUmXS737p1jh52W
   gDz1An2ciTA3B5wQeKCu+EnhBIpzccsegOPjNml93oNfRWcdEQLUgyhSx
   p+/2hqa8ktl5vKG64jIoZ3CCHdm9TZUlIt0dlhj1OgO/vpP+pA0lF/k/a
   JFg1c/F5kQeg9yg+cv4XvqbwMsI0L1z3PcSxsO/OqhnXCRIDFAYOFJRjq
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="360556494"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="360556494"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 11:26:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="723424294"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="723424294"
Received: from dmani-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.217.100])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 11:26:52 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Benjamin Berg <benjamin.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH v2 18/18] wifi: mac80211: reject MLO channel configuration if not supported
Date:   Wed, 20 Sep 2023 21:25:29 +0300
Message-Id: <20230920211508.80c3b8e5a344.Iaa2d466ee6280994537e1ae7ab9256a27934806f@changeid>
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

From: Benjamin Berg <benjamin.berg@intel.com>

Reject configuring a channel for MLO if either EHT is not supported or
the BSS does not have the correct ML element. This avoids trying to do
a multi-link association with a misconfigured AP.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/mac80211/mlme.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index a10b9420aa68..dc9a94bd3b11 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -4778,6 +4778,7 @@ ieee80211_verify_sta_eht_mcs_support(struct ieee80211_sub_if_data *sdata,
 static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 				  struct ieee80211_link_data *link,
 				  struct cfg80211_bss *cbss,
+				  bool mlo,
 				  ieee80211_conn_flags_t *conn_flags)
 {
 	struct ieee80211_local *local = sdata->local;
@@ -4791,6 +4792,7 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 	struct cfg80211_chan_def chandef;
 	bool is_6ghz = cbss->channel->band == NL80211_BAND_6GHZ;
 	bool is_5ghz = cbss->channel->band == NL80211_BAND_5GHZ;
+	bool supports_mlo = false;
 	struct ieee80211_bss *bss = (void *)cbss->priv;
 	struct ieee80211_elems_parse_params parse_params = {
 		.link_id = -1,
@@ -4944,6 +4946,8 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 		    ieee80211_mle_type_ok(eht_ml_elem->data + 1,
 					  IEEE80211_ML_CONTROL_TYPE_BASIC,
 					  eht_ml_elem->datalen - 1)) {
+			supports_mlo = true;
+
 			sdata->vif.cfg.eml_cap =
 				ieee80211_mle_get_eml_cap(eht_ml_elem->data + 1);
 			sdata->vif.cfg.eml_med_sync_delay =
@@ -4999,6 +5003,11 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 		return -EINVAL;
 	}
 
+	if (mlo && !supports_mlo) {
+		sdata_info(sdata, "Rejecting MLO as it is not supported by AP\n");
+		return -EINVAL;
+	}
+
 	if (!link)
 		return 0;
 
@@ -5147,7 +5156,7 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 		link->conf->dtim_period = link->u.mgd.dtim_period ?: 1;
 
 		if (link_id != assoc_data->assoc_link_id) {
-			err = ieee80211_prep_channel(sdata, link, cbss,
+			err = ieee80211_prep_channel(sdata, link, cbss, true,
 						     &link->u.mgd.conn_flags);
 			if (err) {
 				link_info(link, "prep_channel failed\n");
@@ -7182,7 +7191,7 @@ static int ieee80211_prep_connection(struct ieee80211_sub_if_data *sdata,
 	}
 
 	if (new_sta || override) {
-		err = ieee80211_prep_channel(sdata, link, cbss,
+		err = ieee80211_prep_channel(sdata, link, cbss, mlo,
 					     &link->u.mgd.conn_flags);
 		if (err) {
 			if (new_sta)
@@ -7887,7 +7896,8 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 		if (i == assoc_data->assoc_link_id)
 			continue;
 		/* only calculate the flags, hence link == NULL */
-		err = ieee80211_prep_channel(sdata, NULL, assoc_data->link[i].bss,
+		err = ieee80211_prep_channel(sdata, NULL,
+					     assoc_data->link[i].bss, true,
 					     &assoc_data->link[i].conn_flags);
 		if (err) {
 			req->links[i].error = err;
-- 
2.38.1

