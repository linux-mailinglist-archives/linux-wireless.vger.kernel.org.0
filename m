Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E42F765AA0
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jul 2023 19:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbjG0Rlb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Jul 2023 13:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbjG0Rl2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Jul 2023 13:41:28 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF862D68
        for <linux-wireless@vger.kernel.org>; Thu, 27 Jul 2023 10:41:22 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36RDtNSa023621;
        Thu, 27 Jul 2023 17:41:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=MzdapAOIS7NzEjDJx8aZ2L4UnW7uPjg1uEhZ2jWdWZI=;
 b=J6Ut77X495zpmmWjyWlt4s55Qd+GF0GlukygVmrr4h17MRM/u1O52J+AwIm4638WwtYF
 VJ6FAFwC8/xyPl1Ontp8r4mNT2dcsAKyRvNWJtD98jCb7KhIpelAGTuEmAylE1p39OyR
 CUEcjBM0zJSFmRV5BXCMmZLPgEIwX1RqmRU3dlXdsAEcgUlUrhqzQD0HkqLinRO/dKpO
 49glQY0JBUyPTPTcFkzABEK5tqF4zUyCl5b6B1vxQr+F+Og5l9xE3zbinorwdZi1qGQ6
 fT0onRukrW/Fnsoa/IUyPjZSzJNMdupuLfT0+NZTdp8p5i6K/uycjO91YGdViENAV4nT EA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s3krn9jhw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 17:41:17 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36RHfF2B020206
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 17:41:15 GMT
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 27 Jul 2023 10:41:15 -0700
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>
CC:     Aloka Dixit <quic_alokad@quicinc.com>
Subject: [PATCH v8 2/5] wifi: mac80211: fixes in FILS discovery updates
Date:   Thu, 27 Jul 2023 10:40:57 -0700
Message-ID: <20230727174100.11721-3-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230727174100.11721-1-quic_alokad@quicinc.com>
References: <20230727174100.11721-1-quic_alokad@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: t9Ojl2psypUzlaBOVsA8Lh4yFwWkJwhY
X-Proofpoint-GUID: t9Ojl2psypUzlaBOVsA8Lh4yFwWkJwhY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_07,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 adultscore=0 suspectscore=0 mlxlogscore=930 priorityscore=1501 bulkscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307270160
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

FILS discovery configuration gets updated only if the maximum interval
is set to a non-zero value, hence there is no way to reset this value
to 0 once set. Replace the check for interval with a new flag which is
set only if the configuration should be updated.

Add similar changes for the unsolicited broadcast probe response handling.

Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
---
v8: New patch in this series.

 net/mac80211/cfg.c | 75 +++++++++++++++++++++++-----------------------
 1 file changed, 38 insertions(+), 37 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index e7ac24603892..dcf152114652 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -984,25 +984,28 @@ static int ieee80211_set_fils_discovery(struct ieee80211_sub_if_data *sdata,
 	struct fils_discovery_data *new, *old = NULL;
 	struct ieee80211_fils_discovery *fd;
 
-	if (!params->tmpl || !params->tmpl_len)
-		return -EINVAL;
+	if (!params->update)
+		return 0;
 
 	fd = &link_conf->fils_discovery;
 	fd->min_interval = params->min_interval;
 	fd->max_interval = params->max_interval;
 
 	old = sdata_dereference(link->u.ap.fils_discovery, sdata);
-	new = kzalloc(sizeof(*new) + params->tmpl_len, GFP_KERNEL);
-	if (!new)
-		return -ENOMEM;
-	new->len = params->tmpl_len;
-	memcpy(new->data, params->tmpl, params->tmpl_len);
-	rcu_assign_pointer(link->u.ap.fils_discovery, new);
-
 	if (old)
 		kfree_rcu(old, rcu_head);
 
-	return 0;
+	RCU_INIT_POINTER(link->u.ap.fils_discovery, NULL);
+	if (params->tmpl && params->tmpl_len) {
+		new = kzalloc(sizeof(*new) + params->tmpl_len, GFP_KERNEL);
+		if (!new)
+			return -ENOMEM;
+		new->len = params->tmpl_len;
+		memcpy(new->data, params->tmpl, params->tmpl_len);
+		rcu_assign_pointer(link->u.ap.fils_discovery, new);
+	}
+
+	return BSS_CHANGED_FILS_DISCOVERY;
 }
 
 static int
@@ -1013,23 +1016,26 @@ ieee80211_set_unsol_bcast_probe_resp(struct ieee80211_sub_if_data *sdata,
 {
 	struct unsol_bcast_probe_resp_data *new, *old = NULL;
 
-	if (!params->tmpl || !params->tmpl_len)
-		return -EINVAL;
+	if (!params->update)
+		return 0;
 
-	old = sdata_dereference(link->u.ap.unsol_bcast_probe_resp, sdata);
-	new = kzalloc(sizeof(*new) + params->tmpl_len, GFP_KERNEL);
-	if (!new)
-		return -ENOMEM;
-	new->len = params->tmpl_len;
-	memcpy(new->data, params->tmpl, params->tmpl_len);
-	rcu_assign_pointer(link->u.ap.unsol_bcast_probe_resp, new);
+	link_conf->unsol_bcast_probe_resp_interval = params->interval;
 
+	old = sdata_dereference(link->u.ap.unsol_bcast_probe_resp, sdata);
 	if (old)
 		kfree_rcu(old, rcu_head);
 
-	link_conf->unsol_bcast_probe_resp_interval = params->interval;
+	RCU_INIT_POINTER(link->u.ap.unsol_bcast_probe_resp, NULL);
+	if (params->tmpl && params->tmpl_len) {
+		new = kzalloc(sizeof(*new) + params->tmpl_len, GFP_KERNEL);
+		if (!new)
+			return -ENOMEM;
+		new->len = params->tmpl_len;
+		memcpy(new->data, params->tmpl, params->tmpl_len);
+		rcu_assign_pointer(link->u.ap.unsol_bcast_probe_resp, new);
+	}
 
-	return 0;
+	return BSS_CHANGED_UNSOL_BCAST_PROBE_RESP;
 }
 
 static int ieee80211_set_ftm_responder_params(
@@ -1460,23 +1466,18 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 	if (err < 0)
 		goto error;
 
-	if (params->fils_discovery.max_interval) {
-		err = ieee80211_set_fils_discovery(sdata,
-						   &params->fils_discovery,
-						   link, link_conf);
-		if (err < 0)
-			goto error;
-		changed |= BSS_CHANGED_FILS_DISCOVERY;
-	}
+	err = ieee80211_set_fils_discovery(sdata, &params->fils_discovery,
+					   link, link_conf);
+	if (err < 0)
+		goto error;
+	changed |= err;
 
-	if (params->unsol_bcast_probe_resp.interval) {
-		err = ieee80211_set_unsol_bcast_probe_resp(sdata,
-							   &params->unsol_bcast_probe_resp,
-							   link, link_conf);
-		if (err < 0)
-			goto error;
-		changed |= BSS_CHANGED_UNSOL_BCAST_PROBE_RESP;
-	}
+	err = ieee80211_set_unsol_bcast_probe_resp(sdata,
+						   &params->unsol_bcast_probe_resp,
+						   link, link_conf);
+	if (err < 0)
+		goto error;
+	changed |= err;
 
 	err = drv_start_ap(sdata->local, sdata, link_conf);
 	if (err) {
-- 
2.39.0

