Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF676CBB14
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Mar 2023 11:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232885AbjC1JeI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Mar 2023 05:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232898AbjC1Jdx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Mar 2023 05:33:53 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355A77298
        for <linux-wireless@vger.kernel.org>; Tue, 28 Mar 2023 02:32:22 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32S6Xipw003898;
        Tue, 28 Mar 2023 09:31:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=UjSWW8q+RnryjZWnZx5StmA1IkKP+6p7SS8GT1aXiSQ=;
 b=MsB5CiFIviJuTZ2mMr8KdJqisx7tJ3dmRRSa2i5kWRTBxRrT5xrMgmRl8fb+2F0Sum2j
 M/EUJvGstttN4McDwK2ftKxsx6Bzh8LdGNodssKBB82VX4JyfySQpPruCDgGy9CKFmJl
 T/kGDtD+sJIcheEewAgX+w9bQ0JCk+X3ei1aorNBR+bXwvGkyeeUwK39R+fMR8DOG7YG
 cVOpk+Ce2BMh3vQGVNKBYkDKvhOL/bHV4Yigb6MPDaEzlpeyzQFteFriEmi0ex51vyEC
 7s7DGKWBKvUzonmWhyQCZPl1+opoORitJyxSL+a9SQMd+0jVfqIKPuX1F3dV3VLrcGr2 kA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pk7h8u7wh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Mar 2023 09:31:23 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32S9VMvS023972
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Mar 2023 09:31:22 GMT
Received: from cnss-mw-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 28 Mar 2023 02:31:20 -0700
From:   Veerendranath Jakkam <quic_vjakkam@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>, <quic_vjakkam@quicinc.com>
Subject: [PATCH] nl80211: Add support to configure allowed frequency list for AP operation
Date:   Tue, 28 Mar 2023 15:01:04 +0530
Message-ID: <20230328093105.3640436-1-quic_vjakkam@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: t2ViVlKDZSUeBJtJi2h5swJ-rbWGoe5U
X-Proofpoint-ORIG-GUID: t2ViVlKDZSUeBJtJi2h5swJ-rbWGoe5U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-27_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 mlxlogscore=999 phishscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303280079
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add support to configure the list of allowed 20 MHz channels for AP
operation using an array of channel center frequencies in MHz, this
configuration is valid until the AP is stopped. Driver shall filter out
channels on top of this list of channels based on regulatory or other
constraints during channel switch etc. Driver shall stop the AP
operation if all the channels are filtered out during such operation.

This configuration can be used to specify user's choice of frequencies,
allowed list of channels with static puncturing feature etc.

Signed-off-by: Veerendranath Jakkam <quic_vjakkam@quicinc.com>
---
 include/net/cfg80211.h       | 14 +++++++++++
 include/uapi/linux/nl80211.h | 28 ++++++++++++++++++++++
 net/wireless/nl80211.c       | 45 ++++++++++++++++++++++++++++++++++++
 3 files changed, 87 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 9e04f69712b1..062d75709f4f 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1359,6 +1359,18 @@ struct cfg80211_unsol_bcast_probe_resp {
  * @punct_bitmap: Preamble puncturing bitmap. Each bit represents
  *	a 20 MHz channel, lowest bit corresponding to the lowest channel.
  *	Bit set to 1 indicates that the channel is punctured.
+ * @allowed_freqs: List of allowed 20 MHz channel center frequencies in MHz for
+ *	the AP operation. The configuration is valid until the AP is stopped.
+ *	Whenever performing a channel selection, the driver shall generate a new
+ *	list based on this provided list by filtering out the channels that
+ *	cannot be used at that time due to regulatory or other constraints. The
+ *	resulting list is used as the list of all allowed channels, i.e.,
+ *	operation on any channel that is not included is not allowed, whenever
+ *	performing operations like ACS and DFS. If all the channels are filtered
+ *	out during such operation driver shall stop the AP operation. Driver
+ *	shall advertise %NL80211_EXT_FEATURE_AP_ALLOWED_FREQ_LIST when it
+ *	supports this configuration.
+ * @num_allowed_freqs: Number of frequencies specified in %allowed_freqs
  */
 struct cfg80211_ap_settings {
 	struct cfg80211_chan_def chandef;
@@ -1394,6 +1406,8 @@ struct cfg80211_ap_settings {
 	struct cfg80211_unsol_bcast_probe_resp unsol_bcast_probe_resp;
 	struct cfg80211_mbssid_config mbssid_config;
 	u16 punct_bitmap;
+	u32 *allowed_freqs;
+	int num_allowed_freqs;
 };
 
 /**
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index cf4fb981e131..9c9152a6f935 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2805,6 +2805,18 @@ enum nl80211_commands {
  *	index. If the userspace includes more RNR elements than number of
  *	MBSSID elements then these will be added in every EMA beacon.
  *
+ * @NL80211_ATTR_AP_ALLOWED_FREQ_LIST: Nested attribute with frequencies in u32
+ *	attributes. A list of allowed 20 MHz channel center frequencies in MHz
+ *	for AP operation. Used with %NL80211_CMD_START_AP. The configuration is
+ *	valid until the AP is stopped. The drivers shall filter out channels on
+ *	top of this list of channels based on regulatory or other constraints
+ *	during channel switch etc. If all the channels are filtered out during
+ *	such operation, the driver shall stop the AP operation.
+ *	This can be used to specify userspace choice of frequencies, allowed
+ *	list of channels with static puncturing feature etc. This configuration
+ *	allowed only when driver indicates
+ *	%NL80211_EXT_FEATURE_AP_ALLOWED_FREQ_LIST.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3341,6 +3353,8 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_EMA_RNR_ELEMS,
 
+	NL80211_ATTR_AP_ALLOWED_FREQ_LIST,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
@@ -6365,6 +6379,19 @@ enum nl80211_feature_flags {
  *	in authentication and deauthentication frames sent to unassociated peer
  *	using @NL80211_CMD_FRAME.
  *
+ * @NL80211_EXT_FEATURE_AP_ALLOWED_FREQ_LIST: Driver supports configuring
+ *	allowed frequency list for AP operation in %NL80211_CMD_START_AP with
+ *	%NL80211_ATTR_AP_ALLOWED_FREQ_LIST from userspace. When driver indicates
+ *	this and userspace sends %NL80211_ATTR_AP_ALLOWED_FREQ_LIST in
+ *	%NL80211_CMD_START_AP, driver shall generate a new list based on the
+ *	provided list in %NL80211_ATTR_AP_ALLOWED_FREQ_LIST by filtering out the
+ *	channels that can't be used at that time due to regulatory or other
+ *	constraints. The resulting list is used as the list of all allowed
+ *	channels, i.e., operation on any channel that is not included is not
+ *	allowed, whenever performing operations like ACS and DFS. If all the
+ *	channels are filtered out during such operation driver shall stop the AP
+ *	operation.
+ *
  * @NUM_NL80211_EXT_FEATURES: number of extended features.
  * @MAX_NL80211_EXT_FEATURES: highest extended feature index.
  */
@@ -6436,6 +6463,7 @@ enum nl80211_ext_feature_index {
 	NL80211_EXT_FEATURE_PUNCT,
 	NL80211_EXT_FEATURE_SECURE_NAN,
 	NL80211_EXT_FEATURE_AUTH_AND_DEAUTH_RANDOM_TA,
+	NL80211_EXT_FEATURE_AP_ALLOWED_FREQ_LIST,
 
 	/* add new features before the definition below */
 	NUM_NL80211_EXT_FEATURES,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index f1cd3d9130dd..65576d8ccb82 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -810,6 +810,7 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_MAX_HW_TIMESTAMP_PEERS] = { .type = NLA_U16 },
 	[NL80211_ATTR_HW_TIMESTAMP_ENABLED] = { .type = NLA_FLAG },
 	[NL80211_ATTR_EMA_RNR_ELEMS] = { .type = NLA_NESTED },
+	[NL80211_ATTR_AP_ALLOWED_FREQ_LIST] = { .type = NLA_NESTED },
 };
 
 /* policy for the key attributes */
@@ -5886,6 +5887,35 @@ static void nl80211_send_ap_started(struct wireless_dev *wdev,
 	nlmsg_free(msg);
 }
 
+static int parse_ap_allowed_freq_list(struct nlattr *freq_list,
+				      struct cfg80211_ap_settings *params)
+{
+	struct nlattr *attr;
+	int tmp;
+	int n_freqs = 0;
+
+	nla_for_each_nested(attr, freq_list, tmp) {
+		if (nla_len(attr) != sizeof(u32))
+			return -EINVAL;
+
+		n_freqs++;
+	}
+
+	if (!n_freqs)
+		return -EINVAL;
+
+	params->allowed_freqs = kcalloc(n_freqs, sizeof(*params->allowed_freqs),
+					GFP_KERNEL);
+	if (!params->allowed_freqs)
+		return -ENOMEM;
+
+	nla_for_each_nested(attr, freq_list, tmp)
+		params->allowed_freqs[params->num_allowed_freqs++] =
+				nla_get_u32(attr);
+
+	return 0;
+}
+
 static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 {
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
@@ -6049,6 +6079,20 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 		goto out;
 	}
 
+	if (info->attrs[NL80211_ATTR_AP_ALLOWED_FREQ_LIST]) {
+		if (!wiphy_ext_feature_isset(&rdev->wiphy,
+				NL80211_EXT_FEATURE_AP_ALLOWED_FREQ_LIST)) {
+			err = -EOPNOTSUPP;
+			goto out;
+		}
+
+		err = parse_ap_allowed_freq_list(
+				info->attrs[NL80211_ATTR_AP_ALLOWED_FREQ_LIST],
+				params);
+		if (err)
+			goto out;
+	}
+
 	wdev_lock(wdev);
 
 	if (info->attrs[NL80211_ATTR_TX_RATES]) {
@@ -6187,6 +6231,7 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 	wdev_unlock(wdev);
 out:
 	kfree(params->acl);
+	kfree(params->allowed_freqs);
 	kfree(params->beacon.mbssid_ies);
 	if (params->mbssid_config.tx_wdev &&
 	    params->mbssid_config.tx_wdev->netdev &&
-- 
2.25.1

