Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E702B4FFB50
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Apr 2022 18:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236869AbiDMQc2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Apr 2022 12:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236866AbiDMQcZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Apr 2022 12:32:25 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9069062A17
        for <linux-wireless@vger.kernel.org>; Wed, 13 Apr 2022 09:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649867403; x=1681403403;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=4yXpUbWJ+UWLOmXbm/mEZ+Ln9CVd7BfZlhQJHydYkco=;
  b=M7Qf5NOjFbUrdXFZFtHYatCjqj4+JDx6QkC2x6nn4rrEfHc6B9Xg094R
   5sNXiIqcVtQFGKy3a9tiLifxHSHvfwZeAY5hdAy7D+hE7G+6gn6REuJ9F
   1nEaH1pvy9ZAusPEKLi+oZLeMWYFOxB9lODJPAEKuvEoeDtmeE5fkm/sJ
   4=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 13 Apr 2022 09:30:03 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 09:30:03 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 13 Apr 2022 09:30:02 -0700
Received: from ramess-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 13 Apr 2022 09:30:00 -0700
From:   Rameshkumar Sundaram <quic_ramess@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>,
        Lavanya Suresh <lavaks@codeaurora.org>,
        Rameshkumar Sundaram <quic_ramess@quicinc.com>
Subject: [PATCH v5 2/2] mac80211: disable BSS color collision detection in case of no free colors
Date:   Wed, 13 Apr 2022 21:58:15 +0530
Message-ID: <1649867295-7204-3-git-send-email-quic_ramess@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1649867295-7204-1-git-send-email-quic_ramess@quicinc.com>
References: <1649867295-7204-1-git-send-email-quic_ramess@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Lavanya Suresh <lavaks@codeaurora.org>

AP may run out of BSS color after color collision
detection event from driver.

Disable BSS color collision detection if no free colors are
available based on bss color disabled bit sent as a part of
NL80211_ATTR_HE_BSS_COLOR attribute sent in
NL80211_CMD_SET_BEACON.

It can be reenabled once new color is available.

Signed-off-by: Lavanya Suresh <lavaks@codeaurora.org>
Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
---
 net/mac80211/cfg.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 87a2080..789bc62 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1132,9 +1132,9 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 			le32_get_bits(params->he_oper->he_oper_params,
 			      IEEE80211_HE_OPERATION_RTS_THRESHOLD_MASK);
 		changed |= BSS_CHANGED_HE_OBSS_PD;
-
-		if (params->he_bss_color.enabled)
-			changed |= BSS_CHANGED_HE_BSS_COLOR;
+		if (params->beacon.he_bss_color_valid)
+			if (params->beacon.he_bss_color.enabled)
+				changed |= BSS_CHANGED_HE_BSS_COLOR;
 	}
 
 	if (sdata->vif.type == NL80211_IFTYPE_AP &&
@@ -1190,7 +1190,8 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 	sdata->vif.bss_conf.allow_p2p_go_ps = sdata->vif.p2p;
 	sdata->vif.bss_conf.twt_responder = params->twt_responder;
 	sdata->vif.bss_conf.he_obss_pd = params->he_obss_pd;
-	sdata->vif.bss_conf.he_bss_color = params->he_bss_color;
+	if (params->beacon.he_bss_color_valid)
+		sdata->vif.bss_conf.he_bss_color = params->beacon.he_bss_color;
 	sdata->vif.bss_conf.s1g = params->chandef.chan->band ==
 				  NL80211_BAND_S1GHZ;
 
@@ -1275,6 +1276,7 @@ static int ieee80211_change_beacon(struct wiphy *wiphy, struct net_device *dev,
 				   struct cfg80211_beacon_data *params)
 {
 	struct ieee80211_sub_if_data *sdata;
+	struct ieee80211_bss_conf *bss_conf;
 	struct beacon_data *old;
 	int err;
 
@@ -1294,6 +1296,13 @@ static int ieee80211_change_beacon(struct wiphy *wiphy, struct net_device *dev,
 	err = ieee80211_assign_beacon(sdata, params, NULL, NULL);
 	if (err < 0)
 		return err;
+
+	bss_conf = &sdata->vif.bss_conf;
+	if (params->he_bss_color_valid &&
+	    params->he_bss_color.enabled != bss_conf->he_bss_color.enabled) {
+		bss_conf->he_bss_color.enabled = params->he_bss_color.enabled;
+		err |= BSS_CHANGED_HE_BSS_COLOR;
+	}
 	ieee80211_bss_info_change_notify(sdata, err);
 	return 0;
 }
-- 
2.7.4

