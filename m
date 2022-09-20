Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7760B5BE2AE
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Sep 2022 12:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiITKHT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Sep 2022 06:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbiITKHE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Sep 2022 06:07:04 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF4061738
        for <linux-wireless@vger.kernel.org>; Tue, 20 Sep 2022 03:07:02 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28K7xcFc023504;
        Tue, 20 Sep 2022 10:05:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=zoGG73whL65cB+dCMtnJXPjzU/eTvaiJulFQDEVaFg4=;
 b=ZyCT/aH+qGs8VCUW3o9Y7muVsNJ8wA5oHIBYzdWbirKMamxq9M1kkxPtNJt+u7R1Br1k
 OqDazcSZTH136QoYqppZr/BE8QhU9RdOJp1KCt7leEZBY0FA1r8IErMfubdHjHj+lBqG
 RxS6tLRAR1w5Nkj/A8/vQpDCsnkx7uodyr8rPDYCDuh4WuREAensoclC5yxZdgkPG7qB
 m2XFOw0yptBqmkVLR7pKE1uSwqSI+d6IwqszXYXRwI93c+PznfBCXAgJlillBAzd1COY
 VatbCASZIkTkiAATBXuT8LKH+NIhAaWQH/qXQ5Q7wr/53oUmRhTOxp9Q0PZm4YyqXK/S 3A== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jpxaejbgv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 10:05:47 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28KA5lSt004547
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 10:05:47 GMT
Received: from CDCCSTEX0180100-LIN.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 20 Sep 2022 03:05:45 -0700
From:   Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>
Subject: [RFC 4/4] wifi: nl80211: send iface combination to user space in multi-hardware wiphy
Date:   Tue, 20 Sep 2022 15:35:18 +0530
Message-ID: <20220920100518.19705-5-quic_vthiagar@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220920100518.19705-1-quic_vthiagar@quicinc.com>
References: <20220920100518.19705-1-quic_vthiagar@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 023v3_eOp-ZNsMR85izsJ5WRlI-hMI_m
X-Proofpoint-ORIG-GUID: 023v3_eOp-ZNsMR85izsJ5WRlI-hMI_m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-20_02,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 mlxlogscore=759
 adultscore=0 clxscore=1015 malwarescore=0 phishscore=0 impostorscore=0
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209200061
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

A new nested nl attribute is added to the same existing NL command to
advertise the iface combination capability for each underlying hardware
when driver groups more than one physical hardware under one wiphy to
enable MLO among them.

Signed-off-by: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
---
 include/uapi/linux/nl80211.h | 50 ++++++++++++++++++++++++-
 net/wireless/nl80211.c       | 71 ++++++++++++++++++++++++++++++++++++
 2 files changed, 120 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 070b31277402..678da076b122 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -5779,6 +5779,10 @@ enum nl80211_iface_limit_attrs {
  * @NL80211_IFACE_COMB_BI_MIN_GCD: u32 attribute specifying the minimum GCD of
  *	different beacon intervals supported by all the interface combinations
  *	in this group (if not present, all beacon intervals be identical).
+ * @NL80211_IFACE_COMB_PER_HW_COMB: nested attribute specifying the interface
+ *	combination for each underlying hardware when multiple hardware are
+ *	registered under one wiphy,
+ *	see &enum nl80211_if_comb_per_hw_comb_attrs.
  * @NUM_NL80211_IFACE_COMB: number of attributes
  * @MAX_NL80211_IFACE_COMB: highest attribute number
  *
@@ -5795,7 +5799,19 @@ enum nl80211_iface_limit_attrs {
  *	numbers = [ #{STA} <= 1, #{P2P-client,P2P-GO} <= 3 ], max = 4
  *	=> allows a STA plus three P2P interfaces
  *
- * The list of these four possibilities could completely be contained
+ *	When describing per-hardware combinations in multi-hardware in
+ *	one wiphy model, the first possibility can further include the finer
+ *	capabilities like below
+ *	hw_chan_idx = 0, numbers = [ #{STA} <= 1, #{AP} <= 1 ],
+ *	channels = 1, max = 2
+ *	=> allows a STA plus an AP interface on the underlying hardware mac
+ *	   advertised at index 0 in wiphy @hw_chans array.
+ *	hw_chan_idx = 1, numbers = [ #{STA} <= 1, #{AP} <= 2 ],
+ *	channels = 1, max = 3
+ *	=> allows a STA plus two AP interfaces on the underlying hardware mac
+ *	   advertised at index 1 in wiphy @hw_chans array.
+ *
+ * The list of these five possibilities could completely be contained
  * within the %NL80211_ATTR_INTERFACE_COMBINATIONS attribute to indicate
  * that any of these groups must match.
  *
@@ -5814,12 +5830,44 @@ enum nl80211_if_combination_attrs {
 	NL80211_IFACE_COMB_RADAR_DETECT_WIDTHS,
 	NL80211_IFACE_COMB_RADAR_DETECT_REGIONS,
 	NL80211_IFACE_COMB_BI_MIN_GCD,
+	NL80211_IFACE_COMB_PER_HW_COMB,
 
 	/* keep last */
 	NUM_NL80211_IFACE_COMB,
 	MAX_NL80211_IFACE_COMB = NUM_NL80211_IFACE_COMB - 1
 };
 
+/**
+ * enum nl80211_if_comb_per_hw_comb_attrs - per-hardware iface combination
+ * attributes with multi-hw radios in one wiphy model
+ *
+ * @NL80211_IFACE_COMB_PER_HW_COMB_UNSPEC: (reserved)
+ * @NL80211_IFACE_COMB_PER_HW_COMB_HW_IDX: u8 attribute specifying the index
+ *	to the wiphy @hw_chans list for which the iface combination is being
+ *	described.
+ * @NL80211_IFACE_COMB_PER_HW_COMB_LIMITS: nested attribute containing the
+ *	limits for the given interface types, see
+ *	&enum nl80211_iface_limit_attrs.
+ * @NL80211_IFACE_COMB_PER_HW_COMB_MAXIMUM: u32 attribute giving the maximum
+ *	number of interfaces that can be created in this group. This number
+ *	does not apply to the interfaces purely managed in software.
+ * @NL80211_IFACE_COMB_PER_HW_COMB_NUM_CHANNELS: u32 attribute specifying the
+ *	number of different channels that can be used in this group.
+ * @NUM_NL80211_IFACE_COMB_PER_HW_COMB: number of attributes
+ * @MAX_NL80211_IFACE_COMB_PER_HW_COMB: highest attribute number
+ */
+enum nl80211_if_comb_per_hw_comb_attrs {
+	NL80211_IFACE_COMB_PER_HW_COMB_UNSPEC,
+	NL80211_IFACE_COMB_PER_HW_COMB_HW_IDX,
+	NL80211_IFACE_COMB_PER_HW_COMB_LIMITS,
+	NL80211_IFACE_COMB_PER_HW_COMB_MAXIMUM,
+	NL80211_IFACE_COMB_PER_HW_COMB_NUM_CHANNELS,
+
+	/* keep last */
+	NUM_NL80211_IFACE_COMB_PER_HW_COMB,
+	MAX_NL80211_IFACE_COMB_PER_HW_COMB =
+			NUM_NL80211_IFACE_COMB_PER_HW_COMB - 1
+};
 
 /**
  * enum nl80211_plink_state - state of a mesh peer link finite state machine
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index b7d466010e81..1f3b79e10697 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -1595,6 +1595,74 @@ static int nl80211_put_iftypes(struct sk_buff *msg, u32 attr, u16 ifmodes)
 	return -ENOBUFS;
 }
 
+static int
+nl80211_put_per_hw_iface_combinations(struct wiphy *wiphy, struct sk_buff *msg,
+				      const struct ieee80211_iface_combination *c)
+{
+	struct nlattr *hw_combis;
+	int i;
+
+	if (!wiphy->num_hw)
+		return 0;
+
+	hw_combis = nla_nest_start(msg, NL80211_IFACE_COMB_PER_HW_COMB);
+	if (!hw_combis)
+		return -ENOBUFS;
+
+	for (i = 0; i < c->n_hw_list; i++) {
+		struct nlattr *hw_combi, *limits;
+		int l;
+
+		hw_combi = nla_nest_start(msg, i + 1);
+		if (!hw_combi)
+			return -ENOBUFS;
+
+		if (nla_put_u8(msg, NL80211_IFACE_COMB_PER_HW_COMB_HW_IDX,
+			       c->iface_hw_list[i].hw_chans_idx))
+			return -ENOBUFS;
+
+		limits = nla_nest_start(msg,
+					NL80211_IFACE_COMB_PER_HW_COMB_LIMITS);
+		if (!limits)
+			return -ENOBUFS;
+
+		for (l = 0; l < c->iface_hw_list->n_limits; l++) {
+			struct nlattr *limit;
+
+			limit = nla_nest_start(msg, l + 1);
+			if (!limit)
+				return -ENOBUFS;
+
+			if (nla_put_u16(msg, NL80211_IFACE_LIMIT_MAX,
+					c->iface_hw_list[i].limits[l].max))
+				return -ENOBUFS;
+
+			if (nla_put_u16(msg, NL80211_IFACE_LIMIT_TYPES,
+					c->iface_hw_list[i].limits[l].types))
+				return -ENOBUFS;
+
+			nla_nest_end(msg, limit);
+		}
+		nla_nest_end(msg, limits);
+
+		if (nla_put_u32(msg,
+				NL80211_IFACE_COMB_PER_HW_COMB_NUM_CHANNELS,
+				c->iface_hw_list[i].num_different_channels))
+			return -ENOBUFS;
+
+		if (nla_put_u16(msg,
+				NL80211_IFACE_COMB_PER_HW_COMB_MAXIMUM,
+				c->iface_hw_list[i].max_interfaces))
+			return -ENOBUFS;
+
+		nla_nest_end(msg, hw_combi);
+	}
+
+	nla_nest_end(msg, hw_combis);
+
+	return 0;
+}
+
 static int nl80211_put_iface_combinations(struct wiphy *wiphy,
 					  struct sk_buff *msg,
 					  bool large)
@@ -1658,6 +1726,9 @@ static int nl80211_put_iface_combinations(struct wiphy *wiphy,
 				c->beacon_int_min_gcd))
 			goto nla_put_failure;
 
+		if (large && nl80211_put_per_hw_iface_combinations(wiphy, msg, c))
+			goto nla_put_failure;
+
 		nla_nest_end(msg, nl_combi);
 	}
 
-- 
2.17.1

