Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E639152C47E
	for <lists+linux-wireless@lfdr.de>; Wed, 18 May 2022 22:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242631AbiERUjj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 May 2022 16:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242611AbiERUjh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 May 2022 16:39:37 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 566752A719
        for <linux-wireless@vger.kernel.org>; Wed, 18 May 2022 13:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652906377; x=1684442377;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UgOQsKRq/CMRsFLRPlsRo1bPiN/VCCOeYP/RKQapaSQ=;
  b=nj81pEe0SsMRpMDcMwSZI61bZ0HyyYUFY8A6qwdltsYXlHjMFdTblWPY
   ooeHyE/0ep0ZceNHGH/kNsrr3qMYx6/vDKjVfFqSaXvplGcJ7PROUfSsU
   oPUKS9P1TVw1haF2jF84M3pV3mEnVo6e9ldQmxMCsJXzeO4Yg2/oDwjb3
   c=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 18 May 2022 13:39:37 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 13:39:36 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 18 May 2022 13:39:36 -0700
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 18 May 2022 13:39:36 -0700
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>
CC:     Aloka Dixit <quic_alokad@quicinc.com>
Subject: [PATCH v6 3/3] mac80211: additional processing in ieee80211_change_beacon
Date:   Wed, 18 May 2022 13:39:22 -0700
Message-ID: <20220518203922.26417-4-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220518203922.26417-1-quic_alokad@quicinc.com>
References: <20220518203922.26417-1-quic_alokad@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
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

Process FILS discovery and unsolicited broadcast probe response
transmission configurations in ieee80211_change_beacon().

Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
---
 net/mac80211/cfg.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 8b1600e90ca8..1054b6625c53 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1320,6 +1320,7 @@ static int ieee80211_change_beacon(struct wiphy *wiphy, struct net_device *dev,
 	struct cfg80211_beacon_data *beacon = &params->beacon;
 	struct beacon_data *old;
 	int err;
+	u32 changed;
 
 	sdata = IEEE80211_DEV_TO_SUB_IF(dev);
 	sdata_assert_lock(sdata);
@@ -1338,14 +1339,32 @@ static int ieee80211_change_beacon(struct wiphy *wiphy, struct net_device *dev,
 	if (err < 0)
 		return err;
 
+	changed = err;
+
+	if (params->fils_discovery.max_interval) {
+		err = ieee80211_set_fils_discovery(sdata,
+						   &params->fils_discovery);
+		if (err < 0)
+			return err;
+		changed |= BSS_CHANGED_FILS_DISCOVERY;
+	}
+
+	if (params->unsol_bcast_probe_resp.interval) {
+		err = ieee80211_set_unsol_bcast_probe_resp(sdata,
+							   &params->unsol_bcast_probe_resp);
+		if (err < 0)
+			return err;
+		changed |= BSS_CHANGED_UNSOL_BCAST_PROBE_RESP;
+	}
+
 	bss_conf = &sdata->vif.bss_conf;
 	if (beacon->he_bss_color_valid &&
 	    beacon->he_bss_color.enabled != bss_conf->he_bss_color.enabled) {
 		bss_conf->he_bss_color.enabled = beacon->he_bss_color.enabled;
-		err |= BSS_CHANGED_HE_BSS_COLOR;
+		changed |= BSS_CHANGED_HE_BSS_COLOR;
 	}
 
-	ieee80211_bss_info_change_notify(sdata, err);
+	ieee80211_bss_info_change_notify(sdata, changed);
 	return 0;
 }
 
-- 
2.31.1

