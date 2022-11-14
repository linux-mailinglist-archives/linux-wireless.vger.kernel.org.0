Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF9B628D2D
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Nov 2022 00:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238134AbiKNXH4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Nov 2022 18:07:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238120AbiKNXHc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Nov 2022 18:07:32 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2751D0E1
        for <linux-wireless@vger.kernel.org>; Mon, 14 Nov 2022 15:04:51 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AEMF2MX004604;
        Mon, 14 Nov 2022 23:04:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=5Q4K6E+Kff7vgC6mRDM6uDUwSRaPWNRRFyaxrcJSTVI=;
 b=f0xej/h9E6TROHn0ijoWTfLJVvbKAj+0hOXnh/mbdA3UDDUdnRQN1aml0KWOS9zOljvm
 m0PWtFk/CZBSnTYTeo0dGAvN+x3l3BDGWBck/izBFkSThpxn3HYNoiclqLvoCcduR3C9
 2DWAHm9UNl6TsbroQJ6/JxmbPP6KjAPqIxJ3b/cr7JL57esQT9RGFtAaYDhXwan92tgs
 FZ8zxreOYhyUsjbsV/zEh0TAzb9NUj3KPu0GckMP2v6QjTcwy9Dt+iQgIxMjai2h+vR1
 AHoGFcUEm5SAU2HNdyl7PxY0zOGen7svdjlAKhg39fIHx2FlYcNqD8AkeAQaVz28+0tN PA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kusye0uvb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Nov 2022 23:04:26 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2AEN4Qli011773
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Nov 2022 23:04:26 GMT
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 14 Nov 2022 15:04:25 -0800
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/2] cfg80211: support RNR for EMA AP
Date:   Mon, 14 Nov 2022 15:04:15 -0800
Message-ID: <20221114230416.20192-2-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221114230416.20192-1-quic_alokad@quicinc.com>
References: <20221114230416.20192-1-quic_alokad@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: kfuym1MDRNMtwnHwzUha2rpMj-2l3jBx
X-Proofpoint-ORIG-GUID: kfuym1MDRNMtwnHwzUha2rpMj-2l3jBx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-14_15,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0
 clxscore=1015 impostorscore=0 phishscore=0 priorityscore=1501
 suspectscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2211140162
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

As per IEEE Std 802.11ax-2021, 11.1.3.8.3 Discovery of a nontransmitted
BSSID profile, an EMA AP that transmits a Beacon frame carrying a partial
list of nontransmitted BSSID profiles should include in the frame
a Reduced Neighbor Report element carrying information for at least the
nontransmitted BSSIDs that are not present in the Multiple BSSID element
carried in that frame.
Add new nested attribute NL80211_ATTR_EMA_RNR_ELEMS to support the above.
Number of RNR elements must be more than or equal to the number of
MBSSID elements. This attribute can be used only when EMA is enabled.
Userspace is responsible for splitting the RNR into multiple elements such
that each element excludes the non-transmitting profiles already included
in the MBSSID element (%NL80211_ATTR_MBSSID_ELEMS) at the same index.
Each EMA beacon will be generated by adding MBSSID and RNR elements
at the same index. If the userspace provides more RNR elements than the
number of MBSSID elements then these will be added in every EMA beacon.

Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
---
 include/net/cfg80211.h       | 19 ++++++++++++++
 include/uapi/linux/nl80211.h | 13 ++++++++++
 net/wireless/nl80211.c       | 50 ++++++++++++++++++++++++++++++++++++
 3 files changed, 82 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 11a370e64143..bfde9e909c06 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1172,6 +1172,23 @@ struct cfg80211_mbssid_elems {
 	} elem[];
 };
 
+/**
+ * struct cfg80211_rnr_elems - Reduced neighbor report (RNR) elements
+ *
+ * @cnt: Number of elements in array %elems.
+ *
+ * @elem: Array of RNR element(s) to be added into Beacon frames.
+ * @elem.data: Data for RNR elements.
+ * @elem.len: Length of data.
+ */
+struct cfg80211_rnr_elems {
+	u8 cnt;
+	struct {
+		const u8 *data;
+		size_t len;
+	} elem[];
+};
+
 /**
  * struct cfg80211_beacon_data - beacon data
  * @link_id: the link ID for the AP MLD link sending this beacon
@@ -1192,6 +1209,7 @@ struct cfg80211_mbssid_elems {
  * @probe_resp_len: length of probe response template (@probe_resp)
  * @probe_resp: probe response template (AP mode only)
  * @mbssid_ies: multiple BSSID elements
+ * @rnr_ies: reduced neighbor report elements
  * @ftm_responder: enable FTM responder functionality; -1 for no change
  *	(which also implies no change in LCI/civic location data)
  * @lci: Measurement Report element content, starting with Measurement Token
@@ -1215,6 +1233,7 @@ struct cfg80211_beacon_data {
 	const u8 *lci;
 	const u8 *civicloc;
 	struct cfg80211_mbssid_elems *mbssid_ies;
+	struct cfg80211_rnr_elems *rnr_ies;
 	s8 ftm_responder;
 
 	size_t head_len, tail_len;
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index c14a91bbca7c..2623fb4542ec 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2751,6 +2751,17 @@ enum nl80211_commands {
  *	the incoming frame RX timestamp.
  * @NL80211_ATTR_TD_BITMAP: Transition Disable bitmap, for subsequent
  *	(re)associations.
+ * @NL80211_ATTR_EMA_RNR_ELEMS: Optional nested attribute for
+ *	reduced neighbor report (RNR) elements. This attribute can be used
+ *	only when NL80211_MBSSID_CONFIG_ATTR_EMA is enabled.
+ *	Userspace is responsible for splitting the RNR into multiple
+ *	elements such that each element excludes the non-transmitting
+ *	profiles already included in the MBSSID element
+ *	(%NL80211_ATTR_MBSSID_ELEMS) at the same index. Each EMA beacon
+ *	will be generated by adding MBSSID and RNR elements at the same
+ *	index. If the userspace includes more RNR elements than number of
+ *	MBSSID elements then these will be added in every EMA beacon.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3280,6 +3291,8 @@ enum nl80211_attrs {
 	NL80211_ATTR_RX_HW_TIMESTAMP,
 	NL80211_ATTR_TD_BITMAP,
 
+	NL80211_ATTR_EMA_RNR_ELEMS,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 148f66edb015..ee0f3bff989d 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -805,6 +805,7 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_MLD_ADDR] = NLA_POLICY_EXACT_LEN(ETH_ALEN),
 	[NL80211_ATTR_MLO_SUPPORT] = { .type = NLA_FLAG },
 	[NL80211_ATTR_MAX_NUM_AKM_SUITES] = { .type = NLA_REJECT },
+	[NL80211_ATTR_EMA_RNR_ELEMS] = { .type = NLA_NESTED },
 };
 
 /* policy for the key attributes */
@@ -5391,6 +5392,30 @@ nl80211_parse_mbssid_elems(struct wiphy *wiphy, struct nlattr *attrs)
 	return elems;
 }
 
+static struct cfg80211_rnr_elems *nl80211_parse_rnr_elems(struct wiphy *wiphy,
+							  struct nlattr *attrs)
+{
+	struct nlattr *nl_elems;
+	struct cfg80211_rnr_elems *elems;
+	int rem_elems;
+	u8 i = 0, num_elems = 0;
+
+	nla_for_each_nested(nl_elems, attrs, rem_elems)
+		num_elems++;
+
+	elems = kzalloc(struct_size(elems, elem, num_elems), GFP_KERNEL);
+	if (!elems)
+		return ERR_PTR(-ENOMEM);
+
+	nla_for_each_nested(nl_elems, attrs, rem_elems) {
+		elems->elem[i].data = nla_data(nl_elems);
+		elems->elem[i].len = nla_len(nl_elems);
+		i++;
+	}
+	elems->cnt = num_elems;
+	return elems;
+}
+
 static int nl80211_parse_he_bss_color(struct nlattr *attrs,
 				      struct cfg80211_he_bss_color *he_bss_color)
 {
@@ -5514,6 +5539,20 @@ static int nl80211_parse_beacon(struct cfg80211_registered_device *rdev,
 			return PTR_ERR(mbssid);
 
 		bcn->mbssid_ies = mbssid;
+
+		if (bcn->mbssid_ies && attrs[NL80211_ATTR_EMA_RNR_ELEMS]) {
+			struct cfg80211_rnr_elems *rnr =
+				nl80211_parse_rnr_elems(&rdev->wiphy,
+							attrs[NL80211_ATTR_EMA_RNR_ELEMS]);
+
+			if (IS_ERR(rnr))
+				return PTR_ERR(rnr);
+
+			if (rnr && rnr->cnt < bcn->mbssid_ies->cnt)
+				return -EINVAL;
+
+			bcn->rnr_ies = rnr;
+		}
 	}
 
 	return 0;
@@ -6018,6 +6057,11 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 			goto out_unlock;
 	}
 
+	if (!params->mbssid_config.ema && params->beacon.rnr_ies) {
+		err = -EINVAL;
+		goto out_unlock;
+	}
+
 	err = nl80211_calculate_ap_params(params);
 	if (err)
 		goto out_unlock;
@@ -6057,6 +6101,7 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 	    params->mbssid_config.tx_wdev->netdev &&
 	    params->mbssid_config.tx_wdev->netdev != dev)
 		dev_put(params->mbssid_config.tx_wdev->netdev);
+	kfree(params->beacon.rnr_ies);
 	kfree(params);
 
 	return err;
@@ -6091,6 +6136,7 @@ static int nl80211_set_beacon(struct sk_buff *skb, struct genl_info *info)
 
 out:
 	kfree(params.mbssid_ies);
+	kfree(params.rnr_ies);
 	return err;
 }
 
@@ -10061,6 +10107,8 @@ static int nl80211_channel_switch(struct sk_buff *skb, struct genl_info *info)
 free:
 	kfree(params.beacon_after.mbssid_ies);
 	kfree(params.beacon_csa.mbssid_ies);
+	kfree(params.beacon_after.rnr_ies);
+	kfree(params.beacon_csa.rnr_ies);
 	kfree(csa_attrs);
 	return err;
 }
@@ -15832,6 +15880,8 @@ static int nl80211_color_change(struct sk_buff *skb, struct genl_info *info)
 out:
 	kfree(params.beacon_next.mbssid_ies);
 	kfree(params.beacon_color_change.mbssid_ies);
+	kfree(params.beacon_next.rnr_ies);
+	kfree(params.beacon_color_change.rnr_ies);
 	kfree(tb);
 	return err;
 }

base-commit: 901c247f9687b5aecc950a931a3b0e1930d02bfd
prerequisite-patch-id: ee07532847cf9c473ca00649746ad1cf737c6bf6
-- 
2.17.1

