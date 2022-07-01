Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04241563471
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Jul 2022 15:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbiGANgj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Jul 2022 09:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbiGANgg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Jul 2022 09:36:36 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C273E175BD
        for <linux-wireless@vger.kernel.org>; Fri,  1 Jul 2022 06:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1656682595; x=1688218595;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=TfjjDfKN+sm40COVmyAqWY15CdzbjEC36Z6Qv+O+fcU=;
  b=SoOm2nPLfemazxsEsphKwtdX1onZOllPyBDm4dtAVzuPSkZG3Xz68Xa6
   Ma79BsvupadOn0BLFfH7Nh5Cv6kRdo/fr2/McsohgTzljWC2qUyFshHd+
   7eF0dJ9DyG6OCOgx/Wr/zGs02/puiuOjjitJ5zHeBbJiO4Yd0YQCfcr4j
   Y=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 01 Jul 2022 06:36:35 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 06:36:35 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 1 Jul 2022 06:36:35 -0700
Received: from adisi-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 1 Jul 2022 06:36:33 -0700
From:   Aditya Kumar Singh <quic_adisi@quicinc.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <johannes@sipsolutions.net>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>
Subject: [PATCH v2] mac80211: fix mesh airtime link metric estimating
Date:   Fri, 1 Jul 2022 19:06:11 +0530
Message-ID: <20220701133611.544-1-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
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

ieee80211s_update_metric function uses sta_set_rate_info_tx
function to get struct rate_info data from ieee80211_tx_rate
struct, present in ieee80211_sta->deflink.tx_stats. However,
drivers can skip tx rate calculation by setting rate idx as 
-1. Such drivers provides rate_info directly and hence
ieee80211s metric is updated incorrectly since ieee80211_tx_rate
has inconsistent data.

Add fix to use rate_info directly if present instead of
sta_set_rate_info_tx for updating ieee80211s metric.

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
v2: * Rebased to latest HEAD
    * Considered changes due to 44fa75f207d8 ("mac80211: extend
      current rate control tx status API") and the MLO work
---
 net/mac80211/mesh_hwmp.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/mesh_hwmp.c b/net/mac80211/mesh_hwmp.c
index 58ebdcd69d05..2cb6dc84ac38 100644
--- a/net/mac80211/mesh_hwmp.c
+++ b/net/mac80211/mesh_hwmp.c
@@ -310,7 +310,12 @@ void ieee80211s_update_metric(struct ieee80211_local *local,
 			LINK_FAIL_THRESH)
 		mesh_plink_broken(sta);
 
-	sta_set_rate_info_tx(sta, &sta->deflink.tx_stats.last_rate, &rinfo);
+	/* use rate info set by the driver directly if present */
+	if (st->n_rates)
+		rinfo = sta->deflink.tx_stats.last_rate_info;
+	else
+		sta_set_rate_info_tx(sta, &sta->deflink.tx_stats.last_rate, &rinfo);
+
 	ewma_mesh_tx_rate_avg_add(&sta->mesh->tx_rate_avg,
 				  cfg80211_calculate_bitrate(&rinfo));
 }

base-commit: 8d70f33ed7207e82e51d5a4436c8ba2268a83b14
-- 
2.17.1

