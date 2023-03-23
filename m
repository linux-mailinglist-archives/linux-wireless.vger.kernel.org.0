Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2B46C66CE
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Mar 2023 12:38:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbjCWLi0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Mar 2023 07:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbjCWLiX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Mar 2023 07:38:23 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2AA8303F3
        for <linux-wireless@vger.kernel.org>; Thu, 23 Mar 2023 04:38:16 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32NB65Et030676;
        Thu, 23 Mar 2023 11:38:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=Hlz693Iy+8cm9NgzBrLN2UhARGkvHCXgpKHnSl7MpsA=;
 b=DSpuOrqKquuPGmAscK1fcoZC7Inbs/QGi1Sn3kUSp1toZqXMQiYlDiexOmpNJaML0dvx
 1uVk8N/qaGEQwKnGy2o+H65pXIR9XjzlhHuNtngB4dWv+tL4YR82iW6YyGHC0PC2g8+y
 r/r2Es9ui+QLcioqlGqlV2V+Ys0BHF4TqAebpvnPF9F3YOya9QAGeh+ePPVryi2Ot+QF
 aEVNOJfu+Q5QjltfZLbDpSLG9KoFMupSM0aJ/Av+5Jkvk5pL+e59iVUzmqEYko4fJBPx
 wOoUgFXFjViiGxA5K/TQIM5O8YqEWbAKMhHMY7MdFx1t+j2kizx47cS8FEub4uNuvNjy 4Q== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pg64k2522-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 11:38:13 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32NBcCB2017553
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 11:38:12 GMT
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 23 Mar 2023 04:38:12 -0700
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>
CC:     Aloka Dixit <quic_alokad@quicinc.com>
Subject: [PATCH v2 1/2] cfg80211: support RNR for EMA AP
Date:   Thu, 23 Mar 2023 04:38:00 -0700
Message-ID: <20230323113801.6903-2-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230323113801.6903-1-quic_alokad@quicinc.com>
References: <20230323113801.6903-1-quic_alokad@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ohMMM_Dxl5HUAmYIcLfgp-1OrryLYFCi
X-Proofpoint-ORIG-GUID: ohMMM_Dxl5HUAmYIcLfgp-1OrryLYFCi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_21,2023-03-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303230088
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
index 86cb048dc924..3cf236520288 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1178,6 +1178,23 @@ struct cfg80211_mbssid_elems {
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
@@ -1198,6 +1215,7 @@ struct cfg80211_mbssid_elems {
  * @probe_resp_len: length of probe response template (@probe_resp)
  * @probe_resp: probe response template (AP mode only)
  * @mbssid_ies: multiple BSSID elements
+ * @rnr_ies: reduced neighbor report elements
  * @ftm_responder: enable FTM responder functionality; -1 for no change
  *	(which also implies no change in LCI/civic location data)
  * @lci: Measurement Report element content, starting with Measurement Token
@@ -1221,6 +1239,7 @@ struct cfg80211_beacon_data {
 	const u8 *lci;
 	const u8 *civicloc;
 	struct cfg80211_mbssid_elems *mbssid_ies;
+	struct cfg80211_rnr_elems *rnr_ies;
 	s8 ftm_responder;
 
 	size_t head_len, tail_len;
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 14e958a32b84..cf4fb981e131 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2794,6 +2794,17 @@ enum nl80211_commands {
  * @NL80211_ATTR_HW_TIMESTAMP_ENABLED: Indicates whether HW timestamping should
  *	be enabled or not (flag attribute).
  *
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
@@ -3328,6 +3339,8 @@ enum nl80211_attrs {
 	NL80211_ATTR_MAX_HW_TIMESTAMP_PEERS,
 	NL80211_ATTR_HW_TIMESTAMP_ENABLED,
 
+	NL80211_ATTR_EMA_RNR_ELEMS,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 0a31b1d2845d..a1fc7314fc4a 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -809,6 +809,7 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 
 	[NL80211_ATTR_MAX_HW_TIMESTAMP_PEERS] = { .type = NLA_U16 },
 	[NL80211_ATTR_HW_TIMESTAMP_ENABLED] = { .type = NLA_FLAG },
+	[NL80211_ATTR_EMA_RNR_ELEMS] = { .type = NLA_NESTED },
 };
 
 /* policy for the key attributes */
@@ -5425,6 +5426,30 @@ nl80211_parse_mbssid_elems(struct wiphy *wiphy, struct nlattr *attrs)
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
@@ -5548,6 +5573,20 @@ static int nl80211_parse_beacon(struct cfg80211_registered_device *rdev,
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
@@ -6096,6 +6135,11 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
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
@@ -6137,6 +6181,7 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 	    params->mbssid_config.tx_wdev->netdev &&
 	    params->mbssid_config.tx_wdev->netdev != dev)
 		dev_put(params->mbssid_config.tx_wdev->netdev);
+	kfree(params->beacon.rnr_ies);
 	kfree(params);
 
 	return err;
@@ -6171,6 +6216,7 @@ static int nl80211_set_beacon(struct sk_buff *skb, struct genl_info *info)
 
 out:
 	kfree(params.mbssid_ies);
+	kfree(params.rnr_ies);
 	return err;
 }
 
@@ -10167,6 +10213,8 @@ static int nl80211_channel_switch(struct sk_buff *skb, struct genl_info *info)
 free:
 	kfree(params.beacon_after.mbssid_ies);
 	kfree(params.beacon_csa.mbssid_ies);
+	kfree(params.beacon_after.rnr_ies);
+	kfree(params.beacon_csa.rnr_ies);
 	kfree(csa_attrs);
 	return err;
 }
@@ -15952,6 +16000,8 @@ static int nl80211_color_change(struct sk_buff *skb, struct genl_info *info)
 out:
 	kfree(params.beacon_next.mbssid_ies);
 	kfree(params.beacon_color_change.mbssid_ies);
+	kfree(params.beacon_next.rnr_ies);
+	kfree(params.beacon_color_change.rnr_ies);
 	kfree(tb);
 	return err;
 }
-- 
2.39.0

