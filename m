Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1659D5F54DC
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Oct 2022 15:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbiJENBN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Oct 2022 09:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbiJENA4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Oct 2022 09:00:56 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274D11EC57
        for <linux-wireless@vger.kernel.org>; Wed,  5 Oct 2022 06:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=/RqE2piYLSb2iWPmGM7rXLTDwSSGim0jODuygFBxsEc=;
        t=1664974855; x=1666184455; b=REt0fkwB+7quwhn3tJ5RPog1QfbAy9OomCO8Z3jBbs1Ys5x
        2oPCqvvxKJGI6wu9855A+f9mLpnUvjY0FgLZTwv+JFyyhgex6K2mXJURg6HBPGfGZh8GETrQKnEzr
        AuT2lJXsjUcHkufcFwGFEuxSeZZk9YSU/AVJxVp6/g2jZVAj4M76/sR1MBbRlrAAUf9CCk3FNo53B
        wLkGsnDTquoodpI4j+ZiHsW4Q+aB3sbz93cSOcsIyqWFnf8dkidgPZmB+l93WAn1eVm2r6yH2WM+1
        sPxLNdMBFNleOPUPcZ+RlC1kYq2wjBLIh+Z+LgU7gUsRs/+Hyz9WyGQG80aFUjzQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1og416-00G2RL-39;
        Wed, 05 Oct 2022 15:00:53 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH 10/28] wifi: mac80211: Process association status for affiliated links
Date:   Wed,  5 Oct 2022 15:00:30 +0200
Message-Id: <20221005145226.ca9ee81680b3.I6c6b73b6c0433a3433a324945ef56a1244a11c65@changeid>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221005130048.217341-1-johannes@sipsolutions.net>
References: <20221005130048.217341-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ilan Peer <ilan.peer@intel.com>

In case the AP returned a non success status for one of the links,
do not activate the link.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/ieee80211_i.h |  2 ++
 net/mac80211/mlme.c        | 40 +++++++++++++++++++++++++++++++++-----
 2 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 5dcbc8de53fd..517a50abdb09 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -412,6 +412,8 @@ struct ieee80211_mgd_assoc_data {
 		u8 *elems; /* pointing to inside ie[] below */
 
 		ieee80211_conn_flags_t conn_flags;
+
+		u16 status;
 	} link[IEEE80211_MLD_MAX_NUM_LINKS];
 
 	u8 ap_addr[ETH_ALEN] __aligned(2);
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index a7e06c8ddaf3..2e4bb75c68c0 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -2754,7 +2754,8 @@ static void ieee80211_set_associated(struct ieee80211_sub_if_data *sdata,
 		struct cfg80211_bss *cbss = assoc_data->link[link_id].bss;
 		struct ieee80211_link_data *link;
 
-		if (!cbss)
+		if (!cbss ||
+		    assoc_data->link[link_id].status != WLAN_STATUS_SUCCESS)
 			continue;
 
 		link = sdata_dereference(sdata->link[link_id], sdata);
@@ -2782,7 +2783,8 @@ static void ieee80211_set_associated(struct ieee80211_sub_if_data *sdata,
 			struct ieee80211_link_data *link;
 			struct cfg80211_bss *cbss = assoc_data->link[link_id].bss;
 
-			if (!cbss)
+			if (!cbss ||
+			    assoc_data->link[link_id].status != WLAN_STATUS_SUCCESS)
 				continue;
 
 			link = sdata_dereference(sdata->link[link_id], sdata);
@@ -3945,6 +3947,12 @@ static bool ieee80211_assoc_config_link(struct ieee80211_link_data *link,
 
 	if (link_id == assoc_data->assoc_link_id) {
 		capab_info = le16_to_cpu(mgmt->u.assoc_resp.capab_info);
+
+		/*
+		 * we should not get to this flow unless the association was
+		 * successful, so set the status directly to success
+		 */
+		assoc_data->link[link_id].status = WLAN_STATUS_SUCCESS;
 	} else if (!elems->prof) {
 		ret = false;
 		goto out;
@@ -3952,8 +3960,19 @@ static bool ieee80211_assoc_config_link(struct ieee80211_link_data *link,
 		const u8 *ptr = elems->prof->variable +
 				elems->prof->sta_info_len - 1;
 
-		/* FIXME: need to also handle the status code */
+		/*
+		 * During parsing, we validated that these fields exist,
+		 * otherwise elems->prof would have been set to NULL.
+		 */
 		capab_info = get_unaligned_le16(ptr);
+		assoc_data->link[link_id].status = get_unaligned_le16(ptr + 2);
+
+		if (assoc_data->link[link_id].status != WLAN_STATUS_SUCCESS) {
+			link_info(link, "association response status code=%u\n",
+				  assoc_data->link[link_id].status);
+			ret = true;
+			goto out;
+		}
 	}
 
 	if (!is_s1g && !elems->supp_rates) {
@@ -4874,6 +4893,7 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 	unsigned int link_id;
 	struct sta_info *sta;
 	u64 changed[IEEE80211_MLD_MAX_NUM_LINKS] = {};
+	u16 valid_links = 0;
 	int err;
 
 	mutex_lock(&sdata->local->sta_mtx);
@@ -4886,8 +4906,6 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 		goto out_err;
 
 	if (sdata->vif.valid_links) {
-		u16 valid_links = 0;
-
 		for (link_id = 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS; link_id++) {
 			if (!assoc_data->link[link_id].bss)
 				continue;
@@ -4957,6 +4975,12 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 						 &changed[link_id]))
 			goto out_err;
 
+		if (assoc_data->link[link_id].status != WLAN_STATUS_SUCCESS) {
+			valid_links &= ~BIT(link_id);
+			ieee80211_sta_remove_link(sta, link_id);
+			continue;
+		}
+
 		if (link_id != assoc_data->assoc_link_id) {
 			err = ieee80211_sta_activate_link(sta, link_id);
 			if (err)
@@ -4964,6 +4988,9 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 		}
 	}
 
+	/* links might have changed due to rejected ones, set them again */
+	ieee80211_vif_set_links(sdata, valid_links);
+
 	rate_control_rate_init(sta);
 
 	if (ifmgd->flags & IEEE80211_STA_MFP_ENABLED) {
@@ -5197,10 +5224,13 @@ static void ieee80211_rx_mgmt_assoc_resp(struct ieee80211_sub_if_data *sdata,
 		link = sdata_dereference(sdata->link[link_id], sdata);
 		if (!link)
 			continue;
+
 		if (!assoc_data->link[link_id].bss)
 			continue;
+
 		resp.links[link_id].bss = assoc_data->link[link_id].bss;
 		resp.links[link_id].addr = link->conf->addr;
+		resp.links[link_id].status = assoc_data->link[link_id].status;
 
 		/* get uapsd queues configuration - same for all links */
 		resp.uapsd_queues = 0;
-- 
2.37.3

