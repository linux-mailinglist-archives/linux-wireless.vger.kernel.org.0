Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3454E5BE2B9
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Sep 2022 12:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiITKLF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Sep 2022 06:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbiITKKw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Sep 2022 06:10:52 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C2B6AA05
        for <linux-wireless@vger.kernel.org>; Tue, 20 Sep 2022 03:10:47 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28KA0N1v027518;
        Tue, 20 Sep 2022 10:10:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=h3HVczrMpOtauqQmDDmamAnVsfheGtIga8wRQ42gEXo=;
 b=cdXvoHyIX2hIZs4s4g5oFxtr2mll/g/eyOFZWLpLpSQoqa7Qk/dzMy7xQVxh9yWkCsck
 1PgVrkrJKGylkC4unsC0reQBXYqXsGpwGAnrFIP4K9OKVd8n5wCL6ll5asd3ZdmgTr8H
 PhDi6YuKTQblMcmlKZmPQ8wpvrP6eQ0DOgyYrxzX3FXv/JyKiSKj0gWrGAOYivY71Saz
 8L6tJ1UJ3fHZxBQh+yLaStAx0dQt+2leMvekyoPIOHc9Yax0yfCCxqNhdmcsAOeOIW5r
 e7n9Q2itDvxyr3hlS4KuNlcI13Uw+g8mvP/+79UZEoaeZQ7R/FJrGOgnnUZFAQuAxX3Q SQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jpx50ad0t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 10:10:45 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28KA5ivT022220
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 10:05:44 GMT
Received: from CDCCSTEX0180100-LIN.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 20 Sep 2022 03:05:42 -0700
From:   Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>
Subject: [RFC 2/4] wifi: nl80211: send underlying multi-hardware channel capabilities to user space
Date:   Tue, 20 Sep 2022 15:35:16 +0530
Message-ID: <20220920100518.19705-3-quic_vthiagar@quicinc.com>
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
X-Proofpoint-ORIG-GUID: wRZnu9Y5gOcbBJdyzdQLEHZQc2oSbUUb
X-Proofpoint-GUID: wRZnu9Y5gOcbBJdyzdQLEHZQc2oSbUUb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-20_02,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 adultscore=0 mlxlogscore=999 lowpriorityscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209200062
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When driver supports multiple physical hardware under one wiphy,
wiphy->num_hw != 0, send per-hardware supported frequency list to
user space. List of frequency are reported inside an index which
identifies the hardware as in wiphy->hw_chans[]. This hardware index
will be used in follow up patches to identify the interface combination
capability for each of the underlying physical hardware abstracted
under one wiphy.

Signed-off-by: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
---
 include/uapi/linux/nl80211.h | 28 +++++++++++++++++++++
 net/wireless/nl80211.c       | 47 ++++++++++++++++++++++++++++++++++++
 2 files changed, 75 insertions(+)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index c32e7616a366..070b31277402 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2749,6 +2749,12 @@ enum nl80211_commands {
  *	When used with %NL80211_CMD_FRAME_TX_STATUS, indicates the ack RX
  *	timestamp. When used with %NL80211_CMD_FRAME RX notification, indicates
  *	the incoming frame RX timestamp.
+ *
+ * @NL80211_ATTR_MULTI_HW_MACS: nested attribute to send the hardware mac
+ *	specific channel capabilities to user space. Drivers registering
+ *	multiple physical hardware under a wiphy can use this attribute,
+ *	see &enum nl80211_multi_hw_mac_attrs.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3277,6 +3283,8 @@ enum nl80211_attrs {
 	NL80211_ATTR_TX_HW_TIMESTAMP,
 	NL80211_ATTR_RX_HW_TIMESTAMP,
 
+	NL80211_ATTR_MULTI_HW_MACS,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
@@ -7720,4 +7728,24 @@ enum nl80211_ap_settings_flags {
 	NL80211_AP_SETTINGS_SA_QUERY_OFFLOAD_SUPPORT	= 1 << 1,
 };
 
+/**
+ * nl80211_multi_hw_mac_attrs - multi-hw mac attributes
+ *
+ * @NL80211_MULTI_HW_MAC_ATTR_INVALID: invalid
+ * @NL80211_MULTI_HW_MAC_ATTR_IDX: (u8) array index in wiphy @hw_chans to refer an
+ *	underlying hw mac for which the supported channel list is advertised.
+ * @NL80211_MULTI_HW_MAC_ATTR_FREQS: array of supported center frequencies
+ * @__NL80211_MULTI_HW_MAC_ATTR_LAST: internal use
+ * @NL80211_MULTI_HW_MAC_ATTR_MAX: maximum multi-hw mac attribute
+ */
+enum nl80211_multi_hw_mac_attrs {
+	__NL80211_MULTI_HW_MAC_ATTR_INVALID,
+
+	NL80211_MULTI_HW_MAC_ATTR_IDX,
+	NL80211_MULTI_HW_MAC_ATTR_FREQS,
+
+	/* keep last */
+	__NL80211_MULTI_HW_MAC_ATTR_LAST,
+	NL80211_MULTI_HW_MAC_ATTR_MAX = __NL80211_MULTI_HW_MAC_ATTR_LAST - 1
+};
 #endif /* __LINUX_NL80211_H */
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 8ff8b1c040f0..b7d466010e81 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -2355,6 +2355,47 @@ static int nl80211_put_mbssid_support(struct wiphy *wiphy, struct sk_buff *msg)
 	return -ENOBUFS;
 }
 
+static int nl80211_put_multi_hw_support(struct wiphy *wiphy,
+					struct sk_buff *msg)
+{
+	struct nlattr *hw_macs, *hw_mac;
+	struct nlattr *freqs;
+	int i, c;
+
+	if (!wiphy->num_hw)
+		return 0;
+
+	hw_macs = nla_nest_start(msg, NL80211_ATTR_MULTI_HW_MACS);
+	if (!hw_macs)
+		return -ENOBUFS;
+
+	for (i = 0; i < wiphy->num_hw; i++) {
+		hw_mac = nla_nest_start(msg, i + 1);
+		if (!hw_mac)
+			return -ENOBUFS;
+
+		if (nla_put_u8(msg, NL80211_MULTI_HW_MAC_ATTR_IDX, i))
+			return -ENOBUFS;
+
+		freqs = nla_nest_start(msg,
+				       NL80211_MULTI_HW_MAC_ATTR_FREQS);
+		if (!freqs)
+			return -ENOBUFS;
+
+		for (c = 0; c < wiphy->hw_chans[i]->n_chans; c++)
+			if (nla_put_u32(msg, c + 1,
+					wiphy->hw_chans[i]->chans[c].center_freq))
+				return -ENOBUFS;
+
+		nla_nest_end(msg, freqs);
+
+		nla_nest_end(msg, hw_mac);
+	}
+
+	nla_nest_end(msg, hw_macs);
+	return 0;
+}
+
 struct nl80211_dump_wiphy_state {
 	s64 filter_wiphy;
 	long start;
@@ -2959,6 +3000,12 @@ static int nl80211_send_wiphy(struct cfg80211_registered_device *rdev,
 		if (rdev->wiphy.flags & WIPHY_FLAG_SUPPORTS_MLO)
 			nla_put_flag(msg, NL80211_ATTR_MLO_SUPPORT);
 
+		state->split_start++;
+		break;
+	case 17:
+		if (nl80211_put_multi_hw_support(&rdev->wiphy, msg))
+			goto nla_put_failure;
+
 		/* done */
 		state->split_start = 0;
 		break;
-- 
2.17.1

