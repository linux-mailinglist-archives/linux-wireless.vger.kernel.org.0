Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 966E76F0BFA
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Apr 2023 20:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243521AbjD0ScQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Apr 2023 14:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244560AbjD0ScO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Apr 2023 14:32:14 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ABF949D5
        for <linux-wireless@vger.kernel.org>; Thu, 27 Apr 2023 11:32:10 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33RHjYZn017765;
        Thu, 27 Apr 2023 18:32:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=mYnx0EoqX6jpui//5r4lYZIYUKNB4vVh7+h/l+Kiijk=;
 b=Tra9QT9mB2NAUhQODVMuinwGKvMYS0ynH6kRvtVHvg/eZ52YnWJmXWTcploNVMhY/ar6
 ct9XScXHzdVMXuJHckBQjFrNAHR4ThtuojWfk9gtDBLH3O6gBSDP/a9CC6UQMs1g+bZ1
 KFywTYlICMEcVot7+H0XKRnBcuE/5Zu1QAFnbx8IGHdP2CwZHg+R7fEAlauDZIOE667J
 XGSonTwTvPWSeO3BRJkmyWMYXnu2SEGHrmFL9Y4bEe/R1XJkPuFzfsFgEAOzoI4cUHtp
 tdHgWCmORMAeUfzl4vVmuqvJUaNlnrg6Xxnk4nGkBzHwzsfWvDlQpyJr2QczTv/zQHdO 4g== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q7wq883dg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Apr 2023 18:32:07 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33RIW6Cj015425
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Apr 2023 18:32:06 GMT
Received: from msinada-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 27 Apr 2023 11:32:05 -0700
From:   Muna Sinada <quic_msinada@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>,
        Muna Sinada <quic_msinada@quicinc.com>
Subject: [PATCH v5 3/3] cfg80211: Handle driver updated MU-EDCA params
Date:   Thu, 27 Apr 2023 11:31:55 -0700
Message-ID: <1682620315-590-3-git-send-email-quic_msinada@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1682620315-590-1-git-send-email-quic_msinada@quicinc.com>
References: <1682620315-590-1-git-send-email-quic_msinada@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Aovef8mXdGEvlPXFM8RejBHOxK6124T0
X-Proofpoint-ORIG-GUID: Aovef8mXdGEvlPXFM8RejBHOxK6124T0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-27_08,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 bulkscore=0 suspectscore=0 phishscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304270160
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add necessary functions and attributes to receive updated MU-EDCA
parameters from driver and send to user space, where management
frame are updated to reflect latest parameters.

The updated parameters from driver are part of an AP mode feature
where firmware determines better MU-EDCA parameters based on channel
conditions. The updated parameters are used and reported to user space
to reflect in AP management frames. These dynamic parameter updates
are offloaded to firmware for better user experience, thus details on
algorithm are not provided. This is a driver specific feature, thus
no spec references.

Signed-off-by: Muna Sinada <quic_msinada@quicinc.com>
---
v5: Fixed build error from trace event
    (cfg80211_update_muedca_params_event)

v4: Added tracing and added nla policy for new nl attr

v3: modified commit message
---
 include/net/cfg80211.h       | 12 ++++++++++++
 include/uapi/linux/nl80211.h | 11 +++++++++++
 net/wireless/nl80211.c       | 40 ++++++++++++++++++++++++++++++++++++++++
 net/wireless/trace.h         | 40 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 103 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index e56af095828e..fe4f416b85e1 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -9070,4 +9070,16 @@ static inline int cfg80211_color_change_notify(struct net_device *dev)
 bool cfg80211_valid_disable_subchannel_bitmap(u16 *bitmap,
 					      const struct cfg80211_chan_def *chandef);
 
+/**
+ * cfg80211_update_muedca_params_event - Notify userspace about updated
+ *	MU-EDCA parameters
+ *
+ * @wiphy: the wiphy
+ * @params: Updated MU-EDCA parameters
+ * @gfp: allocation flags
+ */
+void cfg80211_update_muedca_params_event(struct wiphy *wiphy,
+					 const struct ieee80211_mu_edca_param_set *params,
+					 gfp_t gfp);
+
 #endif /* __NET_CFG80211_H */
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index e68169130e7e..51c8a94bc411 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -1309,6 +1309,11 @@
  *	The number of peers that HW timestamping can be enabled for concurrently
  *	is indicated by %NL80211_ATTR_MAX_HW_TIMESTAMP_PEERS.
  *
+ * @NL80211_CMD_UPDATE_HE_MUEDCA_PARAMS: Updated MU-EDCA parameters from
+ *	driver. This event is used to update dynamic MU-EDCA parameters in
+ *	management frames, coming from driver and now need to be reflected in
+ *	management frames.
+ *
  * @NL80211_CMD_MAX: highest used command number
  * @__NL80211_CMD_AFTER_LAST: internal use
  */
@@ -1562,6 +1567,8 @@ enum nl80211_commands {
 
 	NL80211_CMD_SET_HW_TIMESTAMP,
 
+	NL80211_CMD_UPDATE_HE_MUEDCA_PARAMS,
+
 	/* add new commands above here */
 
 	/* used to define NL80211_CMD_MAX below */
@@ -2807,6 +2814,9 @@ enum nl80211_commands {
  *
  * @NL80211_ATTR_DYN_MUEDCA_ENABLE: Flag attribute to indicate user space has
  *  enabled Driver control of dynamically updating MU-EDCA parameters.
+ * @NL80211_ATTR_HE_MUEDCA_PARAMS: MU-EDCA AC parameters for the
+ *	%NL80211_CMD_UPDATE_HE_MUEDCA_PARAMS command in format described in
+ *	P802.11ax_D4.0 section 9.4.2.245
  *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
@@ -3345,6 +3355,7 @@ enum nl80211_attrs {
 	NL80211_ATTR_EMA_RNR_ELEMS,
 
 	NL80211_ATTR_DYN_MUEDCA_ENABLE,
+	NL80211_ATTR_HE_MUEDCA_PARAMS,
 
 	/* add attributes here, update the policy in nl80211.c */
 
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index e9e939706630..af36440f2a51 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -816,6 +816,8 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_HW_TIMESTAMP_ENABLED] = { .type = NLA_FLAG },
 	[NL80211_ATTR_EMA_RNR_ELEMS] = { .type = NLA_NESTED },
 	[NL80211_ATTR_DYN_MUEDCA_ENABLE] = { .type = NLA_FLAG },
+	[NL80211_ATTR_HE_MUEDCA_PARAMS] =
+	       NLA_POLICY_EXACT_LEN(sizeof(struct ieee80211_mu_edca_param_set)),
 };
 
 /* policy for the key attributes */
@@ -20017,6 +20019,44 @@ void cfg80211_update_owe_info_event(struct net_device *netdev,
 }
 EXPORT_SYMBOL(cfg80211_update_owe_info_event);
 
+void
+cfg80211_update_muedca_params_event(struct wiphy *wiphy,
+				    const struct ieee80211_mu_edca_param_set *params,
+				    gfp_t gfp)
+{
+	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
+	struct sk_buff *msg;
+	void *hdr;
+
+	trace_cfg80211_update_muedca_params_event(wiphy, params);
+
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, gfp);
+	if (!msg)
+		return;
+
+	hdr = nl80211hdr_put(msg, 0, 0, 0, NL80211_CMD_UPDATE_HE_MUEDCA_PARAMS);
+	if (!hdr)
+		goto nla_put_failure;
+
+	if (nla_put_u32(msg, NL80211_ATTR_WIPHY, rdev->wiphy_idx))
+		goto nla_put_failure;
+
+	if (nla_put(msg, NL80211_ATTR_HE_MUEDCA_PARAMS,
+		    sizeof(*params), params))
+		goto nla_put_failure;
+
+	genlmsg_end(msg, hdr);
+
+	genlmsg_multicast_netns(&nl80211_fam, wiphy_net(&rdev->wiphy), msg, 0,
+				NL80211_MCGRP_MLME, gfp);
+	return;
+
+nla_put_failure:
+	genlmsg_cancel(msg, hdr);
+	nlmsg_free(msg);
+}
+EXPORT_SYMBOL(cfg80211_update_muedca_params_event);
+
 /* initialisation/exit functions */
 
 int __init nl80211_init(void)
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 716a1fa70069..3ac552be0129 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -3785,6 +3785,46 @@ TRACE_EVENT(cfg80211_update_owe_info_event,
 		  __entry->assoc_link_id, __entry->peer_mld_addr)
 );
 
+TRACE_EVENT(cfg80211_update_muedca_params_event,
+	TP_PROTO(struct wiphy *wiphy,
+		 const struct ieee80211_mu_edca_param_set *params),
+	TP_ARGS(wiphy, params),
+	TP_STRUCT__entry(
+		WIPHY_ENTRY
+		__field(u8, mu_qos_info)
+		__field(u8, be_aifsn)
+		__field(u8, be_ecw_min_max)
+		__field(u8, be_mu_edca_timer)
+		__field(u8, bk_aifsn)
+		__field(u8, bk_ecw_min_max)
+		__field(u8, bk_mu_edca_timer)
+		__field(u8, vi_aifsn)
+		__field(u8, vi_ecw_min_max)
+		__field(u8, vi_mu_edca_timer)
+		__field(u8, vo_aifsn)
+		__field(u8, vo_ecw_min_max)
+		__field(u8, vo_mu_edca_timer)
+	),
+	TP_fast_assign(
+		WIPHY_ASSIGN;
+		__entry->mu_qos_info = params->mu_qos_info;
+		__entry->be_aifsn = params->ac_be.aifsn;
+		__entry->be_ecw_min_max = params->ac_be.ecw_min_max;
+		__entry->be_mu_edca_timer = params->ac_be.mu_edca_timer;
+		__entry->bk_aifsn = params->ac_bk.aifsn;
+		__entry->bk_ecw_min_max = params->ac_bk.ecw_min_max;
+		__entry->bk_mu_edca_timer = params->ac_bk.mu_edca_timer;
+		__entry->vi_aifsn = params->ac_vi.aifsn;
+		__entry->vi_ecw_min_max = params->ac_vi.ecw_min_max;
+		__entry->vi_mu_edca_timer = params->ac_vi.mu_edca_timer;
+		__entry->vo_aifsn = params->ac_vo.aifsn;
+		__entry->vo_ecw_min_max = params->ac_vo.ecw_min_max;
+		__entry->vo_mu_edca_timer = params->ac_vo.mu_edca_timer;
+	),
+	TP_printk(WIPHY_PR_FMT ", MU QOS info: %u", WIPHY_PR_ARG,
+		  __entry->mu_qos_info)
+);
+
 TRACE_EVENT(cfg80211_bss_color_notify,
 	TP_PROTO(struct net_device *netdev,
 		 enum nl80211_commands cmd,
-- 
2.7.4

