Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC4E7A4827
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Sep 2023 13:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241360AbjIRLNX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Sep 2023 07:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241489AbjIRLM6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Sep 2023 07:12:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A64421AA
        for <linux-wireless@vger.kernel.org>; Mon, 18 Sep 2023 04:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695035540; x=1726571540;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OUtYvwpO0H+XRS3io6+wo0RTBNqGGonEZV9bgPCtep0=;
  b=LuEQuyiQ8DHuDP3isyN1X9wTAAm/CVWOMBq/11ah55Sh/IYEV4XC16h9
   sefDbyEPrt9Ln+iBUOLve7jTxcB4msOBb/cb7D0yALZvP20RXCpiBCckp
   bVqGgWzbEQqPZH3xdD6VmgcbMHrgVHq2PCbHXEtHasJza3YI4ZqDjVo2R
   KykCTqTD/ZRSDVjW8/7S1fsXdHsLqxT3tnapPOLDMsXT2TQ9u9lsz19CV
   VhX0ft88kilht7f3Jh0LoWLx4zYRWWBDb1+u2bdL4sfH9+RB3bNNQ6FkW
   StjkaVUe5rIDp7kpG/dyYImxIt4d5vuEfJPz9I+Iy5s0v+m/AFw5kUCBO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="378536006"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="378536006"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 04:12:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="861025606"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="861025606"
Received: from guyarad-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.215.14])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 04:12:18 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Benjamin Berg <benjamin.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 18/18] wifi: mac80211: reject MLO channel configuration if not supported
Date:   Mon, 18 Sep 2023 14:11:03 +0300
Message-Id: <20230918140607.3096546632e5.Iaa2d466ee6280994537e1ae7ab9256a27934806f@changeid>
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
index 10a762816146..331221226dcd 100644
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

