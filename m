Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B48E6F34DB
	for <lists+linux-wireless@lfdr.de>; Mon,  1 May 2023 19:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233337AbjEARG6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 1 May 2023 13:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233357AbjEARGl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 1 May 2023 13:06:41 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FCA55BB1
        for <linux-wireless@vger.kernel.org>; Mon,  1 May 2023 10:00:59 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 341D0iPM009999;
        Mon, 1 May 2023 16:59:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=RtxORutrxu0sZ9MY8EbKSvxTYjrAlp+dUovAp6nOEH4=;
 b=QaQvlyhO2WExLBo7rv4mEf/A4sIaymbCkxzKTrHnEGXlgD7zTNBrOJS9zujZUAbmvz5s
 5ddITsfc/0j7emw1beyGdi/9il1LUj5PEVAvOV0IDB2u09bYf5jONF2b+6BRyarRP4IF
 8G59RD7SUqHa60vP7tqymDzqcVf9KU9AFhhUjdBWYhrq1pbxAWu9WvfHcfIUSZZMLoL6
 thpvVMcNo7GqrtG8EqSUSfqO2wyYj3F3ceHTYANWffmmkUamCJA+H83cVUI3HfTfAEeu
 Smk8aSdrXvHY/bQDyZRsFYygCMD3kri5hgc79rBNq/uuap+RKXNSXE/55BThW2fF8x4W 5w== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q8vhgv4m2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 May 2023 16:59:36 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 341GxZS3011773
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 1 May 2023 16:59:35 GMT
Received: from msinada-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 1 May 2023 09:59:35 -0700
From:   Muna Sinada <quic_msinada@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>,
        Muna Sinada <quic_msinada@quicinc.com>
Subject: [PATCH v6 1/3] wifi: cfg80211: allow userspace to enable driver control of MU-EDCA
Date:   Mon, 1 May 2023 09:59:21 -0700
Message-ID: <1682960363-15452-1-git-send-email-quic_msinada@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Z7bOHHZUF278tdKCphvWjU4DwD-pbu8B
X-Proofpoint-ORIG-GUID: Z7bOHHZUF278tdKCphvWjU4DwD-pbu8B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-01_10,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 suspectscore=0 phishscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=695 adultscore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305010138
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
v6: no change

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

