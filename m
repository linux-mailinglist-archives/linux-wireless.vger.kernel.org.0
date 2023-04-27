Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B37A36F0BF6
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Apr 2023 20:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244553AbjD0ScL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Apr 2023 14:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243521AbjD0ScJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Apr 2023 14:32:09 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25A246B8
        for <linux-wireless@vger.kernel.org>; Thu, 27 Apr 2023 11:32:07 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33RGS0kS017091;
        Thu, 27 Apr 2023 18:32:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=+UvwrbUZw1AadsSGY2d/6GxqkPQ35mggkyP28+sE+Bg=;
 b=QdRUUy3DroUZMORYovJLTYGeUzozMyBEwB6VjRQcJrau6OjrXtd5ztq9/V21RE10ykZU
 +/1S9JmJMKt2pnT7fXa/XHOVxVH2eKEDjaHqGJ2YRgg6zmhFIEShJb0jtw74A7ZSZ5bL
 hEzvd0RdPb078SMKOElBi0w3O5lzwnjRB0qOYgzKE5BYVevACzdXIscKyCzl4ysGEVCz
 Ym/H7Lkf8BXRU8DWm36/62vYg8wb7J2md/NO2WiA34id2bSY4cA/ihElBa1IcxtrFML1
 53WNS7IlXW7gwL0jymQdi+rxY++j2/b4kZW88eYaUaaqgP+bjvbApNseNNmNBiSZFwEO Lg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q7kqu9t2e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Apr 2023 18:32:04 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33RIW35R021511
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Apr 2023 18:32:03 GMT
Received: from msinada-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 27 Apr 2023 11:32:02 -0700
From:   Muna Sinada <quic_msinada@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>,
        Muna Sinada <quic_msinada@quicinc.com>
Subject: [PATCH v5 1/3] wifi: cfg80211: allow userspace to enable driver control of MU-EDCA
Date:   Thu, 27 Apr 2023 11:31:53 -0700
Message-ID: <1682620315-590-1-git-send-email-quic_msinada@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: D6pvpJhd4tsVD7EWqGIm5znIoIz3ZnhR
X-Proofpoint-ORIG-GUID: D6pvpJhd4tsVD7EWqGIm5znIoIz3ZnhR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-27_09,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 malwarescore=0 adultscore=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=683 bulkscore=0 phishscore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304270161
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add option for user space to enable driver to dynamically update MU-EDCA
parameters.

The updated MU-EDCA parameters from driver are part of an AP mode feature
where firmware determines better MU-EDCA parameters based on channel
conditions. The updated parameters are used and reported to user space
to reflect in AP management frames. These dynamic parameter updates
are offloaded to firmware for better user experience, thus details on
algorithm are not provided. This is a driver specific feature, thus
no spec references.

Signed-off-by: Muna Sinada <quic_msinada@quicinc.com>
---
v5: no change

v4: newly created patch in response to review comment to add opt in
    for user for this feature
---
 include/net/cfg80211.h       | 3 +++
 include/uapi/linux/nl80211.h | 5 +++++
 net/wireless/nl80211.c       | 5 +++++
 3 files changed, 13 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 9e04f69712b1..e56af095828e 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1359,6 +1359,8 @@ struct cfg80211_unsol_bcast_probe_resp {
  * @punct_bitmap: Preamble puncturing bitmap. Each bit represents
  *	a 20 MHz channel, lowest bit corresponding to the lowest channel.
  *	Bit set to 1 indicates that the channel is punctured.
+ * @dyn_muedca_enable: enable/disable driver control of dynamically update
+ *     MU-EDCA parameters
  */
 struct cfg80211_ap_settings {
 	struct cfg80211_chan_def chandef;
@@ -1394,6 +1396,7 @@ struct cfg80211_ap_settings {
 	struct cfg80211_unsol_bcast_probe_resp unsol_bcast_probe_resp;
 	struct cfg80211_mbssid_config mbssid_config;
 	u16 punct_bitmap;
+	bool dyn_muedca_enable;
 };
 
 /**
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index cf4fb981e131..e68169130e7e 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2805,6 +2805,9 @@ enum nl80211_commands {
  *	index. If the userspace includes more RNR elements than number of
  *	MBSSID elements then these will be added in every EMA beacon.
  *
+ * @NL80211_ATTR_DYN_MUEDCA_ENABLE: Flag attribute to indicate user space has
+ *  enabled Driver control of dynamically updating MU-EDCA parameters.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3341,6 +3344,8 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_EMA_RNR_ELEMS,
 
+	NL80211_ATTR_DYN_MUEDCA_ENABLE,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 3416c9db398f..e9e939706630 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -815,6 +815,7 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_MAX_HW_TIMESTAMP_PEERS] = { .type = NLA_U16 },
 	[NL80211_ATTR_HW_TIMESTAMP_ENABLED] = { .type = NLA_FLAG },
 	[NL80211_ATTR_EMA_RNR_ELEMS] = { .type = NLA_NESTED },
+	[NL80211_ATTR_DYN_MUEDCA_ENABLE] = { .type = NLA_FLAG },
 };
 
 /* policy for the key attributes */
@@ -6156,6 +6157,10 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 		goto out_unlock;
 	}
 
+	if (info->attrs[NL80211_ATTR_DYN_MUEDCA_ENABLE])
+		params->dyn_muedca_enable =
+		     nla_get_flag(info->attrs[NL80211_ATTR_DYN_MUEDCA_ENABLE]);
+
 	err = nl80211_calculate_ap_params(params);
 	if (err)
 		goto out_unlock;
-- 
2.7.4

