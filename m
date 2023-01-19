Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92960673ABD
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Jan 2023 14:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbjASNvC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Jan 2023 08:51:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjASNvA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Jan 2023 08:51:00 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848D25BB1
        for <linux-wireless@vger.kernel.org>; Thu, 19 Jan 2023 05:50:59 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30J5tsAE018052;
        Thu, 19 Jan 2023 13:50:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=zFIBls+cZdLEgCzt64mFdXhCYuvW0648L5NvUIDx5cw=;
 b=Qa4jaGYgcCWEOt46xZ+n1qUYIa9nUwmq4w1JtCGgSTsN9T2k66u+0lTIhT7SAAS01i0s
 i2BA00ZTCzCOG7+O+3tbpK9X8Hq2oqIz9wogat0stmwZsKzIicqlp88+Dndm7GwpzoaZ
 M6zXyy0QL2Zs3a7C5RTy/A3G5GbEDDOVFYXwYDf4uB3xsKiiHKI4oCELkZfuBKk4Lfo9
 jqj1+yeHHQ3EmK9ArxbBvriFxC96OFIipLrNIKPJhtjPpxj2uvGYMbUoG+QwuA2iBqJA
 fnTTjF+Iva33HAelQzKEPHwaRr9WY666KwHrvMWdMjAypDk8sfBto6EqaqTjE+fRpdzL EA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n6wbs9g4j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 13:50:56 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30JDotYx008498
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 13:50:55 GMT
Received: from srirrama-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 19 Jan 2023 05:50:53 -0800
From:   Sriram R <quic_srirrama@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>,
        Sriram R <quic_srirrama@quicinc.com>
Subject: [PATCH] mac80211: support poll sta for ML clients
Date:   Thu, 19 Jan 2023 19:20:36 +0530
Message-ID: <20230119135036.17709-1-quic_srirrama@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: kQu6b4_5C_05w0mF_dYz-wrUE2RSuddQ
X-Proofpoint-GUID: kQu6b4_5C_05w0mF_dYz-wrUE2RSuddQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-19_09,2023-01-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=672 malwarescore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 phishscore=0 adultscore=0 mlxscore=0 suspectscore=0
 clxscore=1011 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301190110
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

