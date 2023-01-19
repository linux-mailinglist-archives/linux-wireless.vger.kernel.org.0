Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A14546745F6
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Jan 2023 23:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbjASW3W (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Jan 2023 17:29:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbjASW2l (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Jan 2023 17:28:41 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC8BC1331
        for <linux-wireless@vger.kernel.org>; Thu, 19 Jan 2023 14:13:05 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30JKpN8s004003;
        Thu, 19 Jan 2023 22:12:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=cRnPTJuBLUk4SAYzUK1Z92hXbmCVfMypcklD9yFONuw=;
 b=PzmSf5EQRS6OS1RzIDh34u3+29eplrsuIpuwb0YTTjwTimWW43fDJ6Z65liq/KZiNQzU
 qt1cNLDgwIGZpJiGcJj0KsnDstLqDiRWBIABxg4yjDZ4nZVsy+wLgb3Zay/GvDqsR/DJ
 YXCFMuck4wI6a2kCrBFmmoaLNwTwS5MSLJnE3+JnHAlw8ffO0Vyx27904A4XvVncWBdK
 ePqO6ZujX4J0NWBQPy4xPapZHpmPTaJznH+F3vlI6kpnJ7KtR7bX5rCLUtCHQI6viSDj
 CMgPTogqYRvqjsIMNlM637fUzgRlhVchSlAUTDM0uD4BRDsxdiu7JHGdcr3S4BF8wuOW jQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n7593sadf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 22:12:58 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30JMCvHe010624
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 22:12:57 GMT
Received: from srirrama-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 19 Jan 2023 14:12:55 -0800
From:   Sriram R <quic_srirrama@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>,
        Sriram R <quic_srirrama@quicinc.com>
Subject: [PATCH v2] wifi: mac80211: support poll sta for ML clients
Date:   Fri, 20 Jan 2023 03:42:40 +0530
Message-ID: <20230119221240.24441-1-quic_srirrama@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: qJeV2CDaYmoklREhwIKFW3rAQUff8giy
X-Proofpoint-ORIG-GUID: qJeV2CDaYmoklREhwIKFW3rAQUff8giy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-19_14,2023-01-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=720 spamscore=0 suspectscore=0 mlxscore=0 adultscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 bulkscore=0
 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301190187
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Update the client probe handling which sends Null data
frames to check inactivity to support ML Stations as well.

Replace the use of default bss conf with the link specific
conf and use the stations default link to send the probe
frame. Non ML Stations associated to the ML AP would use
its default link as well which is one of the active links.

For Non ML AP, the default link id is 0 and it is taken care
as well.

Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
---
v2: Updated wifi prefix in commit title
 net/mac80211/cfg.c | 35 +++++++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index c885076fae89..72df8c708a2d 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3980,17 +3980,13 @@ static int ieee80211_probe_client(struct wiphy *wiphy, struct net_device *dev,
 	struct ieee80211_chanctx_conf *chanctx_conf;
 	enum nl80211_band band;
 	int ret;
+	u8 link_id;
+	struct ieee80211_bss_conf *conf;
 
 	/* the lock is needed to assign the cookie later */
 	mutex_lock(&local->mtx);
 
 	rcu_read_lock();
-	chanctx_conf = rcu_dereference(sdata->vif.bss_conf.chanctx_conf);
-	if (WARN_ON(!chanctx_conf)) {
-		ret = -EINVAL;
-		goto unlock;
-	}
-	band = chanctx_conf->def.chan->band;
 	sta = sta_info_get_bss(sdata, peer);
 	if (sta) {
 		qos = sta->sta.wme;
@@ -3999,6 +3995,27 @@ static int ieee80211_probe_client(struct wiphy *wiphy, struct net_device *dev,
 		goto unlock;
 	}
 
+	/* In case of ML vif, we shall use the default sta link to
+	 * send the probe frame. For non ML vif the link id 0 is
+	 * the deflink
+	 */
+	link_id = sta->deflink.link_id;
+
+	conf = rcu_dereference(sdata->vif.link_conf[link_id]);
+
+	if (unlikely(!conf)) {
+		ret = -ENOLINK;
+		goto unlock;
+	}
+
+	chanctx_conf = rcu_dereference(conf->chanctx_conf);
+	if (WARN_ON(!chanctx_conf)) {
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	band = chanctx_conf->def.chan->band;
+
 	if (qos) {
 		fc = cpu_to_le16(IEEE80211_FTYPE_DATA |
 				 IEEE80211_STYPE_QOS_NULLFUNC |
@@ -4024,8 +4041,8 @@ static int ieee80211_probe_client(struct wiphy *wiphy, struct net_device *dev,
 	nullfunc->frame_control = fc;
 	nullfunc->duration_id = 0;
 	memcpy(nullfunc->addr1, sta->sta.addr, ETH_ALEN);
-	memcpy(nullfunc->addr2, sdata->vif.addr, ETH_ALEN);
-	memcpy(nullfunc->addr3, sdata->vif.addr, ETH_ALEN);
+	memcpy(nullfunc->addr2, conf->addr, ETH_ALEN);
+	memcpy(nullfunc->addr3, conf->addr, ETH_ALEN);
 	nullfunc->seq_ctrl = 0;
 
 	info = IEEE80211_SKB_CB(skb);
@@ -4034,6 +4051,8 @@ static int ieee80211_probe_client(struct wiphy *wiphy, struct net_device *dev,
 		       IEEE80211_TX_INTFL_NL80211_FRAME_TX;
 	info->band = band;
 
+	info->control.flags |= u32_encode_bits(link_id, IEEE80211_TX_CTRL_MLO_LINK);
+
 	skb_set_queue_mapping(skb, IEEE80211_AC_VO);
 	skb->priority = 7;
 	if (qos)
-- 
2.17.1

