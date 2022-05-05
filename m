Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCF451C634
	for <lists+linux-wireless@lfdr.de>; Thu,  5 May 2022 19:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232443AbiEERjY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 May 2022 13:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382757AbiEERio (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 May 2022 13:38:44 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10AF75D5EC
        for <linux-wireless@vger.kernel.org>; Thu,  5 May 2022 10:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651772104; x=1683308104;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EepX6IiCdCHd69YKPdnJG6wAq3HOe79QsU2UoF/ncfc=;
  b=abvugfycTI2QAHFNnZbp8P7OJpeb7SymF85omH8ncaHWTQHkTO3JVt5I
   5mHbPxm00xo9qEcFKAUpppL7kHap+czWHtChj8uwYDRG5Rat5D1aVVBDm
   orvqtg5M4FjAgM2XpR46CWtV08RUAeyvaub/C4hh1SkvVTv5YBqUHliiT
   k=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 05 May 2022 10:35:03 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 10:35:03 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 5 May 2022 10:35:03 -0700
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 5 May 2022 10:35:02 -0700
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>,
        Aloka Dixit <quic_alokad@quicinc.com>
Subject: [PATCH v2 2/2] mac80211: process additional data in ieee80211_change_beacon()
Date:   Thu, 5 May 2022 10:34:49 -0700
Message-ID: <20220505173449.4424-3-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220505173449.4424-1-quic_alokad@quicinc.com>
References: <20220505173449.4424-1-quic_alokad@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Modify the prototype for ieee80211_change_beacon() to accept
an instance of struct cfg80211_ap_settings instead of
struct cfg80211_beacon_data to process FILS discovery and
unsolicited broadcast probe response transmission configuration.

Set the respective flags when applicable.

Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
---
v1:
https://patchwork.kernel.org/project/linux-wireless/patch/20210120005229.32582-3-alokad@codeaurora.org/

 net/mac80211/cfg.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index f1d211e61e49..22843184d6ee 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1313,11 +1313,12 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 }
 
 static int ieee80211_change_beacon(struct wiphy *wiphy, struct net_device *dev,
-				   struct cfg80211_beacon_data *params)
+				   struct cfg80211_ap_settings *params)
 {
 	struct ieee80211_sub_if_data *sdata;
 	struct beacon_data *old;
 	int err;
+	u32 changed;
 
 	sdata = IEEE80211_DEV_TO_SUB_IF(dev);
 	sdata_assert_lock(sdata);
@@ -1332,10 +1333,28 @@ static int ieee80211_change_beacon(struct wiphy *wiphy, struct net_device *dev,
 	if (!old)
 		return -ENOENT;
 
-	err = ieee80211_assign_beacon(sdata, params, NULL, NULL);
+	err = ieee80211_assign_beacon(sdata, &params->beacon, NULL, NULL);
 	if (err < 0)
 		return err;
-	ieee80211_bss_info_change_notify(sdata, err);
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
+	ieee80211_bss_info_change_notify(sdata, changed);
 	return 0;
 }
 
-- 
2.31.1

