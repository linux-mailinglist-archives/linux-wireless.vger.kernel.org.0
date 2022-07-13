Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4C7C573A40
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 17:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236983AbiGMPex (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 11:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236948AbiGMPen (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 11:34:43 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14533E759
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 08:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=SYp1nGWB1c7Fqq0rzR1qutAi5Q5rPYKGDJF8yVQI5oc=;
        t=1657726482; x=1658936082; b=vaxByOH+7MTZCBwYuV2qi5PSVTUB8JPgGqo+Z5OeQeAaQsv
        rID4do5HFq3Zu7czOu44RspfydbtvHq/lQzsbfdwhINoylpAt3onC978wj/lvQKojnK3IEaTmgasM
        EJIQa+b8kijbgvHWBsCi9voKdz6cnmRoZENOZOxt9E8X9DdumuEimz/QPUiFKwpcB6GbDl1+zvvgP
        X+80VwOJ5LmJWWaf05Cqn0yVg0bndnBqCdxwChgFXnKBJqjAEO/NpFOCcmkvmAqxFgzc0eUmhr6+z
        DjdQUUKj1gYmrgLLCBVxEMIH6Vo6MdxmpBOa/P48RPcx+9GAynJMx92jeEBMVJsw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBeNs-00EnaA-8N;
        Wed, 13 Jul 2022 17:34:40 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 12/21] wifi: mac80211: mlme: change flags in ieee80211_determine_chantype()
Date:   Wed, 13 Jul 2022 17:34:24 +0200
Message-Id: <20220713173301.489328a4528e.I0992138c10a86c160a24a52944fbf5639d0de179@changeid>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220713153433.279227-1-johannes@sipsolutions.net>
References: <20220713153433.279227-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

For MLO we'll need to read flags not directly from the link as
it may not even exist yet if we're just setting up flags for
a secondary link before sending the association request, so
pass the incoming conn_flags separately. Also, while at it,
pass the sdata/link separately as for non-tracking now the
link may be NULL.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/mlme.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 3b4d0bc35b5d..03f6da885ce4 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -143,7 +143,9 @@ static int ecw2cw(int ecw)
 }
 
 static ieee80211_conn_flags_t
-ieee80211_determine_chantype(struct ieee80211_link_data *link,
+ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
+			     struct ieee80211_link_data *link,
+			     ieee80211_conn_flags_t conn_flags,
 			     struct ieee80211_supported_band *sband,
 			     struct ieee80211_channel *channel,
 			     u32 vht_cap_info,
@@ -154,7 +156,6 @@ ieee80211_determine_chantype(struct ieee80211_link_data *link,
 			     const struct ieee80211_s1g_oper_ie *s1g_oper,
 			     struct cfg80211_chan_def *chandef, bool tracking)
 {
-	struct ieee80211_sub_if_data *sdata = link->sdata;
 	struct cfg80211_chan_def vht_chandef;
 	struct ieee80211_sta_ht_cap sta_ht_cap;
 	ieee80211_conn_flags_t ret;
@@ -249,7 +250,7 @@ ieee80211_determine_chantype(struct ieee80211_link_data *link,
 	}
 
 	vht_chandef = *chandef;
-	if (!(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HE) &&
+	if (!(conn_flags & IEEE80211_CONN_DISABLE_HE) &&
 	    he_oper &&
 	    (le32_to_cpu(he_oper->he_oper_params) &
 	     IEEE80211_HE_OPERATION_VHT_OPER_INFO)) {
@@ -265,7 +266,7 @@ ieee80211_determine_chantype(struct ieee80211_link_data *link,
 		if (!ieee80211_chandef_vht_oper(&sdata->local->hw, vht_cap_info,
 						&he_oper_vht_cap, ht_oper,
 						&vht_chandef)) {
-			if (!(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HE))
+			if (!(conn_flags & IEEE80211_CONN_DISABLE_HE))
 				sdata_info(sdata,
 					   "HE AP VHT information is invalid, disabling HE\n");
 			ret = IEEE80211_CONN_DISABLE_HE | IEEE80211_CONN_DISABLE_EHT;
@@ -275,7 +276,7 @@ ieee80211_determine_chantype(struct ieee80211_link_data *link,
 					       vht_cap_info,
 					       vht_oper, ht_oper,
 					       &vht_chandef)) {
-		if (!(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_VHT))
+		if (!(conn_flags & IEEE80211_CONN_DISABLE_VHT))
 			sdata_info(sdata,
 				   "AP VHT information is invalid, disabling VHT\n");
 		ret = IEEE80211_CONN_DISABLE_VHT;
@@ -283,7 +284,7 @@ ieee80211_determine_chantype(struct ieee80211_link_data *link,
 	}
 
 	if (!cfg80211_chandef_valid(&vht_chandef)) {
-		if (!(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_VHT))
+		if (!(conn_flags & IEEE80211_CONN_DISABLE_VHT))
 			sdata_info(sdata,
 				   "AP VHT information is invalid, disabling VHT\n");
 		ret = IEEE80211_CONN_DISABLE_VHT;
@@ -296,7 +297,7 @@ ieee80211_determine_chantype(struct ieee80211_link_data *link,
 	}
 
 	if (!cfg80211_chandef_compatible(chandef, &vht_chandef)) {
-		if (!(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_VHT))
+		if (!(conn_flags & IEEE80211_CONN_DISABLE_VHT))
 			sdata_info(sdata,
 				   "AP VHT information doesn't match HT, disabling VHT\n");
 		ret = IEEE80211_CONN_DISABLE_VHT;
@@ -319,7 +320,7 @@ ieee80211_determine_chantype(struct ieee80211_link_data *link,
 					   false, &eht_chandef);
 
 		if (!cfg80211_chandef_valid(&eht_chandef)) {
-			if (!(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_EHT))
+			if (!(conn_flags & IEEE80211_CONN_DISABLE_EHT))
 				sdata_info(sdata,
 					   "AP EHT information is invalid, disabling EHT\n");
 			ret = IEEE80211_CONN_DISABLE_EHT;
@@ -327,7 +328,7 @@ ieee80211_determine_chantype(struct ieee80211_link_data *link,
 		}
 
 		if (!cfg80211_chandef_compatible(chandef, &eht_chandef)) {
-			if (!(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_EHT))
+			if (!(conn_flags & IEEE80211_CONN_DISABLE_EHT))
 				sdata_info(sdata,
 					   "AP EHT information is incompatible, disabling EHT\n");
 			ret = IEEE80211_CONN_DISABLE_EHT;
@@ -462,7 +463,9 @@ static int ieee80211_config_bw(struct ieee80211_link_data *link,
 		vht_cap_info = le32_to_cpu(vht_cap->vht_cap_info);
 
 	/* calculate new channel (type) based on HT/VHT/HE operation IEs */
-	flags = ieee80211_determine_chantype(link, sband, chan, vht_cap_info,
+	flags = ieee80211_determine_chantype(sdata, link,
+					     link->u.mgd.conn_flags,
+					     sband, chan, vht_cap_info,
 					     ht_oper, vht_oper,
 					     he_oper, eht_oper,
 					     s1g_oper, &chandef, true);
@@ -4005,8 +4008,9 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 	}
 
 	link->u.mgd.conn_flags |=
-		ieee80211_determine_chantype(link, sband,
-					     cbss->channel,
+		ieee80211_determine_chantype(sdata, link,
+					     link->u.mgd.conn_flags,
+					     sband, cbss->channel,
 					     bss->vht_cap_info,
 					     ht_oper, vht_oper,
 					     he_oper, eht_oper,
-- 
2.36.1

