Return-Path: <linux-wireless+bounces-14484-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 065649AF6F4
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 03:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A1DA1C214EA
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 01:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B044148FED;
	Fri, 25 Oct 2024 01:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hRtIw+Na"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB18413B787
	for <linux-wireless@vger.kernel.org>; Fri, 25 Oct 2024 01:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729820363; cv=none; b=ogfgRFawSV8TFKe6SSydLpBIOzaVbRg8FCvMVjoPlNlU/95AA2sXfFqQ84KNLfX4+q2hxHXB9U5/6mQYG+ZdmwBnmnZ18YZ8/qmCtFfI3a4UF2q8W+aIz9gKC8yYV3lKVn5rFBhV09An035nr/4BC/b03LkHxAkeHzMbzPsQmrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729820363; c=relaxed/simple;
	bh=vJsTZH8QX5g108Wd6TvOOiXeCB3dfdmfV5I79ZmaQ2o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Irqs4CBcCZDzLGu+MUBDIl9s2eceMG56NStkg+hLyp89rDPkoBe38Jsofq3E71rnNhv8K+DSbg5t7UtyNJH8rPYAFnI7Izs9o9p/yXemZIsBNx7Xa2fwO18ngg6WhfxM1JjLVK6gtK3OVQWGbH5K7Znb8LYUvduzUrd4A8Lma2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hRtIw+Na; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49OJp2Lu007345;
	Fri, 25 Oct 2024 01:39:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gslrlzhVM//dfP4FYysLOJfyGax3nXs/fp3xjmX7De4=; b=hRtIw+NaaICmGqdT
	1TspBv2jW0u07u7rUF9Sczcb6X+IbvATfwsK7NVHJf3muVqg3pNFK5QRo4QtYvJ2
	NzcQlTyNdOr4+2QCG216ob1YWJRsue9amjFhu7NDufNlOYur2BD8mzQbQ2VrzEAg
	n8NmcldjbycmTxQy3b+v26Ub9qTGj1ix/CkoDcCtJBpc7tlBP0mSLIXFxmdl+tPi
	Nm1Yi66NJGtqUmMYgO9QuVowS9bbQ2Z7KrnnE8QzqDZdBZhRgIFvoOmiT1B8hfV9
	b8kyXg4mGiDXK9QiDsfrzh9p61ib5Y6YKIQYK6ERKaQ15ilPcTznu+Iswq4o+wEa
	1t/nFg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42fk52j9dc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Oct 2024 01:39:17 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49P1dFk1026584
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Oct 2024 01:39:15 GMT
Received: from msinada-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 24 Oct 2024 18:39:15 -0700
From: Muna Sinada <quic_msinada@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Rameshkumar Sundaram
	<quic_ramess@quicinc.com>,
        Aloka Dixit <quic_alokad@quicinc.com>,
        Muna Sinada
	<quic_msinada@quicinc.com>
Subject: [PATCH v2 1/2] wifi: nl80211: add link id of transmitted profile for MLO MBSSID
Date: Thu, 24 Oct 2024 18:38:56 -0700
Message-ID: <20241025013857.2793346-2-quic_msinada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241025013857.2793346-1-quic_msinada@quicinc.com>
References: <20241025013857.2793346-1-quic_msinada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: kL3gdvMIyT7v6tgv_M-IEPrUFttJPemi
X-Proofpoint-ORIG-GUID: kL3gdvMIyT7v6tgv_M-IEPrUFttJPemi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 priorityscore=1501 spamscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410250011

From: Rameshkumar Sundaram <quic_ramess@quicinc.com>

Currently non-transmitted profile provides the interface index of the
transmitted profile. The index matches one of the interface indices
advertised by the kernel.

For MLO MBSSID, if the transmitted profile is part of an MLD, then the
transmitted profile is a specific link of that MLD. Utilizing only the
interface index of transmitted profile is no longer sufficient to
identify transmitted profile for MLO.

Add a new attribute to specify link id of the transmitted profile of
MBSSID group if the profile is part of an MLD. It is required to map
the nontransmitted link to corresponding transmitted link.

Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
Co-developed-by: Aloka Dixit <quic_alokad@quicinc.com>
Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
Signed-off-by: Muna Sinada <quic_msinada@quicinc.com>
---
v2: addressed review comments
 - cleaned up commit message
 - added link id value for non-MLO to documentation
 - rewrote documentation for link id NL attibute
 - cleaned up error path
 - removed usage of tx_netdev

---
 include/net/cfg80211.h       |  3 +++
 include/uapi/linux/nl80211.h |  7 ++++++
 net/wireless/nl80211.c       | 43 +++++++++++++++++++++++++++---------
 3 files changed, 42 insertions(+), 11 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 192d72c8b465..cd313f59dc68 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1286,11 +1286,14 @@ struct cfg80211_crypto_settings {
  * struct cfg80211_mbssid_config - AP settings for multi bssid
  *
  * @tx_wdev: pointer to the transmitted interface in the MBSSID set
+ * @tx_link_id: link ID of the transmitted interface if it is part of an MLD.
+ *	If transmitted interface is not part of an MLD, link ID is set to -1.
  * @index: index of this AP in the multi bssid group.
  * @ema: set to true if the beacons should be sent out in EMA mode.
  */
 struct cfg80211_mbssid_config {
 	struct wireless_dev *tx_wdev;
+	int tx_link_id;
 	u8 index;
 	bool ema;
 };
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index f97f5adc8d51..ebf48c11dc0b 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -7987,6 +7987,12 @@ enum nl80211_sar_specs_attrs {
  *	Setting this flag is permitted only if the driver advertises EMA support
  *	by setting wiphy->ema_max_profile_periodicity to non-zero.
  *
+ * @NL80211_MBSSID_CONFIG_ATTR_TX_LINK_ID: Parameter for a non-transmitted
+ *	profile which provides the link ID (u8) of the transmitted profile when
+ *	the latter is part of an MLD. This is a mandatory parameter for a
+ *	non-transmitted profile. If transmitted profile is not part of an MLD,
+ *	link_id will be set to -1.
+ *
  * @__NL80211_MBSSID_CONFIG_ATTR_LAST: Internal
  * @NL80211_MBSSID_CONFIG_ATTR_MAX: highest attribute
  */
@@ -7998,6 +8004,7 @@ enum nl80211_mbssid_config_attributes {
 	NL80211_MBSSID_CONFIG_ATTR_INDEX,
 	NL80211_MBSSID_CONFIG_ATTR_TX_IFINDEX,
 	NL80211_MBSSID_CONFIG_ATTR_EMA,
+	NL80211_MBSSID_CONFIG_ATTR_TX_LINK_ID,
 
 	/* keep last */
 	__NL80211_MBSSID_CONFIG_ATTR_LAST,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 7397a372c78e..32adca100f23 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -454,6 +454,8 @@ nl80211_mbssid_config_policy[NL80211_MBSSID_CONFIG_ATTR_MAX + 1] = {
 	[NL80211_MBSSID_CONFIG_ATTR_INDEX] = { .type = NLA_U8 },
 	[NL80211_MBSSID_CONFIG_ATTR_TX_IFINDEX] = { .type = NLA_U32 },
 	[NL80211_MBSSID_CONFIG_ATTR_EMA] = { .type = NLA_FLAG },
+	[NL80211_MBSSID_CONFIG_ATTR_TX_LINK_ID] =
+		NLA_POLICY_MAX(NLA_U8, IEEE80211_MLD_MAX_NUM_LINKS),
 };
 
 static const struct nla_policy
@@ -5477,6 +5479,7 @@ static int nl80211_parse_mbssid_config(struct wiphy *wiphy,
 				       u8 num_elems)
 {
 	struct nlattr *tb[NL80211_MBSSID_CONFIG_ATTR_MAX + 1];
+	int err;
 
 	if (!wiphy->mbssid_max_interfaces)
 		return -EOPNOTSUPP;
@@ -5509,18 +5512,14 @@ static int nl80211_parse_mbssid_config(struct wiphy *wiphy,
 			return -EINVAL;
 
 		if (tx_ifindex != dev->ifindex) {
-			struct net_device *tx_netdev =
-				dev_get_by_index(wiphy_net(wiphy), tx_ifindex);
-
-			if (!tx_netdev || !tx_netdev->ieee80211_ptr ||
-			    tx_netdev->ieee80211_ptr->wiphy != wiphy ||
-			    tx_netdev->ieee80211_ptr->iftype !=
-							NL80211_IFTYPE_AP) {
-				dev_put(tx_netdev);
-				return -EINVAL;
+			config->tx_wdev =
+			 dev_get_by_index(wiphy_net(wiphy), tx_ifindex)->ieee80211_ptr;
+			if (!config->tx_wdev ||
+			    config->tx_wdev->wiphy != wiphy ||
+			    config->tx_wdev->iftype != NL80211_IFTYPE_AP) {
+				err = -EINVAL;
+				goto out;
 			}
-
-			config->tx_wdev = tx_netdev->ieee80211_ptr;
 		} else {
 			config->tx_wdev = dev->ieee80211_ptr;
 		}
@@ -5530,7 +5529,29 @@ static int nl80211_parse_mbssid_config(struct wiphy *wiphy,
 		return -EINVAL;
 	}
 
+	config->tx_link_id = 0;
+	if (config->tx_wdev->valid_links) {
+		if (!tb[NL80211_MBSSID_CONFIG_ATTR_TX_LINK_ID])
+			goto out;
+
+		config->tx_link_id =
+			  nla_get_u8(tb[NL80211_MBSSID_CONFIG_ATTR_TX_LINK_ID]);
+		if (!(config->tx_wdev->valid_links & BIT(config->tx_link_id))) {
+			err = -ENOLINK;
+			goto out;
+		}
+	} else if (tb[NL80211_MBSSID_CONFIG_ATTR_TX_LINK_ID]) {
+		goto out;
+	}
+
 	return 0;
+
+out:
+	if (config->tx_wdev && config->tx_wdev->netdev &&
+	    config->tx_wdev->netdev != dev)
+		dev_put(config->tx_wdev->netdev);
+
+	return err;
 }
 
 static struct cfg80211_mbssid_elems *
-- 
2.34.1


