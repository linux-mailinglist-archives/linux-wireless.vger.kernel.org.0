Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 255AE640D5B
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Dec 2022 19:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234280AbiLBSgK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Dec 2022 13:36:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234232AbiLBSgI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Dec 2022 13:36:08 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92075ECE72
        for <linux-wireless@vger.kernel.org>; Fri,  2 Dec 2022 10:36:07 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B2DULpP007950;
        Fri, 2 Dec 2022 18:36:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=JO5lF53ifOR7kQZOMCpR4WSj3EYLSlzC+vnRmirp/As=;
 b=MkQgtmr4bWhJ6EBGVoQh9wrn1J8BPKSV0b0mj6hIK423byWIDkalBLPcodlZaLnh4RDZ
 KtpgiE5uEIbUp4B2BkvDmcJJkNNQHsHDjTSRZ7GMP2pkqRRqciDpJnGuuI6ZaOaAYedk
 ET6yYFP5Sn1LGee16tDQQWsraKewC2Iv4yuW7HjfMlKj49o+WzIddlpxNNH9XKy7CwGQ
 op495Yx2M9o/JA6LuDQcDfjSmkcbXgrybxHITj1ntDCqcoqOpLCU0xE5DmN6EFl0Qfvg
 OSngV9R7QtErlPlgKVK2esHnt95q55XEucozzoXtJIjGYKdiMiFcWWKQ34O8IfsujDzB Vw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3m7b82thrf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Dec 2022 18:36:04 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2B2Ia34p014016
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 2 Dec 2022 18:36:03 GMT
Received: from msinada-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 2 Dec 2022 10:36:02 -0800
From:   Muna Sinada <quic_msinada@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>,
        Aloka Dixit <quic_alokad@quicinc.com>
Subject: [RFC 1/4] wifi: nl80211: advertise RU puncturing support to userspace
Date:   Fri, 2 Dec 2022 10:35:51 -0800
Message-ID: <1670006154-6092-2-git-send-email-quic_msinada@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1670006154-6092-1-git-send-email-quic_msinada@quicinc.com>
References: <1670006154-6092-1-git-send-email-quic_msinada@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 3VuLrXHqOz7Rr9H2GayTViSlf-pwN9_y
X-Proofpoint-GUID: 3VuLrXHqOz7Rr9H2GayTViSlf-pwN9_y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-02_11,2022-12-01_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 adultscore=2 mlxscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 spamscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212020148
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Aloka Dixit <quic_alokad@quicinc.com>

RU preamble puncturing is allowed for bandwidths more than 80 MHz
except 80+80. Drivers may not support puncturing at all or have
restrictions for a minimum bandwidth.
Add new attribute NL80211_ATTR_RU_PUNCT_SUPP_BW to advertise the
driver support to the userspace. Default value (0) will indicate that
RU puncturing is not supported.

Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
---
 include/net/cfg80211.h       |  6 ++++++
 include/uapi/linux/nl80211.h | 25 +++++++++++++++++++++++++
 net/wireless/core.c          |  4 ++++
 net/wireless/nl80211.c       | 19 +++++++++++++++++++
 4 files changed, 54 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 11a370e64143..cb856b06a3ac 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -5299,6 +5299,10 @@ struct wiphy_iftype_akm_suites {
  *	NL80211_MAX_NR_AKM_SUITES in order to avoid compatibility issues with
  *	legacy userspace and maximum allowed value is
  *	CFG80211_MAX_NUM_AKM_SUITES.
+ *
+ * @ru_punct_supp_bw: Whether the driver supports RU puncturing, and if so,
+ *     for which bandwidths. See &enum nl80211_ru_punct_supp_bw for the
+ *     possible values for this field.
  */
 struct wiphy {
 	struct mutex mtx;
@@ -5447,6 +5451,8 @@ struct wiphy {
 	u8 ema_max_profile_periodicity;
 	u16 max_num_akm_suites;
 
+	enum nl80211_ru_punct_supp_bw ru_punct_supp_bw;
+
 	char priv[] __aligned(NETDEV_ALIGN);
 };
 
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index c14a91bbca7c..e5218fd7b37b 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2751,7 +2751,13 @@ enum nl80211_commands {
  *	the incoming frame RX timestamp.
  * @NL80211_ATTR_TD_BITMAP: Transition Disable bitmap, for subsequent
  *	(re)associations.
+ *
+ * @NL80211_ATTR_RU_PUNCT_SUPP_BW: (u8) Minimum bandwidth for which
+ *	the driver supports preamble puncturing, value should be of type
+ *	&enum nl80211_ru_punct_supp_bw
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
+ *
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
  */
@@ -3280,6 +3286,8 @@ enum nl80211_attrs {
 	NL80211_ATTR_RX_HW_TIMESTAMP,
 	NL80211_ATTR_TD_BITMAP,
 
+	NL80211_ATTR_RU_PUNCT_SUPP_BW,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
@@ -7723,4 +7731,21 @@ enum nl80211_ap_settings_flags {
 	NL80211_AP_SETTINGS_SA_QUERY_OFFLOAD_SUPPORT	= 1 << 1,
 };
 
+/**
+ * enum nl80211_ru_punct_supp_bw - Bandwidths supporting preamble puncturing
+ *
+ * @NL80211_RU_PUNCT_NOT_SUPP: preamble puncturing is not supported
+ * @NL80211_RU_PUNCT_SUPP_BW_80: puncturing supported within channels of at
+ *	least 80 MHz bandwidth
+ * @NL80211_RU_PUNCT_SUPP_BW_160: puncturing supported within channels of at
+ *	least 160 MHz bandwidth
+ * @NL80211_RU_PUNCT_SUPP_BW_320: puncturing supported within 320 MHz.
+ */
+enum nl80211_ru_punct_supp_bw {
+	NL80211_RU_PUNCT_NOT_SUPP,
+	NL80211_RU_PUNCT_SUPP_BW_80,
+	NL80211_RU_PUNCT_SUPP_BW_160,
+	NL80211_RU_PUNCT_SUPP_BW_320,
+};
+
 #endif /* __LINUX_NL80211_H */
diff --git a/net/wireless/core.c b/net/wireless/core.c
index 5b0c4d5b80cf..aa2a49a8ccbe 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -908,6 +908,10 @@ int wiphy_register(struct wiphy *wiphy)
 		return -EINVAL;
 	}
 
+	if (WARN_ON(rdev->wiphy.ru_punct_supp_bw >
+		    NL80211_RU_PUNCT_SUPP_BW_320))
+		return -EINVAL;
+
 	for (i = 0; i < rdev->wiphy.n_vendor_commands; i++) {
 		/*
 		 * Validate we have a policy (can be explicitly set to
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 148f66edb015..4b4cb3c64f62 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -805,6 +805,8 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_MLD_ADDR] = NLA_POLICY_EXACT_LEN(ETH_ALEN),
 	[NL80211_ATTR_MLO_SUPPORT] = { .type = NLA_FLAG },
 	[NL80211_ATTR_MAX_NUM_AKM_SUITES] = { .type = NLA_REJECT },
+	[NL80211_ATTR_RU_PUNCT_SUPP_BW] =
+		NLA_POLICY_MAX(NLA_U8, NL80211_RU_PUNCT_SUPP_BW_320),
 };
 
 /* policy for the key attributes */
@@ -2355,6 +2357,20 @@ static int nl80211_put_mbssid_support(struct wiphy *wiphy, struct sk_buff *msg)
 	return -ENOBUFS;
 }
 
+static int
+nl80211_put_ru_punct_supp_bw(struct cfg80211_registered_device *rdev,
+			     struct sk_buff *msg)
+{
+	if (rdev->wiphy.ru_punct_supp_bw == NL80211_RU_PUNCT_NOT_SUPP)
+		return 0;
+
+	if (nla_put_u8(msg, NL80211_ATTR_RU_PUNCT_SUPP_BW,
+		       rdev->wiphy.ru_punct_supp_bw))
+		return -ENOBUFS;
+
+	return 0;
+}
+
 struct nl80211_dump_wiphy_state {
 	s64 filter_wiphy;
 	long start;
@@ -2959,6 +2975,9 @@ static int nl80211_send_wiphy(struct cfg80211_registered_device *rdev,
 		if (rdev->wiphy.flags & WIPHY_FLAG_SUPPORTS_MLO)
 			nla_put_flag(msg, NL80211_ATTR_MLO_SUPPORT);
 
+		if (nl80211_put_ru_punct_supp_bw(rdev, msg))
+			goto nla_put_failure;
+
 		/* done */
 		state->split_start = 0;
 		break;
-- 
2.7.4

