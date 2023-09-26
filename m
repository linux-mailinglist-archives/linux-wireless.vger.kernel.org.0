Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 160C17AE8C0
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Sep 2023 11:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234115AbjIZJRT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Sep 2023 05:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234112AbjIZJRS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Sep 2023 05:17:18 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3EA10A
        for <linux-wireless@vger.kernel.org>; Tue, 26 Sep 2023 02:17:11 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38Q6LKTe003193;
        Tue, 26 Sep 2023 09:17:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=FvRtvXmJTry8a4BWHtgGKCc8KrZpPc/mg2CL1l84pPo=;
 b=VsQiRfTlYC8lBU4B357dHg0PLZpWXVqUfeFp9L8oawXhUP5SLbeUYG3Q/3oxiSrU7C2v
 3dlfWwX8As0br6Pu4wCiZB/EnnTpUdxnr69hgSGHWZG2IQbBtJsOiC/9lyM7MXfm92jk
 VgGvTIo12wF8VOq2muWeowrJp6J11xZOdsq18YTI45V0zJxmKcYgqZFgNWN2thv+X/95
 HtZDilyxVneYQqFAeiCrXTl6aIKVudRPJeZq3Ea8KtnZq8+Ux+0GETXmfUp1uRi45Yl0
 CAwLH25uXu3u5YEhIpSIoGhvI833yCKCmRix5wg5ygIzDB6kKvsdDIVJ7tFKgpwBot6B Vw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tbbyf27js-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Sep 2023 09:17:08 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38Q9H71x030570
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Sep 2023 09:17:07 GMT
Received: from adisi-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Tue, 26 Sep 2023 02:17:05 -0700
From:   Aditya Kumar Singh <quic_adisi@quicinc.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <johannes@sipsolutions.net>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>
Subject: [PATCH v3 1/3] wifi: cfg80211: send link id in channel_switch ops
Date:   Tue, 26 Sep 2023 14:46:46 +0530
Message-ID: <20230926091648.17184-2-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230926091648.17184-1-quic_adisi@quicinc.com>
References: <20230926091648.17184-1-quic_adisi@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8d_TYGyRJbgZW1d2AnL31BKd3etS0yQ_
X-Proofpoint-ORIG-GUID: 8d_TYGyRJbgZW1d2AnL31BKd3etS0yQ_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-26_07,2023-09-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 spamscore=0 clxscore=1015 adultscore=0
 mlxlogscore=902 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2309260080
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently, during channel switch, no link id information is passed
due to which channel switch is carried on deflink always. In order
to support channel switch during Multi Link Operation, it is
required to pass link id as well.

Add changes to pass link id in the channel_switch cfg80211_ops.

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 include/net/cfg80211.h     |  3 ++-
 net/mac80211/cfg.c         | 11 ++++++++---
 net/mac80211/ibss.c        |  2 +-
 net/mac80211/ieee80211_i.h |  3 ++-
 net/mac80211/mesh.c        |  2 +-
 net/wireless/nl80211.c     |  2 +-
 net/wireless/rdev-ops.h    |  7 ++++---
 net/wireless/trace.h       | 12 ++++++++----
 8 files changed, 27 insertions(+), 15 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 34c50f7273d1..df0b511b6401 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -4762,7 +4762,8 @@ struct cfg80211_ops {
 
 	int	(*channel_switch)(struct wiphy *wiphy,
 				  struct net_device *dev,
-				  struct cfg80211_csa_settings *params);
+				  struct cfg80211_csa_settings *params,
+				  unsigned int link_id);
 
 	int     (*set_qos_map)(struct wiphy *wiphy,
 			       struct net_device *dev,
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 5bc6b1329465..ac977aaad58e 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3844,7 +3844,8 @@ static void ieee80211_color_change_abort(struct ieee80211_sub_if_data  *sdata)
 
 static int
 __ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
-			   struct cfg80211_csa_settings *params)
+			   struct cfg80211_csa_settings *params,
+			   unsigned int link_id)
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
 	struct ieee80211_local *local = sdata->local;
@@ -3856,6 +3857,9 @@ __ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
+	if (WARN_ON(link_id > IEEE80211_MLD_MAX_NUM_LINKS))
+		return -EINVAL;
+
 	if (!list_empty(&local->roc_list) || local->scanning)
 		return -EBUSY;
 
@@ -3949,14 +3953,15 @@ __ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 }
 
 int ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
-			     struct cfg80211_csa_settings *params)
+			     struct cfg80211_csa_settings *params,
+			     unsigned int link_id)
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
 	struct ieee80211_local *local = sdata->local;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
-	return __ieee80211_channel_switch(wiphy, dev, params);
+	return __ieee80211_channel_switch(wiphy, dev, params, link_id);
 }
 
 u64 ieee80211_mgmt_tx_cookie(struct ieee80211_local *local)
diff --git a/net/mac80211/ibss.c b/net/mac80211/ibss.c
index a7736acadf3c..c72449d0fe1a 100644
--- a/net/mac80211/ibss.c
+++ b/net/mac80211/ibss.c
@@ -871,7 +871,7 @@ ieee80211_ibss_process_chanswitch(struct ieee80211_sub_if_data *sdata,
 	params.block_tx = !!csa_ie.mode;
 
 	if (ieee80211_channel_switch(sdata->local->hw.wiphy, sdata->dev,
-				     &params))
+				     &params, 0))
 		goto disconnect;
 
 	ieee80211_ibss_csa_mark_radar(sdata);
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 19429f84afc3..da97812119ea 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1947,7 +1947,8 @@ int ieee80211_mgmt_tx_cancel_wait(struct wiphy *wiphy,
 /* channel switch handling */
 void ieee80211_csa_finalize_work(struct wiphy *wiphy, struct wiphy_work *work);
 int ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
-			     struct cfg80211_csa_settings *params);
+			     struct cfg80211_csa_settings *params,
+			     unsigned int link_id);
 
 /* color change handling */
 void ieee80211_color_change_finalize_work(struct wiphy *wiphy,
diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
index 0d0fbae51b61..7e63ccea6c22 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -1391,7 +1391,7 @@ ieee80211_mesh_process_chnswitch(struct ieee80211_sub_if_data *sdata,
 	ifmsh->csa_role = IEEE80211_MESH_CSA_ROLE_REPEATER;
 
 	if (ieee80211_channel_switch(sdata->local->hw.wiphy, sdata->dev,
-				     &params) < 0)
+				     &params, 0) < 0)
 		return false;
 
 	return true;
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 87b21c0c0f25..d9212a1431d3 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -10240,7 +10240,7 @@ static int nl80211_channel_switch(struct sk_buff *skb, struct genl_info *info)
 			goto free;
 	}
 
-	err = rdev_channel_switch(rdev, dev, &params);
+	err = rdev_channel_switch(rdev, dev, &params, link_id);
 
 free:
 	kfree(params.beacon_after.mbssid_ies);
diff --git a/net/wireless/rdev-ops.h b/net/wireless/rdev-ops.h
index 2214a90cf101..7487164abe29 100644
--- a/net/wireless/rdev-ops.h
+++ b/net/wireless/rdev-ops.h
@@ -1099,12 +1099,13 @@ static inline void rdev_crit_proto_stop(struct cfg80211_registered_device *rdev,
 
 static inline int rdev_channel_switch(struct cfg80211_registered_device *rdev,
 				      struct net_device *dev,
-				      struct cfg80211_csa_settings *params)
+				      struct cfg80211_csa_settings *params,
+				      unsigned int link_id)
 {
 	int ret;
 
-	trace_rdev_channel_switch(&rdev->wiphy, dev, params);
-	ret = rdev->ops->channel_switch(&rdev->wiphy, dev, params);
+	trace_rdev_channel_switch(&rdev->wiphy, dev, params, link_id);
+	ret = rdev->ops->channel_switch(&rdev->wiphy, dev, params, link_id);
 	trace_rdev_return_int(&rdev->wiphy, ret);
 	return ret;
 }
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index da2b73951c32..014664f4d255 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -2311,8 +2311,9 @@ TRACE_EVENT(rdev_crit_proto_stop,
 
 TRACE_EVENT(rdev_channel_switch,
 	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev,
-		 struct cfg80211_csa_settings *params),
-	TP_ARGS(wiphy, netdev, params),
+		 struct cfg80211_csa_settings *params,
+		 unsigned int link_id),
+	TP_ARGS(wiphy, netdev, params, link_id),
 	TP_STRUCT__entry(
 		WIPHY_ENTRY
 		NETDEV_ENTRY
@@ -2322,6 +2323,7 @@ TRACE_EVENT(rdev_channel_switch,
 		__field(u8, count)
 		__dynamic_array(u16, bcn_ofs, params->n_counter_offsets_beacon)
 		__dynamic_array(u16, pres_ofs, params->n_counter_offsets_presp)
+		__field(unsigned int, link_id)
 	),
 	TP_fast_assign(
 		WIPHY_ASSIGN;
@@ -2339,11 +2341,13 @@ TRACE_EVENT(rdev_channel_switch,
 			memcpy(__get_dynamic_array(pres_ofs),
 			       params->counter_offsets_presp,
 			       params->n_counter_offsets_presp * sizeof(u16));
+		__entry->link_id = link_id;
 	),
 	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", " CHAN_DEF_PR_FMT
-		  ", block_tx: %d, count: %u, radar_required: %d",
+		  ", block_tx: %d, count: %u, radar_required: %d link_id: %d",
 		  WIPHY_PR_ARG, NETDEV_PR_ARG, CHAN_DEF_PR_ARG,
-		  __entry->block_tx, __entry->count, __entry->radar_required)
+		  __entry->block_tx, __entry->count, __entry->radar_required,
+		  __entry->link_id)
 );
 
 TRACE_EVENT(rdev_set_qos_map,
-- 
2.17.1

